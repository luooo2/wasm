; ModuleID = 'data/polybench-c-4.2.1-beta/stencils/heat-3d/heat-3d.c'
source_filename = "data/polybench-c-4.2.1-beta/stencils/heat-3d/heat-3d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 64000, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 64000, i32 noundef 8) #7
  %6 = ptrtoint ptr %5 to i64
  %7 = sub i64 %4, %6
  %8 = icmp ult i64 %7, 16
  br label %9

9:                                                ; preds = %62, %2
  %10 = phi i64 [ 0, %2 ], [ %63, %62 ]
  %11 = add nuw nsw i64 %10, 40
  br label %12

12:                                               ; preds = %59, %9
  %13 = phi i64 [ 0, %9 ], [ %60, %59 ]
  %14 = add nuw nsw i64 %11, %13
  br i1 %8, label %40, label %15

15:                                               ; preds = %12
  %16 = insertelement <2 x i64> poison, i64 %14, i64 0
  %17 = shufflevector <2 x i64> %16, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %18

18:                                               ; preds = %18, %15
  %19 = phi i64 [ 0, %15 ], [ %37, %18 ]
  %20 = phi <2 x i64> [ <i64 0, i64 1>, %15 ], [ %38, %18 ]
  %21 = sub nuw nsw <2 x i64> %17, %20
  %22 = trunc <2 x i64> %21 to <2 x i32>
  %23 = sitofp <2 x i32> %22 to <2 x double>
  %24 = fmul <2 x double> %23, <double 1.000000e+01, double 1.000000e+01>
  %25 = fdiv <2 x double> %24, <double 4.000000e+01, double 4.000000e+01>
  %26 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %10, i64 %13, i64 %19
  store <2 x double> %25, ptr %26, align 8, !tbaa !5
  %27 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %10, i64 %13, i64 %19
  store <2 x double> %25, ptr %27, align 8, !tbaa !5
  %28 = or disjoint i64 %19, 2
  %29 = add <2 x i64> %20, <i64 2, i64 2>
  %30 = sub nuw nsw <2 x i64> %17, %29
  %31 = trunc <2 x i64> %30 to <2 x i32>
  %32 = sitofp <2 x i32> %31 to <2 x double>
  %33 = fmul <2 x double> %32, <double 1.000000e+01, double 1.000000e+01>
  %34 = fdiv <2 x double> %33, <double 4.000000e+01, double 4.000000e+01>
  %35 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %10, i64 %13, i64 %28
  store <2 x double> %34, ptr %35, align 8, !tbaa !5
  %36 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %10, i64 %13, i64 %28
  store <2 x double> %34, ptr %36, align 8, !tbaa !5
  %37 = add nuw nsw i64 %19, 4
  %38 = add <2 x i64> %20, <i64 4, i64 4>
  %39 = icmp eq i64 %37, 40
  br i1 %39, label %59, label %18, !llvm.loop !9

40:                                               ; preds = %12, %40
  %41 = phi i64 [ %57, %40 ], [ 0, %12 ]
  %42 = sub nuw nsw i64 %14, %41
  %43 = trunc i64 %42 to i32
  %44 = sitofp i32 %43 to double
  %45 = fmul double %44, 1.000000e+01
  %46 = fdiv double %45, 4.000000e+01
  %47 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %10, i64 %13, i64 %41
  store double %46, ptr %47, align 8, !tbaa !5
  %48 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %10, i64 %13, i64 %41
  store double %46, ptr %48, align 8, !tbaa !5
  %49 = or disjoint i64 %41, 1
  %50 = sub nuw nsw i64 %14, %49
  %51 = trunc i64 %50 to i32
  %52 = sitofp i32 %51 to double
  %53 = fmul double %52, 1.000000e+01
  %54 = fdiv double %53, 4.000000e+01
  %55 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %10, i64 %13, i64 %49
  store double %54, ptr %55, align 8, !tbaa !5
  %56 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %10, i64 %13, i64 %49
  store double %54, ptr %56, align 8, !tbaa !5
  %57 = add nuw nsw i64 %41, 2
  %58 = icmp eq i64 %57, 40
  br i1 %58, label %59, label %40, !llvm.loop !13

59:                                               ; preds = %18, %40
  %60 = add nuw nsw i64 %13, 1
  %61 = icmp eq i64 %60, 40
  br i1 %61, label %62, label %12, !llvm.loop !14

62:                                               ; preds = %59
  %63 = add nuw nsw i64 %10, 1
  %64 = icmp eq i64 %63, 40
  br i1 %64, label %65, label %9, !llvm.loop !15

65:                                               ; preds = %62
  %66 = getelementptr i8, ptr %5, i64 13128
  %67 = getelementptr i8, ptr %5, i64 25272
  %68 = getelementptr i8, ptr %3, i64 38072
  %69 = getelementptr i8, ptr %3, i64 13128
  %70 = getelementptr i8, ptr %3, i64 25272
  %71 = getelementptr i8, ptr %5, i64 38072
  br label %72

72:                                               ; preds = %65, %242
  %73 = phi i32 [ %243, %242 ], [ 1, %65 ]
  br label %74

74:                                               ; preds = %154, %72
  %75 = phi i64 [ %157, %154 ], [ 0, %72 ]
  %76 = phi i64 [ %155, %154 ], [ 1, %72 ]
  %77 = mul nuw nsw i64 %75, 12800
  %78 = getelementptr i8, ptr %66, i64 %77
  %79 = getelementptr i8, ptr %67, i64 %77
  %80 = or disjoint i64 %77, 328
  %81 = getelementptr i8, ptr %3, i64 %80
  %82 = getelementptr i8, ptr %68, i64 %77
  %83 = getelementptr [40 x [40 x double]], ptr %3, i64 %76
  %84 = icmp ult ptr %78, %82
  %85 = icmp ult ptr %81, %79
  %86 = and i1 %84, %85
  br label %87

87:                                               ; preds = %152, %74
  %88 = phi i64 [ 1, %74 ], [ %89, %152 ]
  %89 = add nuw nsw i64 %88, 1
  %90 = add nsw i64 %88, -1
  br i1 %86, label %122, label %91

91:                                               ; preds = %87, %91
  %92 = phi i64 [ %120, %91 ], [ 0, %87 ]
  %93 = or disjoint i64 %92, 1
  %94 = getelementptr [40 x [40 x double]], ptr %83, i64 1, i64 %88, i64 %93
  %95 = load <2 x double>, ptr %94, align 8, !tbaa !5, !alias.scope !16
  %96 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %88, i64 %93
  %97 = load <2 x double>, ptr %96, align 8, !tbaa !5, !alias.scope !16
  %98 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %97, <2 x double> <double -2.000000e+00, double -2.000000e+00>, <2 x double> %95)
  %99 = getelementptr [40 x [40 x double]], ptr %83, i64 -1, i64 %88, i64 %93
  %100 = load <2 x double>, ptr %99, align 8, !tbaa !5, !alias.scope !16
  %101 = fadd <2 x double> %98, %100
  %102 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %89, i64 %93
  %103 = load <2 x double>, ptr %102, align 8, !tbaa !5, !alias.scope !16
  %104 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %97, <2 x double> <double -2.000000e+00, double -2.000000e+00>, <2 x double> %103)
  %105 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %90, i64 %93
  %106 = load <2 x double>, ptr %105, align 8, !tbaa !5, !alias.scope !16
  %107 = fadd <2 x double> %104, %106
  %108 = fmul <2 x double> %107, <double 1.250000e-01, double 1.250000e-01>
  %109 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %101, <2 x double> <double 1.250000e-01, double 1.250000e-01>, <2 x double> %108)
  %110 = add i64 %92, 2
  %111 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %88, i64 %110
  %112 = load <2 x double>, ptr %111, align 8, !tbaa !5, !alias.scope !16
  %113 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %97, <2 x double> <double -2.000000e+00, double -2.000000e+00>, <2 x double> %112)
  %114 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %88, i64 %92
  %115 = load <2 x double>, ptr %114, align 8, !tbaa !5, !alias.scope !16
  %116 = fadd <2 x double> %113, %115
  %117 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %116, <2 x double> <double 1.250000e-01, double 1.250000e-01>, <2 x double> %109)
  %118 = fadd <2 x double> %97, %117
  %119 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %76, i64 %88, i64 %93
  store <2 x double> %118, ptr %119, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  %120 = add nuw i64 %92, 2
  %121 = icmp eq i64 %120, 38
  br i1 %121, label %152, label %91, !llvm.loop !21

122:                                              ; preds = %87, %122
  %123 = phi i64 [ %140, %122 ], [ 1, %87 ]
  %124 = getelementptr [40 x [40 x double]], ptr %83, i64 1, i64 %88, i64 %123
  %125 = load double, ptr %124, align 8, !tbaa !5
  %126 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %88, i64 %123
  %127 = load double, ptr %126, align 8, !tbaa !5
  %128 = tail call double @llvm.fmuladd.f64(double %127, double -2.000000e+00, double %125)
  %129 = getelementptr [40 x [40 x double]], ptr %83, i64 -1, i64 %88, i64 %123
  %130 = load double, ptr %129, align 8, !tbaa !5
  %131 = fadd double %128, %130
  %132 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %89, i64 %123
  %133 = load double, ptr %132, align 8, !tbaa !5
  %134 = tail call double @llvm.fmuladd.f64(double %127, double -2.000000e+00, double %133)
  %135 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %90, i64 %123
  %136 = load double, ptr %135, align 8, !tbaa !5
  %137 = fadd double %134, %136
  %138 = fmul double %137, 1.250000e-01
  %139 = tail call double @llvm.fmuladd.f64(double %131, double 1.250000e-01, double %138)
  %140 = add nuw nsw i64 %123, 1
  %141 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %88, i64 %140
  %142 = load double, ptr %141, align 8, !tbaa !5
  %143 = tail call double @llvm.fmuladd.f64(double %127, double -2.000000e+00, double %142)
  %144 = add nsw i64 %123, -1
  %145 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %76, i64 %88, i64 %144
  %146 = load double, ptr %145, align 8, !tbaa !5
  %147 = fadd double %143, %146
  %148 = tail call double @llvm.fmuladd.f64(double %147, double 1.250000e-01, double %139)
  %149 = fadd double %127, %148
  %150 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %76, i64 %88, i64 %123
  store double %149, ptr %150, align 8, !tbaa !5
  %151 = icmp eq i64 %140, 39
  br i1 %151, label %152, label %122, !llvm.loop !22

152:                                              ; preds = %91, %122
  %153 = icmp eq i64 %89, 39
  br i1 %153, label %154, label %87, !llvm.loop !23

154:                                              ; preds = %152
  %155 = add nuw nsw i64 %76, 1
  %156 = icmp eq i64 %155, 39
  %157 = add i64 %75, 1
  br i1 %156, label %158, label %74, !llvm.loop !24

158:                                              ; preds = %154, %238
  %159 = phi i64 [ %241, %238 ], [ 0, %154 ]
  %160 = phi i64 [ %239, %238 ], [ 1, %154 ]
  %161 = mul nuw nsw i64 %159, 12800
  %162 = getelementptr i8, ptr %69, i64 %161
  %163 = getelementptr i8, ptr %70, i64 %161
  %164 = or disjoint i64 %161, 328
  %165 = getelementptr i8, ptr %5, i64 %164
  %166 = getelementptr i8, ptr %71, i64 %161
  %167 = getelementptr [40 x [40 x double]], ptr %5, i64 %160
  %168 = icmp ult ptr %162, %166
  %169 = icmp ult ptr %165, %163
  %170 = and i1 %168, %169
  br label %171

171:                                              ; preds = %236, %158
  %172 = phi i64 [ 1, %158 ], [ %173, %236 ]
  %173 = add nuw nsw i64 %172, 1
  %174 = add nsw i64 %172, -1
  br i1 %170, label %206, label %175

175:                                              ; preds = %171, %175
  %176 = phi i64 [ %204, %175 ], [ 0, %171 ]
  %177 = or disjoint i64 %176, 1
  %178 = getelementptr [40 x [40 x double]], ptr %167, i64 1, i64 %172, i64 %177
  %179 = load <2 x double>, ptr %178, align 8, !tbaa !5, !alias.scope !25
  %180 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %172, i64 %177
  %181 = load <2 x double>, ptr %180, align 8, !tbaa !5, !alias.scope !25
  %182 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %181, <2 x double> <double -2.000000e+00, double -2.000000e+00>, <2 x double> %179)
  %183 = getelementptr [40 x [40 x double]], ptr %167, i64 -1, i64 %172, i64 %177
  %184 = load <2 x double>, ptr %183, align 8, !tbaa !5, !alias.scope !25
  %185 = fadd <2 x double> %182, %184
  %186 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %173, i64 %177
  %187 = load <2 x double>, ptr %186, align 8, !tbaa !5, !alias.scope !25
  %188 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %181, <2 x double> <double -2.000000e+00, double -2.000000e+00>, <2 x double> %187)
  %189 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %174, i64 %177
  %190 = load <2 x double>, ptr %189, align 8, !tbaa !5, !alias.scope !25
  %191 = fadd <2 x double> %188, %190
  %192 = fmul <2 x double> %191, <double 1.250000e-01, double 1.250000e-01>
  %193 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %185, <2 x double> <double 1.250000e-01, double 1.250000e-01>, <2 x double> %192)
  %194 = add i64 %176, 2
  %195 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %172, i64 %194
  %196 = load <2 x double>, ptr %195, align 8, !tbaa !5, !alias.scope !25
  %197 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %181, <2 x double> <double -2.000000e+00, double -2.000000e+00>, <2 x double> %196)
  %198 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %172, i64 %176
  %199 = load <2 x double>, ptr %198, align 8, !tbaa !5, !alias.scope !25
  %200 = fadd <2 x double> %197, %199
  %201 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %200, <2 x double> <double 1.250000e-01, double 1.250000e-01>, <2 x double> %193)
  %202 = fadd <2 x double> %181, %201
  %203 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %160, i64 %172, i64 %177
  store <2 x double> %202, ptr %203, align 8, !tbaa !5, !alias.scope !28, !noalias !25
  %204 = add nuw i64 %176, 2
  %205 = icmp eq i64 %204, 38
  br i1 %205, label %236, label %175, !llvm.loop !30

206:                                              ; preds = %171, %206
  %207 = phi i64 [ %224, %206 ], [ 1, %171 ]
  %208 = getelementptr [40 x [40 x double]], ptr %167, i64 1, i64 %172, i64 %207
  %209 = load double, ptr %208, align 8, !tbaa !5
  %210 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %172, i64 %207
  %211 = load double, ptr %210, align 8, !tbaa !5
  %212 = tail call double @llvm.fmuladd.f64(double %211, double -2.000000e+00, double %209)
  %213 = getelementptr [40 x [40 x double]], ptr %167, i64 -1, i64 %172, i64 %207
  %214 = load double, ptr %213, align 8, !tbaa !5
  %215 = fadd double %212, %214
  %216 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %173, i64 %207
  %217 = load double, ptr %216, align 8, !tbaa !5
  %218 = tail call double @llvm.fmuladd.f64(double %211, double -2.000000e+00, double %217)
  %219 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %174, i64 %207
  %220 = load double, ptr %219, align 8, !tbaa !5
  %221 = fadd double %218, %220
  %222 = fmul double %221, 1.250000e-01
  %223 = tail call double @llvm.fmuladd.f64(double %215, double 1.250000e-01, double %222)
  %224 = add nuw nsw i64 %207, 1
  %225 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %172, i64 %224
  %226 = load double, ptr %225, align 8, !tbaa !5
  %227 = tail call double @llvm.fmuladd.f64(double %211, double -2.000000e+00, double %226)
  %228 = add nsw i64 %207, -1
  %229 = getelementptr inbounds [40 x [40 x double]], ptr %5, i64 %160, i64 %172, i64 %228
  %230 = load double, ptr %229, align 8, !tbaa !5
  %231 = fadd double %227, %230
  %232 = tail call double @llvm.fmuladd.f64(double %231, double 1.250000e-01, double %223)
  %233 = fadd double %211, %232
  %234 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %160, i64 %172, i64 %207
  store double %233, ptr %234, align 8, !tbaa !5
  %235 = icmp eq i64 %224, 39
  br i1 %235, label %236, label %206, !llvm.loop !31

236:                                              ; preds = %175, %206
  %237 = icmp eq i64 %173, 39
  br i1 %237, label %238, label %171, !llvm.loop !32

238:                                              ; preds = %236
  %239 = add nuw nsw i64 %160, 1
  %240 = icmp eq i64 %239, 39
  %241 = add i64 %159, 1
  br i1 %240, label %242, label %158, !llvm.loop !33

242:                                              ; preds = %238
  %243 = add nuw nsw i32 %73, 1
  %244 = icmp eq i32 %243, 101
  br i1 %244, label %245, label %72, !llvm.loop !34

245:                                              ; preds = %242
  %246 = icmp sgt i32 %0, 42
  br i1 %246, label %247, label %290

247:                                              ; preds = %245
  %248 = load ptr, ptr %1, align 8, !tbaa !35
  %249 = load i8, ptr %248, align 1
  %250 = icmp eq i8 %249, 0
  br i1 %250, label %251, label %290

251:                                              ; preds = %247
  %252 = load ptr, ptr @stderr, align 8, !tbaa !35
  %253 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %252) #8
  %254 = load ptr, ptr @stderr, align 8, !tbaa !35
  %255 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %254, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %256

256:                                              ; preds = %282, %251
  %257 = phi i64 [ 0, %251 ], [ %283, %282 ]
  %258 = mul nuw nsw i64 %257, 1600
  br label %259

259:                                              ; preds = %279, %256
  %260 = phi i64 [ 0, %256 ], [ %280, %279 ]
  %261 = mul nuw nsw i64 %260, 40
  %262 = add nuw nsw i64 %261, %258
  br label %263

263:                                              ; preds = %272, %259
  %264 = phi i64 [ 0, %259 ], [ %277, %272 ]
  %265 = add nuw nsw i64 %262, %264
  %266 = trunc i64 %265 to i32
  %267 = urem i32 %266, 20
  %268 = icmp eq i32 %267, 0
  br i1 %268, label %269, label %272

269:                                              ; preds = %263
  %270 = load ptr, ptr @stderr, align 8, !tbaa !35
  %271 = tail call i32 @fputc(i32 10, ptr %270)
  br label %272

272:                                              ; preds = %269, %263
  %273 = load ptr, ptr @stderr, align 8, !tbaa !35
  %274 = getelementptr inbounds [40 x [40 x double]], ptr %3, i64 %257, i64 %260, i64 %264
  %275 = load double, ptr %274, align 8, !tbaa !5
  %276 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %273, ptr noundef nonnull @.str.5, double noundef %275) #8
  %277 = add nuw nsw i64 %264, 1
  %278 = icmp eq i64 %277, 40
  br i1 %278, label %279, label %263, !llvm.loop !37

279:                                              ; preds = %272
  %280 = add nuw nsw i64 %260, 1
  %281 = icmp eq i64 %280, 40
  br i1 %281, label %282, label %259, !llvm.loop !38

282:                                              ; preds = %279
  %283 = add nuw nsw i64 %257, 1
  %284 = icmp eq i64 %283, 40
  br i1 %284, label %285, label %256, !llvm.loop !39

285:                                              ; preds = %282
  %286 = load ptr, ptr @stderr, align 8, !tbaa !35
  %287 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %286, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %288 = load ptr, ptr @stderr, align 8, !tbaa !35
  %289 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %288) #8
  br label %290

290:                                              ; preds = %285, %247, %245
  tail call void @free(ptr noundef nonnull %3) #7
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
!13 = distinct !{!13, !10, !11}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = !{!17}
!17 = distinct !{!17, !18}
!18 = distinct !{!18, !"LVerDomain"}
!19 = !{!20}
!20 = distinct !{!20, !18}
!21 = distinct !{!21, !10, !11, !12}
!22 = distinct !{!22, !10, !11}
!23 = distinct !{!23, !10}
!24 = distinct !{!24, !10}
!25 = !{!26}
!26 = distinct !{!26, !27}
!27 = distinct !{!27, !"LVerDomain"}
!28 = !{!29}
!29 = distinct !{!29, !27}
!30 = distinct !{!30, !10, !11, !12}
!31 = distinct !{!31, !10, !11}
!32 = distinct !{!32, !10}
!33 = distinct !{!33, !10}
!34 = distinct !{!34, !10}
!35 = !{!36, !36, i64 0}
!36 = !{!"any pointer", !7, i64 0}
!37 = distinct !{!37, !10}
!38 = distinct !{!38, !10}
!39 = distinct !{!39, !10}
