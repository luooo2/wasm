; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/blas/trmm/trmm.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/blas/trmm/trmm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"B\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 40000, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 48000, i32 noundef 8) #6
  br label %5

5:                                                ; preds = %62, %2
  %6 = phi i64 [ 0, %2 ], [ %63, %62 ]
  switch i64 %6, label %7 [
    i64 0, label %37
    i64 1, label %25
  ]

7:                                                ; preds = %5
  %8 = and i64 %6, 9223372036854775806
  %9 = insertelement <2 x i64> poison, i64 %6, i64 0
  %10 = shufflevector <2 x i64> %9, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %11

11:                                               ; preds = %11, %7
  %12 = phi i64 [ 0, %7 ], [ %20, %11 ]
  %13 = phi <2 x i64> [ <i64 0, i64 1>, %7 ], [ %21, %11 ]
  %14 = add nuw nsw <2 x i64> %13, %10
  %15 = trunc <2 x i64> %14 to <2 x i32>
  %16 = urem <2 x i32> %15, <i32 200, i32 200>
  %17 = sitofp <2 x i32> %16 to <2 x double>
  %18 = fdiv <2 x double> %17, <double 2.000000e+02, double 2.000000e+02>
  %19 = getelementptr inbounds [200 x double], ptr %3, i64 %6, i64 %12
  store <2 x double> %18, ptr %19, align 8, !tbaa !5
  %20 = add nuw i64 %12, 2
  %21 = add <2 x i64> %13, <i64 2, i64 2>
  %22 = icmp eq i64 %20, %8
  br i1 %22, label %23, label %11, !llvm.loop !9

23:                                               ; preds = %11
  %24 = icmp eq i64 %6, %8
  br i1 %24, label %37, label %25

25:                                               ; preds = %5, %23
  %26 = phi i64 [ 0, %5 ], [ %8, %23 ]
  br label %27

27:                                               ; preds = %25, %27
  %28 = phi i64 [ %35, %27 ], [ %26, %25 ]
  %29 = add nuw nsw i64 %28, %6
  %30 = trunc i64 %29 to i32
  %31 = urem i32 %30, 200
  %32 = sitofp i32 %31 to double
  %33 = fdiv double %32, 2.000000e+02
  %34 = getelementptr inbounds [200 x double], ptr %3, i64 %6, i64 %28
  store double %33, ptr %34, align 8, !tbaa !5
  %35 = add nuw nsw i64 %28, 1
  %36 = icmp eq i64 %35, %6
  br i1 %36, label %37, label %27, !llvm.loop !13

37:                                               ; preds = %27, %23, %5
  %38 = getelementptr inbounds [200 x double], ptr %3, i64 %6, i64 %6
  store double 1.000000e+00, ptr %38, align 8, !tbaa !5
  %39 = add nuw nsw i64 %6, 240
  %40 = insertelement <2 x i64> poison, i64 %39, i64 0
  %41 = shufflevector <2 x i64> %40, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %42

42:                                               ; preds = %42, %37
  %43 = phi i64 [ 0, %37 ], [ %59, %42 ]
  %44 = phi <2 x i64> [ <i64 0, i64 1>, %37 ], [ %60, %42 ]
  %45 = sub nuw nsw <2 x i64> %41, %44
  %46 = trunc <2 x i64> %45 to <2 x i32>
  %47 = urem <2 x i32> %46, <i32 240, i32 240>
  %48 = sitofp <2 x i32> %47 to <2 x double>
  %49 = fdiv <2 x double> %48, <double 2.400000e+02, double 2.400000e+02>
  %50 = getelementptr inbounds [240 x double], ptr %4, i64 %6, i64 %43
  store <2 x double> %49, ptr %50, align 8, !tbaa !5
  %51 = or disjoint i64 %43, 2
  %52 = add <2 x i64> %44, <i64 2, i64 2>
  %53 = sub nuw nsw <2 x i64> %41, %52
  %54 = trunc <2 x i64> %53 to <2 x i32>
  %55 = urem <2 x i32> %54, <i32 240, i32 240>
  %56 = sitofp <2 x i32> %55 to <2 x double>
  %57 = fdiv <2 x double> %56, <double 2.400000e+02, double 2.400000e+02>
  %58 = getelementptr inbounds [240 x double], ptr %4, i64 %6, i64 %51
  store <2 x double> %57, ptr %58, align 8, !tbaa !5
  %59 = add nuw nsw i64 %43, 4
  %60 = add <2 x i64> %44, <i64 4, i64 4>
  %61 = icmp eq i64 %59, 240
  br i1 %61, label %62, label %42, !llvm.loop !14

62:                                               ; preds = %42
  %63 = add nuw nsw i64 %6, 1
  %64 = icmp eq i64 %63, 200
  br i1 %64, label %65, label %5, !llvm.loop !15

65:                                               ; preds = %62, %87
  %66 = phi i64 [ %88, %87 ], [ 0, %62 ]
  %67 = icmp ult i64 %66, 199
  br label %68

68:                                               ; preds = %82, %65
  %69 = phi i64 [ 0, %65 ], [ %85, %82 ]
  %70 = getelementptr inbounds [240 x double], ptr %4, i64 %66, i64 %69
  %71 = load double, ptr %70, align 8, !tbaa !5
  br i1 %67, label %72, label %82

72:                                               ; preds = %68, %72
  %73 = phi i64 [ %75, %72 ], [ %66, %68 ]
  %74 = phi double [ %80, %72 ], [ %71, %68 ]
  %75 = add nuw nsw i64 %73, 1
  %76 = getelementptr inbounds [200 x double], ptr %3, i64 %75, i64 %66
  %77 = load double, ptr %76, align 8, !tbaa !5
  %78 = getelementptr inbounds [240 x double], ptr %4, i64 %75, i64 %69
  %79 = load double, ptr %78, align 8, !tbaa !5
  %80 = tail call double @llvm.fmuladd.f64(double %77, double %79, double %74)
  store double %80, ptr %70, align 8, !tbaa !5
  %81 = icmp eq i64 %75, 199
  br i1 %81, label %82, label %72, !llvm.loop !16

82:                                               ; preds = %72, %68
  %83 = phi double [ %71, %68 ], [ %80, %72 ]
  %84 = fmul double %83, 1.500000e+00
  store double %84, ptr %70, align 8, !tbaa !5
  %85 = add nuw nsw i64 %69, 1
  %86 = icmp eq i64 %85, 240
  br i1 %86, label %87, label %68, !llvm.loop !17

87:                                               ; preds = %82
  %88 = add nuw nsw i64 %66, 1
  %89 = icmp eq i64 %88, 200
  br i1 %89, label %90, label %65, !llvm.loop !18

90:                                               ; preds = %87
  %91 = icmp sgt i32 %0, 42
  br i1 %91, label %92, label %128

92:                                               ; preds = %90
  %93 = load ptr, ptr %1, align 8, !tbaa !19
  %94 = load i8, ptr %93, align 1
  %95 = icmp eq i8 %94, 0
  br i1 %95, label %96, label %128

96:                                               ; preds = %92
  %97 = load ptr, ptr @stderr, align 8, !tbaa !19
  %98 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %97) #7
  %99 = load ptr, ptr @stderr, align 8, !tbaa !19
  %100 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %99, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %101

101:                                              ; preds = %120, %96
  %102 = phi i64 [ 0, %96 ], [ %121, %120 ]
  %103 = mul nuw nsw i64 %102, 200
  br label %104

104:                                              ; preds = %113, %101
  %105 = phi i64 [ 0, %101 ], [ %118, %113 ]
  %106 = add nuw nsw i64 %105, %103
  %107 = trunc i64 %106 to i32
  %108 = urem i32 %107, 20
  %109 = icmp eq i32 %108, 0
  br i1 %109, label %110, label %113

110:                                              ; preds = %104
  %111 = load ptr, ptr @stderr, align 8, !tbaa !19
  %112 = tail call i32 @fputc(i32 10, ptr %111)
  br label %113

113:                                              ; preds = %110, %104
  %114 = load ptr, ptr @stderr, align 8, !tbaa !19
  %115 = getelementptr inbounds [240 x double], ptr %4, i64 %102, i64 %105
  %116 = load double, ptr %115, align 8, !tbaa !5
  %117 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %114, ptr noundef nonnull @.str.5, double noundef %116) #7
  %118 = add nuw nsw i64 %105, 1
  %119 = icmp eq i64 %118, 240
  br i1 %119, label %120, label %104, !llvm.loop !21

120:                                              ; preds = %113
  %121 = add nuw nsw i64 %102, 1
  %122 = icmp eq i64 %121, 200
  br i1 %122, label %123, label %101, !llvm.loop !22

123:                                              ; preds = %120
  %124 = load ptr, ptr @stderr, align 8, !tbaa !19
  %125 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %124, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %126 = load ptr, ptr @stderr, align 8, !tbaa !19
  %127 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %126) #7
  br label %128

128:                                              ; preds = %123, %92, %90
  tail call void @free(ptr noundef %3) #6
  tail call void @free(ptr noundef nonnull %4) #6
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
!14 = distinct !{!14, !10, !11, !12}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = distinct !{!17, !10}
!18 = distinct !{!18, !10}
!19 = !{!20, !20, i64 0}
!20 = !{!"any pointer", !7, i64 0}
!21 = distinct !{!21, !10}
!22 = distinct !{!22, !10}
