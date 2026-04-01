; ModuleID = '/code/data/webassembly-polybench-c-master/linear-algebra/solvers/ludcmp/ludcmp.c'
source_filename = "/code/data/webassembly-polybench-c-master/linear-algebra/solvers/ludcmp/ludcmp.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"x\00", align 1
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
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 2000, ptr %6, align 4
  %11 = call ptr @polybench_alloc_data(i64 noundef 4000000, i32 noundef 8)
  store ptr %11, ptr %7, align 8
  %12 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %12, ptr %8, align 8
  %13 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %13, ptr %9, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8)
  store ptr %14, ptr %10, align 8
  %15 = load i32, ptr %6, align 4
  %16 = load ptr, ptr %7, align 8
  %17 = getelementptr inbounds [2000 x [2000 x double]], ptr %16, i64 0, i64 0
  %18 = load ptr, ptr %8, align 8
  %19 = getelementptr inbounds [2000 x double], ptr %18, i64 0, i64 0
  %20 = load ptr, ptr %9, align 8
  %21 = getelementptr inbounds [2000 x double], ptr %20, i64 0, i64 0
  %22 = load ptr, ptr %10, align 8
  %23 = getelementptr inbounds [2000 x double], ptr %22, i64 0, i64 0
  call void @init_array(i32 noundef %15, ptr noundef %17, ptr noundef %19, ptr noundef %21, ptr noundef %23)
  %24 = load i32, ptr %6, align 4
  %25 = load ptr, ptr %7, align 8
  %26 = getelementptr inbounds [2000 x [2000 x double]], ptr %25, i64 0, i64 0
  %27 = load ptr, ptr %8, align 8
  %28 = getelementptr inbounds [2000 x double], ptr %27, i64 0, i64 0
  %29 = load ptr, ptr %9, align 8
  %30 = getelementptr inbounds [2000 x double], ptr %29, i64 0, i64 0
  %31 = load ptr, ptr %10, align 8
  %32 = getelementptr inbounds [2000 x double], ptr %31, i64 0, i64 0
  call void @kernel_ludcmp(i32 noundef %24, ptr noundef %26, ptr noundef %28, ptr noundef %30, ptr noundef %32)
  %33 = load i32, ptr %4, align 4
  %34 = icmp sgt i32 %33, 42
  br i1 %34, label %35, label %45

35:                                               ; preds = %2
  %36 = load ptr, ptr %5, align 8
  %37 = getelementptr inbounds ptr, ptr %36, i64 0
  %38 = load ptr, ptr %37, align 8
  %39 = call i32 @strcmp(ptr noundef %38, ptr noundef @.str) #5
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %45, label %41

41:                                               ; preds = %35
  %42 = load i32, ptr %6, align 4
  %43 = load ptr, ptr %9, align 8
  %44 = getelementptr inbounds [2000 x double], ptr %43, i64 0, i64 0
  call void @print_array(i32 noundef %42, ptr noundef %44)
  br label %45

45:                                               ; preds = %41, %35, %2
  %46 = load ptr, ptr %7, align 8
  call void @free(ptr noundef %46) #6
  %47 = load ptr, ptr %8, align 8
  call void @free(ptr noundef %47) #6
  %48 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %48) #6
  %49 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %49) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca double, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca ptr, align 8
  store i32 %0, ptr %6, align 4
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  store ptr %4, ptr %10, align 8
  %18 = load i32, ptr %6, align 4
  %19 = sitofp i32 %18 to double
  store double %19, ptr %13, align 8
  store i32 0, ptr %11, align 4
  br label %20

20:                                               ; preds = %44, %5
  %21 = load i32, ptr %11, align 4
  %22 = load i32, ptr %6, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %47

24:                                               ; preds = %20
  %25 = load ptr, ptr %9, align 8
  %26 = load i32, ptr %11, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds double, ptr %25, i64 %27
  store double 0.000000e+00, ptr %28, align 8
  %29 = load ptr, ptr %10, align 8
  %30 = load i32, ptr %11, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds double, ptr %29, i64 %31
  store double 0.000000e+00, ptr %32, align 8
  %33 = load i32, ptr %11, align 4
  %34 = add nsw i32 %33, 1
  %35 = sitofp i32 %34 to double
  %36 = load double, ptr %13, align 8
  %37 = fdiv double %35, %36
  %38 = fdiv double %37, 2.000000e+00
  %39 = fadd double %38, 4.000000e+00
  %40 = load ptr, ptr %8, align 8
  %41 = load i32, ptr %11, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds double, ptr %40, i64 %42
  store double %39, ptr %43, align 8
  br label %44

44:                                               ; preds = %24
  %45 = load i32, ptr %11, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %11, align 4
  br label %20, !llvm.loop !6

47:                                               ; preds = %20
  store i32 0, ptr %11, align 4
  br label %48

48:                                               ; preds = %103, %47
  %49 = load i32, ptr %11, align 4
  %50 = load i32, ptr %6, align 4
  %51 = icmp slt i32 %49, %50
  br i1 %51, label %52, label %106

52:                                               ; preds = %48
  store i32 0, ptr %12, align 4
  br label %53

53:                                               ; preds = %74, %52
  %54 = load i32, ptr %12, align 4
  %55 = load i32, ptr %11, align 4
  %56 = icmp sle i32 %54, %55
  br i1 %56, label %57, label %77

57:                                               ; preds = %53
  %58 = load i32, ptr %12, align 4
  %59 = sub nsw i32 0, %58
  %60 = load i32, ptr %6, align 4
  %61 = srem i32 %59, %60
  %62 = sitofp i32 %61 to double
  %63 = load i32, ptr %6, align 4
  %64 = sitofp i32 %63 to double
  %65 = fdiv double %62, %64
  %66 = fadd double %65, 1.000000e+00
  %67 = load ptr, ptr %7, align 8
  %68 = load i32, ptr %11, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds [2000 x double], ptr %67, i64 %69
  %71 = load i32, ptr %12, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds [2000 x double], ptr %70, i64 0, i64 %72
  store double %66, ptr %73, align 8
  br label %74

74:                                               ; preds = %57
  %75 = load i32, ptr %12, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, ptr %12, align 4
  br label %53, !llvm.loop !8

77:                                               ; preds = %53
  %78 = load i32, ptr %11, align 4
  %79 = add nsw i32 %78, 1
  store i32 %79, ptr %12, align 4
  br label %80

80:                                               ; preds = %92, %77
  %81 = load i32, ptr %12, align 4
  %82 = load i32, ptr %6, align 4
  %83 = icmp slt i32 %81, %82
  br i1 %83, label %84, label %95

84:                                               ; preds = %80
  %85 = load ptr, ptr %7, align 8
  %86 = load i32, ptr %11, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds [2000 x double], ptr %85, i64 %87
  %89 = load i32, ptr %12, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds [2000 x double], ptr %88, i64 0, i64 %90
  store double 0.000000e+00, ptr %91, align 8
  br label %92

92:                                               ; preds = %84
  %93 = load i32, ptr %12, align 4
  %94 = add nsw i32 %93, 1
  store i32 %94, ptr %12, align 4
  br label %80, !llvm.loop !9

95:                                               ; preds = %80
  %96 = load ptr, ptr %7, align 8
  %97 = load i32, ptr %11, align 4
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [2000 x double], ptr %96, i64 %98
  %100 = load i32, ptr %11, align 4
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds [2000 x double], ptr %99, i64 0, i64 %101
  store double 1.000000e+00, ptr %102, align 8
  br label %103

103:                                              ; preds = %95
  %104 = load i32, ptr %11, align 4
  %105 = add nsw i32 %104, 1
  store i32 %105, ptr %11, align 4
  br label %48, !llvm.loop !10

106:                                              ; preds = %48
  %107 = call ptr @polybench_alloc_data(i64 noundef 4000000, i32 noundef 8)
  store ptr %107, ptr %17, align 8
  store i32 0, ptr %14, align 4
  br label %108

108:                                              ; preds = %129, %106
  %109 = load i32, ptr %14, align 4
  %110 = load i32, ptr %6, align 4
  %111 = icmp slt i32 %109, %110
  br i1 %111, label %112, label %132

112:                                              ; preds = %108
  store i32 0, ptr %15, align 4
  br label %113

113:                                              ; preds = %125, %112
  %114 = load i32, ptr %15, align 4
  %115 = load i32, ptr %6, align 4
  %116 = icmp slt i32 %114, %115
  br i1 %116, label %117, label %128

117:                                              ; preds = %113
  %118 = load ptr, ptr %17, align 8
  %119 = load i32, ptr %14, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [2000 x [2000 x double]], ptr %118, i64 0, i64 %120
  %122 = load i32, ptr %15, align 4
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds [2000 x double], ptr %121, i64 0, i64 %123
  store double 0.000000e+00, ptr %124, align 8
  br label %125

125:                                              ; preds = %117
  %126 = load i32, ptr %15, align 4
  %127 = add nsw i32 %126, 1
  store i32 %127, ptr %15, align 4
  br label %113, !llvm.loop !11

128:                                              ; preds = %113
  br label %129

129:                                              ; preds = %128
  %130 = load i32, ptr %14, align 4
  %131 = add nsw i32 %130, 1
  store i32 %131, ptr %14, align 4
  br label %108, !llvm.loop !12

132:                                              ; preds = %108
  store i32 0, ptr %16, align 4
  br label %133

133:                                              ; preds = %181, %132
  %134 = load i32, ptr %16, align 4
  %135 = load i32, ptr %6, align 4
  %136 = icmp slt i32 %134, %135
  br i1 %136, label %137, label %184

137:                                              ; preds = %133
  store i32 0, ptr %14, align 4
  br label %138

138:                                              ; preds = %177, %137
  %139 = load i32, ptr %14, align 4
  %140 = load i32, ptr %6, align 4
  %141 = icmp slt i32 %139, %140
  br i1 %141, label %142, label %180

142:                                              ; preds = %138
  store i32 0, ptr %15, align 4
  br label %143

143:                                              ; preds = %173, %142
  %144 = load i32, ptr %15, align 4
  %145 = load i32, ptr %6, align 4
  %146 = icmp slt i32 %144, %145
  br i1 %146, label %147, label %176

147:                                              ; preds = %143
  %148 = load ptr, ptr %7, align 8
  %149 = load i32, ptr %14, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds [2000 x double], ptr %148, i64 %150
  %152 = load i32, ptr %16, align 4
  %153 = sext i32 %152 to i64
  %154 = getelementptr inbounds [2000 x double], ptr %151, i64 0, i64 %153
  %155 = load double, ptr %154, align 8
  %156 = load ptr, ptr %7, align 8
  %157 = load i32, ptr %15, align 4
  %158 = sext i32 %157 to i64
  %159 = getelementptr inbounds [2000 x double], ptr %156, i64 %158
  %160 = load i32, ptr %16, align 4
  %161 = sext i32 %160 to i64
  %162 = getelementptr inbounds [2000 x double], ptr %159, i64 0, i64 %161
  %163 = load double, ptr %162, align 8
  %164 = load ptr, ptr %17, align 8
  %165 = load i32, ptr %14, align 4
  %166 = sext i32 %165 to i64
  %167 = getelementptr inbounds [2000 x [2000 x double]], ptr %164, i64 0, i64 %166
  %168 = load i32, ptr %15, align 4
  %169 = sext i32 %168 to i64
  %170 = getelementptr inbounds [2000 x double], ptr %167, i64 0, i64 %169
  %171 = load double, ptr %170, align 8
  %172 = call double @llvm.fmuladd.f64(double %155, double %163, double %171)
  store double %172, ptr %170, align 8
  br label %173

173:                                              ; preds = %147
  %174 = load i32, ptr %15, align 4
  %175 = add nsw i32 %174, 1
  store i32 %175, ptr %15, align 4
  br label %143, !llvm.loop !13

176:                                              ; preds = %143
  br label %177

177:                                              ; preds = %176
  %178 = load i32, ptr %14, align 4
  %179 = add nsw i32 %178, 1
  store i32 %179, ptr %14, align 4
  br label %138, !llvm.loop !14

180:                                              ; preds = %138
  br label %181

181:                                              ; preds = %180
  %182 = load i32, ptr %16, align 4
  %183 = add nsw i32 %182, 1
  store i32 %183, ptr %16, align 4
  br label %133, !llvm.loop !15

184:                                              ; preds = %133
  store i32 0, ptr %14, align 4
  br label %185

185:                                              ; preds = %214, %184
  %186 = load i32, ptr %14, align 4
  %187 = load i32, ptr %6, align 4
  %188 = icmp slt i32 %186, %187
  br i1 %188, label %189, label %217

189:                                              ; preds = %185
  store i32 0, ptr %15, align 4
  br label %190

190:                                              ; preds = %210, %189
  %191 = load i32, ptr %15, align 4
  %192 = load i32, ptr %6, align 4
  %193 = icmp slt i32 %191, %192
  br i1 %193, label %194, label %213

194:                                              ; preds = %190
  %195 = load ptr, ptr %17, align 8
  %196 = load i32, ptr %14, align 4
  %197 = sext i32 %196 to i64
  %198 = getelementptr inbounds [2000 x [2000 x double]], ptr %195, i64 0, i64 %197
  %199 = load i32, ptr %15, align 4
  %200 = sext i32 %199 to i64
  %201 = getelementptr inbounds [2000 x double], ptr %198, i64 0, i64 %200
  %202 = load double, ptr %201, align 8
  %203 = load ptr, ptr %7, align 8
  %204 = load i32, ptr %14, align 4
  %205 = sext i32 %204 to i64
  %206 = getelementptr inbounds [2000 x double], ptr %203, i64 %205
  %207 = load i32, ptr %15, align 4
  %208 = sext i32 %207 to i64
  %209 = getelementptr inbounds [2000 x double], ptr %206, i64 0, i64 %208
  store double %202, ptr %209, align 8
  br label %210

210:                                              ; preds = %194
  %211 = load i32, ptr %15, align 4
  %212 = add nsw i32 %211, 1
  store i32 %212, ptr %15, align 4
  br label %190, !llvm.loop !16

213:                                              ; preds = %190
  br label %214

214:                                              ; preds = %213
  %215 = load i32, ptr %14, align 4
  %216 = add nsw i32 %215, 1
  store i32 %216, ptr %14, align 4
  br label %185, !llvm.loop !17

217:                                              ; preds = %185
  %218 = load ptr, ptr %17, align 8
  call void @free(ptr noundef %218) #6
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_ludcmp(i32 noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca double, align 8
  store i32 %0, ptr %6, align 4
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  store ptr %4, ptr %10, align 8
  store i32 0, ptr %11, align 4
  br label %15

15:                                               ; preds = %136, %5
  %16 = load i32, ptr %11, align 4
  %17 = load i32, ptr %6, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %139

19:                                               ; preds = %15
  store i32 0, ptr %12, align 4
  br label %20

20:                                               ; preds = %78, %19
  %21 = load i32, ptr %12, align 4
  %22 = load i32, ptr %11, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %81

24:                                               ; preds = %20
  %25 = load ptr, ptr %7, align 8
  %26 = load i32, ptr %11, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [2000 x double], ptr %25, i64 %27
  %29 = load i32, ptr %12, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [2000 x double], ptr %28, i64 0, i64 %30
  %32 = load double, ptr %31, align 8
  store double %32, ptr %14, align 8
  store i32 0, ptr %13, align 4
  br label %33

33:                                               ; preds = %57, %24
  %34 = load i32, ptr %13, align 4
  %35 = load i32, ptr %12, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %60

37:                                               ; preds = %33
  %38 = load ptr, ptr %7, align 8
  %39 = load i32, ptr %11, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [2000 x double], ptr %38, i64 %40
  %42 = load i32, ptr %13, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [2000 x double], ptr %41, i64 0, i64 %43
  %45 = load double, ptr %44, align 8
  %46 = load ptr, ptr %7, align 8
  %47 = load i32, ptr %13, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [2000 x double], ptr %46, i64 %48
  %50 = load i32, ptr %12, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [2000 x double], ptr %49, i64 0, i64 %51
  %53 = load double, ptr %52, align 8
  %54 = load double, ptr %14, align 8
  %55 = fneg double %45
  %56 = call double @llvm.fmuladd.f64(double %55, double %53, double %54)
  store double %56, ptr %14, align 8
  br label %57

57:                                               ; preds = %37
  %58 = load i32, ptr %13, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %13, align 4
  br label %33, !llvm.loop !18

60:                                               ; preds = %33
  %61 = load double, ptr %14, align 8
  %62 = load ptr, ptr %7, align 8
  %63 = load i32, ptr %12, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds [2000 x double], ptr %62, i64 %64
  %66 = load i32, ptr %12, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds [2000 x double], ptr %65, i64 0, i64 %67
  %69 = load double, ptr %68, align 8
  %70 = fdiv double %61, %69
  %71 = load ptr, ptr %7, align 8
  %72 = load i32, ptr %11, align 4
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds [2000 x double], ptr %71, i64 %73
  %75 = load i32, ptr %12, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [2000 x double], ptr %74, i64 0, i64 %76
  store double %70, ptr %77, align 8
  br label %78

78:                                               ; preds = %60
  %79 = load i32, ptr %12, align 4
  %80 = add nsw i32 %79, 1
  store i32 %80, ptr %12, align 4
  br label %20, !llvm.loop !19

81:                                               ; preds = %20
  %82 = load i32, ptr %11, align 4
  store i32 %82, ptr %12, align 4
  br label %83

83:                                               ; preds = %132, %81
  %84 = load i32, ptr %12, align 4
  %85 = load i32, ptr %6, align 4
  %86 = icmp slt i32 %84, %85
  br i1 %86, label %87, label %135

87:                                               ; preds = %83
  %88 = load ptr, ptr %7, align 8
  %89 = load i32, ptr %11, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds [2000 x double], ptr %88, i64 %90
  %92 = load i32, ptr %12, align 4
  %93 = sext i32 %92 to i64
  %94 = getelementptr inbounds [2000 x double], ptr %91, i64 0, i64 %93
  %95 = load double, ptr %94, align 8
  store double %95, ptr %14, align 8
  store i32 0, ptr %13, align 4
  br label %96

96:                                               ; preds = %120, %87
  %97 = load i32, ptr %13, align 4
  %98 = load i32, ptr %11, align 4
  %99 = icmp slt i32 %97, %98
  br i1 %99, label %100, label %123

100:                                              ; preds = %96
  %101 = load ptr, ptr %7, align 8
  %102 = load i32, ptr %11, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds [2000 x double], ptr %101, i64 %103
  %105 = load i32, ptr %13, align 4
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds [2000 x double], ptr %104, i64 0, i64 %106
  %108 = load double, ptr %107, align 8
  %109 = load ptr, ptr %7, align 8
  %110 = load i32, ptr %13, align 4
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds [2000 x double], ptr %109, i64 %111
  %113 = load i32, ptr %12, align 4
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds [2000 x double], ptr %112, i64 0, i64 %114
  %116 = load double, ptr %115, align 8
  %117 = load double, ptr %14, align 8
  %118 = fneg double %108
  %119 = call double @llvm.fmuladd.f64(double %118, double %116, double %117)
  store double %119, ptr %14, align 8
  br label %120

120:                                              ; preds = %100
  %121 = load i32, ptr %13, align 4
  %122 = add nsw i32 %121, 1
  store i32 %122, ptr %13, align 4
  br label %96, !llvm.loop !20

123:                                              ; preds = %96
  %124 = load double, ptr %14, align 8
  %125 = load ptr, ptr %7, align 8
  %126 = load i32, ptr %11, align 4
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds [2000 x double], ptr %125, i64 %127
  %129 = load i32, ptr %12, align 4
  %130 = sext i32 %129 to i64
  %131 = getelementptr inbounds [2000 x double], ptr %128, i64 0, i64 %130
  store double %124, ptr %131, align 8
  br label %132

132:                                              ; preds = %123
  %133 = load i32, ptr %12, align 4
  %134 = add nsw i32 %133, 1
  store i32 %134, ptr %12, align 4
  br label %83, !llvm.loop !21

135:                                              ; preds = %83
  br label %136

136:                                              ; preds = %135
  %137 = load i32, ptr %11, align 4
  %138 = add nsw i32 %137, 1
  store i32 %138, ptr %11, align 4
  br label %15, !llvm.loop !22

139:                                              ; preds = %15
  store i32 0, ptr %11, align 4
  br label %140

140:                                              ; preds = %180, %139
  %141 = load i32, ptr %11, align 4
  %142 = load i32, ptr %6, align 4
  %143 = icmp slt i32 %141, %142
  br i1 %143, label %144, label %183

144:                                              ; preds = %140
  %145 = load ptr, ptr %8, align 8
  %146 = load i32, ptr %11, align 4
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds double, ptr %145, i64 %147
  %149 = load double, ptr %148, align 8
  store double %149, ptr %14, align 8
  store i32 0, ptr %12, align 4
  br label %150

150:                                              ; preds = %171, %144
  %151 = load i32, ptr %12, align 4
  %152 = load i32, ptr %11, align 4
  %153 = icmp slt i32 %151, %152
  br i1 %153, label %154, label %174

154:                                              ; preds = %150
  %155 = load ptr, ptr %7, align 8
  %156 = load i32, ptr %11, align 4
  %157 = sext i32 %156 to i64
  %158 = getelementptr inbounds [2000 x double], ptr %155, i64 %157
  %159 = load i32, ptr %12, align 4
  %160 = sext i32 %159 to i64
  %161 = getelementptr inbounds [2000 x double], ptr %158, i64 0, i64 %160
  %162 = load double, ptr %161, align 8
  %163 = load ptr, ptr %10, align 8
  %164 = load i32, ptr %12, align 4
  %165 = sext i32 %164 to i64
  %166 = getelementptr inbounds double, ptr %163, i64 %165
  %167 = load double, ptr %166, align 8
  %168 = load double, ptr %14, align 8
  %169 = fneg double %162
  %170 = call double @llvm.fmuladd.f64(double %169, double %167, double %168)
  store double %170, ptr %14, align 8
  br label %171

171:                                              ; preds = %154
  %172 = load i32, ptr %12, align 4
  %173 = add nsw i32 %172, 1
  store i32 %173, ptr %12, align 4
  br label %150, !llvm.loop !23

174:                                              ; preds = %150
  %175 = load double, ptr %14, align 8
  %176 = load ptr, ptr %10, align 8
  %177 = load i32, ptr %11, align 4
  %178 = sext i32 %177 to i64
  %179 = getelementptr inbounds double, ptr %176, i64 %178
  store double %175, ptr %179, align 8
  br label %180

180:                                              ; preds = %174
  %181 = load i32, ptr %11, align 4
  %182 = add nsw i32 %181, 1
  store i32 %182, ptr %11, align 4
  br label %140, !llvm.loop !24

183:                                              ; preds = %140
  %184 = load i32, ptr %6, align 4
  %185 = sub nsw i32 %184, 1
  store i32 %185, ptr %11, align 4
  br label %186

186:                                              ; preds = %236, %183
  %187 = load i32, ptr %11, align 4
  %188 = icmp sge i32 %187, 0
  br i1 %188, label %189, label %239

189:                                              ; preds = %186
  %190 = load ptr, ptr %10, align 8
  %191 = load i32, ptr %11, align 4
  %192 = sext i32 %191 to i64
  %193 = getelementptr inbounds double, ptr %190, i64 %192
  %194 = load double, ptr %193, align 8
  store double %194, ptr %14, align 8
  %195 = load i32, ptr %11, align 4
  %196 = add nsw i32 %195, 1
  store i32 %196, ptr %12, align 4
  br label %197

197:                                              ; preds = %218, %189
  %198 = load i32, ptr %12, align 4
  %199 = load i32, ptr %6, align 4
  %200 = icmp slt i32 %198, %199
  br i1 %200, label %201, label %221

201:                                              ; preds = %197
  %202 = load ptr, ptr %7, align 8
  %203 = load i32, ptr %11, align 4
  %204 = sext i32 %203 to i64
  %205 = getelementptr inbounds [2000 x double], ptr %202, i64 %204
  %206 = load i32, ptr %12, align 4
  %207 = sext i32 %206 to i64
  %208 = getelementptr inbounds [2000 x double], ptr %205, i64 0, i64 %207
  %209 = load double, ptr %208, align 8
  %210 = load ptr, ptr %9, align 8
  %211 = load i32, ptr %12, align 4
  %212 = sext i32 %211 to i64
  %213 = getelementptr inbounds double, ptr %210, i64 %212
  %214 = load double, ptr %213, align 8
  %215 = load double, ptr %14, align 8
  %216 = fneg double %209
  %217 = call double @llvm.fmuladd.f64(double %216, double %214, double %215)
  store double %217, ptr %14, align 8
  br label %218

218:                                              ; preds = %201
  %219 = load i32, ptr %12, align 4
  %220 = add nsw i32 %219, 1
  store i32 %220, ptr %12, align 4
  br label %197, !llvm.loop !25

221:                                              ; preds = %197
  %222 = load double, ptr %14, align 8
  %223 = load ptr, ptr %7, align 8
  %224 = load i32, ptr %11, align 4
  %225 = sext i32 %224 to i64
  %226 = getelementptr inbounds [2000 x double], ptr %223, i64 %225
  %227 = load i32, ptr %11, align 4
  %228 = sext i32 %227 to i64
  %229 = getelementptr inbounds [2000 x double], ptr %226, i64 0, i64 %228
  %230 = load double, ptr %229, align 8
  %231 = fdiv double %222, %230
  %232 = load ptr, ptr %9, align 8
  %233 = load i32, ptr %11, align 4
  %234 = sext i32 %233 to i64
  %235 = getelementptr inbounds double, ptr %232, i64 %234
  store double %231, ptr %235, align 8
  br label %236

236:                                              ; preds = %221
  %237 = load i32, ptr %11, align 4
  %238 = add nsw i32 %237, -1
  store i32 %238, ptr %11, align 4
  br label %186, !llvm.loop !26

239:                                              ; preds = %186
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
  br label %10, !llvm.loop !27

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
!26 = distinct !{!26, !7}
!27 = distinct !{!27, !7}
