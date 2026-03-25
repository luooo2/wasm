; ModuleID = 'data/microbenchmarks/call_indirect.c'
source_filename = "data/microbenchmarks/call_indirect.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink_u64 = dso_local global i64 0, align 8
@__const.main.ops = private unnamed_addr constant [3 x ptr] [ptr @op_add, ptr @op_mul, ptr @op_mix], align 16
@.str = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

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
  br label %3

1:                                                ; preds = %3
  store volatile i64 %12, ptr @sink_u64, align 8, !tbaa !5
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %12)
  ret i32 0

3:                                                ; preds = %0, %3
  %4 = phi i64 [ 0, %0 ], [ %13, %3 ]
  %5 = phi i64 [ 1, %0 ], [ %12, %3 ]
  %6 = trunc i64 %4 to i32
  %7 = urem i32 %6, 3
  %8 = zext nneg i32 %7 to i64
  %9 = getelementptr inbounds [3 x ptr], ptr @__const.main.ops, i64 0, i64 %8
  %10 = load ptr, ptr %9, align 8, !tbaa !9
  %11 = add i64 %4, %5
  %12 = tail call i64 %10(i64 noundef %11) #3
  %13 = add nuw nsw i64 %4, 1
  %14 = icmp eq i64 %13, 25000000
  br i1 %14, label %1, label %3, !llvm.loop !11
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

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
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !7, i64 0}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
