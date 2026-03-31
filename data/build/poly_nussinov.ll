; ModuleID = 'data/polybench-c-4.2.1-beta/medley/nussinov/nussinov.c'
source_filename = "data/polybench-c-4.2.1-beta/medley/nussinov/nussinov.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"table\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 500, i32 noundef 1) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 250000, i32 noundef 4) #7
  br label %5

5:                                                ; preds = %5, %2
  %6 = phi i64 [ 0, %2 ], [ %12, %5 ]
  %7 = phi <16 x i64> [ <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7, i64 8, i64 9, i64 10, i64 11, i64 12, i64 13, i64 14, i64 15>, %2 ], [ %13, %5 ]
  %8 = trunc <16 x i64> %7 to <16 x i8>
  %9 = add <16 x i8> %8, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %10 = and <16 x i8> %9, <i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3>
  %11 = getelementptr inbounds i8, ptr %3, i64 %6
  store <16 x i8> %10, ptr %11, align 1, !tbaa !5
  %12 = add nuw i64 %6, 16
  %13 = add <16 x i64> %7, <i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16>
  %14 = icmp eq i64 %12, 496
  br i1 %14, label %15, label %5, !llvm.loop !8

15:                                               ; preds = %5
  %16 = getelementptr inbounds i8, ptr %3, i64 496
  store <4 x i8> <i8 1, i8 2, i8 3, i8 0>, ptr %16, align 1, !tbaa !5
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(1000000) %4, i8 0, i64 1000000, i1 false), !tbaa !12
  br label %17

17:                                               ; preds = %90, %15
  %18 = phi i64 [ 499, %15 ], [ %91, %90 ]
  %19 = phi i64 [ 500, %15 ], [ %93, %90 ]
  %20 = add nuw nsw i64 %18, 1
  %21 = icmp ult i64 %18, 499
  br i1 %21, label %22, label %90

22:                                               ; preds = %17
  %23 = getelementptr inbounds i8, ptr %3, i64 %18
  %24 = getelementptr inbounds [500 x i32], ptr %4, i64 %18, i64 %19
  %25 = add nuw nsw i64 %19, 1
  br label %26

26:                                               ; preds = %86, %22
  %27 = phi i64 [ %89, %86 ], [ 0, %22 ]
  %28 = phi i64 [ %87, %86 ], [ %19, %22 ]
  %29 = add nsw i64 %28, -1
  %30 = getelementptr inbounds [500 x i32], ptr %4, i64 %18, i64 %28
  %31 = load i32, ptr %30, align 4, !tbaa !12
  %32 = getelementptr inbounds [500 x i32], ptr %4, i64 %18, i64 %29
  %33 = load i32, ptr %32, align 4, !tbaa !12
  %34 = tail call i32 @llvm.smax.i32(i32 %31, i32 %33)
  %35 = getelementptr inbounds [500 x i32], ptr %4, i64 %20, i64 %28
  %36 = load i32, ptr %35, align 4, !tbaa !12
  %37 = tail call i32 @llvm.smax.i32(i32 %34, i32 %36)
  store i32 %37, ptr %30, align 4, !tbaa !12
  %38 = icmp ult i64 %18, %29
  %39 = getelementptr inbounds [500 x i32], ptr %4, i64 %20, i64 %29
  %40 = load i32, ptr %39, align 4, !tbaa !12
  br i1 %38, label %41, label %51

41:                                               ; preds = %26
  %42 = load i8, ptr %23, align 1, !tbaa !5
  %43 = sext i8 %42 to i32
  %44 = getelementptr inbounds i8, ptr %3, i64 %28
  %45 = load i8, ptr %44, align 1, !tbaa !5
  %46 = sext i8 %45 to i32
  %47 = add nsw i32 %46, %43
  %48 = icmp eq i32 %47, 3
  %49 = zext i1 %48 to i32
  %50 = add nsw i32 %40, %49
  br label %51

51:                                               ; preds = %41, %26
  %52 = phi i32 [ %50, %41 ], [ %40, %26 ]
  %53 = tail call i32 @llvm.smax.i32(i32 %37, i32 %52)
  store i32 %53, ptr %30, align 4, !tbaa !12
  %54 = icmp ult i64 %20, %28
  br i1 %54, label %55, label %86

55:                                               ; preds = %51
  %56 = and i64 %27, 1
  %57 = icmp eq i64 %56, 0
  br i1 %57, label %64, label %58

58:                                               ; preds = %55
  %59 = load i32, ptr %24, align 4, !tbaa !12
  %60 = getelementptr inbounds [500 x i32], ptr %4, i64 %25, i64 %28
  %61 = load i32, ptr %60, align 4, !tbaa !12
  %62 = add nsw i32 %61, %59
  %63 = tail call i32 @llvm.smax.i32(i32 %53, i32 %62)
  store i32 %63, ptr %30, align 4, !tbaa !12
  br label %64

64:                                               ; preds = %58, %55
  %65 = phi i64 [ %19, %55 ], [ %25, %58 ]
  %66 = phi i32 [ %53, %55 ], [ %63, %58 ]
  %67 = icmp eq i64 %27, 1
  br i1 %67, label %86, label %68

68:                                               ; preds = %64, %68
  %69 = phi i64 [ %80, %68 ], [ %65, %64 ]
  %70 = phi i32 [ %84, %68 ], [ %66, %64 ]
  %71 = getelementptr inbounds [500 x i32], ptr %4, i64 %18, i64 %69
  %72 = load i32, ptr %71, align 4, !tbaa !12
  %73 = add nuw nsw i64 %69, 1
  %74 = getelementptr inbounds [500 x i32], ptr %4, i64 %73, i64 %28
  %75 = load i32, ptr %74, align 4, !tbaa !12
  %76 = add nsw i32 %75, %72
  %77 = tail call i32 @llvm.smax.i32(i32 %70, i32 %76)
  store i32 %77, ptr %30, align 4, !tbaa !12
  %78 = getelementptr inbounds [500 x i32], ptr %4, i64 %18, i64 %73
  %79 = load i32, ptr %78, align 4, !tbaa !12
  %80 = add nuw nsw i64 %69, 2
  %81 = getelementptr inbounds [500 x i32], ptr %4, i64 %80, i64 %28
  %82 = load i32, ptr %81, align 4, !tbaa !12
  %83 = add nsw i32 %82, %79
  %84 = tail call i32 @llvm.smax.i32(i32 %77, i32 %83)
  store i32 %84, ptr %30, align 4, !tbaa !12
  %85 = icmp eq i64 %80, %28
  br i1 %85, label %86, label %68, !llvm.loop !14

86:                                               ; preds = %64, %68, %51
  %87 = add nuw nsw i64 %28, 1
  %88 = icmp eq i64 %87, 500
  %89 = add i64 %27, 1
  br i1 %88, label %90, label %26, !llvm.loop !15

90:                                               ; preds = %86, %17
  %91 = add nsw i64 %18, -1
  %92 = icmp eq i64 %18, 0
  %93 = add nsw i64 %19, -1
  br i1 %92, label %94, label %17, !llvm.loop !16

94:                                               ; preds = %90
  %95 = icmp sgt i32 %0, 42
  br i1 %95, label %96, label %135

96:                                               ; preds = %94
  %97 = load ptr, ptr %1, align 8, !tbaa !17
  %98 = load i8, ptr %97, align 1
  %99 = icmp eq i8 %98, 0
  br i1 %99, label %100, label %135

100:                                              ; preds = %96
  %101 = load ptr, ptr @stderr, align 8, !tbaa !17
  %102 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %101) #8
  %103 = load ptr, ptr @stderr, align 8, !tbaa !17
  %104 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %103, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %105

105:                                              ; preds = %125, %100
  %106 = phi i32 [ 500, %100 ], [ %128, %125 ]
  %107 = phi i64 [ 0, %100 ], [ %127, %125 ]
  %108 = phi i32 [ 0, %100 ], [ %126, %125 ]
  br label %109

109:                                              ; preds = %117, %105
  %110 = phi i64 [ %107, %105 ], [ %123, %117 ]
  %111 = phi i32 [ %108, %105 ], [ %122, %117 ]
  %112 = srem i32 %111, 20
  %113 = icmp eq i32 %112, 0
  br i1 %113, label %114, label %117

114:                                              ; preds = %109
  %115 = load ptr, ptr @stderr, align 8, !tbaa !17
  %116 = tail call i32 @fputc(i32 10, ptr %115)
  br label %117

117:                                              ; preds = %114, %109
  %118 = load ptr, ptr @stderr, align 8, !tbaa !17
  %119 = getelementptr inbounds [500 x i32], ptr %4, i64 %107, i64 %110
  %120 = load i32, ptr %119, align 4, !tbaa !12
  %121 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %118, ptr noundef nonnull @.str.5, i32 noundef %120) #8
  %122 = add nsw i32 %111, 1
  %123 = add nuw nsw i64 %110, 1
  %124 = icmp eq i64 %123, 500
  br i1 %124, label %125, label %109, !llvm.loop !19

125:                                              ; preds = %117
  %126 = add i32 %108, %106
  %127 = add nuw nsw i64 %107, 1
  %128 = add nsw i32 %106, -1
  %129 = icmp eq i64 %127, 500
  br i1 %129, label %130, label %105, !llvm.loop !20

130:                                              ; preds = %125
  %131 = load ptr, ptr @stderr, align 8, !tbaa !17
  %132 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %131, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %133 = load ptr, ptr @stderr, align 8, !tbaa !17
  %134 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %133) #8
  br label %135

135:                                              ; preds = %130, %96, %94
  tail call void @free(ptr noundef %3) #7
  tail call void @free(ptr noundef %4) #7
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind }
attributes #5 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nounwind }
attributes #8 = { cold }

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
!13 = !{!"int", !6, i64 0}
!14 = distinct !{!14, !9}
!15 = distinct !{!15, !9}
!16 = distinct !{!16, !9}
!17 = !{!18, !18, i64 0}
!18 = !{!"any pointer", !6, i64 0}
!19 = distinct !{!19, !9}
!20 = distinct !{!20, !9}
