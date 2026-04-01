; ModuleID = 'data/microbenchmarks/compute_int_mul.c'
source_filename = "data/microbenchmarks/compute_int_mul.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #4
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #4
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #4
  br label %21

4:                                                ; preds = %21
  store volatile i64 %46, ptr @sink_u64, align 8, !tbaa !5
  %5 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #4
  %6 = load i64, ptr %2, align 8, !tbaa !9
  %7 = load i64, ptr %1, align 8, !tbaa !9
  %8 = sub nsw i64 %6, %7
  %9 = mul i64 %8, 1000000000
  %10 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %11 = load i64, ptr %10, align 8, !tbaa !11
  %12 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %13 = load i64, ptr %12, align 8, !tbaa !11
  %14 = icmp slt i64 %11, %13
  %15 = sub i64 %11, %13
  %16 = add i64 %15, %9
  %17 = add i64 %9, %11
  %18 = sub i64 %17, %13
  %19 = select i1 %14, i64 %18, i64 %16
  %20 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %19)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #4
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #4
  ret i32 0

21:                                               ; preds = %21, %0
  %22 = phi i64 [ 1, %0 ], [ %47, %21 ]
  %23 = phi i64 [ 3, %0 ], [ %46, %21 ]
  %24 = mul i64 %23, 1664525
  %25 = mul nuw nsw i64 %22, 1013904223
  %26 = add i64 %25, %24
  %27 = lshr i64 %26, 11
  %28 = xor i64 %27, %26
  %29 = mul i64 %28, 1664525
  %30 = mul nuw i64 %22, 1013904223
  %31 = add nuw i64 %30, 1013904223
  %32 = add i64 %31, %29
  %33 = lshr i64 %32, 11
  %34 = xor i64 %33, %32
  %35 = mul i64 %34, 1664525
  %36 = mul nuw i64 %22, 1013904223
  %37 = add nuw i64 %36, 2027808446
  %38 = add i64 %37, %35
  %39 = lshr i64 %38, 11
  %40 = xor i64 %39, %38
  %41 = mul i64 %40, 1664525
  %42 = mul nuw i64 %22, 1013904223
  %43 = add nuw i64 %42, 3041712669
  %44 = add i64 %43, %41
  %45 = lshr i64 %44, 11
  %46 = xor i64 %45, %44
  %47 = add nuw nsw i64 %22, 4
  %48 = icmp eq i64 %47, 45000001
  br i1 %48, label %4, label %21, !llvm.loop !12
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"long", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !6, i64 0}
!10 = !{!"timespec", !6, i64 0, !6, i64 8}
!11 = !{!10, !6, i64 8}
!12 = distinct !{!12, !13}
!13 = !{!"llvm.loop.mustprogress"}
