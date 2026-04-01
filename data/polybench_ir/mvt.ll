; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/kernels/mvt/mvt.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/kernels/mvt/mvt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"x1\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"x2\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 2000, ptr %6, align 4
  %12 = call ptr @polybench_alloc_data(i64 noundef 4000000, i32 noundef 8)
  store ptr %12, ptr %7, align 8
  %13 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %13, ptr %8, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %14, ptr %9, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %15, ptr %10, align 8
  %16 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %16, ptr %11, align 8
  %17 = load i32, ptr %6, align 4
  %18 = load ptr, ptr %8, align 8
  %19 = getelementptr inbounds [2000 x double], ptr %18, i64 0, i64 0
  %20 = load ptr, ptr %9, align 8
  %21 = getelementptr inbounds [2000 x double], ptr %20, i64 0, i64 0
  %22 = load ptr, ptr %10, align 8
  %23 = getelementptr inbounds [2000 x double], ptr %22, i64 0, i64 0
  %24 = load ptr, ptr %11, align 8
  %25 = getelementptr inbounds [2000 x double], ptr %24, i64 0, i64 0
  %26 = load ptr, ptr %7, align 8
  %27 = getelementptr inbounds [2000 x [2000 x double]], ptr %26, i64 0, i64 0
  call void @init_array(i32 noundef %17, ptr noundef %19, ptr noundef %21, ptr noundef %23, ptr noundef %25, ptr noundef %27)
  %28 = load i32, ptr %6, align 4
  %29 = load ptr, ptr %8, align 8
  %30 = getelementptr inbounds [2000 x double], ptr %29, i64 0, i64 0
  %31 = load ptr, ptr %9, align 8
  %32 = getelementptr inbounds [2000 x double], ptr %31, i64 0, i64 0
  %33 = load ptr, ptr %10, align 8
  %34 = getelementptr inbounds [2000 x double], ptr %33, i64 0, i64 0
  %35 = load ptr, ptr %11, align 8
  %36 = getelementptr inbounds [2000 x double], ptr %35, i64 0, i64 0
  %37 = load ptr, ptr %7, align 8
  %38 = getelementptr inbounds [2000 x [2000 x double]], ptr %37, i64 0, i64 0
  call void @kernel_mvt(i32 noundef %28, ptr noundef %30, ptr noundef %32, ptr noundef %34, ptr noundef %36, ptr noundef %38)
  %39 = load i32, ptr %4, align 4
  %40 = icmp sgt i32 %39, 42
  br i1 %40, label %41, label %53

41:                                               ; preds = %2
  %42 = load ptr, ptr %5, align 8
  %43 = getelementptr inbounds ptr, ptr %42, i64 0
  %44 = load ptr, ptr %43, align 8
  %45 = call i32 @strcmp(ptr noundef %44, ptr noundef @.str) #5
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %53, label %47

47:                                               ; preds = %41
  %48 = load i32, ptr %6, align 4
  %49 = load ptr, ptr %8, align 8
  %50 = getelementptr inbounds [2000 x double], ptr %49, i64 0, i64 0
  %51 = load ptr, ptr %9, align 8
  %52 = getelementptr inbounds [2000 x double], ptr %51, i64 0, i64 0
  call void @print_array(i32 noundef %48, ptr noundef %50, ptr noundef %52)
  br label %53

53:                                               ; preds = %47, %41, %2
  %54 = load ptr, ptr %7, align 8
  call void @free(ptr noundef %54) #6
  %55 = load ptr, ptr %8, align 8
  call void @free(ptr noundef %55) #6
  %56 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %56) #6
  %57 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %57) #6
  %58 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %58) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store ptr %1, ptr %8, align 8
  store ptr %2, ptr %9, align 8
  store ptr %3, ptr %10, align 8
  store ptr %4, ptr %11, align 8
  store ptr %5, ptr %12, align 8
  store i32 0, ptr %13, align 4
  br label %15

15:                                               ; preds = %92, %6
  %16 = load i32, ptr %13, align 4
  %17 = load i32, ptr %7, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %95

19:                                               ; preds = %15
  %20 = load i32, ptr %13, align 4
  %21 = load i32, ptr %7, align 4
  %22 = srem i32 %20, %21
  %23 = sitofp i32 %22 to double
  %24 = load i32, ptr %7, align 4
  %25 = sitofp i32 %24 to double
  %26 = fdiv double %23, %25
  %27 = load ptr, ptr %8, align 8
  %28 = load i32, ptr %13, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds double, ptr %27, i64 %29
  store double %26, ptr %30, align 8
  %31 = load i32, ptr %13, align 4
  %32 = add nsw i32 %31, 1
  %33 = load i32, ptr %7, align 4
  %34 = srem i32 %32, %33
  %35 = sitofp i32 %34 to double
  %36 = load i32, ptr %7, align 4
  %37 = sitofp i32 %36 to double
  %38 = fdiv double %35, %37
  %39 = load ptr, ptr %9, align 8
  %40 = load i32, ptr %13, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds double, ptr %39, i64 %41
  store double %38, ptr %42, align 8
  %43 = load i32, ptr %13, align 4
  %44 = add nsw i32 %43, 3
  %45 = load i32, ptr %7, align 4
  %46 = srem i32 %44, %45
  %47 = sitofp i32 %46 to double
  %48 = load i32, ptr %7, align 4
  %49 = sitofp i32 %48 to double
  %50 = fdiv double %47, %49
  %51 = load ptr, ptr %10, align 8
  %52 = load i32, ptr %13, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds double, ptr %51, i64 %53
  store double %50, ptr %54, align 8
  %55 = load i32, ptr %13, align 4
  %56 = add nsw i32 %55, 4
  %57 = load i32, ptr %7, align 4
  %58 = srem i32 %56, %57
  %59 = sitofp i32 %58 to double
  %60 = load i32, ptr %7, align 4
  %61 = sitofp i32 %60 to double
  %62 = fdiv double %59, %61
  %63 = load ptr, ptr %11, align 8
  %64 = load i32, ptr %13, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds double, ptr %63, i64 %65
  store double %62, ptr %66, align 8
  store i32 0, ptr %14, align 4
  br label %67

67:                                               ; preds = %88, %19
  %68 = load i32, ptr %14, align 4
  %69 = load i32, ptr %7, align 4
  %70 = icmp slt i32 %68, %69
  br i1 %70, label %71, label %91

71:                                               ; preds = %67
  %72 = load i32, ptr %13, align 4
  %73 = load i32, ptr %14, align 4
  %74 = mul nsw i32 %72, %73
  %75 = load i32, ptr %7, align 4
  %76 = srem i32 %74, %75
  %77 = sitofp i32 %76 to double
  %78 = load i32, ptr %7, align 4
  %79 = sitofp i32 %78 to double
  %80 = fdiv double %77, %79
  %81 = load ptr, ptr %12, align 8
  %82 = load i32, ptr %13, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [2000 x double], ptr %81, i64 %83
  %85 = load i32, ptr %14, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [2000 x double], ptr %84, i64 0, i64 %86
  store double %80, ptr %87, align 8
  br label %88

88:                                               ; preds = %71
  %89 = load i32, ptr %14, align 4
  %90 = add nsw i32 %89, 1
  store i32 %90, ptr %14, align 4
  br label %67, !llvm.loop !6

91:                                               ; preds = %67
  br label %92

92:                                               ; preds = %91
  %93 = load i32, ptr %13, align 4
  %94 = add nsw i32 %93, 1
  store i32 %94, ptr %13, align 4
  br label %15, !llvm.loop !8

95:                                               ; preds = %15
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_mvt(i32 noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store ptr %1, ptr %8, align 8
  store ptr %2, ptr %9, align 8
  store ptr %3, ptr %10, align 8
  store ptr %4, ptr %11, align 8
  store ptr %5, ptr %12, align 8
  store i32 0, ptr %13, align 4
  br label %15

15:                                               ; preds = %52, %6
  %16 = load i32, ptr %13, align 4
  %17 = load i32, ptr %7, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %55

19:                                               ; preds = %15
  store i32 0, ptr %14, align 4
  br label %20

20:                                               ; preds = %48, %19
  %21 = load i32, ptr %14, align 4
  %22 = load i32, ptr %7, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %51

24:                                               ; preds = %20
  %25 = load ptr, ptr %8, align 8
  %26 = load i32, ptr %13, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds double, ptr %25, i64 %27
  %29 = load double, ptr %28, align 8
  %30 = load ptr, ptr %12, align 8
  %31 = load i32, ptr %13, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [2000 x double], ptr %30, i64 %32
  %34 = load i32, ptr %14, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [2000 x double], ptr %33, i64 0, i64 %35
  %37 = load double, ptr %36, align 8
  %38 = load ptr, ptr %10, align 8
  %39 = load i32, ptr %14, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds double, ptr %38, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = call double @llvm.fmuladd.f64(double %37, double %42, double %29)
  %44 = load ptr, ptr %8, align 8
  %45 = load i32, ptr %13, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds double, ptr %44, i64 %46
  store double %43, ptr %47, align 8
  br label %48

48:                                               ; preds = %24
  %49 = load i32, ptr %14, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %14, align 4
  br label %20, !llvm.loop !9

51:                                               ; preds = %20
  br label %52

52:                                               ; preds = %51
  %53 = load i32, ptr %13, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %13, align 4
  br label %15, !llvm.loop !10

55:                                               ; preds = %15
  store i32 0, ptr %13, align 4
  br label %56

56:                                               ; preds = %93, %55
  %57 = load i32, ptr %13, align 4
  %58 = load i32, ptr %7, align 4
  %59 = icmp slt i32 %57, %58
  br i1 %59, label %60, label %96

60:                                               ; preds = %56
  store i32 0, ptr %14, align 4
  br label %61

61:                                               ; preds = %89, %60
  %62 = load i32, ptr %14, align 4
  %63 = load i32, ptr %7, align 4
  %64 = icmp slt i32 %62, %63
  br i1 %64, label %65, label %92

65:                                               ; preds = %61
  %66 = load ptr, ptr %9, align 8
  %67 = load i32, ptr %13, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds double, ptr %66, i64 %68
  %70 = load double, ptr %69, align 8
  %71 = load ptr, ptr %12, align 8
  %72 = load i32, ptr %14, align 4
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds [2000 x double], ptr %71, i64 %73
  %75 = load i32, ptr %13, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [2000 x double], ptr %74, i64 0, i64 %76
  %78 = load double, ptr %77, align 8
  %79 = load ptr, ptr %11, align 8
  %80 = load i32, ptr %14, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds double, ptr %79, i64 %81
  %83 = load double, ptr %82, align 8
  %84 = call double @llvm.fmuladd.f64(double %78, double %83, double %70)
  %85 = load ptr, ptr %9, align 8
  %86 = load i32, ptr %13, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds double, ptr %85, i64 %87
  store double %84, ptr %88, align 8
  br label %89

89:                                               ; preds = %65
  %90 = load i32, ptr %14, align 4
  %91 = add nsw i32 %90, 1
  store i32 %91, ptr %14, align 4
  br label %61, !llvm.loop !11

92:                                               ; preds = %61
  br label %93

93:                                               ; preds = %92
  %94 = load i32, ptr %13, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, ptr %13, align 4
  br label %56, !llvm.loop !12

96:                                               ; preds = %56
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %8 = load ptr, ptr @stderr, align 8
  %9 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %8, ptr noundef @.str.1)
  %10 = load ptr, ptr @stderr, align 8
  %11 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %10, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %7, align 4
  br label %12

12:                                               ; preds = %31, %3
  %13 = load i32, ptr %7, align 4
  %14 = load i32, ptr %4, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %34

16:                                               ; preds = %12
  %17 = load i32, ptr %7, align 4
  %18 = srem i32 %17, 20
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %23

20:                                               ; preds = %16
  %21 = load ptr, ptr @stderr, align 8
  %22 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %21, ptr noundef @.str.4)
  br label %23

23:                                               ; preds = %20, %16
  %24 = load ptr, ptr @stderr, align 8
  %25 = load ptr, ptr %5, align 8
  %26 = load i32, ptr %7, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds double, ptr %25, i64 %27
  %29 = load double, ptr %28, align 8
  %30 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %24, ptr noundef @.str.5, double noundef %29)
  br label %31

31:                                               ; preds = %23
  %32 = load i32, ptr %7, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %7, align 4
  br label %12, !llvm.loop !13

34:                                               ; preds = %12
  %35 = load ptr, ptr @stderr, align 8
  %36 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %35, ptr noundef @.str.6, ptr noundef @.str.3)
  %37 = load ptr, ptr @stderr, align 8
  %38 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %37, ptr noundef @.str.2, ptr noundef @.str.7)
  store i32 0, ptr %7, align 4
  br label %39

39:                                               ; preds = %58, %34
  %40 = load i32, ptr %7, align 4
  %41 = load i32, ptr %4, align 4
  %42 = icmp slt i32 %40, %41
  br i1 %42, label %43, label %61

43:                                               ; preds = %39
  %44 = load i32, ptr %7, align 4
  %45 = srem i32 %44, 20
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %50

47:                                               ; preds = %43
  %48 = load ptr, ptr @stderr, align 8
  %49 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %48, ptr noundef @.str.4)
  br label %50

50:                                               ; preds = %47, %43
  %51 = load ptr, ptr @stderr, align 8
  %52 = load ptr, ptr %6, align 8
  %53 = load i32, ptr %7, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds double, ptr %52, i64 %54
  %56 = load double, ptr %55, align 8
  %57 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %51, ptr noundef @.str.5, double noundef %56)
  br label %58

58:                                               ; preds = %50
  %59 = load i32, ptr %7, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %7, align 4
  br label %39, !llvm.loop !14

61:                                               ; preds = %39
  %62 = load ptr, ptr @stderr, align 8
  %63 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %62, ptr noundef @.str.6, ptr noundef @.str.7)
  %64 = load ptr, ptr @stderr, align 8
  %65 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %64, ptr noundef @.str.8)
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
