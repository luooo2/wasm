; ModuleID = 'data/polybench-c-4.2.1-beta/datamining/correlation/correlation.c'
source_filename = "data/polybench-c-4.2.1-beta/datamining/correlation/correlation.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"corr\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 62400, i32 noundef 8) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 57600, i32 noundef 8) #7
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 240, i32 noundef 8) #7
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 240, i32 noundef 8) #7
  br label %7

7:                                                ; preds = %2, %27
  %8 = phi i64 [ 0, %2 ], [ %28, %27 ]
  %9 = trunc i64 %8 to i32
  %10 = sitofp i32 %9 to double
  %11 = insertelement <2 x i64> poison, i64 %8, i64 0
  %12 = shufflevector <2 x i64> %11, <2 x i64> poison, <2 x i32> zeroinitializer
  %13 = insertelement <2 x double> poison, double %10, i64 0
  %14 = shufflevector <2 x double> %13, <2 x double> poison, <2 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %7
  %16 = phi i64 [ 0, %7 ], [ %24, %15 ]
  %17 = phi <2 x i64> [ <i64 0, i64 1>, %7 ], [ %25, %15 ]
  %18 = mul nuw nsw <2 x i64> %17, %12
  %19 = trunc <2 x i64> %18 to <2 x i32>
  %20 = sitofp <2 x i32> %19 to <2 x double>
  %21 = fdiv <2 x double> %20, <double 2.400000e+02, double 2.400000e+02>
  %22 = fadd <2 x double> %21, %14
  %23 = getelementptr inbounds [240 x double], ptr %3, i64 %8, i64 %16
  store <2 x double> %22, ptr %23, align 8, !tbaa !5
  %24 = add nuw i64 %16, 2
  %25 = add <2 x i64> %17, <i64 2, i64 2>
  %26 = icmp eq i64 %24, 240
  br i1 %26, label %27, label %15, !llvm.loop !9

27:                                               ; preds = %15
  %28 = add nuw nsw i64 %8, 1
  %29 = icmp eq i64 %28, 260
  br i1 %29, label %30, label %7, !llvm.loop !13

30:                                               ; preds = %27, %53
  %31 = phi i64 [ %55, %53 ], [ 0, %27 ]
  %32 = getelementptr inbounds double, ptr %5, i64 %31
  store double 0.000000e+00, ptr %32, align 8, !tbaa !5
  br label %33

33:                                               ; preds = %33, %30
  %34 = phi i64 [ 0, %30 ], [ %51, %33 ]
  %35 = phi double [ 0.000000e+00, %30 ], [ %50, %33 ]
  %36 = getelementptr inbounds [240 x double], ptr %3, i64 %34, i64 %31
  %37 = load double, ptr %36, align 8, !tbaa !5
  %38 = fadd double %35, %37
  store double %38, ptr %32, align 8, !tbaa !5
  %39 = or disjoint i64 %34, 1
  %40 = getelementptr inbounds [240 x double], ptr %3, i64 %39, i64 %31
  %41 = load double, ptr %40, align 8, !tbaa !5
  %42 = fadd double %38, %41
  store double %42, ptr %32, align 8, !tbaa !5
  %43 = or disjoint i64 %34, 2
  %44 = getelementptr inbounds [240 x double], ptr %3, i64 %43, i64 %31
  %45 = load double, ptr %44, align 8, !tbaa !5
  %46 = fadd double %42, %45
  store double %46, ptr %32, align 8, !tbaa !5
  %47 = or disjoint i64 %34, 3
  %48 = getelementptr inbounds [240 x double], ptr %3, i64 %47, i64 %31
  %49 = load double, ptr %48, align 8, !tbaa !5
  %50 = fadd double %46, %49
  store double %50, ptr %32, align 8, !tbaa !5
  %51 = add nuw nsw i64 %34, 4
  %52 = icmp eq i64 %51, 260
  br i1 %52, label %53, label %33, !llvm.loop !14

53:                                               ; preds = %33
  %54 = fdiv double %50, 2.600000e+02
  store double %54, ptr %32, align 8, !tbaa !5
  %55 = add nuw nsw i64 %31, 1
  %56 = icmp eq i64 %55, 240
  br i1 %56, label %57, label %30, !llvm.loop !15

57:                                               ; preds = %53, %77
  %58 = phi i64 [ %82, %77 ], [ 0, %53 ]
  %59 = getelementptr inbounds double, ptr %6, i64 %58
  store double 0.000000e+00, ptr %59, align 8, !tbaa !5
  %60 = getelementptr inbounds double, ptr %5, i64 %58
  br label %61

61:                                               ; preds = %61, %57
  %62 = phi double [ 0.000000e+00, %57 ], [ %74, %61 ]
  %63 = phi i64 [ 0, %57 ], [ %75, %61 ]
  %64 = getelementptr inbounds [240 x double], ptr %3, i64 %63, i64 %58
  %65 = load double, ptr %64, align 8, !tbaa !5
  %66 = load double, ptr %60, align 8, !tbaa !5
  %67 = fsub double %65, %66
  %68 = tail call double @llvm.fmuladd.f64(double %67, double %67, double %62)
  store double %68, ptr %59, align 8, !tbaa !5
  %69 = or disjoint i64 %63, 1
  %70 = getelementptr inbounds [240 x double], ptr %3, i64 %69, i64 %58
  %71 = load double, ptr %70, align 8, !tbaa !5
  %72 = load double, ptr %60, align 8, !tbaa !5
  %73 = fsub double %71, %72
  %74 = tail call double @llvm.fmuladd.f64(double %73, double %73, double %68)
  store double %74, ptr %59, align 8, !tbaa !5
  %75 = add nuw nsw i64 %63, 2
  %76 = icmp eq i64 %75, 260
  br i1 %76, label %77, label %61, !llvm.loop !16

77:                                               ; preds = %61
  %78 = fdiv double %74, 2.600000e+02
  %79 = tail call double @sqrt(double noundef %78) #7
  %80 = fcmp ugt double %79, 1.000000e-01
  %81 = select i1 %80, double %79, double 1.000000e+00
  store double %81, ptr %59, align 8, !tbaa !5
  %82 = add nuw nsw i64 %58, 1
  %83 = icmp eq i64 %82, 240
  br i1 %83, label %84, label %57, !llvm.loop !17

84:                                               ; preds = %77
  %85 = getelementptr i8, ptr %3, i64 499200
  %86 = getelementptr i8, ptr %5, i64 1920
  %87 = getelementptr i8, ptr %6, i64 1920
  %88 = icmp ult ptr %3, %86
  %89 = icmp ult ptr %5, %85
  %90 = and i1 %88, %89
  %91 = icmp ult ptr %3, %87
  %92 = icmp ult ptr %6, %85
  %93 = and i1 %91, %92
  %94 = or i1 %90, %93
  br label %95

95:                                               ; preds = %143, %84
  %96 = phi i64 [ %144, %143 ], [ 0, %84 ]
  br i1 %94, label %120, label %97

97:                                               ; preds = %95, %97
  %98 = phi i64 [ %118, %97 ], [ 0, %95 ]
  %99 = getelementptr inbounds double, ptr %5, i64 %98
  %100 = load <2 x double>, ptr %99, align 8, !tbaa !5, !alias.scope !18
  %101 = getelementptr inbounds [240 x double], ptr %3, i64 %96, i64 %98
  %102 = load <2 x double>, ptr %101, align 8, !tbaa !5, !alias.scope !21, !noalias !23
  %103 = fsub <2 x double> %102, %100
  store <2 x double> %103, ptr %101, align 8, !tbaa !5, !alias.scope !21, !noalias !23
  %104 = getelementptr inbounds double, ptr %6, i64 %98
  %105 = load <2 x double>, ptr %104, align 8, !tbaa !5, !alias.scope !25
  %106 = fmul <2 x double> %105, <double 0x40301FE03F61BAD0, double 0x40301FE03F61BAD0>
  %107 = fdiv <2 x double> %103, %106
  store <2 x double> %107, ptr %101, align 8, !tbaa !5, !alias.scope !21, !noalias !23
  %108 = or disjoint i64 %98, 2
  %109 = getelementptr inbounds double, ptr %5, i64 %108
  %110 = load <2 x double>, ptr %109, align 8, !tbaa !5, !alias.scope !18
  %111 = getelementptr inbounds [240 x double], ptr %3, i64 %96, i64 %108
  %112 = load <2 x double>, ptr %111, align 8, !tbaa !5, !alias.scope !21, !noalias !23
  %113 = fsub <2 x double> %112, %110
  store <2 x double> %113, ptr %111, align 8, !tbaa !5, !alias.scope !21, !noalias !23
  %114 = getelementptr inbounds double, ptr %6, i64 %108
  %115 = load <2 x double>, ptr %114, align 8, !tbaa !5, !alias.scope !25
  %116 = fmul <2 x double> %115, <double 0x40301FE03F61BAD0, double 0x40301FE03F61BAD0>
  %117 = fdiv <2 x double> %113, %116
  store <2 x double> %117, ptr %111, align 8, !tbaa !5, !alias.scope !21, !noalias !23
  %118 = add nuw nsw i64 %98, 4
  %119 = icmp eq i64 %118, 240
  br i1 %119, label %143, label %97, !llvm.loop !26

120:                                              ; preds = %95, %120
  %121 = phi i64 [ %141, %120 ], [ 0, %95 ]
  %122 = getelementptr inbounds double, ptr %5, i64 %121
  %123 = load double, ptr %122, align 8, !tbaa !5
  %124 = getelementptr inbounds [240 x double], ptr %3, i64 %96, i64 %121
  %125 = load double, ptr %124, align 8, !tbaa !5
  %126 = fsub double %125, %123
  store double %126, ptr %124, align 8, !tbaa !5
  %127 = getelementptr inbounds double, ptr %6, i64 %121
  %128 = load double, ptr %127, align 8, !tbaa !5
  %129 = fmul double %128, 0x40301FE03F61BAD0
  %130 = fdiv double %126, %129
  store double %130, ptr %124, align 8, !tbaa !5
  %131 = or disjoint i64 %121, 1
  %132 = getelementptr inbounds double, ptr %5, i64 %131
  %133 = load double, ptr %132, align 8, !tbaa !5
  %134 = getelementptr inbounds [240 x double], ptr %3, i64 %96, i64 %131
  %135 = load double, ptr %134, align 8, !tbaa !5
  %136 = fsub double %135, %133
  store double %136, ptr %134, align 8, !tbaa !5
  %137 = getelementptr inbounds double, ptr %6, i64 %131
  %138 = load double, ptr %137, align 8, !tbaa !5
  %139 = fmul double %138, 0x40301FE03F61BAD0
  %140 = fdiv double %136, %139
  store double %140, ptr %134, align 8, !tbaa !5
  %141 = add nuw nsw i64 %121, 2
  %142 = icmp eq i64 %141, 240
  br i1 %142, label %143, label %120, !llvm.loop !27

143:                                              ; preds = %97, %120
  %144 = add nuw nsw i64 %96, 1
  %145 = icmp eq i64 %144, 260
  br i1 %145, label %150, label %95, !llvm.loop !28

146:                                              ; preds = %173
  %147 = add nuw nsw i64 %151, 1
  %148 = add nuw nsw i64 %152, 1
  %149 = icmp eq i64 %147, 239
  br i1 %149, label %177, label %150, !llvm.loop !29

150:                                              ; preds = %143, %146
  %151 = phi i64 [ %147, %146 ], [ 0, %143 ]
  %152 = phi i64 [ %148, %146 ], [ 1, %143 ]
  %153 = getelementptr inbounds [240 x double], ptr %4, i64 %151, i64 %151
  store double 1.000000e+00, ptr %153, align 8, !tbaa !5
  br label %154

154:                                              ; preds = %173, %150
  %155 = phi i64 [ %152, %150 ], [ %175, %173 ]
  %156 = getelementptr inbounds [240 x double], ptr %4, i64 %151, i64 %155
  store double 0.000000e+00, ptr %156, align 8, !tbaa !5
  br label %157

157:                                              ; preds = %157, %154
  %158 = phi i64 [ 0, %154 ], [ %171, %157 ]
  %159 = phi double [ 0.000000e+00, %154 ], [ %170, %157 ]
  %160 = getelementptr inbounds [240 x double], ptr %3, i64 %158, i64 %151
  %161 = load double, ptr %160, align 8, !tbaa !5
  %162 = getelementptr inbounds [240 x double], ptr %3, i64 %158, i64 %155
  %163 = load double, ptr %162, align 8, !tbaa !5
  %164 = tail call double @llvm.fmuladd.f64(double %161, double %163, double %159)
  store double %164, ptr %156, align 8, !tbaa !5
  %165 = or disjoint i64 %158, 1
  %166 = getelementptr inbounds [240 x double], ptr %3, i64 %165, i64 %151
  %167 = load double, ptr %166, align 8, !tbaa !5
  %168 = getelementptr inbounds [240 x double], ptr %3, i64 %165, i64 %155
  %169 = load double, ptr %168, align 8, !tbaa !5
  %170 = tail call double @llvm.fmuladd.f64(double %167, double %169, double %164)
  store double %170, ptr %156, align 8, !tbaa !5
  %171 = add nuw nsw i64 %158, 2
  %172 = icmp eq i64 %171, 260
  br i1 %172, label %173, label %157, !llvm.loop !30

173:                                              ; preds = %157
  %174 = getelementptr inbounds [240 x double], ptr %4, i64 %155, i64 %151
  store double %170, ptr %174, align 8, !tbaa !5
  %175 = add nuw nsw i64 %155, 1
  %176 = icmp eq i64 %175, 240
  br i1 %176, label %146, label %154, !llvm.loop !31

177:                                              ; preds = %146
  %178 = getelementptr inbounds [240 x double], ptr %4, i64 239, i64 239
  store double 1.000000e+00, ptr %178, align 8, !tbaa !5
  %179 = icmp sgt i32 %0, 42
  br i1 %179, label %180, label %216

180:                                              ; preds = %177
  %181 = load ptr, ptr %1, align 8, !tbaa !32
  %182 = load i8, ptr %181, align 1
  %183 = icmp eq i8 %182, 0
  br i1 %183, label %184, label %216

184:                                              ; preds = %180
  %185 = load ptr, ptr @stderr, align 8, !tbaa !32
  %186 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %185) #8
  %187 = load ptr, ptr @stderr, align 8, !tbaa !32
  %188 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %187, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %189

189:                                              ; preds = %208, %184
  %190 = phi i64 [ 0, %184 ], [ %209, %208 ]
  %191 = mul nuw nsw i64 %190, 240
  br label %192

192:                                              ; preds = %201, %189
  %193 = phi i64 [ 0, %189 ], [ %206, %201 ]
  %194 = add nuw nsw i64 %193, %191
  %195 = trunc i64 %194 to i32
  %196 = urem i32 %195, 20
  %197 = icmp eq i32 %196, 0
  br i1 %197, label %198, label %201

198:                                              ; preds = %192
  %199 = load ptr, ptr @stderr, align 8, !tbaa !32
  %200 = tail call i32 @fputc(i32 10, ptr %199)
  br label %201

201:                                              ; preds = %198, %192
  %202 = load ptr, ptr @stderr, align 8, !tbaa !32
  %203 = getelementptr inbounds [240 x double], ptr %4, i64 %190, i64 %193
  %204 = load double, ptr %203, align 8, !tbaa !5
  %205 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %202, ptr noundef nonnull @.str.5, double noundef %204) #8
  %206 = add nuw nsw i64 %193, 1
  %207 = icmp eq i64 %206, 240
  br i1 %207, label %208, label %192, !llvm.loop !34

208:                                              ; preds = %201
  %209 = add nuw nsw i64 %190, 1
  %210 = icmp eq i64 %209, 240
  br i1 %210, label %211, label %189, !llvm.loop !35

211:                                              ; preds = %208
  %212 = load ptr, ptr @stderr, align 8, !tbaa !32
  %213 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %212, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %214 = load ptr, ptr @stderr, align 8, !tbaa !32
  %215 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %214) #8
  br label %216

216:                                              ; preds = %211, %180, %177
  tail call void @free(ptr noundef %3) #7
  tail call void @free(ptr noundef nonnull %4) #7
  tail call void @free(ptr noundef %5) #7
  tail call void @free(ptr noundef %6) #7
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare double @sqrt(double noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { mustprogress nofree nounwind willreturn memory(write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nounwind }
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
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = distinct !{!17, !10}
!18 = !{!19}
!19 = distinct !{!19, !20}
!20 = distinct !{!20, !"LVerDomain"}
!21 = !{!22}
!22 = distinct !{!22, !20}
!23 = !{!19, !24}
!24 = distinct !{!24, !20}
!25 = !{!24}
!26 = distinct !{!26, !10, !11, !12}
!27 = distinct !{!27, !10, !11}
!28 = distinct !{!28, !10}
!29 = distinct !{!29, !10}
!30 = distinct !{!30, !10}
!31 = distinct !{!31, !10}
!32 = !{!33, !33, i64 0}
!33 = !{!"any pointer", !7, i64 0}
!34 = distinct !{!34, !10}
!35 = distinct !{!35, !10}
