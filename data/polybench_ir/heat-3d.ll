; ModuleID = '/code/data/webassembly-polybench-c-master/stencils/heat-3d/heat-3d.c'
source_filename = "/code/data/webassembly-polybench-c-master/stencils/heat-3d/heat-3d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
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
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 120, ptr %6, align 4
  store i32 500, ptr %7, align 4
  %10 = call ptr @polybench_alloc_data(i64 noundef 1728000, i32 noundef 8)
  store ptr %10, ptr %8, align 8
  %11 = call ptr @polybench_alloc_data(i64 noundef 1728000, i32 noundef 8)
  store ptr %11, ptr %9, align 8
  %12 = load i32, ptr %6, align 4
  %13 = load ptr, ptr %8, align 8
  %14 = getelementptr inbounds [120 x [120 x [120 x double]]], ptr %13, i64 0, i64 0
  %15 = load ptr, ptr %9, align 8
  %16 = getelementptr inbounds [120 x [120 x [120 x double]]], ptr %15, i64 0, i64 0
  call void @init_array(i32 noundef %12, ptr noundef %14, ptr noundef %16)
  %17 = load i32, ptr %7, align 4
  %18 = load i32, ptr %6, align 4
  %19 = load ptr, ptr %8, align 8
  %20 = getelementptr inbounds [120 x [120 x [120 x double]]], ptr %19, i64 0, i64 0
  %21 = load ptr, ptr %9, align 8
  %22 = getelementptr inbounds [120 x [120 x [120 x double]]], ptr %21, i64 0, i64 0
  call void @kernel_heat_3d(i32 noundef %17, i32 noundef %18, ptr noundef %20, ptr noundef %22)
  %23 = load i32, ptr %4, align 4
  %24 = icmp sgt i32 %23, 42
  br i1 %24, label %25, label %35

25:                                               ; preds = %2
  %26 = load ptr, ptr %5, align 8
  %27 = getelementptr inbounds ptr, ptr %26, i64 0
  %28 = load ptr, ptr %27, align 8
  %29 = call i32 @strcmp(ptr noundef %28, ptr noundef @.str) #5
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %35, label %31

31:                                               ; preds = %25
  %32 = load i32, ptr %6, align 4
  %33 = load ptr, ptr %8, align 8
  %34 = getelementptr inbounds [120 x [120 x [120 x double]]], ptr %33, i64 0, i64 0
  call void @print_array(i32 noundef %32, ptr noundef %34)
  br label %35

35:                                               ; preds = %31, %25, %2
  %36 = load ptr, ptr %8, align 8
  call void @free(ptr noundef %36) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %10

10:                                               ; preds = %65, %3
  %11 = load i32, ptr %7, align 4
  %12 = load i32, ptr %4, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %68

14:                                               ; preds = %10
  store i32 0, ptr %8, align 4
  br label %15

15:                                               ; preds = %61, %14
  %16 = load i32, ptr %8, align 4
  %17 = load i32, ptr %4, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %64

19:                                               ; preds = %15
  store i32 0, ptr %9, align 4
  br label %20

20:                                               ; preds = %57, %19
  %21 = load i32, ptr %9, align 4
  %22 = load i32, ptr %4, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %60

24:                                               ; preds = %20
  %25 = load i32, ptr %7, align 4
  %26 = load i32, ptr %8, align 4
  %27 = add nsw i32 %25, %26
  %28 = load i32, ptr %4, align 4
  %29 = load i32, ptr %9, align 4
  %30 = sub nsw i32 %28, %29
  %31 = add nsw i32 %27, %30
  %32 = sitofp i32 %31 to double
  %33 = fmul double %32, 1.000000e+01
  %34 = load i32, ptr %4, align 4
  %35 = sitofp i32 %34 to double
  %36 = fdiv double %33, %35
  %37 = load ptr, ptr %6, align 8
  %38 = load i32, ptr %7, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [120 x [120 x double]], ptr %37, i64 %39
  %41 = load i32, ptr %8, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [120 x [120 x double]], ptr %40, i64 0, i64 %42
  %44 = load i32, ptr %9, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [120 x double], ptr %43, i64 0, i64 %45
  store double %36, ptr %46, align 8
  %47 = load ptr, ptr %5, align 8
  %48 = load i32, ptr %7, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [120 x [120 x double]], ptr %47, i64 %49
  %51 = load i32, ptr %8, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [120 x [120 x double]], ptr %50, i64 0, i64 %52
  %54 = load i32, ptr %9, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [120 x double], ptr %53, i64 0, i64 %55
  store double %36, ptr %56, align 8
  br label %57

57:                                               ; preds = %24
  %58 = load i32, ptr %9, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %9, align 4
  br label %20, !llvm.loop !6

60:                                               ; preds = %20
  br label %61

61:                                               ; preds = %60
  %62 = load i32, ptr %8, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %8, align 4
  br label %15, !llvm.loop !8

64:                                               ; preds = %15
  br label %65

65:                                               ; preds = %64
  %66 = load i32, ptr %7, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %7, align 4
  br label %10, !llvm.loop !9

68:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_heat_3d(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store ptr %2, ptr %7, align 8
  store ptr %3, ptr %8, align 8
  store i32 1, ptr %9, align 4
  br label %13

13:                                               ; preds = %349, %4
  %14 = load i32, ptr %9, align 4
  %15 = icmp sle i32 %14, 500
  br i1 %15, label %16, label %352

16:                                               ; preds = %13
  store i32 1, ptr %10, align 4
  br label %17

17:                                               ; preds = %179, %16
  %18 = load i32, ptr %10, align 4
  %19 = load i32, ptr %6, align 4
  %20 = sub nsw i32 %19, 1
  %21 = icmp slt i32 %18, %20
  br i1 %21, label %22, label %182

22:                                               ; preds = %17
  store i32 1, ptr %11, align 4
  br label %23

23:                                               ; preds = %175, %22
  %24 = load i32, ptr %11, align 4
  %25 = load i32, ptr %6, align 4
  %26 = sub nsw i32 %25, 1
  %27 = icmp slt i32 %24, %26
  br i1 %27, label %28, label %178

28:                                               ; preds = %23
  store i32 1, ptr %12, align 4
  br label %29

29:                                               ; preds = %171, %28
  %30 = load i32, ptr %12, align 4
  %31 = load i32, ptr %6, align 4
  %32 = sub nsw i32 %31, 1
  %33 = icmp slt i32 %30, %32
  br i1 %33, label %34, label %174

34:                                               ; preds = %29
  %35 = load ptr, ptr %7, align 8
  %36 = load i32, ptr %10, align 4
  %37 = add nsw i32 %36, 1
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [120 x [120 x double]], ptr %35, i64 %38
  %40 = load i32, ptr %11, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [120 x [120 x double]], ptr %39, i64 0, i64 %41
  %43 = load i32, ptr %12, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [120 x double], ptr %42, i64 0, i64 %44
  %46 = load double, ptr %45, align 8
  %47 = load ptr, ptr %7, align 8
  %48 = load i32, ptr %10, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [120 x [120 x double]], ptr %47, i64 %49
  %51 = load i32, ptr %11, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [120 x [120 x double]], ptr %50, i64 0, i64 %52
  %54 = load i32, ptr %12, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [120 x double], ptr %53, i64 0, i64 %55
  %57 = load double, ptr %56, align 8
  %58 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %57, double %46)
  %59 = load ptr, ptr %7, align 8
  %60 = load i32, ptr %10, align 4
  %61 = sub nsw i32 %60, 1
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [120 x [120 x double]], ptr %59, i64 %62
  %64 = load i32, ptr %11, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [120 x [120 x double]], ptr %63, i64 0, i64 %65
  %67 = load i32, ptr %12, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [120 x double], ptr %66, i64 0, i64 %68
  %70 = load double, ptr %69, align 8
  %71 = fadd double %58, %70
  %72 = load ptr, ptr %7, align 8
  %73 = load i32, ptr %10, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [120 x [120 x double]], ptr %72, i64 %74
  %76 = load i32, ptr %11, align 4
  %77 = add nsw i32 %76, 1
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [120 x [120 x double]], ptr %75, i64 0, i64 %78
  %80 = load i32, ptr %12, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [120 x double], ptr %79, i64 0, i64 %81
  %83 = load double, ptr %82, align 8
  %84 = load ptr, ptr %7, align 8
  %85 = load i32, ptr %10, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [120 x [120 x double]], ptr %84, i64 %86
  %88 = load i32, ptr %11, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [120 x [120 x double]], ptr %87, i64 0, i64 %89
  %91 = load i32, ptr %12, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [120 x double], ptr %90, i64 0, i64 %92
  %94 = load double, ptr %93, align 8
  %95 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %94, double %83)
  %96 = load ptr, ptr %7, align 8
  %97 = load i32, ptr %10, align 4
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [120 x [120 x double]], ptr %96, i64 %98
  %100 = load i32, ptr %11, align 4
  %101 = sub nsw i32 %100, 1
  %102 = sext i32 %101 to i64
  %103 = getelementptr inbounds [120 x [120 x double]], ptr %99, i64 0, i64 %102
  %104 = load i32, ptr %12, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [120 x double], ptr %103, i64 0, i64 %105
  %107 = load double, ptr %106, align 8
  %108 = fadd double %95, %107
  %109 = fmul double 1.250000e-01, %108
  %110 = call double @llvm.fmuladd.f64(double 1.250000e-01, double %71, double %109)
  %111 = load ptr, ptr %7, align 8
  %112 = load i32, ptr %10, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [120 x [120 x double]], ptr %111, i64 %113
  %115 = load i32, ptr %11, align 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds [120 x [120 x double]], ptr %114, i64 0, i64 %116
  %118 = load i32, ptr %12, align 4
  %119 = add nsw i32 %118, 1
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [120 x double], ptr %117, i64 0, i64 %120
  %122 = load double, ptr %121, align 8
  %123 = load ptr, ptr %7, align 8
  %124 = load i32, ptr %10, align 4
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds [120 x [120 x double]], ptr %123, i64 %125
  %127 = load i32, ptr %11, align 4
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds [120 x [120 x double]], ptr %126, i64 0, i64 %128
  %130 = load i32, ptr %12, align 4
  %131 = sext i32 %130 to i64
  %132 = getelementptr inbounds [120 x double], ptr %129, i64 0, i64 %131
  %133 = load double, ptr %132, align 8
  %134 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %133, double %122)
  %135 = load ptr, ptr %7, align 8
  %136 = load i32, ptr %10, align 4
  %137 = sext i32 %136 to i64
  %138 = getelementptr inbounds [120 x [120 x double]], ptr %135, i64 %137
  %139 = load i32, ptr %11, align 4
  %140 = sext i32 %139 to i64
  %141 = getelementptr inbounds [120 x [120 x double]], ptr %138, i64 0, i64 %140
  %142 = load i32, ptr %12, align 4
  %143 = sub nsw i32 %142, 1
  %144 = sext i32 %143 to i64
  %145 = getelementptr inbounds [120 x double], ptr %141, i64 0, i64 %144
  %146 = load double, ptr %145, align 8
  %147 = fadd double %134, %146
  %148 = call double @llvm.fmuladd.f64(double 1.250000e-01, double %147, double %110)
  %149 = load ptr, ptr %7, align 8
  %150 = load i32, ptr %10, align 4
  %151 = sext i32 %150 to i64
  %152 = getelementptr inbounds [120 x [120 x double]], ptr %149, i64 %151
  %153 = load i32, ptr %11, align 4
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds [120 x [120 x double]], ptr %152, i64 0, i64 %154
  %156 = load i32, ptr %12, align 4
  %157 = sext i32 %156 to i64
  %158 = getelementptr inbounds [120 x double], ptr %155, i64 0, i64 %157
  %159 = load double, ptr %158, align 8
  %160 = fadd double %148, %159
  %161 = load ptr, ptr %8, align 8
  %162 = load i32, ptr %10, align 4
  %163 = sext i32 %162 to i64
  %164 = getelementptr inbounds [120 x [120 x double]], ptr %161, i64 %163
  %165 = load i32, ptr %11, align 4
  %166 = sext i32 %165 to i64
  %167 = getelementptr inbounds [120 x [120 x double]], ptr %164, i64 0, i64 %166
  %168 = load i32, ptr %12, align 4
  %169 = sext i32 %168 to i64
  %170 = getelementptr inbounds [120 x double], ptr %167, i64 0, i64 %169
  store double %160, ptr %170, align 8
  br label %171

171:                                              ; preds = %34
  %172 = load i32, ptr %12, align 4
  %173 = add nsw i32 %172, 1
  store i32 %173, ptr %12, align 4
  br label %29, !llvm.loop !10

174:                                              ; preds = %29
  br label %175

175:                                              ; preds = %174
  %176 = load i32, ptr %11, align 4
  %177 = add nsw i32 %176, 1
  store i32 %177, ptr %11, align 4
  br label %23, !llvm.loop !11

178:                                              ; preds = %23
  br label %179

179:                                              ; preds = %178
  %180 = load i32, ptr %10, align 4
  %181 = add nsw i32 %180, 1
  store i32 %181, ptr %10, align 4
  br label %17, !llvm.loop !12

182:                                              ; preds = %17
  store i32 1, ptr %10, align 4
  br label %183

183:                                              ; preds = %345, %182
  %184 = load i32, ptr %10, align 4
  %185 = load i32, ptr %6, align 4
  %186 = sub nsw i32 %185, 1
  %187 = icmp slt i32 %184, %186
  br i1 %187, label %188, label %348

188:                                              ; preds = %183
  store i32 1, ptr %11, align 4
  br label %189

189:                                              ; preds = %341, %188
  %190 = load i32, ptr %11, align 4
  %191 = load i32, ptr %6, align 4
  %192 = sub nsw i32 %191, 1
  %193 = icmp slt i32 %190, %192
  br i1 %193, label %194, label %344

194:                                              ; preds = %189
  store i32 1, ptr %12, align 4
  br label %195

195:                                              ; preds = %337, %194
  %196 = load i32, ptr %12, align 4
  %197 = load i32, ptr %6, align 4
  %198 = sub nsw i32 %197, 1
  %199 = icmp slt i32 %196, %198
  br i1 %199, label %200, label %340

200:                                              ; preds = %195
  %201 = load ptr, ptr %8, align 8
  %202 = load i32, ptr %10, align 4
  %203 = add nsw i32 %202, 1
  %204 = sext i32 %203 to i64
  %205 = getelementptr inbounds [120 x [120 x double]], ptr %201, i64 %204
  %206 = load i32, ptr %11, align 4
  %207 = sext i32 %206 to i64
  %208 = getelementptr inbounds [120 x [120 x double]], ptr %205, i64 0, i64 %207
  %209 = load i32, ptr %12, align 4
  %210 = sext i32 %209 to i64
  %211 = getelementptr inbounds [120 x double], ptr %208, i64 0, i64 %210
  %212 = load double, ptr %211, align 8
  %213 = load ptr, ptr %8, align 8
  %214 = load i32, ptr %10, align 4
  %215 = sext i32 %214 to i64
  %216 = getelementptr inbounds [120 x [120 x double]], ptr %213, i64 %215
  %217 = load i32, ptr %11, align 4
  %218 = sext i32 %217 to i64
  %219 = getelementptr inbounds [120 x [120 x double]], ptr %216, i64 0, i64 %218
  %220 = load i32, ptr %12, align 4
  %221 = sext i32 %220 to i64
  %222 = getelementptr inbounds [120 x double], ptr %219, i64 0, i64 %221
  %223 = load double, ptr %222, align 8
  %224 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %223, double %212)
  %225 = load ptr, ptr %8, align 8
  %226 = load i32, ptr %10, align 4
  %227 = sub nsw i32 %226, 1
  %228 = sext i32 %227 to i64
  %229 = getelementptr inbounds [120 x [120 x double]], ptr %225, i64 %228
  %230 = load i32, ptr %11, align 4
  %231 = sext i32 %230 to i64
  %232 = getelementptr inbounds [120 x [120 x double]], ptr %229, i64 0, i64 %231
  %233 = load i32, ptr %12, align 4
  %234 = sext i32 %233 to i64
  %235 = getelementptr inbounds [120 x double], ptr %232, i64 0, i64 %234
  %236 = load double, ptr %235, align 8
  %237 = fadd double %224, %236
  %238 = load ptr, ptr %8, align 8
  %239 = load i32, ptr %10, align 4
  %240 = sext i32 %239 to i64
  %241 = getelementptr inbounds [120 x [120 x double]], ptr %238, i64 %240
  %242 = load i32, ptr %11, align 4
  %243 = add nsw i32 %242, 1
  %244 = sext i32 %243 to i64
  %245 = getelementptr inbounds [120 x [120 x double]], ptr %241, i64 0, i64 %244
  %246 = load i32, ptr %12, align 4
  %247 = sext i32 %246 to i64
  %248 = getelementptr inbounds [120 x double], ptr %245, i64 0, i64 %247
  %249 = load double, ptr %248, align 8
  %250 = load ptr, ptr %8, align 8
  %251 = load i32, ptr %10, align 4
  %252 = sext i32 %251 to i64
  %253 = getelementptr inbounds [120 x [120 x double]], ptr %250, i64 %252
  %254 = load i32, ptr %11, align 4
  %255 = sext i32 %254 to i64
  %256 = getelementptr inbounds [120 x [120 x double]], ptr %253, i64 0, i64 %255
  %257 = load i32, ptr %12, align 4
  %258 = sext i32 %257 to i64
  %259 = getelementptr inbounds [120 x double], ptr %256, i64 0, i64 %258
  %260 = load double, ptr %259, align 8
  %261 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %260, double %249)
  %262 = load ptr, ptr %8, align 8
  %263 = load i32, ptr %10, align 4
  %264 = sext i32 %263 to i64
  %265 = getelementptr inbounds [120 x [120 x double]], ptr %262, i64 %264
  %266 = load i32, ptr %11, align 4
  %267 = sub nsw i32 %266, 1
  %268 = sext i32 %267 to i64
  %269 = getelementptr inbounds [120 x [120 x double]], ptr %265, i64 0, i64 %268
  %270 = load i32, ptr %12, align 4
  %271 = sext i32 %270 to i64
  %272 = getelementptr inbounds [120 x double], ptr %269, i64 0, i64 %271
  %273 = load double, ptr %272, align 8
  %274 = fadd double %261, %273
  %275 = fmul double 1.250000e-01, %274
  %276 = call double @llvm.fmuladd.f64(double 1.250000e-01, double %237, double %275)
  %277 = load ptr, ptr %8, align 8
  %278 = load i32, ptr %10, align 4
  %279 = sext i32 %278 to i64
  %280 = getelementptr inbounds [120 x [120 x double]], ptr %277, i64 %279
  %281 = load i32, ptr %11, align 4
  %282 = sext i32 %281 to i64
  %283 = getelementptr inbounds [120 x [120 x double]], ptr %280, i64 0, i64 %282
  %284 = load i32, ptr %12, align 4
  %285 = add nsw i32 %284, 1
  %286 = sext i32 %285 to i64
  %287 = getelementptr inbounds [120 x double], ptr %283, i64 0, i64 %286
  %288 = load double, ptr %287, align 8
  %289 = load ptr, ptr %8, align 8
  %290 = load i32, ptr %10, align 4
  %291 = sext i32 %290 to i64
  %292 = getelementptr inbounds [120 x [120 x double]], ptr %289, i64 %291
  %293 = load i32, ptr %11, align 4
  %294 = sext i32 %293 to i64
  %295 = getelementptr inbounds [120 x [120 x double]], ptr %292, i64 0, i64 %294
  %296 = load i32, ptr %12, align 4
  %297 = sext i32 %296 to i64
  %298 = getelementptr inbounds [120 x double], ptr %295, i64 0, i64 %297
  %299 = load double, ptr %298, align 8
  %300 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %299, double %288)
  %301 = load ptr, ptr %8, align 8
  %302 = load i32, ptr %10, align 4
  %303 = sext i32 %302 to i64
  %304 = getelementptr inbounds [120 x [120 x double]], ptr %301, i64 %303
  %305 = load i32, ptr %11, align 4
  %306 = sext i32 %305 to i64
  %307 = getelementptr inbounds [120 x [120 x double]], ptr %304, i64 0, i64 %306
  %308 = load i32, ptr %12, align 4
  %309 = sub nsw i32 %308, 1
  %310 = sext i32 %309 to i64
  %311 = getelementptr inbounds [120 x double], ptr %307, i64 0, i64 %310
  %312 = load double, ptr %311, align 8
  %313 = fadd double %300, %312
  %314 = call double @llvm.fmuladd.f64(double 1.250000e-01, double %313, double %276)
  %315 = load ptr, ptr %8, align 8
  %316 = load i32, ptr %10, align 4
  %317 = sext i32 %316 to i64
  %318 = getelementptr inbounds [120 x [120 x double]], ptr %315, i64 %317
  %319 = load i32, ptr %11, align 4
  %320 = sext i32 %319 to i64
  %321 = getelementptr inbounds [120 x [120 x double]], ptr %318, i64 0, i64 %320
  %322 = load i32, ptr %12, align 4
  %323 = sext i32 %322 to i64
  %324 = getelementptr inbounds [120 x double], ptr %321, i64 0, i64 %323
  %325 = load double, ptr %324, align 8
  %326 = fadd double %314, %325
  %327 = load ptr, ptr %7, align 8
  %328 = load i32, ptr %10, align 4
  %329 = sext i32 %328 to i64
  %330 = getelementptr inbounds [120 x [120 x double]], ptr %327, i64 %329
  %331 = load i32, ptr %11, align 4
  %332 = sext i32 %331 to i64
  %333 = getelementptr inbounds [120 x [120 x double]], ptr %330, i64 0, i64 %332
  %334 = load i32, ptr %12, align 4
  %335 = sext i32 %334 to i64
  %336 = getelementptr inbounds [120 x double], ptr %333, i64 0, i64 %335
  store double %326, ptr %336, align 8
  br label %337

337:                                              ; preds = %200
  %338 = load i32, ptr %12, align 4
  %339 = add nsw i32 %338, 1
  store i32 %339, ptr %12, align 4
  br label %195, !llvm.loop !13

340:                                              ; preds = %195
  br label %341

341:                                              ; preds = %340
  %342 = load i32, ptr %11, align 4
  %343 = add nsw i32 %342, 1
  store i32 %343, ptr %11, align 4
  br label %189, !llvm.loop !14

344:                                              ; preds = %189
  br label %345

345:                                              ; preds = %344
  %346 = load i32, ptr %10, align 4
  %347 = add nsw i32 %346, 1
  store i32 %347, ptr %10, align 4
  br label %183, !llvm.loop !15

348:                                              ; preds = %183
  br label %349

349:                                              ; preds = %348
  %350 = load i32, ptr %9, align 4
  %351 = add nsw i32 %350, 1
  store i32 %351, ptr %9, align 4
  br label %13, !llvm.loop !16

352:                                              ; preds = %13
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
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  %8 = load ptr, ptr @stderr, align 8
  %9 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %8, ptr noundef @.str.1)
  %10 = load ptr, ptr @stderr, align 8
  %11 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %10, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %5, align 4
  br label %12

12:                                               ; preds = %65, %2
  %13 = load i32, ptr %5, align 4
  %14 = load i32, ptr %3, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %68

16:                                               ; preds = %12
  store i32 0, ptr %6, align 4
  br label %17

17:                                               ; preds = %61, %16
  %18 = load i32, ptr %6, align 4
  %19 = load i32, ptr %3, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %64

21:                                               ; preds = %17
  store i32 0, ptr %7, align 4
  br label %22

22:                                               ; preds = %57, %21
  %23 = load i32, ptr %7, align 4
  %24 = load i32, ptr %3, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %26, label %60

26:                                               ; preds = %22
  %27 = load i32, ptr %5, align 4
  %28 = load i32, ptr %3, align 4
  %29 = mul nsw i32 %27, %28
  %30 = load i32, ptr %3, align 4
  %31 = mul nsw i32 %29, %30
  %32 = load i32, ptr %6, align 4
  %33 = load i32, ptr %3, align 4
  %34 = mul nsw i32 %32, %33
  %35 = add nsw i32 %31, %34
  %36 = load i32, ptr %7, align 4
  %37 = add nsw i32 %35, %36
  %38 = srem i32 %37, 20
  %39 = icmp eq i32 %38, 0
  br i1 %39, label %40, label %43

40:                                               ; preds = %26
  %41 = load ptr, ptr @stderr, align 8
  %42 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %41, ptr noundef @.str.4)
  br label %43

43:                                               ; preds = %40, %26
  %44 = load ptr, ptr @stderr, align 8
  %45 = load ptr, ptr %4, align 8
  %46 = load i32, ptr %5, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [120 x [120 x double]], ptr %45, i64 %47
  %49 = load i32, ptr %6, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [120 x [120 x double]], ptr %48, i64 0, i64 %50
  %52 = load i32, ptr %7, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [120 x double], ptr %51, i64 0, i64 %53
  %55 = load double, ptr %54, align 8
  %56 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %44, ptr noundef @.str.5, double noundef %55)
  br label %57

57:                                               ; preds = %43
  %58 = load i32, ptr %7, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %7, align 4
  br label %22, !llvm.loop !17

60:                                               ; preds = %22
  br label %61

61:                                               ; preds = %60
  %62 = load i32, ptr %6, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %6, align 4
  br label %17, !llvm.loop !18

64:                                               ; preds = %17
  br label %65

65:                                               ; preds = %64
  %66 = load i32, ptr %5, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %5, align 4
  br label %12, !llvm.loop !19

68:                                               ; preds = %12
  %69 = load ptr, ptr @stderr, align 8
  %70 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %69, ptr noundef @.str.6, ptr noundef @.str.3)
  %71 = load ptr, ptr @stderr, align 8
  %72 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %71, ptr noundef @.str.7)
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
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
