; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=amdgcn -mcpu=gfx900 -denormal-fp-math-f32=ieee < %s | FileCheck -enable-var-scope -check-prefixes=GCN,GCN-DENORM %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx900 -denormal-fp-math-f32=preserve-sign < %s | FileCheck -enable-var-scope -check-prefixes=GCN,GCN-FLUSH %s

define amdgpu_kernel void @div_1_by_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_1_by_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v0, s2
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v2, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v2
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v0, v2
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_1_by_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v0, s2
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %div = fdiv float 1.000000e+00, %load, !fpmath !0
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_minus_1_by_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_minus_1_by_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v0, -s2
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v2, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v2
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v0, v2
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_minus_1_by_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v0, -s2
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %div = fdiv float -1.000000e+00, %load, !fpmath !0
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_1_by_minus_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_1_by_minus_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v0, -s2
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v2, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v2
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v0, v2
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_1_by_minus_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v0, -s2
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %neg = fneg float %load
  %div = fdiv float 1.000000e+00, %neg, !fpmath !0
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_minus_1_by_minus_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_minus_1_by_minus_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v0, s2
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v2, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v2
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v0, v2
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_minus_1_by_minus_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v0, s2
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %neg = fsub float -0.000000e+00, %load
  %div = fdiv float -1.000000e+00, %neg, !fpmath !0
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_v4_1_by_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_v4_1_by_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v4, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v0, s0
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v2, s1
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v1, s0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v3, s1
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v5, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v1, 0, v1
; GCN-DENORM-NEXT:    v_sub_u32_e32 v3, 0, v3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v5, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v0, v1
; GCN-DENORM-NEXT:    v_ldexp_f32 v1, v2, v3
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v3, s3
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v6, s2
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v3, v3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v6
; GCN-DENORM-NEXT:    v_ldexp_f32 v2, v5, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v5, s3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v5, 0, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v3, v3, v5
; GCN-DENORM-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_v4_1_by_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v4, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v0, s0
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v1, s1
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v2, s2
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v3, s3
; GCN-FLUSH-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load <4 x float>, ptr addrspace(1) %arg, align 16
  %div = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %load, !fpmath !0
  store <4 x float> %div, ptr addrspace(1) %arg, align 16
  ret void
}

define amdgpu_kernel void @div_v4_minus_1_by_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_v4_minus_1_by_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v4, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v0, -s0
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v2, -s1
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v1, s0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v3, s1
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v5, -s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v1, 0, v1
; GCN-DENORM-NEXT:    v_sub_u32_e32 v3, 0, v3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v5, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v0, v1
; GCN-DENORM-NEXT:    v_ldexp_f32 v1, v2, v3
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v3, -s3
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v6, s2
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v3, v3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v6
; GCN-DENORM-NEXT:    v_ldexp_f32 v2, v5, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v5, s3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v5, 0, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v3, v3, v5
; GCN-DENORM-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_v4_minus_1_by_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v4, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v0, -s0
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v1, -s1
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v2, -s2
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v3, -s3
; GCN-FLUSH-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load <4 x float>, ptr addrspace(1) %arg, align 16
  %div = fdiv <4 x float> <float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00>, %load, !fpmath !0
  store <4 x float> %div, ptr addrspace(1) %arg, align 16
  ret void
}

define amdgpu_kernel void @div_v4_1_by_minus_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_v4_1_by_minus_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v4, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v0, -s0
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v2, -s1
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v1, s0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v3, s1
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v5, -s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v1, 0, v1
; GCN-DENORM-NEXT:    v_sub_u32_e32 v3, 0, v3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v5, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v0, v1
; GCN-DENORM-NEXT:    v_ldexp_f32 v1, v2, v3
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v3, -s3
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v6, s2
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v3, v3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v6
; GCN-DENORM-NEXT:    v_ldexp_f32 v2, v5, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v5, s3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v5, 0, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v3, v3, v5
; GCN-DENORM-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_v4_1_by_minus_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v4, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v0, -s0
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v1, -s1
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v2, -s2
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v3, -s3
; GCN-FLUSH-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load <4 x float>, ptr addrspace(1) %arg, align 16
  %neg = fneg <4 x float> %load
  %div = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %neg, !fpmath !0
  store <4 x float> %div, ptr addrspace(1) %arg, align 16
  ret void
}

define amdgpu_kernel void @div_v4_minus_1_by_minus_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_v4_minus_1_by_minus_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v4, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v0, s0
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v2, s1
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v1, s0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v3, s1
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v5, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v1, 0, v1
; GCN-DENORM-NEXT:    v_sub_u32_e32 v3, 0, v3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v5, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v0, v1
; GCN-DENORM-NEXT:    v_ldexp_f32 v1, v2, v3
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v3, s3
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v6, s2
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v3, v3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v6
; GCN-DENORM-NEXT:    v_ldexp_f32 v2, v5, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v5, s3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v5, 0, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v3, v3, v5
; GCN-DENORM-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_v4_minus_1_by_minus_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v4, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v0, s0
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v1, s1
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v2, s2
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v3, s3
; GCN-FLUSH-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load <4 x float>, ptr addrspace(1) %arg, align 16
  %neg = fneg <4 x float> %load
  %div = fdiv <4 x float> <float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00>, %neg, !fpmath !0
  store <4 x float> %div, ptr addrspace(1) %arg, align 16
  ret void
}

define amdgpu_kernel void @div_v4_c_by_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_v4_c_by_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v4, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v1, s0
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v2, s1
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v1, v1
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v3, s1
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v5, -s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v3, 0, v3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v5, v5
; GCN-DENORM-NEXT:    v_mul_f32_e32 v7, 0.5, v1
; GCN-DENORM-NEXT:    v_ldexp_f32 v1, v2, v3
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v2, s3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v3, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v6, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v6
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v0, s0
; GCN-DENORM-NEXT:    v_ldexp_f32 v2, v5, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v5, s3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v0, 2, v0
; GCN-DENORM-NEXT:    v_mul_f32_e32 v3, -0.5, v3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v5, 2, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v7, v0
; GCN-DENORM-NEXT:    v_ldexp_f32 v3, v3, v5
; GCN-DENORM-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_v4_c_by_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v0, 0x6f800000
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0x2f800000
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v4, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_cmp_gt_f32_e64 vcc, |s0|, v0
; GCN-FLUSH-NEXT:    v_cndmask_b32_e32 v3, 1.0, v1, vcc
; GCN-FLUSH-NEXT:    v_cmp_gt_f32_e64 vcc, |s3|, v0
; GCN-FLUSH-NEXT:    v_cndmask_b32_e32 v5, 1.0, v1, vcc
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v0, s0, v3
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v1, s3, v5
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v0, v0
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v6, v1
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v1, s1
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v2, -s2
; GCN-FLUSH-NEXT:    v_add_f32_e32 v0, v0, v0
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v6, -2.0, v6
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v0, v3, v0
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v3, v5, v6
; GCN-FLUSH-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load <4 x float>, ptr addrspace(1) %arg, align 16
  %div = fdiv <4 x float> <float 2.000000e+00, float 1.000000e+00, float -1.000000e+00, float -2.000000e+00>, %load, !fpmath !0
  store <4 x float> %div, ptr addrspace(1) %arg, align 16
  ret void
}

define amdgpu_kernel void @div_v4_c_by_minus_x_25ulp(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_v4_c_by_minus_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v4, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v1, -s0
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v2, -s1
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v1, v1
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v3, s1
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v5, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v3, 0, v3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v5, v5
; GCN-DENORM-NEXT:    v_mul_f32_e32 v7, 0.5, v1
; GCN-DENORM-NEXT:    v_ldexp_f32 v1, v2, v3
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e64 v2, -s3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v3, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v6, s2
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, 0, v6
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v0, s0
; GCN-DENORM-NEXT:    v_ldexp_f32 v2, v5, v2
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v5, s3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v0, 2, v0
; GCN-DENORM-NEXT:    v_mul_f32_e32 v3, -0.5, v3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v5, 2, v5
; GCN-DENORM-NEXT:    v_ldexp_f32 v0, v7, v0
; GCN-DENORM-NEXT:    v_ldexp_f32 v3, v3, v5
; GCN-DENORM-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_v4_c_by_minus_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v0, 0x6f800000
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v2, 0x2f800000
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v4, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_cmp_gt_f32_e64 vcc, |s0|, v0
; GCN-FLUSH-NEXT:    v_cndmask_b32_e32 v3, 1.0, v2, vcc
; GCN-FLUSH-NEXT:    v_cmp_gt_f32_e64 vcc, |s3|, v0
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v5, s0, v3
; GCN-FLUSH-NEXT:    v_mul_f32_e64 v6, -s0, v3
; GCN-FLUSH-NEXT:    v_cndmask_b32_e32 v7, 1.0, v2, vcc
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v5, v5
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v6, v6
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v0, s3, v7
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v8, v0
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v1, -s1
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v2, s2
; GCN-FLUSH-NEXT:    v_sub_f32_e32 v0, v6, v5
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v0, v3, v0
; GCN-FLUSH-NEXT:    v_add_f32_e32 v3, v8, v8
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v3, v7, v3
; GCN-FLUSH-NEXT:    global_store_dwordx4 v4, v[0:3], s[6:7]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load <4 x float>, ptr addrspace(1) %arg, align 16
  %neg = fneg <4 x float> %load
  %div = fdiv <4 x float> <float 2.000000e+00, float 1.000000e+00, float -1.000000e+00, float -2.000000e+00>, %neg, !fpmath !0
  store <4 x float> %div, ptr addrspace(1) %arg, align 16
  ret void
}

define amdgpu_kernel void @div_v_by_x_25ulp(ptr addrspace(1) %arg, float %num) {
; GCN-DENORM-LABEL: div_v_by_x_25ulp:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    s_load_dword s2, s[4:5], 0x2c
; GCN-DENORM-NEXT:    v_mov_b32_e32 v0, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s3, s[0:1], 0x0
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v2, s2
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v3, s2
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_frexp_mant_f32_e32 v1, s3
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v1, v1
; GCN-DENORM-NEXT:    v_frexp_exp_i32_f32_e32 v4, s3
; GCN-DENORM-NEXT:    v_sub_u32_e32 v2, v2, v4
; GCN-DENORM-NEXT:    v_mul_f32_e32 v1, v3, v1
; GCN-DENORM-NEXT:    v_ldexp_f32 v1, v1, v2
; GCN-DENORM-NEXT:    global_store_dword v0, v1, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_v_by_x_25ulp:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    s_load_dword s2, s[4:5], 0x2c
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v0, 0x6f800000
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0x2f800000
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v2, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s3, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_cmp_gt_f32_e64 vcc, |s3|, v0
; GCN-FLUSH-NEXT:    v_cndmask_b32_e32 v0, 1.0, v1, vcc
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v1, s3, v0
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v1, v1
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v1, s2, v1
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v0, v0, v1
; GCN-FLUSH-NEXT:    global_store_dword v2, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %div = fdiv float %num, %load, !fpmath !0
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_1_by_x_fast(ptr addrspace(1) %arg) {
; GCN-LABEL: div_1_by_x_fast:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_rcp_f32_e32 v0, s2
; GCN-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %div = fdiv fast float 1.000000e+00, %load, !fpmath !0
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_minus_1_by_x_fast(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_minus_1_by_x_fast:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_rcp_f32_e64 v0, -s2
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_minus_1_by_x_fast:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v0, s2
; GCN-FLUSH-NEXT:    v_sub_f32_e32 v0, 0x80000000, v0
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %div = fdiv fast float -1.000000e+00, %load, !fpmath !0
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_1_by_minus_x_fast(ptr addrspace(1) %arg) {
; GCN-LABEL: div_1_by_minus_x_fast:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_rcp_f32_e64 v0, -s2
; GCN-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %neg = fneg float %load, !fpmath !0
  %div = fdiv fast float 1.000000e+00, %neg
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_minus_1_by_minus_x_fast(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_minus_1_by_minus_x_fast:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v0, s2
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_minus_1_by_minus_x_fast:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s2, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_rcp_f32_e64 v0, -s2
; GCN-FLUSH-NEXT:    v_sub_f32_e32 v0, 0x80000000, v0
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %neg = fsub float -0.000000e+00, %load, !fpmath !0
  %div = fdiv fast float -1.000000e+00, %neg
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_1_by_x_correctly_rounded(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_1_by_x_correctly_rounded:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_div_scale_f32 v0, s[2:3], s4, s4, 1.0
; GCN-DENORM-NEXT:    v_div_scale_f32 v1, vcc, 1.0, s4, 1.0
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v0
; GCN-DENORM-NEXT:    v_fma_f32 v3, -v0, v2, 1.0
; GCN-DENORM-NEXT:    v_fma_f32 v2, v3, v2, v2
; GCN-DENORM-NEXT:    v_mul_f32_e32 v3, v1, v2
; GCN-DENORM-NEXT:    v_fma_f32 v4, -v0, v3, v1
; GCN-DENORM-NEXT:    v_fma_f32 v3, v4, v2, v3
; GCN-DENORM-NEXT:    v_fma_f32 v0, -v0, v3, v1
; GCN-DENORM-NEXT:    v_div_fmas_f32 v0, v0, v2, v3
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    v_div_fixup_f32 v0, v0, s4, 1.0
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_1_by_x_correctly_rounded:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_div_scale_f32 v0, s[2:3], s4, s4, 1.0
; GCN-FLUSH-NEXT:    v_div_scale_f32 v1, vcc, 1.0, s4, 1.0
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v2, v0
; GCN-FLUSH-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 4, 2), 3
; GCN-FLUSH-NEXT:    v_fma_f32 v3, -v0, v2, 1.0
; GCN-FLUSH-NEXT:    v_fma_f32 v2, v3, v2, v2
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v3, v1, v2
; GCN-FLUSH-NEXT:    v_fma_f32 v4, -v0, v3, v1
; GCN-FLUSH-NEXT:    v_fma_f32 v3, v4, v2, v3
; GCN-FLUSH-NEXT:    v_fma_f32 v0, -v0, v3, v1
; GCN-FLUSH-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 4, 2), 0
; GCN-FLUSH-NEXT:    v_div_fmas_f32 v0, v0, v2, v3
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    v_div_fixup_f32 v0, v0, s4, 1.0
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %div = fdiv float 1.000000e+00, %load
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_minus_1_by_x_correctly_rounded(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_minus_1_by_x_correctly_rounded:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_div_scale_f32 v0, s[2:3], s4, s4, -1.0
; GCN-DENORM-NEXT:    v_div_scale_f32 v1, vcc, -1.0, s4, -1.0
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v0
; GCN-DENORM-NEXT:    v_fma_f32 v3, -v0, v2, 1.0
; GCN-DENORM-NEXT:    v_fma_f32 v2, v3, v2, v2
; GCN-DENORM-NEXT:    v_mul_f32_e32 v3, v1, v2
; GCN-DENORM-NEXT:    v_fma_f32 v4, -v0, v3, v1
; GCN-DENORM-NEXT:    v_fma_f32 v3, v4, v2, v3
; GCN-DENORM-NEXT:    v_fma_f32 v0, -v0, v3, v1
; GCN-DENORM-NEXT:    v_div_fmas_f32 v0, v0, v2, v3
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    v_div_fixup_f32 v0, v0, s4, -1.0
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_minus_1_by_x_correctly_rounded:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_div_scale_f32 v0, s[2:3], s4, s4, -1.0
; GCN-FLUSH-NEXT:    v_div_scale_f32 v1, vcc, -1.0, s4, -1.0
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v2, v0
; GCN-FLUSH-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 4, 2), 3
; GCN-FLUSH-NEXT:    v_fma_f32 v3, -v0, v2, 1.0
; GCN-FLUSH-NEXT:    v_fma_f32 v2, v3, v2, v2
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v3, v1, v2
; GCN-FLUSH-NEXT:    v_fma_f32 v4, -v0, v3, v1
; GCN-FLUSH-NEXT:    v_fma_f32 v3, v4, v2, v3
; GCN-FLUSH-NEXT:    v_fma_f32 v0, -v0, v3, v1
; GCN-FLUSH-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 4, 2), 0
; GCN-FLUSH-NEXT:    v_div_fmas_f32 v0, v0, v2, v3
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    v_div_fixup_f32 v0, v0, s4, -1.0
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %div = fdiv float -1.000000e+00, %load
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_1_by_minus_x_correctly_rounded(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_1_by_minus_x_correctly_rounded:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_div_scale_f32 v0, s[2:3], s4, s4, -1.0
; GCN-DENORM-NEXT:    v_div_scale_f32 v1, vcc, -1.0, s4, -1.0
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v0
; GCN-DENORM-NEXT:    v_fma_f32 v3, -v0, v2, 1.0
; GCN-DENORM-NEXT:    v_fma_f32 v2, v3, v2, v2
; GCN-DENORM-NEXT:    v_mul_f32_e32 v3, v1, v2
; GCN-DENORM-NEXT:    v_fma_f32 v4, -v0, v3, v1
; GCN-DENORM-NEXT:    v_fma_f32 v3, v4, v2, v3
; GCN-DENORM-NEXT:    v_fma_f32 v0, -v0, v3, v1
; GCN-DENORM-NEXT:    v_div_fmas_f32 v0, v0, v2, v3
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    v_div_fixup_f32 v0, v0, s4, -1.0
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_1_by_minus_x_correctly_rounded:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_div_scale_f32 v0, s[2:3], -s4, -s4, 1.0
; GCN-FLUSH-NEXT:    v_div_scale_f32 v1, vcc, 1.0, -s4, 1.0
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v2, v0
; GCN-FLUSH-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 4, 2), 3
; GCN-FLUSH-NEXT:    v_fma_f32 v3, -v0, v2, 1.0
; GCN-FLUSH-NEXT:    v_fma_f32 v2, v3, v2, v2
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v3, v1, v2
; GCN-FLUSH-NEXT:    v_fma_f32 v4, -v0, v3, v1
; GCN-FLUSH-NEXT:    v_fma_f32 v3, v4, v2, v3
; GCN-FLUSH-NEXT:    v_fma_f32 v0, -v0, v3, v1
; GCN-FLUSH-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 4, 2), 0
; GCN-FLUSH-NEXT:    v_div_fmas_f32 v0, v0, v2, v3
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    v_div_fixup_f32 v0, v0, -s4, 1.0
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %neg = fsub float -0.000000e+00, %load
  %div = fdiv float 1.000000e+00, %neg
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

define amdgpu_kernel void @div_minus_1_by_minus_x_correctly_rounded(ptr addrspace(1) %arg) {
; GCN-DENORM-LABEL: div_minus_1_by_minus_x_correctly_rounded:
; GCN-DENORM:       ; %bb.0:
; GCN-DENORM-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-DENORM-NEXT:    v_div_scale_f32 v0, s[2:3], s4, s4, 1.0
; GCN-DENORM-NEXT:    v_div_scale_f32 v1, vcc, 1.0, s4, 1.0
; GCN-DENORM-NEXT:    v_rcp_f32_e32 v2, v0
; GCN-DENORM-NEXT:    v_fma_f32 v3, -v0, v2, 1.0
; GCN-DENORM-NEXT:    v_fma_f32 v2, v3, v2, v2
; GCN-DENORM-NEXT:    v_mul_f32_e32 v3, v1, v2
; GCN-DENORM-NEXT:    v_fma_f32 v4, -v0, v3, v1
; GCN-DENORM-NEXT:    v_fma_f32 v3, v4, v2, v3
; GCN-DENORM-NEXT:    v_fma_f32 v0, -v0, v3, v1
; GCN-DENORM-NEXT:    v_div_fmas_f32 v0, v0, v2, v3
; GCN-DENORM-NEXT:    v_mov_b32_e32 v1, 0
; GCN-DENORM-NEXT:    v_div_fixup_f32 v0, v0, s4, 1.0
; GCN-DENORM-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-DENORM-NEXT:    s_endpgm
;
; GCN-FLUSH-LABEL: div_minus_1_by_minus_x_correctly_rounded:
; GCN-FLUSH:       ; %bb.0:
; GCN-FLUSH-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-FLUSH-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-FLUSH-NEXT:    v_div_scale_f32 v0, s[2:3], -s4, -s4, -1.0
; GCN-FLUSH-NEXT:    v_div_scale_f32 v1, vcc, -1.0, -s4, -1.0
; GCN-FLUSH-NEXT:    v_rcp_f32_e32 v2, v0
; GCN-FLUSH-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 4, 2), 3
; GCN-FLUSH-NEXT:    v_fma_f32 v3, -v0, v2, 1.0
; GCN-FLUSH-NEXT:    v_fma_f32 v2, v3, v2, v2
; GCN-FLUSH-NEXT:    v_mul_f32_e32 v3, v1, v2
; GCN-FLUSH-NEXT:    v_fma_f32 v4, -v0, v3, v1
; GCN-FLUSH-NEXT:    v_fma_f32 v3, v4, v2, v3
; GCN-FLUSH-NEXT:    v_fma_f32 v0, -v0, v3, v1
; GCN-FLUSH-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 4, 2), 0
; GCN-FLUSH-NEXT:    v_div_fmas_f32 v0, v0, v2, v3
; GCN-FLUSH-NEXT:    v_mov_b32_e32 v1, 0
; GCN-FLUSH-NEXT:    v_div_fixup_f32 v0, v0, -s4, -1.0
; GCN-FLUSH-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-FLUSH-NEXT:    s_endpgm
  %load = load float, ptr addrspace(1) %arg, align 4
  %neg = fsub float -0.000000e+00, %load
  %div = fdiv float -1.000000e+00, %neg
  store float %div, ptr addrspace(1) %arg, align 4
  ret void
}

!0 = !{float 2.500000e+00}
