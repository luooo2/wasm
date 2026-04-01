; ModuleID = 'data/microbenchmarks/branch_switch_sparse.c'
source_filename = "data/microbenchmarks/branch_switch_sparse.c"
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

4:                                                ; preds = %47
  store volatile i64 %48, ptr @sink_u64, align 8, !tbaa !5
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

21:                                               ; preds = %0, %47
  %22 = phi i64 [ 0, %0 ], [ %49, %47 ]
  %23 = phi i64 [ 0, %0 ], [ %48, %47 ]
  %24 = phi i64 [ 2463534242, %0 ], [ %30, %47 ]
  %25 = shl i64 %24, 13
  %26 = xor i64 %25, %24
  %27 = lshr i64 %26, 17
  %28 = xor i64 %27, %26
  %29 = shl i64 %28, 5
  %30 = xor i64 %29, %28
  %31 = urem i64 %30, 97
  %32 = trunc i64 %31 to i32
  switch i32 %32, label %44 [
    i32 0, label %33
    i32 17, label %35
    i32 53, label %38
    i32 89, label %41
  ]

33:                                               ; preds = %21
  %34 = add i64 %22, %23
  br label %47

35:                                               ; preds = %21
  %36 = shl nuw nsw i64 %22, 1
  %37 = add i64 %36, %23
  br label %47

38:                                               ; preds = %21
  %39 = add i64 %30, %22
  %40 = xor i64 %39, %23
  br label %47

41:                                               ; preds = %21
  %42 = and i64 %22, 255
  %43 = sub i64 %23, %42
  br label %47

44:                                               ; preds = %21
  %45 = and i64 %28, 15
  %46 = add i64 %45, %23
  br label %47

47:                                               ; preds = %33, %35, %38, %41, %44
  %48 = phi i64 [ %46, %44 ], [ %43, %41 ], [ %40, %38 ], [ %37, %35 ], [ %34, %33 ]
  %49 = add nuw nsw i64 %22, 1
  %50 = icmp eq i64 %49, 45000000
  br i1 %50, label %4, label %21, !llvm.loop !12
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
