; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/kernels/bicg/bicg.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/kernels/bicg/bicg.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"s\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"q\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 159900, i32 noundef 8) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 390, i32 noundef 8) #7
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 410, i32 noundef 8) #7
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 390, i32 noundef 8) #7
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 410, i32 noundef 8) #7
  %8 = getelementptr double, ptr %6, i64 2
  %9 = getelementptr double, ptr %6, i64 4
  br label %10

10:                                               ; preds = %10, %2
  %11 = phi i64 [ 0, %2 ], [ %24, %10 ]
  %12 = phi <2 x i32> [ <i32 0, i32 1>, %2 ], [ %25, %10 ]
  %13 = sitofp <2 x i32> %12 to <2 x double>
  %14 = fdiv <2 x double> %13, <double 3.900000e+02, double 3.900000e+02>
  %15 = getelementptr inbounds double, ptr %6, i64 %11
  store <2 x double> %14, ptr %15, align 8, !tbaa !5
  %16 = add <2 x i32> %12, <i32 2, i32 2>
  %17 = sitofp <2 x i32> %16 to <2 x double>
  %18 = fdiv <2 x double> %17, <double 3.900000e+02, double 3.900000e+02>
  %19 = getelementptr double, ptr %8, i64 %11
  store <2 x double> %18, ptr %19, align 8, !tbaa !5
  %20 = add <2 x i32> %12, <i32 4, i32 4>
  %21 = sitofp <2 x i32> %20 to <2 x double>
  %22 = fdiv <2 x double> %21, <double 3.900000e+02, double 3.900000e+02>
  %23 = getelementptr double, ptr %9, i64 %11
  store <2 x double> %22, ptr %23, align 8, !tbaa !5
  %24 = add nuw nsw i64 %11, 6
  %25 = add <2 x i32> %12, <i32 6, i32 6>
  %26 = icmp eq i64 %24, 390
  br i1 %26, label %27, label %10, !llvm.loop !9

27:                                               ; preds = %10, %48
  %28 = phi i64 [ %49, %48 ], [ 0, %10 ]
  %29 = trunc i64 %28 to i32
  %30 = sitofp i32 %29 to double
  %31 = fdiv double %30, 4.100000e+02
  %32 = getelementptr inbounds double, ptr %7, i64 %28
  store double %31, ptr %32, align 8, !tbaa !5
  %33 = insertelement <2 x i64> poison, i64 %28, i64 0
  %34 = shufflevector <2 x i64> %33, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %35

35:                                               ; preds = %35, %27
  %36 = phi i64 [ 0, %27 ], [ %45, %35 ]
  %37 = phi <2 x i64> [ <i64 0, i64 1>, %27 ], [ %46, %35 ]
  %38 = add nuw nsw <2 x i64> %37, <i64 1, i64 1>
  %39 = mul nuw nsw <2 x i64> %38, %34
  %40 = trunc <2 x i64> %39 to <2 x i32>
  %41 = urem <2 x i32> %40, <i32 410, i32 410>
  %42 = sitofp <2 x i32> %41 to <2 x double>
  %43 = fdiv <2 x double> %42, <double 4.100000e+02, double 4.100000e+02>
  %44 = getelementptr inbounds [390 x double], ptr %3, i64 %28, i64 %36
  store <2 x double> %43, ptr %44, align 8, !tbaa !5
  %45 = add nuw i64 %36, 2
  %46 = add <2 x i64> %37, <i64 2, i64 2>
  %47 = icmp eq i64 %45, 390
  br i1 %47, label %48, label %35, !llvm.loop !13

48:                                               ; preds = %35
  %49 = add nuw nsw i64 %28, 1
  %50 = icmp eq i64 %49, 410
  br i1 %50, label %51, label %27, !llvm.loop !14

51:                                               ; preds = %48
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(3120) %4, i8 0, i64 3120, i1 false), !tbaa !5
  br label %52

52:                                               ; preds = %71, %51
  %53 = phi i64 [ 0, %51 ], [ %72, %71 ]
  %54 = getelementptr inbounds double, ptr %5, i64 %53
  store double 0.000000e+00, ptr %54, align 8, !tbaa !5
  %55 = getelementptr inbounds double, ptr %7, i64 %53
  br label %56

56:                                               ; preds = %56, %52
  %57 = phi i64 [ 0, %52 ], [ %69, %56 ]
  %58 = getelementptr inbounds double, ptr %4, i64 %57
  %59 = load double, ptr %58, align 8, !tbaa !5
  %60 = load double, ptr %55, align 8, !tbaa !5
  %61 = getelementptr inbounds [390 x double], ptr %3, i64 %53, i64 %57
  %62 = load double, ptr %61, align 8, !tbaa !5
  %63 = tail call double @llvm.fmuladd.f64(double %60, double %62, double %59)
  store double %63, ptr %58, align 8, !tbaa !5
  %64 = load double, ptr %54, align 8, !tbaa !5
  %65 = load double, ptr %61, align 8, !tbaa !5
  %66 = getelementptr inbounds double, ptr %6, i64 %57
  %67 = load double, ptr %66, align 8, !tbaa !5
  %68 = tail call double @llvm.fmuladd.f64(double %65, double %67, double %64)
  store double %68, ptr %54, align 8, !tbaa !5
  %69 = add nuw nsw i64 %57, 1
  %70 = icmp eq i64 %69, 390
  br i1 %70, label %71, label %56, !llvm.loop !15

71:                                               ; preds = %56
  %72 = add nuw nsw i64 %53, 1
  %73 = icmp eq i64 %72, 410
  br i1 %73, label %74, label %52, !llvm.loop !16

74:                                               ; preds = %71
  %75 = icmp sgt i32 %0, 42
  br i1 %75, label %76, label %125

76:                                               ; preds = %74
  %77 = load ptr, ptr %1, align 8, !tbaa !17
  %78 = load i8, ptr %77, align 1
  %79 = icmp eq i8 %78, 0
  br i1 %79, label %80, label %125

80:                                               ; preds = %76
  %81 = load ptr, ptr @stderr, align 8, !tbaa !17
  %82 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %81) #8
  %83 = load ptr, ptr @stderr, align 8, !tbaa !17
  %84 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %83, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %85

85:                                               ; preds = %93, %80
  %86 = phi i64 [ 0, %80 ], [ %98, %93 ]
  %87 = trunc i64 %86 to i16
  %88 = urem i16 %87, 20
  %89 = icmp eq i16 %88, 0
  br i1 %89, label %90, label %93

90:                                               ; preds = %85
  %91 = load ptr, ptr @stderr, align 8, !tbaa !17
  %92 = tail call i32 @fputc(i32 10, ptr %91)
  br label %93

93:                                               ; preds = %90, %85
  %94 = load ptr, ptr @stderr, align 8, !tbaa !17
  %95 = getelementptr inbounds double, ptr %4, i64 %86
  %96 = load double, ptr %95, align 8, !tbaa !5
  %97 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %94, ptr noundef nonnull @.str.5, double noundef %96) #8
  %98 = add nuw nsw i64 %86, 1
  %99 = icmp eq i64 %98, 390
  br i1 %99, label %100, label %85, !llvm.loop !19

100:                                              ; preds = %93
  %101 = load ptr, ptr @stderr, align 8, !tbaa !17
  %102 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %101, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %103 = load ptr, ptr @stderr, align 8, !tbaa !17
  %104 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %103, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.7) #8
  br label %105

105:                                              ; preds = %113, %100
  %106 = phi i64 [ 0, %100 ], [ %118, %113 ]
  %107 = trunc i64 %106 to i16
  %108 = urem i16 %107, 20
  %109 = icmp eq i16 %108, 0
  br i1 %109, label %110, label %113

110:                                              ; preds = %105
  %111 = load ptr, ptr @stderr, align 8, !tbaa !17
  %112 = tail call i32 @fputc(i32 10, ptr %111)
  br label %113

113:                                              ; preds = %110, %105
  %114 = load ptr, ptr @stderr, align 8, !tbaa !17
  %115 = getelementptr inbounds double, ptr %5, i64 %106
  %116 = load double, ptr %115, align 8, !tbaa !5
  %117 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %114, ptr noundef nonnull @.str.5, double noundef %116) #8
  %118 = add nuw nsw i64 %106, 1
  %119 = icmp eq i64 %118, 410
  br i1 %119, label %120, label %105, !llvm.loop !20

120:                                              ; preds = %113
  %121 = load ptr, ptr @stderr, align 8, !tbaa !17
  %122 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %121, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.7) #8
  %123 = load ptr, ptr @stderr, align 8, !tbaa !17
  %124 = tail call i64 @fwrite(ptr nonnull @.str.8, i64 22, i64 1, ptr %123) #8
  br label %125

125:                                              ; preds = %120, %76, %74
  tail call void @free(ptr noundef %3) #7
  tail call void @free(ptr noundef %4) #7
  tail call void @free(ptr noundef nonnull %5) #7
  tail call void @free(ptr noundef %6) #7
  tail call void @free(ptr noundef %7) #7
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

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
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
!13 = distinct !{!13, !10, !11, !12}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = !{!18, !18, i64 0}
!18 = !{!"any pointer", !7, i64 0}
!19 = distinct !{!19, !10}
!20 = distinct !{!20, !10}
