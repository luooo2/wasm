; ModuleID = 'data/microbenchmarks/memory_stride_write.c'
source_filename = "data/microbenchmarks/memory_stride_write.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call dereferenceable_or_null(16000000) ptr @calloc(i64 1, i64 16000000)
  %2 = icmp eq ptr %1, null
  br i1 %2, label %81, label %3

3:                                                ; preds = %0, %5
  %4 = phi i64 [ %6, %5 ], [ 0, %0 ]
  br label %8

5:                                                ; preds = %8
  %6 = add nuw nsw i64 %4, 1
  %7 = icmp eq i64 %6, 32
  br i1 %7, label %37, label %3, !llvm.loop !5

8:                                                ; preds = %8, %3
  %9 = phi i64 [ 0, %3 ], [ %33, %8 ]
  %10 = getelementptr inbounds i32, ptr %1, i64 %9
  %11 = load i32, ptr %10, align 4, !tbaa !7
  %12 = add nuw nsw i64 %9, %4
  %13 = trunc i64 %12 to i32
  %14 = add i32 %11, %13
  store i32 %14, ptr %10, align 4, !tbaa !7
  %15 = or disjoint i64 %9, 16
  %16 = getelementptr inbounds i32, ptr %1, i64 %15
  %17 = load i32, ptr %16, align 4, !tbaa !7
  %18 = add nuw nsw i64 %15, %4
  %19 = trunc i64 %18 to i32
  %20 = add i32 %17, %19
  store i32 %20, ptr %16, align 4, !tbaa !7
  %21 = or disjoint i64 %9, 32
  %22 = getelementptr inbounds i32, ptr %1, i64 %21
  %23 = load i32, ptr %22, align 4, !tbaa !7
  %24 = add nuw nsw i64 %21, %4
  %25 = trunc i64 %24 to i32
  %26 = add i32 %23, %25
  store i32 %26, ptr %22, align 4, !tbaa !7
  %27 = or disjoint i64 %9, 48
  %28 = getelementptr inbounds i32, ptr %1, i64 %27
  %29 = load i32, ptr %28, align 4, !tbaa !7
  %30 = add nuw nsw i64 %27, %4
  %31 = trunc i64 %30 to i32
  %32 = add i32 %29, %31
  store i32 %32, ptr %28, align 4, !tbaa !7
  %33 = add nuw nsw i64 %9, 64
  %34 = icmp ult i64 %27, 3999984
  br i1 %34, label %8, label %5, !llvm.loop !11

35:                                               ; preds = %37
  store volatile i64 %78, ptr @sink_u64, align 8, !tbaa !12
  %36 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %78)
  tail call void @free(ptr noundef nonnull %1) #4
  br label %81

37:                                               ; preds = %5, %37
  %38 = phi i64 [ %79, %37 ], [ 0, %5 ]
  %39 = phi i64 [ %78, %37 ], [ 0, %5 ]
  %40 = getelementptr inbounds i32, ptr %1, i64 %38
  %41 = load i32, ptr %40, align 4, !tbaa !7
  %42 = zext i32 %41 to i64
  %43 = add i64 %39, %42
  %44 = or disjoint i64 %38, 16
  %45 = getelementptr inbounds i32, ptr %1, i64 %44
  %46 = load i32, ptr %45, align 4, !tbaa !7
  %47 = zext i32 %46 to i64
  %48 = add i64 %43, %47
  %49 = or disjoint i64 %38, 32
  %50 = getelementptr inbounds i32, ptr %1, i64 %49
  %51 = load i32, ptr %50, align 4, !tbaa !7
  %52 = zext i32 %51 to i64
  %53 = add i64 %48, %52
  %54 = or disjoint i64 %38, 48
  %55 = getelementptr inbounds i32, ptr %1, i64 %54
  %56 = load i32, ptr %55, align 4, !tbaa !7
  %57 = zext i32 %56 to i64
  %58 = add i64 %53, %57
  %59 = or disjoint i64 %38, 64
  %60 = getelementptr inbounds i32, ptr %1, i64 %59
  %61 = load i32, ptr %60, align 4, !tbaa !7
  %62 = zext i32 %61 to i64
  %63 = add i64 %58, %62
  %64 = or disjoint i64 %38, 80
  %65 = getelementptr inbounds i32, ptr %1, i64 %64
  %66 = load i32, ptr %65, align 4, !tbaa !7
  %67 = zext i32 %66 to i64
  %68 = add i64 %63, %67
  %69 = or disjoint i64 %38, 96
  %70 = getelementptr inbounds i32, ptr %1, i64 %69
  %71 = load i32, ptr %70, align 4, !tbaa !7
  %72 = zext i32 %71 to i64
  %73 = add i64 %68, %72
  %74 = or disjoint i64 %38, 112
  %75 = getelementptr inbounds i32, ptr %1, i64 %74
  %76 = load i32, ptr %75, align 4, !tbaa !7
  %77 = zext i32 %76 to i64
  %78 = add i64 %73, %77
  %79 = add nuw nsw i64 %38, 128
  %80 = icmp ult i64 %74, 3999984
  br i1 %80, label %37, label %35, !llvm.loop !14

81:                                               ; preds = %0, %35
  %82 = phi i32 [ 0, %35 ], [ 1, %0 ]
  ret i32 %82
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @calloc(i64 noundef, i64 noundef) local_unnamed_addr #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = distinct !{!11, !6}
!12 = !{!13, !13, i64 0}
!13 = !{!"long", !9, i64 0}
!14 = distinct !{!14, !6}
