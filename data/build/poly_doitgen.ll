; ModuleID = 'data/polybench-c-4.2.1-beta/linear-algebra/kernels/doitgen/doitgen.c'
source_filename = "data/polybench-c-4.2.1-beta/linear-algebra/kernels/doitgen/doitgen.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @kernel_doitgen(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr nocapture noundef %3, ptr nocapture noundef readonly %4, ptr nocapture noundef %5) local_unnamed_addr #0 {
  %7 = icmp sgt i32 %0, 0
  br i1 %7, label %8, label %123

8:                                                ; preds = %6
  %9 = ptrtoint ptr %3 to i64
  %10 = ptrtoint ptr %5 to i64
  %11 = icmp sgt i32 %1, 0
  %12 = icmp sgt i32 %2, 0
  %13 = zext nneg i32 %0 to i64
  %14 = zext nneg i32 %1 to i64
  %15 = zext i32 %2 to i64
  %16 = zext nneg i32 %2 to i64
  %17 = sub i64 %9, %10
  %18 = and i64 %15, 1
  %19 = icmp eq i32 %2, 1
  %20 = and i64 %15, 2147483646
  %21 = icmp eq i64 %18, 0
  %22 = icmp ult i32 %2, 4
  %23 = and i64 %15, 2147483644
  %24 = icmp eq i64 %23, %15
  %25 = and i64 %15, 3
  %26 = icmp eq i64 %25, 0
  br label %27

27:                                               ; preds = %8, %120
  %28 = phi i64 [ 0, %8 ], [ %121, %120 ]
  %29 = mul nuw nsw i64 %28, 19200
  %30 = add i64 %17, %29
  br i1 %11, label %31, label %120

31:                                               ; preds = %27, %117
  %32 = phi i64 [ %118, %117 ], [ 0, %27 ]
  %33 = mul nuw nsw i64 %32, 480
  %34 = add i64 %30, %33
  br i1 %12, label %65, label %117

35:                                               ; preds = %95
  br i1 %12, label %36, label %117

36:                                               ; preds = %35
  %37 = icmp ult i64 %34, 32
  %38 = select i1 %22, i1 true, i1 %37
  br i1 %38, label %50, label %39

39:                                               ; preds = %36, %39
  %40 = phi i64 [ %47, %39 ], [ 0, %36 ]
  %41 = getelementptr inbounds double, ptr %5, i64 %40
  %42 = getelementptr inbounds double, ptr %41, i64 2
  %43 = load <2 x double>, ptr %41, align 8, !tbaa !5
  %44 = load <2 x double>, ptr %42, align 8, !tbaa !5
  %45 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %40
  %46 = getelementptr inbounds double, ptr %45, i64 2
  store <2 x double> %43, ptr %45, align 8, !tbaa !5
  store <2 x double> %44, ptr %46, align 8, !tbaa !5
  %47 = add nuw i64 %40, 4
  %48 = icmp eq i64 %47, %23
  br i1 %48, label %49, label %39, !llvm.loop !9

49:                                               ; preds = %39
  br i1 %24, label %117, label %50

50:                                               ; preds = %36, %49
  %51 = phi i64 [ 0, %36 ], [ %23, %49 ]
  br i1 %26, label %61, label %52

52:                                               ; preds = %50, %52
  %53 = phi i64 [ %58, %52 ], [ %51, %50 ]
  %54 = phi i64 [ %59, %52 ], [ 0, %50 ]
  %55 = getelementptr inbounds double, ptr %5, i64 %53
  %56 = load double, ptr %55, align 8, !tbaa !5
  %57 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %53
  store double %56, ptr %57, align 8, !tbaa !5
  %58 = add nuw nsw i64 %53, 1
  %59 = add i64 %54, 1
  %60 = icmp eq i64 %59, %25
  br i1 %60, label %61, label %52, !llvm.loop !13

61:                                               ; preds = %52, %50
  %62 = phi i64 [ %51, %50 ], [ %58, %52 ]
  %63 = sub nsw i64 %51, %15
  %64 = icmp ugt i64 %63, -4
  br i1 %64, label %117, label %98

65:                                               ; preds = %31, %95
  %66 = phi i64 [ %96, %95 ], [ 0, %31 ]
  %67 = getelementptr inbounds double, ptr %5, i64 %66
  store double 0.000000e+00, ptr %67, align 8, !tbaa !5
  br i1 %19, label %86, label %68

68:                                               ; preds = %65, %68
  %69 = phi i64 [ %83, %68 ], [ 0, %65 ]
  %70 = phi double [ %82, %68 ], [ 0.000000e+00, %65 ]
  %71 = phi i64 [ %84, %68 ], [ 0, %65 ]
  %72 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %69
  %73 = load double, ptr %72, align 8, !tbaa !5
  %74 = getelementptr inbounds [60 x double], ptr %4, i64 %69, i64 %66
  %75 = load double, ptr %74, align 8, !tbaa !5
  %76 = tail call double @llvm.fmuladd.f64(double %73, double %75, double %70)
  store double %76, ptr %67, align 8, !tbaa !5
  %77 = or disjoint i64 %69, 1
  %78 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %77
  %79 = load double, ptr %78, align 8, !tbaa !5
  %80 = getelementptr inbounds [60 x double], ptr %4, i64 %77, i64 %66
  %81 = load double, ptr %80, align 8, !tbaa !5
  %82 = tail call double @llvm.fmuladd.f64(double %79, double %81, double %76)
  store double %82, ptr %67, align 8, !tbaa !5
  %83 = add nuw nsw i64 %69, 2
  %84 = add i64 %71, 2
  %85 = icmp eq i64 %84, %20
  br i1 %85, label %86, label %68, !llvm.loop !15

86:                                               ; preds = %68, %65
  %87 = phi i64 [ 0, %65 ], [ %83, %68 ]
  %88 = phi double [ 0.000000e+00, %65 ], [ %82, %68 ]
  br i1 %21, label %95, label %89

89:                                               ; preds = %86
  %90 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %87
  %91 = load double, ptr %90, align 8, !tbaa !5
  %92 = getelementptr inbounds [60 x double], ptr %4, i64 %87, i64 %66
  %93 = load double, ptr %92, align 8, !tbaa !5
  %94 = tail call double @llvm.fmuladd.f64(double %91, double %93, double %88)
  store double %94, ptr %67, align 8, !tbaa !5
  br label %95

95:                                               ; preds = %86, %89
  %96 = add nuw nsw i64 %66, 1
  %97 = icmp eq i64 %96, %15
  br i1 %97, label %35, label %65, !llvm.loop !16

98:                                               ; preds = %61, %98
  %99 = phi i64 [ %115, %98 ], [ %62, %61 ]
  %100 = getelementptr inbounds double, ptr %5, i64 %99
  %101 = load double, ptr %100, align 8, !tbaa !5
  %102 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %99
  store double %101, ptr %102, align 8, !tbaa !5
  %103 = add nuw nsw i64 %99, 1
  %104 = getelementptr inbounds double, ptr %5, i64 %103
  %105 = load double, ptr %104, align 8, !tbaa !5
  %106 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %103
  store double %105, ptr %106, align 8, !tbaa !5
  %107 = add nuw nsw i64 %99, 2
  %108 = getelementptr inbounds double, ptr %5, i64 %107
  %109 = load double, ptr %108, align 8, !tbaa !5
  %110 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %107
  store double %109, ptr %110, align 8, !tbaa !5
  %111 = add nuw nsw i64 %99, 3
  %112 = getelementptr inbounds double, ptr %5, i64 %111
  %113 = load double, ptr %112, align 8, !tbaa !5
  %114 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %28, i64 %32, i64 %111
  store double %113, ptr %114, align 8, !tbaa !5
  %115 = add nuw nsw i64 %99, 4
  %116 = icmp eq i64 %115, %16
  br i1 %116, label %117, label %98, !llvm.loop !17

117:                                              ; preds = %61, %98, %49, %31, %35
  %118 = add nuw nsw i64 %32, 1
  %119 = icmp eq i64 %118, %14
  br i1 %119, label %120, label %31, !llvm.loop !18

120:                                              ; preds = %117, %27
  %121 = add nuw nsw i64 %28, 1
  %122 = icmp eq i64 %121, %13
  br i1 %122, label %123, label %27, !llvm.loop !19

123:                                              ; preds = %120, %6
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #2 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 120000, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 60, i32 noundef 8) #7
  %6 = ptrtoint ptr %5 to i64
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 3600, i32 noundef 8) #7
  br label %8

8:                                                ; preds = %38, %2
  %9 = phi i64 [ 0, %2 ], [ %39, %38 ]
  br label %10

10:                                               ; preds = %8, %35
  %11 = phi i64 [ 0, %8 ], [ %36, %35 ]
  %12 = mul nuw nsw i64 %11, %9
  %13 = insertelement <2 x i64> poison, i64 %12, i64 0
  %14 = shufflevector <2 x i64> %13, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %10
  %16 = phi i64 [ 0, %10 ], [ %32, %15 ]
  %17 = phi <2 x i64> [ <i64 0, i64 1>, %10 ], [ %33, %15 ]
  %18 = add nuw nsw <2 x i64> %17, %14
  %19 = trunc <2 x i64> %18 to <2 x i32>
  %20 = urem <2 x i32> %19, <i32 60, i32 60>
  %21 = sitofp <2 x i32> %20 to <2 x double>
  %22 = fdiv <2 x double> %21, <double 6.000000e+01, double 6.000000e+01>
  %23 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %9, i64 %11, i64 %16
  store <2 x double> %22, ptr %23, align 8, !tbaa !5
  %24 = or disjoint i64 %16, 2
  %25 = add <2 x i64> %17, <i64 2, i64 2>
  %26 = add nuw nsw <2 x i64> %25, %14
  %27 = trunc <2 x i64> %26 to <2 x i32>
  %28 = urem <2 x i32> %27, <i32 60, i32 60>
  %29 = sitofp <2 x i32> %28 to <2 x double>
  %30 = fdiv <2 x double> %29, <double 6.000000e+01, double 6.000000e+01>
  %31 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %9, i64 %11, i64 %24
  store <2 x double> %30, ptr %31, align 8, !tbaa !5
  %32 = add nuw nsw i64 %16, 4
  %33 = add <2 x i64> %17, <i64 4, i64 4>
  %34 = icmp eq i64 %32, 60
  br i1 %34, label %35, label %15, !llvm.loop !20

35:                                               ; preds = %15
  %36 = add nuw nsw i64 %11, 1
  %37 = icmp eq i64 %36, 40
  br i1 %37, label %38, label %10, !llvm.loop !21

38:                                               ; preds = %35
  %39 = add nuw nsw i64 %9, 1
  %40 = icmp eq i64 %39, 50
  br i1 %40, label %41, label %8, !llvm.loop !22

41:                                               ; preds = %38, %57
  %42 = phi i64 [ %58, %57 ], [ 0, %38 ]
  %43 = insertelement <2 x i64> poison, i64 %42, i64 0
  %44 = shufflevector <2 x i64> %43, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %45

45:                                               ; preds = %45, %41
  %46 = phi i64 [ 0, %41 ], [ %54, %45 ]
  %47 = phi <2 x i64> [ <i64 0, i64 1>, %41 ], [ %55, %45 ]
  %48 = mul nuw nsw <2 x i64> %47, %44
  %49 = trunc <2 x i64> %48 to <2 x i32>
  %50 = urem <2 x i32> %49, <i32 60, i32 60>
  %51 = sitofp <2 x i32> %50 to <2 x double>
  %52 = fdiv <2 x double> %51, <double 6.000000e+01, double 6.000000e+01>
  %53 = getelementptr inbounds [60 x double], ptr %7, i64 %42, i64 %46
  store <2 x double> %52, ptr %53, align 8, !tbaa !5
  %54 = add nuw i64 %46, 2
  %55 = add <2 x i64> %47, <i64 2, i64 2>
  %56 = icmp eq i64 %54, 60
  br i1 %56, label %57, label %45, !llvm.loop !23

57:                                               ; preds = %45
  %58 = add nuw nsw i64 %42, 1
  %59 = icmp eq i64 %58, 60
  br i1 %59, label %60, label %41, !llvm.loop !24

60:                                               ; preds = %57
  %61 = sub i64 %4, %6
  br label %62

62:                                               ; preds = %60, %143
  %63 = phi i64 [ %144, %143 ], [ 0, %60 ]
  %64 = mul nuw nsw i64 %63, 19200
  %65 = add i64 %61, %64
  br label %66

66:                                               ; preds = %140, %62
  %67 = phi i64 [ %141, %140 ], [ 0, %62 ]
  %68 = mul nuw nsw i64 %67, 480
  %69 = add i64 %65, %68
  br label %70

70:                                               ; preds = %89, %66
  %71 = phi i64 [ %90, %89 ], [ 0, %66 ]
  %72 = getelementptr inbounds double, ptr %5, i64 %71
  store double 0.000000e+00, ptr %72, align 8, !tbaa !5
  br label %73

73:                                               ; preds = %73, %70
  %74 = phi i64 [ 0, %70 ], [ %87, %73 ]
  %75 = phi double [ 0.000000e+00, %70 ], [ %86, %73 ]
  %76 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %74
  %77 = load double, ptr %76, align 8, !tbaa !5
  %78 = getelementptr inbounds [60 x double], ptr %7, i64 %74, i64 %71
  %79 = load double, ptr %78, align 8, !tbaa !5
  %80 = tail call double @llvm.fmuladd.f64(double %77, double %79, double %75)
  store double %80, ptr %72, align 8, !tbaa !5
  %81 = or disjoint i64 %74, 1
  %82 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %81
  %83 = load double, ptr %82, align 8, !tbaa !5
  %84 = getelementptr inbounds [60 x double], ptr %7, i64 %81, i64 %71
  %85 = load double, ptr %84, align 8, !tbaa !5
  %86 = tail call double @llvm.fmuladd.f64(double %83, double %85, double %80)
  store double %86, ptr %72, align 8, !tbaa !5
  %87 = add nuw nsw i64 %74, 2
  %88 = icmp eq i64 %87, 60
  br i1 %88, label %89, label %73, !llvm.loop !15

89:                                               ; preds = %73
  %90 = add nuw nsw i64 %71, 1
  %91 = icmp eq i64 %90, 60
  br i1 %91, label %92, label %70, !llvm.loop !16

92:                                               ; preds = %89
  %93 = icmp ult i64 %69, 16
  br i1 %93, label %117, label %94

94:                                               ; preds = %92, %94
  %95 = phi i64 [ %115, %94 ], [ 0, %92 ]
  %96 = getelementptr inbounds double, ptr %5, i64 %95
  %97 = load <2 x double>, ptr %96, align 8, !tbaa !5
  %98 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %95
  store <2 x double> %97, ptr %98, align 8, !tbaa !5
  %99 = add nuw nsw i64 %95, 2
  %100 = getelementptr inbounds double, ptr %5, i64 %99
  %101 = load <2 x double>, ptr %100, align 8, !tbaa !5
  %102 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %99
  store <2 x double> %101, ptr %102, align 8, !tbaa !5
  %103 = add nuw nsw i64 %95, 4
  %104 = getelementptr inbounds double, ptr %5, i64 %103
  %105 = load <2 x double>, ptr %104, align 8, !tbaa !5
  %106 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %103
  store <2 x double> %105, ptr %106, align 8, !tbaa !5
  %107 = add nuw nsw i64 %95, 6
  %108 = getelementptr inbounds double, ptr %5, i64 %107
  %109 = load <2 x double>, ptr %108, align 8, !tbaa !5
  %110 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %107
  store <2 x double> %109, ptr %110, align 8, !tbaa !5
  %111 = add nuw nsw i64 %95, 8
  %112 = getelementptr inbounds double, ptr %5, i64 %111
  %113 = load <2 x double>, ptr %112, align 8, !tbaa !5
  %114 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %111
  store <2 x double> %113, ptr %114, align 8, !tbaa !5
  %115 = add nuw nsw i64 %95, 10
  %116 = icmp eq i64 %115, 60
  br i1 %116, label %140, label %94, !llvm.loop !25

117:                                              ; preds = %92, %117
  %118 = phi i64 [ %138, %117 ], [ 0, %92 ]
  %119 = getelementptr inbounds double, ptr %5, i64 %118
  %120 = load double, ptr %119, align 8, !tbaa !5
  %121 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %118
  store double %120, ptr %121, align 8, !tbaa !5
  %122 = add nuw nsw i64 %118, 1
  %123 = getelementptr inbounds double, ptr %5, i64 %122
  %124 = load double, ptr %123, align 8, !tbaa !5
  %125 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %122
  store double %124, ptr %125, align 8, !tbaa !5
  %126 = add nuw nsw i64 %118, 2
  %127 = getelementptr inbounds double, ptr %5, i64 %126
  %128 = load double, ptr %127, align 8, !tbaa !5
  %129 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %126
  store double %128, ptr %129, align 8, !tbaa !5
  %130 = add nuw nsw i64 %118, 3
  %131 = getelementptr inbounds double, ptr %5, i64 %130
  %132 = load double, ptr %131, align 8, !tbaa !5
  %133 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %130
  store double %132, ptr %133, align 8, !tbaa !5
  %134 = add nuw nsw i64 %118, 4
  %135 = getelementptr inbounds double, ptr %5, i64 %134
  %136 = load double, ptr %135, align 8, !tbaa !5
  %137 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %63, i64 %67, i64 %134
  store double %136, ptr %137, align 8, !tbaa !5
  %138 = add nuw nsw i64 %118, 5
  %139 = icmp eq i64 %138, 60
  br i1 %139, label %140, label %117, !llvm.loop !26

140:                                              ; preds = %94, %117
  %141 = add nuw nsw i64 %67, 1
  %142 = icmp eq i64 %141, 40
  br i1 %142, label %143, label %66, !llvm.loop !18

143:                                              ; preds = %140
  %144 = add nuw nsw i64 %63, 1
  %145 = icmp eq i64 %144, 50
  br i1 %145, label %146, label %62, !llvm.loop !19

146:                                              ; preds = %143
  %147 = icmp sgt i32 %0, 42
  br i1 %147, label %148, label %191

148:                                              ; preds = %146
  %149 = load ptr, ptr %1, align 8, !tbaa !27
  %150 = load i8, ptr %149, align 1
  %151 = icmp eq i8 %150, 0
  br i1 %151, label %152, label %191

152:                                              ; preds = %148
  %153 = load ptr, ptr @stderr, align 8, !tbaa !27
  %154 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %153) #8
  %155 = load ptr, ptr @stderr, align 8, !tbaa !27
  %156 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %155, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %157

157:                                              ; preds = %183, %152
  %158 = phi i64 [ 0, %152 ], [ %184, %183 ]
  %159 = mul nuw nsw i64 %158, 2400
  br label %160

160:                                              ; preds = %180, %157
  %161 = phi i64 [ 0, %157 ], [ %181, %180 ]
  %162 = mul nuw nsw i64 %161, 60
  %163 = add nuw nsw i64 %162, %159
  br label %164

164:                                              ; preds = %173, %160
  %165 = phi i64 [ 0, %160 ], [ %178, %173 ]
  %166 = add nuw nsw i64 %163, %165
  %167 = trunc i64 %166 to i32
  %168 = urem i32 %167, 20
  %169 = icmp eq i32 %168, 0
  br i1 %169, label %170, label %173

170:                                              ; preds = %164
  %171 = load ptr, ptr @stderr, align 8, !tbaa !27
  %172 = tail call i32 @fputc(i32 10, ptr %171)
  br label %173

173:                                              ; preds = %170, %164
  %174 = load ptr, ptr @stderr, align 8, !tbaa !27
  %175 = getelementptr inbounds [40 x [60 x double]], ptr %3, i64 %158, i64 %161, i64 %165
  %176 = load double, ptr %175, align 8, !tbaa !5
  %177 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %174, ptr noundef nonnull @.str.5, double noundef %176) #8
  %178 = add nuw nsw i64 %165, 1
  %179 = icmp eq i64 %178, 60
  br i1 %179, label %180, label %164, !llvm.loop !29

180:                                              ; preds = %173
  %181 = add nuw nsw i64 %161, 1
  %182 = icmp eq i64 %181, 40
  br i1 %182, label %183, label %160, !llvm.loop !30

183:                                              ; preds = %180
  %184 = add nuw nsw i64 %158, 1
  %185 = icmp eq i64 %184, 50
  br i1 %185, label %186, label %157, !llvm.loop !31

186:                                              ; preds = %183
  %187 = load ptr, ptr @stderr, align 8, !tbaa !27
  %188 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %187, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %189 = load ptr, ptr @stderr, align 8, !tbaa !27
  %190 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %189) #8
  br label %191

191:                                              ; preds = %186, %148, %146
  tail call void @free(ptr noundef nonnull %3) #7
  tail call void @free(ptr noundef %5) #7
  tail call void @free(ptr noundef %7) #7
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #6

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nounwind }
attributes #7 = { nounwind }
attributes #8 = { cold }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"double", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10, !11, !12}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.isvectorized", i32 1}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
!13 = distinct !{!13, !14}
!14 = !{!"llvm.loop.unroll.disable"}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = distinct !{!17, !10, !11}
!18 = distinct !{!18, !10}
!19 = distinct !{!19, !10}
!20 = distinct !{!20, !10, !11, !12}
!21 = distinct !{!21, !10}
!22 = distinct !{!22, !10}
!23 = distinct !{!23, !10, !11, !12}
!24 = distinct !{!24, !10}
!25 = distinct !{!25, !10, !11, !12}
!26 = distinct !{!26, !10, !11}
!27 = !{!28, !28, i64 0}
!28 = !{!"any pointer", !7, i64 0}
!29 = distinct !{!29, !10}
!30 = distinct !{!30, !10}
!31 = distinct !{!31, !10}
