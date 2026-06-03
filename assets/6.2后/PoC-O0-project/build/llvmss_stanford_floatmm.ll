; ModuleID = '/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/Stanford/FloatMM.c'
source_filename = "/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/Stanford/FloatMM.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.element = type { i32, i32 }
%struct.complex = type { float, float }

@seed = dso_local global i64 0, align 8
@rma = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@rmb = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@rmr = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1
@value = dso_local global float 0.000000e+00, align 4
@fixed = dso_local global float 0.000000e+00, align 4
@floated = dso_local global float 0.000000e+00, align 4
@permarray = dso_local global [11 x i32] zeroinitializer, align 16
@pctr = dso_local global i32 0, align 4
@tree = dso_local global ptr null, align 8
@stack = dso_local global [4 x i32] zeroinitializer, align 16
@cellspace = dso_local global [19 x %struct.element] zeroinitializer, align 16
@freelist = dso_local global i32 0, align 4
@movesdone = dso_local global i32 0, align 4
@ima = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@imb = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@imr = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@piececount = dso_local global [4 x i32] zeroinitializer, align 16
@class = dso_local global [13 x i32] zeroinitializer, align 16
@piecemax = dso_local global [13 x i32] zeroinitializer, align 16
@puzzl = dso_local global [512 x i32] zeroinitializer, align 16
@p = dso_local global [13 x [512 x i32]] zeroinitializer, align 16
@n = dso_local global i32 0, align 4
@kount = dso_local global i32 0, align 4
@sortlist = dso_local global [5001 x i32] zeroinitializer, align 16
@biggest = dso_local global i32 0, align 4
@littlest = dso_local global i32 0, align 4
@top = dso_local global i32 0, align 4
@z = dso_local global [257 x %struct.complex] zeroinitializer, align 16
@w = dso_local global [257 x %struct.complex] zeroinitializer, align 16
@e = dso_local global [130 x %struct.complex] zeroinitializer, align 16
@zr = dso_local global float 0.000000e+00, align 4
@zi = dso_local global float 0.000000e+00, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Initrand() #0 {
  store i64 74755, ptr @seed, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @Rand() #0 {
  %1 = load i64, ptr @seed, align 8
  %2 = mul nsw i64 %1, 1309
  %3 = add nsw i64 %2, 13849
  %4 = and i64 %3, 65535
  store i64 %4, ptr @seed, align 8
  %5 = load i64, ptr @seed, align 8
  %6 = trunc i64 %5 to i32
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rInitmatrix(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 1, ptr %4, align 4
  br label %6

6:                                                ; preds = %34, %1
  %7 = load i32, ptr %4, align 4
  %8 = icmp sle i32 %7, 40
  br i1 %8, label %9, label %37

9:                                                ; preds = %6
  store i32 1, ptr %5, align 4
  br label %10

10:                                               ; preds = %30, %9
  %11 = load i32, ptr %5, align 4
  %12 = icmp sle i32 %11, 40
  br i1 %12, label %13, label %33

13:                                               ; preds = %10
  %14 = call i32 @Rand()
  store i32 %14, ptr %3, align 4
  %15 = load i32, ptr %3, align 4
  %16 = load i32, ptr %3, align 4
  %17 = sdiv i32 %16, 120
  %18 = mul nsw i32 %17, 120
  %19 = sub nsw i32 %15, %18
  %20 = sub nsw i32 %19, 60
  %21 = sitofp i32 %20 to float
  %22 = fdiv float %21, 3.000000e+00
  %23 = load ptr, ptr %2, align 8
  %24 = load i32, ptr %4, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [41 x float], ptr %23, i64 %25
  %27 = load i32, ptr %5, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [41 x float], ptr %26, i64 0, i64 %28
  store float %22, ptr %29, align 4
  br label %30

30:                                               ; preds = %13
  %31 = load i32, ptr %5, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %5, align 4
  br label %10, !llvm.loop !6

33:                                               ; preds = %10
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %4, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %4, align 4
  br label %6, !llvm.loop !8

37:                                               ; preds = %6
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rInnerproduct(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  %12 = load ptr, ptr %6, align 8
  store float 0.000000e+00, ptr %12, align 4
  store i32 1, ptr %11, align 4
  br label %13

13:                                               ; preds = %37, %5
  %14 = load i32, ptr %11, align 4
  %15 = icmp sle i32 %14, 40
  br i1 %15, label %16, label %40

16:                                               ; preds = %13
  %17 = load ptr, ptr %6, align 8
  %18 = load float, ptr %17, align 4
  %19 = load ptr, ptr %7, align 8
  %20 = load i32, ptr %9, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [41 x float], ptr %19, i64 %21
  %23 = load i32, ptr %11, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [41 x float], ptr %22, i64 0, i64 %24
  %26 = load float, ptr %25, align 4
  %27 = load ptr, ptr %8, align 8
  %28 = load i32, ptr %11, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [41 x float], ptr %27, i64 %29
  %31 = load i32, ptr %10, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [41 x float], ptr %30, i64 0, i64 %32
  %34 = load float, ptr %33, align 4
  %35 = call float @llvm.fmuladd.f32(float %26, float %34, float %18)
  %36 = load ptr, ptr %6, align 8
  store float %35, ptr %36, align 4
  br label %37

37:                                               ; preds = %16
  %38 = load i32, ptr %11, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %11, align 4
  br label %13, !llvm.loop !9

40:                                               ; preds = %13
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Mm(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  call void @Initrand()
  call void @rInitmatrix(ptr noundef @rma)
  call void @rInitmatrix(ptr noundef @rmb)
  store i32 1, ptr %3, align 4
  br label %5

5:                                                ; preds = %25, %1
  %6 = load i32, ptr %3, align 4
  %7 = icmp sle i32 %6, 40
  br i1 %7, label %8, label %28

8:                                                ; preds = %5
  store i32 1, ptr %4, align 4
  br label %9

9:                                                ; preds = %21, %8
  %10 = load i32, ptr %4, align 4
  %11 = icmp sle i32 %10, 40
  br i1 %11, label %12, label %24

12:                                               ; preds = %9
  %13 = load i32, ptr %3, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [41 x [41 x float]], ptr @rmr, i64 0, i64 %14
  %16 = load i32, ptr %4, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [41 x float], ptr %15, i64 0, i64 %17
  %19 = load i32, ptr %3, align 4
  %20 = load i32, ptr %4, align 4
  call void @rInnerproduct(ptr noundef %18, ptr noundef @rma, ptr noundef @rmb, i32 noundef %19, i32 noundef %20)
  br label %21

21:                                               ; preds = %12
  %22 = load i32, ptr %4, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %4, align 4
  br label %9, !llvm.loop !10

24:                                               ; preds = %9
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %3, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %3, align 4
  br label %5, !llvm.loop !11

28:                                               ; preds = %5
  %29 = load i32, ptr %2, align 4
  %30 = icmp slt i32 %29, 40
  br i1 %30, label %31, label %43

31:                                               ; preds = %28
  %32 = load i32, ptr %2, align 4
  %33 = add nsw i32 %32, 1
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [41 x [41 x float]], ptr @rmr, i64 0, i64 %34
  %36 = load i32, ptr %2, align 4
  %37 = add nsw i32 %36, 1
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [41 x float], ptr %35, i64 0, i64 %38
  %40 = load float, ptr %39, align 4
  %41 = fpext float %40 to double
  %42 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %41)
  br label %43

43:                                               ; preds = %31, %28
  ret void
}

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @llvm_bench_main() #0 {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %2

2:                                                ; preds = %7, %0
  %3 = load i32, ptr %1, align 4
  %4 = icmp slt i32 %3, 5000
  br i1 %4, label %5, label %10

5:                                                ; preds = %2
  %6 = load i32, ptr %1, align 4
  call void @Mm(i32 noundef %6)
  br label %7

7:                                                ; preds = %5
  %8 = load i32, ptr %1, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, ptr %1, align 4
  br label %2, !llvm.loop !12

10:                                               ; preds = %2
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
