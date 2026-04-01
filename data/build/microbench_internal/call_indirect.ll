; ModuleID = 'data/microbenchmarks/call_indirect.c'
source_filename = "data/microbenchmarks/call_indirect.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@__const.main.ops = private unnamed_addr constant [3 x ptr] [ptr @op_add, ptr @op_mul, ptr @op_mix], align 16
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @op_add(i64 noundef %0) #0 {
  %2 = add i64 %0, 3
  ret i64 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @op_mul(i64 noundef %0) #0 {
  %2 = mul i64 %0, 5
  ret i64 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @op_mix(i64 noundef %0) #0 {
  %2 = shl i64 %0, 7
  %3 = xor i64 %2, %0
  %4 = add i64 %3, 11
  ret i64 %4
}

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #1 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #5
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #5
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #5
  br label %21

4:                                                ; preds = %21
  store volatile i64 %30, ptr @sink_u64, align 8, !tbaa !5
  %5 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #5
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
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #5
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #5
  ret i32 0

21:                                               ; preds = %0, %21
  %22 = phi i64 [ 0, %0 ], [ %31, %21 ]
  %23 = phi i64 [ 1, %0 ], [ %30, %21 ]
  %24 = trunc i64 %22 to i32
  %25 = urem i32 %24, 3
  %26 = zext nneg i32 %25 to i64
  %27 = getelementptr inbounds [3 x ptr], ptr @__const.main.ops, i64 0, i64 %26
  %28 = load ptr, ptr %27, align 8, !tbaa !12
  %29 = add i64 %22, %23
  %30 = call i64 %28(i64 noundef %29) #5
  %31 = add nuw nsw i64 %22, 1
  %32 = icmp eq i64 %31, 25000000
  br i1 %32, label %4, label %21, !llvm.loop !14
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
!6 = !{!"long", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !6, i64 0}
!10 = !{!"timespec", !6, i64 0, !6, i64 8}
!11 = !{!10, !6, i64 8}
!12 = !{!13, !13, i64 0}
!13 = !{!"any pointer", !7, i64 0}
!14 = distinct !{!14, !15}
!15 = !{!"llvm.loop.mustprogress"}
