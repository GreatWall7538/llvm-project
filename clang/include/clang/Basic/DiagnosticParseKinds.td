//==--- DiagnosticParseKinds.td - libparse diagnostics --------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Parser Diagnostics
//===----------------------------------------------------------------------===//

let Component = "Parse" in {
let CategoryName = "Parse Issue" in {
// C++11 compatibility with C++98.
defm enum_fixed_underlying_type : CXX11Compat<
  "enumeration types with a fixed underlying type are"
  "\n" "警告：具有固定底层类型的枚举类型是",
  /*ext_warn=*/false>;
}

def err_asm_qualifier_ignored : Error<
  "expected 'volatile', 'inline', 'goto', or '('"
  "\n" "错误：应为 'volatile'、'inline'、'goto' 或 '('">, CatInlineAsm;
def err_global_asm_qualifier_ignored : Error<
  "meaningless '%0' on asm outside function"
  "\n" "错误：函数外部的 asm 上的 '%0' 无意义">, CatInlineAsm;

let CategoryName = "Inline Assembly Issue" in {
def err_asm_empty : Error<"__asm used with no assembly instructions"
  "\n" "错误：__asm 使用但没有汇编指令">;
def err_inline_ms_asm_parsing : Error<"%0"
  "\n" "错误：%0">;
def err_msasm_unsupported_arch : Error<
  "unsupported architecture '%0' for MS-style inline assembly"
  "\n" "错误：MS 风格内联汇编不支持架构 '%0'">;
def err_msasm_unable_to_create_target : Error<
  "MS-style inline assembly is not available: %0"
  "\n" "错误：MS 风格内联汇编不可用：%0">;
def err_gnu_inline_asm_disabled : Error<
  "GNU-style inline assembly is disabled"
  "\n" "错误：GNU 风格内联汇编已禁用">;
def err_asm_duplicate_qual : Error<"duplicate asm qualifier '%0'"
  "\n" "错误：重复的 asm 限定符 '%0'">;
}

let CategoryName = "Parse Issue" in {

def ext_empty_translation_unit : Extension<
  "ISO C requires a translation unit to contain at least one declaration"
  "\n" "警告：ISO C 要求翻译单元至少包含一个声明">,
  InGroup<DiagGroup<"empty-translation-unit">>;
def warn_cxx98_compat_top_level_semi : Warning<
  "extra ';' outside of a function is incompatible with C++98"
  "\n" "警告：函数外的多余 ';' 与 C++98 不兼容">,
  InGroup<CXX98CompatExtraSemi>, DefaultIgnore;
def ext_extra_semi : Extension<
  "extra ';' %select{"
  "outside of a function|"
  "inside a %1|"
  "inside instance variable list|"
  "after member function definition}0"
  "\n" "警告：%select{函数外|%1 内|实例变量列表中|成员函数定义后}0多余的 ';'">,
  InGroup<ExtraSemi>;
def ext_extra_semi_cxx11 : Extension<
  "extra ';' outside of a function is a C++11 extension"
  "\n" "警告：函数外的多余 ';' 是 C++11 扩展">,
  InGroup<CXX11ExtraSemi>;
def warn_extra_semi_after_mem_fn_def : Warning<
  "extra ';' after member function definition"
  "\n" "警告：成员函数定义后的多余 ';'">,
  InGroup<ExtraSemi>, DefaultIgnore;
def warn_null_statement : Warning<
  "empty expression statement has no effect; "
  "remove unnecessary ';' to silence this warning"
  "\n" "警告：空表达式语句无效；请移除不必要的 ';' 以消除此警告">,
  InGroup<ExtraSemiStmt>, DefaultIgnore;

def warn_misleading_indentation : Warning<
  "misleading indentation; statement is not part of "
  "the previous '%select{if|else|for|while}0'"
  "\n" "警告：误导性缩进；该语句不是前一个 '%select{if|else|for|while}0' 的一部分">,
  InGroup<MisleadingIndentation>, DefaultIgnore;
def note_previous_statement : Note<
  "previous statement is here"
  "\n" "提示：先前的语句在此">;

def subst_compound_token_kind : TextSubstitution<
  "%select{%1 and |}0%2 tokens "
  "%select{introducing statement expression|terminating statement expression|"
  "introducing attribute|terminating attribute|"
  "forming pointer to member type}3"
  "\n" "%select{%1 与 |}0%2 个标记 "
  "%select{引入语句表达式|终止语句表达式|"
  "引入特性|终止特性|"
  "形成指向成员类型的指针}3">;
def warn_compound_token_split_by_macro : Warning<
  "%sub{subst_compound_token_kind}0,1,2,3 appear in different "
  "macro expansion contexts"
  "\n" "警告：%sub{subst_compound_token_kind}0,1,2,3 出现在不同的宏展开上下文中">,
  InGroup<CompoundTokenSplitByMacro>;
def note_compound_token_split_second_token_here : Note<
  "%select{|second }0%1 token is here"
  "\n" "提示：%select{|第二个 }0%1 标记在此">;
def warn_compound_token_split_by_whitespace : Warning<
  "%sub{subst_compound_token_kind}0,1,2,3 are separated by whitespace"
  "\n" "警告：%sub{subst_compound_token_kind}0,1,2,3 之间被空白分隔">,
  InGroup<CompoundTokenSplitBySpace>, DefaultIgnore;

def ext_thread_before : Extension<"'__thread' before '%0'"
  "\n" "警告：'%0' 之前的 '__thread'">;
def ext_keyword_as_ident : ExtWarn<
  "keyword '%0' will be made available as an identifier "
  "%select{here|for the remainder of the translation unit}1"
  "\n" "警告：关键字 '%0' 将%select{在此|在翻译单元的其余部分}1作为标识符使用">,
  InGroup<KeywordCompat>;

def ext_nullability : Extension<
  "type nullability specifier %0 is a Clang extension"
  "\n" "警告：类型可空性说明符 %0 是 Clang 扩展">,
  InGroup<DiagGroup<"nullability-extension">>;

def err_empty_enum : Error<"use of empty enum"
  "\n" "错误：使用了空枚举">;

def ext_ident_list_in_param : Extension<
  "type-less parameter names in function declaration"
  "\n" "警告：函数声明中的无类型参数名">;
def ext_c99_variable_decl_in_for_loop : Extension<
  "variable declaration in for loop is a C99-specific feature"
  "\n" "警告：for 循环中的变量声明是 C99 特性">, InGroup<C99>;
def ext_c99_compound_literal : Extension<
  "compound literals are a C99-specific feature"
  "\n" "警告：复合字面量是 C99 特性">, InGroup<C99>;
def ext_enumerator_list_comma_c : Extension<
  "commas at the end of enumerator lists are a C99-specific "
  "feature"
  "\n" "警告：枚举列表末尾的逗号是 C99 特性">, InGroup<C99>;
def ext_enumerator_list_comma_cxx : Extension<
  "commas at the end of enumerator lists are a C++11 extension"
  "\n" "警告：枚举列表末尾的逗号是 C++11 扩展">,
  InGroup<CXX11>;
def warn_cxx98_compat_enumerator_list_comma : Warning<
  "commas at the end of enumerator lists are incompatible with C++98"
  "\n" "警告：枚举列表末尾的逗号与 C++98 不兼容">,
  InGroup<CXX98CompatPedantic>, DefaultIgnore;
def err_enumerator_list_missing_comma : Error<
  "missing ',' between enumerators"
  "\n" "错误：枚举项之间缺少 ','">;
def err_enumerator_unnamed_no_def : Error<
  "unnamed enumeration must be a definition"
  "\n" "错误：未命名的枚举必须是定义">;
def ext_ms_c_enum_fixed_underlying_type : Extension<
  "enumeration types with a fixed underlying type are a Microsoft extension"
  "\n" "警告：具有固定底层类型的枚举类型是 Microsoft 扩展">,
  InGroup<MicrosoftFixedEnum>;
def ext_ms_c_empty_enum_type : Extension<
  "empty enumeration types are a Microsoft extension"
  "\n" "警告：空枚举类型是 Microsoft 扩展">,
  InGroup<MicrosoftEmptyEnum>;
def ext_c23_enum_fixed_underlying_type : Extension<
  "enumeration types with a fixed underlying type are a C23 extension"
  "\n" "警告：具有固定底层类型的枚举类型是 C23 扩展">,
  InGroup<C23>;
def warn_c17_compat_enum_fixed_underlying_type : Warning<
  "enumeration types with a fixed underlying type are incompatible with C standards before C23"
  "\n" "警告：具有固定底层类型的枚举类型与 C23 之前的 C 标准不兼容">,
  DefaultIgnore, InGroup<CPre23Compat>;
def ext_enum_base_in_type_specifier : ExtWarn<
  "non-defining declaration of enumeration with a fixed underlying type is "
  "only permitted as a standalone declaration"
  "%select{|; missing list of enumerators?}0"
  "\n" "警告：具有固定底层类型的枚举的非定义声明"
  "仅允许作为独立声明出现%select{|；缺少枚举项列表？}0">,
  InGroup<DiagGroup<"elaborated-enum-base">>, DefaultError;
def ext_elaborated_enum_class : ExtWarn<
  "reference to enumeration must use 'enum' not 'enum %select{struct|class}0'"
  "\n" "警告：对枚举的引用必须使用 'enum'，而不是 'enum %select{struct|class}0'">,
  InGroup<DiagGroup<"elaborated-enum-class">>, DefaultError;
def err_scoped_enum_missing_identifier : Error<
  "scoped enumeration requires a name"
  "\n" "错误：作用域枚举需要名称">;
def ext_scoped_enum : ExtWarn<
  "scoped enumerations are a C++11 extension"
  "\n" "警告：作用域枚举是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_scoped_enum : Warning<
  "scoped enumerations are incompatible with C++98"
  "\n" "警告：作用域枚举与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_anonymous_enum_bitfield : Error<
  "ISO C++ only allows ':' in member enumeration declaration to introduce "
  "a fixed underlying type, not an anonymous bit-field"
  "\n" "错误：ISO C++ 只允许在成员枚举声明中使用 ':' 来引入"
  "固定底层类型，而不允许匿名位域">;

def warn_cxx98_compat_alignof : Warning<
  "alignof expressions are incompatible with C++98"
  "\n" "警告：alignof 表达式与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def ext_alignof_expr : ExtWarn<
  "%0 applied to an expression is a GNU extension"
  "\n" "警告：%0 应用于表达式是 GNU 扩展">, InGroup<GNUAlignofExpression>;
def err_lambda_after_delete : Error<
  "'[]' after delete interpreted as 'delete[]'; add parentheses to treat this as a lambda-expression"
  "\n" "错误：delete 后的 '[]' 被解释为 'delete[]'；请添加括号将其视为 lambda 表达式">;

def warn_microsoft_dependent_exists : Warning<
  "dependent %select{__if_not_exists|__if_exists}0 declarations are ignored"
  "\n" "警告：依赖的%select{__if_not_exists|__if_exists}0声明被忽略">,
  InGroup<DiagGroup<"microsoft-exists">>;
def warn_microsoft_qualifiers_ignored : Warning<
  "qualifiers after comma in declarator list are ignored"
  "\n" "警告：声明符列表中逗号后的限定符被忽略">,
  InGroup<IgnoredAttributes>;

def err_duplicate_default_assoc : Error<
  "duplicate default generic association"
  "\n" "错误：重复的默认泛型关联">;
def note_previous_default_assoc : Note<
  "previous default generic association is here"
  "\n" "提示：先前的默认泛型关联在此">;
def ext_c2y_generic_with_type_arg : Extension<
  "passing a type argument as the first operand to '_Generic' is a C2y "
  "extension"
  "\n" "警告：将类型参数作为 '_Generic' 的第一个操作数传递是 C2y 扩展">,
  InGroup<C2y>;
def warn_c2y_compat_generic_with_type_arg : Warning<
  "passing a type argument as the first operand to '_Generic' is incompatible "
  "with C standards before C2y"
  "\n" "警告：将类型参数作为 '_Generic' 的第一个操作数传递与 C2y 之前的 C 标准不兼容">,
  InGroup<CPre2yCompat>, DefaultIgnore;

def ext_c99_feature : Extension<
  "'%0' is a C99 extension"
  "\n" "警告：'%0' 是 C99 扩展">, InGroup<C99>;
def ext_c11_feature : Extension<
  "'%0' is a C11 extension"
  "\n" "警告：'%0' 是 C11 扩展">, InGroup<C11>;
def ext_c2y_feature : Extension<
  "'%0' is a C2y extension"
  "\n" "警告：'%0' 是 C2y 扩展">, InGroup<C2y>;
def warn_c11_compat_keyword : Warning<
  "'%0' is incompatible with C standards before C11"
  "\n" "警告：'%0' 与 C11 之前的 C 标准不兼容">,
  InGroup<CPre11Compat>, DefaultIgnore;
def warn_c23_compat_keyword : Warning<
 "'%0' is incompatible with C standards before C23"
 "\n" "警告：'%0' 与 C23 之前的 C 标准不兼容">,
 InGroup<CPre23Compat>, DefaultIgnore;
def warn_c2y_compat_keyword : Warning<
  "'%0' is incompatible with C standards before C2y"
  "\n" "警告：'%0' 与 C2y 之前的 C 标准不兼容">,
  InGroup<CPre2yCompat>, DefaultIgnore;

def err_c11_noreturn_misplaced : Error<
  "'_Noreturn' keyword must precede function declarator"
  "\n" "错误：'_Noreturn' 关键字必须位于函数声明符之前">;

def ext_gnu_indirect_goto : Extension<
  "use of GNU indirect-goto extension"
  "\n" "警告：使用了 GNU 间接跳转（indirect-goto）扩展">, InGroup<GNULabelsAsValue>;
def ext_gnu_address_of_label : Extension<
  "use of GNU address-of-label extension"
  "\n" "警告：使用了 GNU 标签地址（address-of-label）扩展">, InGroup<GNULabelsAsValue>;
def err_stmtexpr_file_scope : Error<
  "statement expression not allowed at file scope"
  "\n" "错误：不允许在文件作用域使用语句表达式">;
def ext_gnu_statement_expr : Extension<
  "use of GNU statement expression extension"
  "\n" "警告：使用了 GNU 语句表达式扩展">, InGroup<GNUStatementExpression>;
def ext_gnu_statement_expr_macro : Extension<
  "use of GNU statement expression extension from macro expansion"
  "\n" "警告：在宏展开中使用了 GNU 语句表达式扩展">,
  InGroup<GNUStatementExpressionFromMacroExpansion>;
def ext_gnu_conditional_expr : Extension<
  "use of GNU ?: conditional expression extension, omitting middle operand"
  "\n" "警告：使用了 GNU ?: 条件表达式扩展，省略了中间操作数">, InGroup<GNUConditionalOmittedOperand>;
def ext_gnu_array_range : Extension<"use of GNU array range extension"
  "\n" "警告：使用了 GNU 数组范围扩展">,
  InGroup<GNUDesignator>;
def ext_gnu_missing_equal_designator : ExtWarn<
  "use of GNU 'missing =' extension in designator"
  "\n" "警告：在设计符中使用了 GNU '缺少 =' 扩展">,
  InGroup<GNUDesignator>;
def err_expected_equal_designator : Error<"expected '=' or another designator"
  "\n" "错误：应为 '=' 或其他设计符">;
def ext_gnu_old_style_field_designator : ExtWarn<
  "use of GNU old-style field designator extension"
  "\n" "警告：使用了 GNU 旧式字段设计符扩展">,
  InGroup<GNUDesignator>;
def ext_gnu_case_range : Extension<
  "case ranges are a GNU extension"
  "\n" "警告：case 范围是 GNU 扩展">, InGroup<GNUCaseRange>;
def warn_c23_compat_case_range : Warning<
  "case ranges are incompatible with C standards before C2y"
  "\n" "警告：case 范围与 C2y 之前的 C 标准不兼容">,
  DefaultIgnore, InGroup<CPre2yCompat>;
def ext_c2y_case_range : Extension<
  "case ranges are a C2y extension"
  "\n" "警告：case 范围是 C2y 扩展">, InGroup<C2y>;
def err_c2y_labeled_break_continue : Error<
  "named %select{'break'|'continue'}0 is only supported in C2y"
  "\n" "错误：命名%select{'break'|'continue'}0仅在 C2y 中受支持">;

// Generic errors.
def err_expected_expression : Error<"expected expression"
  "\n" "错误：应为表达式">;
def err_expected_type : Error<"expected a type"
  "\n" "错误：应为类型">;
def err_expected_external_declaration : Error<"expected external declaration"
  "\n" "错误：应为外部声明">;
def err_extraneous_closing_brace : Error<"extraneous closing brace ('}')"
  "\n" "错误：多余的右花括号 ('}')">;
def err_expected_semi_declaration : Error<
  "expected ';' at end of declaration"
  "\n" "错误：声明末尾应有 ';'">;
def err_expected_semi_decl_list : Error<
  "expected ';' at end of declaration list"
  "\n" "错误：声明列表末尾应有 ';'">;
def ext_expected_semi_decl_list : ExtWarn<
  "expected ';' at end of declaration list"
  "\n" "警告：声明列表末尾应有 ';'">;
def err_expected_member_name_or_semi : Error<
  "expected member name or ';' after declaration specifiers"
  "\n" "错误：声明说明符后应有成员名或 ';'">;
def err_function_declared_typedef : Error<
  "function definition declared 'typedef'"
  "\n" "错误：函数定义声明为 'typedef'">;
def err_at_defs_cxx : Error<"@defs is not supported in Objective-C++"
  "\n" "错误：Objective-C++ 中不支持 @defs">;
def err_at_in_class : Error<"unexpected '@' in member specification"
  "\n" "错误：成员声明中出现意外的 '@'">;
def err_unexpected_semi : Error<"unexpected ';' before %0"
  "\n" "错误：%0 之前出现意外的 ';'">;
def err_postfix_after_unary_requires_parens : Error<
  "expression cannot be followed by a postfix %0 operator; add parentheses"
  "\n" "错误：表达式后面不能跟后缀 %0 运算符；请添加括号">;
def err_unparenthesized_non_primary_expr_in_requires_clause : Error<
  "parentheses are required around this expression in a requires clause"
  "\n" "错误：在 requires 子句中此表达式需要用括号括起来">;
def note_unparenthesized_non_primary_expr_in_requires_clause : Note<
  "parentheses are required around this expression in a requires clause"
  "\n" "提示：在 requires 子句中此表达式需要用括号括起来">;

def err_expected_fn_body : Error<
  "expected function body after function declarator"
  "\n" "错误：函数声明符之后应有函数体">;
def warn_attribute_on_function_definition : Warning<
  "GCC does not allow %0 attribute in this position on a function definition"
  "\n" "警告：GCC 不允许在函数定义的此位置使用 %0 特性">,
  InGroup<GccCompat>;
def warn_gcc_attribute_location : Warning<
  "GCC does not allow an attribute in this position on a function declaration"
  "\n" "警告：GCC 不允许在函数声明的此位置使用特性">,
  InGroup<GccCompat>;
def warn_gcc_variable_decl_in_for_loop : Warning<
  "GCC does not allow variable declarations in for loop initializers before "
  "C99"
  "\n" "警告：GCC 不允许在 C99 之前在 for 循环初始化器中声明变量">,
  InGroup<GccCompat>;
def warn_attribute_no_decl : Warning<
  "attribute %0 ignored, because it is not attached to a declaration"
  "\n" "警告：特性 %0 被忽略，因为它没有附加到声明上">,
  InGroup<IgnoredAttributes>;
def err_ms_attributes_not_enabled : Error<
  "'__declspec' attributes are not enabled; use '-fdeclspec' or "
  "'-fms-extensions' to enable support for __declspec attributes"
  "\n" "错误：'__declspec' 特性未启用；请使用 '-fdeclspec' 或 "
  "'-fms-extensions' 启用对 __declspec 特性的支持">;
def err_expected_method_body : Error<"expected method body"
  "\n" "错误：应有方法体">;
def err_declspec_after_virtspec : Error<
  "'%0' qualifier may not appear after the virtual specifier '%1'"
  "\n" "错误：'%0' 限定符不能出现在虚说明符 '%1' 之后">;
def err_invalid_token_after_toplevel_declarator : Error<
  "expected ';' after top level declarator"
  "\n" "错误：顶层声明符之后应有 ';'">;
def err_invalid_token_after_declarator_suggest_equal : Error<
  "invalid %0 at end of declaration; did you mean '='?"
  "\n" "错误：声明末尾的 %0 无效；您是指 '=' 吗？">;
def err_expected_statement : Error<"expected statement"
  "\n" "错误：应为语句">;
def err_expected_lparen_after : Error<"expected '(' after '%0'"
  "\n" "错误：'%0' 之后应有 '('">;
def err_expected_rparen_after : Error<"expected ')' after '%0'"
  "\n" "错误：'%0' 之后应有 ')'">;
def err_expected_punc : Error<"expected ')' or ',' after '%0'"
  "\n" "错误：'%0' 之后应有 ')' 或 ','">;
def err_expected_less_after : Error<"expected '<' after '%0'"
  "\n" "错误：'%0' 之后应有 '<'">;
def err_expected_lbrace_in_compound_literal : Error<
  "expected '{' in compound literal"
  "\n" "错误：复合字面量中应有 '{'">;
def err_expected_while : Error<"expected 'while' in do/while loop"
  "\n" "错误：do/while 循环中应有 'while'">;

def err_expected_semi_after_stmt : Error<"expected ';' after %0 statement"
  "\n" "错误：%0 语句之后应有 ';'">;
def err_expected_semi_after_expr : Error<"expected ';' after expression"
  "\n" "错误：表达式之后应有 ';'">;
def warn_attr_in_secondary_block : ExtWarn<
  "ISO C does not allow an attribute list to appear here"
  "\n" "警告：ISO C 不允许特性列表出现在此处">,
  InGroup<DiagGroup<"c-attribute-extension">>;
def err_extraneous_token_before_semi : Error<"extraneous '%0' before ';'"
  "\n" "错误：';' 之前有多余的 '%0'">;

def err_expected_semi_after_method_proto : Error<
  "expected ';' after method prototype"
  "\n" "错误：方法原型之后应有 ';'">;
def err_expected_semi_after_namespace_name : Error<
  "expected ';' after namespace name"
  "\n" "错误：命名空间名之后应有 ';'">;
def err_unexpected_namespace_attributes_alias : Error<
  "attributes cannot be specified on namespace alias"
  "\n" "错误：不能在命名空间别名上指定特性">;
def err_unexpected_qualified_namespace_alias : Error<
  "namespace alias must be a single identifier"
  "\n" "错误：命名空间别名必须是单个标识符">;
def err_unexpected_nested_namespace_attribute : Error<
  "attributes cannot be specified on a nested namespace definition"
  "\n" "错误：不能在嵌套命名空间定义上指定特性">;
def err_inline_namespace_alias : Error<"namespace alias cannot be inline"
  "\n" "错误：命名空间别名不能是内联的">;
def err_namespace_nonnamespace_scope : Error<
  "namespaces can only be defined in global or namespace scope"
  "\n" "错误：命名空间只能在全局作用域或命名空间作用域中定义">;
def ext_nested_namespace_definition : ExtWarn<
  "nested namespace definition is a C++17 extension; "
  "define each namespace separately"
  "\n" "警告：嵌套命名空间定义是 C++17 扩展；请分别定义每个命名空间">,
  InGroup<CXX17>;
def warn_cxx14_compat_nested_namespace_definition : Warning<
  "nested namespace definition is incompatible with C++ standards before C++17"
  "\n" "警告：嵌套命名空间定义与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17Compat>, DefaultIgnore;
def ext_inline_nested_namespace_definition : ExtWarn<
  "inline nested namespace definition is a C++20 extension"
  "\n" "警告：内联嵌套命名空间定义是 C++20 扩展">, InGroup<CXX20>;
def warn_cxx17_compat_inline_nested_namespace_definition : Warning<
  "inline nested namespace definition is incompatible with C++ standards before"
  " C++20"
  "\n" "警告：内联嵌套命名空间定义与 C++20 之前的 C++ 标准不兼容">,
  InGroup<CXXPre20Compat>, DefaultIgnore;
def err_inline_nested_namespace_definition : Error<
  "nested namespace definition cannot be 'inline'"
  "\n" "错误：嵌套命名空间定义不能是 'inline'">;
def err_expected_semi_after_attribute_list : Error<
  "expected ';' after attribute list"
  "\n" "错误：特性列表之后应有 ';'">;
def err_expected_semi_after_static_assert : Error<
  "expected ';' after '%0'"
  "\n" "错误：'%0' 之后应有 ';'">;
def err_expected_semi_for : Error<"expected ';' in 'for' statement specifier"
  "\n" "错误：'for' 语句说明符中应有 ';'">;
def err_single_decl_assign_in_for_range : Error<
  "range-based 'for' statement uses ':', not '='"
  "\n" "错误：基于范围的 'for' 语句使用 ':'，而不是 '='">;
def warn_missing_selector_name : Warning<
  "%0 used as the name of the previous parameter rather than as part "
  "of the selector"
  "\n" "警告：%0 被用作前一个参数的名称，而不是作为选择器的一部分">,
  InGroup<DiagGroup<"missing-selector-name">>;
def note_missing_selector_name : Note<
  "introduce a parameter name to make %0 part of the selector"
  "\n" "提示：引入参数名以将 %0 作为选择器的一部分">;
def note_force_empty_selector_name : Note<
  "or insert whitespace before ':' to use %0 as parameter name "
  "and have an empty entry in the selector"
  "\n" "提示：或者在 ':' 前插入空格以将 %0 用作参数名，并在选择器中留一个空条目">;
def ext_c_label_followed_by_declaration : ExtWarn<
  "label followed by a declaration is a C23 extension"
  "\n" "警告：标签后跟声明是 C23 扩展">,
  InGroup<C23>;
def warn_c23_compat_label_followed_by_declaration : Warning<
  "label followed by a declaration is incompatible with C standards before "
  "C23"
  "\n" "警告：标签后跟声明与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def ext_c_label_end_of_compound_statement : ExtWarn<
  "label at end of compound statement is a C23 extension"
  "\n" "警告：复合语句末尾的标签是 C23 扩展">,
   InGroup<C23>;
def ext_cxx_label_end_of_compound_statement : ExtWarn<
  "label at end of compound statement is a C++23 extension"
  "\n" "警告：复合语句末尾的标签是 C++23 扩展">,
   InGroup<CXX23>;
def warn_c23_compat_label_end_of_compound_statement : Warning<
  "label at end of compound statement is incompatible with C standards before C23"
  "\n" "警告：复合语句末尾的标签与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def warn_cxx20_compat_label_end_of_compound_statement : Warning<
  "label at end of compound statement is incompatible with C++ standards before C++23"
  "\n" "警告：复合语句末尾的标签与 C++23 之前的 C++ 标准不兼容">,
  InGroup<CXXPre23Compat>, DefaultIgnore;
def err_address_of_label_outside_fn : Error<
  "use of address-of-label extension outside of a function body"
  "\n" "错误：在函数体外使用了地址标签扩展">;
def err_asm_operand_wide_string_literal : Error<
  "cannot use %select{unicode|wide}0 string literal in 'asm'"
  "\n" "错误：不能在 'asm' 中使用%select{unicode|宽}0字符串字面量">;
def err_defer_ts_labeled_stmt : Error<
  "substatement of defer must not be a label"
  "\n" "错误：defer 的子语句不能是标签">;

def err_asm_expected_string : Error<
  "expected string literal %select{or parenthesized constant expression |}0in 'asm'"
  "\n" "错误：'asm' 中应有字符串字面量%select{或带括号的常量表达式 |}0">;
def err_expected_selector_for_method : Error<
  "expected selector for Objective-C method"
  "\n" "错误：应为 Objective-C 方法的选择器">;
def err_expected_property_name : Error<"expected property name"
  "\n" "错误：应为属性名">;

def err_unexpected_at : Error<"unexpected '@' in program"
  "\n" "错误：程序中出现意外的 '@'">;
def err_atimport : Error<
"use of '@import' when modules are disabled"
"\n" "错误：在模块被禁用时使用了 '@import'">;

def warn_atimport_in_framework_header : Warning<
  "use of '@import' in framework header is discouraged, "
  "including this header requires -fmodules"
  "\n" "警告：不鼓励在框架头文件中使用 '@import'，包含此头文件需要 -fmodules">,
  InGroup<FrameworkHdrAtImport>;

def err_invalid_reference_qualifier_application : Error<
  "'%0' qualifier may not be applied to a reference"
  "\n" "错误：'%0' 限定符不能应用于引用">;
def err_illegal_decl_reference_to_reference : Error<
  "%0 declared as a reference to a reference"
  "\n" "错误：%0 被声明为引用的引用">;
def ext_rvalue_reference : ExtWarn<
  "rvalue references are a C++11 extension"
  "\n" "警告：右值引用是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_rvalue_reference : Warning<
  "rvalue references are incompatible with C++98"
  "\n" "警告：右值引用与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def ext_ref_qualifier : ExtWarn<
  "reference qualifiers on functions are a C++11 extension"
  "\n" "警告：函数上的引用限定符是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_ref_qualifier : Warning<
  "reference qualifiers on functions are incompatible with C++98"
  "\n" "警告：函数上的引用限定符与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def ext_inline_namespace : ExtWarn<
  "inline namespaces are a C++11 feature"
  "\n" "警告：内联命名空间是 C++11 特性">, InGroup<CXX11InlineNamespace>;
def warn_cxx98_compat_inline_namespace : Warning<
  "inline namespaces are incompatible with C++98"
  "\n" "警告：内联命名空间与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def ext_generalized_initializer_lists : ExtWarn<
  "generalized initializer lists are a C++11 extension"
  "\n" "警告：广义初始化器列表是 C++11 扩展">,
  InGroup<CXX11>;
def warn_cxx98_compat_generalized_initializer_lists : Warning<
  "generalized initializer lists are incompatible with C++98"
  "\n" "警告：广义初始化器列表与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_init_list_bin_op : Error<"initializer list cannot be used on the "
  "%select{left|right}0 hand side of operator '%1'"
  "\n" "错误：初始化器列表不能用于运算符 '%1' 的%select{左侧|右侧}0">;
def warn_cxx98_compat_trailing_return_type : Warning<
  "trailing return types are incompatible with C++98"
  "\n" "警告：尾随返回类型与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_requires_clause_must_appear_after_trailing_return : Error<
  "trailing return type must appear before trailing requires clause"
  "\n" "错误：尾随返回类型必须出现在尾随 requires 子句之前">;
def err_requires_clause_on_declarator_not_declaring_a_function : Error<
  "trailing requires clause can only be used when declaring a function"
  "\n" "错误：尾随 requires 子句只能在声明函数时使用">;
def err_requires_clause_inside_parens : Error<
  "trailing requires clause should be placed outside parentheses"
  "\n" "错误：尾随 requires 子句应放在括号外">;
def ext_auto_storage_class : ExtWarn<
  "'auto' storage class specifier is not permitted in C++11, and will not "
  "be supported in future releases"
  "\n" "警告：C++11 中不允许 'auto' 存储类说明符，将来的版本也将不再支持">,
  InGroup<DiagGroup<"auto-storage-class">>;
def ext_decltype_auto_type_specifier : ExtWarn<
  "'decltype(auto)' type specifier is a C++14 extension"
  "\n" "警告：'decltype(auto)' 类型说明符是 C++14 扩展">, InGroup<CXX14>;
def warn_cxx11_compat_decltype_auto_type_specifier : Warning<
  "'decltype(auto)' type specifier is incompatible with C++ standards before "
  "C++14"
  "\n" "警告：'decltype(auto)' 类型说明符与 C++14 之前的 C++ 标准不兼容">,
  InGroup<CXXPre14Compat>, DefaultIgnore;
def ext_auto_type : Extension<
  "'__auto_type' is a GNU extension"
  "\n" "警告：'__auto_type' 是 GNU 扩展">,
  InGroup<GNUAutoType>;
def ext_for_range : ExtWarn<
  "range-based for loop is a C++11 extension"
  "\n" "警告：基于范围的 for 循环是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_for_range : Warning<
  "range-based for loop is incompatible with C++98"
  "\n" "警告：基于范围的 for 循环与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_for_range_identifier : Error<
  "%select{range-based for loop|expansion statement}0 requires "
  "type for %select{loop|expansion}0 variable"
  "\n" "错误：%select{基于范围的 for 循环|展开语句}0需要"
  "%select{循环|展开}0变量的类型">;
def err_for_range_expected_decl : Error<
  "%select{for range|expansion statement}0 declaration must declare a variable"
  "\n" "错误：%select{for 范围|展开语句}0声明必须声明一个变量">;
def err_argument_required_after_attribute : Error<
  "argument required after attribute"
  "\n" "错误：特性之后需要参数">;
def err_missing_param : Error<"expected parameter declarator"
  "\n" "错误：应为参数声明符">;
def err_function_scope_depth_exceeded : Error<
  "function scope depth exceeded maximum of %0"
  "\n" "错误：函数作用域深度超过最大 %0">, DefaultFatal;
def err_missing_comma_before_ellipsis : Error<
  "C requires a comma prior to the ellipsis in a variadic function type"
  "\n" "错误：C 要求在可变参数函数类型中省略号之前有逗号">;
def warn_deprecated_missing_comma_before_ellipsis : Warning<
  "declaration of a variadic function without a comma before '...' is deprecated"
  "\n" "警告：没有在 '...' 之前放逗号的可变参数函数声明已弃用">,
  InGroup<DeprecatedMissingCommaVariadicParam>;
def err_unexpected_typedef_ident : Error<
  "unexpected type name %0: expected identifier"
  "\n" "错误：意外的类型名 %0：应为标识符">;
def warn_cxx98_compat_decltype : Warning<
  "'decltype' type specifier is incompatible with C++98"
  "\n" "警告：'decltype' 类型说明符与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_unexpected_scope_on_base_decltype : Error<
  "unexpected namespace scope prior to decltype"
  "\n" "错误：decltype 之前出现意外的命名空间作用域">;
def err_expected_class_name : Error<"expected class name"
  "\n" "错误：应为类名">;
def err_expected_class_name_not_template :
  Error<"'typename' is redundant; base classes are implicitly types"
  "\n" "错误：'typename' 是多余的；基类隐式地是类型">;
def err_unspecified_vla_size_with_static : Error<
  "'static' may not be used with an unspecified variable length array size"
  "\n" "错误：'static' 不能与未指定的变长数组大小一起使用">;
def err_unspecified_size_with_static : Error<
  "'static' may not be used without an array size"
  "\n" "错误：'static' 不能在没有数组大小的情况下使用">;
def err_expected_parentheses_around_typename : Error<
  "expected parentheses around type name in %0 expression"
  "\n" "错误：%0 表达式中类型名周围应有括号">;
def err_expansion_stmt_requires_range : Error<
  "expansion statement must use the syntax of a range-based for loop"
  "\n" "错误：展开语句必须使用基于范围的 for 循环的语法">;
def err_expansion_stmt_requires_cxx2c : Error<
  "expansion statements are only supported in C++2c"
  "\n" "错误：展开语句仅在 C++2c 中受支持">;
def err_for_template : Error<
  "'for template' is invalid; use 'template for' instead"
  "\n" "错误：'for template' 无效；请改用 'template for'">;
def ext_expansion_stmt_body_not_compound_stmt : Extension<
  "ISO C++ requires the body of an expansion statement to be a compound statement"
  "\n" "警告：ISO C++ 要求展开语句的主体是复合语句">,
  InGroup<ExpansionStmtBody>;
def ext_expansion_stmt_body_attr : Extension<
  "ISO C++ forbids attributes before the compound statement of an expansion statement"
  "\n" "警告：ISO C++ 禁止在展开语句的复合语句之前使用特性">,
  InGroup<ExpansionStmtBody>;

def err_expected_case_before_expression: Error<
  "expected 'case' keyword before expression"
  "\n" "错误：表达式之前应有 'case' 关键字">;

def ext_warn_gnu_final : ExtWarn<
  "__final is a GNU extension, consider using C++11 final"
  "\n" "警告：__final 是 GNU 扩展，请考虑使用 C++11 的 final">,
  InGroup<GccCompat>;

// Declarations.
def err_typename_requires_specqual : Error<
  "type name requires a specifier or qualifier"
  "\n" "错误：类型名需要说明符或限定符">;
def err_typename_invalid_storageclass : Error<
  "type name does not allow storage class to be specified"
  "\n" "错误：类型名不允许指定存储类">;
def err_typename_invalid_functionspec : Error<
  "type name does not allow function specifier to be specified"
  "\n" "错误：类型名不允许指定函数说明符">;
def err_typename_invalid_constexpr : Error<
  "type name does not allow %sub{select_constexpr_spec_kind}0 specifier "
  "to be specified"
  "\n" "错误：类型名不允许指定 %sub{select_constexpr_spec_kind}0 说明符">;
def err_typename_identifiers_only : Error<
  "typename is allowed for identifiers only"
  "\n" "错误：typename 只允许用于标识符">;

def err_friend_invalid_in_context : Error<
  "'friend' used outside of class"
  "\n" "错误：在类外使用了 'friend'">;
def err_templated_using_directive_declaration : Error<
  "cannot template a using %select{directive|declaration}0"
  "\n" "错误：不能对 using%select{指令|声明}0使用模板">;
def err_unexpected_colon_in_nested_name_spec : Error<
  "unexpected ':' in nested name specifier; did you mean '::'?"
  "\n" "错误：嵌套名称说明符中出现意外的 ':'；您是指 '::' 吗？">;
def err_unexpected_token_in_nested_name_spec : Error<
  "'%0' cannot be a part of nested name specifier; did you mean ':'?"
  "\n" "错误：'%0' 不能是嵌套名称说明符的一部分；您是指 ':' 吗？">;
def err_bool_redeclaration : Error<
  "redeclaration of C++ built-in type 'bool'"
  "\n" "错误：C++ 内建类型 'bool' 的重新声明">;
def warn_cxx98_compat_static_assert : Warning<
  "'static_assert' declarations are incompatible with C++98"
  "\n" "警告：'static_assert' 声明与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def ext_cxx_static_assert_no_message : ExtWarn<
  "'static_assert' with no message is a C++17 extension"
  "\n" "警告：不带消息的 'static_assert' 是 C++17 扩展">, InGroup<CXX17>;
def ext_c_static_assert_no_message : ExtWarn<
  "'_Static_assert' with no message is a C23 extension"
  "\n" "警告：不带消息的 '_Static_assert' 是 C23 扩展">, InGroup<C23>;
def warn_cxx14_compat_static_assert_no_message : Warning<
  "'static_assert' with no message is incompatible with C++ standards before "
  "C++17"
  "\n" "警告：不带消息的 'static_assert' 与 C++17 之前的 C++ 标准不兼容">,
  DefaultIgnore, InGroup<CXXPre17Compat>;
def warn_c17_compat_static_assert_no_message : Warning<
  "'_Static_assert' with no message is incompatible with C standards before "
  "C23"
  "\n" "警告：不带消息的 '_Static_assert' 与 C23 之前的 C 标准不兼容">,
  DefaultIgnore, InGroup<CPre23Compat>;
def ext_cxx_static_assert_user_generated_message : ExtWarn<
  "'static_assert' with a user-generated message is a C++26 extension"
  "\n" "警告：带用户生成消息的 'static_assert' 是 C++26 扩展">,
  InGroup<CXX26>;
def warn_cxx20_compat_static_assert_user_generated_message : Warning<
  "'static_assert' with a user-generated message is incompatible with "
  "C++ standards before C++26"
  "\n" "警告：带用户生成消息的 'static_assert' 与 C++26 之前的 C++ 标准不兼容">,
  DefaultIgnore, InGroup<CXXPre26Compat>;
def err_function_definition_not_allowed : Error<
  "function definition is not allowed here"
  "\n" "错误：此处不允许函数定义">;
def err_expected_end_of_enumerator : Error<
  "expected '= constant-expression' or end of enumerator definition"
  "\n" "错误：应为 '= 常量表达式' 或枚举定义结尾">;
def err_expected_coloncolon_after_super : Error<
  "expected '::' after '__super'"
  "\n" "错误：'__super' 之后应有 '::'">;

def ext_decomp_decl_empty : ExtWarn<
  "ISO C++17 does not allow a structured binding group to be empty"
  "\n" "警告：ISO C++17 不允许结构化绑定组为空">,
  InGroup<DiagGroup<"empty-decomposition">>;

def err_function_parameter_limit_exceeded : Error<
  "too many function parameters; subsequent parameters will be ignored"
  "\n" "错误：函数参数过多；后续参数将被忽略">;

// C++26 structured bindings
def ext_decl_attrs_on_binding : ExtWarn<
  "an attribute specifier sequence attached to a structured binding declaration "
  "is a C++2c extension"
  "\n" "警告：附加到结构化绑定声明上的特性说明符序列是 C++2c 扩展">,
  InGroup<CXX26>;
def warn_cxx23_compat_decl_attrs_on_binding : Warning<
  "an attribute specifier sequence attached to a structured binding declaration "
  "is incompatible with C++ standards before C++2c"
  "\n" "警告：附加到结构化绑定声明上的特性说明符序列与 C++2c 之前的 C++ 标准不兼容">,
  InGroup<CXXPre26Compat>, DefaultIgnore;

/// Objective-C parser diagnostics
def err_expected_minus_or_plus : Error<
  "method type specifier must start with '-' or '+'"
  "\n" "错误：方法类型说明符必须以 '-' 或 '+' 开头">;
def err_objc_missing_end : Error<"missing '@end'"
  "\n" "错误：缺少 '@end'">;
def note_objc_container_start : Note<
  "%select{class|protocol|category|class extension|implementation"
  "|category implementation}0 started here"
  "\n" "提示：%select{类|协议|类别|类扩展|实现|类别实现}0在此开始">;
def warn_objc_protocol_qualifier_missing_id : Warning<
  "protocol has no object type specified; defaults to qualified 'id'"
  "\n" "警告：协议没有指定对象类型；默认为受限的 'id'">;
def err_objc_unknown_at : Error<"expected an Objective-C directive after '@'"
  "\n" "错误：'@' 之后应有 Objective-C 指令">;
def err_illegal_super_cast : Error<
  "cannot cast 'super' (it isn't an expression)"
  "\n" "错误：无法转换 'super'（它不是表达式）">;
def err_nsnumber_nonliteral_unary : Error<
  "@%0 must be followed by a number to form an NSNumber object"
  "\n" "错误：@%0 后必须跟一个数字以形成 NSNumber 对象">;
def warn_cstyle_param : Warning<
  "use of C-style parameters in Objective-C method declarations"
  " is deprecated"
  "\n" "警告：在 Objective-C 方法声明中使用 C 风格参数已弃用">,
  InGroup<DeprecatedDeclarations>;

let CategoryName = "ARC Parse Issue" in {
def err_arc_bridge_retain : Error<
  "unknown cast annotation __bridge_retain; did you mean __bridge_retained?"
  "\n" "错误：未知的转换注释 __bridge_retain；您是指 __bridge_retained 吗？">;
// To be default mapped to an error later.
def warn_arc_bridge_cast_nonarc : Warning<
  "'%0' casts have no effect when not using ARC"
  "\n" "警告：不使用 ARC 时，'%0' 转换无效">,
  InGroup<DiagGroup<"arc-bridge-casts-disallowed-in-nonarc">>;
}

def err_objc_illegal_visibility_spec : Error<
  "illegal visibility specification"
  "\n" "错误：非法的可见性声明">;
def err_objc_illegal_interface_qual : Error<"illegal interface qualifier"
  "\n" "错误：非法的接口限定符">;
def err_objc_expected_equal_for_getter : Error<
  "expected '=' for Objective-C getter"
  "\n" "错误：Objective-C getter 应有 '='">;
def err_objc_expected_equal_for_setter : Error<
  "expected '=' for Objective-C setter"
  "\n" "错误：Objective-C setter 应有 '='">;
def err_objc_expected_selector_for_getter_setter : Error<
  "expected selector for Objective-C %select{setter|getter}0"
  "\n" "错误：应为 Objective-C %select{setter|getter}0的选择器">;
def err_objc_property_requires_field_name : Error<
  "property requires fields to be named"
  "\n" "错误：属性要求字段被命名">;
def err_objc_property_bitfield : Error<"property name cannot be a bit-field"
  "\n" "错误：属性名不能是位域">;
def err_objc_expected_property_attr : Error<"unknown property attribute %0"
  "\n" "错误：未知的属性特性 %0">;
def err_objc_unexpected_attr : Error<
  "prefix attribute must be followed by an interface, protocol, or implementation"
  "\n" "错误：前缀特性后必须跟接口、协议或实现">;
def err_objc_postfix_attribute : Error <
  "postfix attributes are not allowed on Objective-C directives"
  "\n" "错误：不允许在 Objective-C 指令上使用后缀特性">;
def err_objc_postfix_attribute_hint : Error <
  "postfix attributes are not allowed on Objective-C directives, place"
  " them in front of '%select{@interface|@protocol}0'"
  "\n" "错误：不允许在 Objective-C 指令上使用后缀特性，请将它们放在"
  "'%select{@interface|@protocol}0' 之前">;
def err_objc_directive_only_in_protocol : Error<
  "directive may only be specified in protocols only"
  "\n" "错误：指令只能在协议中指定">;
def err_missing_catch_finally : Error<
  "@try statement without a @catch and @finally clause"
  "\n" "错误：@try 语句没有 @catch 和 @finally 子句">;
def err_objc_concat_string : Error<"unexpected token after Objective-C string"
  "\n" "错误：Objective-C 字符串之后出现意外的标记">;
def err_expected_objc_container : Error<
  "'@end' must appear in an Objective-C context"
  "\n" "错误：'@end' 必须出现在 Objective-C 上下文中">;
def err_unexpected_protocol_qualifier : Error<
  "@implementation declaration cannot be protocol qualified"
  "\n" "错误：@implementation 声明不能被协议限定">;
def err_objc_unexpected_atend : Error<
  "'@end' appears where closing brace '}' is expected"
  "\n" "错误：'@end' 出现在期望右花括号 '}' 的位置">;
def err_synthesized_property_name : Error<
  "expected a property name in @synthesize"
  "\n" "错误：@synthesize 中应有属性名">;
def warn_semicolon_before_method_body : Warning<
  "semicolon before method body is ignored"
  "\n" "警告：方法体之前的分号被忽略">,
  InGroup<SemiBeforeMethodBody>, DefaultIgnore;
def note_extra_comma_message_arg : Note<
  "comma separating Objective-C messaging arguments"
  "\n" "提示：用于分隔 Objective-C 消息传递参数的逗号">;

def err_expected_field_designator : Error<
  "expected a field designator, such as '.field = 4'"
  "\n" "错误：应为字段设计符，例如 '.field = 4'">;

def err_declaration_does_not_declare_param : Error<
  "declaration does not declare a parameter"
  "\n" "错误：声明没有声明参数">;
def err_no_matching_param : Error<"parameter named %0 is missing"
  "\n" "错误：名为 %0 的参数缺失">;

/// Objective-C++ parser diagnostics
def err_expected_token_instead_of_objcxx_keyword : Error<
  "expected %0; %1 is a keyword in Objective-C++"
  "\n" "错误：应为 %0；%1 在 Objective-C++ 中是关键字">;
def err_expected_member_name_or_semi_objcxx_keyword : Error<
  "expected member name or ';' after declaration specifiers; "
  "%0 is a keyword in Objective-C++"
  "\n" "错误：声明说明符后应有成员名或 ';'；"
  "%0 在 Objective-C++ 中是关键字">;

/// C++ parser diagnostics
def err_invalid_operator_on_type : Error<
  "cannot use %select{dot|arrow}0 operator on a type"
  "\n" "错误：不能对类型使用%select{点|箭头}0运算符">;
def err_expected_unqualified_id : Error<
  "expected %select{identifier|unqualified-id}0"
  "\n" "错误：应为 %select{标识符|非限定标识符}0">;
def err_while_loop_outside_of_a_function : Error<
  "while loop outside of a function"
  "\n" "错误：函数外的 while 循环">;
def err_brackets_go_after_unqualified_id : Error<
  "brackets are not allowed here; to declare an array, "
  "place the brackets after the %select{identifier|name}0"
  "\n" "错误：此处不允许使用方括号；要声明数组，"
  "请将方括号放在 %select{标识符|名称}0 之后">;
def err_unexpected_unqualified_id : Error<"type-id cannot have a name"
  "\n" "错误：type-id 不能有名称">;
def err_func_def_no_params : Error<
  "function definition does not declare parameters"
  "\n" "错误：函数定义没有声明参数">;
def err_expected_lparen_after_type : Error<
  "expected '(' for function-style cast or type construction"
  "\n" "错误：函数式转换或类型构造应有 '('">;
def err_expected_init_in_condition : Error<
  "variable declaration in condition must have an initializer"
  "\n" "错误：条件中的变量声明必须有初始化器">;
def err_expected_init_in_condition_lparen : Error<
  "variable declaration in condition cannot have a parenthesized initializer"
  "\n" "错误：条件中的变量声明不能有带括号的初始化器">;
def err_extraneous_rparen_in_condition : Error<
  "extraneous ')' after condition, expected a statement"
  "\n" "错误：条件之后有多余的 ')'，应为语句">;
def ext_alias_in_init_statement : ExtWarn<
  "alias declaration in this context is a C++23 extension"
  "\n" "警告：此上下文中的别名声明是 C++23 扩展">,
  InGroup<CXX23>;
def warn_cxx20_alias_in_init_statement  : Warning<
  "alias declaration in this context is incompatible with C++ standards before C++23"
  "\n" "警告：此上下文中的别名声明与 C++23 之前的 C++ 标准不兼容">,
  DefaultIgnore, InGroup<CXXPre23Compat>;
def warn_dangling_else : Warning<
  "add explicit braces to avoid dangling else"
  "\n" "警告：添加显式花括号以避免悬空 else">,
  InGroup<DanglingElse>;
def err_expected_member_or_base_name : Error<
  "expected class member or base class name"
  "\n" "错误：应为类成员或基类名">;
def err_expected_lbrace_after_base_specifiers : Error<
  "expected '{' after base class list"
  "\n" "错误：基类列表之后应有 '{'">;
def err_missing_end_of_definition : Error<
  "missing '}' at end of definition of %q0"
  "\n" "错误：%q0 的定义末尾缺少 '}'">;
def note_missing_end_of_definition_before : Note<
  "still within definition of %q0 here"
  "\n" "提示：此处仍在 %q0 的定义中">;
def ext_ellipsis_exception_spec : Extension<
  "exception specification of '...' is a Microsoft extension"
  "\n" "警告：'...' 的异常规范是 Microsoft 扩展">,
  InGroup<MicrosoftExceptionSpec>;
def err_dynamic_and_noexcept_specification : Error<
  "cannot have both throw() and noexcept() clause on the same function"
  "\n" "错误：同一函数上不能同时有 throw() 和 noexcept() 子句">;
def err_except_spec_unparsed : Error<
  "unexpected end of exception specification"
  "\n" "错误：异常规范的意外结尾">;
def ext_dynamic_exception_spec : ExtWarn<
  "ISO C++17 does not allow dynamic exception specifications"
  "\n" "警告：ISO C++17 不允许动态异常规范">,
  InGroup<DynamicExceptionSpec>, DefaultError;
def warn_exception_spec_deprecated : Warning<
  "dynamic exception specifications are deprecated"
  "\n" "警告：动态异常规范已弃用">,
  InGroup<DeprecatedDynamicExceptionSpec>, DefaultIgnore;
def note_exception_spec_deprecated : Note<"use '%0' instead"
  "\n" "提示：请改用 '%0'">;
def warn_cxx98_compat_noexcept_decl : Warning<
  "noexcept specifications are incompatible with C++98"
  "\n" "警告：noexcept 规范与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_expected_catch : Error<"expected catch"
  "\n" "错误：应为 catch">;
def err_using_namespace_in_class : Error<
  "'using namespace' is not allowed in classes"
  "\n" "错误：类中不允许使用 'using namespace'">;
def warn_cxx17_compat_using_enum_declaration : Warning<
  "using enum declaration is incompatible with C++ standards before C++20"
  "\n" "警告：using enum 声明与 C++20 之前的 C++ 标准不兼容">,
  InGroup<CXXPre20Compat>, DefaultIgnore;
def ext_using_enum_declaration : ExtWarn<
  "using enum declaration is a C++20 extension"
  "\n" "警告：using enum 声明是 C++20 扩展">,
  InGroup<CXX20>;
def err_using_enum_expect_identifier : Error<
  "using enum %select{requires an enum or typedef name|"
  "does not permit an elaborated enum specifier}0"
  "\n" "错误：using enum%select{需要枚举或 typedef 名称|"
  "不允许使用详细枚举说明符}0">;
def err_constructor_bad_name : Error<
  "missing return type for function %0; did you mean the constructor name %1?"
  "\n" "错误：函数 %0 缺少返回类型；您是指构造函数名 %1 吗？">;
def err_destructor_tilde_identifier : Error<
  "expected a class name after '~' to name a destructor"
  "\n" "错误：'~' 之后应有类名来命名析构函数">;
def err_destructor_tilde_scope : Error<
  "'~' in destructor name should be after nested name specifier"
  "\n" "错误：析构函数名中的 '~' 应位于嵌套名称说明符之后">;
def err_destructor_template_id : Error<
  "destructor name %0 does not refer to a template"
  "\n" "错误：析构函数名 %0 不引用模板">;
def err_default_arg_unparsed : Error<
  "unexpected end of default argument expression"
  "\n" "错误：默认实参表达式的意外结尾">;
def err_bracket_depth_exceeded : Error<
  "bracket nesting level exceeded maximum of %0"
  "\n" "错误：括号嵌套级别超过最大 %0">, DefaultFatal;
def note_bracket_depth : Note<
  "use -fbracket-depth=N to increase maximum nesting level"
  "\n" "提示：使用 -fbracket-depth=N 提高最大嵌套级别">;
def err_misplaced_ellipsis_in_declaration : Error<
  "'...' must %select{immediately precede declared identifier|"
  "be innermost component of anonymous pack declaration}0"
  "\n" "错误：'...' 必须%select{紧跟在被声明的标识符之前|"
  "是匿名包声明的最内层组成部分}0">;
def warn_misplaced_ellipsis_vararg : Warning<
  "'...' in this location creates a C-style varargs function"
  "%select{, not a function parameter pack|}0"
  "\n" "警告：此处的 '...' 创建了一个 C 风格可变参数函数"
  "%select{，而不是函数形参包|}0">,
  InGroup<DiagGroup<"ambiguous-ellipsis">>;
def note_misplaced_ellipsis_vararg_existing_ellipsis : Note<
  "preceding '...' declares a function parameter pack"
  "\n" "提示：前面的 '...' 声明了一个函数形参包">;
def note_misplaced_ellipsis_vararg_add_ellipsis : Note<
  "place '...' %select{immediately before declared identifier|here}0 "
  "to declare a function parameter pack"
  "\n" "提示：将 '...' %select{紧挨在被声明的标识符之前|放在此处}0"
  "以声明函数形参包">;
def note_misplaced_ellipsis_vararg_add_comma : Note<
  "insert ',' before '...' to silence this warning"
  "\n" "提示：在 '...' 之前插入 ',' 以消除此警告">;
def ext_abstract_pack_declarator_parens : ExtWarn<
  "ISO C++11 requires a parenthesized pack declaration to have a name"
  "\n" "警告：ISO C++11 要求带括号的包声明有名称">,
  InGroup<DiagGroup<"anonymous-pack-parens">>;
def err_function_is_not_record : Error<
  "unexpected %0 in function call; perhaps remove the %0?"
  "\n" "错误：函数调用中出现意外的 %0；或许应该删除 %0？">;
def err_super_in_using_declaration : Error<
  "'__super' cannot be used with a using declaration"
  "\n" "错误：'__super' 不能与 using 声明一起使用">;
def ext_constexpr_if : ExtWarn<
  "constexpr if is a C++17 extension"
  "\n" "警告：constexpr if 是 C++17 扩展">, InGroup<CXX17>;
def warn_cxx14_compat_constexpr_if : Warning<
  "constexpr if is incompatible with C++ standards before C++17"
  "\n" "警告：constexpr if 与 C++17 之前的 C++ 标准不兼容">,
  DefaultIgnore, InGroup<CXXPre17Compat>;
def ext_consteval_if : ExtWarn<
  "consteval if is a C++23 extension"
  "\n" "警告：consteval if 是 C++23 扩展">,
   InGroup<CXX23>;
def warn_cxx20_compat_consteval_if : Warning<
  "consteval if is incompatible with C++ standards before C++23"
  "\n" "警告：consteval if 与 C++23 之前的 C++ 标准不兼容">,
  InGroup<CXXPre23Compat>, DefaultIgnore;

def ext_init_statement : ExtWarn<
  "'%select{if|switch}0' initialization statements are a C++17 extension"
  "\n" "警告：'%select{if|switch}0' 初始化语句是 C++17 扩展">,
  InGroup<CXX17>;
def warn_cxx14_compat_init_statement : Warning<
  "%select{if|switch}0 initialization statements are incompatible with "
  "C++ standards before C++17"
  "\n" "警告：%select{if|switch}0初始化语句与 C++17 之前的 C++ 标准不兼容">,
  DefaultIgnore, InGroup<CXXPre17Compat>;
def ext_for_range_init_stmt : ExtWarn<
  "range-based for loop initialization statements are a C++20 extension"
  "\n" "警告：基于范围的 for 循环初始化语句是 C++20 扩展">,
  InGroup<CXX20>;
def warn_cxx17_compat_for_range_init_stmt : Warning<
  "range-based for loop initialization statements are incompatible with "
  "C++ standards before C++20"
  "\n" "警告：基于范围的 for 循环初始化语句与 C++20 之前的 C++ 标准不兼容">,
  DefaultIgnore, InGroup<CXXPre20Compat>;
def warn_empty_init_statement : Warning<
  "empty initialization statement of '%select{if|switch|range-based for}0' "
  "has no effect"
  "\n" "警告：'%select{if|switch|基于范围的 for}0' 的空初始化语句无效">,
  InGroup<EmptyInitStatement>, DefaultIgnore;
def err_keyword_as_parameter : Error <
  "invalid parameter name: '%0' is a keyword"
  "\n" "错误：无效的参数名：'%0' 是关键字">;
def warn_pre_cxx26_ambiguous_pack_indexing_type : Warning<
  "%0 is no longer a pack expansion but a pack "
  "indexing type; add a name to specify a pack expansion"
  "\n" "警告：%0 不再是包展开而是包索引类型；请添加名称以指定包展开">,
  InGroup<CXXPre26Compat>;

// C++ derived classes
def err_dup_virtual : Error<"duplicate 'virtual' in base specifier"
  "\n" "错误：基类说明符中有重复的 'virtual'">;

// C++ operator overloading
def err_literal_operator_string_prefix : Error<
  "string literal after 'operator' cannot have an encoding prefix"
  "\n" "错误：'operator' 之后的字符串字面量不能有编码前缀">;
def err_literal_operator_string_not_empty : Error<
  "string literal after 'operator' must be '\"\"'"
  "\n" "错误：'operator' 之后的字符串字面量必须是 '\"\"'">;
def warn_cxx98_compat_literal_operator : Warning<
  "literal operators are incompatible with C++98"
  "\n" "警告：字面量运算符与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;

// Classes.
def err_anon_type_definition : Error<
  "declaration of anonymous %0 must be a definition"
  "\n" "错误：匿名 %0 的声明必须是定义">;
def err_default_delete_in_multiple_declaration : Error<
  "'= %select{default|delete}0' is a function definition and must occur in a "
  "standalone declaration"
  "\n" "错误：'= %select{default|delete}0' 是函数定义，必须出现在"
  "独立声明中">;

def warn_cxx98_compat_noexcept_expr : Warning<
  "noexcept expressions are incompatible with C++98"
  "\n" "警告：noexcept 表达式与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def warn_cxx98_compat_nullptr : Warning<
  "'nullptr' is incompatible with C++98"
  "\n" "警告：'nullptr' 与 C++98 不兼容">, InGroup<CXX98Compat>, DefaultIgnore;
def ext_c_nullptr : Extension<
  "'nullptr' is a C23 extension"
  "\n" "警告：'nullptr' 是 C23 扩展">, InGroup<C23>;

def warn_wrong_clang_attr_namespace : Warning<
  "'__clang__' is a predefined macro name, not an attribute scope specifier; "
  "did you mean '_Clang' instead?"
  "\n" "警告：'__clang__' 是预定义的宏名，不是特性作用域说明符；"
  "您是指 '_Clang' 吗？">, InGroup<IgnoredAttributes>;
def ext_ns_enum_attribute : Extension<
  "attributes on %select{a namespace|an enumerator}0 declaration are "
  "a C++17 extension"
  "\n" "警告：%select{命名空间|枚举项}0声明上的特性是 C++17 扩展">,
  InGroup<CXX17>;
def warn_cxx14_compat_ns_enum_attribute : Warning<
  "attributes on %select{a namespace|an enumerator}0 declaration are "
  "incompatible with C++ standards before C++17"
  "\n" "警告：%select{命名空间|枚举项}0声明上的特性与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17CompatPedantic>, DefaultIgnore;
def warn_cxx98_compat_alignas : Warning<"'alignas' is incompatible with C++98"
  "\n" "警告：'alignas' 与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def warn_cxx98_compat_attribute : Warning<
  "[[]] attributes are incompatible with C++ standards before C++11"
  "\n" "警告：[[]] 特性与 C++11 之前的 C++ 标准不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def warn_ext_cxx11_attributes : Extension<
  "[[]] attributes are a C++11 extension"
  "\n" "警告：[[]] 特性是 C++11 扩展">,
  InGroup<CXX11>;
def warn_pre_c23_compat_attributes : Warning<
  "[[]] attributes are incompatible with C standards before C23"
  "\n" "警告：[[]] 特性与 C23 之前的 C 标准不兼容">,
  DefaultIgnore, InGroup<CPre23Compat>;
def warn_ext_c23_attributes : Extension<
  "[[]] attributes are a C23 extension"
  "\n" "警告：[[]] 特性是 C23 扩展">,
  InGroup<C23>;
def err_cxx11_attribute_forbids_arguments : Error<
  "attribute %0 cannot have an argument list"
  "\n" "错误：特性 %0 不能有参数列表">;
def err_attribute_requires_arguments : Error<
  "parentheses must be omitted if %0 attribute's argument list is empty"
  "\n" "错误：如果 %0 特性的参数列表为空，必须省略括号">;
def err_cxx11_attribute_forbids_ellipsis : Error<
  "attribute %0 cannot be used as an attribute pack"
  "\n" "错误：特性 %0 不能用作特性包">;
def warn_cxx14_compat_using_attribute_ns : Warning<
  "default scope specifier for attributes is incompatible with C++ standards "
  "before C++17"
  "\n" "警告：特性的默认作用域说明符与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17Compat>, DefaultIgnore;
def ext_using_attribute_ns : ExtWarn<
  "default scope specifier for attributes is a C++17 extension"
  "\n" "警告：特性的默认作用域说明符是 C++17 扩展">,
  InGroup<CXX17>;
def err_using_attribute_ns_conflict : Error<
  "attribute with scope specifier cannot follow default scope specifier"
  "\n" "错误：带作用域说明符的特性不能跟在默认作用域说明符之后">;
def err_attributes_not_allowed : Error<"an attribute list cannot appear here"
  "\n" "错误：特性列表不能出现在此处">;
def err_keyword_not_allowed : Error<"%0 cannot appear here"
  "\n" "错误：%0 不能出现在此处">;
def ext_cxx11_attr_placement : ExtWarn<
  "ISO C++ does not allow %select{an attribute list|%0}1 to appear here"
  "\n" "警告：ISO C++ 不允许 %select{特性列表|%0}1 出现在此处">,
  InGroup<DiagGroup<"cxx-attribute-extension">>;
def err_attributes_misplaced : Error<"misplaced attributes; expected attributes here"
  "\n" "错误：特性位置错误；此处应有特性">;
def err_keyword_misplaced : Error<"misplaced %0; expected %0 here"
  "\n" "错误：%0 位置错误；此处应有 %0">;
def err_l_square_l_square_not_attribute : Error<
  "C++11 only allows consecutive left square brackets when "
  "introducing an attribute"
  "\n" "错误：C++11 只允许在引入特性时连续使用左方括号">;
def err_attribute_argument_parm_pack_not_supported : Error<
  "attribute %0 does not support argument pack expansion"
  "\n" "错误：特性 %0 不支持实参包展开">;
def err_ms_declspec_type : Error<
  "__declspec attributes must be an identifier or string literal"
  "\n" "错误：__declspec 特性必须是标识符或字符串字面量">;
def err_ms_property_no_getter_or_putter : Error<
  "property does not specify a getter or a putter"
  "\n" "错误：属性没有指定 getter 或 putter">;
def err_ms_property_unknown_accessor : Error<
  "expected 'get' or 'put' in property declaration"
  "\n" "错误：属性声明中应有 'get' 或 'put'">;
def err_ms_property_has_set_accessor : Error<
  "putter for property must be specified as 'put', not 'set'"
  "\n" "错误：属性的 putter 必须指定为 'put'，而不是 'set'">;
def err_ms_property_missing_accessor_kind : Error<
  "missing 'get=' or 'put='"
  "\n" "错误：缺少 'get=' 或 'put='">;
def err_ms_property_expected_equal : Error<
  "expected '=' after '%0'"
  "\n" "错误：'%0' 之后应有 '='">;
def err_ms_property_duplicate_accessor : Error<
  "property declaration specifies '%0' accessor twice"
  "\n" "错误：属性声明指定了两次 '%0' 访问器">;
def err_ms_property_expected_accessor_name : Error<
  "expected name of accessor method"
  "\n" "错误：应为访问器方法的名称">;
def err_ms_property_expected_comma_or_rparen : Error<
  "expected ',' or ')' at end of property accessor list"
  "\n" "错误：属性访问器列表末尾应有 ',' 或 ')'">;
def err_ms_property_initializer : Error<
  "property declaration cannot have a default member initializer"
  "\n" "错误：属性声明不能有默认成员初始化器">;
def ext_invalid_attribute_argument
    : Extension<"'%0' is not allowed in an attribute argument list"
    "\n" "警告：'%0' 不允许出现在特性参数列表中">,
    InGroup<DiagGroup<"attribute-preprocessor-tokens">>;

def err_assume_attr_expects_cond_expr : Error<
  "use of this expression in an %0 attribute requires parentheses"
  "\n" "错误：在 %0 特性中使用此表达式需要括号">;

def warn_cxx20_compat_explicit_bool : Warning<
  "this expression will be parsed as explicit(bool) in C++20"
  "\n" "警告：此表达式在 C++20 中将被解析为 explicit(bool)">,
  InGroup<CXX20Compat>, DefaultIgnore;
def warn_cxx17_compat_explicit_bool : Warning<
  "explicit(bool) is incompatible with C++ standards before C++20"
  "\n" "警告：explicit(bool) 与 C++20 之前的 C++ 标准不兼容">,
  InGroup<CXXPre20Compat>, DefaultIgnore;
def ext_explicit_bool : ExtWarn<"explicit(bool) is a C++20 extension"
  "\n" "警告：explicit(bool) 是 C++20 扩展">,
  InGroup<CXX20>;

/// C++ Templates
def err_expected_template : Error<"expected template"
  "\n" "错误：应为模板">;
def err_unknown_template_name : Error<
  "unknown template name %0"
  "\n" "错误：未知的模板名 %0">;
def err_expected_comma_greater : Error<
  "expected ',' or '>' in template-parameter-list"
  "\n" "错误：模板形参列表中应有 ',' 或 '>'">;
def err_class_on_template_template_param
    : Error<"template template parameter requires 'class'%select{| or "
            "'typename'}0 after the parameter list"
    "\n" "错误：模板模板形参需要在形参列表之后使用 'class'%select{| 或 "
    "'typename'}0">;
def ext_template_template_param_typename : ExtWarn<
  "template template parameter using 'typename' is a C++17 extension"
  "\n" "警告：使用 'typename' 的模板模板形参是 C++17 扩展">,
  InGroup<CXX17>;
def warn_cxx14_compat_template_template_param_typename : Warning<
  "template template parameter using 'typename' is "
  "incompatible with C++ standards before C++17"
  "\n" "警告：使用 'typename' 的模板模板形参与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17Compat>, DefaultIgnore;
def err_template_spec_syntax_non_template : Error<
  "identifier followed by '<' indicates a class template specialization but "
  "%0 %select{does not refer to a template|refers to a function template|"
  "<unused>|refers to a variable template|<unused>|<unused>|"
  "refers to a concept}1"
  "\n" "错误：标识符后跟 '<' 表示类模板特化，但 %0 "
  "%select{不引用模板|引用函数模板|<未使用>|引用变量模板|<未使用>|<未使用>|"
  "引用概念}1">;
def err_id_after_template_in_nested_name_spec : Error<
  "expected template name after 'template' keyword in nested name specifier"
  "\n" "错误：嵌套名称说明符中 'template' 关键字之后应有模板名">;
def err_unexpected_template_in_unqualified_id : Error<
  "'template' keyword not permitted here"
  "\n" "错误：此处不允许 'template' 关键字">;
def err_unexpected_template_in_destructor_name : Error<
  "'template' keyword not permitted in destructor name"
  "\n" "错误：析构函数名中不允许 'template' 关键字">;
def err_unexpected_template_after_using : Error<
  "'template' keyword not permitted after 'using' keyword"
  "\n" "错误：'using' 关键字之后不允许 'template' 关键字">;
def err_two_right_angle_brackets_need_space : Error<
  "a space is required between consecutive right angle brackets (use '> >')"
  "\n" "错误：连续右尖括号之间需要空格（使用 '> >'）">;
def err_right_angle_bracket_equal_needs_space : Error<
  "a space is required between a right angle bracket and an equals sign "
  "(use '> =')"
  "\n" "错误：右尖括号和等号之间需要空格（使用 '> ='）">;
def warn_cxx11_right_shift_in_template_arg : Warning<
  "use of right-shift operator ('>>') in template argument will require "
  "parentheses in C++11"
  "\n" "警告：在模板实参中使用右移运算符（'>>'）在 C++11 中将需要括号">,
  InGroup<CXX11Compat>;
def warn_cxx98_compat_two_right_angle_brackets : Warning<
  "consecutive right angle brackets are incompatible with C++98 (use '> >')"
  "\n" "警告：连续右尖括号与 C++98 不兼容（使用 '> >'）">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_templated_invalid_declaration : Error<
  "a static_assert declaration cannot be a template"
  "\n" "错误：static_assert 声明不能是模板">;
def err_multiple_template_declarators : Error<
  "%select{|a template declaration|an explicit template specialization|"
  "an explicit template instantiation}0 can "
  "only %select{|declare|declare|instantiate}0 a single entity"
  "\n" "错误：%select{|模板声明|显式模板特化|"
  "显式模板实例化}0只能%select{|声明|声明|实例化}0单个实体">;
def err_explicit_instantiation_with_definition : Error<
  "explicit template instantiation cannot have a definition; if this "
  "definition is meant to be an explicit specialization, add '<>' after the "
  "'template' keyword"
  "\n" "错误：显式模板实例化不能有定义；如果此定义本意是显式特化，"
  "请在 'template' 关键字之后添加 '<>'">;
def err_template_defn_explicit_instantiation : Error<
  "%select{function|class|variable}0 cannot be defined in an explicit instantiation; if this "
  "declaration is meant to be a %select{function|class|variable}0 definition, remove the 'template' keyword"
  "\n" "错误：%select{函数|类|变量}0不能在显式实例化中定义；如果此声明本意是"
  "%select{函数|类|变量}0定义，请移除 'template' 关键字">;
def err_friend_explicit_instantiation : Error<
  "friend cannot be declared in an explicit instantiation; if this "
  "declaration is meant to be a friend declaration, remove the 'template' keyword"
  "\n" "错误：不能在显式实例化中声明 friend；如果此声明本意是 friend 声明，"
  "请移除 'template' 关键字">;
def err_explicit_instantiation_enum : Error<
  "enumerations cannot be explicitly instantiated"
  "\n" "错误：枚举不能被显式实例化">;
def err_expected_template_parameter : Error<"expected template parameter"
  "\n" "错误：应为模板形参">;
def err_empty_requires_expr : Error<
  "a requires expression must contain at least one requirement"
  "\n" "错误：requires 表达式必须至少包含一个要求">;
def err_requires_expr_parameter_list_ellipsis : Error<
  "varargs not allowed in requires expression"
  "\n" "错误：requires 表达式中不允许可变参数">;
def err_requires_expr_explicit_object_parameter: Error<
  "a requires expression cannot have an explicit object parameter"
  "\n" "错误：requires 表达式不能有显式对象参数">;
def err_expected_semi_requirement : Error<
  "expected ';' at end of requirement"
  "\n" "错误：要求末尾应有 ';'">;
def err_requires_expr_missing_arrow : Error<
  "expected '->' before expression type requirement"
  "\n" "错误：表达式类型要求之前应有 '->'">;
def err_requires_expr_expected_type_constraint : Error<
  "expected concept name with optional arguments"
  "\n" "错误：应为带可选参数的概念名">;
def err_requires_expr_simple_requirement_noexcept : Error<
  "'noexcept' can only be used in a compound requirement (with '{' '}' around "
  "the expression)"
  "\n" "错误：'noexcept' 只能在复合要求中使用（在表达式周围加 '{' '}'）">;
def err_requires_expr_in_simple_requirement : Error<
  "requires expression in requirement body; did "
  "you intend to place it in a nested requirement? (add another 'requires' "
  "before the expression)"
  "\n" "错误：要求体中的 requires 表达式；您是否打算将其放在嵌套要求中？"
  "（在表达式前再添加一个 'requires'）">;
def missing_template_arg_list_after_template_kw : Extension<
  "a template argument list is expected after a name prefixed by the template "
  "keyword"
  "\n" "警告：以 template 关键字为前缀的名称之后应有模板实参列表">,
  InGroup<DiagGroup<"missing-template-arg-list-after-template-kw">>,
  DefaultError;

def err_missing_dependent_template_keyword : Error<
  "use 'template' keyword to treat '%0' as a dependent template name"
  "\n" "错误：使用 'template' 关键字将 '%0' 视为依赖模板名">;
def warn_missing_dependent_template_keyword : ExtWarn<
  "use 'template' keyword to treat '%0' as a dependent template name"
  "\n" "警告：使用 'template' 关键字将 '%0' 视为依赖模板名">;

def err_cxx26_template_template_params
    : Error<"%select{variable template|concept}0 template parameter is a C++2c "
            "extension"
            "\n" "错误：%select{变量模板|概念}0模板形参是 C++2c 扩展">;

def ext_extern_template : Extension<
  "extern templates are a C++11 extension"
  "\n" "警告：extern 模板是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_extern_template : Warning<
  "extern templates are incompatible with C++98"
  "\n" "警告：extern 模板与 C++98 不兼容">,
  InGroup<CXX98CompatPedantic>, DefaultIgnore;
def warn_static_inline_explicit_inst_ignored : Warning<
  "ignoring '%select{static|inline}0' keyword on explicit template "
  "instantiation"
  "\n" "警告：忽略显式模板实例化上的 '%select{static|inline}0' 关键字">,
  InGroup<DiagGroup<"static-inline-explicit-instantiation">>;

// Constructor template diagnostics.
def err_out_of_line_constructor_template_id : Error<
  "out-of-line constructor for %0 cannot have template arguments"
  "\n" "错误：%0 的类外构造函数不能有模板实参">;

def err_expected_qualified_after_typename : Error<
  "expected a qualified name after 'typename'"
  "\n" "错误：'typename' 之后应为限定名">;
def warn_expected_qualified_after_typename : ExtWarn<
  "expected a qualified name after 'typename'"
  "\n" "警告：'typename' 之后应为限定名">;

def err_typename_refers_to_non_type_template : Error<
  "typename specifier refers to a non-type template"
  "\n" "错误：typename 说明符引用了非类型模板">;
def err_expected_type_name_after_typename : Error<
  "expected an identifier or template-id after '::'"
  "\n" "错误：'::' 之后应为标识符或模板 ID">;
def err_explicit_spec_non_template : Error<
  "explicit %select{specialization|instantiation}0 of "
  "%select{non-|undeclared }3template %1 %2"
  "\n" "错误：对 %select{非|未声明的 }3模板 %1 %2 的显式"
  "%select{特化|实例化}0">;

def err_default_template_template_parameter_not_template : Error<
  "default template argument for a template template parameter must be a class "
  "template"
  "\n" "错误：模板模板形参的默认模板实参必须是类模板">;

def ext_fold_expression : ExtWarn<
  "pack fold expression is a C++17 extension"
  "\n" "警告：包折叠表达式是 C++17 扩展">,
  InGroup<CXX17>;
def warn_cxx14_compat_fold_expression : Warning<
  "pack fold expression is incompatible with C++ standards before C++17"
  "\n" "警告：包折叠表达式与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17Compat>, DefaultIgnore;
def err_expected_fold_operator : Error<
  "expected a foldable binary operator in fold expression"
  "\n" "错误：折叠表达式中应有可折叠的二元运算符">;
def err_fold_operator_mismatch : Error<
  "operators in fold expression must be the same"
  "\n" "错误：折叠表达式中的运算符必须相同">;

def err_ctor_init_missing_comma : Error<
  "missing ',' between base or member initializers"
  "\n" "错误：基类或成员初始化器之间缺少 ','">;

// C++ declarations
def err_friend_decl_defines_type : Error<
  "cannot define a type in a friend declaration"
  "\n" "错误：不能在 friend 声明中定义类型">;
def err_missing_whitespace_digraph : Error<
  "found '<::' after a "
  "%select{template name|addrspace_cast|const_cast|dynamic_cast|reinterpret_cast|static_cast}0"
  " which forms the digraph '<:' (aka '[') and a ':', did you mean '< ::'?"
  "\n" "错误：在 %select{模板名|addrspace_cast|const_cast|dynamic_cast|"
  "reinterpret_cast|static_cast}0 后找到 '<::'，它构成二合字母 '<:'（即 '['）"
  "和一个 ':'，您是指 '< ::' 吗？">;

def ext_defaulted_deleted_function : ExtWarn<
  "%select{defaulted|deleted}0 function definitions are a C++11 extension"
  "\n" "警告：%select{默认|已删除}0函数定义是 C++11 扩展">,
  InGroup<CXX11>;
def warn_cxx98_compat_defaulted_deleted_function : Warning<
  "%select{defaulted|deleted}0 function definitions are incompatible with C++98"
  "\n" "警告：%select{默认|已删除}0函数定义与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;

def ext_delete_with_message : Extension<
  "'= delete' with a message is a C++2c extension"
  "\n" "警告：带消息的 '= delete' 是 C++2c 扩展">, InGroup<CXX26>;
def warn_cxx23_delete_with_message : Warning<
  "'= delete' with a message is incompatible with C++ standards before C++2c"
  "\n" "警告：带消息的 '= delete' 与 C++2c 之前的 C++ 标准不兼容">,
  DefaultIgnore, InGroup<CXXPre26Compat>;

def ext_variadic_friends : ExtWarn<
  "variadic 'friend' declarations are a C++2c extension"
  "\n" "警告：可变参数 'friend' 声明是 C++2c 扩展">, InGroup<CXX26>;
def warn_cxx23_variadic_friends : Warning<
  "variadic 'friend' declarations are incompatible with C++ standards before C++2c"
  "\n" "警告：可变参数 'friend' 声明与 C++2c 之前的 C++ 标准不兼容">,
  DefaultIgnore, InGroup<CXXPre26Compat>;

def err_friend_concept : Error<
  "friend declaration cannot be a concept"
  "\n" "错误：friend 声明不能是概念">;

// C++11 default member initialization
def ext_nonstatic_member_init : ExtWarn<
  "default member initializer for non-static data member is a C++11 "
  "extension"
  "\n" "警告：非静态数据成员的默认成员初始化器是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_nonstatic_member_init : Warning<
  "default member initializer for non-static data members is incompatible with "
  "C++98"
  "\n" "警告：非静态数据成员的默认成员初始化器与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def ext_bitfield_member_init: ExtWarn<
  "default member initializer for bit-field is a C++20 extension"
  "\n" "警告：位域的默认成员初始化器是 C++20 扩展">,
  InGroup<CXX20>;
def warn_cxx17_compat_bitfield_member_init: Warning<
  "default member initializer for bit-field is incompatible with "
  "C++ standards before C++20"
  "\n" "警告：位域的默认成员初始化器与 C++20 之前的 C++ 标准不兼容">,
  InGroup<CXXPre20Compat>, DefaultIgnore;
def err_anon_bitfield_member_init : Error<
  "anonymous bit-field cannot have a default member initializer"
  "\n" "错误：匿名位域不能有默认成员初始化器">;
def err_incomplete_array_member_init: Error<
  "array bound cannot be deduced from a default member initializer"
  "\n" "错误：无法从默认成员初始化器推导数组边界">;

// C++11 alias-declaration
def ext_alias_declaration : ExtWarn<
  "alias declarations are a C++11 extension"
  "\n" "警告：别名声明是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_alias_declaration : Warning<
  "alias declarations are incompatible with C++98"
  "\n" "警告：别名声明与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_alias_declaration_not_identifier : Error<
  "name defined in alias declaration must be an identifier"
  "\n" "错误：在别名声明中定义的名称必须是标识符">;
def err_alias_declaration_specialization : Error<
  "%select{partial specialization|explicit specialization|explicit instantiation}0 of alias templates is not permitted"
  "\n" "错误：不允许对别名模板进行%select{部分特化|显式特化|显式实例化}0">;
def err_alias_declaration_pack_expansion : Error<
  "alias declaration cannot be a pack expansion"
  "\n" "错误：别名声明不能是包展开">;

// C++17 using-declaration pack expansions
def ext_multi_using_declaration : ExtWarn<
  "use of multiple declarators in a single using declaration is "
  "a C++17 extension"
  "\n" "警告：在单个 using 声明中使用多个声明符是 C++17 扩展">, InGroup<CXX17>;
def warn_cxx17_compat_multi_using_declaration : Warning<
  "use of multiple declarators in a single using declaration is "
  "incompatible with C++ standards before C++17"
  "\n" "警告：在单个 using 声明中使用多个声明符与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17Compat>, DefaultIgnore;
def ext_using_declaration_pack : ExtWarn<
  "pack expansion of using declaration is a C++17 extension"
  "\n" "警告：using 声明的包展开是 C++17 扩展">, InGroup<CXX17>;
def warn_cxx17_compat_using_declaration_pack : Warning<
  "pack expansion using declaration is incompatible with C++ standards "
  "before C++17"
  "\n" "警告：using 声明的包展开与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17Compat>, DefaultIgnore;

// C++11 override control
def ext_override_control_keyword : ExtWarn<
  "'%0' keyword is a C++11 extension"
  "\n" "警告：'%0' 关键字是 C++11 扩展">, InGroup<CXX11>;
def warn_cxx98_compat_override_control_keyword : Warning<
  "'%0' keyword is incompatible with C++98"
  "\n" "警告：'%0' 关键字与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def err_override_control_interface : Error<
  "'%0' keyword not permitted with interface types"
  "\n" "错误：接口类型不允许使用 '%0' 关键字">;
def ext_ms_sealed_keyword : ExtWarn<
  "'sealed' keyword is a Microsoft extension"
  "\n" "警告：'sealed' 关键字是 Microsoft 扩展">,
  InGroup<MicrosoftSealed>;
def ext_ms_abstract_keyword : ExtWarn<
  "'abstract' keyword is a Microsoft extension"
  "\n" "警告：'abstract' 关键字是 Microsoft 扩展">,
  InGroup<MicrosoftAbstract>;

def err_access_specifier_interface : Error<
  "interface types cannot specify '%select{private|protected}0' access"
  "\n" "错误：接口类型不能指定 '%select{private|protected}0' 访问">;

def err_duplicate_class_virt_specifier : Error<
  "class already marked '%0'"
  "\n" "错误：类已标记为 '%0'">;

def err_duplicate_virt_specifier : Error<
  "class member already marked '%0'"
  "\n" "错误：类成员已标记为 '%0'">;

def err_virt_specifier_outside_class : Error<
  "'%0' specifier is not allowed outside a class definition"
  "\n" "错误：不允许在类定义之外使用 '%0' 说明符">;

def err_expected_parameter_pack : Error<
  "expected the name of a parameter pack"
  "\n" "错误：应为形参包的名称">;
def err_paren_sizeof_parameter_pack : Error<
  "missing parentheses around the size of parameter pack %0"
  "\n" "错误：形参包 %0 的大小缺少括号">;
def err_sizeof_parameter_pack : Error<
  "expected parenthesized parameter pack name in 'sizeof...' expression"
  "\n" "错误：'sizeof...' 表达式中应有带括号的形参包名">;

// C++11 lambda expressions
def err_expected_comma_or_rsquare : Error<
  "expected ',' or ']' in lambda capture list"
  "\n" "错误：lambda 捕获列表中应有 ',' 或 ']'">;
def err_this_captured_by_reference : Error<
  "'this' cannot be captured by reference"
  "\n" "错误：'this' 不能按引用捕获">;
def err_expected_capture : Error<
  "expected variable name or 'this' in lambda capture list"
  "\n" "错误：lambda 捕获列表中应有变量名或 'this'">;
def err_expected_lambda_body : Error<"expected body of lambda expression"
  "\n" "错误：应有 lambda 表达式的主体">;
def warn_cxx98_compat_lambda : Warning<
  "lambda expressions are incompatible with C++98"
  "\n" "警告：lambda 表达式与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def ext_lambda : ExtWarn<"lambdas are a %select{C++11|clang HLSL}0 extension"
  "\n" "警告：lambda 是 %select{C++11|clang HLSL}0 扩展">,
  InGroup<CXX11>;
def ext_hlsl_lambda : ExtWarn<ext_lambda.Summary>,
  InGroup<HLSLExtension>;
def err_lambda_decl_specifier_repeated : Error<
  "%select{'mutable'|'static'|'constexpr'|'consteval'}0 cannot "
  "appear multiple times in a lambda declarator"
  "\n" "错误：%select{'mutable'|'static'|'constexpr'|'consteval'}0不能"
  "多次出现在 lambda 声明符中">;
def err_lambda_capture_misplaced_ellipsis : Error<
  "ellipsis in pack %select{|init-}0capture must appear %select{after|before}0 "
  "the name of the capture"
  "\n" "错误：包%select{|init-}0捕获中的省略号必须出现在捕获名称"
  "%select{之后|之前}0">;
def err_lambda_capture_multiple_ellipses : Error<
  "multiple ellipses in pack capture"
  "\n" "错误：包捕获中有多个省略号">;
def err_binding_multiple_ellipses : Error<
  "multiple packs in structured binding declaration"
  "\n" "错误：结构化绑定声明中有多个包">;
def note_previous_ellipsis : Note<
  "previous binding pack specified here"
  "\n" "提示：先前的绑定包在此指定">;
def ext_cxx_binding_pack : ExtWarn<
  "structured binding packs are a C++2c extension "
  "\n" "警告：结构化绑定包是 C++2c 扩展">,
  InGroup<CXX26>;
def warn_cxx23_compat_binding_pack : Warning<
  "structured binding packs are incompatible with C++ standards before C++2c"
  "\n" "警告：结构化绑定包与 C++2c 之前的 C++ 标准不兼容">,
  InGroup<CXXPre26Compat>, DefaultIgnore;
def err_capture_default_first : Error<
  "capture default must be first"
  "\n" "错误：捕获默认值必须是第一个">;
def ext_decl_attrs_on_lambda : ExtWarn<
  "%select{an attribute specifier sequence|%1}0 in this position "
  "is a C++23 extension"
  "\n" "警告：此位置的%select{特性说明符序列|%1}0是 C++23 扩展">,
  InGroup<CXX23AttrsOnLambda>;
def ext_lambda_missing_parens : ExtWarn<
  "lambda without a parameter clause is a C++23 extension"
  "\n" "警告：没有形参子句的 lambda 是 C++23 扩展">,
  InGroup<CXX23>;
def warn_cxx20_compat_decl_attrs_on_lambda : Warning<
  "%select{an attribute specifier sequence|%1}0 in this position "
  "is incompatible with C++ standards before C++23"
  "\n" "警告：此位置的%select{特性说明符序列|%1}0与 C++23 之前的 C++ 标准不兼容">,
  InGroup<CXXPre23Compat>, DefaultIgnore;

// C++17 lambda expressions
def err_expected_star_this_capture : Error<
  "expected 'this' following '*' in lambda capture list"
  "\n" "错误：lambda 捕获列表中 '*' 之后应有 'this'">;

// C++17 constexpr lambda expressions
def warn_cxx14_compat_constexpr_on_lambda : Warning<
  "constexpr on lambda expressions is incompatible with C++ standards before C++17"
  "\n" "警告：lambda 表达式上的 constexpr 与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17Compat>, DefaultIgnore;
def ext_constexpr_on_lambda_cxx17 : ExtWarn<
  "'constexpr' on lambda expressions is a C++17 extension"
  "\n" "警告：lambda 表达式上的 'constexpr' 是 C++17 扩展">, InGroup<CXX17>;

// C++20 template lambdas
def ext_lambda_template_parameter_list: ExtWarn<
  "explicit template parameter list for lambdas is a C++20 extension"
  "\n" "警告：lambda 的显式模板形参列表是 C++20 扩展">,
  InGroup<CXX20>;
def warn_cxx17_compat_lambda_template_parameter_list: Warning<
  "explicit template parameter list for lambdas is incompatible with "
  "C++ standards before C++20"
  "\n" "警告：lambda 的显式模板形参列表与 C++20 之前的 C++ 标准不兼容">,
  InGroup<CXXPre20Compat>, DefaultIgnore;
def err_lambda_template_parameter_list_empty : Error<
  "lambda template parameter list cannot be empty"
  "\n" "错误：lambda 模板形参列表不能为空">;

// C++23 static lambdas
def err_static_lambda: ExtWarn<
  "static lambdas are a C++23 extension"
  "\n" "警告：static lambda 是 C++23 扩展">, InGroup<CXX23>;
def warn_cxx20_compat_static_lambda : Warning<
  "static lambdas are incompatible with C++ standards before C++23"
  "\n" "警告：static lambda 与 C++23 之前的 C++ 标准不兼容">,
  InGroup<CXXPre23Compat>, DefaultIgnore;
def err_static_mutable_lambda : Error<
  "lambda cannot be both mutable and static"
  "\n" "错误：lambda 不能同时是 mutable 和 static">;
def err_static_lambda_captures : Error<
  "a static lambda cannot have any captures"
  "\n" "错误：static lambda 不能有任何捕获">;

// Availability attribute
def err_expected_version : Error<
  "expected a version of the form 'major[.minor[.subminor]]'"
  "\n" "错误：应为 'major[.minor[.subminor]]' 形式的版本">;
def warn_expected_consistent_version_separator : Warning<
  "use same version number separators '_' or '.'; as in "
  "'major[.minor[.subminor]]'"
  "\n" "警告：使用相同的版本号分隔符 '_' 或 '.'；如 "
  "'major[.minor[.subminor]]'">, InGroup<Availability>;
def err_zero_version : Error<
  "version number must have non-zero major, minor, or sub-minor version"
  "\n" "错误：版本号必须有非零的主版本、次版本或补丁版本">;
def err_availability_expected_platform : Error<
  "expected a platform name, e.g., 'macos'"
  "\n" "错误：应为平台名，例如 'macos'">;
def err_availability_expected_environment : Error<
  "expected an environment name, e.g., 'compute'"
  "\n" "错误：应为环境名，例如 'compute'">;

// objc_bridge_related attribute
def err_objcbridge_related_expected_related_class : Error<
  "expected a related Objective-C class name, e.g., 'NSColor'"
  "\n" "错误：应为相关的 Objective-C 类名，例如 'NSColor'">;
def err_objcbridge_related_selector_name : Error<
  "expected a class method selector with single argument, e.g., 'colorWithCGColor:'"
  "\n" "错误：应为带单个参数的类方法选择器，例如 'colorWithCGColor:'">;

def err_availability_expected_change : Error<
  "expected 'introduced', 'deprecated', or 'obsoleted'"
  "\n" "错误：应为 'introduced'、'deprecated' 或 'obsoleted'">;
def err_availability_unknown_change : Error<
  "%0 is not an availability stage; use 'introduced', 'deprecated', or "
  "'obsoleted'"
  "\n" "错误：%0 不是可用性阶段；请使用 'introduced'、'deprecated' 或 "
  "'obsoleted'">;
def err_availability_redundant : Error<
  "redundant %0 availability change; only the last specified change will "
  "be used"
  "\n" "错误：多余的 %0 可用性更改；只使用最后指定的更改">;
def warn_availability_and_unavailable : Warning<
  "'unavailable' availability overrides all other availability information"
  "\n" "警告：'unavailable' 可用性会覆盖所有其他可用性信息">,
  InGroup<Availability>;

// @available(...)
def err_avail_query_expected_platform_name : Error<
  "expected a platform name here"
  "\n" "错误：此处应有平台名">;

def err_avail_query_unrecognized_platform_name : Error<
  "unrecognized platform name %0"
  "\n" "错误：无法识别的平台名 %0">;
def err_avail_query_anyappleos_min_version : Error<
  "invalid anyAppleOS version '%0' in availability check"
  "\n" "错误：可用性检查中的 anyAppleOS 版本 '%0' 无效">;
def err_availability_query_wildcard_required: Error<
  "must handle potential future platforms with '*'"
  "\n" "错误：必须使用 '*' 处理潜在的未来平台">;
def err_availability_query_repeated_platform: Error<
  "version for '%0' already specified"
  "\n" "错误：'%0' 的版本已指定">;
def err_availability_query_repeated_star : Error<
  "'*' query has already been specified"
  "\n" "错误：'*' 查询已指定">;

// External source symbol attribute
def err_external_source_symbol_expected_keyword : Error<
  "expected 'language', 'defined_in', 'generated_declaration', or 'USR'"
  "\n" "错误：应为 'language'、'defined_in'、'generated_declaration' 或 'USR'">;
def err_external_source_symbol_duplicate_clause : Error<
  "duplicate %0 clause in an 'external_source_symbol' attribute"
  "\n" "错误：'external_source_symbol' 特性中有重复的 %0 子句">;

// Type safety attributes
def err_type_safety_unknown_flag : Error<
  "invalid comparison flag %0; use 'layout_compatible' or 'must_be_null'"
  "\n" "错误：无效的比较标志 %0；请使用 'layout_compatible' 或 'must_be_null'">;

// Type traits
def err_type_trait_arity : Error<
  "type trait requires %0%select{| or more}1 argument%select{|s}2; have "
  "%3 argument%s3"
  "\n" "错误：类型特征需要 %0%select{| 或更多}1个参数%select{|}2；当前有 "
  "%3 个参数%s3">;

// Language specific pragmas
// - Generic warnings
def warn_pragma_expected_lparen : Warning<
  "missing '(' after '#pragma %0' - ignoring"
  "\n" "警告：'#pragma %0' 之后缺少 '(' - 忽略">, InGroup<IgnoredPragmas>;
def warn_pragma_expected_rparen : Warning<
  "missing ')' after '#pragma %0' - ignoring"
  "\n" "警告：'#pragma %0' 之后缺少 ')' - 忽略">, InGroup<IgnoredPragmas>;
def warn_pragma_expected_identifier : Warning<
  "expected identifier in '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 中应为标识符 - 已忽略">, InGroup<IgnoredPragmas>;
def warn_pragma_expected_string : Warning<
  "expected string literal in '#pragma %0' - ignoring"
  "\n" "警告：'#pragma %0' 中应为字符串字面量 - 忽略">, InGroup<IgnoredPragmas>;
def warn_pragma_missing_argument : Warning<
  "missing argument to '#pragma %0'%select{|; expected %2}1"
  "\n" "警告：'#pragma %0' 缺少参数%select{|；应为 %2}1">, InGroup<IgnoredPragmas>;
def warn_pragma_invalid_argument : Warning<
  "unexpected argument '%0' to '#pragma %1'%select{|; expected %3}2"
  "\n" "警告：'#pragma %1' 的参数 '%0' 意外%select{|；应为 %3}2">, InGroup<IgnoredPragmas>;

def err_pragma_misplaced_in_decl : Error<"this pragma cannot appear in %0 declaration"
  "\n" "错误：此 pragma 不能出现在 %0 声明中">;

// '#pragma clang section' related errors
def err_pragma_expected_clang_section_name : Error<
  "expected one of [bss|data|rodata|text|relro] section kind in '#pragma %0'"
  "\n" "错误：'#pragma %0' 中应有 [bss|data|rodata|text|relro] 节类型之一">;
def err_pragma_clang_section_expected_equal : Error<
  "expected '=' following '#pragma clang section %select{invalid|bss|data|rodata|text|relro}0'"
  "\n" "错误：'#pragma clang section %select{无效|bss|data|rodata|text|relro}0' 之后应有 '='">;
def warn_pragma_expected_section_name : Warning<
  "expected a string literal for the section name in '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 中节名应为字符串字面量 - 已忽略">,
  InGroup<IgnoredPragmas>;

def warn_pragma_expected_section_push_pop_or_name : Warning<
  "expected push, pop or a string literal for the section name in '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 中节名应为 push、pop 或字符串字面量 - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_expected_section_label_or_name : Warning<
  "expected a stack label or a string literal for the section name in '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 中节名应为堆栈标签或字符串字面量 - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_expected_init_seg : Warning<
  "expected 'compiler', 'lib', 'user', or a string literal for the section name in '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 中节名应为 'compiler'、'lib'、'user' 或字符串字面量 - 已忽略">,
  InGroup<IgnoredPragmas>;

def err_pragma_expected_integer : Error<"expected an integer argument in '#pragma %0'"
  "\n" "错误：'#pragma %0' 中应为整数参数">;
def warn_pragma_expected_integer : Warning<
  "expected integer between %0 and %1 inclusive in '#pragma %2' - ignored"
  "\n" "警告：'#pragma %2' 中应为 %0 到 %1（含）之间的整数 - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_ms_struct : Warning<
  "incorrect use of '#pragma ms_struct on|off' - ignored"
  "\n" "警告：'#pragma ms_struct on|off' 的使用不正确 - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_ms_fenv_access : Warning<
  "incorrect use of '#pragma fenv_access (on|off)' - ignored"
  "\n" "警告：'#pragma fenv_access (on|off)' 的使用不正确 - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_extra_tokens_at_eol : Warning<
  "extra tokens at end of '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 末尾有额外标记 - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_expected_comma : Warning<
  "expected ',' in '#pragma %0'"
  "\n" "警告：'#pragma %0' 中应有 ','">, InGroup<IgnoredPragmas>;
def warn_pragma_expected_punc : Warning<
  "expected ')' or ',' in '#pragma %0'"
  "\n" "警告：'#pragma %0' 中应有 ')' 或 ','">, InGroup<IgnoredPragmas>;
def warn_pragma_expected_non_wide_string : Warning<
  "expected non-wide string literal in '#pragma %0'"
  "\n" "警告：'#pragma %0' 中应为非宽字符串字面量">, InGroup<IgnoredPragmas>;
// - Generic errors
def err_pragma_missing_argument : Error<
  "missing argument to '#pragma %0'%select{|; expected %2}1"
  "\n" "错误：'#pragma %0' 缺少参数%select{|；应为 %2}1">;
// - #pragma options
def warn_pragma_options_expected_align : Warning<
  "expected 'align' following '#pragma options' - ignored"
  "\n" "警告：'#pragma options' 之后应有 'align' - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_align_expected_equal : Warning<
  "expected '=' following '#pragma %select{align|options align}0' - ignored"
  "\n" "警告：'#pragma %select{align|options align}0' 之后应有 '=' - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_align_invalid_option : Warning<
  "invalid alignment option in '#pragma %select{align|options align}0' - ignored"
  "\n" "警告：'#pragma %select{align|options align}0' 中的对齐选项无效 - 已忽略">,
  InGroup<IgnoredPragmas>;
// - #pragma pack
def warn_pragma_unsupported_action : Warning<
  "known but unsupported action '%1' for '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 的已知但不支持的操作 '%1' - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_invalid_specific_action : Warning<
  "unknown action '%1' for '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 的未知操作 '%1' - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_expected_action_or_r_paren : Warning<
  "expected action or ')' in '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 中应有操作或 ')' - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_invalid_action : Warning<
  "unknown action for '#pragma %0' - ignored"
  "\n" "警告：'#pragma %0' 的未知操作 - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_pack_malformed : Warning<
  "expected integer or identifier in '#pragma pack' - ignored"
  "\n" "警告：'#pragma pack' 中应为整数或标识符 - 已忽略">,
  InGroup<IgnoredPragmas>;
// - #pragma intrinsic
def warn_pragma_intrinsic_builtin : Warning<
  "%0 is not a recognized builtin%select{|; consider including <intrin.h> to access non-builtin intrinsics}1"
  "\n" "警告：%0 不是可识别的内建函数%select{|；请考虑包含 <intrin.h> 以访问非内建函数}1">,
  InGroup<IgnoredPragmaIntrinsic>;
// - #pragma unused
def warn_pragma_unused_expected_var : Warning<
  "expected '#pragma unused' argument to be a variable name"
  "\n" "警告：'#pragma unused' 的参数应为变量名">,
  InGroup<IgnoredPragmas>;
// - #pragma init_seg
def warn_pragma_init_seg_unsupported_target : Warning<
  "'#pragma init_seg' is only supported when targeting a "
  "Microsoft environment"
  "\n" "警告：'#pragma init_seg' 仅在面向 Microsoft 环境时受支持">,
  InGroup<IgnoredPragmas>;
// - #pragma restricted to file scope or start of compound statement
def err_pragma_file_or_compound_scope : Error<
  "'#pragma %0' can only appear at file scope or at the start of a "
  "compound statement"
  "\n" "错误：'#pragma %0' 只能出现在文件作用域或复合语句开头">;
// - #pragma stdc unknown
def ext_stdc_pragma_ignored : ExtWarn<"unknown pragma in STDC namespace"
  "\n" "警告：STDC 命名空间中的未知 pragma">,
   InGroup<UnknownPragmas>;
// The C standard 7.6.1p2 says "The [FENV_ACCESS] pragma shall occur either
// outside external declarations or preceding all explicit declarations and
// statements inside a compound statement.
def warn_stdc_fenv_round_not_supported :
   Warning<"pragma STDC FENV_ROUND is not supported"
   "\n" "警告：不支持 pragma STDC FENV_ROUND">,
   InGroup<UnknownPragmas>;
def warn_stdc_unknown_rounding_mode : Warning<
  "invalid or unsupported rounding mode in '#pragma STDC FENV_ROUND' - ignored"
  "\n" "警告：'#pragma STDC FENV_ROUND' 中的舍入模式无效或不受支持 - 已忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_fp_ignored : Warning<
  "'#pragma %0' is not supported on this target - ignored"
  "\n" "警告：此目标不支持 '#pragma %0' - 已忽略">,
  InGroup<IgnoredPragmas>;
// - #pragma comment
def err_pragma_comment_malformed : Error<
  "pragma comment requires parenthesized identifier and optional string"
  "\n" "错误：pragma comment 需要带括号的标识符和可选字符串">;
def err_pragma_comment_unknown_kind : Error<"unknown kind of pragma comment"
  "\n" "错误：未知的 pragma comment 类型">;
// PS4 recognizes only #pragma comment(lib)
def warn_pragma_comment_ignored : Warning<"'#pragma comment %0' ignored"
  "\n" "警告：'#pragma comment %0' 被忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_comment_once
    : Warning<"'#pragma comment %0' "
              "ignored: it can be specified only once per translation unit"
              "\n" "警告：'#pragma comment %0' "
              "被忽略：它每个翻译单元只能指定一次">,
      InGroup<IgnoredPragmas>;
// - #pragma detect_mismatch
def err_pragma_detect_mismatch_malformed : Error<
  "pragma detect_mismatch is malformed; it requires two comma-separated "
  "string literals"
  "\n" "错误：pragma detect_mismatch 格式错误；它需要两个用逗号分隔的"
  "字符串字面量">;
// - #pragma float_control
def err_pragma_float_control_malformed : Error<
  "pragma float_control is malformed; use 'float_control({push|pop})' or "
  "'float_control({precise|except}, {on|off} [,push])'"
  "\n" "错误：pragma float_control 格式错误；请使用 'float_control({push|pop})' 或 "
  "'float_control({precise|except}, {on|off} [,push])'">;
// - #pragma pointers_to_members
def err_pragma_pointers_to_members_unknown_kind : Error<
  "unexpected %0, expected to see one of %select{|'best_case', 'full_generality', }1"
  "'single_inheritance', 'multiple_inheritance', or 'virtual_inheritance'"
  "\n" "错误：意外的 %0，期望看到 %select{|'best_case'、'full_generality'、}1"
  "'single_inheritance'、'multiple_inheritance' 或 'virtual_inheritance' 之一">;
// - #pragma clang optimize on/off
def err_pragma_optimize_invalid_argument : Error<
  "unexpected argument '%0' to '#pragma clang optimize'; "
  "expected 'on' or 'off'"
  "\n" "错误：'#pragma clang optimize' 的参数 '%0' 意外；"
  "应为 'on' 或 'off'">;
def err_pragma_optimize_extra_argument : Error<
  "unexpected extra argument '%0' to '#pragma clang optimize'"
  "\n" "错误：'#pragma clang optimize' 的额外参数 '%0' 意外">;
// - #pragma clang attribute
def err_pragma_attribute_expected_push_pop_paren : Error<
  "expected 'push', 'pop', or '(' after '#pragma clang attribute'"
  "\n" "错误：'#pragma clang attribute' 之后应有 'push'、'pop' 或 '('">;
def err_pragma_attribute_invalid_argument : Error<
  "unexpected argument '%0' to '#pragma clang attribute'; "
  "expected 'push' or 'pop'"
  "\n" "错误：'#pragma clang attribute' 的参数 '%0' 意外；"
  "应为 'push' 或 'pop'">;
def err_pragma_attribute_expected_attribute : Error<
  "expected an attribute after '('"
  "\n" "错误：'(' 之后应有特性">;
def err_pragma_attribute_expected_attribute_name : Error<
  "expected identifier that represents an attribute name"
  "\n" "错误：应为表示特性名称的标识符">;
def err_pragma_attribute_extra_tokens_after_attribute : Error<
  "extra tokens after attribute in a '#pragma clang attribute push'"
  "\n" "错误：'#pragma clang attribute push' 中特性之后有额外标记">;
def err_pragma_attribute_unsupported_attribute : Error<
  "attribute %0 is not supported by '#pragma clang attribute'"
  "\n" "错误：'#pragma clang attribute' 不支持特性 %0">;
def err_pragma_attribute_expected_attribute_syntax : Error<
  "expected an attribute that is specified using the GNU, C++11 or '__declspec'"
  " syntax"
  "\n" "错误：应为使用 GNU、C++11 或 '__declspec' 语法指定的特性">;
def note_pragma_attribute_use_attribute_kw : Note<"use the GNU '__attribute__' "
  "syntax"
  "\n" "提示：请使用 GNU '__attribute__' 语法">;
def err_pragma_attribute_invalid_subject_set_specifier : Error<
  "expected attribute subject set specifier 'apply_to'"
  "\n" "错误：应为特性主体集说明符 'apply_to'">;
def err_pragma_attribute_expected_subject_identifier : Error<
  "expected an identifier that corresponds to an attribute subject rule"
  "\n" "错误：应为对应于特性主体规则的标识符">;
def err_pragma_attribute_unknown_subject_rule : Error<
  "unknown attribute subject rule '%0'"
  "\n" "错误：未知的特性主体规则 '%0'">;
def err_pragma_attribute_expected_subject_sub_identifier : Error<
  "expected an identifier that corresponds to an attribute subject matcher "
  "sub-rule; '%0' matcher %select{does not support sub-rules|supports the "
  "following sub-rules: %2|}1"
  "\n" "错误：应为对应于特性主体匹配器子规则的标识符；"
  "'%0' 匹配器%select{不支持子规则|支持以下子规则：%2|}1">;
def err_pragma_attribute_unknown_subject_sub_rule : Error<
  "%select{invalid use of|unknown}2 attribute subject matcher sub-rule '%0'; "
  "'%1' matcher %select{does not support sub-rules|supports the following "
  "sub-rules: %3}2"
  "\n" "错误：%select{无效使用|未知}2特性主体匹配器子规则 '%0'；"
  "'%1' 匹配器%select{不支持子规则|支持以下子规则：%3}2">;
def err_pragma_attribute_duplicate_subject : Error<
  "duplicate attribute subject matcher '%0'"
  "\n" "错误：重复的特性主体匹配器 '%0'">;
def err_pragma_attribute_expected_period : Error<
  "expected '.' after pragma attribute namespace %0"
  "\n" "错误：pragma 特性命名空间 %0 之后应有 '.'">;
def err_pragma_attribute_namespace_on_attribute : Error<
  "namespace can only apply to 'push' or 'pop' directives"
  "\n" "错误：命名空间只能应用于 'push' 或 'pop' 指令">;
def note_pragma_attribute_namespace_on_attribute : Note<
  "omit the namespace to add attributes to the most-recently"
  " pushed attribute group"
  "\n" "提示：省略命名空间以将特性添加到最近推送的特性组">;
def warn_no_support_for_eval_method_source_on_m32 : Warning<
  "setting the floating point evaluation method to `source` on a target "
  "without SSE is not supported"
  "\n" "警告：在不支持 SSE 的目标上将浮点求值方法设置为 `source` 不受支持">,
  InGroup<Pragmas>;
// - #pragma __debug
def warn_pragma_debug_dependent_argument : Warning<
  "%select{value|type}0-dependent expression passed as an argument to debug "
  "command"
  "\n" "警告：%select{依赖值的|依赖类型的}0表达式作为参数传递给调试命令">,
  InGroup<IgnoredPragmas>;

// OpenCL EXTENSION pragma (OpenCL 1.1 [9.1])
def warn_pragma_expected_colon : Warning<
  "missing ':' after %0 - ignoring"
  "\n" "警告：%0 之后缺少 ':' - 忽略">, InGroup<IgnoredPragmas>;
def warn_pragma_expected_predicate : Warning<
  "expected %select{'enable', 'disable', 'begin' or 'end'|'disable'}0 - ignoring"
  "\n" "警告：应为 %select{'enable'、'disable'、'begin' 或 'end'|'disable'}0 - 忽略">,
  InGroup<IgnoredPragmas>;
def warn_pragma_unknown_extension : Warning<
  "OpenCL extension %0 unknown or does not require pragma - ignoring"
  "\n" "警告：OpenCL 扩展 %0 未知或不要求 pragma - 忽略">, InGroup<IgnoredPragmas>;
def warn_pragma_unsupported_extension : Warning<
  "unsupported OpenCL extension %0 - ignoring"
  "\n" "警告：不支持的 OpenCL 扩展 %0 - 忽略">, InGroup<IgnoredPragmas>;
def warn_pragma_extension_is_core : Warning<
  "OpenCL extension %0 is core feature or supported optional core feature - ignoring"
  "\n" "警告：OpenCL 扩展 %0 是核心特性或受支持的可选核心特性 - 忽略">,
  InGroup<OpenCLCoreFeaturesDiagGroup>, DefaultIgnore;
def err_modifier_expected_colon : Error<"missing ':' after %0 modifier"
  "\n" "错误：%0 修饰符之后缺少 ':'">;

// OpenCL errors.
def err_opencl_taking_function_address_parser : Error<
  "taking address of function is not allowed"
  "\n" "错误：不允许取函数的地址">;

// C++ for OpenCL.
def err_openclcxx_virtual_function : Error<
  "virtual functions are not supported in C++ for OpenCL"
  "\n" "错误：C++ for OpenCL 中不支持虚函数">;

// OpenACC Support.
def warn_pragma_acc_ignored
    : Warning<"unexpected '#pragma acc ...' in program"
      "\n" "警告：程序中出现意外的 '#pragma acc ...'">,
      InGroup<SourceUsesOpenACC>,
      DefaultIgnore;
def err_acc_unexpected_directive
    : Error<"unexpected OpenACC directive %select{|'#pragma acc %1'}0"
      "\n" "错误：意外的 OpenACC 指令 %select{|'#pragma acc %1'}0">;
def err_acc_invalid_directive
    : Error<"invalid OpenACC directive %select{%1|'%1 %2'}0"
      "\n" "错误：无效的 OpenACC 指令 %select{%1|'%1 %2'}0">;
def err_acc_invalid_clause : Error<"invalid OpenACC clause %0"
  "\n" "错误：无效的 OpenACC 子句 %0">;
def warn_acc_unsupported_extension_clause
    : Warning<"unsupported OpenACC extension clause %0"
      "\n" "警告：不支持的 OpenACC 扩展子句 %0">,
      InGroup<DiagGroup<"unknown-acc-extension-clause">>;
def err_acc_missing_directive : Error<"expected OpenACC directive"
  "\n" "错误：应为 OpenACC 指令">;
def err_acc_invalid_open_paren
    : Error<"expected clause-list or newline in OpenACC directive"
      "\n" "错误：OpenACC 指令中应有子句列表或换行符">;
def err_acc_invalid_default_clause_kind
    : Error<"invalid value for 'default' clause; expected 'present' or 'none'"
      "\n" "错误：'default' 子句的值无效；应为 'present' 或 'none'">;
def err_acc_invalid_tag_kind
    : Error<"invalid tag %0 on '%1' %select{directive|clause}2"
      "\n" "错误：'%1' %select{指令|子句}2上的标记 %0 无效">;
def err_acc_expected_reduction_operator
    : Error<"missing reduction operator, expected '+', '*', 'max', 'min', '&', "
            "'|', '^', '&&', or '||', follwed by a ':'"
            "\n" "错误：缺少归约运算符，应为 '+', '*', 'max', 'min', '&', "
            "'|', '^', '&&' 或 '||'，后跟 ':'">;
def err_acc_invalid_reduction_operator
    : Error<"invalid reduction operator,  expected '+', '*', 'max', 'min', "
            "'&', '|', '^', '&&', or '||'"
            "\n" "错误：无效的归约运算符，应为 '+', '*', 'max', 'min', "
            "'&', '|', '^', '&&' 或 '||'">;
def err_acc_incorrect_bind_arg
    : Error<"expected identifier or string literal in OpenACC 'bind' clause"
      "\n" "错误：OpenACC 'bind' 子句中应为标识符或字符串字面量">;
def err_acc_modifier
    : Error<"%enum_select<ACCModifier>{%Unknown{unknown}|%Duplicate{duplicate}}"
            "0 modifier %1 in OpenACC modifier-list on '%2' clause"
            "\n" "错误：'%2' 子句上的 OpenACC 修饰符列表中的 "
            "%enum_select<ACCModifier>{%Unknown{未知}|%Duplicate{重复}}0 修饰符 %1">;

// OpenMP support.
def warn_pragma_omp_ignored : Warning<
  "unexpected '#pragma omp ...' in program"
  "\n" "警告：程序中出现意外的 '#pragma omp ...'">, InGroup<SourceUsesOpenMP>, DefaultIgnore;
def warn_omp_extra_tokens_at_eol : Warning<
  "extra tokens at the end of '#pragma omp %0' are ignored"
  "\n" "警告：'#pragma omp %0' 末尾的额外标记被忽略">,
  InGroup<ExtraTokens>;
def err_omp_multiple_step_or_linear_modifier : Error<
  "multiple %select{'step size'|'linear modifier'}0 found in linear clause"
  "\n" "错误：在 linear 子句中找到了多个%select{'step size'|'linear modifier'}0">;
def err_omp_deprecate_old_syntax: Error<
  "old syntax '%0' on '%1' clause was deprecated, use new syntax '%2'"
  "\n" "错误：'%1' 子句上的旧语法 '%0' 已弃用，请使用新语法 '%2'">;
def err_omp_allocator_comma_separator :
  Error<"',' not allowed as separator in 'uses_allocators' clause, use ';' instead"
  "\n" "错误：'uses_allocators' 子句中不允许使用 ',' 作为分隔符，请改用 ';'">;
def warn_omp_future_directive_spelling: Warning<
  "directive spelling '%0' is introduced in a later OpenMP version"
  "\n" "警告：指令拼写 '%0' 在较新的 OpenMP 版本中引入">,
  InGroup<OpenMPFuture>;
def warn_pragma_expected_colon_r_paren : Warning<
  "missing ':' or ')' after %0 - ignoring"
  "\n" "警告：%0 之后缺少 ':' 或 ')' - 忽略">, InGroup<IgnoredPragmas>;
def err_omp_unknown_directive : Error<
  "expected an OpenMP directive"
  "\n" "错误：应为 OpenMP 指令">;
def err_omp_unexpected_directive : Error<
  "unexpected OpenMP directive %select{|'#pragma omp %1'}0"
  "\n" "错误：意外的 OpenMP 指令 %select{|'#pragma omp %1'}0">;
def err_omp_expected_punc : Error<
  "expected ',' or ')' in '%0' %select{clause|directive}1"
  "\n" "错误：'%0' %select{子句|指令}1中应有 ',' 或 ')'">;
def warn_clause_expected_string: Warning<
  "expected string %select{|literal }1in 'clause %0' - ignoring"
  "\n" "警告：'clause %0' 中应有字符串%select{|字面量}1 - 忽略">, InGroup<IgnoredPragmas>;
def err_omp_unexpected_clause : Error<
  "unexpected OpenMP clause '%0' in directive '#pragma omp %1'"
  "\n" "错误：指令 '#pragma omp %1' 中出现意外的 OpenMP 子句 '%0'">;
def err_omp_unexpected_clause_extension_only : Error<
  "OpenMP clause '%0' is only available as extension, use '-fopenmp-extensions'"
  "\n" "错误：OpenMP 子句 '%0' 仅作为扩展可用，请使用 '-fopenmp-extensions'">;
def err_omp_immediate_directive : Error<
  "'#pragma omp %0' %select{|with '%2' clause }1cannot be an immediate substatement"
  "\n" "错误：'#pragma omp %0' %select{|带有 '%2' 子句}1不能作为立即子语句">;
def err_omp_expected_identifier_for_critical : Error<
  "expected identifier specifying the name of the 'omp critical' directive"
  "\n" "错误：应为指定 'omp critical' 指令名称的标识符">;
def err_omp_expected_reduction_identifier : Error<
  "expected identifier or one of the following operators: '+', '-', '*', '&', '|', '^', '&&', or '||'"
  "\n" "错误：应为标识符或以下运算符之一：'+'、'-'、'*'、'&'、'|'、'^'、'&&' 或 '||'">;
def err_omp_expected_equal_in_iterator : Error<
  "expected '=' in iterator specifier"
  "\n" "错误：迭代器说明符中应有 '='">;
def err_omp_expected_punc_after_iterator : Error<
  "expected ',' or ')' after iterator specifier"
  "\n" "错误：迭代器说明符之后应有 ',' 或 ')'">;
def err_omp_decl_in_declare_simd_variant : Error<
  "function declaration is expected after 'declare %select{simd|variant}0' directive"
  "\n" "错误：'declare %select{simd|variant}0' 指令之后应有函数声明">;
def err_omp_sink_and_source_iteration_not_allowd: Error<" '%0 %select{sink:|source:}1' must be with '%select{omp_cur_iteration - 1|omp_cur_iteration}1'"
  "\n" "错误：'%0 %select{sink:|source:}1' 必须与 '%select{omp_cur_iteration - 1|omp_cur_iteration}1' 一起使用">;
def err_omp_unknown_map_type : Error<
  "incorrect map type, expected one of 'to', 'from', 'tofrom', 'alloc', 'release', or 'delete'"
  "\n" "错误：不正确的映射类型，应为 'to'、'from'、'tofrom'、'alloc'、'release' 或 'delete' 之一">;
def err_omp_more_one_map_type : Error<"map type is already specified"
  "\n" "错误：映射类型已指定">;
def note_previous_map_type_specified_here
    : Note<"map type '%0' is previous specified here"
      "\n" "提示：映射类型 '%0' 先前在此指定">;
def err_omp_unknown_map_type_modifier : Error<
  "incorrect map type modifier, expected one of: 'always', 'close', 'mapper'"
  "%select{|, 'present'|, 'present', 'iterator'}0%select{|, 'ompx_hold'}1%select{|, 'self'}2"
  "\n" "错误：不正确的映射类型修饰符，期望以下之一：'always'、'close'、'mapper'"
  "%select{|、'present'|、'present'、'iterator'}0%select{|、'ompx_hold'}1%select{|、'self'}2">;
def err_omp_map_type_missing : Error<
  "missing map type"
  "\n" "错误：缺少映射类型">;
def err_omp_map_type_modifier_missing : Error<
  "missing map type modifier"
  "\n" "错误：缺少映射类型修饰符">;
def err_omp_map_modifier_specification_list : Error<
  "empty modifier-specification-list is not allowed"
  "\n" "错误：不允许空的修饰符规范列表">;
def err_omp_declare_simd_inbranch_notinbranch : Error<
  "unexpected '%0' clause, '%1' is specified already"
  "\n" "错误：意外的 '%0' 子句，'%1' 已指定">;
def err_omp_expected_clause_argument
    : Error<"expected '%0' clause with an argument on '#pragma omp %1' "
            "construct"
            "\n" "错误：'#pragma omp %1' 结构中应有带参数的 '%0' 子句">;
def err_expected_end_declare_target_or_variant : Error<
  "expected '#pragma omp end declare %select{target|variant}0'"
  "\n" "错误：应为 '#pragma omp end declare %select{target|variant}0'">;
def err_expected_begin_declare_variant
    : Error<"'#pragma omp end declare variant' with no matching '#pragma omp "
            "begin declare variant'"
            "\n" "错误：'#pragma omp end declare variant' 没有匹配的 "
            "'#pragma omp begin declare variant'">;
def err_expected_begin_assumes
    : Error<"'#pragma omp end assumes' with no matching '#pragma omp begin assumes'"
            "\n" "错误：'#pragma omp end assumes' 没有匹配的 '#pragma omp begin assumes'">;
def warn_omp_unknown_assumption_clause_missing_id
    : Warning<"valid %0 clauses start with %1; %select{token|tokens}2 will be ignored"
      "\n" "警告：有效的 %0 子句以 %1 开头；%select{标记|多个标记}2将被忽略">,
      InGroup<OpenMPClauses>;
def warn_omp_unknown_assumption_clause_without_args
    : Warning<"%0 clause should not be followed by arguments; tokens will be ignored"
      "\n" "警告：%0 子句后面不应跟参数；标记将被忽略">,
      InGroup<OpenMPClauses>;
def note_omp_assumption_clause_continue_here
    : Note<"the ignored tokens spans until here"
      "\n" "提示：被忽略的标记延伸到此为止">;
def err_omp_declare_target_unexpected_clause: Error<
  "unexpected '%0' clause, only %select{'device_type'|'to' or 'link'|'to', 'link' or 'device_type'|'device_type', 'indirect'|'to', 'link', 'device_type' or 'indirect'}1 clauses expected"
  "\n" "错误：意外的 '%0' 子句，只应有 %select{'device_type'|'to' 或 'link'|'to'、'link' 或 'device_type'|'device_type'、'indirect'|'to'、'link'、'device_type' 或 'indirect'}1 子句">;
def err_omp_declare_target_unexpected_clause_52
    : Error<"unexpected '%0' clause, only %select{'device_type'|'enter' or "
            "'link'|'enter', 'link' or 'device_type'|'device_type', "
            "'indirect'|'enter', 'link', 'device_type' or 'indirect'|'enter', "
            "'link', 'device_type', 'indirect' or 'local'}1 clauses expected"
            "\n" "错误：意外的 '%0' 子句，只应有 %select{'device_type'|'enter' 或 "
            "'link'|'enter'、'link' 或 'device_type'|'device_type'、"
            "'indirect'|'enter'、'link'、'device_type' 或 'indirect'|'enter'、"
            "'link'、'device_type'、'indirect' 或 'local'}1 子句">;
def err_omp_begin_declare_target_unexpected_implicit_to_clause: Error<
  "unexpected '(', only 'to', 'link' or 'device_type' clauses expected for 'begin declare target' directive"
  "\n" "错误：意外的 '('，'begin declare target' 指令只应有 'to'、'link' 或 'device_type' 子句">;
def err_omp_declare_target_wrong_clause_after_implicit_to: Error<
  "unexpected clause after an implicit 'to' clause"
  "\n" "错误：隐式 'to' 子句之后出现意外子句">;
def err_omp_declare_target_wrong_clause_after_implicit_enter: Error<
  "unexpected clause after an implicit 'enter' clause"
  "\n" "错误：隐式 'enter' 子句之后出现意外子句">;
def err_omp_declare_target_missing_required_clause
    : Error<"expected at least one %select{'to' or 'link'|'to', 'link' or "
            "'indirect'|'enter', 'link' or 'indirect'|'enter', 'link', "
            "'indirect' or 'local'}0 clause"
            "\n" "错误：至少应有 %select{'to' 或 'link'|'to'、'link' 或 "
            "'indirect'|'enter'、'link' 或 'indirect'|'enter'、'link'、"
            "'indirect' 或 'local'}0 子句">;
def err_omp_declare_target_unexpected_to_clause: Error<
  "unexpected 'to' clause, use 'enter' instead"
  "\n" "错误：意外的 'to' 子句，请改用 'enter'">;
def err_omp_declare_target_unexpected_enter_clause: Error<
  "unexpected 'enter' clause, use 'to' instead"
  "\n" "错误：意外的 'enter' 子句，请改用 'to'">;
def err_omp_declare_target_multiple : Error<
  "%0 appears multiple times in clauses on the same declare target directive"
  "\n" "错误：%0 在同一个 declare target 指令的子句中多次出现">;
def err_omp_declare_target_indirect_device_type: Error<
  "only 'device_type(any)' clause is allowed with indirect clause"
  "\n" "错误：indirect 子句只允许使用 'device_type(any)' 子句">;
def warn_omp_deprecated_declare_target_delimited_form :
  Warning<"the delimited form of '#pragma omp declare target' without clauses is deprecated; use '#pragma omp begin declare target' instead"
  "\n" "警告：不带子句的 '#pragma omp declare target' 分隔形式已弃用；请改用 '#pragma omp begin declare target'">,
  InGroup<Deprecated>;
def err_omp_expected_clause: Error<
  "expected at least one clause on '#pragma omp %0' directive"
  "\n" "错误：'#pragma omp %0' 指令上至少应有子句">;
def err_omp_mapper_illegal_identifier : Error<
  "illegal OpenMP user-defined mapper identifier"
  "\n" "错误：非法的 OpenMP 用户定义映射器标识符">;
def err_omp_mapper_expected_declarator : Error<
  "expected declarator on 'omp declare mapper' directive"
  "\n" "错误：'omp declare mapper' 指令上应有声明符">;
def err_omp_unexpected_append_op : Error<
  "unexpected operation specified in 'append_args' clause, expected 'interop'"
  "\n" "错误：'append_args' 子句中指定了意外的操作，应为 'interop'">;
def err_omp_unexpected_execution_modifier : Error<
  "unexpected 'execution' modifier in non-executable context"
  "\n" "错误：不可执行上下文中出现意外的 'execution' 修饰符">;
def err_omp_unknown_adjust_args_op
    : Error<
          "incorrect 'adjust_args' type, expected 'need_device_ptr'%select{|, "
          "'need_device_addr',}0 or 'nothing'"
          "\n" "错误：不正确的 'adjust_args' 类型，应为 'need_device_ptr'"
          "%select{|、'need_device_addr'、}0 或 'nothing'">;
def err_omp_declare_variant_wrong_clause : Error<
  "expected %select{'match'|'match', 'adjust_args', or 'append_args'}0 clause "
  "on 'omp declare variant' directive"
  "\n" "错误：'omp declare variant' 指令上应有 %select{'match'|'match'、'adjust_args' 或 'append_args'}0 子句">;
def err_omp_non_by_ref_need_device_addr_modifier_argument
    : Error<"expected reference type argument on 'adjust_args' clause with "
            "'need_device_addr' modifier"
            "\n" "错误：带 'need_device_addr' 修饰符的 'adjust_args' 子句上应有引用类型参数">;
def err_omp_declare_variant_duplicate_nested_trait : Error<
  "nested OpenMP context selector contains duplicated trait '%0'"
  " in selector '%1' and set '%2' with different score"
  "\n" "错误：嵌套的 OpenMP 上下文选择器在选择器 '%1' 和集 '%2' 中"
  "包含分数不同的重复特性 '%0'">;
def err_omp_declare_variant_nested_user_condition : Error<
  "nested user conditions in OpenMP context selector not supported (yet)"
  "\n" "错误：OpenMP 上下文选择器中的嵌套用户条件（尚）不支持">;
def warn_omp_declare_variant_string_literal_or_identifier
    : Warning<"expected identifier or string literal describing a context "
              "%select{set|selector|property}0; "
              "%select{set|selector|property}0 skipped"
              "\n" "警告：应为描述上下文的标识符或字符串字面量"
              "%select{集|选择器|属性}0；"
              "%select{集|选择器|属性}0已跳过">,
      InGroup<OpenMPClauses>;
def warn_unknown_declare_variant_isa_trait
    : Warning<"isa trait '%0' is not known to the current target; verify the "
              "spelling or consider restricting the context selector with the "
              "'arch' selector further"
              "\n" "警告：当前目标不认识 isa 特性 '%0'；请检查拼写，"
              "或考虑用 'arch' 选择器进一步限制上下文选择器">,
      InGroup<SourceUsesOpenMP>;
def note_ompx_bare_clause : Note<
  "OpenMP extension clause '%0' only allowed with '#pragma omp %1'"
  "\n" "提示：OpenMP 扩展子句 '%0' 仅允许与 '#pragma omp %1' 一起使用">;
def note_omp_declare_variant_ctx_options
    : Note<"context %select{set|selector|property}0 options are: %1"
      "\n" "提示：上下文%select{集|选择器|属性}0选项是：%1">;
def warn_omp_declare_variant_expected
    : Warning<"expected '%0' after the %1; '%0' assumed"
      "\n" "警告：%1 之后应有 '%0'；假定为 '%0'">,
      InGroup<OpenMPClauses>;
def warn_omp_declare_variant_ctx_not_a_property
    : Warning<"'%0' is not a valid context property for the context selector "
              "'%1' and the context set '%2'; property ignored"
              "\n" "警告：'%0' 不是上下文选择器 '%1' 和上下文集 '%2' 的有效上下文属性；"
              "属性被忽略">,
      InGroup<OpenMPClauses>;
def note_omp_declare_variant_ctx_is_a
    : Note<"'%0' is a context %select{set|selector|property}1 not a context "
           "%select{set|selector|property}2"
           "\n" "提示：'%0' 是上下文%select{集|选择器|属性}1，不是上下文"
           "%select{集|选择器|属性}2">;
def note_omp_declare_variant_ctx_try : Note<"try 'match(%0={%1%2})'"
  "\n" "提示：请尝试 'match(%0={%1%2})'">;
def warn_omp_declare_variant_ctx_not_a_selector
    : Warning<"'%0' is not a valid context selector for the context set '%1'; "
              "selector ignored"
              "\n" "警告：'%0' 不是上下文集 '%1' 的有效上下文选择器；选择器被忽略">,
      InGroup<OpenMPClauses>;
def warn_omp_declare_variant_ctx_not_a_set
    : Warning<"'%0' is not a valid context set in a `declare variant`; set "
              "ignored"
              "\n" "警告：'%0' 不是 `declare variant` 中的有效上下文集；集被忽略">,
      InGroup<OpenMPClauses>;
def warn_omp_declare_variant_ctx_mutiple_use
    : Warning<"the context %select{set|selector|property}0 '%1' was used "
              "already in the same 'omp declare variant' directive; "
              "%select{set|selector|property}0 ignored"
              "\n" "警告：上下文%select{集|选择器|属性}0 '%1' 已在同一个 "
              "'omp declare variant' 指令中使用过；"
              "%select{集|选择器|属性}0已忽略">,
      InGroup<OpenMPClauses>;
def note_omp_declare_variant_ctx_used_here
    : Note<"the previous context %select{set|selector|property}0 '%1' used "
           "here"
           "\n" "提示：先前的上下文%select{集|选择器|属性}0 '%1' 在此使用">;
def note_omp_declare_variant_ctx_continue_here
    : Note<"the ignored %select{set|selector|property}0 spans until here"
           "\n" "提示：被忽略的%select{集|选择器|属性}0延伸到此为止">;
def warn_omp_ctx_incompatible_selector_for_set
    : Warning<"the context selector '%0' is not valid for the context set "
              "'%1'; selector ignored"
              "\n" "警告：上下文选择器 '%0' 对上下文集 '%1' 无效；选择器被忽略">,
      InGroup<OpenMPClauses>;
def note_omp_ctx_compatible_set_for_selector
    : Note<"the context selector '%0' can be nested in the context set '%1'; "
           "try 'match(%1={%0%select{|(property)}2})'"
           "\n" "提示：上下文选择器 '%0' 可以嵌套在上下文集 '%1' 中；"
           "请尝试 'match(%1={%0%select{|(property)}2})'">;
def warn_omp_ctx_selector_without_properties
    : Warning<"the context selector '%0' in context set '%1' requires a "
              "context property defined in parentheses; selector ignored"
              "\n" "警告：上下文集 '%1' 中的上下文选择器 '%0' 要求在括号中定义"
              "上下文属性；选择器被忽略">,
      InGroup<OpenMPClauses>;
def warn_omp_ctx_incompatible_property_for_selector
    : Warning<"the context property '%0' is not valid for the context selector "
              "'%1' and the context set '%2'; property ignored"
              "\n" "警告：上下文属性 '%0' 对上下文选择器 '%1' 和上下文集 '%2' 无效；"
              "属性被忽略">,
      InGroup<OpenMPClauses>;
def note_omp_ctx_compatible_set_and_selector_for_property
    : Note<"the context property '%0' can be nested in the context selector "
           "'%1' which is nested in the context set '%2'; try "
           "'match(%2={%1(%0)})'"
           "\n" "提示：上下文属性 '%0' 可以嵌套在上下文选择器 '%1' 中，"
           "后者嵌套在上下文集 '%2' 中；请尝试 'match(%2={%1(%0)})'">;
def warn_omp_ctx_incompatible_score_for_property
    : Warning<"the context selector '%0' in the context set '%1' cannot have a "
              "score (%quoted2); score ignored"
              "\n" "警告：上下文集 '%1' 中的上下文选择器 '%0' 不能有分数"
              "（%quoted2）；分数被忽略">,
      InGroup<OpenMPClauses>;
def warn_omp_more_one_device_type_clause
    : Warning<"more than one 'device_type' clause is specified"
      "\n" "警告：指定了多个 'device_type' 子句">,
      InGroup<OpenMPClauses>;
def err_omp_variant_ctx_second_match_extension : Error<
  "only a single match extension allowed per OpenMP context selector"
  "\n" "错误：每个 OpenMP 上下文选择器只允许一个 match 扩展">;
def err_omp_invalid_dsa: Error<
  "data-sharing attribute '%0' in '%1' clause requires OpenMP version %2 or above"
  "\n" "错误：'%1' 子句中的数据共享特性 '%0' 需要 OpenMP 版本 %2 或更高">;
def err_omp_expected_punc_after_interop_mod : Error<
  "expected ',' after interop modifier"
  "\n" "错误：interop 修饰符之后应有 ','">;
def err_omp_expected_interop_type : Error<
  "expected interop type: 'target' and/or 'targetsync'"
  "\n" "错误：应为 interop 类型：'target' 和/或 'targetsync'">;
def warn_omp_more_one_interop_type
  : Warning<"interop type '%0' cannot be specified more than once"
    "\n" "警告：interop 类型 '%0' 不能指定多次">,
    InGroup<OpenMPClauses>;
def err_omp_interop_multiple_fr : Error<
  "only one 'fr' selector allowed per preference-specification"
  "\n" "错误：每个偏好规范只允许一个 'fr' 选择器">;
def err_omp_prefer_type_brace_60 : Error<
  "brace-grouped 'prefer_type' argument requires OpenMP version 6.0 or later"
  "\n" "错误：花括号分组的 'prefer_type' 参数需要 OpenMP 版本 6.0 或更高">;
def err_omp_expected_fr_or_attr_selector : Error<
  "expected 'fr' or 'attr' selector in 'prefer_type'"
  "\n" "错误：'prefer_type' 中应有 'fr' 或 'attr' 选择器">;
def err_omp_expected_pref_spec : Error<
  "expected preference-specification in 'prefer_type'"
  "\n" "错误：'prefer_type' 中应有偏好规范">;
def err_expected_sequence_or_directive : Error<
  "expected an OpenMP 'directive' or 'sequence' attribute argument"
  "\n" "错误：应为 OpenMP 'directive' 或 'sequence' 特性参数">;
def ext_omp_attributes : ExtWarn<
  "specifying OpenMP directives with [[]] is an OpenMP 5.1 extension"
  "\n" "警告：使用 [[]] 指定 OpenMP 指令是 OpenMP 5.1 扩展">,
  InGroup<OpenMP51Ext>;
def warn_omp51_compat_attributes : Warning<
  "specifying OpenMP directives with [[]] is incompatible with OpenMP "
  "standards before OpenMP 5.1"
  "\n" "警告：使用 [[]] 指定 OpenMP 指令与 OpenMP 5.1 之前的 OpenMP 标准不兼容">,
  InGroup<OpenMPPre51Compat>, DefaultIgnore;
def err_omp_expected_colon : Error<"missing ':' in %0"
  "\n" "错误：%0 中缺少 ':'">;
def err_omp_missing_comma : Error< "missing ',' after %0"
  "\n" "错误：%0 之后缺少 ','">;
def err_omp_expected_context_selector
    : Error<"expected valid context selector in %0"
      "\n" "错误：%0 中应有有效的上下文选择器">;
def warn_omp_default_deprecated : Warning<"'default' clause for"
  " 'metadirective' is deprecated; use 'otherwise' instead"
  "\n" "警告：'metadirective' 的 'default' 子句已弃用；请改用 'otherwise'">, InGroup<Deprecated>;
def err_omp_requires_out_inout_depend_type : Error<
  "reserved locator 'omp_all_memory' requires 'out' or 'inout' "
  "dependency types"
  "\n" "错误：保留定位符 'omp_all_memory' 需要 'out' 或 'inout' 依赖类型">;
def warn_omp_more_one_omp_all_memory : Warning<
  "reserved locator 'omp_all_memory' cannot be specified more than once"
  "\n" "警告：保留定位符 'omp_all_memory' 不能指定多次">,
  InGroup<OpenMPClauses>;
def warn_omp_depend_in_ordered_deprecated : Warning<"'depend' clause for"
  " 'ordered' is deprecated; use 'doacross' instead"
  "\n" "警告：'ordered' 的 'depend' 子句已弃用；请改用 'doacross'">, InGroup<Deprecated>;
def warn_omp_invalid_attribute_for_ompx_attributes : Warning<"'ompx_attribute' clause only allows "
  "'amdgpu_flat_work_group_size', 'amdgpu_waves_per_eu', and 'launch_bounds'; "
  "%0 is ignored"
  "\n" "警告：'ompx_attribute' 子句只允许 "
  "'amdgpu_flat_work_group_size'、'amdgpu_waves_per_eu' 和 'launch_bounds'；"
  "%0 被忽略">, InGroup<OpenMPExtensions>;
def err_omp_duplicate_modifier : Error<"duplicate modifier '%0' in '%1' clause"
  "\n" "错误：'%1' 子句中有重复的修饰符 '%0'">;
def err_omp_expected_modifier : Error<"expected modifier in '%0' clause"
  "\n" "错误：'%0' 子句中应有修饰符">;
def err_omp_unknown_need_device_ptr_kind
    : Error<
        "invalid argument for 'need_device_ptr' kind in 'adjust_args' clause; "
        "expected 'fb_nullify' or 'fb_preserve'"
        "\n" "错误：'adjust_args' 子句中 'need_device_ptr' 类型的参数无效；"
        "应为 'fb_nullify' 或 'fb_preserve'">;

// Pragma loop support.
def err_pragma_loop_missing_argument : Error<
  "missing argument; expected %select{an integer value|"
  "'enable'%select{|, 'full'}1%select{|, 'assume_safety'}2 or 'disable'}0"
  "\n" "错误：缺少参数；应为 %select{一个整数值|"
  "'enable'%select{|、'full'}1%select{|、'assume_safety'}2 或 'disable'}0">;
def err_pragma_loop_invalid_option : Error<
  "%select{invalid|missing}0 option%select{ %1|}0; expected vectorize, "
  "vectorize_width, interleave, interleave_count, unroll, unroll_count, "
  "pipeline, pipeline_initiation_interval, vectorize_predicate, or distribute"
  "\n" "错误：%select{无效|缺失}0选项%select{ %1|}0；应为 vectorize、"
  "vectorize_width、interleave、interleave_count、unroll、unroll_count、"
  "pipeline、pipeline_initiation_interval、vectorize_predicate 或 distribute">;
def err_pragma_loop_invalid_vectorize_option : Error<
  "vectorize_width loop hint malformed; use vectorize_width(X, fixed) or "
  "vectorize_width(X, scalable) where X is an integer, or vectorize_width('fixed' or 'scalable')"
  "\n" "错误：vectorize_width 循环提示格式错误；请使用 vectorize_width(X, fixed) 或 "
  "vectorize_width(X, scalable)（X 为整数），或 vectorize_width('fixed' or 'scalable')">;
def note_pragma_loop_invalid_vectorize_option : Note<
  "vectorize_width loop hint malformed; use vectorize_width(X, fixed) or "
  "vectorize_width(X, scalable) where X is an integer, or vectorize_width('fixed' or 'scalable')"
  "\n" "提示：vectorize_width 循环提示格式错误；请使用 vectorize_width(X, fixed) 或 "
  "vectorize_width(X, scalable)（X 为整数），或 vectorize_width('fixed' or 'scalable')">;

def err_pragma_fp_invalid_option : Error<
  "%select{invalid|missing}0 option%select{ %1|}0; expected 'contract', 'reassociate', 'reciprocal', or 'exceptions'"
  "\n" "错误：%select{无效|缺失}0选项%select{ %1|}0；应为 'contract'、'reassociate'、'reciprocal' 或 'exceptions'">;
def err_pragma_fp_invalid_argument : Error<
  "unexpected argument '%0' to '#pragma clang fp %1'; expected "
  "%select{"
  "'fast' or 'on' or 'off'|"
  "'on' or 'off'|"
  "'on' or 'off'|"
  "'ignore', 'maytrap' or 'strict'|"
  "'source', 'double' or 'extended'}2"
  "\n" "错误：'#pragma clang fp %1' 的参数 '%0' 意外；应为 "
  "%select{"
  "'fast' 或 'on' 或 'off'|"
  "'on' 或 'off'|"
  "'on' 或 'off'|"
  "'ignore'、'maytrap' 或 'strict'|"
  "'source'、'double' 或 'extended'}2">;

def err_pragma_invalid_keyword : Error<
  "invalid argument; expected 'enable'%select{|, 'full'}0%select{|, 'assume_safety'}1 or 'disable'"
  "\n" "错误：无效参数；应为 'enable'%select{|、'full'}0%select{|、'assume_safety'}1 或 'disable'">;
def err_pragma_pipeline_invalid_keyword : Error<
    "invalid argument; expected 'disable'"
    "\n" "错误：无效参数；应为 'disable'">;

// API notes.
def err_type_unparsed : Error<"unparsed tokens following type"
  "\n" "错误：类型之后有未解析的标记">;

// Pragma unroll support.
def warn_pragma_unroll_cuda_value_in_parens : Warning<
  "argument to '#pragma unroll' should not be in parentheses in CUDA C/C++"
  "\n" "警告：CUDA C/C++ 中 '#pragma unroll' 的参数不应放在括号中">,
  InGroup<CudaCompat>;

def err_ptrauth_qualifier_bad_arg_count : Error<
  "'__ptrauth' qualifier must take between 1 and 3 arguments"
  "\n" "错误：'__ptrauth' 限定符必须接受 1 到 3 个参数">;

def warn_cuda_attr_lambda_position : Warning<
  "nvcc does not allow '__%0__' to appear after the parameter list in lambdas"
  "\n" "警告：nvcc 不允许 '__%0__' 出现在 lambda 中的参数列表之后">,
  InGroup<CudaCompat>;
def warn_pragma_force_cuda_host_device_bad_arg : Warning<
  "incorrect use of #pragma clang force_cuda_host_device begin|end"
  "\n" "警告：#pragma clang force_cuda_host_device begin|end 的使用不正确">,
  InGroup<IgnoredPragmas>;
def err_pragma_cannot_end_force_cuda_host_device : Error<
  "force_cuda_host_device end pragma without matching "
  "force_cuda_host_device begin"
  "\n" "错误：force_cuda_host_device end pragma 没有匹配的 "
  "force_cuda_host_device begin">;

def warn_ext_int_deprecated : Warning<
  "'_ExtInt' is deprecated; use '_BitInt' instead"
  "\n" "警告：'_ExtInt' 已弃用；请改用 '_BitInt'">, InGroup<DeprecatedType>;
def ext_bit_int : Extension<
  "'_BitInt' in %select{C17 and earlier|C++}0 is a Clang extension"
  "\n" "警告：'_BitInt' 在%select{C17 及更早版本|C++}0中是 Clang 扩展">,
  InGroup<BitIntExtension>;
} // end of Parse Issue category.

let CategoryName = "Modules Issue" in {
def err_unexpected_module_or_import_decl : Error<
  "%select{module|import}0 declaration can only appear at the top level"
  "\n" "错误：%select{module|import}0声明只能出现在顶层">;
def err_attribute_not_module_attr : Error<
  "%0 attribute cannot be applied to a module"
  "\n" "错误：%0 特性不能应用于模块">;
def err_keyword_not_module_attr : Error<
  "%0 cannot be applied to a module"
  "\n" "错误：%0 不能应用于模块">;
def err_attribute_not_import_attr : Error<
  "%0 attribute cannot be applied to a module import"
  "\n" "错误：%0 特性不能应用于模块导入">;
def err_keyword_not_import_attr : Error<
  "%0 cannot be applied to a module import"
  "\n" "错误：%0 不能应用于模块导入">;
def err_module_expected_semi : Error<
  "expected ';' after module name"
  "\n" "错误：模块名之后应有 ';'">;
def err_expected_semi_after_module_or_import
  : Error<"%0 directive must end with a ';'"
    "\n" "错误：%0 指令必须以 ';' 结尾">;
def note_module_declared_here : Note<
  "%select{module|import}0 directive defined here"
  "\n" "提示：%select{module|import}0指令在此定义">;
def err_global_module_introducer_not_at_start : Error<
  "'module;' introducing a global module fragment can appear only "
  "at the start of the translation unit"
  "\n" "错误：引入全局模块片段的 'module;' 只能出现在"
  "翻译单元的开头">;
def err_module_fragment_exported : Error<
  "%select{global|private}0 module fragment cannot be exported"
  "\n" "错误：%select{全局|私有}0模块片段不能被导出">;
def err_private_module_fragment_expected_semi : Error<
  "expected ';' after private module fragment declaration"
  "\n" "错误：私有模块片段声明之后应有 ';'">;
def err_missing_before_module_end : Error<"expected %0 at end of module"
  "\n" "错误：模块末尾应有 %0">;
def err_unsupported_module_partition : Error<
  "module partitions are only supported for C++20 onwards"
  "\n" "错误：模块分区仅从 C++20 开始受支持">;
def err_import_not_allowed_here : Error<
  "imports must immediately follow the module declaration"
  "\n" "错误：导入必须紧跟模块声明">;
def err_partition_import_outside_module : Error<
  "module partition imports must be within a module purview"
  "\n" "错误：模块分区导入必须位于模块作用范围内">;
def err_import_in_wrong_fragment : Error<
  "module%select{| partition}0 imports cannot be in the %select{global|private}1 module fragment"
  "\n" "错误：模块%select{| 分区}0导入不能出现在%select{全局|私有}1模块片段中">;

def err_export_empty : Error<"export declaration cannot be empty"
  "\n" "错误：导出声明不能为空">;
}

let CategoryName = "Generics Issue" in {

def err_objc_expected_type_parameter : Error<
  "expected type parameter name"
  "\n" "错误：应为类型参数名">;

def err_objc_parameterized_implementation : Error<
  "@implementation cannot have type parameters"
  "\n" "错误：@implementation 不能有类型参数">;

def err_objc_type_args_after_protocols : Error<
  "protocol qualifiers must precede type arguments"
  "\n" "错误：协议限定符必须位于类型参数之前">;

def note_meant_to_use_typename : Note<
  "did you mean to use 'typename'?"
  "\n" "提示：您是指使用 'typename' 吗？">;
}

let CategoryName = "Coroutines Issue" in {
def err_for_co_await_not_range_for : Error<
  "'co_await' modifier can only be applied to range-based for loop"
  "\n" "错误：'co_await' 修饰符只能应用于基于范围的 for 循环">;
def warn_deprecated_for_co_await : Warning<
  "'for co_await' belongs to CoroutineTS instead of C++20, which is deprecated"
  "\n" "警告：'for co_await' 属于 CoroutineTS 而不是 C++20，这已弃用">,
  InGroup<DeprecatedCoroutine>;
}

let CategoryName = "Concepts Issue" in {
def err_concept_definition_not_identifier : Error<
  "name defined in concept definition must be an identifier"
  "\n" "错误：在概念定义中定义的名称必须是标识符">;
def err_concept_legacy_bool_keyword : Error<
  "ISO C++ does not permit the 'bool' keyword after 'concept'"
  "\n" "错误：ISO C++ 不允许 'concept' 之后使用 'bool' 关键字">;
def err_placeholder_expected_auto_or_decltype_auto : Error<
  "expected 'auto' or 'decltype(auto)' after concept name"
  "\n" "错误：概念名之后应有 'auto' 或 'decltype(auto)'">;
}

let CategoryName = "Reflection Diagnostics" in {
def err_cannot_reflect_operand : Error<
  "unknown or unimplemented reflectable entity"
  "\n" "错误：未知或未实现的可反射实体">;
}

def warn_max_tokens : Warning<
  "the number of preprocessor source tokens (%0) exceeds this token limit (%1)"
  "\n" "警告：预处理器源标记数 (%0) 超过此标记限制 (%1)">,
  InGroup<MaxTokens>, DefaultIgnore;

def warn_max_tokens_total : Warning<
  "the total number of preprocessor source tokens (%0) exceeds the token limit (%1)"
  "\n" "警告：预处理器源标记总数 (%0) 超过标记限制 (%1)">,
  InGroup<MaxTokens>, DefaultIgnore;

def note_max_tokens_total_override : Note<"total token limit set here"
  "\n" "提示：总标记限制在此设置">;

// HLSL Parser Diagnostics

def err_expected_semantic_identifier : Error<
  "expected HLSL Semantic identifier"
  "\n" "错误：应为 HLSL 语义标识符">;
def err_invalid_declaration_in_hlsl_buffer
    : Error<"invalid declaration inside %select{tbuffer|cbuffer}0"
      "\n" "错误：%select{tbuffer|cbuffer}0内部有无效声明">;
def err_hlsl_separate_attr_arg_and_number : Error<"wrong argument format for hlsl attribute, use %0 instead"
  "\n" "错误：hlsl 特性的参数格式错误，请改用 %0">;
def ext_hlsl_access_specifiers : ExtWarn<
  "access specifiers are a clang HLSL extension"
  "\n" "警告：访问说明符是 clang HLSL 扩展">,
  InGroup<HLSLExtension>;
def err_hlsl_unsupported_component : Error<"invalid component '%0' used; expected 'x', 'y', 'z', or 'w'"
  "\n" "错误：使用了无效的分量 '%0'；应为 'x'、'y'、'z' 或 'w'">;
def err_hlsl_packoffset_invalid_reg : Error<"invalid resource class specifier '%0' for packoffset, expected 'c'"
  "\n" "错误：packoffset 的资源类说明符 '%0' 无效，应为 'c'">;
def err_hlsl_virtual_function
    : Error<"virtual functions are unsupported in HLSL"
      "\n" "错误：HLSL 中不支持虚函数">;
def err_hlsl_virtual_inheritance
    : Error<"virtual inheritance is unsupported in HLSL"
      "\n" "错误：HLSL 中不支持虚拟继承">;

// HLSL Root Signature Parser Diagnostics
def err_hlsl_invalid_token : Error<"invalid %select{parameter|value}0 of %1"
  "\n" "错误：%1 的%select{参数|值}0无效">;
def err_hlsl_rootsig_repeat_param : Error<"specified the same parameter '%0' multiple times"
  "\n" "错误：多次指定了相同的参数 '%0'">;
def err_hlsl_rootsig_missing_param : Error<"did not specify mandatory parameter '%0'"
  "\n" "错误：未指定必需参数 '%0'">;
def err_hlsl_number_literal_overflow : Error<
  "%select{integer|float}0 literal is too large to be represented as a "
  "%select{32-bit %select{signed|}1 integer|float}0 type"
  "\n" "错误：%select{整数|浮点}0字面量太大，无法表示为 "
  "%select{32 位 %select{有符号|}1 整数|浮点}0类型">;
def err_hlsl_number_literal_underflow : Error<
  "float literal has a magnitude that is too small to be represented as a float type"
  "\n" "错误：浮点字面量的数量级太小，无法表示为 float 类型">;
def err_hlsl_rootsig_non_zero_flag : Error<"flag value is neither a literal 0 nor a named value"
  "\n" "错误：标志值既不是字面量 0 也不是命名值">;

} // end of Parser diagnostics
