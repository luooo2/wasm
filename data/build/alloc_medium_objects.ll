; ModuleID = 'data/microbenchmarks/alloc_medium_objects.c'
source_filename = "data/microbenchmarks/alloc_medium_objects.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %0, %6
  %2 = phi i64 [ 0, %0 ], [ %62, %6 ]
  %3 = phi i64 [ 0, %0 ], [ %61, %6 ]
  %4 = tail call noalias dereferenceable_or_null(256) ptr @malloc(i64 noundef 256) #4
  %5 = icmp eq ptr %4, null
  br i1 %5, label %66, label %6

6:                                                ; preds = %1
  %7 = insertelement <4 x i64> poison, i64 %2, i64 0
  %8 = shufflevector <4 x i64> %7, <4 x i64> poison, <4 x i32> zeroinitializer
  %9 = trunc <4 x i64> %8 to <4 x i32>
  %10 = add <4 x i32> %9, <i32 0, i32 1, i32 2, i32 3>
  store <4 x i32> %10, ptr %4, align 4, !tbaa !5
  %11 = getelementptr inbounds i32, ptr %4, i64 4
  %12 = trunc <4 x i64> %8 to <4 x i32>
  %13 = add <4 x i32> %12, <i32 4, i32 5, i32 6, i32 7>
  store <4 x i32> %13, ptr %11, align 4, !tbaa !5
  %14 = getelementptr inbounds i32, ptr %4, i64 8
  %15 = trunc <4 x i64> %8 to <4 x i32>
  %16 = add <4 x i32> %15, <i32 8, i32 9, i32 10, i32 11>
  store <4 x i32> %16, ptr %14, align 4, !tbaa !5
  %17 = getelementptr inbounds i32, ptr %4, i64 12
  %18 = trunc <4 x i64> %8 to <4 x i32>
  %19 = add <4 x i32> %18, <i32 12, i32 13, i32 14, i32 15>
  store <4 x i32> %19, ptr %17, align 4, !tbaa !5
  %20 = getelementptr inbounds i32, ptr %4, i64 16
  %21 = trunc <4 x i64> %8 to <4 x i32>
  %22 = add <4 x i32> %21, <i32 16, i32 17, i32 18, i32 19>
  store <4 x i32> %22, ptr %20, align 4, !tbaa !5
  %23 = getelementptr inbounds i32, ptr %4, i64 20
  %24 = trunc <4 x i64> %8 to <4 x i32>
  %25 = add <4 x i32> %24, <i32 20, i32 21, i32 22, i32 23>
  store <4 x i32> %25, ptr %23, align 4, !tbaa !5
  %26 = getelementptr inbounds i32, ptr %4, i64 24
  %27 = trunc <4 x i64> %8 to <4 x i32>
  %28 = add <4 x i32> %27, <i32 24, i32 25, i32 26, i32 27>
  store <4 x i32> %28, ptr %26, align 4, !tbaa !5
  %29 = getelementptr inbounds i32, ptr %4, i64 28
  %30 = trunc <4 x i64> %8 to <4 x i32>
  %31 = add <4 x i32> %30, <i32 28, i32 29, i32 30, i32 31>
  store <4 x i32> %31, ptr %29, align 4, !tbaa !5
  %32 = getelementptr inbounds i32, ptr %4, i64 32
  %33 = trunc <4 x i64> %8 to <4 x i32>
  %34 = add <4 x i32> %33, <i32 32, i32 33, i32 34, i32 35>
  store <4 x i32> %34, ptr %32, align 4, !tbaa !5
  %35 = getelementptr inbounds i32, ptr %4, i64 36
  %36 = trunc <4 x i64> %8 to <4 x i32>
  %37 = add <4 x i32> %36, <i32 36, i32 37, i32 38, i32 39>
  store <4 x i32> %37, ptr %35, align 4, !tbaa !5
  %38 = getelementptr inbounds i32, ptr %4, i64 40
  %39 = trunc <4 x i64> %8 to <4 x i32>
  %40 = add <4 x i32> %39, <i32 40, i32 41, i32 42, i32 43>
  store <4 x i32> %40, ptr %38, align 4, !tbaa !5
  %41 = getelementptr inbounds i32, ptr %4, i64 44
  %42 = trunc <4 x i64> %8 to <4 x i32>
  %43 = add <4 x i32> %42, <i32 44, i32 45, i32 46, i32 47>
  store <4 x i32> %43, ptr %41, align 4, !tbaa !5
  %44 = getelementptr inbounds i32, ptr %4, i64 48
  %45 = trunc <4 x i64> %8 to <4 x i32>
  %46 = add <4 x i32> %45, <i32 48, i32 49, i32 50, i32 51>
  store <4 x i32> %46, ptr %44, align 4, !tbaa !5
  %47 = getelementptr inbounds i32, ptr %4, i64 52
  %48 = trunc <4 x i64> %8 to <4 x i32>
  %49 = add <4 x i32> %48, <i32 52, i32 53, i32 54, i32 55>
  store <4 x i32> %49, ptr %47, align 4, !tbaa !5
  %50 = getelementptr inbounds i32, ptr %4, i64 56
  %51 = trunc <4 x i64> %8 to <4 x i32>
  %52 = add <4 x i32> %51, <i32 56, i32 57, i32 58, i32 59>
  store <4 x i32> %52, ptr %50, align 4, !tbaa !5
  %53 = getelementptr inbounds i32, ptr %4, i64 60
  %54 = trunc <4 x i64> %8 to <4 x i32>
  %55 = add <4 x i32> %54, <i32 60, i32 61, i32 62, i32 63>
  store <4 x i32> %55, ptr %53, align 4, !tbaa !5
  %56 = add nuw i64 %2, 7
  %57 = and i64 %56, 63
  %58 = getelementptr inbounds i32, ptr %4, i64 %57
  %59 = load i32, ptr %58, align 4, !tbaa !5
  %60 = zext i32 %59 to i64
  %61 = add i64 %3, %60
  tail call void @free(ptr noundef nonnull %4) #5
  %62 = add nuw nsw i64 %2, 1
  %63 = icmp eq i64 %62, 1200000
  br i1 %63, label %64, label %1, !llvm.loop !9

64:                                               ; preds = %6
  store volatile i64 %61, ptr @sink_u64, align 8, !tbaa !11
  %65 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %61)
  br label %66

66:                                               ; preds = %1, %64
  %67 = phi i32 [ 0, %64 ], [ 1, %1 ]
  ret i32 %67
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
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!12, !12, i64 0}
!12 = !{!"long", !7, i64 0}
