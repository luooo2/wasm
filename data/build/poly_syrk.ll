; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/blas/syrk/syrk.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/blas/syrk/syrk.c"
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
  br label %5

5:                                                ; preds = %2, %22
  %6 = phi i64 [ 0, %2 ], [ %23, %22 ]
  %7 = insertelement <2 x i64> poison, i64 %6, i64 0
  %8 = shufflevector <2 x i64> %7, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %9

9:                                                ; preds = %9, %5
  %10 = phi i64 [ 0, %5 ], [ %19, %9 ]
  %11 = phi <2 x i64> [ <i64 0, i64 1>, %5 ], [ %20, %9 ]
  %12 = mul nuw nsw <2 x i64> %11, %8
  %13 = trunc <2 x i64> %12 to <2 x i32>
  %14 = add <2 x i32> %13, <i32 1, i32 1>
  %15 = urem <2 x i32> %14, <i32 240, i32 240>
  %16 = sitofp <2 x i32> %15 to <2 x double>
  %17 = fdiv <2 x double> %16, <double 2.400000e+02, double 2.400000e+02>
  %18 = getelementptr inbounds [200 x double], ptr %4, i64 %6, i64 %10
  store <2 x double> %17, ptr %18, align 8, !tbaa !5
  %19 = add nuw i64 %10, 2
  %20 = add <2 x i64> %11, <i64 2, i64 2>
  %21 = icmp eq i64 %19, 200
  br i1 %21, label %22, label %9, !llvm.loop !9

22:                                               ; preds = %9
  %23 = add nuw nsw i64 %6, 1
  %24 = icmp eq i64 %23, 240
  br i1 %24, label %25, label %5, !llvm.loop !13

25:                                               ; preds = %22, %42
  %26 = phi i64 [ %43, %42 ], [ 0, %22 ]
  %27 = insertelement <2 x i64> poison, i64 %26, i64 0
  %28 = shufflevector <2 x i64> %27, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %29

29:                                               ; preds = %29, %25
  %30 = phi i64 [ 0, %25 ], [ %39, %29 ]
  %31 = phi <2 x i64> [ <i64 0, i64 1>, %25 ], [ %40, %29 ]
  %32 = mul nuw nsw <2 x i64> %31, %28
  %33 = trunc <2 x i64> %32 to <2 x i32>
  %34 = add <2 x i32> %33, <i32 2, i32 2>
  %35 = urem <2 x i32> %34, <i32 200, i32 200>
  %36 = sitofp <2 x i32> %35 to <2 x double>
  %37 = fdiv <2 x double> %36, <double 2.000000e+02, double 2.000000e+02>
  %38 = getelementptr inbounds [240 x double], ptr %3, i64 %26, i64 %30
  store <2 x double> %37, ptr %38, align 8, !tbaa !5
  %39 = add nuw i64 %30, 2
  %40 = add <2 x i64> %31, <i64 2, i64 2>
  %41 = icmp eq i64 %39, 240
  br i1 %41, label %42, label %29, !llvm.loop !14

42:                                               ; preds = %29
  %43 = add nuw nsw i64 %26, 1
  %44 = icmp eq i64 %43, 240
  br i1 %44, label %45, label %25, !llvm.loop !15

45:                                               ; preds = %42
  %46 = getelementptr i8, ptr %3, i64 8
  %47 = getelementptr i8, ptr %4, i64 1600
  br label %48

48:                                               ; preds = %45, %167
  %49 = phi i64 [ %168, %167 ], [ 0, %45 ]
  %50 = phi i64 [ %169, %167 ], [ 1, %45 ]
  %51 = mul nuw nsw i64 %49, 1920
  %52 = getelementptr i8, ptr %3, i64 %51
  %53 = mul nuw nsw i64 %49, 1928
  %54 = getelementptr i8, ptr %46, i64 %53
  %55 = mul nuw nsw i64 %49, 1600
  %56 = getelementptr i8, ptr %47, i64 %55
  %57 = getelementptr i8, ptr %4, i64 %55
  %58 = icmp ult i64 %50, 4
  br i1 %58, label %73, label %59

59:                                               ; preds = %48
  %60 = and i64 %50, 9223372036854775804
  br label %61

61:                                               ; preds = %61, %59
  %62 = phi i64 [ 0, %59 ], [ %69, %61 ]
  %63 = getelementptr inbounds [240 x double], ptr %3, i64 %49, i64 %62
  %64 = getelementptr inbounds double, ptr %63, i64 2
  %65 = load <2 x double>, ptr %63, align 8, !tbaa !5
  %66 = load <2 x double>, ptr %64, align 8, !tbaa !5
  %67 = fmul <2 x double> %65, <double 1.200000e+00, double 1.200000e+00>
  %68 = fmul <2 x double> %66, <double 1.200000e+00, double 1.200000e+00>
  store <2 x double> %67, ptr %63, align 8, !tbaa !5
  store <2 x double> %68, ptr %64, align 8, !tbaa !5
  %69 = add nuw i64 %62, 4
  %70 = icmp eq i64 %69, %60
  br i1 %70, label %71, label %61, !llvm.loop !16

71:                                               ; preds = %61
  %72 = icmp eq i64 %50, %60
  br i1 %72, label %82, label %73

73:                                               ; preds = %48, %71
  %74 = phi i64 [ 0, %48 ], [ %60, %71 ]
  br label %75

75:                                               ; preds = %73, %75
  %76 = phi i64 [ %80, %75 ], [ %74, %73 ]
  %77 = getelementptr inbounds [240 x double], ptr %3, i64 %49, i64 %76
  %78 = load double, ptr %77, align 8, !tbaa !5
  %79 = fmul double %78, 1.200000e+00
  store double %79, ptr %77, align 8, !tbaa !5
  %80 = add nuw nsw i64 %76, 1
  %81 = icmp eq i64 %80, %50
  br i1 %81, label %82, label %75, !llvm.loop !17

82:                                               ; preds = %75, %71
  %83 = icmp ult i64 %50, 4
  %84 = icmp ult ptr %52, %56
  %85 = icmp ult ptr %4, %54
  %86 = and i1 %84, %85
  %87 = icmp ult ptr %52, %56
  %88 = icmp ult ptr %57, %54
  %89 = and i1 %87, %88
  %90 = or i1 %86, %89
  %91 = and i64 %50, 9223372036854775804
  %92 = icmp eq i64 %50, %91
  %93 = and i64 %50, 1
  %94 = icmp eq i64 %93, 0
  br label %95

95:                                               ; preds = %82, %164
  %96 = phi i64 [ %165, %164 ], [ 0, %82 ]
  %97 = getelementptr inbounds [200 x double], ptr %4, i64 %49, i64 %96
  %98 = select i1 %83, i1 true, i1 %90
  br i1 %98, label %131, label %99

99:                                               ; preds = %95
  %100 = load double, ptr %97, align 8, !tbaa !5, !alias.scope !18
  %101 = insertelement <2 x double> poison, double %100, i64 0
  %102 = shufflevector <2 x double> %101, <2 x double> poison, <2 x i32> zeroinitializer
  %103 = fmul <2 x double> %102, <double 1.500000e+00, double 1.500000e+00>
  %104 = fmul <2 x double> %102, <double 1.500000e+00, double 1.500000e+00>
  br label %105

105:                                              ; preds = %105, %99
  %106 = phi i64 [ 0, %99 ], [ %128, %105 ]
  %107 = or disjoint i64 %106, 1
  %108 = or disjoint i64 %106, 2
  %109 = or disjoint i64 %106, 3
  %110 = getelementptr inbounds [200 x double], ptr %4, i64 %106, i64 %96
  %111 = getelementptr inbounds [200 x double], ptr %4, i64 %107, i64 %96
  %112 = getelementptr inbounds [200 x double], ptr %4, i64 %108, i64 %96
  %113 = getelementptr inbounds [200 x double], ptr %4, i64 %109, i64 %96
  %114 = load double, ptr %110, align 8, !tbaa !5, !alias.scope !21
  %115 = load double, ptr %111, align 8, !tbaa !5, !alias.scope !21
  %116 = insertelement <2 x double> poison, double %114, i64 0
  %117 = insertelement <2 x double> %116, double %115, i64 1
  %118 = load double, ptr %112, align 8, !tbaa !5, !alias.scope !21
  %119 = load double, ptr %113, align 8, !tbaa !5, !alias.scope !21
  %120 = insertelement <2 x double> poison, double %118, i64 0
  %121 = insertelement <2 x double> %120, double %119, i64 1
  %122 = getelementptr inbounds [240 x double], ptr %3, i64 %49, i64 %106
  %123 = getelementptr inbounds double, ptr %122, i64 2
  %124 = load <2 x double>, ptr %122, align 8, !tbaa !5, !alias.scope !23, !noalias !25
  %125 = load <2 x double>, ptr %123, align 8, !tbaa !5, !alias.scope !23, !noalias !25
  %126 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %103, <2 x double> %117, <2 x double> %124)
  %127 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %104, <2 x double> %121, <2 x double> %125)
  store <2 x double> %126, ptr %122, align 8, !tbaa !5, !alias.scope !23, !noalias !25
  store <2 x double> %127, ptr %123, align 8, !tbaa !5, !alias.scope !23, !noalias !25
  %128 = add nuw i64 %106, 4
  %129 = icmp eq i64 %128, %91
  br i1 %129, label %130, label %105, !llvm.loop !26

130:                                              ; preds = %105
  br i1 %92, label %164, label %131

131:                                              ; preds = %95, %130
  %132 = phi i64 [ 0, %95 ], [ %91, %130 ]
  br i1 %94, label %142, label %133

133:                                              ; preds = %131
  %134 = load double, ptr %97, align 8, !tbaa !5
  %135 = fmul double %134, 1.500000e+00
  %136 = getelementptr inbounds [200 x double], ptr %4, i64 %132, i64 %96
  %137 = load double, ptr %136, align 8, !tbaa !5
  %138 = getelementptr inbounds [240 x double], ptr %3, i64 %49, i64 %132
  %139 = load double, ptr %138, align 8, !tbaa !5
  %140 = tail call double @llvm.fmuladd.f64(double %135, double %137, double %139)
  store double %140, ptr %138, align 8, !tbaa !5
  %141 = or disjoint i64 %132, 1
  br label %142

142:                                              ; preds = %133, %131
  %143 = phi i64 [ %132, %131 ], [ %141, %133 ]
  %144 = icmp eq i64 %49, %132
  br i1 %144, label %164, label %145

145:                                              ; preds = %142, %145
  %146 = phi i64 [ %162, %145 ], [ %143, %142 ]
  %147 = load double, ptr %97, align 8, !tbaa !5
  %148 = fmul double %147, 1.500000e+00
  %149 = getelementptr inbounds [200 x double], ptr %4, i64 %146, i64 %96
  %150 = load double, ptr %149, align 8, !tbaa !5
  %151 = getelementptr inbounds [240 x double], ptr %3, i64 %49, i64 %146
  %152 = load double, ptr %151, align 8, !tbaa !5
  %153 = tail call double @llvm.fmuladd.f64(double %148, double %150, double %152)
  store double %153, ptr %151, align 8, !tbaa !5
  %154 = add nuw nsw i64 %146, 1
  %155 = load double, ptr %97, align 8, !tbaa !5
  %156 = fmul double %155, 1.500000e+00
  %157 = getelementptr inbounds [200 x double], ptr %4, i64 %154, i64 %96
  %158 = load double, ptr %157, align 8, !tbaa !5
  %159 = getelementptr inbounds [240 x double], ptr %3, i64 %49, i64 %154
  %160 = load double, ptr %159, align 8, !tbaa !5
  %161 = tail call double @llvm.fmuladd.f64(double %156, double %158, double %160)
  store double %161, ptr %159, align 8, !tbaa !5
  %162 = add nuw nsw i64 %146, 2
  %163 = icmp eq i64 %162, %50
  br i1 %163, label %164, label %145, !llvm.loop !27

164:                                              ; preds = %142, %145, %130
  %165 = add nuw nsw i64 %96, 1
  %166 = icmp eq i64 %165, 200
  br i1 %166, label %167, label %95, !llvm.loop !28

167:                                              ; preds = %164
  %168 = add nuw nsw i64 %49, 1
  %169 = add nuw nsw i64 %50, 1
  %170 = icmp eq i64 %168, 240
  br i1 %170, label %171, label %48, !llvm.loop !29

171:                                              ; preds = %167
  %172 = icmp sgt i32 %0, 42
  br i1 %172, label %173, label %209

173:                                              ; preds = %171
  %174 = load ptr, ptr %1, align 8, !tbaa !30
  %175 = load i8, ptr %174, align 1
  %176 = icmp eq i8 %175, 0
  br i1 %176, label %177, label %209

177:                                              ; preds = %173
  %178 = load ptr, ptr @stderr, align 8, !tbaa !30
  %179 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %178) #8
  %180 = load ptr, ptr @stderr, align 8, !tbaa !30
  %181 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %180, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %182

182:                                              ; preds = %201, %177
  %183 = phi i64 [ 0, %177 ], [ %202, %201 ]
  %184 = mul nuw nsw i64 %183, 240
  br label %185

185:                                              ; preds = %194, %182
  %186 = phi i64 [ 0, %182 ], [ %199, %194 ]
  %187 = add nuw nsw i64 %186, %184
  %188 = trunc i64 %187 to i32
  %189 = urem i32 %188, 20
  %190 = icmp eq i32 %189, 0
  br i1 %190, label %191, label %194

191:                                              ; preds = %185
  %192 = load ptr, ptr @stderr, align 8, !tbaa !30
  %193 = tail call i32 @fputc(i32 10, ptr %192)
  br label %194

194:                                              ; preds = %191, %185
  %195 = load ptr, ptr @stderr, align 8, !tbaa !30
  %196 = getelementptr inbounds [240 x double], ptr %3, i64 %183, i64 %186
  %197 = load double, ptr %196, align 8, !tbaa !5
  %198 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %195, ptr noundef nonnull @.str.5, double noundef %197) #8
  %199 = add nuw nsw i64 %186, 1
  %200 = icmp eq i64 %199, 240
  br i1 %200, label %201, label %185, !llvm.loop !32

201:                                              ; preds = %194
  %202 = add nuw nsw i64 %183, 1
  %203 = icmp eq i64 %202, 240
  br i1 %203, label %204, label %182, !llvm.loop !33

204:                                              ; preds = %201
  %205 = load ptr, ptr @stderr, align 8, !tbaa !30
  %206 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %205, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %207 = load ptr, ptr @stderr, align 8, !tbaa !30
  %208 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %207) #8
  br label %209

209:                                              ; preds = %204, %173, %171
  tail call void @free(ptr noundef nonnull %3) #7
  tail call void @free(ptr noundef %4) #7
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
!13 = distinct !{!13, !10}
!14 = distinct !{!14, !10, !11, !12}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10, !11, !12}
!17 = distinct !{!17, !10, !12, !11}
!18 = !{!19}
!19 = distinct !{!19, !20}
!20 = distinct !{!20, !"LVerDomain"}
!21 = !{!22}
!22 = distinct !{!22, !20}
!23 = !{!24}
!24 = distinct !{!24, !20}
!25 = !{!22, !19}
!26 = distinct !{!26, !10, !11, !12}
!27 = distinct !{!27, !10, !11}
!28 = distinct !{!28, !10}
!29 = distinct !{!29, !10}
!30 = !{!31, !31, i64 0}
!31 = !{!"any pointer", !7, i64 0}
!32 = distinct !{!32, !10}
!33 = distinct !{!33, !10}
