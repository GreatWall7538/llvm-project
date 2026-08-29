//==--- DiagnosticCommentKinds.td - diagnostics related to comments -------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

let Component = "Comment" in {
let CategoryName = "Documentation Issue" in {

// HTML parsing errors.  These are under -Wdocumentation to make sure the user
// knows that we didn't parse something as they might expect.

def warn_doc_html_start_tag_expected_quoted_string : Warning<
  "expected quoted string after equals sign"
  "\n" "警告：等号后应为带引号的字符串">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_html_start_tag_expected_ident_or_greater : Warning<
  "HTML start tag prematurely ended, expected attribute name or '>'"
  "\n" "警告：HTML 开始标签过早结束，应为属性名或 '>'">,
  InGroup<Documentation>, DefaultIgnore;

def note_doc_html_tag_started_here : Note<
  "HTML tag started here"
  "\n" "提示：HTML 标签在此处开始">;

// HTML semantic errors

def warn_doc_html_end_forbidden : Warning<
  "HTML end tag '%0' is forbidden"
  "\n" "警告：HTML 结束标签 '%0' 是被禁止的">,
  InGroup<DocumentationHTML>, DefaultIgnore;

def warn_doc_html_end_unbalanced : Warning<
  "HTML end tag does not match any start tag"
  "\n" "警告：HTML 结束标签与任何开始标签都不匹配">,
  InGroup<DocumentationHTML>, DefaultIgnore;

def warn_doc_html_start_end_mismatch : Warning<
  "HTML start tag '%0' closed by '%1'"
  "\n" "警告：HTML 开始标签 '%0' 被 '%1' 闭合">,
  InGroup<DocumentationHTML>, DefaultIgnore;

def note_doc_html_end_tag : Note<
  "end tag"
  "\n" "提示：结束标签">;

def warn_doc_html_missing_end_tag : Warning<
  "HTML tag '%0' requires an end tag"
  "\n" "警告：HTML 标签 '%0' 需要结束标签">,
  InGroup<DocumentationHTML>, DefaultIgnore;

// Commands

def warn_doc_block_command_empty_paragraph : Warning<
  "empty paragraph passed to '%select{\\|@}0%1' command"
  "\n" "警告：将空段落传递给了 '%select{\\|@}0%1' 命令">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_block_command_duplicate : Warning<
  "duplicated command '%select{\\|@}0%1'"
  "\n" "警告：重复的命令 '%select{\\|@}0%1'">,
  InGroup<Documentation>, DefaultIgnore;

def note_doc_block_command_previous : Note<
  "previous command '%select{\\|@}0%1' here"
  "\n" "提示：先前的命令 '%select{\\|@}0%1' 在此处">;

def note_doc_block_command_previous_alias : Note<
  "previous command '%select{\\|@}0%1' (an alias of '\\%2') here"
  "\n" "提示：先前的命令 '%select{\\|@}0%1'（'\\%2' 的别名）在此处">;

// \param command

def warn_doc_param_invalid_direction : Warning<
  "unrecognized parameter passing direction, "
  "valid directions are '[in]', '[out]' and '[in,out]'"
  "\n" "警告：无法识别的参数传递方向，有效的方向为 '[in]'、'[out]' 和 '[in,out]'">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_param_spaces_in_direction : Warning<
  "whitespace is not allowed in parameter passing direction"
  "\n" "警告：参数传递方向中不允许出现空白">,
  InGroup<DocumentationPedantic>, DefaultIgnore;

def warn_doc_param_not_attached_to_a_function_decl : Warning<
  "'%select{\\|@}0param' command used in a comment that is not attached to "
  "a function declaration"
  "\n" "警告：'%select{\\|@}0param' 命令用在未附加到函数声明的注释中">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_function_method_decl_mismatch : Warning<
  "'%select{\\|@}0%enum_select<CallableKind>{"
  "%Function{function}|%FunctionGroup{functiongroup}|"
  "%Method{method}|%MethodGroup{methodgroup}|%Callback{callback}}1' "
  "command should be used in a comment attached to "
  "%select{a function|a function|an Objective-C method|an Objective-C method|"
  "a pointer to function}2 declaration"
  "\n" "警告：'%select{\\|@}0%enum_select<CallableKind>{"
  "%Function{函数}|%FunctionGroup{函数组}|"
  "%Method{方法}|%MethodGroup{方法组}|%Callback{回调}}1' "
  "命令应使用在附加到%select{函数|函数|Objective-C 方法|Objective-C 方法|"
  "指向函数的指针}2声明的注释中">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_api_container_decl_mismatch : Warning<
  "'%select{\\|@}0%enum_select<DeclContainerKind>{%Class{class}"
  "|%Interface{interface}|%Protocol{protocol}|%Struct{struct}|%Union{union}}1' "
  "command should not be used in a comment attached to a "
  "non-%select{class|interface|protocol|struct|union}2 declaration"
  "\n" "警告：'%select{\\|@}0%enum_select<DeclContainerKind>{%Class{类}"
  "|%Interface{接口}|%Protocol{协议}|%Struct{结构}|%Union{联合}}1' "
  "命令不应当使用在附加到非%select{类|接口|协议|结构|联合}2声明的注释中">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_container_decl_mismatch : Warning<
  "'%select{\\|@}0%enum_select<DocCommandKind>{%ClassDesign{classdesign}|"
  "%CoClass{coclass}|%Dependency{dependency}|%Helper{helper}|%HelperClass{helperclass}|"
  "%Helps{helps}|%InstanceSize{instancesize}|%Ownership{ownership}|"
  "%Performance{performance}|%Security{security}|%Superclass{superclass}}1' "
  "command should not be used in a comment attached to a non-container declaration"
  "\n" "警告：'%select{\\|@}0%enum_select<DocCommandKind>{%ClassDesign{类设计}|"
  "%CoClass{组件类}|%Dependency{依赖}|%Helper{辅助}|%HelperClass{辅助类}|"
  "%Helps{帮助}|%InstanceSize{实例大小}|%Ownership{所有权}|"
  "%Performance{性能}|%Security{安全}|%Superclass{父类}}1' "
  "命令不应当使用在附加到非容器声明的注释中">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_param_duplicate : Warning<
  "parameter '%0' is already documented"
  "\n" "警告：参数 '%0' 已被记录">,
  InGroup<Documentation>, DefaultIgnore;

def note_doc_param_previous : Note<
  "previous documentation"
  "\n" "提示：先前的文档">;

def warn_doc_param_not_found : Warning<
  "parameter '%0' not found in the function declaration"
  "\n" "警告：在函数声明中找不到参数 '%0'">,
  InGroup<Documentation>, DefaultIgnore;

def note_doc_param_name_suggestion : Note<
  "did you mean '%0'?"
  "\n" "提示：您是指 '%0' 吗？">;

// tparam command

def warn_doc_tparam_not_attached_to_a_template_decl : Warning<
  "'%select{\\|@}0tparam' command used in a comment that is not attached to "
  "a template declaration"
  "\n" "警告：'%select{\\|@}0tparam' 命令用在未附加到模板声明的注释中">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_tparam_duplicate : Warning<
  "template parameter '%0' is already documented"
  "\n" "警告：模板参数 '%0' 已被记录">,
  InGroup<Documentation>, DefaultIgnore;

def note_doc_tparam_previous : Note<
  "previous documentation"
  "\n" "提示：先前的文档">;

def warn_doc_tparam_not_found : Warning<
  "template parameter '%0' not found in the template declaration"
  "\n" "警告：在模板声明中找不到模板参数 '%0'">,
  InGroup<Documentation>, DefaultIgnore;

def note_doc_tparam_name_suggestion : Note<
  "did you mean '%0'?"
  "\n" "提示：您是指 '%0' 吗？">;

// \returns command

def warn_doc_returns_not_attached_to_a_function_decl : Warning<
  "'%select{\\|@}0%1' command used in a comment that is not attached to "
  "a function or method declaration"
  "\n" "警告：'%select{\\|@}0%1' 命令用在未附加到函数或方法声明的注释中">,
  InGroup<Documentation>, DefaultIgnore;

def warn_doc_returns_attached_to_a_void_function : Warning<
  "'%select{\\|@}0%1' command used in a comment that is attached to a "
  "%select{function returning void|constructor|destructor|"
  "method returning void}2"
  "\n" "警告：'%select{\\|@}0%1' 命令用在附加到%select{返回 void 的函数|构造函数|析构函数|"
  "返回 void 的方法}2的注释中">,
  InGroup<Documentation>, DefaultIgnore;

// \deprecated command

def warn_doc_deprecated_not_sync : Warning<
  "declaration is marked with '%select{\\|@}0deprecated' command but does "
  "not have a deprecation attribute"
  "\n" "警告：声明使用 '%select{\\|@}0deprecated' 命令进行了标记，但没有弃用特性">,
  InGroup<DocumentationDeprecatedSync>, DefaultIgnore;

def note_add_deprecation_attr : Note<
  "add a deprecation attribute to the declaration to silence this warning"
  "\n" "提示：为声明添加弃用特性以消除此警告">;

// inline contents commands

def warn_doc_inline_command_not_enough_arguments : Warning<
  "'%select{\\|@}0%1' command has %plural{0:no|:%2}2 word argument%s2, expected %3"
  "\n" "警告：'%select{\\|@}0%1' 命令有 %plural{0:无|:%2}2 个单词参数%s2，应为 %3">,
  InGroup<Documentation>, DefaultIgnore;

// verbatim block commands

def warn_verbatim_block_end_without_start : Warning<
  "'%select{\\|@}0%1' command does not terminate a verbatim text block"
  "\n" "警告：'%select{\\|@}0%1' 命令不终止逐字文本块">,
  InGroup<Documentation>, DefaultIgnore;

def warn_unknown_comment_command_name : Warning<
  "unknown command tag name"
  "\n" "警告：未知的命令标签名称">,
  InGroup<DocumentationUnknownCommand>, DefaultIgnore;

def warn_correct_comment_command_name : Warning<
  "unknown command tag name '%0'; did you mean '%1'?"
  "\n" "警告：未知的命令标签名称 '%0'；您是指 '%1' 吗？">,
  InGroup<DocumentationUnknownCommand>, DefaultIgnore;

} // end of documentation issue category
} // end of AST component
