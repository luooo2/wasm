; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/blas/syr2k/syr2k.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/blas/syr2k/syr2k.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"C\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 57600, i32 noundef 8) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #7
  %5 = ptrtoint ptr %4 to i64
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #7
  %7 = ptrtoint ptr %6 to i64
  %8 = sub i64 %7, %5
  %9 = icmp ult i64 %8, 16
  br label %10

10:                                               ; preds = %2, %49
  %11 = phi i64 [ 0, %2 ], [ %50, %49 ]
  br i1 %9, label %33, label %12

12:                                               ; preds = %10
  %13 = insertelement <2 x i64> poison, i64 %11, i64 0
  %14 = shufflevector <2 x i64> %13, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %12
  %16 = phi i64 [ 0, %12 ], [ %30, %15 ]
  %17 = phi <2 x i64> [ <i64 0, i64 1>, %12 ], [ %31, %15 ]
  %18 = mul nuw nsw <2 x i64> %17, %14
  %19 = trunc <2 x i64> %18 to <2 x i32>
  %20 = add <2 x i32> %19, <i32 1, i32 1>
  %21 = urem <2 x i32> %20, <i32 240, i32 240>
  %22 = sitofp <2 x i32> %21 to <2 x double>
  %23 = fdiv <2 x double> %22, <double 2.400000e+02, double 2.400000e+02>
  %24 = getelementptr inbounds [200 x double], ptr %4, i64 %11, i64 %16
  store <2 x double> %23, ptr %24, align 8, !tbaa !5
  %25 = add <2 x i32> %19, <i32 2, i32 2>
  %26 = urem <2 x i32> %25, <i32 200, i32 200>
  %27 = sitofp <2 x i32> %26 to <2 x double>
  %28 = fdiv <2 x double> %27, <double 2.000000e+02, double 2.000000e+02>
  %29 = getelementptr inbounds [200 x double], ptr %6, i64 %11, i64 %16
  store <2 x double> %28, ptr %29, align 8, !tbaa !5
  %30 = add nuw i64 %16, 2
  %31 = add <2 x i64> %17, <i64 2, i64 2>
  %32 = icmp eq i64 %30, 200
  br i1 %32, label %49, label %15, !llvm.loop !9

33:                                               ; preds = %10, %33
  %34 = phi i64 [ %47, %33 ], [ 0, %10 ]
  %35 = mul nuw nsw i64 %34, %11
  %36 = trunc i64 %35 to i32
  %37 = add i32 %36, 1
  %38 = urem i32 %37, 240
  %39 = sitofp i32 %38 to double
  %40 = fdiv double %39, 2.400000e+02
  %41 = getelementptr inbounds [200 x double], ptr %4, i64 %11, i64 %34
  store double %40, ptr %41, align 8, !tbaa !5
  %42 = add i32 %36, 2
  %43 = urem i32 %42, 200
  %44 = sitofp i32 %43 to double
  %45 = fdiv double %44, 2.000000e+02
  %46 = getelementptr inbounds [200 x double], ptr %6, i64 %11, i64 %34
  store double %45, ptr %46, align 8, !tbaa !5
  %47 = add nuw nsw i64 %34, 1
  %48 = icmp eq i64 %47, 200
  br i1 %48, label %49, label %33, !llvm.loop !13

49:                                               ; preds = %15, %33
  %50 = add nuw nsw i64 %11, 1
  %51 = icmp eq i64 %50, 240
  br i1 %51, label %52, label %10, !llvm.loop !14

52:                                               ; preds = %49, %69
  %53 = phi i64 [ %70, %69 ], [ 0, %49 ]
  %54 = insertelement <2 x i64> poison, i64 %53, i64 0
  %55 = shufflevector <2 x i64> %54, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %56

56:                                               ; preds = %56, %52
  %57 = phi i64 [ 0, %52 ], [ %66, %56 ]
  %58 = phi <2 x i64> [ <i64 0, i64 1>, %52 ], [ %67, %56 ]
  %59 = mul nuw nsw <2 x i64> %58, %55
  %60 = trunc <2 x i64> %59 to <2 x i32>
  %61 = add <2 x i32> %60, <i32 3, i32 3>
  %62 = urem <2 x i32> %61, <i32 240, i32 240>
  %63 = sitofp <2 x i32> %62 to <2 x double>
  %64 = fdiv <2 x double> %63, <double 2.000000e+02, double 2.000000e+02>
  %65 = getelementptr inbounds [240 x double], ptr %3, i64 %53, i64 %57
  store <2 x double> %64, ptr %65, align 8, !tbaa !5
  %66 = add nuw i64 %57, 2
  %67 = add <2 x i64> %58, <i64 2, i64 2>
  %68 = icmp eq i64 %66, 240
  br i1 %68, label %69, label %56, !llvm.loop !15

69:                                               ; preds = %56
  %70 = add nuw nsw i64 %53, 1
  %71 = icmp eq i64 %70, 240
  br i1 %71, label %72, label %52, !llvm.loop !16

72:                                               ; preds = %69
  %73 = getelementptr i8, ptr %3, i64 8
  br label %74

74:                                               ; preds = %72, %189
  %75 = phi i64 [ %190, %189 ], [ 0, %72 ]
  %76 = phi i64 [ %191, %189 ], [ 1, %72 ]
  %77 = mul nuw nsw i64 %75, 1920
  %78 = getelementptr i8, ptr %3, i64 %77
  %79 = mul nuw nsw i64 %75, 1928
  %80 = getelementptr i8, ptr %73, i64 %79
  %81 = mul nuw nsw i64 %75, 1600
  %82 = getelementptr i8, ptr %4, i64 %81
  %83 = add nuw i64 %81, 1600
  %84 = getelementptr i8, ptr %4, i64 %83
  %85 = getelementptr i8, ptr %6, i64 %83
  %86 = getelementptr i8, ptr %6, i64 %81
  %87 = icmp ult i64 %76, 4
  br i1 %87, label %102, label %88

88:                                               ; preds = %74
  %89 = and i64 %76, 9223372036854775804
  br label %90

90:                                               ; preds = %90, %88
  %91 = phi i64 [ 0, %88 ], [ %98, %90 ]
  %92 = getelementptr inbounds [240 x double], ptr %3, i64 %75, i64 %91
  %93 = getelementptr inbounds double, ptr %92, i64 2
  %94 = load <2 x double>, ptr %92, align 8, !tbaa !5
  %95 = load <2 x double>, ptr %93, align 8, !tbaa !5
  %96 = fmul <2 x double> %94, <double 1.200000e+00, double 1.200000e+00>
  %97 = fmul <2 x double> %95, <double 1.200000e+00, double 1.200000e+00>
  store <2 x double> %96, ptr %92, align 8, !tbaa !5
  store <2 x double> %97, ptr %93, align 8, !tbaa !5
  %98 = add nuw i64 %91, 4
  %99 = icmp eq i64 %98, %89
  br i1 %99, label %100, label %90, !llvm.loop !17

100:                                              ; preds = %90
  %101 = icmp eq i64 %76, %89
  br i1 %101, label %111, label %102

102:                                              ; preds = %74, %100
  %103 = phi i64 [ 0, %74 ], [ %89, %100 ]
  br label %104

104:                                              ; preds = %102, %104
  %105 = phi i64 [ %109, %104 ], [ %103, %102 ]
  %106 = getelementptr inbounds [240 x double], ptr %3, i64 %75, i64 %105
  %107 = load double, ptr %106, align 8, !tbaa !5
  %108 = fmul double %107, 1.200000e+00
  store double %108, ptr %106, align 8, !tbaa !5
  %109 = add nuw nsw i64 %105, 1
  %110 = icmp eq i64 %109, %76
  br i1 %110, label %111, label %104, !llvm.loop !18

111:                                              ; preds = %104, %100
  %112 = icmp ult i64 %76, 2
  %113 = icmp ult ptr %78, %84
  %114 = icmp ult ptr %82, %80
  %115 = and i1 %113, %114
  %116 = icmp ult ptr %78, %84
  %117 = icmp ult ptr %4, %80
  %118 = and i1 %116, %117
  %119 = or i1 %115, %118
  %120 = icmp ult ptr %78, %85
  %121 = icmp ult ptr %6, %80
  %122 = and i1 %120, %121
  %123 = or i1 %119, %122
  %124 = icmp ult ptr %78, %85
  %125 = icmp ult ptr %86, %80
  %126 = and i1 %124, %125
  %127 = or i1 %123, %126
  %128 = and i64 %76, 9223372036854775806
  %129 = icmp eq i64 %76, %128
  br label %130

130:                                              ; preds = %111, %186
  %131 = phi i64 [ %187, %186 ], [ 0, %111 ]
  %132 = getelementptr inbounds [200 x double], ptr %6, i64 %75, i64 %131
  %133 = getelementptr inbounds [200 x double], ptr %4, i64 %75, i64 %131
  %134 = select i1 %112, i1 true, i1 %127
  br i1 %134, label %167, label %135

135:                                              ; preds = %130
  %136 = load double, ptr %132, align 8, !tbaa !5, !alias.scope !19
  %137 = insertelement <2 x double> poison, double %136, i64 0
  %138 = shufflevector <2 x double> %137, <2 x double> poison, <2 x i32> zeroinitializer
  %139 = load double, ptr %133, align 8, !tbaa !5, !alias.scope !22
  %140 = insertelement <2 x double> poison, double %139, i64 0
  %141 = shufflevector <2 x double> %140, <2 x double> poison, <2 x i32> zeroinitializer
  br label %142

142:                                              ; preds = %142, %135
  %143 = phi i64 [ 0, %135 ], [ %164, %142 ]
  %144 = or disjoint i64 %143, 1
  %145 = getelementptr inbounds [200 x double], ptr %4, i64 %143, i64 %131
  %146 = getelementptr inbounds [200 x double], ptr %4, i64 %144, i64 %131
  %147 = load double, ptr %145, align 8, !tbaa !5, !alias.scope !24
  %148 = load double, ptr %146, align 8, !tbaa !5, !alias.scope !24
  %149 = insertelement <2 x double> poison, double %147, i64 0
  %150 = insertelement <2 x double> %149, double %148, i64 1
  %151 = fmul <2 x double> %150, <double 1.500000e+00, double 1.500000e+00>
  %152 = getelementptr inbounds [200 x double], ptr %6, i64 %143, i64 %131
  %153 = getelementptr inbounds [200 x double], ptr %6, i64 %144, i64 %131
  %154 = load double, ptr %152, align 8, !tbaa !5, !alias.scope !26
  %155 = load double, ptr %153, align 8, !tbaa !5, !alias.scope !26
  %156 = insertelement <2 x double> poison, double %154, i64 0
  %157 = insertelement <2 x double> %156, double %155, i64 1
  %158 = fmul <2 x double> %157, <double 1.500000e+00, double 1.500000e+00>
  %159 = fmul <2 x double> %158, %141
  %160 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %151, <2 x double> %138, <2 x double> %159)
  %161 = getelementptr inbounds [240 x double], ptr %3, i64 %75, i64 %143
  %162 = load <2 x double>, ptr %161, align 8, !tbaa !5, !alias.scope !28, !noalias !30
  %163 = fadd <2 x double> %162, %160
  store <2 x double> %163, ptr %161, align 8, !tbaa !5, !alias.scope !28, !noalias !30
  %164 = add nuw i64 %143, 2
  %165 = icmp eq i64 %164, %128
  br i1 %165, label %166, label %142, !llvm.loop !31

166:                                              ; preds = %142
  br i1 %129, label %186, label %167

167:                                              ; preds = %130, %166
  %168 = phi i64 [ 0, %130 ], [ %128, %166 ]
  br label %169

169:                                              ; preds = %167, %169
  %170 = phi i64 [ %184, %169 ], [ %168, %167 ]
  %171 = getelementptr inbounds [200 x double], ptr %4, i64 %170, i64 %131
  %172 = load double, ptr %171, align 8, !tbaa !5
  %173 = fmul double %172, 1.500000e+00
  %174 = load double, ptr %132, align 8, !tbaa !5
  %175 = getelementptr inbounds [200 x double], ptr %6, i64 %170, i64 %131
  %176 = load double, ptr %175, align 8, !tbaa !5
  %177 = fmul double %176, 1.500000e+00
  %178 = load double, ptr %133, align 8, !tbaa !5
  %179 = fmul double %177, %178
  %180 = tail call double @llvm.fmuladd.f64(double %173, double %174, double %179)
  %181 = getelementptr inbounds [240 x double], ptr %3, i64 %75, i64 %170
  %182 = load double, ptr %181, align 8, !tbaa !5
  %183 = fadd double %182, %180
  store double %183, ptr %181, align 8, !tbaa !5
  %184 = add nuw nsw i64 %170, 1
  %185 = icmp eq i64 %184, %76
  br i1 %185, label %186, label %169, !llvm.loop !32

186:                                              ; preds = %169, %166
  %187 = add nuw nsw i64 %131, 1
  %188 = icmp eq i64 %187, 200
  br i1 %188, label %189, label %130, !llvm.loop !33

189:                                              ; preds = %186
  %190 = add nuw nsw i64 %75, 1
  %191 = add nuw nsw i64 %76, 1
  %192 = icmp eq i64 %190, 240
  br i1 %192, label %193, label %74, !llvm.loop !34

193:                                              ; preds = %189
  %194 = icmp sgt i32 %0, 42
  br i1 %194, label %195, label %231

195:                                              ; preds = %193
  %196 = load ptr, ptr %1, align 8, !tbaa !35
  %197 = load i8, ptr %196, align 1
  %198 = icmp eq i8 %197, 0
  br i1 %198, label %199, label %231

199:                                              ; preds = %195
  %200 = load ptr, ptr @stderr, align 8, !tbaa !35
  %201 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %200) #8
  %202 = load ptr, ptr @stderr, align 8, !tbaa !35
  %203 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %202, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %204

204:                                              ; preds = %223, %199
  %205 = phi i64 [ 0, %199 ], [ %224, %223 ]
  %206 = mul nuw nsw i64 %205, 240
  br label %207

207:                                              ; preds = %216, %204
  %208 = phi i64 [ 0, %204 ], [ %221, %216 ]
  %209 = add nuw nsw i64 %208, %206
  %210 = trunc i64 %209 to i32
  %211 = urem i32 %210, 20
  %212 = icmp eq i32 %211, 0
  br i1 %212, label %213, label %216

213:                                              ; preds = %207
  %214 = load ptr, ptr @stderr, align 8, !tbaa !35
  %215 = tail call i32 @fputc(i32 10, ptr %214)
  br label %216

216:                                              ; preds = %213, %207
  %217 = load ptr, ptr @stderr, align 8, !tbaa !35
  %218 = getelementptr inbounds [240 x double], ptr %3, i64 %205, i64 %208
  %219 = load double, ptr %218, align 8, !tbaa !5
  %220 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %217, ptr noundef nonnull @.str.5, double noundef %219) #8
  %221 = add nuw nsw i64 %208, 1
  %222 = icmp eq i64 %221, 240
  br i1 %222, label %223, label %207, !llvm.loop !37

223:                                              ; preds = %216
  %224 = add nuw nsw i64 %205, 1
  %225 = icmp eq i64 %224, 240
  br i1 %225, label %226, label %204, !llvm.loop !38

226:                                              ; preds = %223
  %227 = load ptr, ptr @stderr, align 8, !tbaa !35
  %228 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %227, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %229 = load ptr, ptr @stderr, align 8, !tbaa !35
  %230 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %229) #8
  br label %231

231:                                              ; preds = %226, %195, %193
  tail call void @free(ptr noundef nonnull %3) #7
  tail call void @free(ptr noundef %4) #7
  tail call void @free(ptr noundef %6) #7
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
!15 = distinct !{!15, !10, !11, !12}
!16 = distinct !{!16, !10}
!17 = distinct !{!17, !10, !11, !12}
!18 = distinct !{!18, !10, !12, !11}
!19 = !{!20}
!20 = distinct !{!20, !21}
!21 = distinct !{!21, !"LVerDomain"}
!22 = !{!23}
!23 = distinct !{!23, !21}
!24 = !{!25}
!25 = distinct !{!25, !21}
!26 = !{!27}
!27 = distinct !{!27, !21}
!28 = !{!29}
!29 = distinct !{!29, !21}
!30 = !{!23, !25, !27, !20}
!31 = distinct !{!31, !10, !11, !12}
!32 = distinct !{!32, !10, !11}
!33 = distinct !{!33, !10}
!34 = distinct !{!34, !10}
!35 = !{!36, !36, i64 0}
!36 = !{!"any pointer", !7, i64 0}
!37 = distinct !{!37, !10}
!38 = distinct !{!38, !10}
