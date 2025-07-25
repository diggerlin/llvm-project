//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// This version is derived from the generic fma software implementation
// (__clc_sw_fma), but avoids the use of ulong in favor of uint2. The logic has
// been updated as appropriate.

#include <clc/clc_as_type.h>
#include <clc/clcmacro.h>
#include <clc/float/definitions.h>
#include <clc/integer/clc_abs.h>
#include <clc/integer/clc_clz.h>
#include <clc/integer/clc_hadd.h>
#include <clc/integer/clc_mul_hi.h>
#include <clc/integer/definitions.h>
#include <clc/math/clc_mad.h>
#include <clc/math/math.h>
#include <clc/relational/clc_isinf.h>
#include <clc/relational/clc_isnan.h>
#include <clc/shared/clc_max.h>

struct fp {
  uint2 mantissa;
  int exponent;
  uint sign;
};

static uint2 u2_set(uint hi, uint lo) {
  uint2 res;
  res.lo = lo;
  res.hi = hi;
  return res;
}

static uint2 u2_set_u(uint val) { return u2_set(0, val); }

static uint2 u2_mul(uint a, uint b) {
  uint2 res;
  res.hi = __clc_mul_hi(a, b);
  res.lo = a * b;
  return res;
}

static uint2 u2_sll(uint2 val, uint shift) {
  if (shift == 0)
    return val;
  if (shift < 32) {
    val.hi <<= shift;
    val.hi |= val.lo >> (32 - shift);
    val.lo <<= shift;
  } else {
    val.hi = val.lo << (shift - 32);
    val.lo = 0;
  }
  return val;
}

static uint2 u2_srl(uint2 val, uint shift) {
  if (shift == 0)
    return val;
  if (shift < 32) {
    val.lo >>= shift;
    val.lo |= val.hi << (32 - shift);
    val.hi >>= shift;
  } else {
    val.lo = val.hi >> (shift - 32);
    val.hi = 0;
  }
  return val;
}

static uint2 u2_or(uint2 a, uint b) {
  a.lo |= b;
  return a;
}

static uint2 u2_and(uint2 a, uint2 b) {
  a.lo &= b.lo;
  a.hi &= b.hi;
  return a;
}

static uint2 u2_add(uint2 a, uint2 b) {
  uint carry = (__clc_hadd(a.lo, b.lo) >> 31) & 0x1;
  a.lo += b.lo;
  a.hi += b.hi + carry;
  return a;
}

static uint2 u2_add_u(uint2 a, uint b) { return u2_add(a, u2_set_u(b)); }

static uint2 u2_inv(uint2 a) {
  a.lo = ~a.lo;
  a.hi = ~a.hi;
  return u2_add_u(a, 1);
}

static uint u2_clz(uint2 a) {
  uint leading_zeroes = __clc_clz(a.hi);
  if (leading_zeroes == 32) {
    leading_zeroes += __clc_clz(a.lo);
  }
  return leading_zeroes;
}

static bool u2_eq(uint2 a, uint2 b) { return a.lo == b.lo && a.hi == b.hi; }

static bool u2_zero(uint2 a) { return u2_eq(a, u2_set_u(0)); }

static bool u2_gt(uint2 a, uint2 b) {
  return a.hi > b.hi || (a.hi == b.hi && a.lo > b.lo);
}

_CLC_DEF _CLC_OVERLOAD float __clc_sw_fma(float a, float b, float c) {
  /* special cases */
  if (__clc_isnan(a) || __clc_isnan(b) || __clc_isnan(c) || __clc_isinf(a) ||
      __clc_isinf(b)) {
    return __clc_mad(a, b, c);
  }

  /* If only c is inf, and both a,b are regular numbers, the result is c*/
  if (__clc_isinf(c)) {
    return c;
  }

  a = __clc_flush_denormal_if_not_supported(a);
  b = __clc_flush_denormal_if_not_supported(b);
  c = __clc_flush_denormal_if_not_supported(c);

  if (a == 0.0f || b == 0.0f) {
    return c;
  }

  if (c == 0) {
    return a * b;
  }

  struct fp st_a, st_b, st_c;

  st_a.exponent = a == .0f ? 0 : ((__clc_as_uint(a) & 0x7f800000) >> 23) - 127;
  st_b.exponent = b == .0f ? 0 : ((__clc_as_uint(b) & 0x7f800000) >> 23) - 127;
  st_c.exponent = c == .0f ? 0 : ((__clc_as_uint(c) & 0x7f800000) >> 23) - 127;

  st_a.mantissa =
      u2_set_u(a == .0f ? 0 : (__clc_as_uint(a) & 0x7fffff) | 0x800000);
  st_b.mantissa =
      u2_set_u(b == .0f ? 0 : (__clc_as_uint(b) & 0x7fffff) | 0x800000);
  st_c.mantissa =
      u2_set_u(c == .0f ? 0 : (__clc_as_uint(c) & 0x7fffff) | 0x800000);

  st_a.sign = __clc_as_uint(a) & 0x80000000;
  st_b.sign = __clc_as_uint(b) & 0x80000000;
  st_c.sign = __clc_as_uint(c) & 0x80000000;

  // Multiplication.
  // Move the product to the highest bits to maximize precision
  // mantissa is 24 bits => product is 48 bits, 2bits non-fraction.
  // Add one bit for future addition overflow,
  // add another bit to detect subtraction underflow
  struct fp st_mul;
  st_mul.sign = st_a.sign ^ st_b.sign;
  st_mul.mantissa = u2_sll(u2_mul(st_a.mantissa.lo, st_b.mantissa.lo), 14);
  st_mul.exponent =
      !u2_zero(st_mul.mantissa) ? st_a.exponent + st_b.exponent : 0;

  // FIXME: Detecting a == 0 || b == 0 above crashed GCN isel
  if (st_mul.exponent == 0 && u2_zero(st_mul.mantissa))
    return c;

// Mantissa is 23 fractional bits, shift it the same way as product mantissa
#define C_ADJUST 37ul

  // both exponents are bias adjusted
  int exp_diff = st_mul.exponent - st_c.exponent;

  st_c.mantissa = u2_sll(st_c.mantissa, C_ADJUST);
  uint2 cutoff_bits = u2_set_u(0);
  uint2 cutoff_mask = u2_add(u2_sll(u2_set_u(1), __clc_abs(exp_diff)),
                             u2_set(0xffffffff, 0xffffffff));
  if (exp_diff > 0) {
    cutoff_bits =
        exp_diff >= 64 ? st_c.mantissa : u2_and(st_c.mantissa, cutoff_mask);
    st_c.mantissa =
        exp_diff >= 64 ? u2_set_u(0) : u2_srl(st_c.mantissa, exp_diff);
  } else {
    cutoff_bits = -exp_diff >= 64 ? st_mul.mantissa
                                  : u2_and(st_mul.mantissa, cutoff_mask);
    st_mul.mantissa =
        -exp_diff >= 64 ? u2_set_u(0) : u2_srl(st_mul.mantissa, -exp_diff);
  }

  struct fp st_fma;
  st_fma.sign = st_mul.sign;
  st_fma.exponent = __clc_max(st_mul.exponent, st_c.exponent);
  if (st_c.sign == st_mul.sign) {
    st_fma.mantissa = u2_add(st_mul.mantissa, st_c.mantissa);
  } else {
    // cutoff bits borrow one
    st_fma.mantissa =
        u2_add(u2_add(st_mul.mantissa, u2_inv(st_c.mantissa)),
               (!u2_zero(cutoff_bits) && (st_mul.exponent > st_c.exponent)
                    ? u2_set(0xffffffff, 0xffffffff)
                    : u2_set_u(0)));
  }

  // underflow: st_c.sign != st_mul.sign, and magnitude switches the sign
  if (u2_gt(st_fma.mantissa, u2_set(0x7fffffff, 0xffffffff))) {
    st_fma.mantissa = u2_inv(st_fma.mantissa);
    st_fma.sign = st_mul.sign ^ 0x80000000;
  }

  // detect overflow/underflow
  int overflow_bits = 3 - u2_clz(st_fma.mantissa);

  // adjust exponent
  st_fma.exponent += overflow_bits;

  // handle underflow
  if (overflow_bits < 0) {
    st_fma.mantissa = u2_sll(st_fma.mantissa, -overflow_bits);
    overflow_bits = 0;
  }

  // rounding
  uint2 trunc_mask = u2_add(u2_sll(u2_set_u(1), C_ADJUST + overflow_bits),
                            u2_set(0xffffffff, 0xffffffff));
  uint2 trunc_bits =
      u2_or(u2_and(st_fma.mantissa, trunc_mask), !u2_zero(cutoff_bits));
  uint2 last_bit =
      u2_and(st_fma.mantissa, u2_sll(u2_set_u(1), C_ADJUST + overflow_bits));
  uint2 grs_bits = u2_sll(u2_set_u(4), C_ADJUST - 3 + overflow_bits);

  // round to nearest even
  if (u2_gt(trunc_bits, grs_bits) ||
      (u2_eq(trunc_bits, grs_bits) && !u2_zero(last_bit))) {
    st_fma.mantissa =
        u2_add(st_fma.mantissa, u2_sll(u2_set_u(1), C_ADJUST + overflow_bits));
  }

  // Shift mantissa back to bit 23
  st_fma.mantissa = u2_srl(st_fma.mantissa, C_ADJUST + overflow_bits);

  // Detect rounding overflow
  if (u2_gt(st_fma.mantissa, u2_set_u(0xffffff))) {
    ++st_fma.exponent;
    st_fma.mantissa = u2_srl(st_fma.mantissa, 1);
  }

  if (u2_zero(st_fma.mantissa)) {
    return 0.0f;
  }

  // Flating point range limit
  if (st_fma.exponent > 127) {
    return __clc_as_float(__clc_as_uint(INFINITY) | st_fma.sign);
  }

  // Flush denormals
  if (st_fma.exponent <= -127) {
    return __clc_as_float(st_fma.sign);
  }

  return __clc_as_float(st_fma.sign | ((st_fma.exponent + 127) << 23) |
                        ((uint)st_fma.mantissa.lo & 0x7fffff));
}

#define __FLOAT_ONLY
#define FUNCTION __clc_sw_fma
#define __CLC_BODY <clc/shared/ternary_def_scalarize.inc>
#include <clc/math/gentype.inc>
