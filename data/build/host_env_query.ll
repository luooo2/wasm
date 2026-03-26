; ModuleID = 'data/microbenchmarks/host_env_query.c'
source_filename = "data/microbenchmarks/host_env_query.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_i32 = dso_local global i32 0, align 4
@.str = private unnamed_addr constant [5 x i8] c"PATH\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call ptr @getenv(ptr noundef nonnull @.str) #3
  %2 = icmp eq ptr %1, null
  br label %5

3:                                                ; preds = %30
  store volatile i32 %31, ptr @sink_i32, align 4, !tbaa !5
  %4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %31)
  ret i32 0

5:                                                ; preds = %30, %0
  %6 = phi i32 [ 0, %0 ], [ %31, %30 ]
  %7 = phi i32 [ 0, %0 ], [ %32, %30 ]
  br i1 %2, label %14, label %8

8:                                                ; preds = %5
  %9 = load i8, ptr %1, align 1, !tbaa !9
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %14, label %11

11:                                               ; preds = %8
  %12 = sext i8 %9 to i32
  %13 = add nsw i32 %6, %12
  br label %14

14:                                               ; preds = %11, %8, %5
  %15 = phi i32 [ %13, %11 ], [ %6, %8 ], [ %6, %5 ]
  br i1 %2, label %22, label %16

16:                                               ; preds = %14
  %17 = load i8, ptr %1, align 1, !tbaa !9
  %18 = icmp eq i8 %17, 0
  br i1 %18, label %22, label %19

19:                                               ; preds = %16
  %20 = sext i8 %17 to i32
  %21 = add nsw i32 %15, %20
  br label %22

22:                                               ; preds = %19, %16, %14
  %23 = phi i32 [ %21, %19 ], [ %15, %16 ], [ %15, %14 ]
  br i1 %2, label %30, label %24

24:                                               ; preds = %22
  %25 = load i8, ptr %1, align 1, !tbaa !9
  %26 = icmp eq i8 %25, 0
  br i1 %26, label %30, label %27

27:                                               ; preds = %24
  %28 = sext i8 %25 to i32
  %29 = add nsw i32 %23, %28
  br label %30

30:                                               ; preds = %27, %24, %22
  %31 = phi i32 [ %29, %27 ], [ %23, %24 ], [ %23, %22 ]
  %32 = add nuw nsw i32 %7, 3
  %33 = icmp eq i32 %32, 600000
  br i1 %33, label %3, label %5, !llvm.loop !10
}

; Function Attrs: nofree nounwind memory(read)
declare noundef ptr @getenv(ptr nocapture noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind memory(read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!7, !7, i64 0}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
