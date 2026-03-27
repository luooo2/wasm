; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/blas/gesummv/gesummv.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/blas/gesummv/gesummv.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 62500, i32 noundef 8) #6
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 62500, i32 noundef 8) #6
  %6 = ptrtoint ptr %5 to i64
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 250, i32 noundef 8) #6
  %8 = tail call ptr @polybench_alloc_data(i64 noundef 250, i32 noundef 8) #6
  %9 = tail call ptr @polybench_alloc_data(i64 noundef 250, i32 noundef 8) #6
  %10 = sub i64 %6, %4
  %11 = icmp ult i64 %10, 16
  br label %12

12:                                               ; preds = %55, %2
  %13 = phi i64 [ 0, %2 ], [ %56, %55 ]
  %14 = trunc i64 %13 to i32
  %15 = sitofp i32 %14 to double
  %16 = fdiv double %15, 2.500000e+02
  %17 = getelementptr inbounds double, ptr %8, i64 %13
  store double %16, ptr %17, align 8, !tbaa !5
  br i1 %11, label %39, label %18

18:                                               ; preds = %12
  %19 = insertelement <2 x i64> poison, i64 %13, i64 0
  %20 = shufflevector <2 x i64> %19, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %21

21:                                               ; preds = %21, %18
  %22 = phi i64 [ 0, %18 ], [ %36, %21 ]
  %23 = phi <2 x i64> [ <i64 0, i64 1>, %18 ], [ %37, %21 ]
  %24 = mul nuw nsw <2 x i64> %23, %20
  %25 = trunc <2 x i64> %24 to <2 x i32>
  %26 = add <2 x i32> %25, <i32 1, i32 1>
  %27 = urem <2 x i32> %26, <i32 250, i32 250>
  %28 = sitofp <2 x i32> %27 to <2 x double>
  %29 = fdiv <2 x double> %28, <double 2.500000e+02, double 2.500000e+02>
  %30 = getelementptr inbounds [250 x double], ptr %3, i64 %13, i64 %22
  store <2 x double> %29, ptr %30, align 8, !tbaa !5
  %31 = add <2 x i32> %25, <i32 2, i32 2>
  %32 = urem <2 x i32> %31, <i32 250, i32 250>
  %33 = sitofp <2 x i32> %32 to <2 x double>
  %34 = fdiv <2 x double> %33, <double 2.500000e+02, double 2.500000e+02>
  %35 = getelementptr inbounds [250 x double], ptr %5, i64 %13, i64 %22
  store <2 x double> %34, ptr %35, align 8, !tbaa !5
  %36 = add nuw i64 %22, 2
  %37 = add <2 x i64> %23, <i64 2, i64 2>
  %38 = icmp eq i64 %36, 250
  br i1 %38, label %55, label %21, !llvm.loop !9

39:                                               ; preds = %12, %39
  %40 = phi i64 [ %53, %39 ], [ 0, %12 ]
  %41 = mul nuw nsw i64 %40, %13
  %42 = trunc i64 %41 to i32
  %43 = add i32 %42, 1
  %44 = urem i32 %43, 250
  %45 = sitofp i32 %44 to double
  %46 = fdiv double %45, 2.500000e+02
  %47 = getelementptr inbounds [250 x double], ptr %3, i64 %13, i64 %40
  store double %46, ptr %47, align 8, !tbaa !5
  %48 = add i32 %42, 2
  %49 = urem i32 %48, 250
  %50 = sitofp i32 %49 to double
  %51 = fdiv double %50, 2.500000e+02
  %52 = getelementptr inbounds [250 x double], ptr %5, i64 %13, i64 %40
  store double %51, ptr %52, align 8, !tbaa !5
  %53 = add nuw nsw i64 %40, 1
  %54 = icmp eq i64 %53, 250
  br i1 %54, label %55, label %39, !llvm.loop !13

55:                                               ; preds = %21, %39
  %56 = add nuw nsw i64 %13, 1
  %57 = icmp eq i64 %56, 250
  br i1 %57, label %58, label %12, !llvm.loop !14

58:                                               ; preds = %55, %77
  %59 = phi i64 [ %81, %77 ], [ 0, %55 ]
  %60 = getelementptr inbounds double, ptr %7, i64 %59
  store double 0.000000e+00, ptr %60, align 8, !tbaa !5
  %61 = getelementptr inbounds double, ptr %9, i64 %59
  store double 0.000000e+00, ptr %61, align 8, !tbaa !5
  br label %62

62:                                               ; preds = %62, %58
  %63 = phi i64 [ 0, %58 ], [ %75, %62 ]
  %64 = getelementptr inbounds [250 x double], ptr %3, i64 %59, i64 %63
  %65 = load double, ptr %64, align 8, !tbaa !5
  %66 = getelementptr inbounds double, ptr %8, i64 %63
  %67 = load double, ptr %66, align 8, !tbaa !5
  %68 = load double, ptr %60, align 8, !tbaa !5
  %69 = tail call double @llvm.fmuladd.f64(double %65, double %67, double %68)
  store double %69, ptr %60, align 8, !tbaa !5
  %70 = getelementptr inbounds [250 x double], ptr %5, i64 %59, i64 %63
  %71 = load double, ptr %70, align 8, !tbaa !5
  %72 = load double, ptr %66, align 8, !tbaa !5
  %73 = load double, ptr %61, align 8, !tbaa !5
  %74 = tail call double @llvm.fmuladd.f64(double %71, double %72, double %73)
  store double %74, ptr %61, align 8, !tbaa !5
  %75 = add nuw nsw i64 %63, 1
  %76 = icmp eq i64 %75, 250
  br i1 %76, label %77, label %62, !llvm.loop !15

77:                                               ; preds = %62
  %78 = load double, ptr %60, align 8, !tbaa !5
  %79 = fmul double %74, 1.200000e+00
  %80 = tail call double @llvm.fmuladd.f64(double %78, double 1.500000e+00, double %79)
  store double %80, ptr %61, align 8, !tbaa !5
  %81 = add nuw nsw i64 %59, 1
  %82 = icmp eq i64 %81, 250
  br i1 %82, label %83, label %58, !llvm.loop !16

83:                                               ; preds = %77
  %84 = icmp sgt i32 %0, 42
  br i1 %84, label %85, label %114

85:                                               ; preds = %83
  %86 = load ptr, ptr %1, align 8, !tbaa !17
  %87 = load i8, ptr %86, align 1
  %88 = icmp eq i8 %87, 0
  br i1 %88, label %89, label %114

89:                                               ; preds = %85
  %90 = load ptr, ptr @stderr, align 8, !tbaa !17
  %91 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %90) #7
  %92 = load ptr, ptr @stderr, align 8, !tbaa !17
  %93 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %92, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %94

94:                                               ; preds = %102, %89
  %95 = phi i64 [ 0, %89 ], [ %107, %102 ]
  %96 = trunc i64 %95 to i8
  %97 = urem i8 %96, 20
  %98 = icmp eq i8 %97, 0
  br i1 %98, label %99, label %102

99:                                               ; preds = %94
  %100 = load ptr, ptr @stderr, align 8, !tbaa !17
  %101 = tail call i32 @fputc(i32 10, ptr %100)
  br label %102

102:                                              ; preds = %99, %94
  %103 = load ptr, ptr @stderr, align 8, !tbaa !17
  %104 = getelementptr inbounds double, ptr %9, i64 %95
  %105 = load double, ptr %104, align 8, !tbaa !5
  %106 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %103, ptr noundef nonnull @.str.5, double noundef %105) #7
  %107 = add nuw nsw i64 %95, 1
  %108 = icmp eq i64 %107, 250
  br i1 %108, label %109, label %94, !llvm.loop !19

109:                                              ; preds = %102
  %110 = load ptr, ptr @stderr, align 8, !tbaa !17
  %111 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %110, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %112 = load ptr, ptr @stderr, align 8, !tbaa !17
  %113 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %112) #7
  br label %114

114:                                              ; preds = %109, %85, %83
  tail call void @free(ptr noundef %3) #6
  tail call void @free(ptr noundef %5) #6
  tail call void @free(ptr noundef %7) #6
  tail call void @free(ptr noundef %8) #6
  tail call void @free(ptr noundef nonnull %9) #6
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
!6 = !{!"double", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10, !11, !12}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.isvectorized", i32 1}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
!13 = distinct !{!13, !10, !11}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = !{!18, !18, i64 0}
!18 = !{!"any pointer", !7, i64 0}
!19 = distinct !{!19, !10}
