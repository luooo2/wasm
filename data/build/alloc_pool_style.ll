; ModuleID = 'data/microbenchmarks/alloc_pool_style.c'
source_filename = "data/microbenchmarks/alloc_pool_style.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias dereferenceable_or_null(1048576) ptr @malloc(i64 noundef 1048576) #4
  %2 = icmp eq ptr %1, null
  br i1 %2, label %51, label %3

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
  %26 = icmp eq i64 %24, 262144
  br i1 %26, label %29, label %3, !llvm.loop !9

27:                                               ; preds = %29
  tail call void @free(ptr noundef nonnull %1) #5
  store volatile i64 %48, ptr @sink_u64, align 8, !tbaa !13
  %28 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %48)
  br label %51

29:                                               ; preds = %3, %29
  %30 = phi i32 [ %49, %29 ], [ 0, %3 ]
  %31 = phi i64 [ %48, %29 ], [ 0, %3 ]
  %32 = and i32 %30, 262142
  %33 = zext nneg i32 %32 to i64
  %34 = getelementptr inbounds i32, ptr %1, i64 %33
  %35 = load i32, ptr %34, align 4, !tbaa !5
  %36 = and i32 %30, 30
  %37 = add i32 %35, %36
  store i32 %37, ptr %34, align 4, !tbaa !5
  %38 = zext i32 %37 to i64
  %39 = add i64 %31, %38
  %40 = or disjoint i32 %30, 1
  %41 = and i32 %40, 262143
  %42 = zext nneg i32 %41 to i64
  %43 = getelementptr inbounds i32, ptr %1, i64 %42
  %44 = load i32, ptr %43, align 4, !tbaa !5
  %45 = and i32 %40, 31
  %46 = add i32 %44, %45
  store i32 %46, ptr %43, align 4, !tbaa !5
  %47 = zext i32 %46 to i64
  %48 = add i64 %39, %47
  %49 = add nuw nsw i32 %30, 2
  %50 = icmp eq i32 %49, 8000000
  br i1 %50, label %27, label %29, !llvm.loop !15

51:                                               ; preds = %0, %27
  %52 = phi i32 [ 0, %27 ], [ 1, %0 ]
  ret i32 %52
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
!15 = distinct !{!15, !10, !11}
