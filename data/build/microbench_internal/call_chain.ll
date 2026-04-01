; ModuleID = 'data/microbenchmarks/call_chain.c'
source_filename = "data/microbenchmarks/call_chain.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #5
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #5
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #5
  br label %4

4:                                                ; preds = %4, %0
  %5 = phi i64 [ 0, %0 ], [ %26, %4 ]
  %6 = phi <2 x i64> [ <i64 0, i64 1>, %0 ], [ %27, %4 ]
  %7 = phi <2 x i64> [ zeroinitializer, %0 ], [ %24, %4 ]
  %8 = phi <2 x i64> [ zeroinitializer, %0 ], [ %25, %4 ]
  %9 = add <2 x i64> %6, <i64 2, i64 2>
  %10 = mul nuw nsw <2 x i64> %6, <i64 3, i64 3>
  %11 = mul nuw nsw <2 x i64> %9, <i64 3, i64 3>
  %12 = add nuw nsw <2 x i64> %10, <i64 1, i64 1>
  %13 = add nuw nsw <2 x i64> %11, <i64 1, i64 1>
  %14 = shl nuw nsw <2 x i64> %6, <i64 1, i64 1>
  %15 = shl nuw nsw <2 x i64> %9, <i64 1, i64 1>
  %16 = xor <2 x i64> %12, %14
  %17 = xor <2 x i64> %13, %15
  %18 = add nuw nsw <2 x i64> %16, <i64 7, i64 7>
  %19 = add nuw nsw <2 x i64> %17, <i64 7, i64 7>
  %20 = xor <2 x i64> %18, <i64 -7046029254386353131, i64 -7046029254386353131>
  %21 = xor <2 x i64> %19, <i64 -7046029254386353131, i64 -7046029254386353131>
  %22 = add <2 x i64> %7, <i64 13, i64 13>
  %23 = add <2 x i64> %8, <i64 13, i64 13>
  %24 = add <2 x i64> %22, %20
  %25 = add <2 x i64> %23, %21
  %26 = add nuw i64 %5, 4
  %27 = add <2 x i64> %6, <i64 4, i64 4>
  %28 = icmp eq i64 %26, 30000000
  br i1 %28, label %29, label %4, !llvm.loop !5

29:                                               ; preds = %4
  %30 = add <2 x i64> %25, %24
  %31 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %30)
  store volatile i64 %31, ptr @sink_u64, align 8, !tbaa !9
  %32 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #5
  %33 = load i64, ptr %2, align 8, !tbaa !13
  %34 = load i64, ptr %1, align 8, !tbaa !13
  %35 = sub nsw i64 %33, %34
  %36 = mul i64 %35, 1000000000
  %37 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %38 = load i64, ptr %37, align 8, !tbaa !15
  %39 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %40 = load i64, ptr %39, align 8, !tbaa !15
  %41 = icmp slt i64 %38, %40
  %42 = sub i64 %38, %40
  %43 = add i64 %42, %36
  %44 = add i64 %36, %38
  %45 = sub i64 %44, %40
  %46 = select i1 %41, i64 %45, i64 %43
  %47 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %46)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #5
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #5
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>) #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6, !7, !8}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!"llvm.loop.isvectorized", i32 1}
!8 = !{!"llvm.loop.unroll.runtime.disable"}
!9 = !{!10, !10, i64 0}
!10 = !{!"long", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!14, !10, i64 0}
!14 = !{!"timespec", !10, i64 0, !10, i64 8}
!15 = !{!14, !10, i64 8}
