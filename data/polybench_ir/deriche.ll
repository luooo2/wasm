; ModuleID = '/code/data/webassembly-polybench-c-master/medley/deriche/deriche.c'
source_filename = "/code/data/webassembly-polybench-c-master/medley/deriche/deriche.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"imgOut\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"%0.2f \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca float, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 4096, ptr %6, align 4
  store i32 2160, ptr %7, align 4
  %13 = call ptr @polybench_alloc_data(i64 noundef 8847360, i32 noundef 4)
  store ptr %13, ptr %9, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 8847360, i32 noundef 4)
  store ptr %14, ptr %10, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 8847360, i32 noundef 4)
  store ptr %15, ptr %11, align 8
  %16 = call ptr @polybench_alloc_data(i64 noundef 8847360, i32 noundef 4)
  store ptr %16, ptr %12, align 8
  %17 = load i32, ptr %6, align 4
  %18 = load i32, ptr %7, align 4
  %19 = load ptr, ptr %9, align 8
  %20 = getelementptr inbounds [4096 x [2160 x float]], ptr %19, i64 0, i64 0
  %21 = load ptr, ptr %10, align 8
  %22 = getelementptr inbounds [4096 x [2160 x float]], ptr %21, i64 0, i64 0
  call void @init_array(i32 noundef %17, i32 noundef %18, ptr noundef %8, ptr noundef %20, ptr noundef %22)
  %23 = load i32, ptr %6, align 4
  %24 = load i32, ptr %7, align 4
  %25 = load float, ptr %8, align 4
  %26 = load ptr, ptr %9, align 8
  %27 = getelementptr inbounds [4096 x [2160 x float]], ptr %26, i64 0, i64 0
  %28 = load ptr, ptr %10, align 8
  %29 = getelementptr inbounds [4096 x [2160 x float]], ptr %28, i64 0, i64 0
  %30 = load ptr, ptr %11, align 8
  %31 = getelementptr inbounds [4096 x [2160 x float]], ptr %30, i64 0, i64 0
  %32 = load ptr, ptr %12, align 8
  %33 = getelementptr inbounds [4096 x [2160 x float]], ptr %32, i64 0, i64 0
  call void @kernel_deriche(i32 noundef %23, i32 noundef %24, float noundef %25, ptr noundef %27, ptr noundef %29, ptr noundef %31, ptr noundef %33)
  %34 = load i32, ptr %4, align 4
  %35 = icmp sgt i32 %34, 42
  br i1 %35, label %36, label %47

36:                                               ; preds = %2
  %37 = load ptr, ptr %5, align 8
  %38 = getelementptr inbounds ptr, ptr %37, i64 0
  %39 = load ptr, ptr %38, align 8
  %40 = call i32 @strcmp(ptr noundef %39, ptr noundef @.str) #5
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %47, label %42

42:                                               ; preds = %36
  %43 = load i32, ptr %6, align 4
  %44 = load i32, ptr %7, align 4
  %45 = load ptr, ptr %10, align 8
  %46 = getelementptr inbounds [4096 x [2160 x float]], ptr %45, i64 0, i64 0
  call void @print_array(i32 noundef %43, i32 noundef %44, ptr noundef %46)
  br label %47

47:                                               ; preds = %42, %36, %2
  %48 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %48) #6
  %49 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %49) #6
  %50 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %50) #6
  %51 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %51) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  store ptr %4, ptr %10, align 8
  %13 = load ptr, ptr %8, align 8
  store float 2.500000e-01, ptr %13, align 4
  store i32 0, ptr %11, align 4
  br label %14

14:                                               ; preds = %43, %5
  %15 = load i32, ptr %11, align 4
  %16 = load i32, ptr %6, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %46

18:                                               ; preds = %14
  store i32 0, ptr %12, align 4
  br label %19

19:                                               ; preds = %39, %18
  %20 = load i32, ptr %12, align 4
  %21 = load i32, ptr %7, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %42

23:                                               ; preds = %19
  %24 = load i32, ptr %11, align 4
  %25 = mul nsw i32 313, %24
  %26 = load i32, ptr %12, align 4
  %27 = mul nsw i32 991, %26
  %28 = add nsw i32 %25, %27
  %29 = srem i32 %28, 65536
  %30 = sitofp i32 %29 to float
  %31 = fdiv float %30, 6.553500e+04
  %32 = load ptr, ptr %9, align 8
  %33 = load i32, ptr %11, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [2160 x float], ptr %32, i64 %34
  %36 = load i32, ptr %12, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [2160 x float], ptr %35, i64 0, i64 %37
  store float %31, ptr %38, align 4
  br label %39

39:                                               ; preds = %23
  %40 = load i32, ptr %12, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %12, align 4
  br label %19, !llvm.loop !6

42:                                               ; preds = %19
  br label %43

43:                                               ; preds = %42
  %44 = load i32, ptr %11, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %11, align 4
  br label %14, !llvm.loop !8

46:                                               ; preds = %14
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_deriche(i32 noundef %0, i32 noundef %1, float noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca float, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca float, align 4
  %20 = alloca float, align 4
  %21 = alloca float, align 4
  %22 = alloca float, align 4
  %23 = alloca float, align 4
  %24 = alloca float, align 4
  %25 = alloca float, align 4
  %26 = alloca float, align 4
  %27 = alloca float, align 4
  %28 = alloca float, align 4
  %29 = alloca float, align 4
  %30 = alloca float, align 4
  %31 = alloca float, align 4
  %32 = alloca float, align 4
  %33 = alloca float, align 4
  %34 = alloca float, align 4
  %35 = alloca float, align 4
  %36 = alloca float, align 4
  %37 = alloca float, align 4
  %38 = alloca float, align 4
  %39 = alloca float, align 4
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store float %2, ptr %10, align 4
  store ptr %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store ptr %5, ptr %13, align 8
  store ptr %6, ptr %14, align 8
  %40 = load float, ptr %10, align 4
  %41 = fneg float %40
  %42 = call float @expf(float noundef %41) #6
  %43 = fsub float 1.000000e+00, %42
  %44 = load float, ptr %10, align 4
  %45 = fneg float %44
  %46 = call float @expf(float noundef %45) #6
  %47 = fsub float 1.000000e+00, %46
  %48 = fmul float %43, %47
  %49 = load float, ptr %10, align 4
  %50 = fmul float 2.000000e+00, %49
  %51 = load float, ptr %10, align 4
  %52 = fneg float %51
  %53 = call float @expf(float noundef %52) #6
  %54 = call float @llvm.fmuladd.f32(float %50, float %53, float 1.000000e+00)
  %55 = load float, ptr %10, align 4
  %56 = fmul float 2.000000e+00, %55
  %57 = call float @expf(float noundef %56) #6
  %58 = fsub float %54, %57
  %59 = fdiv float %48, %58
  store float %59, ptr %27, align 4
  %60 = load float, ptr %27, align 4
  store float %60, ptr %32, align 4
  store float %60, ptr %28, align 4
  %61 = load float, ptr %27, align 4
  %62 = load float, ptr %10, align 4
  %63 = fneg float %62
  %64 = call float @expf(float noundef %63) #6
  %65 = fmul float %61, %64
  %66 = load float, ptr %10, align 4
  %67 = fsub float %66, 1.000000e+00
  %68 = fmul float %65, %67
  store float %68, ptr %33, align 4
  store float %68, ptr %29, align 4
  %69 = load float, ptr %27, align 4
  %70 = load float, ptr %10, align 4
  %71 = fneg float %70
  %72 = call float @expf(float noundef %71) #6
  %73 = fmul float %69, %72
  %74 = load float, ptr %10, align 4
  %75 = fadd float %74, 1.000000e+00
  %76 = fmul float %73, %75
  store float %76, ptr %34, align 4
  store float %76, ptr %30, align 4
  %77 = load float, ptr %27, align 4
  %78 = fneg float %77
  %79 = load float, ptr %10, align 4
  %80 = fmul float -2.000000e+00, %79
  %81 = call float @expf(float noundef %80) #6
  %82 = fmul float %78, %81
  store float %82, ptr %35, align 4
  store float %82, ptr %31, align 4
  %83 = load float, ptr %10, align 4
  %84 = fneg float %83
  %85 = call float @powf(float noundef 2.000000e+00, float noundef %84) #6
  store float %85, ptr %36, align 4
  %86 = load float, ptr %10, align 4
  %87 = fmul float -2.000000e+00, %86
  %88 = call float @expf(float noundef %87) #6
  %89 = fneg float %88
  store float %89, ptr %37, align 4
  store float 1.000000e+00, ptr %39, align 4
  store float 1.000000e+00, ptr %38, align 4
  store i32 0, ptr %15, align 4
  br label %90

90:                                               ; preds = %147, %7
  %91 = load i32, ptr %15, align 4
  %92 = load i32, ptr %8, align 4
  %93 = icmp slt i32 %91, %92
  br i1 %93, label %94, label %150

94:                                               ; preds = %90
  store float 0.000000e+00, ptr %19, align 4
  store float 0.000000e+00, ptr %20, align 4
  store float 0.000000e+00, ptr %17, align 4
  store i32 0, ptr %16, align 4
  br label %95

95:                                               ; preds = %143, %94
  %96 = load i32, ptr %16, align 4
  %97 = load i32, ptr %9, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %146

99:                                               ; preds = %95
  %100 = load float, ptr %28, align 4
  %101 = load ptr, ptr %11, align 8
  %102 = load i32, ptr %15, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds [2160 x float], ptr %101, i64 %103
  %105 = load i32, ptr %16, align 4
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds [2160 x float], ptr %104, i64 0, i64 %106
  %108 = load float, ptr %107, align 4
  %109 = load float, ptr %29, align 4
  %110 = load float, ptr %17, align 4
  %111 = fmul float %109, %110
  %112 = call float @llvm.fmuladd.f32(float %100, float %108, float %111)
  %113 = load float, ptr %36, align 4
  %114 = load float, ptr %19, align 4
  %115 = call float @llvm.fmuladd.f32(float %113, float %114, float %112)
  %116 = load float, ptr %37, align 4
  %117 = load float, ptr %20, align 4
  %118 = call float @llvm.fmuladd.f32(float %116, float %117, float %115)
  %119 = load ptr, ptr %13, align 8
  %120 = load i32, ptr %15, align 4
  %121 = sext i32 %120 to i64
  %122 = getelementptr inbounds [2160 x float], ptr %119, i64 %121
  %123 = load i32, ptr %16, align 4
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds [2160 x float], ptr %122, i64 0, i64 %124
  store float %118, ptr %125, align 4
  %126 = load ptr, ptr %11, align 8
  %127 = load i32, ptr %15, align 4
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds [2160 x float], ptr %126, i64 %128
  %130 = load i32, ptr %16, align 4
  %131 = sext i32 %130 to i64
  %132 = getelementptr inbounds [2160 x float], ptr %129, i64 0, i64 %131
  %133 = load float, ptr %132, align 4
  store float %133, ptr %17, align 4
  %134 = load float, ptr %19, align 4
  store float %134, ptr %20, align 4
  %135 = load ptr, ptr %13, align 8
  %136 = load i32, ptr %15, align 4
  %137 = sext i32 %136 to i64
  %138 = getelementptr inbounds [2160 x float], ptr %135, i64 %137
  %139 = load i32, ptr %16, align 4
  %140 = sext i32 %139 to i64
  %141 = getelementptr inbounds [2160 x float], ptr %138, i64 0, i64 %140
  %142 = load float, ptr %141, align 4
  store float %142, ptr %19, align 4
  br label %143

143:                                              ; preds = %99
  %144 = load i32, ptr %16, align 4
  %145 = add nsw i32 %144, 1
  store i32 %145, ptr %16, align 4
  br label %95, !llvm.loop !9

146:                                              ; preds = %95
  br label %147

147:                                              ; preds = %146
  %148 = load i32, ptr %15, align 4
  %149 = add nsw i32 %148, 1
  store i32 %149, ptr %15, align 4
  br label %90, !llvm.loop !10

150:                                              ; preds = %90
  store i32 0, ptr %15, align 4
  br label %151

151:                                              ; preds = %203, %150
  %152 = load i32, ptr %15, align 4
  %153 = load i32, ptr %8, align 4
  %154 = icmp slt i32 %152, %153
  br i1 %154, label %155, label %206

155:                                              ; preds = %151
  store float 0.000000e+00, ptr %25, align 4
  store float 0.000000e+00, ptr %26, align 4
  store float 0.000000e+00, ptr %21, align 4
  store float 0.000000e+00, ptr %22, align 4
  %156 = load i32, ptr %9, align 4
  %157 = sub nsw i32 %156, 1
  store i32 %157, ptr %16, align 4
  br label %158

158:                                              ; preds = %199, %155
  %159 = load i32, ptr %16, align 4
  %160 = icmp sge i32 %159, 0
  br i1 %160, label %161, label %202

161:                                              ; preds = %158
  %162 = load float, ptr %30, align 4
  %163 = load float, ptr %21, align 4
  %164 = load float, ptr %31, align 4
  %165 = load float, ptr %22, align 4
  %166 = fmul float %164, %165
  %167 = call float @llvm.fmuladd.f32(float %162, float %163, float %166)
  %168 = load float, ptr %36, align 4
  %169 = load float, ptr %25, align 4
  %170 = call float @llvm.fmuladd.f32(float %168, float %169, float %167)
  %171 = load float, ptr %37, align 4
  %172 = load float, ptr %26, align 4
  %173 = call float @llvm.fmuladd.f32(float %171, float %172, float %170)
  %174 = load ptr, ptr %14, align 8
  %175 = load i32, ptr %15, align 4
  %176 = sext i32 %175 to i64
  %177 = getelementptr inbounds [2160 x float], ptr %174, i64 %176
  %178 = load i32, ptr %16, align 4
  %179 = sext i32 %178 to i64
  %180 = getelementptr inbounds [2160 x float], ptr %177, i64 0, i64 %179
  store float %173, ptr %180, align 4
  %181 = load float, ptr %21, align 4
  store float %181, ptr %22, align 4
  %182 = load ptr, ptr %11, align 8
  %183 = load i32, ptr %15, align 4
  %184 = sext i32 %183 to i64
  %185 = getelementptr inbounds [2160 x float], ptr %182, i64 %184
  %186 = load i32, ptr %16, align 4
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds [2160 x float], ptr %185, i64 0, i64 %187
  %189 = load float, ptr %188, align 4
  store float %189, ptr %21, align 4
  %190 = load float, ptr %25, align 4
  store float %190, ptr %26, align 4
  %191 = load ptr, ptr %14, align 8
  %192 = load i32, ptr %15, align 4
  %193 = sext i32 %192 to i64
  %194 = getelementptr inbounds [2160 x float], ptr %191, i64 %193
  %195 = load i32, ptr %16, align 4
  %196 = sext i32 %195 to i64
  %197 = getelementptr inbounds [2160 x float], ptr %194, i64 0, i64 %196
  %198 = load float, ptr %197, align 4
  store float %198, ptr %25, align 4
  br label %199

199:                                              ; preds = %161
  %200 = load i32, ptr %16, align 4
  %201 = add nsw i32 %200, -1
  store i32 %201, ptr %16, align 4
  br label %158, !llvm.loop !11

202:                                              ; preds = %158
  br label %203

203:                                              ; preds = %202
  %204 = load i32, ptr %15, align 4
  %205 = add nsw i32 %204, 1
  store i32 %205, ptr %15, align 4
  br label %151, !llvm.loop !12

206:                                              ; preds = %151
  store i32 0, ptr %15, align 4
  br label %207

207:                                              ; preds = %247, %206
  %208 = load i32, ptr %15, align 4
  %209 = load i32, ptr %8, align 4
  %210 = icmp slt i32 %208, %209
  br i1 %210, label %211, label %250

211:                                              ; preds = %207
  store i32 0, ptr %16, align 4
  br label %212

212:                                              ; preds = %243, %211
  %213 = load i32, ptr %16, align 4
  %214 = load i32, ptr %9, align 4
  %215 = icmp slt i32 %213, %214
  br i1 %215, label %216, label %246

216:                                              ; preds = %212
  %217 = load float, ptr %38, align 4
  %218 = load ptr, ptr %13, align 8
  %219 = load i32, ptr %15, align 4
  %220 = sext i32 %219 to i64
  %221 = getelementptr inbounds [2160 x float], ptr %218, i64 %220
  %222 = load i32, ptr %16, align 4
  %223 = sext i32 %222 to i64
  %224 = getelementptr inbounds [2160 x float], ptr %221, i64 0, i64 %223
  %225 = load float, ptr %224, align 4
  %226 = load ptr, ptr %14, align 8
  %227 = load i32, ptr %15, align 4
  %228 = sext i32 %227 to i64
  %229 = getelementptr inbounds [2160 x float], ptr %226, i64 %228
  %230 = load i32, ptr %16, align 4
  %231 = sext i32 %230 to i64
  %232 = getelementptr inbounds [2160 x float], ptr %229, i64 0, i64 %231
  %233 = load float, ptr %232, align 4
  %234 = fadd float %225, %233
  %235 = fmul float %217, %234
  %236 = load ptr, ptr %12, align 8
  %237 = load i32, ptr %15, align 4
  %238 = sext i32 %237 to i64
  %239 = getelementptr inbounds [2160 x float], ptr %236, i64 %238
  %240 = load i32, ptr %16, align 4
  %241 = sext i32 %240 to i64
  %242 = getelementptr inbounds [2160 x float], ptr %239, i64 0, i64 %241
  store float %235, ptr %242, align 4
  br label %243

243:                                              ; preds = %216
  %244 = load i32, ptr %16, align 4
  %245 = add nsw i32 %244, 1
  store i32 %245, ptr %16, align 4
  br label %212, !llvm.loop !13

246:                                              ; preds = %212
  br label %247

247:                                              ; preds = %246
  %248 = load i32, ptr %15, align 4
  %249 = add nsw i32 %248, 1
  store i32 %249, ptr %15, align 4
  br label %207, !llvm.loop !14

250:                                              ; preds = %207
  store i32 0, ptr %16, align 4
  br label %251

251:                                              ; preds = %308, %250
  %252 = load i32, ptr %16, align 4
  %253 = load i32, ptr %9, align 4
  %254 = icmp slt i32 %252, %253
  br i1 %254, label %255, label %311

255:                                              ; preds = %251
  store float 0.000000e+00, ptr %18, align 4
  store float 0.000000e+00, ptr %19, align 4
  store float 0.000000e+00, ptr %20, align 4
  store i32 0, ptr %15, align 4
  br label %256

256:                                              ; preds = %304, %255
  %257 = load i32, ptr %15, align 4
  %258 = load i32, ptr %8, align 4
  %259 = icmp slt i32 %257, %258
  br i1 %259, label %260, label %307

260:                                              ; preds = %256
  %261 = load float, ptr %32, align 4
  %262 = load ptr, ptr %12, align 8
  %263 = load i32, ptr %15, align 4
  %264 = sext i32 %263 to i64
  %265 = getelementptr inbounds [2160 x float], ptr %262, i64 %264
  %266 = load i32, ptr %16, align 4
  %267 = sext i32 %266 to i64
  %268 = getelementptr inbounds [2160 x float], ptr %265, i64 0, i64 %267
  %269 = load float, ptr %268, align 4
  %270 = load float, ptr %33, align 4
  %271 = load float, ptr %18, align 4
  %272 = fmul float %270, %271
  %273 = call float @llvm.fmuladd.f32(float %261, float %269, float %272)
  %274 = load float, ptr %36, align 4
  %275 = load float, ptr %19, align 4
  %276 = call float @llvm.fmuladd.f32(float %274, float %275, float %273)
  %277 = load float, ptr %37, align 4
  %278 = load float, ptr %20, align 4
  %279 = call float @llvm.fmuladd.f32(float %277, float %278, float %276)
  %280 = load ptr, ptr %13, align 8
  %281 = load i32, ptr %15, align 4
  %282 = sext i32 %281 to i64
  %283 = getelementptr inbounds [2160 x float], ptr %280, i64 %282
  %284 = load i32, ptr %16, align 4
  %285 = sext i32 %284 to i64
  %286 = getelementptr inbounds [2160 x float], ptr %283, i64 0, i64 %285
  store float %279, ptr %286, align 4
  %287 = load ptr, ptr %12, align 8
  %288 = load i32, ptr %15, align 4
  %289 = sext i32 %288 to i64
  %290 = getelementptr inbounds [2160 x float], ptr %287, i64 %289
  %291 = load i32, ptr %16, align 4
  %292 = sext i32 %291 to i64
  %293 = getelementptr inbounds [2160 x float], ptr %290, i64 0, i64 %292
  %294 = load float, ptr %293, align 4
  store float %294, ptr %18, align 4
  %295 = load float, ptr %19, align 4
  store float %295, ptr %20, align 4
  %296 = load ptr, ptr %13, align 8
  %297 = load i32, ptr %15, align 4
  %298 = sext i32 %297 to i64
  %299 = getelementptr inbounds [2160 x float], ptr %296, i64 %298
  %300 = load i32, ptr %16, align 4
  %301 = sext i32 %300 to i64
  %302 = getelementptr inbounds [2160 x float], ptr %299, i64 0, i64 %301
  %303 = load float, ptr %302, align 4
  store float %303, ptr %19, align 4
  br label %304

304:                                              ; preds = %260
  %305 = load i32, ptr %15, align 4
  %306 = add nsw i32 %305, 1
  store i32 %306, ptr %15, align 4
  br label %256, !llvm.loop !15

307:                                              ; preds = %256
  br label %308

308:                                              ; preds = %307
  %309 = load i32, ptr %16, align 4
  %310 = add nsw i32 %309, 1
  store i32 %310, ptr %16, align 4
  br label %251, !llvm.loop !16

311:                                              ; preds = %251
  store i32 0, ptr %16, align 4
  br label %312

312:                                              ; preds = %364, %311
  %313 = load i32, ptr %16, align 4
  %314 = load i32, ptr %9, align 4
  %315 = icmp slt i32 %313, %314
  br i1 %315, label %316, label %367

316:                                              ; preds = %312
  store float 0.000000e+00, ptr %23, align 4
  store float 0.000000e+00, ptr %24, align 4
  store float 0.000000e+00, ptr %25, align 4
  store float 0.000000e+00, ptr %26, align 4
  %317 = load i32, ptr %8, align 4
  %318 = sub nsw i32 %317, 1
  store i32 %318, ptr %15, align 4
  br label %319

319:                                              ; preds = %360, %316
  %320 = load i32, ptr %15, align 4
  %321 = icmp sge i32 %320, 0
  br i1 %321, label %322, label %363

322:                                              ; preds = %319
  %323 = load float, ptr %34, align 4
  %324 = load float, ptr %23, align 4
  %325 = load float, ptr %35, align 4
  %326 = load float, ptr %24, align 4
  %327 = fmul float %325, %326
  %328 = call float @llvm.fmuladd.f32(float %323, float %324, float %327)
  %329 = load float, ptr %36, align 4
  %330 = load float, ptr %25, align 4
  %331 = call float @llvm.fmuladd.f32(float %329, float %330, float %328)
  %332 = load float, ptr %37, align 4
  %333 = load float, ptr %26, align 4
  %334 = call float @llvm.fmuladd.f32(float %332, float %333, float %331)
  %335 = load ptr, ptr %14, align 8
  %336 = load i32, ptr %15, align 4
  %337 = sext i32 %336 to i64
  %338 = getelementptr inbounds [2160 x float], ptr %335, i64 %337
  %339 = load i32, ptr %16, align 4
  %340 = sext i32 %339 to i64
  %341 = getelementptr inbounds [2160 x float], ptr %338, i64 0, i64 %340
  store float %334, ptr %341, align 4
  %342 = load float, ptr %23, align 4
  store float %342, ptr %24, align 4
  %343 = load ptr, ptr %12, align 8
  %344 = load i32, ptr %15, align 4
  %345 = sext i32 %344 to i64
  %346 = getelementptr inbounds [2160 x float], ptr %343, i64 %345
  %347 = load i32, ptr %16, align 4
  %348 = sext i32 %347 to i64
  %349 = getelementptr inbounds [2160 x float], ptr %346, i64 0, i64 %348
  %350 = load float, ptr %349, align 4
  store float %350, ptr %23, align 4
  %351 = load float, ptr %25, align 4
  store float %351, ptr %26, align 4
  %352 = load ptr, ptr %14, align 8
  %353 = load i32, ptr %15, align 4
  %354 = sext i32 %353 to i64
  %355 = getelementptr inbounds [2160 x float], ptr %352, i64 %354
  %356 = load i32, ptr %16, align 4
  %357 = sext i32 %356 to i64
  %358 = getelementptr inbounds [2160 x float], ptr %355, i64 0, i64 %357
  %359 = load float, ptr %358, align 4
  store float %359, ptr %25, align 4
  br label %360

360:                                              ; preds = %322
  %361 = load i32, ptr %15, align 4
  %362 = add nsw i32 %361, -1
  store i32 %362, ptr %15, align 4
  br label %319, !llvm.loop !17

363:                                              ; preds = %319
  br label %364

364:                                              ; preds = %363
  %365 = load i32, ptr %16, align 4
  %366 = add nsw i32 %365, 1
  store i32 %366, ptr %16, align 4
  br label %312, !llvm.loop !18

367:                                              ; preds = %312
  store i32 0, ptr %15, align 4
  br label %368

368:                                              ; preds = %408, %367
  %369 = load i32, ptr %15, align 4
  %370 = load i32, ptr %8, align 4
  %371 = icmp slt i32 %369, %370
  br i1 %371, label %372, label %411

372:                                              ; preds = %368
  store i32 0, ptr %16, align 4
  br label %373

373:                                              ; preds = %404, %372
  %374 = load i32, ptr %16, align 4
  %375 = load i32, ptr %9, align 4
  %376 = icmp slt i32 %374, %375
  br i1 %376, label %377, label %407

377:                                              ; preds = %373
  %378 = load float, ptr %39, align 4
  %379 = load ptr, ptr %13, align 8
  %380 = load i32, ptr %15, align 4
  %381 = sext i32 %380 to i64
  %382 = getelementptr inbounds [2160 x float], ptr %379, i64 %381
  %383 = load i32, ptr %16, align 4
  %384 = sext i32 %383 to i64
  %385 = getelementptr inbounds [2160 x float], ptr %382, i64 0, i64 %384
  %386 = load float, ptr %385, align 4
  %387 = load ptr, ptr %14, align 8
  %388 = load i32, ptr %15, align 4
  %389 = sext i32 %388 to i64
  %390 = getelementptr inbounds [2160 x float], ptr %387, i64 %389
  %391 = load i32, ptr %16, align 4
  %392 = sext i32 %391 to i64
  %393 = getelementptr inbounds [2160 x float], ptr %390, i64 0, i64 %392
  %394 = load float, ptr %393, align 4
  %395 = fadd float %386, %394
  %396 = fmul float %378, %395
  %397 = load ptr, ptr %12, align 8
  %398 = load i32, ptr %15, align 4
  %399 = sext i32 %398 to i64
  %400 = getelementptr inbounds [2160 x float], ptr %397, i64 %399
  %401 = load i32, ptr %16, align 4
  %402 = sext i32 %401 to i64
  %403 = getelementptr inbounds [2160 x float], ptr %400, i64 0, i64 %402
  store float %396, ptr %403, align 4
  br label %404

404:                                              ; preds = %377
  %405 = load i32, ptr %16, align 4
  %406 = add nsw i32 %405, 1
  store i32 %406, ptr %16, align 4
  br label %373, !llvm.loop !19

407:                                              ; preds = %373
  br label %408

408:                                              ; preds = %407
  %409 = load i32, ptr %15, align 4
  %410 = add nsw i32 %409, 1
  store i32 %410, ptr %15, align 4
  br label %368, !llvm.loop !20

411:                                              ; preds = %368
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, i32 noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store ptr %2, ptr %6, align 8
  %9 = load ptr, ptr @stderr, align 8
  %10 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %9, ptr noundef @.str.1)
  %11 = load ptr, ptr @stderr, align 8
  %12 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %11, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %7, align 4
  br label %13

13:                                               ; preds = %49, %3
  %14 = load i32, ptr %7, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %52

17:                                               ; preds = %13
  store i32 0, ptr %8, align 4
  br label %18

18:                                               ; preds = %45, %17
  %19 = load i32, ptr %8, align 4
  %20 = load i32, ptr %5, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %48

22:                                               ; preds = %18
  %23 = load i32, ptr %7, align 4
  %24 = load i32, ptr %5, align 4
  %25 = mul nsw i32 %23, %24
  %26 = load i32, ptr %8, align 4
  %27 = add nsw i32 %25, %26
  %28 = srem i32 %27, 20
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %30, label %33

30:                                               ; preds = %22
  %31 = load ptr, ptr @stderr, align 8
  %32 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %31, ptr noundef @.str.4)
  br label %33

33:                                               ; preds = %30, %22
  %34 = load ptr, ptr @stderr, align 8
  %35 = load ptr, ptr %6, align 8
  %36 = load i32, ptr %7, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [2160 x float], ptr %35, i64 %37
  %39 = load i32, ptr %8, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [2160 x float], ptr %38, i64 0, i64 %40
  %42 = load float, ptr %41, align 4
  %43 = fpext float %42 to double
  %44 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %34, ptr noundef @.str.5, double noundef %43)
  br label %45

45:                                               ; preds = %33
  %46 = load i32, ptr %8, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, ptr %8, align 4
  br label %18, !llvm.loop !21

48:                                               ; preds = %18
  br label %49

49:                                               ; preds = %48
  %50 = load i32, ptr %7, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %7, align 4
  br label %13, !llvm.loop !22

52:                                               ; preds = %13
  %53 = load ptr, ptr @stderr, align 8
  %54 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %53, ptr noundef @.str.6, ptr noundef @.str.3)
  %55 = load ptr, ptr @stderr, align 8
  %56 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %55, ptr noundef @.str.7)
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

; Function Attrs: nounwind
declare float @expf(float noundef) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #4

; Function Attrs: nounwind
declare float @powf(float noundef, float noundef) #3

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind willreturn memory(read) }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
