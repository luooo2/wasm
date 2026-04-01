; ModuleID = 'data/microbenchmarks/call_recursive.c'
source_filename = "data/microbenchmarks/call_recursive.c"
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
  %5 = phi i64 [ 0, %0 ], [ %170, %4 ]
  %6 = phi <2 x i64> [ <i64 0, i64 1>, %0 ], [ %171, %4 ]
  %7 = phi <2 x i64> [ zeroinitializer, %0 ], [ %168, %4 ]
  %8 = phi <2 x i64> [ zeroinitializer, %0 ], [ %169, %4 ]
  %9 = add <2 x i64> %6, <i64 2, i64 2>
  %10 = xor <2 x i64> %6, <i64 26, i64 26>
  %11 = xor <2 x i64> %9, <i64 26, i64 26>
  %12 = shl nuw <2 x i64> %6, <i64 1, i64 1>
  %13 = shl nuw <2 x i64> %9, <i64 1, i64 1>
  %14 = add <2 x i64> %10, %12
  %15 = add <2 x i64> %11, %13
  %16 = xor <2 x i64> %14, <i64 25, i64 25>
  %17 = xor <2 x i64> %15, <i64 25, i64 25>
  %18 = shl <2 x i64> %14, <i64 1, i64 1>
  %19 = shl <2 x i64> %15, <i64 1, i64 1>
  %20 = add <2 x i64> %16, %18
  %21 = add <2 x i64> %17, %19
  %22 = xor <2 x i64> %20, <i64 24, i64 24>
  %23 = xor <2 x i64> %21, <i64 24, i64 24>
  %24 = shl <2 x i64> %20, <i64 1, i64 1>
  %25 = shl <2 x i64> %21, <i64 1, i64 1>
  %26 = add <2 x i64> %22, %24
  %27 = add <2 x i64> %23, %25
  %28 = xor <2 x i64> %26, <i64 23, i64 23>
  %29 = xor <2 x i64> %27, <i64 23, i64 23>
  %30 = shl <2 x i64> %26, <i64 1, i64 1>
  %31 = shl <2 x i64> %27, <i64 1, i64 1>
  %32 = add <2 x i64> %28, %30
  %33 = add <2 x i64> %29, %31
  %34 = xor <2 x i64> %32, <i64 22, i64 22>
  %35 = xor <2 x i64> %33, <i64 22, i64 22>
  %36 = shl <2 x i64> %32, <i64 1, i64 1>
  %37 = shl <2 x i64> %33, <i64 1, i64 1>
  %38 = add <2 x i64> %34, %36
  %39 = add <2 x i64> %35, %37
  %40 = xor <2 x i64> %38, <i64 21, i64 21>
  %41 = xor <2 x i64> %39, <i64 21, i64 21>
  %42 = shl <2 x i64> %38, <i64 1, i64 1>
  %43 = shl <2 x i64> %39, <i64 1, i64 1>
  %44 = add <2 x i64> %40, %42
  %45 = add <2 x i64> %41, %43
  %46 = xor <2 x i64> %44, <i64 20, i64 20>
  %47 = xor <2 x i64> %45, <i64 20, i64 20>
  %48 = shl <2 x i64> %44, <i64 1, i64 1>
  %49 = shl <2 x i64> %45, <i64 1, i64 1>
  %50 = add <2 x i64> %46, %48
  %51 = add <2 x i64> %47, %49
  %52 = xor <2 x i64> %50, <i64 19, i64 19>
  %53 = xor <2 x i64> %51, <i64 19, i64 19>
  %54 = shl <2 x i64> %50, <i64 1, i64 1>
  %55 = shl <2 x i64> %51, <i64 1, i64 1>
  %56 = add <2 x i64> %52, %54
  %57 = add <2 x i64> %53, %55
  %58 = xor <2 x i64> %56, <i64 18, i64 18>
  %59 = xor <2 x i64> %57, <i64 18, i64 18>
  %60 = shl <2 x i64> %56, <i64 1, i64 1>
  %61 = shl <2 x i64> %57, <i64 1, i64 1>
  %62 = add <2 x i64> %58, %60
  %63 = add <2 x i64> %59, %61
  %64 = xor <2 x i64> %62, <i64 17, i64 17>
  %65 = xor <2 x i64> %63, <i64 17, i64 17>
  %66 = shl <2 x i64> %62, <i64 1, i64 1>
  %67 = shl <2 x i64> %63, <i64 1, i64 1>
  %68 = add <2 x i64> %64, %66
  %69 = add <2 x i64> %65, %67
  %70 = xor <2 x i64> %68, <i64 16, i64 16>
  %71 = xor <2 x i64> %69, <i64 16, i64 16>
  %72 = shl <2 x i64> %68, <i64 1, i64 1>
  %73 = shl <2 x i64> %69, <i64 1, i64 1>
  %74 = add <2 x i64> %70, %72
  %75 = add <2 x i64> %71, %73
  %76 = xor <2 x i64> %74, <i64 15, i64 15>
  %77 = xor <2 x i64> %75, <i64 15, i64 15>
  %78 = shl <2 x i64> %74, <i64 1, i64 1>
  %79 = shl <2 x i64> %75, <i64 1, i64 1>
  %80 = add <2 x i64> %76, %78
  %81 = add <2 x i64> %77, %79
  %82 = xor <2 x i64> %80, <i64 14, i64 14>
  %83 = xor <2 x i64> %81, <i64 14, i64 14>
  %84 = shl <2 x i64> %80, <i64 1, i64 1>
  %85 = shl <2 x i64> %81, <i64 1, i64 1>
  %86 = add <2 x i64> %82, %84
  %87 = add <2 x i64> %83, %85
  %88 = xor <2 x i64> %86, <i64 13, i64 13>
  %89 = xor <2 x i64> %87, <i64 13, i64 13>
  %90 = shl <2 x i64> %86, <i64 1, i64 1>
  %91 = shl <2 x i64> %87, <i64 1, i64 1>
  %92 = add <2 x i64> %88, %90
  %93 = add <2 x i64> %89, %91
  %94 = xor <2 x i64> %92, <i64 12, i64 12>
  %95 = xor <2 x i64> %93, <i64 12, i64 12>
  %96 = shl <2 x i64> %92, <i64 1, i64 1>
  %97 = shl <2 x i64> %93, <i64 1, i64 1>
  %98 = add <2 x i64> %94, %96
  %99 = add <2 x i64> %95, %97
  %100 = xor <2 x i64> %98, <i64 11, i64 11>
  %101 = xor <2 x i64> %99, <i64 11, i64 11>
  %102 = shl <2 x i64> %98, <i64 1, i64 1>
  %103 = shl <2 x i64> %99, <i64 1, i64 1>
  %104 = add <2 x i64> %100, %102
  %105 = add <2 x i64> %101, %103
  %106 = xor <2 x i64> %104, <i64 10, i64 10>
  %107 = xor <2 x i64> %105, <i64 10, i64 10>
  %108 = shl <2 x i64> %104, <i64 1, i64 1>
  %109 = shl <2 x i64> %105, <i64 1, i64 1>
  %110 = add <2 x i64> %106, %108
  %111 = add <2 x i64> %107, %109
  %112 = xor <2 x i64> %110, <i64 9, i64 9>
  %113 = xor <2 x i64> %111, <i64 9, i64 9>
  %114 = shl <2 x i64> %110, <i64 1, i64 1>
  %115 = shl <2 x i64> %111, <i64 1, i64 1>
  %116 = add <2 x i64> %112, %114
  %117 = add <2 x i64> %113, %115
  %118 = xor <2 x i64> %116, <i64 8, i64 8>
  %119 = xor <2 x i64> %117, <i64 8, i64 8>
  %120 = shl <2 x i64> %116, <i64 1, i64 1>
  %121 = shl <2 x i64> %117, <i64 1, i64 1>
  %122 = add <2 x i64> %118, %120
  %123 = add <2 x i64> %119, %121
  %124 = xor <2 x i64> %122, <i64 7, i64 7>
  %125 = xor <2 x i64> %123, <i64 7, i64 7>
  %126 = shl <2 x i64> %122, <i64 1, i64 1>
  %127 = shl <2 x i64> %123, <i64 1, i64 1>
  %128 = add <2 x i64> %124, %126
  %129 = add <2 x i64> %125, %127
  %130 = xor <2 x i64> %128, <i64 6, i64 6>
  %131 = xor <2 x i64> %129, <i64 6, i64 6>
  %132 = shl <2 x i64> %128, <i64 1, i64 1>
  %133 = shl <2 x i64> %129, <i64 1, i64 1>
  %134 = add <2 x i64> %130, %132
  %135 = add <2 x i64> %131, %133
  %136 = xor <2 x i64> %134, <i64 5, i64 5>
  %137 = xor <2 x i64> %135, <i64 5, i64 5>
  %138 = shl <2 x i64> %134, <i64 1, i64 1>
  %139 = shl <2 x i64> %135, <i64 1, i64 1>
  %140 = add <2 x i64> %136, %138
  %141 = add <2 x i64> %137, %139
  %142 = xor <2 x i64> %140, <i64 4, i64 4>
  %143 = xor <2 x i64> %141, <i64 4, i64 4>
  %144 = shl <2 x i64> %140, <i64 1, i64 1>
  %145 = shl <2 x i64> %141, <i64 1, i64 1>
  %146 = add <2 x i64> %142, %144
  %147 = add <2 x i64> %143, %145
  %148 = xor <2 x i64> %146, <i64 3, i64 3>
  %149 = xor <2 x i64> %147, <i64 3, i64 3>
  %150 = shl <2 x i64> %146, <i64 1, i64 1>
  %151 = shl <2 x i64> %147, <i64 1, i64 1>
  %152 = add <2 x i64> %148, %150
  %153 = add <2 x i64> %149, %151
  %154 = xor <2 x i64> %152, <i64 2, i64 2>
  %155 = xor <2 x i64> %153, <i64 2, i64 2>
  %156 = shl <2 x i64> %152, <i64 1, i64 1>
  %157 = shl <2 x i64> %153, <i64 1, i64 1>
  %158 = add <2 x i64> %154, %156
  %159 = add <2 x i64> %155, %157
  %160 = xor <2 x i64> %158, <i64 1, i64 1>
  %161 = xor <2 x i64> %159, <i64 1, i64 1>
  %162 = shl <2 x i64> %158, <i64 1, i64 1>
  %163 = shl <2 x i64> %159, <i64 1, i64 1>
  %164 = add <2 x i64> %160, %162
  %165 = add <2 x i64> %161, %163
  %166 = add <2 x i64> %7, <i64 352, i64 352>
  %167 = add <2 x i64> %8, <i64 352, i64 352>
  %168 = add <2 x i64> %166, %164
  %169 = add <2 x i64> %167, %165
  %170 = add nuw i64 %5, 4
  %171 = add <2 x i64> %6, <i64 4, i64 4>
  %172 = icmp eq i64 %170, 3000000
  br i1 %172, label %173, label %4, !llvm.loop !5

173:                                              ; preds = %4
  %174 = add <2 x i64> %169, %168
  %175 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %174)
  store volatile i64 %175, ptr @sink_u64, align 8, !tbaa !9
  %176 = call i32 @clock_gettime(i32 noundef 1, ptr noundef nonnull %2) #5
  %177 = load i64, ptr %2, align 8, !tbaa !13
  %178 = load i64, ptr %1, align 8, !tbaa !13
  %179 = sub nsw i64 %177, %178
  %180 = mul i64 %179, 1000000000
  %181 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %182 = load i64, ptr %181, align 8, !tbaa !15
  %183 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %184 = load i64, ptr %183, align 8, !tbaa !15
  %185 = icmp slt i64 %182, %184
  %186 = sub i64 %182, %184
  %187 = add i64 %186, %180
  %188 = add i64 %180, %182
  %189 = sub i64 %188, %184
  %190 = select i1 %185, i64 %189, i64 %187
  %191 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %190)
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
