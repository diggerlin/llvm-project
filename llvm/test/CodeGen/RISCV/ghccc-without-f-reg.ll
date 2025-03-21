; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=riscv64 -mattr=+zfinx,+zdinx < %s | FileCheck %s

; Check the GHC call convention works for zfinx, zdinx (rv64)

@f1 = external global float
@f2 = external global float
@f3 = external global float
@f4 = external global float
@f5 = external global float
@f6 = external global float

define ghccc void @caller_float() nounwind {
; CHECK-LABEL: caller_float:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a0, %hi(f6)
; CHECK-NEXT:    lui a1, %hi(f5)
; CHECK-NEXT:    lui a2, %hi(f4)
; CHECK-NEXT:    lui a3, %hi(f3)
; CHECK-NEXT:    lui a4, %hi(f2)
; CHECK-NEXT:    lui a5, %hi(f1)
; CHECK-NEXT:    lw s6, %lo(f6)(a0)
; CHECK-NEXT:    lw s5, %lo(f5)(a1)
; CHECK-NEXT:    lw s4, %lo(f4)(a2)
; CHECK-NEXT:    lw s3, %lo(f3)(a3)
; CHECK-NEXT:    lw s2, %lo(f2)(a4)
; CHECK-NEXT:    lw s1, %lo(f1)(a5)
; CHECK-NEXT:    tail callee_float
entry:
  %0  = load float, ptr @f6
  %1  = load float, ptr @f5
  %2  = load float, ptr @f4
  %3  = load float, ptr @f3
  %4 = load float, ptr @f2
  %5 = load float, ptr @f1
  tail call ghccc void @callee_float(float %5, float %4, float %3, float %2, float %1, float %0) nounwind
  ret void
}

declare ghccc void @callee_float(float, float, float, float, float, float)

@d1 = external global double
@d2 = external global double
@d3 = external global double
@d4 = external global double
@d5 = external global double
@d6 = external global double

define ghccc void @caller_double() nounwind {
; CHECK-LABEL: caller_double:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a0, %hi(d6)
; CHECK-NEXT:    lui a1, %hi(d5)
; CHECK-NEXT:    lui a2, %hi(d4)
; CHECK-NEXT:    lui a3, %hi(d3)
; CHECK-NEXT:    lui a4, %hi(d2)
; CHECK-NEXT:    lui a5, %hi(d1)
; CHECK-NEXT:    ld s6, %lo(d6)(a0)
; CHECK-NEXT:    ld s5, %lo(d5)(a1)
; CHECK-NEXT:    ld s4, %lo(d4)(a2)
; CHECK-NEXT:    ld s3, %lo(d3)(a3)
; CHECK-NEXT:    ld s2, %lo(d2)(a4)
; CHECK-NEXT:    ld s1, %lo(d1)(a5)
; CHECK-NEXT:    tail callee_double
entry:
  %0  = load double, ptr @d6
  %1  = load double, ptr @d5
  %2  = load double, ptr @d4
  %3  = load double, ptr @d3
  %4 = load double, ptr @d2
  %5 = load double, ptr @d1
  tail call ghccc void @callee_double(double %5, double %4, double %3, double %2, double %1, double %0) nounwind
  ret void
}

declare ghccc void @callee_double(double, double, double, double, double, double)
