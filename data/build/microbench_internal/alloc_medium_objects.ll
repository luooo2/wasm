; ModuleID = 'data/microbenchmarks/alloc_medium_objects.c'
source_filename = "data/microbenchmarks/alloc_medium_objects.c"
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
  br label %4

4:                                                ; preds = %0, %9
  %5 = phi i64 [ 0, %0 ], [ %65, %9 ]
  %6 = phi i64 [ 0, %0 ], [ %64, %9 ]
  %7 = call noalias dereferenceable_or_null(256) ptr @malloc(i64 noundef 256) #7
  %8 = icmp eq ptr %7, null
  br i1 %8, label %84, label %9

9:                                                ; preds = %4
  %10 = insertelement <4 x i64> poison, i64 %5, i64 0
  %11 = shufflevector <4 x i64> %10, <4 x i64> poison, <4 x i32> zeroinitializer
  %12 = trunc <4 x i64> %11 to <4 x i32>
  %13 = add <4 x i32> %12, <i32 0, i32 1, i32 2, i32 3>
  store <4 x i32> %13, ptr %7, align 4, !tbaa !5
  %14 = getelementptr inbounds i32, ptr %7, i64 4
  %15 = trunc <4 x i64> %11 to <4 x i32>
  %16 = add <4 x i32> %15, <i32 4, i32 5, i32 6, i32 7>
  store <4 x i32> %16, ptr %14, align 4, !tbaa !5
  %17 = getelementptr inbounds i32, ptr %7, i64 8
  %18 = trunc <4 x i64> %11 to <4 x i32>
  %19 = add <4 x i32> %18, <i32 8, i32 9, i32 10, i32 11>
  store <4 x i32> %19, ptr %17, align 4, !tbaa !5
  %20 = getelementptr inbounds i32, ptr %7, i64 12
  %21 = trunc <4 x i64> %11 to <4 x i32>
  %22 = add <4 x i32> %21, <i32 12, i32 13, i32 14, i32 15>
  store <4 x i32> %22, ptr %20, align 4, !tbaa !5
  %23 = getelementptr inbounds i32, ptr %7, i64 16
  %24 = trunc <4 x i64> %11 to <4 x i32>
  %25 = add <4 x i32> %24, <i32 16, i32 17, i32 18, i32 19>
  store <4 x i32> %25, ptr %23, align 4, !tbaa !5
  %26 = getelementptr inbounds i32, ptr %7, i64 20
  %27 = trunc <4 x i64> %11 to <4 x i32>
  %28 = add <4 x i32> %27, <i32 20, i32 21, i32 22, i32 23>
  store <4 x i32> %28, ptr %26, align 4, !tbaa !5
  %29 = getelementptr inbounds i32, ptr %7, i64 24
  %30 = trunc <4 x i64> %11 to <4 x i32>
  %31 = add <4 x i32> %30, <i32 24, i32 25, i32 26, i32 27>
  store <4 x i32> %31, ptr %29, align 4, !tbaa !5
  %32 = getelementptr inbounds i32, ptr %7, i64 28
  %33 = trunc <4 x i64> %11 to <4 x i32>
  %34 = add <4 x i32> %33, <i32 28, i32 29, i32 30, i32 31>
  store <4 x i32> %34, ptr %32, align 4, !tbaa !5
  %35 = getelementptr inbounds i32, ptr %7, i64 32
  %36 = trunc <4 x i64> %11 to <4 x i32>
  %37 = add <4 x i32> %36, <i32 32, i32 33, i32 34, i32 35>
  store <4 x i32> %37, ptr %35, align 4, !tbaa !5
  %38 = getelementptr inbounds i32, ptr %7, i64 36
  %39 = trunc <4 x i64> %11 to <4 x i32>
  %40 = add <4 x i32> %39, <i32 36, i32 37, i32 38, i32 39>
  store <4 x i32> %40, ptr %38, align 4, !tbaa !5
  %41 = getelementptr inbounds i32, ptr %7, i64 40
  %42 = trunc <4 x i64> %11 to <4 x i32>
  %43 = add <4 x i32> %42, <i32 40, i32 41, i32 42, i32 43>
  store <4 x i32> %43, ptr %41, align 4, !tbaa !5
  %44 = getelementptr inbounds i32, ptr %7, i64 44
  %45 = trunc <4 x i64> %11 to <4 x i32>
  %46 = add <4 x i32> %45, <i32 44, i32 45, i32 46, i32 47>
  store <4 x i32> %46, ptr %44, align 4, !tbaa !5
  %47 = getelementptr inbounds i32, ptr %7, i64 48
  %48 = trunc <4 x i64> %11 to <4 x i32>
  %49 = add <4 x i32> %48, <i32 48, i32 49, i32 50, i32 51>
  store <4 x i32> %49, ptr %47, align 4, !tbaa !5
  %50 = getelementptr inbounds i32, ptr %7, i64 52
  %51 = trunc <4 x i64> %11 to <4 x i32>
  %52 = add <4 x i32> %51, <i32 52, i32 53, i32 54, i32 55>
  store <4 x i32> %52, ptr %50, align 4, !tbaa !5
  %53 = getelementptr inbounds i32, ptr %7, i64 56
  %54 = trunc <4 x i64> %11 to <4 x i32>
  %55 = add <4 x i32> %54, <i32 56, i32 57, i32 58, i32 59>
  store <4 x i32> %55, ptr %53, align 4, !tbaa !5
  %56 = getelementptr inbounds i32, ptr %7, i64 60
  %57 = trunc <4 x i64> %11 to <4 x i32>
  %58 = add <4 x i32> %57, <i32 60, i32 61, i32 62, i32 63>
  store <4 x i32> %58, ptr %56, align 4, !tbaa !5
  %59 = add nuw i64 %5, 7
  %60 = and i64 %59, 63
  %61 = getelementptr inbounds i32, ptr %7, i64 %60
  %62 = load i32, ptr %61, align 4, !tbaa !5
  %63 = zext i32 %62 to i64
  %64 = add i64 %6, %63
  call void @free(ptr noundef nonnull %7) #6
  %65 = add nuw nsw i64 %5, 1
  %66 = icmp eq i64 %65, 120000
  br i1 %66, label %67, label %4, !llvm.loop !9

67:                                               ; preds = %9
  store volatile i64 %64, ptr @sink_u64, align 8, !tbaa !11
  %68 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %69 = load i64, ptr %2, align 8, !tbaa !13
  %70 = load i64, ptr %1, align 8, !tbaa !13
  %71 = sub nsw i64 %69, %70
  %72 = mul i64 %71, 1000000000
  %73 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %74 = load i64, ptr %73, align 8, !tbaa !15
  %75 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %76 = load i64, ptr %75, align 8, !tbaa !15
  %77 = icmp slt i64 %74, %76
  %78 = sub i64 %74, %76
  %79 = add i64 %78, %72
  %80 = add i64 %72, %74
  %81 = sub i64 %80, %76
  %82 = select i1 %77, i64 %81, i64 %79
  %83 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %82)
  br label %84

84:                                               ; preds = %4, %67
  %85 = phi i32 [ 0, %67 ], [ 1, %4 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %85
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
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!12, !12, i64 0}
!12 = !{!"long", !7, i64 0}
!13 = !{!14, !12, i64 0}
!14 = !{!"timespec", !12, i64 0, !12, i64 8}
!15 = !{!14, !12, i64 8}
