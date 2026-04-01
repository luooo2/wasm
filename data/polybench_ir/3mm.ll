; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/kernels/3mm/3mm.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/kernels/3mm/3mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"G\00", align 1
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
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 800, ptr %6, align 4
  store i32 900, ptr %7, align 4
  store i32 1000, ptr %8, align 4
  store i32 1100, ptr %9, align 4
  store i32 1200, ptr %10, align 4
  %18 = call ptr @polybench_alloc_data(i64 noundef 720000, i32 noundef 8)
  store ptr %18, ptr %11, align 8
  %19 = call ptr @polybench_alloc_data(i64 noundef 800000, i32 noundef 8)
  store ptr %19, ptr %12, align 8
  %20 = call ptr @polybench_alloc_data(i64 noundef 900000, i32 noundef 8)
  store ptr %20, ptr %13, align 8
  %21 = call ptr @polybench_alloc_data(i64 noundef 990000, i32 noundef 8)
  store ptr %21, ptr %14, align 8
  %22 = call ptr @polybench_alloc_data(i64 noundef 1080000, i32 noundef 8)
  store ptr %22, ptr %15, align 8
  %23 = call ptr @polybench_alloc_data(i64 noundef 1320000, i32 noundef 8)
  store ptr %23, ptr %16, align 8
  %24 = call ptr @polybench_alloc_data(i64 noundef 880000, i32 noundef 8)
  store ptr %24, ptr %17, align 8
  %25 = load i32, ptr %6, align 4
  %26 = load i32, ptr %7, align 4
  %27 = load i32, ptr %8, align 4
  %28 = load i32, ptr %9, align 4
  %29 = load i32, ptr %10, align 4
  %30 = load ptr, ptr %12, align 8
  %31 = getelementptr inbounds [800 x [1000 x double]], ptr %30, i64 0, i64 0
  %32 = load ptr, ptr %13, align 8
  %33 = getelementptr inbounds [1000 x [900 x double]], ptr %32, i64 0, i64 0
  %34 = load ptr, ptr %15, align 8
  %35 = getelementptr inbounds [900 x [1200 x double]], ptr %34, i64 0, i64 0
  %36 = load ptr, ptr %16, align 8
  %37 = getelementptr inbounds [1200 x [1100 x double]], ptr %36, i64 0, i64 0
  call void @init_array(i32 noundef %25, i32 noundef %26, i32 noundef %27, i32 noundef %28, i32 noundef %29, ptr noundef %31, ptr noundef %33, ptr noundef %35, ptr noundef %37)
  %38 = load i32, ptr %6, align 4
  %39 = load i32, ptr %7, align 4
  %40 = load i32, ptr %8, align 4
  %41 = load i32, ptr %9, align 4
  %42 = load i32, ptr %10, align 4
  %43 = load ptr, ptr %11, align 8
  %44 = getelementptr inbounds [800 x [900 x double]], ptr %43, i64 0, i64 0
  %45 = load ptr, ptr %12, align 8
  %46 = getelementptr inbounds [800 x [1000 x double]], ptr %45, i64 0, i64 0
  %47 = load ptr, ptr %13, align 8
  %48 = getelementptr inbounds [1000 x [900 x double]], ptr %47, i64 0, i64 0
  %49 = load ptr, ptr %14, align 8
  %50 = getelementptr inbounds [900 x [1100 x double]], ptr %49, i64 0, i64 0
  %51 = load ptr, ptr %15, align 8
  %52 = getelementptr inbounds [900 x [1200 x double]], ptr %51, i64 0, i64 0
  %53 = load ptr, ptr %16, align 8
  %54 = getelementptr inbounds [1200 x [1100 x double]], ptr %53, i64 0, i64 0
  %55 = load ptr, ptr %17, align 8
  %56 = getelementptr inbounds [800 x [1100 x double]], ptr %55, i64 0, i64 0
  call void @kernel_3mm(i32 noundef %38, i32 noundef %39, i32 noundef %40, i32 noundef %41, i32 noundef %42, ptr noundef %44, ptr noundef %46, ptr noundef %48, ptr noundef %50, ptr noundef %52, ptr noundef %54, ptr noundef %56)
  %57 = load i32, ptr %4, align 4
  %58 = icmp sgt i32 %57, 42
  br i1 %58, label %59, label %70

59:                                               ; preds = %2
  %60 = load ptr, ptr %5, align 8
  %61 = getelementptr inbounds ptr, ptr %60, i64 0
  %62 = load ptr, ptr %61, align 8
  %63 = call i32 @strcmp(ptr noundef %62, ptr noundef @.str) #5
  %64 = icmp ne i32 %63, 0
  br i1 %64, label %70, label %65

65:                                               ; preds = %59
  %66 = load i32, ptr %6, align 4
  %67 = load i32, ptr %9, align 4
  %68 = load ptr, ptr %17, align 8
  %69 = getelementptr inbounds [800 x [1100 x double]], ptr %68, i64 0, i64 0
  call void @print_array(i32 noundef %66, i32 noundef %67, ptr noundef %69)
  br label %70

70:                                               ; preds = %65, %59, %2
  %71 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %71) #6
  %72 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %72) #6
  %73 = load ptr, ptr %13, align 8
  call void @free(ptr noundef %73) #6
  %74 = load ptr, ptr %14, align 8
  call void @free(ptr noundef %74) #6
  %75 = load ptr, ptr %15, align 8
  call void @free(ptr noundef %75) #6
  %76 = load ptr, ptr %16, align 8
  call void @free(ptr noundef %76) #6
  %77 = load ptr, ptr %17, align 8
  call void @free(ptr noundef %77) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, ptr noundef %5, ptr noundef %6, ptr noundef %7, ptr noundef %8) #0 {
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca ptr, align 8
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  store i32 %0, ptr %10, align 4
  store i32 %1, ptr %11, align 4
  store i32 %2, ptr %12, align 4
  store i32 %3, ptr %13, align 4
  store i32 %4, ptr %14, align 4
  store ptr %5, ptr %15, align 8
  store ptr %6, ptr %16, align 8
  store ptr %7, ptr %17, align 8
  store ptr %8, ptr %18, align 8
  store i32 0, ptr %19, align 4
  br label %21

21:                                               ; preds = %53, %9
  %22 = load i32, ptr %19, align 4
  %23 = load i32, ptr %10, align 4
  %24 = icmp slt i32 %22, %23
  br i1 %24, label %25, label %56

25:                                               ; preds = %21
  store i32 0, ptr %20, align 4
  br label %26

26:                                               ; preds = %49, %25
  %27 = load i32, ptr %20, align 4
  %28 = load i32, ptr %12, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %52

30:                                               ; preds = %26
  %31 = load i32, ptr %19, align 4
  %32 = load i32, ptr %20, align 4
  %33 = mul nsw i32 %31, %32
  %34 = add nsw i32 %33, 1
  %35 = load i32, ptr %10, align 4
  %36 = srem i32 %34, %35
  %37 = sitofp i32 %36 to double
  %38 = load i32, ptr %10, align 4
  %39 = mul nsw i32 5, %38
  %40 = sitofp i32 %39 to double
  %41 = fdiv double %37, %40
  %42 = load ptr, ptr %15, align 8
  %43 = load i32, ptr %19, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [1000 x double], ptr %42, i64 %44
  %46 = load i32, ptr %20, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [1000 x double], ptr %45, i64 0, i64 %47
  store double %41, ptr %48, align 8
  br label %49

49:                                               ; preds = %30
  %50 = load i32, ptr %20, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %20, align 4
  br label %26, !llvm.loop !6

52:                                               ; preds = %26
  br label %53

53:                                               ; preds = %52
  %54 = load i32, ptr %19, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %19, align 4
  br label %21, !llvm.loop !8

56:                                               ; preds = %21
  store i32 0, ptr %19, align 4
  br label %57

57:                                               ; preds = %90, %56
  %58 = load i32, ptr %19, align 4
  %59 = load i32, ptr %12, align 4
  %60 = icmp slt i32 %58, %59
  br i1 %60, label %61, label %93

61:                                               ; preds = %57
  store i32 0, ptr %20, align 4
  br label %62

62:                                               ; preds = %86, %61
  %63 = load i32, ptr %20, align 4
  %64 = load i32, ptr %11, align 4
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %89

66:                                               ; preds = %62
  %67 = load i32, ptr %19, align 4
  %68 = load i32, ptr %20, align 4
  %69 = add nsw i32 %68, 1
  %70 = mul nsw i32 %67, %69
  %71 = add nsw i32 %70, 2
  %72 = load i32, ptr %11, align 4
  %73 = srem i32 %71, %72
  %74 = sitofp i32 %73 to double
  %75 = load i32, ptr %11, align 4
  %76 = mul nsw i32 5, %75
  %77 = sitofp i32 %76 to double
  %78 = fdiv double %74, %77
  %79 = load ptr, ptr %16, align 8
  %80 = load i32, ptr %19, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [900 x double], ptr %79, i64 %81
  %83 = load i32, ptr %20, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds [900 x double], ptr %82, i64 0, i64 %84
  store double %78, ptr %85, align 8
  br label %86

86:                                               ; preds = %66
  %87 = load i32, ptr %20, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %20, align 4
  br label %62, !llvm.loop !9

89:                                               ; preds = %62
  br label %90

90:                                               ; preds = %89
  %91 = load i32, ptr %19, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, ptr %19, align 4
  br label %57, !llvm.loop !10

93:                                               ; preds = %57
  store i32 0, ptr %19, align 4
  br label %94

94:                                               ; preds = %126, %93
  %95 = load i32, ptr %19, align 4
  %96 = load i32, ptr %11, align 4
  %97 = icmp slt i32 %95, %96
  br i1 %97, label %98, label %129

98:                                               ; preds = %94
  store i32 0, ptr %20, align 4
  br label %99

99:                                               ; preds = %122, %98
  %100 = load i32, ptr %20, align 4
  %101 = load i32, ptr %14, align 4
  %102 = icmp slt i32 %100, %101
  br i1 %102, label %103, label %125

103:                                              ; preds = %99
  %104 = load i32, ptr %19, align 4
  %105 = load i32, ptr %20, align 4
  %106 = add nsw i32 %105, 3
  %107 = mul nsw i32 %104, %106
  %108 = load i32, ptr %13, align 4
  %109 = srem i32 %107, %108
  %110 = sitofp i32 %109 to double
  %111 = load i32, ptr %13, align 4
  %112 = mul nsw i32 5, %111
  %113 = sitofp i32 %112 to double
  %114 = fdiv double %110, %113
  %115 = load ptr, ptr %17, align 8
  %116 = load i32, ptr %19, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds [1200 x double], ptr %115, i64 %117
  %119 = load i32, ptr %20, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [1200 x double], ptr %118, i64 0, i64 %120
  store double %114, ptr %121, align 8
  br label %122

122:                                              ; preds = %103
  %123 = load i32, ptr %20, align 4
  %124 = add nsw i32 %123, 1
  store i32 %124, ptr %20, align 4
  br label %99, !llvm.loop !11

125:                                              ; preds = %99
  br label %126

126:                                              ; preds = %125
  %127 = load i32, ptr %19, align 4
  %128 = add nsw i32 %127, 1
  store i32 %128, ptr %19, align 4
  br label %94, !llvm.loop !12

129:                                              ; preds = %94
  store i32 0, ptr %19, align 4
  br label %130

130:                                              ; preds = %163, %129
  %131 = load i32, ptr %19, align 4
  %132 = load i32, ptr %14, align 4
  %133 = icmp slt i32 %131, %132
  br i1 %133, label %134, label %166

134:                                              ; preds = %130
  store i32 0, ptr %20, align 4
  br label %135

135:                                              ; preds = %159, %134
  %136 = load i32, ptr %20, align 4
  %137 = load i32, ptr %13, align 4
  %138 = icmp slt i32 %136, %137
  br i1 %138, label %139, label %162

139:                                              ; preds = %135
  %140 = load i32, ptr %19, align 4
  %141 = load i32, ptr %20, align 4
  %142 = add nsw i32 %141, 2
  %143 = mul nsw i32 %140, %142
  %144 = add nsw i32 %143, 2
  %145 = load i32, ptr %12, align 4
  %146 = srem i32 %144, %145
  %147 = sitofp i32 %146 to double
  %148 = load i32, ptr %12, align 4
  %149 = mul nsw i32 5, %148
  %150 = sitofp i32 %149 to double
  %151 = fdiv double %147, %150
  %152 = load ptr, ptr %18, align 8
  %153 = load i32, ptr %19, align 4
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds [1100 x double], ptr %152, i64 %154
  %156 = load i32, ptr %20, align 4
  %157 = sext i32 %156 to i64
  %158 = getelementptr inbounds [1100 x double], ptr %155, i64 0, i64 %157
  store double %151, ptr %158, align 8
  br label %159

159:                                              ; preds = %139
  %160 = load i32, ptr %20, align 4
  %161 = add nsw i32 %160, 1
  store i32 %161, ptr %20, align 4
  br label %135, !llvm.loop !13

162:                                              ; preds = %135
  br label %163

163:                                              ; preds = %162
  %164 = load i32, ptr %19, align 4
  %165 = add nsw i32 %164, 1
  store i32 %165, ptr %19, align 4
  br label %130, !llvm.loop !14

166:                                              ; preds = %130
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_3mm(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, ptr noundef %5, ptr noundef %6, ptr noundef %7, ptr noundef %8, ptr noundef %9, ptr noundef %10, ptr noundef %11) #0 {
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca ptr, align 8
  %19 = alloca ptr, align 8
  %20 = alloca ptr, align 8
  %21 = alloca ptr, align 8
  %22 = alloca ptr, align 8
  %23 = alloca ptr, align 8
  %24 = alloca ptr, align 8
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  store i32 %0, ptr %13, align 4
  store i32 %1, ptr %14, align 4
  store i32 %2, ptr %15, align 4
  store i32 %3, ptr %16, align 4
  store i32 %4, ptr %17, align 4
  store ptr %5, ptr %18, align 8
  store ptr %6, ptr %19, align 8
  store ptr %7, ptr %20, align 8
  store ptr %8, ptr %21, align 8
  store ptr %9, ptr %22, align 8
  store ptr %10, ptr %23, align 8
  store ptr %11, ptr %24, align 8
  store i32 0, ptr %25, align 4
  br label %28

28:                                               ; preds = %83, %12
  %29 = load i32, ptr %25, align 4
  %30 = load i32, ptr %13, align 4
  %31 = icmp slt i32 %29, %30
  br i1 %31, label %32, label %86

32:                                               ; preds = %28
  store i32 0, ptr %26, align 4
  br label %33

33:                                               ; preds = %79, %32
  %34 = load i32, ptr %26, align 4
  %35 = load i32, ptr %14, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %82

37:                                               ; preds = %33
  %38 = load ptr, ptr %18, align 8
  %39 = load i32, ptr %25, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [900 x double], ptr %38, i64 %40
  %42 = load i32, ptr %26, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [900 x double], ptr %41, i64 0, i64 %43
  store double 0.000000e+00, ptr %44, align 8
  store i32 0, ptr %27, align 4
  br label %45

45:                                               ; preds = %75, %37
  %46 = load i32, ptr %27, align 4
  %47 = load i32, ptr %15, align 4
  %48 = icmp slt i32 %46, %47
  br i1 %48, label %49, label %78

49:                                               ; preds = %45
  %50 = load ptr, ptr %19, align 8
  %51 = load i32, ptr %25, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [1000 x double], ptr %50, i64 %52
  %54 = load i32, ptr %27, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [1000 x double], ptr %53, i64 0, i64 %55
  %57 = load double, ptr %56, align 8
  %58 = load ptr, ptr %20, align 8
  %59 = load i32, ptr %27, align 4
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [900 x double], ptr %58, i64 %60
  %62 = load i32, ptr %26, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [900 x double], ptr %61, i64 0, i64 %63
  %65 = load double, ptr %64, align 8
  %66 = load ptr, ptr %18, align 8
  %67 = load i32, ptr %25, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [900 x double], ptr %66, i64 %68
  %70 = load i32, ptr %26, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [900 x double], ptr %69, i64 0, i64 %71
  %73 = load double, ptr %72, align 8
  %74 = call double @llvm.fmuladd.f64(double %57, double %65, double %73)
  store double %74, ptr %72, align 8
  br label %75

75:                                               ; preds = %49
  %76 = load i32, ptr %27, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, ptr %27, align 4
  br label %45, !llvm.loop !15

78:                                               ; preds = %45
  br label %79

79:                                               ; preds = %78
  %80 = load i32, ptr %26, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, ptr %26, align 4
  br label %33, !llvm.loop !16

82:                                               ; preds = %33
  br label %83

83:                                               ; preds = %82
  %84 = load i32, ptr %25, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, ptr %25, align 4
  br label %28, !llvm.loop !17

86:                                               ; preds = %28
  store i32 0, ptr %25, align 4
  br label %87

87:                                               ; preds = %142, %86
  %88 = load i32, ptr %25, align 4
  %89 = load i32, ptr %14, align 4
  %90 = icmp slt i32 %88, %89
  br i1 %90, label %91, label %145

91:                                               ; preds = %87
  store i32 0, ptr %26, align 4
  br label %92

92:                                               ; preds = %138, %91
  %93 = load i32, ptr %26, align 4
  %94 = load i32, ptr %16, align 4
  %95 = icmp slt i32 %93, %94
  br i1 %95, label %96, label %141

96:                                               ; preds = %92
  %97 = load ptr, ptr %21, align 8
  %98 = load i32, ptr %25, align 4
  %99 = sext i32 %98 to i64
  %100 = getelementptr inbounds [1100 x double], ptr %97, i64 %99
  %101 = load i32, ptr %26, align 4
  %102 = sext i32 %101 to i64
  %103 = getelementptr inbounds [1100 x double], ptr %100, i64 0, i64 %102
  store double 0.000000e+00, ptr %103, align 8
  store i32 0, ptr %27, align 4
  br label %104

104:                                              ; preds = %134, %96
  %105 = load i32, ptr %27, align 4
  %106 = load i32, ptr %17, align 4
  %107 = icmp slt i32 %105, %106
  br i1 %107, label %108, label %137

108:                                              ; preds = %104
  %109 = load ptr, ptr %22, align 8
  %110 = load i32, ptr %25, align 4
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds [1200 x double], ptr %109, i64 %111
  %113 = load i32, ptr %27, align 4
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds [1200 x double], ptr %112, i64 0, i64 %114
  %116 = load double, ptr %115, align 8
  %117 = load ptr, ptr %23, align 8
  %118 = load i32, ptr %27, align 4
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds [1100 x double], ptr %117, i64 %119
  %121 = load i32, ptr %26, align 4
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds [1100 x double], ptr %120, i64 0, i64 %122
  %124 = load double, ptr %123, align 8
  %125 = load ptr, ptr %21, align 8
  %126 = load i32, ptr %25, align 4
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds [1100 x double], ptr %125, i64 %127
  %129 = load i32, ptr %26, align 4
  %130 = sext i32 %129 to i64
  %131 = getelementptr inbounds [1100 x double], ptr %128, i64 0, i64 %130
  %132 = load double, ptr %131, align 8
  %133 = call double @llvm.fmuladd.f64(double %116, double %124, double %132)
  store double %133, ptr %131, align 8
  br label %134

134:                                              ; preds = %108
  %135 = load i32, ptr %27, align 4
  %136 = add nsw i32 %135, 1
  store i32 %136, ptr %27, align 4
  br label %104, !llvm.loop !18

137:                                              ; preds = %104
  br label %138

138:                                              ; preds = %137
  %139 = load i32, ptr %26, align 4
  %140 = add nsw i32 %139, 1
  store i32 %140, ptr %26, align 4
  br label %92, !llvm.loop !19

141:                                              ; preds = %92
  br label %142

142:                                              ; preds = %141
  %143 = load i32, ptr %25, align 4
  %144 = add nsw i32 %143, 1
  store i32 %144, ptr %25, align 4
  br label %87, !llvm.loop !20

145:                                              ; preds = %87
  store i32 0, ptr %25, align 4
  br label %146

146:                                              ; preds = %201, %145
  %147 = load i32, ptr %25, align 4
  %148 = load i32, ptr %13, align 4
  %149 = icmp slt i32 %147, %148
  br i1 %149, label %150, label %204

150:                                              ; preds = %146
  store i32 0, ptr %26, align 4
  br label %151

151:                                              ; preds = %197, %150
  %152 = load i32, ptr %26, align 4
  %153 = load i32, ptr %16, align 4
  %154 = icmp slt i32 %152, %153
  br i1 %154, label %155, label %200

155:                                              ; preds = %151
  %156 = load ptr, ptr %24, align 8
  %157 = load i32, ptr %25, align 4
  %158 = sext i32 %157 to i64
  %159 = getelementptr inbounds [1100 x double], ptr %156, i64 %158
  %160 = load i32, ptr %26, align 4
  %161 = sext i32 %160 to i64
  %162 = getelementptr inbounds [1100 x double], ptr %159, i64 0, i64 %161
  store double 0.000000e+00, ptr %162, align 8
  store i32 0, ptr %27, align 4
  br label %163

163:                                              ; preds = %193, %155
  %164 = load i32, ptr %27, align 4
  %165 = load i32, ptr %14, align 4
  %166 = icmp slt i32 %164, %165
  br i1 %166, label %167, label %196

167:                                              ; preds = %163
  %168 = load ptr, ptr %18, align 8
  %169 = load i32, ptr %25, align 4
  %170 = sext i32 %169 to i64
  %171 = getelementptr inbounds [900 x double], ptr %168, i64 %170
  %172 = load i32, ptr %27, align 4
  %173 = sext i32 %172 to i64
  %174 = getelementptr inbounds [900 x double], ptr %171, i64 0, i64 %173
  %175 = load double, ptr %174, align 8
  %176 = load ptr, ptr %21, align 8
  %177 = load i32, ptr %27, align 4
  %178 = sext i32 %177 to i64
  %179 = getelementptr inbounds [1100 x double], ptr %176, i64 %178
  %180 = load i32, ptr %26, align 4
  %181 = sext i32 %180 to i64
  %182 = getelementptr inbounds [1100 x double], ptr %179, i64 0, i64 %181
  %183 = load double, ptr %182, align 8
  %184 = load ptr, ptr %24, align 8
  %185 = load i32, ptr %25, align 4
  %186 = sext i32 %185 to i64
  %187 = getelementptr inbounds [1100 x double], ptr %184, i64 %186
  %188 = load i32, ptr %26, align 4
  %189 = sext i32 %188 to i64
  %190 = getelementptr inbounds [1100 x double], ptr %187, i64 0, i64 %189
  %191 = load double, ptr %190, align 8
  %192 = call double @llvm.fmuladd.f64(double %175, double %183, double %191)
  store double %192, ptr %190, align 8
  br label %193

193:                                              ; preds = %167
  %194 = load i32, ptr %27, align 4
  %195 = add nsw i32 %194, 1
  store i32 %195, ptr %27, align 4
  br label %163, !llvm.loop !21

196:                                              ; preds = %163
  br label %197

197:                                              ; preds = %196
  %198 = load i32, ptr %26, align 4
  %199 = add nsw i32 %198, 1
  store i32 %199, ptr %26, align 4
  br label %151, !llvm.loop !22

200:                                              ; preds = %151
  br label %201

201:                                              ; preds = %200
  %202 = load i32, ptr %25, align 4
  %203 = add nsw i32 %202, 1
  store i32 %203, ptr %25, align 4
  br label %146, !llvm.loop !23

204:                                              ; preds = %146
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, i32 noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store ptr %2, ptr %6, align 8
  %9 = load ptr, ptr @stderr, align 8
  %10 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %9, ptr noundef @.str.1)
  %11 = load ptr, ptr @stderr, align 8
  %12 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %11, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %7, align 4
  br label %13

13:                                               ; preds = %48, %3
  %14 = load i32, ptr %7, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %51

17:                                               ; preds = %13
  store i32 0, ptr %8, align 4
  br label %18

18:                                               ; preds = %44, %17
  %19 = load i32, ptr %8, align 4
  %20 = load i32, ptr %5, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %47

22:                                               ; preds = %18
  %23 = load i32, ptr %7, align 4
  %24 = load i32, ptr %4, align 4
  %25 = mul nsw i32 %23, %24
  %26 = load i32, ptr %8, align 4
  %27 = add nsw i32 %25, %26
  %28 = srem i32 %27, 20
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %30, label %33

30:                                               ; preds = %22
  %31 = load ptr, ptr @stderr, align 8
  %32 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %31, ptr noundef @.str.4)
  br label %33

33:                                               ; preds = %30, %22
  %34 = load ptr, ptr @stderr, align 8
  %35 = load ptr, ptr %6, align 8
  %36 = load i32, ptr %7, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [1100 x double], ptr %35, i64 %37
  %39 = load i32, ptr %8, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [1100 x double], ptr %38, i64 0, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %34, ptr noundef @.str.5, double noundef %42)
  br label %44

44:                                               ; preds = %33
  %45 = load i32, ptr %8, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %8, align 4
  br label %18, !llvm.loop !24

47:                                               ; preds = %18
  br label %48

48:                                               ; preds = %47
  %49 = load i32, ptr %7, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %7, align 4
  br label %13, !llvm.loop !25

51:                                               ; preds = %13
  %52 = load ptr, ptr @stderr, align 8
  %53 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %52, ptr noundef @.str.6, ptr noundef @.str.3)
  %54 = load ptr, ptr @stderr, align 8
  %55 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %54, ptr noundef @.str.7)
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
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
!24 = distinct !{!24, !7}
!25 = distinct !{!25, !7}
