; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/solvers/lu/lu.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/solvers/lu/lu.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 160000, i32 noundef 8) #8
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
  %52 = tail call ptr @polybench_alloc_data(i64 noundef 160000, i32 noundef 8) #8
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
  tail call void @free(ptr noundef nonnull %52) #8
  br label %164

164:                                              ; preds = %264, %163
  %165 = phi i64 [ 0, %163 ], [ %265, %264 ]
  %166 = icmp eq i64 %165, 0
  br i1 %166, label %221, label %167

167:                                              ; preds = %164
  %168 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 0
  br label %169

169:                                              ; preds = %213, %167
  %170 = phi i64 [ 0, %167 ], [ %219, %213 ]
  %171 = icmp eq i64 %170, 0
  br i1 %171, label %172, label %174

172:                                              ; preds = %169
  %173 = load double, ptr %168, align 8, !tbaa !5
  br label %213

174:                                              ; preds = %169
  %175 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %170
  %176 = load double, ptr %175, align 8, !tbaa !5
  %177 = and i64 %170, 1
  %178 = icmp eq i64 %170, 1
  br i1 %178, label %201, label %179

179:                                              ; preds = %174
  %180 = and i64 %170, 9223372036854775806
  br label %181

181:                                              ; preds = %181, %179
  %182 = phi i64 [ 0, %179 ], [ %198, %181 ]
  %183 = phi double [ %176, %179 ], [ %197, %181 ]
  %184 = phi i64 [ 0, %179 ], [ %199, %181 ]
  %185 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %182
  %186 = load double, ptr %185, align 8, !tbaa !5
  %187 = getelementptr inbounds [400 x double], ptr %3, i64 %182, i64 %170
  %188 = load double, ptr %187, align 8, !tbaa !5
  %189 = fneg double %186
  %190 = tail call double @llvm.fmuladd.f64(double %189, double %188, double %183)
  store double %190, ptr %175, align 8, !tbaa !5
  %191 = or disjoint i64 %182, 1
  %192 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %191
  %193 = load double, ptr %192, align 8, !tbaa !5
  %194 = getelementptr inbounds [400 x double], ptr %3, i64 %191, i64 %170
  %195 = load double, ptr %194, align 8, !tbaa !5
  %196 = fneg double %193
  %197 = tail call double @llvm.fmuladd.f64(double %196, double %195, double %190)
  store double %197, ptr %175, align 8, !tbaa !5
  %198 = add nuw nsw i64 %182, 2
  %199 = add i64 %184, 2
  %200 = icmp eq i64 %199, %180
  br i1 %200, label %201, label %181, !llvm.loop !30

201:                                              ; preds = %181, %174
  %202 = phi double [ undef, %174 ], [ %197, %181 ]
  %203 = phi i64 [ 0, %174 ], [ %198, %181 ]
  %204 = phi double [ %176, %174 ], [ %197, %181 ]
  %205 = icmp eq i64 %177, 0
  br i1 %205, label %213, label %206

206:                                              ; preds = %201
  %207 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %203
  %208 = load double, ptr %207, align 8, !tbaa !5
  %209 = getelementptr inbounds [400 x double], ptr %3, i64 %203, i64 %170
  %210 = load double, ptr %209, align 8, !tbaa !5
  %211 = fneg double %208
  %212 = tail call double @llvm.fmuladd.f64(double %211, double %210, double %204)
  store double %212, ptr %175, align 8, !tbaa !5
  br label %213

213:                                              ; preds = %206, %201, %172
  %214 = phi double [ %173, %172 ], [ %202, %201 ], [ %212, %206 ]
  %215 = getelementptr inbounds [400 x double], ptr %3, i64 %170, i64 %170
  %216 = load double, ptr %215, align 8, !tbaa !5
  %217 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %170
  %218 = fdiv double %214, %216
  store double %218, ptr %217, align 8, !tbaa !5
  %219 = add nuw nsw i64 %170, 1
  %220 = icmp eq i64 %219, %165
  br i1 %220, label %221, label %169, !llvm.loop !31

221:                                              ; preds = %213, %164
  %222 = and i64 %165, 1
  %223 = icmp eq i64 %165, 1
  %224 = and i64 %165, 9223372036854775806
  %225 = icmp eq i64 %222, 0
  br label %226

226:                                              ; preds = %221, %261
  %227 = phi i64 [ %262, %261 ], [ %165, %221 ]
  br i1 %166, label %261, label %228

228:                                              ; preds = %226
  %229 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %227
  %230 = load double, ptr %229, align 8, !tbaa !5
  br i1 %223, label %251, label %231

231:                                              ; preds = %228, %231
  %232 = phi i64 [ %248, %231 ], [ 0, %228 ]
  %233 = phi double [ %247, %231 ], [ %230, %228 ]
  %234 = phi i64 [ %249, %231 ], [ 0, %228 ]
  %235 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %232
  %236 = load double, ptr %235, align 8, !tbaa !5
  %237 = getelementptr inbounds [400 x double], ptr %3, i64 %232, i64 %227
  %238 = load double, ptr %237, align 8, !tbaa !5
  %239 = fneg double %236
  %240 = tail call double @llvm.fmuladd.f64(double %239, double %238, double %233)
  store double %240, ptr %229, align 8, !tbaa !5
  %241 = or disjoint i64 %232, 1
  %242 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %241
  %243 = load double, ptr %242, align 8, !tbaa !5
  %244 = getelementptr inbounds [400 x double], ptr %3, i64 %241, i64 %227
  %245 = load double, ptr %244, align 8, !tbaa !5
  %246 = fneg double %243
  %247 = tail call double @llvm.fmuladd.f64(double %246, double %245, double %240)
  store double %247, ptr %229, align 8, !tbaa !5
  %248 = add nuw nsw i64 %232, 2
  %249 = add i64 %234, 2
  %250 = icmp eq i64 %249, %224
  br i1 %250, label %251, label %231, !llvm.loop !32

251:                                              ; preds = %231, %228
  %252 = phi i64 [ 0, %228 ], [ %248, %231 ]
  %253 = phi double [ %230, %228 ], [ %247, %231 ]
  br i1 %225, label %261, label %254

254:                                              ; preds = %251
  %255 = getelementptr inbounds [400 x double], ptr %3, i64 %165, i64 %252
  %256 = load double, ptr %255, align 8, !tbaa !5
  %257 = getelementptr inbounds [400 x double], ptr %3, i64 %252, i64 %227
  %258 = load double, ptr %257, align 8, !tbaa !5
  %259 = fneg double %256
  %260 = tail call double @llvm.fmuladd.f64(double %259, double %258, double %253)
  store double %260, ptr %229, align 8, !tbaa !5
  br label %261

261:                                              ; preds = %254, %251, %226
  %262 = add nuw nsw i64 %227, 1
  %263 = icmp eq i64 %262, 400
  br i1 %263, label %264, label %226, !llvm.loop !33

264:                                              ; preds = %261
  %265 = add nuw nsw i64 %165, 1
  %266 = icmp eq i64 %265, 400
  br i1 %266, label %267, label %164, !llvm.loop !34

267:                                              ; preds = %264
  %268 = icmp sgt i32 %0, 42
  br i1 %268, label %269, label %305

269:                                              ; preds = %267
  %270 = load ptr, ptr %1, align 8, !tbaa !35
  %271 = load i8, ptr %270, align 1
  %272 = icmp eq i8 %271, 0
  br i1 %272, label %273, label %305

273:                                              ; preds = %269
  %274 = load ptr, ptr @stderr, align 8, !tbaa !35
  %275 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %274) #9
  %276 = load ptr, ptr @stderr, align 8, !tbaa !35
  %277 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %276, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #9
  br label %278

278:                                              ; preds = %297, %273
  %279 = phi i64 [ 0, %273 ], [ %298, %297 ]
  %280 = mul nuw nsw i64 %279, 400
  br label %281

281:                                              ; preds = %290, %278
  %282 = phi i64 [ 0, %278 ], [ %295, %290 ]
  %283 = add nuw nsw i64 %282, %280
  %284 = trunc i64 %283 to i32
  %285 = urem i32 %284, 20
  %286 = icmp eq i32 %285, 0
  br i1 %286, label %287, label %290

287:                                              ; preds = %281
  %288 = load ptr, ptr @stderr, align 8, !tbaa !35
  %289 = tail call i32 @fputc(i32 10, ptr %288)
  br label %290

290:                                              ; preds = %287, %281
  %291 = load ptr, ptr @stderr, align 8, !tbaa !35
  %292 = getelementptr inbounds [400 x double], ptr %3, i64 %279, i64 %282
  %293 = load double, ptr %292, align 8, !tbaa !5
  %294 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %291, ptr noundef nonnull @.str.5, double noundef %293) #9
  %295 = add nuw nsw i64 %282, 1
  %296 = icmp eq i64 %295, 400
  br i1 %296, label %297, label %281, !llvm.loop !37

297:                                              ; preds = %290
  %298 = add nuw nsw i64 %279, 1
  %299 = icmp eq i64 %298, 400
  br i1 %299, label %300, label %278, !llvm.loop !38

300:                                              ; preds = %297
  %301 = load ptr, ptr @stderr, align 8, !tbaa !35
  %302 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %301, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #9
  %303 = load ptr, ptr @stderr, align 8, !tbaa !35
  %304 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %303) #9
  br label %305

305:                                              ; preds = %300, %269, %267
  tail call void @free(ptr noundef %3) #8
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
!34 = distinct !{!34, !10}
!35 = !{!36, !36, i64 0}
!36 = !{!"any pointer", !7, i64 0}
!37 = distinct !{!37, !10}
!38 = distinct !{!38, !10}
