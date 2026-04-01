; ModuleID = 'data/microbenchmarks/host_read_small.c'
source_filename = "data/microbenchmarks/host_read_small.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [19 x i8] c"bench_tmp_read.dat\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"TIME_NS:%llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  %3 = alloca [64 x i8], align 16
  %4 = alloca [64 x i8], align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #6
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #6
  %5 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %1) #6
  %6 = call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 577, i32 noundef 420) #6
  %7 = icmp slt i32 %6, 0
  br i1 %7, label %119, label %8

8:                                                ; preds = %0
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %3) #6
  store <16 x i8> <i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15, i8 16>, ptr %3, align 16, !tbaa !5
  %9 = getelementptr inbounds [64 x i8], ptr %3, i64 0, i64 16
  store <16 x i8> <i8 17, i8 18, i8 19, i8 20, i8 21, i8 22, i8 23, i8 24, i8 25, i8 26, i8 27, i8 28, i8 29, i8 30, i8 31, i8 32>, ptr %9, align 16, !tbaa !5
  %10 = getelementptr inbounds [64 x i8], ptr %3, i64 0, i64 32
  store <16 x i8> <i8 33, i8 34, i8 35, i8 36, i8 37, i8 38, i8 39, i8 40, i8 41, i8 42, i8 43, i8 44, i8 45, i8 46, i8 47, i8 48>, ptr %10, align 16, !tbaa !5
  %11 = getelementptr inbounds [64 x i8], ptr %3, i64 0, i64 48
  store <16 x i8> <i8 49, i8 50, i8 51, i8 52, i8 53, i8 54, i8 55, i8 56, i8 57, i8 58, i8 59, i8 60, i8 61, i8 62, i8 63, i8 64>, ptr %11, align 16, !tbaa !5
  %12 = call i64 @write(i32 noundef %6, ptr noundef nonnull %3, i64 noundef 64) #6
  %13 = icmp slt i64 %12, 0
  br i1 %13, label %117, label %14

14:                                               ; preds = %8
  %15 = call i32 @close(i32 noundef %6) #6
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %4) #6
  br label %16

16:                                               ; preds = %14, %93
  %17 = phi i32 [ 0, %14 ], [ %96, %93 ]
  %18 = phi i64 [ 0, %14 ], [ %94, %93 ]
  %19 = call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str, i32 noundef 0) #6
  %20 = icmp slt i32 %19, 0
  br i1 %20, label %115, label %21

21:                                               ; preds = %16
  %22 = call i64 @read(i32 noundef %19, ptr noundef nonnull %4, i64 noundef 64) #6
  %23 = icmp slt i64 %22, 0
  br i1 %23, label %115, label %24

24:                                               ; preds = %21
  %25 = icmp eq i64 %22, 0
  br i1 %25, label %93, label %26

26:                                               ; preds = %24
  %27 = and i64 %22, 7
  %28 = icmp ult i64 %22, 8
  br i1 %28, label %77, label %29

29:                                               ; preds = %26
  %30 = and i64 %22, 9223372036854775800
  br label %31

31:                                               ; preds = %31, %29
  %32 = phi i64 [ 0, %29 ], [ %74, %31 ]
  %33 = phi i64 [ %18, %29 ], [ %73, %31 ]
  %34 = phi i64 [ 0, %29 ], [ %75, %31 ]
  %35 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %32
  %36 = load i8, ptr %35, align 8, !tbaa !5
  %37 = zext i8 %36 to i64
  %38 = add i64 %33, %37
  %39 = or disjoint i64 %32, 1
  %40 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %39
  %41 = load i8, ptr %40, align 1, !tbaa !5
  %42 = zext i8 %41 to i64
  %43 = add i64 %38, %42
  %44 = or disjoint i64 %32, 2
  %45 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %44
  %46 = load i8, ptr %45, align 2, !tbaa !5
  %47 = zext i8 %46 to i64
  %48 = add i64 %43, %47
  %49 = or disjoint i64 %32, 3
  %50 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %49
  %51 = load i8, ptr %50, align 1, !tbaa !5
  %52 = zext i8 %51 to i64
  %53 = add i64 %48, %52
  %54 = or disjoint i64 %32, 4
  %55 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %54
  %56 = load i8, ptr %55, align 4, !tbaa !5
  %57 = zext i8 %56 to i64
  %58 = add i64 %53, %57
  %59 = or disjoint i64 %32, 5
  %60 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %59
  %61 = load i8, ptr %60, align 1, !tbaa !5
  %62 = zext i8 %61 to i64
  %63 = add i64 %58, %62
  %64 = or disjoint i64 %32, 6
  %65 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %64
  %66 = load i8, ptr %65, align 2, !tbaa !5
  %67 = zext i8 %66 to i64
  %68 = add i64 %63, %67
  %69 = or disjoint i64 %32, 7
  %70 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %69
  %71 = load i8, ptr %70, align 1, !tbaa !5
  %72 = zext i8 %71 to i64
  %73 = add i64 %68, %72
  %74 = add nuw nsw i64 %32, 8
  %75 = add i64 %34, 8
  %76 = icmp eq i64 %75, %30
  br i1 %76, label %77, label %31, !llvm.loop !8

77:                                               ; preds = %31, %26
  %78 = phi i64 [ undef, %26 ], [ %73, %31 ]
  %79 = phi i64 [ 0, %26 ], [ %74, %31 ]
  %80 = phi i64 [ %18, %26 ], [ %73, %31 ]
  %81 = icmp eq i64 %27, 0
  br i1 %81, label %93, label %82

82:                                               ; preds = %77, %82
  %83 = phi i64 [ %90, %82 ], [ %79, %77 ]
  %84 = phi i64 [ %89, %82 ], [ %80, %77 ]
  %85 = phi i64 [ %91, %82 ], [ 0, %77 ]
  %86 = getelementptr inbounds [64 x i8], ptr %4, i64 0, i64 %83
  %87 = load i8, ptr %86, align 1, !tbaa !5
  %88 = zext i8 %87 to i64
  %89 = add i64 %84, %88
  %90 = add nuw nsw i64 %83, 1
  %91 = add i64 %85, 1
  %92 = icmp eq i64 %91, %27
  br i1 %92, label %93, label %82, !llvm.loop !10

93:                                               ; preds = %77, %82, %24
  %94 = phi i64 [ %18, %24 ], [ %78, %77 ], [ %89, %82 ]
  %95 = call i32 @close(i32 noundef %19) #6
  %96 = add nuw nsw i32 %17, 1
  %97 = icmp eq i32 %96, 800
  br i1 %97, label %98, label %16, !llvm.loop !12

98:                                               ; preds = %93
  store volatile i64 %94, ptr @sink_u64, align 8, !tbaa !13
  %99 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #6
  %100 = load i64, ptr %2, align 8, !tbaa !15
  %101 = load i64, ptr %1, align 8, !tbaa !15
  %102 = sub nsw i64 %100, %101
  %103 = mul i64 %102, 1000000000
  %104 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %105 = load i64, ptr %104, align 8, !tbaa !17
  %106 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %107 = load i64, ptr %106, align 8, !tbaa !17
  %108 = icmp slt i64 %105, %107
  %109 = sub i64 %105, %107
  %110 = add i64 %109, %103
  %111 = add i64 %103, %105
  %112 = sub i64 %111, %107
  %113 = select i1 %108, i64 %112, i64 %110
  %114 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i64 noundef %113)
  br label %115

115:                                              ; preds = %21, %16, %98
  %116 = phi i32 [ 0, %98 ], [ 1, %16 ], [ 1, %21 ]
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %4) #6
  br label %117

117:                                              ; preds = %8, %115
  %118 = phi i32 [ %116, %115 ], [ 1, %8 ]
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %3) #6
  br label %119

119:                                              ; preds = %0, %117
  %120 = phi i32 [ %118, %117 ], [ 1, %0 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #6
  ret i32 %120
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: nofree
declare noundef i32 @open(ptr nocapture noundef readonly, i32 noundef, ...) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree
declare noundef i64 @write(i32 noundef, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #3

declare i32 @close(i32 noundef) local_unnamed_addr #4

; Function Attrs: nofree
declare noundef i64 @read(i32 noundef, ptr nocapture noundef, i64 noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }

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
!15 = !{!16, !14, i64 0}
!16 = !{!"timespec", !14, i64 0, !14, i64 8}
!17 = !{!16, !14, i64 8}
