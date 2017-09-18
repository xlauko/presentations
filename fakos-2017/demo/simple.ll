
// Input program:

int main() {
    __zero__ int in;
    if ( in == 0 )
        return 0;
    assert( in != 0 );
}

// Abstraction -> Substitution


// Input program llvm:

define i32 @main() #0 {
entry:
  %in = alloca i32, align 4
  call void @llvm.var.annotation( ... )
  %0 = load i32, i32* %in, align 4,
  %cmp = icmp ne i32 %0, 0,
  br i1 %cmp, label %if.then, label %if.end,
if.then:
  %1 = load i32, i32* %in, align 4,
  %cmp2 = icmp ne i32 %1, 0,
  br i1 %cmp2, label %if.end, label %if.then.3,
if.then.3:
  call void @_PDCLIB_assert_dios( ... )
  br label %if.end,
if.end:
  ret i32 0,
}



// Instrumentation: abstraction

define i32 @main() #0 {
entry:
  %0 = call %lart.i32* @lart.alloca.i32()
  %2 = call %lart.i32 @lart.load.i32(%lart.i32* %0)
  %3 = call %lart.i32 @lart.lift.i32(i32 0)
  %4 = call %lart.i1 @lart.icmp_ne.i32(%lart.i32 %2, %lart.i32 %3)
  %5 = call %lart.tristate @lart.bool_to_tristate(%lart.i1 %4)
  %6 = call i1 @lart.tristate.lower(%lart.tristate %5)
  br i1 %6, label %if.then, label %if.end
if.then:
  %7 = call %lart.i32 @lart.load.i32(%lart.i32* %0)
  %8 = call %lart.i32 @lart.lift.i32(i32 0)
  %9 = call %lart.i1 @lart.icmp_ne.i32(%lart.i32 %7, %lart.i32 %8)
  %10 = call %lart.tristate @lart.bool_to_tristate(%lart.i1 %9)
  %11 = call i1 @lart.tristate.lower(%lart.tristate %10)
  br i1 %11, label %if.end, label %if.then.3
  if.then.3:
  call void @_PDCLIB_assert_dios( ... )
  br label %if.end,
if.end:
  ret i32 0,
}



// Instrumentation: assume insertion

define i32 @main() #0 {
entry:
  %0 = call %lart.i32* @lart.alloca.i32()
  %2 = call %lart.i32 @lart.load.i32(%lart.i32* %0)
  %3 = call %lart.i32 @lart.lift.i32(i32 0)
  %4 = call %lart.i1 @lart.icmp_ne.i32(%lart.i32 %2, %lart.i32 %3)
  %5 = call %lart.tristate @lart.bool_to_tristate(%lart.i1 %4)
  %6 = call i1 @lart.tristate.lower(%lart.tristate %5)
  br i1 %6, label %if.then, label %if.end
if.then:
  call void @lart.assume(%lart.tristate %5, i1 true), <--- ASSUME
  %7 = call %lart.i32 @lart.load.i32(%lart.i32* %0)
  %8 = call %lart.i32 @lart.lift.i32(i32 0)
  %9 = call %lart.i1 @lart.icmp_ne.i32(%lart.i32 %7, %lart.i32 %8)
  %10 = call %lart.tristate @lart.bool_to_tristate(%lart.i1 %9)
  %11 = call i1 @lart.tristate.lower(%lart.tristate %10)
  br i1 %11, label %if.end, label %if.then.3
if.then.3:
  call void @lart.assume(%lart.tristate %5, i1 false) <--- ASSUME
  call void @_PDCLIB_assert_dios( ... )
  br label %if.end,
if.end:
  ret i32 0,
}



// Instrumentation: constraint propagation

define i32 @main() #0 {
entry:
  %0 = call %lart.i32* @lart.alloca.i32()
  %2 = call %lart.i32 @lart.load.i32(%lart.i32* %0)
  %3 = call %lart.i32 @lart.lift.i32(i32 0)
  %4 = call %lart.i1 @lart.icmp_ne.i32(%lart.i32 %2, %lart.i32 %3)
  %5 = call %lart.tristate @lart.bool_to_tristate(%lart.i1 %4)
  %6 = call i1 @lart.tristate.lower(%lart.tristate %5)
  br i1 %6, label %if.then, label %if.end
if.then:
  %7 = call %lart.i32 @lart.assume(%lart.i32 %2, %lart.i1 %4, i1 true)
  %8 = call %lart.i32 @lart.assume(%lart.i32 %3, %lart.i1 %4, i1 true)
  %9 = call %lart.i1 @lart.assume(%lart.i1 %4, %lart.i1 %4, i1 true)

  %11 = call %lart.i32 @lart.lift.i32(i32 0)
  %12 = call %lart.i1 @lart.icmp_ne.i32(%lart.i32 %7, %lart.i32 %11)
  ...
}



// Instrumentation: domain substitution

define i32 @main() #0 {
entry:
  %0 = call %struct.zero** @__abstract_zero_alloca()
  %1 = call %struct.zero* @__abstract_zero_load(%struct.zero** %0)
  %2 = call %struct.zero* @__abstract_zero_lift_i32(i32 0)
  %3 = call %struct.zero* @__abstract_zero_icmp_eq(%struct.zero* %1, %struct.zero* %2)
  %4 = call %struct.zero* @__abstract_zero_bool_to_tristate(%struct.zero* %3)
  %5 = call i1 @__abstract_tristate_lower(%struct.zero* %4)
  br i1 %5, label %if.then, label %if.end
if.then:
  %6 = call %struct.zero* @__abstract_zero_assume(%struct.zero* %1, %struct.zero* %3, i1 true)
  %7 = call %struct.zero* @__abstract_zero_assume(%struct.zero* %2, %struct.zero* %3, i1 true)
  %8 = call %struct.zero* @__abstract_zero_assume(%struct.zero* %3, %struct.zero* %3, i1 true)
  br label %if.then.split
if.then.split:
  ...
}

