; ModuleID = 'data/microbenchmarks/compute_int_divmod.c'
source_filename = "data/microbenchmarks/compute_int_divmod.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %3

1:                                                ; preds = %3
  store volatile i64 %17, ptr @sink_u64, align 8, !tbaa !5
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %17)
  ret i32 0

3:                                                ; preds = %0, %3
  %4 = phi i64 [ 17, %0 ], [ %17, %3 ]
  %5 = phi i64 [ 1, %0 ], [ %18, %3 ]
  %6 = and i64 %5, 255
  %7 = add nuw nsw i64 %6, 1
  %8 = udiv i64 %4, %7
  %9 = and i64 %5, 127
  %10 = add nuw nsw i64 %9, 1
  %11 = urem i64 %4, %10
  %12 = add i64 %8, %5
  %13 = add i64 %12, %11
  %14 = shl i64 %13, 9
  %15 = lshr i64 %13, 5
  %16 = xor i64 %15, %14
  %17 = xor i64 %16, %13
  %18 = add nuw nsw i64 %5, 1
  %19 = icmp eq i64 %18, 30000001
  br i1 %19, label %1, label %3, !llvm.loop !9
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
