; ModuleID = 'data/microbenchmarks/memory_seq_write.c'
source_filename = "data/microbenchmarks/memory_seq_write.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #6
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #6
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #6
  %4 = call noalias dereferenceable_or_null(20000000) ptr @malloc(i64 noundef 20000000) #7
  %5 = icmp eq ptr %4, null
  br i1 %5, label %101, label %6

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
  %29 = icmp eq i64 %27, 5000000
  br i1 %29, label %30, label %6, !llvm.loop !9

30:                                               ; preds = %6, %51
  %31 = phi i64 [ %52, %51 ], [ 0, %6 ]
  %32 = insertelement <4 x i64> poison, i64 %31, i64 0
  %33 = shufflevector <4 x i64> %32, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %34

34:                                               ; preds = %34, %30
  %35 = phi i64 [ 0, %30 ], [ %48, %34 ]
  %36 = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %30 ], [ %49, %34 ]
  %37 = add <4 x i64> %36, <i64 4, i64 4, i64 4, i64 4>
  %38 = getelementptr inbounds i32, ptr %4, i64 %35
  %39 = getelementptr inbounds i32, ptr %38, i64 4
  %40 = load <4 x i32>, ptr %38, align 4, !tbaa !5
  %41 = load <4 x i32>, ptr %39, align 4, !tbaa !5
  %42 = add nuw nsw <4 x i64> %36, %33
  %43 = add nuw nsw <4 x i64> %37, %33
  %44 = trunc <4 x i64> %42 to <4 x i32>
  %45 = trunc <4 x i64> %43 to <4 x i32>
  %46 = add <4 x i32> %40, %44
  %47 = add <4 x i32> %41, %45
  store <4 x i32> %46, ptr %38, align 4, !tbaa !5
  store <4 x i32> %47, ptr %39, align 4, !tbaa !5
  %48 = add nuw i64 %35, 8
  %49 = add <4 x i64> %36, <i64 8, i64 8, i64 8, i64 8>
  %50 = icmp eq i64 %48, 5000000
  br i1 %50, label %51, label %34, !llvm.loop !13

51:                                               ; preds = %34
  %52 = add nuw nsw i64 %31, 1
  %53 = icmp eq i64 %52, 20
  br i1 %53, label %54, label %30, !llvm.loop !14

54:                                               ; preds = %51
  %55 = getelementptr i32, ptr %4, i64 64
  %56 = getelementptr i32, ptr %4, i64 128
  %57 = getelementptr i32, ptr %4, i64 192
  %58 = getelementptr i32, ptr %4, i64 256
  br label %76

59:                                               ; preds = %76
  store volatile i64 %98, ptr @sink_u64, align 8, !tbaa !15
  call void @free(ptr noundef nonnull %4) #6
  %60 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %61 = load i64, ptr %2, align 8, !tbaa !17
  %62 = load i64, ptr %1, align 8, !tbaa !17
  %63 = sub nsw i64 %61, %62
  %64 = mul i64 %63, 1000000000
  %65 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %66 = load i64, ptr %65, align 8, !tbaa !19
  %67 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %68 = load i64, ptr %67, align 8, !tbaa !19
  %69 = icmp slt i64 %66, %68
  %70 = sub i64 %66, %68
  %71 = add i64 %70, %64
  %72 = add i64 %64, %66
  %73 = sub i64 %72, %68
  %74 = select i1 %69, i64 %73, i64 %71
  %75 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %74)
  br label %101

76:                                               ; preds = %76, %54
  %77 = phi i64 [ 0, %54 ], [ %99, %76 ]
  %78 = phi i64 [ 0, %54 ], [ %98, %76 ]
  %79 = getelementptr inbounds i32, ptr %4, i64 %77
  %80 = load i32, ptr %79, align 4, !tbaa !5
  %81 = zext i32 %80 to i64
  %82 = add i64 %78, %81
  %83 = getelementptr i32, ptr %55, i64 %77
  %84 = load i32, ptr %83, align 4, !tbaa !5
  %85 = zext i32 %84 to i64
  %86 = add i64 %82, %85
  %87 = getelementptr i32, ptr %56, i64 %77
  %88 = load i32, ptr %87, align 4, !tbaa !5
  %89 = zext i32 %88 to i64
  %90 = add i64 %86, %89
  %91 = getelementptr i32, ptr %57, i64 %77
  %92 = load i32, ptr %91, align 4, !tbaa !5
  %93 = zext i32 %92 to i64
  %94 = add i64 %90, %93
  %95 = getelementptr i32, ptr %58, i64 %77
  %96 = load i32, ptr %95, align 4, !tbaa !5
  %97 = zext i32 %96 to i64
  %98 = add i64 %94, %97
  %99 = add nuw nsw i64 %77, 320
  %100 = icmp ult i64 %77, 4999680
  br i1 %100, label %76, label %59, !llvm.loop !20

101:                                              ; preds = %0, %59
  %102 = phi i32 [ 0, %59 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %102
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

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }
attributes #7 = { nounwind allocsize(0) }

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
!14 = distinct !{!14, !10}
!15 = !{!16, !16, i64 0}
!16 = !{!"long", !7, i64 0}
!17 = !{!18, !16, i64 0}
!18 = !{!"timespec", !16, i64 0, !16, i64 8}
!19 = !{!18, !16, i64 8}
!20 = distinct !{!20, !10}
