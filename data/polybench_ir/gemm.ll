; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/blas/gemm/gemm.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/blas/gemm/gemm.c"
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
  %8 = alloca i32, align 4
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 1000, ptr %6, align 4
  store i32 1100, ptr %7, align 4
  store i32 1200, ptr %8, align 4
  %14 = call ptr @polybench_alloc_data(i64 noundef 1100000, i32 noundef 8)
  store ptr %14, ptr %11, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %15, ptr %12, align 8
  %16 = call ptr @polybench_alloc_data(i64 noundef 1320000, i32 noundef 8)
  store ptr %16, ptr %13, align 8
  %17 = load i32, ptr %6, align 4
  %18 = load i32, ptr %7, align 4
  %19 = load i32, ptr %8, align 4
  %20 = load ptr, ptr %11, align 8
  %21 = getelementptr inbounds [1000 x [1100 x double]], ptr %20, i64 0, i64 0
  %22 = load ptr, ptr %12, align 8
  %23 = getelementptr inbounds [1000 x [1200 x double]], ptr %22, i64 0, i64 0
  %24 = load ptr, ptr %13, align 8
  %25 = getelementptr inbounds [1200 x [1100 x double]], ptr %24, i64 0, i64 0
  call void @init_array(i32 noundef %17, i32 noundef %18, i32 noundef %19, ptr noundef %9, ptr noundef %10, ptr noundef %21, ptr noundef %23, ptr noundef %25)
  %26 = load i32, ptr %6, align 4
  %27 = load i32, ptr %7, align 4
  %28 = load i32, ptr %8, align 4
  %29 = load double, ptr %9, align 8
  %30 = load double, ptr %10, align 8
  %31 = load ptr, ptr %11, align 8
  %32 = getelementptr inbounds [1000 x [1100 x double]], ptr %31, i64 0, i64 0
  %33 = load ptr, ptr %12, align 8
  %34 = getelementptr inbounds [1000 x [1200 x double]], ptr %33, i64 0, i64 0
  %35 = load ptr, ptr %13, align 8
  %36 = getelementptr inbounds [1200 x [1100 x double]], ptr %35, i64 0, i64 0
  call void @kernel_gemm(i32 noundef %26, i32 noundef %27, i32 noundef %28, double noundef %29, double noundef %30, ptr noundef %32, ptr noundef %34, ptr noundef %36)
  %37 = load i32, ptr %4, align 4
  %38 = icmp sgt i32 %37, 42
  br i1 %38, label %39, label %50

39:                                               ; preds = %2
  %40 = load ptr, ptr %5, align 8
  %41 = getelementptr inbounds ptr, ptr %40, i64 0
  %42 = load ptr, ptr %41, align 8
  %43 = call i32 @strcmp(ptr noundef %42, ptr noundef @.str) #5
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %50, label %45

45:                                               ; preds = %39
  %46 = load i32, ptr %6, align 4
  %47 = load i32, ptr %7, align 4
  %48 = load ptr, ptr %11, align 8
  %49 = getelementptr inbounds [1000 x [1100 x double]], ptr %48, i64 0, i64 0
  call void @print_array(i32 noundef %46, i32 noundef %47, ptr noundef %49)
  br label %50

50:                                               ; preds = %45, %39, %2
  %51 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %51) #6
  %52 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %52) #6
  %53 = load ptr, ptr %13, align 8
  call void @free(ptr noundef %53) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6, ptr noundef %7) #0 {
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store i32 %0, ptr %9, align 4
  store i32 %1, ptr %10, align 4
  store i32 %2, ptr %11, align 4
  store ptr %3, ptr %12, align 8
  store ptr %4, ptr %13, align 8
  store ptr %5, ptr %14, align 8
  store ptr %6, ptr %15, align 8
  store ptr %7, ptr %16, align 8
  %19 = load ptr, ptr %12, align 8
  store double 1.500000e+00, ptr %19, align 8
  %20 = load ptr, ptr %13, align 8
  store double 1.200000e+00, ptr %20, align 8
  store i32 0, ptr %17, align 4
  br label %21

21:                                               ; preds = %52, %8
  %22 = load i32, ptr %17, align 4
  %23 = load i32, ptr %9, align 4
  %24 = icmp slt i32 %22, %23
  br i1 %24, label %25, label %55

25:                                               ; preds = %21
  store i32 0, ptr %18, align 4
  br label %26

26:                                               ; preds = %48, %25
  %27 = load i32, ptr %18, align 4
  %28 = load i32, ptr %10, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %51

30:                                               ; preds = %26
  %31 = load i32, ptr %17, align 4
  %32 = load i32, ptr %18, align 4
  %33 = mul nsw i32 %31, %32
  %34 = add nsw i32 %33, 1
  %35 = load i32, ptr %9, align 4
  %36 = srem i32 %34, %35
  %37 = sitofp i32 %36 to double
  %38 = load i32, ptr %9, align 4
  %39 = sitofp i32 %38 to double
  %40 = fdiv double %37, %39
  %41 = load ptr, ptr %14, align 8
  %42 = load i32, ptr %17, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [1100 x double], ptr %41, i64 %43
  %45 = load i32, ptr %18, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [1100 x double], ptr %44, i64 0, i64 %46
  store double %40, ptr %47, align 8
  br label %48

48:                                               ; preds = %30
  %49 = load i32, ptr %18, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %18, align 4
  br label %26, !llvm.loop !6

51:                                               ; preds = %26
  br label %52

52:                                               ; preds = %51
  %53 = load i32, ptr %17, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %17, align 4
  br label %21, !llvm.loop !8

55:                                               ; preds = %21
  store i32 0, ptr %17, align 4
  br label %56

56:                                               ; preds = %87, %55
  %57 = load i32, ptr %17, align 4
  %58 = load i32, ptr %9, align 4
  %59 = icmp slt i32 %57, %58
  br i1 %59, label %60, label %90

60:                                               ; preds = %56
  store i32 0, ptr %18, align 4
  br label %61

61:                                               ; preds = %83, %60
  %62 = load i32, ptr %18, align 4
  %63 = load i32, ptr %11, align 4
  %64 = icmp slt i32 %62, %63
  br i1 %64, label %65, label %86

65:                                               ; preds = %61
  %66 = load i32, ptr %17, align 4
  %67 = load i32, ptr %18, align 4
  %68 = add nsw i32 %67, 1
  %69 = mul nsw i32 %66, %68
  %70 = load i32, ptr %11, align 4
  %71 = srem i32 %69, %70
  %72 = sitofp i32 %71 to double
  %73 = load i32, ptr %11, align 4
  %74 = sitofp i32 %73 to double
  %75 = fdiv double %72, %74
  %76 = load ptr, ptr %15, align 8
  %77 = load i32, ptr %17, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [1200 x double], ptr %76, i64 %78
  %80 = load i32, ptr %18, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [1200 x double], ptr %79, i64 0, i64 %81
  store double %75, ptr %82, align 8
  br label %83

83:                                               ; preds = %65
  %84 = load i32, ptr %18, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, ptr %18, align 4
  br label %61, !llvm.loop !9

86:                                               ; preds = %61
  br label %87

87:                                               ; preds = %86
  %88 = load i32, ptr %17, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %17, align 4
  br label %56, !llvm.loop !10

90:                                               ; preds = %56
  store i32 0, ptr %17, align 4
  br label %91

91:                                               ; preds = %122, %90
  %92 = load i32, ptr %17, align 4
  %93 = load i32, ptr %11, align 4
  %94 = icmp slt i32 %92, %93
  br i1 %94, label %95, label %125

95:                                               ; preds = %91
  store i32 0, ptr %18, align 4
  br label %96

96:                                               ; preds = %118, %95
  %97 = load i32, ptr %18, align 4
  %98 = load i32, ptr %10, align 4
  %99 = icmp slt i32 %97, %98
  br i1 %99, label %100, label %121

100:                                              ; preds = %96
  %101 = load i32, ptr %17, align 4
  %102 = load i32, ptr %18, align 4
  %103 = add nsw i32 %102, 2
  %104 = mul nsw i32 %101, %103
  %105 = load i32, ptr %10, align 4
  %106 = srem i32 %104, %105
  %107 = sitofp i32 %106 to double
  %108 = load i32, ptr %10, align 4
  %109 = sitofp i32 %108 to double
  %110 = fdiv double %107, %109
  %111 = load ptr, ptr %16, align 8
  %112 = load i32, ptr %17, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [1100 x double], ptr %111, i64 %113
  %115 = load i32, ptr %18, align 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds [1100 x double], ptr %114, i64 0, i64 %116
  store double %110, ptr %117, align 8
  br label %118

118:                                              ; preds = %100
  %119 = load i32, ptr %18, align 4
  %120 = add nsw i32 %119, 1
  store i32 %120, ptr %18, align 4
  br label %96, !llvm.loop !11

121:                                              ; preds = %96
  br label %122

122:                                              ; preds = %121
  %123 = load i32, ptr %17, align 4
  %124 = add nsw i32 %123, 1
  store i32 %124, ptr %17, align 4
  br label %91, !llvm.loop !12

125:                                              ; preds = %91
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_gemm(i32 noundef %0, i32 noundef %1, i32 noundef %2, double noundef %3, double noundef %4, ptr noundef %5, ptr noundef %6, ptr noundef %7) #0 {
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca double, align 8
  %13 = alloca double, align 8
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  store i32 %0, ptr %9, align 4
  store i32 %1, ptr %10, align 4
  store i32 %2, ptr %11, align 4
  store double %3, ptr %12, align 8
  store double %4, ptr %13, align 8
  store ptr %5, ptr %14, align 8
  store ptr %6, ptr %15, align 8
  store ptr %7, ptr %16, align 8
  store i32 0, ptr %17, align 4
  br label %20

20:                                               ; preds = %89, %8
  %21 = load i32, ptr %17, align 4
  %22 = load i32, ptr %9, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %92

24:                                               ; preds = %20
  store i32 0, ptr %18, align 4
  br label %25

25:                                               ; preds = %40, %24
  %26 = load i32, ptr %18, align 4
  %27 = load i32, ptr %10, align 4
  %28 = icmp slt i32 %26, %27
  br i1 %28, label %29, label %43

29:                                               ; preds = %25
  %30 = load double, ptr %13, align 8
  %31 = load ptr, ptr %14, align 8
  %32 = load i32, ptr %17, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [1100 x double], ptr %31, i64 %33
  %35 = load i32, ptr %18, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [1100 x double], ptr %34, i64 0, i64 %36
  %38 = load double, ptr %37, align 8
  %39 = fmul double %38, %30
  store double %39, ptr %37, align 8
  br label %40

40:                                               ; preds = %29
  %41 = load i32, ptr %18, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %18, align 4
  br label %25, !llvm.loop !13

43:                                               ; preds = %25
  store i32 0, ptr %19, align 4
  br label %44

44:                                               ; preds = %85, %43
  %45 = load i32, ptr %19, align 4
  %46 = load i32, ptr %11, align 4
  %47 = icmp slt i32 %45, %46
  br i1 %47, label %48, label %88

48:                                               ; preds = %44
  store i32 0, ptr %18, align 4
  br label %49

49:                                               ; preds = %81, %48
  %50 = load i32, ptr %18, align 4
  %51 = load i32, ptr %10, align 4
  %52 = icmp slt i32 %50, %51
  br i1 %52, label %53, label %84

53:                                               ; preds = %49
  %54 = load double, ptr %12, align 8
  %55 = load ptr, ptr %15, align 8
  %56 = load i32, ptr %17, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [1200 x double], ptr %55, i64 %57
  %59 = load i32, ptr %19, align 4
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [1200 x double], ptr %58, i64 0, i64 %60
  %62 = load double, ptr %61, align 8
  %63 = fmul double %54, %62
  %64 = load ptr, ptr %16, align 8
  %65 = load i32, ptr %19, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [1100 x double], ptr %64, i64 %66
  %68 = load i32, ptr %18, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds [1100 x double], ptr %67, i64 0, i64 %69
  %71 = load double, ptr %70, align 8
  %72 = load ptr, ptr %14, align 8
  %73 = load i32, ptr %17, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [1100 x double], ptr %72, i64 %74
  %76 = load i32, ptr %18, align 4
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds [1100 x double], ptr %75, i64 0, i64 %77
  %79 = load double, ptr %78, align 8
  %80 = call double @llvm.fmuladd.f64(double %63, double %71, double %79)
  store double %80, ptr %78, align 8
  br label %81

81:                                               ; preds = %53
  %82 = load i32, ptr %18, align 4
  %83 = add nsw i32 %82, 1
  store i32 %83, ptr %18, align 4
  br label %49, !llvm.loop !14

84:                                               ; preds = %49
  br label %85

85:                                               ; preds = %84
  %86 = load i32, ptr %19, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %19, align 4
  br label %44, !llvm.loop !15

88:                                               ; preds = %44
  br label %89

89:                                               ; preds = %88
  %90 = load i32, ptr %17, align 4
  %91 = add nsw i32 %90, 1
  store i32 %91, ptr %17, align 4
  br label %20, !llvm.loop !16

92:                                               ; preds = %20
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
  %38 = getelementptr inbounds [1100 x double], ptr %35, i64 %37
  %39 = load i32, ptr %8, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [1100 x double], ptr %38, i64 0, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %34, ptr noundef @.str.5, double noundef %42)
  br label %44

44:                                               ; preds = %33
  %45 = load i32, ptr %8, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %8, align 4
  br label %18, !llvm.loop !17

47:                                               ; preds = %18
  br label %48

48:                                               ; preds = %47
  %49 = load i32, ptr %7, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %7, align 4
  br label %13, !llvm.loop !18

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
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
