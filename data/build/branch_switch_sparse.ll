; ModuleID = 'data/microbenchmarks/branch_switch_sparse.c'
source_filename = "data/microbenchmarks/branch_switch_sparse.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %3

1:                                                ; preds = %29
  store volatile i64 %30, ptr @sink_u64, align 8, !tbaa !5
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %30)
  ret i32 0

3:                                                ; preds = %0, %29
  %4 = phi i64 [ 0, %0 ], [ %31, %29 ]
  %5 = phi i64 [ 0, %0 ], [ %30, %29 ]
  %6 = phi i64 [ 2463534242, %0 ], [ %12, %29 ]
  %7 = shl i64 %6, 13
  %8 = xor i64 %7, %6
  %9 = lshr i64 %8, 17
  %10 = xor i64 %9, %8
  %11 = shl i64 %10, 5
  %12 = xor i64 %11, %10
  %13 = urem i64 %12, 97
  %14 = trunc i64 %13 to i32
  switch i32 %14, label %26 [
    i32 0, label %15
    i32 17, label %17
    i32 53, label %20
    i32 89, label %23
  ]

15:                                               ; preds = %3
  %16 = add i64 %4, %5
  br label %29

17:                                               ; preds = %3
  %18 = shl nuw nsw i64 %4, 1
  %19 = add i64 %18, %5
  br label %29

20:                                               ; preds = %3
  %21 = add i64 %12, %4
  %22 = xor i64 %21, %5
  br label %29

23:                                               ; preds = %3
  %24 = and i64 %4, 255
  %25 = sub i64 %5, %24
  br label %29

26:                                               ; preds = %3
  %27 = and i64 %10, 15
  %28 = add i64 %27, %5
  br label %29

29:                                               ; preds = %15, %17, %20, %23, %26
  %30 = phi i64 [ %28, %26 ], [ %25, %23 ], [ %22, %20 ], [ %19, %17 ], [ %16, %15 ]
  %31 = add nuw nsw i64 %4, 1
  %32 = icmp eq i64 %31, 45000000
  br i1 %32, label %1, label %3, !llvm.loop !9
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
