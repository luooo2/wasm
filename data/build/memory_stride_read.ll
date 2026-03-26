; ModuleID = 'data/microbenchmarks/memory_stride_read.c'
source_filename = "data/microbenchmarks/memory_stride_read.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias dereferenceable_or_null(20000000) ptr @malloc(i64 noundef 20000000) #4
  %2 = icmp eq ptr %1, null
  br i1 %2, label %58, label %3

3:                                                ; preds = %0, %3
  %4 = phi i64 [ %12, %3 ], [ 0, %0 ]
  %5 = phi <4 x i32> [ %13, %3 ], [ <i32 0, i32 1, i32 2, i32 3>, %0 ]
  %6 = getelementptr inbounds i32, ptr %1, i64 %4
  %7 = mul <4 x i32> %5, <i32 3, i32 3, i32 3, i32 3>
  %8 = mul <4 x i32> %5, <i32 3, i32 3, i32 3, i32 3>
  %9 = add <4 x i32> %7, <i32 7, i32 7, i32 7, i32 7>
  %10 = add <4 x i32> %8, <i32 19, i32 19, i32 19, i32 19>
  %11 = getelementptr inbounds i32, ptr %6, i64 4
  store <4 x i32> %9, ptr %6, align 4, !tbaa !5
  store <4 x i32> %10, ptr %11, align 4, !tbaa !5
  %12 = add nuw i64 %4, 8
  %13 = add <4 x i32> %5, <i32 8, i32 8, i32 8, i32 8>
  %14 = icmp eq i64 %12, 5000000
  br i1 %14, label %15, label %3, !llvm.loop !9

15:                                               ; preds = %3
  %16 = getelementptr i32, ptr %1, i64 16
  %17 = getelementptr i32, ptr %1, i64 32
  %18 = getelementptr i32, ptr %1, i64 48
  %19 = getelementptr i32, ptr %1, i64 64
  br label %20

20:                                               ; preds = %15, %25
  %21 = phi i32 [ %26, %25 ], [ 0, %15 ]
  %22 = phi i64 [ %55, %25 ], [ 0, %15 ]
  br label %28

23:                                               ; preds = %25
  store volatile i64 %55, ptr @sink_u64, align 8, !tbaa !13
  %24 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %55)
  tail call void @free(ptr noundef nonnull %1) #5
  br label %58

25:                                               ; preds = %28
  %26 = add nuw nsw i32 %21, 1
  %27 = icmp eq i32 %26, 32
  br i1 %27, label %23, label %20, !llvm.loop !15

28:                                               ; preds = %28, %20
  %29 = phi i64 [ 0, %20 ], [ %56, %28 ]
  %30 = phi i64 [ %22, %20 ], [ %55, %28 ]
  %31 = getelementptr inbounds i32, ptr %1, i64 %29
  %32 = load i32, ptr %31, align 4, !tbaa !5
  %33 = xor i32 %32, %21
  %34 = zext i32 %33 to i64
  %35 = add i64 %30, %34
  %36 = getelementptr i32, ptr %16, i64 %29
  %37 = load i32, ptr %36, align 4, !tbaa !5
  %38 = xor i32 %37, %21
  %39 = zext i32 %38 to i64
  %40 = add i64 %35, %39
  %41 = getelementptr i32, ptr %17, i64 %29
  %42 = load i32, ptr %41, align 4, !tbaa !5
  %43 = xor i32 %42, %21
  %44 = zext i32 %43 to i64
  %45 = add i64 %40, %44
  %46 = getelementptr i32, ptr %18, i64 %29
  %47 = load i32, ptr %46, align 4, !tbaa !5
  %48 = xor i32 %47, %21
  %49 = zext i32 %48 to i64
  %50 = add i64 %45, %49
  %51 = getelementptr i32, ptr %19, i64 %29
  %52 = load i32, ptr %51, align 4, !tbaa !5
  %53 = xor i32 %52, %21
  %54 = zext i32 %53 to i64
  %55 = add i64 %50, %54
  %56 = add nuw nsw i64 %29, 80
  %57 = icmp ult i64 %29, 4999920
  br i1 %57, label %28, label %25, !llvm.loop !16

58:                                               ; preds = %0, %23
  %59 = phi i32 [ 0, %23 ], [ 1, %0 ]
  ret i32 %59
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
