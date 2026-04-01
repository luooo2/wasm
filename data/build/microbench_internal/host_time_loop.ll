; ModuleID = 'data/microbenchmarks/host_time_loop.c'
source_filename = "data/microbenchmarks/host_time_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_i64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  %3 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #4
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #4
  %4 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #4
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3) #4
  %5 = getelementptr inbounds %struct.timespec, ptr %3, i64 0, i32 1
  br label %23

6:                                                ; preds = %23
  store volatile i64 %29, ptr @sink_i64, align 8, !tbaa !5
  %7 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #4
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
  %22 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %21)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3) #4
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #4
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #4
  ret i32 0

23:                                               ; preds = %0, %23
  %24 = phi i32 [ 0, %0 ], [ %30, %23 ]
  %25 = phi i64 [ 0, %0 ], [ %29, %23 ]
  %26 = call i32 @clock_gettime(i32 noundef 0, ptr noundef nonnull %3) #4
  %27 = load i64, ptr %5, align 8, !tbaa !12
  %28 = and i64 %27, 1023
  %29 = add nuw nsw i64 %28, %25
  %30 = add nuw nsw i32 %24, 1
  %31 = icmp eq i32 %30, 2000
  br i1 %31, label %6, label %23, !llvm.loop !13
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

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
!5 = !{!6, !6, i64 0}
!6 = !{!"long long", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !11, i64 0}
!10 = !{!"timespec", !11, i64 0, !11, i64 8}
!11 = !{!"long", !7, i64 0}
!12 = !{!10, !11, i64 8}
!13 = distinct !{!13, !14}
!14 = !{!"llvm.loop.mustprogress"}
