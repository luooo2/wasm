; ModuleID = 'data/polybench-c-4.2.1-beta/stencils/fdtd-2d/fdtd-2d.c'
source_filename = "data/polybench-c-4.2.1-beta/stencils/fdtd-2d/fdtd-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"ex\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1
@.str.8 = private unnamed_addr constant [3 x i8] c"ey\00", align 1
@.str.9 = private unnamed_addr constant [3 x i8] c"hz\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #7
  %6 = ptrtoint ptr %5 to i64
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #7
  %8 = ptrtoint ptr %7 to i64
  %9 = tail call ptr @polybench_alloc_data(i64 noundef 100, i32 noundef 8) #7
  %10 = getelementptr double, ptr %9, i64 2
  %11 = getelementptr double, ptr %9, i64 4
  %12 = getelementptr double, ptr %9, i64 6
  %13 = getelementptr double, ptr %9, i64 8
  br label %14

14:                                               ; preds = %14, %2
  %15 = phi i64 [ 0, %2 ], [ %31, %14 ]
  %16 = phi <2 x i32> [ <i32 0, i32 1>, %2 ], [ %32, %14 ]
  %17 = sitofp <2 x i32> %16 to <2 x double>
  %18 = getelementptr inbounds double, ptr %9, i64 %15
  store <2 x double> %17, ptr %18, align 8, !tbaa !5
  %19 = add <2 x i32> %16, <i32 2, i32 2>
  %20 = sitofp <2 x i32> %19 to <2 x double>
  %21 = getelementptr double, ptr %10, i64 %15
  store <2 x double> %20, ptr %21, align 8, !tbaa !5
  %22 = add <2 x i32> %16, <i32 4, i32 4>
  %23 = sitofp <2 x i32> %22 to <2 x double>
  %24 = getelementptr double, ptr %11, i64 %15
  store <2 x double> %23, ptr %24, align 8, !tbaa !5
  %25 = add <2 x i32> %16, <i32 6, i32 6>
  %26 = sitofp <2 x i32> %25 to <2 x double>
  %27 = getelementptr double, ptr %12, i64 %15
  store <2 x double> %26, ptr %27, align 8, !tbaa !5
  %28 = add <2 x i32> %16, <i32 8, i32 8>
  %29 = sitofp <2 x i32> %28 to <2 x double>
  %30 = getelementptr double, ptr %13, i64 %15
  store <2 x double> %29, ptr %30, align 8, !tbaa !5
  %31 = add nuw nsw i64 %15, 10
  %32 = add <2 x i32> %16, <i32 10, i32 10>
  %33 = icmp eq i64 %31, 100
  br i1 %33, label %34, label %14, !llvm.loop !9

34:                                               ; preds = %14
  %35 = sub i64 %6, %4
  %36 = sub i64 %8, %4
  %37 = sub i64 %8, %6
  %38 = icmp ult i64 %35, 16
  %39 = icmp ult i64 %36, 16
  %40 = or i1 %38, %39
  %41 = icmp ult i64 %37, 16
  %42 = or i1 %40, %41
  br label %43

43:                                               ; preds = %34, %94
  %44 = phi i64 [ %95, %94 ], [ 0, %34 ]
  %45 = trunc i64 %44 to i32
  %46 = sitofp i32 %45 to double
  br i1 %42, label %74, label %47

47:                                               ; preds = %43
  %48 = insertelement <2 x double> poison, double %46, i64 0
  %49 = shufflevector <2 x double> %48, <2 x double> poison, <2 x i32> zeroinitializer
  br label %50

50:                                               ; preds = %50, %47
  %51 = phi i64 [ 0, %47 ], [ %70, %50 ]
  %52 = phi <2 x i64> [ <i64 0, i64 1>, %47 ], [ %71, %50 ]
  %53 = phi <2 x i32> [ <i32 0, i32 1>, %47 ], [ %72, %50 ]
  %54 = trunc <2 x i64> %52 to <2 x i32>
  %55 = add <2 x i32> %54, <i32 1, i32 1>
  %56 = sitofp <2 x i32> %55 to <2 x double>
  %57 = fmul <2 x double> %49, %56
  %58 = fdiv <2 x double> %57, <double 2.000000e+02, double 2.000000e+02>
  %59 = getelementptr inbounds [240 x double], ptr %3, i64 %44, i64 %51
  store <2 x double> %58, ptr %59, align 8, !tbaa !5
  %60 = add <2 x i32> %53, <i32 2, i32 2>
  %61 = sitofp <2 x i32> %60 to <2 x double>
  %62 = fmul <2 x double> %49, %61
  %63 = fdiv <2 x double> %62, <double 2.400000e+02, double 2.400000e+02>
  %64 = getelementptr inbounds [240 x double], ptr %5, i64 %44, i64 %51
  store <2 x double> %63, ptr %64, align 8, !tbaa !5
  %65 = add <2 x i32> %53, <i32 3, i32 3>
  %66 = sitofp <2 x i32> %65 to <2 x double>
  %67 = fmul <2 x double> %49, %66
  %68 = fdiv <2 x double> %67, <double 2.000000e+02, double 2.000000e+02>
  %69 = getelementptr inbounds [240 x double], ptr %7, i64 %44, i64 %51
  store <2 x double> %68, ptr %69, align 8, !tbaa !5
  %70 = add nuw i64 %51, 2
  %71 = add <2 x i64> %52, <i64 2, i64 2>
  %72 = add <2 x i32> %53, <i32 2, i32 2>
  %73 = icmp eq i64 %70, 240
  br i1 %73, label %94, label %50, !llvm.loop !13

74:                                               ; preds = %43, %74
  %75 = phi i64 [ %76, %74 ], [ 0, %43 ]
  %76 = add nuw nsw i64 %75, 1
  %77 = trunc i64 %76 to i32
  %78 = sitofp i32 %77 to double
  %79 = fmul double %46, %78
  %80 = fdiv double %79, 2.000000e+02
  %81 = getelementptr inbounds [240 x double], ptr %3, i64 %44, i64 %75
  store double %80, ptr %81, align 8, !tbaa !5
  %82 = trunc i64 %75 to i32
  %83 = add i32 %82, 2
  %84 = sitofp i32 %83 to double
  %85 = fmul double %46, %84
  %86 = fdiv double %85, 2.400000e+02
  %87 = getelementptr inbounds [240 x double], ptr %5, i64 %44, i64 %75
  store double %86, ptr %87, align 8, !tbaa !5
  %88 = add i32 %82, 3
  %89 = sitofp i32 %88 to double
  %90 = fmul double %46, %89
  %91 = fdiv double %90, 2.000000e+02
  %92 = getelementptr inbounds [240 x double], ptr %7, i64 %44, i64 %75
  store double %91, ptr %92, align 8, !tbaa !5
  %93 = icmp eq i64 %76, 240
  br i1 %93, label %94, label %74, !llvm.loop !14

94:                                               ; preds = %50, %74
  %95 = add nuw nsw i64 %44, 1
  %96 = icmp eq i64 %95, 200
  br i1 %96, label %97, label %43, !llvm.loop !15

97:                                               ; preds = %94
  %98 = getelementptr i8, ptr %7, i64 382072
  %99 = getelementptr i8, ptr %3, i64 382080
  %100 = getelementptr i8, ptr %5, i64 383992
  %101 = getelementptr i8, ptr %3, i64 8
  %102 = getelementptr i8, ptr %3, i64 384000
  %103 = getelementptr i8, ptr %7, i64 384000
  %104 = getelementptr i8, ptr %5, i64 1920
  %105 = getelementptr i8, ptr %5, i64 384000
  %106 = icmp ult ptr %104, %103
  %107 = icmp ult ptr %7, %105
  %108 = and i1 %106, %107
  %109 = icmp ult ptr %101, %103
  %110 = icmp ult ptr %7, %102
  %111 = and i1 %109, %110
  %112 = icmp ult ptr %7, %99
  %113 = icmp ult ptr %3, %98
  %114 = and i1 %112, %113
  %115 = icmp ult ptr %7, %100
  %116 = icmp ult ptr %5, %98
  %117 = and i1 %115, %116
  %118 = or i1 %114, %117
  br label %119

119:                                              ; preds = %312, %97
  %120 = phi i64 [ %313, %312 ], [ 0, %97 ]
  %121 = getelementptr inbounds double, ptr %9, i64 %120
  %122 = load double, ptr %121, align 8, !tbaa !5
  %123 = insertelement <2 x double> poison, double %122, i64 0
  %124 = shufflevector <2 x double> %123, <2 x double> poison, <2 x i32> zeroinitializer
  br label %125

125:                                              ; preds = %125, %119
  %126 = phi i64 [ 0, %119 ], [ %144, %125 ]
  %127 = getelementptr inbounds [240 x double], ptr %5, i64 0, i64 %126
  %128 = getelementptr inbounds double, ptr %127, i64 2
  store <2 x double> %124, ptr %127, align 8, !tbaa !5
  store <2 x double> %124, ptr %128, align 8, !tbaa !5
  %129 = or disjoint i64 %126, 4
  %130 = getelementptr inbounds [240 x double], ptr %5, i64 0, i64 %129
  %131 = getelementptr inbounds double, ptr %130, i64 2
  store <2 x double> %124, ptr %130, align 8, !tbaa !5
  store <2 x double> %124, ptr %131, align 8, !tbaa !5
  %132 = add nuw nsw i64 %126, 8
  %133 = getelementptr inbounds [240 x double], ptr %5, i64 0, i64 %132
  %134 = getelementptr inbounds double, ptr %133, i64 2
  store <2 x double> %124, ptr %133, align 8, !tbaa !5
  store <2 x double> %124, ptr %134, align 8, !tbaa !5
  %135 = add nuw nsw i64 %126, 12
  %136 = getelementptr inbounds [240 x double], ptr %5, i64 0, i64 %135
  %137 = getelementptr inbounds double, ptr %136, i64 2
  store <2 x double> %124, ptr %136, align 8, !tbaa !5
  store <2 x double> %124, ptr %137, align 8, !tbaa !5
  %138 = add nuw nsw i64 %126, 16
  %139 = getelementptr inbounds [240 x double], ptr %5, i64 0, i64 %138
  %140 = getelementptr inbounds double, ptr %139, i64 2
  store <2 x double> %124, ptr %139, align 8, !tbaa !5
  store <2 x double> %124, ptr %140, align 8, !tbaa !5
  %141 = add nuw nsw i64 %126, 20
  %142 = getelementptr inbounds [240 x double], ptr %5, i64 0, i64 %141
  %143 = getelementptr inbounds double, ptr %142, i64 2
  store <2 x double> %124, ptr %142, align 8, !tbaa !5
  store <2 x double> %124, ptr %143, align 8, !tbaa !5
  %144 = add nuw nsw i64 %126, 24
  %145 = icmp eq i64 %144, 240
  br i1 %145, label %146, label %125, !llvm.loop !16

146:                                              ; preds = %125, %190
  %147 = phi i64 [ %191, %190 ], [ 1, %125 ]
  %148 = getelementptr [240 x double], ptr %7, i64 %147
  br i1 %108, label %169, label %149

149:                                              ; preds = %146, %149
  %150 = phi i64 [ %167, %149 ], [ 0, %146 ]
  %151 = getelementptr inbounds [240 x double], ptr %5, i64 %147, i64 %150
  %152 = getelementptr inbounds double, ptr %151, i64 2
  %153 = load <2 x double>, ptr %151, align 8, !tbaa !5, !alias.scope !17, !noalias !20
  %154 = load <2 x double>, ptr %152, align 8, !tbaa !5, !alias.scope !17, !noalias !20
  %155 = getelementptr inbounds [240 x double], ptr %7, i64 %147, i64 %150
  %156 = getelementptr inbounds double, ptr %155, i64 2
  %157 = load <2 x double>, ptr %155, align 8, !tbaa !5, !alias.scope !20
  %158 = load <2 x double>, ptr %156, align 8, !tbaa !5, !alias.scope !20
  %159 = getelementptr [240 x double], ptr %148, i64 -1, i64 %150
  %160 = getelementptr double, ptr %159, i64 2
  %161 = load <2 x double>, ptr %159, align 8, !tbaa !5, !alias.scope !20
  %162 = load <2 x double>, ptr %160, align 8, !tbaa !5, !alias.scope !20
  %163 = fsub <2 x double> %157, %161
  %164 = fsub <2 x double> %158, %162
  %165 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %163, <2 x double> <double -5.000000e-01, double -5.000000e-01>, <2 x double> %153)
  %166 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %164, <2 x double> <double -5.000000e-01, double -5.000000e-01>, <2 x double> %154)
  store <2 x double> %165, ptr %151, align 8, !tbaa !5, !alias.scope !17, !noalias !20
  store <2 x double> %166, ptr %152, align 8, !tbaa !5, !alias.scope !17, !noalias !20
  %167 = add nuw i64 %150, 4
  %168 = icmp eq i64 %167, 240
  br i1 %168, label %190, label %149, !llvm.loop !22

169:                                              ; preds = %146, %169
  %170 = phi i64 [ %188, %169 ], [ 0, %146 ]
  %171 = getelementptr inbounds [240 x double], ptr %5, i64 %147, i64 %170
  %172 = load double, ptr %171, align 8, !tbaa !5
  %173 = getelementptr inbounds [240 x double], ptr %7, i64 %147, i64 %170
  %174 = load double, ptr %173, align 8, !tbaa !5
  %175 = getelementptr [240 x double], ptr %148, i64 -1, i64 %170
  %176 = load double, ptr %175, align 8, !tbaa !5
  %177 = fsub double %174, %176
  %178 = tail call double @llvm.fmuladd.f64(double %177, double -5.000000e-01, double %172)
  store double %178, ptr %171, align 8, !tbaa !5
  %179 = or disjoint i64 %170, 1
  %180 = getelementptr inbounds [240 x double], ptr %5, i64 %147, i64 %179
  %181 = load double, ptr %180, align 8, !tbaa !5
  %182 = getelementptr inbounds [240 x double], ptr %7, i64 %147, i64 %179
  %183 = load double, ptr %182, align 8, !tbaa !5
  %184 = getelementptr [240 x double], ptr %148, i64 -1, i64 %179
  %185 = load double, ptr %184, align 8, !tbaa !5
  %186 = fsub double %183, %185
  %187 = tail call double @llvm.fmuladd.f64(double %186, double -5.000000e-01, double %181)
  store double %187, ptr %180, align 8, !tbaa !5
  %188 = add nuw nsw i64 %170, 2
  %189 = icmp eq i64 %188, 240
  br i1 %189, label %190, label %169, !llvm.loop !23

190:                                              ; preds = %149, %169
  %191 = add nuw nsw i64 %147, 1
  %192 = icmp eq i64 %191, 200
  br i1 %192, label %193, label %146, !llvm.loop !24

193:                                              ; preds = %190, %250
  %194 = phi i64 [ %251, %250 ], [ 0, %190 ]
  br i1 %111, label %216, label %195

195:                                              ; preds = %193, %195
  %196 = phi i64 [ %214, %195 ], [ 0, %193 ]
  %197 = or disjoint i64 %196, 1
  %198 = getelementptr inbounds [240 x double], ptr %3, i64 %194, i64 %197
  %199 = getelementptr inbounds double, ptr %198, i64 2
  %200 = load <2 x double>, ptr %198, align 8, !tbaa !5, !alias.scope !25, !noalias !28
  %201 = load <2 x double>, ptr %199, align 8, !tbaa !5, !alias.scope !25, !noalias !28
  %202 = getelementptr inbounds [240 x double], ptr %7, i64 %194, i64 %197
  %203 = getelementptr inbounds double, ptr %202, i64 2
  %204 = load <2 x double>, ptr %202, align 8, !tbaa !5, !alias.scope !28
  %205 = load <2 x double>, ptr %203, align 8, !tbaa !5, !alias.scope !28
  %206 = getelementptr inbounds [240 x double], ptr %7, i64 %194, i64 %196
  %207 = getelementptr inbounds double, ptr %206, i64 2
  %208 = load <2 x double>, ptr %206, align 8, !tbaa !5, !alias.scope !28
  %209 = load <2 x double>, ptr %207, align 8, !tbaa !5, !alias.scope !28
  %210 = fsub <2 x double> %204, %208
  %211 = fsub <2 x double> %205, %209
  %212 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %210, <2 x double> <double -5.000000e-01, double -5.000000e-01>, <2 x double> %200)
  %213 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %211, <2 x double> <double -5.000000e-01, double -5.000000e-01>, <2 x double> %201)
  store <2 x double> %212, ptr %198, align 8, !tbaa !5, !alias.scope !25, !noalias !28
  store <2 x double> %213, ptr %199, align 8, !tbaa !5, !alias.scope !25, !noalias !28
  %214 = add nuw i64 %196, 4
  %215 = icmp eq i64 %214, 236
  br i1 %215, label %216, label %195, !llvm.loop !30

216:                                              ; preds = %195, %193
  %217 = phi i64 [ 1, %193 ], [ 237, %195 ]
  %218 = getelementptr inbounds [240 x double], ptr %3, i64 %194, i64 %217
  %219 = load double, ptr %218, align 8, !tbaa !5
  %220 = getelementptr inbounds [240 x double], ptr %7, i64 %194, i64 %217
  %221 = load double, ptr %220, align 8, !tbaa !5
  %222 = add nsw i64 %217, -1
  %223 = getelementptr inbounds [240 x double], ptr %7, i64 %194, i64 %222
  %224 = load double, ptr %223, align 8, !tbaa !5
  %225 = fsub double %221, %224
  %226 = tail call double @llvm.fmuladd.f64(double %225, double -5.000000e-01, double %219)
  store double %226, ptr %218, align 8, !tbaa !5
  %227 = add nuw nsw i64 %217, 1
  br label %228

228:                                              ; preds = %228, %216
  %229 = phi i64 [ %227, %216 ], [ %248, %228 ]
  %230 = getelementptr inbounds [240 x double], ptr %3, i64 %194, i64 %229
  %231 = load double, ptr %230, align 8, !tbaa !5
  %232 = getelementptr inbounds [240 x double], ptr %7, i64 %194, i64 %229
  %233 = load double, ptr %232, align 8, !tbaa !5
  %234 = add nsw i64 %229, -1
  %235 = getelementptr inbounds [240 x double], ptr %7, i64 %194, i64 %234
  %236 = load double, ptr %235, align 8, !tbaa !5
  %237 = fsub double %233, %236
  %238 = tail call double @llvm.fmuladd.f64(double %237, double -5.000000e-01, double %231)
  store double %238, ptr %230, align 8, !tbaa !5
  %239 = add nuw nsw i64 %229, 1
  %240 = getelementptr inbounds [240 x double], ptr %3, i64 %194, i64 %239
  %241 = load double, ptr %240, align 8, !tbaa !5
  %242 = getelementptr inbounds [240 x double], ptr %7, i64 %194, i64 %239
  %243 = load double, ptr %242, align 8, !tbaa !5
  %244 = getelementptr inbounds [240 x double], ptr %7, i64 %194, i64 %229
  %245 = load double, ptr %244, align 8, !tbaa !5
  %246 = fsub double %243, %245
  %247 = tail call double @llvm.fmuladd.f64(double %246, double -5.000000e-01, double %241)
  store double %247, ptr %240, align 8, !tbaa !5
  %248 = add nuw nsw i64 %229, 2
  %249 = icmp eq i64 %248, 240
  br i1 %249, label %250, label %228, !llvm.loop !31

250:                                              ; preds = %228
  %251 = add nuw nsw i64 %194, 1
  %252 = icmp eq i64 %251, 200
  br i1 %252, label %253, label %193, !llvm.loop !32

253:                                              ; preds = %250, %309
  %254 = phi i64 [ %310, %309 ], [ 0, %250 ]
  %255 = getelementptr [240 x double], ptr %5, i64 %254
  br i1 %118, label %289, label %256

256:                                              ; preds = %253, %256
  %257 = phi i64 [ %287, %256 ], [ 0, %253 ]
  %258 = getelementptr inbounds [240 x double], ptr %7, i64 %254, i64 %257
  %259 = getelementptr inbounds double, ptr %258, i64 2
  %260 = load <2 x double>, ptr %258, align 8, !tbaa !5, !alias.scope !33, !noalias !36
  %261 = load <2 x double>, ptr %259, align 8, !tbaa !5, !alias.scope !33, !noalias !36
  %262 = or disjoint i64 %257, 1
  %263 = getelementptr inbounds [240 x double], ptr %3, i64 %254, i64 %262
  %264 = getelementptr inbounds double, ptr %263, i64 2
  %265 = load <2 x double>, ptr %263, align 8, !tbaa !5, !alias.scope !39
  %266 = load <2 x double>, ptr %264, align 8, !tbaa !5, !alias.scope !39
  %267 = getelementptr inbounds [240 x double], ptr %3, i64 %254, i64 %257
  %268 = getelementptr inbounds double, ptr %267, i64 2
  %269 = load <2 x double>, ptr %267, align 8, !tbaa !5, !alias.scope !39
  %270 = load <2 x double>, ptr %268, align 8, !tbaa !5, !alias.scope !39
  %271 = fsub <2 x double> %265, %269
  %272 = fsub <2 x double> %266, %270
  %273 = getelementptr [240 x double], ptr %255, i64 1, i64 %257
  %274 = getelementptr double, ptr %273, i64 2
  %275 = load <2 x double>, ptr %273, align 8, !tbaa !5, !alias.scope !40
  %276 = load <2 x double>, ptr %274, align 8, !tbaa !5, !alias.scope !40
  %277 = fadd <2 x double> %271, %275
  %278 = fadd <2 x double> %272, %276
  %279 = getelementptr inbounds [240 x double], ptr %5, i64 %254, i64 %257
  %280 = getelementptr inbounds double, ptr %279, i64 2
  %281 = load <2 x double>, ptr %279, align 8, !tbaa !5, !alias.scope !40
  %282 = load <2 x double>, ptr %280, align 8, !tbaa !5, !alias.scope !40
  %283 = fsub <2 x double> %277, %281
  %284 = fsub <2 x double> %278, %282
  %285 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %283, <2 x double> <double 0xBFE6666666666666, double 0xBFE6666666666666>, <2 x double> %260)
  %286 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %284, <2 x double> <double 0xBFE6666666666666, double 0xBFE6666666666666>, <2 x double> %261)
  store <2 x double> %285, ptr %258, align 8, !tbaa !5, !alias.scope !33, !noalias !36
  store <2 x double> %286, ptr %259, align 8, !tbaa !5, !alias.scope !33, !noalias !36
  %287 = add nuw i64 %257, 4
  %288 = icmp eq i64 %287, 236
  br i1 %288, label %289, label %256, !llvm.loop !41

289:                                              ; preds = %256, %253
  %290 = phi i64 [ 0, %253 ], [ 236, %256 ]
  br label %291

291:                                              ; preds = %289, %291
  %292 = phi i64 [ %295, %291 ], [ %290, %289 ]
  %293 = getelementptr inbounds [240 x double], ptr %7, i64 %254, i64 %292
  %294 = load double, ptr %293, align 8, !tbaa !5
  %295 = add nuw nsw i64 %292, 1
  %296 = getelementptr inbounds [240 x double], ptr %3, i64 %254, i64 %295
  %297 = load double, ptr %296, align 8, !tbaa !5
  %298 = getelementptr inbounds [240 x double], ptr %3, i64 %254, i64 %292
  %299 = load double, ptr %298, align 8, !tbaa !5
  %300 = fsub double %297, %299
  %301 = getelementptr [240 x double], ptr %255, i64 1, i64 %292
  %302 = load double, ptr %301, align 8, !tbaa !5
  %303 = fadd double %300, %302
  %304 = getelementptr inbounds [240 x double], ptr %5, i64 %254, i64 %292
  %305 = load double, ptr %304, align 8, !tbaa !5
  %306 = fsub double %303, %305
  %307 = tail call double @llvm.fmuladd.f64(double %306, double 0xBFE6666666666666, double %294)
  store double %307, ptr %293, align 8, !tbaa !5
  %308 = icmp eq i64 %295, 239
  br i1 %308, label %309, label %291, !llvm.loop !42

309:                                              ; preds = %291
  %310 = add nuw nsw i64 %254, 1
  %311 = icmp eq i64 %310, 199
  br i1 %311, label %312, label %253, !llvm.loop !43

312:                                              ; preds = %309
  %313 = add nuw nsw i64 %120, 1
  %314 = icmp eq i64 %313, 100
  br i1 %314, label %315, label %119, !llvm.loop !44

315:                                              ; preds = %312
  %316 = icmp sgt i32 %0, 42
  br i1 %316, label %317, label %407

317:                                              ; preds = %315
  %318 = load ptr, ptr %1, align 8, !tbaa !45
  %319 = load i8, ptr %318, align 1
  %320 = icmp eq i8 %319, 0
  br i1 %320, label %321, label %407

321:                                              ; preds = %317
  %322 = load ptr, ptr @stderr, align 8, !tbaa !45
  %323 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %322) #8
  %324 = load ptr, ptr @stderr, align 8, !tbaa !45
  %325 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %324, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %326

326:                                              ; preds = %345, %321
  %327 = phi i64 [ 0, %321 ], [ %346, %345 ]
  %328 = mul nuw nsw i64 %327, 200
  br label %329

329:                                              ; preds = %338, %326
  %330 = phi i64 [ 0, %326 ], [ %343, %338 ]
  %331 = add nuw nsw i64 %330, %328
  %332 = trunc i64 %331 to i32
  %333 = urem i32 %332, 20
  %334 = icmp eq i32 %333, 0
  br i1 %334, label %335, label %338

335:                                              ; preds = %329
  %336 = load ptr, ptr @stderr, align 8, !tbaa !45
  %337 = tail call i32 @fputc(i32 10, ptr %336)
  br label %338

338:                                              ; preds = %335, %329
  %339 = load ptr, ptr @stderr, align 8, !tbaa !45
  %340 = getelementptr inbounds [240 x double], ptr %3, i64 %327, i64 %330
  %341 = load double, ptr %340, align 8, !tbaa !5
  %342 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %339, ptr noundef nonnull @.str.5, double noundef %341) #8
  %343 = add nuw nsw i64 %330, 1
  %344 = icmp eq i64 %343, 240
  br i1 %344, label %345, label %329, !llvm.loop !47

345:                                              ; preds = %338
  %346 = add nuw nsw i64 %327, 1
  %347 = icmp eq i64 %346, 200
  br i1 %347, label %348, label %326, !llvm.loop !48

348:                                              ; preds = %345
  %349 = load ptr, ptr @stderr, align 8, !tbaa !45
  %350 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %349, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %351 = load ptr, ptr @stderr, align 8, !tbaa !45
  %352 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %351) #8
  %353 = load ptr, ptr @stderr, align 8, !tbaa !45
  %354 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %353, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.8) #8
  br label %355

355:                                              ; preds = %374, %348
  %356 = phi i64 [ 0, %348 ], [ %375, %374 ]
  %357 = mul nuw nsw i64 %356, 200
  br label %358

358:                                              ; preds = %367, %355
  %359 = phi i64 [ 0, %355 ], [ %372, %367 ]
  %360 = add nuw nsw i64 %359, %357
  %361 = trunc i64 %360 to i32
  %362 = urem i32 %361, 20
  %363 = icmp eq i32 %362, 0
  br i1 %363, label %364, label %367

364:                                              ; preds = %358
  %365 = load ptr, ptr @stderr, align 8, !tbaa !45
  %366 = tail call i32 @fputc(i32 10, ptr %365)
  br label %367

367:                                              ; preds = %364, %358
  %368 = load ptr, ptr @stderr, align 8, !tbaa !45
  %369 = getelementptr inbounds [240 x double], ptr %5, i64 %356, i64 %359
  %370 = load double, ptr %369, align 8, !tbaa !5
  %371 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %368, ptr noundef nonnull @.str.5, double noundef %370) #8
  %372 = add nuw nsw i64 %359, 1
  %373 = icmp eq i64 %372, 240
  br i1 %373, label %374, label %358, !llvm.loop !49

374:                                              ; preds = %367
  %375 = add nuw nsw i64 %356, 1
  %376 = icmp eq i64 %375, 200
  br i1 %376, label %377, label %355, !llvm.loop !50

377:                                              ; preds = %374
  %378 = load ptr, ptr @stderr, align 8, !tbaa !45
  %379 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %378, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.8) #8
  %380 = load ptr, ptr @stderr, align 8, !tbaa !45
  %381 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %380, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.9) #8
  br label %382

382:                                              ; preds = %401, %377
  %383 = phi i64 [ 0, %377 ], [ %402, %401 ]
  %384 = mul nuw nsw i64 %383, 200
  br label %385

385:                                              ; preds = %394, %382
  %386 = phi i64 [ 0, %382 ], [ %399, %394 ]
  %387 = add nuw nsw i64 %386, %384
  %388 = trunc i64 %387 to i32
  %389 = urem i32 %388, 20
  %390 = icmp eq i32 %389, 0
  br i1 %390, label %391, label %394

391:                                              ; preds = %385
  %392 = load ptr, ptr @stderr, align 8, !tbaa !45
  %393 = tail call i32 @fputc(i32 10, ptr %392)
  br label %394

394:                                              ; preds = %391, %385
  %395 = load ptr, ptr @stderr, align 8, !tbaa !45
  %396 = getelementptr inbounds [240 x double], ptr %7, i64 %383, i64 %386
  %397 = load double, ptr %396, align 8, !tbaa !5
  %398 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %395, ptr noundef nonnull @.str.5, double noundef %397) #8
  %399 = add nuw nsw i64 %386, 1
  %400 = icmp eq i64 %399, 240
  br i1 %400, label %401, label %385, !llvm.loop !51

401:                                              ; preds = %394
  %402 = add nuw nsw i64 %383, 1
  %403 = icmp eq i64 %402, 200
  br i1 %403, label %404, label %382, !llvm.loop !52

404:                                              ; preds = %401
  %405 = load ptr, ptr @stderr, align 8, !tbaa !45
  %406 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %405, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.9) #8
  br label %407

407:                                              ; preds = %404, %317, %315
  tail call void @free(ptr noundef %3) #7
  tail call void @free(ptr noundef %5) #7
  tail call void @free(ptr noundef nonnull %7) #7
  tail call void @free(ptr noundef %9) #7
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
!13 = distinct !{!13, !10, !11, !12}
!14 = distinct !{!14, !10, !11}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10, !11, !12}
!17 = !{!18}
!18 = distinct !{!18, !19}
!19 = distinct !{!19, !"LVerDomain"}
!20 = !{!21}
!21 = distinct !{!21, !19}
!22 = distinct !{!22, !10, !11, !12}
!23 = distinct !{!23, !10, !11}
!24 = distinct !{!24, !10}
!25 = !{!26}
!26 = distinct !{!26, !27}
!27 = distinct !{!27, !"LVerDomain"}
!28 = !{!29}
!29 = distinct !{!29, !27}
!30 = distinct !{!30, !10, !11, !12}
!31 = distinct !{!31, !10, !11}
!32 = distinct !{!32, !10}
!33 = !{!34}
!34 = distinct !{!34, !35}
!35 = distinct !{!35, !"LVerDomain"}
!36 = !{!37, !38}
!37 = distinct !{!37, !35}
!38 = distinct !{!38, !35}
!39 = !{!37}
!40 = !{!38}
!41 = distinct !{!41, !10, !11, !12}
!42 = distinct !{!42, !10, !11}
!43 = distinct !{!43, !10}
!44 = distinct !{!44, !10}
!45 = !{!46, !46, i64 0}
!46 = !{!"any pointer", !7, i64 0}
!47 = distinct !{!47, !10}
!48 = distinct !{!48, !10}
!49 = distinct !{!49, !10}
!50 = distinct !{!50, !10}
!51 = distinct !{!51, !10}
!52 = distinct !{!52, !10}
