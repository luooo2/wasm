; ModuleID = 'data/microbenchmarks/alloc_fragmented_pattern.c'
source_filename = "data/microbenchmarks/alloc_fragmented_pattern.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  %3 = alloca [64 x ptr], align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #7
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #7
  %4 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #7
  call void @llvm.lifetime.start.p0(i64 512, ptr nonnull %3) #7
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(512) %3, i8 0, i64 512, i1 false)
  br label %5

5:                                                ; preds = %0, %26
  %6 = phi i32 [ 0, %0 ], [ %28, %26 ]
  %7 = phi i64 [ 0, %0 ], [ %27, %26 ]
  %8 = and i32 %6, 63
  %9 = zext nneg i32 %8 to i64
  %10 = getelementptr inbounds [64 x ptr], ptr %3, i64 0, i64 %9
  %11 = load ptr, ptr %10, align 8, !tbaa !5
  %12 = icmp eq ptr %11, null
  br i1 %12, label %17, label %13

13:                                               ; preds = %5
  %14 = load i32, ptr %11, align 4, !tbaa !9
  %15 = zext i32 %14 to i64
  %16 = add i64 %7, %15
  call void @free(ptr noundef nonnull %11) #7
  store ptr null, ptr %10, align 8, !tbaa !5
  br label %26

17:                                               ; preds = %5
  %18 = and i32 %6, 127
  %19 = add nuw nsw i32 %18, 8
  %20 = shl nuw nsw i32 %19, 2
  %21 = zext nneg i32 %20 to i64
  %22 = call noalias ptr @malloc(i64 noundef %21) #8
  store ptr %22, ptr %10, align 8, !tbaa !5
  %23 = icmp eq ptr %22, null
  br i1 %23, label %61, label %24

24:                                               ; preds = %17
  %25 = xor i32 %19, %6
  store i32 %25, ptr %22, align 4, !tbaa !9
  br label %26

26:                                               ; preds = %24, %13
  %27 = phi i64 [ %16, %13 ], [ %7, %24 ]
  %28 = add nuw nsw i32 %6, 1
  %29 = icmp eq i32 %28, 100000
  br i1 %29, label %47, label %5, !llvm.loop !11

30:                                               ; preds = %57
  store volatile i64 %58, ptr @sink_u64, align 8, !tbaa !13
  %31 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #7
  %32 = load i64, ptr %2, align 8, !tbaa !15
  %33 = load i64, ptr %1, align 8, !tbaa !15
  %34 = sub nsw i64 %32, %33
  %35 = mul i64 %34, 1000000000
  %36 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %37 = load i64, ptr %36, align 8, !tbaa !17
  %38 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %39 = load i64, ptr %38, align 8, !tbaa !17
  %40 = icmp slt i64 %37, %39
  %41 = sub i64 %37, %39
  %42 = add i64 %41, %35
  %43 = add i64 %35, %37
  %44 = sub i64 %43, %39
  %45 = select i1 %40, i64 %44, i64 %42
  %46 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %45)
  br label %61

47:                                               ; preds = %26, %57
  %48 = phi i64 [ %59, %57 ], [ 0, %26 ]
  %49 = phi i64 [ %58, %57 ], [ %27, %26 ]
  %50 = getelementptr inbounds [64 x ptr], ptr %3, i64 0, i64 %48
  %51 = load ptr, ptr %50, align 8, !tbaa !5
  %52 = icmp eq ptr %51, null
  br i1 %52, label %57, label %53

53:                                               ; preds = %47
  %54 = load i32, ptr %51, align 4, !tbaa !9
  %55 = zext i32 %54 to i64
  %56 = add i64 %49, %55
  call void @free(ptr noundef nonnull %51) #7
  br label %57

57:                                               ; preds = %47, %53
  %58 = phi i64 [ %56, %53 ], [ %49, %47 ]
  %59 = add nuw nsw i64 %48, 1
  %60 = icmp eq i64 %59, 64
  br i1 %60, label %30, label %47, !llvm.loop !18

61:                                               ; preds = %17, %30
  %62 = phi i32 [ 0, %30 ], [ 1, %17 ]
  call void @llvm.lifetime.end.p0(i64 512, ptr nonnull %3) #7
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #7
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #7
  ret i32 %62
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #4 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
!6 = !{!"any pointer", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !7, i64 0}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!14, !14, i64 0}
!14 = !{!"long", !7, i64 0}
!15 = !{!16, !14, i64 0}
!16 = !{!"timespec", !14, i64 0, !14, i64 8}
!17 = !{!16, !14, i64 8}
!18 = distinct !{!18, !12}
