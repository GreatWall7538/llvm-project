//==--- DiagnosticASTKinds.td - libast diagnostics ------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

let Component = "AST" in {

// Constant expression diagnostics. These (and their users) belong in Sema.
def note_expr_divide_by_zero : Note<"division by zero" "\n" "提示：除以零">;
def note_constexpr_invalid_cast : Note<
  "%enum_select<ConstexprInvalidCastKind>{%Reinterpret{reinterpret_cast}|%Dynamic{dynamic_cast}|"
  "%ThisConversionOrReinterpret{%select{this conversion|cast that performs the conversions "
  "of a reinterpret_cast}1}|%CastFrom{cast from %1}}0"
  " is not allowed in a constant expression"
  "%select{| in C++ standards before C++20||}0"
  "\n" "提示：%enum_select<ConstexprInvalidCastKind>{%Reinterpret{reinterpret_cast}|%Dynamic{dynamic_cast}|"
  "%ThisConversionOrReinterpret{%select{此转换|进行 reinterpret_cast 转换的强制转换}1}|%CastFrom{从 %1 进行强制转换}}0 "
  "不允许出现在常量表达式中"
  "%select{|在 C++20 之前的 C++ 标准中||}0">;
def note_constexpr_invalid_void_star_cast : Note<
  "cast from %0 is not allowed in a constant expression "
  "%select{in C++ standards before C++2c|because the pointed object "
  "type %2 is not similar to the target type %3}1"
  "\n" "提示：从 %0 进行强制转换不允许出现在常量表达式中 "
  "%select{在 C++2c 之前的 C++ 标准中|因为所指对象的类型 %2 与目标类型 %3 不相似}1">;
def note_constexpr_invalid_downcast : Note<
  "cannot cast object of dynamic type %0 to type %1"
  "\n" "提示：无法将动态类型为 %0 的对象转换为类型 %1">;
def note_constexpr_overflow : Note<
  "value %0 is outside the range of representable values of type %1"
  "\n" "提示：值 %0 超出类型 %1 可表示值的范围">;
def note_constexpr_offsetof_overflow : Note<
  "overflow in offsetof"
  "\n" "提示：offsetof 中出现溢出">;
def note_constexpr_negative_shift : Note<"negative shift count %0" "\n" "提示：移位计数 %0 为负">;
def note_constexpr_large_shift : Note<
  "shift count %0 >= width of type %1 (%2 bit%s2)"
  "\n" "提示：移位计数 %0 >= 类型 %1 的宽度（%2 位%s2）">;
def note_constexpr_lshift_of_negative : Note<"left shift of negative value %0" "\n" "提示：对负值 %0 进行左移">;
def note_constexpr_lshift_discards : Note<"signed left shift discards bits" "\n" "提示：有符号左移丢弃位">;
def note_constexpr_invalid_function : Note<
  "%select{non-constexpr|undefined}0 %select{function|constructor}1 %2 cannot "
  "be used in a constant expression"
  "\n" "提示：%select{非 constexpr|未定义}0 %select{函数|构造函数}1 %2 不能用于常量表达式">;
def note_constexpr_invalid_inhctor : Note<
  "constructor inherited from base class %0 cannot be used in a "
  "constant expression; derived class cannot be implicitly initialized"
  "\n" "提示：从基类 %0 继承的构造函数不能用于常量表达式；派生类无法隐式初始化">;
def note_constexpr_no_return : Note<
  "control reached end of constexpr function"
  "\n" "提示：控制流到达 constexpr 函数末尾">;
def note_constexpr_virtual_call : Note<
  "cannot evaluate call to virtual function in a constant expression "
  "in C++ standards before C++20"
  "\n" "提示：在 C++20 之前的 C++ 标准中，无法在常量表达式中求值对虚函数的调用">;
def note_constexpr_pure_virtual_call : Note<
  "pure virtual function %q0 called"
  "\n" "提示：调用了纯虚函数 %q0">;
def note_constexpr_polymorphic_unknown_dynamic_type : Note<
  "%select{|||||virtual function called on|dynamic_cast applied to|"
  "typeid applied to|construction of|destruction of}0 object '%1' "
  "whose dynamic type is not constant"
  "\n" "提示：%select{|||||对……调用虚函数|对……应用 dynamic_cast|对……应用 typeid|构造……|销毁……}0 "
  "动态类型不是常量的对象 '%1'">;
def note_constexpr_dynamic_cast_to_reference_failed : Note<
  "reference dynamic_cast failed: %select{"
  "static type %1 of operand is a non-public base class of dynamic type %2|"
  "dynamic type %2 of operand does not have a base class of type %3|"
  "%3 is an ambiguous base class of dynamic type %2 of operand|"
  "%3 is a non-public base class of dynamic type %2 of operand}0"
  "\n" "提示：引用 dynamic_cast 失败：%select{操作数的静态类型 %1 是动态类型 %2 的非公开基类|"
  "操作数的动态类型 %2 没有类型为 %3 的基类|"
  "%3 是操作数的动态类型 %2 的歧义基类|"
  "%3 是操作数的动态类型 %2 的非公开基类}0">;
def note_constexpr_virtual_base : Note<
  "cannot construct object of type %0 with virtual base class "
  "in a constant expression"
  "\n" "提示：无法在常量表达式中构造带有虚基类的类型 %0 的对象">;
def note_constexpr_nonliteral : Note<
  "non-literal type %0 cannot be used in a constant expression"
  "\n" "提示：非字面量类型 %0 不能用于常量表达式">;
def note_constexpr_non_global : Note<
  "%select{pointer|reference}0 to %select{|subobject of }1"
  "%select{temporary|%3}2 is not a constant expression"
  "\n" "提示：%select{指针|引用}0 指向%select{|子对象 }1%select{临时对象|%3}2 不是常量表达式">;
def note_constexpr_not_static : Note<
  "address of non-static constexpr variable %0 may differ on each invocation "
  "of the enclosing function; add 'static' to give it a constant address"
  "\n" "提示：非 static 的 constexpr 变量 %0 的地址在每次调用外层函数时可能不同；添加 'static' 以赋予其常量地址">;
def note_constexpr_dynamic_alloc : Note<
  "%select{pointer|reference}0 to %select{|subobject of }1"
  "heap-allocated object is not a constant expression"
  "\n" "提示：指向堆分配对象%select{|的子对象 }1的%select{指针|引用}0 不是常量表达式">;
def note_consteval_address_accessible : Note<
  "%select{pointer|reference}0 to a consteval declaration "
  "is not a constant expression"
  "\n" "提示：指向 consteval 声明的%select{指针|引用}0 不是常量表达式">;
def note_constexpr_uninitialized : Note<
  "subobject %select{of type |}0%1 is not initialized"
  "\n" "提示：子对象 %select{类型为 |}0%1 未被初始化">;
def note_constexpr_uninitialized_base : Note<
  "constructor of base class %0 is not called"
  "\n" "提示：基类 %0 的构造函数未被调用">;
def note_constexpr_static_local : Note<
  "control flows through the definition of a %select{static|thread_local}0 variable"
  "\n" "提示：控制流经过 %select{static|thread_local}0 变量的定义">;
def note_constexpr_subobject_declared_here : Note<
  "subobject declared here"
  "\n" "提示：子对象在此处声明">;
def note_constexpr_array_index : Note<"cannot refer to element %0 of "
  "%select{array of %2 element%plural{1:|:s}2|non-array object}1 "
  "in a constant expression"
  "\n" "提示：不能在常量表达式中引用 %select{包含 %2 个元素%plural{1:|:}2的数组|非数组对象}1 中的元素 %0">;
def note_constexpr_float_arithmetic : Note<
  "floating point arithmetic produces %select{an infinity|a NaN}0"
  "\n" "提示：浮点运算产生%select{无穷大|NaN}0">;
def note_constexpr_dynamic_rounding : Note<
  "cannot evaluate this expression if rounding mode is dynamic"
  "\n" "提示：如果舍入模式是动态的，则无法求值此表达式">;
def note_constexpr_float_arithmetic_strict : Note<
  "compile time floating point arithmetic suppressed in strict evaluation modes"
  "\n" "提示：在严格求值模式下，编译期浮点运算被禁止">;
def note_constexpr_pointer_subtraction_not_same_array : Note<
  "subtracted pointers are not elements of the same array"
  "\n" "提示：被相减的指针不是同一数组的元素">;
def note_constexpr_pointer_subtraction_zero_size : Note<
  "subtraction of pointers to type %0 of zero size"
  "\n" "提示：对指向大小为零的类型 %0 的指针进行减法">;
def note_constexpr_pointer_comparison_unspecified : Note<
  "comparison between pointers to unrelated objects '%0' and '%1' has unspecified value"
  "\n" "提示：指向无关对象 '%0' 和 '%1' 的指针之间的比较具有未指定值">;
def note_constexpr_pointer_arith_unspecified : Note<
  "arithmetic involving unrelated objects '%0' and '%1' has unspecified value"
  "\n" "提示：涉及无关对象 '%0' 和 '%1' 的运算具有未指定值">;
def note_constexpr_pointer_constant_comparison : Note<
  "comparison of numeric address '%0' with pointer '%1' can only be performed "
  "at runtime"
  "\n" "提示：数值地址 '%0' 与指针 '%1' 的比较只能在运行时进行">;
def note_constexpr_literal_comparison : Note<
  "comparison of addresses of potentially overlapping literals has unspecified value"
  "\n" "提示：对可能重叠的字面量的地址进行比较具有未指定值">;
def note_constexpr_literal_arith : Note<
  "arithmetic on addresses of potentially overlapping literals has unspecified value"
  "\n" "提示：对可能重叠的字面量的地址进行运算具有未指定值">;
def note_constexpr_repeated_literal_eval : Note<
  "repeated evaluation of the same literal expression can produce different objects"
  "\n" "提示：对同一字面量表达式进行重复求值可能产生不同的对象">;
def note_constexpr_opaque_call_comparison : Note<
  "comparison against opaque constant address '%0' can only be performed at "
  "runtime"
  "\n" "提示：与不透明常量地址 '%0' 的比较只能在运行时进行">;
def note_constexpr_pointer_weak_comparison : Note<
  "comparison against address of weak declaration '%0' can only be performed "
  "at runtime"
  "\n" "提示：与弱声明 '%0' 的地址的比较只能在运行时进行">;
def note_constexpr_mem_pointer_weak_comparison : Note<
  "comparison against pointer to weak member %q0 can only be performed "
  "at runtime"
  "\n" "提示：与指向弱成员 %q0 的指针的比较只能在运行时进行">;
def note_constexpr_pointer_comparison_past_end : Note<
  "comparison against pointer '%0' that points past the end of a "
  "complete object has unspecified value"
  "\n" "提示：与指向完整对象末尾之后的指针 '%0' 的比较具有未指定值">;
def note_constexpr_pointer_comparison_zero_sized : Note<
  "comparison of pointers '%0' and '%1' to unrelated zero-sized objects"
  "\n" "提示：对指向无关的零大小对象的指针 '%0' 和 '%1' 进行比较">;
def note_constexpr_pointer_comparison_base_classes : Note<
  "comparison of addresses of subobjects of different base classes "
  "has unspecified value"
  "\n" "提示：对不同基类的子对象的地址进行比较具有未指定值">;
def note_constexpr_pointer_comparison_base_field : Note<
  "comparison of address of base class subobject %0 of class %1 to field %2 "
  "has unspecified value"
  "\n" "提示：类 %1 的基类子对象 %0 的地址与字段 %2 的比较具有未指定值">;
def note_constexpr_pointer_comparison_differing_access : Note<
  "comparison of address of fields %0 and %2 of %4 with differing access "
  "specifiers (%1 vs %3) has unspecified value"
  "\n" "提示：对 %4 的字段 %0 和 %2 的地址（访问说明符不同：%1 对比 %3）进行比较具有未指定值">;
def note_constexpr_compare_virtual_mem_ptr : Note<
  "comparison of pointer to virtual member function %0 has unspecified value"
  "\n" "提示：指向虚成员函数 %0 的指针的比较具有未指定值">;
def note_constexpr_past_end : Note<
  "dereferenced pointer past the end of %select{|subobject of }0"
  "%select{temporary|%2}1 is not a constant expression"
  "\n" "提示：解引用超出%select{|子对象 }0%select{临时对象|%2}1 末尾的指针不是常量表达式">;
def note_constexpr_past_end_subobject : Note<
  "cannot %select{access base class of|access derived class of|access field of|"
  "access array element of|ERROR|"
  "access real component of|access imaginary component of}0 "
  "pointer past the end of object"
  "\n" "提示：不能对超出对象末尾的指针%select{访问其基类|访问其派生类|访问其字段|访问其数组元素|ERROR|访问其实部|访问其虚部}0">;
def note_non_null_attribute_failed : Note<
  "null passed to a callee that requires a non-null argument"
  "\n" "提示：将空指针传递给了要求非空实参的被调用方">;
def note_constexpr_null_subobject : Note<
  "cannot %select{access base class of|access derived class of|access field of|"
  "access array element of|perform pointer arithmetic on|"
  "access real component of|"
  "access imaginary component of}0 null pointer"
  "\n" "提示：不能对空指针%select{访问其基类|访问其派生类|访问其字段|访问其数组元素|执行指针运算|访问其实部|访问其虚部}0">;
def note_constexpr_null_callee
    : Note<"%0 evaluates to a null function pointer"
      "\n" "提示：%0 求值为空函数指针">;
def note_constexpr_function_param_value_unknown : Note<
  "function parameter %0 with unknown value cannot be used in a constant "
  "expression"
  "\n" "提示：值未知的函数形参 %0 不能用于常量表达式">;
def note_constexpr_var_init_unknown : Note<
  "initializer of %0 is unknown"
  "\n" "提示：%0 的初始化式未知">;
def note_constexpr_var_init_non_constant : Note<
  "initializer of %0 is not a constant expression"
  "\n" "提示：%0 的初始化式不是常量表达式">;
def note_constexpr_var_init_weak : Note<
  "initializer of weak variable %0 is not considered constant because "
  "it may be different at runtime"
  "\n" "提示：弱变量 %0 的初始化式不被视为常量，因为它在运行时可能不同">;
def note_constexpr_typeid_polymorphic : Note<
  "typeid applied to expression of polymorphic type %0 is "
  "not allowed in a constant expression in C++ standards before C++20"
  "\n" "提示：在 C++20 之前的 C++ 标准中，不允许在常量表达式中对多态类型 %0 的表达式应用 typeid">;
def note_constexpr_temporary_here : Note<"temporary created here" "\n" "提示：临时对象在此处创建">;
def note_constexpr_dynamic_alloc_here : Note<"heap allocation performed here" "\n" "提示：在此处执行了堆分配">;
def note_constexpr_conditional_never_const : Note<
  "both arms of conditional operator are unable to produce a "
  "constant expression"
  "\n" "提示：条件运算符的两个分支都无法产生常量表达式">;
def note_constexpr_depth_limit_exceeded : Note<
  "constexpr evaluation exceeded maximum depth of %0 calls"
  "\n" "提示：constexpr 求值超出最大调用深度 %0">;
def note_constexpr_call_limit_exceeded : Note<
  "constexpr evaluation hit maximum call limit"
  "\n" "提示：constexpr 求值达到最大调用次数限制">;
def note_constexpr_step_limit_exceeded : Note<
  "constexpr evaluation hit maximum step limit; possible infinite loop?"
  "\n" "提示：constexpr 求值达到最大步数限制；可能是无限循环？">;
def note_constexpr_heap_alloc_limit_exceeded : Note<
  "constexpr evaluation hit maximum heap allocation limit"
  "\n" "提示：constexpr 求值达到最大堆分配限制">;
def note_constexpr_this : Note<
  "%select{|implicit }0use of 'this' pointer is only allowed within the "
  "evaluation of a call to a 'constexpr' member function"
  "\n" "提示：仅在求值对 'constexpr' 成员函数的调用时才允许%select{|隐式 }0使用 'this' 指针">;
def access_kind
    : TextSubstitution<
          "%select{read of|read of|assignment to|increment of|decrement of|"
          "member call on|dynamic_cast of|typeid applied to|construction of|"
          "destruction of|read of|read of}0"
          "\n" "%select{读取|读取|赋值给|递增|递减|"
          "调用……上的成员|对……进行 dynamic_cast|对……应用 typeid|构造……|"
          "销毁……|读取|读取}0">;
def access_kind_subobject : TextSubstitution<
  "%select{read of|read of|assignment to|increment of|decrement of|"
  "member call on|dynamic_cast of|typeid applied to|"
  "construction of subobject of|destruction of|read of}0"
  "\n" "%select{读取|读取|赋值给|递增|递减|"
  "调用……上的成员|对……进行 dynamic_cast|对……应用 typeid|"
  "构造……的子对象|销毁……|读取}0">;
def access_kind_volatile : TextSubstitution<
  "%select{read of|read of|assignment to|increment of|decrement of|"
  "<ERROR>|<ERROR>|<ERROR>|<ERROR>|<ERROR>|<ERROR>}0"
  "\n" "%select{读取|读取|赋值给|递增|递减|"
  "<ERROR>|<ERROR>|<ERROR>|<ERROR>|<ERROR>|<ERROR>}0">;
def note_constexpr_access_uninit : Note<
  "%sub{access_kind_subobject}0 "
  "%select{object outside its lifetime|uninitialized object}1 "
  "is not allowed in a constant expression"
  "\n" "提示：%sub{access_kind_subobject}0 %select{生存期之外的对象|未初始化的对象}1 不允许出现在常量表达式中">;
def note_constexpr_use_uninit_reference : Note<
  "use of reference outside its lifetime "
  "is not allowed in a constant expression"
  "\n" "提示：在生存期之外使用引用不允许出现在常量表达式中">;
def note_constexpr_modify_const_type : Note<
  "modification of object of const-qualified type %0 is not allowed "
  "in a constant expression"
  "\n" "提示：对 const 限定类型 %0 的对象进行修改不允许出现在常量表达式中">;
def note_constexpr_access_volatile_type : Note<
  "%sub{access_kind_volatile}0 "
  "volatile-qualified type %1 is not allowed in a constant expression"
  "\n" "提示：%sub{access_kind_volatile}0 volatile 限定的类型 %1 不允许出现在常量表达式中">;
def note_constexpr_access_volatile_obj : Note<
  "%sub{access_kind_volatile}0 "
  "volatile %select{temporary|object %2|member %2}1 is not allowed in "
  "a constant expression"
  "\n" "提示：%sub{access_kind_volatile}0 volatile %select{临时对象|对象 %2|成员 %2}1 不允许出现在常量表达式中">;
def note_constexpr_volatile_here : Note<
  "volatile %select{temporary created|object declared|member declared}0 here"
  "\n" "提示：此处%select{创建了 volatile 临时对象|声明了 volatile 对象|声明了 volatile 成员}0">;
def note_constexpr_access_mutable : Note<
  "%sub{access_kind}0 "
  "mutable member %1 is not allowed in a constant expression"
  "\n" "提示：%sub{access_kind}0 mutable 成员 %1 不允许出现在常量表达式中">;
def note_constexpr_ltor_non_const_int : Note<
  "read of non-const variable %0 is not allowed in a constant expression"
  "\n" "提示：读取非 const 变量 %0 不允许出现在常量表达式中">;
def note_constexpr_ltor_non_integral : Note<
  "read of variable %0 of non-integral, non-enumeration type %1 "
  "is not allowed in a constant expression"
  "\n" "提示：读取非整数、非枚举类型 %1 的变量 %0 不允许出现在常量表达式中">;
def note_constexpr_ltor_non_constexpr : Note<
  "read of non-constexpr variable %0 is not allowed in a constant expression"
  "\n" "提示：读取非 constexpr 变量 %0 不允许出现在常量表达式中">;
def note_constexpr_ltor_incomplete_type : Note<
  "read of incomplete type %0 is not allowed in a constant expression"
  "\n" "提示：读取不完整类型 %0 不允许出现在常量表达式中">;
def note_constexpr_access_null : Note<
  "%sub{access_kind}0 "
  "dereferenced null pointer is not allowed in a constant expression"
  "\n" "提示：%sub{access_kind}0 解引用空指针不允许出现在常量表达式中">;
def note_constexpr_dereferencing_null
    : Note<"dereferencing a null pointer is not allowed in a constant "
           "expression"
           "\n" "提示：解引用空指针不允许出现在常量表达式中">;
def note_constexpr_access_past_end : Note<
  "%sub{access_kind}0 dereferenced one-past-the-end pointer "
  "is not allowed in a constant expression"
  "\n" "提示：%sub{access_kind}0 解引用末尾之后一个位置的指针不允许出现在常量表达式中">;
def note_constexpr_access_unsized_array : Note<
  "%sub{access_kind}0 element of array without known bound "
  "is not allowed in a constant expression"
  "\n" "提示：%sub{access_kind}0 未知边界的数组的元素不允许出现在常量表达式中">;
def note_constexpr_access_inactive_union_member : Note<
  "%sub{access_kind_subobject}0 "
  "member %1 of union with %select{active member %3|no active member}2 "
  "is not allowed in a constant expression"
  "\n" "提示：%sub{access_kind_subobject}0 具有%select{活跃成员 %3|无活跃成员}2 的联合的成员 %1 不允许出现在常量表达式中">;
def note_constexpr_union_member_change_during_init : Note<
  "assignment would change active union member during the initialization of "
  "a different member of the same union"
  "\n" "提示：在初始化同一联合的另一个成员期间，赋值会更改活跃的联合成员">;
def note_constexpr_access_static_temporary : Note<
  "%sub{access_kind}0 temporary is not allowed in a constant expression "
  "outside the expression that created the temporary"
  "\n" "提示：在创建临时对象的表达式之外，%sub{access_kind}0 临时对象不允许出现在常量表达式中">;
def note_constexpr_access_unreadable_object : Note<
  "%sub{access_kind}0 object '%1' whose value is not known"
  "\n" "提示：%sub{access_kind}0 值未知的对象 '%1'">;
def note_constexpr_access_unknown_variable : Note<
  "%sub{access_kind}0 variable %1 whose value is not known"
  "\n" "提示：%sub{access_kind}0 值未知的变量 %1">;
def note_constexpr_access_deleted_object : Note<
  "%sub{access_kind}0 heap allocated object that has been deleted"
  "\n" "提示：%sub{access_kind}0 已被删除的堆分配对象">;
def note_constexpr_modify_global : Note<
  "a constant expression cannot modify an object that is visible outside "
  "that expression"
  "\n" "提示：常量表达式不能修改在该表达式之外可见的对象">;
def note_constexpr_stmt_expr_unsupported : Note<
  "this use of statement expressions is not supported in a "
  "constant expression"
  "\n" "提示：不支持在常量表达式中使用此语句表达式">;
def note_constexpr_calls_suppressed : Note<
  "(skipping %0 call%s0 in backtrace; use -fconstexpr-backtrace-limit=0 to "
  "see all)"
  "\n" "提示：（回溯中跳过 %0 个调用%s0；使用 -fconstexpr-backtrace-limit=0 查看全部）">;
def note_constexpr_call_here : Note<"in call to '%0'" "\n" "提示：在调用 '%0' 中">;
def note_constexpr_inherited_ctor_call_here : Note<
  "in implicit initialization for inherited constructor of %0"
  "\n" "提示：在 %0 的继承构造函数的隐式初始化中">;
def note_constexpr_baa_insufficient_alignment : Note<
  "%select{alignment of|offset of the aligned pointer from}0 the base pointee "
  "object (%1 %plural{1:byte|:bytes}1) is %select{less than|not a multiple of}0 the "
  "asserted %2 %plural{1:byte|:bytes}2"
  "\n" "提示：%select{……的对齐|对齐指针相对……的偏移}0 基点所指对象（%1 %plural{1:字节|:字节}1）"
  "%select{小于|不是……的整数倍}0 断言的 %2 %plural{1:字节|:字节}2">;
def note_constexpr_baa_value_insufficient_alignment : Note<
  "value of the aligned pointer (%0) is not a multiple of the asserted %1 "
  "%plural{1:byte|:bytes}1"
  "\n" "提示：对齐指针的值（%0）不是断言的 %1 %plural{1:字节|:字节}1 的整数倍">;
def note_constexpr_invalid_alignment : Note<
  "requested alignment %0 is not a positive power of two"
  "\n" "提示：请求的对齐 %0 不是正的 2 的幂">;
def note_constexpr_alignment_too_big : Note<
  "requested alignment must be %0 or less for type %1; %2 is invalid"
  "\n" "提示：类型 %1 请求的对齐必须为 %0 或更小；%2 无效">;
def note_constexpr_alignment_compute : Note<
  "cannot constant evaluate whether run-time alignment is at least %0"
  "\n" "提示：无法常量求值运行时对齐是否至少为 %0">;
def note_constexpr_alignment_adjust : Note<
  "cannot constant evaluate the result of adjusting alignment to %0"
  "\n" "提示：无法常量求值将对齐调整为 %0 的结果">;
def note_constexpr_destroy_out_of_lifetime : Note<
  "destroying object '%0' whose lifetime has already ended"
  "\n" "提示：销毁生存期已结束的对象 '%0'">;
def note_constexpr_unsupported_destruction : Note<
  "non-trivial destruction of type %0 in a constant expression is not supported"
  "\n" "提示：不支持在常量表达式中对类型 %0 进行非平凡销毁">;
def note_constexpr_unsupported_temporary_nontrivial_dtor : Note<
  "non-trivial destruction of lifetime-extended temporary with type %0 "
  "used in the result of a constant expression is not yet supported"
  "\n" "提示：尚不支持对类型 %0 的延长生存期的临时对象进行非平凡销毁，该临时对象用于常量表达式的结果中">;
def note_constexpr_unsupported_unsized_array : Note<
  "array-to-pointer decay of array member without known bound is not supported"
  "\n" "提示：不支持对未知边界的数组成员进行数组向指针的衰变">;
def note_constexpr_unsized_array_indexed : Note<
  "indexing of array without known bound is not allowed "
  "in a constant expression"
  "\n" "提示：不允许在常量表达式中对未知边界的数组进行下标访问">;
def note_constexpr_memcmp_unsupported : Note<
  "constant evaluation of %0 between arrays of types %1 and %2 "
  "is not supported; only arrays of narrow character types can be compared"
  "\n" "提示：不支持在类型 %1 和 %2 的数组之间对 %0 进行常量求值；只能比较窄字符类型的数组">;
def note_constexpr_memchr_unsupported : Note<
  "constant evaluation of %0 on array of type %1 "
  "is not supported; only arrays of narrow character types can be searched"
  "\n" "提示：不支持在类型 %1 的数组上对 %0 进行常量求值；只能搜索窄字符类型的数组">;
def note_constexpr_memcpy_null : Note<
  "%select{source|destination}2 of "
  "'%select{%select{memcpy|wmemcpy}1|%select{memmove|wmemmove}1}0' "
  "is %3"
  "\n" "提示：%select{源|目标}2 的 '%select{%select{memcpy|wmemcpy}1|%select{memmove|wmemmove}1}0' 是 %3">;
def note_constexpr_memcpy_type_pun : Note<
  "cannot constant evaluate '%select{memcpy|memmove}0' from object of "
  "type %1 to object of type %2"
  "\n" "提示：无法对从类型 %1 的对象到类型 %2 的对象的 '%select{memcpy|memmove}0' 进行常量求值">;
def note_constexpr_memcpy_nontrivial : Note<
  "cannot constant evaluate '%select{memcpy|memmove}0' between objects of "
  "non-trivially-copyable type %1"
  "\n" "提示：无法对非平凡可复制类型 %1 的对象之间的 '%select{memcpy|memmove}0' 进行常量求值">;
def note_constexpr_memcpy_incomplete_type : Note<
  "cannot constant evaluate '%select{memcpy|memmove}0' between objects of "
  "incomplete type %1"
  "\n" "提示：无法对不完整类型 %1 的对象之间的 '%select{memcpy|memmove}0' 进行常量求值">;
def note_constexpr_memcpy_overlap : Note<
  "'%select{memcpy|wmemcpy}0' between overlapping memory regions"
  "\n" "提示：重叠内存区域之间的 '%select{memcpy|wmemcpy}0'">;
def note_constexpr_memcpy_unsupported : Note<
  "'%select{%select{memcpy|wmemcpy}1|%select{memmove|wmemmove}1}0' "
  "not supported: %select{"
  "size to copy (%4) is not a multiple of size of element type %3 (%5)|"
  "source is not a contiguous array of at least %4 elements of type %3|"
  "destination is not a contiguous array of at least %4 elements of type %3}2"
  "\n" "提示：不支持 '%select{%select{memcpy|wmemcpy}1|%select{memmove|wmemmove}1}0'：%select{"
  "要复制的字节数（%4）不是元素类型 %3 的大小（%5）的整数倍|"
  "源不是类型 %3 的至少 %4 个元素的连续数组|"
  "目标不是类型 %3 的至少 %4 个元素的连续数组}2">;
def note_constexpr_bit_cast_unsupported_type : Note<
  "constexpr bit cast involving type %0 is not yet supported"
  "\n" "提示：尚不支持涉及类型 %0 的 constexpr 位转换">;
def note_constexpr_bit_cast_unsupported_bitfield : Note<
  "constexpr bit_cast involving bit-field is not yet supported"
  "\n" "提示：尚不支持涉及位域的 constexpr 位转换">;
def note_constexpr_bit_cast_invalid_type : Note<
  "bit_cast %select{from|to}0 a %select{|type with a }1"
  "%select{union|pointer|member pointer|volatile|reference}2 "
  "%select{type|member}1 is not allowed in a constant expression"
  "\n" "提示：不允许在常量表达式中将对象位转换%select{自|至}0 %select{|具有 }1"
  "%select{联合|指针|成员指针|volatile|引用}2 "
  "%select{类型|成员}1">;
def note_constexpr_bit_cast_invalid_subtype : Note<
  "invalid type %0 is a %select{member|base}1 of %2"
  "\n" "提示：无效类型 %0 是 %2 的%select{成员|基类}1">;
def note_constexpr_bit_cast_invalid_vector : Note<
  "bit_cast involving type %0 is not allowed in a constant expression; "
  "element size %1 * element count %2 is not a multiple of the byte size %3"
  "\n" "提示：不允许在常量表达式中进行涉及类型 %0 的位转换；"
  "元素大小 %1 * 元素个数 %2 不是字节大小 %3 的整数倍">;
def note_constexpr_bit_cast_indet_dest : Note<
  "indeterminate value can only initialize an object of type 'unsigned char'"
  "%select{, 'char',|}1 or 'std::byte'; %0 is invalid"
  "\n" "提示：未确定的值只能初始化类型为 'unsigned char'%select{、'char'、|}1 或 'std::byte' 的对象；%0 无效">;
def note_constexpr_bit_cast_unrepresentable_value : Note<
  "value %1 cannot be represented in type %0"
  "\n" "提示：值 %1 无法在类型 %0 中表示">;
def note_constexpr_pseudo_destructor : Note<
  "pseudo-destructor call is not permitted in constant expressions "
  "until C++20"
  "\n" "提示：在 C++20 之前不允许在常量表达式中调用伪析构函数">;
def note_constexpr_construct_complex_elem : Note<
  "construction of individual component of complex number is not yet supported "
  "in constant expressions"
  "\n" "提示：尚不支持在常量表达式中构造复数的单个分量">;
def note_constexpr_destroy_complex_elem : Note<
  "destruction of individual component of complex number is not yet supported "
  "in constant expressions"
  "\n" "提示：尚不支持在常量表达式中销毁复数的单个分量">;
def note_constexpr_new : Note<
  "dynamic memory allocation is not permitted in constant expressions "
  "until C++20"
  "\n" "提示：在 C++20 之前不允许在常量表达式中进行动态内存分配">;
def note_constexpr_new_non_replaceable : Note<
  "call to %select{placement|class-specific}0 %1"
  "\n" "提示：调用%select{布局|类专属}0 %1">;
def note_constexpr_new_placement : Note<
  "this placement new expression is not supported in constant expressions "
  "%select{|before C++2c}0"
  "\n" "提示：在常量表达式%select{|C++2c 之前}0 中不支持此布局 new 表达式">;
def note_constexpr_placement_new_wrong_type : Note<
  "placement new would change type of storage from %0 to %1"
  "\n" "提示：布局 new 会将存储的类型从 %0 更改为 %1">;
def note_constexpr_new_negative : Note<
  "cannot allocate array; evaluated array bound %0 is negative"
  "\n" "提示：无法分配数组；求值出的数组边界 %0 为负">;
def note_constexpr_new_too_large : Note<
  "cannot allocate array; evaluated array bound %0 is too large"
  "\n" "提示：无法分配数组；求值出的数组边界 %0 太大">;
def note_constexpr_new_exceeds_limits : Note<
  "cannot allocate array; evaluated array bound %0 exceeds the limit (%1); "
  "use '-fconstexpr-steps' to increase this limit"
  "\n" "提示：无法分配数组；求值出的数组边界 %0 超出限制（%1）；"
  "使用 '-fconstexpr-steps' 提高此限制">;
def note_constexpr_new_too_small : Note<
  "cannot allocate array; evaluated array bound %0 is too small to hold "
  "%1 explicitly initialized elements"
  "\n" "提示：无法分配数组；求值出的数组边界 %0 太小，无法容纳 %1 个显式初始化的元素">;
def note_constexpr_new_untyped : Note<
  "cannot allocate untyped memory in a constant expression; "
  "use 'std::allocator<T>::allocate' to allocate memory of type 'T'"
  "\n" "提示：不能在常量表达式中分配无类型的内存；"
  "使用 'std::allocator<T>::allocate' 分配类型为 'T' 的内存">;
def note_constexpr_new_not_complete_object_type : Note<
  "cannot allocate memory of %select{incomplete|function}0 type %1"
  "\n" "提示：无法分配%select{不完整|函数}0类型 %1 的内存">;
def note_constexpr_operator_new_bad_size : Note<
  "allocated size %0 is not a multiple of size %1 of element type %2"
  "\n" "提示：分配的大小 %0 不是元素类型 %2 的大小 %1 的整数倍">;
def note_constexpr_delete_not_heap_alloc : Note<
  "delete of pointer '%0' that does not point to a heap-allocated object"
  "\n" "提示：对不指向堆分配对象的指针 '%0' 执行 delete">;
def note_constexpr_double_delete : Note<
  "delete of pointer that has already been deleted"
  "\n" "提示：对已被删除的指针执行 delete">;
def note_constexpr_double_destroy : Note<
  "destruction of object that is already being destroyed"
  "\n" "提示：销毁正在被销毁的对象">;
def note_constexpr_new_delete_mismatch : Note<
  "%plural{2:'delete' used to delete pointer to object "
  "allocated with 'std::allocator<...>::allocate'|"
  ":%select{non-array delete|array delete|'std::allocator<...>::deallocate'}0 "
  "used to delete pointer to "
  "%select{array object of type %2|non-array object of type %2|"
  "object allocated with 'new'}0}1"
  "\n" "提示：%plural{2:'delete' 用于删除通过 'std::allocator<...>::allocate' 分配的对象指针|"
  ":%select{非数组 delete|数组 delete|'std::allocator<...>::deallocate'}0 "
  "用于删除%select{类型 %2 的数组对象|类型 %2 的非数组对象|"
  "通过 'new' 分配的对象}0 的指针}1">;
def note_constexpr_deallocate_null : Note<
  "'std::allocator<...>::deallocate' used to delete a null pointer"
  "\n" "提示：'std::allocator<...>::deallocate' 用于删除空指针">;
def note_constexpr_delete_subobject : Note<
  "delete of pointer%select{ to subobject|}1 '%0' "
  "%select{|that does not point to complete object}1"
  "\n" "提示：对%select{指向子对象的|}1指针 '%0' 执行 delete%select{|，该指针不指向完整对象}1">;
def note_constexpr_delete_base_nonvirt_dtor : Note<
  "delete of object with dynamic type %1 through pointer to "
  "base class type %0 with non-virtual destructor"
  "\n" "提示：通过指向具有非虚析构函数的基类类型 %0 的指针删除动态类型为 %1 的对象">;
def note_constexpr_memory_leak : Note<
  "allocation performed here was not deallocated"
  "%plural{0:|: (along with %0 other memory leak%s0)}0"
  "\n" "提示：此处执行的内存分配未被回收"
  "%plural{0:|：（还有 %0 个其他内存泄漏%s0）}0">;
def note_constexpr_unsupported_layout : Note<
  "type %0 has unexpected layout"
  "\n" "提示：类型 %0 具有意外的布局">;
def note_constexpr_unsupported_flexible_array : Note<
  "flexible array initialization is not yet supported"
  "\n" "提示：尚不支持柔性数组初始化">;
def note_constexpr_non_const_vectorelements : Note<
  "cannot determine number of elements for sizeless vectors in a constant expression"
  "\n" "提示：无法在常量表达式中确定无大小向量的元素个数">;
def note_constexpr_assumption_failed : Note<
  "assumption evaluated to false"
  "\n" "提示：假设求值为假">;
def note_constexpr_countzeroes_zero : Note<
  "evaluation of %select{__builtin_elementwise_clzg|__builtin_elementwise_ctzg}0 "
  "with a zero value is undefined"
  "\n" "提示：对值为零的 %select{__builtin_elementwise_clzg|__builtin_elementwise_ctzg}0 求值是未定义的">;
def note_constexpr_infer_alloc_token_type_inference_failed : Note<
  "could not infer allocation type for __builtin_infer_alloc_token"
  "\n" "提示：无法为 __builtin_infer_alloc_token 推断分配类型">;
def note_constexpr_infer_alloc_token_no_metadata : Note<
  "could not get token metadata for inferred type"
  "\n" "提示：无法为推断的类型获取令牌元数据">;
def note_constexpr_infer_alloc_token_stateful_mode
    : Note<"stateful alloc token mode not supported in constexpr"
      "\n" "提示：constexpr 中不支持有状态的分配令牌模式">;

def warn_attribute_needs_aggregate : Warning<
  "%0 attribute is ignored in non-aggregate type %1"
  "\n" "警告：%0 特性在非聚合类型 %1 中被忽略">,
  InGroup<IgnoredAttributes>;

def warn_cxx20_compat_requires_explicit_init_non_aggregate : Warning<
  "explicit initialization of field %1 will not be enforced in C++20 and later "
  "because %2 has a user-declared constructor, making the type no longer an "
  "aggregate"
  "\n" "警告：在 C++20 及之后将不再强制要求对字段 %1 进行显式初始化，因为 %2 具有用户声明的构造函数，使该类型不再是聚合类型">,
  DefaultIgnore, InGroup<CXX20Compat>;

def warn_integer_constant_overflow : Warning<
  "overflow in expression; result is %0 with type %1"
  "\n" "警告：表达式中溢出；结果是类型为 %1 的 %0">,
  InGroup<DiagGroup<"integer-overflow">>;
def warn_fixedpoint_constant_overflow : Warning<
  "overflow in expression; result is %0 with type %1"
  "\n" "警告：表达式中溢出；结果是类型为 %1 的 %0">,
  InGroup<DiagGroup<"fixed-point-overflow">>;
def note_constexpr_unscoped_enum_out_of_range : Note<
  "integer value %0 is outside the valid range of values [%1, %2] for the "
  "enumeration type %3"
  "\n" "提示：整数值 %0 超出枚举类型 %3 的有效取值范围 [%1, %2]">;

def warn_is_constant_evaluated_always_true_constexpr : Warning<
  "'%0' will always evaluate to 'true' in a manifestly constant-evaluated expression"
  "\n" "警告：在显式常量求值的表达式中，'%0' 将始终求值为 'true'">,
  InGroup<DiagGroup<"constant-evaluated">>;

def err_invalid_is_within_lifetime : Note<
  "'%0' cannot be called with "
  "%select{a null pointer|a one-past-the-end pointer|"
  "a pointer to an object whose lifetime has not yet begun}1"
  "\n" "提示：不能以%select{空指针|末尾之后一个位置的指针|"
  "指向生存期尚未开始对象的指针}1 调用 '%0'"
>;

// inline asm related.
let CategoryName = "Inline Assembly Issue" in {
  def err_asm_invalid_escape : Error<
    "invalid %% escape in inline assembly string"
    "\n" "错误：内联汇编字符串中出现无效的 %% 转义">;
  def err_asm_unknown_symbolic_operand_name : Error<
    "unknown symbolic operand name in inline assembly string"
    "\n" "错误：内联汇编字符串中出现未知的符号操作数名称">;

  def err_asm_unterminated_symbolic_operand_name : Error<
    "unterminated symbolic operand name in inline assembly string"
    "\n" "错误：内联汇编字符串中的符号操作数名称未终止">;
  def err_asm_empty_symbolic_operand_name : Error<
    "empty symbolic operand name in inline assembly string"
    "\n" "错误：内联汇编字符串中的符号操作数名称为空">;
  def err_asm_invalid_operand_number : Error<
    "invalid operand number in inline asm string"
    "\n" "错误：内联汇编字符串中出现无效的操作数编号">;
}

// vtable related.
let CategoryName = "VTable ABI Issue" in {
  def err_vftable_ambiguous_component : Error<
    "ambiguous vftable component for %0 introduced via covariant thunks; "
    "this is an inherent limitation of the ABI"
    "\n" "错误：通过协变跳板为 %0 引入的 vftable 组件存在歧义；"
    "这是 ABI 的固有局限">;
  def note_covariant_thunk : Note<
    "covariant thunk required by %0"
    "\n" "提示：%0 需要协变跳板">;
}

// Importing ASTs
def err_odr_variable_type_inconsistent : Error<
  "external variable %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "错误：外部变量 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">;
def warn_odr_variable_type_inconsistent : Warning<
  "external variable %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "警告：外部变量 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">,
  InGroup<ODR>;
def err_odr_variable_multiple_def : Error<
  "external variable %0 defined in multiple translation units"
  "\n" "错误：外部变量 %0 在多个翻译单元中定义">;
def warn_odr_variable_multiple_def : Warning<
  "external variable %0 defined in multiple translation units"
  "\n" "警告：外部变量 %0 在多个翻译单元中定义">,
  InGroup<ODR>;
def note_odr_value_here : Note<"declared here with type %0" "\n" "提示：在此处声明，类型为 %0">;
def err_odr_function_type_inconsistent : Error<
  "external function %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "错误：外部函数 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">;
def warn_odr_function_type_inconsistent : Warning<
  "external function %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "警告：外部函数 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">,
  InGroup<ODR>;
def warn_odr_tag_type_with_attributes : Warning<
  "type %0 has %select{an attribute|a member with an attribute}1 which "
  "currently causes the types to be treated as though they are incompatible"
  "\n" "警告：类型 %0 具有%select{特性|带特性的成员}1，目前这会导致这些类型被视为不兼容">,
  InGroup<ODR>, DefaultError;
def note_odr_attr_here : Note<"attribute %0 here" "\n" "提示：此处为特性 %0">;
def err_odr_tag_type_inconsistent
    : Error<"type %0 has incompatible definitions%select{| in different "
            "translation units}1"
            "\n" "错误：类型 %0 具有不兼容的定义%select{|在不同的翻译单元中}1">;
def warn_odr_tag_type_inconsistent
    : Warning<"type %0 has incompatible definitions%select{| in different "
              "translation units}1"
              "\n" "警告：类型 %0 具有不兼容的定义%select{|在不同的翻译单元中}1">,
      InGroup<ODR>;
def note_odr_tag_kind_here: Note<
  "%0 is a %select{struct|interface|union|class|enum}1 here"
  "\n" "提示：%0 在此处是%select{结构|接口|联合|类|枚举}1">;
def note_odr_field : Note<"field %0 has type %1 here" "\n" "提示：字段 %0 在此处的类型为 %1">;
def note_odr_field_bit_width : Note<"bit-field %0 has bit-width %1 here" "\n" "提示：位域 %0 在此处的位宽为 %1">;
def note_odr_field_not_bit_field : Note<"field %0 is not a bit-field" "\n" "提示：字段 %0 不是位域">;
def note_odr_field_name : Note<"field has name %0 here" "\n" "提示：此处字段的名称为 %0">;
def note_odr_missing_field : Note<"no corresponding field here" "\n" "提示：此处没有对应的字段">;
def note_odr_base : Note<"class has base type %0" "\n" "提示：类具有基类型 %0">;
def note_odr_virtual_base : Note<
  "%select{non-virtual|virtual}0 derivation here"
  "\n" "提示：此处为%select{非虚|虚}0派生">;
def note_odr_missing_base : Note<"no corresponding base class here" "\n" "提示：此处没有对应的基类">;
def note_odr_number_of_bases : Note<
  "class has %0 base %plural{1:class|:classes}0"
  "\n" "提示：类具有 %0 个基%plural{1:类|:类}0">;
def note_odr_enumerator : Note<"enumerator %0 with value %1 here" "\n" "提示：此处枚举符 %0 的值为 %1">;
def note_odr_missing_enumerator : Note<"no corresponding enumerator here" "\n" "提示：此处没有对应的枚举符">;
def note_odr_incompatible_fixed_underlying_type : Note<
  "enumeration %0 declared with incompatible fixed underlying types (%1 vs. "
  "%2)"
  "\n" "提示：枚举 %0 以不兼容的固定底层类型声明（%1 对比 %2）">;
def note_odr_fixed_underlying_type : Note<
  "enumeration %0 has fixed underlying type here"
  "\n" "提示：枚举 %0 此处具有固定底层类型">;
def note_odr_missing_fixed_underlying_type : Note<
  "enumeration %0 missing fixed underlying type here"
  "\n" "提示：枚举 %0 此处缺少固定底层类型">;

def err_odr_field_type_inconsistent : Error<
  "field %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "错误：字段 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">;
def warn_odr_field_type_inconsistent : Warning<
  "field %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "警告：字段 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">,
  InGroup<ODR>;

// Importing Objective-C ASTs
def err_odr_ivar_type_inconsistent : Error<
  "instance variable %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "错误：实例变量 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">;
def warn_odr_ivar_type_inconsistent : Warning<
  "instance variable %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "警告：实例变量 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">,
  InGroup<ODR>;
def err_odr_objc_superclass_inconsistent : Error<
  "class %0 has incompatible superclasses" "\n" "错误：类 %0 具有不兼容的父类">;
def warn_odr_objc_superclass_inconsistent : Warning<
  "class %0 has incompatible superclasses" "\n" "警告：类 %0 具有不兼容的父类">,
  InGroup<ODR>;
def note_odr_objc_superclass : Note<"inherits from superclass %0 here" "\n" "提示：此处继承自父类 %0">;
def note_odr_objc_missing_superclass : Note<"no corresponding superclass here" "\n" "提示：此处没有对应的父类">;
def err_odr_objc_method_result_type_inconsistent : Error<
  "%select{class|instance}0 method %1 has incompatible result types in "
  "different translation units (%2 vs. %3)"
  "\n" "错误：%select{类|实例}0方法 %1 在不同的翻译单元中具有不兼容的结果类型（%2 对比 %3）">;
def warn_odr_objc_method_result_type_inconsistent : Warning<
  "%select{class|instance}0 method %1 has incompatible result types in "
  "different translation units (%2 vs. %3)"
  "\n" "警告：%select{类|实例}0方法 %1 在不同的翻译单元中具有不兼容的结果类型（%2 对比 %3）">,
  InGroup<ODR>;
def err_odr_objc_method_num_params_inconsistent : Error<
  "%select{class|instance}0 method %1 has a different number of parameters in "
  "different translation units (%2 vs. %3)"
  "\n" "错误：%select{类|实例}0方法 %1 在不同的翻译单元中具有不同数量的参数（%2 对比 %3）">;
def warn_odr_objc_method_num_params_inconsistent : Warning<
  "%select{class|instance}0 method %1 has a different number of parameters in "
  "different translation units (%2 vs. %3)"
  "\n" "警告：%select{类|实例}0方法 %1 在不同的翻译单元中具有不同数量的参数（%2 对比 %3）">,
  InGroup<ODR>;
def err_odr_objc_method_param_type_inconsistent : Error<
  "%select{class|instance}0 method %1 has a parameter with a different types "
  "in different translation units (%2 vs. %3)"
  "\n" "错误：%select{类|实例}0方法 %1 在不同的翻译单元中具有类型不同的参数（%2 对比 %3）">;
def warn_odr_objc_method_param_type_inconsistent : Warning<
  "%select{class|instance}0 method %1 has a parameter with a different types "
  "in different translation units (%2 vs. %3)"
  "\n" "警告：%select{类|实例}0方法 %1 在不同的翻译单元中具有类型不同的参数（%2 对比 %3）">,
  InGroup<ODR>;
def err_odr_objc_method_variadic_inconsistent : Error<
  "%select{class|instance}0 method %1 is variadic in one translation unit "
  "and not variadic in another"
  "\n" "错误：%select{类|实例}0方法 %1 在一个翻译单元中是可变参数，而在另一个翻译单元中不是可变参数">;
def warn_odr_objc_method_variadic_inconsistent : Warning<
  "%select{class|instance}0 method %1 is variadic in one translation unit "
  "and not variadic in another"
  "\n" "警告：%select{类|实例}0方法 %1 在一个翻译单元中是可变参数，而在另一个翻译单元中不是可变参数">,
  InGroup<ODR>;
def note_odr_objc_method_here : Note<
  "%select{class|instance}0 method %1 also declared here"
  "\n" "提示：%select{类|实例}0方法 %1 也在此处声明">;
def err_odr_objc_property_type_inconsistent : Error<
  "property %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "错误：属性 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">;
def warn_odr_objc_property_type_inconsistent : Warning<
  "property %0 declared with incompatible types in different "
  "translation units (%1 vs. %2)"
  "\n" "警告：属性 %0 在不同的翻译单元中以不兼容的类型声明（%1 对比 %2）">,
  InGroup<ODR>;
def err_odr_objc_property_impl_kind_inconsistent : Error<
  "property %0 is implemented with %select{@synthesize|@dynamic}1 in one "
  "translation but %select{@dynamic|@synthesize}1 in another translation unit"
  "\n" "错误：属性 %0 在一个翻译单元中以%select{@synthesize|@dynamic}1实现，但在另一个翻译单元中以%select{@dynamic|@synthesize}1实现">;
def warn_odr_objc_property_impl_kind_inconsistent : Warning<
  "property %0 is implemented with %select{@synthesize|@dynamic}1 in one "
  "translation but %select{@dynamic|@synthesize}1 in another translation unit"
  "\n" "警告：属性 %0 在一个翻译单元中以%select{@synthesize|@dynamic}1实现，但在另一个翻译单元中以%select{@dynamic|@synthesize}1实现">,
  InGroup<ODR>;
def note_odr_objc_property_impl_kind : Note<
  "property %0 is implemented with %select{@synthesize|@dynamic}1 here"
  "\n" "提示：属性 %0 在此处以%select{@synthesize|@dynamic}1实现">;
def err_odr_objc_synthesize_ivar_inconsistent : Error<
  "property %0 is synthesized to different ivars in different translation "
  "units (%1 vs. %2)"
  "\n" "错误：属性 %0 在不同的翻译单元中被综合到不同的实例变量（%1 对比 %2）">;
def warn_odr_objc_synthesize_ivar_inconsistent : Warning<
  "property %0 is synthesized to different ivars in different translation "
  "units (%1 vs. %2)"
  "\n" "警告：属性 %0 在不同的翻译单元中被综合到不同的实例变量（%1 对比 %2）">,
  InGroup<ODR>;
def note_odr_objc_synthesize_ivar_here : Note<
  "property is synthesized to ivar %0 here"
  "\n" "提示：此处将属性综合到实例变量 %0">;
def err_unsupported_objc_primitive_encoding
    : Error<"cannot yet @encode type %0" "\n" "错误：尚无法对类型 %0 进行 @encode">;

// Importing C++ ASTs
def note_odr_friend : Note<"friend declared here" "\n" "提示：在此处声明为友元">;
def note_odr_missing_friend : Note<"no corresponding friend here" "\n" "提示：此处没有对应的友元">;
def err_odr_different_num_template_parameters : Error<
  "template parameter lists have a different number of parameters (%0 vs %1)"
  "\n" "错误：模板形参列表具有不同数量的形参（%0 对比 %1）">;
def warn_odr_different_num_template_parameters : Warning<
  "template parameter lists have a different number of parameters (%0 vs %1)"
  "\n" "警告：模板形参列表具有不同数量的形参（%0 对比 %1）">,
  InGroup<ODR>;
def note_odr_template_parameter_list : Note<
  "template parameter list also declared here"
  "\n" "提示：模板形参列表也在此处声明">;
def err_odr_different_template_parameter_kind : Error<
  "template parameter has different kinds in different translation units"
  "\n" "错误：模板形参在不同的翻译单元中具有不同的种类">;
def warn_odr_different_template_parameter_kind : Warning<
  "template parameter has different kinds in different translation units"
  "\n" "警告：模板形参在不同的翻译单元中具有不同的种类">,
  InGroup<ODR>;
def note_odr_template_parameter_here : Note<
  "template parameter declared here"
  "\n" "提示：在此处声明模板形参">;
def err_odr_parameter_pack_non_pack : Error<
  "parameter kind mismatch; parameter is %select{not a|a}0 parameter pack"
  "\n" "错误：形参种类不匹配；形参%select{不是|是}0参数包">;
def warn_odr_parameter_pack_non_pack : Warning<
  "parameter kind mismatch; parameter is %select{not a|a}0 parameter pack"
  "\n" "警告：形参种类不匹配；形参%select{不是|是}0参数包">,
  InGroup<ODR>;
def note_odr_parameter_pack_non_pack : Note<
  "%select{parameter|parameter pack}0 declared here"
  "\n" "提示：在此处声明%select{形参|参数包}0">;
def err_odr_non_type_parameter_type_inconsistent : Error<
  "non-type template parameter declared with incompatible types in different "
  "translation units (%0 vs. %1)"
  "\n" "错误：非类型模板形参在不同的翻译单元中以不兼容的类型声明（%0 对比 %1）">;
def warn_odr_non_type_parameter_type_inconsistent : Warning<
  "non-type template parameter declared with incompatible types in different "
  "translation units (%0 vs. %1)"
  "\n" "警告：非类型模板形参在不同的翻译单元中以不兼容的类型声明（%0 对比 %1）">,
  InGroup<ODR>;
def err_unsupported_ast_node: Error<"cannot import unsupported AST node %0" "\n" "错误：无法导入不支持的 AST 节点 %0">;

// Compare ODR hashes
def err_module_odr_violation_different_definitions : Error<
  "%q0 has different definitions in different modules; "
  "%select{definition in module '%2' is here|defined here}1"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；"
  "%select{模块 '%2' 中的定义在此处|定义在此处}1">;
def note_first_module_difference : Note<
  "in first definition, possible difference is here"
  "\n" "提示：在第一个定义中，可能的不同之处在此处">;
def note_module_odr_violation_different_definitions : Note<
  "definition in module '%0' is here"
  "\n" "提示：模块 '%0' 中的定义在此处">;
def note_second_module_difference : Note<
  "in second definition, possible difference is here"
  "\n" "提示：在第二个定义中，可能的不同之处在此处">;

def err_module_odr_violation_definition_data : Error <
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "%4 base %plural{1:class|:classes}4|"
  "%4 virtual base %plural{1:class|:classes}4|"
  "%ordinal4 base class with type %5|"
  "%ordinal4 %select{non-virtual|virtual}5 base class %6|"
  "%ordinal4 base class %5 with "
  "%select{public|protected|private|no}6 access specifier}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "%4 个基%plural{1:类|:类}4|"
  "%4 个虚基%plural{1:类|:类}4|"
  "第 %ordinal4 个基类，其类型为 %5|"
  "第 %ordinal4 个%select{非虚|虚}5基类 %6|"
  "第 %ordinal4 个基类 %5，其访问说明符为 "
  "%select{public|protected|private|无}6}3">;

def note_module_odr_violation_definition_data : Note <
  "but in '%0' found "
  "%select{"
  "%2 base %plural{1:class|:classes}2|"
  "%2 virtual base %plural{1:class|:classes}2|"
  "%ordinal2 base class with different type %3|"
  "%ordinal2 %select{non-virtual|virtual}3 base class %4|"
  "%ordinal2 base class %3 with "
  "%select{public|protected|private|no}4 access specifier}1"
  "\n" "提示：但在 '%0' 中发现 "
  "%select{"
  "%2 个基%plural{1:类|:类}2|"
  "%2 个虚基%plural{1:类|:类}2|"
  "第 %ordinal2 个基类，其类型不同为 %3|"
  "第 %ordinal2 个%select{非虚|虚}3基类 %4|"
  "第 %ordinal2 个基类 %3，其访问说明符为 "
  "%select{public|protected|private|无}4}1">;

def err_module_odr_violation_objc_interface : Error <
  "%0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "%select{no super class|super class with type %5}4|"
  "instance variable '%4' access control is "
    "%select{|@private|@protected|@public|@package}5"
  "}3"
  "\n" "错误：%0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "%select{无父类|父类类型为 %5}4|"
  "实例变量 '%4' 的访问控制为 "
    "%select{|@private|@protected|@public|@package}5"
  "}3">;
def note_module_odr_violation_objc_interface : Note <
  "but in %select{'%1'|definition here}0 found "
  "%select{"
  "%select{no super class|super class with type %4}3|"
  "instance variable '%3' access control is "
    "%select{|@private|@protected|@public|@package}4"
  "}2"
  "\n" "提示：但在 %select{'%1'|此处的定义}0中发现 "
  "%select{"
  "%select{无父类|父类类型为 %4}3|"
  "实例变量 '%3' 的访问控制为 "
    "%select{|@private|@protected|@public|@package}4"
  "}2">;

def err_module_odr_violation_template_parameter : Error <
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "unnamed template parameter|"
  "template parameter %5|"
  "template parameter with %select{no |}4default argument|"
  "template parameter with default argument}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "未命名的模板形参|"
  "模板形参 %5|"
  "带有%select{无|}4默认实参的模板形参|"
  "带有默认实参的模板形参}3">;

def note_module_odr_violation_template_parameter : Note <
  "but in '%0' found "
  "%select{"
  "unnamed template parameter %2|"
  "template parameter %3|"
  "template parameter with %select{no |}2default argument|"
  "template parameter with different default argument}1"
  "\n" "提示：但在 '%0' 中发现 "
  "%select{"
  "未命名的模板形参 %2|"
  "模板形参 %3|"
  "带有%select{无|}2默认实参的模板形参|"
  "带有不同默认实参的模板形参}1">;

def err_module_odr_violation_mismatch_decl : Error<
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{end of class|public access specifier|private access specifier|"
  "protected access specifier|static assert|field|method|type alias|typedef|"
  "data member|friend declaration|function template|method|instance variable|"
  "property}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{类的末尾|public 访问说明符|private 访问说明符|"
  "protected 访问说明符|static assert|字段|方法|类型别名|typedef|"
  "数据成员|友元声明|函数模板|方法|实例变量|"
  "属性}3">;
def note_module_odr_violation_mismatch_decl : Note<
  "but in %select{'%1'|definition here}0 found "
  "%select{end of class|public access specifier|private access specifier|"
  "protected access specifier|static assert|field|method|type alias|typedef|"
  "data member|friend declaration|function template|method|instance variable|"
  "property}2"
  "\n" "提示：但在 %select{'%1'|此处的定义}0中发现 "
  "%select{类的末尾|public 访问说明符|private 访问说明符|"
  "protected 访问说明符|static assert|字段|方法|类型别名|typedef|"
  "数据成员|友元声明|函数模板|方法|实例变量|"
  "属性}2">;

def err_module_odr_violation_record : Error<
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "static assert with condition|"
  "static assert with message|"
  "static assert with %select{|no }4message|"
  "%select{method %5|constructor|destructor}4|"
  "%select{method %5|constructor|destructor}4 "
    "is %select{not deleted|deleted}6|"
  "%select{method %5|constructor|destructor}4 "
    "is %select{not defaulted|defaulted}6|"
  "%select{method %5|constructor|destructor}4 "
    "is %select{|pure }6%select{not virtual|virtual}7|"
  "%select{method %5|constructor|destructor}4 "
    "is %select{not static|static}6|"
  "%select{method %5|constructor|destructor}4 "
    "is %select{not volatile|volatile}6|"
  "%select{method %5|constructor|destructor}4 "
    "is %select{not const|const}6|"
  "%select{method %5|constructor|destructor}4 "
    "is %select{not inline|inline}6|"
  "%select{method %5|constructor|destructor}4 "
    "with %ordinal6 parameter with%select{out|}7 a default argument|"
  "%select{method %5|constructor|destructor}4 "
    "with %ordinal6 parameter with a default argument|"
  "%select{method %5|constructor|destructor}4 "
    "with %select{no |}6template arguments|"
  "%select{method %5|constructor|destructor}4 "
    "with %6 template argument%s6|"
  "%select{method %5|constructor|destructor}4 "
    "with %6 for %ordinal7 template argument|"
  "%select{method %5|constructor|destructor}4 "
    "with %select{no body|body}6|"
  "%select{method %5|constructor|destructor}4 "
    "with body|"
  "friend %select{class|function}4|"
  "friend %4|"
  "friend function %4|"
  "function template %4 with %5 template parameter%s5|"
  "function template %4 with %ordinal5 template parameter being a "
    "%select{type|non-type|template}6 template parameter|"
  "function template %4 with %ordinal5 template parameter "
    "%select{with no name|named %7}6|"
  "function template %4 with %ordinal5 template parameter with "
    "%select{no |}6default argument|"
  "function template %4 with %ordinal5 template parameter with "
    "default argument %6|"
  "function template %4 with %ordinal5 template parameter with one type|"
  "function template %4 with %ordinal5 template parameter %select{not |}6"
    "being a template parameter pack|"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "带有条件的 static assert|"
  "带有消息的 static assert|"
  "带有%select{|无}4消息的 static assert|"
  "%select{方法 %5|构造函数|析构函数}4|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "%select{未被删除|已被删除}6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "%select{未默认化|已默认化}6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "为%select{|纯虚}6%select{非虚|虚}7|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "%select{非静态|静态}6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "%select{非 volatile|volatile}6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "%select{非 const|const}6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "%select{非内联|内联}6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "的第 %ordinal6 个参数%select{没有|}7默认实参|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "的第 %ordinal6 个参数具有默认实参|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "%select{没有|}6模板实参|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "具有 %6 个模板实参%s6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "的第 %ordinal7 个模板实参为 %6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "%select{无函数体|有函数体}6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "具有函数体|"
  "友元%select{类|函数}4|"
  "友元 %4|"
  "友元函数 %4|"
  "具有 %5 个模板形参%s5 的函数模板 %4|"
  "函数模板 %4 的第 %ordinal5 个模板形参为"
    "%select{类型|非类型|模板}6模板形参|"
  "函数模板 %4 的第 %ordinal5 个模板形参 "
    "%select{没有名称|名为 %7}6|"
  "函数模板 %4 的第 %ordinal5 个模板形参"
    "%select{没有|}6默认实参|"
  "函数模板 %4 的第 %ordinal5 个模板形参具有"
    "默认实参 %6|"
  "函数模板 %4 的第 %ordinal5 个模板形参只有一个类型|"
  "函数模板 %4 的第 %ordinal5 个模板形参%select{不是|}6"
    "模板参数包|"
  "}3">;

def note_module_odr_violation_record : Note<"but in '%0' found "
  "%select{"
  "static assert with different condition|"
  "static assert with different message|"
  "static assert with %select{|no }2message|"
  "%select{method %3|constructor|destructor}2|"
  "%select{method %3|constructor|destructor}2 "
    "is %select{not deleted|deleted}4|"
  "%select{method %3|constructor|destructor}2 "
    "is %select{not defaulted|defaulted}4|"
  "%select{method %3|constructor|destructor}2 "
    "is %select{|pure }4%select{not virtual|virtual}5|"
  "%select{method %3|constructor|destructor}2 "
    "is %select{not static|static}4|"
  "%select{method %3|constructor|destructor}2 "
    "is %select{not volatile|volatile}4|"
  "%select{method %3|constructor|destructor}2 "
    "is %select{not const|const}4|"
  "%select{method %3|constructor|destructor}2 "
    "is %select{not inline|inline}4|"
  "%select{method %3|constructor|destructor}2 "
    "with %ordinal4 parameter with%select{out|}5 a default argument|"
  "%select{method %3|constructor|destructor}2 "
    "with %ordinal4 parameter with a different default argument|"
  "%select{method %3|constructor|destructor}2 "
    "with %select{no |}4template arguments|"
  "%select{method %3|constructor|destructor}2 "
    "with %4 template argument%s4|"
  "%select{method %3|constructor|destructor}2 "
    "with %4 for %ordinal5 template argument|"
  "%select{method %3|constructor|destructor}2 "
    "with %select{no body|body}4|"
  "%select{method %3|constructor|destructor}2 "
    "with different body|"
  "friend %select{class|function}2|"
  "friend %2|"
  "friend function %2|"
  "function template %2 with %3 template parameter%s3|"
  "function template %2 with %ordinal3 template paramter being a "
    "%select{type|non-type|template}4 template parameter|"
  "function template %2 with %ordinal3 template parameter "
    "%select{with no name|named %5}4|"
  "function template %2 with %ordinal3 template parameter with "
    "%select{no |}4default argument|"
  "function template %2 with %ordinal3 template parameter with "
    "default argument %4|"
  "function template %2 with %ordinal3 template parameter with different type|"
  "function template %2 with %ordinal3 template parameter %select{not |}4"
    "being a template parameter pack|"
  "}1"
  "\n" "提示：但在 '%0' 中发现 "
  "%select{"
  "带有不同条件的 static assert|"
  "带有不同消息的 static assert|"
  "带有%select{|无}2消息的 static assert|"
  "%select{方法 %3|构造函数|析构函数}2|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "%select{未被删除|已被删除}4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "%select{未默认化|已默认化}4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "为%select{|纯虚}4%select{非虚|虚}5|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "%select{非静态|静态}4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "%select{非 volatile|volatile}4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "%select{非 const|const}4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "%select{非内联|内联}4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "的第 %ordinal4 个参数%select{没有|}5默认实参|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "的第 %ordinal4 个参数具有不同的默认实参|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "%select{没有|}4模板实参|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "具有 %4 个模板实参%s4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "的第 %ordinal5 个模板实参为 %4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "%select{无函数体|有函数体}4|"
  "%select{方法 %3|构造函数|析构函数}2 "
    "具有不同的函数体|"
  "友元%select{类|函数}2|"
  "友元 %2|"
  "友元函数 %2|"
  "具有 %3 个模板形参%s3 的函数模板 %2|"
  "函数模板 %2 的第 %ordinal3 个模板形参为"
    "%select{类型|非类型|模板}4模板形参|"
  "函数模板 %2 的第 %ordinal3 个模板形参 "
    "%select{没有名称|名为 %5}4|"
  "函数模板 %2 的第 %ordinal3 个模板形参"
    "%select{没有|}4默认实参|"
  "函数模板 %2 的第 %ordinal3 个模板形参具有"
    "默认实参 %4|"
  "函数模板 %2 的第 %ordinal3 个模板形参具有不同的类型|"
  "函数模板 %2 的第 %ordinal3 个模板形参%select{不是|}4"
    "模板参数包|"
  "}1">;

def err_module_odr_violation_field : Error<
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "field %4|"
  "field %4 with type %5|"
  "%select{non-|}5bit-field %4|"
  "bit-field %4 with one width expression|"
  "%select{non-|}5mutable field %4|"
  "field %4 with %select{no|an}5 initializer|"
  "field %4 with an initializer"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "字段 %4|"
  "类型为 %5 的字段 %4|"
  "%select{非|}5位域 %4|"
  "具有一个宽度表达式的位域 %4|"
  "%select{非|}5可变字段 %4|"
  "%select{无|有}5初始化器的字段 %4|"
  "具有初始化器的字段 %4"
  "}3">;
def note_module_odr_violation_field : Note<
  "but in %select{'%1'|definition here}0 found "
  "%select{"
  "field %3|"
  "field %3 with type %4|"
  "%select{non-|}4bit-field %3|"
  "bit-field %3 with different width expression|"
  "%select{non-|}4mutable field %3|"
  "field %3 with %select{no|an}4 initializer|"
  "field %3 with a different initializer"
  "}2"
  "\n" "提示：但在 %select{'%1'|此处的定义}0中发现 "
  "%select{"
  "字段 %3|"
  "类型为 %4 的字段 %3|"
  "%select{非|}4位域 %3|"
  "具有不同宽度表达式的位域 %3|"
  "%select{非|}4可变字段 %3|"
  "%select{无|有}4初始化器的字段 %3|"
  "具有不同初始化器的字段 %3"
  "}2">;

def err_module_odr_violation_typedef : Error<
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "%select{typedef|type alias}4 name %5|"
  "%select{typedef|type alias}4 %5 with underlying type %6"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "%select{typedef|类型别名}4 名称为 %5|"
  "%select{typedef|类型别名}4 %5，其底层类型为 %6"
  "}3">;
def note_module_odr_violation_typedef : Note<"but in '%0' found "
  "%select{"
  "%select{typedef|type alias}2 name %3|"
  "%select{typedef|type alias}2 %3 with different underlying type %4"
  "}1"
  "\n" "提示：但在 '%0' 中发现 "
  "%select{"
  "%select{typedef|类型别名}2 名称为 %3|"
  "%select{typedef|类型别名}2 %3，其底层类型不同为 %4"
  "}1">;

def err_module_odr_violation_variable : Error<
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "data member with name %4|"
  "data member %4 with type %5|"
  "data member %4 with%select{out|}5 an initializer|"
  "data member %4 with an initializer|"
  "data member %4 %select{is constexpr|is not constexpr}5"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "名称为 %4 的数据成员|"
  "类型为 %5 的数据成员 %4|"
  "%select{没有|}5初始化器的数据成员 %4|"
  "具有初始化器的数据成员 %4|"
  "数据成员 %4%select{是 constexpr|不是 constexpr}5"
  "}3">;
def note_module_odr_violation_variable : Note<"but in '%0' found "
  "%select{"
  "data member with name %2|"
  "data member %2 with different type %3|"
  "data member %2 with%select{out|}3 an initializer|"
  "data member %2 with a different initializer|"
  "data member %2 %select{is constexpr|is not constexpr}3"
  "}1"
  "\n" "提示：但在 '%0' 中发现 "
  "%select{"
  "名称为 %2 的数据成员|"
  "类型不同为 %3 的数据成员 %2|"
  "%select{没有|}3初始化器的数据成员 %2|"
  "具有不同初始化器的数据成员 %2|"
  "数据成员 %2%select{是 constexpr|不是 constexpr}3"
  "}1">;

def err_module_odr_violation_function : Error<
  "%q0 has different definitions in different modules; "
  "%select{definition in module '%2'|defined here}1 "
  "first difference is "
  "%select{"
  "return type is %4|"
  "%ordinal4 parameter with name %5|"
  "%ordinal4 parameter with type %5%select{| decayed from %7}6|"
  "%ordinal4 parameter with%select{out|}5 a default argument|"
  "%ordinal4 parameter with a default argument|"
  "function body"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；"
  "%select{模块 '%2' 中的定义|定义在此处}1 "
  "第一个差异是 "
  "%select{"
  "返回类型为 %4|"
  "第 %ordinal4 个参数名为 %5|"
  "第 %ordinal4 个参数类型为 %5%select{|由 %7 衰变而来}6|"
  "第 %ordinal4 个参数%select{没有|}5默认实参|"
  "第 %ordinal4 个参数具有默认实参|"
  "函数体"
  "}3">;

def note_module_odr_violation_function : Note<"but in '%0' found "
  "%select{"
  "different return type %2|"
  "%ordinal2 parameter with name %3|"
  "%ordinal2 parameter with type %3%select{| decayed from %5}4|"
  "%ordinal2 parameter with%select{out|}3 a default argument|"
  "%ordinal2 parameter with a different default argument|"
  "a different body"
  "}1"
  "\n" "提示：但在 '%0' 中发现 "
  "%select{"
  "不同的返回类型 %2|"
  "第 %ordinal2 个参数名为 %3|"
  "第 %ordinal2 个参数类型为 %3%select{|由 %5 衰变而来}4|"
  "第 %ordinal2 个参数%select{没有|}3默认实参|"
  "第 %ordinal2 个参数具有不同的默认实参|"
  "不同的函数体"
  "}1">;

def err_module_odr_violation_enum : Error<
  "%q0 has different definitions in different modules; "
  "%select{definition in module '%2'|defined here}1 "
  "first difference is "
  "%select{"
  "enum that is %select{not scoped|scoped}4|"
  "enum scoped with keyword %select{struct|class}4|"
  "enum %select{without|with}4 specified type|"
  "enum with specified type %4|"
  "enum with %4 element%s4|"
  "%ordinal4 element has name %5|"
  "%ordinal4 element %5 %select{has|does not have}6 an initializer|"
  "%ordinal4 element %5 has an initializer|"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；"
  "%select{模块 '%2' 中的定义|定义在此处}1 "
  "第一个差异是 "
  "%select{"
  "%select{非作用域限定|作用域限定}4枚举|"
  "使用 %select{struct|class}4 关键字限定作用域的枚举|"
  "%select{未指定|指定}4类型的枚举|"
  "具有指定类型 %4 的枚举|"
  "具有 %4 个元素%s4 的枚举|"
  "第 %ordinal4 个元素名为 %5|"
  "第 %ordinal4 个元素 %5%select{有|没有}6初始化器|"
  "第 %ordinal4 个元素 %5 具有初始化器|"
  "}3">;

def note_module_odr_violation_enum : Note<"but in '%0' found "
  "%select{"
  "enum that is %select{not scoped|scoped}2|"
  "enum scoped with keyword %select{struct|class}2|"
  "enum %select{without|with}2 specified type|"
  "enum with specified type %2|"
  "enum with %2 element%s2|"
  "%ordinal2 element has name %3|"
  "%ordinal2 element %3 %select{has|does not have}4 an initializer|"
  "%ordinal2 element %3 has different initializer|"
  "}1"
  "\n" "提示：但在 '%0' 中发现 "
  "%select{"
  "%select{非作用域限定|作用域限定}2枚举|"
  "使用 %select{struct|class}2 关键字限定作用域的枚举|"
  "%select{未指定|指定}2类型的枚举|"
  "具有指定类型 %2 的枚举|"
  "具有 %2 个元素%s2 的枚举|"
  "第 %ordinal2 个元素名为 %3|"
  "第 %ordinal2 个元素 %3%select{有|没有}4初始化器|"
  "第 %ordinal2 个元素 %3 具有不同的初始化器|"
  "}1">;

def err_module_odr_violation_referenced_protocols : Error <
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "%4 referenced %plural{1:protocol|:protocols}4|"
  "%ordinal4 referenced protocol with name %5"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "%4 个被引用的%plural{1:协议|:协议}4|"
  "第 %ordinal4 个被引用的协议名为 %5"
  "}3">;
def note_module_odr_violation_referenced_protocols : Note <
  "but in %select{'%1'|definition here}0 found "
  "%select{"
  "%3 referenced %plural{1:protocol|:protocols}3|"
  "%ordinal3 referenced protocol with different name %4"
  "}2"
  "\n" "提示：但在 %select{'%1'|此处的定义}0中发现 "
  "%select{"
  "%3 个被引用的%plural{1:协议|:协议}3|"
  "第 %ordinal3 个被引用的协议名称不同为 %4"
  "}2">;

def err_module_odr_violation_objc_method : Error<
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "method %4 with return type %5|"
  "%select{class|instance}5 method %4|"
  "%select{no|'required'|'optional'}4 method control|"
  "method %4 with %select{no designated initializer|designated initializer}5|"
  "%select{regular|direct}5 method %4|"
  "method %4"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "返回类型为 %5 的方法 %4|"
  "%select{类|实例}5方法 %4|"
  "%select{无|'required'|'optional'}4方法控制|"
  "%select{无指定初始化器|有指定初始化器}5的方法 %4|"
  "%select{常规|直接}5方法 %4|"
  "方法 %4"
  "}3">;
def note_module_odr_violation_objc_method : Note<
  "but in %select{'%1'|definition here}0 found "
  "%select{"
  "method %3 with different return type %4|"
  "method %3 as %select{class|instance}4 method|"
  "%select{no|'required'|'optional'}3 method control|"
  "method %3 with %select{no designated initializer|designated initializer}4|"
  "%select{regular|direct}4 method %3|"
  "different method %3"
  "}2"
  "\n" "提示：但在 %select{'%1'|此处的定义}0中发现 "
  "%select{"
  "返回类型不同为 %4 的方法 %3|"
  "作为%select{类|实例}4方法的方法 %3|"
  "%select{无|'required'|'optional'}3方法控制|"
  "%select{无指定初始化器|有指定初始化器}4的方法 %3|"
  "%select{常规|直接}4方法 %3|"
  "不同的方法 %3"
  "}2">;

def err_module_odr_violation_method_params : Error<
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "%select{method %5|constructor|destructor}4 "
    "that has %6 parameter%s6|"
  "%select{method %5|constructor|destructor}4 "
    "with %ordinal6 parameter of type %7%select{| decayed from %9}8|"
  "%select{method %5|constructor|destructor}4 "
    "with %ordinal6 parameter named %7"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "%select{方法 %5|构造函数|析构函数}4 "
    "具有 %6 个参数%s6|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "的第 %ordinal6 个参数类型为 %7%select{|由 %9 衰变而来}8|"
  "%select{方法 %5|构造函数|析构函数}4 "
    "的第 %ordinal6 个参数名为 %7"
  "}3">;
def note_module_odr_violation_method_params : Note<
  "but in %select{'%1'|definition here}0 found "
  "%select{"
  "%select{method %4|constructor|destructor}3 "
    "that has %5 parameter%s5|"
  "%select{method %4|constructor|destructor}3 "
    "with %ordinal5 parameter of type %6%select{| decayed from %8}7|"
  "%select{method %4|constructor|destructor}3 "
    "with %ordinal5 parameter named %6"
  "}2"
  "\n" "提示：但在 %select{'%1'|此处的定义}0中发现 "
  "%select{"
  "%select{方法 %4|构造函数|析构函数}3 "
    "具有 %5 个参数%s5|"
  "%select{方法 %4|构造函数|析构函数}3 "
    "的第 %ordinal5 个参数类型为 %6%select{|由 %8 衰变而来}7|"
  "%select{方法 %4|构造函数|析构函数}3 "
    "的第 %ordinal5 个参数名为 %6"
  "}2">;

def err_module_odr_violation_objc_property : Error<
  "%q0 has different definitions in different modules; first difference is "
  "%select{definition in module '%2'|defined here}1 found "
  "%select{"
  "property %4|"
  "property %4 with type %5|"
  "%select{no|'required'|'optional'}4 property control|"
  "property %4 with %select{default |}6'%select{none|readonly|getter|assign|"
    "readwrite|retain|copy|nonatomic|setter|atomic|weak|strong|"
    "unsafe_unretained|nullability|null_resettable|class|direct}5' attribute"
  "}3"
  "\n" "错误：%q0 在不同的模块中具有不同的定义；第一个差异是 "
  "%select{模块 '%2' 中的定义|定义在此处}1发现 "
  "%select{"
  "属性 %4|"
  "类型为 %5 的属性 %4|"
  "%select{无|'required'|'optional'}4属性控制|"
  "具有%select{默认 |}6'%select{none|readonly|getter|assign|"
    "readwrite|retain|copy|nonatomic|setter|atomic|weak|strong|"
    "unsafe_unretained|nullability|null_resettable|class|direct}5'特性的属性 %4"
  "}3">;
def note_module_odr_violation_objc_property : Note<
  "but in %select{'%1'|definition here}0 found "
  "%select{"
  "property %3|"
  "property %3 with type %4|"
  "%select{no|'required'|'optional'}3 property control|"
  "property %3 with different '%select{none|readonly|getter|assign|"
    "readwrite|retain|copy|nonatomic|setter|atomic|weak|strong|"
    "unsafe_unretained|nullability|null_resettable|class|direct}4' attribute"
  "}2"
  "\n" "提示：但在 %select{'%1'|此处的定义}0中发现 "
  "%select{"
  "属性 %3|"
  "类型为 %4 的属性 %3|"
  "%select{无|'required'|'optional'}3属性控制|"
  "具有不同的 '%select{none|readonly|getter|assign|"
    "readwrite|retain|copy|nonatomic|setter|atomic|weak|strong|"
    "unsafe_unretained|nullability|null_resettable|class|direct}4'特性的属性 %3"
  "}2">;

def err_module_odr_violation_mismatch_decl_unknown : Error<
  "%q0 %select{with definition in module '%2'|defined here}1 has different "
  "definitions in different modules; first difference is this "
  "%select{||||static assert|field|method|type alias|typedef|data member|"
  "friend declaration|function template|method|instance variable|"
  "property|unexpected decl}3"
  "\n" "错误：%q0 %select{定义在模块 '%2' 中|定义在此处}1 在不同的模块中"
  "具有不同的定义；第一个差异是此 "
  "%select{||||static assert|字段|方法|类型别名|typedef|数据成员|"
  "友元声明|函数模板|方法|实例变量|"
  "属性|意外的声明}3">;
def note_module_odr_violation_mismatch_decl_unknown : Note<
  "but in %select{'%1'|definition here}0 found "
  "%select{||||different static assert|different field|different method|"
  "different type alias|different typedef|different data member|"
  "different friend declaration|different function template|different method|"
  "different instance variable|different property|another unexpected decl}2"
  "\n" "提示：但在 %select{'%1'|此处的定义}0中发现 "
  "%select{||||不同的 static assert|不同的字段|不同的方法|"
  "不同的类型别名|不同的 typedef|不同的数据成员|"
  "不同的友元声明|不同的函数模板|不同的方法|"
  "不同的实例变量|不同的属性|另一个意外的声明}2">;

def err_struct_too_large : Error<
  "structure '%0' is too large, which exceeds maximum allowed size of %1 bytes"
  "\n" "错误：结构 '%0' 过大，超过了 %1 字节的最大允许大小">;

def remark_sanitize_address_insert_extra_padding_accepted : Remark<
    "-fsanitize-address-field-padding applied to %0"
    "\n" "备注：已将 -fsanitize-address-field-padding 应用于 %0">,
    ShowInSystemHeader,
    InGroup<SanitizeAddressRemarks>;
def remark_sanitize_address_insert_extra_padding_rejected : Remark<
    "-fsanitize-address-field-padding ignored for %0 because it "
    "%select{is not C++|is packed|is a union|is trivially copyable|"
    "has trivial destructor|is standard layout|is in a ignorelisted file|"
    "is ignorelisted}1"
    "\n" "备注：由于 %0 %select{不是 C++|被 packed|是联合|可平凡复制|"
    "具有平凡析构函数|是标准布局|位于被忽略列表中|"
    "被忽略}1，因此忽略其 -fsanitize-address-field-padding">,
    ShowInSystemHeader,
    InGroup<SanitizeAddressRemarks>;

def warn_npot_ms_struct : Warning<
  "ms_struct may not produce Microsoft-compatible layouts with fundamental "
  "data types with sizes that aren't a power of two"
  "\n" "警告：当基本数据类型的大小不是 2 的幂时，ms_struct 可能无法生成"
  "与 Microsoft 兼容的布局">,
  DefaultError, InGroup<IncompatibleMSStruct>;

def err_itanium_layout_unimplemented : Error<
  "Itanium-compatible layout for the Microsoft C++ ABI is not yet supported"
  "\n" "错误：尚不支持 Microsoft C++ ABI 的 Itanium 兼容布局">;

// Unsupported features in name mangling
def err_unsupported_itanium_mangling : Error<
    "cannot yet mangle "
    "%enum_select<UnsupportedItaniumManglingKind>"
    "{%FixedPointLiteral{fixed point literal}"
    "|%DependentNeonVector{dependent neon vector type}"
    "|%DependentFixedLengthSVEVector{dependent fixed-length SVE vector "
    "type}"
    "|%DependentFixedLengthRVVVectorType{dependent fixed-length RVV "
    "vector type}"
    "|%TernaryWithOmittedMiddleOperand{?: operator with omitted middle "
    "operand}"
    "|%OpenACCAsteriskSizeExpr{OpenACC Asterisk Size expression}"
    "|%UnnamedUnionNTTP{unnamed union non-type template parameter}"
    "|%RequiresExprWithSubstitutionFailure{requires-expression "
    "containing a substitution failure}"
    "}0"
    "\n" "错误：尚无法对 "
    "%enum_select<UnsupportedItaniumManglingKind>"
    "{%FixedPointLiteral{定点字面量}"
    "|%DependentNeonVector{依赖的 neon 向量类型}"
    "|%DependentFixedLengthSVEVector{依赖的定长 SVE 向量类型}"
    "|%DependentFixedLengthRVVVectorType{依赖的定长 RVV 向量类型}"
    "|%TernaryWithOmittedMiddleOperand{省略了中间操作数的 ?: 运算符}"
    "|%OpenACCAsteriskSizeExpr{OpenACC Asterisk 大小表达式}"
    "|%UnnamedUnionNTTP{未命名的联合非类型模板形参}"
    "|%RequiresExprWithSubstitutionFailure{包含替换失败的 requires 表达式}"
    "}0 进行名称改编">;

def err_unsupported_itanium_expr_mangling : Error<
    "cannot yet mangle %0 expression" "\n" "错误：尚无法对 %0 表达式进行名称改编">;

def err_ms_mangle_number_overflow : Error<
    "mangling number exceeds limit (65535)"
    "\n" "错误：名称改编编号超出限制（65535）">;
def err_ms_mangle_unsupported_with_detail : Error<
    "cannot mangle this %0 %1 yet" "\n" "错误：尚无法对 %0 %1 进行名称改编">;
def err_ms_mangle_unsupported : Error<
    "cannot mangle this %0 yet" "\n" "错误：尚无法对 %0 进行名称改编">;

def err_unexpected_vftable_component : Error<
    "unexpected vftable component type %0 for component number %1"
    "\n" "错误：组件编号 %1 出现意外的 vftable 组件类型 %0">;

// -Wpadded-bitfield
def warn_padded_struct_bitfield : Warning<
  "padding %select{struct|interface|class}0 %1 with %2 "
  "%select{byte|bit}3%s2 to align %4"
  "\n" "警告：填充%select{结构|接口|类}0 %1，用 %2 个%select{字节|位}3%s2 以对齐 %4">,
  InGroup<PaddedBitField>, DefaultIgnore;
def warn_padded_struct_anon_bitfield : Warning<
  "padding %select{struct|interface|class}0 %1 with %2 "
  "%select{byte|bit}3%s2 to align anonymous bit-field"
  "\n" "警告：填充%select{结构|接口|类}0 %1，用 %2 个%select{字节|位}3%s2 以对齐匿名位域">,
  InGroup<PaddedBitField>, DefaultIgnore;

// -Wpadded, -Wpacked
def warn_padded_struct_field : Warning<
  "padding %select{struct|interface|class}0 %1 with %2 "
  "%select{byte|bit}3%s2 to align %4"
  "\n" "警告：填充%select{结构|接口|类}0 %1，用 %2 个%select{字节|位}3%s2 以对齐 %4">,
  InGroup<Padded>, DefaultIgnore;
def warn_padded_struct_anon_field : Warning<
  "padding %select{struct|interface|class}0 %1 with %2 "
  "%select{byte|bit}3%s2 to align anonymous field"
  "\n" "警告：填充%select{结构|接口|类}0 %1，用 %2 个%select{字节|位}3%s2 以对齐匿名字段">,
  InGroup<Padded>, DefaultIgnore;
def warn_padded_struct_size : Warning<
  "padding size of %0 with %1 %select{byte|bit}2%s1 to alignment boundary"
  "\n" "警告：用 %1 个%select{字节|位}2%s1 填充 %0 的大小，以对齐到边界">,
  InGroup<Padded>, DefaultIgnore;
def warn_unnecessary_packed : Warning<
  "packed attribute is unnecessary for %0"
  "\n" "警告：%0 不需要 packed 特性">, InGroup<Packed>, DefaultIgnore;
def warn_unpacked_field
    : Warning<
          "not packing field %0 as it is non-POD for the purposes of layout"
          "\n" "警告：不打包字段 %0，因为它出于布局目的不是 POD">,
      InGroup<PackedNonPod>,
      DefaultIgnore;

// -Wunaligned-access
def warn_unaligned_access : Warning<
  "field %1 within %0 is less aligned than %2 and is usually due to %0 being "
  "packed, which can lead to unaligned accesses"
  "\n" "警告：%0 中的字段 %1 对齐程度低于 %2，通常是因为 %0 被 packed，"
  "这可能导致未对齐访问">, InGroup<UnalignedAccess>, DefaultIgnore;
}
