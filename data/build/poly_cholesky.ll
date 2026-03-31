; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/solvers/cholesky/cholesky.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/solvers/cholesky/cholesky.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 160000, i32 noundef 8) #9
  %4 = ptrtoint ptr %3 to i64
  %5 = getelementptr i8, ptr %3, i64 8
  br label %6

6:                                                ; preds = %47, %2
  %7 = phi i64 [ 1, %2 ], [ %49, %47 ]
  %8 = phi i64 [ 0, %2 ], [ %42, %47 ]
  %9 = mul nuw nsw i64 %8, 3208
  %10 = shl i64 %8, 3
  %11 = sub nsw i64 3184, %10
  %12 = and i64 %11, 34359738360
  %13 = icmp ult i64 %7, 2
  br i1 %13, label %29, label %14

14:                                               ; preds = %6
  %15 = and i64 %7, 9223372036854775806
  br label %16

16:                                               ; preds = %16, %14
  %17 = phi i64 [ 0, %14 ], [ %24, %16 ]
  %18 = phi <2 x i32> [ <i32 0, i32 1>, %14 ], [ %25, %16 ]
  %19 = sub <2 x i32> zeroinitializer, %18
  %20 = sitofp <2 x i32> %19 to <2 x double>
  %21 = fdiv <2 x double> %20, <double 4.000000e+02, double 4.000000e+02>
  %22 = fadd <2 x double> %21, <double 1.000000e+00, double 1.000000e+00>
  %23 = getelementptr inbounds [400 x double], ptr %3, i64 %8, i64 %17
  store <2 x double> %22, ptr %23, align 8, !tbaa !5
  %24 = add nuw i64 %17, 2
  %25 = add <2 x i32> %18, <i32 2, i32 2>
  %26 = icmp eq i64 %24, %15
  br i1 %26, label %27, label %16, !llvm.loop !9

27:                                               ; preds = %16
  %28 = icmp eq i64 %7, %15
  br i1 %28, label %41, label %29

29:                                               ; preds = %6, %27
  %30 = phi i64 [ 0, %6 ], [ %15, %27 ]
  br label %31

31:                                               ; preds = %29, %31
  %32 = phi i64 [ %39, %31 ], [ %30, %29 ]
  %33 = trunc i64 %32 to i32
  %34 = sub i32 0, %33
  %35 = sitofp i32 %34 to double
  %36 = fdiv double %35, 4.000000e+02
  %37 = fadd double %36, 1.000000e+00
  %38 = getelementptr inbounds [400 x double], ptr %3, i64 %8, i64 %32
  store double %37, ptr %38, align 8, !tbaa !5
  %39 = add nuw nsw i64 %32, 1
  %40 = icmp eq i64 %39, %7
  br i1 %40, label %41, label %31, !llvm.loop !13

41:                                               ; preds = %31, %27
  %42 = add nuw nsw i64 %8, 1
  %43 = icmp ult i64 %8, 399
  br i1 %43, label %44, label %47

44:                                               ; preds = %41
  %45 = add nuw nsw i64 %12, 8
  %46 = getelementptr i8, ptr %5, i64 %9
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(1) %46, i8 0, i64 %45, i1 false), !tbaa !5
  br label %47

47:                                               ; preds = %44, %41
  %48 = getelementptr inbounds [400 x double], ptr %3, i64 %8, i64 %8
  store double 1.000000e+00, ptr %48, align 8, !tbaa !5
  %49 = add nuw nsw i64 %7, 1
  %50 = icmp eq i64 %42, 400
  br i1 %50, label %51, label %6, !llvm.loop !14

51:                                               ; preds = %47
  %52 = tail call ptr @polybench_alloc_data(i64 noundef 160000, i32 noundef 8) #9
  %53 = ptrtoint ptr %52 to i64
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(1280000) %52, i8 0, i64 1280000, i1 false), !tbaa !5
  %54 = getelementptr i8, ptr %52, i64 1280000
  %55 = getelementptr i8, ptr %3, i64 1276808
  br label %56

56:                                               ; preds = %116, %51
  %57 = phi i64 [ 0, %51 ], [ %117, %116 ]
  %58 = shl nuw nsw i64 %57, 3
  %59 = getelementptr i8, ptr %3, i64 %58
  %60 = getelementptr i8, ptr %55, i64 %58
  %61 = icmp ult ptr %52, %60
  %62 = icmp ult ptr %59, %54
  %63 = and i1 %61, %62
  br label %64

64:                                               ; preds = %113, %56
  %65 = phi i64 [ 0, %56 ], [ %114, %113 ]
  %66 = getelementptr inbounds [400 x double], ptr %3, i64 %65, i64 %57
  br i1 %63, label %96, label %67

67:                                               ; preds = %64
  %68 = load double, ptr %66, align 8, !tbaa !5, !alias.scope !15
  %69 = insertelement <2 x double> poison, double %68, i64 0
  %70 = shufflevector <2 x double> %69, <2 x double> poison, <2 x i32> zeroinitializer
  br label %71

71:                                               ; preds = %67, %71
  %72 = phi i64 [ %94, %71 ], [ 0, %67 ]
  %73 = or disjoint i64 %72, 1
  %74 = or disjoint i64 %72, 2
  %75 = or disjoint i64 %72, 3
  %76 = getelementptr inbounds [400 x double], ptr %3, i64 %72, i64 %57
  %77 = getelementptr inbounds [400 x double], ptr %3, i64 %73, i64 %57
  %78 = getelementptr inbounds [400 x double], ptr %3, i64 %74, i64 %57
  %79 = getelementptr inbounds [400 x double], ptr %3, i64 %75, i64 %57
  %80 = load double, ptr %76, align 8, !tbaa !5, !alias.scope !18
  %81 = load double, ptr %77, align 8, !tbaa !5, !alias.scope !18
  %82 = insertelement <2 x double> poison, double %80, i64 0
  %83 = insertelement <2 x double> %82, double %81, i64 1
  %84 = load double, ptr %78, align 8, !tbaa !5, !alias.scope !18
  %85 = load double, ptr %79, align 8, !tbaa !5, !alias.scope !18
  %86 = insertelement <2 x double> poison, double %84, i64 0
  %87 = insertelement <2 x double> %86, double %85, i64 1
  %88 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %65, i64 %72
  %89 = getelementptr inbounds double, ptr %88, i64 2
  %90 = load <2 x double>, ptr %88, align 8, !tbaa !5, !alias.scope !20, !noalias !22
  %91 = load <2 x double>, ptr %89, align 8, !tbaa !5, !alias.scope !20, !noalias !22
  %92 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %70, <2 x double> %83, <2 x double> %90)
  %93 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %70, <2 x double> %87, <2 x double> %91)
  store <2 x double> %92, ptr %88, align 8, !tbaa !5, !alias.scope !20, !noalias !22
  store <2 x double> %93, ptr %89, align 8, !tbaa !5, !alias.scope !20, !noalias !22
  %94 = add nuw i64 %72, 4
  %95 = icmp eq i64 %94, 400
  br i1 %95, label %113, label %71, !llvm.loop !23

96:                                               ; preds = %64, %96
  %97 = phi i64 [ %111, %96 ], [ 0, %64 ]
  %98 = load double, ptr %66, align 8, !tbaa !5
  %99 = getelementptr inbounds [400 x double], ptr %3, i64 %97, i64 %57
  %100 = load double, ptr %99, align 8, !tbaa !5
  %101 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %65, i64 %97
  %102 = load double, ptr %101, align 8, !tbaa !5
  %103 = tail call double @llvm.fmuladd.f64(double %98, double %100, double %102)
  store double %103, ptr %101, align 8, !tbaa !5
  %104 = or disjoint i64 %97, 1
  %105 = load double, ptr %66, align 8, !tbaa !5
  %106 = getelementptr inbounds [400 x double], ptr %3, i64 %104, i64 %57
  %107 = load double, ptr %106, align 8, !tbaa !5
  %108 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %65, i64 %104
  %109 = load double, ptr %108, align 8, !tbaa !5
  %110 = tail call double @llvm.fmuladd.f64(double %105, double %107, double %109)
  store double %110, ptr %108, align 8, !tbaa !5
  %111 = add nuw nsw i64 %97, 2
  %112 = icmp eq i64 %111, 400
  br i1 %112, label %113, label %96, !llvm.loop !24

113:                                              ; preds = %71, %96
  %114 = add nuw nsw i64 %65, 1
  %115 = icmp eq i64 %114, 400
  br i1 %115, label %116, label %64, !llvm.loop !25

116:                                              ; preds = %113
  %117 = add nuw nsw i64 %57, 1
  %118 = icmp eq i64 %117, 400
  br i1 %118, label %119, label %56, !llvm.loop !26

119:                                              ; preds = %116
  %120 = sub i64 %4, %53
  %121 = icmp ult i64 %120, 32
  br label %122

122:                                              ; preds = %160, %119
  %123 = phi i64 [ %161, %160 ], [ 0, %119 ]
  br i1 %121, label %141, label %124

124:                                              ; preds = %122, %124
  %125 = phi i64 [ %139, %124 ], [ 0, %122 ]
  %126 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %123, i64 %125
  %127 = getelementptr inbounds double, ptr %126, i64 2
  %128 = load <2 x double>, ptr %126, align 8, !tbaa !5
  %129 = load <2 x double>, ptr %127, align 8, !tbaa !5
  %130 = getelementptr inbounds [400 x double], ptr %3, i64 %123, i64 %125
  %131 = getelementptr inbounds double, ptr %130, i64 2
  store <2 x double> %128, ptr %130, align 8, !tbaa !5
  store <2 x double> %129, ptr %131, align 8, !tbaa !5
  %132 = or disjoint i64 %125, 4
  %133 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %123, i64 %132
  %134 = getelementptr inbounds double, ptr %133, i64 2
  %135 = load <2 x double>, ptr %133, align 8, !tbaa !5
  %136 = load <2 x double>, ptr %134, align 8, !tbaa !5
  %137 = getelementptr inbounds [400 x double], ptr %3, i64 %123, i64 %132
  %138 = getelementptr inbounds double, ptr %137, i64 2
  store <2 x double> %135, ptr %137, align 8, !tbaa !5
  store <2 x double> %136, ptr %138, align 8, !tbaa !5
  %139 = add nuw nsw i64 %125, 8
  %140 = icmp eq i64 %139, 400
  br i1 %140, label %160, label %124, !llvm.loop !27

141:                                              ; preds = %122, %141
  %142 = phi i64 [ %158, %141 ], [ 0, %122 ]
  %143 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %123, i64 %142
  %144 = load double, ptr %143, align 8, !tbaa !5
  %145 = getelementptr inbounds [400 x double], ptr %3, i64 %123, i64 %142
  store double %144, ptr %145, align 8, !tbaa !5
  %146 = or disjoint i64 %142, 1
  %147 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %123, i64 %146
  %148 = load double, ptr %147, align 8, !tbaa !5
  %149 = getelementptr inbounds [400 x double], ptr %3, i64 %123, i64 %146
  store double %148, ptr %149, align 8, !tbaa !5
  %150 = or disjoint i64 %142, 2
  %151 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %123, i64 %150
  %152 = load double, ptr %151, align 8, !tbaa !5
  %153 = getelementptr inbounds [400 x double], ptr %3, i64 %123, i64 %150
  store double %152, ptr %153, align 8, !tbaa !5
  %154 = or disjoint i64 %142, 3
  %155 = getelementptr inbounds [400 x [400 x double]], ptr %52, i64 0, i64 %123, i64 %154
  %156 = load double, ptr %155, align 8, !tbaa !5
  %157 = getelementptr inbounds [400 x double], ptr %3, i64 %123, i64 %154
  store double %156, ptr %157, align 8, !tbaa !5
  %158 = add nuw nsw i64 %142, 4
  %159 = icmp eq i64 %158, 400
  br i1 %159, label %160, label %141, !llvm.loop !28

160:                                              ; preds = %124, %141
  %161 = add nuw nsw i64 %123, 1
  %162 = icmp eq i64 %161, 400
  br i1 %162, label %163, label %122, !llvm.loop !29

163:                                              ; preds = %160
  tail call void @free(ptr noundef nonnull %52) #9
  br label %164

164:                                              ; preds = %256, %163
  %165 = phi i64 [ 0, %163 ], [ %260, %256 ]
  %166 = icmp eq i64 %165, 0
  br i1 %166, label %169, label %167

167:                                              ; preds = %164
  %168 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 0
  br label %178

169:                                              ; preds = %164
  %170 = load double, ptr %3, align 8, !tbaa !5
  br label %256

171:                                              ; preds = %222
  %172 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %165
  %173 = load double, ptr %172, align 8, !tbaa !5
  %174 = and i64 %165, 1
  %175 = icmp eq i64 %165, 1
  br i1 %175, label %246, label %176

176:                                              ; preds = %171
  %177 = and i64 %165, 9223372036854775806
  br label %230

178:                                              ; preds = %222, %167
  %179 = phi i64 [ 0, %167 ], [ %228, %222 ]
  %180 = icmp eq i64 %179, 0
  br i1 %180, label %181, label %183

181:                                              ; preds = %178
  %182 = load double, ptr %168, align 8, !tbaa !5
  br label %222

183:                                              ; preds = %178
  %184 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %179
  %185 = load double, ptr %184, align 8, !tbaa !5
  %186 = and i64 %179, 1
  %187 = icmp eq i64 %179, 1
  br i1 %187, label %210, label %188

188:                                              ; preds = %183
  %189 = and i64 %179, 9223372036854775806
  br label %190

190:                                              ; preds = %190, %188
  %191 = phi i64 [ 0, %188 ], [ %207, %190 ]
  %192 = phi double [ %185, %188 ], [ %206, %190 ]
  %193 = phi i64 [ 0, %188 ], [ %208, %190 ]
  %194 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %191
  %195 = load double, ptr %194, align 8, !tbaa !5
  %196 = getelementptr inbounds [400 x double], ptr %3, i64 %179, i64 %191
  %197 = load double, ptr %196, align 8, !tbaa !5
  %198 = fneg double %195
  %199 = tail call double @llvm.fmuladd.f64(double %198, double %197, double %192)
  store double %199, ptr %184, align 8, !tbaa !5
  %200 = or disjoint i64 %191, 1
  %201 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %200
  %202 = load double, ptr %201, align 8, !tbaa !5
  %203 = getelementptr inbounds [400 x double], ptr %3, i64 %179, i64 %200
  %204 = load double, ptr %203, align 8, !tbaa !5
  %205 = fneg double %202
  %206 = tail call double @llvm.fmuladd.f64(double %205, double %204, double %199)
  store double %206, ptr %184, align 8, !tbaa !5
  %207 = add nuw nsw i64 %191, 2
  %208 = add i64 %193, 2
  %209 = icmp eq i64 %208, %189
  br i1 %209, label %210, label %190, !llvm.loop !30

210:                                              ; preds = %190, %183
  %211 = phi double [ undef, %183 ], [ %206, %190 ]
  %212 = phi i64 [ 0, %183 ], [ %207, %190 ]
  %213 = phi double [ %185, %183 ], [ %206, %190 ]
  %214 = icmp eq i64 %186, 0
  br i1 %214, label %222, label %215

215:                                              ; preds = %210
  %216 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %212
  %217 = load double, ptr %216, align 8, !tbaa !5
  %218 = getelementptr inbounds [400 x double], ptr %3, i64 %179, i64 %212
  %219 = load double, ptr %218, align 8, !tbaa !5
  %220 = fneg double %217
  %221 = tail call double @llvm.fmuladd.f64(double %220, double %219, double %213)
  store double %221, ptr %184, align 8, !tbaa !5
  br label %222

222:                                              ; preds = %215, %210, %181
  %223 = phi double [ %182, %181 ], [ %211, %210 ], [ %221, %215 ]
  %224 = getelementptr inbounds [400 x double], ptr %3, i64 %179, i64 %179
  %225 = load double, ptr %224, align 8, !tbaa !5
  %226 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %179
  %227 = fdiv double %223, %225
  store double %227, ptr %226, align 8, !tbaa !5
  %228 = add nuw nsw i64 %179, 1
  %229 = icmp eq i64 %228, %165
  br i1 %229, label %171, label %178, !llvm.loop !31

230:                                              ; preds = %230, %176
  %231 = phi i64 [ 0, %176 ], [ %243, %230 ]
  %232 = phi double [ %173, %176 ], [ %242, %230 ]
  %233 = phi i64 [ 0, %176 ], [ %244, %230 ]
  %234 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %231
  %235 = load double, ptr %234, align 8, !tbaa !5
  %236 = fneg double %235
  %237 = tail call double @llvm.fmuladd.f64(double %236, double %235, double %232)
  store double %237, ptr %172, align 8, !tbaa !5
  %238 = or disjoint i64 %231, 1
  %239 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %238
  %240 = load double, ptr %239, align 8, !tbaa !5
  %241 = fneg double %240
  %242 = tail call double @llvm.fmuladd.f64(double %241, double %240, double %237)
  store double %242, ptr %172, align 8, !tbaa !5
  %243 = add nuw nsw i64 %231, 2
  %244 = add i64 %233, 2
  %245 = icmp eq i64 %244, %177
  br i1 %245, label %246, label %230, !llvm.loop !32

246:                                              ; preds = %230, %171
  %247 = phi double [ undef, %171 ], [ %242, %230 ]
  %248 = phi i64 [ 0, %171 ], [ %243, %230 ]
  %249 = phi double [ %173, %171 ], [ %242, %230 ]
  %250 = icmp eq i64 %174, 0
  br i1 %250, label %256, label %251

251:                                              ; preds = %246
  %252 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %248
  %253 = load double, ptr %252, align 8, !tbaa !5
  %254 = fneg double %253
  %255 = tail call double @llvm.fmuladd.f64(double %254, double %253, double %249)
  store double %255, ptr %172, align 8, !tbaa !5
  br label %256

256:                                              ; preds = %251, %246, %169
  %257 = phi double [ %170, %169 ], [ %247, %246 ], [ %255, %251 ]
  %258 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %165
  %259 = tail call double @sqrt(double noundef %257) #9
  store double %259, ptr %258, align 8, !tbaa !5
  %260 = add nuw nsw i64 %165, 1
  %261 = icmp eq i64 %260, 400
  br i1 %261, label %262, label %164, !llvm.loop !33

262:                                              ; preds = %256
  %263 = icmp sgt i32 %0, 42
  br i1 %263, label %264, label %302

264:                                              ; preds = %262
  %265 = load ptr, ptr %1, align 8, !tbaa !34
  %266 = load i8, ptr %265, align 1
  %267 = icmp eq i8 %266, 0
  br i1 %267, label %268, label %302

268:                                              ; preds = %264
  %269 = load ptr, ptr @stderr, align 8, !tbaa !34
  %270 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %269) #10
  %271 = load ptr, ptr @stderr, align 8, !tbaa !34
  %272 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %271, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #10
  br label %273

273:                                              ; preds = %293, %268
  %274 = phi i64 [ 0, %268 ], [ %294, %293 ]
  %275 = phi i64 [ 1, %268 ], [ %295, %293 ]
  %276 = mul nuw nsw i64 %274, 400
  br label %277

277:                                              ; preds = %286, %273
  %278 = phi i64 [ 0, %273 ], [ %291, %286 ]
  %279 = add nuw nsw i64 %278, %276
  %280 = trunc i64 %279 to i32
  %281 = urem i32 %280, 20
  %282 = icmp eq i32 %281, 0
  br i1 %282, label %283, label %286

283:                                              ; preds = %277
  %284 = load ptr, ptr @stderr, align 8, !tbaa !34
  %285 = tail call i32 @fputc(i32 10, ptr %284)
  br label %286

286:                                              ; preds = %283, %277
  %287 = load ptr, ptr @stderr, align 8, !tbaa !34
  %288 = getelementptr inbounds [400 x double], ptr %3, i64 %274, i64 %278
  %289 = load double, ptr %288, align 8, !tbaa !5
  %290 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %287, ptr noundef nonnull @.str.5, double noundef %289) #10
  %291 = add nuw nsw i64 %278, 1
  %292 = icmp eq i64 %291, %275
  br i1 %292, label %293, label %277, !llvm.loop !36

293:                                              ; preds = %286
  %294 = add nuw nsw i64 %274, 1
  %295 = add nuw nsw i64 %275, 1
  %296 = icmp eq i64 %294, 400
  br i1 %296, label %297, label %273, !llvm.loop !37

297:                                              ; preds = %293
  %298 = load ptr, ptr @stderr, align 8, !tbaa !34
  %299 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %298, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #10
  %300 = load ptr, ptr @stderr, align 8, !tbaa !34
  %301 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %300) #10
  br label %302

302:                                              ; preds = %297, %264, %262
  tail call void @free(ptr noundef nonnull %3) #9
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare double @sqrt(double noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #8

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { mustprogress nofree nounwind willreturn memory(write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nounwind }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind }
attributes #10 = { cold }

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
!13 = distinct !{!13, !10, !12, !11}
!14 = distinct !{!14, !10}
!15 = !{!16}
!16 = distinct !{!16, !17}
!17 = distinct !{!17, !"LVerDomain"}
!18 = !{!19}
!19 = distinct !{!19, !17}
!20 = !{!21}
!21 = distinct !{!21, !17}
!22 = !{!19, !16}
!23 = distinct !{!23, !10, !11, !12}
!24 = distinct !{!24, !10, !11}
!25 = distinct !{!25, !10}
!26 = distinct !{!26, !10}
!27 = distinct !{!27, !10, !11, !12}
!28 = distinct !{!28, !10, !11}
!29 = distinct !{!29, !10}
!30 = distinct !{!30, !10}
!31 = distinct !{!31, !10}
!32 = distinct !{!32, !10}
!33 = distinct !{!33, !10}
!34 = !{!35, !35, i64 0}
!35 = !{!"any pointer", !7, i64 0}
!36 = distinct !{!36, !10}
!37 = distinct !{!37, !10}
