; ModuleID = 'data/microbenchmarks/branch_nested.c'
source_filename = "data/microbenchmarks/branch_nested.c"
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

4:                                                ; preds = %42
  store volatile i64 %43, ptr @sink_u64, align 8, !tbaa !5
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

21:                                               ; preds = %0, %42
  %22 = phi i64 [ 0, %0 ], [ %44, %42 ]
  %23 = phi i64 [ 0, %0 ], [ %43, %42 ]
  %24 = and i64 %22, 1
  %25 = icmp eq i64 %24, 0
  br i1 %25, label %26, label %34

26:                                               ; preds = %21
  %27 = and i64 %22, 2
  %28 = icmp eq i64 %27, 0
  br i1 %28, label %29, label %31

29:                                               ; preds = %26
  %30 = add i64 %22, %23
  br label %42

31:                                               ; preds = %26
  %32 = lshr exact i64 %22, 1
  %33 = add i64 %32, %23
  br label %42

34:                                               ; preds = %21
  %35 = and i64 %22, 7
  %36 = icmp eq i64 %35, 1
  br i1 %36, label %37, label %39

37:                                               ; preds = %34
  %38 = sub i64 %23, %22
  br label %42

39:                                               ; preds = %34
  %40 = xor i64 %22, 40503
  %41 = add i64 %40, %23
  br label %42

42:                                               ; preds = %31, %29, %39, %37
  %43 = phi i64 [ %30, %29 ], [ %33, %31 ], [ %38, %37 ], [ %41, %39 ]
  %44 = add nuw nsw i64 %22, 1
  %45 = icmp eq i64 %44, 35000000
  br i1 %45, label %4, label %21, !llvm.loop !12
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
