; ModuleID = 'data/microbenchmarks/alloc_small_objects.c'
source_filename = "data/microbenchmarks/alloc_small_objects.c"
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
  %5 = phi i64 [ 0, %0 ], [ %31, %4 ]
  %6 = phi <2 x i64> [ <i64 0, i64 1>, %0 ], [ %32, %4 ]
  %7 = phi <2 x i64> [ zeroinitializer, %0 ], [ %30, %4 ]
  %8 = add nuw nsw <2 x i64> %6, <i64 1, i64 1>
  %9 = add nuw <2 x i64> %6, <i64 2, i64 2>
  %10 = add nuw <2 x i64> %6, <i64 3, i64 3>
  %11 = add nuw <2 x i64> %6, <i64 4, i64 4>
  %12 = add nuw <2 x i64> %6, <i64 5, i64 5>
  %13 = add nuw <2 x i64> %6, <i64 6, i64 6>
  %14 = add nuw <2 x i64> %6, <i64 7, i64 7>
  %15 = and <2 x i64> %6, <i64 4294967295, i64 4294967295>
  %16 = add <2 x i64> %7, %15
  %17 = and <2 x i64> %8, <i64 4294967295, i64 4294967295>
  %18 = add <2 x i64> %16, %17
  %19 = and <2 x i64> %9, <i64 4294967295, i64 4294967295>
  %20 = add <2 x i64> %18, %19
  %21 = and <2 x i64> %10, <i64 4294967295, i64 4294967295>
  %22 = add <2 x i64> %20, %21
  %23 = and <2 x i64> %11, <i64 4294967295, i64 4294967295>
  %24 = add <2 x i64> %22, %23
  %25 = and <2 x i64> %12, <i64 4294967295, i64 4294967295>
  %26 = add <2 x i64> %24, %25
  %27 = and <2 x i64> %13, <i64 4294967295, i64 4294967295>
  %28 = add <2 x i64> %26, %27
  %29 = and <2 x i64> %14, <i64 4294967295, i64 4294967295>
  %30 = add <2 x i64> %28, %29
  %31 = add nuw i64 %5, 2
  %32 = add <2 x i64> %6, <i64 2, i64 2>
  %33 = icmp eq i64 %31, 200000
  br i1 %33, label %34, label %4, !llvm.loop !5

34:                                               ; preds = %4
  %35 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %30)
  store volatile i64 %35, ptr @sink_u64, align 8, !tbaa !9
  %36 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #5
  %37 = load i64, ptr %2, align 8, !tbaa !13
  %38 = load i64, ptr %1, align 8, !tbaa !13
  %39 = sub nsw i64 %37, %38
  %40 = mul i64 %39, 1000000000
  %41 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %42 = load i64, ptr %41, align 8, !tbaa !15
  %43 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %44 = load i64, ptr %43, align 8, !tbaa !15
  %45 = icmp slt i64 %42, %44
  %46 = sub i64 %42, %44
  %47 = add i64 %46, %40
  %48 = add i64 %40, %42
  %49 = sub i64 %48, %44
  %50 = select i1 %45, i64 %49, i64 %47
  %51 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %50)
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
