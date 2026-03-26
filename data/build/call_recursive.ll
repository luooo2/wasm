; ModuleID = 'data/microbenchmarks/call_recursive.c'
source_filename = "data/microbenchmarks/call_recursive.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %1, %0
  %2 = phi i64 [ 0, %0 ], [ %167, %1 ]
  %3 = phi <2 x i64> [ <i64 0, i64 1>, %0 ], [ %168, %1 ]
  %4 = phi <2 x i64> [ zeroinitializer, %0 ], [ %165, %1 ]
  %5 = phi <2 x i64> [ zeroinitializer, %0 ], [ %166, %1 ]
  %6 = add <2 x i64> %3, <i64 2, i64 2>
  %7 = xor <2 x i64> %3, <i64 26, i64 26>
  %8 = xor <2 x i64> %6, <i64 26, i64 26>
  %9 = shl nuw <2 x i64> %3, <i64 1, i64 1>
  %10 = shl nuw <2 x i64> %6, <i64 1, i64 1>
  %11 = add <2 x i64> %7, %9
  %12 = add <2 x i64> %8, %10
  %13 = xor <2 x i64> %11, <i64 25, i64 25>
  %14 = xor <2 x i64> %12, <i64 25, i64 25>
  %15 = shl <2 x i64> %11, <i64 1, i64 1>
  %16 = shl <2 x i64> %12, <i64 1, i64 1>
  %17 = add <2 x i64> %13, %15
  %18 = add <2 x i64> %14, %16
  %19 = xor <2 x i64> %17, <i64 24, i64 24>
  %20 = xor <2 x i64> %18, <i64 24, i64 24>
  %21 = shl <2 x i64> %17, <i64 1, i64 1>
  %22 = shl <2 x i64> %18, <i64 1, i64 1>
  %23 = add <2 x i64> %19, %21
  %24 = add <2 x i64> %20, %22
  %25 = xor <2 x i64> %23, <i64 23, i64 23>
  %26 = xor <2 x i64> %24, <i64 23, i64 23>
  %27 = shl <2 x i64> %23, <i64 1, i64 1>
  %28 = shl <2 x i64> %24, <i64 1, i64 1>
  %29 = add <2 x i64> %25, %27
  %30 = add <2 x i64> %26, %28
  %31 = xor <2 x i64> %29, <i64 22, i64 22>
  %32 = xor <2 x i64> %30, <i64 22, i64 22>
  %33 = shl <2 x i64> %29, <i64 1, i64 1>
  %34 = shl <2 x i64> %30, <i64 1, i64 1>
  %35 = add <2 x i64> %31, %33
  %36 = add <2 x i64> %32, %34
  %37 = xor <2 x i64> %35, <i64 21, i64 21>
  %38 = xor <2 x i64> %36, <i64 21, i64 21>
  %39 = shl <2 x i64> %35, <i64 1, i64 1>
  %40 = shl <2 x i64> %36, <i64 1, i64 1>
  %41 = add <2 x i64> %37, %39
  %42 = add <2 x i64> %38, %40
  %43 = xor <2 x i64> %41, <i64 20, i64 20>
  %44 = xor <2 x i64> %42, <i64 20, i64 20>
  %45 = shl <2 x i64> %41, <i64 1, i64 1>
  %46 = shl <2 x i64> %42, <i64 1, i64 1>
  %47 = add <2 x i64> %43, %45
  %48 = add <2 x i64> %44, %46
  %49 = xor <2 x i64> %47, <i64 19, i64 19>
  %50 = xor <2 x i64> %48, <i64 19, i64 19>
  %51 = shl <2 x i64> %47, <i64 1, i64 1>
  %52 = shl <2 x i64> %48, <i64 1, i64 1>
  %53 = add <2 x i64> %49, %51
  %54 = add <2 x i64> %50, %52
  %55 = xor <2 x i64> %53, <i64 18, i64 18>
  %56 = xor <2 x i64> %54, <i64 18, i64 18>
  %57 = shl <2 x i64> %53, <i64 1, i64 1>
  %58 = shl <2 x i64> %54, <i64 1, i64 1>
  %59 = add <2 x i64> %55, %57
  %60 = add <2 x i64> %56, %58
  %61 = xor <2 x i64> %59, <i64 17, i64 17>
  %62 = xor <2 x i64> %60, <i64 17, i64 17>
  %63 = shl <2 x i64> %59, <i64 1, i64 1>
  %64 = shl <2 x i64> %60, <i64 1, i64 1>
  %65 = add <2 x i64> %61, %63
  %66 = add <2 x i64> %62, %64
  %67 = xor <2 x i64> %65, <i64 16, i64 16>
  %68 = xor <2 x i64> %66, <i64 16, i64 16>
  %69 = shl <2 x i64> %65, <i64 1, i64 1>
  %70 = shl <2 x i64> %66, <i64 1, i64 1>
  %71 = add <2 x i64> %67, %69
  %72 = add <2 x i64> %68, %70
  %73 = xor <2 x i64> %71, <i64 15, i64 15>
  %74 = xor <2 x i64> %72, <i64 15, i64 15>
  %75 = shl <2 x i64> %71, <i64 1, i64 1>
  %76 = shl <2 x i64> %72, <i64 1, i64 1>
  %77 = add <2 x i64> %73, %75
  %78 = add <2 x i64> %74, %76
  %79 = xor <2 x i64> %77, <i64 14, i64 14>
  %80 = xor <2 x i64> %78, <i64 14, i64 14>
  %81 = shl <2 x i64> %77, <i64 1, i64 1>
  %82 = shl <2 x i64> %78, <i64 1, i64 1>
  %83 = add <2 x i64> %79, %81
  %84 = add <2 x i64> %80, %82
  %85 = xor <2 x i64> %83, <i64 13, i64 13>
  %86 = xor <2 x i64> %84, <i64 13, i64 13>
  %87 = shl <2 x i64> %83, <i64 1, i64 1>
  %88 = shl <2 x i64> %84, <i64 1, i64 1>
  %89 = add <2 x i64> %85, %87
  %90 = add <2 x i64> %86, %88
  %91 = xor <2 x i64> %89, <i64 12, i64 12>
  %92 = xor <2 x i64> %90, <i64 12, i64 12>
  %93 = shl <2 x i64> %89, <i64 1, i64 1>
  %94 = shl <2 x i64> %90, <i64 1, i64 1>
  %95 = add <2 x i64> %91, %93
  %96 = add <2 x i64> %92, %94
  %97 = xor <2 x i64> %95, <i64 11, i64 11>
  %98 = xor <2 x i64> %96, <i64 11, i64 11>
  %99 = shl <2 x i64> %95, <i64 1, i64 1>
  %100 = shl <2 x i64> %96, <i64 1, i64 1>
  %101 = add <2 x i64> %97, %99
  %102 = add <2 x i64> %98, %100
  %103 = xor <2 x i64> %101, <i64 10, i64 10>
  %104 = xor <2 x i64> %102, <i64 10, i64 10>
  %105 = shl <2 x i64> %101, <i64 1, i64 1>
  %106 = shl <2 x i64> %102, <i64 1, i64 1>
  %107 = add <2 x i64> %103, %105
  %108 = add <2 x i64> %104, %106
  %109 = xor <2 x i64> %107, <i64 9, i64 9>
  %110 = xor <2 x i64> %108, <i64 9, i64 9>
  %111 = shl <2 x i64> %107, <i64 1, i64 1>
  %112 = shl <2 x i64> %108, <i64 1, i64 1>
  %113 = add <2 x i64> %109, %111
  %114 = add <2 x i64> %110, %112
  %115 = xor <2 x i64> %113, <i64 8, i64 8>
  %116 = xor <2 x i64> %114, <i64 8, i64 8>
  %117 = shl <2 x i64> %113, <i64 1, i64 1>
  %118 = shl <2 x i64> %114, <i64 1, i64 1>
  %119 = add <2 x i64> %115, %117
  %120 = add <2 x i64> %116, %118
  %121 = xor <2 x i64> %119, <i64 7, i64 7>
  %122 = xor <2 x i64> %120, <i64 7, i64 7>
  %123 = shl <2 x i64> %119, <i64 1, i64 1>
  %124 = shl <2 x i64> %120, <i64 1, i64 1>
  %125 = add <2 x i64> %121, %123
  %126 = add <2 x i64> %122, %124
  %127 = xor <2 x i64> %125, <i64 6, i64 6>
  %128 = xor <2 x i64> %126, <i64 6, i64 6>
  %129 = shl <2 x i64> %125, <i64 1, i64 1>
  %130 = shl <2 x i64> %126, <i64 1, i64 1>
  %131 = add <2 x i64> %127, %129
  %132 = add <2 x i64> %128, %130
  %133 = xor <2 x i64> %131, <i64 5, i64 5>
  %134 = xor <2 x i64> %132, <i64 5, i64 5>
  %135 = shl <2 x i64> %131, <i64 1, i64 1>
  %136 = shl <2 x i64> %132, <i64 1, i64 1>
  %137 = add <2 x i64> %133, %135
  %138 = add <2 x i64> %134, %136
  %139 = xor <2 x i64> %137, <i64 4, i64 4>
  %140 = xor <2 x i64> %138, <i64 4, i64 4>
  %141 = shl <2 x i64> %137, <i64 1, i64 1>
  %142 = shl <2 x i64> %138, <i64 1, i64 1>
  %143 = add <2 x i64> %139, %141
  %144 = add <2 x i64> %140, %142
  %145 = xor <2 x i64> %143, <i64 3, i64 3>
  %146 = xor <2 x i64> %144, <i64 3, i64 3>
  %147 = shl <2 x i64> %143, <i64 1, i64 1>
  %148 = shl <2 x i64> %144, <i64 1, i64 1>
  %149 = add <2 x i64> %145, %147
  %150 = add <2 x i64> %146, %148
  %151 = xor <2 x i64> %149, <i64 2, i64 2>
  %152 = xor <2 x i64> %150, <i64 2, i64 2>
  %153 = shl <2 x i64> %149, <i64 1, i64 1>
  %154 = shl <2 x i64> %150, <i64 1, i64 1>
  %155 = add <2 x i64> %151, %153
  %156 = add <2 x i64> %152, %154
  %157 = xor <2 x i64> %155, <i64 1, i64 1>
  %158 = xor <2 x i64> %156, <i64 1, i64 1>
  %159 = shl <2 x i64> %155, <i64 1, i64 1>
  %160 = shl <2 x i64> %156, <i64 1, i64 1>
  %161 = add <2 x i64> %157, %159
  %162 = add <2 x i64> %158, %160
  %163 = add <2 x i64> %4, <i64 352, i64 352>
  %164 = add <2 x i64> %5, <i64 352, i64 352>
  %165 = add <2 x i64> %163, %161
  %166 = add <2 x i64> %164, %162
  %167 = add nuw i64 %2, 4
  %168 = add <2 x i64> %3, <i64 4, i64 4>
  %169 = icmp eq i64 %167, 300000
  br i1 %169, label %170, label %1, !llvm.loop !5

170:                                              ; preds = %1
  %171 = add <2 x i64> %166, %165
  %172 = tail call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %171)
  store volatile i64 %172, ptr @sink_u64, align 8, !tbaa !9
  %173 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %172)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>) #2

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
