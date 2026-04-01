; ModuleID = 'data/microbenchmarks/alloc_bulk_buffer.c'
source_filename = "data/microbenchmarks/alloc_bulk_buffer.c"
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
  br label %4

4:                                                ; preds = %0, %55
  %5 = phi i32 [ 0, %0 ], [ %56, %55 ]
  %6 = phi i64 [ 0, %0 ], [ %52, %55 ]
  %7 = call noalias dereferenceable_or_null(1048576) ptr @malloc(i64 noundef 1048576) #8
  %8 = icmp eq ptr %7, null
  br i1 %8, label %75, label %9

9:                                                ; preds = %4
  %10 = trunc i32 %5 to i8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(1048576) %7, i8 %10, i64 1048576, i1 false)
  br label %11

11:                                               ; preds = %11, %9
  %12 = phi i64 [ 0, %9 ], [ %53, %11 ]
  %13 = phi i64 [ %6, %9 ], [ %52, %11 ]
  %14 = getelementptr inbounds i8, ptr %7, i64 %12
  %15 = load i8, ptr %14, align 1, !tbaa !5
  %16 = zext i8 %15 to i64
  %17 = add i64 %13, %16
  %18 = or disjoint i64 %12, 64
  %19 = getelementptr inbounds i8, ptr %7, i64 %18
  %20 = load i8, ptr %19, align 1, !tbaa !5
  %21 = zext i8 %20 to i64
  %22 = add i64 %17, %21
  %23 = or disjoint i64 %12, 128
  %24 = getelementptr inbounds i8, ptr %7, i64 %23
  %25 = load i8, ptr %24, align 1, !tbaa !5
  %26 = zext i8 %25 to i64
  %27 = add i64 %22, %26
  %28 = or disjoint i64 %12, 192
  %29 = getelementptr inbounds i8, ptr %7, i64 %28
  %30 = load i8, ptr %29, align 1, !tbaa !5
  %31 = zext i8 %30 to i64
  %32 = add i64 %27, %31
  %33 = or disjoint i64 %12, 256
  %34 = getelementptr inbounds i8, ptr %7, i64 %33
  %35 = load i8, ptr %34, align 1, !tbaa !5
  %36 = zext i8 %35 to i64
  %37 = add i64 %32, %36
  %38 = or disjoint i64 %12, 320
  %39 = getelementptr inbounds i8, ptr %7, i64 %38
  %40 = load i8, ptr %39, align 1, !tbaa !5
  %41 = zext i8 %40 to i64
  %42 = add i64 %37, %41
  %43 = or disjoint i64 %12, 384
  %44 = getelementptr inbounds i8, ptr %7, i64 %43
  %45 = load i8, ptr %44, align 1, !tbaa !5
  %46 = zext i8 %45 to i64
  %47 = add i64 %42, %46
  %48 = or disjoint i64 %12, 448
  %49 = getelementptr inbounds i8, ptr %7, i64 %48
  %50 = load i8, ptr %49, align 1, !tbaa !5
  %51 = zext i8 %50 to i64
  %52 = add i64 %47, %51
  %53 = add nuw nsw i64 %12, 512
  %54 = icmp ult i64 %48, 1048512
  br i1 %54, label %11, label %55, !llvm.loop !8

55:                                               ; preds = %11
  call void @free(ptr noundef nonnull %7) #7
  %56 = add nuw nsw i32 %5, 1
  %57 = icmp eq i32 %56, 512
  br i1 %57, label %58, label %4, !llvm.loop !10

58:                                               ; preds = %55
  store volatile i64 %52, ptr @sink_u64, align 8, !tbaa !11
  %59 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #7
  %60 = load i64, ptr %2, align 8, !tbaa !13
  %61 = load i64, ptr %1, align 8, !tbaa !13
  %62 = sub nsw i64 %60, %61
  %63 = mul i64 %62, 1000000000
  %64 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %65 = load i64, ptr %64, align 8, !tbaa !15
  %66 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %67 = load i64, ptr %66, align 8, !tbaa !15
  %68 = icmp slt i64 %65, %67
  %69 = sub i64 %65, %67
  %70 = add i64 %69, %63
  %71 = add i64 %63, %65
  %72 = sub i64 %71, %67
  %73 = select i1 %68, i64 %72, i64 %70
  %74 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %73)
  br label %75

75:                                               ; preds = %4, %58
  %76 = phi i32 [ 0, %58 ], [ 1, %4 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #7
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #7
  ret i32 %76
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #4

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
attributes #4 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind }
attributes #8 = { nounwind allocsize(0) }

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
!10 = distinct !{!10, !9}
!11 = !{!12, !12, i64 0}
!12 = !{!"long", !6, i64 0}
!13 = !{!14, !12, i64 0}
!14 = !{!"timespec", !12, i64 0, !12, i64 8}
!15 = !{!14, !12, i64 8}
