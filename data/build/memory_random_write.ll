; ModuleID = 'data/microbenchmarks/memory_random_write.c'
source_filename = "data/microbenchmarks/memory_random_write.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias dereferenceable_or_null(10000000) ptr @malloc(i64 noundef 10000000) #4
  %2 = icmp eq ptr %1, null
  br i1 %2, label %76, label %3

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
  %26 = icmp eq i64 %24, 2500000
  br i1 %26, label %27, label %3, !llvm.loop !9

27:                                               ; preds = %3, %30
  %28 = phi i32 [ %31, %30 ], [ 0, %3 ]
  %29 = phi i32 [ %41, %30 ], [ 123456789, %3 ]
  br label %33

30:                                               ; preds = %33
  %31 = add nuw nsw i32 %28, 1
  %32 = icmp eq i32 %31, 20
  br i1 %32, label %52, label %27, !llvm.loop !13

33:                                               ; preds = %27, %33
  %34 = phi i32 [ 0, %27 ], [ %48, %33 ]
  %35 = phi i32 [ %29, %27 ], [ %41, %33 ]
  %36 = shl i32 %35, 13
  %37 = xor i32 %36, %35
  %38 = lshr i32 %37, 17
  %39 = xor i32 %38, %37
  %40 = shl i32 %39, 5
  %41 = xor i32 %40, %39
  %42 = urem i32 %41, 2500000
  %43 = zext nneg i32 %42 to i64
  %44 = getelementptr inbounds i32, ptr %1, i64 %43
  %45 = load i32, ptr %44, align 4, !tbaa !5
  %46 = add nuw nsw i32 %34, %28
  %47 = add i32 %46, %45
  store i32 %47, ptr %44, align 4, !tbaa !5
  %48 = add nuw nsw i32 %34, 1
  %49 = icmp eq i32 %48, 2500000
  br i1 %49, label %30, label %33, !llvm.loop !14

50:                                               ; preds = %52
  store volatile i64 %73, ptr @sink_u64, align 8, !tbaa !15
  %51 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %73)
  tail call void @free(ptr noundef nonnull %1) #5
  br label %76

52:                                               ; preds = %30, %52
  %53 = phi i64 [ %74, %52 ], [ 0, %30 ]
  %54 = phi i64 [ %73, %52 ], [ 0, %30 ]
  %55 = getelementptr inbounds i32, ptr %1, i64 %53
  %56 = load i32, ptr %55, align 4, !tbaa !5
  %57 = zext i32 %56 to i64
  %58 = add i64 %54, %57
  %59 = or disjoint i64 %53, 128
  %60 = getelementptr inbounds i32, ptr %1, i64 %59
  %61 = load i32, ptr %60, align 4, !tbaa !5
  %62 = zext i32 %61 to i64
  %63 = add i64 %58, %62
  %64 = or disjoint i64 %53, 256
  %65 = getelementptr inbounds i32, ptr %1, i64 %64
  %66 = load i32, ptr %65, align 4, !tbaa !5
  %67 = zext i32 %66 to i64
  %68 = add i64 %63, %67
  %69 = or disjoint i64 %53, 384
  %70 = getelementptr inbounds i32, ptr %1, i64 %69
  %71 = load i32, ptr %70, align 4, !tbaa !5
  %72 = zext i32 %71 to i64
  %73 = add i64 %68, %72
  %74 = add nuw nsw i64 %53, 512
  %75 = icmp ult i64 %69, 2499872
  br i1 %75, label %52, label %50, !llvm.loop !17

76:                                               ; preds = %0, %50
  %77 = phi i32 [ 0, %50 ], [ 1, %0 ]
  ret i32 %77
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
!13 = distinct !{!13, !10}
!14 = distinct !{!14, !10}
!15 = !{!16, !16, i64 0}
!16 = !{!"long", !7, i64 0}
!17 = distinct !{!17, !10}
