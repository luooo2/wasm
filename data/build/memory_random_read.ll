; ModuleID = 'data/microbenchmarks/memory_random_read.c'
source_filename = "data/microbenchmarks/memory_random_read.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias dereferenceable_or_null(12000000) ptr @malloc(i64 noundef 12000000) #4
  %2 = icmp eq ptr %1, null
  br i1 %2, label %67, label %3

3:                                                ; preds = %0, %3
  %4 = phi i64 [ %25, %3 ], [ 0, %0 ]
  %5 = phi <4 x i32> [ %26, %3 ], [ <i32 0, i32 1, i32 2, i32 3>, %0 ]
  %6 = add <4 x i32> %5, <i32 4, i32 4, i32 4, i32 4>
  %7 = xor <4 x i32> %5, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %8 = xor <4 x i32> %6, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %9 = getelementptr inbounds i32, ptr %1, i64 %4
  %10 = getelementptr inbounds i32, ptr %9, i64 4
  store <4 x i32> %7, ptr %9, align 4, !tbaa !5
  store <4 x i32> %8, ptr %10, align 4, !tbaa !5
  %11 = add <4 x i32> %5, <i32 8, i32 8, i32 8, i32 8>
  %12 = add <4 x i32> %5, <i32 12, i32 12, i32 12, i32 12>
  %13 = xor <4 x i32> %11, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %14 = xor <4 x i32> %12, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %15 = getelementptr i32, ptr %1, i64 %4
  %16 = getelementptr i32, ptr %15, i64 8
  %17 = getelementptr i32, ptr %15, i64 12
  store <4 x i32> %13, ptr %16, align 4, !tbaa !5
  store <4 x i32> %14, ptr %17, align 4, !tbaa !5
  %18 = add <4 x i32> %5, <i32 16, i32 16, i32 16, i32 16>
  %19 = add <4 x i32> %5, <i32 20, i32 20, i32 20, i32 20>
  %20 = xor <4 x i32> %18, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %21 = xor <4 x i32> %19, <i32 1515870810, i32 1515870810, i32 1515870810, i32 1515870810>
  %22 = getelementptr i32, ptr %1, i64 %4
  %23 = getelementptr i32, ptr %22, i64 16
  %24 = getelementptr i32, ptr %22, i64 20
  store <4 x i32> %20, ptr %23, align 4, !tbaa !5
  store <4 x i32> %21, ptr %24, align 4, !tbaa !5
  %25 = add nuw nsw i64 %4, 24
  %26 = add <4 x i32> %5, <i32 24, i32 24, i32 24, i32 24>
  %27 = icmp eq i64 %25, 3000000
  br i1 %27, label %28, label %3, !llvm.loop !9

28:                                               ; preds = %3, %34
  %29 = phi i32 [ %35, %34 ], [ 0, %3 ]
  %30 = phi i64 [ %64, %34 ], [ 0, %3 ]
  %31 = phi i32 [ %58, %34 ], [ -1831433054, %3 ]
  br label %37

32:                                               ; preds = %34
  store volatile i64 %64, ptr @sink_u64, align 8, !tbaa !13
  %33 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %64)
  tail call void @free(ptr noundef nonnull %1) #5
  br label %67

34:                                               ; preds = %37
  %35 = add nuw nsw i32 %29, 1
  %36 = icmp eq i32 %35, 24
  br i1 %36, label %32, label %28, !llvm.loop !15

37:                                               ; preds = %37, %28
  %38 = phi i32 [ 0, %28 ], [ %65, %37 ]
  %39 = phi i64 [ %30, %28 ], [ %64, %37 ]
  %40 = phi i32 [ %31, %28 ], [ %58, %37 ]
  %41 = shl i32 %40, 13
  %42 = xor i32 %41, %40
  %43 = lshr i32 %42, 17
  %44 = xor i32 %43, %42
  %45 = shl i32 %44, 5
  %46 = xor i32 %45, %44
  %47 = urem i32 %46, 3000000
  %48 = zext nneg i32 %47 to i64
  %49 = getelementptr inbounds i32, ptr %1, i64 %48
  %50 = load i32, ptr %49, align 4, !tbaa !5
  %51 = zext i32 %50 to i64
  %52 = add i64 %39, %51
  %53 = shl i32 %46, 13
  %54 = xor i32 %53, %46
  %55 = lshr i32 %54, 17
  %56 = xor i32 %55, %54
  %57 = shl i32 %56, 5
  %58 = xor i32 %57, %56
  %59 = urem i32 %58, 3000000
  %60 = zext nneg i32 %59 to i64
  %61 = getelementptr inbounds i32, ptr %1, i64 %60
  %62 = load i32, ptr %61, align 4, !tbaa !5
  %63 = zext i32 %62 to i64
  %64 = add i64 %52, %63
  %65 = add nuw nsw i32 %38, 2
  %66 = icmp eq i32 %65, 3000000
  br i1 %66, label %34, label %37, !llvm.loop !16

67:                                               ; preds = %0, %32
  %68 = phi i32 [ 0, %32 ], [ 1, %0 ]
  ret i32 %68
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
!13 = !{!14, !14, i64 0}
!14 = !{!"long", !7, i64 0}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
