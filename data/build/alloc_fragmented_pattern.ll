; ModuleID = 'data/microbenchmarks/alloc_fragmented_pattern.c'
source_filename = "data/microbenchmarks/alloc_fragmented_pattern.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca [64 x ptr], align 16
  call void @llvm.lifetime.start.p0(i64 512, ptr nonnull %1) #6
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(512) %1, i8 0, i64 512, i1 false)
  br label %2

2:                                                ; preds = %0, %23
  %3 = phi i64 [ 0, %0 ], [ %24, %23 ]
  %4 = phi i32 [ 0, %0 ], [ %25, %23 ]
  %5 = and i32 %4, 63
  %6 = zext nneg i32 %5 to i64
  %7 = getelementptr inbounds [64 x ptr], ptr %1, i64 0, i64 %6
  %8 = load ptr, ptr %7, align 8, !tbaa !5
  %9 = icmp eq ptr %8, null
  br i1 %9, label %14, label %10

10:                                               ; preds = %2
  %11 = load i32, ptr %8, align 4, !tbaa !9
  %12 = zext i32 %11 to i64
  %13 = add i64 %3, %12
  tail call void @free(ptr noundef nonnull %8) #6
  store ptr null, ptr %7, align 8, !tbaa !5
  br label %23

14:                                               ; preds = %2
  %15 = and i32 %4, 127
  %16 = add nuw nsw i32 %15, 8
  %17 = shl nuw nsw i32 %16, 2
  %18 = zext nneg i32 %17 to i64
  %19 = tail call noalias ptr @malloc(i64 noundef %18) #7
  store ptr %19, ptr %7, align 8, !tbaa !5
  %20 = icmp eq ptr %19, null
  br i1 %20, label %43, label %21

21:                                               ; preds = %14
  %22 = xor i32 %16, %4
  store i32 %22, ptr %19, align 4, !tbaa !9
  br label %23

23:                                               ; preds = %21, %10
  %24 = phi i64 [ %13, %10 ], [ %3, %21 ]
  %25 = add nuw nsw i32 %4, 1
  %26 = icmp eq i32 %25, 600000
  br i1 %26, label %29, label %2, !llvm.loop !11

27:                                               ; preds = %39
  store volatile i64 %40, ptr @sink_u64, align 8, !tbaa !13
  %28 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %40)
  br label %43

29:                                               ; preds = %23, %39
  %30 = phi i64 [ %41, %39 ], [ 0, %23 ]
  %31 = phi i64 [ %40, %39 ], [ %24, %23 ]
  %32 = getelementptr inbounds [64 x ptr], ptr %1, i64 0, i64 %30
  %33 = load ptr, ptr %32, align 8, !tbaa !5
  %34 = icmp eq ptr %33, null
  br i1 %34, label %39, label %35

35:                                               ; preds = %29
  %36 = load i32, ptr %33, align 4, !tbaa !9
  %37 = zext i32 %36 to i64
  %38 = add i64 %31, %37
  tail call void @free(ptr noundef nonnull %33) #6
  br label %39

39:                                               ; preds = %29, %35
  %40 = phi i64 [ %38, %35 ], [ %31, %29 ]
  %41 = add nuw nsw i64 %30, 1
  %42 = icmp eq i64 %41, 64
  br i1 %42, label %27, label %29, !llvm.loop !15

43:                                               ; preds = %14, %27
  %44 = phi i32 [ 0, %27 ], [ 1, %14 ]
  call void @llvm.lifetime.end.p0(i64 512, ptr nonnull %1) #6
  ret i32 %44
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }
attributes #7 = { nounwind allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"any pointer", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !7, i64 0}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!14, !14, i64 0}
!14 = !{!"long", !7, i64 0}
!15 = distinct !{!15, !12}
