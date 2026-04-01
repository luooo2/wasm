; ModuleID = '/code/data/webassembly-polybench-c-master/datamining/covariance/covariance.c'
source_filename = "/code/data/webassembly-polybench-c-master/datamining/covariance/covariance.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"cov\00", align 1
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
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 1400, ptr %6, align 4
  store i32 1200, ptr %7, align 4
  %12 = call ptr @polybench_alloc_data(i64 noundef 1680000, i32 noundef 8)
  store ptr %12, ptr %9, align 8
  %13 = call ptr @polybench_alloc_data(i64 noundef 1440000, i32 noundef 8)
  store ptr %13, ptr %10, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 1200, i32 noundef 8)
  store ptr %14, ptr %11, align 8
  %15 = load i32, ptr %7, align 4
  %16 = load i32, ptr %6, align 4
  %17 = load ptr, ptr %9, align 8
  %18 = getelementptr inbounds [1400 x [1200 x double]], ptr %17, i64 0, i64 0
  call void @init_array(i32 noundef %15, i32 noundef %16, ptr noundef %8, ptr noundef %18)
  %19 = load i32, ptr %7, align 4
  %20 = load i32, ptr %6, align 4
  %21 = load double, ptr %8, align 8
  %22 = load ptr, ptr %9, align 8
  %23 = getelementptr inbounds [1400 x [1200 x double]], ptr %22, i64 0, i64 0
  %24 = load ptr, ptr %10, align 8
  %25 = getelementptr inbounds [1200 x [1200 x double]], ptr %24, i64 0, i64 0
  %26 = load ptr, ptr %11, align 8
  %27 = getelementptr inbounds [1200 x double], ptr %26, i64 0, i64 0
  call void @kernel_covariance(i32 noundef %19, i32 noundef %20, double noundef %21, ptr noundef %23, ptr noundef %25, ptr noundef %27)
  %28 = load i32, ptr %4, align 4
  %29 = icmp sgt i32 %28, 42
  br i1 %29, label %30, label %40

30:                                               ; preds = %2
  %31 = load ptr, ptr %5, align 8
  %32 = getelementptr inbounds ptr, ptr %31, i64 0
  %33 = load ptr, ptr %32, align 8
  %34 = call i32 @strcmp(ptr noundef %33, ptr noundef @.str) #5
  %35 = icmp ne i32 %34, 0
  br i1 %35, label %40, label %36

36:                                               ; preds = %30
  %37 = load i32, ptr %7, align 4
  %38 = load ptr, ptr %10, align 8
  %39 = getelementptr inbounds [1200 x [1200 x double]], ptr %38, i64 0, i64 0
  call void @print_array(i32 noundef %37, ptr noundef %39)
  br label %40

40:                                               ; preds = %36, %30, %2
  %41 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %41) #6
  %42 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %42) #6
  %43 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %43) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store ptr %2, ptr %7, align 8
  store ptr %3, ptr %8, align 8
  %11 = load i32, ptr %6, align 4
  %12 = sitofp i32 %11 to double
  %13 = load ptr, ptr %7, align 8
  store double %12, ptr %13, align 8
  store i32 0, ptr %9, align 4
  br label %14

14:                                               ; preds = %39, %4
  %15 = load i32, ptr %9, align 4
  %16 = icmp slt i32 %15, 1400
  br i1 %16, label %17, label %42

17:                                               ; preds = %14
  store i32 0, ptr %10, align 4
  br label %18

18:                                               ; preds = %35, %17
  %19 = load i32, ptr %10, align 4
  %20 = icmp slt i32 %19, 1200
  br i1 %20, label %21, label %38

21:                                               ; preds = %18
  %22 = load i32, ptr %9, align 4
  %23 = sitofp i32 %22 to double
  %24 = load i32, ptr %10, align 4
  %25 = sitofp i32 %24 to double
  %26 = fmul double %23, %25
  %27 = fdiv double %26, 1.200000e+03
  %28 = load ptr, ptr %8, align 8
  %29 = load i32, ptr %9, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [1200 x double], ptr %28, i64 %30
  %32 = load i32, ptr %10, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [1200 x double], ptr %31, i64 0, i64 %33
  store double %27, ptr %34, align 8
  br label %35

35:                                               ; preds = %21
  %36 = load i32, ptr %10, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %10, align 4
  br label %18, !llvm.loop !6

38:                                               ; preds = %18
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %9, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %9, align 4
  br label %14, !llvm.loop !8

42:                                               ; preds = %14
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_covariance(i32 noundef %0, i32 noundef %1, double noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca double, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store double %2, ptr %9, align 8
  store ptr %3, ptr %10, align 8
  store ptr %4, ptr %11, align 8
  store ptr %5, ptr %12, align 8
  store i32 0, ptr %14, align 4
  br label %16

16:                                               ; preds = %55, %6
  %17 = load i32, ptr %14, align 4
  %18 = load i32, ptr %7, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %58

20:                                               ; preds = %16
  %21 = load ptr, ptr %12, align 8
  %22 = load i32, ptr %14, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds double, ptr %21, i64 %23
  store double 0.000000e+00, ptr %24, align 8
  store i32 0, ptr %13, align 4
  br label %25

25:                                               ; preds = %44, %20
  %26 = load i32, ptr %13, align 4
  %27 = load i32, ptr %8, align 4
  %28 = icmp slt i32 %26, %27
  br i1 %28, label %29, label %47

29:                                               ; preds = %25
  %30 = load ptr, ptr %10, align 8
  %31 = load i32, ptr %13, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [1200 x double], ptr %30, i64 %32
  %34 = load i32, ptr %14, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [1200 x double], ptr %33, i64 0, i64 %35
  %37 = load double, ptr %36, align 8
  %38 = load ptr, ptr %12, align 8
  %39 = load i32, ptr %14, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds double, ptr %38, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = fadd double %42, %37
  store double %43, ptr %41, align 8
  br label %44

44:                                               ; preds = %29
  %45 = load i32, ptr %13, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %13, align 4
  br label %25, !llvm.loop !9

47:                                               ; preds = %25
  %48 = load double, ptr %9, align 8
  %49 = load ptr, ptr %12, align 8
  %50 = load i32, ptr %14, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds double, ptr %49, i64 %51
  %53 = load double, ptr %52, align 8
  %54 = fdiv double %53, %48
  store double %54, ptr %52, align 8
  br label %55

55:                                               ; preds = %47
  %56 = load i32, ptr %14, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %14, align 4
  br label %16, !llvm.loop !10

58:                                               ; preds = %16
  store i32 0, ptr %13, align 4
  br label %59

59:                                               ; preds = %87, %58
  %60 = load i32, ptr %13, align 4
  %61 = load i32, ptr %8, align 4
  %62 = icmp slt i32 %60, %61
  br i1 %62, label %63, label %90

63:                                               ; preds = %59
  store i32 0, ptr %14, align 4
  br label %64

64:                                               ; preds = %83, %63
  %65 = load i32, ptr %14, align 4
  %66 = load i32, ptr %7, align 4
  %67 = icmp slt i32 %65, %66
  br i1 %67, label %68, label %86

68:                                               ; preds = %64
  %69 = load ptr, ptr %12, align 8
  %70 = load i32, ptr %14, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds double, ptr %69, i64 %71
  %73 = load double, ptr %72, align 8
  %74 = load ptr, ptr %10, align 8
  %75 = load i32, ptr %13, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [1200 x double], ptr %74, i64 %76
  %78 = load i32, ptr %14, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds [1200 x double], ptr %77, i64 0, i64 %79
  %81 = load double, ptr %80, align 8
  %82 = fsub double %81, %73
  store double %82, ptr %80, align 8
  br label %83

83:                                               ; preds = %68
  %84 = load i32, ptr %14, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, ptr %14, align 4
  br label %64, !llvm.loop !11

86:                                               ; preds = %64
  br label %87

87:                                               ; preds = %86
  %88 = load i32, ptr %13, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %13, align 4
  br label %59, !llvm.loop !12

90:                                               ; preds = %59
  store i32 0, ptr %13, align 4
  br label %91

91:                                               ; preds = %173, %90
  %92 = load i32, ptr %13, align 4
  %93 = load i32, ptr %7, align 4
  %94 = icmp slt i32 %92, %93
  br i1 %94, label %95, label %176

95:                                               ; preds = %91
  %96 = load i32, ptr %13, align 4
  store i32 %96, ptr %14, align 4
  br label %97

97:                                               ; preds = %169, %95
  %98 = load i32, ptr %14, align 4
  %99 = load i32, ptr %7, align 4
  %100 = icmp slt i32 %98, %99
  br i1 %100, label %101, label %172

101:                                              ; preds = %97
  %102 = load ptr, ptr %11, align 8
  %103 = load i32, ptr %13, align 4
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds [1200 x double], ptr %102, i64 %104
  %106 = load i32, ptr %14, align 4
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [1200 x double], ptr %105, i64 0, i64 %107
  store double 0.000000e+00, ptr %108, align 8
  store i32 0, ptr %15, align 4
  br label %109

109:                                              ; preds = %139, %101
  %110 = load i32, ptr %15, align 4
  %111 = load i32, ptr %8, align 4
  %112 = icmp slt i32 %110, %111
  br i1 %112, label %113, label %142

113:                                              ; preds = %109
  %114 = load ptr, ptr %10, align 8
  %115 = load i32, ptr %15, align 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds [1200 x double], ptr %114, i64 %116
  %118 = load i32, ptr %13, align 4
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds [1200 x double], ptr %117, i64 0, i64 %119
  %121 = load double, ptr %120, align 8
  %122 = load ptr, ptr %10, align 8
  %123 = load i32, ptr %15, align 4
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds [1200 x double], ptr %122, i64 %124
  %126 = load i32, ptr %14, align 4
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds [1200 x double], ptr %125, i64 0, i64 %127
  %129 = load double, ptr %128, align 8
  %130 = load ptr, ptr %11, align 8
  %131 = load i32, ptr %13, align 4
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds [1200 x double], ptr %130, i64 %132
  %134 = load i32, ptr %14, align 4
  %135 = sext i32 %134 to i64
  %136 = getelementptr inbounds [1200 x double], ptr %133, i64 0, i64 %135
  %137 = load double, ptr %136, align 8
  %138 = call double @llvm.fmuladd.f64(double %121, double %129, double %137)
  store double %138, ptr %136, align 8
  br label %139

139:                                              ; preds = %113
  %140 = load i32, ptr %15, align 4
  %141 = add nsw i32 %140, 1
  store i32 %141, ptr %15, align 4
  br label %109, !llvm.loop !13

142:                                              ; preds = %109
  %143 = load double, ptr %9, align 8
  %144 = fsub double %143, 1.000000e+00
  %145 = load ptr, ptr %11, align 8
  %146 = load i32, ptr %13, align 4
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds [1200 x double], ptr %145, i64 %147
  %149 = load i32, ptr %14, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds [1200 x double], ptr %148, i64 0, i64 %150
  %152 = load double, ptr %151, align 8
  %153 = fdiv double %152, %144
  store double %153, ptr %151, align 8
  %154 = load ptr, ptr %11, align 8
  %155 = load i32, ptr %13, align 4
  %156 = sext i32 %155 to i64
  %157 = getelementptr inbounds [1200 x double], ptr %154, i64 %156
  %158 = load i32, ptr %14, align 4
  %159 = sext i32 %158 to i64
  %160 = getelementptr inbounds [1200 x double], ptr %157, i64 0, i64 %159
  %161 = load double, ptr %160, align 8
  %162 = load ptr, ptr %11, align 8
  %163 = load i32, ptr %14, align 4
  %164 = sext i32 %163 to i64
  %165 = getelementptr inbounds [1200 x double], ptr %162, i64 %164
  %166 = load i32, ptr %13, align 4
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds [1200 x double], ptr %165, i64 0, i64 %167
  store double %161, ptr %168, align 8
  br label %169

169:                                              ; preds = %142
  %170 = load i32, ptr %14, align 4
  %171 = add nsw i32 %170, 1
  store i32 %171, ptr %14, align 4
  br label %97, !llvm.loop !14

172:                                              ; preds = %97
  br label %173

173:                                              ; preds = %172
  %174 = load i32, ptr %13, align 4
  %175 = add nsw i32 %174, 1
  store i32 %175, ptr %13, align 4
  br label %91, !llvm.loop !15

176:                                              ; preds = %91
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
  br label %16, !llvm.loop !16

45:                                               ; preds = %16
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %5, align 4
  br label %11, !llvm.loop !17

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
!17 = distinct !{!17, !7}
