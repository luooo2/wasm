; ModuleID = '/code/data/webassembly-polybench-c-master/medley/nussinov/nussinov.c'
source_filename = "/code/data/webassembly-polybench-c-master/medley/nussinov/nussinov.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"table\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
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
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 2500, ptr %6, align 4
  %9 = call ptr @polybench_alloc_data(i64 noundef 2500, i32 noundef 1)
  store ptr %9, ptr %7, align 8
  %10 = call ptr @polybench_alloc_data(i64 noundef 6250000, i32 noundef 4)
  store ptr %10, ptr %8, align 8
  %11 = load i32, ptr %6, align 4
  %12 = load ptr, ptr %7, align 8
  %13 = getelementptr inbounds [2500 x i8], ptr %12, i64 0, i64 0
  %14 = load ptr, ptr %8, align 8
  %15 = getelementptr inbounds [2500 x [2500 x i32]], ptr %14, i64 0, i64 0
  call void @init_array(i32 noundef %11, ptr noundef %13, ptr noundef %15)
  %16 = load i32, ptr %6, align 4
  %17 = load ptr, ptr %7, align 8
  %18 = getelementptr inbounds [2500 x i8], ptr %17, i64 0, i64 0
  %19 = load ptr, ptr %8, align 8
  %20 = getelementptr inbounds [2500 x [2500 x i32]], ptr %19, i64 0, i64 0
  call void @kernel_nussinov(i32 noundef %16, ptr noundef %18, ptr noundef %20)
  %21 = load i32, ptr %4, align 4
  %22 = icmp sgt i32 %21, 42
  br i1 %22, label %23, label %33

23:                                               ; preds = %2
  %24 = load ptr, ptr %5, align 8
  %25 = getelementptr inbounds ptr, ptr %24, i64 0
  %26 = load ptr, ptr %25, align 8
  %27 = call i32 @strcmp(ptr noundef %26, ptr noundef @.str) #4
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %33, label %29

29:                                               ; preds = %23
  %30 = load i32, ptr %6, align 4
  %31 = load ptr, ptr %8, align 8
  %32 = getelementptr inbounds [2500 x [2500 x i32]], ptr %31, i64 0, i64 0
  call void @print_array(i32 noundef %30, ptr noundef %32)
  br label %33

33:                                               ; preds = %29, %23, %2
  %34 = load ptr, ptr %7, align 8
  call void @free(ptr noundef %34) #5
  %35 = load ptr, ptr %8, align 8
  call void @free(ptr noundef %35) #5
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

9:                                                ; preds = %22, %3
  %10 = load i32, ptr %7, align 4
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %25

13:                                               ; preds = %9
  %14 = load i32, ptr %7, align 4
  %15 = add nsw i32 %14, 1
  %16 = srem i32 %15, 4
  %17 = trunc i32 %16 to i8
  %18 = load ptr, ptr %5, align 8
  %19 = load i32, ptr %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i8, ptr %18, i64 %20
  store i8 %17, ptr %21, align 1
  br label %22

22:                                               ; preds = %13
  %23 = load i32, ptr %7, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %7, align 4
  br label %9, !llvm.loop !6

25:                                               ; preds = %9
  store i32 0, ptr %7, align 4
  br label %26

26:                                               ; preds = %47, %25
  %27 = load i32, ptr %7, align 4
  %28 = load i32, ptr %4, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %50

30:                                               ; preds = %26
  store i32 0, ptr %8, align 4
  br label %31

31:                                               ; preds = %43, %30
  %32 = load i32, ptr %8, align 4
  %33 = load i32, ptr %4, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %46

35:                                               ; preds = %31
  %36 = load ptr, ptr %6, align 8
  %37 = load i32, ptr %7, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [2500 x i32], ptr %36, i64 %38
  %40 = load i32, ptr %8, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [2500 x i32], ptr %39, i64 0, i64 %41
  store i32 0, ptr %42, align 4
  br label %43

43:                                               ; preds = %35
  %44 = load i32, ptr %8, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %8, align 4
  br label %31, !llvm.loop !8

46:                                               ; preds = %31
  br label %47

47:                                               ; preds = %46
  %48 = load i32, ptr %7, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %7, align 4
  br label %26, !llvm.loop !9

50:                                               ; preds = %26
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_nussinov(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %10 = load i32, ptr %4, align 4
  %11 = sub nsw i32 %10, 1
  store i32 %11, ptr %7, align 4
  br label %12

12:                                               ; preds = %352, %3
  %13 = load i32, ptr %7, align 4
  %14 = icmp sge i32 %13, 0
  br i1 %14, label %15, label %355

15:                                               ; preds = %12
  %16 = load i32, ptr %7, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, ptr %8, align 4
  br label %18

18:                                               ; preds = %348, %15
  %19 = load i32, ptr %8, align 4
  %20 = load i32, ptr %4, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %351

22:                                               ; preds = %18
  %23 = load i32, ptr %8, align 4
  %24 = sub nsw i32 %23, 1
  %25 = icmp sge i32 %24, 0
  br i1 %25, label %26, label %73

26:                                               ; preds = %22
  %27 = load ptr, ptr %6, align 8
  %28 = load i32, ptr %7, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [2500 x i32], ptr %27, i64 %29
  %31 = load i32, ptr %8, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [2500 x i32], ptr %30, i64 0, i64 %32
  %34 = load i32, ptr %33, align 4
  %35 = load ptr, ptr %6, align 8
  %36 = load i32, ptr %7, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [2500 x i32], ptr %35, i64 %37
  %39 = load i32, ptr %8, align 4
  %40 = sub nsw i32 %39, 1
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [2500 x i32], ptr %38, i64 0, i64 %41
  %43 = load i32, ptr %42, align 4
  %44 = icmp sge i32 %34, %43
  br i1 %44, label %45, label %54

45:                                               ; preds = %26
  %46 = load ptr, ptr %6, align 8
  %47 = load i32, ptr %7, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [2500 x i32], ptr %46, i64 %48
  %50 = load i32, ptr %8, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [2500 x i32], ptr %49, i64 0, i64 %51
  %53 = load i32, ptr %52, align 4
  br label %64

54:                                               ; preds = %26
  %55 = load ptr, ptr %6, align 8
  %56 = load i32, ptr %7, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [2500 x i32], ptr %55, i64 %57
  %59 = load i32, ptr %8, align 4
  %60 = sub nsw i32 %59, 1
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [2500 x i32], ptr %58, i64 0, i64 %61
  %63 = load i32, ptr %62, align 4
  br label %64

64:                                               ; preds = %54, %45
  %65 = phi i32 [ %53, %45 ], [ %63, %54 ]
  %66 = load ptr, ptr %6, align 8
  %67 = load i32, ptr %7, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [2500 x i32], ptr %66, i64 %68
  %70 = load i32, ptr %8, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [2500 x i32], ptr %69, i64 0, i64 %71
  store i32 %65, ptr %72, align 4
  br label %73

73:                                               ; preds = %64, %22
  %74 = load i32, ptr %7, align 4
  %75 = add nsw i32 %74, 1
  %76 = load i32, ptr %4, align 4
  %77 = icmp slt i32 %75, %76
  br i1 %77, label %78, label %125

78:                                               ; preds = %73
  %79 = load ptr, ptr %6, align 8
  %80 = load i32, ptr %7, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [2500 x i32], ptr %79, i64 %81
  %83 = load i32, ptr %8, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds [2500 x i32], ptr %82, i64 0, i64 %84
  %86 = load i32, ptr %85, align 4
  %87 = load ptr, ptr %6, align 8
  %88 = load i32, ptr %7, align 4
  %89 = add nsw i32 %88, 1
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds [2500 x i32], ptr %87, i64 %90
  %92 = load i32, ptr %8, align 4
  %93 = sext i32 %92 to i64
  %94 = getelementptr inbounds [2500 x i32], ptr %91, i64 0, i64 %93
  %95 = load i32, ptr %94, align 4
  %96 = icmp sge i32 %86, %95
  br i1 %96, label %97, label %106

97:                                               ; preds = %78
  %98 = load ptr, ptr %6, align 8
  %99 = load i32, ptr %7, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds [2500 x i32], ptr %98, i64 %100
  %102 = load i32, ptr %8, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds [2500 x i32], ptr %101, i64 0, i64 %103
  %105 = load i32, ptr %104, align 4
  br label %116

106:                                              ; preds = %78
  %107 = load ptr, ptr %6, align 8
  %108 = load i32, ptr %7, align 4
  %109 = add nsw i32 %108, 1
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds [2500 x i32], ptr %107, i64 %110
  %112 = load i32, ptr %8, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [2500 x i32], ptr %111, i64 0, i64 %113
  %115 = load i32, ptr %114, align 4
  br label %116

116:                                              ; preds = %106, %97
  %117 = phi i32 [ %105, %97 ], [ %115, %106 ]
  %118 = load ptr, ptr %6, align 8
  %119 = load i32, ptr %7, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [2500 x i32], ptr %118, i64 %120
  %122 = load i32, ptr %8, align 4
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds [2500 x i32], ptr %121, i64 0, i64 %123
  store i32 %117, ptr %124, align 4
  br label %125

125:                                              ; preds = %116, %73
  %126 = load i32, ptr %8, align 4
  %127 = sub nsw i32 %126, 1
  %128 = icmp sge i32 %127, 0
  br i1 %128, label %129, label %272

129:                                              ; preds = %125
  %130 = load i32, ptr %7, align 4
  %131 = add nsw i32 %130, 1
  %132 = load i32, ptr %4, align 4
  %133 = icmp slt i32 %131, %132
  br i1 %133, label %134, label %272

134:                                              ; preds = %129
  %135 = load i32, ptr %7, align 4
  %136 = load i32, ptr %8, align 4
  %137 = sub nsw i32 %136, 1
  %138 = icmp slt i32 %135, %137
  br i1 %138, label %139, label %222

139:                                              ; preds = %134
  %140 = load ptr, ptr %6, align 8
  %141 = load i32, ptr %7, align 4
  %142 = sext i32 %141 to i64
  %143 = getelementptr inbounds [2500 x i32], ptr %140, i64 %142
  %144 = load i32, ptr %8, align 4
  %145 = sext i32 %144 to i64
  %146 = getelementptr inbounds [2500 x i32], ptr %143, i64 0, i64 %145
  %147 = load i32, ptr %146, align 4
  %148 = load ptr, ptr %6, align 8
  %149 = load i32, ptr %7, align 4
  %150 = add nsw i32 %149, 1
  %151 = sext i32 %150 to i64
  %152 = getelementptr inbounds [2500 x i32], ptr %148, i64 %151
  %153 = load i32, ptr %8, align 4
  %154 = sub nsw i32 %153, 1
  %155 = sext i32 %154 to i64
  %156 = getelementptr inbounds [2500 x i32], ptr %152, i64 0, i64 %155
  %157 = load i32, ptr %156, align 4
  %158 = load ptr, ptr %5, align 8
  %159 = load i32, ptr %7, align 4
  %160 = sext i32 %159 to i64
  %161 = getelementptr inbounds i8, ptr %158, i64 %160
  %162 = load i8, ptr %161, align 1
  %163 = sext i8 %162 to i32
  %164 = load ptr, ptr %5, align 8
  %165 = load i32, ptr %8, align 4
  %166 = sext i32 %165 to i64
  %167 = getelementptr inbounds i8, ptr %164, i64 %166
  %168 = load i8, ptr %167, align 1
  %169 = sext i8 %168 to i32
  %170 = add nsw i32 %163, %169
  %171 = icmp eq i32 %170, 3
  %172 = zext i1 %171 to i64
  %173 = select i1 %171, i32 1, i32 0
  %174 = add nsw i32 %157, %173
  %175 = icmp sge i32 %147, %174
  br i1 %175, label %176, label %185

176:                                              ; preds = %139
  %177 = load ptr, ptr %6, align 8
  %178 = load i32, ptr %7, align 4
  %179 = sext i32 %178 to i64
  %180 = getelementptr inbounds [2500 x i32], ptr %177, i64 %179
  %181 = load i32, ptr %8, align 4
  %182 = sext i32 %181 to i64
  %183 = getelementptr inbounds [2500 x i32], ptr %180, i64 0, i64 %182
  %184 = load i32, ptr %183, align 4
  br label %213

185:                                              ; preds = %139
  %186 = load ptr, ptr %6, align 8
  %187 = load i32, ptr %7, align 4
  %188 = add nsw i32 %187, 1
  %189 = sext i32 %188 to i64
  %190 = getelementptr inbounds [2500 x i32], ptr %186, i64 %189
  %191 = load i32, ptr %8, align 4
  %192 = sub nsw i32 %191, 1
  %193 = sext i32 %192 to i64
  %194 = getelementptr inbounds [2500 x i32], ptr %190, i64 0, i64 %193
  %195 = load i32, ptr %194, align 4
  %196 = load ptr, ptr %5, align 8
  %197 = load i32, ptr %7, align 4
  %198 = sext i32 %197 to i64
  %199 = getelementptr inbounds i8, ptr %196, i64 %198
  %200 = load i8, ptr %199, align 1
  %201 = sext i8 %200 to i32
  %202 = load ptr, ptr %5, align 8
  %203 = load i32, ptr %8, align 4
  %204 = sext i32 %203 to i64
  %205 = getelementptr inbounds i8, ptr %202, i64 %204
  %206 = load i8, ptr %205, align 1
  %207 = sext i8 %206 to i32
  %208 = add nsw i32 %201, %207
  %209 = icmp eq i32 %208, 3
  %210 = zext i1 %209 to i64
  %211 = select i1 %209, i32 1, i32 0
  %212 = add nsw i32 %195, %211
  br label %213

213:                                              ; preds = %185, %176
  %214 = phi i32 [ %184, %176 ], [ %212, %185 ]
  %215 = load ptr, ptr %6, align 8
  %216 = load i32, ptr %7, align 4
  %217 = sext i32 %216 to i64
  %218 = getelementptr inbounds [2500 x i32], ptr %215, i64 %217
  %219 = load i32, ptr %8, align 4
  %220 = sext i32 %219 to i64
  %221 = getelementptr inbounds [2500 x i32], ptr %218, i64 0, i64 %220
  store i32 %214, ptr %221, align 4
  br label %271

222:                                              ; preds = %134
  %223 = load ptr, ptr %6, align 8
  %224 = load i32, ptr %7, align 4
  %225 = sext i32 %224 to i64
  %226 = getelementptr inbounds [2500 x i32], ptr %223, i64 %225
  %227 = load i32, ptr %8, align 4
  %228 = sext i32 %227 to i64
  %229 = getelementptr inbounds [2500 x i32], ptr %226, i64 0, i64 %228
  %230 = load i32, ptr %229, align 4
  %231 = load ptr, ptr %6, align 8
  %232 = load i32, ptr %7, align 4
  %233 = add nsw i32 %232, 1
  %234 = sext i32 %233 to i64
  %235 = getelementptr inbounds [2500 x i32], ptr %231, i64 %234
  %236 = load i32, ptr %8, align 4
  %237 = sub nsw i32 %236, 1
  %238 = sext i32 %237 to i64
  %239 = getelementptr inbounds [2500 x i32], ptr %235, i64 0, i64 %238
  %240 = load i32, ptr %239, align 4
  %241 = icmp sge i32 %230, %240
  br i1 %241, label %242, label %251

242:                                              ; preds = %222
  %243 = load ptr, ptr %6, align 8
  %244 = load i32, ptr %7, align 4
  %245 = sext i32 %244 to i64
  %246 = getelementptr inbounds [2500 x i32], ptr %243, i64 %245
  %247 = load i32, ptr %8, align 4
  %248 = sext i32 %247 to i64
  %249 = getelementptr inbounds [2500 x i32], ptr %246, i64 0, i64 %248
  %250 = load i32, ptr %249, align 4
  br label %262

251:                                              ; preds = %222
  %252 = load ptr, ptr %6, align 8
  %253 = load i32, ptr %7, align 4
  %254 = add nsw i32 %253, 1
  %255 = sext i32 %254 to i64
  %256 = getelementptr inbounds [2500 x i32], ptr %252, i64 %255
  %257 = load i32, ptr %8, align 4
  %258 = sub nsw i32 %257, 1
  %259 = sext i32 %258 to i64
  %260 = getelementptr inbounds [2500 x i32], ptr %256, i64 0, i64 %259
  %261 = load i32, ptr %260, align 4
  br label %262

262:                                              ; preds = %251, %242
  %263 = phi i32 [ %250, %242 ], [ %261, %251 ]
  %264 = load ptr, ptr %6, align 8
  %265 = load i32, ptr %7, align 4
  %266 = sext i32 %265 to i64
  %267 = getelementptr inbounds [2500 x i32], ptr %264, i64 %266
  %268 = load i32, ptr %8, align 4
  %269 = sext i32 %268 to i64
  %270 = getelementptr inbounds [2500 x i32], ptr %267, i64 0, i64 %269
  store i32 %263, ptr %270, align 4
  br label %271

271:                                              ; preds = %262, %213
  br label %272

272:                                              ; preds = %271, %129, %125
  %273 = load i32, ptr %7, align 4
  %274 = add nsw i32 %273, 1
  store i32 %274, ptr %9, align 4
  br label %275

275:                                              ; preds = %344, %272
  %276 = load i32, ptr %9, align 4
  %277 = load i32, ptr %8, align 4
  %278 = icmp slt i32 %276, %277
  br i1 %278, label %279, label %347

279:                                              ; preds = %275
  %280 = load ptr, ptr %6, align 8
  %281 = load i32, ptr %7, align 4
  %282 = sext i32 %281 to i64
  %283 = getelementptr inbounds [2500 x i32], ptr %280, i64 %282
  %284 = load i32, ptr %8, align 4
  %285 = sext i32 %284 to i64
  %286 = getelementptr inbounds [2500 x i32], ptr %283, i64 0, i64 %285
  %287 = load i32, ptr %286, align 4
  %288 = load ptr, ptr %6, align 8
  %289 = load i32, ptr %7, align 4
  %290 = sext i32 %289 to i64
  %291 = getelementptr inbounds [2500 x i32], ptr %288, i64 %290
  %292 = load i32, ptr %9, align 4
  %293 = sext i32 %292 to i64
  %294 = getelementptr inbounds [2500 x i32], ptr %291, i64 0, i64 %293
  %295 = load i32, ptr %294, align 4
  %296 = load ptr, ptr %6, align 8
  %297 = load i32, ptr %9, align 4
  %298 = add nsw i32 %297, 1
  %299 = sext i32 %298 to i64
  %300 = getelementptr inbounds [2500 x i32], ptr %296, i64 %299
  %301 = load i32, ptr %8, align 4
  %302 = sext i32 %301 to i64
  %303 = getelementptr inbounds [2500 x i32], ptr %300, i64 0, i64 %302
  %304 = load i32, ptr %303, align 4
  %305 = add nsw i32 %295, %304
  %306 = icmp sge i32 %287, %305
  br i1 %306, label %307, label %316

307:                                              ; preds = %279
  %308 = load ptr, ptr %6, align 8
  %309 = load i32, ptr %7, align 4
  %310 = sext i32 %309 to i64
  %311 = getelementptr inbounds [2500 x i32], ptr %308, i64 %310
  %312 = load i32, ptr %8, align 4
  %313 = sext i32 %312 to i64
  %314 = getelementptr inbounds [2500 x i32], ptr %311, i64 0, i64 %313
  %315 = load i32, ptr %314, align 4
  br label %335

316:                                              ; preds = %279
  %317 = load ptr, ptr %6, align 8
  %318 = load i32, ptr %7, align 4
  %319 = sext i32 %318 to i64
  %320 = getelementptr inbounds [2500 x i32], ptr %317, i64 %319
  %321 = load i32, ptr %9, align 4
  %322 = sext i32 %321 to i64
  %323 = getelementptr inbounds [2500 x i32], ptr %320, i64 0, i64 %322
  %324 = load i32, ptr %323, align 4
  %325 = load ptr, ptr %6, align 8
  %326 = load i32, ptr %9, align 4
  %327 = add nsw i32 %326, 1
  %328 = sext i32 %327 to i64
  %329 = getelementptr inbounds [2500 x i32], ptr %325, i64 %328
  %330 = load i32, ptr %8, align 4
  %331 = sext i32 %330 to i64
  %332 = getelementptr inbounds [2500 x i32], ptr %329, i64 0, i64 %331
  %333 = load i32, ptr %332, align 4
  %334 = add nsw i32 %324, %333
  br label %335

335:                                              ; preds = %316, %307
  %336 = phi i32 [ %315, %307 ], [ %334, %316 ]
  %337 = load ptr, ptr %6, align 8
  %338 = load i32, ptr %7, align 4
  %339 = sext i32 %338 to i64
  %340 = getelementptr inbounds [2500 x i32], ptr %337, i64 %339
  %341 = load i32, ptr %8, align 4
  %342 = sext i32 %341 to i64
  %343 = getelementptr inbounds [2500 x i32], ptr %340, i64 0, i64 %342
  store i32 %336, ptr %343, align 4
  br label %344

344:                                              ; preds = %335
  %345 = load i32, ptr %9, align 4
  %346 = add nsw i32 %345, 1
  store i32 %346, ptr %9, align 4
  br label %275, !llvm.loop !10

347:                                              ; preds = %275
  br label %348

348:                                              ; preds = %347
  %349 = load i32, ptr %8, align 4
  %350 = add nsw i32 %349, 1
  store i32 %350, ptr %8, align 4
  br label %18, !llvm.loop !11

351:                                              ; preds = %18
  br label %352

352:                                              ; preds = %351
  %353 = load i32, ptr %7, align 4
  %354 = add nsw i32 %353, -1
  store i32 %354, ptr %7, align 4
  br label %12, !llvm.loop !12

355:                                              ; preds = %12
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
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %7, align 4
  %8 = load ptr, ptr @stderr, align 8
  %9 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %8, ptr noundef @.str.1)
  %10 = load ptr, ptr @stderr, align 8
  %11 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %10, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %5, align 4
  br label %12

12:                                               ; preds = %46, %2
  %13 = load i32, ptr %5, align 4
  %14 = load i32, ptr %3, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %49

16:                                               ; preds = %12
  %17 = load i32, ptr %5, align 4
  store i32 %17, ptr %6, align 4
  br label %18

18:                                               ; preds = %42, %16
  %19 = load i32, ptr %6, align 4
  %20 = load i32, ptr %3, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %45

22:                                               ; preds = %18
  %23 = load i32, ptr %7, align 4
  %24 = srem i32 %23, 20
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %26, label %29

26:                                               ; preds = %22
  %27 = load ptr, ptr @stderr, align 8
  %28 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %27, ptr noundef @.str.4)
  br label %29

29:                                               ; preds = %26, %22
  %30 = load ptr, ptr @stderr, align 8
  %31 = load ptr, ptr %4, align 8
  %32 = load i32, ptr %5, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [2500 x i32], ptr %31, i64 %33
  %35 = load i32, ptr %6, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [2500 x i32], ptr %34, i64 0, i64 %36
  %38 = load i32, ptr %37, align 4
  %39 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %30, ptr noundef @.str.5, i32 noundef %38)
  %40 = load i32, ptr %7, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %7, align 4
  br label %42

42:                                               ; preds = %29
  %43 = load i32, ptr %6, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %6, align 4
  br label %18, !llvm.loop !13

45:                                               ; preds = %18
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %5, align 4
  br label %12, !llvm.loop !14

49:                                               ; preds = %12
  %50 = load ptr, ptr @stderr, align 8
  %51 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %50, ptr noundef @.str.6, ptr noundef @.str.3)
  %52 = load ptr, ptr @stderr, align 8
  %53 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %52, ptr noundef @.str.7)
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind willreturn memory(read) }
attributes #5 = { nounwind }

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
