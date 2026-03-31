; ModuleID = 'data/microbenchmarks/host_read_small.c'
source_filename = "data/microbenchmarks/host_read_small.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [19 x i8] c"bench_tmp_read.dat\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca [64 x i8], align 16
  %2 = alloca [64 x i8], align 16
  %3 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 577, i32 noundef 420) #5
  %4 = icmp slt i32 %3, 0
  br i1 %4, label %101, label %5

5:                                                ; preds = %0
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %1) #5
  store <16 x i8> <i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15, i8 16>, ptr %1, align 16, !tbaa !5
  %6 = getelementptr inbounds [64 x i8], ptr %1, i64 0, i64 16
  store <16 x i8> <i8 17, i8 18, i8 19, i8 20, i8 21, i8 22, i8 23, i8 24, i8 25, i8 26, i8 27, i8 28, i8 29, i8 30, i8 31, i8 32>, ptr %6, align 16, !tbaa !5
  %7 = getelementptr inbounds [64 x i8], ptr %1, i64 0, i64 32
  store <16 x i8> <i8 33, i8 34, i8 35, i8 36, i8 37, i8 38, i8 39, i8 40, i8 41, i8 42, i8 43, i8 44, i8 45, i8 46, i8 47, i8 48>, ptr %7, align 16, !tbaa !5
  %8 = getelementptr inbounds [64 x i8], ptr %1, i64 0, i64 48
  store <16 x i8> <i8 49, i8 50, i8 51, i8 52, i8 53, i8 54, i8 55, i8 56, i8 57, i8 58, i8 59, i8 60, i8 61, i8 62, i8 63, i8 64>, ptr %8, align 16, !tbaa !5
  %9 = call i64 @write(i32 noundef %3, ptr noundef nonnull %1, i64 noundef 64) #5
  %10 = icmp slt i64 %9, 0
  br i1 %10, label %99, label %11

11:                                               ; preds = %5
  %12 = tail call i32 @close(i32 noundef %3) #5
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %2) #5
  br label %13

13:                                               ; preds = %11, %90
  %14 = phi i32 [ 0, %11 ], [ %93, %90 ]
  %15 = phi i64 [ 0, %11 ], [ %91, %90 ]
  %16 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 0) #5
  %17 = icmp slt i32 %16, 0
  br i1 %17, label %97, label %18

18:                                               ; preds = %13
  %19 = call i64 @read(i32 noundef %16, ptr noundef nonnull %2, i64 noundef 64) #5
  %20 = icmp slt i64 %19, 0
  br i1 %20, label %97, label %21

21:                                               ; preds = %18
  %22 = icmp eq i64 %19, 0
  br i1 %22, label %90, label %23

23:                                               ; preds = %21
  %24 = and i64 %19, 7
  %25 = icmp ult i64 %19, 8
  br i1 %25, label %74, label %26

26:                                               ; preds = %23
  %27 = and i64 %19, 9223372036854775800
  br label %28

28:                                               ; preds = %28, %26
  %29 = phi i64 [ 0, %26 ], [ %71, %28 ]
  %30 = phi i64 [ %15, %26 ], [ %70, %28 ]
  %31 = phi i64 [ 0, %26 ], [ %72, %28 ]
  %32 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %29
  %33 = load i8, ptr %32, align 8, !tbaa !5
  %34 = zext i8 %33 to i64
  %35 = add i64 %30, %34
  %36 = or disjoint i64 %29, 1
  %37 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %36
  %38 = load i8, ptr %37, align 1, !tbaa !5
  %39 = zext i8 %38 to i64
  %40 = add i64 %35, %39
  %41 = or disjoint i64 %29, 2
  %42 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %41
  %43 = load i8, ptr %42, align 2, !tbaa !5
  %44 = zext i8 %43 to i64
  %45 = add i64 %40, %44
  %46 = or disjoint i64 %29, 3
  %47 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %46
  %48 = load i8, ptr %47, align 1, !tbaa !5
  %49 = zext i8 %48 to i64
  %50 = add i64 %45, %49
  %51 = or disjoint i64 %29, 4
  %52 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %51
  %53 = load i8, ptr %52, align 4, !tbaa !5
  %54 = zext i8 %53 to i64
  %55 = add i64 %50, %54
  %56 = or disjoint i64 %29, 5
  %57 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %56
  %58 = load i8, ptr %57, align 1, !tbaa !5
  %59 = zext i8 %58 to i64
  %60 = add i64 %55, %59
  %61 = or disjoint i64 %29, 6
  %62 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %61
  %63 = load i8, ptr %62, align 2, !tbaa !5
  %64 = zext i8 %63 to i64
  %65 = add i64 %60, %64
  %66 = or disjoint i64 %29, 7
  %67 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %66
  %68 = load i8, ptr %67, align 1, !tbaa !5
  %69 = zext i8 %68 to i64
  %70 = add i64 %65, %69
  %71 = add nuw nsw i64 %29, 8
  %72 = add i64 %31, 8
  %73 = icmp eq i64 %72, %27
  br i1 %73, label %74, label %28, !llvm.loop !8

74:                                               ; preds = %28, %23
  %75 = phi i64 [ undef, %23 ], [ %70, %28 ]
  %76 = phi i64 [ 0, %23 ], [ %71, %28 ]
  %77 = phi i64 [ %15, %23 ], [ %70, %28 ]
  %78 = icmp eq i64 %24, 0
  br i1 %78, label %90, label %79

79:                                               ; preds = %74, %79
  %80 = phi i64 [ %87, %79 ], [ %76, %74 ]
  %81 = phi i64 [ %86, %79 ], [ %77, %74 ]
  %82 = phi i64 [ %88, %79 ], [ 0, %74 ]
  %83 = getelementptr inbounds [64 x i8], ptr %2, i64 0, i64 %80
  %84 = load i8, ptr %83, align 1, !tbaa !5
  %85 = zext i8 %84 to i64
  %86 = add i64 %81, %85
  %87 = add nuw nsw i64 %80, 1
  %88 = add i64 %82, 1
  %89 = icmp eq i64 %88, %24
  br i1 %89, label %90, label %79, !llvm.loop !10

90:                                               ; preds = %74, %79, %21
  %91 = phi i64 [ %15, %21 ], [ %75, %74 ], [ %86, %79 ]
  %92 = tail call i32 @close(i32 noundef %16) #5
  %93 = add nuw nsw i32 %14, 1
  %94 = icmp eq i32 %93, 800
  br i1 %94, label %95, label %13, !llvm.loop !12

95:                                               ; preds = %90
  store volatile i64 %91, ptr @sink_u64, align 8, !tbaa !13
  %96 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i64 noundef %91)
  br label %97

97:                                               ; preds = %18, %13, %95
  %98 = phi i32 [ 0, %95 ], [ 1, %13 ], [ 1, %18 ]
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %2) #5
  br label %99

99:                                               ; preds = %5, %97
  %100 = phi i32 [ %98, %97 ], [ 1, %5 ]
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %1) #5
  br label %101

101:                                              ; preds = %0, %99
  %102 = phi i32 [ %100, %99 ], [ 1, %0 ]
  ret i32 %102
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree
declare noundef i32 @open(ptr nocapture noundef readonly, i32 noundef, ...) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree
declare noundef i64 @write(i32 noundef, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #2

declare i32 @close(i32 noundef) local_unnamed_addr #3

; Function Attrs: nofree
declare noundef i64 @read(i32 noundef, ptr nocapture noundef, i64 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.unroll.disable"}
!12 = distinct !{!12, !9}
!13 = !{!14, !14, i64 0}
!14 = !{!"long", !6, i64 0}
