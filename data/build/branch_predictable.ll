; ModuleID = 'data/microbenchmarks/branch_predictable.c'
source_filename = "data/microbenchmarks/branch_predictable.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %1, %0
  %2 = phi i64 [ 0, %0 ], [ %15, %1 ]
  %3 = phi <2 x i64> [ <i64 0, i64 1>, %0 ], [ %16, %1 ]
  %4 = phi <2 x i64> [ zeroinitializer, %0 ], [ %13, %1 ]
  %5 = phi <2 x i64> [ zeroinitializer, %0 ], [ %14, %1 ]
  %6 = add <2 x i64> %3, <i64 2, i64 2>
  %7 = and <2 x i64> %3, <i64 1, i64 1>
  %8 = and <2 x i64> %3, <i64 1, i64 1>
  %9 = icmp eq <2 x i64> %7, zeroinitializer
  %10 = icmp eq <2 x i64> %8, zeroinitializer
  %11 = select <2 x i1> %9, <2 x i64> %3, <2 x i64> <i64 3, i64 3>
  %12 = select <2 x i1> %10, <2 x i64> %6, <2 x i64> <i64 3, i64 3>
  %13 = add <2 x i64> %11, %4
  %14 = add <2 x i64> %12, %5
  %15 = add nuw i64 %2, 4
  %16 = add <2 x i64> %3, <i64 4, i64 4>
  %17 = icmp eq i64 %15, 60000000
  br i1 %17, label %18, label %1, !llvm.loop !5

18:                                               ; preds = %1
  %19 = add <2 x i64> %14, %13
  %20 = tail call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %19)
  store volatile i64 %20, ptr @sink_u64, align 8, !tbaa !9
  %21 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %20)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>) #2

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6, !7, !8}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!"llvm.loop.isvectorized", i32 1}
!8 = !{!"llvm.loop.unroll.runtime.disable"}
!9 = !{!10, !10, i64 0}
!10 = !{!"long", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
