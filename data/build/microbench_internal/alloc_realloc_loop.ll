; ModuleID = 'data/microbenchmarks/alloc_realloc_loop.c'
source_filename = "data/microbenchmarks/alloc_realloc_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #7
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #7
  %3 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #7
  %4 = call noalias dereferenceable_or_null(16) ptr @malloc(i64 noundef 16) #8
  %5 = icmp eq ptr %4, null
  br i1 %5, label %49, label %6

6:                                                ; preds = %0, %19
  %7 = phi i32 [ %30, %19 ], [ 0, %0 ]
  %8 = phi i64 [ %29, %19 ], [ 0, %0 ]
  %9 = phi i64 [ %21, %19 ], [ 16, %0 ]
  %10 = phi ptr [ %20, %19 ], [ %4, %0 ]
  %11 = and i32 %7, 7
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %19

13:                                               ; preds = %6
  %14 = icmp ult i64 %9, 4096
  %15 = shl i64 %9, 1
  %16 = select i1 %14, i64 %15, i64 16
  %17 = call ptr @realloc(ptr noundef %10, i64 noundef %16) #9
  %18 = icmp eq ptr %17, null
  br i1 %18, label %49, label %19

19:                                               ; preds = %13, %6
  %20 = phi ptr [ %17, %13 ], [ %10, %6 ]
  %21 = phi i64 [ %16, %13 ], [ %9, %6 ]
  %22 = trunc i32 %7 to i8
  %23 = and i8 %22, 127
  %24 = trunc i64 %21 to i32
  %25 = srem i32 %7, %24
  %26 = zext nneg i32 %25 to i64
  %27 = getelementptr inbounds i8, ptr %20, i64 %26
  store i8 %23, ptr %27, align 1, !tbaa !5
  %28 = zext nneg i8 %23 to i64
  %29 = add i64 %8, %28
  %30 = add nuw nsw i32 %7, 1
  %31 = icmp eq i32 %30, 100000
  br i1 %31, label %32, label %6, !llvm.loop !8

32:                                               ; preds = %19
  call void @free(ptr noundef nonnull %20) #7
  store volatile i64 %29, ptr @sink_u64, align 8, !tbaa !10
  %33 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #7
  %34 = load i64, ptr %2, align 8, !tbaa !12
  %35 = load i64, ptr %1, align 8, !tbaa !12
  %36 = sub nsw i64 %34, %35
  %37 = mul i64 %36, 1000000000
  %38 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %39 = load i64, ptr %38, align 8, !tbaa !14
  %40 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %41 = load i64, ptr %40, align 8, !tbaa !14
  %42 = icmp slt i64 %39, %41
  %43 = sub i64 %39, %41
  %44 = add i64 %43, %37
  %45 = add i64 %37, %39
  %46 = sub i64 %45, %41
  %47 = select i1 %42, i64 %46, i64 %44
  %48 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %47)
  br label %49

49:                                               ; preds = %13, %32, %0
  %50 = phi i32 [ 1, %0 ], [ 0, %32 ], [ 1, %13 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #7
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #7
  ret i32 %50
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nounwind willreturn allockind("realloc") allocsize(1) memory(argmem: readwrite, inaccessiblemem: readwrite)
declare noalias noundef ptr @realloc(ptr allocptr nocapture noundef, i64 noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nounwind willreturn allockind("realloc") allocsize(1) memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind }
attributes #8 = { nounwind allocsize(0) }
attributes #9 = { nounwind allocsize(1) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{!11, !11, i64 0}
!11 = !{!"long", !6, i64 0}
!12 = !{!13, !11, i64 0}
!13 = !{!"timespec", !11, i64 0, !11, i64 8}
!14 = !{!13, !11, i64 8}
