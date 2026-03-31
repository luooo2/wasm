; ModuleID = 'data/polybench-c-4.2.1-beta/stencils/adi/adi.c'
source_filename = "data/polybench-c-4.2.1-beta/stencils/adi/adi.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"u\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 40000, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 40000, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 40000, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 40000, i32 noundef 8) #6
  br label %7

7:                                                ; preds = %2, %30
  %8 = phi i64 [ 0, %2 ], [ %31, %30 ]
  %9 = add nuw nsw i64 %8, 200
  %10 = insertelement <2 x i64> poison, i64 %9, i64 0
  %11 = shufflevector <2 x i64> %10, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %12

12:                                               ; preds = %12, %7
  %13 = phi i64 [ 0, %7 ], [ %27, %12 ]
  %14 = phi <2 x i64> [ <i64 0, i64 1>, %7 ], [ %28, %12 ]
  %15 = sub nuw nsw <2 x i64> %11, %14
  %16 = trunc <2 x i64> %15 to <2 x i32>
  %17 = sitofp <2 x i32> %16 to <2 x double>
  %18 = fdiv <2 x double> %17, <double 2.000000e+02, double 2.000000e+02>
  %19 = getelementptr inbounds [200 x double], ptr %3, i64 %8, i64 %13
  store <2 x double> %18, ptr %19, align 8, !tbaa !5
  %20 = or disjoint i64 %13, 2
  %21 = add <2 x i64> %14, <i64 2, i64 2>
  %22 = sub nuw nsw <2 x i64> %11, %21
  %23 = trunc <2 x i64> %22 to <2 x i32>
  %24 = sitofp <2 x i32> %23 to <2 x double>
  %25 = fdiv <2 x double> %24, <double 2.000000e+02, double 2.000000e+02>
  %26 = getelementptr inbounds [200 x double], ptr %3, i64 %8, i64 %20
  store <2 x double> %25, ptr %26, align 8, !tbaa !5
  %27 = add nuw nsw i64 %13, 4
  %28 = add <2 x i64> %14, <i64 4, i64 4>
  %29 = icmp eq i64 %27, 200
  br i1 %29, label %30, label %12, !llvm.loop !9

30:                                               ; preds = %12
  %31 = add nuw nsw i64 %8, 1
  %32 = icmp eq i64 %31, 200
  br i1 %32, label %33, label %7, !llvm.loop !13

33:                                               ; preds = %30, %227
  %34 = phi i32 [ %228, %227 ], [ 1, %30 ]
  br label %35

35:                                               ; preds = %130, %33
  %36 = phi i64 [ %132, %130 ], [ 0, %33 ]
  %37 = phi i64 [ %50, %130 ], [ 1, %33 ]
  %38 = mul nuw nsw i64 %36, 1600
  %39 = add i64 %38, 1600
  %40 = getelementptr i8, ptr %5, i64 %39
  %41 = add i64 %38, 3192
  %42 = getelementptr i8, ptr %5, i64 %41
  %43 = getelementptr i8, ptr %6, i64 %39
  %44 = getelementptr i8, ptr %6, i64 %41
  %45 = getelementptr inbounds [200 x double], ptr %4, i64 0, i64 %37
  store double 1.000000e+00, ptr %45, align 8, !tbaa !5
  %46 = getelementptr inbounds [200 x double], ptr %5, i64 %37
  store double 0.000000e+00, ptr %46, align 8, !tbaa !5
  %47 = load double, ptr %45, align 8, !tbaa !5
  %48 = getelementptr inbounds [200 x double], ptr %6, i64 %37
  store double %47, ptr %48, align 8, !tbaa !5
  %49 = add nsw i64 %37, -1
  %50 = add nuw nsw i64 %37, 1
  %51 = icmp ult ptr %40, %44
  %52 = icmp ult ptr %43, %42
  %53 = and i1 %51, %52
  br i1 %53, label %54, label %78

54:                                               ; preds = %35, %54
  %55 = phi i64 [ %76, %54 ], [ 1, %35 ]
  %56 = add nsw i64 %55, -1
  %57 = getelementptr inbounds [200 x double], ptr %5, i64 %37, i64 %56
  %58 = load double, ptr %57, align 8, !tbaa !5
  %59 = tail call double @llvm.fmuladd.f64(double %58, double -4.000000e+02, double 8.010000e+02)
  %60 = fdiv double 4.000000e+02, %59
  %61 = getelementptr inbounds [200 x double], ptr %5, i64 %37, i64 %55
  store double %60, ptr %61, align 8, !tbaa !5
  %62 = getelementptr inbounds [200 x double], ptr %3, i64 %55, i64 %49
  %63 = load double, ptr %62, align 8, !tbaa !5
  %64 = getelementptr inbounds [200 x double], ptr %3, i64 %55, i64 %37
  %65 = load double, ptr %64, align 8, !tbaa !5
  %66 = fmul double %65, -3.990000e+02
  %67 = tail call double @llvm.fmuladd.f64(double %63, double 2.000000e+02, double %66)
  %68 = getelementptr inbounds [200 x double], ptr %3, i64 %55, i64 %50
  %69 = load double, ptr %68, align 8, !tbaa !5
  %70 = tail call double @llvm.fmuladd.f64(double %69, double 2.000000e+02, double %67)
  %71 = getelementptr inbounds [200 x double], ptr %6, i64 %37, i64 %56
  %72 = load double, ptr %71, align 8, !tbaa !5
  %73 = tail call double @llvm.fmuladd.f64(double %72, double 4.000000e+02, double %70)
  %74 = fdiv double %73, %59
  %75 = getelementptr inbounds [200 x double], ptr %6, i64 %37, i64 %55
  store double %74, ptr %75, align 8, !tbaa !5
  %76 = add nuw nsw i64 %55, 1
  %77 = icmp eq i64 %76, 199
  br i1 %77, label %106, label %54, !llvm.loop !14

78:                                               ; preds = %35
  %79 = mul nuw nsw i64 %36, 1600
  %80 = add i64 %79, 1600
  %81 = getelementptr i8, ptr %6, i64 %80
  %82 = getelementptr i8, ptr %5, i64 %80
  %83 = load double, ptr %82, align 8
  %84 = load double, ptr %81, align 8
  br label %85

85:                                               ; preds = %85, %78
  %86 = phi double [ %84, %78 ], [ %102, %85 ]
  %87 = phi double [ %83, %78 ], [ %90, %85 ]
  %88 = phi i64 [ 1, %78 ], [ %104, %85 ]
  %89 = tail call double @llvm.fmuladd.f64(double %87, double -4.000000e+02, double 8.010000e+02)
  %90 = fdiv double 4.000000e+02, %89
  %91 = getelementptr inbounds [200 x double], ptr %5, i64 %37, i64 %88
  store double %90, ptr %91, align 8, !tbaa !5
  %92 = getelementptr inbounds [200 x double], ptr %3, i64 %88, i64 %49
  %93 = load double, ptr %92, align 8, !tbaa !5
  %94 = getelementptr inbounds [200 x double], ptr %3, i64 %88, i64 %37
  %95 = load double, ptr %94, align 8, !tbaa !5
  %96 = fmul double %95, -3.990000e+02
  %97 = tail call double @llvm.fmuladd.f64(double %93, double 2.000000e+02, double %96)
  %98 = getelementptr inbounds [200 x double], ptr %3, i64 %88, i64 %50
  %99 = load double, ptr %98, align 8, !tbaa !5
  %100 = tail call double @llvm.fmuladd.f64(double %99, double 2.000000e+02, double %97)
  %101 = tail call double @llvm.fmuladd.f64(double %86, double 4.000000e+02, double %100)
  %102 = fdiv double %101, %89
  %103 = getelementptr inbounds [200 x double], ptr %6, i64 %37, i64 %88
  store double %102, ptr %103, align 8, !tbaa !5
  %104 = add nuw nsw i64 %88, 1
  %105 = icmp eq i64 %104, 199
  br i1 %105, label %106, label %85, !llvm.loop !14

106:                                              ; preds = %85, %54
  %107 = getelementptr inbounds [200 x double], ptr %4, i64 199, i64 %37
  store double 1.000000e+00, ptr %107, align 8, !tbaa !5
  %108 = getelementptr [200 x double], ptr %4, i64 1, i64 %37
  br label %109

109:                                              ; preds = %109, %106
  %110 = phi i64 [ 198, %106 ], [ %128, %109 ]
  %111 = getelementptr inbounds [200 x double], ptr %5, i64 %37, i64 %110
  %112 = load double, ptr %111, align 8, !tbaa !5
  %113 = getelementptr [200 x double], ptr %108, i64 %110
  %114 = load double, ptr %113, align 8, !tbaa !5
  %115 = getelementptr inbounds [200 x double], ptr %6, i64 %37, i64 %110
  %116 = load double, ptr %115, align 8, !tbaa !5
  %117 = tail call double @llvm.fmuladd.f64(double %112, double %114, double %116)
  %118 = getelementptr inbounds [200 x double], ptr %4, i64 %110, i64 %37
  store double %117, ptr %118, align 8, !tbaa !5
  %119 = add nsw i64 %110, -1
  %120 = getelementptr inbounds [200 x double], ptr %5, i64 %37, i64 %119
  %121 = load double, ptr %120, align 8, !tbaa !5
  %122 = getelementptr [200 x double], ptr %108, i64 %119
  %123 = load double, ptr %122, align 8, !tbaa !5
  %124 = getelementptr inbounds [200 x double], ptr %6, i64 %37, i64 %119
  %125 = load double, ptr %124, align 8, !tbaa !5
  %126 = tail call double @llvm.fmuladd.f64(double %121, double %123, double %125)
  %127 = getelementptr inbounds [200 x double], ptr %4, i64 %119, i64 %37
  store double %126, ptr %127, align 8, !tbaa !5
  %128 = add nsw i64 %110, -2
  %129 = icmp eq i64 %119, 1
  br i1 %129, label %130, label %109, !llvm.loop !15

130:                                              ; preds = %109
  %131 = icmp eq i64 %50, 199
  %132 = add i64 %36, 1
  br i1 %131, label %133, label %35, !llvm.loop !16

133:                                              ; preds = %130, %223
  %134 = phi i64 [ %226, %223 ], [ 0, %130 ]
  %135 = phi i64 [ %224, %223 ], [ 1, %130 ]
  %136 = mul nuw nsw i64 %134, 1600
  %137 = add i64 %136, 1600
  %138 = getelementptr i8, ptr %5, i64 %137
  %139 = add i64 %136, 3192
  %140 = getelementptr i8, ptr %5, i64 %139
  %141 = getelementptr i8, ptr %6, i64 %137
  %142 = getelementptr i8, ptr %6, i64 %139
  %143 = getelementptr inbounds [200 x double], ptr %3, i64 %135
  store double 1.000000e+00, ptr %143, align 8, !tbaa !5
  %144 = getelementptr inbounds [200 x double], ptr %5, i64 %135
  store double 0.000000e+00, ptr %144, align 8, !tbaa !5
  %145 = load double, ptr %143, align 8, !tbaa !5
  %146 = getelementptr inbounds [200 x double], ptr %6, i64 %135
  store double %145, ptr %146, align 8, !tbaa !5
  %147 = getelementptr [200 x double], ptr %4, i64 %135
  %148 = icmp ult ptr %138, %142
  %149 = icmp ult ptr %141, %140
  %150 = and i1 %148, %149
  br i1 %150, label %151, label %175

151:                                              ; preds = %133, %151
  %152 = phi i64 [ %173, %151 ], [ 1, %133 ]
  %153 = add nsw i64 %152, -1
  %154 = getelementptr inbounds [200 x double], ptr %5, i64 %135, i64 %153
  %155 = load double, ptr %154, align 8, !tbaa !5
  %156 = tail call double @llvm.fmuladd.f64(double %155, double -2.000000e+02, double 4.010000e+02)
  %157 = fdiv double 2.000000e+02, %156
  %158 = getelementptr inbounds [200 x double], ptr %5, i64 %135, i64 %152
  store double %157, ptr %158, align 8, !tbaa !5
  %159 = getelementptr [200 x double], ptr %147, i64 -1, i64 %152
  %160 = load double, ptr %159, align 8, !tbaa !5
  %161 = getelementptr inbounds [200 x double], ptr %4, i64 %135, i64 %152
  %162 = load double, ptr %161, align 8, !tbaa !5
  %163 = fmul double %162, -7.990000e+02
  %164 = tail call double @llvm.fmuladd.f64(double %160, double 4.000000e+02, double %163)
  %165 = getelementptr [200 x double], ptr %147, i64 1, i64 %152
  %166 = load double, ptr %165, align 8, !tbaa !5
  %167 = tail call double @llvm.fmuladd.f64(double %166, double 4.000000e+02, double %164)
  %168 = getelementptr inbounds [200 x double], ptr %6, i64 %135, i64 %153
  %169 = load double, ptr %168, align 8, !tbaa !5
  %170 = tail call double @llvm.fmuladd.f64(double %169, double 2.000000e+02, double %167)
  %171 = fdiv double %170, %156
  %172 = getelementptr inbounds [200 x double], ptr %6, i64 %135, i64 %152
  store double %171, ptr %172, align 8, !tbaa !5
  %173 = add nuw nsw i64 %152, 1
  %174 = icmp eq i64 %173, 199
  br i1 %174, label %203, label %151, !llvm.loop !17

175:                                              ; preds = %133
  %176 = mul nuw nsw i64 %134, 1600
  %177 = add i64 %176, 1600
  %178 = getelementptr i8, ptr %6, i64 %177
  %179 = getelementptr i8, ptr %5, i64 %177
  %180 = load double, ptr %179, align 8
  %181 = load double, ptr %178, align 8
  br label %182

182:                                              ; preds = %182, %175
  %183 = phi double [ %181, %175 ], [ %199, %182 ]
  %184 = phi double [ %180, %175 ], [ %187, %182 ]
  %185 = phi i64 [ 1, %175 ], [ %201, %182 ]
  %186 = tail call double @llvm.fmuladd.f64(double %184, double -2.000000e+02, double 4.010000e+02)
  %187 = fdiv double 2.000000e+02, %186
  %188 = getelementptr inbounds [200 x double], ptr %5, i64 %135, i64 %185
  store double %187, ptr %188, align 8, !tbaa !5
  %189 = getelementptr [200 x double], ptr %147, i64 -1, i64 %185
  %190 = load double, ptr %189, align 8, !tbaa !5
  %191 = getelementptr inbounds [200 x double], ptr %4, i64 %135, i64 %185
  %192 = load double, ptr %191, align 8, !tbaa !5
  %193 = fmul double %192, -7.990000e+02
  %194 = tail call double @llvm.fmuladd.f64(double %190, double 4.000000e+02, double %193)
  %195 = getelementptr [200 x double], ptr %147, i64 1, i64 %185
  %196 = load double, ptr %195, align 8, !tbaa !5
  %197 = tail call double @llvm.fmuladd.f64(double %196, double 4.000000e+02, double %194)
  %198 = tail call double @llvm.fmuladd.f64(double %183, double 2.000000e+02, double %197)
  %199 = fdiv double %198, %186
  %200 = getelementptr inbounds [200 x double], ptr %6, i64 %135, i64 %185
  store double %199, ptr %200, align 8, !tbaa !5
  %201 = add nuw nsw i64 %185, 1
  %202 = icmp eq i64 %201, 199
  br i1 %202, label %203, label %182, !llvm.loop !17

203:                                              ; preds = %182, %151
  %204 = getelementptr inbounds [200 x double], ptr %3, i64 %135, i64 199
  store double 1.000000e+00, ptr %204, align 8, !tbaa !5
  br label %205

205:                                              ; preds = %205, %203
  %206 = phi double [ 1.000000e+00, %203 ], [ %219, %205 ]
  %207 = phi i64 [ 198, %203 ], [ %221, %205 ]
  %208 = getelementptr inbounds [200 x double], ptr %5, i64 %135, i64 %207
  %209 = load double, ptr %208, align 8, !tbaa !5
  %210 = getelementptr inbounds [200 x double], ptr %6, i64 %135, i64 %207
  %211 = load double, ptr %210, align 8, !tbaa !5
  %212 = tail call double @llvm.fmuladd.f64(double %209, double %206, double %211)
  %213 = getelementptr inbounds [200 x double], ptr %3, i64 %135, i64 %207
  store double %212, ptr %213, align 8, !tbaa !5
  %214 = add nsw i64 %207, -1
  %215 = getelementptr inbounds [200 x double], ptr %5, i64 %135, i64 %214
  %216 = load double, ptr %215, align 8, !tbaa !5
  %217 = getelementptr inbounds [200 x double], ptr %6, i64 %135, i64 %214
  %218 = load double, ptr %217, align 8, !tbaa !5
  %219 = tail call double @llvm.fmuladd.f64(double %216, double %212, double %218)
  %220 = getelementptr inbounds [200 x double], ptr %3, i64 %135, i64 %214
  store double %219, ptr %220, align 8, !tbaa !5
  %221 = add nsw i64 %207, -2
  %222 = icmp eq i64 %214, 1
  br i1 %222, label %223, label %205, !llvm.loop !18

223:                                              ; preds = %205
  %224 = add nuw nsw i64 %135, 1
  %225 = icmp eq i64 %224, 199
  %226 = add i64 %134, 1
  br i1 %225, label %227, label %133, !llvm.loop !19

227:                                              ; preds = %223
  %228 = add nuw nsw i32 %34, 1
  %229 = icmp eq i32 %228, 101
  br i1 %229, label %230, label %33, !llvm.loop !20

230:                                              ; preds = %227
  %231 = icmp sgt i32 %0, 42
  br i1 %231, label %232, label %268

232:                                              ; preds = %230
  %233 = load ptr, ptr %1, align 8, !tbaa !21
  %234 = load i8, ptr %233, align 1
  %235 = icmp eq i8 %234, 0
  br i1 %235, label %236, label %268

236:                                              ; preds = %232
  %237 = load ptr, ptr @stderr, align 8, !tbaa !21
  %238 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %237) #7
  %239 = load ptr, ptr @stderr, align 8, !tbaa !21
  %240 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %239, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %241

241:                                              ; preds = %260, %236
  %242 = phi i64 [ 0, %236 ], [ %261, %260 ]
  %243 = mul nuw nsw i64 %242, 200
  br label %244

244:                                              ; preds = %253, %241
  %245 = phi i64 [ 0, %241 ], [ %258, %253 ]
  %246 = add nuw nsw i64 %245, %243
  %247 = trunc i64 %246 to i32
  %248 = urem i32 %247, 20
  %249 = icmp eq i32 %248, 0
  br i1 %249, label %250, label %253

250:                                              ; preds = %244
  %251 = load ptr, ptr @stderr, align 8, !tbaa !21
  %252 = tail call i32 @fputc(i32 10, ptr %251)
  br label %253

253:                                              ; preds = %250, %244
  %254 = load ptr, ptr @stderr, align 8, !tbaa !21
  %255 = getelementptr inbounds [200 x double], ptr %3, i64 %242, i64 %245
  %256 = load double, ptr %255, align 8, !tbaa !5
  %257 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %254, ptr noundef nonnull @.str.5, double noundef %256) #7
  %258 = add nuw nsw i64 %245, 1
  %259 = icmp eq i64 %258, 200
  br i1 %259, label %260, label %244, !llvm.loop !23

260:                                              ; preds = %253
  %261 = add nuw nsw i64 %242, 1
  %262 = icmp eq i64 %261, 200
  br i1 %262, label %263, label %241, !llvm.loop !24

263:                                              ; preds = %260
  %264 = load ptr, ptr @stderr, align 8, !tbaa !21
  %265 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %264, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %266 = load ptr, ptr @stderr, align 8, !tbaa !21
  %267 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %266) #7
  br label %268

268:                                              ; preds = %263, %232, %230
  tail call void @free(ptr noundef nonnull %3) #6
  tail call void @free(ptr noundef %4) #6
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
!13 = distinct !{!13, !10}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = distinct !{!17, !10}
!18 = distinct !{!18, !10}
!19 = distinct !{!19, !10}
!20 = distinct !{!20, !10}
!21 = !{!22, !22, i64 0}
!22 = !{!"any pointer", !7, i64 0}
!23 = distinct !{!23, !10}
!24 = distinct !{!24, !10}
