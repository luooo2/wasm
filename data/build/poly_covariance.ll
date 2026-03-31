; ModuleID = 'data/polybench-c-4.2.1-beta/datamining/covariance/covariance.c'
source_filename = "data/polybench-c-4.2.1-beta/datamining/covariance/covariance.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"cov\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 62400, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 57600, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 240, i32 noundef 8) #6
  br label %6

6:                                                ; preds = %2, %34
  %7 = phi i64 [ 0, %2 ], [ %35, %34 ]
  %8 = trunc i64 %7 to i32
  %9 = sitofp i32 %8 to double
  %10 = insertelement <2 x double> poison, double %9, i64 0
  %11 = shufflevector <2 x double> %10, <2 x double> poison, <2 x i32> zeroinitializer
  br label %12

12:                                               ; preds = %12, %6
  %13 = phi i64 [ 0, %6 ], [ %31, %12 ]
  %14 = phi <2 x i32> [ <i32 0, i32 1>, %6 ], [ %32, %12 ]
  %15 = sitofp <2 x i32> %14 to <2 x double>
  %16 = fmul <2 x double> %11, %15
  %17 = fdiv <2 x double> %16, <double 2.400000e+02, double 2.400000e+02>
  %18 = getelementptr inbounds [240 x double], ptr %3, i64 %7, i64 %13
  store <2 x double> %17, ptr %18, align 8, !tbaa !5
  %19 = add nuw nsw i64 %13, 2
  %20 = add <2 x i32> %14, <i32 2, i32 2>
  %21 = sitofp <2 x i32> %20 to <2 x double>
  %22 = fmul <2 x double> %11, %21
  %23 = fdiv <2 x double> %22, <double 2.400000e+02, double 2.400000e+02>
  %24 = getelementptr inbounds [240 x double], ptr %3, i64 %7, i64 %19
  store <2 x double> %23, ptr %24, align 8, !tbaa !5
  %25 = add nuw nsw i64 %13, 4
  %26 = add <2 x i32> %14, <i32 4, i32 4>
  %27 = sitofp <2 x i32> %26 to <2 x double>
  %28 = fmul <2 x double> %11, %27
  %29 = fdiv <2 x double> %28, <double 2.400000e+02, double 2.400000e+02>
  %30 = getelementptr inbounds [240 x double], ptr %3, i64 %7, i64 %25
  store <2 x double> %29, ptr %30, align 8, !tbaa !5
  %31 = add nuw nsw i64 %13, 6
  %32 = add <2 x i32> %14, <i32 6, i32 6>
  %33 = icmp eq i64 %31, 240
  br i1 %33, label %34, label %12, !llvm.loop !9

34:                                               ; preds = %12
  %35 = add nuw nsw i64 %7, 1
  %36 = icmp eq i64 %35, 260
  br i1 %36, label %37, label %6, !llvm.loop !13

37:                                               ; preds = %34, %60
  %38 = phi i64 [ %62, %60 ], [ 0, %34 ]
  %39 = getelementptr inbounds double, ptr %5, i64 %38
  store double 0.000000e+00, ptr %39, align 8, !tbaa !5
  br label %40

40:                                               ; preds = %40, %37
  %41 = phi i64 [ 0, %37 ], [ %58, %40 ]
  %42 = phi double [ 0.000000e+00, %37 ], [ %57, %40 ]
  %43 = getelementptr inbounds [240 x double], ptr %3, i64 %41, i64 %38
  %44 = load double, ptr %43, align 8, !tbaa !5
  %45 = fadd double %42, %44
  store double %45, ptr %39, align 8, !tbaa !5
  %46 = or disjoint i64 %41, 1
  %47 = getelementptr inbounds [240 x double], ptr %3, i64 %46, i64 %38
  %48 = load double, ptr %47, align 8, !tbaa !5
  %49 = fadd double %45, %48
  store double %49, ptr %39, align 8, !tbaa !5
  %50 = or disjoint i64 %41, 2
  %51 = getelementptr inbounds [240 x double], ptr %3, i64 %50, i64 %38
  %52 = load double, ptr %51, align 8, !tbaa !5
  %53 = fadd double %49, %52
  store double %53, ptr %39, align 8, !tbaa !5
  %54 = or disjoint i64 %41, 3
  %55 = getelementptr inbounds [240 x double], ptr %3, i64 %54, i64 %38
  %56 = load double, ptr %55, align 8, !tbaa !5
  %57 = fadd double %53, %56
  store double %57, ptr %39, align 8, !tbaa !5
  %58 = add nuw nsw i64 %41, 4
  %59 = icmp eq i64 %58, 260
  br i1 %59, label %60, label %40, !llvm.loop !14

60:                                               ; preds = %40
  %61 = fdiv double %57, 2.600000e+02
  store double %61, ptr %39, align 8, !tbaa !5
  %62 = add nuw nsw i64 %38, 1
  %63 = icmp eq i64 %62, 240
  br i1 %63, label %64, label %37, !llvm.loop !15

64:                                               ; preds = %60
  %65 = getelementptr i8, ptr %3, i64 499200
  %66 = getelementptr i8, ptr %5, i64 1920
  %67 = icmp ult ptr %3, %66
  %68 = icmp ult ptr %5, %65
  %69 = and i1 %67, %68
  br label %70

70:                                               ; preds = %118, %64
  %71 = phi i64 [ %119, %118 ], [ 0, %64 ]
  br i1 %69, label %97, label %72

72:                                               ; preds = %70, %72
  %73 = phi i64 [ %95, %72 ], [ 0, %70 ]
  %74 = getelementptr inbounds double, ptr %5, i64 %73
  %75 = getelementptr inbounds double, ptr %74, i64 2
  %76 = load <2 x double>, ptr %74, align 8, !tbaa !5, !alias.scope !16
  %77 = load <2 x double>, ptr %75, align 8, !tbaa !5, !alias.scope !16
  %78 = getelementptr inbounds [240 x double], ptr %3, i64 %71, i64 %73
  %79 = getelementptr inbounds double, ptr %78, i64 2
  %80 = load <2 x double>, ptr %78, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  %81 = load <2 x double>, ptr %79, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  %82 = fsub <2 x double> %80, %76
  %83 = fsub <2 x double> %81, %77
  store <2 x double> %82, ptr %78, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  store <2 x double> %83, ptr %79, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  %84 = or disjoint i64 %73, 4
  %85 = getelementptr inbounds double, ptr %5, i64 %84
  %86 = getelementptr inbounds double, ptr %85, i64 2
  %87 = load <2 x double>, ptr %85, align 8, !tbaa !5, !alias.scope !16
  %88 = load <2 x double>, ptr %86, align 8, !tbaa !5, !alias.scope !16
  %89 = getelementptr inbounds [240 x double], ptr %3, i64 %71, i64 %84
  %90 = getelementptr inbounds double, ptr %89, i64 2
  %91 = load <2 x double>, ptr %89, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  %92 = load <2 x double>, ptr %90, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  %93 = fsub <2 x double> %91, %87
  %94 = fsub <2 x double> %92, %88
  store <2 x double> %93, ptr %89, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  store <2 x double> %94, ptr %90, align 8, !tbaa !5, !alias.scope !19, !noalias !16
  %95 = add nuw nsw i64 %73, 8
  %96 = icmp eq i64 %95, 240
  br i1 %96, label %118, label %72, !llvm.loop !21

97:                                               ; preds = %70, %97
  %98 = phi i64 [ %116, %97 ], [ 0, %70 ]
  %99 = getelementptr inbounds double, ptr %5, i64 %98
  %100 = load double, ptr %99, align 8, !tbaa !5
  %101 = getelementptr inbounds [240 x double], ptr %3, i64 %71, i64 %98
  %102 = load double, ptr %101, align 8, !tbaa !5
  %103 = fsub double %102, %100
  store double %103, ptr %101, align 8, !tbaa !5
  %104 = add nuw nsw i64 %98, 1
  %105 = getelementptr inbounds double, ptr %5, i64 %104
  %106 = load double, ptr %105, align 8, !tbaa !5
  %107 = getelementptr inbounds [240 x double], ptr %3, i64 %71, i64 %104
  %108 = load double, ptr %107, align 8, !tbaa !5
  %109 = fsub double %108, %106
  store double %109, ptr %107, align 8, !tbaa !5
  %110 = add nuw nsw i64 %98, 2
  %111 = getelementptr inbounds double, ptr %5, i64 %110
  %112 = load double, ptr %111, align 8, !tbaa !5
  %113 = getelementptr inbounds [240 x double], ptr %3, i64 %71, i64 %110
  %114 = load double, ptr %113, align 8, !tbaa !5
  %115 = fsub double %114, %112
  store double %115, ptr %113, align 8, !tbaa !5
  %116 = add nuw nsw i64 %98, 3
  %117 = icmp eq i64 %116, 240
  br i1 %117, label %118, label %97, !llvm.loop !22

118:                                              ; preds = %72, %97
  %119 = add nuw nsw i64 %71, 1
  %120 = icmp eq i64 %119, 260
  br i1 %120, label %121, label %70, !llvm.loop !23

121:                                              ; preds = %118, %147
  %122 = phi i64 [ %148, %147 ], [ 0, %118 ]
  br label %123

123:                                              ; preds = %142, %121
  %124 = phi i64 [ %122, %121 ], [ %145, %142 ]
  %125 = getelementptr inbounds [240 x double], ptr %4, i64 %122, i64 %124
  store double 0.000000e+00, ptr %125, align 8, !tbaa !5
  br label %126

126:                                              ; preds = %126, %123
  %127 = phi i64 [ 0, %123 ], [ %140, %126 ]
  %128 = phi double [ 0.000000e+00, %123 ], [ %139, %126 ]
  %129 = getelementptr inbounds [240 x double], ptr %3, i64 %127, i64 %122
  %130 = load double, ptr %129, align 8, !tbaa !5
  %131 = getelementptr inbounds [240 x double], ptr %3, i64 %127, i64 %124
  %132 = load double, ptr %131, align 8, !tbaa !5
  %133 = tail call double @llvm.fmuladd.f64(double %130, double %132, double %128)
  store double %133, ptr %125, align 8, !tbaa !5
  %134 = or disjoint i64 %127, 1
  %135 = getelementptr inbounds [240 x double], ptr %3, i64 %134, i64 %122
  %136 = load double, ptr %135, align 8, !tbaa !5
  %137 = getelementptr inbounds [240 x double], ptr %3, i64 %134, i64 %124
  %138 = load double, ptr %137, align 8, !tbaa !5
  %139 = tail call double @llvm.fmuladd.f64(double %136, double %138, double %133)
  store double %139, ptr %125, align 8, !tbaa !5
  %140 = add nuw nsw i64 %127, 2
  %141 = icmp eq i64 %140, 260
  br i1 %141, label %142, label %126, !llvm.loop !24

142:                                              ; preds = %126
  %143 = fdiv double %139, 2.590000e+02
  store double %143, ptr %125, align 8, !tbaa !5
  %144 = getelementptr inbounds [240 x double], ptr %4, i64 %124, i64 %122
  store double %143, ptr %144, align 8, !tbaa !5
  %145 = add nuw nsw i64 %124, 1
  %146 = icmp eq i64 %145, 240
  br i1 %146, label %147, label %123, !llvm.loop !25

147:                                              ; preds = %142
  %148 = add nuw nsw i64 %122, 1
  %149 = icmp eq i64 %148, 240
  br i1 %149, label %150, label %121, !llvm.loop !26

150:                                              ; preds = %147
  %151 = icmp sgt i32 %0, 42
  br i1 %151, label %152, label %188

152:                                              ; preds = %150
  %153 = load ptr, ptr %1, align 8, !tbaa !27
  %154 = load i8, ptr %153, align 1
  %155 = icmp eq i8 %154, 0
  br i1 %155, label %156, label %188

156:                                              ; preds = %152
  %157 = load ptr, ptr @stderr, align 8, !tbaa !27
  %158 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %157) #7
  %159 = load ptr, ptr @stderr, align 8, !tbaa !27
  %160 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %159, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %161

161:                                              ; preds = %180, %156
  %162 = phi i64 [ 0, %156 ], [ %181, %180 ]
  %163 = mul nuw nsw i64 %162, 240
  br label %164

164:                                              ; preds = %173, %161
  %165 = phi i64 [ 0, %161 ], [ %178, %173 ]
  %166 = add nuw nsw i64 %165, %163
  %167 = trunc i64 %166 to i32
  %168 = urem i32 %167, 20
  %169 = icmp eq i32 %168, 0
  br i1 %169, label %170, label %173

170:                                              ; preds = %164
  %171 = load ptr, ptr @stderr, align 8, !tbaa !27
  %172 = tail call i32 @fputc(i32 10, ptr %171)
  br label %173

173:                                              ; preds = %170, %164
  %174 = load ptr, ptr @stderr, align 8, !tbaa !27
  %175 = getelementptr inbounds [240 x double], ptr %4, i64 %162, i64 %165
  %176 = load double, ptr %175, align 8, !tbaa !5
  %177 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %174, ptr noundef nonnull @.str.5, double noundef %176) #7
  %178 = add nuw nsw i64 %165, 1
  %179 = icmp eq i64 %178, 240
  br i1 %179, label %180, label %164, !llvm.loop !29

180:                                              ; preds = %173
  %181 = add nuw nsw i64 %162, 1
  %182 = icmp eq i64 %181, 240
  br i1 %182, label %183, label %161, !llvm.loop !30

183:                                              ; preds = %180
  %184 = load ptr, ptr @stderr, align 8, !tbaa !27
  %185 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %184, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %186 = load ptr, ptr @stderr, align 8, !tbaa !27
  %187 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %186) #7
  br label %188

188:                                              ; preds = %183, %152, %150
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
!13 = distinct !{!13, !10}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = !{!17}
!17 = distinct !{!17, !18}
!18 = distinct !{!18, !"LVerDomain"}
!19 = !{!20}
!20 = distinct !{!20, !18}
!21 = distinct !{!21, !10, !11, !12}
!22 = distinct !{!22, !10, !11}
!23 = distinct !{!23, !10}
!24 = distinct !{!24, !10}
!25 = distinct !{!25, !10}
!26 = distinct !{!26, !10}
!27 = !{!28, !28, i64 0}
!28 = !{!"any pointer", !7, i64 0}
!29 = distinct !{!29, !10}
!30 = distinct !{!30, !10}
