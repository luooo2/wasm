; ModuleID = 'data/microbenchmarks/compute_fp_mix.c'
source_filename = "data/microbenchmarks/compute_fp_mix.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_f64 = dso_local global double 0.000000e+00, align 8
@.str = private unnamed_addr constant [6 x i8] c"%.8f\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %5

1:                                                ; preds = %5
  %2 = fadd double %23, %19
  store volatile double %2, ptr @sink_f64, align 8, !tbaa !5
  %3 = load volatile double, ptr @sink_f64, align 8, !tbaa !5
  %4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef %3)
  ret i32 0

5:                                                ; preds = %5, %0
  %6 = phi i32 [ 0, %0 ], [ %24, %5 ]
  %7 = phi double [ 0x3FF6A09E667A35E6, %0 ], [ %19, %5 ]
  %8 = phi double [ 0x3FE3C6EF37290DCB, %0 ], [ %23, %5 ]
  %9 = fmul double %7, 0x3FEFFFFE8830BB8A
  %10 = tail call double @llvm.fmuladd.f64(double %8, double 0x3FF000001AD7F29B, double %9)
  %11 = fmul double %10, 0xBEA77CF44765195F
  %12 = tail call double @llvm.fmuladd.f64(double %7, double 0x3FF000005087D7D0, double %11)
  %13 = and i32 %6, 6
  %14 = sitofp i32 %13 to double
  %15 = tail call double @llvm.fmuladd.f64(double %14, double 1.250000e-01, double %10)
  %16 = fmul double %12, 0x3FEFFFFE8830BB8A
  %17 = tail call double @llvm.fmuladd.f64(double %15, double 0x3FF000001AD7F29B, double %16)
  %18 = fmul double %17, 0xBEA77CF44765195F
  %19 = tail call double @llvm.fmuladd.f64(double %12, double 0x3FF000005087D7D0, double %18)
  %20 = and i32 %6, 6
  %21 = or disjoint i32 %20, 1
  %22 = sitofp i32 %21 to double
  %23 = tail call double @llvm.fmuladd.f64(double %22, double 1.250000e-01, double %17)
  %24 = add nuw nsw i32 %6, 2
  %25 = icmp eq i32 %24, 12000000
  br i1 %25, label %1, label %5, !llvm.loop !9
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
