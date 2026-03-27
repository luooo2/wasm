; ModuleID = 'data/polybench-c-4.2.1-beta/stencils/jacobi-2d/jacobi-2d.c'
source_filename = "data/polybench-c-4.2.1-beta/stencils/jacobi-2d/jacobi-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 62500, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 62500, i32 noundef 8) #7
  %6 = ptrtoint ptr %5 to i64
  %7 = sub i64 %6, %4
  %8 = icmp ult i64 %7, 16
  br label %9

9:                                                ; preds = %47, %2
  %10 = phi i64 [ 0, %2 ], [ %48, %47 ]
  %11 = trunc i64 %10 to i32
  %12 = sitofp i32 %11 to double
  br i1 %8, label %32, label %13

13:                                               ; preds = %9
  %14 = insertelement <2 x double> poison, double %12, i64 0
  %15 = shufflevector <2 x double> %14, <2 x double> poison, <2 x i32> zeroinitializer
  br label %16

16:                                               ; preds = %16, %13
  %17 = phi i64 [ 0, %13 ], [ %29, %16 ]
  %18 = phi <2 x i32> [ <i32 0, i32 1>, %13 ], [ %30, %16 ]
  %19 = add <2 x i32> %18, <i32 2, i32 2>
  %20 = sitofp <2 x i32> %19 to <2 x double>
  %21 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %20, <2 x double> <double 2.000000e+00, double 2.000000e+00>)
  %22 = fdiv <2 x double> %21, <double 2.500000e+02, double 2.500000e+02>
  %23 = getelementptr inbounds [250 x double], ptr %3, i64 %10, i64 %17
  store <2 x double> %22, ptr %23, align 8, !tbaa !5
  %24 = add <2 x i32> %18, <i32 3, i32 3>
  %25 = sitofp <2 x i32> %24 to <2 x double>
  %26 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %25, <2 x double> <double 3.000000e+00, double 3.000000e+00>)
  %27 = fdiv <2 x double> %26, <double 2.500000e+02, double 2.500000e+02>
  %28 = getelementptr inbounds [250 x double], ptr %5, i64 %10, i64 %17
  store <2 x double> %27, ptr %28, align 8, !tbaa !5
  %29 = add nuw i64 %17, 2
  %30 = add <2 x i32> %18, <i32 2, i32 2>
  %31 = icmp eq i64 %29, 250
  br i1 %31, label %47, label %16, !llvm.loop !9

32:                                               ; preds = %9, %32
  %33 = phi i64 [ %45, %32 ], [ 0, %9 ]
  %34 = trunc i64 %33 to i32
  %35 = add i32 %34, 2
  %36 = sitofp i32 %35 to double
  %37 = tail call double @llvm.fmuladd.f64(double %12, double %36, double 2.000000e+00)
  %38 = fdiv double %37, 2.500000e+02
  %39 = getelementptr inbounds [250 x double], ptr %3, i64 %10, i64 %33
  store double %38, ptr %39, align 8, !tbaa !5
  %40 = add i32 %34, 3
  %41 = sitofp i32 %40 to double
  %42 = tail call double @llvm.fmuladd.f64(double %12, double %41, double 3.000000e+00)
  %43 = fdiv double %42, 2.500000e+02
  %44 = getelementptr inbounds [250 x double], ptr %5, i64 %10, i64 %33
  store double %43, ptr %44, align 8, !tbaa !5
  %45 = add nuw nsw i64 %33, 1
  %46 = icmp eq i64 %45, 250
  br i1 %46, label %47, label %32, !llvm.loop !13

47:                                               ; preds = %16, %32
  %48 = add nuw nsw i64 %10, 1
  %49 = icmp eq i64 %48, 250
  br i1 %49, label %50, label %9, !llvm.loop !14

50:                                               ; preds = %47
  %51 = getelementptr i8, ptr %3, i64 2008
  %52 = getelementptr i8, ptr %3, i64 497992
  %53 = getelementptr i8, ptr %5, i64 8
  %54 = getelementptr i8, ptr %5, i64 499992
  %55 = getelementptr i8, ptr %5, i64 2008
  %56 = getelementptr i8, ptr %5, i64 497992
  %57 = getelementptr i8, ptr %3, i64 8
  %58 = getelementptr i8, ptr %3, i64 499992
  %59 = icmp ult ptr %55, %58
  %60 = icmp ult ptr %57, %56
  %61 = and i1 %59, %60
  %62 = icmp ult ptr %51, %54
  %63 = icmp ult ptr %53, %52
  %64 = and i1 %62, %63
  br label %65

65:                                               ; preds = %50, %197
  %66 = phi i32 [ %198, %197 ], [ 0, %50 ]
  br label %67

67:                                               ; preds = %129, %65
  %68 = phi i64 [ 1, %65 ], [ %130, %129 ]
  %69 = getelementptr [250 x double], ptr %3, i64 %68
  br i1 %61, label %108, label %70

70:                                               ; preds = %67, %70
  %71 = phi i64 [ %106, %70 ], [ 0, %67 ]
  %72 = or disjoint i64 %71, 1
  %73 = getelementptr inbounds [250 x double], ptr %3, i64 %68, i64 %72
  %74 = getelementptr inbounds double, ptr %73, i64 2
  %75 = load <2 x double>, ptr %73, align 8, !tbaa !5, !alias.scope !15
  %76 = load <2 x double>, ptr %74, align 8, !tbaa !5, !alias.scope !15
  %77 = getelementptr inbounds [250 x double], ptr %3, i64 %68, i64 %71
  %78 = getelementptr inbounds double, ptr %77, i64 2
  %79 = load <2 x double>, ptr %77, align 8, !tbaa !5, !alias.scope !15
  %80 = load <2 x double>, ptr %78, align 8, !tbaa !5, !alias.scope !15
  %81 = fadd <2 x double> %75, %79
  %82 = fadd <2 x double> %76, %80
  %83 = or disjoint i64 %71, 2
  %84 = getelementptr inbounds [250 x double], ptr %3, i64 %68, i64 %83
  %85 = getelementptr inbounds double, ptr %84, i64 2
  %86 = load <2 x double>, ptr %84, align 8, !tbaa !5, !alias.scope !15
  %87 = load <2 x double>, ptr %85, align 8, !tbaa !5, !alias.scope !15
  %88 = fadd <2 x double> %81, %86
  %89 = fadd <2 x double> %82, %87
  %90 = getelementptr [250 x double], ptr %69, i64 1, i64 %72
  %91 = getelementptr double, ptr %90, i64 2
  %92 = load <2 x double>, ptr %90, align 8, !tbaa !5, !alias.scope !15
  %93 = load <2 x double>, ptr %91, align 8, !tbaa !5, !alias.scope !15
  %94 = fadd <2 x double> %88, %92
  %95 = fadd <2 x double> %89, %93
  %96 = getelementptr [250 x double], ptr %69, i64 -1, i64 %72
  %97 = getelementptr double, ptr %96, i64 2
  %98 = load <2 x double>, ptr %96, align 8, !tbaa !5, !alias.scope !15
  %99 = load <2 x double>, ptr %97, align 8, !tbaa !5, !alias.scope !15
  %100 = fadd <2 x double> %94, %98
  %101 = fadd <2 x double> %95, %99
  %102 = fmul <2 x double> %100, <double 2.000000e-01, double 2.000000e-01>
  %103 = fmul <2 x double> %101, <double 2.000000e-01, double 2.000000e-01>
  %104 = getelementptr inbounds [250 x double], ptr %5, i64 %68, i64 %72
  %105 = getelementptr inbounds double, ptr %104, i64 2
  store <2 x double> %102, ptr %104, align 8, !tbaa !5, !alias.scope !18, !noalias !15
  store <2 x double> %103, ptr %105, align 8, !tbaa !5, !alias.scope !18, !noalias !15
  %106 = add nuw i64 %71, 4
  %107 = icmp eq i64 %106, 248
  br i1 %107, label %129, label %70, !llvm.loop !20

108:                                              ; preds = %67, %108
  %109 = phi i64 [ %116, %108 ], [ 1, %67 ]
  %110 = getelementptr inbounds [250 x double], ptr %3, i64 %68, i64 %109
  %111 = load double, ptr %110, align 8, !tbaa !5
  %112 = add nsw i64 %109, -1
  %113 = getelementptr inbounds [250 x double], ptr %3, i64 %68, i64 %112
  %114 = load double, ptr %113, align 8, !tbaa !5
  %115 = fadd double %111, %114
  %116 = add nuw nsw i64 %109, 1
  %117 = getelementptr inbounds [250 x double], ptr %3, i64 %68, i64 %116
  %118 = load double, ptr %117, align 8, !tbaa !5
  %119 = fadd double %115, %118
  %120 = getelementptr [250 x double], ptr %69, i64 1, i64 %109
  %121 = load double, ptr %120, align 8, !tbaa !5
  %122 = fadd double %119, %121
  %123 = getelementptr [250 x double], ptr %69, i64 -1, i64 %109
  %124 = load double, ptr %123, align 8, !tbaa !5
  %125 = fadd double %122, %124
  %126 = fmul double %125, 2.000000e-01
  %127 = getelementptr inbounds [250 x double], ptr %5, i64 %68, i64 %109
  store double %126, ptr %127, align 8, !tbaa !5
  %128 = icmp eq i64 %116, 249
  br i1 %128, label %129, label %108, !llvm.loop !21

129:                                              ; preds = %70, %108
  %130 = add nuw nsw i64 %68, 1
  %131 = icmp eq i64 %130, 249
  br i1 %131, label %132, label %67, !llvm.loop !22

132:                                              ; preds = %129, %194
  %133 = phi i64 [ %195, %194 ], [ 1, %129 ]
  %134 = getelementptr [250 x double], ptr %5, i64 %133
  br i1 %64, label %173, label %135

135:                                              ; preds = %132, %135
  %136 = phi i64 [ %171, %135 ], [ 0, %132 ]
  %137 = or disjoint i64 %136, 1
  %138 = getelementptr inbounds [250 x double], ptr %5, i64 %133, i64 %137
  %139 = getelementptr inbounds double, ptr %138, i64 2
  %140 = load <2 x double>, ptr %138, align 8, !tbaa !5, !alias.scope !23
  %141 = load <2 x double>, ptr %139, align 8, !tbaa !5, !alias.scope !23
  %142 = getelementptr inbounds [250 x double], ptr %5, i64 %133, i64 %136
  %143 = getelementptr inbounds double, ptr %142, i64 2
  %144 = load <2 x double>, ptr %142, align 8, !tbaa !5, !alias.scope !23
  %145 = load <2 x double>, ptr %143, align 8, !tbaa !5, !alias.scope !23
  %146 = fadd <2 x double> %140, %144
  %147 = fadd <2 x double> %141, %145
  %148 = or disjoint i64 %136, 2
  %149 = getelementptr inbounds [250 x double], ptr %5, i64 %133, i64 %148
  %150 = getelementptr inbounds double, ptr %149, i64 2
  %151 = load <2 x double>, ptr %149, align 8, !tbaa !5, !alias.scope !23
  %152 = load <2 x double>, ptr %150, align 8, !tbaa !5, !alias.scope !23
  %153 = fadd <2 x double> %146, %151
  %154 = fadd <2 x double> %147, %152
  %155 = getelementptr [250 x double], ptr %134, i64 1, i64 %137
  %156 = getelementptr double, ptr %155, i64 2
  %157 = load <2 x double>, ptr %155, align 8, !tbaa !5, !alias.scope !23
  %158 = load <2 x double>, ptr %156, align 8, !tbaa !5, !alias.scope !23
  %159 = fadd <2 x double> %153, %157
  %160 = fadd <2 x double> %154, %158
  %161 = getelementptr [250 x double], ptr %134, i64 -1, i64 %137
  %162 = getelementptr double, ptr %161, i64 2
  %163 = load <2 x double>, ptr %161, align 8, !tbaa !5, !alias.scope !23
  %164 = load <2 x double>, ptr %162, align 8, !tbaa !5, !alias.scope !23
  %165 = fadd <2 x double> %159, %163
  %166 = fadd <2 x double> %160, %164
  %167 = fmul <2 x double> %165, <double 2.000000e-01, double 2.000000e-01>
  %168 = fmul <2 x double> %166, <double 2.000000e-01, double 2.000000e-01>
  %169 = getelementptr inbounds [250 x double], ptr %3, i64 %133, i64 %137
  %170 = getelementptr inbounds double, ptr %169, i64 2
  store <2 x double> %167, ptr %169, align 8, !tbaa !5, !alias.scope !26, !noalias !23
  store <2 x double> %168, ptr %170, align 8, !tbaa !5, !alias.scope !26, !noalias !23
  %171 = add nuw i64 %136, 4
  %172 = icmp eq i64 %171, 248
  br i1 %172, label %194, label %135, !llvm.loop !28

173:                                              ; preds = %132, %173
  %174 = phi i64 [ %181, %173 ], [ 1, %132 ]
  %175 = getelementptr inbounds [250 x double], ptr %5, i64 %133, i64 %174
  %176 = load double, ptr %175, align 8, !tbaa !5
  %177 = add nsw i64 %174, -1
  %178 = getelementptr inbounds [250 x double], ptr %5, i64 %133, i64 %177
  %179 = load double, ptr %178, align 8, !tbaa !5
  %180 = fadd double %176, %179
  %181 = add nuw nsw i64 %174, 1
  %182 = getelementptr inbounds [250 x double], ptr %5, i64 %133, i64 %181
  %183 = load double, ptr %182, align 8, !tbaa !5
  %184 = fadd double %180, %183
  %185 = getelementptr [250 x double], ptr %134, i64 1, i64 %174
  %186 = load double, ptr %185, align 8, !tbaa !5
  %187 = fadd double %184, %186
  %188 = getelementptr [250 x double], ptr %134, i64 -1, i64 %174
  %189 = load double, ptr %188, align 8, !tbaa !5
  %190 = fadd double %187, %189
  %191 = fmul double %190, 2.000000e-01
  %192 = getelementptr inbounds [250 x double], ptr %3, i64 %133, i64 %174
  store double %191, ptr %192, align 8, !tbaa !5
  %193 = icmp eq i64 %181, 249
  br i1 %193, label %194, label %173, !llvm.loop !29

194:                                              ; preds = %135, %173
  %195 = add nuw nsw i64 %133, 1
  %196 = icmp eq i64 %195, 249
  br i1 %196, label %197, label %132, !llvm.loop !30

197:                                              ; preds = %194
  %198 = add nuw nsw i32 %66, 1
  %199 = icmp eq i32 %198, 100
  br i1 %199, label %200, label %65, !llvm.loop !31

200:                                              ; preds = %197
  %201 = icmp sgt i32 %0, 42
  br i1 %201, label %202, label %238

202:                                              ; preds = %200
  %203 = load ptr, ptr %1, align 8, !tbaa !32
  %204 = load i8, ptr %203, align 1
  %205 = icmp eq i8 %204, 0
  br i1 %205, label %206, label %238

206:                                              ; preds = %202
  %207 = load ptr, ptr @stderr, align 8, !tbaa !32
  %208 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %207) #8
  %209 = load ptr, ptr @stderr, align 8, !tbaa !32
  %210 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %209, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %211

211:                                              ; preds = %230, %206
  %212 = phi i64 [ 0, %206 ], [ %231, %230 ]
  %213 = mul nuw nsw i64 %212, 250
  br label %214

214:                                              ; preds = %223, %211
  %215 = phi i64 [ 0, %211 ], [ %228, %223 ]
  %216 = add nuw nsw i64 %215, %213
  %217 = trunc i64 %216 to i32
  %218 = urem i32 %217, 20
  %219 = icmp eq i32 %218, 0
  br i1 %219, label %220, label %223

220:                                              ; preds = %214
  %221 = load ptr, ptr @stderr, align 8, !tbaa !32
  %222 = tail call i32 @fputc(i32 10, ptr %221)
  br label %223

223:                                              ; preds = %220, %214
  %224 = load ptr, ptr @stderr, align 8, !tbaa !32
  %225 = getelementptr inbounds [250 x double], ptr %3, i64 %212, i64 %215
  %226 = load double, ptr %225, align 8, !tbaa !5
  %227 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %224, ptr noundef nonnull @.str.5, double noundef %226) #8
  %228 = add nuw nsw i64 %215, 1
  %229 = icmp eq i64 %228, 250
  br i1 %229, label %230, label %214, !llvm.loop !34

230:                                              ; preds = %223
  %231 = add nuw nsw i64 %212, 1
  %232 = icmp eq i64 %231, 250
  br i1 %232, label %233, label %211, !llvm.loop !35

233:                                              ; preds = %230
  %234 = load ptr, ptr @stderr, align 8, !tbaa !32
  %235 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %234, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %236 = load ptr, ptr @stderr, align 8, !tbaa !32
  %237 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %236) #8
  br label %238

238:                                              ; preds = %233, %202, %200
  tail call void @free(ptr noundef nonnull %3) #7
  tail call void @free(ptr noundef %5) #7
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nounwind }
attributes #8 = { cold }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"double", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10, !11, !12}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.isvectorized", i32 1}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
!13 = distinct !{!13, !10, !11}
!14 = distinct !{!14, !10}
!15 = !{!16}
!16 = distinct !{!16, !17}
!17 = distinct !{!17, !"LVerDomain"}
!18 = !{!19}
!19 = distinct !{!19, !17}
!20 = distinct !{!20, !10, !11, !12}
!21 = distinct !{!21, !10, !11}
!22 = distinct !{!22, !10}
!23 = !{!24}
!24 = distinct !{!24, !25}
!25 = distinct !{!25, !"LVerDomain"}
!26 = !{!27}
!27 = distinct !{!27, !25}
!28 = distinct !{!28, !10, !11, !12}
!29 = distinct !{!29, !10, !11}
!30 = distinct !{!30, !10}
!31 = distinct !{!31, !10}
!32 = !{!33, !33, i64 0}
!33 = !{!"any pointer", !7, i64 0}
!34 = distinct !{!34, !10}
!35 = distinct !{!35, !10}
