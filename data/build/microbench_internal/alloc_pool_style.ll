; ModuleID = 'data/microbenchmarks/alloc_pool_style.c'
source_filename = "data/microbenchmarks/alloc_pool_style.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #7
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #7
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #7
  %4 = call noalias dereferenceable_or_null(1048576) ptr @malloc(i64 noundef 1048576) #8
  %5 = icmp eq ptr %4, null
  br i1 %5, label %70, label %6

6:                                                ; preds = %0, %6
  %7 = phi i64 [ %27, %6 ], [ 0, %0 ]
  %8 = phi <4 x i32> [ %28, %6 ], [ <i32 0, i32 1, i32 2, i32 3>, %0 ]
  %9 = add <4 x i32> %8, <i32 4, i32 4, i32 4, i32 4>
  %10 = getelementptr inbounds i32, ptr %4, i64 %7
  %11 = getelementptr inbounds i32, ptr %10, i64 4
  store <4 x i32> %8, ptr %10, align 4, !tbaa !5
  store <4 x i32> %9, ptr %11, align 4, !tbaa !5
  %12 = or disjoint i64 %7, 8
  %13 = add <4 x i32> %8, <i32 8, i32 8, i32 8, i32 8>
  %14 = add <4 x i32> %8, <i32 12, i32 12, i32 12, i32 12>
  %15 = getelementptr inbounds i32, ptr %4, i64 %12
  %16 = getelementptr inbounds i32, ptr %15, i64 4
  store <4 x i32> %13, ptr %15, align 4, !tbaa !5
  store <4 x i32> %14, ptr %16, align 4, !tbaa !5
  %17 = or disjoint i64 %7, 16
  %18 = add <4 x i32> %8, <i32 16, i32 16, i32 16, i32 16>
  %19 = add <4 x i32> %8, <i32 20, i32 20, i32 20, i32 20>
  %20 = getelementptr inbounds i32, ptr %4, i64 %17
  %21 = getelementptr inbounds i32, ptr %20, i64 4
  store <4 x i32> %18, ptr %20, align 4, !tbaa !5
  store <4 x i32> %19, ptr %21, align 4, !tbaa !5
  %22 = or disjoint i64 %7, 24
  %23 = add <4 x i32> %8, <i32 24, i32 24, i32 24, i32 24>
  %24 = add <4 x i32> %8, <i32 28, i32 28, i32 28, i32 28>
  %25 = getelementptr inbounds i32, ptr %4, i64 %22
  %26 = getelementptr inbounds i32, ptr %25, i64 4
  store <4 x i32> %23, ptr %25, align 4, !tbaa !5
  store <4 x i32> %24, ptr %26, align 4, !tbaa !5
  %27 = add nuw nsw i64 %7, 32
  %28 = add <4 x i32> %8, <i32 32, i32 32, i32 32, i32 32>
  %29 = icmp eq i64 %27, 262144
  br i1 %29, label %30, label %6, !llvm.loop !9

30:                                               ; preds = %6, %30
  %31 = phi i64 [ %48, %30 ], [ 0, %6 ]
  %32 = phi <2 x i64> [ %46, %30 ], [ zeroinitializer, %6 ]
  %33 = phi <2 x i64> [ %47, %30 ], [ zeroinitializer, %6 ]
  %34 = phi <2 x i32> [ %49, %30 ], [ <i32 0, i32 1>, %6 ]
  %35 = add <2 x i32> %34, <i32 2, i32 2>
  %36 = getelementptr inbounds i32, ptr %4, i64 %31
  %37 = getelementptr inbounds i32, ptr %36, i64 2
  %38 = load <2 x i32>, ptr %36, align 4, !tbaa !5
  %39 = load <2 x i32>, ptr %37, align 4, !tbaa !5
  %40 = and <2 x i32> %34, <i32 31, i32 31>
  %41 = and <2 x i32> %35, <i32 31, i32 31>
  %42 = add <2 x i32> %38, %40
  %43 = add <2 x i32> %39, %41
  store <2 x i32> %42, ptr %36, align 4, !tbaa !5
  store <2 x i32> %43, ptr %37, align 4, !tbaa !5
  %44 = zext <2 x i32> %42 to <2 x i64>
  %45 = zext <2 x i32> %43 to <2 x i64>
  %46 = add <2 x i64> %32, %44
  %47 = add <2 x i64> %33, %45
  %48 = add nuw i64 %31, 4
  %49 = add <2 x i32> %34, <i32 4, i32 4>
  %50 = icmp eq i64 %48, 250000
  br i1 %50, label %51, label %30, !llvm.loop !13

51:                                               ; preds = %30
  %52 = add <2 x i64> %47, %46
  %53 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %52)
  call void @free(ptr noundef nonnull %4) #7
  store volatile i64 %53, ptr @sink_u64, align 8, !tbaa !14
  %54 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #7
  %55 = load i64, ptr %2, align 8, !tbaa !16
  %56 = load i64, ptr %1, align 8, !tbaa !16
  %57 = sub nsw i64 %55, %56
  %58 = mul i64 %57, 1000000000
  %59 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %60 = load i64, ptr %59, align 8, !tbaa !18
  %61 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %62 = load i64, ptr %61, align 8, !tbaa !18
  %63 = icmp slt i64 %60, %62
  %64 = sub i64 %60, %62
  %65 = add i64 %64, %58
  %66 = add i64 %58, %60
  %67 = sub i64 %66, %62
  %68 = select i1 %63, i64 %67, i64 %65
  %69 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %68)
  br label %70

70:                                               ; preds = %0, %51
  %71 = phi i32 [ 0, %51 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #7
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #7
  ret i32 %71
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>) #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nounwind }
attributes #8 = { nounwind allocsize(0) }

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
!9 = distinct !{!9, !10, !11, !12}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.isvectorized", i32 1}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
!13 = distinct !{!13, !10, !11, !12}
!14 = !{!15, !15, i64 0}
!15 = !{!"long", !7, i64 0}
!16 = !{!17, !15, i64 0}
!17 = !{!"timespec", !15, i64 0, !15, i64 8}
!18 = !{!17, !15, i64 8}
