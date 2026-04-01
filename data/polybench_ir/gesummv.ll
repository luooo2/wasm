; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/blas/gesummv/gesummv.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/blas/gesummv/gesummv.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"y\00", align 1
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
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 1300, ptr %6, align 4
  %14 = call ptr @polybench_alloc_data(i64 noundef 1690000, i32 noundef 8)
  store ptr %14, ptr %9, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 1690000, i32 noundef 8)
  store ptr %15, ptr %10, align 8
  %16 = call ptr @polybench_alloc_data(i64 noundef 1300, i32 noundef 8)
  store ptr %16, ptr %11, align 8
  %17 = call ptr @polybench_alloc_data(i64 noundef 1300, i32 noundef 8)
  store ptr %17, ptr %12, align 8
  %18 = call ptr @polybench_alloc_data(i64 noundef 1300, i32 noundef 8)
  store ptr %18, ptr %13, align 8
  %19 = load i32, ptr %6, align 4
  %20 = load ptr, ptr %9, align 8
  %21 = getelementptr inbounds [1300 x [1300 x double]], ptr %20, i64 0, i64 0
  %22 = load ptr, ptr %10, align 8
  %23 = getelementptr inbounds [1300 x [1300 x double]], ptr %22, i64 0, i64 0
  %24 = load ptr, ptr %12, align 8
  %25 = getelementptr inbounds [1300 x double], ptr %24, i64 0, i64 0
  call void @init_array(i32 noundef %19, ptr noundef %7, ptr noundef %8, ptr noundef %21, ptr noundef %23, ptr noundef %25)
  %26 = load i32, ptr %6, align 4
  %27 = load double, ptr %7, align 8
  %28 = load double, ptr %8, align 8
  %29 = load ptr, ptr %9, align 8
  %30 = getelementptr inbounds [1300 x [1300 x double]], ptr %29, i64 0, i64 0
  %31 = load ptr, ptr %10, align 8
  %32 = getelementptr inbounds [1300 x [1300 x double]], ptr %31, i64 0, i64 0
  %33 = load ptr, ptr %11, align 8
  %34 = getelementptr inbounds [1300 x double], ptr %33, i64 0, i64 0
  %35 = load ptr, ptr %12, align 8
  %36 = getelementptr inbounds [1300 x double], ptr %35, i64 0, i64 0
  %37 = load ptr, ptr %13, align 8
  %38 = getelementptr inbounds [1300 x double], ptr %37, i64 0, i64 0
  call void @kernel_gesummv(i32 noundef %26, double noundef %27, double noundef %28, ptr noundef %30, ptr noundef %32, ptr noundef %34, ptr noundef %36, ptr noundef %38)
  %39 = load i32, ptr %4, align 4
  %40 = icmp sgt i32 %39, 42
  br i1 %40, label %41, label %51

41:                                               ; preds = %2
  %42 = load ptr, ptr %5, align 8
  %43 = getelementptr inbounds ptr, ptr %42, i64 0
  %44 = load ptr, ptr %43, align 8
  %45 = call i32 @strcmp(ptr noundef %44, ptr noundef @.str) #5
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %51, label %47

47:                                               ; preds = %41
  %48 = load i32, ptr %6, align 4
  %49 = load ptr, ptr %13, align 8
  %50 = getelementptr inbounds [1300 x double], ptr %49, i64 0, i64 0
  call void @print_array(i32 noundef %48, ptr noundef %50)
  br label %51

51:                                               ; preds = %47, %41, %2
  %52 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %52) #6
  %53 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %53) #6
  %54 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %54) #6
  %55 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %55) #6
  %56 = load ptr, ptr %13, align 8
  call void @free(ptr noundef %56) #6
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
  %15 = load ptr, ptr %8, align 8
  store double 1.500000e+00, ptr %15, align 8
  %16 = load ptr, ptr %9, align 8
  store double 1.200000e+00, ptr %16, align 8
  store i32 0, ptr %13, align 4
  br label %17

17:                                               ; preds = %76, %6
  %18 = load i32, ptr %13, align 4
  %19 = load i32, ptr %7, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %79

21:                                               ; preds = %17
  %22 = load i32, ptr %13, align 4
  %23 = load i32, ptr %7, align 4
  %24 = srem i32 %22, %23
  %25 = sitofp i32 %24 to double
  %26 = load i32, ptr %7, align 4
  %27 = sitofp i32 %26 to double
  %28 = fdiv double %25, %27
  %29 = load ptr, ptr %12, align 8
  %30 = load i32, ptr %13, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds double, ptr %29, i64 %31
  store double %28, ptr %32, align 8
  store i32 0, ptr %14, align 4
  br label %33

33:                                               ; preds = %72, %21
  %34 = load i32, ptr %14, align 4
  %35 = load i32, ptr %7, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %75

37:                                               ; preds = %33
  %38 = load i32, ptr %13, align 4
  %39 = load i32, ptr %14, align 4
  %40 = mul nsw i32 %38, %39
  %41 = add nsw i32 %40, 1
  %42 = load i32, ptr %7, align 4
  %43 = srem i32 %41, %42
  %44 = sitofp i32 %43 to double
  %45 = load i32, ptr %7, align 4
  %46 = sitofp i32 %45 to double
  %47 = fdiv double %44, %46
  %48 = load ptr, ptr %10, align 8
  %49 = load i32, ptr %13, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [1300 x double], ptr %48, i64 %50
  %52 = load i32, ptr %14, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [1300 x double], ptr %51, i64 0, i64 %53
  store double %47, ptr %54, align 8
  %55 = load i32, ptr %13, align 4
  %56 = load i32, ptr %14, align 4
  %57 = mul nsw i32 %55, %56
  %58 = add nsw i32 %57, 2
  %59 = load i32, ptr %7, align 4
  %60 = srem i32 %58, %59
  %61 = sitofp i32 %60 to double
  %62 = load i32, ptr %7, align 4
  %63 = sitofp i32 %62 to double
  %64 = fdiv double %61, %63
  %65 = load ptr, ptr %11, align 8
  %66 = load i32, ptr %13, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds [1300 x double], ptr %65, i64 %67
  %69 = load i32, ptr %14, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds [1300 x double], ptr %68, i64 0, i64 %70
  store double %64, ptr %71, align 8
  br label %72

72:                                               ; preds = %37
  %73 = load i32, ptr %14, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, ptr %14, align 4
  br label %33, !llvm.loop !6

75:                                               ; preds = %33
  br label %76

76:                                               ; preds = %75
  %77 = load i32, ptr %13, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, ptr %13, align 4
  br label %17, !llvm.loop !8

79:                                               ; preds = %17
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_gesummv(i32 noundef %0, double noundef %1, double noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6, ptr noundef %7) #0 {
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store i32 %0, ptr %9, align 4
  store double %1, ptr %10, align 8
  store double %2, ptr %11, align 8
  store ptr %3, ptr %12, align 8
  store ptr %4, ptr %13, align 8
  store ptr %5, ptr %14, align 8
  store ptr %6, ptr %15, align 8
  store ptr %7, ptr %16, align 8
  store i32 0, ptr %17, align 4
  br label %19

19:                                               ; preds = %105, %8
  %20 = load i32, ptr %17, align 4
  %21 = load i32, ptr %9, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %108

23:                                               ; preds = %19
  %24 = load ptr, ptr %14, align 8
  %25 = load i32, ptr %17, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds double, ptr %24, i64 %26
  store double 0.000000e+00, ptr %27, align 8
  %28 = load ptr, ptr %16, align 8
  %29 = load i32, ptr %17, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds double, ptr %28, i64 %30
  store double 0.000000e+00, ptr %31, align 8
  store i32 0, ptr %18, align 4
  br label %32

32:                                               ; preds = %83, %23
  %33 = load i32, ptr %18, align 4
  %34 = load i32, ptr %9, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %86

36:                                               ; preds = %32
  %37 = load ptr, ptr %12, align 8
  %38 = load i32, ptr %17, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [1300 x double], ptr %37, i64 %39
  %41 = load i32, ptr %18, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [1300 x double], ptr %40, i64 0, i64 %42
  %44 = load double, ptr %43, align 8
  %45 = load ptr, ptr %15, align 8
  %46 = load i32, ptr %18, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds double, ptr %45, i64 %47
  %49 = load double, ptr %48, align 8
  %50 = load ptr, ptr %14, align 8
  %51 = load i32, ptr %17, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds double, ptr %50, i64 %52
  %54 = load double, ptr %53, align 8
  %55 = call double @llvm.fmuladd.f64(double %44, double %49, double %54)
  %56 = load ptr, ptr %14, align 8
  %57 = load i32, ptr %17, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds double, ptr %56, i64 %58
  store double %55, ptr %59, align 8
  %60 = load ptr, ptr %13, align 8
  %61 = load i32, ptr %17, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [1300 x double], ptr %60, i64 %62
  %64 = load i32, ptr %18, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [1300 x double], ptr %63, i64 0, i64 %65
  %67 = load double, ptr %66, align 8
  %68 = load ptr, ptr %15, align 8
  %69 = load i32, ptr %18, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds double, ptr %68, i64 %70
  %72 = load double, ptr %71, align 8
  %73 = load ptr, ptr %16, align 8
  %74 = load i32, ptr %17, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds double, ptr %73, i64 %75
  %77 = load double, ptr %76, align 8
  %78 = call double @llvm.fmuladd.f64(double %67, double %72, double %77)
  %79 = load ptr, ptr %16, align 8
  %80 = load i32, ptr %17, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds double, ptr %79, i64 %81
  store double %78, ptr %82, align 8
  br label %83

83:                                               ; preds = %36
  %84 = load i32, ptr %18, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, ptr %18, align 4
  br label %32, !llvm.loop !9

86:                                               ; preds = %32
  %87 = load double, ptr %10, align 8
  %88 = load ptr, ptr %14, align 8
  %89 = load i32, ptr %17, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds double, ptr %88, i64 %90
  %92 = load double, ptr %91, align 8
  %93 = load double, ptr %11, align 8
  %94 = load ptr, ptr %16, align 8
  %95 = load i32, ptr %17, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds double, ptr %94, i64 %96
  %98 = load double, ptr %97, align 8
  %99 = fmul double %93, %98
  %100 = call double @llvm.fmuladd.f64(double %87, double %92, double %99)
  %101 = load ptr, ptr %16, align 8
  %102 = load i32, ptr %17, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds double, ptr %101, i64 %103
  store double %100, ptr %104, align 8
  br label %105

105:                                              ; preds = %86
  %106 = load i32, ptr %17, align 4
  %107 = add nsw i32 %106, 1
  store i32 %107, ptr %17, align 4
  br label %19, !llvm.loop !10

108:                                              ; preds = %19
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
  br label %10, !llvm.loop !11

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
