; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/blas/gemver/gemver.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/blas/gemver/gemver.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"w\00", align 1
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
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 2000, ptr %6, align 4
  %18 = call ptr @polybench_alloc_data(i64 noundef 4000000, i32 noundef 8)
  store ptr %18, ptr %9, align 8
  %19 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %19, ptr %10, align 8
  %20 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %20, ptr %11, align 8
  %21 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %21, ptr %12, align 8
  %22 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %22, ptr %13, align 8
  %23 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %23, ptr %14, align 8
  %24 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %24, ptr %15, align 8
  %25 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %25, ptr %16, align 8
  %26 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %26, ptr %17, align 8
  %27 = load i32, ptr %6, align 4
  %28 = load ptr, ptr %9, align 8
  %29 = getelementptr inbounds [2000 x [2000 x double]], ptr %28, i64 0, i64 0
  %30 = load ptr, ptr %10, align 8
  %31 = getelementptr inbounds [2000 x double], ptr %30, i64 0, i64 0
  %32 = load ptr, ptr %11, align 8
  %33 = getelementptr inbounds [2000 x double], ptr %32, i64 0, i64 0
  %34 = load ptr, ptr %12, align 8
  %35 = getelementptr inbounds [2000 x double], ptr %34, i64 0, i64 0
  %36 = load ptr, ptr %13, align 8
  %37 = getelementptr inbounds [2000 x double], ptr %36, i64 0, i64 0
  %38 = load ptr, ptr %14, align 8
  %39 = getelementptr inbounds [2000 x double], ptr %38, i64 0, i64 0
  %40 = load ptr, ptr %15, align 8
  %41 = getelementptr inbounds [2000 x double], ptr %40, i64 0, i64 0
  %42 = load ptr, ptr %16, align 8
  %43 = getelementptr inbounds [2000 x double], ptr %42, i64 0, i64 0
  %44 = load ptr, ptr %17, align 8
  %45 = getelementptr inbounds [2000 x double], ptr %44, i64 0, i64 0
  call void @init_array(i32 noundef %27, ptr noundef %7, ptr noundef %8, ptr noundef %29, ptr noundef %31, ptr noundef %33, ptr noundef %35, ptr noundef %37, ptr noundef %39, ptr noundef %41, ptr noundef %43, ptr noundef %45)
  %46 = load i32, ptr %6, align 4
  %47 = load double, ptr %7, align 8
  %48 = load double, ptr %8, align 8
  %49 = load ptr, ptr %9, align 8
  %50 = getelementptr inbounds [2000 x [2000 x double]], ptr %49, i64 0, i64 0
  %51 = load ptr, ptr %10, align 8
  %52 = getelementptr inbounds [2000 x double], ptr %51, i64 0, i64 0
  %53 = load ptr, ptr %11, align 8
  %54 = getelementptr inbounds [2000 x double], ptr %53, i64 0, i64 0
  %55 = load ptr, ptr %12, align 8
  %56 = getelementptr inbounds [2000 x double], ptr %55, i64 0, i64 0
  %57 = load ptr, ptr %13, align 8
  %58 = getelementptr inbounds [2000 x double], ptr %57, i64 0, i64 0
  %59 = load ptr, ptr %14, align 8
  %60 = getelementptr inbounds [2000 x double], ptr %59, i64 0, i64 0
  %61 = load ptr, ptr %15, align 8
  %62 = getelementptr inbounds [2000 x double], ptr %61, i64 0, i64 0
  %63 = load ptr, ptr %16, align 8
  %64 = getelementptr inbounds [2000 x double], ptr %63, i64 0, i64 0
  %65 = load ptr, ptr %17, align 8
  %66 = getelementptr inbounds [2000 x double], ptr %65, i64 0, i64 0
  call void @kernel_gemver(i32 noundef %46, double noundef %47, double noundef %48, ptr noundef %50, ptr noundef %52, ptr noundef %54, ptr noundef %56, ptr noundef %58, ptr noundef %60, ptr noundef %62, ptr noundef %64, ptr noundef %66)
  %67 = load i32, ptr %4, align 4
  %68 = icmp sgt i32 %67, 42
  br i1 %68, label %69, label %79

69:                                               ; preds = %2
  %70 = load ptr, ptr %5, align 8
  %71 = getelementptr inbounds ptr, ptr %70, i64 0
  %72 = load ptr, ptr %71, align 8
  %73 = call i32 @strcmp(ptr noundef %72, ptr noundef @.str) #5
  %74 = icmp ne i32 %73, 0
  br i1 %74, label %79, label %75

75:                                               ; preds = %69
  %76 = load i32, ptr %6, align 4
  %77 = load ptr, ptr %14, align 8
  %78 = getelementptr inbounds [2000 x double], ptr %77, i64 0, i64 0
  call void @print_array(i32 noundef %76, ptr noundef %78)
  br label %79

79:                                               ; preds = %75, %69, %2
  %80 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %80) #6
  %81 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %81) #6
  %82 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %82) #6
  %83 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %83) #6
  %84 = load ptr, ptr %13, align 8
  call void @free(ptr noundef %84) #6
  %85 = load ptr, ptr %14, align 8
  call void @free(ptr noundef %85) #6
  %86 = load ptr, ptr %15, align 8
  call void @free(ptr noundef %86) #6
  %87 = load ptr, ptr %16, align 8
  call void @free(ptr noundef %87) #6
  %88 = load ptr, ptr %17, align 8
  call void @free(ptr noundef %88) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6, ptr noundef %7, ptr noundef %8, ptr noundef %9, ptr noundef %10, ptr noundef %11) #0 {
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca ptr, align 8
  %18 = alloca ptr, align 8
  %19 = alloca ptr, align 8
  %20 = alloca ptr, align 8
  %21 = alloca ptr, align 8
  %22 = alloca ptr, align 8
  %23 = alloca ptr, align 8
  %24 = alloca ptr, align 8
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca double, align 8
  store i32 %0, ptr %13, align 4
  store ptr %1, ptr %14, align 8
  store ptr %2, ptr %15, align 8
  store ptr %3, ptr %16, align 8
  store ptr %4, ptr %17, align 8
  store ptr %5, ptr %18, align 8
  store ptr %6, ptr %19, align 8
  store ptr %7, ptr %20, align 8
  store ptr %8, ptr %21, align 8
  store ptr %9, ptr %22, align 8
  store ptr %10, ptr %23, align 8
  store ptr %11, ptr %24, align 8
  %28 = load ptr, ptr %14, align 8
  store double 1.500000e+00, ptr %28, align 8
  %29 = load ptr, ptr %15, align 8
  store double 1.200000e+00, ptr %29, align 8
  %30 = load i32, ptr %13, align 4
  %31 = sitofp i32 %30 to double
  store double %31, ptr %27, align 8
  store i32 0, ptr %25, align 4
  br label %32

32:                                               ; preds = %126, %12
  %33 = load i32, ptr %25, align 4
  %34 = load i32, ptr %13, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %129

36:                                               ; preds = %32
  %37 = load i32, ptr %25, align 4
  %38 = sitofp i32 %37 to double
  %39 = load ptr, ptr %17, align 8
  %40 = load i32, ptr %25, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds double, ptr %39, i64 %41
  store double %38, ptr %42, align 8
  %43 = load i32, ptr %25, align 4
  %44 = add nsw i32 %43, 1
  %45 = sitofp i32 %44 to double
  %46 = load double, ptr %27, align 8
  %47 = fdiv double %45, %46
  %48 = fdiv double %47, 2.000000e+00
  %49 = load ptr, ptr %19, align 8
  %50 = load i32, ptr %25, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds double, ptr %49, i64 %51
  store double %48, ptr %52, align 8
  %53 = load i32, ptr %25, align 4
  %54 = add nsw i32 %53, 1
  %55 = sitofp i32 %54 to double
  %56 = load double, ptr %27, align 8
  %57 = fdiv double %55, %56
  %58 = fdiv double %57, 4.000000e+00
  %59 = load ptr, ptr %18, align 8
  %60 = load i32, ptr %25, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds double, ptr %59, i64 %61
  store double %58, ptr %62, align 8
  %63 = load i32, ptr %25, align 4
  %64 = add nsw i32 %63, 1
  %65 = sitofp i32 %64 to double
  %66 = load double, ptr %27, align 8
  %67 = fdiv double %65, %66
  %68 = fdiv double %67, 6.000000e+00
  %69 = load ptr, ptr %20, align 8
  %70 = load i32, ptr %25, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds double, ptr %69, i64 %71
  store double %68, ptr %72, align 8
  %73 = load i32, ptr %25, align 4
  %74 = add nsw i32 %73, 1
  %75 = sitofp i32 %74 to double
  %76 = load double, ptr %27, align 8
  %77 = fdiv double %75, %76
  %78 = fdiv double %77, 8.000000e+00
  %79 = load ptr, ptr %23, align 8
  %80 = load i32, ptr %25, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds double, ptr %79, i64 %81
  store double %78, ptr %82, align 8
  %83 = load i32, ptr %25, align 4
  %84 = add nsw i32 %83, 1
  %85 = sitofp i32 %84 to double
  %86 = load double, ptr %27, align 8
  %87 = fdiv double %85, %86
  %88 = fdiv double %87, 9.000000e+00
  %89 = load ptr, ptr %24, align 8
  %90 = load i32, ptr %25, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds double, ptr %89, i64 %91
  store double %88, ptr %92, align 8
  %93 = load ptr, ptr %22, align 8
  %94 = load i32, ptr %25, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds double, ptr %93, i64 %95
  store double 0.000000e+00, ptr %96, align 8
  %97 = load ptr, ptr %21, align 8
  %98 = load i32, ptr %25, align 4
  %99 = sext i32 %98 to i64
  %100 = getelementptr inbounds double, ptr %97, i64 %99
  store double 0.000000e+00, ptr %100, align 8
  store i32 0, ptr %26, align 4
  br label %101

101:                                              ; preds = %122, %36
  %102 = load i32, ptr %26, align 4
  %103 = load i32, ptr %13, align 4
  %104 = icmp slt i32 %102, %103
  br i1 %104, label %105, label %125

105:                                              ; preds = %101
  %106 = load i32, ptr %25, align 4
  %107 = load i32, ptr %26, align 4
  %108 = mul nsw i32 %106, %107
  %109 = load i32, ptr %13, align 4
  %110 = srem i32 %108, %109
  %111 = sitofp i32 %110 to double
  %112 = load i32, ptr %13, align 4
  %113 = sitofp i32 %112 to double
  %114 = fdiv double %111, %113
  %115 = load ptr, ptr %16, align 8
  %116 = load i32, ptr %25, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds [2000 x double], ptr %115, i64 %117
  %119 = load i32, ptr %26, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [2000 x double], ptr %118, i64 0, i64 %120
  store double %114, ptr %121, align 8
  br label %122

122:                                              ; preds = %105
  %123 = load i32, ptr %26, align 4
  %124 = add nsw i32 %123, 1
  store i32 %124, ptr %26, align 4
  br label %101, !llvm.loop !6

125:                                              ; preds = %101
  br label %126

126:                                              ; preds = %125
  %127 = load i32, ptr %25, align 4
  %128 = add nsw i32 %127, 1
  store i32 %128, ptr %25, align 4
  br label %32, !llvm.loop !8

129:                                              ; preds = %32
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_gemver(i32 noundef %0, double noundef %1, double noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6, ptr noundef %7, ptr noundef %8, ptr noundef %9, ptr noundef %10, ptr noundef %11) #0 {
  %13 = alloca i32, align 4
  %14 = alloca double, align 8
  %15 = alloca double, align 8
  %16 = alloca ptr, align 8
  %17 = alloca ptr, align 8
  %18 = alloca ptr, align 8
  %19 = alloca ptr, align 8
  %20 = alloca ptr, align 8
  %21 = alloca ptr, align 8
  %22 = alloca ptr, align 8
  %23 = alloca ptr, align 8
  %24 = alloca ptr, align 8
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  store i32 %0, ptr %13, align 4
  store double %1, ptr %14, align 8
  store double %2, ptr %15, align 8
  store ptr %3, ptr %16, align 8
  store ptr %4, ptr %17, align 8
  store ptr %5, ptr %18, align 8
  store ptr %6, ptr %19, align 8
  store ptr %7, ptr %20, align 8
  store ptr %8, ptr %21, align 8
  store ptr %9, ptr %22, align 8
  store ptr %10, ptr %23, align 8
  store ptr %11, ptr %24, align 8
  store i32 0, ptr %25, align 4
  br label %27

27:                                               ; preds = %78, %12
  %28 = load i32, ptr %25, align 4
  %29 = load i32, ptr %13, align 4
  %30 = icmp slt i32 %28, %29
  br i1 %30, label %31, label %81

31:                                               ; preds = %27
  store i32 0, ptr %26, align 4
  br label %32

32:                                               ; preds = %74, %31
  %33 = load i32, ptr %26, align 4
  %34 = load i32, ptr %13, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %77

36:                                               ; preds = %32
  %37 = load ptr, ptr %16, align 8
  %38 = load i32, ptr %25, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [2000 x double], ptr %37, i64 %39
  %41 = load i32, ptr %26, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [2000 x double], ptr %40, i64 0, i64 %42
  %44 = load double, ptr %43, align 8
  %45 = load ptr, ptr %17, align 8
  %46 = load i32, ptr %25, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds double, ptr %45, i64 %47
  %49 = load double, ptr %48, align 8
  %50 = load ptr, ptr %18, align 8
  %51 = load i32, ptr %26, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds double, ptr %50, i64 %52
  %54 = load double, ptr %53, align 8
  %55 = call double @llvm.fmuladd.f64(double %49, double %54, double %44)
  %56 = load ptr, ptr %19, align 8
  %57 = load i32, ptr %25, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds double, ptr %56, i64 %58
  %60 = load double, ptr %59, align 8
  %61 = load ptr, ptr %20, align 8
  %62 = load i32, ptr %26, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds double, ptr %61, i64 %63
  %65 = load double, ptr %64, align 8
  %66 = call double @llvm.fmuladd.f64(double %60, double %65, double %55)
  %67 = load ptr, ptr %16, align 8
  %68 = load i32, ptr %25, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds [2000 x double], ptr %67, i64 %69
  %71 = load i32, ptr %26, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds [2000 x double], ptr %70, i64 0, i64 %72
  store double %66, ptr %73, align 8
  br label %74

74:                                               ; preds = %36
  %75 = load i32, ptr %26, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, ptr %26, align 4
  br label %32, !llvm.loop !9

77:                                               ; preds = %32
  br label %78

78:                                               ; preds = %77
  %79 = load i32, ptr %25, align 4
  %80 = add nsw i32 %79, 1
  store i32 %80, ptr %25, align 4
  br label %27, !llvm.loop !10

81:                                               ; preds = %27
  store i32 0, ptr %25, align 4
  br label %82

82:                                               ; preds = %121, %81
  %83 = load i32, ptr %25, align 4
  %84 = load i32, ptr %13, align 4
  %85 = icmp slt i32 %83, %84
  br i1 %85, label %86, label %124

86:                                               ; preds = %82
  store i32 0, ptr %26, align 4
  br label %87

87:                                               ; preds = %117, %86
  %88 = load i32, ptr %26, align 4
  %89 = load i32, ptr %13, align 4
  %90 = icmp slt i32 %88, %89
  br i1 %90, label %91, label %120

91:                                               ; preds = %87
  %92 = load ptr, ptr %22, align 8
  %93 = load i32, ptr %25, align 4
  %94 = sext i32 %93 to i64
  %95 = getelementptr inbounds double, ptr %92, i64 %94
  %96 = load double, ptr %95, align 8
  %97 = load double, ptr %15, align 8
  %98 = load ptr, ptr %16, align 8
  %99 = load i32, ptr %26, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds [2000 x double], ptr %98, i64 %100
  %102 = load i32, ptr %25, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds [2000 x double], ptr %101, i64 0, i64 %103
  %105 = load double, ptr %104, align 8
  %106 = fmul double %97, %105
  %107 = load ptr, ptr %23, align 8
  %108 = load i32, ptr %26, align 4
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds double, ptr %107, i64 %109
  %111 = load double, ptr %110, align 8
  %112 = call double @llvm.fmuladd.f64(double %106, double %111, double %96)
  %113 = load ptr, ptr %22, align 8
  %114 = load i32, ptr %25, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds double, ptr %113, i64 %115
  store double %112, ptr %116, align 8
  br label %117

117:                                              ; preds = %91
  %118 = load i32, ptr %26, align 4
  %119 = add nsw i32 %118, 1
  store i32 %119, ptr %26, align 4
  br label %87, !llvm.loop !11

120:                                              ; preds = %87
  br label %121

121:                                              ; preds = %120
  %122 = load i32, ptr %25, align 4
  %123 = add nsw i32 %122, 1
  store i32 %123, ptr %25, align 4
  br label %82, !llvm.loop !12

124:                                              ; preds = %82
  store i32 0, ptr %25, align 4
  br label %125

125:                                              ; preds = %145, %124
  %126 = load i32, ptr %25, align 4
  %127 = load i32, ptr %13, align 4
  %128 = icmp slt i32 %126, %127
  br i1 %128, label %129, label %148

129:                                              ; preds = %125
  %130 = load ptr, ptr %22, align 8
  %131 = load i32, ptr %25, align 4
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds double, ptr %130, i64 %132
  %134 = load double, ptr %133, align 8
  %135 = load ptr, ptr %24, align 8
  %136 = load i32, ptr %25, align 4
  %137 = sext i32 %136 to i64
  %138 = getelementptr inbounds double, ptr %135, i64 %137
  %139 = load double, ptr %138, align 8
  %140 = fadd double %134, %139
  %141 = load ptr, ptr %22, align 8
  %142 = load i32, ptr %25, align 4
  %143 = sext i32 %142 to i64
  %144 = getelementptr inbounds double, ptr %141, i64 %143
  store double %140, ptr %144, align 8
  br label %145

145:                                              ; preds = %129
  %146 = load i32, ptr %25, align 4
  %147 = add nsw i32 %146, 1
  store i32 %147, ptr %25, align 4
  br label %125, !llvm.loop !13

148:                                              ; preds = %125
  store i32 0, ptr %25, align 4
  br label %149

149:                                              ; preds = %188, %148
  %150 = load i32, ptr %25, align 4
  %151 = load i32, ptr %13, align 4
  %152 = icmp slt i32 %150, %151
  br i1 %152, label %153, label %191

153:                                              ; preds = %149
  store i32 0, ptr %26, align 4
  br label %154

154:                                              ; preds = %184, %153
  %155 = load i32, ptr %26, align 4
  %156 = load i32, ptr %13, align 4
  %157 = icmp slt i32 %155, %156
  br i1 %157, label %158, label %187

158:                                              ; preds = %154
  %159 = load ptr, ptr %21, align 8
  %160 = load i32, ptr %25, align 4
  %161 = sext i32 %160 to i64
  %162 = getelementptr inbounds double, ptr %159, i64 %161
  %163 = load double, ptr %162, align 8
  %164 = load double, ptr %14, align 8
  %165 = load ptr, ptr %16, align 8
  %166 = load i32, ptr %25, align 4
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds [2000 x double], ptr %165, i64 %167
  %169 = load i32, ptr %26, align 4
  %170 = sext i32 %169 to i64
  %171 = getelementptr inbounds [2000 x double], ptr %168, i64 0, i64 %170
  %172 = load double, ptr %171, align 8
  %173 = fmul double %164, %172
  %174 = load ptr, ptr %22, align 8
  %175 = load i32, ptr %26, align 4
  %176 = sext i32 %175 to i64
  %177 = getelementptr inbounds double, ptr %174, i64 %176
  %178 = load double, ptr %177, align 8
  %179 = call double @llvm.fmuladd.f64(double %173, double %178, double %163)
  %180 = load ptr, ptr %21, align 8
  %181 = load i32, ptr %25, align 4
  %182 = sext i32 %181 to i64
  %183 = getelementptr inbounds double, ptr %180, i64 %182
  store double %179, ptr %183, align 8
  br label %184

184:                                              ; preds = %158
  %185 = load i32, ptr %26, align 4
  %186 = add nsw i32 %185, 1
  store i32 %186, ptr %26, align 4
  br label %154, !llvm.loop !14

187:                                              ; preds = %154
  br label %188

188:                                              ; preds = %187
  %189 = load i32, ptr %25, align 4
  %190 = add nsw i32 %189, 1
  store i32 %190, ptr %25, align 4
  br label %149, !llvm.loop !15

191:                                              ; preds = %149
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr @stderr, align 8
  %7 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %6, ptr noundef @.str.1)
  %8 = load ptr, ptr @stderr, align 8
  %9 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %8, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %5, align 4
  br label %10

10:                                               ; preds = %29, %2
  %11 = load i32, ptr %5, align 4
  %12 = load i32, ptr %3, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %32

14:                                               ; preds = %10
  %15 = load i32, ptr %5, align 4
  %16 = srem i32 %15, 20
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %21

18:                                               ; preds = %14
  %19 = load ptr, ptr @stderr, align 8
  %20 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %19, ptr noundef @.str.4)
  br label %21

21:                                               ; preds = %18, %14
  %22 = load ptr, ptr @stderr, align 8
  %23 = load ptr, ptr %4, align 8
  %24 = load i32, ptr %5, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds double, ptr %23, i64 %25
  %27 = load double, ptr %26, align 8
  %28 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %22, ptr noundef @.str.5, double noundef %27)
  br label %29

29:                                               ; preds = %21
  %30 = load i32, ptr %5, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %5, align 4
  br label %10, !llvm.loop !16

32:                                               ; preds = %10
  %33 = load ptr, ptr @stderr, align 8
  %34 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %33, ptr noundef @.str.6, ptr noundef @.str.3)
  %35 = load ptr, ptr @stderr, align 8
  %36 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %35, ptr noundef @.str.7)
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
