; ModuleID = 'data/polybench-c-4.2.1-beta/medley/floyd-warshall/floyd-warshall.c'
source_filename = "data/polybench-c-4.2.1-beta/medley/floyd-warshall/floyd-warshall.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"path\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 250000, i32 noundef 4) #6
  br label %4

4:                                                ; preds = %2, %30
  %5 = phi i64 [ 0, %2 ], [ %31, %30 ]
  %6 = insertelement <4 x i64> poison, i64 %5, i64 0
  %7 = shufflevector <4 x i64> %6, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %8

8:                                                ; preds = %8, %4
  %9 = phi i64 [ 0, %4 ], [ %27, %8 ]
  %10 = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %4 ], [ %28, %8 ]
  %11 = mul nuw nsw <4 x i64> %10, %7
  %12 = trunc <4 x i64> %11 to <4 x i32>
  %13 = urem <4 x i32> %12, <i32 7, i32 7, i32 7, i32 7>
  %14 = add nuw nsw <4 x i32> %13, <i32 1, i32 1, i32 1, i32 1>
  %15 = getelementptr inbounds [500 x i32], ptr %3, i64 %5, i64 %9
  %16 = add nuw nsw <4 x i64> %10, %7
  %17 = trunc <4 x i64> %16 to <4 x i32>
  %18 = urem <4 x i32> %17, <i32 13, i32 13, i32 13, i32 13>
  %19 = icmp eq <4 x i32> %18, zeroinitializer
  %20 = urem <4 x i32> %17, <i32 7, i32 7, i32 7, i32 7>
  %21 = icmp eq <4 x i32> %20, zeroinitializer
  %22 = or <4 x i1> %19, %21
  %23 = urem <4 x i32> %17, <i32 11, i32 11, i32 11, i32 11>
  %24 = icmp eq <4 x i32> %23, zeroinitializer
  %25 = or <4 x i1> %24, %22
  %26 = select <4 x i1> %25, <4 x i32> <i32 999, i32 999, i32 999, i32 999>, <4 x i32> %14
  store <4 x i32> %26, ptr %15, align 4, !tbaa !5
  %27 = add nuw i64 %9, 4
  %28 = add <4 x i64> %10, <i64 4, i64 4, i64 4, i64 4>
  %29 = icmp eq i64 %27, 500
  br i1 %29, label %30, label %8, !llvm.loop !9

30:                                               ; preds = %8
  %31 = add nuw nsw i64 %5, 1
  %32 = icmp eq i64 %31, 500
  br i1 %32, label %33, label %4, !llvm.loop !13

33:                                               ; preds = %30
  %34 = getelementptr i8, ptr %3, i64 1000000
  %35 = getelementptr i8, ptr %3, i64 998004
  %36 = getelementptr i8, ptr %3, i64 2000
  br label %37

37:                                               ; preds = %33, %99
  %38 = phi i64 [ %100, %99 ], [ 0, %33 ]
  %39 = shl nuw nsw i64 %38, 2
  %40 = getelementptr i8, ptr %3, i64 %39
  %41 = getelementptr i8, ptr %35, i64 %39
  %42 = mul nuw nsw i64 %38, 2000
  %43 = getelementptr i8, ptr %3, i64 %42
  %44 = getelementptr i8, ptr %36, i64 %42
  %45 = icmp ult ptr %3, %41
  %46 = icmp ult ptr %40, %34
  %47 = and i1 %45, %46
  %48 = icmp ult ptr %3, %44
  %49 = icmp ult ptr %43, %34
  %50 = and i1 %48, %49
  %51 = or i1 %47, %50
  br label %52

52:                                               ; preds = %96, %37
  %53 = phi i64 [ 0, %37 ], [ %97, %96 ]
  %54 = getelementptr inbounds [500 x i32], ptr %3, i64 %53, i64 %38
  br i1 %51, label %75, label %55

55:                                               ; preds = %52
  %56 = load i32, ptr %54, align 4, !tbaa !5, !alias.scope !14
  %57 = insertelement <4 x i32> poison, i32 %56, i64 0
  %58 = shufflevector <4 x i32> %57, <4 x i32> poison, <4 x i32> zeroinitializer
  br label %59

59:                                               ; preds = %55, %59
  %60 = phi i64 [ %73, %59 ], [ 0, %55 ]
  %61 = getelementptr inbounds [500 x i32], ptr %3, i64 %53, i64 %60
  %62 = getelementptr inbounds i32, ptr %61, i64 4
  %63 = load <4 x i32>, ptr %61, align 4, !tbaa !5, !alias.scope !17, !noalias !19
  %64 = load <4 x i32>, ptr %62, align 4, !tbaa !5, !alias.scope !17, !noalias !19
  %65 = getelementptr inbounds [500 x i32], ptr %3, i64 %38, i64 %60
  %66 = getelementptr inbounds i32, ptr %65, i64 4
  %67 = load <4 x i32>, ptr %65, align 4, !tbaa !5, !alias.scope !21
  %68 = load <4 x i32>, ptr %66, align 4, !tbaa !5, !alias.scope !21
  %69 = add nsw <4 x i32> %67, %58
  %70 = add nsw <4 x i32> %68, %58
  %71 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %63, <4 x i32> %69)
  %72 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %64, <4 x i32> %70)
  store <4 x i32> %71, ptr %61, align 4, !tbaa !5, !alias.scope !17, !noalias !19
  store <4 x i32> %72, ptr %62, align 4, !tbaa !5, !alias.scope !17, !noalias !19
  %73 = add nuw i64 %60, 8
  %74 = icmp eq i64 %73, 496
  br i1 %74, label %75, label %59, !llvm.loop !22

75:                                               ; preds = %59, %52
  %76 = phi i64 [ 0, %52 ], [ 496, %59 ]
  br label %77

77:                                               ; preds = %77, %75
  %78 = phi i64 [ %76, %75 ], [ %94, %77 ]
  %79 = getelementptr inbounds [500 x i32], ptr %3, i64 %53, i64 %78
  %80 = load i32, ptr %79, align 4, !tbaa !5
  %81 = load i32, ptr %54, align 4, !tbaa !5
  %82 = getelementptr inbounds [500 x i32], ptr %3, i64 %38, i64 %78
  %83 = load i32, ptr %82, align 4, !tbaa !5
  %84 = add nsw i32 %83, %81
  %85 = tail call i32 @llvm.smin.i32(i32 %80, i32 %84)
  store i32 %85, ptr %79, align 4, !tbaa !5
  %86 = or disjoint i64 %78, 1
  %87 = getelementptr inbounds [500 x i32], ptr %3, i64 %53, i64 %86
  %88 = load i32, ptr %87, align 4, !tbaa !5
  %89 = load i32, ptr %54, align 4, !tbaa !5
  %90 = getelementptr inbounds [500 x i32], ptr %3, i64 %38, i64 %86
  %91 = load i32, ptr %90, align 4, !tbaa !5
  %92 = add nsw i32 %91, %89
  %93 = tail call i32 @llvm.smin.i32(i32 %88, i32 %92)
  store i32 %93, ptr %87, align 4, !tbaa !5
  %94 = add nuw nsw i64 %78, 2
  %95 = icmp eq i64 %94, 500
  br i1 %95, label %96, label %77, !llvm.loop !23

96:                                               ; preds = %77
  %97 = add nuw nsw i64 %53, 1
  %98 = icmp eq i64 %97, 500
  br i1 %98, label %99, label %52, !llvm.loop !24

99:                                               ; preds = %96
  %100 = add nuw nsw i64 %38, 1
  %101 = icmp eq i64 %100, 500
  br i1 %101, label %102, label %37, !llvm.loop !25

102:                                              ; preds = %99
  %103 = icmp sgt i32 %0, 42
  br i1 %103, label %104, label %140

104:                                              ; preds = %102
  %105 = load ptr, ptr %1, align 8, !tbaa !26
  %106 = load i8, ptr %105, align 1
  %107 = icmp eq i8 %106, 0
  br i1 %107, label %108, label %140

108:                                              ; preds = %104
  %109 = load ptr, ptr @stderr, align 8, !tbaa !26
  %110 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %109) #7
  %111 = load ptr, ptr @stderr, align 8, !tbaa !26
  %112 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %111, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %113

113:                                              ; preds = %132, %108
  %114 = phi i64 [ 0, %108 ], [ %133, %132 ]
  %115 = mul nuw nsw i64 %114, 500
  br label %116

116:                                              ; preds = %125, %113
  %117 = phi i64 [ 0, %113 ], [ %130, %125 ]
  %118 = add nuw nsw i64 %117, %115
  %119 = trunc i64 %118 to i32
  %120 = urem i32 %119, 20
  %121 = icmp eq i32 %120, 0
  br i1 %121, label %122, label %125

122:                                              ; preds = %116
  %123 = load ptr, ptr @stderr, align 8, !tbaa !26
  %124 = tail call i32 @fputc(i32 10, ptr %123)
  br label %125

125:                                              ; preds = %122, %116
  %126 = load ptr, ptr @stderr, align 8, !tbaa !26
  %127 = getelementptr inbounds [500 x i32], ptr %3, i64 %114, i64 %117
  %128 = load i32, ptr %127, align 4, !tbaa !5
  %129 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %126, ptr noundef nonnull @.str.5, i32 noundef %128) #7
  %130 = add nuw nsw i64 %117, 1
  %131 = icmp eq i64 %130, 500
  br i1 %131, label %132, label %116, !llvm.loop !28

132:                                              ; preds = %125
  %133 = add nuw nsw i64 %114, 1
  %134 = icmp eq i64 %133, 500
  br i1 %134, label %135, label %113, !llvm.loop !29

135:                                              ; preds = %132
  %136 = load ptr, ptr @stderr, align 8, !tbaa !26
  %137 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %136, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %138 = load ptr, ptr @stderr, align 8, !tbaa !26
  %139 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %138) #7
  br label %140

140:                                              ; preds = %135, %104, %102
  tail call void @free(ptr noundef nonnull %3) #6
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.smin.v4i32(<4 x i32>, <4 x i32>) #5

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nounwind }
attributes #7 = { cold }

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
!14 = !{!15}
!15 = distinct !{!15, !16}
!16 = distinct !{!16, !"LVerDomain"}
!17 = !{!18}
!18 = distinct !{!18, !16}
!19 = !{!15, !20}
!20 = distinct !{!20, !16}
!21 = !{!20}
!22 = distinct !{!22, !10, !11, !12}
!23 = distinct !{!23, !10, !11}
!24 = distinct !{!24, !10}
!25 = distinct !{!25, !10}
!26 = !{!27, !27, i64 0}
!27 = !{!"any pointer", !7, i64 0}
!28 = distinct !{!28, !10}
!29 = distinct !{!29, !10}
