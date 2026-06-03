; ModuleID = '/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/Misc/salsa20.c'
source_filename = "/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/Misc/salsa20.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@ptr = dso_local global i32 0, align 4
@outbuf = dso_local global [16 x i32] zeroinitializer, align 16
@STATE = dso_local global [16 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [15 x i8] c"got:       %x\0A\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"should be: %x\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @salsa20(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca [16 x i32], align 16
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %7

7:                                                ; preds = %19, %2
  %8 = load i32, ptr %5, align 4
  %9 = icmp ult i32 %8, 16
  br i1 %9, label %10, label %22

10:                                               ; preds = %7
  %11 = load ptr, ptr %4, align 8
  %12 = load i32, ptr %5, align 4
  %13 = zext i32 %12 to i64
  %14 = getelementptr inbounds i32, ptr %11, i64 %13
  %15 = load i32, ptr %14, align 4
  %16 = load i32, ptr %5, align 4
  %17 = zext i32 %16 to i64
  %18 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 %17
  store i32 %15, ptr %18, align 4
  br label %19

19:                                               ; preds = %10
  %20 = load i32, ptr %5, align 4
  %21 = add i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %7, !llvm.loop !6

22:                                               ; preds = %7
  store i32 20, ptr %5, align 4
  br label %23

23:                                               ; preds = %539, %22
  %24 = load i32, ptr %5, align 4
  %25 = icmp ugt i32 %24, 0
  br i1 %25, label %26, label %542

26:                                               ; preds = %23
  %27 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %28 = load i32, ptr %27, align 16
  %29 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %30 = load i32, ptr %29, align 16
  %31 = add i32 %28, %30
  %32 = shl i32 %31, 7
  %33 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %34 = load i32, ptr %33, align 16
  %35 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %36 = load i32, ptr %35, align 16
  %37 = add i32 %34, %36
  %38 = lshr i32 %37, 25
  %39 = or i32 %32, %38
  %40 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %41 = load i32, ptr %40, align 16
  %42 = xor i32 %41, %39
  store i32 %42, ptr %40, align 16
  %43 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %44 = load i32, ptr %43, align 16
  %45 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %46 = load i32, ptr %45, align 16
  %47 = add i32 %44, %46
  %48 = shl i32 %47, 9
  %49 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %50 = load i32, ptr %49, align 16
  %51 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %52 = load i32, ptr %51, align 16
  %53 = add i32 %50, %52
  %54 = lshr i32 %53, 23
  %55 = or i32 %48, %54
  %56 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %57 = load i32, ptr %56, align 16
  %58 = xor i32 %57, %55
  store i32 %58, ptr %56, align 16
  %59 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %60 = load i32, ptr %59, align 16
  %61 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %62 = load i32, ptr %61, align 16
  %63 = add i32 %60, %62
  %64 = shl i32 %63, 13
  %65 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %66 = load i32, ptr %65, align 16
  %67 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %68 = load i32, ptr %67, align 16
  %69 = add i32 %66, %68
  %70 = lshr i32 %69, 19
  %71 = or i32 %64, %70
  %72 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %73 = load i32, ptr %72, align 16
  %74 = xor i32 %73, %71
  store i32 %74, ptr %72, align 16
  %75 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %76 = load i32, ptr %75, align 16
  %77 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %78 = load i32, ptr %77, align 16
  %79 = add i32 %76, %78
  %80 = shl i32 %79, 18
  %81 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %82 = load i32, ptr %81, align 16
  %83 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %84 = load i32, ptr %83, align 16
  %85 = add i32 %82, %84
  %86 = lshr i32 %85, 14
  %87 = or i32 %80, %86
  %88 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %89 = load i32, ptr %88, align 16
  %90 = xor i32 %89, %87
  store i32 %90, ptr %88, align 16
  %91 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %92 = load i32, ptr %91, align 4
  %93 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %94 = load i32, ptr %93, align 4
  %95 = add i32 %92, %94
  %96 = shl i32 %95, 7
  %97 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %98 = load i32, ptr %97, align 4
  %99 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %100 = load i32, ptr %99, align 4
  %101 = add i32 %98, %100
  %102 = lshr i32 %101, 25
  %103 = or i32 %96, %102
  %104 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %105 = load i32, ptr %104, align 4
  %106 = xor i32 %105, %103
  store i32 %106, ptr %104, align 4
  %107 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %108 = load i32, ptr %107, align 4
  %109 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %110 = load i32, ptr %109, align 4
  %111 = add i32 %108, %110
  %112 = shl i32 %111, 9
  %113 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %114 = load i32, ptr %113, align 4
  %115 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %116 = load i32, ptr %115, align 4
  %117 = add i32 %114, %116
  %118 = lshr i32 %117, 23
  %119 = or i32 %112, %118
  %120 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %121 = load i32, ptr %120, align 4
  %122 = xor i32 %121, %119
  store i32 %122, ptr %120, align 4
  %123 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %124 = load i32, ptr %123, align 4
  %125 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %126 = load i32, ptr %125, align 4
  %127 = add i32 %124, %126
  %128 = shl i32 %127, 13
  %129 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %130 = load i32, ptr %129, align 4
  %131 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %132 = load i32, ptr %131, align 4
  %133 = add i32 %130, %132
  %134 = lshr i32 %133, 19
  %135 = or i32 %128, %134
  %136 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %137 = load i32, ptr %136, align 4
  %138 = xor i32 %137, %135
  store i32 %138, ptr %136, align 4
  %139 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %140 = load i32, ptr %139, align 4
  %141 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %142 = load i32, ptr %141, align 4
  %143 = add i32 %140, %142
  %144 = shl i32 %143, 18
  %145 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %146 = load i32, ptr %145, align 4
  %147 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %148 = load i32, ptr %147, align 4
  %149 = add i32 %146, %148
  %150 = lshr i32 %149, 14
  %151 = or i32 %144, %150
  %152 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %153 = load i32, ptr %152, align 4
  %154 = xor i32 %153, %151
  store i32 %154, ptr %152, align 4
  %155 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %156 = load i32, ptr %155, align 8
  %157 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %158 = load i32, ptr %157, align 8
  %159 = add i32 %156, %158
  %160 = shl i32 %159, 7
  %161 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %162 = load i32, ptr %161, align 8
  %163 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %164 = load i32, ptr %163, align 8
  %165 = add i32 %162, %164
  %166 = lshr i32 %165, 25
  %167 = or i32 %160, %166
  %168 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %169 = load i32, ptr %168, align 8
  %170 = xor i32 %169, %167
  store i32 %170, ptr %168, align 8
  %171 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %172 = load i32, ptr %171, align 8
  %173 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %174 = load i32, ptr %173, align 8
  %175 = add i32 %172, %174
  %176 = shl i32 %175, 9
  %177 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %178 = load i32, ptr %177, align 8
  %179 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %180 = load i32, ptr %179, align 8
  %181 = add i32 %178, %180
  %182 = lshr i32 %181, 23
  %183 = or i32 %176, %182
  %184 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %185 = load i32, ptr %184, align 8
  %186 = xor i32 %185, %183
  store i32 %186, ptr %184, align 8
  %187 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %188 = load i32, ptr %187, align 8
  %189 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %190 = load i32, ptr %189, align 8
  %191 = add i32 %188, %190
  %192 = shl i32 %191, 13
  %193 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %194 = load i32, ptr %193, align 8
  %195 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %196 = load i32, ptr %195, align 8
  %197 = add i32 %194, %196
  %198 = lshr i32 %197, 19
  %199 = or i32 %192, %198
  %200 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %201 = load i32, ptr %200, align 8
  %202 = xor i32 %201, %199
  store i32 %202, ptr %200, align 8
  %203 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %204 = load i32, ptr %203, align 8
  %205 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %206 = load i32, ptr %205, align 8
  %207 = add i32 %204, %206
  %208 = shl i32 %207, 18
  %209 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %210 = load i32, ptr %209, align 8
  %211 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %212 = load i32, ptr %211, align 8
  %213 = add i32 %210, %212
  %214 = lshr i32 %213, 14
  %215 = or i32 %208, %214
  %216 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %217 = load i32, ptr %216, align 8
  %218 = xor i32 %217, %215
  store i32 %218, ptr %216, align 8
  %219 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %220 = load i32, ptr %219, align 4
  %221 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %222 = load i32, ptr %221, align 4
  %223 = add i32 %220, %222
  %224 = shl i32 %223, 7
  %225 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %226 = load i32, ptr %225, align 4
  %227 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %228 = load i32, ptr %227, align 4
  %229 = add i32 %226, %228
  %230 = lshr i32 %229, 25
  %231 = or i32 %224, %230
  %232 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %233 = load i32, ptr %232, align 4
  %234 = xor i32 %233, %231
  store i32 %234, ptr %232, align 4
  %235 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %236 = load i32, ptr %235, align 4
  %237 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %238 = load i32, ptr %237, align 4
  %239 = add i32 %236, %238
  %240 = shl i32 %239, 9
  %241 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %242 = load i32, ptr %241, align 4
  %243 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %244 = load i32, ptr %243, align 4
  %245 = add i32 %242, %244
  %246 = lshr i32 %245, 23
  %247 = or i32 %240, %246
  %248 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %249 = load i32, ptr %248, align 4
  %250 = xor i32 %249, %247
  store i32 %250, ptr %248, align 4
  %251 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %252 = load i32, ptr %251, align 4
  %253 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %254 = load i32, ptr %253, align 4
  %255 = add i32 %252, %254
  %256 = shl i32 %255, 13
  %257 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %258 = load i32, ptr %257, align 4
  %259 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %260 = load i32, ptr %259, align 4
  %261 = add i32 %258, %260
  %262 = lshr i32 %261, 19
  %263 = or i32 %256, %262
  %264 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %265 = load i32, ptr %264, align 4
  %266 = xor i32 %265, %263
  store i32 %266, ptr %264, align 4
  %267 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %268 = load i32, ptr %267, align 4
  %269 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %270 = load i32, ptr %269, align 4
  %271 = add i32 %268, %270
  %272 = shl i32 %271, 18
  %273 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %274 = load i32, ptr %273, align 4
  %275 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %276 = load i32, ptr %275, align 4
  %277 = add i32 %274, %276
  %278 = lshr i32 %277, 14
  %279 = or i32 %272, %278
  %280 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %281 = load i32, ptr %280, align 4
  %282 = xor i32 %281, %279
  store i32 %282, ptr %280, align 4
  %283 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %284 = load i32, ptr %283, align 16
  %285 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %286 = load i32, ptr %285, align 4
  %287 = add i32 %284, %286
  %288 = shl i32 %287, 7
  %289 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %290 = load i32, ptr %289, align 16
  %291 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %292 = load i32, ptr %291, align 4
  %293 = add i32 %290, %292
  %294 = lshr i32 %293, 25
  %295 = or i32 %288, %294
  %296 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %297 = load i32, ptr %296, align 4
  %298 = xor i32 %297, %295
  store i32 %298, ptr %296, align 4
  %299 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %300 = load i32, ptr %299, align 4
  %301 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %302 = load i32, ptr %301, align 16
  %303 = add i32 %300, %302
  %304 = shl i32 %303, 9
  %305 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %306 = load i32, ptr %305, align 4
  %307 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %308 = load i32, ptr %307, align 16
  %309 = add i32 %306, %308
  %310 = lshr i32 %309, 23
  %311 = or i32 %304, %310
  %312 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %313 = load i32, ptr %312, align 8
  %314 = xor i32 %313, %311
  store i32 %314, ptr %312, align 8
  %315 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %316 = load i32, ptr %315, align 8
  %317 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %318 = load i32, ptr %317, align 4
  %319 = add i32 %316, %318
  %320 = shl i32 %319, 13
  %321 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %322 = load i32, ptr %321, align 8
  %323 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 1
  %324 = load i32, ptr %323, align 4
  %325 = add i32 %322, %324
  %326 = lshr i32 %325, 19
  %327 = or i32 %320, %326
  %328 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %329 = load i32, ptr %328, align 4
  %330 = xor i32 %329, %327
  store i32 %330, ptr %328, align 4
  %331 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %332 = load i32, ptr %331, align 4
  %333 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %334 = load i32, ptr %333, align 8
  %335 = add i32 %332, %334
  %336 = shl i32 %335, 18
  %337 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 3
  %338 = load i32, ptr %337, align 4
  %339 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 2
  %340 = load i32, ptr %339, align 8
  %341 = add i32 %338, %340
  %342 = lshr i32 %341, 14
  %343 = or i32 %336, %342
  %344 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 0
  %345 = load i32, ptr %344, align 16
  %346 = xor i32 %345, %343
  store i32 %346, ptr %344, align 16
  %347 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %348 = load i32, ptr %347, align 4
  %349 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %350 = load i32, ptr %349, align 16
  %351 = add i32 %348, %350
  %352 = shl i32 %351, 7
  %353 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %354 = load i32, ptr %353, align 4
  %355 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %356 = load i32, ptr %355, align 16
  %357 = add i32 %354, %356
  %358 = lshr i32 %357, 25
  %359 = or i32 %352, %358
  %360 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %361 = load i32, ptr %360, align 8
  %362 = xor i32 %361, %359
  store i32 %362, ptr %360, align 8
  %363 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %364 = load i32, ptr %363, align 8
  %365 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %366 = load i32, ptr %365, align 4
  %367 = add i32 %364, %366
  %368 = shl i32 %367, 9
  %369 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %370 = load i32, ptr %369, align 8
  %371 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %372 = load i32, ptr %371, align 4
  %373 = add i32 %370, %372
  %374 = lshr i32 %373, 23
  %375 = or i32 %368, %374
  %376 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %377 = load i32, ptr %376, align 4
  %378 = xor i32 %377, %375
  store i32 %378, ptr %376, align 4
  %379 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %380 = load i32, ptr %379, align 4
  %381 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %382 = load i32, ptr %381, align 8
  %383 = add i32 %380, %382
  %384 = shl i32 %383, 13
  %385 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %386 = load i32, ptr %385, align 4
  %387 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 6
  %388 = load i32, ptr %387, align 8
  %389 = add i32 %386, %388
  %390 = lshr i32 %389, 19
  %391 = or i32 %384, %390
  %392 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %393 = load i32, ptr %392, align 16
  %394 = xor i32 %393, %391
  store i32 %394, ptr %392, align 16
  %395 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %396 = load i32, ptr %395, align 16
  %397 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %398 = load i32, ptr %397, align 4
  %399 = add i32 %396, %398
  %400 = shl i32 %399, 18
  %401 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 4
  %402 = load i32, ptr %401, align 16
  %403 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 7
  %404 = load i32, ptr %403, align 4
  %405 = add i32 %402, %404
  %406 = lshr i32 %405, 14
  %407 = or i32 %400, %406
  %408 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 5
  %409 = load i32, ptr %408, align 4
  %410 = xor i32 %409, %407
  store i32 %410, ptr %408, align 4
  %411 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %412 = load i32, ptr %411, align 8
  %413 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %414 = load i32, ptr %413, align 4
  %415 = add i32 %412, %414
  %416 = shl i32 %415, 7
  %417 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %418 = load i32, ptr %417, align 8
  %419 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %420 = load i32, ptr %419, align 4
  %421 = add i32 %418, %420
  %422 = lshr i32 %421, 25
  %423 = or i32 %416, %422
  %424 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %425 = load i32, ptr %424, align 4
  %426 = xor i32 %425, %423
  store i32 %426, ptr %424, align 4
  %427 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %428 = load i32, ptr %427, align 4
  %429 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %430 = load i32, ptr %429, align 8
  %431 = add i32 %428, %430
  %432 = shl i32 %431, 9
  %433 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %434 = load i32, ptr %433, align 4
  %435 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %436 = load i32, ptr %435, align 8
  %437 = add i32 %434, %436
  %438 = lshr i32 %437, 23
  %439 = or i32 %432, %438
  %440 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %441 = load i32, ptr %440, align 16
  %442 = xor i32 %441, %439
  store i32 %442, ptr %440, align 16
  %443 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %444 = load i32, ptr %443, align 16
  %445 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %446 = load i32, ptr %445, align 4
  %447 = add i32 %444, %446
  %448 = shl i32 %447, 13
  %449 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %450 = load i32, ptr %449, align 16
  %451 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 11
  %452 = load i32, ptr %451, align 4
  %453 = add i32 %450, %452
  %454 = lshr i32 %453, 19
  %455 = or i32 %448, %454
  %456 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %457 = load i32, ptr %456, align 4
  %458 = xor i32 %457, %455
  store i32 %458, ptr %456, align 4
  %459 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %460 = load i32, ptr %459, align 4
  %461 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %462 = load i32, ptr %461, align 16
  %463 = add i32 %460, %462
  %464 = shl i32 %463, 18
  %465 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 9
  %466 = load i32, ptr %465, align 4
  %467 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 8
  %468 = load i32, ptr %467, align 16
  %469 = add i32 %466, %468
  %470 = lshr i32 %469, 14
  %471 = or i32 %464, %470
  %472 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 10
  %473 = load i32, ptr %472, align 8
  %474 = xor i32 %473, %471
  store i32 %474, ptr %472, align 8
  %475 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %476 = load i32, ptr %475, align 4
  %477 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %478 = load i32, ptr %477, align 8
  %479 = add i32 %476, %478
  %480 = shl i32 %479, 7
  %481 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %482 = load i32, ptr %481, align 4
  %483 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %484 = load i32, ptr %483, align 8
  %485 = add i32 %482, %484
  %486 = lshr i32 %485, 25
  %487 = or i32 %480, %486
  %488 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %489 = load i32, ptr %488, align 16
  %490 = xor i32 %489, %487
  store i32 %490, ptr %488, align 16
  %491 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %492 = load i32, ptr %491, align 16
  %493 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %494 = load i32, ptr %493, align 4
  %495 = add i32 %492, %494
  %496 = shl i32 %495, 9
  %497 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %498 = load i32, ptr %497, align 16
  %499 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %500 = load i32, ptr %499, align 4
  %501 = add i32 %498, %500
  %502 = lshr i32 %501, 23
  %503 = or i32 %496, %502
  %504 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %505 = load i32, ptr %504, align 4
  %506 = xor i32 %505, %503
  store i32 %506, ptr %504, align 4
  %507 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %508 = load i32, ptr %507, align 4
  %509 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %510 = load i32, ptr %509, align 16
  %511 = add i32 %508, %510
  %512 = shl i32 %511, 13
  %513 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %514 = load i32, ptr %513, align 4
  %515 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 12
  %516 = load i32, ptr %515, align 16
  %517 = add i32 %514, %516
  %518 = lshr i32 %517, 19
  %519 = or i32 %512, %518
  %520 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %521 = load i32, ptr %520, align 8
  %522 = xor i32 %521, %519
  store i32 %522, ptr %520, align 8
  %523 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %524 = load i32, ptr %523, align 8
  %525 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %526 = load i32, ptr %525, align 4
  %527 = add i32 %524, %526
  %528 = shl i32 %527, 18
  %529 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 14
  %530 = load i32, ptr %529, align 8
  %531 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 13
  %532 = load i32, ptr %531, align 4
  %533 = add i32 %530, %532
  %534 = lshr i32 %533, 14
  %535 = or i32 %528, %534
  %536 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 15
  %537 = load i32, ptr %536, align 4
  %538 = xor i32 %537, %535
  store i32 %538, ptr %536, align 4
  br label %539

539:                                              ; preds = %26
  %540 = load i32, ptr %5, align 4
  %541 = sub i32 %540, 2
  store i32 %541, ptr %5, align 4
  br label %23, !llvm.loop !8

542:                                              ; preds = %23
  store i32 0, ptr %5, align 4
  br label %543

543:                                              ; preds = %561, %542
  %544 = load i32, ptr %5, align 4
  %545 = icmp ult i32 %544, 16
  br i1 %545, label %546, label %564

546:                                              ; preds = %543
  %547 = load i32, ptr %5, align 4
  %548 = zext i32 %547 to i64
  %549 = getelementptr inbounds [16 x i32], ptr %6, i64 0, i64 %548
  %550 = load i32, ptr %549, align 4
  %551 = load ptr, ptr %4, align 8
  %552 = load i32, ptr %5, align 4
  %553 = zext i32 %552 to i64
  %554 = getelementptr inbounds i32, ptr %551, i64 %553
  %555 = load i32, ptr %554, align 4
  %556 = add i32 %550, %555
  %557 = load ptr, ptr %3, align 8
  %558 = load i32, ptr %5, align 4
  %559 = zext i32 %558 to i64
  %560 = getelementptr inbounds i32, ptr %557, i64 %559
  store i32 %556, ptr %560, align 4
  br label %561

561:                                              ; preds = %546
  %562 = load i32, ptr %5, align 4
  %563 = add i32 %562, 1
  store i32 %563, ptr %5, align 4
  br label %543, !llvm.loop !9

564:                                              ; preds = %543
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @salsa() #0 {
  %1 = load i32, ptr @ptr, align 4
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %7

3:                                                ; preds = %0
  call void @salsa20(ptr noundef @outbuf, ptr noundef @STATE)
  %4 = load i32, ptr @STATE, align 16
  %5 = add i32 %4, 1
  store i32 %5, ptr @STATE, align 16
  %6 = zext i32 %4 to i64
  br label %7

7:                                                ; preds = %3, %0
  %8 = load i32, ptr @ptr, align 4
  %9 = add i32 %8, 1
  %10 = and i32 %9, 15
  store i32 %10, ptr @ptr, align 4
  %11 = load i32, ptr @ptr, align 4
  %12 = zext i32 %11 to i64
  %13 = getelementptr inbounds [16 x i32], ptr @outbuf, i64 0, i64 %12
  %14 = load i32, ptr %13, align 4
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @llvm_bench_main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 537919488, ptr %3, align 4
  store i32 0, ptr %4, align 4
  store i32 0, ptr %2, align 4
  br label %5

5:                                                ; preds = %18, %0
  %6 = load i32, ptr %2, align 4
  %7 = icmp ult i32 %6, 16
  br i1 %7, label %8, label %21

8:                                                ; preds = %5
  %9 = load i32, ptr %2, align 4
  %10 = add i32 %9, 13
  %11 = add i32 -307516443, %10
  %12 = load i32, ptr %2, align 4
  %13 = sub i32 -559038737, %12
  %14 = xor i32 %11, %13
  %15 = load i32, ptr %2, align 4
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds [16 x i32], ptr @STATE, i64 0, i64 %16
  store i32 %14, ptr %17, align 4
  br label %18

18:                                               ; preds = %8
  %19 = load i32, ptr %2, align 4
  %20 = add i32 %19, 1
  store i32 %20, ptr %2, align 4
  br label %5, !llvm.loop !10

21:                                               ; preds = %5
  store i32 0, ptr %2, align 4
  br label %22

22:                                               ; preds = %28, %21
  %23 = load i32, ptr %2, align 4
  %24 = load i32, ptr %3, align 4
  %25 = icmp ult i32 %23, %24
  br i1 %25, label %26, label %31

26:                                               ; preds = %22
  %27 = call i32 @salsa()
  br label %28

28:                                               ; preds = %26
  %29 = load i32, ptr %2, align 4
  %30 = add i32 %29, 1
  store i32 %30, ptr %2, align 4
  br label %22, !llvm.loop !11

31:                                               ; preds = %22
  %32 = call i32 @salsa()
  store i32 %32, ptr %1, align 4
  %33 = load i32, ptr %4, align 4
  %34 = load i32, ptr %1, align 4
  %35 = add i32 %34, %33
  store i32 %35, ptr %1, align 4
  %36 = load i32, ptr %1, align 4
  %37 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %36)
  %38 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef -162172867)
  %39 = load i32, ptr %1, align 4
  %40 = icmp ne i32 %39, -162172867
  %41 = zext i1 %40 to i32
  ret i32 %41
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
