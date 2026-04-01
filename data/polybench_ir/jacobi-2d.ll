; ModuleID = '/code/data/webassembly-polybench-c-master/stencils/jacobi-2d/jacobi-2d.c'
source_filename = "/code/data/webassembly-polybench-c-master/stencils/jacobi-2d/jacobi-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
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
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 1300, ptr %6, align 4
  store i32 500, ptr %7, align 4
  %10 = call ptr @polybench_alloc_data(i64 noundef 1690000, i32 noundef 8)
  store ptr %10, ptr %8, align 8
  %11 = call ptr @polybench_alloc_data(i64 noundef 1690000, i32 noundef 8)
  store ptr %11, ptr %9, align 8
  %12 = load i32, ptr %6, align 4
  %13 = load ptr, ptr %8, align 8
  %14 = getelementptr inbounds [1300 x [1300 x double]], ptr %13, i64 0, i64 0
  %15 = load ptr, ptr %9, align 8
  %16 = getelementptr inbounds [1300 x [1300 x double]], ptr %15, i64 0, i64 0
  call void @init_array(i32 noundef %12, ptr noundef %14, ptr noundef %16)
  %17 = load i32, ptr %7, align 4
  %18 = load i32, ptr %6, align 4
  %19 = load ptr, ptr %8, align 8
  %20 = getelementptr inbounds [1300 x [1300 x double]], ptr %19, i64 0, i64 0
  %21 = load ptr, ptr %9, align 8
  %22 = getelementptr inbounds [1300 x [1300 x double]], ptr %21, i64 0, i64 0
  call void @kernel_jacobi_2d(i32 noundef %17, i32 noundef %18, ptr noundef %20, ptr noundef %22)
  %23 = load i32, ptr %4, align 4
  %24 = icmp sgt i32 %23, 42
  br i1 %24, label %25, label %35

25:                                               ; preds = %2
  %26 = load ptr, ptr %5, align 8
  %27 = getelementptr inbounds ptr, ptr %26, i64 0
  %28 = load ptr, ptr %27, align 8
  %29 = call i32 @strcmp(ptr noundef %28, ptr noundef @.str) #5
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %35, label %31

31:                                               ; preds = %25
  %32 = load i32, ptr %6, align 4
  %33 = load ptr, ptr %8, align 8
  %34 = getelementptr inbounds [1300 x [1300 x double]], ptr %33, i64 0, i64 0
  call void @print_array(i32 noundef %32, ptr noundef %34)
  br label %35

35:                                               ; preds = %31, %25, %2
  %36 = load ptr, ptr %8, align 8
  call void @free(ptr noundef %36) #6
  %37 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %37) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %9

9:                                                ; preds = %55, %3
  %10 = load i32, ptr %7, align 4
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %58

13:                                               ; preds = %9
  store i32 0, ptr %8, align 4
  br label %14

14:                                               ; preds = %51, %13
  %15 = load i32, ptr %8, align 4
  %16 = load i32, ptr %4, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %54

18:                                               ; preds = %14
  %19 = load i32, ptr %7, align 4
  %20 = sitofp i32 %19 to double
  %21 = load i32, ptr %8, align 4
  %22 = add nsw i32 %21, 2
  %23 = sitofp i32 %22 to double
  %24 = call double @llvm.fmuladd.f64(double %20, double %23, double 2.000000e+00)
  %25 = load i32, ptr %4, align 4
  %26 = sitofp i32 %25 to double
  %27 = fdiv double %24, %26
  %28 = load ptr, ptr %5, align 8
  %29 = load i32, ptr %7, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [1300 x double], ptr %28, i64 %30
  %32 = load i32, ptr %8, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [1300 x double], ptr %31, i64 0, i64 %33
  store double %27, ptr %34, align 8
  %35 = load i32, ptr %7, align 4
  %36 = sitofp i32 %35 to double
  %37 = load i32, ptr %8, align 4
  %38 = add nsw i32 %37, 3
  %39 = sitofp i32 %38 to double
  %40 = call double @llvm.fmuladd.f64(double %36, double %39, double 3.000000e+00)
  %41 = load i32, ptr %4, align 4
  %42 = sitofp i32 %41 to double
  %43 = fdiv double %40, %42
  %44 = load ptr, ptr %6, align 8
  %45 = load i32, ptr %7, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [1300 x double], ptr %44, i64 %46
  %48 = load i32, ptr %8, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [1300 x double], ptr %47, i64 0, i64 %49
  store double %43, ptr %50, align 8
  br label %51

51:                                               ; preds = %18
  %52 = load i32, ptr %8, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %8, align 4
  br label %14, !llvm.loop !6

54:                                               ; preds = %14
  br label %55

55:                                               ; preds = %54
  %56 = load i32, ptr %7, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %7, align 4
  br label %9, !llvm.loop !8

58:                                               ; preds = %9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_jacobi_2d(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store ptr %2, ptr %7, align 8
  store ptr %3, ptr %8, align 8
  store i32 0, ptr %9, align 4
  br label %12

12:                                               ; preds = %169, %4
  %13 = load i32, ptr %9, align 4
  %14 = load i32, ptr %5, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %172

16:                                               ; preds = %12
  store i32 1, ptr %10, align 4
  br label %17

17:                                               ; preds = %89, %16
  %18 = load i32, ptr %10, align 4
  %19 = load i32, ptr %6, align 4
  %20 = sub nsw i32 %19, 1
  %21 = icmp slt i32 %18, %20
  br i1 %21, label %22, label %92

22:                                               ; preds = %17
  store i32 1, ptr %11, align 4
  br label %23

23:                                               ; preds = %85, %22
  %24 = load i32, ptr %11, align 4
  %25 = load i32, ptr %6, align 4
  %26 = sub nsw i32 %25, 1
  %27 = icmp slt i32 %24, %26
  br i1 %27, label %28, label %88

28:                                               ; preds = %23
  %29 = load ptr, ptr %7, align 8
  %30 = load i32, ptr %10, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [1300 x double], ptr %29, i64 %31
  %33 = load i32, ptr %11, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [1300 x double], ptr %32, i64 0, i64 %34
  %36 = load double, ptr %35, align 8
  %37 = load ptr, ptr %7, align 8
  %38 = load i32, ptr %10, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [1300 x double], ptr %37, i64 %39
  %41 = load i32, ptr %11, align 4
  %42 = sub nsw i32 %41, 1
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [1300 x double], ptr %40, i64 0, i64 %43
  %45 = load double, ptr %44, align 8
  %46 = fadd double %36, %45
  %47 = load ptr, ptr %7, align 8
  %48 = load i32, ptr %10, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [1300 x double], ptr %47, i64 %49
  %51 = load i32, ptr %11, align 4
  %52 = add nsw i32 1, %51
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [1300 x double], ptr %50, i64 0, i64 %53
  %55 = load double, ptr %54, align 8
  %56 = fadd double %46, %55
  %57 = load ptr, ptr %7, align 8
  %58 = load i32, ptr %10, align 4
  %59 = add nsw i32 1, %58
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [1300 x double], ptr %57, i64 %60
  %62 = load i32, ptr %11, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [1300 x double], ptr %61, i64 0, i64 %63
  %65 = load double, ptr %64, align 8
  %66 = fadd double %56, %65
  %67 = load ptr, ptr %7, align 8
  %68 = load i32, ptr %10, align 4
  %69 = sub nsw i32 %68, 1
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds [1300 x double], ptr %67, i64 %70
  %72 = load i32, ptr %11, align 4
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds [1300 x double], ptr %71, i64 0, i64 %73
  %75 = load double, ptr %74, align 8
  %76 = fadd double %66, %75
  %77 = fmul double 2.000000e-01, %76
  %78 = load ptr, ptr %8, align 8
  %79 = load i32, ptr %10, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds [1300 x double], ptr %78, i64 %80
  %82 = load i32, ptr %11, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [1300 x double], ptr %81, i64 0, i64 %83
  store double %77, ptr %84, align 8
  br label %85

85:                                               ; preds = %28
  %86 = load i32, ptr %11, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %11, align 4
  br label %23, !llvm.loop !9

88:                                               ; preds = %23
  br label %89

89:                                               ; preds = %88
  %90 = load i32, ptr %10, align 4
  %91 = add nsw i32 %90, 1
  store i32 %91, ptr %10, align 4
  br label %17, !llvm.loop !10

92:                                               ; preds = %17
  store i32 1, ptr %10, align 4
  br label %93

93:                                               ; preds = %165, %92
  %94 = load i32, ptr %10, align 4
  %95 = load i32, ptr %6, align 4
  %96 = sub nsw i32 %95, 1
  %97 = icmp slt i32 %94, %96
  br i1 %97, label %98, label %168

98:                                               ; preds = %93
  store i32 1, ptr %11, align 4
  br label %99

99:                                               ; preds = %161, %98
  %100 = load i32, ptr %11, align 4
  %101 = load i32, ptr %6, align 4
  %102 = sub nsw i32 %101, 1
  %103 = icmp slt i32 %100, %102
  br i1 %103, label %104, label %164

104:                                              ; preds = %99
  %105 = load ptr, ptr %8, align 8
  %106 = load i32, ptr %10, align 4
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [1300 x double], ptr %105, i64 %107
  %109 = load i32, ptr %11, align 4
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds [1300 x double], ptr %108, i64 0, i64 %110
  %112 = load double, ptr %111, align 8
  %113 = load ptr, ptr %8, align 8
  %114 = load i32, ptr %10, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds [1300 x double], ptr %113, i64 %115
  %117 = load i32, ptr %11, align 4
  %118 = sub nsw i32 %117, 1
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds [1300 x double], ptr %116, i64 0, i64 %119
  %121 = load double, ptr %120, align 8
  %122 = fadd double %112, %121
  %123 = load ptr, ptr %8, align 8
  %124 = load i32, ptr %10, align 4
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds [1300 x double], ptr %123, i64 %125
  %127 = load i32, ptr %11, align 4
  %128 = add nsw i32 1, %127
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds [1300 x double], ptr %126, i64 0, i64 %129
  %131 = load double, ptr %130, align 8
  %132 = fadd double %122, %131
  %133 = load ptr, ptr %8, align 8
  %134 = load i32, ptr %10, align 4
  %135 = add nsw i32 1, %134
  %136 = sext i32 %135 to i64
  %137 = getelementptr inbounds [1300 x double], ptr %133, i64 %136
  %138 = load i32, ptr %11, align 4
  %139 = sext i32 %138 to i64
  %140 = getelementptr inbounds [1300 x double], ptr %137, i64 0, i64 %139
  %141 = load double, ptr %140, align 8
  %142 = fadd double %132, %141
  %143 = load ptr, ptr %8, align 8
  %144 = load i32, ptr %10, align 4
  %145 = sub nsw i32 %144, 1
  %146 = sext i32 %145 to i64
  %147 = getelementptr inbounds [1300 x double], ptr %143, i64 %146
  %148 = load i32, ptr %11, align 4
  %149 = sext i32 %148 to i64
  %150 = getelementptr inbounds [1300 x double], ptr %147, i64 0, i64 %149
  %151 = load double, ptr %150, align 8
  %152 = fadd double %142, %151
  %153 = fmul double 2.000000e-01, %152
  %154 = load ptr, ptr %7, align 8
  %155 = load i32, ptr %10, align 4
  %156 = sext i32 %155 to i64
  %157 = getelementptr inbounds [1300 x double], ptr %154, i64 %156
  %158 = load i32, ptr %11, align 4
  %159 = sext i32 %158 to i64
  %160 = getelementptr inbounds [1300 x double], ptr %157, i64 0, i64 %159
  store double %153, ptr %160, align 8
  br label %161

161:                                              ; preds = %104
  %162 = load i32, ptr %11, align 4
  %163 = add nsw i32 %162, 1
  store i32 %163, ptr %11, align 4
  br label %99, !llvm.loop !11

164:                                              ; preds = %99
  br label %165

165:                                              ; preds = %164
  %166 = load i32, ptr %10, align 4
  %167 = add nsw i32 %166, 1
  store i32 %167, ptr %10, align 4
  br label %93, !llvm.loop !12

168:                                              ; preds = %93
  br label %169

169:                                              ; preds = %168
  %170 = load i32, ptr %9, align 4
  %171 = add nsw i32 %170, 1
  store i32 %171, ptr %9, align 4
  br label %12, !llvm.loop !13

172:                                              ; preds = %12
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
  %36 = getelementptr inbounds [1300 x double], ptr %33, i64 %35
  %37 = load i32, ptr %6, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [1300 x double], ptr %36, i64 0, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %32, ptr noundef @.str.5, double noundef %40)
  br label %42

42:                                               ; preds = %31
  %43 = load i32, ptr %6, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %6, align 4
  br label %16, !llvm.loop !14

45:                                               ; preds = %16
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %5, align 4
  br label %11, !llvm.loop !15

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
