; ModuleID = '/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/BenchmarkGame/puzzle.c'
source_filename = "/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/BenchmarkGame/puzzle.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@next = internal global i64 1, align 8
@.str = private unnamed_addr constant [21 x i8] c"Found duplicate: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @rand() #0 {
  %1 = load i64, ptr @next, align 8
  %2 = mul i64 %1, 1103515245
  %3 = add i64 %2, 12345
  store i64 %3, ptr @next, align 8
  %4 = load i64, ptr @next, align 8
  %5 = udiv i64 %4, 65536
  %6 = trunc i64 %5 to i32
  %7 = urem i32 %6, 32767
  %8 = add i32 %7, 1
  ret i32 %8
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @srand(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = zext i32 %3 to i64
  store i64 %4, ptr @next, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @randInt(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %3, align 4
  %9 = sub nsw i32 %7, %8
  %10 = add nsw i32 %9, 1
  store i32 %10, ptr %6, align 4
  %11 = load i32, ptr %6, align 4
  %12 = sitofp i32 %11 to double
  %13 = call i32 @rand() #4
  %14 = sitofp i32 %13 to double
  %15 = fdiv double %14, 3.276800e+04
  %16 = fmul double %12, %15
  %17 = fptosi double %16 to i32
  store i32 %17, ptr %5, align 4
  %18 = load i32, ptr %5, align 4
  %19 = load i32, ptr %6, align 4
  %20 = icmp eq i32 %18, %19
  br i1 %20, label %21, label %26

21:                                               ; preds = %2
  %22 = load i32, ptr %5, align 4
  %23 = load i32, ptr %3, align 4
  %24 = add nsw i32 %22, %23
  %25 = sub nsw i32 %24, 1
  br label %30

26:                                               ; preds = %2
  %27 = load i32, ptr %5, align 4
  %28 = load i32, ptr %3, align 4
  %29 = add nsw i32 %27, %28
  br label %30

30:                                               ; preds = %26, %21
  %31 = phi i32 [ %25, %21 ], [ %29, %26 ]
  ret i32 %31
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @shuffle(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %9 = load i32, ptr %4, align 4
  %10 = sub nsw i32 %9, 1
  %11 = sext i32 %10 to i64
  store i64 %11, ptr %7, align 8
  br label %12

12:                                               ; preds = %51, %2
  %13 = load i64, ptr %7, align 8
  %14 = icmp ugt i64 %13, 0
  br i1 %14, label %15, label %54

15:                                               ; preds = %12
  %16 = load i64, ptr %7, align 8
  %17 = add i64 %16, 1
  %18 = uitofp i64 %17 to double
  %19 = call i32 @rand() #4
  %20 = sitofp i32 %19 to double
  %21 = fdiv double %20, 3.276800e+04
  %22 = fmul double %18, %21
  %23 = fptosi double %22 to i32
  %24 = sext i32 %23 to i64
  store i64 %24, ptr %6, align 8
  %25 = load i64, ptr %6, align 8
  %26 = load i64, ptr %7, align 8
  %27 = add i64 %26, 1
  %28 = icmp eq i64 %25, %27
  br i1 %28, label %29, label %32

29:                                               ; preds = %15
  %30 = load i64, ptr %6, align 8
  %31 = sub i64 %30, 1
  br label %34

32:                                               ; preds = %15
  %33 = load i64, ptr %6, align 8
  br label %34

34:                                               ; preds = %32, %29
  %35 = phi i64 [ %31, %29 ], [ %33, %32 ]
  store i64 %35, ptr %5, align 8
  %36 = load ptr, ptr %3, align 8
  %37 = load i64, ptr %7, align 8
  %38 = getelementptr inbounds i32, ptr %36, i64 %37
  %39 = load i32, ptr %38, align 4
  store i32 %39, ptr %8, align 4
  %40 = load ptr, ptr %3, align 8
  %41 = load i64, ptr %5, align 8
  %42 = getelementptr inbounds i32, ptr %40, i64 %41
  %43 = load i32, ptr %42, align 4
  %44 = load ptr, ptr %3, align 8
  %45 = load i64, ptr %7, align 8
  %46 = getelementptr inbounds i32, ptr %44, i64 %45
  store i32 %43, ptr %46, align 4
  %47 = load i32, ptr %8, align 4
  %48 = load ptr, ptr %3, align 8
  %49 = load i64, ptr %5, align 8
  %50 = getelementptr inbounds i32, ptr %48, i64 %49
  store i32 %47, ptr %50, align 4
  br label %51

51:                                               ; preds = %34
  %52 = load i64, ptr %7, align 8
  %53 = add i64 %52, -1
  store i64 %53, ptr %7, align 8
  br label %12, !llvm.loop !6

54:                                               ; preds = %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @createRandomArray(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4
  %6 = load i32, ptr %2, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, ptr %4, align 4
  %8 = load i32, ptr %4, align 4
  %9 = sext i32 %8 to i64
  %10 = mul i64 %9, 4
  %11 = call noalias ptr @malloc(i64 noundef %10) #5
  store ptr %11, ptr %5, align 8
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %22, %1
  %13 = load i32, ptr %3, align 4
  %14 = load i32, ptr %4, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %25

16:                                               ; preds = %12
  %17 = load i32, ptr %3, align 4
  %18 = load ptr, ptr %5, align 8
  %19 = load i32, ptr %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %18, i64 %20
  store i32 %17, ptr %21, align 4
  br label %22

22:                                               ; preds = %16
  %23 = load i32, ptr %3, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %3, align 4
  br label %12, !llvm.loop !8

25:                                               ; preds = %12
  %26 = load i32, ptr %2, align 4
  %27 = call i32 @randInt(i32 noundef 1, i32 noundef %26)
  %28 = load ptr, ptr %5, align 8
  %29 = getelementptr inbounds i32, ptr %28, i64 0
  store i32 %27, ptr %29, align 4
  %30 = load ptr, ptr %5, align 8
  %31 = load i32, ptr %4, align 4
  call void @shuffle(ptr noundef %30, i32 noundef %31)
  %32 = load ptr, ptr %5, align 8
  ret ptr %32
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @findDuplicate(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %6, align 4
  store i32 0, ptr %5, align 4
  br label %7

7:                                                ; preds = %22, %2
  %8 = load i32, ptr %5, align 4
  %9 = load i32, ptr %4, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %25

11:                                               ; preds = %7
  %12 = load i32, ptr %6, align 4
  %13 = load i32, ptr %5, align 4
  %14 = add nsw i32 %13, 1
  %15 = xor i32 %12, %14
  %16 = load ptr, ptr %3, align 8
  %17 = load i32, ptr %5, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i32, ptr %16, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = xor i32 %15, %20
  store i32 %21, ptr %6, align 4
  br label %22

22:                                               ; preds = %11
  %23 = load i32, ptr %5, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %5, align 4
  br label %7, !llvm.loop !9

25:                                               ; preds = %7
  %26 = load i32, ptr %4, align 4
  %27 = load i32, ptr %6, align 4
  %28 = xor i32 %27, %26
  store i32 %28, ptr %6, align 4
  %29 = load i32, ptr %6, align 4
  ret i32 %29
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @llvm_bench_main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  call void @srand(i32 noundef 1) #4
  store i32 0, ptr %1, align 4
  br label %5

5:                                                ; preds = %23, %0
  %6 = load i32, ptr %1, align 4
  %7 = icmp slt i32 %6, 5
  br i1 %7, label %8, label %26

8:                                                ; preds = %5
  %9 = call ptr @createRandomArray(i32 noundef 500000)
  store ptr %9, ptr %4, align 8
  store i32 0, ptr %2, align 4
  br label %10

10:                                               ; preds = %16, %8
  %11 = load i32, ptr %2, align 4
  %12 = icmp slt i32 %11, 200
  br i1 %12, label %13, label %19

13:                                               ; preds = %10
  %14 = load ptr, ptr %4, align 8
  %15 = call i32 @findDuplicate(ptr noundef %14, i32 noundef 500001)
  store i32 %15, ptr %3, align 4
  br label %16

16:                                               ; preds = %13
  %17 = load i32, ptr %2, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr %2, align 4
  br label %10, !llvm.loop !10

19:                                               ; preds = %10
  %20 = load ptr, ptr %4, align 8
  call void @free(ptr noundef %20) #4
  %21 = load i32, ptr %3, align 4
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %21)
  br label %23

23:                                               ; preds = %19
  %24 = load i32, ptr %1, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr %1, align 4
  br label %5, !llvm.loop !11

26:                                               ; preds = %5
  ret i32 0
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #2

declare i32 @printf(ptr noundef, ...) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }
attributes #5 = { nounwind allocsize(0) }

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
