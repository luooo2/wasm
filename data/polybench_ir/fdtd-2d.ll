; ModuleID = '/code/data/webassembly-polybench-c-master/stencils/fdtd-2d/fdtd-2d.c'
source_filename = "/code/data/webassembly-polybench-c-master/stencils/fdtd-2d/fdtd-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"ex\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1
@.str.8 = private unnamed_addr constant [3 x i8] c"ey\00", align 1
@.str.9 = private unnamed_addr constant [3 x i8] c"hz\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 500, ptr %6, align 4
  store i32 1000, ptr %7, align 4
  store i32 1200, ptr %8, align 4
  %13 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %13, ptr %9, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %14, ptr %10, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %15, ptr %11, align 8
  %16 = call ptr @polybench_alloc_data(i64 noundef 500, i32 noundef 8)
  store ptr %16, ptr %12, align 8
  %17 = load i32, ptr %6, align 4
  %18 = load i32, ptr %7, align 4
  %19 = load i32, ptr %8, align 4
  %20 = load ptr, ptr %9, align 8
  %21 = getelementptr inbounds [1000 x [1200 x double]], ptr %20, i64 0, i64 0
  %22 = load ptr, ptr %10, align 8
  %23 = getelementptr inbounds [1000 x [1200 x double]], ptr %22, i64 0, i64 0
  %24 = load ptr, ptr %11, align 8
  %25 = getelementptr inbounds [1000 x [1200 x double]], ptr %24, i64 0, i64 0
  %26 = load ptr, ptr %12, align 8
  %27 = getelementptr inbounds [500 x double], ptr %26, i64 0, i64 0
  call void @init_array(i32 noundef %17, i32 noundef %18, i32 noundef %19, ptr noundef %21, ptr noundef %23, ptr noundef %25, ptr noundef %27)
  %28 = load i32, ptr %6, align 4
  %29 = load i32, ptr %7, align 4
  %30 = load i32, ptr %8, align 4
  %31 = load ptr, ptr %9, align 8
  %32 = getelementptr inbounds [1000 x [1200 x double]], ptr %31, i64 0, i64 0
  %33 = load ptr, ptr %10, align 8
  %34 = getelementptr inbounds [1000 x [1200 x double]], ptr %33, i64 0, i64 0
  %35 = load ptr, ptr %11, align 8
  %36 = getelementptr inbounds [1000 x [1200 x double]], ptr %35, i64 0, i64 0
  %37 = load ptr, ptr %12, align 8
  %38 = getelementptr inbounds [500 x double], ptr %37, i64 0, i64 0
  call void @kernel_fdtd_2d(i32 noundef %28, i32 noundef %29, i32 noundef %30, ptr noundef %32, ptr noundef %34, ptr noundef %36, ptr noundef %38)
  %39 = load i32, ptr %4, align 4
  %40 = icmp sgt i32 %39, 42
  br i1 %40, label %41, label %56

41:                                               ; preds = %2
  %42 = load ptr, ptr %5, align 8
  %43 = getelementptr inbounds ptr, ptr %42, i64 0
  %44 = load ptr, ptr %43, align 8
  %45 = call i32 @strcmp(ptr noundef %44, ptr noundef @.str) #5
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %56, label %47

47:                                               ; preds = %41
  %48 = load i32, ptr %7, align 4
  %49 = load i32, ptr %8, align 4
  %50 = load ptr, ptr %9, align 8
  %51 = getelementptr inbounds [1000 x [1200 x double]], ptr %50, i64 0, i64 0
  %52 = load ptr, ptr %10, align 8
  %53 = getelementptr inbounds [1000 x [1200 x double]], ptr %52, i64 0, i64 0
  %54 = load ptr, ptr %11, align 8
  %55 = getelementptr inbounds [1000 x [1200 x double]], ptr %54, i64 0, i64 0
  call void @print_array(i32 noundef %48, i32 noundef %49, ptr noundef %51, ptr noundef %53, ptr noundef %55)
  br label %56

56:                                               ; preds = %47, %41, %2
  %57 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %57) #6
  %58 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %58) #6
  %59 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %59) #6
  %60 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %60) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store ptr %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store ptr %5, ptr %13, align 8
  store ptr %6, ptr %14, align 8
  store i32 0, ptr %15, align 4
  br label %17

17:                                               ; preds = %28, %7
  %18 = load i32, ptr %15, align 4
  %19 = load i32, ptr %8, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %31

21:                                               ; preds = %17
  %22 = load i32, ptr %15, align 4
  %23 = sitofp i32 %22 to double
  %24 = load ptr, ptr %14, align 8
  %25 = load i32, ptr %15, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds double, ptr %24, i64 %26
  store double %23, ptr %27, align 8
  br label %28

28:                                               ; preds = %21
  %29 = load i32, ptr %15, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %15, align 4
  br label %17, !llvm.loop !6

31:                                               ; preds = %17
  store i32 0, ptr %15, align 4
  br label %32

32:                                               ; preds = %94, %31
  %33 = load i32, ptr %15, align 4
  %34 = load i32, ptr %9, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %97

36:                                               ; preds = %32
  store i32 0, ptr %16, align 4
  br label %37

37:                                               ; preds = %90, %36
  %38 = load i32, ptr %16, align 4
  %39 = load i32, ptr %10, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %41, label %93

41:                                               ; preds = %37
  %42 = load i32, ptr %15, align 4
  %43 = sitofp i32 %42 to double
  %44 = load i32, ptr %16, align 4
  %45 = add nsw i32 %44, 1
  %46 = sitofp i32 %45 to double
  %47 = fmul double %43, %46
  %48 = load i32, ptr %9, align 4
  %49 = sitofp i32 %48 to double
  %50 = fdiv double %47, %49
  %51 = load ptr, ptr %11, align 8
  %52 = load i32, ptr %15, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [1200 x double], ptr %51, i64 %53
  %55 = load i32, ptr %16, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [1200 x double], ptr %54, i64 0, i64 %56
  store double %50, ptr %57, align 8
  %58 = load i32, ptr %15, align 4
  %59 = sitofp i32 %58 to double
  %60 = load i32, ptr %16, align 4
  %61 = add nsw i32 %60, 2
  %62 = sitofp i32 %61 to double
  %63 = fmul double %59, %62
  %64 = load i32, ptr %10, align 4
  %65 = sitofp i32 %64 to double
  %66 = fdiv double %63, %65
  %67 = load ptr, ptr %12, align 8
  %68 = load i32, ptr %15, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds [1200 x double], ptr %67, i64 %69
  %71 = load i32, ptr %16, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds [1200 x double], ptr %70, i64 0, i64 %72
  store double %66, ptr %73, align 8
  %74 = load i32, ptr %15, align 4
  %75 = sitofp i32 %74 to double
  %76 = load i32, ptr %16, align 4
  %77 = add nsw i32 %76, 3
  %78 = sitofp i32 %77 to double
  %79 = fmul double %75, %78
  %80 = load i32, ptr %9, align 4
  %81 = sitofp i32 %80 to double
  %82 = fdiv double %79, %81
  %83 = load ptr, ptr %13, align 8
  %84 = load i32, ptr %15, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds [1200 x double], ptr %83, i64 %85
  %87 = load i32, ptr %16, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds [1200 x double], ptr %86, i64 0, i64 %88
  store double %82, ptr %89, align 8
  br label %90

90:                                               ; preds = %41
  %91 = load i32, ptr %16, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, ptr %16, align 4
  br label %37, !llvm.loop !8

93:                                               ; preds = %37
  br label %94

94:                                               ; preds = %93
  %95 = load i32, ptr %15, align 4
  %96 = add nsw i32 %95, 1
  store i32 %96, ptr %15, align 4
  br label %32, !llvm.loop !9

97:                                               ; preds = %32
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_fdtd_2d(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store ptr %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store ptr %5, ptr %13, align 8
  store ptr %6, ptr %14, align 8
  store i32 0, ptr %15, align 4
  br label %18

18:                                               ; preds = %219, %7
  %19 = load i32, ptr %15, align 4
  %20 = load i32, ptr %8, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %222

22:                                               ; preds = %18
  store i32 0, ptr %17, align 4
  br label %23

23:                                               ; preds = %38, %22
  %24 = load i32, ptr %17, align 4
  %25 = load i32, ptr %10, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %41

27:                                               ; preds = %23
  %28 = load ptr, ptr %14, align 8
  %29 = load i32, ptr %15, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds double, ptr %28, i64 %30
  %32 = load double, ptr %31, align 8
  %33 = load ptr, ptr %12, align 8
  %34 = getelementptr inbounds [1200 x double], ptr %33, i64 0
  %35 = load i32, ptr %17, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [1200 x double], ptr %34, i64 0, i64 %36
  store double %32, ptr %37, align 8
  br label %38

38:                                               ; preds = %27
  %39 = load i32, ptr %17, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %17, align 4
  br label %23, !llvm.loop !10

41:                                               ; preds = %23
  store i32 1, ptr %16, align 4
  br label %42

42:                                               ; preds = %90, %41
  %43 = load i32, ptr %16, align 4
  %44 = load i32, ptr %9, align 4
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %93

46:                                               ; preds = %42
  store i32 0, ptr %17, align 4
  br label %47

47:                                               ; preds = %86, %46
  %48 = load i32, ptr %17, align 4
  %49 = load i32, ptr %10, align 4
  %50 = icmp slt i32 %48, %49
  br i1 %50, label %51, label %89

51:                                               ; preds = %47
  %52 = load ptr, ptr %12, align 8
  %53 = load i32, ptr %16, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [1200 x double], ptr %52, i64 %54
  %56 = load i32, ptr %17, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [1200 x double], ptr %55, i64 0, i64 %57
  %59 = load double, ptr %58, align 8
  %60 = load ptr, ptr %13, align 8
  %61 = load i32, ptr %16, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [1200 x double], ptr %60, i64 %62
  %64 = load i32, ptr %17, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [1200 x double], ptr %63, i64 0, i64 %65
  %67 = load double, ptr %66, align 8
  %68 = load ptr, ptr %13, align 8
  %69 = load i32, ptr %16, align 4
  %70 = sub nsw i32 %69, 1
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [1200 x double], ptr %68, i64 %71
  %73 = load i32, ptr %17, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [1200 x double], ptr %72, i64 0, i64 %74
  %76 = load double, ptr %75, align 8
  %77 = fsub double %67, %76
  %78 = call double @llvm.fmuladd.f64(double -5.000000e-01, double %77, double %59)
  %79 = load ptr, ptr %12, align 8
  %80 = load i32, ptr %16, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [1200 x double], ptr %79, i64 %81
  %83 = load i32, ptr %17, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds [1200 x double], ptr %82, i64 0, i64 %84
  store double %78, ptr %85, align 8
  br label %86

86:                                               ; preds = %51
  %87 = load i32, ptr %17, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %17, align 4
  br label %47, !llvm.loop !11

89:                                               ; preds = %47
  br label %90

90:                                               ; preds = %89
  %91 = load i32, ptr %16, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, ptr %16, align 4
  br label %42, !llvm.loop !12

93:                                               ; preds = %42
  store i32 0, ptr %16, align 4
  br label %94

94:                                               ; preds = %142, %93
  %95 = load i32, ptr %16, align 4
  %96 = load i32, ptr %9, align 4
  %97 = icmp slt i32 %95, %96
  br i1 %97, label %98, label %145

98:                                               ; preds = %94
  store i32 1, ptr %17, align 4
  br label %99

99:                                               ; preds = %138, %98
  %100 = load i32, ptr %17, align 4
  %101 = load i32, ptr %10, align 4
  %102 = icmp slt i32 %100, %101
  br i1 %102, label %103, label %141

103:                                              ; preds = %99
  %104 = load ptr, ptr %11, align 8
  %105 = load i32, ptr %16, align 4
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds [1200 x double], ptr %104, i64 %106
  %108 = load i32, ptr %17, align 4
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds [1200 x double], ptr %107, i64 0, i64 %109
  %111 = load double, ptr %110, align 8
  %112 = load ptr, ptr %13, align 8
  %113 = load i32, ptr %16, align 4
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds [1200 x double], ptr %112, i64 %114
  %116 = load i32, ptr %17, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds [1200 x double], ptr %115, i64 0, i64 %117
  %119 = load double, ptr %118, align 8
  %120 = load ptr, ptr %13, align 8
  %121 = load i32, ptr %16, align 4
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds [1200 x double], ptr %120, i64 %122
  %124 = load i32, ptr %17, align 4
  %125 = sub nsw i32 %124, 1
  %126 = sext i32 %125 to i64
  %127 = getelementptr inbounds [1200 x double], ptr %123, i64 0, i64 %126
  %128 = load double, ptr %127, align 8
  %129 = fsub double %119, %128
  %130 = call double @llvm.fmuladd.f64(double -5.000000e-01, double %129, double %111)
  %131 = load ptr, ptr %11, align 8
  %132 = load i32, ptr %16, align 4
  %133 = sext i32 %132 to i64
  %134 = getelementptr inbounds [1200 x double], ptr %131, i64 %133
  %135 = load i32, ptr %17, align 4
  %136 = sext i32 %135 to i64
  %137 = getelementptr inbounds [1200 x double], ptr %134, i64 0, i64 %136
  store double %130, ptr %137, align 8
  br label %138

138:                                              ; preds = %103
  %139 = load i32, ptr %17, align 4
  %140 = add nsw i32 %139, 1
  store i32 %140, ptr %17, align 4
  br label %99, !llvm.loop !13

141:                                              ; preds = %99
  br label %142

142:                                              ; preds = %141
  %143 = load i32, ptr %16, align 4
  %144 = add nsw i32 %143, 1
  store i32 %144, ptr %16, align 4
  br label %94, !llvm.loop !14

145:                                              ; preds = %94
  store i32 0, ptr %16, align 4
  br label %146

146:                                              ; preds = %215, %145
  %147 = load i32, ptr %16, align 4
  %148 = load i32, ptr %9, align 4
  %149 = sub nsw i32 %148, 1
  %150 = icmp slt i32 %147, %149
  br i1 %150, label %151, label %218

151:                                              ; preds = %146
  store i32 0, ptr %17, align 4
  br label %152

152:                                              ; preds = %211, %151
  %153 = load i32, ptr %17, align 4
  %154 = load i32, ptr %10, align 4
  %155 = sub nsw i32 %154, 1
  %156 = icmp slt i32 %153, %155
  br i1 %156, label %157, label %214

157:                                              ; preds = %152
  %158 = load ptr, ptr %13, align 8
  %159 = load i32, ptr %16, align 4
  %160 = sext i32 %159 to i64
  %161 = getelementptr inbounds [1200 x double], ptr %158, i64 %160
  %162 = load i32, ptr %17, align 4
  %163 = sext i32 %162 to i64
  %164 = getelementptr inbounds [1200 x double], ptr %161, i64 0, i64 %163
  %165 = load double, ptr %164, align 8
  %166 = load ptr, ptr %11, align 8
  %167 = load i32, ptr %16, align 4
  %168 = sext i32 %167 to i64
  %169 = getelementptr inbounds [1200 x double], ptr %166, i64 %168
  %170 = load i32, ptr %17, align 4
  %171 = add nsw i32 %170, 1
  %172 = sext i32 %171 to i64
  %173 = getelementptr inbounds [1200 x double], ptr %169, i64 0, i64 %172
  %174 = load double, ptr %173, align 8
  %175 = load ptr, ptr %11, align 8
  %176 = load i32, ptr %16, align 4
  %177 = sext i32 %176 to i64
  %178 = getelementptr inbounds [1200 x double], ptr %175, i64 %177
  %179 = load i32, ptr %17, align 4
  %180 = sext i32 %179 to i64
  %181 = getelementptr inbounds [1200 x double], ptr %178, i64 0, i64 %180
  %182 = load double, ptr %181, align 8
  %183 = fsub double %174, %182
  %184 = load ptr, ptr %12, align 8
  %185 = load i32, ptr %16, align 4
  %186 = add nsw i32 %185, 1
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds [1200 x double], ptr %184, i64 %187
  %189 = load i32, ptr %17, align 4
  %190 = sext i32 %189 to i64
  %191 = getelementptr inbounds [1200 x double], ptr %188, i64 0, i64 %190
  %192 = load double, ptr %191, align 8
  %193 = fadd double %183, %192
  %194 = load ptr, ptr %12, align 8
  %195 = load i32, ptr %16, align 4
  %196 = sext i32 %195 to i64
  %197 = getelementptr inbounds [1200 x double], ptr %194, i64 %196
  %198 = load i32, ptr %17, align 4
  %199 = sext i32 %198 to i64
  %200 = getelementptr inbounds [1200 x double], ptr %197, i64 0, i64 %199
  %201 = load double, ptr %200, align 8
  %202 = fsub double %193, %201
  %203 = call double @llvm.fmuladd.f64(double 0xBFE6666666666666, double %202, double %165)
  %204 = load ptr, ptr %13, align 8
  %205 = load i32, ptr %16, align 4
  %206 = sext i32 %205 to i64
  %207 = getelementptr inbounds [1200 x double], ptr %204, i64 %206
  %208 = load i32, ptr %17, align 4
  %209 = sext i32 %208 to i64
  %210 = getelementptr inbounds [1200 x double], ptr %207, i64 0, i64 %209
  store double %203, ptr %210, align 8
  br label %211

211:                                              ; preds = %157
  %212 = load i32, ptr %17, align 4
  %213 = add nsw i32 %212, 1
  store i32 %213, ptr %17, align 4
  br label %152, !llvm.loop !15

214:                                              ; preds = %152
  br label %215

215:                                              ; preds = %214
  %216 = load i32, ptr %16, align 4
  %217 = add nsw i32 %216, 1
  store i32 %217, ptr %16, align 4
  br label %146, !llvm.loop !16

218:                                              ; preds = %146
  br label %219

219:                                              ; preds = %218
  %220 = load i32, ptr %15, align 4
  %221 = add nsw i32 %220, 1
  store i32 %221, ptr %15, align 4
  br label %18, !llvm.loop !17

222:                                              ; preds = %18
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4) #0 {
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
  %13 = load ptr, ptr @stderr, align 8
  %14 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %13, ptr noundef @.str.1)
  %15 = load ptr, ptr @stderr, align 8
  %16 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %15, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %11, align 4
  br label %17

17:                                               ; preds = %52, %5
  %18 = load i32, ptr %11, align 4
  %19 = load i32, ptr %6, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %55

21:                                               ; preds = %17
  store i32 0, ptr %12, align 4
  br label %22

22:                                               ; preds = %48, %21
  %23 = load i32, ptr %12, align 4
  %24 = load i32, ptr %7, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %26, label %51

26:                                               ; preds = %22
  %27 = load i32, ptr %11, align 4
  %28 = load i32, ptr %6, align 4
  %29 = mul nsw i32 %27, %28
  %30 = load i32, ptr %12, align 4
  %31 = add nsw i32 %29, %30
  %32 = srem i32 %31, 20
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %37

34:                                               ; preds = %26
  %35 = load ptr, ptr @stderr, align 8
  %36 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %35, ptr noundef @.str.4)
  br label %37

37:                                               ; preds = %34, %26
  %38 = load ptr, ptr @stderr, align 8
  %39 = load ptr, ptr %8, align 8
  %40 = load i32, ptr %11, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [1200 x double], ptr %39, i64 %41
  %43 = load i32, ptr %12, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [1200 x double], ptr %42, i64 0, i64 %44
  %46 = load double, ptr %45, align 8
  %47 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %38, ptr noundef @.str.5, double noundef %46)
  br label %48

48:                                               ; preds = %37
  %49 = load i32, ptr %12, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %12, align 4
  br label %22, !llvm.loop !18

51:                                               ; preds = %22
  br label %52

52:                                               ; preds = %51
  %53 = load i32, ptr %11, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %11, align 4
  br label %17, !llvm.loop !19

55:                                               ; preds = %17
  %56 = load ptr, ptr @stderr, align 8
  %57 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %56, ptr noundef @.str.6, ptr noundef @.str.3)
  %58 = load ptr, ptr @stderr, align 8
  %59 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %58, ptr noundef @.str.7)
  %60 = load ptr, ptr @stderr, align 8
  %61 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %60, ptr noundef @.str.2, ptr noundef @.str.8)
  store i32 0, ptr %11, align 4
  br label %62

62:                                               ; preds = %97, %55
  %63 = load i32, ptr %11, align 4
  %64 = load i32, ptr %6, align 4
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %100

66:                                               ; preds = %62
  store i32 0, ptr %12, align 4
  br label %67

67:                                               ; preds = %93, %66
  %68 = load i32, ptr %12, align 4
  %69 = load i32, ptr %7, align 4
  %70 = icmp slt i32 %68, %69
  br i1 %70, label %71, label %96

71:                                               ; preds = %67
  %72 = load i32, ptr %11, align 4
  %73 = load i32, ptr %6, align 4
  %74 = mul nsw i32 %72, %73
  %75 = load i32, ptr %12, align 4
  %76 = add nsw i32 %74, %75
  %77 = srem i32 %76, 20
  %78 = icmp eq i32 %77, 0
  br i1 %78, label %79, label %82

79:                                               ; preds = %71
  %80 = load ptr, ptr @stderr, align 8
  %81 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %80, ptr noundef @.str.4)
  br label %82

82:                                               ; preds = %79, %71
  %83 = load ptr, ptr @stderr, align 8
  %84 = load ptr, ptr %9, align 8
  %85 = load i32, ptr %11, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [1200 x double], ptr %84, i64 %86
  %88 = load i32, ptr %12, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [1200 x double], ptr %87, i64 0, i64 %89
  %91 = load double, ptr %90, align 8
  %92 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %83, ptr noundef @.str.5, double noundef %91)
  br label %93

93:                                               ; preds = %82
  %94 = load i32, ptr %12, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, ptr %12, align 4
  br label %67, !llvm.loop !20

96:                                               ; preds = %67
  br label %97

97:                                               ; preds = %96
  %98 = load i32, ptr %11, align 4
  %99 = add nsw i32 %98, 1
  store i32 %99, ptr %11, align 4
  br label %62, !llvm.loop !21

100:                                              ; preds = %62
  %101 = load ptr, ptr @stderr, align 8
  %102 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %101, ptr noundef @.str.6, ptr noundef @.str.8)
  %103 = load ptr, ptr @stderr, align 8
  %104 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %103, ptr noundef @.str.2, ptr noundef @.str.9)
  store i32 0, ptr %11, align 4
  br label %105

105:                                              ; preds = %140, %100
  %106 = load i32, ptr %11, align 4
  %107 = load i32, ptr %6, align 4
  %108 = icmp slt i32 %106, %107
  br i1 %108, label %109, label %143

109:                                              ; preds = %105
  store i32 0, ptr %12, align 4
  br label %110

110:                                              ; preds = %136, %109
  %111 = load i32, ptr %12, align 4
  %112 = load i32, ptr %7, align 4
  %113 = icmp slt i32 %111, %112
  br i1 %113, label %114, label %139

114:                                              ; preds = %110
  %115 = load i32, ptr %11, align 4
  %116 = load i32, ptr %6, align 4
  %117 = mul nsw i32 %115, %116
  %118 = load i32, ptr %12, align 4
  %119 = add nsw i32 %117, %118
  %120 = srem i32 %119, 20
  %121 = icmp eq i32 %120, 0
  br i1 %121, label %122, label %125

122:                                              ; preds = %114
  %123 = load ptr, ptr @stderr, align 8
  %124 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %123, ptr noundef @.str.4)
  br label %125

125:                                              ; preds = %122, %114
  %126 = load ptr, ptr @stderr, align 8
  %127 = load ptr, ptr %10, align 8
  %128 = load i32, ptr %11, align 4
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds [1200 x double], ptr %127, i64 %129
  %131 = load i32, ptr %12, align 4
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds [1200 x double], ptr %130, i64 0, i64 %132
  %134 = load double, ptr %133, align 8
  %135 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %126, ptr noundef @.str.5, double noundef %134)
  br label %136

136:                                              ; preds = %125
  %137 = load i32, ptr %12, align 4
  %138 = add nsw i32 %137, 1
  store i32 %138, ptr %12, align 4
  br label %110, !llvm.loop !22

139:                                              ; preds = %110
  br label %140

140:                                              ; preds = %139
  %141 = load i32, ptr %11, align 4
  %142 = add nsw i32 %141, 1
  store i32 %142, ptr %11, align 4
  br label %105, !llvm.loop !23

143:                                              ; preds = %105
  %144 = load ptr, ptr @stderr, align 8
  %145 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %144, ptr noundef @.str.6, ptr noundef @.str.9)
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
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
