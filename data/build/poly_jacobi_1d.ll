; ModuleID = 'data/polybench-c-4.2.1-beta/stencils/jacobi-1d/jacobi-1d.c'
source_filename = "data/polybench-c-4.2.1-beta/stencils/jacobi-1d/jacobi-1d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #5
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 400, i32 noundef 8) #5
  %5 = ptrtoint ptr %4 to i64
  %6 = ptrtoint ptr %3 to i64
  %7 = sub i64 %5, %6
  %8 = icmp ult i64 %7, 16
  br i1 %8, label %31, label %9

9:                                                ; preds = %2, %9
  %10 = phi i64 [ %28, %9 ], [ 0, %2 ]
  %11 = phi <2 x i32> [ %29, %9 ], [ <i32 0, i32 1>, %2 ]
  %12 = sitofp <2 x i32> %11 to <2 x double>
  %13 = fadd <2 x double> %12, <double 2.000000e+00, double 2.000000e+00>
  %14 = fdiv <2 x double> %13, <double 4.000000e+02, double 4.000000e+02>
  %15 = getelementptr inbounds double, ptr %3, i64 %10
  store <2 x double> %14, ptr %15, align 8, !tbaa !5
  %16 = fadd <2 x double> %12, <double 3.000000e+00, double 3.000000e+00>
  %17 = fdiv <2 x double> %16, <double 4.000000e+02, double 4.000000e+02>
  %18 = getelementptr inbounds double, ptr %4, i64 %10
  store <2 x double> %17, ptr %18, align 8, !tbaa !5
  %19 = or disjoint i64 %10, 2
  %20 = add <2 x i32> %11, <i32 2, i32 2>
  %21 = sitofp <2 x i32> %20 to <2 x double>
  %22 = fadd <2 x double> %21, <double 2.000000e+00, double 2.000000e+00>
  %23 = fdiv <2 x double> %22, <double 4.000000e+02, double 4.000000e+02>
  %24 = getelementptr inbounds double, ptr %3, i64 %19
  store <2 x double> %23, ptr %24, align 8, !tbaa !5
  %25 = fadd <2 x double> %21, <double 3.000000e+00, double 3.000000e+00>
  %26 = fdiv <2 x double> %25, <double 4.000000e+02, double 4.000000e+02>
  %27 = getelementptr inbounds double, ptr %4, i64 %19
  store <2 x double> %26, ptr %27, align 8, !tbaa !5
  %28 = add nuw nsw i64 %10, 4
  %29 = add <2 x i32> %11, <i32 4, i32 4>
  %30 = icmp eq i64 %28, 400
  br i1 %30, label %52, label %9, !llvm.loop !9

31:                                               ; preds = %2, %31
  %32 = phi i64 [ %50, %31 ], [ 0, %2 ]
  %33 = trunc i64 %32 to i32
  %34 = sitofp i32 %33 to double
  %35 = fadd double %34, 2.000000e+00
  %36 = fdiv double %35, 4.000000e+02
  %37 = getelementptr inbounds double, ptr %3, i64 %32
  store double %36, ptr %37, align 8, !tbaa !5
  %38 = fadd double %34, 3.000000e+00
  %39 = fdiv double %38, 4.000000e+02
  %40 = getelementptr inbounds double, ptr %4, i64 %32
  store double %39, ptr %40, align 8, !tbaa !5
  %41 = or disjoint i64 %32, 1
  %42 = trunc i64 %41 to i32
  %43 = sitofp i32 %42 to double
  %44 = fadd double %43, 2.000000e+00
  %45 = fdiv double %44, 4.000000e+02
  %46 = getelementptr inbounds double, ptr %3, i64 %41
  store double %45, ptr %46, align 8, !tbaa !5
  %47 = fadd double %43, 3.000000e+00
  %48 = fdiv double %47, 4.000000e+02
  %49 = getelementptr inbounds double, ptr %4, i64 %41
  store double %48, ptr %49, align 8, !tbaa !5
  %50 = add nuw nsw i64 %32, 2
  %51 = icmp eq i64 %50, 400
  br i1 %51, label %52, label %31, !llvm.loop !13

52:                                               ; preds = %9, %31
  %53 = getelementptr i8, ptr %3, i64 8
  %54 = getelementptr i8, ptr %3, i64 3192
  %55 = getelementptr i8, ptr %4, i64 3200
  %56 = getelementptr i8, ptr %4, i64 8
  %57 = getelementptr i8, ptr %4, i64 3192
  %58 = getelementptr i8, ptr %3, i64 3200
  %59 = icmp ult ptr %56, %58
  %60 = icmp ult ptr %3, %57
  %61 = and i1 %59, %60
  %62 = icmp ult ptr %53, %55
  %63 = icmp ult ptr %4, %54
  %64 = and i1 %62, %63
  br label %65

65:                                               ; preds = %174, %52
  %66 = phi i32 [ %175, %174 ], [ 0, %52 ]
  br i1 %61, label %93, label %67

67:                                               ; preds = %65, %67
  %68 = phi i64 [ %91, %67 ], [ 0, %65 ]
  %69 = or disjoint i64 %68, 1
  %70 = getelementptr double, ptr %3, i64 %69
  %71 = getelementptr double, ptr %70, i64 -1
  %72 = getelementptr double, ptr %70, i64 1
  %73 = load <2 x double>, ptr %71, align 8, !tbaa !5, !alias.scope !14
  %74 = load <2 x double>, ptr %72, align 8, !tbaa !5, !alias.scope !14
  %75 = getelementptr double, ptr %70, i64 2
  %76 = load <2 x double>, ptr %70, align 8, !tbaa !5, !alias.scope !14
  %77 = load <2 x double>, ptr %75, align 8, !tbaa !5, !alias.scope !14
  %78 = fadd <2 x double> %73, %76
  %79 = fadd <2 x double> %74, %77
  %80 = or disjoint i64 %68, 2
  %81 = getelementptr inbounds double, ptr %3, i64 %80
  %82 = getelementptr inbounds double, ptr %81, i64 2
  %83 = load <2 x double>, ptr %81, align 8, !tbaa !5, !alias.scope !14
  %84 = load <2 x double>, ptr %82, align 8, !tbaa !5, !alias.scope !14
  %85 = fadd <2 x double> %78, %83
  %86 = fadd <2 x double> %79, %84
  %87 = fmul <2 x double> %85, <double 3.333300e-01, double 3.333300e-01>
  %88 = fmul <2 x double> %86, <double 3.333300e-01, double 3.333300e-01>
  %89 = getelementptr inbounds double, ptr %4, i64 %69
  %90 = getelementptr inbounds double, ptr %89, i64 2
  store <2 x double> %87, ptr %89, align 8, !tbaa !5, !alias.scope !17, !noalias !14
  store <2 x double> %88, ptr %90, align 8, !tbaa !5, !alias.scope !17, !noalias !14
  %91 = add nuw i64 %68, 4
  %92 = icmp eq i64 %91, 396
  br i1 %92, label %93, label %67, !llvm.loop !19

93:                                               ; preds = %67, %65
  %94 = phi i64 [ 1, %65 ], [ 397, %67 ]
  br label %95

95:                                               ; preds = %95, %93
  %96 = phi i64 [ %94, %93 ], [ %113, %95 ]
  %97 = getelementptr double, ptr %3, i64 %96
  %98 = getelementptr double, ptr %97, i64 -1
  %99 = load double, ptr %98, align 8, !tbaa !5
  %100 = load double, ptr %97, align 8, !tbaa !5
  %101 = fadd double %99, %100
  %102 = add nuw nsw i64 %96, 1
  %103 = getelementptr inbounds double, ptr %3, i64 %102
  %104 = load double, ptr %103, align 8, !tbaa !5
  %105 = fadd double %101, %104
  %106 = fmul double %105, 3.333300e-01
  %107 = getelementptr inbounds double, ptr %4, i64 %96
  store double %106, ptr %107, align 8, !tbaa !5
  %108 = getelementptr double, ptr %3, i64 %102
  %109 = getelementptr double, ptr %3, i64 %96
  %110 = load double, ptr %109, align 8, !tbaa !5
  %111 = load double, ptr %108, align 8, !tbaa !5
  %112 = fadd double %110, %111
  %113 = add nuw nsw i64 %96, 2
  %114 = getelementptr inbounds double, ptr %3, i64 %113
  %115 = load double, ptr %114, align 8, !tbaa !5
  %116 = fadd double %112, %115
  %117 = fmul double %116, 3.333300e-01
  %118 = getelementptr inbounds double, ptr %4, i64 %102
  store double %117, ptr %118, align 8, !tbaa !5
  %119 = icmp eq i64 %113, 399
  br i1 %119, label %120, label %95, !llvm.loop !20

120:                                              ; preds = %95
  br i1 %64, label %147, label %121

121:                                              ; preds = %120, %121
  %122 = phi i64 [ %145, %121 ], [ 0, %120 ]
  %123 = or disjoint i64 %122, 1
  %124 = getelementptr double, ptr %4, i64 %123
  %125 = getelementptr double, ptr %124, i64 -1
  %126 = getelementptr double, ptr %124, i64 1
  %127 = load <2 x double>, ptr %125, align 8, !tbaa !5, !alias.scope !21
  %128 = load <2 x double>, ptr %126, align 8, !tbaa !5, !alias.scope !21
  %129 = getelementptr double, ptr %124, i64 2
  %130 = load <2 x double>, ptr %124, align 8, !tbaa !5, !alias.scope !21
  %131 = load <2 x double>, ptr %129, align 8, !tbaa !5, !alias.scope !21
  %132 = fadd <2 x double> %127, %130
  %133 = fadd <2 x double> %128, %131
  %134 = or disjoint i64 %122, 2
  %135 = getelementptr inbounds double, ptr %4, i64 %134
  %136 = getelementptr inbounds double, ptr %135, i64 2
  %137 = load <2 x double>, ptr %135, align 8, !tbaa !5, !alias.scope !21
  %138 = load <2 x double>, ptr %136, align 8, !tbaa !5, !alias.scope !21
  %139 = fadd <2 x double> %132, %137
  %140 = fadd <2 x double> %133, %138
  %141 = fmul <2 x double> %139, <double 3.333300e-01, double 3.333300e-01>
  %142 = fmul <2 x double> %140, <double 3.333300e-01, double 3.333300e-01>
  %143 = getelementptr inbounds double, ptr %3, i64 %123
  %144 = getelementptr inbounds double, ptr %143, i64 2
  store <2 x double> %141, ptr %143, align 8, !tbaa !5, !alias.scope !24, !noalias !21
  store <2 x double> %142, ptr %144, align 8, !tbaa !5, !alias.scope !24, !noalias !21
  %145 = add nuw i64 %122, 4
  %146 = icmp eq i64 %145, 396
  br i1 %146, label %147, label %121, !llvm.loop !26

147:                                              ; preds = %121, %120
  %148 = phi i64 [ 1, %120 ], [ 397, %121 ]
  br label %149

149:                                              ; preds = %149, %147
  %150 = phi i64 [ %148, %147 ], [ %167, %149 ]
  %151 = getelementptr double, ptr %4, i64 %150
  %152 = getelementptr double, ptr %151, i64 -1
  %153 = load double, ptr %152, align 8, !tbaa !5
  %154 = load double, ptr %151, align 8, !tbaa !5
  %155 = fadd double %153, %154
  %156 = add nuw nsw i64 %150, 1
  %157 = getelementptr inbounds double, ptr %4, i64 %156
  %158 = load double, ptr %157, align 8, !tbaa !5
  %159 = fadd double %155, %158
  %160 = fmul double %159, 3.333300e-01
  %161 = getelementptr inbounds double, ptr %3, i64 %150
  store double %160, ptr %161, align 8, !tbaa !5
  %162 = getelementptr double, ptr %4, i64 %156
  %163 = getelementptr double, ptr %4, i64 %150
  %164 = load double, ptr %163, align 8, !tbaa !5
  %165 = load double, ptr %162, align 8, !tbaa !5
  %166 = fadd double %164, %165
  %167 = add nuw nsw i64 %150, 2
  %168 = getelementptr inbounds double, ptr %4, i64 %167
  %169 = load double, ptr %168, align 8, !tbaa !5
  %170 = fadd double %166, %169
  %171 = fmul double %170, 3.333300e-01
  %172 = getelementptr inbounds double, ptr %3, i64 %156
  store double %171, ptr %172, align 8, !tbaa !5
  %173 = icmp eq i64 %167, 399
  br i1 %173, label %174, label %149, !llvm.loop !27

174:                                              ; preds = %149
  %175 = add nuw nsw i32 %66, 1
  %176 = icmp eq i32 %175, 100
  br i1 %176, label %177, label %65, !llvm.loop !28

177:                                              ; preds = %174
  %178 = icmp sgt i32 %0, 42
  br i1 %178, label %179, label %208

179:                                              ; preds = %177
  %180 = load ptr, ptr %1, align 8, !tbaa !29
  %181 = load i8, ptr %180, align 1
  %182 = icmp eq i8 %181, 0
  br i1 %182, label %183, label %208

183:                                              ; preds = %179
  %184 = load ptr, ptr @stderr, align 8, !tbaa !29
  %185 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %184) #6
  %186 = load ptr, ptr @stderr, align 8, !tbaa !29
  %187 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %186, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %188

188:                                              ; preds = %196, %183
  %189 = phi i64 [ 0, %183 ], [ %201, %196 ]
  %190 = trunc i64 %189 to i16
  %191 = urem i16 %190, 20
  %192 = icmp eq i16 %191, 0
  br i1 %192, label %193, label %196

193:                                              ; preds = %188
  %194 = load ptr, ptr @stderr, align 8, !tbaa !29
  %195 = tail call i32 @fputc(i32 10, ptr %194)
  br label %196

196:                                              ; preds = %193, %188
  %197 = load ptr, ptr @stderr, align 8, !tbaa !29
  %198 = getelementptr inbounds double, ptr %3, i64 %189
  %199 = load double, ptr %198, align 8, !tbaa !5
  %200 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %197, ptr noundef nonnull @.str.5, double noundef %199) #6
  %201 = add nuw nsw i64 %189, 1
  %202 = icmp eq i64 %201, 400
  br i1 %202, label %203, label %188, !llvm.loop !31

203:                                              ; preds = %196
  %204 = load ptr, ptr @stderr, align 8, !tbaa !29
  %205 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %204, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %206 = load ptr, ptr @stderr, align 8, !tbaa !29
  %207 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %206) #6
  br label %208

208:                                              ; preds = %203, %179, %177
  tail call void @free(ptr noundef nonnull %3) #5
  tail call void @free(ptr noundef %4) #5
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind }
attributes #5 = { nounwind }
attributes #6 = { cold }

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
!14 = !{!15}
!15 = distinct !{!15, !16}
!16 = distinct !{!16, !"LVerDomain"}
!17 = !{!18}
!18 = distinct !{!18, !16}
!19 = distinct !{!19, !10, !11, !12}
!20 = distinct !{!20, !10, !11}
!21 = !{!22}
!22 = distinct !{!22, !23}
!23 = distinct !{!23, !"LVerDomain"}
!24 = !{!25}
!25 = distinct !{!25, !23}
!26 = distinct !{!26, !10, !11, !12}
!27 = distinct !{!27, !10, !11}
!28 = distinct !{!28, !10}
!29 = !{!30, !30, i64 0}
!30 = !{!"any pointer", !7, i64 0}
!31 = distinct !{!31, !10}
