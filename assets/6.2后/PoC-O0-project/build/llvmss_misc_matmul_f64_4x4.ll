; ModuleID = '/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/Misc/matmul_f64_4x4.c'
source_filename = "/home/luomz/wasm/data/llvm-test-suite/SingleSource/Benchmarks/Misc/matmul_f64_4x4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@__const.llvm_bench_main.A = private unnamed_addr constant [4 x [4 x double]] [[4 x double] [double 4.500000e+00, double 1.300000e+00, double 6.000000e+00, double 4.100000e+00], [4 x double] [double 2.500000e+00, double 7.200000e+00, double 7.700000e+00, double 1.700000e+00], [4 x double] [double 6.700000e+00, double 1.300000e+00, double 9.400000e+00, double 1.300000e+00], [4 x double] [double 1.100000e+00, double 2.200000e+00, double 3.000000e+00, double 2.100000e+00]], align 16
@__const.llvm_bench_main.B = private unnamed_addr constant [4 x [4 x double]] [[4 x double] [double 1.000000e+00, double 7.900000e+00, double 5.100000e+00, double 3.400000e+00], [4 x double] [double 6.600000e+00, double 2.800000e+00, double 5.400000e+00, double 0x4022666666666666], [4 x double] [double 5.000000e+00, double 4.100000e+00, double 4.100000e+00, double 9.900000e+00], [4 x double] [double 8.400000e+00, double 3.700000e+00, double 9.500000e+00, double 6.400000e+00]], align 16
@.str = private unnamed_addr constant [6 x i8] c"%8.2f\00", align 1
@.str.1 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @wrap_mul4(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  call void @mul4(ptr noundef %7, ptr noundef %8, ptr noundef %9)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @mul4(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca [16 x double], align 16
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = getelementptr inbounds [4 x double], ptr %9, i64 0
  %11 = getelementptr inbounds [4 x double], ptr %10, i64 0, i64 0
  %12 = load double, ptr %11, align 8
  %13 = load ptr, ptr %6, align 8
  %14 = getelementptr inbounds [4 x double], ptr %13, i64 0
  %15 = getelementptr inbounds [4 x double], ptr %14, i64 0, i64 0
  %16 = load double, ptr %15, align 8
  %17 = load ptr, ptr %5, align 8
  %18 = getelementptr inbounds [4 x double], ptr %17, i64 0
  %19 = getelementptr inbounds [4 x double], ptr %18, i64 0, i64 1
  %20 = load double, ptr %19, align 8
  %21 = load ptr, ptr %6, align 8
  %22 = getelementptr inbounds [4 x double], ptr %21, i64 1
  %23 = getelementptr inbounds [4 x double], ptr %22, i64 0, i64 0
  %24 = load double, ptr %23, align 8
  %25 = fmul double %20, %24
  %26 = call double @llvm.fmuladd.f64(double %12, double %16, double %25)
  %27 = load ptr, ptr %5, align 8
  %28 = getelementptr inbounds [4 x double], ptr %27, i64 0
  %29 = getelementptr inbounds [4 x double], ptr %28, i64 0, i64 2
  %30 = load double, ptr %29, align 8
  %31 = load ptr, ptr %6, align 8
  %32 = getelementptr inbounds [4 x double], ptr %31, i64 2
  %33 = getelementptr inbounds [4 x double], ptr %32, i64 0, i64 0
  %34 = load double, ptr %33, align 8
  %35 = call double @llvm.fmuladd.f64(double %30, double %34, double %26)
  %36 = load ptr, ptr %5, align 8
  %37 = getelementptr inbounds [4 x double], ptr %36, i64 0
  %38 = getelementptr inbounds [4 x double], ptr %37, i64 0, i64 3
  %39 = load double, ptr %38, align 8
  %40 = load ptr, ptr %6, align 8
  %41 = getelementptr inbounds [4 x double], ptr %40, i64 3
  %42 = getelementptr inbounds [4 x double], ptr %41, i64 0, i64 0
  %43 = load double, ptr %42, align 8
  %44 = call double @llvm.fmuladd.f64(double %39, double %43, double %35)
  %45 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 0
  store double %44, ptr %45, align 16
  %46 = load ptr, ptr %5, align 8
  %47 = getelementptr inbounds [4 x double], ptr %46, i64 0
  %48 = getelementptr inbounds [4 x double], ptr %47, i64 0, i64 0
  %49 = load double, ptr %48, align 8
  %50 = load ptr, ptr %6, align 8
  %51 = getelementptr inbounds [4 x double], ptr %50, i64 0
  %52 = getelementptr inbounds [4 x double], ptr %51, i64 0, i64 1
  %53 = load double, ptr %52, align 8
  %54 = load ptr, ptr %5, align 8
  %55 = getelementptr inbounds [4 x double], ptr %54, i64 0
  %56 = getelementptr inbounds [4 x double], ptr %55, i64 0, i64 1
  %57 = load double, ptr %56, align 8
  %58 = load ptr, ptr %6, align 8
  %59 = getelementptr inbounds [4 x double], ptr %58, i64 1
  %60 = getelementptr inbounds [4 x double], ptr %59, i64 0, i64 1
  %61 = load double, ptr %60, align 8
  %62 = fmul double %57, %61
  %63 = call double @llvm.fmuladd.f64(double %49, double %53, double %62)
  %64 = load ptr, ptr %5, align 8
  %65 = getelementptr inbounds [4 x double], ptr %64, i64 0
  %66 = getelementptr inbounds [4 x double], ptr %65, i64 0, i64 2
  %67 = load double, ptr %66, align 8
  %68 = load ptr, ptr %6, align 8
  %69 = getelementptr inbounds [4 x double], ptr %68, i64 2
  %70 = getelementptr inbounds [4 x double], ptr %69, i64 0, i64 1
  %71 = load double, ptr %70, align 8
  %72 = call double @llvm.fmuladd.f64(double %67, double %71, double %63)
  %73 = load ptr, ptr %5, align 8
  %74 = getelementptr inbounds [4 x double], ptr %73, i64 0
  %75 = getelementptr inbounds [4 x double], ptr %74, i64 0, i64 3
  %76 = load double, ptr %75, align 8
  %77 = load ptr, ptr %6, align 8
  %78 = getelementptr inbounds [4 x double], ptr %77, i64 3
  %79 = getelementptr inbounds [4 x double], ptr %78, i64 0, i64 1
  %80 = load double, ptr %79, align 8
  %81 = call double @llvm.fmuladd.f64(double %76, double %80, double %72)
  %82 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 1
  store double %81, ptr %82, align 8
  %83 = load ptr, ptr %5, align 8
  %84 = getelementptr inbounds [4 x double], ptr %83, i64 0
  %85 = getelementptr inbounds [4 x double], ptr %84, i64 0, i64 0
  %86 = load double, ptr %85, align 8
  %87 = load ptr, ptr %6, align 8
  %88 = getelementptr inbounds [4 x double], ptr %87, i64 0
  %89 = getelementptr inbounds [4 x double], ptr %88, i64 0, i64 2
  %90 = load double, ptr %89, align 8
  %91 = load ptr, ptr %5, align 8
  %92 = getelementptr inbounds [4 x double], ptr %91, i64 0
  %93 = getelementptr inbounds [4 x double], ptr %92, i64 0, i64 1
  %94 = load double, ptr %93, align 8
  %95 = load ptr, ptr %6, align 8
  %96 = getelementptr inbounds [4 x double], ptr %95, i64 1
  %97 = getelementptr inbounds [4 x double], ptr %96, i64 0, i64 2
  %98 = load double, ptr %97, align 8
  %99 = fmul double %94, %98
  %100 = call double @llvm.fmuladd.f64(double %86, double %90, double %99)
  %101 = load ptr, ptr %5, align 8
  %102 = getelementptr inbounds [4 x double], ptr %101, i64 0
  %103 = getelementptr inbounds [4 x double], ptr %102, i64 0, i64 2
  %104 = load double, ptr %103, align 8
  %105 = load ptr, ptr %6, align 8
  %106 = getelementptr inbounds [4 x double], ptr %105, i64 2
  %107 = getelementptr inbounds [4 x double], ptr %106, i64 0, i64 2
  %108 = load double, ptr %107, align 8
  %109 = call double @llvm.fmuladd.f64(double %104, double %108, double %100)
  %110 = load ptr, ptr %5, align 8
  %111 = getelementptr inbounds [4 x double], ptr %110, i64 0
  %112 = getelementptr inbounds [4 x double], ptr %111, i64 0, i64 3
  %113 = load double, ptr %112, align 8
  %114 = load ptr, ptr %6, align 8
  %115 = getelementptr inbounds [4 x double], ptr %114, i64 3
  %116 = getelementptr inbounds [4 x double], ptr %115, i64 0, i64 2
  %117 = load double, ptr %116, align 8
  %118 = call double @llvm.fmuladd.f64(double %113, double %117, double %109)
  %119 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 2
  store double %118, ptr %119, align 16
  %120 = load ptr, ptr %5, align 8
  %121 = getelementptr inbounds [4 x double], ptr %120, i64 0
  %122 = getelementptr inbounds [4 x double], ptr %121, i64 0, i64 0
  %123 = load double, ptr %122, align 8
  %124 = load ptr, ptr %6, align 8
  %125 = getelementptr inbounds [4 x double], ptr %124, i64 0
  %126 = getelementptr inbounds [4 x double], ptr %125, i64 0, i64 3
  %127 = load double, ptr %126, align 8
  %128 = load ptr, ptr %5, align 8
  %129 = getelementptr inbounds [4 x double], ptr %128, i64 0
  %130 = getelementptr inbounds [4 x double], ptr %129, i64 0, i64 1
  %131 = load double, ptr %130, align 8
  %132 = load ptr, ptr %6, align 8
  %133 = getelementptr inbounds [4 x double], ptr %132, i64 1
  %134 = getelementptr inbounds [4 x double], ptr %133, i64 0, i64 3
  %135 = load double, ptr %134, align 8
  %136 = fmul double %131, %135
  %137 = call double @llvm.fmuladd.f64(double %123, double %127, double %136)
  %138 = load ptr, ptr %5, align 8
  %139 = getelementptr inbounds [4 x double], ptr %138, i64 0
  %140 = getelementptr inbounds [4 x double], ptr %139, i64 0, i64 2
  %141 = load double, ptr %140, align 8
  %142 = load ptr, ptr %6, align 8
  %143 = getelementptr inbounds [4 x double], ptr %142, i64 2
  %144 = getelementptr inbounds [4 x double], ptr %143, i64 0, i64 3
  %145 = load double, ptr %144, align 8
  %146 = call double @llvm.fmuladd.f64(double %141, double %145, double %137)
  %147 = load ptr, ptr %5, align 8
  %148 = getelementptr inbounds [4 x double], ptr %147, i64 0
  %149 = getelementptr inbounds [4 x double], ptr %148, i64 0, i64 3
  %150 = load double, ptr %149, align 8
  %151 = load ptr, ptr %6, align 8
  %152 = getelementptr inbounds [4 x double], ptr %151, i64 3
  %153 = getelementptr inbounds [4 x double], ptr %152, i64 0, i64 3
  %154 = load double, ptr %153, align 8
  %155 = call double @llvm.fmuladd.f64(double %150, double %154, double %146)
  %156 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 3
  store double %155, ptr %156, align 8
  %157 = load ptr, ptr %5, align 8
  %158 = getelementptr inbounds [4 x double], ptr %157, i64 1
  %159 = getelementptr inbounds [4 x double], ptr %158, i64 0, i64 0
  %160 = load double, ptr %159, align 8
  %161 = load ptr, ptr %6, align 8
  %162 = getelementptr inbounds [4 x double], ptr %161, i64 0
  %163 = getelementptr inbounds [4 x double], ptr %162, i64 0, i64 0
  %164 = load double, ptr %163, align 8
  %165 = load ptr, ptr %5, align 8
  %166 = getelementptr inbounds [4 x double], ptr %165, i64 1
  %167 = getelementptr inbounds [4 x double], ptr %166, i64 0, i64 1
  %168 = load double, ptr %167, align 8
  %169 = load ptr, ptr %6, align 8
  %170 = getelementptr inbounds [4 x double], ptr %169, i64 1
  %171 = getelementptr inbounds [4 x double], ptr %170, i64 0, i64 0
  %172 = load double, ptr %171, align 8
  %173 = fmul double %168, %172
  %174 = call double @llvm.fmuladd.f64(double %160, double %164, double %173)
  %175 = load ptr, ptr %5, align 8
  %176 = getelementptr inbounds [4 x double], ptr %175, i64 1
  %177 = getelementptr inbounds [4 x double], ptr %176, i64 0, i64 2
  %178 = load double, ptr %177, align 8
  %179 = load ptr, ptr %6, align 8
  %180 = getelementptr inbounds [4 x double], ptr %179, i64 2
  %181 = getelementptr inbounds [4 x double], ptr %180, i64 0, i64 0
  %182 = load double, ptr %181, align 8
  %183 = call double @llvm.fmuladd.f64(double %178, double %182, double %174)
  %184 = load ptr, ptr %5, align 8
  %185 = getelementptr inbounds [4 x double], ptr %184, i64 1
  %186 = getelementptr inbounds [4 x double], ptr %185, i64 0, i64 3
  %187 = load double, ptr %186, align 8
  %188 = load ptr, ptr %6, align 8
  %189 = getelementptr inbounds [4 x double], ptr %188, i64 3
  %190 = getelementptr inbounds [4 x double], ptr %189, i64 0, i64 0
  %191 = load double, ptr %190, align 8
  %192 = call double @llvm.fmuladd.f64(double %187, double %191, double %183)
  %193 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 4
  store double %192, ptr %193, align 16
  %194 = load ptr, ptr %5, align 8
  %195 = getelementptr inbounds [4 x double], ptr %194, i64 1
  %196 = getelementptr inbounds [4 x double], ptr %195, i64 0, i64 0
  %197 = load double, ptr %196, align 8
  %198 = load ptr, ptr %6, align 8
  %199 = getelementptr inbounds [4 x double], ptr %198, i64 0
  %200 = getelementptr inbounds [4 x double], ptr %199, i64 0, i64 1
  %201 = load double, ptr %200, align 8
  %202 = load ptr, ptr %5, align 8
  %203 = getelementptr inbounds [4 x double], ptr %202, i64 1
  %204 = getelementptr inbounds [4 x double], ptr %203, i64 0, i64 1
  %205 = load double, ptr %204, align 8
  %206 = load ptr, ptr %6, align 8
  %207 = getelementptr inbounds [4 x double], ptr %206, i64 1
  %208 = getelementptr inbounds [4 x double], ptr %207, i64 0, i64 1
  %209 = load double, ptr %208, align 8
  %210 = fmul double %205, %209
  %211 = call double @llvm.fmuladd.f64(double %197, double %201, double %210)
  %212 = load ptr, ptr %5, align 8
  %213 = getelementptr inbounds [4 x double], ptr %212, i64 1
  %214 = getelementptr inbounds [4 x double], ptr %213, i64 0, i64 2
  %215 = load double, ptr %214, align 8
  %216 = load ptr, ptr %6, align 8
  %217 = getelementptr inbounds [4 x double], ptr %216, i64 2
  %218 = getelementptr inbounds [4 x double], ptr %217, i64 0, i64 1
  %219 = load double, ptr %218, align 8
  %220 = call double @llvm.fmuladd.f64(double %215, double %219, double %211)
  %221 = load ptr, ptr %5, align 8
  %222 = getelementptr inbounds [4 x double], ptr %221, i64 1
  %223 = getelementptr inbounds [4 x double], ptr %222, i64 0, i64 3
  %224 = load double, ptr %223, align 8
  %225 = load ptr, ptr %6, align 8
  %226 = getelementptr inbounds [4 x double], ptr %225, i64 3
  %227 = getelementptr inbounds [4 x double], ptr %226, i64 0, i64 1
  %228 = load double, ptr %227, align 8
  %229 = call double @llvm.fmuladd.f64(double %224, double %228, double %220)
  %230 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 5
  store double %229, ptr %230, align 8
  %231 = load ptr, ptr %5, align 8
  %232 = getelementptr inbounds [4 x double], ptr %231, i64 1
  %233 = getelementptr inbounds [4 x double], ptr %232, i64 0, i64 0
  %234 = load double, ptr %233, align 8
  %235 = load ptr, ptr %6, align 8
  %236 = getelementptr inbounds [4 x double], ptr %235, i64 0
  %237 = getelementptr inbounds [4 x double], ptr %236, i64 0, i64 2
  %238 = load double, ptr %237, align 8
  %239 = load ptr, ptr %5, align 8
  %240 = getelementptr inbounds [4 x double], ptr %239, i64 1
  %241 = getelementptr inbounds [4 x double], ptr %240, i64 0, i64 1
  %242 = load double, ptr %241, align 8
  %243 = load ptr, ptr %6, align 8
  %244 = getelementptr inbounds [4 x double], ptr %243, i64 1
  %245 = getelementptr inbounds [4 x double], ptr %244, i64 0, i64 2
  %246 = load double, ptr %245, align 8
  %247 = fmul double %242, %246
  %248 = call double @llvm.fmuladd.f64(double %234, double %238, double %247)
  %249 = load ptr, ptr %5, align 8
  %250 = getelementptr inbounds [4 x double], ptr %249, i64 1
  %251 = getelementptr inbounds [4 x double], ptr %250, i64 0, i64 2
  %252 = load double, ptr %251, align 8
  %253 = load ptr, ptr %6, align 8
  %254 = getelementptr inbounds [4 x double], ptr %253, i64 2
  %255 = getelementptr inbounds [4 x double], ptr %254, i64 0, i64 2
  %256 = load double, ptr %255, align 8
  %257 = call double @llvm.fmuladd.f64(double %252, double %256, double %248)
  %258 = load ptr, ptr %5, align 8
  %259 = getelementptr inbounds [4 x double], ptr %258, i64 1
  %260 = getelementptr inbounds [4 x double], ptr %259, i64 0, i64 3
  %261 = load double, ptr %260, align 8
  %262 = load ptr, ptr %6, align 8
  %263 = getelementptr inbounds [4 x double], ptr %262, i64 3
  %264 = getelementptr inbounds [4 x double], ptr %263, i64 0, i64 2
  %265 = load double, ptr %264, align 8
  %266 = call double @llvm.fmuladd.f64(double %261, double %265, double %257)
  %267 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 6
  store double %266, ptr %267, align 16
  %268 = load ptr, ptr %5, align 8
  %269 = getelementptr inbounds [4 x double], ptr %268, i64 1
  %270 = getelementptr inbounds [4 x double], ptr %269, i64 0, i64 0
  %271 = load double, ptr %270, align 8
  %272 = load ptr, ptr %6, align 8
  %273 = getelementptr inbounds [4 x double], ptr %272, i64 0
  %274 = getelementptr inbounds [4 x double], ptr %273, i64 0, i64 3
  %275 = load double, ptr %274, align 8
  %276 = load ptr, ptr %5, align 8
  %277 = getelementptr inbounds [4 x double], ptr %276, i64 1
  %278 = getelementptr inbounds [4 x double], ptr %277, i64 0, i64 1
  %279 = load double, ptr %278, align 8
  %280 = load ptr, ptr %6, align 8
  %281 = getelementptr inbounds [4 x double], ptr %280, i64 1
  %282 = getelementptr inbounds [4 x double], ptr %281, i64 0, i64 3
  %283 = load double, ptr %282, align 8
  %284 = fmul double %279, %283
  %285 = call double @llvm.fmuladd.f64(double %271, double %275, double %284)
  %286 = load ptr, ptr %5, align 8
  %287 = getelementptr inbounds [4 x double], ptr %286, i64 1
  %288 = getelementptr inbounds [4 x double], ptr %287, i64 0, i64 2
  %289 = load double, ptr %288, align 8
  %290 = load ptr, ptr %6, align 8
  %291 = getelementptr inbounds [4 x double], ptr %290, i64 2
  %292 = getelementptr inbounds [4 x double], ptr %291, i64 0, i64 3
  %293 = load double, ptr %292, align 8
  %294 = call double @llvm.fmuladd.f64(double %289, double %293, double %285)
  %295 = load ptr, ptr %5, align 8
  %296 = getelementptr inbounds [4 x double], ptr %295, i64 1
  %297 = getelementptr inbounds [4 x double], ptr %296, i64 0, i64 3
  %298 = load double, ptr %297, align 8
  %299 = load ptr, ptr %6, align 8
  %300 = getelementptr inbounds [4 x double], ptr %299, i64 3
  %301 = getelementptr inbounds [4 x double], ptr %300, i64 0, i64 3
  %302 = load double, ptr %301, align 8
  %303 = call double @llvm.fmuladd.f64(double %298, double %302, double %294)
  %304 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 7
  store double %303, ptr %304, align 8
  %305 = load ptr, ptr %5, align 8
  %306 = getelementptr inbounds [4 x double], ptr %305, i64 2
  %307 = getelementptr inbounds [4 x double], ptr %306, i64 0, i64 0
  %308 = load double, ptr %307, align 8
  %309 = load ptr, ptr %6, align 8
  %310 = getelementptr inbounds [4 x double], ptr %309, i64 0
  %311 = getelementptr inbounds [4 x double], ptr %310, i64 0, i64 0
  %312 = load double, ptr %311, align 8
  %313 = load ptr, ptr %5, align 8
  %314 = getelementptr inbounds [4 x double], ptr %313, i64 2
  %315 = getelementptr inbounds [4 x double], ptr %314, i64 0, i64 1
  %316 = load double, ptr %315, align 8
  %317 = load ptr, ptr %6, align 8
  %318 = getelementptr inbounds [4 x double], ptr %317, i64 1
  %319 = getelementptr inbounds [4 x double], ptr %318, i64 0, i64 0
  %320 = load double, ptr %319, align 8
  %321 = fmul double %316, %320
  %322 = call double @llvm.fmuladd.f64(double %308, double %312, double %321)
  %323 = load ptr, ptr %5, align 8
  %324 = getelementptr inbounds [4 x double], ptr %323, i64 2
  %325 = getelementptr inbounds [4 x double], ptr %324, i64 0, i64 2
  %326 = load double, ptr %325, align 8
  %327 = load ptr, ptr %6, align 8
  %328 = getelementptr inbounds [4 x double], ptr %327, i64 2
  %329 = getelementptr inbounds [4 x double], ptr %328, i64 0, i64 0
  %330 = load double, ptr %329, align 8
  %331 = call double @llvm.fmuladd.f64(double %326, double %330, double %322)
  %332 = load ptr, ptr %5, align 8
  %333 = getelementptr inbounds [4 x double], ptr %332, i64 2
  %334 = getelementptr inbounds [4 x double], ptr %333, i64 0, i64 3
  %335 = load double, ptr %334, align 8
  %336 = load ptr, ptr %6, align 8
  %337 = getelementptr inbounds [4 x double], ptr %336, i64 3
  %338 = getelementptr inbounds [4 x double], ptr %337, i64 0, i64 0
  %339 = load double, ptr %338, align 8
  %340 = call double @llvm.fmuladd.f64(double %335, double %339, double %331)
  %341 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 8
  store double %340, ptr %341, align 16
  %342 = load ptr, ptr %5, align 8
  %343 = getelementptr inbounds [4 x double], ptr %342, i64 2
  %344 = getelementptr inbounds [4 x double], ptr %343, i64 0, i64 0
  %345 = load double, ptr %344, align 8
  %346 = load ptr, ptr %6, align 8
  %347 = getelementptr inbounds [4 x double], ptr %346, i64 0
  %348 = getelementptr inbounds [4 x double], ptr %347, i64 0, i64 1
  %349 = load double, ptr %348, align 8
  %350 = load ptr, ptr %5, align 8
  %351 = getelementptr inbounds [4 x double], ptr %350, i64 2
  %352 = getelementptr inbounds [4 x double], ptr %351, i64 0, i64 1
  %353 = load double, ptr %352, align 8
  %354 = load ptr, ptr %6, align 8
  %355 = getelementptr inbounds [4 x double], ptr %354, i64 1
  %356 = getelementptr inbounds [4 x double], ptr %355, i64 0, i64 1
  %357 = load double, ptr %356, align 8
  %358 = fmul double %353, %357
  %359 = call double @llvm.fmuladd.f64(double %345, double %349, double %358)
  %360 = load ptr, ptr %5, align 8
  %361 = getelementptr inbounds [4 x double], ptr %360, i64 2
  %362 = getelementptr inbounds [4 x double], ptr %361, i64 0, i64 2
  %363 = load double, ptr %362, align 8
  %364 = load ptr, ptr %6, align 8
  %365 = getelementptr inbounds [4 x double], ptr %364, i64 2
  %366 = getelementptr inbounds [4 x double], ptr %365, i64 0, i64 1
  %367 = load double, ptr %366, align 8
  %368 = call double @llvm.fmuladd.f64(double %363, double %367, double %359)
  %369 = load ptr, ptr %5, align 8
  %370 = getelementptr inbounds [4 x double], ptr %369, i64 2
  %371 = getelementptr inbounds [4 x double], ptr %370, i64 0, i64 3
  %372 = load double, ptr %371, align 8
  %373 = load ptr, ptr %6, align 8
  %374 = getelementptr inbounds [4 x double], ptr %373, i64 3
  %375 = getelementptr inbounds [4 x double], ptr %374, i64 0, i64 1
  %376 = load double, ptr %375, align 8
  %377 = call double @llvm.fmuladd.f64(double %372, double %376, double %368)
  %378 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 9
  store double %377, ptr %378, align 8
  %379 = load ptr, ptr %5, align 8
  %380 = getelementptr inbounds [4 x double], ptr %379, i64 2
  %381 = getelementptr inbounds [4 x double], ptr %380, i64 0, i64 0
  %382 = load double, ptr %381, align 8
  %383 = load ptr, ptr %6, align 8
  %384 = getelementptr inbounds [4 x double], ptr %383, i64 0
  %385 = getelementptr inbounds [4 x double], ptr %384, i64 0, i64 2
  %386 = load double, ptr %385, align 8
  %387 = load ptr, ptr %5, align 8
  %388 = getelementptr inbounds [4 x double], ptr %387, i64 2
  %389 = getelementptr inbounds [4 x double], ptr %388, i64 0, i64 1
  %390 = load double, ptr %389, align 8
  %391 = load ptr, ptr %6, align 8
  %392 = getelementptr inbounds [4 x double], ptr %391, i64 1
  %393 = getelementptr inbounds [4 x double], ptr %392, i64 0, i64 2
  %394 = load double, ptr %393, align 8
  %395 = fmul double %390, %394
  %396 = call double @llvm.fmuladd.f64(double %382, double %386, double %395)
  %397 = load ptr, ptr %5, align 8
  %398 = getelementptr inbounds [4 x double], ptr %397, i64 2
  %399 = getelementptr inbounds [4 x double], ptr %398, i64 0, i64 2
  %400 = load double, ptr %399, align 8
  %401 = load ptr, ptr %6, align 8
  %402 = getelementptr inbounds [4 x double], ptr %401, i64 2
  %403 = getelementptr inbounds [4 x double], ptr %402, i64 0, i64 2
  %404 = load double, ptr %403, align 8
  %405 = call double @llvm.fmuladd.f64(double %400, double %404, double %396)
  %406 = load ptr, ptr %5, align 8
  %407 = getelementptr inbounds [4 x double], ptr %406, i64 2
  %408 = getelementptr inbounds [4 x double], ptr %407, i64 0, i64 3
  %409 = load double, ptr %408, align 8
  %410 = load ptr, ptr %6, align 8
  %411 = getelementptr inbounds [4 x double], ptr %410, i64 3
  %412 = getelementptr inbounds [4 x double], ptr %411, i64 0, i64 2
  %413 = load double, ptr %412, align 8
  %414 = call double @llvm.fmuladd.f64(double %409, double %413, double %405)
  %415 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 10
  store double %414, ptr %415, align 16
  %416 = load ptr, ptr %5, align 8
  %417 = getelementptr inbounds [4 x double], ptr %416, i64 2
  %418 = getelementptr inbounds [4 x double], ptr %417, i64 0, i64 0
  %419 = load double, ptr %418, align 8
  %420 = load ptr, ptr %6, align 8
  %421 = getelementptr inbounds [4 x double], ptr %420, i64 0
  %422 = getelementptr inbounds [4 x double], ptr %421, i64 0, i64 3
  %423 = load double, ptr %422, align 8
  %424 = load ptr, ptr %5, align 8
  %425 = getelementptr inbounds [4 x double], ptr %424, i64 2
  %426 = getelementptr inbounds [4 x double], ptr %425, i64 0, i64 1
  %427 = load double, ptr %426, align 8
  %428 = load ptr, ptr %6, align 8
  %429 = getelementptr inbounds [4 x double], ptr %428, i64 1
  %430 = getelementptr inbounds [4 x double], ptr %429, i64 0, i64 3
  %431 = load double, ptr %430, align 8
  %432 = fmul double %427, %431
  %433 = call double @llvm.fmuladd.f64(double %419, double %423, double %432)
  %434 = load ptr, ptr %5, align 8
  %435 = getelementptr inbounds [4 x double], ptr %434, i64 2
  %436 = getelementptr inbounds [4 x double], ptr %435, i64 0, i64 2
  %437 = load double, ptr %436, align 8
  %438 = load ptr, ptr %6, align 8
  %439 = getelementptr inbounds [4 x double], ptr %438, i64 2
  %440 = getelementptr inbounds [4 x double], ptr %439, i64 0, i64 3
  %441 = load double, ptr %440, align 8
  %442 = call double @llvm.fmuladd.f64(double %437, double %441, double %433)
  %443 = load ptr, ptr %5, align 8
  %444 = getelementptr inbounds [4 x double], ptr %443, i64 2
  %445 = getelementptr inbounds [4 x double], ptr %444, i64 0, i64 3
  %446 = load double, ptr %445, align 8
  %447 = load ptr, ptr %6, align 8
  %448 = getelementptr inbounds [4 x double], ptr %447, i64 3
  %449 = getelementptr inbounds [4 x double], ptr %448, i64 0, i64 3
  %450 = load double, ptr %449, align 8
  %451 = call double @llvm.fmuladd.f64(double %446, double %450, double %442)
  %452 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 11
  store double %451, ptr %452, align 8
  %453 = load ptr, ptr %5, align 8
  %454 = getelementptr inbounds [4 x double], ptr %453, i64 3
  %455 = getelementptr inbounds [4 x double], ptr %454, i64 0, i64 0
  %456 = load double, ptr %455, align 8
  %457 = load ptr, ptr %6, align 8
  %458 = getelementptr inbounds [4 x double], ptr %457, i64 0
  %459 = getelementptr inbounds [4 x double], ptr %458, i64 0, i64 0
  %460 = load double, ptr %459, align 8
  %461 = load ptr, ptr %5, align 8
  %462 = getelementptr inbounds [4 x double], ptr %461, i64 3
  %463 = getelementptr inbounds [4 x double], ptr %462, i64 0, i64 1
  %464 = load double, ptr %463, align 8
  %465 = load ptr, ptr %6, align 8
  %466 = getelementptr inbounds [4 x double], ptr %465, i64 1
  %467 = getelementptr inbounds [4 x double], ptr %466, i64 0, i64 0
  %468 = load double, ptr %467, align 8
  %469 = fmul double %464, %468
  %470 = call double @llvm.fmuladd.f64(double %456, double %460, double %469)
  %471 = load ptr, ptr %5, align 8
  %472 = getelementptr inbounds [4 x double], ptr %471, i64 3
  %473 = getelementptr inbounds [4 x double], ptr %472, i64 0, i64 2
  %474 = load double, ptr %473, align 8
  %475 = load ptr, ptr %6, align 8
  %476 = getelementptr inbounds [4 x double], ptr %475, i64 2
  %477 = getelementptr inbounds [4 x double], ptr %476, i64 0, i64 0
  %478 = load double, ptr %477, align 8
  %479 = call double @llvm.fmuladd.f64(double %474, double %478, double %470)
  %480 = load ptr, ptr %5, align 8
  %481 = getelementptr inbounds [4 x double], ptr %480, i64 3
  %482 = getelementptr inbounds [4 x double], ptr %481, i64 0, i64 3
  %483 = load double, ptr %482, align 8
  %484 = load ptr, ptr %6, align 8
  %485 = getelementptr inbounds [4 x double], ptr %484, i64 3
  %486 = getelementptr inbounds [4 x double], ptr %485, i64 0, i64 0
  %487 = load double, ptr %486, align 8
  %488 = call double @llvm.fmuladd.f64(double %483, double %487, double %479)
  %489 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 12
  store double %488, ptr %489, align 16
  %490 = load ptr, ptr %5, align 8
  %491 = getelementptr inbounds [4 x double], ptr %490, i64 3
  %492 = getelementptr inbounds [4 x double], ptr %491, i64 0, i64 0
  %493 = load double, ptr %492, align 8
  %494 = load ptr, ptr %6, align 8
  %495 = getelementptr inbounds [4 x double], ptr %494, i64 0
  %496 = getelementptr inbounds [4 x double], ptr %495, i64 0, i64 1
  %497 = load double, ptr %496, align 8
  %498 = load ptr, ptr %5, align 8
  %499 = getelementptr inbounds [4 x double], ptr %498, i64 3
  %500 = getelementptr inbounds [4 x double], ptr %499, i64 0, i64 1
  %501 = load double, ptr %500, align 8
  %502 = load ptr, ptr %6, align 8
  %503 = getelementptr inbounds [4 x double], ptr %502, i64 1
  %504 = getelementptr inbounds [4 x double], ptr %503, i64 0, i64 1
  %505 = load double, ptr %504, align 8
  %506 = fmul double %501, %505
  %507 = call double @llvm.fmuladd.f64(double %493, double %497, double %506)
  %508 = load ptr, ptr %5, align 8
  %509 = getelementptr inbounds [4 x double], ptr %508, i64 3
  %510 = getelementptr inbounds [4 x double], ptr %509, i64 0, i64 2
  %511 = load double, ptr %510, align 8
  %512 = load ptr, ptr %6, align 8
  %513 = getelementptr inbounds [4 x double], ptr %512, i64 2
  %514 = getelementptr inbounds [4 x double], ptr %513, i64 0, i64 1
  %515 = load double, ptr %514, align 8
  %516 = call double @llvm.fmuladd.f64(double %511, double %515, double %507)
  %517 = load ptr, ptr %5, align 8
  %518 = getelementptr inbounds [4 x double], ptr %517, i64 3
  %519 = getelementptr inbounds [4 x double], ptr %518, i64 0, i64 3
  %520 = load double, ptr %519, align 8
  %521 = load ptr, ptr %6, align 8
  %522 = getelementptr inbounds [4 x double], ptr %521, i64 3
  %523 = getelementptr inbounds [4 x double], ptr %522, i64 0, i64 1
  %524 = load double, ptr %523, align 8
  %525 = call double @llvm.fmuladd.f64(double %520, double %524, double %516)
  %526 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 13
  store double %525, ptr %526, align 8
  %527 = load ptr, ptr %5, align 8
  %528 = getelementptr inbounds [4 x double], ptr %527, i64 3
  %529 = getelementptr inbounds [4 x double], ptr %528, i64 0, i64 0
  %530 = load double, ptr %529, align 8
  %531 = load ptr, ptr %6, align 8
  %532 = getelementptr inbounds [4 x double], ptr %531, i64 0
  %533 = getelementptr inbounds [4 x double], ptr %532, i64 0, i64 2
  %534 = load double, ptr %533, align 8
  %535 = load ptr, ptr %5, align 8
  %536 = getelementptr inbounds [4 x double], ptr %535, i64 3
  %537 = getelementptr inbounds [4 x double], ptr %536, i64 0, i64 1
  %538 = load double, ptr %537, align 8
  %539 = load ptr, ptr %6, align 8
  %540 = getelementptr inbounds [4 x double], ptr %539, i64 1
  %541 = getelementptr inbounds [4 x double], ptr %540, i64 0, i64 2
  %542 = load double, ptr %541, align 8
  %543 = fmul double %538, %542
  %544 = call double @llvm.fmuladd.f64(double %530, double %534, double %543)
  %545 = load ptr, ptr %5, align 8
  %546 = getelementptr inbounds [4 x double], ptr %545, i64 3
  %547 = getelementptr inbounds [4 x double], ptr %546, i64 0, i64 2
  %548 = load double, ptr %547, align 8
  %549 = load ptr, ptr %6, align 8
  %550 = getelementptr inbounds [4 x double], ptr %549, i64 2
  %551 = getelementptr inbounds [4 x double], ptr %550, i64 0, i64 2
  %552 = load double, ptr %551, align 8
  %553 = call double @llvm.fmuladd.f64(double %548, double %552, double %544)
  %554 = load ptr, ptr %5, align 8
  %555 = getelementptr inbounds [4 x double], ptr %554, i64 3
  %556 = getelementptr inbounds [4 x double], ptr %555, i64 0, i64 3
  %557 = load double, ptr %556, align 8
  %558 = load ptr, ptr %6, align 8
  %559 = getelementptr inbounds [4 x double], ptr %558, i64 3
  %560 = getelementptr inbounds [4 x double], ptr %559, i64 0, i64 2
  %561 = load double, ptr %560, align 8
  %562 = call double @llvm.fmuladd.f64(double %557, double %561, double %553)
  %563 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 14
  store double %562, ptr %563, align 16
  %564 = load ptr, ptr %5, align 8
  %565 = getelementptr inbounds [4 x double], ptr %564, i64 3
  %566 = getelementptr inbounds [4 x double], ptr %565, i64 0, i64 0
  %567 = load double, ptr %566, align 8
  %568 = load ptr, ptr %6, align 8
  %569 = getelementptr inbounds [4 x double], ptr %568, i64 0
  %570 = getelementptr inbounds [4 x double], ptr %569, i64 0, i64 3
  %571 = load double, ptr %570, align 8
  %572 = load ptr, ptr %5, align 8
  %573 = getelementptr inbounds [4 x double], ptr %572, i64 3
  %574 = getelementptr inbounds [4 x double], ptr %573, i64 0, i64 1
  %575 = load double, ptr %574, align 8
  %576 = load ptr, ptr %6, align 8
  %577 = getelementptr inbounds [4 x double], ptr %576, i64 1
  %578 = getelementptr inbounds [4 x double], ptr %577, i64 0, i64 3
  %579 = load double, ptr %578, align 8
  %580 = fmul double %575, %579
  %581 = call double @llvm.fmuladd.f64(double %567, double %571, double %580)
  %582 = load ptr, ptr %5, align 8
  %583 = getelementptr inbounds [4 x double], ptr %582, i64 3
  %584 = getelementptr inbounds [4 x double], ptr %583, i64 0, i64 2
  %585 = load double, ptr %584, align 8
  %586 = load ptr, ptr %6, align 8
  %587 = getelementptr inbounds [4 x double], ptr %586, i64 2
  %588 = getelementptr inbounds [4 x double], ptr %587, i64 0, i64 3
  %589 = load double, ptr %588, align 8
  %590 = call double @llvm.fmuladd.f64(double %585, double %589, double %581)
  %591 = load ptr, ptr %5, align 8
  %592 = getelementptr inbounds [4 x double], ptr %591, i64 3
  %593 = getelementptr inbounds [4 x double], ptr %592, i64 0, i64 3
  %594 = load double, ptr %593, align 8
  %595 = load ptr, ptr %6, align 8
  %596 = getelementptr inbounds [4 x double], ptr %595, i64 3
  %597 = getelementptr inbounds [4 x double], ptr %596, i64 0, i64 3
  %598 = load double, ptr %597, align 8
  %599 = call double @llvm.fmuladd.f64(double %594, double %598, double %590)
  %600 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 15
  store double %599, ptr %600, align 8
  store i32 0, ptr %7, align 4
  br label %601

601:                                              ; preds = %613, %3
  %602 = load i32, ptr %7, align 4
  %603 = icmp ult i32 %602, 16
  br i1 %603, label %604, label %616

604:                                              ; preds = %601
  %605 = load i32, ptr %7, align 4
  %606 = zext i32 %605 to i64
  %607 = getelementptr inbounds [16 x double], ptr %8, i64 0, i64 %606
  %608 = load double, ptr %607, align 8
  %609 = load ptr, ptr %4, align 8
  %610 = load i32, ptr %7, align 4
  %611 = zext i32 %610 to i64
  %612 = getelementptr inbounds double, ptr %609, i64 %611
  store double %608, ptr %612, align 8
  br label %613

613:                                              ; preds = %604
  %614 = load i32, ptr %7, align 4
  %615 = add i32 %614, 1
  store i32 %615, ptr %7, align 4
  br label %601, !llvm.loop !6

616:                                              ; preds = %601
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @llvm_bench_main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [4 x [4 x double]], align 16
  %3 = alloca [4 x [4 x double]], align 16
  %4 = alloca [4 x [4 x double]], align 16
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 50000000, ptr %1, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %2, ptr align 16 @__const.llvm_bench_main.A, i64 128, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %3, ptr align 16 @__const.llvm_bench_main.B, i64 128, i1 false)
  store i32 0, ptr %5, align 4
  br label %7

7:                                                ; preds = %15, %0
  %8 = load i32, ptr %5, align 4
  %9 = icmp ne i32 %8, 50000000
  br i1 %9, label %10, label %18

10:                                               ; preds = %7
  %11 = getelementptr inbounds [4 x [4 x double]], ptr %4, i64 0, i64 0
  %12 = getelementptr inbounds [4 x double], ptr %11, i64 0, i64 0
  %13 = getelementptr inbounds [4 x [4 x double]], ptr %2, i64 0, i64 0
  %14 = getelementptr inbounds [4 x [4 x double]], ptr %3, i64 0, i64 0
  call void @wrap_mul4(ptr noundef %12, ptr noundef %13, ptr noundef %14)
  br label %15

15:                                               ; preds = %10
  %16 = load i32, ptr %5, align 4
  %17 = add i32 %16, 1
  store i32 %17, ptr %5, align 4
  br label %7, !llvm.loop !8

18:                                               ; preds = %7
  store i32 0, ptr %5, align 4
  br label %19

19:                                               ; preds = %40, %18
  %20 = load i32, ptr %5, align 4
  %21 = icmp ne i32 %20, 4
  br i1 %21, label %22, label %43

22:                                               ; preds = %19
  store i32 0, ptr %6, align 4
  br label %23

23:                                               ; preds = %35, %22
  %24 = load i32, ptr %6, align 4
  %25 = icmp ne i32 %24, 4
  br i1 %25, label %26, label %38

26:                                               ; preds = %23
  %27 = load i32, ptr %5, align 4
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds [4 x [4 x double]], ptr %4, i64 0, i64 %28
  %30 = load i32, ptr %6, align 4
  %31 = zext i32 %30 to i64
  %32 = getelementptr inbounds [4 x double], ptr %29, i64 0, i64 %31
  %33 = load double, ptr %32, align 8
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %33)
  br label %35

35:                                               ; preds = %26
  %36 = load i32, ptr %6, align 4
  %37 = add i32 %36, 1
  store i32 %37, ptr %6, align 4
  br label %23, !llvm.loop !9

38:                                               ; preds = %23
  %39 = call i32 @puts(ptr noundef @.str.1)
  br label %40

40:                                               ; preds = %38
  %41 = load i32, ptr %5, align 4
  %42 = add i32 %41, 1
  store i32 %42, ptr %5, align 4
  br label %19, !llvm.loop !10

43:                                               ; preds = %19
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

declare i32 @printf(ptr noundef, ...) #2

declare i32 @puts(ptr noundef) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
