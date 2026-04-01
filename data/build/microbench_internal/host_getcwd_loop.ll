; ModuleID = 'data/microbenchmarks/host_getcwd_loop.c'
source_filename = "data/microbenchmarks/host_getcwd_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_i32 = dso_local global i32 0, align 4
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  %3 = alloca [4096 x i8], align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #4
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #4
  %4 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #4
  call void @llvm.lifetime.start.p0(i64 4096, ptr nonnull %3) #4
  br label %5

5:                                                ; preds = %0, %10
  %6 = phi i32 [ 0, %0 ], [ %14, %10 ]
  %7 = phi i32 [ 0, %0 ], [ %13, %10 ]
  %8 = call ptr @getcwd(ptr noundef nonnull %3, i64 noundef 4096) #4
  %9 = icmp eq ptr %8, null
  br i1 %9, label %33, label %10

10:                                               ; preds = %5
  %11 = load i8, ptr %3, align 16, !tbaa !5
  %12 = sext i8 %11 to i32
  %13 = add nsw i32 %7, %12
  %14 = add nuw nsw i32 %6, 1
  %15 = icmp eq i32 %14, 2000
  br i1 %15, label %16, label %5, !llvm.loop !8

16:                                               ; preds = %10
  store volatile i32 %13, ptr @sink_i32, align 4, !tbaa !10
  %17 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #4
  %18 = load i64, ptr %2, align 8, !tbaa !12
  %19 = load i64, ptr %1, align 8, !tbaa !12
  %20 = sub nsw i64 %18, %19
  %21 = mul i64 %20, 1000000000
  %22 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %23 = load i64, ptr %22, align 8, !tbaa !15
  %24 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %25 = load i64, ptr %24, align 8, !tbaa !15
  %26 = icmp slt i64 %23, %25
  %27 = sub i64 %23, %25
  %28 = add i64 %27, %21
  %29 = add i64 %21, %23
  %30 = sub i64 %29, %25
  %31 = select i1 %26, i64 %30, i64 %28
  %32 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %31)
  br label %33

33:                                               ; preds = %5, %16
  %34 = phi i32 [ 0, %16 ], [ 1, %5 ]
  call void @llvm.lifetime.end.p0(i64 4096, ptr nonnull %3) #4
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #4
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #4
  ret i32 %34
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: nounwind
declare ptr @getcwd(ptr noundef, i64 noundef) local_unnamed_addr #2

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
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{!11, !11, i64 0}
!11 = !{!"int", !6, i64 0}
!12 = !{!13, !14, i64 0}
!13 = !{!"timespec", !14, i64 0, !14, i64 8}
!14 = !{!"long", !6, i64 0}
!15 = !{!13, !14, i64 8}
