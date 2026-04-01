; ModuleID = 'data/microbenchmarks/host_write_small.c'
source_filename = "data/microbenchmarks/host_write_small.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [20 x i8] c"bench_tmp_write.dat\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  %3 = alloca [64 x i8], align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #6
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #6
  %4 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #6
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %3) #6
  store <16 x i8> <i8 1, i8 4, i8 7, i8 10, i8 13, i8 16, i8 19, i8 22, i8 25, i8 28, i8 31, i8 34, i8 37, i8 40, i8 43, i8 46>, ptr %3, align 16, !tbaa !5
  %5 = getelementptr inbounds [64 x i8], ptr %3, i64 0, i64 16
  store <16 x i8> <i8 49, i8 52, i8 55, i8 58, i8 61, i8 64, i8 67, i8 70, i8 73, i8 76, i8 79, i8 82, i8 85, i8 88, i8 91, i8 94>, ptr %5, align 16, !tbaa !5
  %6 = getelementptr inbounds [64 x i8], ptr %3, i64 0, i64 32
  store <16 x i8> <i8 97, i8 100, i8 103, i8 106, i8 109, i8 112, i8 115, i8 118, i8 121, i8 124, i8 127, i8 -126, i8 -123, i8 -120, i8 -117, i8 -114>, ptr %6, align 16, !tbaa !5
  %7 = getelementptr inbounds [64 x i8], ptr %3, i64 0, i64 48
  store <16 x i8> <i8 -111, i8 -108, i8 -105, i8 -102, i8 -99, i8 -96, i8 -93, i8 -90, i8 -87, i8 -84, i8 -81, i8 -78, i8 -75, i8 -72, i8 -69, i8 -66>, ptr %7, align 16, !tbaa !5
  br label %8

8:                                                ; preds = %0, %16
  %9 = phi i32 [ %19, %16 ], [ 0, %0 ]
  %10 = phi i64 [ %17, %16 ], [ 0, %0 ]
  %11 = call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 577, i32 noundef 420) #6
  %12 = icmp slt i32 %11, 0
  br i1 %12, label %38, label %13

13:                                               ; preds = %8
  %14 = call i64 @write(i32 noundef %11, ptr noundef nonnull %3, i64 noundef 64) #6
  %15 = icmp slt i64 %14, 0
  br i1 %15, label %38, label %16

16:                                               ; preds = %13
  %17 = add i64 %14, %10
  %18 = call i32 @close(i32 noundef %11) #6
  %19 = add nuw nsw i32 %9, 1
  %20 = icmp eq i32 %19, 500
  br i1 %20, label %21, label %8, !llvm.loop !8

21:                                               ; preds = %16
  store volatile i64 %17, ptr @sink_u64, align 8, !tbaa !10
  %22 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %23 = load i64, ptr %2, align 8, !tbaa !12
  %24 = load i64, ptr %1, align 8, !tbaa !12
  %25 = sub nsw i64 %23, %24
  %26 = mul i64 %25, 1000000000
  %27 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %28 = load i64, ptr %27, align 8, !tbaa !14
  %29 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %30 = load i64, ptr %29, align 8, !tbaa !14
  %31 = icmp slt i64 %28, %30
  %32 = sub i64 %28, %30
  %33 = add i64 %32, %26
  %34 = add i64 %26, %28
  %35 = sub i64 %34, %30
  %36 = select i1 %31, i64 %35, i64 %33
  %37 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i64 noundef %36)
  br label %38

38:                                               ; preds = %13, %8, %21
  %39 = phi i32 [ 0, %21 ], [ 1, %8 ], [ 1, %13 ]
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %3) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %39
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree
declare noundef i32 @open(ptr nocapture noundef readonly, i32 noundef, ...) local_unnamed_addr #3

; Function Attrs: nofree
declare noundef i64 @write(i32 noundef, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #3

declare i32 @close(i32 noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }

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
!11 = !{!"long", !6, i64 0}
!12 = !{!13, !11, i64 0}
!13 = !{!"timespec", !11, i64 0, !11, i64 8}
!14 = !{!13, !11, i64 8}
