; ModuleID = 'data/microbenchmarks/memory_copy_loop.c'
source_filename = "data/microbenchmarks/memory_copy_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias dereferenceable_or_null(8388608) ptr @malloc(i64 noundef 8388608) #4
  %2 = icmp eq ptr %1, null
  br i1 %2, label %65, label %3

3:                                                ; preds = %0, %3
  %4 = phi i64 [ %16, %3 ], [ 0, %0 ]
  %5 = phi <16 x i8> [ %17, %3 ], [ <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15>, %0 ]
  %6 = getelementptr inbounds i8, ptr %1, i64 %4
  store <16 x i8> %5, ptr %6, align 1, !tbaa !5
  %7 = or disjoint i64 %4, 16
  %8 = add <16 x i8> %5, <i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16, i8 16>
  %9 = getelementptr inbounds i8, ptr %1, i64 %7
  store <16 x i8> %8, ptr %9, align 1, !tbaa !5
  %10 = or disjoint i64 %4, 32
  %11 = add <16 x i8> %5, <i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32>
  %12 = getelementptr inbounds i8, ptr %1, i64 %10
  store <16 x i8> %11, ptr %12, align 1, !tbaa !5
  %13 = or disjoint i64 %4, 48
  %14 = add <16 x i8> %5, <i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48, i8 48>
  %15 = getelementptr inbounds i8, ptr %1, i64 %13
  store <16 x i8> %14, ptr %15, align 1, !tbaa !5
  %16 = add nuw nsw i64 %4, 64
  %17 = add <16 x i8> %5, <i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64>
  %18 = icmp eq i64 %16, 8388608
  br i1 %18, label %21, label %3, !llvm.loop !8

19:                                               ; preds = %21
  store volatile i64 %62, ptr @sink_u64, align 8, !tbaa !12
  %20 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %62)
  tail call void @free(ptr noundef nonnull %1) #5
  br label %65

21:                                               ; preds = %3, %21
  %22 = phi i64 [ %63, %21 ], [ 0, %3 ]
  %23 = phi i64 [ %62, %21 ], [ 0, %3 ]
  %24 = getelementptr inbounds i8, ptr %1, i64 %22
  %25 = load i8, ptr %24, align 1, !tbaa !5
  %26 = zext i8 %25 to i64
  %27 = add i64 %23, %26
  %28 = or disjoint i64 %22, 4096
  %29 = getelementptr inbounds i8, ptr %1, i64 %28
  %30 = load i8, ptr %29, align 1, !tbaa !5
  %31 = zext i8 %30 to i64
  %32 = add i64 %27, %31
  %33 = or disjoint i64 %22, 8192
  %34 = getelementptr inbounds i8, ptr %1, i64 %33
  %35 = load i8, ptr %34, align 1, !tbaa !5
  %36 = zext i8 %35 to i64
  %37 = add i64 %32, %36
  %38 = or disjoint i64 %22, 12288
  %39 = getelementptr inbounds i8, ptr %1, i64 %38
  %40 = load i8, ptr %39, align 1, !tbaa !5
  %41 = zext i8 %40 to i64
  %42 = add i64 %37, %41
  %43 = or disjoint i64 %22, 16384
  %44 = getelementptr inbounds i8, ptr %1, i64 %43
  %45 = load i8, ptr %44, align 1, !tbaa !5
  %46 = zext i8 %45 to i64
  %47 = add i64 %42, %46
  %48 = or disjoint i64 %22, 20480
  %49 = getelementptr inbounds i8, ptr %1, i64 %48
  %50 = load i8, ptr %49, align 1, !tbaa !5
  %51 = zext i8 %50 to i64
  %52 = add i64 %47, %51
  %53 = or disjoint i64 %22, 24576
  %54 = getelementptr inbounds i8, ptr %1, i64 %53
  %55 = load i8, ptr %54, align 1, !tbaa !5
  %56 = zext i8 %55 to i64
  %57 = add i64 %52, %56
  %58 = or disjoint i64 %22, 28672
  %59 = getelementptr inbounds i8, ptr %1, i64 %58
  %60 = load i8, ptr %59, align 1, !tbaa !5
  %61 = zext i8 %60 to i64
  %62 = add i64 %57, %61
  %63 = add nuw nsw i64 %22, 32768
  %64 = icmp ult i64 %58, 8384512
  br i1 %64, label %21, label %19, !llvm.loop !14

65:                                               ; preds = %0, %19
  %66 = phi i32 [ 0, %19 ], [ 1, %0 ]
  ret i32 %66
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
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9, !10, !11}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = !{!"llvm.loop.unroll.runtime.disable"}
!12 = !{!13, !13, i64 0}
!13 = !{!"long", !6, i64 0}
!14 = distinct !{!14, !9}
