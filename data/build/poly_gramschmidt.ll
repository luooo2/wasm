; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/solvers/gramschmidt/gramschmidt.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/solvers/gramschmidt/gramschmidt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"R\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"Q\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #9
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 57600, i32 noundef 8) #9
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #9
  %7 = ptrtoint ptr %6 to i64
  %8 = sub i64 %7, %4
  %9 = icmp ult i64 %8, 16
  br label %10

10:                                               ; preds = %2, %41
  %11 = phi i64 [ 0, %2 ], [ %42, %41 ]
  br i1 %9, label %29, label %12

12:                                               ; preds = %10
  %13 = insertelement <2 x i64> poison, i64 %11, i64 0
  %14 = shufflevector <2 x i64> %13, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %12
  %16 = phi i64 [ 0, %12 ], [ %26, %15 ]
  %17 = phi <2 x i64> [ <i64 0, i64 1>, %12 ], [ %27, %15 ]
  %18 = mul nuw nsw <2 x i64> %17, %14
  %19 = trunc <2 x i64> %18 to <2 x i32>
  %20 = urem <2 x i32> %19, <i32 200, i32 200>
  %21 = sitofp <2 x i32> %20 to <2 x double>
  %22 = fdiv <2 x double> %21, <double 2.000000e+02, double 2.000000e+02>
  %23 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %22, <2 x double> <double 1.000000e+02, double 1.000000e+02>, <2 x double> <double 1.000000e+01, double 1.000000e+01>)
  %24 = getelementptr inbounds [240 x double], ptr %3, i64 %11, i64 %16
  store <2 x double> %23, ptr %24, align 8, !tbaa !5
  %25 = getelementptr inbounds [240 x double], ptr %6, i64 %11, i64 %16
  store <2 x double> zeroinitializer, ptr %25, align 8, !tbaa !5
  %26 = add nuw i64 %16, 2
  %27 = add <2 x i64> %17, <i64 2, i64 2>
  %28 = icmp eq i64 %26, 240
  br i1 %28, label %41, label %15, !llvm.loop !9

29:                                               ; preds = %10, %29
  %30 = phi i64 [ %39, %29 ], [ 0, %10 ]
  %31 = mul nuw nsw i64 %30, %11
  %32 = trunc i64 %31 to i32
  %33 = urem i32 %32, 200
  %34 = sitofp i32 %33 to double
  %35 = fdiv double %34, 2.000000e+02
  %36 = tail call double @llvm.fmuladd.f64(double %35, double 1.000000e+02, double 1.000000e+01)
  %37 = getelementptr inbounds [240 x double], ptr %3, i64 %11, i64 %30
  store double %36, ptr %37, align 8, !tbaa !5
  %38 = getelementptr inbounds [240 x double], ptr %6, i64 %11, i64 %30
  store double 0.000000e+00, ptr %38, align 8, !tbaa !5
  %39 = add nuw nsw i64 %30, 1
  %40 = icmp eq i64 %39, 240
  br i1 %40, label %41, label %29, !llvm.loop !13

41:                                               ; preds = %15, %29
  %42 = add nuw nsw i64 %11, 1
  %43 = icmp eq i64 %42, 200
  br i1 %43, label %44, label %10, !llvm.loop !14

44:                                               ; preds = %41
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(460800) %5, i8 0, i64 460800, i1 false), !tbaa !5
  %45 = getelementptr i8, ptr %3, i64 384000
  %46 = getelementptr i8, ptr %6, i64 384000
  %47 = getelementptr i8, ptr %5, i64 460800
  %48 = getelementptr i8, ptr %3, i64 8
  %49 = getelementptr i8, ptr %6, i64 382088
  %50 = getelementptr i8, ptr %5, i64 8
  %51 = getelementptr i8, ptr %5, i64 1920
  %52 = icmp ult ptr %6, %45
  %53 = icmp ult ptr %3, %46
  %54 = and i1 %52, %53
  %55 = icmp ult ptr %6, %47
  %56 = icmp ult ptr %5, %46
  %57 = and i1 %55, %56
  %58 = or i1 %54, %57
  br label %62

59:                                               ; preds = %210, %135
  %60 = add nuw nsw i64 %64, 1
  %61 = icmp eq i64 %136, 240
  br i1 %61, label %213, label %62, !llvm.loop !15

62:                                               ; preds = %59, %44
  %63 = phi i64 [ 0, %44 ], [ %136, %59 ]
  %64 = phi i64 [ 1, %44 ], [ %60, %59 ]
  %65 = shl nuw nsw i64 %63, 3
  %66 = getelementptr i8, ptr %48, i64 %65
  %67 = getelementptr i8, ptr %6, i64 %65
  %68 = getelementptr i8, ptr %49, i64 %65
  %69 = mul nuw nsw i64 %63, 1928
  %70 = getelementptr i8, ptr %50, i64 %69
  %71 = mul nuw nsw i64 %63, 1920
  %72 = getelementptr i8, ptr %51, i64 %71
  br label %73

73:                                               ; preds = %73, %62
  %74 = phi i64 [ 0, %62 ], [ %95, %73 ]
  %75 = phi double [ 0.000000e+00, %62 ], [ %94, %73 ]
  %76 = getelementptr inbounds [240 x double], ptr %3, i64 %74, i64 %63
  %77 = load double, ptr %76, align 8, !tbaa !5
  %78 = tail call double @llvm.fmuladd.f64(double %77, double %77, double %75)
  %79 = add nuw nsw i64 %74, 1
  %80 = getelementptr inbounds [240 x double], ptr %3, i64 %79, i64 %63
  %81 = load double, ptr %80, align 8, !tbaa !5
  %82 = tail call double @llvm.fmuladd.f64(double %81, double %81, double %78)
  %83 = add nuw nsw i64 %74, 2
  %84 = getelementptr inbounds [240 x double], ptr %3, i64 %83, i64 %63
  %85 = load double, ptr %84, align 8, !tbaa !5
  %86 = tail call double @llvm.fmuladd.f64(double %85, double %85, double %82)
  %87 = add nuw nsw i64 %74, 3
  %88 = getelementptr inbounds [240 x double], ptr %3, i64 %87, i64 %63
  %89 = load double, ptr %88, align 8, !tbaa !5
  %90 = tail call double @llvm.fmuladd.f64(double %89, double %89, double %86)
  %91 = add nuw nsw i64 %74, 4
  %92 = getelementptr inbounds [240 x double], ptr %3, i64 %91, i64 %63
  %93 = load double, ptr %92, align 8, !tbaa !5
  %94 = tail call double @llvm.fmuladd.f64(double %93, double %93, double %90)
  %95 = add nuw nsw i64 %74, 5
  %96 = icmp eq i64 %95, 200
  br i1 %96, label %97, label %73, !llvm.loop !16

97:                                               ; preds = %73
  %98 = tail call double @sqrt(double noundef %94) #9
  %99 = getelementptr inbounds [240 x double], ptr %5, i64 %63, i64 %63
  store double %98, ptr %99, align 8, !tbaa !5
  br i1 %58, label %120, label %100

100:                                              ; preds = %97
  %101 = load double, ptr %99, align 8, !tbaa !5, !alias.scope !17
  %102 = insertelement <2 x double> poison, double %101, i64 0
  %103 = shufflevector <2 x double> %102, <2 x double> poison, <2 x i32> zeroinitializer
  br label %104

104:                                              ; preds = %100, %104
  %105 = phi i64 [ %118, %104 ], [ 0, %100 ]
  %106 = or disjoint i64 %105, 1
  %107 = getelementptr inbounds [240 x double], ptr %3, i64 %105, i64 %63
  %108 = getelementptr inbounds [240 x double], ptr %3, i64 %106, i64 %63
  %109 = load double, ptr %107, align 8, !tbaa !5, !alias.scope !20
  %110 = load double, ptr %108, align 8, !tbaa !5, !alias.scope !20
  %111 = insertelement <2 x double> poison, double %109, i64 0
  %112 = insertelement <2 x double> %111, double %110, i64 1
  %113 = fdiv <2 x double> %112, %103
  %114 = getelementptr inbounds [240 x double], ptr %6, i64 %105, i64 %63
  %115 = getelementptr inbounds [240 x double], ptr %6, i64 %106, i64 %63
  %116 = extractelement <2 x double> %113, i64 0
  store double %116, ptr %114, align 8, !tbaa !5, !alias.scope !22, !noalias !24
  %117 = extractelement <2 x double> %113, i64 1
  store double %117, ptr %115, align 8, !tbaa !5, !alias.scope !22, !noalias !24
  %118 = add nuw i64 %105, 2
  %119 = icmp eq i64 %118, 200
  br i1 %119, label %135, label %104, !llvm.loop !25

120:                                              ; preds = %97, %120
  %121 = phi i64 [ %133, %120 ], [ 0, %97 ]
  %122 = getelementptr inbounds [240 x double], ptr %3, i64 %121, i64 %63
  %123 = load double, ptr %122, align 8, !tbaa !5
  %124 = load double, ptr %99, align 8, !tbaa !5
  %125 = fdiv double %123, %124
  %126 = getelementptr inbounds [240 x double], ptr %6, i64 %121, i64 %63
  store double %125, ptr %126, align 8, !tbaa !5
  %127 = or disjoint i64 %121, 1
  %128 = getelementptr inbounds [240 x double], ptr %3, i64 %127, i64 %63
  %129 = load double, ptr %128, align 8, !tbaa !5
  %130 = load double, ptr %99, align 8, !tbaa !5
  %131 = fdiv double %129, %130
  %132 = getelementptr inbounds [240 x double], ptr %6, i64 %127, i64 %63
  store double %131, ptr %132, align 8, !tbaa !5
  %133 = add nuw nsw i64 %121, 2
  %134 = icmp eq i64 %133, 200
  br i1 %134, label %135, label %120, !llvm.loop !26

135:                                              ; preds = %104, %120
  %136 = add nuw nsw i64 %63, 1
  %137 = icmp ult i64 %63, 239
  br i1 %137, label %138, label %59

138:                                              ; preds = %135
  %139 = icmp ult ptr %66, %68
  %140 = icmp ult ptr %67, %45
  %141 = and i1 %139, %140
  %142 = icmp ult ptr %66, %72
  %143 = icmp ult ptr %70, %45
  %144 = and i1 %142, %143
  %145 = or i1 %141, %144
  br label %146

146:                                              ; preds = %138, %210
  %147 = phi i64 [ %211, %210 ], [ %64, %138 ]
  %148 = getelementptr inbounds [240 x double], ptr %5, i64 %63, i64 %147
  store double 0.000000e+00, ptr %148, align 8, !tbaa !5
  br label %149

149:                                              ; preds = %149, %146
  %150 = phi i64 [ 0, %146 ], [ %163, %149 ]
  %151 = phi double [ 0.000000e+00, %146 ], [ %162, %149 ]
  %152 = getelementptr inbounds [240 x double], ptr %6, i64 %150, i64 %63
  %153 = load double, ptr %152, align 8, !tbaa !5
  %154 = getelementptr inbounds [240 x double], ptr %3, i64 %150, i64 %147
  %155 = load double, ptr %154, align 8, !tbaa !5
  %156 = tail call double @llvm.fmuladd.f64(double %153, double %155, double %151)
  store double %156, ptr %148, align 8, !tbaa !5
  %157 = or disjoint i64 %150, 1
  %158 = getelementptr inbounds [240 x double], ptr %6, i64 %157, i64 %63
  %159 = load double, ptr %158, align 8, !tbaa !5
  %160 = getelementptr inbounds [240 x double], ptr %3, i64 %157, i64 %147
  %161 = load double, ptr %160, align 8, !tbaa !5
  %162 = tail call double @llvm.fmuladd.f64(double %159, double %161, double %156)
  store double %162, ptr %148, align 8, !tbaa !5
  %163 = add nuw nsw i64 %150, 2
  %164 = icmp eq i64 %163, 200
  br i1 %164, label %165, label %149, !llvm.loop !27

165:                                              ; preds = %149
  br i1 %145, label %191, label %166

166:                                              ; preds = %165
  %167 = load double, ptr %148, align 8, !tbaa !5, !alias.scope !28
  %168 = insertelement <2 x double> poison, double %167, i64 0
  %169 = shufflevector <2 x double> %168, <2 x double> poison, <2 x i32> zeroinitializer
  br label %170

170:                                              ; preds = %166, %170
  %171 = phi i64 [ %189, %170 ], [ 0, %166 ]
  %172 = or disjoint i64 %171, 1
  %173 = getelementptr inbounds [240 x double], ptr %3, i64 %171, i64 %147
  %174 = getelementptr inbounds [240 x double], ptr %3, i64 %172, i64 %147
  %175 = load double, ptr %173, align 8, !tbaa !5, !alias.scope !31, !noalias !33
  %176 = load double, ptr %174, align 8, !tbaa !5, !alias.scope !31, !noalias !33
  %177 = insertelement <2 x double> poison, double %175, i64 0
  %178 = insertelement <2 x double> %177, double %176, i64 1
  %179 = getelementptr inbounds [240 x double], ptr %6, i64 %171, i64 %63
  %180 = getelementptr inbounds [240 x double], ptr %6, i64 %172, i64 %63
  %181 = load double, ptr %179, align 8, !tbaa !5, !alias.scope !35
  %182 = load double, ptr %180, align 8, !tbaa !5, !alias.scope !35
  %183 = insertelement <2 x double> poison, double %181, i64 0
  %184 = insertelement <2 x double> %183, double %182, i64 1
  %185 = fneg <2 x double> %184
  %186 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %185, <2 x double> %169, <2 x double> %178)
  %187 = extractelement <2 x double> %186, i64 0
  store double %187, ptr %173, align 8, !tbaa !5, !alias.scope !31, !noalias !33
  %188 = extractelement <2 x double> %186, i64 1
  store double %188, ptr %174, align 8, !tbaa !5, !alias.scope !31, !noalias !33
  %189 = add nuw i64 %171, 2
  %190 = icmp eq i64 %189, 200
  br i1 %190, label %210, label %170, !llvm.loop !36

191:                                              ; preds = %165, %191
  %192 = phi i64 [ %208, %191 ], [ 0, %165 ]
  %193 = getelementptr inbounds [240 x double], ptr %3, i64 %192, i64 %147
  %194 = load double, ptr %193, align 8, !tbaa !5
  %195 = getelementptr inbounds [240 x double], ptr %6, i64 %192, i64 %63
  %196 = load double, ptr %195, align 8, !tbaa !5
  %197 = load double, ptr %148, align 8, !tbaa !5
  %198 = fneg double %196
  %199 = tail call double @llvm.fmuladd.f64(double %198, double %197, double %194)
  store double %199, ptr %193, align 8, !tbaa !5
  %200 = or disjoint i64 %192, 1
  %201 = getelementptr inbounds [240 x double], ptr %3, i64 %200, i64 %147
  %202 = load double, ptr %201, align 8, !tbaa !5
  %203 = getelementptr inbounds [240 x double], ptr %6, i64 %200, i64 %63
  %204 = load double, ptr %203, align 8, !tbaa !5
  %205 = load double, ptr %148, align 8, !tbaa !5
  %206 = fneg double %204
  %207 = tail call double @llvm.fmuladd.f64(double %206, double %205, double %202)
  store double %207, ptr %201, align 8, !tbaa !5
  %208 = add nuw nsw i64 %192, 2
  %209 = icmp eq i64 %208, 200
  br i1 %209, label %210, label %191, !llvm.loop !37

210:                                              ; preds = %170, %191
  %211 = add nuw nsw i64 %147, 1
  %212 = icmp eq i64 %211, 240
  br i1 %212, label %59, label %146, !llvm.loop !38

213:                                              ; preds = %59
  %214 = icmp sgt i32 %0, 42
  br i1 %214, label %215, label %278

215:                                              ; preds = %213
  %216 = load ptr, ptr %1, align 8, !tbaa !39
  %217 = load i8, ptr %216, align 1
  %218 = icmp eq i8 %217, 0
  br i1 %218, label %219, label %278

219:                                              ; preds = %215
  %220 = load ptr, ptr @stderr, align 8, !tbaa !39
  %221 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %220) #10
  %222 = load ptr, ptr @stderr, align 8, !tbaa !39
  %223 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %222, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #10
  br label %224

224:                                              ; preds = %243, %219
  %225 = phi i64 [ 0, %219 ], [ %244, %243 ]
  %226 = mul nuw nsw i64 %225, 240
  br label %227

227:                                              ; preds = %236, %224
  %228 = phi i64 [ 0, %224 ], [ %241, %236 ]
  %229 = add nuw nsw i64 %228, %226
  %230 = trunc i64 %229 to i32
  %231 = urem i32 %230, 20
  %232 = icmp eq i32 %231, 0
  br i1 %232, label %233, label %236

233:                                              ; preds = %227
  %234 = load ptr, ptr @stderr, align 8, !tbaa !39
  %235 = tail call i32 @fputc(i32 10, ptr %234)
  br label %236

236:                                              ; preds = %233, %227
  %237 = load ptr, ptr @stderr, align 8, !tbaa !39
  %238 = getelementptr inbounds [240 x double], ptr %5, i64 %225, i64 %228
  %239 = load double, ptr %238, align 8, !tbaa !5
  %240 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %237, ptr noundef nonnull @.str.5, double noundef %239) #10
  %241 = add nuw nsw i64 %228, 1
  %242 = icmp eq i64 %241, 240
  br i1 %242, label %243, label %227, !llvm.loop !41

243:                                              ; preds = %236
  %244 = add nuw nsw i64 %225, 1
  %245 = icmp eq i64 %244, 240
  br i1 %245, label %246, label %224, !llvm.loop !42

246:                                              ; preds = %243
  %247 = load ptr, ptr @stderr, align 8, !tbaa !39
  %248 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %247, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #10
  %249 = load ptr, ptr @stderr, align 8, !tbaa !39
  %250 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %249, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.7) #10
  br label %251

251:                                              ; preds = %270, %246
  %252 = phi i64 [ 0, %246 ], [ %271, %270 ]
  %253 = mul nuw nsw i64 %252, 240
  br label %254

254:                                              ; preds = %263, %251
  %255 = phi i64 [ 0, %251 ], [ %268, %263 ]
  %256 = add nuw nsw i64 %255, %253
  %257 = trunc i64 %256 to i32
  %258 = urem i32 %257, 20
  %259 = icmp eq i32 %258, 0
  br i1 %259, label %260, label %263

260:                                              ; preds = %254
  %261 = load ptr, ptr @stderr, align 8, !tbaa !39
  %262 = tail call i32 @fputc(i32 10, ptr %261)
  br label %263

263:                                              ; preds = %260, %254
  %264 = load ptr, ptr @stderr, align 8, !tbaa !39
  %265 = getelementptr inbounds [240 x double], ptr %6, i64 %252, i64 %255
  %266 = load double, ptr %265, align 8, !tbaa !5
  %267 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %264, ptr noundef nonnull @.str.5, double noundef %266) #10
  %268 = add nuw nsw i64 %255, 1
  %269 = icmp eq i64 %268, 240
  br i1 %269, label %270, label %254, !llvm.loop !43

270:                                              ; preds = %263
  %271 = add nuw nsw i64 %252, 1
  %272 = icmp eq i64 %271, 200
  br i1 %272, label %273, label %251, !llvm.loop !44

273:                                              ; preds = %270
  %274 = load ptr, ptr @stderr, align 8, !tbaa !39
  %275 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %274, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.7) #10
  %276 = load ptr, ptr @stderr, align 8, !tbaa !39
  %277 = tail call i64 @fwrite(ptr nonnull @.str.8, i64 22, i64 1, ptr %276) #10
  br label %278

278:                                              ; preds = %273, %215, %213
  tail call void @free(ptr noundef %3) #9
  tail call void @free(ptr noundef %5) #9
  tail call void @free(ptr noundef nonnull %6) #9
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
!13 = distinct !{!13, !10, !11}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
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
!28 = !{!29}
!29 = distinct !{!29, !30}
!30 = distinct !{!30, !"LVerDomain"}
!31 = !{!32}
!32 = distinct !{!32, !30}
!33 = !{!34, !29}
!34 = distinct !{!34, !30}
!35 = !{!34}
!36 = distinct !{!36, !10, !11, !12}
!37 = distinct !{!37, !10, !11}
!38 = distinct !{!38, !10}
!39 = !{!40, !40, i64 0}
!40 = !{!"any pointer", !7, i64 0}
!41 = distinct !{!41, !10}
!42 = distinct !{!42, !10}
!43 = distinct !{!43, !10}
!44 = distinct !{!44, !10}
