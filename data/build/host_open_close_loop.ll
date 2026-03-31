; ModuleID = 'data/microbenchmarks/host_open_close_loop.c'
source_filename = "data/microbenchmarks/host_open_close_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [24 x i8] c"bench_tmp_openclose.dat\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 577, i32 noundef 420) #4
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %20, label %3

3:                                                ; preds = %0
  %4 = tail call i64 @write(i32 noundef %1, ptr noundef nonnull @.str.1, i64 noundef 1) #4
  %5 = tail call i32 @close(i32 noundef %1) #4
  br label %6

6:                                                ; preds = %3, %11
  %7 = phi i32 [ 0, %3 ], [ %16, %11 ]
  %8 = phi i64 [ 0, %3 ], [ %14, %11 ]
  %9 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 0) #4
  %10 = icmp sgt i32 %9, -1
  br i1 %10, label %11, label %20

11:                                               ; preds = %6
  %12 = and i32 %9, 255
  %13 = zext nneg i32 %12 to i64
  %14 = add i64 %8, %13
  %15 = tail call i32 @close(i32 noundef %9) #4
  %16 = add nuw nsw i32 %7, 1
  %17 = icmp eq i32 %16, 500
  br i1 %17, label %18, label %6, !llvm.loop !5

18:                                               ; preds = %11
  store volatile i64 %14, ptr @sink_u64, align 8, !tbaa !7
  %19 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i64 noundef %14)
  br label %20

20:                                               ; preds = %6, %18, %0
  %21 = phi i32 [ 1, %0 ], [ 0, %18 ], [ 1, %6 ]
  ret i32 %21
}

; Function Attrs: nofree
declare noundef i32 @open(ptr nocapture noundef readonly, i32 noundef, ...) local_unnamed_addr #1

; Function Attrs: nofree
declare noundef i64 @write(i32 noundef, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #1

declare i32 @close(i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!8, !8, i64 0}
!8 = !{!"long", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
