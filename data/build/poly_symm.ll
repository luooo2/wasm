; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/blas/symm/symm.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/blas/symm/symm.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #6
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 40000, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #6
  %7 = ptrtoint ptr %6 to i64
  %8 = sub i64 %7, %4
  %9 = icmp ult i64 %8, 16
  br label %10

10:                                               ; preds = %52, %2
  %11 = phi i64 [ 0, %2 ], [ %53, %52 ]
  %12 = add nuw nsw i64 %11, 240
  br i1 %9, label %36, label %13

13:                                               ; preds = %10
  %14 = insertelement <2 x i64> poison, i64 %11, i64 0
  %15 = shufflevector <2 x i64> %14, <2 x i64> poison, <2 x i32> zeroinitializer
  %16 = insertelement <2 x i64> poison, i64 %12, i64 0
  %17 = shufflevector <2 x i64> %16, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %18

18:                                               ; preds = %18, %13
  %19 = phi i64 [ 0, %13 ], [ %33, %18 ]
  %20 = phi <2 x i64> [ <i64 0, i64 1>, %13 ], [ %34, %18 ]
  %21 = add nuw nsw <2 x i64> %20, %15
  %22 = trunc <2 x i64> %21 to <2 x i32>
  %23 = urem <2 x i32> %22, <i32 100, i32 100>
  %24 = sitofp <2 x i32> %23 to <2 x double>
  %25 = fdiv <2 x double> %24, <double 2.000000e+02, double 2.000000e+02>
  %26 = getelementptr inbounds [240 x double], ptr %3, i64 %11, i64 %19
  store <2 x double> %25, ptr %26, align 8, !tbaa !5
  %27 = sub nuw nsw <2 x i64> %17, %20
  %28 = trunc <2 x i64> %27 to <2 x i32>
  %29 = urem <2 x i32> %28, <i32 100, i32 100>
  %30 = sitofp <2 x i32> %29 to <2 x double>
  %31 = fdiv <2 x double> %30, <double 2.000000e+02, double 2.000000e+02>
  %32 = getelementptr inbounds [240 x double], ptr %6, i64 %11, i64 %19
  store <2 x double> %31, ptr %32, align 8, !tbaa !5
  %33 = add nuw i64 %19, 2
  %34 = add <2 x i64> %20, <i64 2, i64 2>
  %35 = icmp eq i64 %33, 240
  br i1 %35, label %52, label %18, !llvm.loop !9

36:                                               ; preds = %10, %36
  %37 = phi i64 [ %50, %36 ], [ 0, %10 ]
  %38 = add nuw nsw i64 %37, %11
  %39 = trunc i64 %38 to i32
  %40 = urem i32 %39, 100
  %41 = sitofp i32 %40 to double
  %42 = fdiv double %41, 2.000000e+02
  %43 = getelementptr inbounds [240 x double], ptr %3, i64 %11, i64 %37
  store double %42, ptr %43, align 8, !tbaa !5
  %44 = sub nuw nsw i64 %12, %37
  %45 = trunc i64 %44 to i32
  %46 = urem i32 %45, 100
  %47 = sitofp i32 %46 to double
  %48 = fdiv double %47, 2.000000e+02
  %49 = getelementptr inbounds [240 x double], ptr %6, i64 %11, i64 %37
  store double %48, ptr %49, align 8, !tbaa !5
  %50 = add nuw nsw i64 %37, 1
  %51 = icmp eq i64 %50, 240
  br i1 %51, label %52, label %36, !llvm.loop !13

52:                                               ; preds = %18, %36
  %53 = add nuw nsw i64 %11, 1
  %54 = icmp eq i64 %53, 200
  br i1 %54, label %58, label %10, !llvm.loop !14

55:                                               ; preds = %112, %108, %93
  %56 = add nuw nsw i64 %60, 1
  %57 = icmp eq i64 %94, 200
  br i1 %57, label %117, label %58, !llvm.loop !15

58:                                               ; preds = %52, %55
  %59 = phi i64 [ %94, %55 ], [ 0, %52 ]
  %60 = phi i64 [ %56, %55 ], [ 1, %52 ]
  %61 = sub nsw i64 199, %59
  %62 = icmp ult i64 %60, 2
  br i1 %62, label %81, label %63

63:                                               ; preds = %58
  %64 = and i64 %60, 9223372036854775806
  %65 = insertelement <2 x i64> poison, i64 %59, i64 0
  %66 = shufflevector <2 x i64> %65, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %67

67:                                               ; preds = %67, %63
  %68 = phi i64 [ 0, %63 ], [ %76, %67 ]
  %69 = phi <2 x i64> [ <i64 0, i64 1>, %63 ], [ %77, %67 ]
  %70 = add nuw nsw <2 x i64> %69, %66
  %71 = trunc <2 x i64> %70 to <2 x i32>
  %72 = urem <2 x i32> %71, <i32 100, i32 100>
  %73 = sitofp <2 x i32> %72 to <2 x double>
  %74 = fdiv <2 x double> %73, <double 2.000000e+02, double 2.000000e+02>
  %75 = getelementptr inbounds [200 x double], ptr %5, i64 %59, i64 %68
  store <2 x double> %74, ptr %75, align 8, !tbaa !5
  %76 = add nuw i64 %68, 2
  %77 = add <2 x i64> %69, <i64 2, i64 2>
  %78 = icmp eq i64 %76, %64
  br i1 %78, label %79, label %67, !llvm.loop !16

79:                                               ; preds = %67
  %80 = icmp eq i64 %60, %64
  br i1 %80, label %93, label %81

81:                                               ; preds = %58, %79
  %82 = phi i64 [ 0, %58 ], [ %64, %79 ]
  br label %83

83:                                               ; preds = %81, %83
  %84 = phi i64 [ %91, %83 ], [ %82, %81 ]
  %85 = add nuw nsw i64 %84, %59
  %86 = trunc i64 %85 to i32
  %87 = urem i32 %86, 100
  %88 = sitofp i32 %87 to double
  %89 = fdiv double %88, 2.000000e+02
  %90 = getelementptr inbounds [200 x double], ptr %5, i64 %59, i64 %84
  store double %89, ptr %90, align 8, !tbaa !5
  %91 = add nuw nsw i64 %84, 1
  %92 = icmp eq i64 %91, %60
  br i1 %92, label %93, label %83, !llvm.loop !17

93:                                               ; preds = %83, %79
  %94 = add nuw nsw i64 %59, 1
  %95 = icmp ult i64 %59, 199
  br i1 %95, label %96, label %55

96:                                               ; preds = %93
  %97 = icmp ult i64 %61, 4
  br i1 %97, label %110, label %98

98:                                               ; preds = %96
  %99 = and i64 %61, -4
  %100 = add i64 %60, %99
  br label %101

101:                                              ; preds = %101, %98
  %102 = phi i64 [ 0, %98 ], [ %106, %101 ]
  %103 = add i64 %60, %102
  %104 = getelementptr inbounds [200 x double], ptr %5, i64 %59, i64 %103
  %105 = getelementptr inbounds double, ptr %104, i64 2
  store <2 x double> <double -9.990000e+02, double -9.990000e+02>, ptr %104, align 8, !tbaa !5
  store <2 x double> <double -9.990000e+02, double -9.990000e+02>, ptr %105, align 8, !tbaa !5
  %106 = add nuw i64 %102, 4
  %107 = icmp eq i64 %106, %99
  br i1 %107, label %108, label %101, !llvm.loop !18

108:                                              ; preds = %101
  %109 = icmp eq i64 %61, %99
  br i1 %109, label %55, label %110

110:                                              ; preds = %96, %108
  %111 = phi i64 [ %60, %96 ], [ %100, %108 ]
  br label %112

112:                                              ; preds = %110, %112
  %113 = phi i64 [ %115, %112 ], [ %111, %110 ]
  %114 = getelementptr inbounds [200 x double], ptr %5, i64 %59, i64 %113
  store double -9.990000e+02, ptr %114, align 8, !tbaa !5
  %115 = add nuw nsw i64 %113, 1
  %116 = icmp eq i64 %115, 200
  br i1 %116, label %55, label %112, !llvm.loop !19

117:                                              ; preds = %55, %154
  %118 = phi i64 [ %155, %154 ], [ 0, %55 ]
  %119 = icmp eq i64 %118, 0
  %120 = getelementptr inbounds [200 x double], ptr %5, i64 %118, i64 %118
  br label %121

121:                                              ; preds = %141, %117
  %122 = phi i64 [ 0, %117 ], [ %152, %141 ]
  br i1 %119, label %141, label %123

123:                                              ; preds = %121
  %124 = getelementptr inbounds [240 x double], ptr %6, i64 %118, i64 %122
  br label %125

125:                                              ; preds = %125, %123
  %126 = phi i64 [ 0, %123 ], [ %139, %125 ]
  %127 = phi double [ 0.000000e+00, %123 ], [ %138, %125 ]
  %128 = load double, ptr %124, align 8, !tbaa !5
  %129 = fmul double %128, 1.500000e+00
  %130 = getelementptr inbounds [200 x double], ptr %5, i64 %118, i64 %126
  %131 = load double, ptr %130, align 8, !tbaa !5
  %132 = getelementptr inbounds [240 x double], ptr %3, i64 %126, i64 %122
  %133 = load double, ptr %132, align 8, !tbaa !5
  %134 = tail call double @llvm.fmuladd.f64(double %129, double %131, double %133)
  store double %134, ptr %132, align 8, !tbaa !5
  %135 = getelementptr inbounds [240 x double], ptr %6, i64 %126, i64 %122
  %136 = load double, ptr %135, align 8, !tbaa !5
  %137 = load double, ptr %130, align 8, !tbaa !5
  %138 = tail call double @llvm.fmuladd.f64(double %136, double %137, double %127)
  %139 = add nuw nsw i64 %126, 1
  %140 = icmp eq i64 %139, %118
  br i1 %140, label %141, label %125, !llvm.loop !20

141:                                              ; preds = %125, %121
  %142 = phi double [ 0.000000e+00, %121 ], [ %138, %125 ]
  %143 = getelementptr inbounds [240 x double], ptr %3, i64 %118, i64 %122
  %144 = load double, ptr %143, align 8, !tbaa !5
  %145 = getelementptr inbounds [240 x double], ptr %6, i64 %118, i64 %122
  %146 = load double, ptr %145, align 8, !tbaa !5
  %147 = fmul double %146, 1.500000e+00
  %148 = load double, ptr %120, align 8, !tbaa !5
  %149 = fmul double %147, %148
  %150 = tail call double @llvm.fmuladd.f64(double %144, double 1.200000e+00, double %149)
  %151 = tail call double @llvm.fmuladd.f64(double %142, double 1.500000e+00, double %150)
  store double %151, ptr %143, align 8, !tbaa !5
  %152 = add nuw nsw i64 %122, 1
  %153 = icmp eq i64 %152, 240
  br i1 %153, label %154, label %121, !llvm.loop !21

154:                                              ; preds = %141
  %155 = add nuw nsw i64 %118, 1
  %156 = icmp eq i64 %155, 200
  br i1 %156, label %157, label %117, !llvm.loop !22

157:                                              ; preds = %154
  %158 = icmp sgt i32 %0, 42
  br i1 %158, label %159, label %195

159:                                              ; preds = %157
  %160 = load ptr, ptr %1, align 8, !tbaa !23
  %161 = load i8, ptr %160, align 1
  %162 = icmp eq i8 %161, 0
  br i1 %162, label %163, label %195

163:                                              ; preds = %159
  %164 = load ptr, ptr @stderr, align 8, !tbaa !23
  %165 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %164) #7
  %166 = load ptr, ptr @stderr, align 8, !tbaa !23
  %167 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %166, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %168

168:                                              ; preds = %187, %163
  %169 = phi i64 [ 0, %163 ], [ %188, %187 ]
  %170 = mul nuw nsw i64 %169, 200
  br label %171

171:                                              ; preds = %180, %168
  %172 = phi i64 [ 0, %168 ], [ %185, %180 ]
  %173 = add nuw nsw i64 %172, %170
  %174 = trunc i64 %173 to i32
  %175 = urem i32 %174, 20
  %176 = icmp eq i32 %175, 0
  br i1 %176, label %177, label %180

177:                                              ; preds = %171
  %178 = load ptr, ptr @stderr, align 8, !tbaa !23
  %179 = tail call i32 @fputc(i32 10, ptr %178)
  br label %180

180:                                              ; preds = %177, %171
  %181 = load ptr, ptr @stderr, align 8, !tbaa !23
  %182 = getelementptr inbounds [240 x double], ptr %3, i64 %169, i64 %172
  %183 = load double, ptr %182, align 8, !tbaa !5
  %184 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %181, ptr noundef nonnull @.str.5, double noundef %183) #7
  %185 = add nuw nsw i64 %172, 1
  %186 = icmp eq i64 %185, 240
  br i1 %186, label %187, label %171, !llvm.loop !25

187:                                              ; preds = %180
  %188 = add nuw nsw i64 %169, 1
  %189 = icmp eq i64 %188, 200
  br i1 %189, label %190, label %168, !llvm.loop !26

190:                                              ; preds = %187
  %191 = load ptr, ptr @stderr, align 8, !tbaa !23
  %192 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %191, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %193 = load ptr, ptr @stderr, align 8, !tbaa !23
  %194 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %193) #7
  br label %195

195:                                              ; preds = %190, %159, %157
  tail call void @free(ptr noundef nonnull %3) #6
  tail call void @free(ptr noundef %5) #6
  tail call void @free(ptr noundef %6) #6
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
!13 = distinct !{!13, !10, !11}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10, !11, !12}
!17 = distinct !{!17, !10, !12, !11}
!18 = distinct !{!18, !10, !11, !12}
!19 = distinct !{!19, !10, !12, !11}
!20 = distinct !{!20, !10}
!21 = distinct !{!21, !10}
!22 = distinct !{!22, !10}
!23 = !{!24, !24, i64 0}
!24 = !{!"any pointer", !7, i64 0}
!25 = distinct !{!25, !10}
!26 = distinct !{!26, !10}
