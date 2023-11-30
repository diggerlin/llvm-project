// RUN: %clang_cc1 -triple powerpc-unknown-aix -emit-llvm -x c++ < %s | FileCheck %s

bool isPower8() {
  return __builtin_cpu_is("power8");
}

bool isPower5Plus() {
  return __builtin_cpu_is("power5+");
}

bool isPower476() {
  return __builtin_cpu_is("ppc476");
}


// CHECK:      @_system_configuration = external global { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i32, i32, i32, i32, i64, i64, i64, i64, i32, i32, i32, i32, i32, i32, i64, i32, i8, i8, i8, i8, i32, i32, i16, i16, [3 x i32], i32 }

// CHECK:     define noundef zeroext i1 @_Z8isPower8v() #0 {
// CHECK-NEXT: entry:
// CHECK-NEXT:   %0 = load i32, ptr getelementptr inbounds ({ i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i32, i32, i32, i32, i64, i64, i64, i64, i32, i32, i32, i32, i32, i32, i64, i32, i8, i8, i8, i8, i32, i32, i16, i16, [3 x i32], i32 }, ptr @_system_configuration, i32 0, i32 2), align 4
// CHECK-NEXT:   %1 = lshr i32 %0, 16
// CHECK-NEXT:   %2 = and i32 %0, 4095
// CHECK-NEXT:   %3 = icmp eq i32 %1, 48
// CHECK-NEXT:   %4 = icmp eq i32 %2, 0
// CHECK-NEXT:   %5 = select i1 %4, i1 %3, i1 false
// CHECK-NEXT:   ret i1 %5
// CHECK-NEXT: }

// CHECK:     define noundef zeroext i1 @_Z12isPower5Plusv() #0 {
// CHECK-NEXT: entry:
// CHECK-NEXT:   %0 = load i32, ptr getelementptr inbounds ({ i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i32, i32, i32, i32, i64, i64, i64, i64, i32, i32, i32, i32, i32, i32, i64, i32, i8, i8, i8, i8, i32, i32, i16, i16, [3 x i32], i32 }, ptr @_system_configuration, i32 0, i32 2), align 4
// CHECK-NEXT:   %1 = lshr i32 %0, 16
// CHECK-NEXT:   %2 = and i32 %0, 4095
// CHECK-NEXT:   %3 = icmp eq i32 %1, 15
// CHECK-NEXT:   %4 = icmp ne i32 %2, 0
// CHECK-NEXT:   %5 = select i1 %4, i1 %3, i1 false
// CHECK-NEXT:   ret i1 %5
// CHECK-NEXT: }

// CHECK:      define noundef zeroext i1 @_Z10isPower476v() #0 {
// CHECK-NEXT: entry:
// CHECK-NEXT:   ret i1 false
// CHECK-NEXT: }
