; ModuleID = 'data/microbenchmarks/memory_stride_write.c'
source_filename = "data/microbenchmarks/memory_stride_write.c"
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
  %4 = call dereferenceable_or_null(16000000) ptr @calloc(i64 1, i64 16000000)
  %5 = icmp eq ptr %4, null
  br i1 %5, label %99, label %6

6:                                                ; preds = %0, %8
  %7 = phi i64 [ %9, %8 ], [ 0, %0 ]
  br label %11

8:                                                ; preds = %11
  %9 = add nuw nsw i64 %7, 1
  %10 = icmp eq i64 %9, 32
  br i1 %10, label %55, label %6, !llvm.loop !5

11:                                               ; preds = %11, %6
  %12 = phi i64 [ 0, %6 ], [ %36, %11 ]
  %13 = getelementptr inbounds i32, ptr %4, i64 %12
  %14 = load i32, ptr %13, align 4, !tbaa !7
  %15 = add nuw nsw i64 %12, %7
  %16 = trunc i64 %15 to i32
  %17 = add i32 %14, %16
  store i32 %17, ptr %13, align 4, !tbaa !7
  %18 = or disjoint i64 %12, 16
  %19 = getelementptr inbounds i32, ptr %4, i64 %18
  %20 = load i32, ptr %19, align 4, !tbaa !7
  %21 = add nuw nsw i64 %18, %7
  %22 = trunc i64 %21 to i32
  %23 = add i32 %20, %22
  store i32 %23, ptr %19, align 4, !tbaa !7
  %24 = or disjoint i64 %12, 32
  %25 = getelementptr inbounds i32, ptr %4, i64 %24
  %26 = load i32, ptr %25, align 4, !tbaa !7
  %27 = add nuw nsw i64 %24, %7
  %28 = trunc i64 %27 to i32
  %29 = add i32 %26, %28
  store i32 %29, ptr %25, align 4, !tbaa !7
  %30 = or disjoint i64 %12, 48
  %31 = getelementptr inbounds i32, ptr %4, i64 %30
  %32 = load i32, ptr %31, align 4, !tbaa !7
  %33 = add nuw nsw i64 %30, %7
  %34 = trunc i64 %33 to i32
  %35 = add i32 %32, %34
  store i32 %35, ptr %31, align 4, !tbaa !7
  %36 = add nuw nsw i64 %12, 64
  %37 = icmp ult i64 %30, 3999984
  br i1 %37, label %11, label %8, !llvm.loop !11

38:                                               ; preds = %55
  store volatile i64 %96, ptr @sink_u64, align 8, !tbaa !12
  call void @free(ptr noundef nonnull %4) #6
  %39 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %40 = load i64, ptr %2, align 8, !tbaa !14
  %41 = load i64, ptr %1, align 8, !tbaa !14
  %42 = sub nsw i64 %40, %41
  %43 = mul i64 %42, 1000000000
  %44 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %45 = load i64, ptr %44, align 8, !tbaa !16
  %46 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %47 = load i64, ptr %46, align 8, !tbaa !16
  %48 = icmp slt i64 %45, %47
  %49 = sub i64 %45, %47
  %50 = add i64 %49, %43
  %51 = add i64 %43, %45
  %52 = sub i64 %51, %47
  %53 = select i1 %48, i64 %52, i64 %50
  %54 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %53)
  br label %99

55:                                               ; preds = %8, %55
  %56 = phi i64 [ %97, %55 ], [ 0, %8 ]
  %57 = phi i64 [ %96, %55 ], [ 0, %8 ]
  %58 = getelementptr inbounds i32, ptr %4, i64 %56
  %59 = load i32, ptr %58, align 4, !tbaa !7
  %60 = zext i32 %59 to i64
  %61 = add i64 %57, %60
  %62 = or disjoint i64 %56, 16
  %63 = getelementptr inbounds i32, ptr %4, i64 %62
  %64 = load i32, ptr %63, align 4, !tbaa !7
  %65 = zext i32 %64 to i64
  %66 = add i64 %61, %65
  %67 = or disjoint i64 %56, 32
  %68 = getelementptr inbounds i32, ptr %4, i64 %67
  %69 = load i32, ptr %68, align 4, !tbaa !7
  %70 = zext i32 %69 to i64
  %71 = add i64 %66, %70
  %72 = or disjoint i64 %56, 48
  %73 = getelementptr inbounds i32, ptr %4, i64 %72
  %74 = load i32, ptr %73, align 4, !tbaa !7
  %75 = zext i32 %74 to i64
  %76 = add i64 %71, %75
  %77 = or disjoint i64 %56, 64
  %78 = getelementptr inbounds i32, ptr %4, i64 %77
  %79 = load i32, ptr %78, align 4, !tbaa !7
  %80 = zext i32 %79 to i64
  %81 = add i64 %76, %80
  %82 = or disjoint i64 %56, 80
  %83 = getelementptr inbounds i32, ptr %4, i64 %82
  %84 = load i32, ptr %83, align 4, !tbaa !7
  %85 = zext i32 %84 to i64
  %86 = add i64 %81, %85
  %87 = or disjoint i64 %56, 96
  %88 = getelementptr inbounds i32, ptr %4, i64 %87
  %89 = load i32, ptr %88, align 4, !tbaa !7
  %90 = zext i32 %89 to i64
  %91 = add i64 %86, %90
  %92 = or disjoint i64 %56, 112
  %93 = getelementptr inbounds i32, ptr %4, i64 %92
  %94 = load i32, ptr %93, align 4, !tbaa !7
  %95 = zext i32 %94 to i64
  %96 = add i64 %91, %95
  %97 = add nuw nsw i64 %56, 128
  %98 = icmp ult i64 %92, 3999984
  br i1 %98, label %55, label %38, !llvm.loop !17

99:                                               ; preds = %0, %38
  %100 = phi i32 [ 0, %38 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %100
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @calloc(i64 noundef, i64 noundef) local_unnamed_addr #5

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
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
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = distinct !{!11, !6}
!12 = !{!13, !13, i64 0}
!13 = !{!"long", !9, i64 0}
!14 = !{!15, !13, i64 0}
!15 = !{!"timespec", !13, i64 0, !13, i64 8}
!16 = !{!15, !13, i64 8}
!17 = distinct !{!17, !6}
