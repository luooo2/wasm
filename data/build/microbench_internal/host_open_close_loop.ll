; ModuleID = 'data/microbenchmarks/host_open_close_loop.c'
source_filename = "data/microbenchmarks/host_open_close_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [24 x i8] c"bench_tmp_openclose.dat\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@.str.2 = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #6
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #6
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #6
  %4 = call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 577, i32 noundef 420) #6
  %5 = icmp slt i32 %4, 0
  br i1 %5, label %38, label %6

6:                                                ; preds = %0
  %7 = call i64 @write(i32 noundef %4, ptr noundef nonnull @.str.1, i64 noundef 1) #6
  %8 = call i32 @close(i32 noundef %4) #6
  br label %9

9:                                                ; preds = %6, %14
  %10 = phi i32 [ 0, %6 ], [ %19, %14 ]
  %11 = phi i64 [ 0, %6 ], [ %17, %14 ]
  %12 = call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 0) #6
  %13 = icmp sgt i32 %12, -1
  br i1 %13, label %14, label %38

14:                                               ; preds = %9
  %15 = and i32 %12, 255
  %16 = zext nneg i32 %15 to i64
  %17 = add i64 %11, %16
  %18 = call i32 @close(i32 noundef %12) #6
  %19 = add nuw nsw i32 %10, 1
  %20 = icmp eq i32 %19, 800
  br i1 %20, label %21, label %9, !llvm.loop !5

21:                                               ; preds = %14
  store volatile i64 %17, ptr @sink_u64, align 8, !tbaa !7
  %22 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %23 = load i64, ptr %2, align 8, !tbaa !11
  %24 = load i64, ptr %1, align 8, !tbaa !11
  %25 = sub nsw i64 %23, %24
  %26 = mul i64 %25, 1000000000
  %27 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %28 = load i64, ptr %27, align 8, !tbaa !13
  %29 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %30 = load i64, ptr %29, align 8, !tbaa !13
  %31 = icmp slt i64 %28, %30
  %32 = sub i64 %28, %30
  %33 = add i64 %32, %26
  %34 = add i64 %26, %28
  %35 = sub i64 %34, %30
  %36 = select i1 %31, i64 %35, i64 %33
  %37 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i64 noundef %36)
  br label %38

38:                                               ; preds = %9, %21, %0
  %39 = phi i32 [ 1, %0 ], [ 0, %21 ], [ 1, %9 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %39
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: nofree
declare noundef i32 @open(ptr nocapture noundef readonly, i32 noundef, ...) local_unnamed_addr #3

; Function Attrs: nofree
declare noundef i64 @write(i32 noundef, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #3

declare i32 @close(i32 noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

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
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!8, !8, i64 0}
!8 = !{!"long", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!12, !8, i64 0}
!12 = !{!"timespec", !8, i64 0, !8, i64 8}
!13 = !{!12, !8, i64 8}
