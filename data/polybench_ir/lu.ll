; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/solvers/lu/lu.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/solvers/lu/lu.c"
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
  %7 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 2000, ptr %6, align 4
  %8 = call ptr @polybench_alloc_data(i64 noundef 4000000, i32 noundef 8)
  store ptr %8, ptr %7, align 8
  %9 = load i32, ptr %6, align 4
  %10 = load ptr, ptr %7, align 8
  %11 = getelementptr inbounds [2000 x [2000 x double]], ptr %10, i64 0, i64 0
  call void @init_array(i32 noundef %9, ptr noundef %11)
  %12 = load i32, ptr %6, align 4
  %13 = load ptr, ptr %7, align 8
  %14 = getelementptr inbounds [2000 x [2000 x double]], ptr %13, i64 0, i64 0
  call void @kernel_lu(i32 noundef %12, ptr noundef %14)
  %15 = load i32, ptr %4, align 4
  %16 = icmp sgt i32 %15, 42
  br i1 %16, label %17, label %27

17:                                               ; preds = %2
  %18 = load ptr, ptr %5, align 8
  %19 = getelementptr inbounds ptr, ptr %18, i64 0
  %20 = load ptr, ptr %19, align 8
  %21 = call i32 @strcmp(ptr noundef %20, ptr noundef @.str) #5
  %22 = icmp ne i32 %21, 0
  br i1 %22, label %27, label %23

23:                                               ; preds = %17
  %24 = load i32, ptr %6, align 4
  %25 = load ptr, ptr %7, align 8
  %26 = getelementptr inbounds [2000 x [2000 x double]], ptr %25, i64 0, i64 0
  call void @print_array(i32 noundef %24, ptr noundef %26)
  br label %27

27:                                               ; preds = %23, %17, %2
  %28 = load ptr, ptr %7, align 8
  call void @free(ptr noundef %28) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 8
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %11

11:                                               ; preds = %66, %2
  %12 = load i32, ptr %5, align 4
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %69

15:                                               ; preds = %11
  store i32 0, ptr %6, align 4
  br label %16

16:                                               ; preds = %37, %15
  %17 = load i32, ptr %6, align 4
  %18 = load i32, ptr %5, align 4
  %19 = icmp sle i32 %17, %18
  br i1 %19, label %20, label %40

20:                                               ; preds = %16
  %21 = load i32, ptr %6, align 4
  %22 = sub nsw i32 0, %21
  %23 = load i32, ptr %3, align 4
  %24 = srem i32 %22, %23
  %25 = sitofp i32 %24 to double
  %26 = load i32, ptr %3, align 4
  %27 = sitofp i32 %26 to double
  %28 = fdiv double %25, %27
  %29 = fadd double %28, 1.000000e+00
  %30 = load ptr, ptr %4, align 8
  %31 = load i32, ptr %5, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [2000 x double], ptr %30, i64 %32
  %34 = load i32, ptr %6, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [2000 x double], ptr %33, i64 0, i64 %35
  store double %29, ptr %36, align 8
  br label %37

37:                                               ; preds = %20
  %38 = load i32, ptr %6, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %6, align 4
  br label %16, !llvm.loop !6

40:                                               ; preds = %16
  %41 = load i32, ptr %5, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %6, align 4
  br label %43

43:                                               ; preds = %55, %40
  %44 = load i32, ptr %6, align 4
  %45 = load i32, ptr %3, align 4
  %46 = icmp slt i32 %44, %45
  br i1 %46, label %47, label %58

47:                                               ; preds = %43
  %48 = load ptr, ptr %4, align 8
  %49 = load i32, ptr %5, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [2000 x double], ptr %48, i64 %50
  %52 = load i32, ptr %6, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [2000 x double], ptr %51, i64 0, i64 %53
  store double 0.000000e+00, ptr %54, align 8
  br label %55

55:                                               ; preds = %47
  %56 = load i32, ptr %6, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %6, align 4
  br label %43, !llvm.loop !8

58:                                               ; preds = %43
  %59 = load ptr, ptr %4, align 8
  %60 = load i32, ptr %5, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [2000 x double], ptr %59, i64 %61
  %63 = load i32, ptr %5, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds [2000 x double], ptr %62, i64 0, i64 %64
  store double 1.000000e+00, ptr %65, align 8
  br label %66

66:                                               ; preds = %58
  %67 = load i32, ptr %5, align 4
  %68 = add nsw i32 %67, 1
  store i32 %68, ptr %5, align 4
  br label %11, !llvm.loop !9

69:                                               ; preds = %11
  %70 = call ptr @polybench_alloc_data(i64 noundef 4000000, i32 noundef 8)
  store ptr %70, ptr %10, align 8
  store i32 0, ptr %7, align 4
  br label %71

71:                                               ; preds = %92, %69
  %72 = load i32, ptr %7, align 4
  %73 = load i32, ptr %3, align 4
  %74 = icmp slt i32 %72, %73
  br i1 %74, label %75, label %95

75:                                               ; preds = %71
  store i32 0, ptr %8, align 4
  br label %76

76:                                               ; preds = %88, %75
  %77 = load i32, ptr %8, align 4
  %78 = load i32, ptr %3, align 4
  %79 = icmp slt i32 %77, %78
  br i1 %79, label %80, label %91

80:                                               ; preds = %76
  %81 = load ptr, ptr %10, align 8
  %82 = load i32, ptr %7, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [2000 x [2000 x double]], ptr %81, i64 0, i64 %83
  %85 = load i32, ptr %8, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [2000 x double], ptr %84, i64 0, i64 %86
  store double 0.000000e+00, ptr %87, align 8
  br label %88

88:                                               ; preds = %80
  %89 = load i32, ptr %8, align 4
  %90 = add nsw i32 %89, 1
  store i32 %90, ptr %8, align 4
  br label %76, !llvm.loop !10

91:                                               ; preds = %76
  br label %92

92:                                               ; preds = %91
  %93 = load i32, ptr %7, align 4
  %94 = add nsw i32 %93, 1
  store i32 %94, ptr %7, align 4
  br label %71, !llvm.loop !11

95:                                               ; preds = %71
  store i32 0, ptr %9, align 4
  br label %96

96:                                               ; preds = %144, %95
  %97 = load i32, ptr %9, align 4
  %98 = load i32, ptr %3, align 4
  %99 = icmp slt i32 %97, %98
  br i1 %99, label %100, label %147

100:                                              ; preds = %96
  store i32 0, ptr %7, align 4
  br label %101

101:                                              ; preds = %140, %100
  %102 = load i32, ptr %7, align 4
  %103 = load i32, ptr %3, align 4
  %104 = icmp slt i32 %102, %103
  br i1 %104, label %105, label %143

105:                                              ; preds = %101
  store i32 0, ptr %8, align 4
  br label %106

106:                                              ; preds = %136, %105
  %107 = load i32, ptr %8, align 4
  %108 = load i32, ptr %3, align 4
  %109 = icmp slt i32 %107, %108
  br i1 %109, label %110, label %139

110:                                              ; preds = %106
  %111 = load ptr, ptr %4, align 8
  %112 = load i32, ptr %7, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [2000 x double], ptr %111, i64 %113
  %115 = load i32, ptr %9, align 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds [2000 x double], ptr %114, i64 0, i64 %116
  %118 = load double, ptr %117, align 8
  %119 = load ptr, ptr %4, align 8
  %120 = load i32, ptr %8, align 4
  %121 = sext i32 %120 to i64
  %122 = getelementptr inbounds [2000 x double], ptr %119, i64 %121
  %123 = load i32, ptr %9, align 4
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds [2000 x double], ptr %122, i64 0, i64 %124
  %126 = load double, ptr %125, align 8
  %127 = load ptr, ptr %10, align 8
  %128 = load i32, ptr %7, align 4
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds [2000 x [2000 x double]], ptr %127, i64 0, i64 %129
  %131 = load i32, ptr %8, align 4
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds [2000 x double], ptr %130, i64 0, i64 %132
  %134 = load double, ptr %133, align 8
  %135 = call double @llvm.fmuladd.f64(double %118, double %126, double %134)
  store double %135, ptr %133, align 8
  br label %136

136:                                              ; preds = %110
  %137 = load i32, ptr %8, align 4
  %138 = add nsw i32 %137, 1
  store i32 %138, ptr %8, align 4
  br label %106, !llvm.loop !12

139:                                              ; preds = %106
  br label %140

140:                                              ; preds = %139
  %141 = load i32, ptr %7, align 4
  %142 = add nsw i32 %141, 1
  store i32 %142, ptr %7, align 4
  br label %101, !llvm.loop !13

143:                                              ; preds = %101
  br label %144

144:                                              ; preds = %143
  %145 = load i32, ptr %9, align 4
  %146 = add nsw i32 %145, 1
  store i32 %146, ptr %9, align 4
  br label %96, !llvm.loop !14

147:                                              ; preds = %96
  store i32 0, ptr %7, align 4
  br label %148

148:                                              ; preds = %177, %147
  %149 = load i32, ptr %7, align 4
  %150 = load i32, ptr %3, align 4
  %151 = icmp slt i32 %149, %150
  br i1 %151, label %152, label %180

152:                                              ; preds = %148
  store i32 0, ptr %8, align 4
  br label %153

153:                                              ; preds = %173, %152
  %154 = load i32, ptr %8, align 4
  %155 = load i32, ptr %3, align 4
  %156 = icmp slt i32 %154, %155
  br i1 %156, label %157, label %176

157:                                              ; preds = %153
  %158 = load ptr, ptr %10, align 8
  %159 = load i32, ptr %7, align 4
  %160 = sext i32 %159 to i64
  %161 = getelementptr inbounds [2000 x [2000 x double]], ptr %158, i64 0, i64 %160
  %162 = load i32, ptr %8, align 4
  %163 = sext i32 %162 to i64
  %164 = getelementptr inbounds [2000 x double], ptr %161, i64 0, i64 %163
  %165 = load double, ptr %164, align 8
  %166 = load ptr, ptr %4, align 8
  %167 = load i32, ptr %7, align 4
  %168 = sext i32 %167 to i64
  %169 = getelementptr inbounds [2000 x double], ptr %166, i64 %168
  %170 = load i32, ptr %8, align 4
  %171 = sext i32 %170 to i64
  %172 = getelementptr inbounds [2000 x double], ptr %169, i64 0, i64 %171
  store double %165, ptr %172, align 8
  br label %173

173:                                              ; preds = %157
  %174 = load i32, ptr %8, align 4
  %175 = add nsw i32 %174, 1
  store i32 %175, ptr %8, align 4
  br label %153, !llvm.loop !15

176:                                              ; preds = %153
  br label %177

177:                                              ; preds = %176
  %178 = load i32, ptr %7, align 4
  %179 = add nsw i32 %178, 1
  store i32 %179, ptr %7, align 4
  br label %148, !llvm.loop !16

180:                                              ; preds = %148
  %181 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %181) #6
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_lu(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %8

8:                                                ; preds = %119, %2
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %3, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %122

12:                                               ; preds = %8
  store i32 0, ptr %6, align 4
  br label %13

13:                                               ; preds = %70, %12
  %14 = load i32, ptr %6, align 4
  %15 = load i32, ptr %5, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %73

17:                                               ; preds = %13
  store i32 0, ptr %7, align 4
  br label %18

18:                                               ; preds = %49, %17
  %19 = load i32, ptr %7, align 4
  %20 = load i32, ptr %6, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %52

22:                                               ; preds = %18
  %23 = load ptr, ptr %4, align 8
  %24 = load i32, ptr %5, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [2000 x double], ptr %23, i64 %25
  %27 = load i32, ptr %7, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [2000 x double], ptr %26, i64 0, i64 %28
  %30 = load double, ptr %29, align 8
  %31 = load ptr, ptr %4, align 8
  %32 = load i32, ptr %7, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [2000 x double], ptr %31, i64 %33
  %35 = load i32, ptr %6, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [2000 x double], ptr %34, i64 0, i64 %36
  %38 = load double, ptr %37, align 8
  %39 = load ptr, ptr %4, align 8
  %40 = load i32, ptr %5, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [2000 x double], ptr %39, i64 %41
  %43 = load i32, ptr %6, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [2000 x double], ptr %42, i64 0, i64 %44
  %46 = load double, ptr %45, align 8
  %47 = fneg double %30
  %48 = call double @llvm.fmuladd.f64(double %47, double %38, double %46)
  store double %48, ptr %45, align 8
  br label %49

49:                                               ; preds = %22
  %50 = load i32, ptr %7, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %7, align 4
  br label %18, !llvm.loop !17

52:                                               ; preds = %18
  %53 = load ptr, ptr %4, align 8
  %54 = load i32, ptr %6, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [2000 x double], ptr %53, i64 %55
  %57 = load i32, ptr %6, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds [2000 x double], ptr %56, i64 0, i64 %58
  %60 = load double, ptr %59, align 8
  %61 = load ptr, ptr %4, align 8
  %62 = load i32, ptr %5, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [2000 x double], ptr %61, i64 %63
  %65 = load i32, ptr %6, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [2000 x double], ptr %64, i64 0, i64 %66
  %68 = load double, ptr %67, align 8
  %69 = fdiv double %68, %60
  store double %69, ptr %67, align 8
  br label %70

70:                                               ; preds = %52
  %71 = load i32, ptr %6, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, ptr %6, align 4
  br label %13, !llvm.loop !18

73:                                               ; preds = %13
  %74 = load i32, ptr %5, align 4
  store i32 %74, ptr %6, align 4
  br label %75

75:                                               ; preds = %115, %73
  %76 = load i32, ptr %6, align 4
  %77 = load i32, ptr %3, align 4
  %78 = icmp slt i32 %76, %77
  br i1 %78, label %79, label %118

79:                                               ; preds = %75
  store i32 0, ptr %7, align 4
  br label %80

80:                                               ; preds = %111, %79
  %81 = load i32, ptr %7, align 4
  %82 = load i32, ptr %5, align 4
  %83 = icmp slt i32 %81, %82
  br i1 %83, label %84, label %114

84:                                               ; preds = %80
  %85 = load ptr, ptr %4, align 8
  %86 = load i32, ptr %5, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds [2000 x double], ptr %85, i64 %87
  %89 = load i32, ptr %7, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds [2000 x double], ptr %88, i64 0, i64 %90
  %92 = load double, ptr %91, align 8
  %93 = load ptr, ptr %4, align 8
  %94 = load i32, ptr %7, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [2000 x double], ptr %93, i64 %95
  %97 = load i32, ptr %6, align 4
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [2000 x double], ptr %96, i64 0, i64 %98
  %100 = load double, ptr %99, align 8
  %101 = load ptr, ptr %4, align 8
  %102 = load i32, ptr %5, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds [2000 x double], ptr %101, i64 %103
  %105 = load i32, ptr %6, align 4
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds [2000 x double], ptr %104, i64 0, i64 %106
  %108 = load double, ptr %107, align 8
  %109 = fneg double %92
  %110 = call double @llvm.fmuladd.f64(double %109, double %100, double %108)
  store double %110, ptr %107, align 8
  br label %111

111:                                              ; preds = %84
  %112 = load i32, ptr %7, align 4
  %113 = add nsw i32 %112, 1
  store i32 %113, ptr %7, align 4
  br label %80, !llvm.loop !19

114:                                              ; preds = %80
  br label %115

115:                                              ; preds = %114
  %116 = load i32, ptr %6, align 4
  %117 = add nsw i32 %116, 1
  store i32 %117, ptr %6, align 4
  br label %75, !llvm.loop !20

118:                                              ; preds = %75
  br label %119

119:                                              ; preds = %118
  %120 = load i32, ptr %5, align 4
  %121 = add nsw i32 %120, 1
  store i32 %121, ptr %5, align 4
  br label %8, !llvm.loop !21

122:                                              ; preds = %8
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
  %36 = getelementptr inbounds [2000 x double], ptr %33, i64 %35
  %37 = load i32, ptr %6, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [2000 x double], ptr %36, i64 0, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %32, ptr noundef @.str.5, double noundef %40)
  br label %42

42:                                               ; preds = %31
  %43 = load i32, ptr %6, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %6, align 4
  br label %16, !llvm.loop !22

45:                                               ; preds = %16
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %5, align 4
  br label %11, !llvm.loop !23

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
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
