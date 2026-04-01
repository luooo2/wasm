; ModuleID = 'data/microbenchmarks/host_stat_loop.c'
source_filename = "data/microbenchmarks/host_stat_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  %3 = alloca %struct.stat, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #4
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #4
  %4 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #4
  call void @llvm.lifetime.start.p0(i64 144, ptr nonnull %3) #4
  %5 = getelementptr inbounds %struct.stat, ptr %3, i64 0, i32 3
  br label %6

6:                                                ; preds = %0, %11
  %7 = phi i32 [ 0, %0 ], [ %16, %11 ]
  %8 = phi i64 [ 0, %0 ], [ %15, %11 ]
  %9 = call i32 @stat(ptr noundef nonnull @.str, ptr noundef nonnull %3) #4
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %35

11:                                               ; preds = %6
  %12 = load i32, ptr %5, align 8, !tbaa !5
  %13 = and i32 %12, 65535
  %14 = zext nneg i32 %13 to i64
  %15 = add i64 %8, %14
  %16 = add nuw nsw i32 %7, 1
  %17 = icmp eq i32 %16, 1000
  br i1 %17, label %18, label %6, !llvm.loop !12

18:                                               ; preds = %11
  store volatile i64 %15, ptr @sink_u64, align 8, !tbaa !14
  %19 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #4
  %20 = load i64, ptr %2, align 8, !tbaa !15
  %21 = load i64, ptr %1, align 8, !tbaa !15
  %22 = sub nsw i64 %20, %21
  %23 = mul i64 %22, 1000000000
  %24 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %25 = load i64, ptr %24, align 8, !tbaa !16
  %26 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %27 = load i64, ptr %26, align 8, !tbaa !16
  %28 = icmp slt i64 %25, %27
  %29 = sub i64 %25, %27
  %30 = add i64 %29, %23
  %31 = add i64 %23, %25
  %32 = sub i64 %31, %27
  %33 = select i1 %28, i64 %32, i64 %30
  %34 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i64 noundef %33)
  br label %35

35:                                               ; preds = %6, %18
  %36 = phi i32 [ 0, %18 ], [ 1, %6 ]
  call void @llvm.lifetime.end.p0(i64 144, ptr nonnull %3) #4
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #4
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #4
  ret i32 %36
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @stat(ptr nocapture noundef readonly, ptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !10, i64 24}
!6 = !{!"stat", !7, i64 0, !7, i64 8, !7, i64 16, !10, i64 24, !10, i64 28, !10, i64 32, !10, i64 36, !7, i64 40, !7, i64 48, !7, i64 56, !7, i64 64, !11, i64 72, !11, i64 88, !11, i64 104, !8, i64 120}
!7 = !{!"long", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!"int", !8, i64 0}
!11 = !{!"timespec", !7, i64 0, !7, i64 8}
!12 = distinct !{!12, !13}
!13 = !{!"llvm.loop.mustprogress"}
!14 = !{!7, !7, i64 0}
!15 = !{!11, !7, i64 0}
!16 = !{!11, !7, i64 8}
