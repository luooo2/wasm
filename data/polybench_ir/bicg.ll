; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/kernels/bicg/bicg.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/kernels/bicg/bicg.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"s\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"q\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

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
  %12 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 2100, ptr %6, align 4
  store i32 1900, ptr %7, align 4
  %13 = call ptr @polybench_alloc_data(i64 noundef 3990000, i32 noundef 8)
  store ptr %13, ptr %8, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 1900, i32 noundef 8)
  store ptr %14, ptr %9, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 2100, i32 noundef 8)
  store ptr %15, ptr %10, align 8
  %16 = call ptr @polybench_alloc_data(i64 noundef 1900, i32 noundef 8)
  store ptr %16, ptr %11, align 8
  %17 = call ptr @polybench_alloc_data(i64 noundef 2100, i32 noundef 8)
  store ptr %17, ptr %12, align 8
  %18 = load i32, ptr %7, align 4
  %19 = load i32, ptr %6, align 4
  %20 = load ptr, ptr %8, align 8
  %21 = getelementptr inbounds [2100 x [1900 x double]], ptr %20, i64 0, i64 0
  %22 = load ptr, ptr %12, align 8
  %23 = getelementptr inbounds [2100 x double], ptr %22, i64 0, i64 0
  %24 = load ptr, ptr %11, align 8
  %25 = getelementptr inbounds [1900 x double], ptr %24, i64 0, i64 0
  call void @init_array(i32 noundef %18, i32 noundef %19, ptr noundef %21, ptr noundef %23, ptr noundef %25)
  %26 = load i32, ptr %7, align 4
  %27 = load i32, ptr %6, align 4
  %28 = load ptr, ptr %8, align 8
  %29 = getelementptr inbounds [2100 x [1900 x double]], ptr %28, i64 0, i64 0
  %30 = load ptr, ptr %9, align 8
  %31 = getelementptr inbounds [1900 x double], ptr %30, i64 0, i64 0
  %32 = load ptr, ptr %10, align 8
  %33 = getelementptr inbounds [2100 x double], ptr %32, i64 0, i64 0
  %34 = load ptr, ptr %11, align 8
  %35 = getelementptr inbounds [1900 x double], ptr %34, i64 0, i64 0
  %36 = load ptr, ptr %12, align 8
  %37 = getelementptr inbounds [2100 x double], ptr %36, i64 0, i64 0
  call void @kernel_bicg(i32 noundef %26, i32 noundef %27, ptr noundef %29, ptr noundef %31, ptr noundef %33, ptr noundef %35, ptr noundef %37)
  %38 = load i32, ptr %4, align 4
  %39 = icmp sgt i32 %38, 42
  br i1 %39, label %40, label %53

40:                                               ; preds = %2
  %41 = load ptr, ptr %5, align 8
  %42 = getelementptr inbounds ptr, ptr %41, i64 0
  %43 = load ptr, ptr %42, align 8
  %44 = call i32 @strcmp(ptr noundef %43, ptr noundef @.str) #5
  %45 = icmp ne i32 %44, 0
  br i1 %45, label %53, label %46

46:                                               ; preds = %40
  %47 = load i32, ptr %7, align 4
  %48 = load i32, ptr %6, align 4
  %49 = load ptr, ptr %9, align 8
  %50 = getelementptr inbounds [1900 x double], ptr %49, i64 0, i64 0
  %51 = load ptr, ptr %10, align 8
  %52 = getelementptr inbounds [2100 x double], ptr %51, i64 0, i64 0
  call void @print_array(i32 noundef %47, i32 noundef %48, ptr noundef %50, ptr noundef %52)
  br label %53

53:                                               ; preds = %46, %40, %2
  %54 = load ptr, ptr %8, align 8
  call void @free(ptr noundef %54) #6
  %55 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %55) #6
  %56 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %56) #6
  %57 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %57) #6
  %58 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %58) #6
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
  store i32 0, ptr %11, align 4
  br label %13

13:                                               ; preds = %29, %5
  %14 = load i32, ptr %11, align 4
  %15 = load i32, ptr %6, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %32

17:                                               ; preds = %13
  %18 = load i32, ptr %11, align 4
  %19 = load i32, ptr %6, align 4
  %20 = srem i32 %18, %19
  %21 = sitofp i32 %20 to double
  %22 = load i32, ptr %6, align 4
  %23 = sitofp i32 %22 to double
  %24 = fdiv double %21, %23
  %25 = load ptr, ptr %10, align 8
  %26 = load i32, ptr %11, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds double, ptr %25, i64 %27
  store double %24, ptr %28, align 8
  br label %29

29:                                               ; preds = %17
  %30 = load i32, ptr %11, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %11, align 4
  br label %13, !llvm.loop !6

32:                                               ; preds = %13
  store i32 0, ptr %11, align 4
  br label %33

33:                                               ; preds = %75, %32
  %34 = load i32, ptr %11, align 4
  %35 = load i32, ptr %7, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %78

37:                                               ; preds = %33
  %38 = load i32, ptr %11, align 4
  %39 = load i32, ptr %7, align 4
  %40 = srem i32 %38, %39
  %41 = sitofp i32 %40 to double
  %42 = load i32, ptr %7, align 4
  %43 = sitofp i32 %42 to double
  %44 = fdiv double %41, %43
  %45 = load ptr, ptr %9, align 8
  %46 = load i32, ptr %11, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds double, ptr %45, i64 %47
  store double %44, ptr %48, align 8
  store i32 0, ptr %12, align 4
  br label %49

49:                                               ; preds = %71, %37
  %50 = load i32, ptr %12, align 4
  %51 = load i32, ptr %6, align 4
  %52 = icmp slt i32 %50, %51
  br i1 %52, label %53, label %74

53:                                               ; preds = %49
  %54 = load i32, ptr %11, align 4
  %55 = load i32, ptr %12, align 4
  %56 = add nsw i32 %55, 1
  %57 = mul nsw i32 %54, %56
  %58 = load i32, ptr %7, align 4
  %59 = srem i32 %57, %58
  %60 = sitofp i32 %59 to double
  %61 = load i32, ptr %7, align 4
  %62 = sitofp i32 %61 to double
  %63 = fdiv double %60, %62
  %64 = load ptr, ptr %8, align 8
  %65 = load i32, ptr %11, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [1900 x double], ptr %64, i64 %66
  %68 = load i32, ptr %12, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds [1900 x double], ptr %67, i64 0, i64 %69
  store double %63, ptr %70, align 8
  br label %71

71:                                               ; preds = %53
  %72 = load i32, ptr %12, align 4
  %73 = add nsw i32 %72, 1
  store i32 %73, ptr %12, align 4
  br label %49, !llvm.loop !8

74:                                               ; preds = %49
  br label %75

75:                                               ; preds = %74
  %76 = load i32, ptr %11, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, ptr %11, align 4
  br label %33, !llvm.loop !9

78:                                               ; preds = %33
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_bicg(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6) #0 {
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
  store i32 0, ptr %15, align 4
  br label %17

17:                                               ; preds = %26, %7
  %18 = load i32, ptr %15, align 4
  %19 = load i32, ptr %8, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %29

21:                                               ; preds = %17
  %22 = load ptr, ptr %11, align 8
  %23 = load i32, ptr %15, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds double, ptr %22, i64 %24
  store double 0.000000e+00, ptr %25, align 8
  br label %26

26:                                               ; preds = %21
  %27 = load i32, ptr %15, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %15, align 4
  br label %17, !llvm.loop !10

29:                                               ; preds = %17
  store i32 0, ptr %15, align 4
  br label %30

30:                                               ; preds = %94, %29
  %31 = load i32, ptr %15, align 4
  %32 = load i32, ptr %9, align 4
  %33 = icmp slt i32 %31, %32
  br i1 %33, label %34, label %97

34:                                               ; preds = %30
  %35 = load ptr, ptr %12, align 8
  %36 = load i32, ptr %15, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds double, ptr %35, i64 %37
  store double 0.000000e+00, ptr %38, align 8
  store i32 0, ptr %16, align 4
  br label %39

39:                                               ; preds = %90, %34
  %40 = load i32, ptr %16, align 4
  %41 = load i32, ptr %8, align 4
  %42 = icmp slt i32 %40, %41
  br i1 %42, label %43, label %93

43:                                               ; preds = %39
  %44 = load ptr, ptr %11, align 8
  %45 = load i32, ptr %16, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds double, ptr %44, i64 %46
  %48 = load double, ptr %47, align 8
  %49 = load ptr, ptr %14, align 8
  %50 = load i32, ptr %15, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds double, ptr %49, i64 %51
  %53 = load double, ptr %52, align 8
  %54 = load ptr, ptr %10, align 8
  %55 = load i32, ptr %15, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [1900 x double], ptr %54, i64 %56
  %58 = load i32, ptr %16, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [1900 x double], ptr %57, i64 0, i64 %59
  %61 = load double, ptr %60, align 8
  %62 = call double @llvm.fmuladd.f64(double %53, double %61, double %48)
  %63 = load ptr, ptr %11, align 8
  %64 = load i32, ptr %16, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds double, ptr %63, i64 %65
  store double %62, ptr %66, align 8
  %67 = load ptr, ptr %12, align 8
  %68 = load i32, ptr %15, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds double, ptr %67, i64 %69
  %71 = load double, ptr %70, align 8
  %72 = load ptr, ptr %10, align 8
  %73 = load i32, ptr %15, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [1900 x double], ptr %72, i64 %74
  %76 = load i32, ptr %16, align 4
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds [1900 x double], ptr %75, i64 0, i64 %77
  %79 = load double, ptr %78, align 8
  %80 = load ptr, ptr %13, align 8
  %81 = load i32, ptr %16, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds double, ptr %80, i64 %82
  %84 = load double, ptr %83, align 8
  %85 = call double @llvm.fmuladd.f64(double %79, double %84, double %71)
  %86 = load ptr, ptr %12, align 8
  %87 = load i32, ptr %15, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds double, ptr %86, i64 %88
  store double %85, ptr %89, align 8
  br label %90

90:                                               ; preds = %43
  %91 = load i32, ptr %16, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, ptr %16, align 4
  br label %39, !llvm.loop !11

93:                                               ; preds = %39
  br label %94

94:                                               ; preds = %93
  %95 = load i32, ptr %15, align 4
  %96 = add nsw i32 %95, 1
  store i32 %96, ptr %15, align 4
  br label %30, !llvm.loop !12

97:                                               ; preds = %30
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store ptr %2, ptr %7, align 8
  store ptr %3, ptr %8, align 8
  %10 = load ptr, ptr @stderr, align 8
  %11 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %10, ptr noundef @.str.1)
  %12 = load ptr, ptr @stderr, align 8
  %13 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %12, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %9, align 4
  br label %14

14:                                               ; preds = %33, %4
  %15 = load i32, ptr %9, align 4
  %16 = load i32, ptr %5, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %36

18:                                               ; preds = %14
  %19 = load i32, ptr %9, align 4
  %20 = srem i32 %19, 20
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %25

22:                                               ; preds = %18
  %23 = load ptr, ptr @stderr, align 8
  %24 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %23, ptr noundef @.str.4)
  br label %25

25:                                               ; preds = %22, %18
  %26 = load ptr, ptr @stderr, align 8
  %27 = load ptr, ptr %7, align 8
  %28 = load i32, ptr %9, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds double, ptr %27, i64 %29
  %31 = load double, ptr %30, align 8
  %32 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %26, ptr noundef @.str.5, double noundef %31)
  br label %33

33:                                               ; preds = %25
  %34 = load i32, ptr %9, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %9, align 4
  br label %14, !llvm.loop !13

36:                                               ; preds = %14
  %37 = load ptr, ptr @stderr, align 8
  %38 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %37, ptr noundef @.str.6, ptr noundef @.str.3)
  %39 = load ptr, ptr @stderr, align 8
  %40 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %39, ptr noundef @.str.2, ptr noundef @.str.7)
  store i32 0, ptr %9, align 4
  br label %41

41:                                               ; preds = %60, %36
  %42 = load i32, ptr %9, align 4
  %43 = load i32, ptr %6, align 4
  %44 = icmp slt i32 %42, %43
  br i1 %44, label %45, label %63

45:                                               ; preds = %41
  %46 = load i32, ptr %9, align 4
  %47 = srem i32 %46, 20
  %48 = icmp eq i32 %47, 0
  br i1 %48, label %49, label %52

49:                                               ; preds = %45
  %50 = load ptr, ptr @stderr, align 8
  %51 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %50, ptr noundef @.str.4)
  br label %52

52:                                               ; preds = %49, %45
  %53 = load ptr, ptr @stderr, align 8
  %54 = load ptr, ptr %8, align 8
  %55 = load i32, ptr %9, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds double, ptr %54, i64 %56
  %58 = load double, ptr %57, align 8
  %59 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %53, ptr noundef @.str.5, double noundef %58)
  br label %60

60:                                               ; preds = %52
  %61 = load i32, ptr %9, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, ptr %9, align 4
  br label %41, !llvm.loop !14

63:                                               ; preds = %41
  %64 = load ptr, ptr @stderr, align 8
  %65 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %64, ptr noundef @.str.6, ptr noundef @.str.7)
  %66 = load ptr, ptr @stderr, align 8
  %67 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %66, ptr noundef @.str.8)
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
