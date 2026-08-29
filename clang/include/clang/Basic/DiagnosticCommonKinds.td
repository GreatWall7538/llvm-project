//==--- DiagnosticCommonKinds.td - common diagnostics ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Common Helpers
//===----------------------------------------------------------------------===//

let Component = "Common" in {

// Substitutions.

def select_constexpr_spec_kind : TextSubstitution<
  "%select{<ERROR>|constexpr|consteval|constinit}0"
  "\n" "%select{<ERROR>|constexpr|consteval|constinit}0">;

// Basic.

def fatal_too_many_errors
  : Error<"too many errors emitted, stopping now"
          "\n" "错误：已发出过多错误，正在停止">, DefaultFatal;

def warn_stack_exhausted : Warning<
  "stack nearly exhausted; compilation time may suffer, and "
  "crashes due to stack overflow are likely"
  "\n" "警告：栈几乎耗尽；编译时间可能受到影响，并且很可能因栈溢出而崩溃">,
  InGroup<DiagGroup<"stack-exhausted">>, NoSFINAE;

def note_declared_at : Note<"declared here" "\n" "提示：在此处声明">;
def note_previous_definition : Note<"previous definition is here" "\n" "提示：先前定义在此处">;
def note_previous_declaration : Note<"previous declaration is here" "\n" "提示：先前声明在此处">;
def note_previous_implicit_declaration : Note<
  "previous implicit declaration is here"
  "\n" "提示：先前的隐式声明在此处">;
def note_previous_use : Note<"previous use is here" "\n" "提示：先前使用在此处">;
def note_duplicate_case_prev : Note<"previous case defined here" "\n" "提示：先前的 case 定义在此处">;
def note_forward_declaration : Note<"forward declaration of %0" "\n" "提示：%0 的前向声明">;
def note_type_being_defined : Note<
  "definition of %0 is not complete until the closing '}'"
  "\n" "提示：%0 的定义在右花括号 '}' 之前不完整">;
/// note_matching - this is used as a continuation of a previous diagnostic,
/// e.g. to specify the '(' when we expected a ')'.
def note_matching : Note<"to match this %0" "\n" "提示：以匹配此 %0">;

def note_using : Note<"using" "\n" "提示：using">;
def note_possibility : Note<"one possibility" "\n" "提示：一种可能性">;
def note_also_found : Note<"also found" "\n" "提示：也找到">;

// Parse && Lex

let CategoryName = "Lexical or Preprocessor Issue" in {

def err_expected_colon_after_setter_name : Error<
  "method name referenced in property setter attribute "
  "must end with ':'"
  "\n" "错误：在属性 setter 特性中引用的方法名称必须以 ':' 结尾">;
def err_expected_string_literal : Error<"expected string literal "
  "%select{in %1|for diagnostic message in static_assert|"
          "for optional message in 'availability' attribute|"
          "for %select{language name|source container name|USR}1 in "
          "'external_source_symbol' attribute|"
          "as argument of '%1' attribute}0"
  "\n" "错误：应为字符串字面量 "
  "%select{位于 %1 中|用于 static_assert 中的诊断消息|"
          "用于 'availability' 特性中的可选消息|"
          "用于 'external_source_symbol' 特性中的%select{语言名称|源容器名称|USR}1|"
          "作为 '%1' 特性的实参}0">;

def err_invalid_string_udl : Error<
  "string literal with user-defined suffix cannot be used here"
  "\n" "错误：带用户自定义后缀的字符串字面量不能在此处使用">;
def err_invalid_character_udl : Error<
  "character literal with user-defined suffix cannot be used here"
  "\n" "错误：带用户自定义后缀的字符字面量不能在此处使用">;
def err_invalid_numeric_udl : Error<
  "numeric literal with user-defined suffix cannot be used here"
  "\n" "错误：带用户自定义后缀的数值字面量不能在此处使用">;
def warn_pragma_debug_missing_argument : Warning<
  "missing argument to debug command '%0'"
  "\n" "警告：调试命令 '%0' 缺少实参">, InGroup<IgnoredPragmas>;
def warn_pragma_debug_unexpected_argument : Warning<
  "unexpected argument to debug command"
  "\n" "警告：调试命令的实参意外">, InGroup<IgnoredPragmas>;

def warn_fp_nan_inf_when_disabled : Warning<
  "use of %select{infinity|NaN}0%select{| via a macro}1 is undefined behavior "
  "due to the currently enabled floating-point options"
  "\n" "警告：由于当前启用的浮点选项，使用%select{无穷大|NaN}0%select{|通过宏}1是未定义行为">,
  InGroup<DiagGroup<"nan-infinity-disabled", [], NanInfDisabledDocs>>;
}

// Parse && Sema

let CategoryName = "Parse Issue" in {

def err_expected : Error<"expected %0" "\n" "错误：应为 %0">;
def err_expected_either : Error<"expected %0 or %1" "\n" "错误：应为 %0 或 %1">;
def err_expected_after : Error<"expected %1 after %0" "\n" "错误：在 %0 之后应为 %1">;

def err_param_redefinition : Error<"redefinition of parameter %0" "\n" "错误：形参 %0 被重新定义">;
def warn_method_param_redefinition : Warning<"redefinition of method parameter %0" "\n" "警告：方法形参 %0 被重新定义">;
def warn_method_param_declaration : Warning<"redeclaration of method parameter %0"
  "\n" "警告：方法形参 %0 被重新声明">,
  InGroup<DuplicateArgDecl>, DefaultIgnore;
def err_invalid_storage_class_in_func_decl : Error<
  "invalid storage class specifier in function declarator"
  "\n" "错误：函数声明符中出现无效的存储类说明符">;
def err_expected_namespace_name : Error<"expected namespace name" "\n" "错误：应为命名空间名称">;
def ext_variadic_templates : ExtWarn<
  "variadic templates are a C++11 extension"
  "\n" "警告：可变参数模板是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_variadic_templates :
  Warning<"variadic templates are incompatible with C++98"
  "\n" "警告：可变参数模板与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_default_special_members : Error<
  "only special member functions %select{|and comparison operators }0"
  "may be defaulted"
  "\n" "错误：只有特殊成员函数%select{|和比较运算符 }0可以被默认化">;
def err_deleted_non_function : Error<
  "only functions can have deleted definitions"
  "\n" "错误：只有函数才能具有被删除的定义">;
def err_module_not_found : Error<"module '%0' not found"
  "\n" "错误：未找到模块 '%0'">, DefaultFatal;
def err_module_not_built : Error<"could not build module '%0'"
  "\n" "错误：无法构建模块 '%0'">, DefaultFatal;
def err_module_not_written : Error<"could not write module file for '%0' to '%1': %2"
  "\n" "错误：无法将模块文件为 '%0' 写入 '%1'：%2">, DefaultFatal;
def err_module_build_disabled: Error<
  "module '%0' is needed but has not been provided, and implicit use of module "
  "files is disabled"
  "\n" "错误：需要模块 '%0' 但未提供，且禁止隐式使用模块文件">, DefaultFatal;
def err_module_unavailable : Error<
  "module '%0' %select{is incompatible with|requires}1 feature '%2'"
  "\n" "错误：模块 '%0' %select{与……不兼容|需要}1特性 '%2'">;
def err_module_header_missing : Error<
  "%select{|umbrella }0header '%1' not found"
  "\n" "错误：%select{|伞 }0头文件 '%1' 未找到">;
def remark_module_lock_failure : Remark<
  "could not acquire lock file for module '%0': %1"
  "\n" "备注：无法为模块 '%0' 获取锁文件：%1">, InGroup<ModuleBuild>;
def remark_module_lock_timeout : Remark<
  "timed out waiting to acquire lock file for module '%0'"
  "\n" "备注：等待为模块 '%0' 获取锁文件超时">, InGroup<ModuleBuild>;
def err_module_shadowed : Error<"import of shadowed module '%0'"
  "\n" "错误：导入被遮蔽的模块 '%0'">, DefaultFatal;
def err_module_build_shadowed_submodule : Error<
  "build a shadowed submodule '%0'"
  "\n" "错误：构建被遮蔽的子模块 '%0'">, DefaultFatal;
def err_module_cycle : Error<"cyclic dependency in module '%0': %1"
  "\n" "错误：模块 '%0' 中存在循环依赖：%1">,
  DefaultFatal;
def err_module_prebuilt : Error<
  "error in loading module '%0' from prebuilt module path"
  "\n" "错误：从预构建模块路径加载模块 '%0' 时出错">, DefaultFatal;
def err_module_rebuild_finalized : Error<
  "cannot rebuild module '%0' as it is already finalized"
  "\n" "错误：无法重建模块 '%0'，因为它已定型">, DefaultFatal;
def note_pragma_entered_here : Note<"#pragma entered here" "\n" "提示：#pragma 在此处进入">;
def note_decl_hiding_tag_type : Note<
  "%1 %0 is hidden by a non-type declaration of %0 here"
  "\n" "提示：%1 %0 在此处被 %0 的非类型声明隐藏">;
def err_attribute_not_type_attr : Error<
  "%0%select{ attribute|}1 cannot be applied to types"
  "\n" "错误：%0%select{ 特性|}1不能应用于类型">;
def err_enum_template : Error<"enumeration cannot be a template"
  "\n" "错误：枚举不能是模板">;

def warn_cxx20_compat_consteval
    : Warning<"'consteval' specifier is incompatible with C++ standards before "
              "C++20"
              "\n" "警告：'consteval' 说明符与 C++20 之前的 C++ 标准不兼容">,
      InGroup<CXXPre20Compat>,
      DefaultIgnore;
def warn_missing_type_specifier : Warning<
  "type specifier missing, defaults to 'int'"
  "\n" "警告：缺少类型说明符，默认为 'int'">,
  InGroup<ImplicitInt>, DefaultIgnore;

def ext_c_empty_initializer : Extension<
  "use of an empty initializer is a C23 extension"
  "\n" "警告：使用空初始化式是 C23 扩展">, InGroup<C23>;
def warn_c23_compat_empty_initializer : Warning<
  "use of an empty initializer is incompatible with C standards before C23"
  "\n" "警告：使用空初始化式与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
}

let CategoryName = "Nullability Issue" in {

def warn_nullability_duplicate : Warning<
  "duplicate nullability specifier %0"
  "\n" "警告：重复的可空性说明符 %0">,
  InGroup<Nullability>;

def warn_conflicting_nullability_attr_overriding_ret_types : Warning<
  "conflicting nullability specifier on return types, %0 "
  "conflicts with existing specifier %1"
  "\n" "警告：返回类型上的可空性说明符冲突，%0 与现有说明符 %1 冲突">,
  InGroup<Nullability>;

def warn_conflicting_nullability_attr_overriding_param_types : Warning<
  "conflicting nullability specifier on parameter types, %0 "
  "conflicts with existing specifier %1"
  "\n" "警告：形参类型上的可空性说明符冲突，%0 与现有说明符 %1 冲突">,
  InGroup<Nullability>;

def err_nullability_conflicting : Error<
  "nullability specifier %0 conflicts with existing specifier %1"
  "\n" "错误：可空性说明符 %0 与现有说明符 %1 冲突">;

def warn_incompatible_branch_protection_option: Warning <
  "'-mbranch-protection=' option is incompatible with the '%0' architecture"
  "\n" "警告：'-mbranch-protection=' 选项与 '%0' 架构不兼容">,
  InGroup<BranchProtection>;

def warn_target_unsupported_branch_protection_attribute: Warning <
  "ignoring the 'branch-protection' attribute because the '%0' architecture does not support it"
  "\n" "警告：忽略 'branch-protection' 特性，因为 '%0' 架构不支持它">,
  InGroup<BranchProtection>;
}

// OpenCL Section 6.8.g
def err_opencl_unknown_type_specifier : Error<
  "%0 does not support the '%1' "
  "%select{type qualifier|storage class specifier}2"
  "\n" "错误：%0 不支持 '%1' %select{类型限定符|存储类说明符}2">;

def warn_unknown_attribute_ignored : Warning<
  "unknown attribute %0 ignored"
  "\n" "警告：未知特性 %0 被忽略">, InGroup<UnknownAttributes>;
def warn_unknown_attribute_ignored_suggestion : Warning<
  "unknown attribute %0 ignored; did you mean '%1'?"
  "\n" "警告：未知特性 %0 被忽略；您是指 '%1' 吗？">, InGroup<UnknownAttributes>;
def warn_attribute_ignored : Warning<"%0 attribute ignored"
  "\n" "警告：特性 %0 被忽略">,
  InGroup<IgnoredAttributes>;
def err_keyword_not_supported_on_target : Error<
  "%0 is not supported on this target"
  "\n" "错误：此目标不支持 %0">;
def err_use_of_tag_name_without_tag : Error<
  "must use '%1' tag to refer to type %0%select{| in this scope}2"
  "\n" "错误：必须使用 '%1' 标签来引用类型 %0%select{|在此作用域中}2">;

def duplicate_declspec : TextSubstitution<
  "duplicate '%0' declaration specifier"
  "\n" "重复的 '%0' 声明说明符">;

def ext_duplicate_declspec : Extension<"%sub{duplicate_declspec}0"
  "\n" "警告：%sub{duplicate_declspec}0">,
  InGroup<DuplicateDeclSpecifier>;
def ext_warn_duplicate_declspec : ExtWarn<"%sub{duplicate_declspec}0"
  "\n" "警告：%sub{duplicate_declspec}0">,
  InGroup<DuplicateDeclSpecifier>;
def warn_duplicate_declspec : Warning<"%sub{duplicate_declspec}0"
  "\n" "警告：%sub{duplicate_declspec}0">,
  InGroup<DuplicateDeclSpecifier>;

def err_duplicate_declspec : Error<"%sub{duplicate_declspec}0"
  "\n" "错误：%sub{duplicate_declspec}0">;

def err_friend_decl_spec : Error<"'%0' is invalid in friend declarations"
  "\n" "错误：'%0' 在友元声明中无效">;

def err_invalid_member_in_interface : Error<
  "%select{data member |non-public member function |static member function |"
          "user-declared constructor|user-declared destructor|operator |"
          "nested class }0%1 is not permitted within an interface type"
  "\n" "错误：%select{数据成员 |非公开成员函数 |静态成员函数 |"
          "用户声明的构造函数|用户声明的析构函数|运算符 |"
          "嵌套类 }0%1 不允许出现在接口类型中">;

def err_attribute_uuid_malformed_guid : Error<
  "uuid attribute contains a malformed GUID"
  "\n" "错误：uuid 特性包含格式错误的 GUID">;

// Sema && Lex
def ext_c99_longlong : Extension<
  "'long long' is an extension when C99 mode is not enabled"
  "\n" "警告：'long long' 在未启用 C99 模式时是扩展">,
  InGroup<LongLong>;
def ext_cxx11_longlong : Extension<
  "'long long' is a C++11 extension"
  "\n" "警告：'long long' 是 C++11 扩展">,
  InGroup<CXX11LongLong>;
def warn_cxx98_compat_longlong : Warning<
  "'long long' is incompatible with C++98"
  "\n" "警告：'long long' 与 C++98 不兼容">,
  InGroup<CXX98CompatPedantic>, DefaultIgnore;
def ext_cxx23_size_t_suffix : ExtWarn<
  "'size_t' suffix for literals is a C++23 extension"
  "\n" "警告：字面量的 'size_t' 后缀是 C++23 扩展">,
  InGroup<CXX23>;
def warn_cxx20_compat_size_t_suffix : Warning<
  "'size_t' suffix for literals is incompatible with C++ standards before "
  "C++23"
  "\n" "警告：字面量的 'size_t' 后缀与 C++23 之前的 C++ 标准不兼容">, InGroup<CXXPre23Compat>, DefaultIgnore;
def err_cxx23_size_t_suffix: Error<
  "'size_t' suffix for literals is a C++23 feature"
  "\n" "错误：字面量的 'size_t' 后缀是 C++23 特性">;
def err_size_t_literal_too_large: Error<
  "%select{signed |}0'size_t' literal is out of range of possible "
  "%select{signed |}0'size_t' values"
  "\n" "错误：%select{有符号 |}0'size_t' 字面量超出可能的 "
  "%select{有符号 |}0'size_t' 值的范围">;
def ext_cxx_bitint_suffix : Extension<
  "'_BitInt' suffix for literals is a Clang extension"
  "\n" "警告：字面量的 '_BitInt' 后缀是 Clang 扩展">,
  InGroup<BitIntExtension>;
def ext_c23_bitint_suffix : ExtWarn<
  "'_BitInt' suffix for literals is a C23 extension"
  "\n" "警告：字面量的 '_BitInt' 后缀是 C23 扩展">,
  InGroup<C23>;
def warn_c23_compat_bitint_suffix : Warning<
  "'_BitInt' suffix for literals is incompatible with C standards before C23"
  "\n" "警告：字面量的 '_BitInt' 后缀与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def err_integer_literal_too_large : Error<
  "integer literal is too large to be represented in any %select{signed |}0"
  "integer type"
  "\n" "错误：整数字面量过大，无法在任何%select{有符号 |}0整数类型中表示">;
def ext_integer_literal_too_large_for_signed : ExtWarn<
  "integer literal is too large to be represented in a signed integer type, "
  "interpreting as unsigned"
  "\n" "警告：整数字面量过大，无法在带符号整数类型中表示，将解释为无符号">,
  InGroup<ImplicitlyUnsignedLiteral>;
def warn_old_implicitly_unsigned_long : Warning<
  "integer literal is too large to be represented in type 'long', "
  "interpreting as 'unsigned long' per C89; this literal will "
  "%select{have type 'long long'|be ill-formed}0 in C99 onwards"
  "\n" "警告：整数字面量过大，无法在类型 'long' 中表示，根据 C89 将解释为 'unsigned long'；"
  "此字面量在 C99 及以后将%select{具有类型 'long long'|为非良构}0">,
  InGroup<C99Compat>;
def warn_old_implicitly_unsigned_long_cxx : Warning<
  "integer literal is too large to be represented in type 'long', "
  "interpreting as 'unsigned long' per C++98; this literal will "
  "%select{have type 'long long'|be ill-formed}0 in C++11 onwards"
  "\n" "警告：整数字面量过大，无法在类型 'long' 中表示，根据 C++98 将解释为 'unsigned long'；"
  "此字面量在 C++11 及以后将%select{具有类型 'long long'|为非良构}0">,
  InGroup<CXX11Compat>;
def ext_old_implicitly_unsigned_long_cxx : ExtWarn<
  "integer literal is too large to be represented in type 'long' and is "
  "subject to undefined behavior under C++98, interpreting as 'unsigned long'; "
  "this literal will %select{have type 'long long'|be ill-formed}0 "
  "in C++11 onwards"
  "\n" "警告：整数字面量过大，无法在类型 'long' 中表示，在 C++98 下存在未定义行为，"
  "将解释为 'unsigned long'；此字面量在 C++11 及以后将"
  "%select{具有类型 'long long'|为非良构}0">,
  InGroup<CXX11Compat>;
def ext_clang_enable_if : Extension<"'enable_if' is a clang extension"
  "\n" "警告：'enable_if' 是 clang 扩展">,
                          InGroup<GccCompat>;
def ext_clang_diagnose_if : Extension<"'diagnose_if' is a clang extension"
  "\n" "警告：'diagnose_if' 是 clang 扩展">,
                            InGroup<GccCompat>;
def err_too_large_for_fixed_point : Error<
  "this value is too large for this fixed point type"
  "\n" "错误：此值对于此定点类型过大">;
def err_unimplemented_conversion_with_fixed_point_type : Error<
  "conversion between fixed point and %0 is not yet supported"
  "\n" "错误：尚不支持定点与 %0 之间的转换">;

def err_requires_positive_value : Error<
  "%select{invalid value '%0'; must be positive|value '%0' is too large}1"
  "\n" "错误：%select{无效值 '%0'；必须为正|值 '%0' 过大}1">;

// SEH
def err_seh_expected_handler : Error<
  "expected '__except' or '__finally' block"
  "\n" "错误：应为 '__except' 或 '__finally' 块">;
def err_seh___except_block : Error<
  "%0 only allowed in __except block or filter expression"
  "\n" "错误：%0 只允许出现在 __except 块或筛选表达式中">;
def err_seh___except_filter : Error<
  "%0 only allowed in __except filter expression"
  "\n" "错误：%0 只允许出现在 __except 筛选表达式中">;
def err_seh___finally_block : Error<
  "%0 only allowed in __finally block"
  "\n" "错误：%0 只允许出现在 __finally 块中">;
def err_seh_object_unwinding : Error<
  "'__try' is not permitted in functions that require object unwinding"
  "\n" "错误：'__try' 不允许出现在需要对象展开的函数中">;

// Sema && AST
def note_invalid_subexpr_in_const_expr : Note<
  "subexpression not valid in a constant expression"
  "\n" "提示：子表达式在常量表达式中无效">;
def note_constexpr_invalid_template_arg : Note<
  "%select{pointer|reference}0 to %select{|subobject of }1"
  "%select{type_info object|string literal|temporary object|"
  "predefined '%3' variable}2 is not allowed in a template argument"
  "\n" "提示：%select{指针|引用}0 指向%select{|子对象 }1"
  "%select{type_info 对象|字符串字面量|临时对象|"
  "预定义的 '%3' 变量}2，不允许用作模板实参">;
def err_constexpr_invalid_template_arg : Error<
  note_constexpr_invalid_template_arg.Summary>;

// Sema && Frontend
let CategoryName = "Inline Assembly Issue" in {
def err_asm_invalid_type_in_input : Error<
  "invalid type %0 in asm input for constraint '%1'"
  "\n" "错误：约束 '%1' 的 asm 输入中出现无效类型 %0">;

def err_asm_invalid_type : Error<
  "invalid type %0 in asm %select{input|output}1"
  "\n" "错误：asm %select{输入|输出}1 中出现无效类型 %0">;

def err_ms_asm_bitfield_unsupported : Error<
  "an inline asm block cannot have an operand which is a bit-field"
  "\n" "错误：内联 asm 块不能有作为位域的操作数">;

def warn_stack_clash_protection_inline_asm : Warning<
  "unable to protect inline asm that clobbers stack pointer against stack "
  "clash"
  "\n" "警告：无法保护会破坏栈指针的内联 asm 免受栈冲突的影响">, InGroup<DiagGroup<"stack-protector">>;

def warn_stack_protection_ignore_attribute : Warning<
  "'stack_protector_ignore' attribute ignored due to "
  "'-fstack-protector-all' option"
  "\n" "警告：由于 '-fstack-protector-all' 选项，'stack_protector_ignore' 特性被忽略">, InGroup<IgnoredAttributes>;

def warn_slh_does_not_support_asm_goto : Warning<
  "speculative load hardening does not protect functions with asm goto"
  "\n" "警告：推测性加载强化不保护带有 asm goto 的函数">,
  InGroup<DiagGroup<"slh-asm-goto">>;
}

// Sema && Serialization
def warn_dup_category_def : Warning<
  "duplicate definition of category %1 on interface %0"
  "\n" "警告：接口 %0 上类别 %1 的重复定义">,
  InGroup<DiagGroup<"objc-duplicate-category-definition">>;

// Targets

def err_target_unknown_triple : Error<
  "unknown target triple '%0'"
  "\n" "错误：未知的目标三元组 '%0'">;
def err_target_unknown_cpu : Error<"unknown target CPU '%0'"
  "\n" "错误：未知的目标 CPU '%0'">;
def note_valid_options : Note<"valid target CPU values are: %0"
  "\n" "提示：有效的目标 CPU 值为：%0">;
def err_target_unsupported_cpu_for_micromips : Error<
  "micromips is not supported for target CPU '%0'"
  "\n" "错误：目标 CPU '%0' 不支持 micromips">;
def err_target_unknown_abi : Error<"unknown target ABI '%0'"
  "\n" "错误：未知的目标 ABI '%0'">;
def err_target_unsupported_abi : Error<"ABI '%0' is not supported on CPU '%1'"
  "\n" "错误：CPU '%1' 上不支持 ABI '%0'">;
def err_target_unsupported_abi_for_triple : Error<
  "ABI '%0' is not supported for '%1'"
  "\n" "错误：'%1' 不支持 ABI '%0'">;
def err_unsupported_abi_for_opt : Error<"'%0' can only be used with the '%1' ABI"
  "\n" "错误：'%0' 只能与 '%1' ABI 一起使用">;
def err_mips_fp64_req : Error<
    "'%0' can only be used if the target supports the mfhc1 and mthc1 instructions"
    "\n" "错误：只有在目标支持 mfhc1 和 mthc1 指令时才能使用 '%0'">;
def err_target_unknown_fpmath : Error<"unknown FP unit '%0'"
  "\n" "错误：未知的 FP 单元 '%0'">;
def err_target_unsupported_fpmath : Error<
    "the '%0' unit is not supported with this instruction set"
    "\n" "错误：此指令集不支持 '%0' 单元">;
def err_target_unsupported_unaligned : Error<
  "the %0 sub-architecture does not support unaligned accesses"
  "\n" "错误：%0 子架构不支持未对齐访问">;
def err_target_unsupported_execute_only : Error<
  "execute only is not supported for the %0 sub-architecture"
  "\n" "错误：%0 子架构不支持只执行模式">;
def err_target_unsupported_tp_hard : Error<
  "hardware TLS register is not supported for the %0 sub-architecture"
  "\n" "错误：%0 子架构不支持硬件 TLS 寄存器">;
def err_target_unsupported_mcmse : Error<
  "-mcmse is not supported for %0"
  "\n" "错误：%0 不支持 -mcmse">;
def err_opt_not_valid_with_opt : Error<
  "option '%0' cannot be specified with '%1'"
  "\n" "错误：选项 '%0' 不能与 '%1' 一起指定">;
def err_opt_not_valid_with_opt_on_target : Error<
  "option '%0' cannot be specified with '%1' for the %2 sub-architecture"
  "\n" "错误：选项 '%0' 不能与 '%1' 一起为 %2 子架构指定">;
def err_opt_not_valid_without_opt : Error<
  "option '%0' cannot be specified without '%1'"
  "\n" "错误：选项 '%0' 不能在未指定 '%1' 的情况下指定">;
def err_opt_not_valid_on_target : Error<
  "option '%0' cannot be specified on this target"
  "\n" "错误：选项 '%0' 不能在此目标上指定">;
def err_opt_unsupported_with_suggest : Error<
  "option '%0' is unsupported; consider using '%1'"
  "\n" "错误：不支持选项 '%0'；请考虑使用 '%1'">;
def err_invalid_feature_combination : Error<
  "invalid feature combination: %0"
  "\n" "错误：无效的特性组合：%0">;
def warn_invalid_feature_combination : Warning<
  "invalid feature combination: %0"
  "\n" "警告：无效的特性组合：%0">, InGroup<DiagGroup<"invalid-feature-combination">>;
def warn_target_unrecognized_env : Warning<
  "mismatch between architecture and environment in target triple '%0'; did you mean '%1'?"
  "\n" "警告：目标三元组 '%0' 中架构与环境不匹配；您是指 '%1' 吗？">,
  InGroup<InvalidCommandLineArgument>;
def err_target_unsupported_abi_with_fpu : Error<
  "'%0' ABI is not supported with FPU"
  "\n" "错误：不支持带 FPU 的 '%0' ABI">;

def err_ppc_impossible_musttail: Error<
  "'musttail' attribute for this call is impossible because %select{"
  "long calls cannot be tail called on PPC|"
  "indirect calls cannot be tail called on PPC|"
  "external calls cannot be tail called on PPC}0"
  "\n" "错误：此调用的 'musttail' 特性不可能实现，因为%select{"
  "长调用无法在 PPC 上进行尾调用|"
  "间接调用无法在 PPC 上进行尾调用|"
  "外部调用无法在 PPC 上进行尾调用}0"
  >;
def err_mips_impossible_musttail: Error<
  "'musttail' attribute for this call is impossible because %select{"
  "the MIPS16 ABI does not support tail calls|"
  "calls outside the current linkage unit cannot be tail called on MIPS}0"
  "\n" "错误：此调用的 'musttail' 特性不可能实现，因为%select{"
  "MIPS16 ABI 不支持尾调用|"
  "当前链接单元之外的调用无法在 MIPS 上进行尾调用}0"
  >;
def err_aix_musttail_unsupported: Error<
  "'musttail' attribute is not supported on AIX"
  "\n" "错误：AIX 上不支持 'musttail' 特性">;
def err_musttail_noexcept_mismatch: Error<
  "'musttail' in a noexcept function requires a noexcept callee"
  "\n" "错误：noexcept 函数中的 'musttail' 需要 noexcept 的被调用方">;

// Source manager
def err_cannot_open_file : Error<"cannot open file '%0': %1"
  "\n" "错误：无法打开文件 '%0'：%1">, DefaultFatal;
def err_file_modified : Error<
  "file '%0' modified since it was first processed"
  "\n" "错误：文件 '%0' 自首次处理以来已被修改">, DefaultFatal;
def err_file_too_large : Error<
  "file '%0' is too large for Clang to process"
  "\n" "错误：文件 '%0' 过大，Clang 无法处理">;
def err_sloc_space_too_large : Error<
  "translation unit is too large for Clang to process: ran out of source locations"
  "\n" "错误：翻译单元过大，Clang 无法处理：源位置已用尽">, DefaultFatal;
def err_unsupported_bom : Error<"%0 byte order mark detected in '%1', but "
  "encoding is not supported"
  "\n" "错误：在 '%1' 中检测到 %0 字节序标记，但不支持该编码">, DefaultFatal;
def err_unable_to_rename_temp : Error<
  "unable to rename temporary '%0' to output file '%1': '%2'"
  "\n" "错误：无法将临时文件 '%0' 重命名为输出文件 '%1'：'%2'">;
def err_unable_to_make_temp : Error<
  "unable to make temporary file: %0"
  "\n" "错误：无法创建临时文件：%0">;
def remark_sloc_usage : Remark<
  "source manager location address space usage:"
  "\n" "备注：源管理器位置地址空间使用情况：">,
  InGroup<DiagGroup<"sloc-usage">>, DefaultRemark, ShowInSystemHeader;
def note_total_sloc_usage : Note<
  "%0B (%human0B) in local locations, %1B (%human1B) "
  "in locations loaded from AST files, for a total of %2B (%human2B) "
  "(%3%% of available space)"
  "\n" "提示：本地位置使用 %0B（%human0B），从 AST 文件加载的位置使用 %1B（%human1B），"
  "总计 %2B（%human2B）（占可用空间的 %3%%）">;
def note_file_sloc_usage : Note<
  "file entered %0 time%s0 using %1B (%human1B) of space"
  "%plural{0:|: plus %2B (%human2B) for macro expansions}2"
  "\n" "提示：文件进入 %0 次%s0，使用 %1B（%human1B）空间"
  "%plural{0:|：外加 %2B（%human2B）用于宏展开}2">;
def note_file_misc_sloc_usage : Note<
  "%0 additional files entered using a total of %1B (%human1B) of space"
  "\n" "提示：另外进入的 %0 个文件共使用 %1B（%human1B）空间">;

// Modules
def err_module_format_unhandled : Error<
  "no handler registered for module format '%0'"
  "\n" "错误：未为模块格式 '%0' 注册处理程序">, DefaultFatal;

// API notes
def err_apinotes_message : Error<"%0" "\n" "错误：%0">;
def warn_apinotes_message : Warning<"%0" "\n" "警告：%0">, InGroup<DiagGroup<"apinotes">>;
def note_apinotes_message : Note<"%0" "\n" "提示：%0">;

class NonportablePrivateAPINotesPath  : Warning<
  "private API notes file for module '%0' should be named "
  "'%0_private.apinotes', not '%1'"
  "\n" "警告：模块 '%0' 的私有 API 备注文件应命名为 "
  "'%0_private.apinotes'，而不是 '%1'">;
def warn_apinotes_private_case : NonportablePrivateAPINotesPath,
  InGroup<DiagGroup<"nonportable-private-apinotes-path">>;
def warn_apinotes_private_case_system : NonportablePrivateAPINotesPath,
  DefaultIgnore, InGroup<DiagGroup<"nonportable-private-system-apinotes-path">>;

// C++ for OpenCL.
def err_openclcxx_not_supported : Error<
  "'%0' is not supported in C++ for OpenCL"
  "\n" "错误：OpenCL 的 C++ 中不支持 '%0'">;

// HIP
def warn_ignored_hip_only_option : Warning<
  "'%0' is ignored since it is only supported for HIP"
  "\n" "警告：'%0' 被忽略，因为它仅支持 HIP">,
  InGroup<HIPOnly>;

// OpenMP
def err_omp_more_one_clause : Error<
  "directive '#pragma omp %0' cannot contain more than one '%1' clause%select{| with '%3' name modifier| with 'source' dependence}2"
  "\n" "错误：指令 '#pragma omp %0' 不能包含多个 '%1' 子句%select{|带 '%3' 名称修饰符|带 'source' 依赖}2">;
def err_omp_required_clause : Error<
  "directive '#pragma omp %0' requires the '%1' clause"
  "\n" "错误：指令 '#pragma omp %0' 需要 '%1' 子句">;
def warn_omp_gpu_unsupported_clause: Warning<
  "clause '%0' is currently not supported on a GPU; clause ignored"
  "\n" "警告：当前不支持在 GPU 上使用子句 '%0'；子句被忽略">,
  InGroup<OpenMPClauses>;
def warn_omp_gpu_unsupported_modifier_for_clause: Warning<
  "modifier '%0' is currently not supported on a GPU for the '%1' clause; modifier ignored"
  "\n" "警告：当前不支持在 GPU 上为 '%1' 子句使用修饰符 '%0'；修饰符被忽略">,
  InGroup<OpenMPClauses>;

// Static Analyzer Core
def err_unknown_analyzer_checker_or_package : Error<
    "no analyzer checkers or packages are associated with '%0'"
    "\n" "错误：没有与 '%0' 关联的分析器检查器或包">;
def note_suggest_disabling_all_checkers : Note<
    "use -analyzer-disable-all-checks to disable all static analyzer checkers"
    "\n" "提示：使用 -analyzer-disable-all-checks 禁用所有静态分析器检查器">;

// Poison system directories.
def warn_poison_system_directories : Warning <
  "include location '%0' is unsafe for cross-compilation"
  "\n" "警告：包含位置 '%0' 对交叉编译不安全">,
  InGroup<DiagGroup<"poison-system-directories">>, DefaultIgnore;

def warn_opencl_unsupported_core_feature : Warning<
  "%0 is a core feature in %select{OpenCL C|C++ for OpenCL}1 version %2 but not supported on this target"
  "\n" "警告：%0 是 %select{OpenCL C|OpenCL 的 C++}1 版本 %2 中的核心特性，但此目标不支持">,
  InGroup<OpenCLCoreFeaturesDiagGroup>, DefaultIgnore;

def err_opencl_extension_and_feature_differs : Error<
  "options %0 and %1 are set to different values"
  "\n" "错误：选项 %0 和 %1 被设置为不同的值">;
def err_opencl_feature_requires : Error<
  "feature %0 requires support of %1 feature"
  "\n" "错误：特性 %0 需要支持 %1 特性">;

def warn_throw_not_valid_on_target : Warning<
  "target '%0' does not support exception handling;"
  " 'throw' is assumed to be never reached"
  "\n" "警告：目标 '%0' 不支持异常处理；"
  " 'throw' 假定为永远不会执行到">,
  InGroup<OpenMPTargetException>;
def warn_try_not_valid_on_target : Warning<
  "target '%0' does not support exception handling;"
  " 'catch' block is ignored"
  "\n" "警告：目标 '%0' 不支持异常处理；"
  " 'catch' 块被忽略">,
  InGroup<OpenMPTargetException>;
}
