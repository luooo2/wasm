; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/solvers/ludcmp/ludcmp.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/solvers/ludcmp/ludcmp.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 160000, i32 noundef 8) #8
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #8
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #8
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #8
  %8 = ptrtoint ptr %7 to i64
  %9 = ptrtoint ptr %6 to i64
  %10 = ptrtoint ptr %5 to i64
  %11 = sub i64 %8, %9
  %12 = icmp ult i64 %11, 16
  %13 = sub i64 %10, %9
  %14 = icmp ult i64 %13, 16
  %15 = or i1 %12, %14
  %16 = sub i64 %10, %8
  %17 = icmp ult i64 %16, 16
  %18 = or i1 %15, %17
  br i1 %18, label %34, label %19

19:                                               ; preds = %2, %19
  %20 = phi i64 [ %31, %19 ], [ 0, %2 ]
  %21 = phi <2 x i64> [ %32, %19 ], [ <i64 0, i64 1>, %2 ]
  %22 = getelementptr inbounds double, ptr %6, i64 %20
  store <2 x double> zeroinitializer, ptr %22, align 8, !tbaa !5
  %23 = getelementptr inbounds double, ptr %7, i64 %20
  store <2 x double> zeroinitializer, ptr %23, align 8, !tbaa !5
  %24 = trunc <2 x i64> %21 to <2 x i32>
  %25 = add <2 x i32> %24, <i32 1, i32 1>
  %26 = sitofp <2 x i32> %25 to <2 x double>
  %27 = fdiv <2 x double> %26, <double 4.000000e+02, double 4.000000e+02>
  %28 = fmul <2 x double> %27, <double 5.000000e-01, double 5.000000e-01>
  %29 = fadd <2 x double> %28, <double 4.000000e+00, double 4.000000e+00>
  %30 = getelementptr inbounds double, ptr %5, i64 %20
  store <2 x double> %29, ptr %30, align 8, !tbaa !5
  %31 = add nuw i64 %20, 2
  %32 = add <2 x i64> %21, <i64 2, i64 2>
  %33 = icmp eq i64 %31, 400
  br i1 %33, label %55, label %19, !llvm.loop !9

34:                                               ; preds = %2, %34
  %35 = phi i64 [ %47, %34 ], [ 0, %2 ]
  %36 = getelementptr inbounds double, ptr %6, i64 %35
  store double 0.000000e+00, ptr %36, align 8, !tbaa !5
  %37 = getelementptr inbounds double, ptr %7, i64 %35
  store double 0.000000e+00, ptr %37, align 8, !tbaa !5
  %38 = or disjoint i64 %35, 1
  %39 = trunc i64 %38 to i32
  %40 = sitofp i32 %39 to double
  %41 = fdiv double %40, 4.000000e+02
  %42 = fmul double %41, 5.000000e-01
  %43 = fadd double %42, 4.000000e+00
  %44 = getelementptr inbounds double, ptr %5, i64 %35
  store double %43, ptr %44, align 8, !tbaa !5
  %45 = getelementptr inbounds double, ptr %6, i64 %38
  store double 0.000000e+00, ptr %45, align 8, !tbaa !5
  %46 = getelementptr inbounds double, ptr %7, i64 %38
  store double 0.000000e+00, ptr %46, align 8, !tbaa !5
  %47 = add nuw nsw i64 %35, 2
  %48 = trunc i64 %47 to i32
  %49 = sitofp i32 %48 to double
  %50 = fdiv double %49, 4.000000e+02
  %51 = fmul double %50, 5.000000e-01
  %52 = fadd double %51, 4.000000e+00
  %53 = getelementptr inbounds double, ptr %5, i64 %38
  store double %52, ptr %53, align 8, !tbaa !5
  %54 = icmp eq i64 %47, 400
  br i1 %54, label %55, label %34, !llvm.loop !13

55:                                               ; preds = %19, %34
  %56 = getelementptr i8, ptr %3, i64 8
  br label %57

57:                                               ; preds = %98, %55
  %58 = phi i64 [ 1, %55 ], [ %100, %98 ]
  %59 = phi i64 [ 0, %55 ], [ %93, %98 ]
  %60 = mul nuw nsw i64 %59, 3208
  %61 = shl i64 %59, 3
  %62 = sub nsw i64 3184, %61
  %63 = and i64 %62, 34359738360
  %64 = icmp ult i64 %58, 2
  br i1 %64, label %80, label %65

65:                                               ; preds = %57
  %66 = and i64 %58, 9223372036854775806
  br label %67

67:                                               ; preds = %67, %65
  %68 = phi i64 [ 0, %65 ], [ %75, %67 ]
  %69 = phi <2 x i32> [ <i32 0, i32 1>, %65 ], [ %76, %67 ]
  %70 = sub <2 x i32> zeroinitializer, %69
  %71 = sitofp <2 x i32> %70 to <2 x double>
  %72 = fdiv <2 x double> %71, <double 4.000000e+02, double 4.000000e+02>
  %73 = fadd <2 x double> %72, <double 1.000000e+00, double 1.000000e+00>
  %74 = getelementptr inbounds [400 x double], ptr %3, i64 %59, i64 %68
  store <2 x double> %73, ptr %74, align 8, !tbaa !5
  %75 = add nuw i64 %68, 2
  %76 = add <2 x i32> %69, <i32 2, i32 2>
  %77 = icmp eq i64 %75, %66
  br i1 %77, label %78, label %67, !llvm.loop !14

78:                                               ; preds = %67
  %79 = icmp eq i64 %58, %66
  br i1 %79, label %92, label %80

80:                                               ; preds = %57, %78
  %81 = phi i64 [ 0, %57 ], [ %66, %78 ]
  br label %82

82:                                               ; preds = %80, %82
  %83 = phi i64 [ %90, %82 ], [ %81, %80 ]
  %84 = trunc i64 %83 to i32
  %85 = sub i32 0, %84
  %86 = sitofp i32 %85 to double
  %87 = fdiv double %86, 4.000000e+02
  %88 = fadd double %87, 1.000000e+00
  %89 = getelementptr inbounds [400 x double], ptr %3, i64 %59, i64 %83
  store double %88, ptr %89, align 8, !tbaa !5
  %90 = add nuw nsw i64 %83, 1
  %91 = icmp eq i64 %90, %58
  br i1 %91, label %92, label %82, !llvm.loop !15

92:                                               ; preds = %82, %78
  %93 = add nuw nsw i64 %59, 1
  %94 = icmp ult i64 %59, 399
  br i1 %94, label %95, label %98

95:                                               ; preds = %92
  %96 = add nuw nsw i64 %63, 8
  %97 = getelementptr i8, ptr %56, i64 %60
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(1) %97, i8 0, i64 %96, i1 false), !tbaa !5
  br label %98

98:                                               ; preds = %95, %92
  %99 = getelementptr inbounds [400 x double], ptr %3, i64 %59, i64 %59
  store double 1.000000e+00, ptr %99, align 8, !tbaa !5
  %100 = add nuw nsw i64 %58, 1
  %101 = icmp eq i64 %93, 400
  br i1 %101, label %102, label %57, !llvm.loop !16

102:                                              ; preds = %98
  %103 = tail call ptr @polybench_alloc_data(i64 noundef 160000, i32 noundef 8) #8
  %104 = ptrtoint ptr %103 to i64
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(1280000) %103, i8 0, i64 1280000, i1 false), !tbaa !5
  %105 = getelementptr i8, ptr %103, i64 1280000
  %106 = getelementptr i8, ptr %3, i64 1276808
  br label %107

107:                                              ; preds = %167, %102
  %108 = phi i64 [ 0, %102 ], [ %168, %167 ]
  %109 = shl nuw nsw i64 %108, 3
  %110 = getelementptr i8, ptr %3, i64 %109
  %111 = getelementptr i8, ptr %106, i64 %109
  %112 = icmp ult ptr %103, %111
  %113 = icmp ult ptr %110, %105
  %114 = and i1 %112, %113
  br label %115

115:                                              ; preds = %164, %107
  %116 = phi i64 [ 0, %107 ], [ %165, %164 ]
  %117 = getelementptr inbounds [400 x double], ptr %3, i64 %116, i64 %108
  br i1 %114, label %147, label %118

118:                                              ; preds = %115
  %119 = load double, ptr %117, align 8, !tbaa !5, !alias.scope !17
  %120 = insertelement <2 x double> poison, double %119, i64 0
  %121 = shufflevector <2 x double> %120, <2 x double> poison, <2 x i32> zeroinitializer
  br label %122

122:                                              ; preds = %118, %122
  %123 = phi i64 [ %145, %122 ], [ 0, %118 ]
  %124 = or disjoint i64 %123, 1
  %125 = or disjoint i64 %123, 2
  %126 = or disjoint i64 %123, 3
  %127 = getelementptr inbounds [400 x double], ptr %3, i64 %123, i64 %108
  %128 = getelementptr inbounds [400 x double], ptr %3, i64 %124, i64 %108
  %129 = getelementptr inbounds [400 x double], ptr %3, i64 %125, i64 %108
  %130 = getelementptr inbounds [400 x double], ptr %3, i64 %126, i64 %108
  %131 = load double, ptr %127, align 8, !tbaa !5, !alias.scope !20
  %132 = load double, ptr %128, align 8, !tbaa !5, !alias.scope !20
  %133 = insertelement <2 x double> poison, double %131, i64 0
  %134 = insertelement <2 x double> %133, double %132, i64 1
  %135 = load double, ptr %129, align 8, !tbaa !5, !alias.scope !20
  %136 = load double, ptr %130, align 8, !tbaa !5, !alias.scope !20
  %137 = insertelement <2 x double> poison, double %135, i64 0
  %138 = insertelement <2 x double> %137, double %136, i64 1
  %139 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %116, i64 %123
  %140 = getelementptr inbounds double, ptr %139, i64 2
  %141 = load <2 x double>, ptr %139, align 8, !tbaa !5, !alias.scope !22, !noalias !24
  %142 = load <2 x double>, ptr %140, align 8, !tbaa !5, !alias.scope !22, !noalias !24
  %143 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %121, <2 x double> %134, <2 x double> %141)
  %144 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %121, <2 x double> %138, <2 x double> %142)
  store <2 x double> %143, ptr %139, align 8, !tbaa !5, !alias.scope !22, !noalias !24
  store <2 x double> %144, ptr %140, align 8, !tbaa !5, !alias.scope !22, !noalias !24
  %145 = add nuw i64 %123, 4
  %146 = icmp eq i64 %145, 400
  br i1 %146, label %164, label %122, !llvm.loop !25

147:                                              ; preds = %115, %147
  %148 = phi i64 [ %162, %147 ], [ 0, %115 ]
  %149 = load double, ptr %117, align 8, !tbaa !5
  %150 = getelementptr inbounds [400 x double], ptr %3, i64 %148, i64 %108
  %151 = load double, ptr %150, align 8, !tbaa !5
  %152 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %116, i64 %148
  %153 = load double, ptr %152, align 8, !tbaa !5
  %154 = tail call double @llvm.fmuladd.f64(double %149, double %151, double %153)
  store double %154, ptr %152, align 8, !tbaa !5
  %155 = or disjoint i64 %148, 1
  %156 = load double, ptr %117, align 8, !tbaa !5
  %157 = getelementptr inbounds [400 x double], ptr %3, i64 %155, i64 %108
  %158 = load double, ptr %157, align 8, !tbaa !5
  %159 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %116, i64 %155
  %160 = load double, ptr %159, align 8, !tbaa !5
  %161 = tail call double @llvm.fmuladd.f64(double %156, double %158, double %160)
  store double %161, ptr %159, align 8, !tbaa !5
  %162 = add nuw nsw i64 %148, 2
  %163 = icmp eq i64 %162, 400
  br i1 %163, label %164, label %147, !llvm.loop !26

164:                                              ; preds = %122, %147
  %165 = add nuw nsw i64 %116, 1
  %166 = icmp eq i64 %165, 400
  br i1 %166, label %167, label %115, !llvm.loop !27

167:                                              ; preds = %164
  %168 = add nuw nsw i64 %108, 1
  %169 = icmp eq i64 %168, 400
  br i1 %169, label %170, label %107, !llvm.loop !28

170:                                              ; preds = %167
  %171 = sub i64 %4, %104
  %172 = icmp ult i64 %171, 32
  br label %173

173:                                              ; preds = %211, %170
  %174 = phi i64 [ %212, %211 ], [ 0, %170 ]
  br i1 %172, label %192, label %175

175:                                              ; preds = %173, %175
  %176 = phi i64 [ %190, %175 ], [ 0, %173 ]
  %177 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %174, i64 %176
  %178 = getelementptr inbounds double, ptr %177, i64 2
  %179 = load <2 x double>, ptr %177, align 8, !tbaa !5
  %180 = load <2 x double>, ptr %178, align 8, !tbaa !5
  %181 = getelementptr inbounds [400 x double], ptr %3, i64 %174, i64 %176
  %182 = getelementptr inbounds double, ptr %181, i64 2
  store <2 x double> %179, ptr %181, align 8, !tbaa !5
  store <2 x double> %180, ptr %182, align 8, !tbaa !5
  %183 = or disjoint i64 %176, 4
  %184 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %174, i64 %183
  %185 = getelementptr inbounds double, ptr %184, i64 2
  %186 = load <2 x double>, ptr %184, align 8, !tbaa !5
  %187 = load <2 x double>, ptr %185, align 8, !tbaa !5
  %188 = getelementptr inbounds [400 x double], ptr %3, i64 %174, i64 %183
  %189 = getelementptr inbounds double, ptr %188, i64 2
  store <2 x double> %186, ptr %188, align 8, !tbaa !5
  store <2 x double> %187, ptr %189, align 8, !tbaa !5
  %190 = add nuw nsw i64 %176, 8
  %191 = icmp eq i64 %190, 400
  br i1 %191, label %211, label %175, !llvm.loop !29

192:                                              ; preds = %173, %192
  %193 = phi i64 [ %209, %192 ], [ 0, %173 ]
  %194 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %174, i64 %193
  %195 = load double, ptr %194, align 8, !tbaa !5
  %196 = getelementptr inbounds [400 x double], ptr %3, i64 %174, i64 %193
  store double %195, ptr %196, align 8, !tbaa !5
  %197 = or disjoint i64 %193, 1
  %198 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %174, i64 %197
  %199 = load double, ptr %198, align 8, !tbaa !5
  %200 = getelementptr inbounds [400 x double], ptr %3, i64 %174, i64 %197
  store double %199, ptr %200, align 8, !tbaa !5
  %201 = or disjoint i64 %193, 2
  %202 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %174, i64 %201
  %203 = load double, ptr %202, align 8, !tbaa !5
  %204 = getelementptr inbounds [400 x double], ptr %3, i64 %174, i64 %201
  store double %203, ptr %204, align 8, !tbaa !5
  %205 = or disjoint i64 %193, 3
  %206 = getelementptr inbounds [400 x [400 x double]], ptr %103, i64 0, i64 %174, i64 %205
  %207 = load double, ptr %206, align 8, !tbaa !5
  %208 = getelementptr inbounds [400 x double], ptr %3, i64 %174, i64 %205
  store double %207, ptr %208, align 8, !tbaa !5
  %209 = add nuw nsw i64 %193, 4
  %210 = icmp eq i64 %209, 400
  br i1 %210, label %211, label %192, !llvm.loop !30

211:                                              ; preds = %175, %192
  %212 = add nuw nsw i64 %174, 1
  %213 = icmp eq i64 %212, 400
  br i1 %213, label %214, label %173, !llvm.loop !31

214:                                              ; preds = %211
  tail call void @free(ptr noundef nonnull %103) #8
  br label %215

215:                                              ; preds = %312, %214
  %216 = phi i64 [ 0, %214 ], [ %313, %312 ]
  %217 = icmp eq i64 %216, 0
  br i1 %217, label %267, label %218

218:                                              ; preds = %215, %260
  %219 = phi i64 [ %265, %260 ], [ 0, %215 ]
  %220 = getelementptr inbounds [400 x double], ptr %3, i64 %216, i64 %219
  %221 = load double, ptr %220, align 8, !tbaa !5
  %222 = icmp eq i64 %219, 0
  br i1 %222, label %260, label %223

223:                                              ; preds = %218
  %224 = and i64 %219, 1
  %225 = icmp eq i64 %219, 1
  br i1 %225, label %248, label %226

226:                                              ; preds = %223
  %227 = and i64 %219, 9223372036854775806
  br label %228

228:                                              ; preds = %228, %226
  %229 = phi i64 [ 0, %226 ], [ %245, %228 ]
  %230 = phi double [ %221, %226 ], [ %244, %228 ]
  %231 = phi i64 [ 0, %226 ], [ %246, %228 ]
  %232 = getelementptr inbounds [400 x double], ptr %3, i64 %216, i64 %229
  %233 = load double, ptr %232, align 8, !tbaa !5
  %234 = getelementptr inbounds [400 x double], ptr %3, i64 %229, i64 %219
  %235 = load double, ptr %234, align 8, !tbaa !5
  %236 = fneg double %233
  %237 = tail call double @llvm.fmuladd.f64(double %236, double %235, double %230)
  %238 = or disjoint i64 %229, 1
  %239 = getelementptr inbounds [400 x double], ptr %3, i64 %216, i64 %238
  %240 = load double, ptr %239, align 8, !tbaa !5
  %241 = getelementptr inbounds [400 x double], ptr %3, i64 %238, i64 %219
  %242 = load double, ptr %241, align 8, !tbaa !5
  %243 = fneg double %240
  %244 = tail call double @llvm.fmuladd.f64(double %243, double %242, double %237)
  %245 = add nuw nsw i64 %229, 2
  %246 = add i64 %231, 2
  %247 = icmp eq i64 %246, %227
  br i1 %247, label %248, label %228, !llvm.loop !32

248:                                              ; preds = %228, %223
  %249 = phi double [ undef, %223 ], [ %244, %228 ]
  %250 = phi i64 [ 0, %223 ], [ %245, %228 ]
  %251 = phi double [ %221, %223 ], [ %244, %228 ]
  %252 = icmp eq i64 %224, 0
  br i1 %252, label %260, label %253

253:                                              ; preds = %248
  %254 = getelementptr inbounds [400 x double], ptr %3, i64 %216, i64 %250
  %255 = load double, ptr %254, align 8, !tbaa !5
  %256 = getelementptr inbounds [400 x double], ptr %3, i64 %250, i64 %219
  %257 = load double, ptr %256, align 8, !tbaa !5
  %258 = fneg double %255
  %259 = tail call double @llvm.fmuladd.f64(double %258, double %257, double %251)
  br label %260

260:                                              ; preds = %253, %248, %218
  %261 = phi double [ %221, %218 ], [ %249, %248 ], [ %259, %253 ]
  %262 = getelementptr inbounds [400 x double], ptr %3, i64 %219, i64 %219
  %263 = load double, ptr %262, align 8, !tbaa !5
  %264 = fdiv double %261, %263
  store double %264, ptr %220, align 8, !tbaa !5
  %265 = add nuw nsw i64 %219, 1
  %266 = icmp eq i64 %265, %216
  br i1 %266, label %267, label %218, !llvm.loop !33

267:                                              ; preds = %260, %215
  %268 = and i64 %216, 1
  %269 = icmp eq i64 %216, 1
  %270 = and i64 %216, 9223372036854775806
  %271 = icmp eq i64 %268, 0
  br label %272

272:                                              ; preds = %267, %308
  %273 = phi i64 [ %310, %308 ], [ %216, %267 ]
  %274 = getelementptr inbounds [400 x double], ptr %3, i64 %216, i64 %273
  %275 = load double, ptr %274, align 8, !tbaa !5
  br i1 %217, label %308, label %276

276:                                              ; preds = %272
  br i1 %269, label %297, label %277

277:                                              ; preds = %276, %277
  %278 = phi i64 [ %294, %277 ], [ 0, %276 ]
  %279 = phi double [ %293, %277 ], [ %275, %276 ]
  %280 = phi i64 [ %295, %277 ], [ 0, %276 ]
  %281 = getelementptr inbounds [400 x double], ptr %3, i64 %216, i64 %278
  %282 = load double, ptr %281, align 8, !tbaa !5
  %283 = getelementptr inbounds [400 x double], ptr %3, i64 %278, i64 %273
  %284 = load double, ptr %283, align 8, !tbaa !5
  %285 = fneg double %282
  %286 = tail call double @llvm.fmuladd.f64(double %285, double %284, double %279)
  %287 = or disjoint i64 %278, 1
  %288 = getelementptr inbounds [400 x double], ptr %3, i64 %216, i64 %287
  %289 = load double, ptr %288, align 8, !tbaa !5
  %290 = getelementptr inbounds [400 x double], ptr %3, i64 %287, i64 %273
  %291 = load double, ptr %290, align 8, !tbaa !5
  %292 = fneg double %289
  %293 = tail call double @llvm.fmuladd.f64(double %292, double %291, double %286)
  %294 = add nuw nsw i64 %278, 2
  %295 = add i64 %280, 2
  %296 = icmp eq i64 %295, %270
  br i1 %296, label %297, label %277, !llvm.loop !34

297:                                              ; preds = %277, %276
  %298 = phi double [ undef, %276 ], [ %293, %277 ]
  %299 = phi i64 [ 0, %276 ], [ %294, %277 ]
  %300 = phi double [ %275, %276 ], [ %293, %277 ]
  br i1 %271, label %308, label %301

301:                                              ; preds = %297
  %302 = getelementptr inbounds [400 x double], ptr %3, i64 %216, i64 %299
  %303 = load double, ptr %302, align 8, !tbaa !5
  %304 = getelementptr inbounds [400 x double], ptr %3, i64 %299, i64 %273
  %305 = load double, ptr %304, align 8, !tbaa !5
  %306 = fneg double %303
  %307 = tail call double @llvm.fmuladd.f64(double %306, double %305, double %300)
  br label %308

308:                                              ; preds = %301, %297, %272
  %309 = phi double [ %275, %272 ], [ %298, %297 ], [ %307, %301 ]
  store double %309, ptr %274, align 8, !tbaa !5
  %310 = add nuw nsw i64 %273, 1
  %311 = icmp eq i64 %310, 400
  br i1 %311, label %312, label %272, !llvm.loop !35

312:                                              ; preds = %308
  %313 = add nuw nsw i64 %216, 1
  %314 = icmp eq i64 %313, 400
  br i1 %314, label %315, label %215, !llvm.loop !36

315:                                              ; preds = %312, %357
  %316 = phi i64 [ %360, %357 ], [ 0, %312 ]
  %317 = getelementptr inbounds double, ptr %5, i64 %316
  %318 = load double, ptr %317, align 8, !tbaa !5
  %319 = icmp eq i64 %316, 0
  br i1 %319, label %357, label %320

320:                                              ; preds = %315
  %321 = and i64 %316, 1
  %322 = icmp eq i64 %316, 1
  br i1 %322, label %345, label %323

323:                                              ; preds = %320
  %324 = and i64 %316, 9223372036854775806
  br label %325

325:                                              ; preds = %325, %323
  %326 = phi i64 [ 0, %323 ], [ %342, %325 ]
  %327 = phi double [ %318, %323 ], [ %341, %325 ]
  %328 = phi i64 [ 0, %323 ], [ %343, %325 ]
  %329 = getelementptr inbounds [400 x double], ptr %3, i64 %316, i64 %326
  %330 = load double, ptr %329, align 8, !tbaa !5
  %331 = getelementptr inbounds double, ptr %7, i64 %326
  %332 = load double, ptr %331, align 8, !tbaa !5
  %333 = fneg double %330
  %334 = tail call double @llvm.fmuladd.f64(double %333, double %332, double %327)
  %335 = or disjoint i64 %326, 1
  %336 = getelementptr inbounds [400 x double], ptr %3, i64 %316, i64 %335
  %337 = load double, ptr %336, align 8, !tbaa !5
  %338 = getelementptr inbounds double, ptr %7, i64 %335
  %339 = load double, ptr %338, align 8, !tbaa !5
  %340 = fneg double %337
  %341 = tail call double @llvm.fmuladd.f64(double %340, double %339, double %334)
  %342 = add nuw nsw i64 %326, 2
  %343 = add i64 %328, 2
  %344 = icmp eq i64 %343, %324
  br i1 %344, label %345, label %325, !llvm.loop !37

345:                                              ; preds = %325, %320
  %346 = phi double [ undef, %320 ], [ %341, %325 ]
  %347 = phi i64 [ 0, %320 ], [ %342, %325 ]
  %348 = phi double [ %318, %320 ], [ %341, %325 ]
  %349 = icmp eq i64 %321, 0
  br i1 %349, label %357, label %350

350:                                              ; preds = %345
  %351 = getelementptr inbounds [400 x double], ptr %3, i64 %316, i64 %347
  %352 = load double, ptr %351, align 8, !tbaa !5
  %353 = getelementptr inbounds double, ptr %7, i64 %347
  %354 = load double, ptr %353, align 8, !tbaa !5
  %355 = fneg double %352
  %356 = tail call double @llvm.fmuladd.f64(double %355, double %354, double %348)
  br label %357

357:                                              ; preds = %350, %345, %315
  %358 = phi double [ %318, %315 ], [ %346, %345 ], [ %356, %350 ]
  %359 = getelementptr inbounds double, ptr %7, i64 %316
  store double %358, ptr %359, align 8, !tbaa !5
  %360 = add nuw nsw i64 %316, 1
  %361 = icmp eq i64 %360, 400
  br i1 %361, label %362, label %315, !llvm.loop !38

362:                                              ; preds = %357, %402
  %363 = phi i64 [ %410, %402 ], [ 0, %357 ]
  %364 = phi i64 [ %408, %402 ], [ 399, %357 ]
  %365 = getelementptr inbounds double, ptr %7, i64 %364
  %366 = load double, ptr %365, align 8, !tbaa !5
  %367 = icmp ult i64 %364, 399
  br i1 %367, label %368, label %402

368:                                              ; preds = %362
  %369 = and i64 %363, 1
  %370 = icmp eq i64 %369, 0
  br i1 %370, label %379, label %371

371:                                              ; preds = %368
  %372 = add nuw nsw i64 %364, 1
  %373 = getelementptr inbounds [400 x double], ptr %3, i64 %364, i64 %372
  %374 = load double, ptr %373, align 8, !tbaa !5
  %375 = getelementptr inbounds double, ptr %6, i64 %372
  %376 = load double, ptr %375, align 8, !tbaa !5
  %377 = fneg double %374
  %378 = tail call double @llvm.fmuladd.f64(double %377, double %376, double %366)
  br label %379

379:                                              ; preds = %371, %368
  %380 = phi double [ undef, %368 ], [ %378, %371 ]
  %381 = phi i64 [ %364, %368 ], [ %372, %371 ]
  %382 = phi double [ %366, %368 ], [ %378, %371 ]
  %383 = icmp eq i64 %363, 1
  br i1 %383, label %402, label %384

384:                                              ; preds = %379, %384
  %385 = phi i64 [ %394, %384 ], [ %381, %379 ]
  %386 = phi double [ %400, %384 ], [ %382, %379 ]
  %387 = add nuw nsw i64 %385, 1
  %388 = getelementptr inbounds [400 x double], ptr %3, i64 %364, i64 %387
  %389 = load double, ptr %388, align 8, !tbaa !5
  %390 = getelementptr inbounds double, ptr %6, i64 %387
  %391 = load double, ptr %390, align 8, !tbaa !5
  %392 = fneg double %389
  %393 = tail call double @llvm.fmuladd.f64(double %392, double %391, double %386)
  %394 = add nuw nsw i64 %385, 2
  %395 = getelementptr inbounds [400 x double], ptr %3, i64 %364, i64 %394
  %396 = load double, ptr %395, align 8, !tbaa !5
  %397 = getelementptr inbounds double, ptr %6, i64 %394
  %398 = load double, ptr %397, align 8, !tbaa !5
  %399 = fneg double %396
  %400 = tail call double @llvm.fmuladd.f64(double %399, double %398, double %393)
  %401 = icmp eq i64 %394, 399
  br i1 %401, label %402, label %384, !llvm.loop !39

402:                                              ; preds = %379, %384, %362
  %403 = phi double [ %366, %362 ], [ %380, %379 ], [ %400, %384 ]
  %404 = getelementptr inbounds [400 x double], ptr %3, i64 %364, i64 %364
  %405 = load double, ptr %404, align 8, !tbaa !5
  %406 = fdiv double %403, %405
  %407 = getelementptr inbounds double, ptr %6, i64 %364
  store double %406, ptr %407, align 8, !tbaa !5
  %408 = add nsw i64 %364, -1
  %409 = icmp eq i64 %364, 0
  %410 = add i64 %363, 1
  br i1 %409, label %411, label %362, !llvm.loop !40

411:                                              ; preds = %402
  %412 = icmp sgt i32 %0, 42
  br i1 %412, label %413, label %442

413:                                              ; preds = %411
  %414 = load ptr, ptr %1, align 8, !tbaa !41
  %415 = load i8, ptr %414, align 1
  %416 = icmp eq i8 %415, 0
  br i1 %416, label %417, label %442

417:                                              ; preds = %413
  %418 = load ptr, ptr @stderr, align 8, !tbaa !41
  %419 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %418) #9
  %420 = load ptr, ptr @stderr, align 8, !tbaa !41
  %421 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %420, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #9
  br label %422

422:                                              ; preds = %430, %417
  %423 = phi i64 [ 0, %417 ], [ %435, %430 ]
  %424 = trunc i64 %423 to i16
  %425 = urem i16 %424, 20
  %426 = icmp eq i16 %425, 0
  br i1 %426, label %427, label %430

427:                                              ; preds = %422
  %428 = load ptr, ptr @stderr, align 8, !tbaa !41
  %429 = tail call i32 @fputc(i32 10, ptr %428)
  br label %430

430:                                              ; preds = %427, %422
  %431 = load ptr, ptr @stderr, align 8, !tbaa !41
  %432 = getelementptr inbounds double, ptr %6, i64 %423
  %433 = load double, ptr %432, align 8, !tbaa !5
  %434 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %431, ptr noundef nonnull @.str.5, double noundef %433) #9
  %435 = add nuw nsw i64 %423, 1
  %436 = icmp eq i64 %435, 400
  br i1 %436, label %437, label %422, !llvm.loop !43

437:                                              ; preds = %430
  %438 = load ptr, ptr @stderr, align 8, !tbaa !41
  %439 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %438, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #9
  %440 = load ptr, ptr @stderr, align 8, !tbaa !41
  %441 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %440) #9
  br label %442

442:                                              ; preds = %437, %413, %411
  tail call void @free(ptr noundef %3) #8
  tail call void @free(ptr noundef %5) #8
  tail call void @free(ptr noundef nonnull %6) #8
  tail call void @free(ptr noundef %7) #8
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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #7

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nounwind }
attributes #9 = { cold }

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
!14 = distinct !{!14, !10, !11, !12}
!15 = distinct !{!15, !10, !12, !11}
!16 = distinct !{!16, !10}
!17 = !{!18}
!18 = distinct !{!18, !19}
!19 = distinct !{!19, !"LVerDomain"}
!20 = !{!21}
!21 = distinct !{!21, !19}
!22 = !{!23}
!23 = distinct !{!23, !19}
!24 = !{!21, !18}
!25 = distinct !{!25, !10, !11, !12}
!26 = distinct !{!26, !10, !11}
!27 = distinct !{!27, !10}
!28 = distinct !{!28, !10}
!29 = distinct !{!29, !10, !11, !12}
!30 = distinct !{!30, !10, !11}
!31 = distinct !{!31, !10}
!32 = distinct !{!32, !10}
!33 = distinct !{!33, !10}
!34 = distinct !{!34, !10}
!35 = distinct !{!35, !10}
!36 = distinct !{!36, !10}
!37 = distinct !{!37, !10}
!38 = distinct !{!38, !10}
!39 = distinct !{!39, !10}
!40 = distinct !{!40, !10}
!41 = !{!42, !42, i64 0}
!42 = !{!"any pointer", !7, i64 0}
!43 = distinct !{!43, !10}
