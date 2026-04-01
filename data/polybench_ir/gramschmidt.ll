; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/solvers/gramschmidt/gramschmidt.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/solvers/gramschmidt/gramschmidt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"R\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"Q\00", align 1
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
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 1000, ptr %6, align 4
  store i32 1200, ptr %7, align 4
  %11 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %11, ptr %8, align 8
  %12 = call ptr @polybench_alloc_data(i64 noundef 1440000, i32 noundef 8)
  store ptr %12, ptr %9, align 8
  %13 = call ptr @polybench_alloc_data(i64 noundef 1200000, i32 noundef 8)
  store ptr %13, ptr %10, align 8
  %14 = load i32, ptr %6, align 4
  %15 = load i32, ptr %7, align 4
  %16 = load ptr, ptr %8, align 8
  %17 = getelementptr inbounds [1000 x [1200 x double]], ptr %16, i64 0, i64 0
  %18 = load ptr, ptr %9, align 8
  %19 = getelementptr inbounds [1200 x [1200 x double]], ptr %18, i64 0, i64 0
  %20 = load ptr, ptr %10, align 8
  %21 = getelementptr inbounds [1000 x [1200 x double]], ptr %20, i64 0, i64 0
  call void @init_array(i32 noundef %14, i32 noundef %15, ptr noundef %17, ptr noundef %19, ptr noundef %21)
  %22 = load i32, ptr %6, align 4
  %23 = load i32, ptr %7, align 4
  %24 = load ptr, ptr %8, align 8
  %25 = getelementptr inbounds [1000 x [1200 x double]], ptr %24, i64 0, i64 0
  %26 = load ptr, ptr %9, align 8
  %27 = getelementptr inbounds [1200 x [1200 x double]], ptr %26, i64 0, i64 0
  %28 = load ptr, ptr %10, align 8
  %29 = getelementptr inbounds [1000 x [1200 x double]], ptr %28, i64 0, i64 0
  call void @kernel_gramschmidt(i32 noundef %22, i32 noundef %23, ptr noundef %25, ptr noundef %27, ptr noundef %29)
  %30 = load i32, ptr %4, align 4
  %31 = icmp sgt i32 %30, 42
  br i1 %31, label %32, label %47

32:                                               ; preds = %2
  %33 = load ptr, ptr %5, align 8
  %34 = getelementptr inbounds ptr, ptr %33, i64 0
  %35 = load ptr, ptr %34, align 8
  %36 = call i32 @strcmp(ptr noundef %35, ptr noundef @.str) #5
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %47, label %38

38:                                               ; preds = %32
  %39 = load i32, ptr %6, align 4
  %40 = load i32, ptr %7, align 4
  %41 = load ptr, ptr %8, align 8
  %42 = getelementptr inbounds [1000 x [1200 x double]], ptr %41, i64 0, i64 0
  %43 = load ptr, ptr %9, align 8
  %44 = getelementptr inbounds [1200 x [1200 x double]], ptr %43, i64 0, i64 0
  %45 = load ptr, ptr %10, align 8
  %46 = getelementptr inbounds [1000 x [1200 x double]], ptr %45, i64 0, i64 0
  call void @print_array(i32 noundef %39, i32 noundef %40, ptr noundef %42, ptr noundef %44, ptr noundef %46)
  br label %47

47:                                               ; preds = %38, %32, %2
  %48 = load ptr, ptr %8, align 8
  call void @free(ptr noundef %48) #6
  %49 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %49) #6
  %50 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %50) #6
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

13:                                               ; preds = %51, %5
  %14 = load i32, ptr %11, align 4
  %15 = load i32, ptr %6, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %54

17:                                               ; preds = %13
  store i32 0, ptr %12, align 4
  br label %18

18:                                               ; preds = %47, %17
  %19 = load i32, ptr %12, align 4
  %20 = load i32, ptr %7, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %50

22:                                               ; preds = %18
  %23 = load i32, ptr %11, align 4
  %24 = load i32, ptr %12, align 4
  %25 = mul nsw i32 %23, %24
  %26 = load i32, ptr %6, align 4
  %27 = srem i32 %25, %26
  %28 = sitofp i32 %27 to double
  %29 = load i32, ptr %6, align 4
  %30 = sitofp i32 %29 to double
  %31 = fdiv double %28, %30
  %32 = call double @llvm.fmuladd.f64(double %31, double 1.000000e+02, double 1.000000e+01)
  %33 = load ptr, ptr %8, align 8
  %34 = load i32, ptr %11, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [1200 x double], ptr %33, i64 %35
  %37 = load i32, ptr %12, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [1200 x double], ptr %36, i64 0, i64 %38
  store double %32, ptr %39, align 8
  %40 = load ptr, ptr %10, align 8
  %41 = load i32, ptr %11, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [1200 x double], ptr %40, i64 %42
  %44 = load i32, ptr %12, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [1200 x double], ptr %43, i64 0, i64 %45
  store double 0.000000e+00, ptr %46, align 8
  br label %47

47:                                               ; preds = %22
  %48 = load i32, ptr %12, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %12, align 4
  br label %18, !llvm.loop !6

50:                                               ; preds = %18
  br label %51

51:                                               ; preds = %50
  %52 = load i32, ptr %11, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %11, align 4
  br label %13, !llvm.loop !8

54:                                               ; preds = %13
  store i32 0, ptr %11, align 4
  br label %55

55:                                               ; preds = %76, %54
  %56 = load i32, ptr %11, align 4
  %57 = load i32, ptr %7, align 4
  %58 = icmp slt i32 %56, %57
  br i1 %58, label %59, label %79

59:                                               ; preds = %55
  store i32 0, ptr %12, align 4
  br label %60

60:                                               ; preds = %72, %59
  %61 = load i32, ptr %12, align 4
  %62 = load i32, ptr %7, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %75

64:                                               ; preds = %60
  %65 = load ptr, ptr %9, align 8
  %66 = load i32, ptr %11, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds [1200 x double], ptr %65, i64 %67
  %69 = load i32, ptr %12, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds [1200 x double], ptr %68, i64 0, i64 %70
  store double 0.000000e+00, ptr %71, align 8
  br label %72

72:                                               ; preds = %64
  %73 = load i32, ptr %12, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, ptr %12, align 4
  br label %60, !llvm.loop !9

75:                                               ; preds = %60
  br label %76

76:                                               ; preds = %75
  %77 = load i32, ptr %11, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, ptr %11, align 4
  br label %55, !llvm.loop !10

79:                                               ; preds = %55
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_gramschmidt(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca double, align 8
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  store ptr %4, ptr %10, align 8
  store i32 0, ptr %13, align 4
  br label %15

15:                                               ; preds = %183, %5
  %16 = load i32, ptr %13, align 4
  %17 = load i32, ptr %7, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %186

19:                                               ; preds = %15
  store double 0.000000e+00, ptr %14, align 8
  store i32 0, ptr %11, align 4
  br label %20

20:                                               ; preds = %43, %19
  %21 = load i32, ptr %11, align 4
  %22 = load i32, ptr %6, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %46

24:                                               ; preds = %20
  %25 = load ptr, ptr %8, align 8
  %26 = load i32, ptr %11, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [1200 x double], ptr %25, i64 %27
  %29 = load i32, ptr %13, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [1200 x double], ptr %28, i64 0, i64 %30
  %32 = load double, ptr %31, align 8
  %33 = load ptr, ptr %8, align 8
  %34 = load i32, ptr %11, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [1200 x double], ptr %33, i64 %35
  %37 = load i32, ptr %13, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [1200 x double], ptr %36, i64 0, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = load double, ptr %14, align 8
  %42 = call double @llvm.fmuladd.f64(double %32, double %40, double %41)
  store double %42, ptr %14, align 8
  br label %43

43:                                               ; preds = %24
  %44 = load i32, ptr %11, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %11, align 4
  br label %20, !llvm.loop !11

46:                                               ; preds = %20
  %47 = load double, ptr %14, align 8
  %48 = call double @sqrt(double noundef %47) #6
  %49 = load ptr, ptr %9, align 8
  %50 = load i32, ptr %13, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [1200 x double], ptr %49, i64 %51
  %53 = load i32, ptr %13, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [1200 x double], ptr %52, i64 0, i64 %54
  store double %48, ptr %55, align 8
  store i32 0, ptr %11, align 4
  br label %56

56:                                               ; preds = %85, %46
  %57 = load i32, ptr %11, align 4
  %58 = load i32, ptr %6, align 4
  %59 = icmp slt i32 %57, %58
  br i1 %59, label %60, label %88

60:                                               ; preds = %56
  %61 = load ptr, ptr %8, align 8
  %62 = load i32, ptr %11, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [1200 x double], ptr %61, i64 %63
  %65 = load i32, ptr %13, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [1200 x double], ptr %64, i64 0, i64 %66
  %68 = load double, ptr %67, align 8
  %69 = load ptr, ptr %9, align 8
  %70 = load i32, ptr %13, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [1200 x double], ptr %69, i64 %71
  %73 = load i32, ptr %13, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [1200 x double], ptr %72, i64 0, i64 %74
  %76 = load double, ptr %75, align 8
  %77 = fdiv double %68, %76
  %78 = load ptr, ptr %10, align 8
  %79 = load i32, ptr %11, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds [1200 x double], ptr %78, i64 %80
  %82 = load i32, ptr %13, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [1200 x double], ptr %81, i64 0, i64 %83
  store double %77, ptr %84, align 8
  br label %85

85:                                               ; preds = %60
  %86 = load i32, ptr %11, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %11, align 4
  br label %56, !llvm.loop !12

88:                                               ; preds = %56
  %89 = load i32, ptr %13, align 4
  %90 = add nsw i32 %89, 1
  store i32 %90, ptr %12, align 4
  br label %91

91:                                               ; preds = %179, %88
  %92 = load i32, ptr %12, align 4
  %93 = load i32, ptr %7, align 4
  %94 = icmp slt i32 %92, %93
  br i1 %94, label %95, label %182

95:                                               ; preds = %91
  %96 = load ptr, ptr %9, align 8
  %97 = load i32, ptr %13, align 4
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [1200 x double], ptr %96, i64 %98
  %100 = load i32, ptr %12, align 4
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds [1200 x double], ptr %99, i64 0, i64 %101
  store double 0.000000e+00, ptr %102, align 8
  store i32 0, ptr %11, align 4
  br label %103

103:                                              ; preds = %133, %95
  %104 = load i32, ptr %11, align 4
  %105 = load i32, ptr %6, align 4
  %106 = icmp slt i32 %104, %105
  br i1 %106, label %107, label %136

107:                                              ; preds = %103
  %108 = load ptr, ptr %10, align 8
  %109 = load i32, ptr %11, align 4
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds [1200 x double], ptr %108, i64 %110
  %112 = load i32, ptr %13, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [1200 x double], ptr %111, i64 0, i64 %113
  %115 = load double, ptr %114, align 8
  %116 = load ptr, ptr %8, align 8
  %117 = load i32, ptr %11, align 4
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds [1200 x double], ptr %116, i64 %118
  %120 = load i32, ptr %12, align 4
  %121 = sext i32 %120 to i64
  %122 = getelementptr inbounds [1200 x double], ptr %119, i64 0, i64 %121
  %123 = load double, ptr %122, align 8
  %124 = load ptr, ptr %9, align 8
  %125 = load i32, ptr %13, align 4
  %126 = sext i32 %125 to i64
  %127 = getelementptr inbounds [1200 x double], ptr %124, i64 %126
  %128 = load i32, ptr %12, align 4
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds [1200 x double], ptr %127, i64 0, i64 %129
  %131 = load double, ptr %130, align 8
  %132 = call double @llvm.fmuladd.f64(double %115, double %123, double %131)
  store double %132, ptr %130, align 8
  br label %133

133:                                              ; preds = %107
  %134 = load i32, ptr %11, align 4
  %135 = add nsw i32 %134, 1
  store i32 %135, ptr %11, align 4
  br label %103, !llvm.loop !13

136:                                              ; preds = %103
  store i32 0, ptr %11, align 4
  br label %137

137:                                              ; preds = %175, %136
  %138 = load i32, ptr %11, align 4
  %139 = load i32, ptr %6, align 4
  %140 = icmp slt i32 %138, %139
  br i1 %140, label %141, label %178

141:                                              ; preds = %137
  %142 = load ptr, ptr %8, align 8
  %143 = load i32, ptr %11, align 4
  %144 = sext i32 %143 to i64
  %145 = getelementptr inbounds [1200 x double], ptr %142, i64 %144
  %146 = load i32, ptr %12, align 4
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds [1200 x double], ptr %145, i64 0, i64 %147
  %149 = load double, ptr %148, align 8
  %150 = load ptr, ptr %10, align 8
  %151 = load i32, ptr %11, align 4
  %152 = sext i32 %151 to i64
  %153 = getelementptr inbounds [1200 x double], ptr %150, i64 %152
  %154 = load i32, ptr %13, align 4
  %155 = sext i32 %154 to i64
  %156 = getelementptr inbounds [1200 x double], ptr %153, i64 0, i64 %155
  %157 = load double, ptr %156, align 8
  %158 = load ptr, ptr %9, align 8
  %159 = load i32, ptr %13, align 4
  %160 = sext i32 %159 to i64
  %161 = getelementptr inbounds [1200 x double], ptr %158, i64 %160
  %162 = load i32, ptr %12, align 4
  %163 = sext i32 %162 to i64
  %164 = getelementptr inbounds [1200 x double], ptr %161, i64 0, i64 %163
  %165 = load double, ptr %164, align 8
  %166 = fneg double %157
  %167 = call double @llvm.fmuladd.f64(double %166, double %165, double %149)
  %168 = load ptr, ptr %8, align 8
  %169 = load i32, ptr %11, align 4
  %170 = sext i32 %169 to i64
  %171 = getelementptr inbounds [1200 x double], ptr %168, i64 %170
  %172 = load i32, ptr %12, align 4
  %173 = sext i32 %172 to i64
  %174 = getelementptr inbounds [1200 x double], ptr %171, i64 0, i64 %173
  store double %167, ptr %174, align 8
  br label %175

175:                                              ; preds = %141
  %176 = load i32, ptr %11, align 4
  %177 = add nsw i32 %176, 1
  store i32 %177, ptr %11, align 4
  br label %137, !llvm.loop !14

178:                                              ; preds = %137
  br label %179

179:                                              ; preds = %178
  %180 = load i32, ptr %12, align 4
  %181 = add nsw i32 %180, 1
  store i32 %181, ptr %12, align 4
  br label %91, !llvm.loop !15

182:                                              ; preds = %91
  br label %183

183:                                              ; preds = %182
  %184 = load i32, ptr %13, align 4
  %185 = add nsw i32 %184, 1
  store i32 %185, ptr %13, align 4
  br label %15, !llvm.loop !16

186:                                              ; preds = %15
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4) #0 {
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
  %13 = load ptr, ptr @stderr, align 8
  %14 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %13, ptr noundef @.str.1)
  %15 = load ptr, ptr @stderr, align 8
  %16 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %15, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %11, align 4
  br label %17

17:                                               ; preds = %52, %5
  %18 = load i32, ptr %11, align 4
  %19 = load i32, ptr %7, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %55

21:                                               ; preds = %17
  store i32 0, ptr %12, align 4
  br label %22

22:                                               ; preds = %48, %21
  %23 = load i32, ptr %12, align 4
  %24 = load i32, ptr %7, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %26, label %51

26:                                               ; preds = %22
  %27 = load i32, ptr %11, align 4
  %28 = load i32, ptr %7, align 4
  %29 = mul nsw i32 %27, %28
  %30 = load i32, ptr %12, align 4
  %31 = add nsw i32 %29, %30
  %32 = srem i32 %31, 20
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %37

34:                                               ; preds = %26
  %35 = load ptr, ptr @stderr, align 8
  %36 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %35, ptr noundef @.str.4)
  br label %37

37:                                               ; preds = %34, %26
  %38 = load ptr, ptr @stderr, align 8
  %39 = load ptr, ptr %9, align 8
  %40 = load i32, ptr %11, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [1200 x double], ptr %39, i64 %41
  %43 = load i32, ptr %12, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [1200 x double], ptr %42, i64 0, i64 %44
  %46 = load double, ptr %45, align 8
  %47 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %38, ptr noundef @.str.5, double noundef %46)
  br label %48

48:                                               ; preds = %37
  %49 = load i32, ptr %12, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %12, align 4
  br label %22, !llvm.loop !17

51:                                               ; preds = %22
  br label %52

52:                                               ; preds = %51
  %53 = load i32, ptr %11, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %11, align 4
  br label %17, !llvm.loop !18

55:                                               ; preds = %17
  %56 = load ptr, ptr @stderr, align 8
  %57 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %56, ptr noundef @.str.6, ptr noundef @.str.3)
  %58 = load ptr, ptr @stderr, align 8
  %59 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %58, ptr noundef @.str.2, ptr noundef @.str.7)
  store i32 0, ptr %11, align 4
  br label %60

60:                                               ; preds = %95, %55
  %61 = load i32, ptr %11, align 4
  %62 = load i32, ptr %6, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %98

64:                                               ; preds = %60
  store i32 0, ptr %12, align 4
  br label %65

65:                                               ; preds = %91, %64
  %66 = load i32, ptr %12, align 4
  %67 = load i32, ptr %7, align 4
  %68 = icmp slt i32 %66, %67
  br i1 %68, label %69, label %94

69:                                               ; preds = %65
  %70 = load i32, ptr %11, align 4
  %71 = load i32, ptr %7, align 4
  %72 = mul nsw i32 %70, %71
  %73 = load i32, ptr %12, align 4
  %74 = add nsw i32 %72, %73
  %75 = srem i32 %74, 20
  %76 = icmp eq i32 %75, 0
  br i1 %76, label %77, label %80

77:                                               ; preds = %69
  %78 = load ptr, ptr @stderr, align 8
  %79 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %78, ptr noundef @.str.4)
  br label %80

80:                                               ; preds = %77, %69
  %81 = load ptr, ptr @stderr, align 8
  %82 = load ptr, ptr %10, align 8
  %83 = load i32, ptr %11, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds [1200 x double], ptr %82, i64 %84
  %86 = load i32, ptr %12, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds [1200 x double], ptr %85, i64 0, i64 %87
  %89 = load double, ptr %88, align 8
  %90 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %81, ptr noundef @.str.5, double noundef %89)
  br label %91

91:                                               ; preds = %80
  %92 = load i32, ptr %12, align 4
  %93 = add nsw i32 %92, 1
  store i32 %93, ptr %12, align 4
  br label %65, !llvm.loop !19

94:                                               ; preds = %65
  br label %95

95:                                               ; preds = %94
  %96 = load i32, ptr %11, align 4
  %97 = add nsw i32 %96, 1
  store i32 %97, ptr %11, align 4
  br label %60, !llvm.loop !20

98:                                               ; preds = %60
  %99 = load ptr, ptr @stderr, align 8
  %100 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %99, ptr noundef @.str.6, ptr noundef @.str.7)
  %101 = load ptr, ptr @stderr, align 8
  %102 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %101, ptr noundef @.str.8)
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #4

; Function Attrs: nounwind
declare double @sqrt(double noundef) #3

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
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
