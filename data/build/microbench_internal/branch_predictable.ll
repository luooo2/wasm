; ModuleID = 'data/microbenchmarks/branch_predictable.c'
source_filename = "data/microbenchmarks/branch_predictable.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #5
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #5
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #5
  br label %4

4:                                                ; preds = %4, %0
  %5 = phi i64 [ 0, %0 ], [ %18, %4 ]
  %6 = phi <2 x i64> [ <i64 0, i64 1>, %0 ], [ %19, %4 ]
  %7 = phi <2 x i64> [ zeroinitializer, %0 ], [ %16, %4 ]
  %8 = phi <2 x i64> [ zeroinitializer, %0 ], [ %17, %4 ]
  %9 = add <2 x i64> %6, <i64 2, i64 2>
  %10 = and <2 x i64> %6, <i64 1, i64 1>
  %11 = and <2 x i64> %6, <i64 1, i64 1>
  %12 = icmp eq <2 x i64> %10, zeroinitializer
  %13 = icmp eq <2 x i64> %11, zeroinitializer
  %14 = select <2 x i1> %12, <2 x i64> %6, <2 x i64> <i64 3, i64 3>
  %15 = select <2 x i1> %13, <2 x i64> %9, <2 x i64> <i64 3, i64 3>
  %16 = add <2 x i64> %14, %7
  %17 = add <2 x i64> %15, %8
  %18 = add nuw i64 %5, 4
  %19 = add <2 x i64> %6, <i64 4, i64 4>
  %20 = icmp eq i64 %18, 60000000
  br i1 %20, label %21, label %4, !llvm.loop !5

21:                                               ; preds = %4
  %22 = add <2 x i64> %17, %16
  %23 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %22)
  store volatile i64 %23, ptr @sink_u64, align 8, !tbaa !9
  %24 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #5
  %25 = load i64, ptr %2, align 8, !tbaa !13
  %26 = load i64, ptr %1, align 8, !tbaa !13
  %27 = sub nsw i64 %25, %26
  %28 = mul i64 %27, 1000000000
  %29 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %30 = load i64, ptr %29, align 8, !tbaa !15
  %31 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %32 = load i64, ptr %31, align 8, !tbaa !15
  %33 = icmp slt i64 %30, %32
  %34 = sub i64 %30, %32
  %35 = add i64 %34, %28
  %36 = add i64 %28, %30
  %37 = sub i64 %36, %32
  %38 = select i1 %33, i64 %37, i64 %35
  %39 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %38)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #5
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #5
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>) #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind }

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
!13 = !{!14, !10, i64 0}
!14 = !{!"timespec", !10, i64 0, !10, i64 8}
!15 = !{!14, !10, i64 8}
