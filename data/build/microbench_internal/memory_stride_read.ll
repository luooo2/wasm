; ModuleID = 'data/microbenchmarks/memory_stride_read.c'
source_filename = "data/microbenchmarks/memory_stride_read.c"
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
  br i1 %5, label %76, label %6

6:                                                ; preds = %0, %6
  %7 = phi i64 [ %15, %6 ], [ 0, %0 ]
  %8 = phi <4 x i32> [ %16, %6 ], [ <i32 0, i32 1, i32 2, i32 3>, %0 ]
  %9 = getelementptr inbounds i32, ptr %4, i64 %7
  %10 = mul <4 x i32> %8, <i32 3, i32 3, i32 3, i32 3>
  %11 = mul <4 x i32> %8, <i32 3, i32 3, i32 3, i32 3>
  %12 = add <4 x i32> %10, <i32 7, i32 7, i32 7, i32 7>
  %13 = add <4 x i32> %11, <i32 19, i32 19, i32 19, i32 19>
  %14 = getelementptr inbounds i32, ptr %9, i64 4
  store <4 x i32> %12, ptr %9, align 4, !tbaa !5
  store <4 x i32> %13, ptr %14, align 4, !tbaa !5
  %15 = add nuw i64 %7, 8
  %16 = add <4 x i32> %8, <i32 8, i32 8, i32 8, i32 8>
  %17 = icmp eq i64 %15, 5000000
  br i1 %17, label %18, label %6, !llvm.loop !9

18:                                               ; preds = %6
  %19 = getelementptr i32, ptr %4, i64 16
  %20 = getelementptr i32, ptr %4, i64 32
  %21 = getelementptr i32, ptr %4, i64 48
  %22 = getelementptr i32, ptr %4, i64 64
  br label %23

23:                                               ; preds = %18, %43
  %24 = phi i32 [ %44, %43 ], [ 0, %18 ]
  %25 = phi i64 [ %73, %43 ], [ 0, %18 ]
  br label %46

26:                                               ; preds = %43
  store volatile i64 %73, ptr @sink_u64, align 8, !tbaa !13
  call void @free(ptr noundef nonnull %4) #6
  %27 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %28 = load i64, ptr %2, align 8, !tbaa !15
  %29 = load i64, ptr %1, align 8, !tbaa !15
  %30 = sub nsw i64 %28, %29
  %31 = mul i64 %30, 1000000000
  %32 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %33 = load i64, ptr %32, align 8, !tbaa !17
  %34 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %35 = load i64, ptr %34, align 8, !tbaa !17
  %36 = icmp slt i64 %33, %35
  %37 = sub i64 %33, %35
  %38 = add i64 %37, %31
  %39 = add i64 %31, %33
  %40 = sub i64 %39, %35
  %41 = select i1 %36, i64 %40, i64 %38
  %42 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %41)
  br label %76

43:                                               ; preds = %46
  %44 = add nuw nsw i32 %24, 1
  %45 = icmp eq i32 %44, 32
  br i1 %45, label %26, label %23, !llvm.loop !18

46:                                               ; preds = %46, %23
  %47 = phi i64 [ 0, %23 ], [ %74, %46 ]
  %48 = phi i64 [ %25, %23 ], [ %73, %46 ]
  %49 = getelementptr inbounds i32, ptr %4, i64 %47
  %50 = load i32, ptr %49, align 4, !tbaa !5
  %51 = xor i32 %50, %24
  %52 = zext i32 %51 to i64
  %53 = add i64 %48, %52
  %54 = getelementptr i32, ptr %19, i64 %47
  %55 = load i32, ptr %54, align 4, !tbaa !5
  %56 = xor i32 %55, %24
  %57 = zext i32 %56 to i64
  %58 = add i64 %53, %57
  %59 = getelementptr i32, ptr %20, i64 %47
  %60 = load i32, ptr %59, align 4, !tbaa !5
  %61 = xor i32 %60, %24
  %62 = zext i32 %61 to i64
  %63 = add i64 %58, %62
  %64 = getelementptr i32, ptr %21, i64 %47
  %65 = load i32, ptr %64, align 4, !tbaa !5
  %66 = xor i32 %65, %24
  %67 = zext i32 %66 to i64
  %68 = add i64 %63, %67
  %69 = getelementptr i32, ptr %22, i64 %47
  %70 = load i32, ptr %69, align 4, !tbaa !5
  %71 = xor i32 %70, %24
  %72 = zext i32 %71 to i64
  %73 = add i64 %68, %72
  %74 = add nuw nsw i64 %47, 80
  %75 = icmp ult i64 %47, 4999920
  br i1 %75, label %46, label %43, !llvm.loop !19

76:                                               ; preds = %0, %26
  %77 = phi i32 [ 0, %26 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %77
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
