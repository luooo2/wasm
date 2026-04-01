; ModuleID = 'data/microbenchmarks/memory_random_read.c'
source_filename = "data/microbenchmarks/memory_random_read.c"
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
  %4 = call noalias dereferenceable_or_null(12000000) ptr @malloc(i64 noundef 12000000) #7
  %5 = icmp eq ptr %4, null
  br i1 %5, label %85, label %6

6:                                                ; preds = %0, %6
  %7 = phi i64 [ %28, %6 ], [ 0, %0 ]
  %8 = phi <4 x i32> [ %29, %6 ], [ <i32 0, i32 1, i32 2, i32 3>, %0 ]
  %9 = add <4 x i32> %8, <i32 4, i32 4, i32 4, i32 4>
  %10 = xor <4 x i32> %8, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %11 = xor <4 x i32> %9, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %12 = getelementptr inbounds i32, ptr %4, i64 %7
  %13 = getelementptr inbounds i32, ptr %12, i64 4
  store <4 x i32> %10, ptr %12, align 4, !tbaa !5
  store <4 x i32> %11, ptr %13, align 4, !tbaa !5
  %14 = add <4 x i32> %8, <i32 8, i32 8, i32 8, i32 8>
  %15 = add <4 x i32> %8, <i32 12, i32 12, i32 12, i32 12>
  %16 = xor <4 x i32> %14, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %17 = xor <4 x i32> %15, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %18 = getelementptr i32, ptr %4, i64 %7
  %19 = getelementptr i32, ptr %18, i64 8
  %20 = getelementptr i32, ptr %18, i64 12
  store <4 x i32> %16, ptr %19, align 4, !tbaa !5
  store <4 x i32> %17, ptr %20, align 4, !tbaa !5
  %21 = add <4 x i32> %8, <i32 16, i32 16, i32 16, i32 16>
  %22 = add <4 x i32> %8, <i32 20, i32 20, i32 20, i32 20>
  %23 = xor <4 x i32> %21, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %24 = xor <4 x i32> %22, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %25 = getelementptr i32, ptr %4, i64 %7
  %26 = getelementptr i32, ptr %25, i64 16
  %27 = getelementptr i32, ptr %25, i64 20
  store <4 x i32> %23, ptr %26, align 4, !tbaa !5
  store <4 x i32> %24, ptr %27, align 4, !tbaa !5
  %28 = add nuw nsw i64 %7, 24
  %29 = add <4 x i32> %8, <i32 24, i32 24, i32 24, i32 24>
  %30 = icmp eq i64 %28, 3000000
  br i1 %30, label %31, label %6, !llvm.loop !9

31:                                               ; preds = %6, %52
  %32 = phi i32 [ %53, %52 ], [ 0, %6 ]
  %33 = phi i64 [ %82, %52 ], [ 0, %6 ]
  %34 = phi i32 [ %76, %52 ], [ -1831433054, %6 ]
  br label %55

35:                                               ; preds = %52
  store volatile i64 %82, ptr @sink_u64, align 8, !tbaa !13
  call void @free(ptr noundef nonnull %4) #6
  %36 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %37 = load i64, ptr %2, align 8, !tbaa !15
  %38 = load i64, ptr %1, align 8, !tbaa !15
  %39 = sub nsw i64 %37, %38
  %40 = mul i64 %39, 1000000000
  %41 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %42 = load i64, ptr %41, align 8, !tbaa !17
  %43 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %44 = load i64, ptr %43, align 8, !tbaa !17
  %45 = icmp slt i64 %42, %44
  %46 = sub i64 %42, %44
  %47 = add i64 %46, %40
  %48 = add i64 %40, %42
  %49 = sub i64 %48, %44
  %50 = select i1 %45, i64 %49, i64 %47
  %51 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %50)
  br label %85

52:                                               ; preds = %55
  %53 = add nuw nsw i32 %32, 1
  %54 = icmp eq i32 %53, 24
  br i1 %54, label %35, label %31, !llvm.loop !18

55:                                               ; preds = %55, %31
  %56 = phi i32 [ 0, %31 ], [ %83, %55 ]
  %57 = phi i64 [ %33, %31 ], [ %82, %55 ]
  %58 = phi i32 [ %34, %31 ], [ %76, %55 ]
  %59 = shl i32 %58, 13
  %60 = xor i32 %59, %58
  %61 = lshr i32 %60, 17
  %62 = xor i32 %61, %60
  %63 = shl i32 %62, 5
  %64 = xor i32 %63, %62
  %65 = urem i32 %64, 3000000
  %66 = zext nneg i32 %65 to i64
  %67 = getelementptr inbounds i32, ptr %4, i64 %66
  %68 = load i32, ptr %67, align 4, !tbaa !5
  %69 = zext i32 %68 to i64
  %70 = add i64 %57, %69
  %71 = shl i32 %64, 13
  %72 = xor i32 %71, %64
  %73 = lshr i32 %72, 17
  %74 = xor i32 %73, %72
  %75 = shl i32 %74, 5
  %76 = xor i32 %75, %74
  %77 = urem i32 %76, 3000000
  %78 = zext nneg i32 %77 to i64
  %79 = getelementptr inbounds i32, ptr %4, i64 %78
  %80 = load i32, ptr %79, align 4, !tbaa !5
  %81 = zext i32 %80 to i64
  %82 = add i64 %70, %81
  %83 = add nuw nsw i32 %56, 2
  %84 = icmp eq i32 %83, 3000000
  br i1 %84, label %52, label %55, !llvm.loop !19

85:                                               ; preds = %0, %35
  %86 = phi i32 [ 0, %35 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %86
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
!13 = !{!14, !14, i64 0}
!14 = !{!"long", !7, i64 0}
!15 = !{!16, !14, i64 0}
!16 = !{!"timespec", !14, i64 0, !14, i64 8}
!17 = !{!16, !14, i64 8}
!18 = distinct !{!18, !10}
!19 = distinct !{!19, !10}
