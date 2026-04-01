; ModuleID = 'data/microbenchmarks/compute_fp_muladd.c'
source_filename = "data/microbenchmarks/compute_fp_muladd.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_f64 = dso_local global double 0.000000e+00, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #5
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #5
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #5
  br label %22

4:                                                ; preds = %22
  %5 = fadd double %40, %36
  store volatile double %5, ptr @sink_f64, align 8, !tbaa !5
  %6 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #5
  %7 = load i64, ptr %2, align 8, !tbaa !9
  %8 = load i64, ptr %1, align 8, !tbaa !9
  %9 = sub nsw i64 %7, %8
  %10 = mul i64 %9, 1000000000
  %11 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %12 = load i64, ptr %11, align 8, !tbaa !12
  %13 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %14 = load i64, ptr %13, align 8, !tbaa !12
  %15 = icmp slt i64 %12, %14
  %16 = sub i64 %12, %14
  %17 = add i64 %16, %10
  %18 = add i64 %10, %12
  %19 = sub i64 %18, %14
  %20 = select i1 %15, i64 %19, i64 %17
  %21 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %20)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #5
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #5
  ret i32 0

22:                                               ; preds = %22, %0
  %23 = phi i32 [ 0, %0 ], [ %41, %22 ]
  %24 = phi double [ 1.217000e+00, %0 ], [ %36, %22 ]
  %25 = phi double [ 7.310000e-01, %0 ], [ %40, %22 ]
  %26 = fmul double %24, 7.300000e-07
  %27 = call double @llvm.fmuladd.f64(double %25, double 0x3FF00000533709AC, double %26)
  %28 = fmul double %27, 1.190000e-06
  %29 = call double @llvm.fmuladd.f64(double %24, double 0x3FEFFFFF644EB418, double %28)
  %30 = and i32 %23, 14
  %31 = sitofp i32 %30 to double
  %32 = call double @llvm.fmuladd.f64(double %31, double 3.125000e-02, double %27)
  %33 = fmul double %29, 7.300000e-07
  %34 = call double @llvm.fmuladd.f64(double %32, double 0x3FF00000533709AC, double %33)
  %35 = fmul double %34, 1.190000e-06
  %36 = call double @llvm.fmuladd.f64(double %29, double 0x3FEFFFFF644EB418, double %35)
  %37 = and i32 %23, 14
  %38 = or disjoint i32 %37, 1
  %39 = sitofp i32 %38 to double
  %40 = call double @llvm.fmuladd.f64(double %39, double 3.125000e-02, double %34)
  %41 = add nuw nsw i32 %23, 2
  %42 = icmp eq i32 %41, 14000000
  br i1 %42, label %4, label %22, !llvm.loop !13
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

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
!9 = !{!10, !11, i64 0}
!10 = !{!"timespec", !11, i64 0, !11, i64 8}
!11 = !{!"long", !7, i64 0}
!12 = !{!10, !11, i64 8}
!13 = distinct !{!13, !14}
!14 = !{!"llvm.loop.mustprogress"}
