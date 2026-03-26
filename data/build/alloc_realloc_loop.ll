; ModuleID = 'data/microbenchmarks/alloc_realloc_loop.c'
source_filename = "data/microbenchmarks/alloc_realloc_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias dereferenceable_or_null(16) ptr @malloc(i64 noundef 16) #5
  %2 = icmp eq ptr %1, null
  br i1 %2, label %31, label %3

3:                                                ; preds = %0, %16
  %4 = phi i32 [ %27, %16 ], [ 0, %0 ]
  %5 = phi i64 [ %26, %16 ], [ 0, %0 ]
  %6 = phi i64 [ %18, %16 ], [ 16, %0 ]
  %7 = phi ptr [ %17, %16 ], [ %1, %0 ]
  %8 = and i32 %4, 7
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %10, label %16

10:                                               ; preds = %3
  %11 = icmp ult i64 %6, 4096
  %12 = shl i64 %6, 1
  %13 = select i1 %11, i64 %12, i64 16
  %14 = tail call ptr @realloc(ptr noundef %7, i64 noundef %13) #6
  %15 = icmp eq ptr %14, null
  br i1 %15, label %31, label %16

16:                                               ; preds = %10, %3
  %17 = phi ptr [ %14, %10 ], [ %7, %3 ]
  %18 = phi i64 [ %13, %10 ], [ %6, %3 ]
  %19 = trunc i32 %4 to i8
  %20 = and i8 %19, 127
  %21 = trunc i64 %18 to i32
  %22 = srem i32 %4, %21
  %23 = zext nneg i32 %22 to i64
  %24 = getelementptr inbounds i8, ptr %17, i64 %23
  store i8 %20, ptr %24, align 1, !tbaa !5
  %25 = zext nneg i8 %20 to i64
  %26 = add i64 %5, %25
  %27 = add nuw nsw i32 %4, 1
  %28 = icmp eq i32 %27, 1000000
  br i1 %28, label %29, label %3, !llvm.loop !8

29:                                               ; preds = %16
  tail call void @free(ptr noundef nonnull %17) #7
  store volatile i64 %26, ptr @sink_u64, align 8, !tbaa !10
  %30 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %26)
  br label %31

31:                                               ; preds = %10, %29, %0
  %32 = phi i32 [ 1, %0 ], [ 0, %29 ], [ 1, %10 ]
  ret i32 %32
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("realloc") allocsize(1) memory(argmem: readwrite, inaccessiblemem: readwrite)
declare noalias noundef ptr @realloc(ptr allocptr nocapture noundef, i64 noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nounwind willreturn allockind("realloc") allocsize(1) memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind allocsize(0) }
attributes #6 = { nounwind allocsize(1) }
attributes #7 = { nounwind }

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
