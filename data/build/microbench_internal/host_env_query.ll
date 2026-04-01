; ModuleID = 'data/microbenchmarks/host_env_query.c'
source_filename = "data/microbenchmarks/host_env_query.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_i32 = dso_local global i32 0, align 4
@.str = private unnamed_addr constant [5 x i8] c"PATH\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #5
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #5
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #5
  %4 = call ptr @getenv(ptr noundef nonnull @.str) #5
  %5 = icmp eq ptr %4, null
  br label %23

6:                                                ; preds = %40
  store volatile i32 %41, ptr @sink_i32, align 4, !tbaa !5
  %7 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #5
  %8 = load i64, ptr %2, align 8, !tbaa !9
  %9 = load i64, ptr %1, align 8, !tbaa !9
  %10 = sub nsw i64 %8, %9
  %11 = mul i64 %10, 1000000000
  %12 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %13 = load i64, ptr %12, align 8, !tbaa !12
  %14 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %15 = load i64, ptr %14, align 8, !tbaa !12
  %16 = icmp slt i64 %13, %15
  %17 = sub i64 %13, %15
  %18 = add i64 %17, %11
  %19 = add i64 %11, %13
  %20 = sub i64 %19, %15
  %21 = select i1 %16, i64 %20, i64 %18
  %22 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i64 noundef %21)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #5
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #5
  ret i32 0

23:                                               ; preds = %40, %0
  %24 = phi i32 [ 0, %0 ], [ %42, %40 ]
  %25 = phi i32 [ 0, %0 ], [ %41, %40 ]
  br i1 %5, label %32, label %26

26:                                               ; preds = %23
  %27 = load i8, ptr %4, align 1, !tbaa !13
  %28 = icmp eq i8 %27, 0
  br i1 %28, label %32, label %29

29:                                               ; preds = %26
  %30 = sext i8 %27 to i32
  %31 = add nsw i32 %25, %30
  br label %32

32:                                               ; preds = %29, %26, %23
  %33 = phi i32 [ %31, %29 ], [ %25, %26 ], [ %25, %23 ]
  br i1 %5, label %40, label %34

34:                                               ; preds = %32
  %35 = load i8, ptr %4, align 1, !tbaa !13
  %36 = icmp eq i8 %35, 0
  br i1 %36, label %40, label %37

37:                                               ; preds = %34
  %38 = sext i8 %35 to i32
  %39 = add nsw i32 %33, %38
  br label %40

40:                                               ; preds = %37, %34, %32
  %41 = phi i32 [ %39, %37 ], [ %33, %34 ], [ %33, %32 ]
  %42 = add nuw nsw i32 %24, 2
  %43 = icmp eq i32 %42, 2000
  br i1 %43, label %6, label %23, !llvm.loop !14
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind memory(read)
declare noundef ptr @getenv(ptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind memory(read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

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
!9 = !{!10, !11, i64 0}
!10 = !{!"timespec", !11, i64 0, !11, i64 8}
!11 = !{!"long", !7, i64 0}
!12 = !{!10, !11, i64 8}
!13 = !{!7, !7, i64 0}
!14 = distinct !{!14, !15}
!15 = !{!"llvm.loop.mustprogress"}
