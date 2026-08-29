//==--- DiagnosticFrontendKinds.td - frontend diagnostics -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

class BackendInfo : CatBackend, ShowInSystemHeader;

let Component = "Frontend" in {

def err_fe_error_opening : Error<"error opening '%0': %1"
  "\n" "错误：打开 '%0' 时出错：%1">;
def err_fe_error_reading : Error<"error reading '%0': %1"
  "\n" "错误：读取 '%0' 时出错：%1">;
def err_fe_error_reading_stdin : Error<"error reading stdin: %0"
  "\n" "错误：读取标准输入时出错：%0">;
def err_fe_error_backend : Error<"error in backend: %0"
  "\n" "错误：后端出错：%0">, DefaultFatal;

def err_fe_inline_asm : Error<"%0"
  "\n" "错误：%0">, CatInlineAsm;
def warn_fe_inline_asm : Warning<"%0"
  "\n" "警告：%0">, CatInlineAsm, InGroup<BackendInlineAsm>;
def note_fe_inline_asm : Note<"%0"
  "\n" "提示：%0">, CatInlineAsm;
def note_fe_inline_asm_here : Note<"instantiated into assembly here"
  "\n" "提示：在此处实例化到汇编中">;
def err_fe_source_mgr : Error<"%0"
  "\n" "错误：%0">, CatSourceMgr;
def warn_fe_source_mgr : Warning<"%0"
  "\n" "警告：%0">, CatSourceMgr, InGroup<BackendSourceMgr>;
def note_fe_source_mgr : Note<"%0"
  "\n" "提示：%0">, CatSourceMgr;
def err_fe_linking_module : Error<"cannot link module '%0': %1"
  "\n" "错误：无法链接模块 '%0'：%1">, DefaultFatal;
def warn_fe_linking_module : Warning<"linking module '%0': %1"
  "\n" "警告：正在链接模块 '%0'：%1">, InGroup<LinkerWarnings>;
def note_fe_linking_module : Note<"linking module '%0': %1"
  "\n" "提示：正在链接模块 '%0'：%1">;

def warn_fe_frame_larger_than : Warning<"stack frame size (%0) exceeds limit (%1) in '%2'"
  "\n" "警告：'%2' 中的栈帧大小 (%0) 超过限制 (%1)">,
    BackendInfo, InGroup<BackendFrameLargerThan>;
def warn_fe_backend_frame_larger_than: Warning<"%0"
  "\n" "警告：%0">,
    BackendInfo, InGroup<BackendFrameLargerThan>;
def err_fe_backend_frame_larger_than: Error<"%0"
  "\n" "错误：%0">, BackendInfo;
def note_fe_backend_frame_larger_than: Note<"%0"
  "\n" "提示：%0">, BackendInfo;

def warn_fe_backend_plugin: Warning<"%0"
  "\n" "警告：%0">, BackendInfo, InGroup<BackendPlugin>;
def err_fe_backend_plugin: Error<"%0"
  "\n" "错误：%0">, BackendInfo;

def warn_fe_backend_resource_limit: Warning<"%0 (%1) exceeds limit (%2) in '%3'"
  "\n" "警告：'%3' 中的 %0 (%1) 超过限制 (%2)">, BackendInfo, InGroup<BackendPlugin>;
def err_fe_backend_resource_limit: Error<"%0 (%1) exceeds limit (%2) in '%3'"
  "\n" "错误：'%3' 中的 %0 (%1) 超过限制 (%2)">, BackendInfo;
def note_fe_backend_resource_limit: Note<"%0 (%1) exceeds limit (%2) in '%3'"
  "\n" "提示：'%3' 中的 %0 (%1) 超过限制 (%2)">, BackendInfo;

def remark_fe_backend_plugin: Remark<"%0"
  "\n" "备注：%0">, BackendInfo, InGroup<RemarkBackendPlugin>;
def note_fe_backend_plugin: Note<"%0"
  "\n" "提示：%0">, BackendInfo;

def err_target_spirv_requires_vulkan : Error<
    "SPIR-V target requires a Vulkan environment"
    "\n" "错误：SPIR-V 目标需要 Vulkan 环境">;
def err_target_spirv_invalid_shader_stage : Error<
    "SPIR-V target requires a valid shader stage or no environment"
    "\n" "错误：SPIR-V 目标需要有效的着色器阶段或不需要环境">;

def warn_fe_override_module : Warning<
    "overriding the module target triple with %0"
    "\n" "警告：用 %0 覆盖模块的目标三元组">,
    InGroup<DiagGroup<"override-module">>;
def warn_fe_backend_unsupported_fp_rounding : Warning<
    "overriding currently unsupported rounding mode on this target"
    "\n" "警告：覆盖此目标当前不支持的舍入模式">,
    InGroup<UnsupportedFPOpt>;
def warn_fe_backend_unsupported_fp_exceptions : Warning<
    "overriding currently unsupported use of floating point exceptions "
    "on this target"
    "\n" "警告：覆盖此目标当前不支持的浮点异常使用">, InGroup<UnsupportedFPOpt>;
def warn_fe_backend_invalid_feature_flag : Warning<
    "feature flag '%0' must start with either '+' to enable the feature or '-'"
    " to disable it; flag ignored"
    "\n" "警告：特性标志 '%0' 必须以 '+'（启用该特性）或 '-'（禁用该特性）开头；该标志被忽略">, InGroup<InvalidCommandLineArgument>;
def warn_fe_backend_readonly_feature_flag : Warning<
    "feature flag '%0' is ignored since the feature is read only"
    "\n" "警告：特性标志 '%0' 被忽略，因为该特性是只读的">,
    InGroup<InvalidCommandLineArgument>;

def err_incompatible_fp_eval_method_options : Error<
    "option 'ffp-eval-method' cannot be used with option "
    "%select{'fapprox-func'|'mreassociate'|'freciprocal'}0"
    "\n" "错误：选项 'ffp-eval-method' 不能与选项 "
    "%select{'fapprox-func'|'mreassociate'|'freciprocal'}0 一起使用">;

def remark_fe_backend_optimization_remark : Remark<"%0"
  "\n" "备注：%0">, BackendInfo,
    InGroup<BackendOptimizationRemark>;
def remark_fe_backend_optimization_remark_missed : Remark<"%0"
  "\n" "备注：%0">, BackendInfo,
    InGroup<BackendOptimizationRemarkMissed>;
def remark_fe_backend_optimization_remark_analysis : Remark<"%0"
  "\n" "备注：%0">, BackendInfo,
    InGroup<BackendOptimizationRemarkAnalysis>;
def remark_fe_backend_optimization_remark_analysis_fpcommute : Remark<"%0; "
    "allow reordering by specifying '#pragma clang loop vectorize(enable)' "
    "before the loop or by providing the compiler option '-ffast-math'"
    "\n" "备注：%0；通过在循环前指定 '#pragma clang loop vectorize(enable)' "
    "或提供编译器选项 '-ffast-math' 来允许重新排序">,
    BackendInfo, InGroup<BackendOptimizationRemarkAnalysis>;
def remark_fe_backend_optimization_remark_analysis_aliasing : Remark<"%0; "
    "allow reordering by specifying '#pragma clang loop vectorize(enable)' "
    "before the loop; if the arrays will always be independent, specify "
    "'#pragma clang loop vectorize(assume_safety)' before the loop or provide "
    "the '__restrict__' qualifier with the independent array arguments -- "
    "erroneous results will occur if these options are incorrectly applied"
    "\n" "备注：%0；通过在循环前指定 '#pragma clang loop vectorize(enable)' "
    "来允许重新排序；如果数组始终相互独立，请在循环前指定 "
    "'#pragma clang loop vectorize(assume_safety)' 或为独立的数组实参提供 "
    "'__restrict__' 限定符——如果这些选项应用不当，将产生错误结果">,
    BackendInfo, InGroup<BackendOptimizationRemarkAnalysis>;

def warn_fe_backend_optimization_failure : Warning<"%0"
  "\n" "警告：%0">, BackendInfo,
    InGroup<BackendOptimizationFailure>, DefaultWarn;
def note_fe_backend_invalid_loc : Note<"could "
  "not determine the original source location for %0:%1:%2"
  "\n" "提示：无法确定 %0:%1:%2 的原始源位置">, BackendInfo;

def err_fe_backend_unsupported : Error<"%0"
  "\n" "错误：%0">, BackendInfo;
def warn_fe_backend_unsupported : Warning<"%0"
  "\n" "警告：%0">, BackendInfo;

def err_fe_backend_error_attr :
  Error<"call to '%0' declared with 'error' attribute: %1"
  "\n" "错误：对 '%0' 的调用声明了 'error' 特性：%1">, BackendInfo;
def warn_fe_backend_warning_attr :
  Warning<"call to '%0' declared with 'warning' attribute: %1"
  "\n" "警告：对 '%0' 的调用声明了 'warning' 特性：%1">, BackendInfo,
  InGroup<BackendWarningAttributes>;
def note_fe_backend_in : Note<"called by function '%0'"
  "\n" "提示：由函数 '%0' 调用">, BackendInfo;
def note_fe_backend_inlined : Note<"inlined by function '%0'"
  "\n" "提示：由函数 '%0' 内联">, BackendInfo;
def note_fe_backend_inlining_debug_info
    : Note<"use '-gline-directives-only' (implied by '-g1') or higher for "
           "more accurate inlining chain locations"
           "\n" "提示：使用 '-gline-directives-only'（由 '-g1' 隐含）或更高版本以获得更准确的内联链位置">,
      BackendInfo;
def warn_toc_unsupported_type : Warning<"-mtocdata option is ignored "
  "for %0 because %1"
  "\n" "警告：-mtocdata 选项对 %0 被忽略，因为 %1">, InGroup<BackendWarningAttributes>;

def err_fe_invalid_code_complete_file : Error<
    "cannot locate code-completion file %0"
    "\n" "错误：无法定位代码补全文件 %0">, DefaultFatal;
def err_fe_dependency_file_requires_MT : Error<
    "-dependency-file requires at least one -MT or -MQ option"
    "\n" "错误：-dependency-file 至少需要一个 -MT 或 -MQ 选项">;
def err_fe_invalid_plugin_name : Error<
    "unable to find plugin '%0'"
    "\n" "错误：找不到插件 '%0'">;
def err_fe_expected_compiler_job : Error<
    "unable to handle compilation, expected exactly one compiler job in '%0'"
    "\n" "错误：无法处理编译，在 '%0' 中应恰好有一个编译器作业">;
def err_fe_expected_clang_command : Error<
    "expected a clang compiler command"
    "\n" "错误：应有一个 clang 编译器命令">;
def err_fe_remap_missing_to_file : Error<
    "could not remap file '%0' to the contents of file '%1'"
    "\n" "错误：无法将文件 '%0' 重新映射到文件 '%1' 的内容">, DefaultFatal;
def err_fe_unable_to_load_ast_file : Error<"unable to load precompiled file"
  "\n" "错误：无法加载预编译文件">;
def err_fe_unable_to_load_plugin : Error<
    "unable to load plugin '%0': '%1'"
    "\n" "错误：无法加载插件 '%0'：'%1'">;
def err_fe_unable_to_create_target : Error<
    "unable to create target: '%0'"
    "\n" "错误：无法创建目标：'%0'">;
def err_fe_unable_to_create_subtarget : Error<
    "unable to create subtarget: '%0'%select{ with features '%2'|}1"
    "\n" "错误：无法创建子目标：'%0'%select{ 使用特性 '%2'|}1">;
def err_fe_unable_to_interface_with_target : Error<
    "unable to interface with target machine"
    "\n" "错误：无法与目标机器交互">;
def err_fe_unable_to_open_output : Error<
    "unable to open output file '%0': '%1'"
    "\n" "错误：无法打开输出文件 '%0'：'%1'">;
def warn_fe_macro_contains_embedded_newline : Warning<
    "macro '%0' contains embedded newline; text after the newline is ignored"
    "\n" "警告：宏 '%0' 包含嵌入的换行符；换行符之后的文本被忽略">;
def warn_fe_cc_print_header_failure : Warning<
    "unable to open CC_PRINT_HEADERS file: %0 (using stderr)"
    "\n" "警告：无法打开 CC_PRINT_HEADERS 文件：%0（使用 stderr）">;
def warn_fe_cc_log_diagnostics_failure : Warning<
    "unable to open CC_LOG_DIAGNOSTICS file: %0 (using stderr)"
    "\n" "警告：无法打开 CC_LOG_DIAGNOSTICS 文件：%0（使用 stderr）">;
def warn_fe_unable_to_open_stats_file : Warning<
    "unable to open statistics output file '%0': '%1'"
    "\n" "警告：无法打开统计输出文件 '%0'：'%1'">,
    InGroup<DiagGroup<"unable-to-open-stats-file">>;
def err_fe_no_pch_in_dir : Error<
    "no suitable precompiled header file found in directory '%0'"
    "\n" "错误：在目录 '%0' 中找不到合适的预编译头文件">;
def err_fe_action_not_available : Error<
    "action %0 not compiled in"
    "\n" "错误：操作 %0 未编译进">;
def err_fe_cir_not_built : Error<"clang IR support not available, rebuild "
                                 "clang with -DCLANG_ENABLE_CIR=ON"
                                 "\n" "错误：clang IR 支持不可用，请使用 "
                                 "-DCLANG_ENABLE_CIR=ON 重新构建 clang">;
def err_fe_invalid_multiple_actions : Error<
    "'%0' action ignored; '%1' action specified previously"
    "\n" "错误：'%0' 操作被忽略；先前指定了 '%1' 操作">;
def err_fe_invalid_alignment : Error<
    "invalid value '%1' in '%0'; alignment must be a power of 2"
    "\n" "错误：'%0' 中的值 '%1' 无效；对齐必须是 2 的幂">;
def err_fe_invalid_exception_model
   : Error<"invalid exception model '%select{none|sjlj|seh|dwarf|wasm}0' for target '%1'"
   "\n" "错误：目标 '%1' 的异常模型 '%select{无|sjlj|seh|dwarf|wasm}0' 无效">;
def err_fe_invalid_source_date_epoch : Error<
    "environment variable 'SOURCE_DATE_EPOCH' ('%0') must be a non-negative decimal integer <= %1"
    "\n" "错误：环境变量 'SOURCE_DATE_EPOCH'（'%0'）必须是非负十进制整数且 <= %1">;

def err_fe_unable_to_load_basic_block_sections_file : Error<
    "unable to load basic block sections function list: '%0'"
    "\n" "错误：无法加载基本块段函数列表：'%0'">;

def warn_fe_serialized_diag_merge_failure : Warning<
    "unable to merge a subprocess's serialized diagnostics"
    "\n" "警告：无法合并子进程的序列化诊断">,
    InGroup<SerializedDiagnostics>;
def warn_fe_serialized_diag_failure : Warning<
    "unable to open file %0 for serializing diagnostics (%1)"
    "\n" "警告：无法打开文件 %0 以序列化诊断 (%1)">,
    InGroup<SerializedDiagnostics>;
def warn_fe_serialized_diag_failure_during_finalization : Warning<
    "received warning after diagnostic serialization teardown was underway: %0"
    "\n" "警告：诊断序列化拆除进行中收到警告：%0">,
    InGroup<SerializedDiagnostics>;

def err_verify_missing_line : Error<
    "missing or invalid line number following '@' in expected %0"
    "\n" "错误：在预期的 %0 中 '@' 后面缺少行号或行号无效">;
def err_verify_missing_file : Error<
    "file '%0' could not be located in expected %1"
    "\n" "错误：无法在预期的 %1 中找到文件 '%0'">;
def err_verify_invalid_range : Error<
    "invalid range following '-' in expected %0"
    "\n" "错误：在预期的 %0 中 '-' 后面的范围无效">;
def err_verify_ambiguous_marker : Error<
    "reference to marker '%0' is ambiguous"
    "\n" "错误：对标记 '%0' 的引用有歧义">;
def note_verify_ambiguous_marker : Note<
    "ambiguous marker '%0' is defined here"
    "\n" "提示：有歧义的标记 '%0' 在此处定义">;
def err_verify_no_such_marker : Error<
    "use of undefined marker '%0'"
    "\n" "错误：使用了未定义的标记 '%0'">;
def err_verify_missing_start : Error<
    "cannot find start ('{{') of expected %0"
    "\n" "错误：找不到预期的 %0 的开头（'{{'）">;
def err_verify_missing_end : Error<
    "cannot find end ('%1') of expected %0"
    "\n" "错误：找不到预期的 %0 的结尾（'%1'）">;
def err_verify_invalid_content : Error<
    "invalid expected %0: %1"
    "\n" "错误：无效的预期 %0：%1">;
def err_verify_missing_regex : Error<
    "cannot find start of regex ('{{') in %0"
    "\n" "错误：在 %0 中找不到正则表达式的开头（'{{'）">;
def err_verify_inconsistent_diags : Error<
    "%select{|'%1-%2' }0diagnostics %select{with '%2' severity |}0"
    "%select{expected|seen}3 but not %select{seen|expected}3: "
    "%4"
    "\n" "错误：%select{|'%1-%2' }0诊断%select{具有 '%2' 严重性 |}0"
    "%select{预期|看到}3 但未%select{看到|预期}3："
    "%4">;
def err_verify_invalid_no_diags : Error<
    "'%0' directive cannot follow %select{'%2' directive|other expected directives}1"
    "\n" "错误：'%0' 指令不能跟在%select{'%2' 指令|其他预期指令}1之后">;
def err_verify_no_directives : Error<
    "no expected directives found: consider use of '%0-no-diagnostics'"
    "\n" "错误：未找到预期的指令：请考虑使用 '%0-no-diagnostics'">;
def err_verify_nonconst_addrspace : Error<
  "qualifier 'const' is needed for variables in address space '%0'"
  "\n" "错误：地址空间 '%0' 中的变量需要 'const' 限定符">;
def err_verify_message_partial_match : Error<
  "diagnostic messages of '%0' severity not fully matched: %1"
  "\n" "错误：'%0' 严重性的诊断消息未完全匹配：%1">;
def err_verify_directive_out_of_order : Error<
  "all diagnostics were successfully matched, but out-of-order directives "
  "were found: %0"
  "\n" "错误：所有诊断都成功匹配，但发现了乱序的指令：%0">;
def err_verify_non_singular_match : Error<
  "diagnostic verification mode disallows use of a diagnostic quantifier"
  "\n" "错误：诊断验证模式不允许使用诊断量词">;
def err_verify_wildcard_loc : Error<
  "diagnostic verification mode disallows use of a wildcard for diagnostic "
  "location"
  "\n" "错误：诊断验证模式不允许对诊断位置使用通配符">;

def note_fixit_applied : Note<"FIX-IT applied suggested code changes"
  "\n" "提示：FIX-IT 已应用建议的代码更改">;
def note_fixit_in_macro : Note<
    "FIX-IT unable to apply suggested code changes in a macro"
    "\n" "提示：FIX-IT 无法在宏中应用建议的代码更改">;
def note_fixit_failed : Note<
    "FIX-IT unable to apply suggested code changes"
    "\n" "提示：FIX-IT 无法应用建议的代码更改">;
def note_fixit_unfixed_error : Note<"FIX-IT detected an error it cannot fix"
  "\n" "提示：FIX-IT 检测到无法修复的错误">;
def warn_fixit_no_changes : Note<
    "FIX-IT detected errors it could not fix; no output will be generated"
    "\n" "提示：FIX-IT 检测到无法修复的错误；不会生成任何输出">;

// PCH reader
def err_relocatable_without_isysroot : Error<
    "must specify system root with -isysroot when building a relocatable "
    "PCH file"
    "\n" "错误：构建可重定位的 PCH 文件时必须使用 -isysroot 指定系统根目录">;

def warn_unknown_diag_option : Warning<
    "unknown %select{warning|remark}0 option '%1'%select{|; did you mean '%3'?}2"
    "\n" "警告：未知的%select{警告|备注}0选项 '%1'%select{|；您是指 '%3' 吗？}2">,
    InGroup<UnknownWarningOption>;
def warn_unknown_warning_specifier : Warning<
    "unknown %0 warning specifier: '%1'"
    "\n" "警告：未知的 %0 警告说明符：'%1'">,
    InGroup<UnknownWarningOption>;

def warn_incompatible_analyzer_plugin_api : Warning<
    "checker plugin '%0' is not compatible with this version of the analyzer"
    "\n" "警告：检查器插件 '%0' 与此版本的分析器不兼容">,
    InGroup<DiagGroup<"analyzer-incompatible-plugin"> >;
def note_incompatible_analyzer_plugin_api : Note<
    "current API version is '%0', but plugin was compiled with version '%1'"
    "\n" "提示：当前 API 版本为 '%0'，但插件是用版本 '%1' 编译的">;

def err_module_build_requires_fmodules : Error<
  "module compilation requires '-fmodules'"
  "\n" "错误：模块编译需要 '-fmodules'">;
def err_module_interface_requires_cpp_modules
    : Error<"module interface compilation requires '-std=c++20'"
    "\n" "错误：模块接口编译需要 '-std=c++20'">;
def err_module_map_not_found : Error<"module map file '%0' not found"
  "\n" "错误：找不到模块映射文件 '%0'">,
  DefaultFatal;
def err_missing_module_name : Error<
  "no module name provided; specify one with -fmodule-name="
  "\n" "错误：未提供模块名称；请使用 -fmodule-name= 指定一个">,
  DefaultFatal;
def err_file_is_not_module : Error<"file '%0' is not a module file"
  "\n" "错误：文件 '%0' 不是模块文件">, DefaultFatal;
def err_missing_module : Error<
  "no module named '%0' declared in module map file '%1'"
  "\n" "错误：模块映射文件 '%1' 中未声明名为 '%0' 的模块">, DefaultFatal;
def err_no_submodule : Error<"no submodule named %0 in module '%1'"
  "\n" "错误：模块 '%1' 中没有名为 %0 的子模块">;
def err_no_submodule_suggest : Error<
  "no submodule named %0 in module '%1'; did you mean '%2'?"
  "\n" "错误：模块 '%1' 中没有名为 %0 的子模块；您是指 '%2' 吗？">;
def warn_no_priv_submodule_use_toplevel : Warning<
  "no submodule named %0 in module '%1'; using top level '%2'"
  "\n" "警告：模块 '%1' 中没有名为 %0 的子模块；正在使用顶层 '%2'">,
  InGroup<PrivateModule>;
def note_private_top_level_defined : Note<
  "module defined here"
  "\n" "提示：模块在此处定义">;
def warn_missing_submodule : Warning<"missing submodule '%0'"
  "\n" "警告：缺少子模块 '%0'">,
  InGroup<IncompleteUmbrella>;
def note_module_import_here : Note<"module imported here"
  "\n" "提示：模块在此处导入">;
def err_module_cannot_create_includes : Error<
  "cannot create includes file for module %0: %1"
  "\n" "错误：无法为模块 %0 创建包含文件：%1">;
def warn_module_config_macro_undef : Warning<
  "%select{definition|#undef}0 of configuration macro '%1' has no effect on "
  "the import of '%2'; pass '%select{-D%1=...|-U%1}0' on the command line "
  "to configure the module"
  "\n" "警告：配置宏 '%1' 的%select{定义|#undef}0对 '%2' 的导入没有影响；"
  "请在命令行传递 '%select{-D%1=...|-U%1}0' 来配置该模块">,
  InGroup<ConfigMacros>;
def note_module_def_undef_here : Note<
  "macro was %select{defined|#undef'd}0 here"
  "\n" "提示：宏在此处%select{被定义|被 #undef}0">;
def remark_module_build : Remark<"building module '%0' as '%1'"
  "\n" "备注：正在将模块 '%0' 构建为 '%1'">,
  ShowInSystemHeader,
  InGroup<ModuleBuild>;
def remark_module_build_done : Remark<"finished building module '%0'"
  "\n" "备注：已完成模块 '%0' 的构建">,
  ShowInSystemHeader,
  InGroup<ModuleBuild>;
def remark_module_lock : Remark<"locking '%0' to build module '%1'"
  "\n" "备注：正在锁定 '%0' 以构建模块 '%1'">,
  InGroup<ModuleLock>;
def err_modules_embed_file_not_found :
  Error<"file '%0' specified by '-fmodules-embed-file=' not found"
  "\n" "错误：找不到 '-fmodules-embed-file=' 指定的文件 '%0'">,
  DefaultFatal;
def err_module_header_file_not_found :
  Error<"module header file '%0' not found"
  "\n" "错误：找不到模块头文件 '%0'">, DefaultFatal;
def err_frontend_action_unsupported_input_format
    : Error<"%0 does not support input file format of file '%1': "
            "'%select{Source|ModuleMap|Precompiled|Unknown}2'"
            "\n" "错误：%0 不支持文件 '%1' 的输入文件格式："
            "'%select{源|模块映射|预编译|未知}2'">,
      DefaultFatal;

def err_test_module_file_extension_version : Error<
  "test module file extension '%0' has different version (%1.%2) than expected "
  "(%3.%4)"
  "\n" "错误：测试模块文件扩展名 '%0' 的版本 (%1.%2) 与预期版本 (%3.%4) 不同">;

def warn_eagerly_load_for_standard_cplusplus_modules : Warning<
  "the form '-fmodule-file=<BMI-path>' is deprecated for standard C++ named modules; "
  "consider to use '-fmodule-file=<module-name>=<BMI-path>' instead"
  "\n" "警告：对于标准 C++ 具名模块，形式 '-fmodule-file=<BMI-path>' 已弃用；"
  "请考虑改用 '-fmodule-file=<module-name>=<BMI-path>'">,
  InGroup<DiagGroup<"eager-load-cxx-named-modules">>;

def err_missing_vfs_overlay_file : Error<
  "virtual filesystem overlay file '%0' not found"
  "\n" "错误：找不到虚拟文件系统覆盖文件 '%0'">, DefaultFatal;
def err_invalid_vfs_overlay : Error<
  "invalid virtual filesystem overlay file '%0'"
  "\n" "错误：无效的虚拟文件系统覆盖文件 '%0'">, DefaultFatal;

def warn_option_invalid_ocl_version : Warning<
  "%0 does not support the option '%1'"
  "\n" "警告：%0 不支持选项 '%1'">, InGroup<Deprecated>;

def err_builtin_needs_feature : Error<"%0 needs target feature %1"
  "\n" "错误：%0 需要目标特性 %1">;
def err_function_needs_feature : Error<
  "always_inline function %1 requires target feature '%2', but would "
  "be inlined into function %0 that is compiled without support for '%2'"
  "\n" "错误：always_inline 函数 %1 需要目标特性 '%2'，但将被内联到"
  "未编译支持 '%2' 的函数 %0 中">;

def err_flatten_function_needs_feature : Error<
  "flatten function %0 calls %1 which requires target feature '%2', but the "
  "caller is compiled without support for '%2'"
  "\n" "错误：flatten 函数 %0 调用需要目标特性 '%2' 的 %1，"
  "但调用方是在未编译支持 '%2' 的情况下编译的">;

let CategoryName = "Codegen ABI Check" in {
def err_function_always_inline_attribute_mismatch : Error<
  "always_inline function %1 and its caller %0 have mismatching %2 attributes"
  "\n" "错误：always_inline 函数 %1 与其调用方 %0 的 %2 特性不匹配">;
def warn_function_always_inline_attribute_mismatch : Warning<
  "always_inline function %1 and its caller %0 have mismatching %2 attributes, "
  "inlining may change runtime behaviour"
  "\n" "警告：always_inline 函数 %1 与其调用方 %0 的 %2 特性不匹配，"
  "内联可能会改变运行时行为">, InGroup<AArch64SMEAttributes>;
def err_function_always_inline_new_za : Error<
  "always_inline function %0 has new za state"
  "\n" "错误：always_inline 函数 %0 具有新的 za 状态">;
def err_function_always_inline_new_zt0
    : Error<"always_inline function %0 has new zt0 state"
    "\n" "错误：always_inline 函数 %0 具有新的 zt0 状态">;

def warn_avx_calling_convention
    : Warning<"AVX vector %select{return|argument}0 of type %1 without '%2' "
              "enabled changes the ABI"
              "\n" "警告：类型为 %1 的 AVX 向量%select{返回值|实参}0在未启用 "
              "'%2' 的情况下会改变 ABI">,
      InGroup<DiagGroup<"psabi">>;
def err_avx_calling_convention : Error<warn_avx_calling_convention.Summary>;

def err_target_unsupported_type_for_abi
    : Error<"%0 requires %1 type support, but ABI '%2' does not support it"
    "\n" "错误：%0 需要 %1 类型支持，但 ABI '%2' 不支持它">;
}

def err_omp_host_ir_file_not_found : Error<
  "provided host compiler IR file '%0' is required to generate code for OpenMP "
  "target regions but cannot be found"
  "\n" "错误：为 OpenMP 目标区域生成代码所需的宿主编译器 IR 文件 '%0' "
  "无法找到">;
def err_alias_to_undefined : Error<
  "%select{alias|ifunc}0 must point to a defined "
  "%select{variable or |}1function"
  "\n" "错误：%select{别名|ifunc}0必须指向已定义的%select{变量或 |}1函数">;
def err_alias_to_common : Error<
  "alias to a variable in a common section is not allowed"
  "\n" "错误：不允许对公共段中的变量使用别名">;
def note_alias_requires_mangled_name : Note<
  "the %select{function or variable|function}0 specified in an %select{alias|ifunc}1 must refer to its mangled name"
  "\n" "提示：在%select{别名|ifunc}1中指定的%select{函数或变量|函数}0必须引用其改写名">;
def note_alias_mangled_name_alternative: Note<
  "function by that name is mangled as \"%0\""
  "\n" "提示：该名称的函数被改写为 \"%0\"">;
def warn_alias_to_weak_alias : Warning<
  "%select{alias|ifunc}2 will always resolve to %0 even if weak definition of "
  "%1 is overridden"
  "\n" "警告：即使 %1 的弱定义被覆盖，%select{别名|ifunc}2也始终解析为 %0">,
  InGroup<IgnoredAttributes>;
def err_duplicate_mangled_name : Error<
  "definition with same mangled name '%0' as another definition"
  "\n" "错误：定义与另一个定义的改写名 '%0' 相同">;
def err_cyclic_alias : Error<
  "%select{alias|ifunc}0 definition is part of a cycle"
  "\n" "错误：%select{别名|ifunc}0定义是环的一部分">;
def err_hidden_visibility_dllexport : Error<
  "hidden visibility cannot be applied to 'dllexport' declaration"
  "\n" "错误：隐藏可见性不能应用于 'dllexport' 声明">;
def err_non_default_visibility_dllimport : Error<
  "non-default visibility cannot be applied to 'dllimport' declaration"
  "\n" "错误：非默认可见性不能应用于 'dllimport' 声明">;
def err_ifunc_resolver_return : Error<
  "ifunc resolver function must return a pointer"
  "\n" "错误：ifunc 解析函数必须返回指针">;
def err_alias_between_function_and_variable : Error<
  "cannot alias a %select{function|variable}0 with a %select{variable|function}0"
  "\n" "错误：不能将一个%select{函数|变量}0与一个%select{变量|函数}0取别名">;
def note_aliasee_declaration: Note<"aliasee is declared here"
  "\n" "提示：被别名对象在此处声明">;
def warn_alias_type_mismatch : Warning<
  "alias and aliasee have different types %0 and %1"
  "\n" "警告：别名与被别名对象具有不同的类型 %0 和 %1">,
  InGroup<DiagGroup<"attribute-alias">>;

def err_fe_text_encoding_config : Error<"failed to set fexec-charset to '%0'"
  "\n" "错误：无法将 fexec-charset 设置为 '%0'">;
def warn_atomic_op_misaligned : Warning<
  "misaligned atomic operation may incur "
  "significant performance penalty"
  "; the expected alignment (%0 bytes) exceeds the actual alignment (%1 bytes)"
  "\n" "警告：未对齐的原子操作可能会带来显著的性能损失"
  "；预期的对齐（%0 字节）超过实际的对齐（%1 字节）">,
  InGroup<AtomicAlignment>;

def warn_atomic_op_oversized : Warning<
  "large atomic operation may incur "
  "significant performance penalty"
  "; the access size (%0 bytes) exceeds the max lock-free size (%1 bytes)"
  "\n" "警告：大型原子操作可能会带来显著的性能损失"
  "；访问大小（%0 字节）超过最大无锁大小（%1 字节）">,
InGroup<AtomicAlignment>;

def warn_sync_op_misaligned : Warning<
  "__sync builtin operation must have natural alignment (consider using __atomic)"
  "\n" "警告：__sync 内建操作必须具有自然对齐（请考虑使用 __atomic）">,
  InGroup<SyncAlignment>;

def warn_alias_with_section : Warning<
  "%select{alias|ifunc}1 will not be in section '%0' but in the same section "
  "as the %select{aliasee|resolver}2"
  "\n" "警告：%select{别名|ifunc}1将不在段 '%0' 中，而在与"
  "%select{被别名对象|解析器}2相同的段中">,
  InGroup<IgnoredAttributes>;

let CategoryName = "Instrumentation Issue" in {
def warn_profile_data_out_of_date : Warning<
  "profile data may be out of date: of %0 function%s0, %1 %plural{1:has|:have}1"
  " mismatched data that will be ignored"
  "\n" "警告：概要数据可能已过时：在 %0 个函数%s0 中，%1 个%plural{1:有|:有}1"
  "不匹配的数据将被忽略">,
  InGroup<ProfileInstrOutOfDate>;
def warn_profile_data_missing : Warning<
  "profile data may be incomplete: of %0 function%s0, %1 %plural{1:has|:have}1"
  " no data"
  "\n" "警告：概要数据可能不完整：在 %0 个函数%s0 中，%1 个%plural{1:有|:有}1"
  "没有数据">,
  InGroup<ProfileInstrMissing>,
  DefaultIgnore;
def warn_profile_data_unprofiled : Warning<
  "no profile data available for file \"%0\""
  "\n" "警告：文件 \"%0\" 没有可用的概要数据">,
  InGroup<ProfileInstrUnprofiled>;
def warn_profile_data_misexpect : Warning<
  "potential performance regression from use of __builtin_expect(): "
  "annotation was correct on %0 of profiled executions"
  "\n" "警告：使用 __builtin_expect() 可能导致性能回退："
  "注释在被概要分析的 %0 次执行中是正确的">,
  BackendInfo, InGroup<MisExpect>;
} // end of instrumentation issue category

def warn_ssaf_extract_tu_summary_file_unknown_output_format :
  Warning<"unknown output summary file format '%0' "
  "specified by '--ssaf-tu-summary-file=%1'"
  "\n" "警告：由 '--ssaf-tu-summary-file=%1' 指定了未知的输出概要文件格式 '%0'">,
  InGroup<ScalableStaticAnalysis>, DefaultError;

def warn_ssaf_extract_tu_summary_file_unknown_format :
  Warning<"failed to parse the value of '--ssaf-tu-summary-file=%0' "
  "the value must follow the '<path>.<format>' pattern"
  "\n" "警告：无法解析 '--ssaf-tu-summary-file=%0' 的值，"
  "该值必须遵循 '<path>.<format>' 模式">,
  InGroup<ScalableStaticAnalysis>, DefaultError;

def warn_ssaf_must_enable_summary_extractors :
  Warning<"must enable some summary extractors using the "
        "'--ssaf-extract-summaries=' option"
        "\n" "警告：必须使用 '--ssaf-extract-summaries=' 选项启用一些概要提取器">,
  InGroup<ScalableStaticAnalysis>, DefaultError;

def warn_ssaf_extract_summary_unknown_extractor_name :
  Warning<"no summary extractor%s0 %plural{1:was|:were}0 registered with name: %1"
  "\n" "警告：没有注册名为 %1 的概要提取器%s0%plural{1:是|:是}0">,
  InGroup<ScalableStaticAnalysis>, DefaultError;

def warn_ssaf_write_tu_summary_failed :
  Warning<"failed to write TU summary to '%0': %1"
  "\n" "警告：无法将 TU 概要写入 '%0'：%1">,
  InGroup<ScalableStaticAnalysis>, DefaultError;

def warn_ssaf_tu_summary_requires_compilation_unit_id :
  Warning<"option '--ssaf-tu-summary-file=' requires "
          "'--ssaf-compilation-unit-id=' to be set"
          "\n" "警告：选项 '--ssaf-tu-summary-file=' 需要设置 "
          "'--ssaf-compilation-unit-id='">,
  InGroup<ScalableStaticAnalysis>, DefaultError;

def err_extract_api_ignores_file_not_found :
  Error<"file '%0' specified by '--extract-api-ignores=' not found"
  "\n" "错误：找不到 '--extract-api-ignores=' 指定的文件 '%0'">, DefaultFatal;

def warn_missing_symbol_graph_dir : Warning<
  "missing symbol graph output directory, defaulting to working directory"
  "\n" "警告：缺少符号图输出目录，默认使用工作目录">,
  InGroup<ExtractAPIMisuse>;

def err_ast_action_on_llvm_ir : Error<
  "cannot apply AST actions to LLVM IR file '%0'"
  "\n" "错误：无法对 LLVM IR 文件 '%0' 应用 AST 操作">,
  DefaultFatal;

def err_invalid_llvm_ir : Error<"invalid LLVM IR input: %0"
  "\n" "错误：无效的 LLVM IR 输入：%0">;

def err_os_unsupport_riscv_fmv : Error<
  "function multiversioning is currently only supported on Linux"
  "\n" "错误：函数多版本化目前仅在 Linux 上受支持">;

def warn_unreachable_version
    : Warning<"function version '%0' is unreachable; ignoring version"
      "\n" "警告：函数版本 '%0' 不可达；忽略该版本">,
      InGroup<FunctionMultiVersioning>;

def warn_hlsl_langstd_minimal :
  Warning<"support for HLSL language version %0 is incomplete, "
          "recommend using %1 instead"
          "\n" "警告：对 HLSL 语言版本 %0 的支持不完整，建议改用 %1">,
  InGroup<HLSLDXCCompat>;
def warn_hlsl_failed_to_embed_source
    : Warning<"failed to embed source for '%0' into dx.source.contents"
      "\n" "警告：无法将 '%0' 的源代码嵌入到 dx.source.contents 中">,
      InGroup<HLSLDXCCompat>;

def err_data_layout_mismatch : Error<"backend data layout '%0' does not match "
                                     "expected target description '%1'"
                                     "\n" "错误：后端数据布局 '%0' 与预期的 "
                                     "目标描述 '%1' 不匹配">;
def err_failed_to_open_for_embedding
    : Error<"could not open '%0' for embedding"
    "\n" "错误：无法打开 '%0' 以进行嵌入">;
def err_unsupported_cxx_abi_feature
    : Error<"cannot yet compile %0 in this ABI"
    "\n" "错误：尚不能在此 ABI 中编译 %0">;

def err_target_region_offloading_entry_incorrect
    : Error<"offloading entry for target region in %0 is incorrect: either the "
            "address or the ID is invalid"
            "\n" "错误：%0 中目标区域的卸载条目不正确：地址或 ID 无效">;
def err_target_var_offloading_entry_incorrect_with_parent
    : Error<"offloading entry for declare target variable %0 is incorrect: the "
            "address is invalid"
            "\n" "错误：声明目标变量 %0 的卸载条目不正确：地址无效">;
def err_target_var_offloading_entry_incorrect
    : Error<"offloading entry for declare target variable is incorrect: the "
            "address is invalid"
            "\n" "错误：声明目标变量的卸载条目不正确：地址无效">;

def err_missing_mandatory_offloading
    : Error<"no offloading entry generated while offloading is mandatory"
    "\n" "错误：在必须进行卸载时未生成卸载条目">;

def err_reading_profile : Error<"error in reading profile %0: %1"
  "\n" "错误：读取概要 %0 时出错：%1">;
def err_open_hotpatch_file_failed
    : Error<"failed to open hotpatch functions file "
            "(-fms-hotpatch-functions-file): %0 : %1"
            "\n" "错误：无法打开热补丁函数文件 "
            "（-fms-hotpatch-functions-file）：%0 : %1">;

def err_codegen_unsupported : Error<"cannot compile this %0 yet"
  "\n" "错误：尚不能编译此 %0">;

def warn_trivial_auto_var_limit
    : Warning<"-ftrivial-auto-var-init-stop-after=%0 has been enabled to limit "
              "the number of times ftrivial-auto-var-init=%1 gets applied"
              "\n" "警告：已启用 -ftrivial-auto-var-init-stop-after=%0 "
              "以限制 ftrivial-auto-var-init=%1 被应用的次数">,
      InGroup<TrivialAutoVarInit>;

def warn_simdlen_1_no_effect
    : Warning<"the clause simdlen(1) has no effect when targeting aarch64"
      "\n" "警告：simdlen(1) 子句在面向 aarch64 时没有效果">,
      InGroup<SIMDLen>;
def warn_simdlen_requires_power_of_2
    : Warning<"the value specified in simdlen must be a power of 2 when "
              "targeting Advanced SIMD"
              "\n" "警告：在面向 Advanced SIMD 时，simdlen 中指定的值必须是 2 的幂">,
      InGroup<SIMDLen>;
def warn_simdlen_must_fit_lanes
    : Warning<"the clause simdlen must fit the %0-bit lanes in the "
              "architectural constraints for SVE (min is 128-bit, max is "
              "2048-bit, by steps of 128-bit)"
              "\n" "警告：simdlen 子句必须符合 SVE 架构约束中的 %0 位通道"
              "（最小为 128 位，最大为 2048 位，以 128 位为步长）">,
      InGroup<SIMDLen>;

def warn_pgo_condition_limit
    : Warning<"unsupported MC/DC boolean expression; number of conditions (%0) "
              "exceeds max (%1). Expression will not be covered"
              "\n" "警告：不支持的 MC/DC 布尔表达式；条件数 (%0) 超过最大值 "
              "(%1)。该表达式将不被覆盖">,
      InGroup<PGOCoverage>;
def warn_pgo_test_vector_limit
    : Warning<"unsupported MC/DC boolean expression; number of test vectors "
              "(%0) exceeds max (%1). Expression will not be covered"
              "\n" "警告：不支持的 MC/DC 布尔表达式；测试向量数 (%0) 超过最大值 "
              "(%1)。该表达式将不被覆盖">,
      InGroup<PGOCoverage>;

def err_member_ptr_requires_complete_type
    : Error<"member pointer representation requires a complete class type for "
            "%0 to perform this expression"
            "\n" "错误：成员指针表示需要 %0 的完整类类型才能执行此表达式">;

// ClangIR frontend errors
def err_cir_to_cir_transform_failed : Error<
    "CIR-to-CIR transformation failed"
    "\n" "错误：CIR 到 CIR 的转换失败">, DefaultFatal;

def err_cir_verification_failed_pre_passes : Error<
    "CIR module verification error before running CIR-to-CIR passes"
    "\n" "错误：在运行 CIR 到 CIR 的遍之前发生 CIR 模块验证错误">,
    DefaultFatal;
}
