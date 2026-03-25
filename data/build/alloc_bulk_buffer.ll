; ModuleID = 'data/microbenchmarks/alloc_bulk_buffer.c'
source_filename = "data/microbenchmarks/alloc_bulk_buffer.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %0, %52
  %2 = phi i32 [ 0, %0 ], [ %53, %52 ]
  %3 = phi i64 [ 0, %0 ], [ %49, %52 ]
  %4 = tail call noalias dereferenceable_or_null(1048576) ptr @malloc(i64 noundef 1048576) #5
  %5 = icmp eq ptr %4, null
  br i1 %5, label %57, label %6

6:                                                ; preds = %1
  %7 = trunc i32 %2 to i8
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(1048576) %4, i8 %7, i64 1048576, i1 false)
  br label %8

8:                                                ; preds = %8, %6
  %9 = phi i64 [ 0, %6 ], [ %50, %8 ]
  %10 = phi i64 [ %3, %6 ], [ %49, %8 ]
  %11 = getelementptr inbounds i8, ptr %4, i64 %9
  %12 = load i8, ptr %11, align 1, !tbaa !5
  %13 = zext i8 %12 to i64
  %14 = add i64 %10, %13
  %15 = or disjoint i64 %9, 64
  %16 = getelementptr inbounds i8, ptr %4, i64 %15
  %17 = load i8, ptr %16, align 1, !tbaa !5
  %18 = zext i8 %17 to i64
  %19 = add i64 %14, %18
  %20 = or disjoint i64 %9, 128
  %21 = getelementptr inbounds i8, ptr %4, i64 %20
  %22 = load i8, ptr %21, align 1, !tbaa !5
  %23 = zext i8 %22 to i64
  %24 = add i64 %19, %23
  %25 = or disjoint i64 %9, 192
  %26 = getelementptr inbounds i8, ptr %4, i64 %25
  %27 = load i8, ptr %26, align 1, !tbaa !5
  %28 = zext i8 %27 to i64
  %29 = add i64 %24, %28
  %30 = or disjoint i64 %9, 256
  %31 = getelementptr inbounds i8, ptr %4, i64 %30
  %32 = load i8, ptr %31, align 1, !tbaa !5
  %33 = zext i8 %32 to i64
  %34 = add i64 %29, %33
  %35 = or disjoint i64 %9, 320
  %36 = getelementptr inbounds i8, ptr %4, i64 %35
  %37 = load i8, ptr %36, align 1, !tbaa !5
  %38 = zext i8 %37 to i64
  %39 = add i64 %34, %38
  %40 = or disjoint i64 %9, 384
  %41 = getelementptr inbounds i8, ptr %4, i64 %40
  %42 = load i8, ptr %41, align 1, !tbaa !5
  %43 = zext i8 %42 to i64
  %44 = add i64 %39, %43
  %45 = or disjoint i64 %9, 448
  %46 = getelementptr inbounds i8, ptr %4, i64 %45
  %47 = load i8, ptr %46, align 1, !tbaa !5
  %48 = zext i8 %47 to i64
  %49 = add i64 %44, %48
  %50 = add nuw nsw i64 %9, 512
  %51 = icmp ult i64 %45, 1048512
  br i1 %51, label %8, label %52, !llvm.loop !8

52:                                               ; preds = %8
  tail call void @free(ptr noundef nonnull %4) #6
  %53 = add nuw nsw i32 %2, 1
  %54 = icmp eq i32 %53, 512
  br i1 %54, label %55, label %1, !llvm.loop !10

55:                                               ; preds = %52
  store volatile i64 %49, ptr @sink_u64, align 8, !tbaa !11
  %56 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %49)
  br label %57

57:                                               ; preds = %1, %55
  %58 = phi i32 [ 0, %55 ], [ 1, %1 ]
  ret i32 %58
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
!11 = !{!12, !12, i64 0}
!12 = !{!"long", !6, i64 0}
