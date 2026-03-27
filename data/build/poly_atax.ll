; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/kernels/atax/atax.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/kernels/atax/atax.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"y\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 159900, i32 noundef 8) #8
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 410, i32 noundef 8) #8
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 410, i32 noundef 8) #8
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 390, i32 noundef 8) #8
  br label %7

7:                                                ; preds = %16, %2
  %8 = phi i64 [ 0, %2 ], [ %22, %16 ]
  %9 = phi <2 x i32> [ <i32 0, i32 1>, %2 ], [ %23, %16 ]
  %10 = sitofp <2 x i32> %9 to <2 x double>
  %11 = fdiv <2 x double> %10, <double 4.100000e+02, double 4.100000e+02>
  %12 = fadd <2 x double> %11, <double 1.000000e+00, double 1.000000e+00>
  %13 = getelementptr inbounds double, ptr %4, i64 %8
  store <2 x double> %12, ptr %13, align 8, !tbaa !5
  %14 = or disjoint i64 %8, 2
  %15 = icmp eq i64 %14, 410
  br i1 %15, label %24, label %16, !llvm.loop !9

16:                                               ; preds = %7
  %17 = add <2 x i32> %9, <i32 2, i32 2>
  %18 = sitofp <2 x i32> %17 to <2 x double>
  %19 = fdiv <2 x double> %18, <double 4.100000e+02, double 4.100000e+02>
  %20 = fadd <2 x double> %19, <double 1.000000e+00, double 1.000000e+00>
  %21 = getelementptr inbounds double, ptr %4, i64 %14
  store <2 x double> %20, ptr %21, align 8, !tbaa !5
  %22 = add nuw nsw i64 %8, 4
  %23 = add <2 x i32> %9, <i32 4, i32 4>
  br label %7

24:                                               ; preds = %7, %49
  %25 = phi i64 [ %50, %49 ], [ 0, %7 ]
  %26 = insertelement <2 x i64> poison, i64 %25, i64 0
  %27 = shufflevector <2 x i64> %26, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %28

28:                                               ; preds = %39, %24
  %29 = phi i64 [ 0, %24 ], [ %47, %39 ]
  %30 = phi <2 x i64> [ <i64 0, i64 1>, %24 ], [ %48, %39 ]
  %31 = add nuw nsw <2 x i64> %30, %27
  %32 = trunc <2 x i64> %31 to <2 x i32>
  %33 = urem <2 x i32> %32, <i32 410, i32 410>
  %34 = sitofp <2 x i32> %33 to <2 x double>
  %35 = fdiv <2 x double> %34, <double 1.950000e+03, double 1.950000e+03>
  %36 = getelementptr inbounds [410 x double], ptr %3, i64 %25, i64 %29
  store <2 x double> %35, ptr %36, align 8, !tbaa !5
  %37 = or disjoint i64 %29, 2
  %38 = icmp eq i64 %37, 410
  br i1 %38, label %49, label %39, !llvm.loop !13

39:                                               ; preds = %28
  %40 = add <2 x i64> %30, <i64 2, i64 2>
  %41 = add nuw nsw <2 x i64> %40, %27
  %42 = trunc <2 x i64> %41 to <2 x i32>
  %43 = urem <2 x i32> %42, <i32 410, i32 410>
  %44 = sitofp <2 x i32> %43 to <2 x double>
  %45 = fdiv <2 x double> %44, <double 1.950000e+03, double 1.950000e+03>
  %46 = getelementptr inbounds [410 x double], ptr %3, i64 %25, i64 %37
  store <2 x double> %45, ptr %46, align 8, !tbaa !5
  %47 = add nuw nsw i64 %29, 4
  %48 = add <2 x i64> %30, <i64 4, i64 4>
  br label %28

49:                                               ; preds = %28
  %50 = add nuw nsw i64 %25, 1
  %51 = icmp eq i64 %50, 390
  br i1 %51, label %52, label %24, !llvm.loop !14

52:                                               ; preds = %49
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(3280) %5, i8 0, i64 3280, i1 false), !tbaa !5
  %53 = getelementptr i8, ptr %5, i64 3280
  %54 = getelementptr i8, ptr %3, i64 1279200
  %55 = getelementptr i8, ptr %6, i64 3120
  %56 = icmp ult ptr %5, %54
  %57 = icmp ult ptr %3, %53
  %58 = and i1 %56, %57
  %59 = icmp ult ptr %5, %55
  %60 = icmp ult ptr %6, %53
  %61 = and i1 %59, %60
  %62 = or i1 %58, %61
  br label %63

63:                                               ; preds = %120, %52
  %64 = phi i64 [ 0, %52 ], [ %121, %120 ]
  %65 = getelementptr inbounds double, ptr %6, i64 %64
  store double 0.000000e+00, ptr %65, align 8, !tbaa !5
  br label %66

66:                                               ; preds = %66, %63
  %67 = phi i64 [ 0, %63 ], [ %80, %66 ]
  %68 = phi double [ 0.000000e+00, %63 ], [ %79, %66 ]
  %69 = getelementptr inbounds [410 x double], ptr %3, i64 %64, i64 %67
  %70 = load double, ptr %69, align 8, !tbaa !5
  %71 = getelementptr inbounds double, ptr %4, i64 %67
  %72 = load double, ptr %71, align 8, !tbaa !5
  %73 = tail call double @llvm.fmuladd.f64(double %70, double %72, double %68)
  store double %73, ptr %65, align 8, !tbaa !5
  %74 = or disjoint i64 %67, 1
  %75 = getelementptr inbounds [410 x double], ptr %3, i64 %64, i64 %74
  %76 = load double, ptr %75, align 8, !tbaa !5
  %77 = getelementptr inbounds double, ptr %4, i64 %74
  %78 = load double, ptr %77, align 8, !tbaa !5
  %79 = tail call double @llvm.fmuladd.f64(double %76, double %78, double %73)
  store double %79, ptr %65, align 8, !tbaa !5
  %80 = add nuw nsw i64 %67, 2
  %81 = icmp eq i64 %80, 410
  br i1 %81, label %82, label %66, !llvm.loop !15

82:                                               ; preds = %66
  br i1 %62, label %101, label %83

83:                                               ; preds = %82
  %84 = load double, ptr %65, align 8, !tbaa !5, !alias.scope !16
  %85 = insertelement <2 x double> poison, double %84, i64 0
  %86 = shufflevector <2 x double> %85, <2 x double> poison, <2 x i32> zeroinitializer
  br label %87

87:                                               ; preds = %83, %87
  %88 = phi i64 [ %99, %87 ], [ 0, %83 ]
  %89 = getelementptr inbounds double, ptr %5, i64 %88
  %90 = getelementptr inbounds double, ptr %89, i64 2
  %91 = load <2 x double>, ptr %89, align 8, !tbaa !5, !alias.scope !19, !noalias !21
  %92 = load <2 x double>, ptr %90, align 8, !tbaa !5, !alias.scope !19, !noalias !21
  %93 = getelementptr inbounds [410 x double], ptr %3, i64 %64, i64 %88
  %94 = getelementptr inbounds double, ptr %93, i64 2
  %95 = load <2 x double>, ptr %93, align 8, !tbaa !5, !alias.scope !23
  %96 = load <2 x double>, ptr %94, align 8, !tbaa !5, !alias.scope !23
  %97 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %95, <2 x double> %86, <2 x double> %91)
  %98 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %96, <2 x double> %86, <2 x double> %92)
  store <2 x double> %97, ptr %89, align 8, !tbaa !5, !alias.scope !19, !noalias !21
  store <2 x double> %98, ptr %90, align 8, !tbaa !5, !alias.scope !19, !noalias !21
  %99 = add nuw i64 %88, 4
  %100 = icmp eq i64 %99, 408
  br i1 %100, label %101, label %87, !llvm.loop !24

101:                                              ; preds = %87, %82
  %102 = phi i64 [ 0, %82 ], [ 408, %87 ]
  br label %103

103:                                              ; preds = %103, %101
  %104 = phi i64 [ %102, %101 ], [ %118, %103 ]
  %105 = getelementptr inbounds double, ptr %5, i64 %104
  %106 = load double, ptr %105, align 8, !tbaa !5
  %107 = getelementptr inbounds [410 x double], ptr %3, i64 %64, i64 %104
  %108 = load double, ptr %107, align 8, !tbaa !5
  %109 = load double, ptr %65, align 8, !tbaa !5
  %110 = tail call double @llvm.fmuladd.f64(double %108, double %109, double %106)
  store double %110, ptr %105, align 8, !tbaa !5
  %111 = or disjoint i64 %104, 1
  %112 = getelementptr inbounds double, ptr %5, i64 %111
  %113 = load double, ptr %112, align 8, !tbaa !5
  %114 = getelementptr inbounds [410 x double], ptr %3, i64 %64, i64 %111
  %115 = load double, ptr %114, align 8, !tbaa !5
  %116 = load double, ptr %65, align 8, !tbaa !5
  %117 = tail call double @llvm.fmuladd.f64(double %115, double %116, double %113)
  store double %117, ptr %112, align 8, !tbaa !5
  %118 = add nuw nsw i64 %104, 2
  %119 = icmp eq i64 %118, 410
  br i1 %119, label %120, label %103, !llvm.loop !25

120:                                              ; preds = %103
  %121 = add nuw nsw i64 %64, 1
  %122 = icmp eq i64 %121, 390
  br i1 %122, label %123, label %63, !llvm.loop !26

123:                                              ; preds = %120
  %124 = icmp sgt i32 %0, 42
  br i1 %124, label %125, label %154

125:                                              ; preds = %123
  %126 = load ptr, ptr %1, align 8, !tbaa !27
  %127 = load i8, ptr %126, align 1
  %128 = icmp eq i8 %127, 0
  br i1 %128, label %129, label %154

129:                                              ; preds = %125
  %130 = load ptr, ptr @stderr, align 8, !tbaa !27
  %131 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %130) #9
  %132 = load ptr, ptr @stderr, align 8, !tbaa !27
  %133 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %132, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #9
  br label %134

134:                                              ; preds = %142, %129
  %135 = phi i64 [ 0, %129 ], [ %147, %142 ]
  %136 = trunc i64 %135 to i16
  %137 = urem i16 %136, 20
  %138 = icmp eq i16 %137, 0
  br i1 %138, label %139, label %142

139:                                              ; preds = %134
  %140 = load ptr, ptr @stderr, align 8, !tbaa !27
  %141 = tail call i32 @fputc(i32 10, ptr %140)
  br label %142

142:                                              ; preds = %139, %134
  %143 = load ptr, ptr @stderr, align 8, !tbaa !27
  %144 = getelementptr inbounds double, ptr %5, i64 %135
  %145 = load double, ptr %144, align 8, !tbaa !5
  %146 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %143, ptr noundef nonnull @.str.5, double noundef %145) #9
  %147 = add nuw nsw i64 %135, 1
  %148 = icmp eq i64 %147, 410
  br i1 %148, label %149, label %134, !llvm.loop !29

149:                                              ; preds = %142
  %150 = load ptr, ptr @stderr, align 8, !tbaa !27
  %151 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %150, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #9
  %152 = load ptr, ptr @stderr, align 8, !tbaa !27
  %153 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %152) #9
  br label %154

154:                                              ; preds = %149, %125, %123
  tail call void @free(ptr noundef %3) #8
  tail call void @free(ptr noundef %4) #8
  tail call void @free(ptr noundef nonnull %5) #8
  tail call void @free(ptr noundef %6) #8
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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #7

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nounwind }
attributes #9 = { cold }

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
!13 = distinct !{!13, !10, !11, !12}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = !{!17}
!17 = distinct !{!17, !18}
!18 = distinct !{!18, !"LVerDomain"}
!19 = !{!20}
!20 = distinct !{!20, !18}
!21 = !{!22, !17}
!22 = distinct !{!22, !18}
!23 = !{!22}
!24 = distinct !{!24, !10, !11, !12}
!25 = distinct !{!25, !10, !11}
!26 = distinct !{!26, !10}
!27 = !{!28, !28, i64 0}
!28 = !{!"any pointer", !7, i64 0}
!29 = distinct !{!29, !10}
