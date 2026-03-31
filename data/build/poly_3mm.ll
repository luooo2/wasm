; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/kernels/3mm/3mm.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/kernels/3mm/3mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"G\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 34200, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 36000, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 38000, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 39900, i32 noundef 8) #6
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 41800, i32 noundef 8) #6
  %8 = tail call ptr @polybench_alloc_data(i64 noundef 46200, i32 noundef 8) #6
  %9 = tail call ptr @polybench_alloc_data(i64 noundef 37800, i32 noundef 8) #6
  br label %10

10:                                               ; preds = %2, %27
  %11 = phi i64 [ 0, %2 ], [ %28, %27 ]
  %12 = insertelement <2 x i64> poison, i64 %11, i64 0
  %13 = shufflevector <2 x i64> %12, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %14

14:                                               ; preds = %14, %10
  %15 = phi i64 [ 0, %10 ], [ %24, %14 ]
  %16 = phi <2 x i64> [ <i64 0, i64 1>, %10 ], [ %25, %14 ]
  %17 = mul nuw nsw <2 x i64> %16, %13
  %18 = trunc <2 x i64> %17 to <2 x i32>
  %19 = add <2 x i32> %18, <i32 1, i32 1>
  %20 = urem <2 x i32> %19, <i32 180, i32 180>
  %21 = sitofp <2 x i32> %20 to <2 x double>
  %22 = fdiv <2 x double> %21, <double 9.000000e+02, double 9.000000e+02>
  %23 = getelementptr inbounds [200 x double], ptr %4, i64 %11, i64 %15
  store <2 x double> %22, ptr %23, align 8, !tbaa !5
  %24 = add nuw i64 %15, 2
  %25 = add <2 x i64> %16, <i64 2, i64 2>
  %26 = icmp eq i64 %24, 200
  br i1 %26, label %27, label %14, !llvm.loop !9

27:                                               ; preds = %14
  %28 = add nuw nsw i64 %11, 1
  %29 = icmp eq i64 %28, 180
  br i1 %29, label %30, label %10, !llvm.loop !13

30:                                               ; preds = %27, %48
  %31 = phi i64 [ %49, %48 ], [ 0, %27 ]
  %32 = insertelement <2 x i64> poison, i64 %31, i64 0
  %33 = shufflevector <2 x i64> %32, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %34

34:                                               ; preds = %34, %30
  %35 = phi i64 [ 0, %30 ], [ %45, %34 ]
  %36 = phi <2 x i64> [ <i64 0, i64 1>, %30 ], [ %46, %34 ]
  %37 = add nuw nsw <2 x i64> %36, <i64 1, i64 1>
  %38 = mul nuw nsw <2 x i64> %37, %33
  %39 = trunc <2 x i64> %38 to <2 x i32>
  %40 = add <2 x i32> %39, <i32 2, i32 2>
  %41 = urem <2 x i32> %40, <i32 190, i32 190>
  %42 = sitofp <2 x i32> %41 to <2 x double>
  %43 = fdiv <2 x double> %42, <double 9.500000e+02, double 9.500000e+02>
  %44 = getelementptr inbounds [190 x double], ptr %5, i64 %31, i64 %35
  store <2 x double> %43, ptr %44, align 8, !tbaa !5
  %45 = add nuw i64 %35, 2
  %46 = add <2 x i64> %36, <i64 2, i64 2>
  %47 = icmp eq i64 %45, 190
  br i1 %47, label %48, label %34, !llvm.loop !14

48:                                               ; preds = %34
  %49 = add nuw nsw i64 %31, 1
  %50 = icmp eq i64 %49, 200
  br i1 %50, label %51, label %30, !llvm.loop !15

51:                                               ; preds = %48, %68
  %52 = phi i64 [ %69, %68 ], [ 0, %48 ]
  %53 = insertelement <2 x i64> poison, i64 %52, i64 0
  %54 = shufflevector <2 x i64> %53, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %55

55:                                               ; preds = %55, %51
  %56 = phi i64 [ 0, %51 ], [ %65, %55 ]
  %57 = phi <2 x i64> [ <i64 0, i64 1>, %51 ], [ %66, %55 ]
  %58 = add nuw nsw <2 x i64> %57, <i64 3, i64 3>
  %59 = mul nuw nsw <2 x i64> %58, %54
  %60 = trunc <2 x i64> %59 to <2 x i32>
  %61 = urem <2 x i32> %60, <i32 210, i32 210>
  %62 = sitofp <2 x i32> %61 to <2 x double>
  %63 = fdiv <2 x double> %62, <double 1.050000e+03, double 1.050000e+03>
  %64 = getelementptr inbounds [220 x double], ptr %7, i64 %52, i64 %56
  store <2 x double> %63, ptr %64, align 8, !tbaa !5
  %65 = add nuw i64 %56, 2
  %66 = add <2 x i64> %57, <i64 2, i64 2>
  %67 = icmp eq i64 %65, 220
  br i1 %67, label %68, label %55, !llvm.loop !16

68:                                               ; preds = %55
  %69 = add nuw nsw i64 %52, 1
  %70 = icmp eq i64 %69, 190
  br i1 %70, label %71, label %51, !llvm.loop !17

71:                                               ; preds = %68, %89
  %72 = phi i64 [ %90, %89 ], [ 0, %68 ]
  %73 = insertelement <2 x i64> poison, i64 %72, i64 0
  %74 = shufflevector <2 x i64> %73, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %75

75:                                               ; preds = %75, %71
  %76 = phi i64 [ 0, %71 ], [ %86, %75 ]
  %77 = phi <2 x i64> [ <i64 0, i64 1>, %71 ], [ %87, %75 ]
  %78 = add nuw nsw <2 x i64> %77, <i64 2, i64 2>
  %79 = mul nuw nsw <2 x i64> %78, %74
  %80 = trunc <2 x i64> %79 to <2 x i32>
  %81 = add <2 x i32> %80, <i32 2, i32 2>
  %82 = urem <2 x i32> %81, <i32 200, i32 200>
  %83 = sitofp <2 x i32> %82 to <2 x double>
  %84 = fdiv <2 x double> %83, <double 1.000000e+03, double 1.000000e+03>
  %85 = getelementptr inbounds [210 x double], ptr %8, i64 %72, i64 %76
  store <2 x double> %84, ptr %85, align 8, !tbaa !5
  %86 = add nuw i64 %76, 2
  %87 = add <2 x i64> %77, <i64 2, i64 2>
  %88 = icmp eq i64 %86, 210
  br i1 %88, label %89, label %75, !llvm.loop !18

89:                                               ; preds = %75
  %90 = add nuw nsw i64 %72, 1
  %91 = icmp eq i64 %90, 220
  br i1 %91, label %92, label %71, !llvm.loop !19

92:                                               ; preds = %89, %116
  %93 = phi i64 [ %117, %116 ], [ 0, %89 ]
  br label %94

94:                                               ; preds = %113, %92
  %95 = phi i64 [ 0, %92 ], [ %114, %113 ]
  %96 = getelementptr inbounds [190 x double], ptr %3, i64 %93, i64 %95
  store double 0.000000e+00, ptr %96, align 8, !tbaa !5
  br label %97

97:                                               ; preds = %97, %94
  %98 = phi i64 [ 0, %94 ], [ %111, %97 ]
  %99 = phi double [ 0.000000e+00, %94 ], [ %110, %97 ]
  %100 = getelementptr inbounds [200 x double], ptr %4, i64 %93, i64 %98
  %101 = load double, ptr %100, align 8, !tbaa !5
  %102 = getelementptr inbounds [190 x double], ptr %5, i64 %98, i64 %95
  %103 = load double, ptr %102, align 8, !tbaa !5
  %104 = tail call double @llvm.fmuladd.f64(double %101, double %103, double %99)
  store double %104, ptr %96, align 8, !tbaa !5
  %105 = or disjoint i64 %98, 1
  %106 = getelementptr inbounds [200 x double], ptr %4, i64 %93, i64 %105
  %107 = load double, ptr %106, align 8, !tbaa !5
  %108 = getelementptr inbounds [190 x double], ptr %5, i64 %105, i64 %95
  %109 = load double, ptr %108, align 8, !tbaa !5
  %110 = tail call double @llvm.fmuladd.f64(double %107, double %109, double %104)
  store double %110, ptr %96, align 8, !tbaa !5
  %111 = add nuw nsw i64 %98, 2
  %112 = icmp eq i64 %111, 200
  br i1 %112, label %113, label %97, !llvm.loop !20

113:                                              ; preds = %97
  %114 = add nuw nsw i64 %95, 1
  %115 = icmp eq i64 %114, 190
  br i1 %115, label %116, label %94, !llvm.loop !21

116:                                              ; preds = %113
  %117 = add nuw nsw i64 %93, 1
  %118 = icmp eq i64 %117, 180
  br i1 %118, label %119, label %92, !llvm.loop !22

119:                                              ; preds = %116, %143
  %120 = phi i64 [ %144, %143 ], [ 0, %116 ]
  br label %121

121:                                              ; preds = %140, %119
  %122 = phi i64 [ 0, %119 ], [ %141, %140 ]
  %123 = getelementptr inbounds [210 x double], ptr %6, i64 %120, i64 %122
  store double 0.000000e+00, ptr %123, align 8, !tbaa !5
  br label %124

124:                                              ; preds = %124, %121
  %125 = phi i64 [ 0, %121 ], [ %138, %124 ]
  %126 = phi double [ 0.000000e+00, %121 ], [ %137, %124 ]
  %127 = getelementptr inbounds [220 x double], ptr %7, i64 %120, i64 %125
  %128 = load double, ptr %127, align 8, !tbaa !5
  %129 = getelementptr inbounds [210 x double], ptr %8, i64 %125, i64 %122
  %130 = load double, ptr %129, align 8, !tbaa !5
  %131 = tail call double @llvm.fmuladd.f64(double %128, double %130, double %126)
  store double %131, ptr %123, align 8, !tbaa !5
  %132 = or disjoint i64 %125, 1
  %133 = getelementptr inbounds [220 x double], ptr %7, i64 %120, i64 %132
  %134 = load double, ptr %133, align 8, !tbaa !5
  %135 = getelementptr inbounds [210 x double], ptr %8, i64 %132, i64 %122
  %136 = load double, ptr %135, align 8, !tbaa !5
  %137 = tail call double @llvm.fmuladd.f64(double %134, double %136, double %131)
  store double %137, ptr %123, align 8, !tbaa !5
  %138 = add nuw nsw i64 %125, 2
  %139 = icmp eq i64 %138, 220
  br i1 %139, label %140, label %124, !llvm.loop !23

140:                                              ; preds = %124
  %141 = add nuw nsw i64 %122, 1
  %142 = icmp eq i64 %141, 210
  br i1 %142, label %143, label %121, !llvm.loop !24

143:                                              ; preds = %140
  %144 = add nuw nsw i64 %120, 1
  %145 = icmp eq i64 %144, 190
  br i1 %145, label %146, label %119, !llvm.loop !25

146:                                              ; preds = %143, %170
  %147 = phi i64 [ %171, %170 ], [ 0, %143 ]
  br label %148

148:                                              ; preds = %167, %146
  %149 = phi i64 [ 0, %146 ], [ %168, %167 ]
  %150 = getelementptr inbounds [210 x double], ptr %9, i64 %147, i64 %149
  store double 0.000000e+00, ptr %150, align 8, !tbaa !5
  br label %151

151:                                              ; preds = %151, %148
  %152 = phi i64 [ 0, %148 ], [ %165, %151 ]
  %153 = phi double [ 0.000000e+00, %148 ], [ %164, %151 ]
  %154 = getelementptr inbounds [190 x double], ptr %3, i64 %147, i64 %152
  %155 = load double, ptr %154, align 8, !tbaa !5
  %156 = getelementptr inbounds [210 x double], ptr %6, i64 %152, i64 %149
  %157 = load double, ptr %156, align 8, !tbaa !5
  %158 = tail call double @llvm.fmuladd.f64(double %155, double %157, double %153)
  store double %158, ptr %150, align 8, !tbaa !5
  %159 = or disjoint i64 %152, 1
  %160 = getelementptr inbounds [190 x double], ptr %3, i64 %147, i64 %159
  %161 = load double, ptr %160, align 8, !tbaa !5
  %162 = getelementptr inbounds [210 x double], ptr %6, i64 %159, i64 %149
  %163 = load double, ptr %162, align 8, !tbaa !5
  %164 = tail call double @llvm.fmuladd.f64(double %161, double %163, double %158)
  store double %164, ptr %150, align 8, !tbaa !5
  %165 = add nuw nsw i64 %152, 2
  %166 = icmp eq i64 %165, 190
  br i1 %166, label %167, label %151, !llvm.loop !26

167:                                              ; preds = %151
  %168 = add nuw nsw i64 %149, 1
  %169 = icmp eq i64 %168, 210
  br i1 %169, label %170, label %148, !llvm.loop !27

170:                                              ; preds = %167
  %171 = add nuw nsw i64 %147, 1
  %172 = icmp eq i64 %171, 180
  br i1 %172, label %173, label %146, !llvm.loop !28

173:                                              ; preds = %170
  %174 = icmp sgt i32 %0, 42
  br i1 %174, label %175, label %211

175:                                              ; preds = %173
  %176 = load ptr, ptr %1, align 8, !tbaa !29
  %177 = load i8, ptr %176, align 1
  %178 = icmp eq i8 %177, 0
  br i1 %178, label %179, label %211

179:                                              ; preds = %175
  %180 = load ptr, ptr @stderr, align 8, !tbaa !29
  %181 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %180) #7
  %182 = load ptr, ptr @stderr, align 8, !tbaa !29
  %183 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %182, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %184

184:                                              ; preds = %203, %179
  %185 = phi i64 [ 0, %179 ], [ %204, %203 ]
  %186 = mul nuw nsw i64 %185, 180
  br label %187

187:                                              ; preds = %196, %184
  %188 = phi i64 [ 0, %184 ], [ %201, %196 ]
  %189 = add nuw nsw i64 %188, %186
  %190 = trunc i64 %189 to i32
  %191 = urem i32 %190, 20
  %192 = icmp eq i32 %191, 0
  br i1 %192, label %193, label %196

193:                                              ; preds = %187
  %194 = load ptr, ptr @stderr, align 8, !tbaa !29
  %195 = tail call i32 @fputc(i32 10, ptr %194)
  br label %196

196:                                              ; preds = %193, %187
  %197 = load ptr, ptr @stderr, align 8, !tbaa !29
  %198 = getelementptr inbounds [210 x double], ptr %9, i64 %185, i64 %188
  %199 = load double, ptr %198, align 8, !tbaa !5
  %200 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %197, ptr noundef nonnull @.str.5, double noundef %199) #7
  %201 = add nuw nsw i64 %188, 1
  %202 = icmp eq i64 %201, 210
  br i1 %202, label %203, label %187, !llvm.loop !31

203:                                              ; preds = %196
  %204 = add nuw nsw i64 %185, 1
  %205 = icmp eq i64 %204, 180
  br i1 %205, label %206, label %184, !llvm.loop !32

206:                                              ; preds = %203
  %207 = load ptr, ptr @stderr, align 8, !tbaa !29
  %208 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %207, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %209 = load ptr, ptr @stderr, align 8, !tbaa !29
  %210 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %209) #7
  br label %211

211:                                              ; preds = %206, %175, %173
  tail call void @free(ptr noundef %3) #6
  tail call void @free(ptr noundef %4) #6
  tail call void @free(ptr noundef %5) #6
  tail call void @free(ptr noundef %6) #6
  tail call void @free(ptr noundef %7) #6
  tail call void @free(ptr noundef %8) #6
  tail call void @free(ptr noundef nonnull %9) #6
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

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
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
!19 = distinct !{!19, !10}
!20 = distinct !{!20, !10}
!21 = distinct !{!21, !10}
!22 = distinct !{!22, !10}
!23 = distinct !{!23, !10}
!24 = distinct !{!24, !10}
!25 = distinct !{!25, !10}
!26 = distinct !{!26, !10}
!27 = distinct !{!27, !10}
!28 = distinct !{!28, !10}
!29 = !{!30, !30, i64 0}
!30 = !{!"any pointer", !7, i64 0}
!31 = distinct !{!31, !10}
!32 = distinct !{!32, !10}
