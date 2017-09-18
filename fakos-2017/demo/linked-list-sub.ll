; Function Attrs: uwtable
define i32 @main() #0 {
entry:
  %ns = alloca %"struct.std::__2::array", align 8
  %list = alloca %struct.List, align 8
  %0 = call %"union.sym::Formula.2.13"** @__abstract_sym_alloca(i32 64)
  call void @llvm.dbg.declare(metadata %"struct.std::__2::array"* %ns, metadata !232576, metadata !232577), !dbg !232578
  %__elems_ = getelementptr inbounds %"struct.std::__2::array", %"struct.std::__2::array"* %ns, i32 0, i32 0, !dbg !232579
  %arrayinit.begin = getelementptr inbounds [3 x %struct.Node], [3 x %struct.Node]* %__elems_, i64 0, i64 0, !dbg !232580
  call void @_ZN4NodeC2Ei(%struct.Node* %arrayinit.begin, i32 1), !dbg !232580
  %arrayinit.element = getelementptr inbounds %struct.Node, %struct.Node* %arrayinit.begin, i64 1, !dbg !232580
  call void @_ZN4NodeC2Ei(%struct.Node* %arrayinit.element, i32 2), !dbg !232581
  %arrayinit.element1 = getelementptr inbounds %struct.Node, %struct.Node* %arrayinit.element, i64 1, !dbg !232580
  call void @_ZN4NodeC2Ei(%struct.Node* %arrayinit.element1, i32 3), !dbg !232582
  call void @llvm.dbg.declare(metadata %struct.List* %list, metadata !232583, metadata !232577), !dbg !232584
  %call = call %struct.Node* @_Z9make_listINSt3__25arrayI4NodeLm3EEEE4ListIT_ERS5_(%"struct.std::__2::array"* dereferenceable(48) %ns), !dbg !232585
  %coerce.dive = getelementptr %struct.List, %struct.List* %list, i32 0, i32 0, !dbg !232585
  store %struct.Node* %call, %struct.Node** %coerce.dive, align 8, !dbg !232585
  call void @llvm.dbg.declare(metadata i64* undef, metadata !232586, metadata !232577), !dbg !232587
  call void @llvm.dbg.declare(metadata !2, metadata !232588, metadata !232577), !dbg !232589
  %1 = call %"union.sym::Formula.2.13"* @__abstract_sym_load(%"union.sym::Formula.2.13"** %0, i32 64), !dbg !232590
  %2 = call %struct.Node* @_ZN4ListINSt3__25arrayI4NodeLm3EEEE2atEm.1487.1491(%struct.List* %list, %"union.sym::Formula.2.13"* %1), !dbg !232591
  call void @llvm.dbg.value(metadata %struct.Node* %2, i64 0, metadata !232588, metadata !232577), !dbg !232589
  %cmp = icmp eq %struct.Node* %2, null, !dbg !232592
  br i1 %cmp, label %if.end, label %lor.lhs.false, !dbg !232592

lor.lhs.false:                                    ; preds = %entry
  %val = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 0, !dbg !232596
  %3 = load i32, i32* %val, align 4, !dbg !232596
  %cmp4 = icmp eq i32 %3, 1, !dbg !232596
  br i1 %cmp4, label %if.end, label %lor.lhs.false.5, !dbg !232596

lor.lhs.false.5:                                  ; preds = %lor.lhs.false
  %val6 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 0, !dbg !232598
  %4 = load i32, i32* %val6, align 4, !dbg !232598
  %cmp7 = icmp eq i32 %4, 2, !dbg !232598
  br i1 %cmp7, label %if.end, label %lor.lhs.false.8, !dbg !232598

lor.lhs.false.8:                                  ; preds = %lor.lhs.false.5
  %val9 = getelementptr inbounds %struct.Node, %struct.Node* %2, i32 0, i32 0, !dbg !232600
  %5 = load i32, i32* %val9, align 4, !dbg !232600
  %cmp10 = icmp eq i32 %5, 3, !dbg !232600
  br i1 %cmp10, label %if.end, label %if.then, !dbg !232602

if.then:                                          ; preds = %lor.lhs.false.8
  call void @_PDCLIB_assert_dios(i8* getelementptr inbounds ([116 x i8], [116 x i8]* @.str.2, i32 0, i32 0)) #3, !dbg !232603
  br label %if.end, !dbg !232603

if.end:                                           ; preds = %if.then, %lor.lhs.false.8, %lor.lhs.false.5, %lor.lhs.false, %entry
  ret i32 0, !dbg !232606
}
