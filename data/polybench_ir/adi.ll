; ModuleID = '/code/data/webassembly-polybench-c-master/stencils/adi/adi.c'
source_filename = "/code/data/webassembly-polybench-c-master/stencils/adi/adi.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"u\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 1000, ptr %6, align 4
  store i32 500, ptr %7, align 4
  %12 = call ptr @polybench_alloc_data(i64 noundef 1000000, i32 noundef 8)
  store ptr %12, ptr %8, align 8
  %13 = call ptr @polybench_alloc_data(i64 noundef 1000000, i32 noundef 8)
  store ptr %13, ptr %9, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 1000000, i32 noundef 8)
  store ptr %14, ptr %10, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 1000000, i32 noundef 8)
  store ptr %15, ptr %11, align 8
  %16 = load i32, ptr %6, align 4
  %17 = load ptr, ptr %8, align 8
  %18 = getelementptr inbounds [1000 x [1000 x double]], ptr %17, i64 0, i64 0
  call void @init_array(i32 noundef %16, ptr noundef %18)
  %19 = load i32, ptr %7, align 4
  %20 = load i32, ptr %6, align 4
  %21 = load ptr, ptr %8, align 8
  %22 = getelementptr inbounds [1000 x [1000 x double]], ptr %21, i64 0, i64 0
  %23 = load ptr, ptr %9, align 8
  %24 = getelementptr inbounds [1000 x [1000 x double]], ptr %23, i64 0, i64 0
  %25 = load ptr, ptr %10, align 8
  %26 = getelementptr inbounds [1000 x [1000 x double]], ptr %25, i64 0, i64 0
  %27 = load ptr, ptr %11, align 8
  %28 = getelementptr inbounds [1000 x [1000 x double]], ptr %27, i64 0, i64 0
  call void @kernel_adi(i32 noundef %19, i32 noundef %20, ptr noundef %22, ptr noundef %24, ptr noundef %26, ptr noundef %28)
  %29 = load i32, ptr %4, align 4
  %30 = icmp sgt i32 %29, 42
  br i1 %30, label %31, label %41

31:                                               ; preds = %2
  %32 = load ptr, ptr %5, align 8
  %33 = getelementptr inbounds ptr, ptr %32, i64 0
  %34 = load ptr, ptr %33, align 8
  %35 = call i32 @strcmp(ptr noundef %34, ptr noundef @.str) #5
  %36 = icmp ne i32 %35, 0
  br i1 %36, label %41, label %37

37:                                               ; preds = %31
  %38 = load i32, ptr %6, align 4
  %39 = load ptr, ptr %8, align 8
  %40 = getelementptr inbounds [1000 x [1000 x double]], ptr %39, i64 0, i64 0
  call void @print_array(i32 noundef %38, ptr noundef %40)
  br label %41

41:                                               ; preds = %37, %31, %2
  %42 = load ptr, ptr %8, align 8
  call void @free(ptr noundef %42) #6
  %43 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %43) #6
  %44 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %44) #6
  %45 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %45) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %7

7:                                                ; preds = %37, %2
  %8 = load i32, ptr %5, align 4
  %9 = load i32, ptr %3, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %40

11:                                               ; preds = %7
  store i32 0, ptr %6, align 4
  br label %12

12:                                               ; preds = %33, %11
  %13 = load i32, ptr %6, align 4
  %14 = load i32, ptr %3, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %36

16:                                               ; preds = %12
  %17 = load i32, ptr %5, align 4
  %18 = load i32, ptr %3, align 4
  %19 = add nsw i32 %17, %18
  %20 = load i32, ptr %6, align 4
  %21 = sub nsw i32 %19, %20
  %22 = sitofp i32 %21 to double
  %23 = load i32, ptr %3, align 4
  %24 = sitofp i32 %23 to double
  %25 = fdiv double %22, %24
  %26 = load ptr, ptr %4, align 8
  %27 = load i32, ptr %5, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [1000 x double], ptr %26, i64 %28
  %30 = load i32, ptr %6, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [1000 x double], ptr %29, i64 0, i64 %31
  store double %25, ptr %32, align 8
  br label %33

33:                                               ; preds = %16
  %34 = load i32, ptr %6, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %6, align 4
  br label %12, !llvm.loop !6

36:                                               ; preds = %12
  br label %37

37:                                               ; preds = %36
  %38 = load i32, ptr %5, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %5, align 4
  br label %7, !llvm.loop !8

40:                                               ; preds = %7
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_adi(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca double, align 8
  %17 = alloca double, align 8
  %18 = alloca double, align 8
  %19 = alloca double, align 8
  %20 = alloca double, align 8
  %21 = alloca double, align 8
  %22 = alloca double, align 8
  %23 = alloca double, align 8
  %24 = alloca double, align 8
  %25 = alloca double, align 8
  %26 = alloca double, align 8
  %27 = alloca double, align 8
  %28 = alloca double, align 8
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store ptr %2, ptr %9, align 8
  store ptr %3, ptr %10, align 8
  store ptr %4, ptr %11, align 8
  store ptr %5, ptr %12, align 8
  %29 = load i32, ptr %8, align 4
  %30 = sitofp i32 %29 to double
  %31 = fdiv double 1.000000e+00, %30
  store double %31, ptr %16, align 8
  %32 = load i32, ptr %8, align 4
  %33 = sitofp i32 %32 to double
  %34 = fdiv double 1.000000e+00, %33
  store double %34, ptr %17, align 8
  %35 = load i32, ptr %7, align 4
  %36 = sitofp i32 %35 to double
  %37 = fdiv double 1.000000e+00, %36
  store double %37, ptr %18, align 8
  store double 2.000000e+00, ptr %19, align 8
  store double 1.000000e+00, ptr %20, align 8
  %38 = load double, ptr %19, align 8
  %39 = load double, ptr %18, align 8
  %40 = fmul double %38, %39
  %41 = load double, ptr %16, align 8
  %42 = load double, ptr %16, align 8
  %43 = fmul double %41, %42
  %44 = fdiv double %40, %43
  store double %44, ptr %21, align 8
  %45 = load double, ptr %20, align 8
  %46 = load double, ptr %18, align 8
  %47 = fmul double %45, %46
  %48 = load double, ptr %17, align 8
  %49 = load double, ptr %17, align 8
  %50 = fmul double %48, %49
  %51 = fdiv double %47, %50
  store double %51, ptr %22, align 8
  %52 = load double, ptr %21, align 8
  %53 = fneg double %52
  %54 = fdiv double %53, 2.000000e+00
  store double %54, ptr %23, align 8
  %55 = load double, ptr %21, align 8
  %56 = fadd double 1.000000e+00, %55
  store double %56, ptr %24, align 8
  %57 = load double, ptr %23, align 8
  store double %57, ptr %25, align 8
  %58 = load double, ptr %22, align 8
  %59 = fneg double %58
  %60 = fdiv double %59, 2.000000e+00
  store double %60, ptr %26, align 8
  %61 = load double, ptr %22, align 8
  %62 = fadd double 1.000000e+00, %61
  store double %62, ptr %27, align 8
  %63 = load double, ptr %26, align 8
  store double %63, ptr %28, align 8
  store i32 1, ptr %13, align 4
  br label %64

64:                                               ; preds = %431, %6
  %65 = load i32, ptr %13, align 4
  %66 = load i32, ptr %7, align 4
  %67 = icmp sle i32 %65, %66
  br i1 %67, label %68, label %434

68:                                               ; preds = %64
  store i32 1, ptr %14, align 4
  br label %69

69:                                               ; preds = %246, %68
  %70 = load i32, ptr %14, align 4
  %71 = load i32, ptr %8, align 4
  %72 = sub nsw i32 %71, 1
  %73 = icmp slt i32 %70, %72
  br i1 %73, label %74, label %249

74:                                               ; preds = %69
  %75 = load ptr, ptr %10, align 8
  %76 = getelementptr inbounds [1000 x double], ptr %75, i64 0
  %77 = load i32, ptr %14, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [1000 x double], ptr %76, i64 0, i64 %78
  store double 1.000000e+00, ptr %79, align 8
  %80 = load ptr, ptr %11, align 8
  %81 = load i32, ptr %14, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [1000 x double], ptr %80, i64 %82
  %84 = getelementptr inbounds [1000 x double], ptr %83, i64 0, i64 0
  store double 0.000000e+00, ptr %84, align 8
  %85 = load ptr, ptr %10, align 8
  %86 = getelementptr inbounds [1000 x double], ptr %85, i64 0
  %87 = load i32, ptr %14, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds [1000 x double], ptr %86, i64 0, i64 %88
  %90 = load double, ptr %89, align 8
  %91 = load ptr, ptr %12, align 8
  %92 = load i32, ptr %14, align 4
  %93 = sext i32 %92 to i64
  %94 = getelementptr inbounds [1000 x double], ptr %91, i64 %93
  %95 = getelementptr inbounds [1000 x double], ptr %94, i64 0, i64 0
  store double %90, ptr %95, align 8
  store i32 1, ptr %15, align 4
  br label %96

96:                                               ; preds = %191, %74
  %97 = load i32, ptr %15, align 4
  %98 = load i32, ptr %8, align 4
  %99 = sub nsw i32 %98, 1
  %100 = icmp slt i32 %97, %99
  br i1 %100, label %101, label %194

101:                                              ; preds = %96
  %102 = load double, ptr %25, align 8
  %103 = fneg double %102
  %104 = load double, ptr %23, align 8
  %105 = load ptr, ptr %11, align 8
  %106 = load i32, ptr %14, align 4
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [1000 x double], ptr %105, i64 %107
  %109 = load i32, ptr %15, align 4
  %110 = sub nsw i32 %109, 1
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds [1000 x double], ptr %108, i64 0, i64 %111
  %113 = load double, ptr %112, align 8
  %114 = load double, ptr %24, align 8
  %115 = call double @llvm.fmuladd.f64(double %104, double %113, double %114)
  %116 = fdiv double %103, %115
  %117 = load ptr, ptr %11, align 8
  %118 = load i32, ptr %14, align 4
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds [1000 x double], ptr %117, i64 %119
  %121 = load i32, ptr %15, align 4
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds [1000 x double], ptr %120, i64 0, i64 %122
  store double %116, ptr %123, align 8
  %124 = load double, ptr %26, align 8
  %125 = fneg double %124
  %126 = load ptr, ptr %9, align 8
  %127 = load i32, ptr %15, align 4
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds [1000 x double], ptr %126, i64 %128
  %130 = load i32, ptr %14, align 4
  %131 = sub nsw i32 %130, 1
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds [1000 x double], ptr %129, i64 0, i64 %132
  %134 = load double, ptr %133, align 8
  %135 = load double, ptr %26, align 8
  %136 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %135, double 1.000000e+00)
  %137 = load ptr, ptr %9, align 8
  %138 = load i32, ptr %15, align 4
  %139 = sext i32 %138 to i64
  %140 = getelementptr inbounds [1000 x double], ptr %137, i64 %139
  %141 = load i32, ptr %14, align 4
  %142 = sext i32 %141 to i64
  %143 = getelementptr inbounds [1000 x double], ptr %140, i64 0, i64 %142
  %144 = load double, ptr %143, align 8
  %145 = fmul double %136, %144
  %146 = call double @llvm.fmuladd.f64(double %125, double %134, double %145)
  %147 = load double, ptr %28, align 8
  %148 = load ptr, ptr %9, align 8
  %149 = load i32, ptr %15, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds [1000 x double], ptr %148, i64 %150
  %152 = load i32, ptr %14, align 4
  %153 = add nsw i32 %152, 1
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds [1000 x double], ptr %151, i64 0, i64 %154
  %156 = load double, ptr %155, align 8
  %157 = fneg double %147
  %158 = call double @llvm.fmuladd.f64(double %157, double %156, double %146)
  %159 = load double, ptr %23, align 8
  %160 = load ptr, ptr %12, align 8
  %161 = load i32, ptr %14, align 4
  %162 = sext i32 %161 to i64
  %163 = getelementptr inbounds [1000 x double], ptr %160, i64 %162
  %164 = load i32, ptr %15, align 4
  %165 = sub nsw i32 %164, 1
  %166 = sext i32 %165 to i64
  %167 = getelementptr inbounds [1000 x double], ptr %163, i64 0, i64 %166
  %168 = load double, ptr %167, align 8
  %169 = fneg double %159
  %170 = call double @llvm.fmuladd.f64(double %169, double %168, double %158)
  %171 = load double, ptr %23, align 8
  %172 = load ptr, ptr %11, align 8
  %173 = load i32, ptr %14, align 4
  %174 = sext i32 %173 to i64
  %175 = getelementptr inbounds [1000 x double], ptr %172, i64 %174
  %176 = load i32, ptr %15, align 4
  %177 = sub nsw i32 %176, 1
  %178 = sext i32 %177 to i64
  %179 = getelementptr inbounds [1000 x double], ptr %175, i64 0, i64 %178
  %180 = load double, ptr %179, align 8
  %181 = load double, ptr %24, align 8
  %182 = call double @llvm.fmuladd.f64(double %171, double %180, double %181)
  %183 = fdiv double %170, %182
  %184 = load ptr, ptr %12, align 8
  %185 = load i32, ptr %14, align 4
  %186 = sext i32 %185 to i64
  %187 = getelementptr inbounds [1000 x double], ptr %184, i64 %186
  %188 = load i32, ptr %15, align 4
  %189 = sext i32 %188 to i64
  %190 = getelementptr inbounds [1000 x double], ptr %187, i64 0, i64 %189
  store double %183, ptr %190, align 8
  br label %191

191:                                              ; preds = %101
  %192 = load i32, ptr %15, align 4
  %193 = add nsw i32 %192, 1
  store i32 %193, ptr %15, align 4
  br label %96, !llvm.loop !9

194:                                              ; preds = %96
  %195 = load ptr, ptr %10, align 8
  %196 = load i32, ptr %8, align 4
  %197 = sub nsw i32 %196, 1
  %198 = sext i32 %197 to i64
  %199 = getelementptr inbounds [1000 x double], ptr %195, i64 %198
  %200 = load i32, ptr %14, align 4
  %201 = sext i32 %200 to i64
  %202 = getelementptr inbounds [1000 x double], ptr %199, i64 0, i64 %201
  store double 1.000000e+00, ptr %202, align 8
  %203 = load i32, ptr %8, align 4
  %204 = sub nsw i32 %203, 2
  store i32 %204, ptr %15, align 4
  br label %205

205:                                              ; preds = %242, %194
  %206 = load i32, ptr %15, align 4
  %207 = icmp sge i32 %206, 1
  br i1 %207, label %208, label %245

208:                                              ; preds = %205
  %209 = load ptr, ptr %11, align 8
  %210 = load i32, ptr %14, align 4
  %211 = sext i32 %210 to i64
  %212 = getelementptr inbounds [1000 x double], ptr %209, i64 %211
  %213 = load i32, ptr %15, align 4
  %214 = sext i32 %213 to i64
  %215 = getelementptr inbounds [1000 x double], ptr %212, i64 0, i64 %214
  %216 = load double, ptr %215, align 8
  %217 = load ptr, ptr %10, align 8
  %218 = load i32, ptr %15, align 4
  %219 = add nsw i32 %218, 1
  %220 = sext i32 %219 to i64
  %221 = getelementptr inbounds [1000 x double], ptr %217, i64 %220
  %222 = load i32, ptr %14, align 4
  %223 = sext i32 %222 to i64
  %224 = getelementptr inbounds [1000 x double], ptr %221, i64 0, i64 %223
  %225 = load double, ptr %224, align 8
  %226 = load ptr, ptr %12, align 8
  %227 = load i32, ptr %14, align 4
  %228 = sext i32 %227 to i64
  %229 = getelementptr inbounds [1000 x double], ptr %226, i64 %228
  %230 = load i32, ptr %15, align 4
  %231 = sext i32 %230 to i64
  %232 = getelementptr inbounds [1000 x double], ptr %229, i64 0, i64 %231
  %233 = load double, ptr %232, align 8
  %234 = call double @llvm.fmuladd.f64(double %216, double %225, double %233)
  %235 = load ptr, ptr %10, align 8
  %236 = load i32, ptr %15, align 4
  %237 = sext i32 %236 to i64
  %238 = getelementptr inbounds [1000 x double], ptr %235, i64 %237
  %239 = load i32, ptr %14, align 4
  %240 = sext i32 %239 to i64
  %241 = getelementptr inbounds [1000 x double], ptr %238, i64 0, i64 %240
  store double %234, ptr %241, align 8
  br label %242

242:                                              ; preds = %208
  %243 = load i32, ptr %15, align 4
  %244 = add nsw i32 %243, -1
  store i32 %244, ptr %15, align 4
  br label %205, !llvm.loop !10

245:                                              ; preds = %205
  br label %246

246:                                              ; preds = %245
  %247 = load i32, ptr %14, align 4
  %248 = add nsw i32 %247, 1
  store i32 %248, ptr %14, align 4
  br label %69, !llvm.loop !11

249:                                              ; preds = %69
  store i32 1, ptr %14, align 4
  br label %250

250:                                              ; preds = %427, %249
  %251 = load i32, ptr %14, align 4
  %252 = load i32, ptr %8, align 4
  %253 = sub nsw i32 %252, 1
  %254 = icmp slt i32 %251, %253
  br i1 %254, label %255, label %430

255:                                              ; preds = %250
  %256 = load ptr, ptr %9, align 8
  %257 = load i32, ptr %14, align 4
  %258 = sext i32 %257 to i64
  %259 = getelementptr inbounds [1000 x double], ptr %256, i64 %258
  %260 = getelementptr inbounds [1000 x double], ptr %259, i64 0, i64 0
  store double 1.000000e+00, ptr %260, align 8
  %261 = load ptr, ptr %11, align 8
  %262 = load i32, ptr %14, align 4
  %263 = sext i32 %262 to i64
  %264 = getelementptr inbounds [1000 x double], ptr %261, i64 %263
  %265 = getelementptr inbounds [1000 x double], ptr %264, i64 0, i64 0
  store double 0.000000e+00, ptr %265, align 8
  %266 = load ptr, ptr %9, align 8
  %267 = load i32, ptr %14, align 4
  %268 = sext i32 %267 to i64
  %269 = getelementptr inbounds [1000 x double], ptr %266, i64 %268
  %270 = getelementptr inbounds [1000 x double], ptr %269, i64 0, i64 0
  %271 = load double, ptr %270, align 8
  %272 = load ptr, ptr %12, align 8
  %273 = load i32, ptr %14, align 4
  %274 = sext i32 %273 to i64
  %275 = getelementptr inbounds [1000 x double], ptr %272, i64 %274
  %276 = getelementptr inbounds [1000 x double], ptr %275, i64 0, i64 0
  store double %271, ptr %276, align 8
  store i32 1, ptr %15, align 4
  br label %277

277:                                              ; preds = %372, %255
  %278 = load i32, ptr %15, align 4
  %279 = load i32, ptr %8, align 4
  %280 = sub nsw i32 %279, 1
  %281 = icmp slt i32 %278, %280
  br i1 %281, label %282, label %375

282:                                              ; preds = %277
  %283 = load double, ptr %28, align 8
  %284 = fneg double %283
  %285 = load double, ptr %26, align 8
  %286 = load ptr, ptr %11, align 8
  %287 = load i32, ptr %14, align 4
  %288 = sext i32 %287 to i64
  %289 = getelementptr inbounds [1000 x double], ptr %286, i64 %288
  %290 = load i32, ptr %15, align 4
  %291 = sub nsw i32 %290, 1
  %292 = sext i32 %291 to i64
  %293 = getelementptr inbounds [1000 x double], ptr %289, i64 0, i64 %292
  %294 = load double, ptr %293, align 8
  %295 = load double, ptr %27, align 8
  %296 = call double @llvm.fmuladd.f64(double %285, double %294, double %295)
  %297 = fdiv double %284, %296
  %298 = load ptr, ptr %11, align 8
  %299 = load i32, ptr %14, align 4
  %300 = sext i32 %299 to i64
  %301 = getelementptr inbounds [1000 x double], ptr %298, i64 %300
  %302 = load i32, ptr %15, align 4
  %303 = sext i32 %302 to i64
  %304 = getelementptr inbounds [1000 x double], ptr %301, i64 0, i64 %303
  store double %297, ptr %304, align 8
  %305 = load double, ptr %23, align 8
  %306 = fneg double %305
  %307 = load ptr, ptr %10, align 8
  %308 = load i32, ptr %14, align 4
  %309 = sub nsw i32 %308, 1
  %310 = sext i32 %309 to i64
  %311 = getelementptr inbounds [1000 x double], ptr %307, i64 %310
  %312 = load i32, ptr %15, align 4
  %313 = sext i32 %312 to i64
  %314 = getelementptr inbounds [1000 x double], ptr %311, i64 0, i64 %313
  %315 = load double, ptr %314, align 8
  %316 = load double, ptr %23, align 8
  %317 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %316, double 1.000000e+00)
  %318 = load ptr, ptr %10, align 8
  %319 = load i32, ptr %14, align 4
  %320 = sext i32 %319 to i64
  %321 = getelementptr inbounds [1000 x double], ptr %318, i64 %320
  %322 = load i32, ptr %15, align 4
  %323 = sext i32 %322 to i64
  %324 = getelementptr inbounds [1000 x double], ptr %321, i64 0, i64 %323
  %325 = load double, ptr %324, align 8
  %326 = fmul double %317, %325
  %327 = call double @llvm.fmuladd.f64(double %306, double %315, double %326)
  %328 = load double, ptr %25, align 8
  %329 = load ptr, ptr %10, align 8
  %330 = load i32, ptr %14, align 4
  %331 = add nsw i32 %330, 1
  %332 = sext i32 %331 to i64
  %333 = getelementptr inbounds [1000 x double], ptr %329, i64 %332
  %334 = load i32, ptr %15, align 4
  %335 = sext i32 %334 to i64
  %336 = getelementptr inbounds [1000 x double], ptr %333, i64 0, i64 %335
  %337 = load double, ptr %336, align 8
  %338 = fneg double %328
  %339 = call double @llvm.fmuladd.f64(double %338, double %337, double %327)
  %340 = load double, ptr %26, align 8
  %341 = load ptr, ptr %12, align 8
  %342 = load i32, ptr %14, align 4
  %343 = sext i32 %342 to i64
  %344 = getelementptr inbounds [1000 x double], ptr %341, i64 %343
  %345 = load i32, ptr %15, align 4
  %346 = sub nsw i32 %345, 1
  %347 = sext i32 %346 to i64
  %348 = getelementptr inbounds [1000 x double], ptr %344, i64 0, i64 %347
  %349 = load double, ptr %348, align 8
  %350 = fneg double %340
  %351 = call double @llvm.fmuladd.f64(double %350, double %349, double %339)
  %352 = load double, ptr %26, align 8
  %353 = load ptr, ptr %11, align 8
  %354 = load i32, ptr %14, align 4
  %355 = sext i32 %354 to i64
  %356 = getelementptr inbounds [1000 x double], ptr %353, i64 %355
  %357 = load i32, ptr %15, align 4
  %358 = sub nsw i32 %357, 1
  %359 = sext i32 %358 to i64
  %360 = getelementptr inbounds [1000 x double], ptr %356, i64 0, i64 %359
  %361 = load double, ptr %360, align 8
  %362 = load double, ptr %27, align 8
  %363 = call double @llvm.fmuladd.f64(double %352, double %361, double %362)
  %364 = fdiv double %351, %363
  %365 = load ptr, ptr %12, align 8
  %366 = load i32, ptr %14, align 4
  %367 = sext i32 %366 to i64
  %368 = getelementptr inbounds [1000 x double], ptr %365, i64 %367
  %369 = load i32, ptr %15, align 4
  %370 = sext i32 %369 to i64
  %371 = getelementptr inbounds [1000 x double], ptr %368, i64 0, i64 %370
  store double %364, ptr %371, align 8
  br label %372

372:                                              ; preds = %282
  %373 = load i32, ptr %15, align 4
  %374 = add nsw i32 %373, 1
  store i32 %374, ptr %15, align 4
  br label %277, !llvm.loop !12

375:                                              ; preds = %277
  %376 = load ptr, ptr %9, align 8
  %377 = load i32, ptr %14, align 4
  %378 = sext i32 %377 to i64
  %379 = getelementptr inbounds [1000 x double], ptr %376, i64 %378
  %380 = load i32, ptr %8, align 4
  %381 = sub nsw i32 %380, 1
  %382 = sext i32 %381 to i64
  %383 = getelementptr inbounds [1000 x double], ptr %379, i64 0, i64 %382
  store double 1.000000e+00, ptr %383, align 8
  %384 = load i32, ptr %8, align 4
  %385 = sub nsw i32 %384, 2
  store i32 %385, ptr %15, align 4
  br label %386

386:                                              ; preds = %423, %375
  %387 = load i32, ptr %15, align 4
  %388 = icmp sge i32 %387, 1
  br i1 %388, label %389, label %426

389:                                              ; preds = %386
  %390 = load ptr, ptr %11, align 8
  %391 = load i32, ptr %14, align 4
  %392 = sext i32 %391 to i64
  %393 = getelementptr inbounds [1000 x double], ptr %390, i64 %392
  %394 = load i32, ptr %15, align 4
  %395 = sext i32 %394 to i64
  %396 = getelementptr inbounds [1000 x double], ptr %393, i64 0, i64 %395
  %397 = load double, ptr %396, align 8
  %398 = load ptr, ptr %9, align 8
  %399 = load i32, ptr %14, align 4
  %400 = sext i32 %399 to i64
  %401 = getelementptr inbounds [1000 x double], ptr %398, i64 %400
  %402 = load i32, ptr %15, align 4
  %403 = add nsw i32 %402, 1
  %404 = sext i32 %403 to i64
  %405 = getelementptr inbounds [1000 x double], ptr %401, i64 0, i64 %404
  %406 = load double, ptr %405, align 8
  %407 = load ptr, ptr %12, align 8
  %408 = load i32, ptr %14, align 4
  %409 = sext i32 %408 to i64
  %410 = getelementptr inbounds [1000 x double], ptr %407, i64 %409
  %411 = load i32, ptr %15, align 4
  %412 = sext i32 %411 to i64
  %413 = getelementptr inbounds [1000 x double], ptr %410, i64 0, i64 %412
  %414 = load double, ptr %413, align 8
  %415 = call double @llvm.fmuladd.f64(double %397, double %406, double %414)
  %416 = load ptr, ptr %9, align 8
  %417 = load i32, ptr %14, align 4
  %418 = sext i32 %417 to i64
  %419 = getelementptr inbounds [1000 x double], ptr %416, i64 %418
  %420 = load i32, ptr %15, align 4
  %421 = sext i32 %420 to i64
  %422 = getelementptr inbounds [1000 x double], ptr %419, i64 0, i64 %421
  store double %415, ptr %422, align 8
  br label %423

423:                                              ; preds = %389
  %424 = load i32, ptr %15, align 4
  %425 = add nsw i32 %424, -1
  store i32 %425, ptr %15, align 4
  br label %386, !llvm.loop !13

426:                                              ; preds = %386
  br label %427

427:                                              ; preds = %426
  %428 = load i32, ptr %14, align 4
  %429 = add nsw i32 %428, 1
  store i32 %429, ptr %14, align 4
  br label %250, !llvm.loop !14

430:                                              ; preds = %250
  br label %431

431:                                              ; preds = %430
  %432 = load i32, ptr %13, align 4
  %433 = add nsw i32 %432, 1
  store i32 %433, ptr %13, align 4
  br label %64, !llvm.loop !15

434:                                              ; preds = %64
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  %7 = load ptr, ptr @stderr, align 8
  %8 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %7, ptr noundef @.str.1)
  %9 = load ptr, ptr @stderr, align 8
  %10 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %9, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %5, align 4
  br label %11

11:                                               ; preds = %46, %2
  %12 = load i32, ptr %5, align 4
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %49

15:                                               ; preds = %11
  store i32 0, ptr %6, align 4
  br label %16

16:                                               ; preds = %42, %15
  %17 = load i32, ptr %6, align 4
  %18 = load i32, ptr %3, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %45

20:                                               ; preds = %16
  %21 = load i32, ptr %5, align 4
  %22 = load i32, ptr %3, align 4
  %23 = mul nsw i32 %21, %22
  %24 = load i32, ptr %6, align 4
  %25 = add nsw i32 %23, %24
  %26 = srem i32 %25, 20
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %31

28:                                               ; preds = %20
  %29 = load ptr, ptr @stderr, align 8
  %30 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %29, ptr noundef @.str.4)
  br label %31

31:                                               ; preds = %28, %20
  %32 = load ptr, ptr @stderr, align 8
  %33 = load ptr, ptr %4, align 8
  %34 = load i32, ptr %5, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [1000 x double], ptr %33, i64 %35
  %37 = load i32, ptr %6, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [1000 x double], ptr %36, i64 0, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %32, ptr noundef @.str.5, double noundef %40)
  br label %42

42:                                               ; preds = %31
  %43 = load i32, ptr %6, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %6, align 4
  br label %16, !llvm.loop !16

45:                                               ; preds = %16
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %5, align 4
  br label %11, !llvm.loop !17

49:                                               ; preds = %11
  %50 = load ptr, ptr @stderr, align 8
  %51 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %50, ptr noundef @.str.6, ptr noundef @.str.3)
  %52 = load ptr, ptr @stderr, align 8
  %53 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %52, ptr noundef @.str.7)
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #4

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
