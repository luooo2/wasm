; ModuleID = 'data/microbenchmarks/memory_seq_write.c'
source_filename = "data/microbenchmarks/memory_seq_write.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias dereferenceable_or_null(20000000) ptr @malloc(i64 noundef 20000000) #4
  %2 = icmp eq ptr %1, null
  br i1 %2, label %83, label %3

3:                                                ; preds = %0, %3
  %4 = phi i64 [ %24, %3 ], [ 0, %0 ]
  %5 = phi <4 x i32> [ %25, %3 ], [ <i32 0, i32 1, i32 2, i32 3>, %0 ]
  %6 = add <4 x i32> %5, <i32 4, i32 4, i32 4, i32 4>
  %7 = getelementptr inbounds i32, ptr %1, i64 %4
  %8 = getelementptr inbounds i32, ptr %7, i64 4
  store <4 x i32> %5, ptr %7, align 4, !tbaa !5
  store <4 x i32> %6, ptr %8, align 4, !tbaa !5
  %9 = or disjoint i64 %4, 8
  %10 = add <4 x i32> %5, <i32 8, i32 8, i32 8, i32 8>
  %11 = add <4 x i32> %5, <i32 12, i32 12, i32 12, i32 12>
  %12 = getelementptr inbounds i32, ptr %1, i64 %9
  %13 = getelementptr inbounds i32, ptr %12, i64 4
  store <4 x i32> %10, ptr %12, align 4, !tbaa !5
  store <4 x i32> %11, ptr %13, align 4, !tbaa !5
  %14 = or disjoint i64 %4, 16
  %15 = add <4 x i32> %5, <i32 16, i32 16, i32 16, i32 16>
  %16 = add <4 x i32> %5, <i32 20, i32 20, i32 20, i32 20>
  %17 = getelementptr inbounds i32, ptr %1, i64 %14
  %18 = getelementptr inbounds i32, ptr %17, i64 4
  store <4 x i32> %15, ptr %17, align 4, !tbaa !5
  store <4 x i32> %16, ptr %18, align 4, !tbaa !5
  %19 = or disjoint i64 %4, 24
  %20 = add <4 x i32> %5, <i32 24, i32 24, i32 24, i32 24>
  %21 = add <4 x i32> %5, <i32 28, i32 28, i32 28, i32 28>
  %22 = getelementptr inbounds i32, ptr %1, i64 %19
  %23 = getelementptr inbounds i32, ptr %22, i64 4
  store <4 x i32> %20, ptr %22, align 4, !tbaa !5
  store <4 x i32> %21, ptr %23, align 4, !tbaa !5
  %24 = add nuw nsw i64 %4, 32
  %25 = add <4 x i32> %5, <i32 32, i32 32, i32 32, i32 32>
  %26 = icmp eq i64 %24, 5000000
  br i1 %26, label %27, label %3, !llvm.loop !9

27:                                               ; preds = %3, %48
  %28 = phi i64 [ %49, %48 ], [ 0, %3 ]
  %29 = insertelement <4 x i64> poison, i64 %28, i64 0
  %30 = shufflevector <4 x i64> %29, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %31

31:                                               ; preds = %31, %27
  %32 = phi i64 [ 0, %27 ], [ %45, %31 ]
  %33 = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %27 ], [ %46, %31 ]
  %34 = add <4 x i64> %33, <i64 4, i64 4, i64 4, i64 4>
  %35 = getelementptr inbounds i32, ptr %1, i64 %32
  %36 = getelementptr inbounds i32, ptr %35, i64 4
  %37 = load <4 x i32>, ptr %35, align 4, !tbaa !5
  %38 = load <4 x i32>, ptr %36, align 4, !tbaa !5
  %39 = add nuw nsw <4 x i64> %33, %30
  %40 = add nuw nsw <4 x i64> %34, %30
  %41 = trunc <4 x i64> %39 to <4 x i32>
  %42 = trunc <4 x i64> %40 to <4 x i32>
  %43 = add <4 x i32> %37, %41
  %44 = add <4 x i32> %38, %42
  store <4 x i32> %43, ptr %35, align 4, !tbaa !5
  store <4 x i32> %44, ptr %36, align 4, !tbaa !5
  %45 = add nuw i64 %32, 8
  %46 = add <4 x i64> %33, <i64 8, i64 8, i64 8, i64 8>
  %47 = icmp eq i64 %45, 5000000
  br i1 %47, label %48, label %31, !llvm.loop !13

48:                                               ; preds = %31
  %49 = add nuw nsw i64 %28, 1
  %50 = icmp eq i64 %49, 20
  br i1 %50, label %51, label %27, !llvm.loop !14

51:                                               ; preds = %48
  %52 = getelementptr i32, ptr %1, i64 64
  %53 = getelementptr i32, ptr %1, i64 128
  %54 = getelementptr i32, ptr %1, i64 192
  %55 = getelementptr i32, ptr %1, i64 256
  br label %58

56:                                               ; preds = %58
  store volatile i64 %80, ptr @sink_u64, align 8, !tbaa !15
  %57 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %80)
  tail call void @free(ptr noundef nonnull %1) #5
  br label %83

58:                                               ; preds = %58, %51
  %59 = phi i64 [ 0, %51 ], [ %81, %58 ]
  %60 = phi i64 [ 0, %51 ], [ %80, %58 ]
  %61 = getelementptr inbounds i32, ptr %1, i64 %59
  %62 = load i32, ptr %61, align 4, !tbaa !5
  %63 = zext i32 %62 to i64
  %64 = add i64 %60, %63
  %65 = getelementptr i32, ptr %52, i64 %59
  %66 = load i32, ptr %65, align 4, !tbaa !5
  %67 = zext i32 %66 to i64
  %68 = add i64 %64, %67
  %69 = getelementptr i32, ptr %53, i64 %59
  %70 = load i32, ptr %69, align 4, !tbaa !5
  %71 = zext i32 %70 to i64
  %72 = add i64 %68, %71
  %73 = getelementptr i32, ptr %54, i64 %59
  %74 = load i32, ptr %73, align 4, !tbaa !5
  %75 = zext i32 %74 to i64
  %76 = add i64 %72, %75
  %77 = getelementptr i32, ptr %55, i64 %59
  %78 = load i32, ptr %77, align 4, !tbaa !5
  %79 = zext i32 %78 to i64
  %80 = add i64 %76, %79
  %81 = add nuw nsw i64 %59, 320
  %82 = icmp ult i64 %59, 4999680
  br i1 %82, label %58, label %56, !llvm.loop !17

83:                                               ; preds = %0, %56
  %84 = phi i32 [ 0, %56 ], [ 1, %0 ]
  ret i32 %84
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind allocsize(0) }
attributes #5 = { nounwind }

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
!17 = distinct !{!17, !10}
