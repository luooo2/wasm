; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/blas/syr2k/syr2k.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/blas/syr2k/syr2k.c"
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
  store i32 1200, ptr %6, align 4
  store i32 1000, ptr %7, align 4
  %13 = call ptr @polybench_alloc_data(i64 noundef 1440000, i32 noundef 8)
  store ptr %13, ptr %10, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %14, ptr %11, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %15, ptr %12, align 8
  %16 = load i32, ptr %6, align 4
  %17 = load i32, ptr %7, align 4
  %18 = load ptr, ptr %10, align 8
  %19 = getelementptr inbounds [1200 x [1200 x double]], ptr %18, i64 0, i64 0
  %20 = load ptr, ptr %11, align 8
  %21 = getelementptr inbounds [1200 x [1000 x double]], ptr %20, i64 0, i64 0
  %22 = load ptr, ptr %12, align 8
  %23 = getelementptr inbounds [1200 x [1000 x double]], ptr %22, i64 0, i64 0
  call void @init_array(i32 noundef %16, i32 noundef %17, ptr noundef %8, ptr noundef %9, ptr noundef %19, ptr noundef %21, ptr noundef %23)
  %24 = load i32, ptr %6, align 4
  %25 = load i32, ptr %7, align 4
  %26 = load double, ptr %8, align 8
  %27 = load double, ptr %9, align 8
  %28 = load ptr, ptr %10, align 8
  %29 = getelementptr inbounds [1200 x [1200 x double]], ptr %28, i64 0, i64 0
  %30 = load ptr, ptr %11, align 8
  %31 = getelementptr inbounds [1200 x [1000 x double]], ptr %30, i64 0, i64 0
  %32 = load ptr, ptr %12, align 8
  %33 = getelementptr inbounds [1200 x [1000 x double]], ptr %32, i64 0, i64 0
  call void @kernel_syr2k(i32 noundef %24, i32 noundef %25, double noundef %26, double noundef %27, ptr noundef %29, ptr noundef %31, ptr noundef %33)
  %34 = load i32, ptr %4, align 4
  %35 = icmp sgt i32 %34, 42
  br i1 %35, label %36, label %46

36:                                               ; preds = %2
  %37 = load ptr, ptr %5, align 8
  %38 = getelementptr inbounds ptr, ptr %37, i64 0
  %39 = load ptr, ptr %38, align 8
  %40 = call i32 @strcmp(ptr noundef %39, ptr noundef @.str) #5
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %46, label %42

42:                                               ; preds = %36
  %43 = load i32, ptr %6, align 4
  %44 = load ptr, ptr %10, align 8
  %45 = getelementptr inbounds [1200 x [1200 x double]], ptr %44, i64 0, i64 0
  call void @print_array(i32 noundef %43, ptr noundef %45)
  br label %46

46:                                               ; preds = %42, %36, %2
  %47 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %47) #6
  %48 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %48) #6
  %49 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %49) #6
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

19:                                               ; preds = %67, %7
  %20 = load i32, ptr %15, align 4
  %21 = load i32, ptr %8, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %70

23:                                               ; preds = %19
  store i32 0, ptr %16, align 4
  br label %24

24:                                               ; preds = %63, %23
  %25 = load i32, ptr %16, align 4
  %26 = load i32, ptr %9, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %66

28:                                               ; preds = %24
  %29 = load i32, ptr %15, align 4
  %30 = load i32, ptr %16, align 4
  %31 = mul nsw i32 %29, %30
  %32 = add nsw i32 %31, 1
  %33 = load i32, ptr %8, align 4
  %34 = srem i32 %32, %33
  %35 = sitofp i32 %34 to double
  %36 = load i32, ptr %8, align 4
  %37 = sitofp i32 %36 to double
  %38 = fdiv double %35, %37
  %39 = load ptr, ptr %13, align 8
  %40 = load i32, ptr %15, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [1000 x double], ptr %39, i64 %41
  %43 = load i32, ptr %16, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [1000 x double], ptr %42, i64 0, i64 %44
  store double %38, ptr %45, align 8
  %46 = load i32, ptr %15, align 4
  %47 = load i32, ptr %16, align 4
  %48 = mul nsw i32 %46, %47
  %49 = add nsw i32 %48, 2
  %50 = load i32, ptr %9, align 4
  %51 = srem i32 %49, %50
  %52 = sitofp i32 %51 to double
  %53 = load i32, ptr %9, align 4
  %54 = sitofp i32 %53 to double
  %55 = fdiv double %52, %54
  %56 = load ptr, ptr %14, align 8
  %57 = load i32, ptr %15, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds [1000 x double], ptr %56, i64 %58
  %60 = load i32, ptr %16, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [1000 x double], ptr %59, i64 0, i64 %61
  store double %55, ptr %62, align 8
  br label %63

63:                                               ; preds = %28
  %64 = load i32, ptr %16, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, ptr %16, align 4
  br label %24, !llvm.loop !6

66:                                               ; preds = %24
  br label %67

67:                                               ; preds = %66
  %68 = load i32, ptr %15, align 4
  %69 = add nsw i32 %68, 1
  store i32 %69, ptr %15, align 4
  br label %19, !llvm.loop !8

70:                                               ; preds = %19
  store i32 0, ptr %15, align 4
  br label %71

71:                                               ; preds = %102, %70
  %72 = load i32, ptr %15, align 4
  %73 = load i32, ptr %8, align 4
  %74 = icmp slt i32 %72, %73
  br i1 %74, label %75, label %105

75:                                               ; preds = %71
  store i32 0, ptr %16, align 4
  br label %76

76:                                               ; preds = %98, %75
  %77 = load i32, ptr %16, align 4
  %78 = load i32, ptr %8, align 4
  %79 = icmp slt i32 %77, %78
  br i1 %79, label %80, label %101

80:                                               ; preds = %76
  %81 = load i32, ptr %15, align 4
  %82 = load i32, ptr %16, align 4
  %83 = mul nsw i32 %81, %82
  %84 = add nsw i32 %83, 3
  %85 = load i32, ptr %8, align 4
  %86 = srem i32 %84, %85
  %87 = sitofp i32 %86 to double
  %88 = load i32, ptr %9, align 4
  %89 = sitofp i32 %88 to double
  %90 = fdiv double %87, %89
  %91 = load ptr, ptr %12, align 8
  %92 = load i32, ptr %15, align 4
  %93 = sext i32 %92 to i64
  %94 = getelementptr inbounds [1200 x double], ptr %91, i64 %93
  %95 = load i32, ptr %16, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds [1200 x double], ptr %94, i64 0, i64 %96
  store double %90, ptr %97, align 8
  br label %98

98:                                               ; preds = %80
  %99 = load i32, ptr %16, align 4
  %100 = add nsw i32 %99, 1
  store i32 %100, ptr %16, align 4
  br label %76, !llvm.loop !9

101:                                              ; preds = %76
  br label %102

102:                                              ; preds = %101
  %103 = load i32, ptr %15, align 4
  %104 = add nsw i32 %103, 1
  store i32 %104, ptr %15, align 4
  br label %71, !llvm.loop !10

105:                                              ; preds = %71
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_syr2k(i32 noundef %0, i32 noundef %1, double noundef %2, double noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6) #0 {
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
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store double %2, ptr %10, align 8
  store double %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store ptr %5, ptr %13, align 8
  store ptr %6, ptr %14, align 8
  store i32 0, ptr %15, align 4
  br label %18

18:                                               ; preds = %107, %7
  %19 = load i32, ptr %15, align 4
  %20 = load i32, ptr %8, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %110

22:                                               ; preds = %18
  store i32 0, ptr %16, align 4
  br label %23

23:                                               ; preds = %38, %22
  %24 = load i32, ptr %16, align 4
  %25 = load i32, ptr %15, align 4
  %26 = icmp sle i32 %24, %25
  br i1 %26, label %27, label %41

27:                                               ; preds = %23
  %28 = load double, ptr %11, align 8
  %29 = load ptr, ptr %12, align 8
  %30 = load i32, ptr %15, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [1200 x double], ptr %29, i64 %31
  %33 = load i32, ptr %16, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [1200 x double], ptr %32, i64 0, i64 %34
  %36 = load double, ptr %35, align 8
  %37 = fmul double %36, %28
  store double %37, ptr %35, align 8
  br label %38

38:                                               ; preds = %27
  %39 = load i32, ptr %16, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %16, align 4
  br label %23, !llvm.loop !11

41:                                               ; preds = %23
  store i32 0, ptr %17, align 4
  br label %42

42:                                               ; preds = %103, %41
  %43 = load i32, ptr %17, align 4
  %44 = load i32, ptr %9, align 4
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %106

46:                                               ; preds = %42
  store i32 0, ptr %16, align 4
  br label %47

47:                                               ; preds = %99, %46
  %48 = load i32, ptr %16, align 4
  %49 = load i32, ptr %15, align 4
  %50 = icmp sle i32 %48, %49
  br i1 %50, label %51, label %102

51:                                               ; preds = %47
  %52 = load ptr, ptr %13, align 8
  %53 = load i32, ptr %16, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [1000 x double], ptr %52, i64 %54
  %56 = load i32, ptr %17, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [1000 x double], ptr %55, i64 0, i64 %57
  %59 = load double, ptr %58, align 8
  %60 = load double, ptr %10, align 8
  %61 = fmul double %59, %60
  %62 = load ptr, ptr %14, align 8
  %63 = load i32, ptr %15, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds [1000 x double], ptr %62, i64 %64
  %66 = load i32, ptr %17, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds [1000 x double], ptr %65, i64 0, i64 %67
  %69 = load double, ptr %68, align 8
  %70 = load ptr, ptr %14, align 8
  %71 = load i32, ptr %16, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds [1000 x double], ptr %70, i64 %72
  %74 = load i32, ptr %17, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds [1000 x double], ptr %73, i64 0, i64 %75
  %77 = load double, ptr %76, align 8
  %78 = load double, ptr %10, align 8
  %79 = fmul double %77, %78
  %80 = load ptr, ptr %13, align 8
  %81 = load i32, ptr %15, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [1000 x double], ptr %80, i64 %82
  %84 = load i32, ptr %17, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds [1000 x double], ptr %83, i64 0, i64 %85
  %87 = load double, ptr %86, align 8
  %88 = fmul double %79, %87
  %89 = call double @llvm.fmuladd.f64(double %61, double %69, double %88)
  %90 = load ptr, ptr %12, align 8
  %91 = load i32, ptr %15, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [1200 x double], ptr %90, i64 %92
  %94 = load i32, ptr %16, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [1200 x double], ptr %93, i64 0, i64 %95
  %97 = load double, ptr %96, align 8
  %98 = fadd double %97, %89
  store double %98, ptr %96, align 8
  br label %99

99:                                               ; preds = %51
  %100 = load i32, ptr %16, align 4
  %101 = add nsw i32 %100, 1
  store i32 %101, ptr %16, align 4
  br label %47, !llvm.loop !12

102:                                              ; preds = %47
  br label %103

103:                                              ; preds = %102
  %104 = load i32, ptr %17, align 4
  %105 = add nsw i32 %104, 1
  store i32 %105, ptr %17, align 4
  br label %42, !llvm.loop !13

106:                                              ; preds = %42
  br label %107

107:                                              ; preds = %106
  %108 = load i32, ptr %15, align 4
  %109 = add nsw i32 %108, 1
  store i32 %109, ptr %15, align 4
  br label %18, !llvm.loop !14

110:                                              ; preds = %18
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
  %36 = getelementptr inbounds [1200 x double], ptr %33, i64 %35
  %37 = load i32, ptr %6, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [1200 x double], ptr %36, i64 0, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %32, ptr noundef @.str.5, double noundef %40)
  br label %42

42:                                               ; preds = %31
  %43 = load i32, ptr %6, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %6, align 4
  br label %16, !llvm.loop !15

45:                                               ; preds = %16
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %5, align 4
  br label %11, !llvm.loop !16

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
