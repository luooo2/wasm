; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm/gemm.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm/gemm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"C\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 44000, i32 noundef 8) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #7
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 52800, i32 noundef 8) #7
  br label %6

6:                                                ; preds = %2, %23
  %7 = phi i64 [ 0, %2 ], [ %24, %23 ]
  %8 = insertelement <2 x i64> poison, i64 %7, i64 0
  %9 = shufflevector <2 x i64> %8, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %10

10:                                               ; preds = %10, %6
  %11 = phi i64 [ 0, %6 ], [ %20, %10 ]
  %12 = phi <2 x i64> [ <i64 0, i64 1>, %6 ], [ %21, %10 ]
  %13 = mul nuw nsw <2 x i64> %12, %9
  %14 = trunc <2 x i64> %13 to <2 x i32>
  %15 = add <2 x i32> %14, <i32 1, i32 1>
  %16 = urem <2 x i32> %15, <i32 200, i32 200>
  %17 = sitofp <2 x i32> %16 to <2 x double>
  %18 = fdiv <2 x double> %17, <double 2.000000e+02, double 2.000000e+02>
  %19 = getelementptr inbounds [220 x double], ptr %3, i64 %7, i64 %11
  store <2 x double> %18, ptr %19, align 8, !tbaa !5
  %20 = add nuw i64 %11, 2
  %21 = add <2 x i64> %12, <i64 2, i64 2>
  %22 = icmp eq i64 %20, 220
  br i1 %22, label %23, label %10, !llvm.loop !9

23:                                               ; preds = %10
  %24 = add nuw nsw i64 %7, 1
  %25 = icmp eq i64 %24, 200
  br i1 %25, label %26, label %6, !llvm.loop !13

26:                                               ; preds = %23, %43
  %27 = phi i64 [ %44, %43 ], [ 0, %23 ]
  %28 = insertelement <2 x i64> poison, i64 %27, i64 0
  %29 = shufflevector <2 x i64> %28, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %30

30:                                               ; preds = %30, %26
  %31 = phi i64 [ 0, %26 ], [ %40, %30 ]
  %32 = phi <2 x i64> [ <i64 0, i64 1>, %26 ], [ %41, %30 ]
  %33 = add nuw nsw <2 x i64> %32, <i64 1, i64 1>
  %34 = mul nuw nsw <2 x i64> %33, %29
  %35 = trunc <2 x i64> %34 to <2 x i32>
  %36 = urem <2 x i32> %35, <i32 240, i32 240>
  %37 = sitofp <2 x i32> %36 to <2 x double>
  %38 = fdiv <2 x double> %37, <double 2.400000e+02, double 2.400000e+02>
  %39 = getelementptr inbounds [240 x double], ptr %4, i64 %27, i64 %31
  store <2 x double> %38, ptr %39, align 8, !tbaa !5
  %40 = add nuw i64 %31, 2
  %41 = add <2 x i64> %32, <i64 2, i64 2>
  %42 = icmp eq i64 %40, 240
  br i1 %42, label %43, label %30, !llvm.loop !14

43:                                               ; preds = %30
  %44 = add nuw nsw i64 %27, 1
  %45 = icmp eq i64 %44, 200
  br i1 %45, label %46, label %26, !llvm.loop !15

46:                                               ; preds = %43, %63
  %47 = phi i64 [ %64, %63 ], [ 0, %43 ]
  %48 = insertelement <2 x i64> poison, i64 %47, i64 0
  %49 = shufflevector <2 x i64> %48, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %50

50:                                               ; preds = %50, %46
  %51 = phi i64 [ 0, %46 ], [ %60, %50 ]
  %52 = phi <2 x i64> [ <i64 0, i64 1>, %46 ], [ %61, %50 ]
  %53 = add nuw nsw <2 x i64> %52, <i64 2, i64 2>
  %54 = mul nuw nsw <2 x i64> %53, %49
  %55 = trunc <2 x i64> %54 to <2 x i32>
  %56 = urem <2 x i32> %55, <i32 220, i32 220>
  %57 = sitofp <2 x i32> %56 to <2 x double>
  %58 = fdiv <2 x double> %57, <double 2.200000e+02, double 2.200000e+02>
  %59 = getelementptr inbounds [220 x double], ptr %5, i64 %47, i64 %51
  store <2 x double> %58, ptr %59, align 8, !tbaa !5
  %60 = add nuw i64 %51, 2
  %61 = add <2 x i64> %52, <i64 2, i64 2>
  %62 = icmp eq i64 %60, 220
  br i1 %62, label %63, label %50, !llvm.loop !16

63:                                               ; preds = %50
  %64 = add nuw nsw i64 %47, 1
  %65 = icmp eq i64 %64, 240
  br i1 %65, label %66, label %46, !llvm.loop !17

66:                                               ; preds = %63
  %67 = getelementptr i8, ptr %5, i64 422400
  %68 = getelementptr i8, ptr %3, i64 1760
  %69 = getelementptr i8, ptr %4, i64 1920
  br label %70

70:                                               ; preds = %66, %149
  %71 = phi i64 [ %150, %149 ], [ 0, %66 ]
  %72 = mul nuw nsw i64 %71, 1760
  %73 = getelementptr i8, ptr %3, i64 %72
  %74 = getelementptr i8, ptr %68, i64 %72
  %75 = mul nuw nsw i64 %71, 1920
  %76 = getelementptr i8, ptr %4, i64 %75
  %77 = getelementptr i8, ptr %69, i64 %75
  br label %78

78:                                               ; preds = %88, %70
  %79 = phi i64 [ 0, %70 ], [ %95, %88 ]
  %80 = getelementptr inbounds [220 x double], ptr %3, i64 %71, i64 %79
  %81 = getelementptr inbounds double, ptr %80, i64 2
  %82 = load <2 x double>, ptr %80, align 8, !tbaa !5
  %83 = load <2 x double>, ptr %81, align 8, !tbaa !5
  %84 = fmul <2 x double> %82, <double 1.200000e+00, double 1.200000e+00>
  %85 = fmul <2 x double> %83, <double 1.200000e+00, double 1.200000e+00>
  store <2 x double> %84, ptr %80, align 8, !tbaa !5
  store <2 x double> %85, ptr %81, align 8, !tbaa !5
  %86 = or disjoint i64 %79, 4
  %87 = icmp eq i64 %86, 220
  br i1 %87, label %96, label %88, !llvm.loop !18

88:                                               ; preds = %78
  %89 = getelementptr inbounds [220 x double], ptr %3, i64 %71, i64 %86
  %90 = getelementptr inbounds double, ptr %89, i64 2
  %91 = load <2 x double>, ptr %89, align 8, !tbaa !5
  %92 = load <2 x double>, ptr %90, align 8, !tbaa !5
  %93 = fmul <2 x double> %91, <double 1.200000e+00, double 1.200000e+00>
  %94 = fmul <2 x double> %92, <double 1.200000e+00, double 1.200000e+00>
  store <2 x double> %93, ptr %89, align 8, !tbaa !5
  store <2 x double> %94, ptr %90, align 8, !tbaa !5
  %95 = add nuw nsw i64 %79, 8
  br label %78

96:                                               ; preds = %78
  %97 = icmp ult ptr %73, %77
  %98 = icmp ult ptr %76, %74
  %99 = and i1 %97, %98
  %100 = icmp ult ptr %73, %67
  %101 = icmp ult ptr %5, %74
  %102 = and i1 %100, %101
  %103 = or i1 %99, %102
  br label %104

104:                                              ; preds = %96, %146
  %105 = phi i64 [ %147, %146 ], [ 0, %96 ]
  %106 = getelementptr inbounds [240 x double], ptr %4, i64 %71, i64 %105
  br i1 %103, label %127, label %107

107:                                              ; preds = %104
  %108 = load double, ptr %106, align 8, !tbaa !5, !alias.scope !19
  %109 = insertelement <2 x double> poison, double %108, i64 0
  %110 = shufflevector <2 x double> %109, <2 x double> poison, <2 x i32> zeroinitializer
  %111 = fmul <2 x double> %110, <double 1.500000e+00, double 1.500000e+00>
  %112 = fmul <2 x double> %110, <double 1.500000e+00, double 1.500000e+00>
  br label %113

113:                                              ; preds = %107, %113
  %114 = phi i64 [ %125, %113 ], [ 0, %107 ]
  %115 = getelementptr inbounds [220 x double], ptr %5, i64 %105, i64 %114
  %116 = getelementptr inbounds double, ptr %115, i64 2
  %117 = load <2 x double>, ptr %115, align 8, !tbaa !5, !alias.scope !22
  %118 = load <2 x double>, ptr %116, align 8, !tbaa !5, !alias.scope !22
  %119 = getelementptr inbounds [220 x double], ptr %3, i64 %71, i64 %114
  %120 = getelementptr inbounds double, ptr %119, i64 2
  %121 = load <2 x double>, ptr %119, align 8, !tbaa !5, !alias.scope !24, !noalias !26
  %122 = load <2 x double>, ptr %120, align 8, !tbaa !5, !alias.scope !24, !noalias !26
  %123 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %111, <2 x double> %117, <2 x double> %121)
  %124 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %112, <2 x double> %118, <2 x double> %122)
  store <2 x double> %123, ptr %119, align 8, !tbaa !5, !alias.scope !24, !noalias !26
  store <2 x double> %124, ptr %120, align 8, !tbaa !5, !alias.scope !24, !noalias !26
  %125 = add nuw i64 %114, 4
  %126 = icmp eq i64 %125, 220
  br i1 %126, label %146, label %113, !llvm.loop !27

127:                                              ; preds = %104, %127
  %128 = phi i64 [ %144, %127 ], [ 0, %104 ]
  %129 = load double, ptr %106, align 8, !tbaa !5
  %130 = fmul double %129, 1.500000e+00
  %131 = getelementptr inbounds [220 x double], ptr %5, i64 %105, i64 %128
  %132 = load double, ptr %131, align 8, !tbaa !5
  %133 = getelementptr inbounds [220 x double], ptr %3, i64 %71, i64 %128
  %134 = load double, ptr %133, align 8, !tbaa !5
  %135 = tail call double @llvm.fmuladd.f64(double %130, double %132, double %134)
  store double %135, ptr %133, align 8, !tbaa !5
  %136 = or disjoint i64 %128, 1
  %137 = load double, ptr %106, align 8, !tbaa !5
  %138 = fmul double %137, 1.500000e+00
  %139 = getelementptr inbounds [220 x double], ptr %5, i64 %105, i64 %136
  %140 = load double, ptr %139, align 8, !tbaa !5
  %141 = getelementptr inbounds [220 x double], ptr %3, i64 %71, i64 %136
  %142 = load double, ptr %141, align 8, !tbaa !5
  %143 = tail call double @llvm.fmuladd.f64(double %138, double %140, double %142)
  store double %143, ptr %141, align 8, !tbaa !5
  %144 = add nuw nsw i64 %128, 2
  %145 = icmp eq i64 %144, 220
  br i1 %145, label %146, label %127, !llvm.loop !28

146:                                              ; preds = %113, %127
  %147 = add nuw nsw i64 %105, 1
  %148 = icmp eq i64 %147, 240
  br i1 %148, label %149, label %104, !llvm.loop !29

149:                                              ; preds = %146
  %150 = add nuw nsw i64 %71, 1
  %151 = icmp eq i64 %150, 200
  br i1 %151, label %152, label %70, !llvm.loop !30

152:                                              ; preds = %149
  %153 = icmp sgt i32 %0, 42
  br i1 %153, label %154, label %190

154:                                              ; preds = %152
  %155 = load ptr, ptr %1, align 8, !tbaa !31
  %156 = load i8, ptr %155, align 1
  %157 = icmp eq i8 %156, 0
  br i1 %157, label %158, label %190

158:                                              ; preds = %154
  %159 = load ptr, ptr @stderr, align 8, !tbaa !31
  %160 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %159) #8
  %161 = load ptr, ptr @stderr, align 8, !tbaa !31
  %162 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %161, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %163

163:                                              ; preds = %182, %158
  %164 = phi i64 [ 0, %158 ], [ %183, %182 ]
  %165 = mul nuw nsw i64 %164, 200
  br label %166

166:                                              ; preds = %175, %163
  %167 = phi i64 [ 0, %163 ], [ %180, %175 ]
  %168 = add nuw nsw i64 %167, %165
  %169 = trunc i64 %168 to i32
  %170 = urem i32 %169, 20
  %171 = icmp eq i32 %170, 0
  br i1 %171, label %172, label %175

172:                                              ; preds = %166
  %173 = load ptr, ptr @stderr, align 8, !tbaa !31
  %174 = tail call i32 @fputc(i32 10, ptr %173)
  br label %175

175:                                              ; preds = %172, %166
  %176 = load ptr, ptr @stderr, align 8, !tbaa !31
  %177 = getelementptr inbounds [220 x double], ptr %3, i64 %164, i64 %167
  %178 = load double, ptr %177, align 8, !tbaa !5
  %179 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %176, ptr noundef nonnull @.str.5, double noundef %178) #8
  %180 = add nuw nsw i64 %167, 1
  %181 = icmp eq i64 %180, 220
  br i1 %181, label %182, label %166, !llvm.loop !33

182:                                              ; preds = %175
  %183 = add nuw nsw i64 %164, 1
  %184 = icmp eq i64 %183, 200
  br i1 %184, label %185, label %163, !llvm.loop !34

185:                                              ; preds = %182
  %186 = load ptr, ptr @stderr, align 8, !tbaa !31
  %187 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %186, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %188 = load ptr, ptr @stderr, align 8, !tbaa !31
  %189 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %188) #8
  br label %190

190:                                              ; preds = %185, %154, %152
  tail call void @free(ptr noundef nonnull %3) #7
  tail call void @free(ptr noundef %4) #7
  tail call void @free(ptr noundef %5) #7
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
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
!6 = !{!"double", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10, !11, !12}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.isvectorized", i32 1}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
!13 = distinct !{!13, !10}
!14 = distinct !{!14, !10, !11, !12}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10, !11, !12}
!17 = distinct !{!17, !10}
!18 = distinct !{!18, !10, !11, !12}
!19 = !{!20}
!20 = distinct !{!20, !21}
!21 = distinct !{!21, !"LVerDomain"}
!22 = !{!23}
!23 = distinct !{!23, !21}
!24 = !{!25}
!25 = distinct !{!25, !21}
!26 = !{!20, !23}
!27 = distinct !{!27, !10, !11, !12}
!28 = distinct !{!28, !10, !11}
!29 = distinct !{!29, !10}
!30 = distinct !{!30, !10}
!31 = !{!32, !32, i64 0}
!32 = !{!"any pointer", !7, i64 0}
!33 = distinct !{!33, !10}
!34 = distinct !{!34, !10}
