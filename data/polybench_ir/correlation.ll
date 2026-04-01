; ModuleID = '/code/data/webassembly-polybench-c-master/datamining/correlation/correlation.c'
source_filename = "/code/data/webassembly-polybench-c-master/datamining/correlation/correlation.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"corr\00", align 1
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
  %12 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 1400, ptr %6, align 4
  store i32 1200, ptr %7, align 4
  %13 = call ptr @polybench_alloc_data(i64 noundef 1680000, i32 noundef 8)
  store ptr %13, ptr %9, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 1440000, i32 noundef 8)
  store ptr %14, ptr %10, align 8
  %15 = call ptr @polybench_alloc_data(i64 noundef 1200, i32 noundef 8)
  store ptr %15, ptr %11, align 8
  %16 = call ptr @polybench_alloc_data(i64 noundef 1200, i32 noundef 8)
  store ptr %16, ptr %12, align 8
  %17 = load i32, ptr %7, align 4
  %18 = load i32, ptr %6, align 4
  %19 = load ptr, ptr %9, align 8
  %20 = getelementptr inbounds [1400 x [1200 x double]], ptr %19, i64 0, i64 0
  call void @init_array(i32 noundef %17, i32 noundef %18, ptr noundef %8, ptr noundef %20)
  %21 = load i32, ptr %7, align 4
  %22 = load i32, ptr %6, align 4
  %23 = load double, ptr %8, align 8
  %24 = load ptr, ptr %9, align 8
  %25 = getelementptr inbounds [1400 x [1200 x double]], ptr %24, i64 0, i64 0
  %26 = load ptr, ptr %10, align 8
  %27 = getelementptr inbounds [1200 x [1200 x double]], ptr %26, i64 0, i64 0
  %28 = load ptr, ptr %11, align 8
  %29 = getelementptr inbounds [1200 x double], ptr %28, i64 0, i64 0
  %30 = load ptr, ptr %12, align 8
  %31 = getelementptr inbounds [1200 x double], ptr %30, i64 0, i64 0
  call void @kernel_correlation(i32 noundef %21, i32 noundef %22, double noundef %23, ptr noundef %25, ptr noundef %27, ptr noundef %29, ptr noundef %31)
  %32 = load i32, ptr %4, align 4
  %33 = icmp sgt i32 %32, 42
  br i1 %33, label %34, label %44

34:                                               ; preds = %2
  %35 = load ptr, ptr %5, align 8
  %36 = getelementptr inbounds ptr, ptr %35, i64 0
  %37 = load ptr, ptr %36, align 8
  %38 = call i32 @strcmp(ptr noundef %37, ptr noundef @.str) #5
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %44, label %40

40:                                               ; preds = %34
  %41 = load i32, ptr %7, align 4
  %42 = load ptr, ptr %10, align 8
  %43 = getelementptr inbounds [1200 x [1200 x double]], ptr %42, i64 0, i64 0
  call void @print_array(i32 noundef %41, ptr noundef %43)
  br label %44

44:                                               ; preds = %40, %34, %2
  %45 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %45) #6
  %46 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %46) #6
  %47 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %47) #6
  %48 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %48) #6
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
  %11 = load ptr, ptr %7, align 8
  store double 1.400000e+03, ptr %11, align 8
  store i32 0, ptr %9, align 4
  br label %12

12:                                               ; preds = %39, %4
  %13 = load i32, ptr %9, align 4
  %14 = icmp slt i32 %13, 1400
  br i1 %14, label %15, label %42

15:                                               ; preds = %12
  store i32 0, ptr %10, align 4
  br label %16

16:                                               ; preds = %35, %15
  %17 = load i32, ptr %10, align 4
  %18 = icmp slt i32 %17, 1200
  br i1 %18, label %19, label %38

19:                                               ; preds = %16
  %20 = load i32, ptr %9, align 4
  %21 = load i32, ptr %10, align 4
  %22 = mul nsw i32 %20, %21
  %23 = sitofp i32 %22 to double
  %24 = fdiv double %23, 1.200000e+03
  %25 = load i32, ptr %9, align 4
  %26 = sitofp i32 %25 to double
  %27 = fadd double %24, %26
  %28 = load ptr, ptr %8, align 8
  %29 = load i32, ptr %9, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [1200 x double], ptr %28, i64 %30
  %32 = load i32, ptr %10, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [1200 x double], ptr %31, i64 0, i64 %33
  store double %27, ptr %34, align 8
  br label %35

35:                                               ; preds = %19
  %36 = load i32, ptr %10, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %10, align 4
  br label %16, !llvm.loop !6

38:                                               ; preds = %16
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %9, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %9, align 4
  br label %12, !llvm.loop !8

42:                                               ; preds = %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_correlation(i32 noundef %0, i32 noundef %1, double noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca double, align 8
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store double %2, ptr %10, align 8
  store ptr %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store ptr %5, ptr %13, align 8
  store ptr %6, ptr %14, align 8
  store double 1.000000e-01, ptr %18, align 8
  store i32 0, ptr %16, align 4
  br label %19

19:                                               ; preds = %58, %7
  %20 = load i32, ptr %16, align 4
  %21 = load i32, ptr %8, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %61

23:                                               ; preds = %19
  %24 = load ptr, ptr %13, align 8
  %25 = load i32, ptr %16, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds double, ptr %24, i64 %26
  store double 0.000000e+00, ptr %27, align 8
  store i32 0, ptr %15, align 4
  br label %28

28:                                               ; preds = %47, %23
  %29 = load i32, ptr %15, align 4
  %30 = load i32, ptr %9, align 4
  %31 = icmp slt i32 %29, %30
  br i1 %31, label %32, label %50

32:                                               ; preds = %28
  %33 = load ptr, ptr %11, align 8
  %34 = load i32, ptr %15, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [1200 x double], ptr %33, i64 %35
  %37 = load i32, ptr %16, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [1200 x double], ptr %36, i64 0, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = load ptr, ptr %13, align 8
  %42 = load i32, ptr %16, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds double, ptr %41, i64 %43
  %45 = load double, ptr %44, align 8
  %46 = fadd double %45, %40
  store double %46, ptr %44, align 8
  br label %47

47:                                               ; preds = %32
  %48 = load i32, ptr %15, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %15, align 4
  br label %28, !llvm.loop !9

50:                                               ; preds = %28
  %51 = load double, ptr %10, align 8
  %52 = load ptr, ptr %13, align 8
  %53 = load i32, ptr %16, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds double, ptr %52, i64 %54
  %56 = load double, ptr %55, align 8
  %57 = fdiv double %56, %51
  store double %57, ptr %55, align 8
  br label %58

58:                                               ; preds = %50
  %59 = load i32, ptr %16, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %16, align 4
  br label %19, !llvm.loop !10

61:                                               ; preds = %19
  store i32 0, ptr %16, align 4
  br label %62

62:                                               ; preds = %151, %61
  %63 = load i32, ptr %16, align 4
  %64 = load i32, ptr %8, align 4
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %154

66:                                               ; preds = %62
  %67 = load ptr, ptr %14, align 8
  %68 = load i32, ptr %16, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds double, ptr %67, i64 %69
  store double 0.000000e+00, ptr %70, align 8
  store i32 0, ptr %15, align 4
  br label %71

71:                                               ; preds = %110, %66
  %72 = load i32, ptr %15, align 4
  %73 = load i32, ptr %9, align 4
  %74 = icmp slt i32 %72, %73
  br i1 %74, label %75, label %113

75:                                               ; preds = %71
  %76 = load ptr, ptr %11, align 8
  %77 = load i32, ptr %15, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [1200 x double], ptr %76, i64 %78
  %80 = load i32, ptr %16, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [1200 x double], ptr %79, i64 0, i64 %81
  %83 = load double, ptr %82, align 8
  %84 = load ptr, ptr %13, align 8
  %85 = load i32, ptr %16, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds double, ptr %84, i64 %86
  %88 = load double, ptr %87, align 8
  %89 = fsub double %83, %88
  %90 = load ptr, ptr %11, align 8
  %91 = load i32, ptr %15, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [1200 x double], ptr %90, i64 %92
  %94 = load i32, ptr %16, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [1200 x double], ptr %93, i64 0, i64 %95
  %97 = load double, ptr %96, align 8
  %98 = load ptr, ptr %13, align 8
  %99 = load i32, ptr %16, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds double, ptr %98, i64 %100
  %102 = load double, ptr %101, align 8
  %103 = fsub double %97, %102
  %104 = load ptr, ptr %14, align 8
  %105 = load i32, ptr %16, align 4
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds double, ptr %104, i64 %106
  %108 = load double, ptr %107, align 8
  %109 = call double @llvm.fmuladd.f64(double %89, double %103, double %108)
  store double %109, ptr %107, align 8
  br label %110

110:                                              ; preds = %75
  %111 = load i32, ptr %15, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, ptr %15, align 4
  br label %71, !llvm.loop !11

113:                                              ; preds = %71
  %114 = load double, ptr %10, align 8
  %115 = load ptr, ptr %14, align 8
  %116 = load i32, ptr %16, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds double, ptr %115, i64 %117
  %119 = load double, ptr %118, align 8
  %120 = fdiv double %119, %114
  store double %120, ptr %118, align 8
  %121 = load ptr, ptr %14, align 8
  %122 = load i32, ptr %16, align 4
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds double, ptr %121, i64 %123
  %125 = load double, ptr %124, align 8
  %126 = call double @sqrt(double noundef %125) #6
  %127 = load ptr, ptr %14, align 8
  %128 = load i32, ptr %16, align 4
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds double, ptr %127, i64 %129
  store double %126, ptr %130, align 8
  %131 = load ptr, ptr %14, align 8
  %132 = load i32, ptr %16, align 4
  %133 = sext i32 %132 to i64
  %134 = getelementptr inbounds double, ptr %131, i64 %133
  %135 = load double, ptr %134, align 8
  %136 = load double, ptr %18, align 8
  %137 = fcmp ole double %135, %136
  br i1 %137, label %138, label %139

138:                                              ; preds = %113
  br label %145

139:                                              ; preds = %113
  %140 = load ptr, ptr %14, align 8
  %141 = load i32, ptr %16, align 4
  %142 = sext i32 %141 to i64
  %143 = getelementptr inbounds double, ptr %140, i64 %142
  %144 = load double, ptr %143, align 8
  br label %145

145:                                              ; preds = %139, %138
  %146 = phi double [ 1.000000e+00, %138 ], [ %144, %139 ]
  %147 = load ptr, ptr %14, align 8
  %148 = load i32, ptr %16, align 4
  %149 = sext i32 %148 to i64
  %150 = getelementptr inbounds double, ptr %147, i64 %149
  store double %146, ptr %150, align 8
  br label %151

151:                                              ; preds = %145
  %152 = load i32, ptr %16, align 4
  %153 = add nsw i32 %152, 1
  store i32 %153, ptr %16, align 4
  br label %62, !llvm.loop !12

154:                                              ; preds = %62
  store i32 0, ptr %15, align 4
  br label %155

155:                                              ; preds = %200, %154
  %156 = load i32, ptr %15, align 4
  %157 = load i32, ptr %9, align 4
  %158 = icmp slt i32 %156, %157
  br i1 %158, label %159, label %203

159:                                              ; preds = %155
  store i32 0, ptr %16, align 4
  br label %160

160:                                              ; preds = %196, %159
  %161 = load i32, ptr %16, align 4
  %162 = load i32, ptr %8, align 4
  %163 = icmp slt i32 %161, %162
  br i1 %163, label %164, label %199

164:                                              ; preds = %160
  %165 = load ptr, ptr %13, align 8
  %166 = load i32, ptr %16, align 4
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds double, ptr %165, i64 %167
  %169 = load double, ptr %168, align 8
  %170 = load ptr, ptr %11, align 8
  %171 = load i32, ptr %15, align 4
  %172 = sext i32 %171 to i64
  %173 = getelementptr inbounds [1200 x double], ptr %170, i64 %172
  %174 = load i32, ptr %16, align 4
  %175 = sext i32 %174 to i64
  %176 = getelementptr inbounds [1200 x double], ptr %173, i64 0, i64 %175
  %177 = load double, ptr %176, align 8
  %178 = fsub double %177, %169
  store double %178, ptr %176, align 8
  %179 = load double, ptr %10, align 8
  %180 = call double @sqrt(double noundef %179) #6
  %181 = load ptr, ptr %14, align 8
  %182 = load i32, ptr %16, align 4
  %183 = sext i32 %182 to i64
  %184 = getelementptr inbounds double, ptr %181, i64 %183
  %185 = load double, ptr %184, align 8
  %186 = fmul double %180, %185
  %187 = load ptr, ptr %11, align 8
  %188 = load i32, ptr %15, align 4
  %189 = sext i32 %188 to i64
  %190 = getelementptr inbounds [1200 x double], ptr %187, i64 %189
  %191 = load i32, ptr %16, align 4
  %192 = sext i32 %191 to i64
  %193 = getelementptr inbounds [1200 x double], ptr %190, i64 0, i64 %192
  %194 = load double, ptr %193, align 8
  %195 = fdiv double %194, %186
  store double %195, ptr %193, align 8
  br label %196

196:                                              ; preds = %164
  %197 = load i32, ptr %16, align 4
  %198 = add nsw i32 %197, 1
  store i32 %198, ptr %16, align 4
  br label %160, !llvm.loop !13

199:                                              ; preds = %160
  br label %200

200:                                              ; preds = %199
  %201 = load i32, ptr %15, align 4
  %202 = add nsw i32 %201, 1
  store i32 %202, ptr %15, align 4
  br label %155, !llvm.loop !14

203:                                              ; preds = %155
  store i32 0, ptr %15, align 4
  br label %204

204:                                              ; preds = %284, %203
  %205 = load i32, ptr %15, align 4
  %206 = load i32, ptr %8, align 4
  %207 = sub nsw i32 %206, 1
  %208 = icmp slt i32 %205, %207
  br i1 %208, label %209, label %287

209:                                              ; preds = %204
  %210 = load ptr, ptr %12, align 8
  %211 = load i32, ptr %15, align 4
  %212 = sext i32 %211 to i64
  %213 = getelementptr inbounds [1200 x double], ptr %210, i64 %212
  %214 = load i32, ptr %15, align 4
  %215 = sext i32 %214 to i64
  %216 = getelementptr inbounds [1200 x double], ptr %213, i64 0, i64 %215
  store double 1.000000e+00, ptr %216, align 8
  %217 = load i32, ptr %15, align 4
  %218 = add nsw i32 %217, 1
  store i32 %218, ptr %16, align 4
  br label %219

219:                                              ; preds = %280, %209
  %220 = load i32, ptr %16, align 4
  %221 = load i32, ptr %8, align 4
  %222 = icmp slt i32 %220, %221
  br i1 %222, label %223, label %283

223:                                              ; preds = %219
  %224 = load ptr, ptr %12, align 8
  %225 = load i32, ptr %15, align 4
  %226 = sext i32 %225 to i64
  %227 = getelementptr inbounds [1200 x double], ptr %224, i64 %226
  %228 = load i32, ptr %16, align 4
  %229 = sext i32 %228 to i64
  %230 = getelementptr inbounds [1200 x double], ptr %227, i64 0, i64 %229
  store double 0.000000e+00, ptr %230, align 8
  store i32 0, ptr %17, align 4
  br label %231

231:                                              ; preds = %261, %223
  %232 = load i32, ptr %17, align 4
  %233 = load i32, ptr %9, align 4
  %234 = icmp slt i32 %232, %233
  br i1 %234, label %235, label %264

235:                                              ; preds = %231
  %236 = load ptr, ptr %11, align 8
  %237 = load i32, ptr %17, align 4
  %238 = sext i32 %237 to i64
  %239 = getelementptr inbounds [1200 x double], ptr %236, i64 %238
  %240 = load i32, ptr %15, align 4
  %241 = sext i32 %240 to i64
  %242 = getelementptr inbounds [1200 x double], ptr %239, i64 0, i64 %241
  %243 = load double, ptr %242, align 8
  %244 = load ptr, ptr %11, align 8
  %245 = load i32, ptr %17, align 4
  %246 = sext i32 %245 to i64
  %247 = getelementptr inbounds [1200 x double], ptr %244, i64 %246
  %248 = load i32, ptr %16, align 4
  %249 = sext i32 %248 to i64
  %250 = getelementptr inbounds [1200 x double], ptr %247, i64 0, i64 %249
  %251 = load double, ptr %250, align 8
  %252 = load ptr, ptr %12, align 8
  %253 = load i32, ptr %15, align 4
  %254 = sext i32 %253 to i64
  %255 = getelementptr inbounds [1200 x double], ptr %252, i64 %254
  %256 = load i32, ptr %16, align 4
  %257 = sext i32 %256 to i64
  %258 = getelementptr inbounds [1200 x double], ptr %255, i64 0, i64 %257
  %259 = load double, ptr %258, align 8
  %260 = call double @llvm.fmuladd.f64(double %243, double %251, double %259)
  store double %260, ptr %258, align 8
  br label %261

261:                                              ; preds = %235
  %262 = load i32, ptr %17, align 4
  %263 = add nsw i32 %262, 1
  store i32 %263, ptr %17, align 4
  br label %231, !llvm.loop !15

264:                                              ; preds = %231
  %265 = load ptr, ptr %12, align 8
  %266 = load i32, ptr %15, align 4
  %267 = sext i32 %266 to i64
  %268 = getelementptr inbounds [1200 x double], ptr %265, i64 %267
  %269 = load i32, ptr %16, align 4
  %270 = sext i32 %269 to i64
  %271 = getelementptr inbounds [1200 x double], ptr %268, i64 0, i64 %270
  %272 = load double, ptr %271, align 8
  %273 = load ptr, ptr %12, align 8
  %274 = load i32, ptr %16, align 4
  %275 = sext i32 %274 to i64
  %276 = getelementptr inbounds [1200 x double], ptr %273, i64 %275
  %277 = load i32, ptr %15, align 4
  %278 = sext i32 %277 to i64
  %279 = getelementptr inbounds [1200 x double], ptr %276, i64 0, i64 %278
  store double %272, ptr %279, align 8
  br label %280

280:                                              ; preds = %264
  %281 = load i32, ptr %16, align 4
  %282 = add nsw i32 %281, 1
  store i32 %282, ptr %16, align 4
  br label %219, !llvm.loop !16

283:                                              ; preds = %219
  br label %284

284:                                              ; preds = %283
  %285 = load i32, ptr %15, align 4
  %286 = add nsw i32 %285, 1
  store i32 %286, ptr %15, align 4
  br label %204, !llvm.loop !17

287:                                              ; preds = %204
  %288 = load ptr, ptr %12, align 8
  %289 = load i32, ptr %8, align 4
  %290 = sub nsw i32 %289, 1
  %291 = sext i32 %290 to i64
  %292 = getelementptr inbounds [1200 x double], ptr %288, i64 %291
  %293 = load i32, ptr %8, align 4
  %294 = sub nsw i32 %293, 1
  %295 = sext i32 %294 to i64
  %296 = getelementptr inbounds [1200 x double], ptr %292, i64 0, i64 %295
  store double 1.000000e+00, ptr %296, align 8
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
  br label %16, !llvm.loop !18

45:                                               ; preds = %16
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %5, align 4
  br label %11, !llvm.loop !19

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
