; ModuleID = '/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/Misc/richards_benchmark.c'
source_filename = "/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/Misc/richards_benchmark.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.task = type { ptr, i32, i32, ptr, i32, ptr, i64, i64 }
%struct.packet = type { ptr, i32, i32, i32, [4 x i8] }

@alphabet = dso_local global [28 x i8] c"0ABCDEFGHIJKLMNOPQRSTUVWXYZ\00", align 16
@tasktab = dso_local global [11 x ptr] zeroinitializer, align 16
@tasklist = dso_local global ptr null, align 8
@qpktcount = dso_local global i32 0, align 4
@holdcount = dso_local global i32 0, align 4
@tracing = dso_local global i32 1, align 4
@layout = dso_local global i32 0, align 4
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@tcb = dso_local global ptr null, align 8
@taskid = dso_local global i64 0, align 8
@v1 = dso_local global i64 0, align 8
@v2 = dso_local global i64 0, align 8
@.str.2 = private unnamed_addr constant [17 x i8] c"\0ABad task id %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [21 x i8] c"Bench mark starting\0A\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"Starting\0A\00", align 1
@.str.5 = private unnamed_addr constant [10 x i8] c"finished\0A\00", align 1
@.str.6 = private unnamed_addr constant [33 x i8] c"qpkt count = %d  holdcount = %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [19 x i8] c"These results are \00", align 1
@.str.8 = private unnamed_addr constant [8 x i8] c"correct\00", align 1
@.str.9 = private unnamed_addr constant [10 x i8] c"incorrect\00", align 1
@.str.10 = private unnamed_addr constant [13 x i8] c"\0Aend of run\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @createtask(i32 noundef %0, i32 noundef %1, ptr noundef %2, i32 noundef %3, ptr noundef %4, i64 noundef %5, i64 noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  %15 = alloca ptr, align 8
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store ptr %2, ptr %10, align 8
  store i32 %3, ptr %11, align 4
  store ptr %4, ptr %12, align 8
  store i64 %5, ptr %13, align 8
  store i64 %6, ptr %14, align 8
  %16 = call noalias ptr @malloc(i64 noundef 56) #3
  store ptr %16, ptr %15, align 8
  %17 = load ptr, ptr %15, align 8
  %18 = load i32, ptr %8, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [11 x ptr], ptr @tasktab, i64 0, i64 %19
  store ptr %17, ptr %20, align 8
  %21 = load ptr, ptr @tasklist, align 8
  %22 = load ptr, ptr %15, align 8
  %23 = getelementptr inbounds %struct.task, ptr %22, i32 0, i32 0
  store ptr %21, ptr %23, align 8
  %24 = load i32, ptr %8, align 4
  %25 = load ptr, ptr %15, align 8
  %26 = getelementptr inbounds %struct.task, ptr %25, i32 0, i32 1
  store i32 %24, ptr %26, align 8
  %27 = load i32, ptr %9, align 4
  %28 = load ptr, ptr %15, align 8
  %29 = getelementptr inbounds %struct.task, ptr %28, i32 0, i32 2
  store i32 %27, ptr %29, align 4
  %30 = load ptr, ptr %10, align 8
  %31 = load ptr, ptr %15, align 8
  %32 = getelementptr inbounds %struct.task, ptr %31, i32 0, i32 3
  store ptr %30, ptr %32, align 8
  %33 = load i32, ptr %11, align 4
  %34 = load ptr, ptr %15, align 8
  %35 = getelementptr inbounds %struct.task, ptr %34, i32 0, i32 4
  store i32 %33, ptr %35, align 8
  %36 = load ptr, ptr %12, align 8
  %37 = load ptr, ptr %15, align 8
  %38 = getelementptr inbounds %struct.task, ptr %37, i32 0, i32 5
  store ptr %36, ptr %38, align 8
  %39 = load i64, ptr %13, align 8
  %40 = load ptr, ptr %15, align 8
  %41 = getelementptr inbounds %struct.task, ptr %40, i32 0, i32 6
  store i64 %39, ptr %41, align 8
  %42 = load i64, ptr %14, align 8
  %43 = load ptr, ptr %15, align 8
  %44 = getelementptr inbounds %struct.task, ptr %43, i32 0, i32 7
  store i64 %42, ptr %44, align 8
  %45 = load ptr, ptr %15, align 8
  store ptr %45, ptr @tasklist, align 8
  ret void
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @pkt(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %9 = call noalias ptr @malloc(i64 noundef 24) #3
  store ptr %9, ptr %8, align 8
  store i32 0, ptr %7, align 4
  br label %10

10:                                               ; preds = %19, %3
  %11 = load i32, ptr %7, align 4
  %12 = icmp sle i32 %11, 3
  br i1 %12, label %13, label %22

13:                                               ; preds = %10
  %14 = load ptr, ptr %8, align 8
  %15 = getelementptr inbounds %struct.packet, ptr %14, i32 0, i32 4
  %16 = load i32, ptr %7, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [4 x i8], ptr %15, i64 0, i64 %17
  store i8 0, ptr %18, align 1
  br label %19

19:                                               ; preds = %13
  %20 = load i32, ptr %7, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %7, align 4
  br label %10, !llvm.loop !6

22:                                               ; preds = %10
  %23 = load ptr, ptr %4, align 8
  %24 = load ptr, ptr %8, align 8
  %25 = getelementptr inbounds %struct.packet, ptr %24, i32 0, i32 0
  store ptr %23, ptr %25, align 8
  %26 = load i32, ptr %5, align 4
  %27 = load ptr, ptr %8, align 8
  %28 = getelementptr inbounds %struct.packet, ptr %27, i32 0, i32 1
  store i32 %26, ptr %28, align 8
  %29 = load i32, ptr %6, align 4
  %30 = load ptr, ptr %8, align 8
  %31 = getelementptr inbounds %struct.packet, ptr %30, i32 0, i32 2
  store i32 %29, ptr %31, align 4
  %32 = load ptr, ptr %8, align 8
  %33 = getelementptr inbounds %struct.packet, ptr %32, i32 0, i32 3
  store i32 0, ptr %33, align 8
  %34 = load ptr, ptr %8, align 8
  ret ptr %34
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @trace(i8 noundef signext %0) #0 {
  %2 = alloca i8, align 1
  store i8 %0, ptr %2, align 1
  %3 = load i32, ptr @layout, align 4
  %4 = add nsw i32 %3, -1
  store i32 %4, ptr @layout, align 4
  %5 = icmp sle i32 %4, 0
  br i1 %5, label %6, label %8

6:                                                ; preds = %1
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 50, ptr @layout, align 4
  br label %8

8:                                                ; preds = %6, %1
  %9 = load i8, ptr %2, align 1
  %10 = sext i8 %9 to i32
  %11 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %10)
  ret void
}

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @schedule() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  br label %3

3:                                                ; preds = %62, %0
  %4 = load ptr, ptr @tcb, align 8
  %5 = icmp ne ptr %4, null
  br i1 %5, label %6, label %63

6:                                                ; preds = %3
  store ptr null, ptr %1, align 8
  %7 = load ptr, ptr @tcb, align 8
  %8 = getelementptr inbounds %struct.task, ptr %7, i32 0, i32 4
  %9 = load i32, ptr %8, align 8
  switch i32 %9, label %61 [
    i32 3, label %10
    i32 0, label %27
    i32 1, label %27
    i32 2, label %57
    i32 4, label %57
    i32 5, label %57
    i32 6, label %57
    i32 7, label %57
  ]

10:                                               ; preds = %6
  %11 = load ptr, ptr @tcb, align 8
  %12 = getelementptr inbounds %struct.task, ptr %11, i32 0, i32 3
  %13 = load ptr, ptr %12, align 8
  store ptr %13, ptr %1, align 8
  %14 = load ptr, ptr %1, align 8
  %15 = getelementptr inbounds %struct.packet, ptr %14, i32 0, i32 0
  %16 = load ptr, ptr %15, align 8
  %17 = load ptr, ptr @tcb, align 8
  %18 = getelementptr inbounds %struct.task, ptr %17, i32 0, i32 3
  store ptr %16, ptr %18, align 8
  %19 = load ptr, ptr @tcb, align 8
  %20 = getelementptr inbounds %struct.task, ptr %19, i32 0, i32 3
  %21 = load ptr, ptr %20, align 8
  %22 = icmp eq ptr %21, null
  %23 = zext i1 %22 to i64
  %24 = select i1 %22, i32 0, i32 1
  %25 = load ptr, ptr @tcb, align 8
  %26 = getelementptr inbounds %struct.task, ptr %25, i32 0, i32 4
  store i32 %24, ptr %26, align 8
  br label %27

27:                                               ; preds = %6, %6, %10
  %28 = load ptr, ptr @tcb, align 8
  %29 = getelementptr inbounds %struct.task, ptr %28, i32 0, i32 1
  %30 = load i32, ptr %29, align 8
  %31 = sext i32 %30 to i64
  store i64 %31, ptr @taskid, align 8
  %32 = load ptr, ptr @tcb, align 8
  %33 = getelementptr inbounds %struct.task, ptr %32, i32 0, i32 6
  %34 = load i64, ptr %33, align 8
  store i64 %34, ptr @v1, align 8
  %35 = load ptr, ptr @tcb, align 8
  %36 = getelementptr inbounds %struct.task, ptr %35, i32 0, i32 7
  %37 = load i64, ptr %36, align 8
  store i64 %37, ptr @v2, align 8
  %38 = load i32, ptr @tracing, align 4
  %39 = icmp eq i32 %38, 1
  br i1 %39, label %40, label %44

40:                                               ; preds = %27
  %41 = load i64, ptr @taskid, align 8
  %42 = add nsw i64 %41, 48
  %43 = trunc i64 %42 to i8
  call void @trace(i8 noundef signext %43)
  br label %44

44:                                               ; preds = %40, %27
  %45 = load ptr, ptr @tcb, align 8
  %46 = getelementptr inbounds %struct.task, ptr %45, i32 0, i32 5
  %47 = load ptr, ptr %46, align 8
  %48 = load ptr, ptr %1, align 8
  %49 = call ptr %47(ptr noundef %48)
  store ptr %49, ptr %2, align 8
  %50 = load i64, ptr @v1, align 8
  %51 = load ptr, ptr @tcb, align 8
  %52 = getelementptr inbounds %struct.task, ptr %51, i32 0, i32 6
  store i64 %50, ptr %52, align 8
  %53 = load i64, ptr @v2, align 8
  %54 = load ptr, ptr @tcb, align 8
  %55 = getelementptr inbounds %struct.task, ptr %54, i32 0, i32 7
  store i64 %53, ptr %55, align 8
  %56 = load ptr, ptr %2, align 8
  store ptr %56, ptr @tcb, align 8
  br label %62

57:                                               ; preds = %6, %6, %6, %6, %6
  %58 = load ptr, ptr @tcb, align 8
  %59 = getelementptr inbounds %struct.task, ptr %58, i32 0, i32 0
  %60 = load ptr, ptr %59, align 8
  store ptr %60, ptr @tcb, align 8
  br label %62

61:                                               ; preds = %6
  br label %63

62:                                               ; preds = %57, %44
  br label %3, !llvm.loop !8

63:                                               ; preds = %61, %3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @Wait() #0 {
  %1 = load ptr, ptr @tcb, align 8
  %2 = getelementptr inbounds %struct.task, ptr %1, i32 0, i32 4
  %3 = load i32, ptr %2, align 8
  %4 = or i32 %3, 2
  store i32 %4, ptr %2, align 8
  %5 = load ptr, ptr @tcb, align 8
  ret ptr %5
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @holdself() #0 {
  %1 = load i32, ptr @holdcount, align 4
  %2 = add nsw i32 %1, 1
  store i32 %2, ptr @holdcount, align 4
  %3 = load ptr, ptr @tcb, align 8
  %4 = getelementptr inbounds %struct.task, ptr %3, i32 0, i32 4
  %5 = load i32, ptr %4, align 8
  %6 = or i32 %5, 4
  store i32 %6, ptr %4, align 8
  %7 = load ptr, ptr @tcb, align 8
  %8 = getelementptr inbounds %struct.task, ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %8, align 8
  ret ptr %9
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @findtcb(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4
  store ptr null, ptr %3, align 8
  %4 = load i32, ptr %2, align 4
  %5 = icmp sle i32 1, %4
  br i1 %5, label %6, label %15

6:                                                ; preds = %1
  %7 = load i32, ptr %2, align 4
  %8 = sext i32 %7 to i64
  %9 = icmp sle i64 %8, 10
  br i1 %9, label %10, label %15

10:                                               ; preds = %6
  %11 = load i32, ptr %2, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [11 x ptr], ptr @tasktab, i64 0, i64 %12
  %14 = load ptr, ptr %13, align 8
  store ptr %14, ptr %3, align 8
  br label %15

15:                                               ; preds = %10, %6, %1
  %16 = load ptr, ptr %3, align 8
  %17 = icmp eq ptr %16, null
  br i1 %17, label %18, label %21

18:                                               ; preds = %15
  %19 = load i32, ptr %2, align 4
  %20 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %19)
  br label %21

21:                                               ; preds = %18, %15
  %22 = load ptr, ptr %3, align 8
  ret ptr %22
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @release(i32 noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  store i32 %0, ptr %3, align 4
  %5 = load i32, ptr %3, align 4
  %6 = call ptr @findtcb(i32 noundef %5)
  store ptr %6, ptr %4, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = icmp eq ptr %7, null
  br i1 %8, label %9, label %10

9:                                                ; preds = %1
  store ptr null, ptr %2, align 8
  br label %26

10:                                               ; preds = %1
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds %struct.task, ptr %11, i32 0, i32 4
  %13 = load i32, ptr %12, align 8
  %14 = and i32 %13, 65531
  store i32 %14, ptr %12, align 8
  %15 = load ptr, ptr %4, align 8
  %16 = getelementptr inbounds %struct.task, ptr %15, i32 0, i32 2
  %17 = load i32, ptr %16, align 4
  %18 = load ptr, ptr @tcb, align 8
  %19 = getelementptr inbounds %struct.task, ptr %18, i32 0, i32 2
  %20 = load i32, ptr %19, align 4
  %21 = icmp sgt i32 %17, %20
  br i1 %21, label %22, label %24

22:                                               ; preds = %10
  %23 = load ptr, ptr %4, align 8
  store ptr %23, ptr %2, align 8
  br label %26

24:                                               ; preds = %10
  %25 = load ptr, ptr @tcb, align 8
  store ptr %25, ptr %2, align 8
  br label %26

26:                                               ; preds = %24, %22, %9
  %27 = load ptr, ptr %2, align 8
  ret ptr %27
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @qpkt(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %struct.packet, ptr %5, i32 0, i32 1
  %7 = load i32, ptr %6, align 8
  %8 = call ptr @findtcb(i32 noundef %7)
  store ptr %8, ptr %4, align 8
  %9 = load ptr, ptr %4, align 8
  %10 = icmp eq ptr %9, null
  br i1 %10, label %11, label %13

11:                                               ; preds = %1
  %12 = load ptr, ptr %4, align 8
  store ptr %12, ptr %2, align 8
  br label %50

13:                                               ; preds = %1
  %14 = load i32, ptr @qpktcount, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr @qpktcount, align 4
  %16 = load ptr, ptr %3, align 8
  %17 = getelementptr inbounds %struct.packet, ptr %16, i32 0, i32 0
  store ptr null, ptr %17, align 8
  %18 = load i64, ptr @taskid, align 8
  %19 = trunc i64 %18 to i32
  %20 = load ptr, ptr %3, align 8
  %21 = getelementptr inbounds %struct.packet, ptr %20, i32 0, i32 1
  store i32 %19, ptr %21, align 8
  %22 = load ptr, ptr %4, align 8
  %23 = getelementptr inbounds %struct.task, ptr %22, i32 0, i32 3
  %24 = load ptr, ptr %23, align 8
  %25 = icmp eq ptr %24, null
  br i1 %25, label %26, label %44

26:                                               ; preds = %13
  %27 = load ptr, ptr %3, align 8
  %28 = load ptr, ptr %4, align 8
  %29 = getelementptr inbounds %struct.task, ptr %28, i32 0, i32 3
  store ptr %27, ptr %29, align 8
  %30 = load ptr, ptr %4, align 8
  %31 = getelementptr inbounds %struct.task, ptr %30, i32 0, i32 4
  %32 = load i32, ptr %31, align 8
  %33 = or i32 %32, 1
  store i32 %33, ptr %31, align 8
  %34 = load ptr, ptr %4, align 8
  %35 = getelementptr inbounds %struct.task, ptr %34, i32 0, i32 2
  %36 = load i32, ptr %35, align 4
  %37 = load ptr, ptr @tcb, align 8
  %38 = getelementptr inbounds %struct.task, ptr %37, i32 0, i32 2
  %39 = load i32, ptr %38, align 4
  %40 = icmp sgt i32 %36, %39
  br i1 %40, label %41, label %43

41:                                               ; preds = %26
  %42 = load ptr, ptr %4, align 8
  store ptr %42, ptr %2, align 8
  br label %50

43:                                               ; preds = %26
  br label %48

44:                                               ; preds = %13
  %45 = load ptr, ptr %3, align 8
  %46 = load ptr, ptr %4, align 8
  %47 = getelementptr inbounds %struct.task, ptr %46, i32 0, i32 3
  call void @append(ptr noundef %45, ptr noundef %47)
  br label %48

48:                                               ; preds = %44, %43
  %49 = load ptr, ptr @tcb, align 8
  store ptr %49, ptr %2, align 8
  br label %50

50:                                               ; preds = %48, %41, %11
  %51 = load ptr, ptr %2, align 8
  ret ptr %51
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @append(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %struct.packet, ptr %5, i32 0, i32 0
  store ptr null, ptr %6, align 8
  br label %7

7:                                                ; preds = %12, %2
  %8 = load ptr, ptr %4, align 8
  %9 = getelementptr inbounds %struct.packet, ptr %8, i32 0, i32 0
  %10 = load ptr, ptr %9, align 8
  %11 = icmp ne ptr %10, null
  br i1 %11, label %12, label %16

12:                                               ; preds = %7
  %13 = load ptr, ptr %4, align 8
  %14 = getelementptr inbounds %struct.packet, ptr %13, i32 0, i32 0
  %15 = load ptr, ptr %14, align 8
  store ptr %15, ptr %4, align 8
  br label %7, !llvm.loop !9

16:                                               ; preds = %7
  %17 = load ptr, ptr %3, align 8
  %18 = load ptr, ptr %4, align 8
  %19 = getelementptr inbounds %struct.packet, ptr %18, i32 0, i32 0
  store ptr %17, ptr %19, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @idlefn(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load i64, ptr @v2, align 8
  %5 = add nsw i64 %4, -1
  store i64 %5, ptr @v2, align 8
  %6 = load i64, ptr @v2, align 8
  %7 = icmp eq i64 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %1
  %9 = call ptr @holdself()
  store ptr %9, ptr %2, align 8
  br label %25

10:                                               ; preds = %1
  %11 = load i64, ptr @v1, align 8
  %12 = and i64 %11, 1
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %14, label %19

14:                                               ; preds = %10
  %15 = load i64, ptr @v1, align 8
  %16 = ashr i64 %15, 1
  %17 = and i64 %16, 32767
  store i64 %17, ptr @v1, align 8
  %18 = call ptr @release(i32 noundef 5)
  store ptr %18, ptr %2, align 8
  br label %25

19:                                               ; preds = %10
  %20 = load i64, ptr @v1, align 8
  %21 = ashr i64 %20, 1
  %22 = and i64 %21, 32767
  %23 = xor i64 %22, 53256
  store i64 %23, ptr @v1, align 8
  %24 = call ptr @release(i32 noundef 6)
  store ptr %24, ptr %2, align 8
  br label %25

25:                                               ; preds = %19, %14, %8
  %26 = load ptr, ptr %2, align 8
  ret ptr %26
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @workfn(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %9

7:                                                ; preds = %1
  %8 = call ptr @Wait()
  store ptr %8, ptr %2, align 8
  br label %42

9:                                                ; preds = %1
  %10 = load i64, ptr @v1, align 8
  %11 = sub nsw i64 7, %10
  store i64 %11, ptr @v1, align 8
  %12 = load i64, ptr @v1, align 8
  %13 = trunc i64 %12 to i32
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %struct.packet, ptr %14, i32 0, i32 1
  store i32 %13, ptr %15, align 8
  %16 = load ptr, ptr %3, align 8
  %17 = getelementptr inbounds %struct.packet, ptr %16, i32 0, i32 3
  store i32 0, ptr %17, align 8
  store i32 0, ptr %4, align 4
  br label %18

18:                                               ; preds = %36, %9
  %19 = load i32, ptr %4, align 4
  %20 = icmp sle i32 %19, 3
  br i1 %20, label %21, label %39

21:                                               ; preds = %18
  %22 = load i64, ptr @v2, align 8
  %23 = add nsw i64 %22, 1
  store i64 %23, ptr @v2, align 8
  %24 = load i64, ptr @v2, align 8
  %25 = icmp sgt i64 %24, 26
  br i1 %25, label %26, label %27

26:                                               ; preds = %21
  store i64 1, ptr @v2, align 8
  br label %27

27:                                               ; preds = %26, %21
  %28 = load i64, ptr @v2, align 8
  %29 = getelementptr inbounds [28 x i8], ptr @alphabet, i64 0, i64 %28
  %30 = load i8, ptr %29, align 1
  %31 = load ptr, ptr %3, align 8
  %32 = getelementptr inbounds %struct.packet, ptr %31, i32 0, i32 4
  %33 = load i32, ptr %4, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [4 x i8], ptr %32, i64 0, i64 %34
  store i8 %30, ptr %35, align 1
  br label %36

36:                                               ; preds = %27
  %37 = load i32, ptr %4, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %4, align 4
  br label %18, !llvm.loop !10

39:                                               ; preds = %18
  %40 = load ptr, ptr %3, align 8
  %41 = call ptr @qpkt(ptr noundef %40)
  store ptr %41, ptr %2, align 8
  br label %42

42:                                               ; preds = %39, %7
  %43 = load ptr, ptr %2, align 8
  ret ptr %43
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @handlerfn(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = icmp ne ptr %7, null
  br i1 %8, label %9, label %17

9:                                                ; preds = %1
  %10 = load ptr, ptr %3, align 8
  %11 = load ptr, ptr %3, align 8
  %12 = getelementptr inbounds %struct.packet, ptr %11, i32 0, i32 2
  %13 = load i32, ptr %12, align 4
  %14 = icmp eq i32 %13, 1001
  %15 = zext i1 %14 to i64
  %16 = select i1 %14, ptr @v1, ptr @v2
  call void @append(ptr noundef %10, ptr noundef %16)
  br label %17

17:                                               ; preds = %9, %1
  %18 = load i64, ptr @v1, align 8
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %20, label %63

20:                                               ; preds = %17
  %21 = load i64, ptr @v1, align 8
  %22 = inttoptr i64 %21 to ptr
  store ptr %22, ptr %5, align 8
  %23 = load ptr, ptr %5, align 8
  %24 = getelementptr inbounds %struct.packet, ptr %23, i32 0, i32 3
  %25 = load i32, ptr %24, align 8
  store i32 %25, ptr %4, align 4
  %26 = load i32, ptr %4, align 4
  %27 = icmp sgt i32 %26, 3
  br i1 %27, label %28, label %36

28:                                               ; preds = %20
  %29 = load i64, ptr @v1, align 8
  %30 = inttoptr i64 %29 to ptr
  %31 = getelementptr inbounds %struct.packet, ptr %30, i32 0, i32 0
  %32 = load ptr, ptr %31, align 8
  %33 = ptrtoint ptr %32 to i64
  store i64 %33, ptr @v1, align 8
  %34 = load ptr, ptr %5, align 8
  %35 = call ptr @qpkt(ptr noundef %34)
  store ptr %35, ptr %2, align 8
  br label %65

36:                                               ; preds = %20
  %37 = load i64, ptr @v2, align 8
  %38 = icmp ne i64 %37, 0
  br i1 %38, label %39, label %62

39:                                               ; preds = %36
  %40 = load i64, ptr @v2, align 8
  %41 = inttoptr i64 %40 to ptr
  store ptr %41, ptr %6, align 8
  %42 = load i64, ptr @v2, align 8
  %43 = inttoptr i64 %42 to ptr
  %44 = getelementptr inbounds %struct.packet, ptr %43, i32 0, i32 0
  %45 = load ptr, ptr %44, align 8
  %46 = ptrtoint ptr %45 to i64
  store i64 %46, ptr @v2, align 8
  %47 = load ptr, ptr %5, align 8
  %48 = getelementptr inbounds %struct.packet, ptr %47, i32 0, i32 4
  %49 = load i32, ptr %4, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [4 x i8], ptr %48, i64 0, i64 %50
  %52 = load i8, ptr %51, align 1
  %53 = sext i8 %52 to i32
  %54 = load ptr, ptr %6, align 8
  %55 = getelementptr inbounds %struct.packet, ptr %54, i32 0, i32 3
  store i32 %53, ptr %55, align 8
  %56 = load i32, ptr %4, align 4
  %57 = add nsw i32 %56, 1
  %58 = load ptr, ptr %5, align 8
  %59 = getelementptr inbounds %struct.packet, ptr %58, i32 0, i32 3
  store i32 %57, ptr %59, align 8
  %60 = load ptr, ptr %6, align 8
  %61 = call ptr @qpkt(ptr noundef %60)
  store ptr %61, ptr %2, align 8
  br label %65

62:                                               ; preds = %36
  br label %63

63:                                               ; preds = %62, %17
  %64 = call ptr @Wait()
  store ptr %64, ptr %2, align 8
  br label %65

65:                                               ; preds = %63, %39, %28
  %66 = load ptr, ptr %2, align 8
  ret ptr %66
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @devfn(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %16

6:                                                ; preds = %1
  %7 = load i64, ptr @v1, align 8
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %9, label %11

9:                                                ; preds = %6
  %10 = call ptr @Wait()
  store ptr %10, ptr %2, align 8
  br label %28

11:                                               ; preds = %6
  %12 = load i64, ptr @v1, align 8
  %13 = inttoptr i64 %12 to ptr
  store ptr %13, ptr %3, align 8
  store i64 0, ptr @v1, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = call ptr @qpkt(ptr noundef %14)
  store ptr %15, ptr %2, align 8
  br label %28

16:                                               ; preds = %1
  %17 = load ptr, ptr %3, align 8
  %18 = ptrtoint ptr %17 to i64
  store i64 %18, ptr @v1, align 8
  %19 = load i32, ptr @tracing, align 4
  %20 = icmp eq i32 %19, 1
  br i1 %20, label %21, label %26

21:                                               ; preds = %16
  %22 = load ptr, ptr %3, align 8
  %23 = getelementptr inbounds %struct.packet, ptr %22, i32 0, i32 3
  %24 = load i32, ptr %23, align 8
  %25 = trunc i32 %24 to i8
  call void @trace(i8 noundef signext %25)
  br label %26

26:                                               ; preds = %21, %16
  %27 = call ptr @holdself()
  store ptr %27, ptr %2, align 8
  br label %28

28:                                               ; preds = %26, %11, %9
  %29 = load ptr, ptr %2, align 8
  ret ptr %29
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @llvm_bench_main() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i32, align 4
  store ptr null, ptr %1, align 8
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %4 = load ptr, ptr %1, align 8
  call void @createtask(i32 noundef 1, i32 noundef 0, ptr noundef %4, i32 noundef 0, ptr noundef @idlefn, i64 noundef 1, i64 noundef 10000000)
  %5 = call ptr @pkt(ptr noundef null, i32 noundef 0, i32 noundef 1001)
  store ptr %5, ptr %1, align 8
  %6 = load ptr, ptr %1, align 8
  %7 = call ptr @pkt(ptr noundef %6, i32 noundef 0, i32 noundef 1001)
  store ptr %7, ptr %1, align 8
  %8 = load ptr, ptr %1, align 8
  call void @createtask(i32 noundef 2, i32 noundef 1000, ptr noundef %8, i32 noundef 3, ptr noundef @workfn, i64 noundef 3, i64 noundef 0)
  %9 = call ptr @pkt(ptr noundef null, i32 noundef 5, i32 noundef 1000)
  store ptr %9, ptr %1, align 8
  %10 = load ptr, ptr %1, align 8
  %11 = call ptr @pkt(ptr noundef %10, i32 noundef 5, i32 noundef 1000)
  store ptr %11, ptr %1, align 8
  %12 = load ptr, ptr %1, align 8
  %13 = call ptr @pkt(ptr noundef %12, i32 noundef 5, i32 noundef 1000)
  store ptr %13, ptr %1, align 8
  %14 = load ptr, ptr %1, align 8
  call void @createtask(i32 noundef 3, i32 noundef 2000, ptr noundef %14, i32 noundef 3, ptr noundef @handlerfn, i64 noundef 0, i64 noundef 0)
  %15 = call ptr @pkt(ptr noundef null, i32 noundef 6, i32 noundef 1000)
  store ptr %15, ptr %1, align 8
  %16 = load ptr, ptr %1, align 8
  %17 = call ptr @pkt(ptr noundef %16, i32 noundef 6, i32 noundef 1000)
  store ptr %17, ptr %1, align 8
  %18 = load ptr, ptr %1, align 8
  %19 = call ptr @pkt(ptr noundef %18, i32 noundef 6, i32 noundef 1000)
  store ptr %19, ptr %1, align 8
  %20 = load ptr, ptr %1, align 8
  call void @createtask(i32 noundef 4, i32 noundef 3000, ptr noundef %20, i32 noundef 3, ptr noundef @handlerfn, i64 noundef 0, i64 noundef 0)
  store ptr null, ptr %1, align 8
  %21 = load ptr, ptr %1, align 8
  call void @createtask(i32 noundef 5, i32 noundef 4000, ptr noundef %21, i32 noundef 2, ptr noundef @devfn, i64 noundef 0, i64 noundef 0)
  %22 = load ptr, ptr %1, align 8
  call void @createtask(i32 noundef 6, i32 noundef 5000, ptr noundef %22, i32 noundef 2, ptr noundef @devfn, i64 noundef 0, i64 noundef 0)
  %23 = load ptr, ptr @tasklist, align 8
  store ptr %23, ptr @tcb, align 8
  store i32 0, ptr @holdcount, align 4
  store i32 0, ptr @qpktcount, align 4
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  store i32 0, ptr @tracing, align 4
  store i32 0, ptr @layout, align 4
  call void @schedule()
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  %26 = load i32, ptr @qpktcount, align 4
  %27 = load i32, ptr @holdcount, align 4
  %28 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %26, i32 noundef %27)
  %29 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  %30 = load i32, ptr @qpktcount, align 4
  %31 = icmp eq i32 %30, 23263894
  br i1 %31, label %32, label %37

32:                                               ; preds = %0
  %33 = load i32, ptr @holdcount, align 4
  %34 = icmp eq i32 %33, 9305557
  br i1 %34, label %35, label %37

35:                                               ; preds = %32
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  store i32 0, ptr %2, align 4
  br label %39

37:                                               ; preds = %32, %0
  %38 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  store i32 1, ptr %2, align 4
  br label %39

39:                                               ; preds = %37, %35
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  %41 = load i32, ptr %2, align 4
  ret i32 %41
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind allocsize(0) }

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
