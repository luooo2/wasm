; ModuleID = 'data/microbenchmarks/memory_copy_loop.c'
source_filename = "data/microbenchmarks/memory_copy_loop.c"
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
  %4 = call noalias dereferenceable_or_null(8388608) ptr @malloc(i64 noundef 8388608) #7
  %5 = icmp eq ptr %4, null
  br i1 %5, label %83, label %6

6:                                                ; preds = %0, %6
  %7 = phi i64 [ %19, %6 ], [ 0, %0 ]
  %8 = phi <16 x i8> [ %20, %6 ], [ <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15>, %0 ]
  %9 = getelementptr inbounds i8, ptr %4, i64 %7
  store <16 x i8> %8, ptr %9, align 1, !tbaa !5
  %10 = or disjoint i64 %7, 16
  %11 = add <16 x i8> %8, <i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16>
  %12 = getelementptr inbounds i8, ptr %4, i64 %10
  store <16 x i8> %11, ptr %12, align 1, !tbaa !5
  %13 = or disjoint i64 %7, 32
  %14 = add <16 x i8> %8, <i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32>
  %15 = getelementptr inbounds i8, ptr %4, i64 %13
  store <16 x i8> %14, ptr %15, align 1, !tbaa !5
  %16 = or disjoint i64 %7, 48
  %17 = add <16 x i8> %8, <i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48>
  %18 = getelementptr inbounds i8, ptr %4, i64 %16
  store <16 x i8> %17, ptr %18, align 1, !tbaa !5
  %19 = add nuw nsw i64 %7, 64
  %20 = add <16 x i8> %8, <i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64>
  %21 = icmp eq i64 %19, 8388608
  br i1 %21, label %39, label %6, !llvm.loop !8

22:                                               ; preds = %39
  store volatile i64 %80, ptr @sink_u64, align 8, !tbaa !12
  call void @free(ptr noundef nonnull %4) #6
  %23 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %24 = load i64, ptr %2, align 8, !tbaa !14
  %25 = load i64, ptr %1, align 8, !tbaa !14
  %26 = sub nsw i64 %24, %25
  %27 = mul i64 %26, 1000000000
  %28 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %29 = load i64, ptr %28, align 8, !tbaa !16
  %30 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %31 = load i64, ptr %30, align 8, !tbaa !16
  %32 = icmp slt i64 %29, %31
  %33 = sub i64 %29, %31
  %34 = add i64 %33, %27
  %35 = add i64 %27, %29
  %36 = sub i64 %35, %31
  %37 = select i1 %32, i64 %36, i64 %34
  %38 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %37)
  br label %83

39:                                               ; preds = %6, %39
  %40 = phi i64 [ %81, %39 ], [ 0, %6 ]
  %41 = phi i64 [ %80, %39 ], [ 0, %6 ]
  %42 = getelementptr inbounds i8, ptr %4, i64 %40
  %43 = load i8, ptr %42, align 1, !tbaa !5
  %44 = zext i8 %43 to i64
  %45 = add i64 %41, %44
  %46 = or disjoint i64 %40, 4096
  %47 = getelementptr inbounds i8, ptr %4, i64 %46
  %48 = load i8, ptr %47, align 1, !tbaa !5
  %49 = zext i8 %48 to i64
  %50 = add i64 %45, %49
  %51 = or disjoint i64 %40, 8192
  %52 = getelementptr inbounds i8, ptr %4, i64 %51
  %53 = load i8, ptr %52, align 1, !tbaa !5
  %54 = zext i8 %53 to i64
  %55 = add i64 %50, %54
  %56 = or disjoint i64 %40, 12288
  %57 = getelementptr inbounds i8, ptr %4, i64 %56
  %58 = load i8, ptr %57, align 1, !tbaa !5
  %59 = zext i8 %58 to i64
  %60 = add i64 %55, %59
  %61 = or disjoint i64 %40, 16384
  %62 = getelementptr inbounds i8, ptr %4, i64 %61
  %63 = load i8, ptr %62, align 1, !tbaa !5
  %64 = zext i8 %63 to i64
  %65 = add i64 %60, %64
  %66 = or disjoint i64 %40, 20480
  %67 = getelementptr inbounds i8, ptr %4, i64 %66
  %68 = load i8, ptr %67, align 1, !tbaa !5
  %69 = zext i8 %68 to i64
  %70 = add i64 %65, %69
  %71 = or disjoint i64 %40, 24576
  %72 = getelementptr inbounds i8, ptr %4, i64 %71
  %73 = load i8, ptr %72, align 1, !tbaa !5
  %74 = zext i8 %73 to i64
  %75 = add i64 %70, %74
  %76 = or disjoint i64 %40, 28672
  %77 = getelementptr inbounds i8, ptr %4, i64 %76
  %78 = load i8, ptr %77, align 1, !tbaa !5
  %79 = zext i8 %78 to i64
  %80 = add i64 %75, %79
  %81 = add nuw nsw i64 %40, 32768
  %82 = icmp ult i64 %76, 8384512
  br i1 %82, label %39, label %22, !llvm.loop !17

83:                                               ; preds = %0, %22
  %84 = phi i32 [ 0, %22 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %84
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
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9, !10, !11}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = !{!"llvm.loop.unroll.runtime.disable"}
!12 = !{!13, !13, i64 0}
!13 = !{!"long", !6, i64 0}
!14 = !{!15, !13, i64 0}
!15 = !{!"timespec", !13, i64 0, !13, i64 8}
!16 = !{!15, !13, i64 8}
!17 = distinct !{!17, !9}
