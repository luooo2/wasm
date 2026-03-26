; ModuleID = 'data/microbenchmarks/branch_nested.c'
source_filename = "data/microbenchmarks/branch_nested.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %3

1:                                                ; preds = %24
  store volatile i64 %25, ptr @sink_u64, align 8, !tbaa !5
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %25)
  ret i32 0

3:                                                ; preds = %0, %24
  %4 = phi i64 [ 0, %0 ], [ %26, %24 ]
  %5 = phi i64 [ 0, %0 ], [ %25, %24 ]
  %6 = and i64 %4, 1
  %7 = icmp eq i64 %6, 0
  br i1 %7, label %8, label %16

8:                                                ; preds = %3
  %9 = and i64 %4, 2
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %11, label %13

11:                                               ; preds = %8
  %12 = add i64 %4, %5
  br label %24

13:                                               ; preds = %8
  %14 = lshr exact i64 %4, 1
  %15 = add i64 %14, %5
  br label %24

16:                                               ; preds = %3
  %17 = and i64 %4, 7
  %18 = icmp eq i64 %17, 1
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  %20 = sub i64 %5, %4
  br label %24

21:                                               ; preds = %16
  %22 = xor i64 %4, 40503
  %23 = add i64 %22, %5
  br label %24

24:                                               ; preds = %13, %11, %21, %19
  %25 = phi i64 [ %12, %11 ], [ %15, %13 ], [ %20, %19 ], [ %23, %21 ]
  %26 = add nuw nsw i64 %4, 1
  %27 = icmp eq i64 %26, 35000000
  br i1 %27, label %1, label %3, !llvm.loop !9
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
