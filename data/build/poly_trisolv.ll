; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/solvers/trisolv/trisolv.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/solvers/trisolv/trisolv.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 160000, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #6
  br label %6

6:                                                ; preds = %45, %2
  %7 = phi i64 [ 0, %2 ], [ %46, %45 ]
  %8 = phi i64 [ 1, %2 ], [ %47, %45 ]
  %9 = getelementptr inbounds double, ptr %4, i64 %7
  store double -9.990000e+02, ptr %9, align 8, !tbaa !5
  %10 = trunc i64 %7 to i32
  %11 = sitofp i32 %10 to double
  %12 = getelementptr inbounds double, ptr %5, i64 %7
  store double %11, ptr %12, align 8, !tbaa !5
  %13 = add nuw nsw i64 %7, 401
  %14 = icmp ult i64 %8, 2
  br i1 %14, label %33, label %15

15:                                               ; preds = %6
  %16 = and i64 %8, 9223372036854775806
  %17 = insertelement <2 x i64> poison, i64 %13, i64 0
  %18 = shufflevector <2 x i64> %17, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %19

19:                                               ; preds = %19, %15
  %20 = phi i64 [ 0, %15 ], [ %28, %19 ]
  %21 = phi <2 x i64> [ <i64 0, i64 1>, %15 ], [ %29, %19 ]
  %22 = sub nuw nsw <2 x i64> %18, %21
  %23 = trunc <2 x i64> %22 to <2 x i32>
  %24 = sitofp <2 x i32> %23 to <2 x double>
  %25 = fmul <2 x double> %24, <double 2.000000e+00, double 2.000000e+00>
  %26 = fdiv <2 x double> %25, <double 4.000000e+02, double 4.000000e+02>
  %27 = getelementptr inbounds [400 x double], ptr %3, i64 %7, i64 %20
  store <2 x double> %26, ptr %27, align 8, !tbaa !5
  %28 = add nuw i64 %20, 2
  %29 = add <2 x i64> %21, <i64 2, i64 2>
  %30 = icmp eq i64 %28, %16
  br i1 %30, label %31, label %19, !llvm.loop !9

31:                                               ; preds = %19
  %32 = icmp eq i64 %8, %16
  br i1 %32, label %45, label %33

33:                                               ; preds = %6, %31
  %34 = phi i64 [ 0, %6 ], [ %16, %31 ]
  br label %35

35:                                               ; preds = %33, %35
  %36 = phi i64 [ %43, %35 ], [ %34, %33 ]
  %37 = sub nuw nsw i64 %13, %36
  %38 = trunc i64 %37 to i32
  %39 = sitofp i32 %38 to double
  %40 = fmul double %39, 2.000000e+00
  %41 = fdiv double %40, 4.000000e+02
  %42 = getelementptr inbounds [400 x double], ptr %3, i64 %7, i64 %36
  store double %41, ptr %42, align 8, !tbaa !5
  %43 = add nuw nsw i64 %36, 1
  %44 = icmp eq i64 %43, %8
  br i1 %44, label %45, label %35, !llvm.loop !13

45:                                               ; preds = %35, %31
  %46 = add nuw nsw i64 %7, 1
  %47 = add nuw nsw i64 %8, 1
  %48 = icmp eq i64 %46, 400
  br i1 %48, label %49, label %6, !llvm.loop !14

49:                                               ; preds = %45, %92
  %50 = phi i64 [ %97, %92 ], [ 0, %45 ]
  %51 = getelementptr inbounds double, ptr %5, i64 %50
  %52 = load double, ptr %51, align 8, !tbaa !5
  %53 = getelementptr inbounds double, ptr %4, i64 %50
  store double %52, ptr %53, align 8, !tbaa !5
  %54 = icmp eq i64 %50, 0
  br i1 %54, label %92, label %55

55:                                               ; preds = %49
  %56 = and i64 %50, 1
  %57 = icmp eq i64 %50, 1
  br i1 %57, label %80, label %58

58:                                               ; preds = %55
  %59 = and i64 %50, 9223372036854775806
  br label %60

60:                                               ; preds = %60, %58
  %61 = phi i64 [ 0, %58 ], [ %77, %60 ]
  %62 = phi double [ %52, %58 ], [ %76, %60 ]
  %63 = phi i64 [ 0, %58 ], [ %78, %60 ]
  %64 = getelementptr inbounds [400 x double], ptr %3, i64 %50, i64 %61
  %65 = load double, ptr %64, align 8, !tbaa !5
  %66 = getelementptr inbounds double, ptr %4, i64 %61
  %67 = load double, ptr %66, align 8, !tbaa !5
  %68 = fneg double %65
  %69 = tail call double @llvm.fmuladd.f64(double %68, double %67, double %62)
  store double %69, ptr %53, align 8, !tbaa !5
  %70 = or disjoint i64 %61, 1
  %71 = getelementptr inbounds [400 x double], ptr %3, i64 %50, i64 %70
  %72 = load double, ptr %71, align 8, !tbaa !5
  %73 = getelementptr inbounds double, ptr %4, i64 %70
  %74 = load double, ptr %73, align 8, !tbaa !5
  %75 = fneg double %72
  %76 = tail call double @llvm.fmuladd.f64(double %75, double %74, double %69)
  store double %76, ptr %53, align 8, !tbaa !5
  %77 = add nuw nsw i64 %61, 2
  %78 = add i64 %63, 2
  %79 = icmp eq i64 %78, %59
  br i1 %79, label %80, label %60, !llvm.loop !15

80:                                               ; preds = %60, %55
  %81 = phi double [ undef, %55 ], [ %76, %60 ]
  %82 = phi i64 [ 0, %55 ], [ %77, %60 ]
  %83 = phi double [ %52, %55 ], [ %76, %60 ]
  %84 = icmp eq i64 %56, 0
  br i1 %84, label %92, label %85

85:                                               ; preds = %80
  %86 = getelementptr inbounds [400 x double], ptr %3, i64 %50, i64 %82
  %87 = load double, ptr %86, align 8, !tbaa !5
  %88 = getelementptr inbounds double, ptr %4, i64 %82
  %89 = load double, ptr %88, align 8, !tbaa !5
  %90 = fneg double %87
  %91 = tail call double @llvm.fmuladd.f64(double %90, double %89, double %83)
  store double %91, ptr %53, align 8, !tbaa !5
  br label %92

92:                                               ; preds = %85, %80, %49
  %93 = phi double [ %52, %49 ], [ %81, %80 ], [ %91, %85 ]
  %94 = getelementptr inbounds [400 x double], ptr %3, i64 %50, i64 %50
  %95 = load double, ptr %94, align 8, !tbaa !5
  %96 = fdiv double %93, %95
  store double %96, ptr %53, align 8, !tbaa !5
  %97 = add nuw nsw i64 %50, 1
  %98 = icmp eq i64 %97, 400
  br i1 %98, label %99, label %49, !llvm.loop !16

99:                                               ; preds = %92
  %100 = icmp sgt i32 %0, 42
  br i1 %100, label %101, label %130

101:                                              ; preds = %99
  %102 = load ptr, ptr %1, align 8, !tbaa !17
  %103 = load i8, ptr %102, align 1
  %104 = icmp eq i8 %103, 0
  br i1 %104, label %105, label %130

105:                                              ; preds = %101
  %106 = load ptr, ptr @stderr, align 8, !tbaa !17
  %107 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %106) #7
  %108 = load ptr, ptr @stderr, align 8, !tbaa !17
  %109 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %108, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %110

110:                                              ; preds = %122, %105
  %111 = phi i64 [ 0, %105 ], [ %123, %122 ]
  %112 = load ptr, ptr @stderr, align 8, !tbaa !17
  %113 = getelementptr inbounds double, ptr %4, i64 %111
  %114 = load double, ptr %113, align 8, !tbaa !5
  %115 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %112, ptr noundef nonnull @.str.4, double noundef %114) #7
  %116 = trunc i64 %111 to i16
  %117 = urem i16 %116, 20
  %118 = icmp eq i16 %117, 0
  br i1 %118, label %119, label %122

119:                                              ; preds = %110
  %120 = load ptr, ptr @stderr, align 8, !tbaa !17
  %121 = tail call i32 @fputc(i32 10, ptr %120)
  br label %122

122:                                              ; preds = %119, %110
  %123 = add nuw nsw i64 %111, 1
  %124 = icmp eq i64 %123, 400
  br i1 %124, label %125, label %110, !llvm.loop !19

125:                                              ; preds = %122
  %126 = load ptr, ptr @stderr, align 8, !tbaa !17
  %127 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %126, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %128 = load ptr, ptr @stderr, align 8, !tbaa !17
  %129 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %128) #7
  br label %130

130:                                              ; preds = %125, %101, %99
  tail call void @free(ptr noundef %3) #6
  tail call void @free(ptr noundef nonnull %4) #6
  tail call void @free(ptr noundef %5) #6
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
!13 = distinct !{!13, !10, !12, !11}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = !{!18, !18, i64 0}
!18 = !{!"any pointer", !7, i64 0}
!19 = distinct !{!19, !10}
