; ModuleID = 'data/microbenchmarks/call_many_small_funcs.c'
source_filename = "data/microbenchmarks/call_many_small_funcs.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %3

1:                                                ; preds = %3
  store volatile i64 %29, ptr @sink_u64, align 8, !tbaa !5
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %29)
  ret i32 0

3:                                                ; preds = %3, %0
  %4 = phi i64 [ 0, %0 ], [ %18, %3 ]
  %5 = phi i64 [ 1, %0 ], [ %29, %3 ]
  %6 = or disjoint i64 %4, 1
  %7 = add i64 %6, %5
  %8 = mul i64 %7, 3
  %9 = add i64 %8, 10
  %10 = shl i64 %9, 3
  %11 = xor i64 %10, %9
  %12 = add i64 %11, 11
  %13 = xor i64 %12, %4
  %14 = lshr i64 %13, 5
  %15 = add i64 %14, %13
  %16 = mul i64 %15, 5
  %17 = add i64 %16, 18
  %18 = add nuw nsw i64 %4, 2
  %19 = add i64 %18, %17
  %20 = mul i64 %19, 3
  %21 = add i64 %20, 10
  %22 = shl i64 %21, 3
  %23 = xor i64 %22, %21
  %24 = add i64 %23, 11
  %25 = xor i64 %24, %6
  %26 = lshr i64 %25, 5
  %27 = add i64 %26, %25
  %28 = mul i64 %27, 5
  %29 = add i64 %28, 18
  %30 = icmp eq i64 %18, 20000000
  br i1 %30, label %1, label %3, !llvm.loop !9
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"long", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
