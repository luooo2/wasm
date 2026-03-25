; ModuleID = 'data/microbenchmarks/memory_seq_read.c'
source_filename = "data/microbenchmarks/memory_seq_read.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias dereferenceable_or_null(16000000) ptr @malloc(i64 noundef 16000000) #5
  %2 = icmp eq ptr %1, null
  br i1 %2, label %42, label %3

3:                                                ; preds = %0, %3
  %4 = phi i64 [ %12, %3 ], [ 0, %0 ]
  %5 = phi <4 x i32> [ %13, %3 ], [ <i32 0, i32 1, i32 2, i32 3>, %0 ]
  %6 = getelementptr inbounds i32, ptr %1, i64 %4
  %7 = mul <4 x i32> %5, <i32 17, i32 17, i32 17, i32 17>
  %8 = mul <4 x i32> %5, <i32 17, i32 17, i32 17, i32 17>
  %9 = add <4 x i32> %7, <i32 3, i32 3, i32 3, i32 3>
  %10 = add <4 x i32> %8, <i32 71, i32 71, i32 71, i32 71>
  %11 = getelementptr inbounds i32, ptr %6, i64 4
  store <4 x i32> %9, ptr %6, align 4, !tbaa !5
  store <4 x i32> %10, ptr %11, align 4, !tbaa !5
  %12 = add nuw i64 %4, 8
  %13 = add <4 x i32> %5, <i32 8, i32 8, i32 8, i32 8>
  %14 = icmp eq i64 %12, 4000000
  br i1 %14, label %15, label %3, !llvm.loop !9

15:                                               ; preds = %3, %15
  %16 = phi i64 [ %36, %15 ], [ 0, %3 ]
  %17 = phi <2 x i64> [ %34, %15 ], [ zeroinitializer, %3 ]
  %18 = phi <2 x i64> [ %35, %15 ], [ zeroinitializer, %3 ]
  %19 = getelementptr inbounds i32, ptr %1, i64 %16
  %20 = getelementptr inbounds i32, ptr %19, i64 2
  %21 = load <2 x i32>, ptr %19, align 4, !tbaa !5
  %22 = load <2 x i32>, ptr %20, align 4, !tbaa !5
  %23 = zext <2 x i32> %21 to <2 x i64>
  %24 = zext <2 x i32> %22 to <2 x i64>
  %25 = add <2 x i64> %17, %23
  %26 = add <2 x i64> %18, %24
  %27 = or disjoint i64 %16, 4
  %28 = getelementptr inbounds i32, ptr %1, i64 %27
  %29 = getelementptr inbounds i32, ptr %28, i64 2
  %30 = load <2 x i32>, ptr %28, align 4, !tbaa !5
  %31 = load <2 x i32>, ptr %29, align 4, !tbaa !5
  %32 = zext <2 x i32> %30 to <2 x i64>
  %33 = zext <2 x i32> %31 to <2 x i64>
  %34 = add <2 x i64> %25, %32
  %35 = add <2 x i64> %26, %33
  %36 = add nuw nsw i64 %16, 8
  %37 = icmp eq i64 %36, 4000000
  br i1 %37, label %38, label %15, !llvm.loop !13

38:                                               ; preds = %15
  %39 = add <2 x i64> %35, %34
  %40 = tail call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %39)
  store volatile i64 %40, ptr @sink_u64, align 8, !tbaa !14
  %41 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %40)
  tail call void @free(ptr noundef nonnull %1) #6
  br label %42

42:                                               ; preds = %0, %38
  %43 = phi i32 [ 0, %38 ], [ 1, %0 ]
  ret i32 %43
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>) #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind allocsize(0) }
attributes #6 = { nounwind }

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
