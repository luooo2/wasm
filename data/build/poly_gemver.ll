; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/blas/gemver/gemver.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/blas/gemver/gemver.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 160000, i32 noundef 8) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #7
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #7
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #7
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #7
  %8 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #7
  %9 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #7
  %10 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #7
  %11 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #7
  br label %28

12:                                               ; preds = %63
  %13 = getelementptr i8, ptr %3, i64 1280000
  %14 = insertelement <4 x ptr> poison, ptr %5, i64 0
  %15 = insertelement <4 x ptr> %14, ptr %4, i64 1
  %16 = insertelement <4 x ptr> %15, ptr %6, i64 2
  %17 = insertelement <4 x ptr> %16, ptr %7, i64 3
  %18 = getelementptr i8, <4 x ptr> %17, <4 x i64> <i64 3200, i64 3200, i64 3200, i64 3200>
  %19 = insertelement <4 x ptr> poison, ptr %3, i64 0
  %20 = shufflevector <4 x ptr> %19, <4 x ptr> poison, <4 x i32> zeroinitializer
  %21 = insertelement <4 x ptr> poison, ptr %13, i64 0
  %22 = shufflevector <4 x ptr> %21, <4 x ptr> poison, <4 x i32> zeroinitializer
  %23 = icmp ult <4 x ptr> %20, %18
  %24 = icmp ult <4 x ptr> %17, %22
  %25 = and <4 x i1> %23, %24
  %26 = bitcast <4 x i1> %25 to i4
  %27 = icmp eq i4 %26, 0
  br label %65

28:                                               ; preds = %63, %2
  %29 = phi i64 [ 0, %2 ], [ %33, %63 ]
  %30 = trunc i64 %29 to i32
  %31 = sitofp i32 %30 to double
  %32 = getelementptr inbounds double, ptr %4, i64 %29
  store double %31, ptr %32, align 8, !tbaa !5
  %33 = add nuw nsw i64 %29, 1
  %34 = trunc i64 %33 to i32
  %35 = sitofp i32 %34 to double
  %36 = fdiv double %35, 4.000000e+02
  %37 = fmul double %36, 5.000000e-01
  %38 = getelementptr inbounds double, ptr %6, i64 %29
  store double %37, ptr %38, align 8, !tbaa !5
  %39 = fmul double %36, 2.500000e-01
  %40 = getelementptr inbounds double, ptr %5, i64 %29
  store double %39, ptr %40, align 8, !tbaa !5
  %41 = fdiv double %36, 6.000000e+00
  %42 = getelementptr inbounds double, ptr %7, i64 %29
  store double %41, ptr %42, align 8, !tbaa !5
  %43 = fmul double %36, 1.250000e-01
  %44 = getelementptr inbounds double, ptr %10, i64 %29
  store double %43, ptr %44, align 8, !tbaa !5
  %45 = fdiv double %36, 9.000000e+00
  %46 = getelementptr inbounds double, ptr %11, i64 %29
  store double %45, ptr %46, align 8, !tbaa !5
  %47 = getelementptr inbounds double, ptr %9, i64 %29
  store double 0.000000e+00, ptr %47, align 8, !tbaa !5
  %48 = getelementptr inbounds double, ptr %8, i64 %29
  store double 0.000000e+00, ptr %48, align 8, !tbaa !5
  %49 = insertelement <2 x i64> poison, i64 %29, i64 0
  %50 = shufflevector <2 x i64> %49, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %51

51:                                               ; preds = %51, %28
  %52 = phi i64 [ 0, %28 ], [ %60, %51 ]
  %53 = phi <2 x i64> [ <i64 0, i64 1>, %28 ], [ %61, %51 ]
  %54 = mul nuw nsw <2 x i64> %53, %50
  %55 = trunc <2 x i64> %54 to <2 x i32>
  %56 = urem <2 x i32> %55, <i32 400, i32 400>
  %57 = sitofp <2 x i32> %56 to <2 x double>
  %58 = fdiv <2 x double> %57, <double 4.000000e+02, double 4.000000e+02>
  %59 = getelementptr inbounds [400 x double], ptr %3, i64 %29, i64 %52
  store <2 x double> %58, ptr %59, align 8, !tbaa !5
  %60 = add nuw i64 %52, 2
  %61 = add <2 x i64> %53, <i64 2, i64 2>
  %62 = icmp eq i64 %60, 400
  br i1 %62, label %63, label %51, !llvm.loop !9

63:                                               ; preds = %51
  %64 = icmp eq i64 %33, 400
  br i1 %64, label %12, label %28, !llvm.loop !13

65:                                               ; preds = %12, %121
  %66 = phi i64 [ %122, %121 ], [ 0, %12 ]
  %67 = getelementptr inbounds double, ptr %4, i64 %66
  %68 = getelementptr inbounds double, ptr %6, i64 %66
  br i1 %27, label %69, label %96

69:                                               ; preds = %65
  %70 = load double, ptr %67, align 8, !tbaa !5, !alias.scope !14
  %71 = insertelement <2 x double> poison, double %70, i64 0
  %72 = shufflevector <2 x double> %71, <2 x double> poison, <2 x i32> zeroinitializer
  %73 = load double, ptr %68, align 8, !tbaa !5, !alias.scope !17
  %74 = insertelement <2 x double> poison, double %73, i64 0
  %75 = shufflevector <2 x double> %74, <2 x double> poison, <2 x i32> zeroinitializer
  br label %76

76:                                               ; preds = %69, %76
  %77 = phi i64 [ %94, %76 ], [ 0, %69 ]
  %78 = getelementptr inbounds [400 x double], ptr %3, i64 %66, i64 %77
  %79 = getelementptr inbounds double, ptr %78, i64 2
  %80 = load <2 x double>, ptr %78, align 8, !tbaa !5, !alias.scope !19, !noalias !21
  %81 = load <2 x double>, ptr %79, align 8, !tbaa !5, !alias.scope !19, !noalias !21
  %82 = getelementptr inbounds double, ptr %5, i64 %77
  %83 = getelementptr inbounds double, ptr %82, i64 2
  %84 = load <2 x double>, ptr %82, align 8, !tbaa !5, !alias.scope !24
  %85 = load <2 x double>, ptr %83, align 8, !tbaa !5, !alias.scope !24
  %86 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %72, <2 x double> %84, <2 x double> %80)
  %87 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %72, <2 x double> %85, <2 x double> %81)
  %88 = getelementptr inbounds double, ptr %7, i64 %77
  %89 = getelementptr inbounds double, ptr %88, i64 2
  %90 = load <2 x double>, ptr %88, align 8, !tbaa !5, !alias.scope !25
  %91 = load <2 x double>, ptr %89, align 8, !tbaa !5, !alias.scope !25
  %92 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %75, <2 x double> %90, <2 x double> %86)
  %93 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %75, <2 x double> %91, <2 x double> %87)
  store <2 x double> %92, ptr %78, align 8, !tbaa !5, !alias.scope !19, !noalias !21
  store <2 x double> %93, ptr %79, align 8, !tbaa !5, !alias.scope !19, !noalias !21
  %94 = add nuw i64 %77, 4
  %95 = icmp eq i64 %94, 400
  br i1 %95, label %121, label %76, !llvm.loop !26

96:                                               ; preds = %65, %96
  %97 = phi i64 [ %119, %96 ], [ 0, %65 ]
  %98 = getelementptr inbounds [400 x double], ptr %3, i64 %66, i64 %97
  %99 = load double, ptr %98, align 8, !tbaa !5
  %100 = load double, ptr %67, align 8, !tbaa !5
  %101 = getelementptr inbounds double, ptr %5, i64 %97
  %102 = load double, ptr %101, align 8, !tbaa !5
  %103 = tail call double @llvm.fmuladd.f64(double %100, double %102, double %99)
  %104 = load double, ptr %68, align 8, !tbaa !5
  %105 = getelementptr inbounds double, ptr %7, i64 %97
  %106 = load double, ptr %105, align 8, !tbaa !5
  %107 = tail call double @llvm.fmuladd.f64(double %104, double %106, double %103)
  store double %107, ptr %98, align 8, !tbaa !5
  %108 = or disjoint i64 %97, 1
  %109 = getelementptr inbounds [400 x double], ptr %3, i64 %66, i64 %108
  %110 = load double, ptr %109, align 8, !tbaa !5
  %111 = load double, ptr %67, align 8, !tbaa !5
  %112 = getelementptr inbounds double, ptr %5, i64 %108
  %113 = load double, ptr %112, align 8, !tbaa !5
  %114 = tail call double @llvm.fmuladd.f64(double %111, double %113, double %110)
  %115 = load double, ptr %68, align 8, !tbaa !5
  %116 = getelementptr inbounds double, ptr %7, i64 %108
  %117 = load double, ptr %116, align 8, !tbaa !5
  %118 = tail call double @llvm.fmuladd.f64(double %115, double %117, double %114)
  store double %118, ptr %109, align 8, !tbaa !5
  %119 = add nuw nsw i64 %97, 2
  %120 = icmp eq i64 %119, 400
  br i1 %120, label %121, label %96, !llvm.loop !27

121:                                              ; preds = %76, %96
  %122 = add nuw nsw i64 %66, 1
  %123 = icmp eq i64 %122, 400
  br i1 %123, label %124, label %65, !llvm.loop !28

124:                                              ; preds = %121, %146
  %125 = phi i64 [ %147, %146 ], [ 0, %121 ]
  %126 = getelementptr inbounds double, ptr %9, i64 %125
  %127 = load double, ptr %126, align 8, !tbaa !5
  br label %128

128:                                              ; preds = %128, %124
  %129 = phi i64 [ 0, %124 ], [ %144, %128 ]
  %130 = phi double [ %127, %124 ], [ %143, %128 ]
  %131 = getelementptr inbounds [400 x double], ptr %3, i64 %129, i64 %125
  %132 = load double, ptr %131, align 8, !tbaa !5
  %133 = fmul double %132, 1.200000e+00
  %134 = getelementptr inbounds double, ptr %10, i64 %129
  %135 = load double, ptr %134, align 8, !tbaa !5
  %136 = tail call double @llvm.fmuladd.f64(double %133, double %135, double %130)
  store double %136, ptr %126, align 8, !tbaa !5
  %137 = or disjoint i64 %129, 1
  %138 = getelementptr inbounds [400 x double], ptr %3, i64 %137, i64 %125
  %139 = load double, ptr %138, align 8, !tbaa !5
  %140 = fmul double %139, 1.200000e+00
  %141 = getelementptr inbounds double, ptr %10, i64 %137
  %142 = load double, ptr %141, align 8, !tbaa !5
  %143 = tail call double @llvm.fmuladd.f64(double %140, double %142, double %136)
  store double %143, ptr %126, align 8, !tbaa !5
  %144 = add nuw nsw i64 %129, 2
  %145 = icmp eq i64 %144, 400
  br i1 %145, label %146, label %128, !llvm.loop !29

146:                                              ; preds = %128
  %147 = add nuw nsw i64 %125, 1
  %148 = icmp eq i64 %147, 400
  br i1 %148, label %149, label %124, !llvm.loop !30

149:                                              ; preds = %146
  %150 = getelementptr i8, ptr %9, i64 3200
  %151 = getelementptr i8, ptr %11, i64 3200
  %152 = icmp ult ptr %9, %151
  %153 = icmp ult ptr %11, %150
  %154 = and i1 %152, %153
  br i1 %154, label %180, label %155

155:                                              ; preds = %149, %155
  %156 = phi i64 [ %178, %155 ], [ 0, %149 ]
  %157 = getelementptr inbounds double, ptr %9, i64 %156
  %158 = getelementptr inbounds double, ptr %157, i64 2
  %159 = load <2 x double>, ptr %157, align 8, !tbaa !5, !alias.scope !31, !noalias !34
  %160 = load <2 x double>, ptr %158, align 8, !tbaa !5, !alias.scope !31, !noalias !34
  %161 = getelementptr inbounds double, ptr %11, i64 %156
  %162 = getelementptr inbounds double, ptr %161, i64 2
  %163 = load <2 x double>, ptr %161, align 8, !tbaa !5, !alias.scope !34
  %164 = load <2 x double>, ptr %162, align 8, !tbaa !5, !alias.scope !34
  %165 = fadd <2 x double> %159, %163
  %166 = fadd <2 x double> %160, %164
  store <2 x double> %165, ptr %157, align 8, !tbaa !5, !alias.scope !31, !noalias !34
  store <2 x double> %166, ptr %158, align 8, !tbaa !5, !alias.scope !31, !noalias !34
  %167 = or disjoint i64 %156, 4
  %168 = getelementptr inbounds double, ptr %9, i64 %167
  %169 = getelementptr inbounds double, ptr %168, i64 2
  %170 = load <2 x double>, ptr %168, align 8, !tbaa !5, !alias.scope !31, !noalias !34
  %171 = load <2 x double>, ptr %169, align 8, !tbaa !5, !alias.scope !31, !noalias !34
  %172 = getelementptr inbounds double, ptr %11, i64 %167
  %173 = getelementptr inbounds double, ptr %172, i64 2
  %174 = load <2 x double>, ptr %172, align 8, !tbaa !5, !alias.scope !34
  %175 = load <2 x double>, ptr %173, align 8, !tbaa !5, !alias.scope !34
  %176 = fadd <2 x double> %170, %174
  %177 = fadd <2 x double> %171, %175
  store <2 x double> %176, ptr %168, align 8, !tbaa !5, !alias.scope !31, !noalias !34
  store <2 x double> %177, ptr %169, align 8, !tbaa !5, !alias.scope !31, !noalias !34
  %178 = add nuw nsw i64 %156, 8
  %179 = icmp eq i64 %178, 400
  br i1 %179, label %207, label %155, !llvm.loop !36

180:                                              ; preds = %149, %180
  %181 = phi i64 [ %205, %180 ], [ 0, %149 ]
  %182 = getelementptr inbounds double, ptr %9, i64 %181
  %183 = load double, ptr %182, align 8, !tbaa !5
  %184 = getelementptr inbounds double, ptr %11, i64 %181
  %185 = load double, ptr %184, align 8, !tbaa !5
  %186 = fadd double %183, %185
  store double %186, ptr %182, align 8, !tbaa !5
  %187 = or disjoint i64 %181, 1
  %188 = getelementptr inbounds double, ptr %9, i64 %187
  %189 = load double, ptr %188, align 8, !tbaa !5
  %190 = getelementptr inbounds double, ptr %11, i64 %187
  %191 = load double, ptr %190, align 8, !tbaa !5
  %192 = fadd double %189, %191
  store double %192, ptr %188, align 8, !tbaa !5
  %193 = or disjoint i64 %181, 2
  %194 = getelementptr inbounds double, ptr %9, i64 %193
  %195 = load double, ptr %194, align 8, !tbaa !5
  %196 = getelementptr inbounds double, ptr %11, i64 %193
  %197 = load double, ptr %196, align 8, !tbaa !5
  %198 = fadd double %195, %197
  store double %198, ptr %194, align 8, !tbaa !5
  %199 = or disjoint i64 %181, 3
  %200 = getelementptr inbounds double, ptr %9, i64 %199
  %201 = load double, ptr %200, align 8, !tbaa !5
  %202 = getelementptr inbounds double, ptr %11, i64 %199
  %203 = load double, ptr %202, align 8, !tbaa !5
  %204 = fadd double %201, %203
  store double %204, ptr %200, align 8, !tbaa !5
  %205 = add nuw nsw i64 %181, 4
  %206 = icmp eq i64 %205, 400
  br i1 %206, label %207, label %180, !llvm.loop !37

207:                                              ; preds = %155, %180
  br label %208

208:                                              ; preds = %207, %230
  %209 = phi i64 [ %231, %230 ], [ 0, %207 ]
  %210 = getelementptr inbounds double, ptr %8, i64 %209
  %211 = load double, ptr %210, align 8, !tbaa !5
  br label %212

212:                                              ; preds = %212, %208
  %213 = phi i64 [ 0, %208 ], [ %228, %212 ]
  %214 = phi double [ %211, %208 ], [ %227, %212 ]
  %215 = getelementptr inbounds [400 x double], ptr %3, i64 %209, i64 %213
  %216 = load double, ptr %215, align 8, !tbaa !5
  %217 = fmul double %216, 1.500000e+00
  %218 = getelementptr inbounds double, ptr %9, i64 %213
  %219 = load double, ptr %218, align 8, !tbaa !5
  %220 = tail call double @llvm.fmuladd.f64(double %217, double %219, double %214)
  store double %220, ptr %210, align 8, !tbaa !5
  %221 = or disjoint i64 %213, 1
  %222 = getelementptr inbounds [400 x double], ptr %3, i64 %209, i64 %221
  %223 = load double, ptr %222, align 8, !tbaa !5
  %224 = fmul double %223, 1.500000e+00
  %225 = getelementptr inbounds double, ptr %9, i64 %221
  %226 = load double, ptr %225, align 8, !tbaa !5
  %227 = tail call double @llvm.fmuladd.f64(double %224, double %226, double %220)
  store double %227, ptr %210, align 8, !tbaa !5
  %228 = add nuw nsw i64 %213, 2
  %229 = icmp eq i64 %228, 400
  br i1 %229, label %230, label %212, !llvm.loop !38

230:                                              ; preds = %212
  %231 = add nuw nsw i64 %209, 1
  %232 = icmp eq i64 %231, 400
  br i1 %232, label %233, label %208, !llvm.loop !39

233:                                              ; preds = %230
  %234 = icmp sgt i32 %0, 42
  br i1 %234, label %235, label %264

235:                                              ; preds = %233
  %236 = load ptr, ptr %1, align 8, !tbaa !40
  %237 = load i8, ptr %236, align 1
  %238 = icmp eq i8 %237, 0
  br i1 %238, label %239, label %264

239:                                              ; preds = %235
  %240 = load ptr, ptr @stderr, align 8, !tbaa !40
  %241 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %240) #8
  %242 = load ptr, ptr @stderr, align 8, !tbaa !40
  %243 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %242, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %244

244:                                              ; preds = %252, %239
  %245 = phi i64 [ 0, %239 ], [ %257, %252 ]
  %246 = trunc i64 %245 to i16
  %247 = urem i16 %246, 20
  %248 = icmp eq i16 %247, 0
  br i1 %248, label %249, label %252

249:                                              ; preds = %244
  %250 = load ptr, ptr @stderr, align 8, !tbaa !40
  %251 = tail call i32 @fputc(i32 10, ptr %250)
  br label %252

252:                                              ; preds = %249, %244
  %253 = load ptr, ptr @stderr, align 8, !tbaa !40
  %254 = getelementptr inbounds double, ptr %8, i64 %245
  %255 = load double, ptr %254, align 8, !tbaa !5
  %256 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %253, ptr noundef nonnull @.str.5, double noundef %255) #8
  %257 = add nuw nsw i64 %245, 1
  %258 = icmp eq i64 %257, 400
  br i1 %258, label %259, label %244, !llvm.loop !42

259:                                              ; preds = %252
  %260 = load ptr, ptr @stderr, align 8, !tbaa !40
  %261 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %260, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %262 = load ptr, ptr @stderr, align 8, !tbaa !40
  %263 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %262) #8
  br label %264

264:                                              ; preds = %259, %235, %233
  tail call void @free(ptr noundef %3) #7
  tail call void @free(ptr noundef %4) #7
  tail call void @free(ptr noundef %5) #7
  tail call void @free(ptr noundef %6) #7
  tail call void @free(ptr noundef %7) #7
  tail call void @free(ptr noundef nonnull %8) #7
  tail call void @free(ptr noundef %9) #7
  tail call void @free(ptr noundef %10) #7
  tail call void @free(ptr noundef %11) #7
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
!14 = !{!15}
!15 = distinct !{!15, !16}
!16 = distinct !{!16, !"LVerDomain"}
!17 = !{!18}
!18 = distinct !{!18, !16}
!19 = !{!20}
!20 = distinct !{!20, !16}
!21 = !{!15, !22, !18, !23}
!22 = distinct !{!22, !16}
!23 = distinct !{!23, !16}
!24 = !{!22}
!25 = !{!23}
!26 = distinct !{!26, !10, !11, !12}
!27 = distinct !{!27, !10, !11}
!28 = distinct !{!28, !10}
!29 = distinct !{!29, !10}
!30 = distinct !{!30, !10}
!31 = !{!32}
!32 = distinct !{!32, !33}
!33 = distinct !{!33, !"LVerDomain"}
!34 = !{!35}
!35 = distinct !{!35, !33}
!36 = distinct !{!36, !10, !11, !12}
!37 = distinct !{!37, !10, !11}
!38 = distinct !{!38, !10}
!39 = distinct !{!39, !10}
!40 = !{!41, !41, i64 0}
!41 = !{!"any pointer", !7, i64 0}
!42 = distinct !{!42, !10}
