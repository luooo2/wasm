; ModuleID = 'data/microbenchmarks/branch_switch_dense.c'
source_filename = "data/microbenchmarks/branch_switch_dense.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1
@switch.table.main = private unnamed_addr constant [7 x i64] [i64 1, i64 3, i64 5, i64 7, i64 11, i64 13, i64 17], align 8

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %3

1:                                                ; preds = %18
  store volatile i64 %21, ptr @sink_u64, align 8, !tbaa !5
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %21)
  ret i32 0

3:                                                ; preds = %18, %0
  %4 = phi i64 [ 0, %0 ], [ %22, %18 ]
  %5 = phi i64 [ 0, %0 ], [ %21, %18 ]
  %6 = and i64 %4, 6
  %7 = getelementptr inbounds [7 x i64], ptr @switch.table.main, i64 0, i64 %6
  %8 = load i64, ptr %7, align 8
  %9 = add nuw nsw i64 %4, %8
  %10 = add i64 %9, %5
  %11 = or disjoint i64 %4, 1
  %12 = and i64 %11, 7
  %13 = icmp eq i64 %12, 7
  br i1 %13, label %18, label %14

14:                                               ; preds = %3
  %15 = and i64 %11, 7
  %16 = getelementptr inbounds [7 x i64], ptr @switch.table.main, i64 0, i64 %15
  %17 = load i64, ptr %16, align 8
  br label %18

18:                                               ; preds = %14, %3
  %19 = phi i64 [ %17, %14 ], [ 19, %3 ]
  %20 = add nuw nsw i64 %11, %19
  %21 = add i64 %20, %10
  %22 = add nuw nsw i64 %4, 2
  %23 = icmp eq i64 %22, 45000000
  br i1 %23, label %1, label %3, !llvm.loop !9
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
