; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/kernels/2mm/2mm.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/kernels/2mm/2mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"D\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 34200, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 37800, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 39900, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 41800, i32 noundef 8) #6
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 39600, i32 noundef 8) #6
  br label %8

8:                                                ; preds = %2, %25
  %9 = phi i64 [ 0, %2 ], [ %26, %25 ]
  %10 = insertelement <2 x i64> poison, i64 %9, i64 0
  %11 = shufflevector <2 x i64> %10, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %12

12:                                               ; preds = %12, %8
  %13 = phi i64 [ 0, %8 ], [ %22, %12 ]
  %14 = phi <2 x i64> [ <i64 0, i64 1>, %8 ], [ %23, %12 ]
  %15 = mul nuw nsw <2 x i64> %14, %11
  %16 = trunc <2 x i64> %15 to <2 x i32>
  %17 = add <2 x i32> %16, <i32 1, i32 1>
  %18 = urem <2 x i32> %17, <i32 180, i32 180>
  %19 = sitofp <2 x i32> %18 to <2 x double>
  %20 = fdiv <2 x double> %19, <double 1.800000e+02, double 1.800000e+02>
  %21 = getelementptr inbounds [210 x double], ptr %4, i64 %9, i64 %13
  store <2 x double> %20, ptr %21, align 8, !tbaa !5
  %22 = add nuw i64 %13, 2
  %23 = add <2 x i64> %14, <i64 2, i64 2>
  %24 = icmp eq i64 %22, 210
  br i1 %24, label %25, label %12, !llvm.loop !9

25:                                               ; preds = %12
  %26 = add nuw nsw i64 %9, 1
  %27 = icmp eq i64 %26, 180
  br i1 %27, label %28, label %8, !llvm.loop !13

28:                                               ; preds = %25, %45
  %29 = phi i64 [ %46, %45 ], [ 0, %25 ]
  %30 = insertelement <2 x i64> poison, i64 %29, i64 0
  %31 = shufflevector <2 x i64> %30, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %32

32:                                               ; preds = %32, %28
  %33 = phi i64 [ 0, %28 ], [ %42, %32 ]
  %34 = phi <2 x i64> [ <i64 0, i64 1>, %28 ], [ %43, %32 ]
  %35 = add nuw nsw <2 x i64> %34, <i64 1, i64 1>
  %36 = mul nuw nsw <2 x i64> %35, %31
  %37 = trunc <2 x i64> %36 to <2 x i32>
  %38 = urem <2 x i32> %37, <i32 190, i32 190>
  %39 = sitofp <2 x i32> %38 to <2 x double>
  %40 = fdiv <2 x double> %39, <double 1.900000e+02, double 1.900000e+02>
  %41 = getelementptr inbounds [190 x double], ptr %5, i64 %29, i64 %33
  store <2 x double> %40, ptr %41, align 8, !tbaa !5
  %42 = add nuw i64 %33, 2
  %43 = add <2 x i64> %34, <i64 2, i64 2>
  %44 = icmp eq i64 %42, 190
  br i1 %44, label %45, label %32, !llvm.loop !14

45:                                               ; preds = %32
  %46 = add nuw nsw i64 %29, 1
  %47 = icmp eq i64 %46, 210
  br i1 %47, label %48, label %28, !llvm.loop !15

48:                                               ; preds = %45, %66
  %49 = phi i64 [ %67, %66 ], [ 0, %45 ]
  %50 = insertelement <2 x i64> poison, i64 %49, i64 0
  %51 = shufflevector <2 x i64> %50, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %52

52:                                               ; preds = %52, %48
  %53 = phi i64 [ 0, %48 ], [ %63, %52 ]
  %54 = phi <2 x i64> [ <i64 0, i64 1>, %48 ], [ %64, %52 ]
  %55 = add nuw nsw <2 x i64> %54, <i64 3, i64 3>
  %56 = mul nuw nsw <2 x i64> %55, %51
  %57 = trunc <2 x i64> %56 to <2 x i32>
  %58 = add <2 x i32> %57, <i32 1, i32 1>
  %59 = urem <2 x i32> %58, <i32 220, i32 220>
  %60 = sitofp <2 x i32> %59 to <2 x double>
  %61 = fdiv <2 x double> %60, <double 2.200000e+02, double 2.200000e+02>
  %62 = getelementptr inbounds [220 x double], ptr %6, i64 %49, i64 %53
  store <2 x double> %61, ptr %62, align 8, !tbaa !5
  %63 = add nuw i64 %53, 2
  %64 = add <2 x i64> %54, <i64 2, i64 2>
  %65 = icmp eq i64 %63, 220
  br i1 %65, label %66, label %52, !llvm.loop !16

66:                                               ; preds = %52
  %67 = add nuw nsw i64 %49, 1
  %68 = icmp eq i64 %67, 190
  br i1 %68, label %69, label %48, !llvm.loop !17

69:                                               ; preds = %66, %86
  %70 = phi i64 [ %87, %86 ], [ 0, %66 ]
  %71 = insertelement <2 x i64> poison, i64 %70, i64 0
  %72 = shufflevector <2 x i64> %71, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %73

73:                                               ; preds = %73, %69
  %74 = phi i64 [ 0, %69 ], [ %83, %73 ]
  %75 = phi <2 x i64> [ <i64 0, i64 1>, %69 ], [ %84, %73 ]
  %76 = add nuw nsw <2 x i64> %75, <i64 2, i64 2>
  %77 = mul nuw nsw <2 x i64> %76, %72
  %78 = trunc <2 x i64> %77 to <2 x i32>
  %79 = urem <2 x i32> %78, <i32 210, i32 210>
  %80 = sitofp <2 x i32> %79 to <2 x double>
  %81 = fdiv <2 x double> %80, <double 2.100000e+02, double 2.100000e+02>
  %82 = getelementptr inbounds [220 x double], ptr %7, i64 %70, i64 %74
  store <2 x double> %81, ptr %82, align 8, !tbaa !5
  %83 = add nuw i64 %74, 2
  %84 = add <2 x i64> %75, <i64 2, i64 2>
  %85 = icmp eq i64 %83, 220
  br i1 %85, label %86, label %73, !llvm.loop !18

86:                                               ; preds = %73
  %87 = add nuw nsw i64 %70, 1
  %88 = icmp eq i64 %87, 180
  br i1 %88, label %89, label %69, !llvm.loop !19

89:                                               ; preds = %86, %115
  %90 = phi i64 [ %116, %115 ], [ 0, %86 ]
  br label %91

91:                                               ; preds = %112, %89
  %92 = phi i64 [ 0, %89 ], [ %113, %112 ]
  %93 = getelementptr inbounds [190 x double], ptr %3, i64 %90, i64 %92
  store double 0.000000e+00, ptr %93, align 8, !tbaa !5
  br label %94

94:                                               ; preds = %94, %91
  %95 = phi i64 [ 0, %91 ], [ %110, %94 ]
  %96 = phi double [ 0.000000e+00, %91 ], [ %109, %94 ]
  %97 = getelementptr inbounds [210 x double], ptr %4, i64 %90, i64 %95
  %98 = load double, ptr %97, align 8, !tbaa !5
  %99 = fmul double %98, 1.500000e+00
  %100 = getelementptr inbounds [190 x double], ptr %5, i64 %95, i64 %92
  %101 = load double, ptr %100, align 8, !tbaa !5
  %102 = tail call double @llvm.fmuladd.f64(double %99, double %101, double %96)
  store double %102, ptr %93, align 8, !tbaa !5
  %103 = or disjoint i64 %95, 1
  %104 = getelementptr inbounds [210 x double], ptr %4, i64 %90, i64 %103
  %105 = load double, ptr %104, align 8, !tbaa !5
  %106 = fmul double %105, 1.500000e+00
  %107 = getelementptr inbounds [190 x double], ptr %5, i64 %103, i64 %92
  %108 = load double, ptr %107, align 8, !tbaa !5
  %109 = tail call double @llvm.fmuladd.f64(double %106, double %108, double %102)
  store double %109, ptr %93, align 8, !tbaa !5
  %110 = add nuw nsw i64 %95, 2
  %111 = icmp eq i64 %110, 210
  br i1 %111, label %112, label %94, !llvm.loop !20

112:                                              ; preds = %94
  %113 = add nuw nsw i64 %92, 1
  %114 = icmp eq i64 %113, 190
  br i1 %114, label %115, label %91, !llvm.loop !21

115:                                              ; preds = %112
  %116 = add nuw nsw i64 %90, 1
  %117 = icmp eq i64 %116, 180
  br i1 %117, label %118, label %89, !llvm.loop !22

118:                                              ; preds = %115, %144
  %119 = phi i64 [ %145, %144 ], [ 0, %115 ]
  br label %120

120:                                              ; preds = %141, %118
  %121 = phi i64 [ 0, %118 ], [ %142, %141 ]
  %122 = getelementptr inbounds [220 x double], ptr %7, i64 %119, i64 %121
  %123 = load double, ptr %122, align 8, !tbaa !5
  %124 = fmul double %123, 1.200000e+00
  store double %124, ptr %122, align 8, !tbaa !5
  br label %125

125:                                              ; preds = %125, %120
  %126 = phi i64 [ 0, %120 ], [ %139, %125 ]
  %127 = phi double [ %124, %120 ], [ %138, %125 ]
  %128 = getelementptr inbounds [190 x double], ptr %3, i64 %119, i64 %126
  %129 = load double, ptr %128, align 8, !tbaa !5
  %130 = getelementptr inbounds [220 x double], ptr %6, i64 %126, i64 %121
  %131 = load double, ptr %130, align 8, !tbaa !5
  %132 = tail call double @llvm.fmuladd.f64(double %129, double %131, double %127)
  store double %132, ptr %122, align 8, !tbaa !5
  %133 = or disjoint i64 %126, 1
  %134 = getelementptr inbounds [190 x double], ptr %3, i64 %119, i64 %133
  %135 = load double, ptr %134, align 8, !tbaa !5
  %136 = getelementptr inbounds [220 x double], ptr %6, i64 %133, i64 %121
  %137 = load double, ptr %136, align 8, !tbaa !5
  %138 = tail call double @llvm.fmuladd.f64(double %135, double %137, double %132)
  store double %138, ptr %122, align 8, !tbaa !5
  %139 = add nuw nsw i64 %126, 2
  %140 = icmp eq i64 %139, 190
  br i1 %140, label %141, label %125, !llvm.loop !23

141:                                              ; preds = %125
  %142 = add nuw nsw i64 %121, 1
  %143 = icmp eq i64 %142, 220
  br i1 %143, label %144, label %120, !llvm.loop !24

144:                                              ; preds = %141
  %145 = add nuw nsw i64 %119, 1
  %146 = icmp eq i64 %145, 180
  br i1 %146, label %147, label %118, !llvm.loop !25

147:                                              ; preds = %144
  %148 = icmp sgt i32 %0, 42
  br i1 %148, label %149, label %185

149:                                              ; preds = %147
  %150 = load ptr, ptr %1, align 8, !tbaa !26
  %151 = load i8, ptr %150, align 1
  %152 = icmp eq i8 %151, 0
  br i1 %152, label %153, label %185

153:                                              ; preds = %149
  %154 = load ptr, ptr @stderr, align 8, !tbaa !26
  %155 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %154) #7
  %156 = load ptr, ptr @stderr, align 8, !tbaa !26
  %157 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %156, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %158

158:                                              ; preds = %177, %153
  %159 = phi i64 [ 0, %153 ], [ %178, %177 ]
  %160 = mul nuw nsw i64 %159, 180
  br label %161

161:                                              ; preds = %170, %158
  %162 = phi i64 [ 0, %158 ], [ %175, %170 ]
  %163 = add nuw nsw i64 %162, %160
  %164 = trunc i64 %163 to i32
  %165 = urem i32 %164, 20
  %166 = icmp eq i32 %165, 0
  br i1 %166, label %167, label %170

167:                                              ; preds = %161
  %168 = load ptr, ptr @stderr, align 8, !tbaa !26
  %169 = tail call i32 @fputc(i32 10, ptr %168)
  br label %170

170:                                              ; preds = %167, %161
  %171 = load ptr, ptr @stderr, align 8, !tbaa !26
  %172 = getelementptr inbounds [220 x double], ptr %7, i64 %159, i64 %162
  %173 = load double, ptr %172, align 8, !tbaa !5
  %174 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %171, ptr noundef nonnull @.str.5, double noundef %173) #7
  %175 = add nuw nsw i64 %162, 1
  %176 = icmp eq i64 %175, 220
  br i1 %176, label %177, label %161, !llvm.loop !28

177:                                              ; preds = %170
  %178 = add nuw nsw i64 %159, 1
  %179 = icmp eq i64 %178, 180
  br i1 %179, label %180, label %158, !llvm.loop !29

180:                                              ; preds = %177
  %181 = load ptr, ptr @stderr, align 8, !tbaa !26
  %182 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %181, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %183 = load ptr, ptr @stderr, align 8, !tbaa !26
  %184 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %183) #7
  br label %185

185:                                              ; preds = %180, %149, %147
  tail call void @free(ptr noundef %3) #6
  tail call void @free(ptr noundef %4) #6
  tail call void @free(ptr noundef %5) #6
  tail call void @free(ptr noundef %6) #6
  tail call void @free(ptr noundef nonnull %7) #6
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
!13 = distinct !{!13, !10}
!14 = distinct !{!14, !10, !11, !12}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10, !11, !12}
!17 = distinct !{!17, !10}
!18 = distinct !{!18, !10, !11, !12}
!19 = distinct !{!19, !10}
!20 = distinct !{!20, !10}
!21 = distinct !{!21, !10}
!22 = distinct !{!22, !10}
!23 = distinct !{!23, !10}
!24 = distinct !{!24, !10}
!25 = distinct !{!25, !10}
!26 = !{!27, !27, i64 0}
!27 = !{!"any pointer", !7, i64 0}
!28 = distinct !{!28, !10}
!29 = distinct !{!29, !10}
