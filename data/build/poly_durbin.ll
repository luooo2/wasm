; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/solvers/durbin/durbin.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/solvers/durbin/durbin.c"
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
  %3 = alloca [400 x double], align 16
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #9
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #9
  br label %6

6:                                                ; preds = %6, %2
  %7 = phi i64 [ 0, %2 ], [ %22, %6 ]
  %8 = phi <2 x i32> [ <i32 0, i32 1>, %2 ], [ %23, %6 ]
  %9 = sub <2 x i32> <i32 401, i32 401>, %8
  %10 = sub <2 x i32> <i32 399, i32 399>, %8
  %11 = sitofp <2 x i32> %9 to <2 x double>
  %12 = sitofp <2 x i32> %10 to <2 x double>
  %13 = getelementptr inbounds double, ptr %4, i64 %7
  %14 = getelementptr inbounds double, ptr %13, i64 2
  store <2 x double> %11, ptr %13, align 8, !tbaa !5
  store <2 x double> %12, ptr %14, align 8, !tbaa !5
  %15 = or disjoint i64 %7, 4
  %16 = sub <2 x i32> <i32 397, i32 397>, %8
  %17 = sub <2 x i32> <i32 395, i32 395>, %8
  %18 = sitofp <2 x i32> %16 to <2 x double>
  %19 = sitofp <2 x i32> %17 to <2 x double>
  %20 = getelementptr inbounds double, ptr %4, i64 %15
  %21 = getelementptr inbounds double, ptr %20, i64 2
  store <2 x double> %18, ptr %20, align 8, !tbaa !5
  store <2 x double> %19, ptr %21, align 8, !tbaa !5
  %22 = add nuw nsw i64 %7, 8
  %23 = add <2 x i32> %8, <i32 8, i32 8>
  %24 = icmp eq i64 %22, 400
  br i1 %24, label %25, label %6, !llvm.loop !9

25:                                               ; preds = %6
  call void @llvm.lifetime.start.p0(i64 3200, ptr nonnull %3) #9
  %26 = load double, ptr %4, align 8, !tbaa !5
  %27 = fneg double %26
  store double %27, ptr %5, align 8, !tbaa !5
  %28 = load double, ptr %4, align 8, !tbaa !5
  %29 = fneg double %28
  br label %30

30:                                               ; preds = %143, %25
  %31 = phi i64 [ 1, %25 ], [ %145, %143 ]
  %32 = phi i64 [ 0, %25 ], [ %146, %143 ]
  %33 = phi double [ 1.000000e+00, %25 ], [ %97, %143 ]
  %34 = phi double [ %29, %25 ], [ %101, %143 ]
  %35 = shl nuw nsw i64 %32, 3
  %36 = fneg double %34
  %37 = getelementptr double, ptr %4, i64 %31
  %38 = and i64 %31, 3
  %39 = icmp ult i64 %32, 3
  br i1 %39, label %76, label %40

40:                                               ; preds = %30
  %41 = and i64 %31, 9223372036854775804
  br label %42

42:                                               ; preds = %42, %40
  %43 = phi i64 [ 0, %40 ], [ %73, %42 ]
  %44 = phi double [ 0.000000e+00, %40 ], [ %72, %42 ]
  %45 = phi i64 [ 0, %40 ], [ %74, %42 ]
  %46 = xor i64 %43, -1
  %47 = getelementptr double, ptr %37, i64 %46
  %48 = load double, ptr %47, align 8, !tbaa !5
  %49 = getelementptr inbounds double, ptr %5, i64 %43
  %50 = load double, ptr %49, align 8, !tbaa !5
  %51 = tail call double @llvm.fmuladd.f64(double %48, double %50, double %44)
  %52 = or disjoint i64 %43, 1
  %53 = xor i64 %43, -2
  %54 = getelementptr double, ptr %37, i64 %53
  %55 = load double, ptr %54, align 8, !tbaa !5
  %56 = getelementptr inbounds double, ptr %5, i64 %52
  %57 = load double, ptr %56, align 8, !tbaa !5
  %58 = tail call double @llvm.fmuladd.f64(double %55, double %57, double %51)
  %59 = or disjoint i64 %43, 2
  %60 = xor i64 %43, -3
  %61 = getelementptr double, ptr %37, i64 %60
  %62 = load double, ptr %61, align 8, !tbaa !5
  %63 = getelementptr inbounds double, ptr %5, i64 %59
  %64 = load double, ptr %63, align 8, !tbaa !5
  %65 = tail call double @llvm.fmuladd.f64(double %62, double %64, double %58)
  %66 = or disjoint i64 %43, 3
  %67 = xor i64 %43, -4
  %68 = getelementptr double, ptr %37, i64 %67
  %69 = load double, ptr %68, align 8, !tbaa !5
  %70 = getelementptr inbounds double, ptr %5, i64 %66
  %71 = load double, ptr %70, align 8, !tbaa !5
  %72 = tail call double @llvm.fmuladd.f64(double %69, double %71, double %65)
  %73 = add nuw nsw i64 %43, 4
  %74 = add i64 %45, 4
  %75 = icmp eq i64 %74, %41
  br i1 %75, label %76, label %42, !llvm.loop !13

76:                                               ; preds = %42, %30
  %77 = phi double [ undef, %30 ], [ %72, %42 ]
  %78 = phi i64 [ 0, %30 ], [ %73, %42 ]
  %79 = phi double [ 0.000000e+00, %30 ], [ %72, %42 ]
  %80 = icmp eq i64 %38, 0
  br i1 %80, label %94, label %81

81:                                               ; preds = %76, %81
  %82 = phi i64 [ %91, %81 ], [ %78, %76 ]
  %83 = phi double [ %90, %81 ], [ %79, %76 ]
  %84 = phi i64 [ %92, %81 ], [ 0, %76 ]
  %85 = xor i64 %82, -1
  %86 = getelementptr double, ptr %37, i64 %85
  %87 = load double, ptr %86, align 8, !tbaa !5
  %88 = getelementptr inbounds double, ptr %5, i64 %82
  %89 = load double, ptr %88, align 8, !tbaa !5
  %90 = tail call double @llvm.fmuladd.f64(double %87, double %89, double %83)
  %91 = add nuw nsw i64 %82, 1
  %92 = add i64 %84, 1
  %93 = icmp eq i64 %92, %38
  br i1 %93, label %94, label %81, !llvm.loop !14

94:                                               ; preds = %81, %76
  %95 = phi double [ %77, %76 ], [ %90, %81 ]
  %96 = tail call double @llvm.fmuladd.f64(double %36, double %34, double 1.000000e+00)
  %97 = fmul double %33, %96
  %98 = load double, ptr %37, align 8, !tbaa !5
  %99 = fadd double %95, %98
  %100 = fneg double %99
  %101 = fdiv double %100, %97
  %102 = getelementptr double, ptr %5, i64 %31
  %103 = icmp ult i64 %31, 4
  br i1 %103, label %130, label %104

104:                                              ; preds = %94
  %105 = and i64 %31, 9223372036854775804
  %106 = insertelement <2 x double> poison, double %101, i64 0
  %107 = shufflevector <2 x double> %106, <2 x double> poison, <2 x i32> zeroinitializer
  br label %108

108:                                              ; preds = %108, %104
  %109 = phi i64 [ 0, %104 ], [ %126, %108 ]
  %110 = getelementptr inbounds double, ptr %5, i64 %109
  %111 = getelementptr inbounds double, ptr %110, i64 2
  %112 = load <2 x double>, ptr %110, align 8, !tbaa !5
  %113 = load <2 x double>, ptr %111, align 8, !tbaa !5
  %114 = xor i64 %109, -1
  %115 = getelementptr double, ptr %102, i64 %114
  %116 = getelementptr double, ptr %115, i64 -1
  %117 = getelementptr double, ptr %115, i64 -3
  %118 = load <2 x double>, ptr %116, align 8, !tbaa !5
  %119 = shufflevector <2 x double> %118, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %120 = load <2 x double>, ptr %117, align 8, !tbaa !5
  %121 = shufflevector <2 x double> %120, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %122 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %107, <2 x double> %119, <2 x double> %112)
  %123 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %107, <2 x double> %121, <2 x double> %113)
  %124 = getelementptr inbounds [400 x double], ptr %3, i64 0, i64 %109
  %125 = getelementptr inbounds double, ptr %124, i64 2
  store <2 x double> %122, ptr %124, align 16, !tbaa !5
  store <2 x double> %123, ptr %125, align 16, !tbaa !5
  %126 = add nuw i64 %109, 4
  %127 = icmp eq i64 %126, %105
  br i1 %127, label %128, label %108, !llvm.loop !16

128:                                              ; preds = %108
  %129 = icmp eq i64 %31, %105
  br i1 %129, label %143, label %130

130:                                              ; preds = %94, %128
  %131 = phi i64 [ 0, %94 ], [ %105, %128 ]
  br label %132

132:                                              ; preds = %130, %132
  %133 = phi i64 [ %141, %132 ], [ %131, %130 ]
  %134 = getelementptr inbounds double, ptr %5, i64 %133
  %135 = load double, ptr %134, align 8, !tbaa !5
  %136 = xor i64 %133, -1
  %137 = getelementptr double, ptr %102, i64 %136
  %138 = load double, ptr %137, align 8, !tbaa !5
  %139 = tail call double @llvm.fmuladd.f64(double %101, double %138, double %135)
  %140 = getelementptr inbounds [400 x double], ptr %3, i64 0, i64 %133
  store double %139, ptr %140, align 8, !tbaa !5
  %141 = add nuw nsw i64 %133, 1
  %142 = icmp eq i64 %141, %31
  br i1 %142, label %143, label %132, !llvm.loop !17

143:                                              ; preds = %132, %128
  %144 = add nuw nsw i64 %35, 8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(1) %5, ptr noundef nonnull align 16 dereferenceable(1) %3, i64 %144, i1 false), !tbaa !5
  store double %101, ptr %102, align 8, !tbaa !5
  %145 = add nuw nsw i64 %31, 1
  %146 = add nuw nsw i64 %32, 1
  %147 = icmp eq i64 %146, 399
  br i1 %147, label %148, label %30, !llvm.loop !18

148:                                              ; preds = %143
  call void @llvm.lifetime.end.p0(i64 3200, ptr nonnull %3) #9
  %149 = icmp sgt i32 %0, 42
  br i1 %149, label %150, label %179

150:                                              ; preds = %148
  %151 = load ptr, ptr %1, align 8, !tbaa !19
  %152 = load i8, ptr %151, align 1
  %153 = icmp eq i8 %152, 0
  br i1 %153, label %154, label %179

154:                                              ; preds = %150
  %155 = load ptr, ptr @stderr, align 8, !tbaa !19
  %156 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %155) #10
  %157 = load ptr, ptr @stderr, align 8, !tbaa !19
  %158 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %157, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #10
  br label %159

159:                                              ; preds = %167, %154
  %160 = phi i64 [ 0, %154 ], [ %172, %167 ]
  %161 = trunc i64 %160 to i16
  %162 = urem i16 %161, 20
  %163 = icmp eq i16 %162, 0
  br i1 %163, label %164, label %167

164:                                              ; preds = %159
  %165 = load ptr, ptr @stderr, align 8, !tbaa !19
  %166 = tail call i32 @fputc(i32 10, ptr %165)
  br label %167

167:                                              ; preds = %164, %159
  %168 = load ptr, ptr @stderr, align 8, !tbaa !19
  %169 = getelementptr inbounds double, ptr %5, i64 %160
  %170 = load double, ptr %169, align 8, !tbaa !5
  %171 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %168, ptr noundef nonnull @.str.5, double noundef %170) #10
  %172 = add nuw nsw i64 %160, 1
  %173 = icmp eq i64 %172, 400
  br i1 %173, label %174, label %159, !llvm.loop !21

174:                                              ; preds = %167
  %175 = load ptr, ptr @stderr, align 8, !tbaa !19
  %176 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %175, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #10
  %177 = load ptr, ptr @stderr, align 8, !tbaa !19
  %178 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %177) #10
  br label %179

179:                                              ; preds = %174, %150, %148
  tail call void @free(ptr noundef %4) #9
  tail call void @free(ptr noundef nonnull %5) #9
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #4

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #8

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nounwind }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind }
attributes #10 = { cold }

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
!14 = distinct !{!14, !15}
!15 = !{!"llvm.loop.unroll.disable"}
!16 = distinct !{!16, !10, !11, !12}
!17 = distinct !{!17, !10, !12, !11}
!18 = distinct !{!18, !10}
!19 = !{!20, !20, i64 0}
!20 = !{!"any pointer", !7, i64 0}
!21 = distinct !{!21, !10}
