; ModuleID = 'data/microbenchmarks/memory_random_write.c'
source_filename = "data/microbenchmarks/memory_random_write.c"
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
  %4 = call noalias dereferenceable_or_null(10000000) ptr @malloc(i64 noundef 10000000) #7
  %5 = icmp eq ptr %4, null
  br i1 %5, label %94, label %6

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
  %29 = icmp eq i64 %27, 2500000
  br i1 %29, label %30, label %6, !llvm.loop !9

30:                                               ; preds = %6, %33
  %31 = phi i32 [ %34, %33 ], [ 0, %6 ]
  %32 = phi i32 [ %44, %33 ], [ 123456789, %6 ]
  br label %36

33:                                               ; preds = %36
  %34 = add nuw nsw i32 %31, 1
  %35 = icmp eq i32 %34, 20
  br i1 %35, label %70, label %30, !llvm.loop !13

36:                                               ; preds = %30, %36
  %37 = phi i32 [ 0, %30 ], [ %51, %36 ]
  %38 = phi i32 [ %32, %30 ], [ %44, %36 ]
  %39 = shl i32 %38, 13
  %40 = xor i32 %39, %38
  %41 = lshr i32 %40, 17
  %42 = xor i32 %41, %40
  %43 = shl i32 %42, 5
  %44 = xor i32 %43, %42
  %45 = urem i32 %44, 2500000
  %46 = zext nneg i32 %45 to i64
  %47 = getelementptr inbounds i32, ptr %4, i64 %46
  %48 = load i32, ptr %47, align 4, !tbaa !5
  %49 = add nuw nsw i32 %37, %31
  %50 = add i32 %49, %48
  store i32 %50, ptr %47, align 4, !tbaa !5
  %51 = add nuw nsw i32 %37, 1
  %52 = icmp eq i32 %51, 2500000
  br i1 %52, label %33, label %36, !llvm.loop !14

53:                                               ; preds = %70
  store volatile i64 %91, ptr @sink_u64, align 8, !tbaa !15
  call void @free(ptr noundef nonnull %4) #6
  %54 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %55 = load i64, ptr %2, align 8, !tbaa !17
  %56 = load i64, ptr %1, align 8, !tbaa !17
  %57 = sub nsw i64 %55, %56
  %58 = mul i64 %57, 1000000000
  %59 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %60 = load i64, ptr %59, align 8, !tbaa !19
  %61 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %62 = load i64, ptr %61, align 8, !tbaa !19
  %63 = icmp slt i64 %60, %62
  %64 = sub i64 %60, %62
  %65 = add i64 %64, %58
  %66 = add i64 %58, %60
  %67 = sub i64 %66, %62
  %68 = select i1 %63, i64 %67, i64 %65
  %69 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %68)
  br label %94

70:                                               ; preds = %33, %70
  %71 = phi i64 [ %92, %70 ], [ 0, %33 ]
  %72 = phi i64 [ %91, %70 ], [ 0, %33 ]
  %73 = getelementptr inbounds i32, ptr %4, i64 %71
  %74 = load i32, ptr %73, align 4, !tbaa !5
  %75 = zext i32 %74 to i64
  %76 = add i64 %72, %75
  %77 = or disjoint i64 %71, 128
  %78 = getelementptr inbounds i32, ptr %4, i64 %77
  %79 = load i32, ptr %78, align 4, !tbaa !5
  %80 = zext i32 %79 to i64
  %81 = add i64 %76, %80
  %82 = or disjoint i64 %71, 256
  %83 = getelementptr inbounds i32, ptr %4, i64 %82
  %84 = load i32, ptr %83, align 4, !tbaa !5
  %85 = zext i32 %84 to i64
  %86 = add i64 %81, %85
  %87 = or disjoint i64 %71, 384
  %88 = getelementptr inbounds i32, ptr %4, i64 %87
  %89 = load i32, ptr %88, align 4, !tbaa !5
  %90 = zext i32 %89 to i64
  %91 = add i64 %86, %90
  %92 = add nuw nsw i64 %71, 512
  %93 = icmp ult i64 %87, 2499872
  br i1 %93, label %70, label %53, !llvm.loop !20

94:                                               ; preds = %0, %53
  %95 = phi i32 [ 0, %53 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %95
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
!13 = distinct !{!13, !10}
!14 = distinct !{!14, !10}
!15 = !{!16, !16, i64 0}
!16 = !{!"long", !7, i64 0}
!17 = !{!18, !16, i64 0}
!18 = !{!"timespec", !16, i64 0, !16, i64 8}
!19 = !{!18, !16, i64 8}
!20 = distinct !{!20, !10}
