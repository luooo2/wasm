; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/blas/symm/symm.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/blas/symm/symm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"C\00", align 1
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
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 1000, ptr %6, align 4
  store i32 1200, ptr %7, align 4
  %13 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %13, ptr %10, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 1000000, i32 noundef 8)
  store ptr %14, ptr %11, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %15, ptr %12, align 8
  %16 = load i32, ptr %6, align 4
  %17 = load i32, ptr %7, align 4
  %18 = load ptr, ptr %10, align 8
  %19 = getelementptr inbounds [1000 x [1200 x double]], ptr %18, i64 0, i64 0
  %20 = load ptr, ptr %11, align 8
  %21 = getelementptr inbounds [1000 x [1000 x double]], ptr %20, i64 0, i64 0
  %22 = load ptr, ptr %12, align 8
  %23 = getelementptr inbounds [1000 x [1200 x double]], ptr %22, i64 0, i64 0
  call void @init_array(i32 noundef %16, i32 noundef %17, ptr noundef %8, ptr noundef %9, ptr noundef %19, ptr noundef %21, ptr noundef %23)
  %24 = load i32, ptr %6, align 4
  %25 = load i32, ptr %7, align 4
  %26 = load double, ptr %8, align 8
  %27 = load double, ptr %9, align 8
  %28 = load ptr, ptr %10, align 8
  %29 = getelementptr inbounds [1000 x [1200 x double]], ptr %28, i64 0, i64 0
  %30 = load ptr, ptr %11, align 8
  %31 = getelementptr inbounds [1000 x [1000 x double]], ptr %30, i64 0, i64 0
  %32 = load ptr, ptr %12, align 8
  %33 = getelementptr inbounds [1000 x [1200 x double]], ptr %32, i64 0, i64 0
  call void @kernel_symm(i32 noundef %24, i32 noundef %25, double noundef %26, double noundef %27, ptr noundef %29, ptr noundef %31, ptr noundef %33)
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
  %46 = getelementptr inbounds [1000 x [1200 x double]], ptr %45, i64 0, i64 0
  call void @print_array(i32 noundef %43, i32 noundef %44, ptr noundef %46)
  br label %47

47:                                               ; preds = %42, %36, %2
  %48 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %48) #6
  %49 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %49) #6
  %50 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %50) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store ptr %2, ptr %10, align 8
  store ptr %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store ptr %5, ptr %13, align 8
  store ptr %6, ptr %14, align 8
  %17 = load ptr, ptr %10, align 8
  store double 1.500000e+00, ptr %17, align 8
  %18 = load ptr, ptr %11, align 8
  store double 1.200000e+00, ptr %18, align 8
  store i32 0, ptr %15, align 4
  br label %19

19:                                               ; preds = %65, %7
  %20 = load i32, ptr %15, align 4
  %21 = load i32, ptr %8, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %68

23:                                               ; preds = %19
  store i32 0, ptr %16, align 4
  br label %24

24:                                               ; preds = %61, %23
  %25 = load i32, ptr %16, align 4
  %26 = load i32, ptr %9, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %64

28:                                               ; preds = %24
  %29 = load i32, ptr %15, align 4
  %30 = load i32, ptr %16, align 4
  %31 = add nsw i32 %29, %30
  %32 = srem i32 %31, 100
  %33 = sitofp i32 %32 to double
  %34 = load i32, ptr %8, align 4
  %35 = sitofp i32 %34 to double
  %36 = fdiv double %33, %35
  %37 = load ptr, ptr %12, align 8
  %38 = load i32, ptr %15, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [1200 x double], ptr %37, i64 %39
  %41 = load i32, ptr %16, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [1200 x double], ptr %40, i64 0, i64 %42
  store double %36, ptr %43, align 8
  %44 = load i32, ptr %9, align 4
  %45 = load i32, ptr %15, align 4
  %46 = add nsw i32 %44, %45
  %47 = load i32, ptr %16, align 4
  %48 = sub nsw i32 %46, %47
  %49 = srem i32 %48, 100
  %50 = sitofp i32 %49 to double
  %51 = load i32, ptr %8, align 4
  %52 = sitofp i32 %51 to double
  %53 = fdiv double %50, %52
  %54 = load ptr, ptr %14, align 8
  %55 = load i32, ptr %15, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [1200 x double], ptr %54, i64 %56
  %58 = load i32, ptr %16, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [1200 x double], ptr %57, i64 0, i64 %59
  store double %53, ptr %60, align 8
  br label %61

61:                                               ; preds = %28
  %62 = load i32, ptr %16, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %16, align 4
  br label %24, !llvm.loop !6

64:                                               ; preds = %24
  br label %65

65:                                               ; preds = %64
  %66 = load i32, ptr %15, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %15, align 4
  br label %19, !llvm.loop !8

68:                                               ; preds = %19
  store i32 0, ptr %15, align 4
  br label %69

69:                                               ; preds = %116, %68
  %70 = load i32, ptr %15, align 4
  %71 = load i32, ptr %8, align 4
  %72 = icmp slt i32 %70, %71
  br i1 %72, label %73, label %119

73:                                               ; preds = %69
  store i32 0, ptr %16, align 4
  br label %74

74:                                               ; preds = %94, %73
  %75 = load i32, ptr %16, align 4
  %76 = load i32, ptr %15, align 4
  %77 = icmp sle i32 %75, %76
  br i1 %77, label %78, label %97

78:                                               ; preds = %74
  %79 = load i32, ptr %15, align 4
  %80 = load i32, ptr %16, align 4
  %81 = add nsw i32 %79, %80
  %82 = srem i32 %81, 100
  %83 = sitofp i32 %82 to double
  %84 = load i32, ptr %8, align 4
  %85 = sitofp i32 %84 to double
  %86 = fdiv double %83, %85
  %87 = load ptr, ptr %13, align 8
  %88 = load i32, ptr %15, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [1000 x double], ptr %87, i64 %89
  %91 = load i32, ptr %16, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [1000 x double], ptr %90, i64 0, i64 %92
  store double %86, ptr %93, align 8
  br label %94

94:                                               ; preds = %78
  %95 = load i32, ptr %16, align 4
  %96 = add nsw i32 %95, 1
  store i32 %96, ptr %16, align 4
  br label %74, !llvm.loop !9

97:                                               ; preds = %74
  %98 = load i32, ptr %15, align 4
  %99 = add nsw i32 %98, 1
  store i32 %99, ptr %16, align 4
  br label %100

100:                                              ; preds = %112, %97
  %101 = load i32, ptr %16, align 4
  %102 = load i32, ptr %8, align 4
  %103 = icmp slt i32 %101, %102
  br i1 %103, label %104, label %115

104:                                              ; preds = %100
  %105 = load ptr, ptr %13, align 8
  %106 = load i32, ptr %15, align 4
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [1000 x double], ptr %105, i64 %107
  %109 = load i32, ptr %16, align 4
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds [1000 x double], ptr %108, i64 0, i64 %110
  store double -9.990000e+02, ptr %111, align 8
  br label %112

112:                                              ; preds = %104
  %113 = load i32, ptr %16, align 4
  %114 = add nsw i32 %113, 1
  store i32 %114, ptr %16, align 4
  br label %100, !llvm.loop !10

115:                                              ; preds = %100
  br label %116

116:                                              ; preds = %115
  %117 = load i32, ptr %15, align 4
  %118 = add nsw i32 %117, 1
  store i32 %118, ptr %15, align 4
  br label %69, !llvm.loop !11

119:                                              ; preds = %69
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_symm(i32 noundef %0, i32 noundef %1, double noundef %2, double noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca double, align 8
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store double %2, ptr %10, align 8
  store double %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store ptr %5, ptr %13, align 8
  store ptr %6, ptr %14, align 8
  store i32 0, ptr %15, align 4
  br label %19

19:                                               ; preds = %126, %7
  %20 = load i32, ptr %15, align 4
  %21 = load i32, ptr %8, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %129

23:                                               ; preds = %19
  store i32 0, ptr %16, align 4
  br label %24

24:                                               ; preds = %122, %23
  %25 = load i32, ptr %16, align 4
  %26 = load i32, ptr %9, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %125

28:                                               ; preds = %24
  store double 0.000000e+00, ptr %18, align 8
  store i32 0, ptr %17, align 4
  br label %29

29:                                               ; preds = %79, %28
  %30 = load i32, ptr %17, align 4
  %31 = load i32, ptr %15, align 4
  %32 = icmp slt i32 %30, %31
  br i1 %32, label %33, label %82

33:                                               ; preds = %29
  %34 = load double, ptr %10, align 8
  %35 = load ptr, ptr %14, align 8
  %36 = load i32, ptr %15, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [1200 x double], ptr %35, i64 %37
  %39 = load i32, ptr %16, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [1200 x double], ptr %38, i64 0, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = fmul double %34, %42
  %44 = load ptr, ptr %13, align 8
  %45 = load i32, ptr %15, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [1000 x double], ptr %44, i64 %46
  %48 = load i32, ptr %17, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [1000 x double], ptr %47, i64 0, i64 %49
  %51 = load double, ptr %50, align 8
  %52 = load ptr, ptr %12, align 8
  %53 = load i32, ptr %17, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [1200 x double], ptr %52, i64 %54
  %56 = load i32, ptr %16, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [1200 x double], ptr %55, i64 0, i64 %57
  %59 = load double, ptr %58, align 8
  %60 = call double @llvm.fmuladd.f64(double %43, double %51, double %59)
  store double %60, ptr %58, align 8
  %61 = load ptr, ptr %14, align 8
  %62 = load i32, ptr %17, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [1200 x double], ptr %61, i64 %63
  %65 = load i32, ptr %16, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [1200 x double], ptr %64, i64 0, i64 %66
  %68 = load double, ptr %67, align 8
  %69 = load ptr, ptr %13, align 8
  %70 = load i32, ptr %15, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [1000 x double], ptr %69, i64 %71
  %73 = load i32, ptr %17, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [1000 x double], ptr %72, i64 0, i64 %74
  %76 = load double, ptr %75, align 8
  %77 = load double, ptr %18, align 8
  %78 = call double @llvm.fmuladd.f64(double %68, double %76, double %77)
  store double %78, ptr %18, align 8
  br label %79

79:                                               ; preds = %33
  %80 = load i32, ptr %17, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, ptr %17, align 4
  br label %29, !llvm.loop !12

82:                                               ; preds = %29
  %83 = load double, ptr %11, align 8
  %84 = load ptr, ptr %12, align 8
  %85 = load i32, ptr %15, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [1200 x double], ptr %84, i64 %86
  %88 = load i32, ptr %16, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [1200 x double], ptr %87, i64 0, i64 %89
  %91 = load double, ptr %90, align 8
  %92 = load double, ptr %10, align 8
  %93 = load ptr, ptr %14, align 8
  %94 = load i32, ptr %15, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [1200 x double], ptr %93, i64 %95
  %97 = load i32, ptr %16, align 4
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [1200 x double], ptr %96, i64 0, i64 %98
  %100 = load double, ptr %99, align 8
  %101 = fmul double %92, %100
  %102 = load ptr, ptr %13, align 8
  %103 = load i32, ptr %15, align 4
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds [1000 x double], ptr %102, i64 %104
  %106 = load i32, ptr %15, align 4
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [1000 x double], ptr %105, i64 0, i64 %107
  %109 = load double, ptr %108, align 8
  %110 = fmul double %101, %109
  %111 = call double @llvm.fmuladd.f64(double %83, double %91, double %110)
  %112 = load double, ptr %10, align 8
  %113 = load double, ptr %18, align 8
  %114 = call double @llvm.fmuladd.f64(double %112, double %113, double %111)
  %115 = load ptr, ptr %12, align 8
  %116 = load i32, ptr %15, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds [1200 x double], ptr %115, i64 %117
  %119 = load i32, ptr %16, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [1200 x double], ptr %118, i64 0, i64 %120
  store double %114, ptr %121, align 8
  br label %122

122:                                              ; preds = %82
  %123 = load i32, ptr %16, align 4
  %124 = add nsw i32 %123, 1
  store i32 %124, ptr %16, align 4
  br label %24, !llvm.loop !13

125:                                              ; preds = %24
  br label %126

126:                                              ; preds = %125
  %127 = load i32, ptr %15, align 4
  %128 = add nsw i32 %127, 1
  store i32 %128, ptr %15, align 4
  br label %19, !llvm.loop !14

129:                                              ; preds = %19
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

13:                                               ; preds = %48, %3
  %14 = load i32, ptr %7, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %51

17:                                               ; preds = %13
  store i32 0, ptr %8, align 4
  br label %18

18:                                               ; preds = %44, %17
  %19 = load i32, ptr %8, align 4
  %20 = load i32, ptr %5, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %47

22:                                               ; preds = %18
  %23 = load i32, ptr %7, align 4
  %24 = load i32, ptr %4, align 4
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
  %38 = getelementptr inbounds [1200 x double], ptr %35, i64 %37
  %39 = load i32, ptr %8, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [1200 x double], ptr %38, i64 0, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %34, ptr noundef @.str.5, double noundef %42)
  br label %44

44:                                               ; preds = %33
  %45 = load i32, ptr %8, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %8, align 4
  br label %18, !llvm.loop !15

47:                                               ; preds = %18
  br label %48

48:                                               ; preds = %47
  %49 = load i32, ptr %7, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %7, align 4
  br label %13, !llvm.loop !16

51:                                               ; preds = %13
  %52 = load ptr, ptr @stderr, align 8
  %53 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %52, ptr noundef @.str.6, ptr noundef @.str.3)
  %54 = load ptr, ptr @stderr, align 8
  %55 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %54, ptr noundef @.str.7)
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
