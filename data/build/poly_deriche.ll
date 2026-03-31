; ModuleID = 'data/polybench-c-4.2.1-beta/medley/deriche/deriche.c'
source_filename = "data/polybench-c-4.2.1-beta/medley/deriche/deriche.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"imgOut\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"%0.2f \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 345600, i32 noundef 4) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 345600, i32 noundef 4) #6
  %5 = ptrtoint ptr %4 to i64
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 345600, i32 noundef 4) #6
  %7 = ptrtoint ptr %6 to i64
  %8 = tail call ptr @polybench_alloc_data(i64 noundef 345600, i32 noundef 4) #6
  %9 = ptrtoint ptr %8 to i64
  br label %10

10:                                               ; preds = %2, %28
  %11 = phi i64 [ 0, %2 ], [ %29, %28 ]
  %12 = mul nuw nsw i64 %11, 313
  %13 = insertelement <4 x i64> poison, i64 %12, i64 0
  %14 = shufflevector <4 x i64> %13, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %10
  %16 = phi i64 [ 0, %10 ], [ %25, %15 ]
  %17 = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %10 ], [ %26, %15 ]
  %18 = mul nuw nsw <4 x i64> %17, <i64 991, i64 991, i64 991, i64 991>
  %19 = add nuw nsw <4 x i64> %18, %14
  %20 = trunc <4 x i64> %19 to <4 x i32>
  %21 = and <4 x i32> %20, <i32 65535, i32 65535, i32 65535, i32 65535>
  %22 = sitofp <4 x i32> %21 to <4 x float>
  %23 = fdiv <4 x float> %22, <float 6.553500e+04, float 6.553500e+04, float 6.553500e+04, float 6.553500e+04>
  %24 = getelementptr inbounds [480 x float], ptr %3, i64 %11, i64 %16
  store <4 x float> %23, ptr %24, align 4, !tbaa !5
  %25 = add nuw i64 %16, 4
  %26 = add <4 x i64> %17, <i64 4, i64 4, i64 4, i64 4>
  %27 = icmp eq i64 %25, 480
  br i1 %27, label %28, label %15, !llvm.loop !9

28:                                               ; preds = %15
  %29 = add nuw nsw i64 %11, 1
  %30 = icmp eq i64 %29, 720
  br i1 %30, label %31, label %10, !llvm.loop !13

31:                                               ; preds = %28, %48
  %32 = phi i64 [ %49, %48 ], [ 0, %28 ]
  br label %33

33:                                               ; preds = %33, %31
  %34 = phi i64 [ 0, %31 ], [ %46, %33 ]
  %35 = phi float [ 0.000000e+00, %31 ], [ %45, %33 ]
  %36 = phi float [ 0.000000e+00, %31 ], [ %43, %33 ]
  %37 = phi float [ 0.000000e+00, %31 ], [ %36, %33 ]
  %38 = getelementptr inbounds [480 x float], ptr %3, i64 %32, i64 %34
  %39 = load float, ptr %38, align 4, !tbaa !5
  %40 = fmul float %35, 0x3FBC36A980000000
  %41 = tail call float @llvm.fmuladd.f32(float %39, float 0xBFC826B880000000, float %40)
  %42 = tail call float @llvm.fmuladd.f32(float %36, float 0x3FEAE89FA0000000, float %41)
  %43 = tail call float @llvm.fmuladd.f32(float %37, float 0xBFE368B300000000, float %42)
  %44 = getelementptr inbounds [480 x float], ptr %6, i64 %32, i64 %34
  store float %43, ptr %44, align 4, !tbaa !5
  %45 = load float, ptr %38, align 4, !tbaa !5
  %46 = add nuw nsw i64 %34, 1
  %47 = icmp eq i64 %46, 480
  br i1 %47, label %48, label %33, !llvm.loop !14

48:                                               ; preds = %33
  %49 = add nuw nsw i64 %32, 1
  %50 = icmp eq i64 %49, 720
  br i1 %50, label %51, label %31, !llvm.loop !15

51:                                               ; preds = %48, %76
  %52 = phi i64 [ %77, %76 ], [ 0, %48 ]
  br label %53

53:                                               ; preds = %53, %51
  %54 = phi i64 [ 479, %51 ], [ %74, %53 ]
  %55 = phi float [ 0.000000e+00, %51 ], [ %73, %53 ]
  %56 = phi float [ 0.000000e+00, %51 ], [ %65, %53 ]
  %57 = phi float [ 0.000000e+00, %51 ], [ %70, %53 ]
  %58 = phi float [ 0.000000e+00, %51 ], [ %62, %53 ]
  %59 = fmul float %56, 0x3FBD4C0500000000
  %60 = tail call float @llvm.fmuladd.f32(float %55, float 0xBFC782E280000000, float %59)
  %61 = tail call float @llvm.fmuladd.f32(float %57, float 0x3FEAE89FA0000000, float %60)
  %62 = tail call float @llvm.fmuladd.f32(float %58, float 0xBFE368B300000000, float %61)
  %63 = getelementptr inbounds [480 x float], ptr %8, i64 %52, i64 %54
  store float %62, ptr %63, align 4, !tbaa !5
  %64 = getelementptr inbounds [480 x float], ptr %3, i64 %52, i64 %54
  %65 = load float, ptr %64, align 4, !tbaa !5
  %66 = add nsw i64 %54, -1
  %67 = fmul float %55, 0x3FBD4C0500000000
  %68 = tail call float @llvm.fmuladd.f32(float %65, float 0xBFC782E280000000, float %67)
  %69 = tail call float @llvm.fmuladd.f32(float %62, float 0x3FEAE89FA0000000, float %68)
  %70 = tail call float @llvm.fmuladd.f32(float %57, float 0xBFE368B300000000, float %69)
  %71 = getelementptr inbounds [480 x float], ptr %8, i64 %52, i64 %66
  store float %70, ptr %71, align 4, !tbaa !5
  %72 = getelementptr inbounds [480 x float], ptr %3, i64 %52, i64 %66
  %73 = load float, ptr %72, align 4, !tbaa !5
  %74 = add nsw i64 %54, -2
  %75 = icmp eq i64 %66, 0
  br i1 %75, label %76, label %53, !llvm.loop !16

76:                                               ; preds = %53
  %77 = add nuw nsw i64 %52, 1
  %78 = icmp eq i64 %77, 720
  br i1 %78, label %79, label %51, !llvm.loop !17

79:                                               ; preds = %76
  %80 = sub i64 %5, %7
  %81 = sub i64 %5, %9
  %82 = icmp ult i64 %80, 32
  %83 = icmp ult i64 %81, 32
  %84 = or i1 %82, %83
  br label %85

85:                                               ; preds = %133, %79
  %86 = phi i64 [ %134, %133 ], [ 0, %79 ]
  br i1 %84, label %116, label %87

87:                                               ; preds = %85, %87
  %88 = phi i64 [ %114, %87 ], [ 0, %85 ]
  %89 = getelementptr inbounds [480 x float], ptr %6, i64 %86, i64 %88
  %90 = getelementptr inbounds float, ptr %89, i64 4
  %91 = load <4 x float>, ptr %89, align 4, !tbaa !5
  %92 = load <4 x float>, ptr %90, align 4, !tbaa !5
  %93 = getelementptr inbounds [480 x float], ptr %8, i64 %86, i64 %88
  %94 = getelementptr inbounds float, ptr %93, i64 4
  %95 = load <4 x float>, ptr %93, align 4, !tbaa !5
  %96 = load <4 x float>, ptr %94, align 4, !tbaa !5
  %97 = fadd <4 x float> %91, %95
  %98 = fadd <4 x float> %92, %96
  %99 = getelementptr inbounds [480 x float], ptr %4, i64 %86, i64 %88
  %100 = getelementptr inbounds float, ptr %99, i64 4
  store <4 x float> %97, ptr %99, align 4, !tbaa !5
  store <4 x float> %98, ptr %100, align 4, !tbaa !5
  %101 = or disjoint i64 %88, 8
  %102 = getelementptr inbounds [480 x float], ptr %6, i64 %86, i64 %101
  %103 = getelementptr inbounds float, ptr %102, i64 4
  %104 = load <4 x float>, ptr %102, align 4, !tbaa !5
  %105 = load <4 x float>, ptr %103, align 4, !tbaa !5
  %106 = getelementptr inbounds [480 x float], ptr %8, i64 %86, i64 %101
  %107 = getelementptr inbounds float, ptr %106, i64 4
  %108 = load <4 x float>, ptr %106, align 4, !tbaa !5
  %109 = load <4 x float>, ptr %107, align 4, !tbaa !5
  %110 = fadd <4 x float> %104, %108
  %111 = fadd <4 x float> %105, %109
  %112 = getelementptr inbounds [480 x float], ptr %4, i64 %86, i64 %101
  %113 = getelementptr inbounds float, ptr %112, i64 4
  store <4 x float> %110, ptr %112, align 4, !tbaa !5
  store <4 x float> %111, ptr %113, align 4, !tbaa !5
  %114 = add nuw nsw i64 %88, 16
  %115 = icmp eq i64 %114, 480
  br i1 %115, label %133, label %87, !llvm.loop !18

116:                                              ; preds = %85, %116
  %117 = phi i64 [ %131, %116 ], [ 0, %85 ]
  %118 = getelementptr inbounds [480 x float], ptr %6, i64 %86, i64 %117
  %119 = load float, ptr %118, align 4, !tbaa !5
  %120 = getelementptr inbounds [480 x float], ptr %8, i64 %86, i64 %117
  %121 = load float, ptr %120, align 4, !tbaa !5
  %122 = fadd float %119, %121
  %123 = getelementptr inbounds [480 x float], ptr %4, i64 %86, i64 %117
  store float %122, ptr %123, align 4, !tbaa !5
  %124 = or disjoint i64 %117, 1
  %125 = getelementptr inbounds [480 x float], ptr %6, i64 %86, i64 %124
  %126 = load float, ptr %125, align 4, !tbaa !5
  %127 = getelementptr inbounds [480 x float], ptr %8, i64 %86, i64 %124
  %128 = load float, ptr %127, align 4, !tbaa !5
  %129 = fadd float %126, %128
  %130 = getelementptr inbounds [480 x float], ptr %4, i64 %86, i64 %124
  store float %129, ptr %130, align 4, !tbaa !5
  %131 = add nuw nsw i64 %117, 2
  %132 = icmp eq i64 %131, 480
  br i1 %132, label %133, label %116, !llvm.loop !19

133:                                              ; preds = %87, %116
  %134 = add nuw nsw i64 %86, 1
  %135 = icmp eq i64 %134, 720
  br i1 %135, label %136, label %85, !llvm.loop !20

136:                                              ; preds = %133, %153
  %137 = phi i64 [ %154, %153 ], [ 0, %133 ]
  br label %138

138:                                              ; preds = %138, %136
  %139 = phi i64 [ 0, %136 ], [ %151, %138 ]
  %140 = phi float [ 0.000000e+00, %136 ], [ %150, %138 ]
  %141 = phi float [ 0.000000e+00, %136 ], [ %148, %138 ]
  %142 = phi float [ 0.000000e+00, %136 ], [ %141, %138 ]
  %143 = getelementptr inbounds [480 x float], ptr %4, i64 %139, i64 %137
  %144 = load float, ptr %143, align 4, !tbaa !5
  %145 = fmul float %140, 0x3FBC36A980000000
  %146 = tail call float @llvm.fmuladd.f32(float %144, float 0xBFC826B880000000, float %145)
  %147 = tail call float @llvm.fmuladd.f32(float %141, float 0x3FEAE89FA0000000, float %146)
  %148 = tail call float @llvm.fmuladd.f32(float %142, float 0xBFE368B300000000, float %147)
  %149 = getelementptr inbounds [480 x float], ptr %6, i64 %139, i64 %137
  store float %148, ptr %149, align 4, !tbaa !5
  %150 = load float, ptr %143, align 4, !tbaa !5
  %151 = add nuw nsw i64 %139, 1
  %152 = icmp eq i64 %151, 720
  br i1 %152, label %153, label %138, !llvm.loop !21

153:                                              ; preds = %138
  %154 = add nuw nsw i64 %137, 1
  %155 = icmp eq i64 %154, 480
  br i1 %155, label %156, label %136, !llvm.loop !22

156:                                              ; preds = %153, %181
  %157 = phi i64 [ %182, %181 ], [ 0, %153 ]
  br label %158

158:                                              ; preds = %158, %156
  %159 = phi i64 [ 719, %156 ], [ %179, %158 ]
  %160 = phi float [ 0.000000e+00, %156 ], [ %178, %158 ]
  %161 = phi float [ 0.000000e+00, %156 ], [ %170, %158 ]
  %162 = phi float [ 0.000000e+00, %156 ], [ %175, %158 ]
  %163 = phi float [ 0.000000e+00, %156 ], [ %167, %158 ]
  %164 = fmul float %161, 0x3FBD4C0500000000
  %165 = tail call float @llvm.fmuladd.f32(float %160, float 0xBFC782E280000000, float %164)
  %166 = tail call float @llvm.fmuladd.f32(float %162, float 0x3FEAE89FA0000000, float %165)
  %167 = tail call float @llvm.fmuladd.f32(float %163, float 0xBFE368B300000000, float %166)
  %168 = getelementptr inbounds [480 x float], ptr %8, i64 %159, i64 %157
  store float %167, ptr %168, align 4, !tbaa !5
  %169 = getelementptr inbounds [480 x float], ptr %4, i64 %159, i64 %157
  %170 = load float, ptr %169, align 4, !tbaa !5
  %171 = add nsw i64 %159, -1
  %172 = fmul float %160, 0x3FBD4C0500000000
  %173 = tail call float @llvm.fmuladd.f32(float %170, float 0xBFC782E280000000, float %172)
  %174 = tail call float @llvm.fmuladd.f32(float %167, float 0x3FEAE89FA0000000, float %173)
  %175 = tail call float @llvm.fmuladd.f32(float %162, float 0xBFE368B300000000, float %174)
  %176 = getelementptr inbounds [480 x float], ptr %8, i64 %171, i64 %157
  store float %175, ptr %176, align 4, !tbaa !5
  %177 = getelementptr inbounds [480 x float], ptr %4, i64 %171, i64 %157
  %178 = load float, ptr %177, align 4, !tbaa !5
  %179 = add nsw i64 %159, -2
  %180 = icmp eq i64 %171, 0
  br i1 %180, label %181, label %158, !llvm.loop !23

181:                                              ; preds = %158
  %182 = add nuw nsw i64 %157, 1
  %183 = icmp eq i64 %182, 480
  br i1 %183, label %184, label %156, !llvm.loop !24

184:                                              ; preds = %181
  %185 = sub i64 %5, %7
  %186 = sub i64 %5, %9
  %187 = icmp ult i64 %185, 32
  %188 = icmp ult i64 %186, 32
  %189 = or i1 %187, %188
  br label %190

190:                                              ; preds = %238, %184
  %191 = phi i64 [ %239, %238 ], [ 0, %184 ]
  br i1 %189, label %221, label %192

192:                                              ; preds = %190, %192
  %193 = phi i64 [ %219, %192 ], [ 0, %190 ]
  %194 = getelementptr inbounds [480 x float], ptr %6, i64 %191, i64 %193
  %195 = getelementptr inbounds float, ptr %194, i64 4
  %196 = load <4 x float>, ptr %194, align 4, !tbaa !5
  %197 = load <4 x float>, ptr %195, align 4, !tbaa !5
  %198 = getelementptr inbounds [480 x float], ptr %8, i64 %191, i64 %193
  %199 = getelementptr inbounds float, ptr %198, i64 4
  %200 = load <4 x float>, ptr %198, align 4, !tbaa !5
  %201 = load <4 x float>, ptr %199, align 4, !tbaa !5
  %202 = fadd <4 x float> %196, %200
  %203 = fadd <4 x float> %197, %201
  %204 = getelementptr inbounds [480 x float], ptr %4, i64 %191, i64 %193
  %205 = getelementptr inbounds float, ptr %204, i64 4
  store <4 x float> %202, ptr %204, align 4, !tbaa !5
  store <4 x float> %203, ptr %205, align 4, !tbaa !5
  %206 = or disjoint i64 %193, 8
  %207 = getelementptr inbounds [480 x float], ptr %6, i64 %191, i64 %206
  %208 = getelementptr inbounds float, ptr %207, i64 4
  %209 = load <4 x float>, ptr %207, align 4, !tbaa !5
  %210 = load <4 x float>, ptr %208, align 4, !tbaa !5
  %211 = getelementptr inbounds [480 x float], ptr %8, i64 %191, i64 %206
  %212 = getelementptr inbounds float, ptr %211, i64 4
  %213 = load <4 x float>, ptr %211, align 4, !tbaa !5
  %214 = load <4 x float>, ptr %212, align 4, !tbaa !5
  %215 = fadd <4 x float> %209, %213
  %216 = fadd <4 x float> %210, %214
  %217 = getelementptr inbounds [480 x float], ptr %4, i64 %191, i64 %206
  %218 = getelementptr inbounds float, ptr %217, i64 4
  store <4 x float> %215, ptr %217, align 4, !tbaa !5
  store <4 x float> %216, ptr %218, align 4, !tbaa !5
  %219 = add nuw nsw i64 %193, 16
  %220 = icmp eq i64 %219, 480
  br i1 %220, label %238, label %192, !llvm.loop !25

221:                                              ; preds = %190, %221
  %222 = phi i64 [ %236, %221 ], [ 0, %190 ]
  %223 = getelementptr inbounds [480 x float], ptr %6, i64 %191, i64 %222
  %224 = load float, ptr %223, align 4, !tbaa !5
  %225 = getelementptr inbounds [480 x float], ptr %8, i64 %191, i64 %222
  %226 = load float, ptr %225, align 4, !tbaa !5
  %227 = fadd float %224, %226
  %228 = getelementptr inbounds [480 x float], ptr %4, i64 %191, i64 %222
  store float %227, ptr %228, align 4, !tbaa !5
  %229 = or disjoint i64 %222, 1
  %230 = getelementptr inbounds [480 x float], ptr %6, i64 %191, i64 %229
  %231 = load float, ptr %230, align 4, !tbaa !5
  %232 = getelementptr inbounds [480 x float], ptr %8, i64 %191, i64 %229
  %233 = load float, ptr %232, align 4, !tbaa !5
  %234 = fadd float %231, %233
  %235 = getelementptr inbounds [480 x float], ptr %4, i64 %191, i64 %229
  store float %234, ptr %235, align 4, !tbaa !5
  %236 = add nuw nsw i64 %222, 2
  %237 = icmp eq i64 %236, 480
  br i1 %237, label %238, label %221, !llvm.loop !26

238:                                              ; preds = %192, %221
  %239 = add nuw nsw i64 %191, 1
  %240 = icmp eq i64 %239, 720
  br i1 %240, label %241, label %190, !llvm.loop !27

241:                                              ; preds = %238
  %242 = icmp sgt i32 %0, 42
  br i1 %242, label %243, label %280

243:                                              ; preds = %241
  %244 = load ptr, ptr %1, align 8, !tbaa !28
  %245 = load i8, ptr %244, align 1
  %246 = icmp eq i8 %245, 0
  br i1 %246, label %247, label %280

247:                                              ; preds = %243
  %248 = load ptr, ptr @stderr, align 8, !tbaa !28
  %249 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %248) #7
  %250 = load ptr, ptr @stderr, align 8, !tbaa !28
  %251 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %250, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %252

252:                                              ; preds = %272, %247
  %253 = phi i64 [ 0, %247 ], [ %273, %272 ]
  %254 = mul nuw nsw i64 %253, 480
  br label %255

255:                                              ; preds = %264, %252
  %256 = phi i64 [ 0, %252 ], [ %270, %264 ]
  %257 = add nuw nsw i64 %256, %254
  %258 = trunc i64 %257 to i32
  %259 = urem i32 %258, 20
  %260 = icmp eq i32 %259, 0
  br i1 %260, label %261, label %264

261:                                              ; preds = %255
  %262 = load ptr, ptr @stderr, align 8, !tbaa !28
  %263 = tail call i32 @fputc(i32 10, ptr %262)
  br label %264

264:                                              ; preds = %261, %255
  %265 = load ptr, ptr @stderr, align 8, !tbaa !28
  %266 = getelementptr inbounds [480 x float], ptr %4, i64 %253, i64 %256
  %267 = load float, ptr %266, align 4, !tbaa !5
  %268 = fpext float %267 to double
  %269 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %265, ptr noundef nonnull @.str.5, double noundef %268) #7
  %270 = add nuw nsw i64 %256, 1
  %271 = icmp eq i64 %270, 480
  br i1 %271, label %272, label %255, !llvm.loop !30

272:                                              ; preds = %264
  %273 = add nuw nsw i64 %253, 1
  %274 = icmp eq i64 %273, 720
  br i1 %274, label %275, label %252, !llvm.loop !31

275:                                              ; preds = %272
  %276 = load ptr, ptr @stderr, align 8, !tbaa !28
  %277 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %276, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %278 = load ptr, ptr @stderr, align 8, !tbaa !28
  %279 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %278) #7
  br label %280

280:                                              ; preds = %275, %243, %241
  tail call void @free(ptr noundef %3) #6
  tail call void @free(ptr noundef nonnull %4) #6
  tail call void @free(ptr noundef %6) #6
  tail call void @free(ptr noundef %8) #6
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #3

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #5

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
attributes #6 = { nounwind }
attributes #7 = { cold }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"float", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10, !11, !12}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.isvectorized", i32 1}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
!13 = distinct !{!13, !10}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = distinct !{!17, !10}
!18 = distinct !{!18, !10, !11, !12}
!19 = distinct !{!19, !10, !11}
!20 = distinct !{!20, !10}
!21 = distinct !{!21, !10}
!22 = distinct !{!22, !10}
!23 = distinct !{!23, !10}
!24 = distinct !{!24, !10}
!25 = distinct !{!25, !10, !11, !12}
!26 = distinct !{!26, !10, !11}
!27 = distinct !{!27, !10}
!28 = !{!29, !29, i64 0}
!29 = !{!"any pointer", !7, i64 0}
!30 = distinct !{!30, !10}
!31 = distinct !{!31, !10}
