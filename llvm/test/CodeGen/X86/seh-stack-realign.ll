; RUN: llc -stack-symbol-ordering=0 -mtriple=i686-windows-msvc < %s | FileCheck %s

; 32-bit catch-all has to use a filter function because that's how it saves the
; exception code.

@str = linkonce_odr unnamed_addr constant [27 x i8] c"GetExceptionCode(): 0x%lx\0A\00", align 1

declare i32 @_except_handler3(...)
declare void @crash()
declare i32 @printf(ptr nocapture readonly, ...) nounwind
declare i32 @llvm.eh.typeid.for(ptr)
declare ptr @llvm.frameaddress(i32)
declare ptr @llvm.localrecover(ptr, ptr, i32)
declare void @llvm.localescape(...)
declare ptr @llvm.eh.recoverfp(ptr, ptr)

define i32 @main() personality ptr @_except_handler3 {
entry:
  ; The EH code allocation is overaligned, triggering realignment.
  %__exceptioncode = alloca i32, align 8
  call void (...) @llvm.localescape(ptr %__exceptioncode)
  invoke void @crash() #5
          to label %__try.cont unwind label %lpad

lpad:                                             ; preds = %entry
  %cs1 = catchswitch within none [label %__except] unwind to caller

__except:                                         ; preds = %lpad
  %p = catchpad within %cs1 [ptr @"filt$main"]
  %code = load i32, ptr %__exceptioncode, align 4
  %call = call i32 (ptr, ...) @printf(ptr @str, i32 %code) #4 [ "funclet"(token %p) ]
  catchret from %p to label %__try.cont

__try.cont:                                       ; preds = %entry, %__except
  ret i32 0
}

define internal i32 @"filt$main"() {
entry:
  %ebp = tail call ptr @llvm.frameaddress(i32 1)
  %parentfp = tail call ptr @llvm.eh.recoverfp(ptr @main, ptr %ebp)
  %code.i8 = tail call ptr @llvm.localrecover(ptr @main, ptr %parentfp, i32 0)
  %info.addr = getelementptr inbounds i8, ptr %ebp, i32 -20
  %0 = load ptr, ptr %info.addr, align 4
  %1 = load ptr, ptr %0, align 4
  %2 = load i32, ptr %1, align 4
  store i32 %2, ptr %code.i8, align 4
  ret i32 1
}

; Check that we can get the exception code from eax to the printf.

; CHECK-LABEL: _main:
; CHECK: Lmain$frame_escape_0 = [[code_offs:[-0-9]+]]
; CHECK: movl %esp, [[reg_offs:[-0-9]+]](%esi)
; CHECK: movl $L__ehtable$main,
;       EH state 0
; CHECK: movl $0, 32(%esi)
; CHECK: calll _crash
; CHECK: retl
; CHECK: LBB0_[[lpbb:[0-9]+]]: # %__except
;       Restore ESP
; CHECK: movl -24(%ebp), %esp
;       Restore ESI
; CHECK: leal -36(%ebp), %esi
;       Restore EBP
; CHECK: movl 4(%esi), %ebp
; CHECK: movl [[code_offs]](%esi), %[[code:[a-z]+]]
; CHECK: pushl %[[code]]
; CHECK: pushl $_str
; CHECK: calll _printf

; CHECK: .section .xdata,"dr"
; CHECK: Lmain$parent_frame_offset = [[reg_offs]]
; CHECK: L__ehtable$main
; CHECK-NEXT: .long -1
; CHECK-NEXT: .long _filt$main
; CHECK-NEXT: .long LBB0_[[lpbb]]

; CHECK-LABEL: _filt$main:
; CHECK: pushl %ebp
; CHECK: movl %esp, %ebp
; CHECK: movl (%ebp), %[[oldebp:[a-z]+]]
; CHECK: movl -20(%[[oldebp]]), %[[ehinfo:[a-z]+]]
; CHECK: movl (%[[ehinfo]]), %[[ehrec:[a-z]+]]
; CHECK: movl (%[[ehrec]]), %[[ehcode:[a-z]+]]
; CHECK: movl %[[ehcode]], {{.*}}(%{{.*}})
