; ModuleID = 'data/microbenchmarks/memory_seq_read.c'
source_filename = "data/microbenchmarks/memory_seq_read.c"
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
  %4 = call noalias dereferenceable_or_null(16000000) ptr @malloc(i64 noundef 16000000) #8
  %5 = icmp eq ptr %4, null
  br i1 %5, label %60, label %6

6:                                                ; preds = %0, %6
  %7 = phi i64 [ %15, %6 ], [ 0, %0 ]
  %8 = phi <4 x i32> [ %16, %6 ], [ <i32 0, i32 1, i32 2, i32 3>, %0 ]
  %9 = getelementptr inbounds i32, ptr %4, i64 %7
  %10 = mul <4 x i32> %8, <i32 17, i32 17, i32 17, i32 17>
  %11 = mul <4 x i32> %8, <i32 17, i32 17, i32 17, i32 17>
  %12 = add <4 x i32> %10, <i32 3, i32 3, i32 3, i32 3>
  %13 = add <4 x i32> %11, <i32 71, i32 71, i32 71, i32 71>
  %14 = getelementptr inbounds i32, ptr %9, i64 4
  store <4 x i32> %12, ptr %9, align 4, !tbaa !5
  store <4 x i32> %13, ptr %14, align 4, !tbaa !5
  %15 = add nuw i64 %7, 8
  %16 = add <4 x i32> %8, <i32 8, i32 8, i32 8, i32 8>
  %17 = icmp eq i64 %15, 4000000
  br i1 %17, label %18, label %6, !llvm.loop !9

18:                                               ; preds = %6, %18
  %19 = phi i64 [ %39, %18 ], [ 0, %6 ]
  %20 = phi <2 x i64> [ %37, %18 ], [ zeroinitializer, %6 ]
  %21 = phi <2 x i64> [ %38, %18 ], [ zeroinitializer, %6 ]
  %22 = getelementptr inbounds i32, ptr %4, i64 %19
  %23 = getelementptr inbounds i32, ptr %22, i64 2
  %24 = load <2 x i32>, ptr %22, align 4, !tbaa !5
  %25 = load <2 x i32>, ptr %23, align 4, !tbaa !5
  %26 = zext <2 x i32> %24 to <2 x i64>
  %27 = zext <2 x i32> %25 to <2 x i64>
  %28 = add <2 x i64> %20, %26
  %29 = add <2 x i64> %21, %27
  %30 = or disjoint i64 %19, 4
  %31 = getelementptr inbounds i32, ptr %4, i64 %30
  %32 = getelementptr inbounds i32, ptr %31, i64 2
  %33 = load <2 x i32>, ptr %31, align 4, !tbaa !5
  %34 = load <2 x i32>, ptr %32, align 4, !tbaa !5
  %35 = zext <2 x i32> %33 to <2 x i64>
  %36 = zext <2 x i32> %34 to <2 x i64>
  %37 = add <2 x i64> %28, %35
  %38 = add <2 x i64> %29, %36
  %39 = add nuw nsw i64 %19, 8
  %40 = icmp eq i64 %39, 4000000
  br i1 %40, label %41, label %18, !llvm.loop !13

41:                                               ; preds = %18
  %42 = add <2 x i64> %38, %37
  %43 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %42)
  store volatile i64 %43, ptr @sink_u64, align 8, !tbaa !14
  call void @free(ptr noundef nonnull %4) #7
  %44 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #7
  %45 = load i64, ptr %2, align 8, !tbaa !16
  %46 = load i64, ptr %1, align 8, !tbaa !16
  %47 = sub nsw i64 %45, %46
  %48 = mul i64 %47, 1000000000
  %49 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %50 = load i64, ptr %49, align 8, !tbaa !18
  %51 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %52 = load i64, ptr %51, align 8, !tbaa !18
  %53 = icmp slt i64 %50, %52
  %54 = sub i64 %50, %52
  %55 = add i64 %54, %48
  %56 = add i64 %48, %50
  %57 = sub i64 %56, %52
  %58 = select i1 %53, i64 %57, i64 %55
  %59 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %58)
  br label %60

60:                                               ; preds = %0, %41
  %61 = phi i32 [ 0, %41 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #7
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #7
  ret i32 %61
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
