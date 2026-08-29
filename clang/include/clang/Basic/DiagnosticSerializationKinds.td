//==--- DiagnosticSerializationKinds.td - serialization diagnostics -------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

let Component = "Serialization" in {
let CategoryName = "AST Deserialization Issue" in {

def err_fe_unable_to_read_pch_file : Error<
    "unable to read PCH file %0: '%1'"
    "\n" "错误：无法读取 PCH 文件 %0：'%1'">;
def err_fe_not_a_pch_file : Error<
    "input is not a PCH file: '%0'"
    "\n" "错误：输入不是 PCH 文件：'%0'">;
def err_fe_ast_file_malformed : Error<
    "malformed or corrupted precompiled file: '%0'"
    "\n" "错误：格式错误或损坏的预编译文件：'%0'">, DefaultFatal;
def err_fe_pch_malformed_block : Error<
    "malformed block record in PCH file: '%0'"
    "\n" "错误：PCH 文件中的块记录格式错误：'%0'">, DefaultFatal;
def err_fe_ast_file_modified : Error<
    "file '%0' has been modified since the "
    "%select{precompiled header|module file|precompiled file}1 '%2' was built"
    "\n" "错误：自 %select{预编译头|模块文件|预编译文件}1 '%2' 构建以来，文件 '%0' 已被修改">,
    DefaultFatal;
def note_fe_ast_file_modified : Note<
    "%select{size|mtime|content}0 changed%select{| from expected %2 to %3}1"
    "\n" "提示：%select{大小|修改时间|内容}0 已改变%select{| 从预期 %2 变为 %3}1">;
def err_fe_pch_file_overridden : Error<
    "file '%0' from the precompiled header has been overridden"
    "\n" "错误：预编译头中的文件 '%0' 已被覆盖">;
def note_ast_file_required_by : Note<"'%0' required by '%1'"
    "\n" "提示：'%0' 被 '%1' 需要">;
def note_ast_file_rebuild_required
    : Note<"precompiled file '%0' needs to be rebuilt"
    "\n" "提示：预编译文件 '%0' 需要重新构建">;
def note_module_cache_path : Note<
    "after modifying system headers, please delete the module cache at '%0'"
    "\n" "提示：修改系统头文件后，请删除 '%0' 处的模块缓存">;
def note_ast_file_input_files_validation_status : Note<"earlier input file validation "
    "%select{was not performed|was disabled for this kind of precompiled file|"
    "was skipped for the current build session|"
    "has covered only user files|has covered all files}0"
    "\n" "提示：先前的输入文件验证%select{未执行|对此类预编译文件已禁用|"
    "在当前构建会话中被跳过|仅覆盖了用户文件|覆盖了所有文件}0">;

def err_ast_file_targetopt_mismatch : Error<
    "precompiled file '%0' was compiled for the %1 '%2' but the current translation "
    "unit is being compiled for target '%3'"
    "\n" "错误：预编译文件 '%0' 是为 %1 '%2' 编译的，但当前翻译单元正在为目标 '%3' 编译">;
def err_ast_file_targetopt_feature_mismatch : Error<
    "%select{precompiled file '%1' was|current translation unit is}0 compiled with the target "
    "feature '%2' but the %select{current translation unit is|precompiled file '%1' was}0 "
    "not"
    "\n" "错误：%select{预编译文件 '%1' 是|当前翻译单元是}0使用目标 "
    "特性 '%2' 编译的，但%select{当前翻译单元不是|预编译文件 '%1' 不是}0">;
def err_ast_file_langopt_mismatch : Error<"%0 was %select{disabled|enabled}1 in "
    "precompiled file '%3' but is currently %select{disabled|enabled}2"
    "\n" "错误：%0 在预编译文件 '%3' 中%select{已禁用|已启用}1，但目前%select{已禁用|已启用}2">;
def warn_ast_file_config_mismatch
    : Warning<"precompiled file '%0' cannot be loaded due to a configuration "
              "mismatch with the current "
              "compilation"
              "\n" "警告：由于与当前编译的配置不匹配，无法加载预编译文件 '%0'">,
      InGroup<DiagGroup<"module-file-config-mismatch">>,
      DefaultError;
def err_ast_file_langopt_value_mismatch : Error<
  "%0 differs in precompiled file '%1' vs. current file"
  "\n" "错误：%0 在预编译文件 '%1' 中与当前文件不同">;
def err_ast_file_codegenopt_mismatch : Error<"%0 was %select{disabled|enabled}1 in "
  "precompiled file '%3' but is currently %select{disabled|enabled}2"
  "\n" "错误：%0 在预编译文件 '%3' 中%select{已禁用|已启用}1，但目前%select{已禁用|已启用}2">;
def err_ast_file_codegenopt_value_mismatch
    : Error<"%0 differs in precompiled file '%1' vs. current file"
  "\n" "错误：%0 在预编译文件 '%1' 中与当前文件不同">;
def err_ast_file_diagopt_mismatch : Error<"%0 is currently enabled, but was not in "
  "the precompiled file '%1'"
  "\n" "错误：%0 目前已启用，但预编译文件 '%1' 中没有">;
def err_ast_file_modulecache_mismatch : Error<"precompiled file '%2' was compiled with module cache "
  "path '%0', but the path is currently '%1'"
  "\n" "错误：预编译文件 '%2' 是使用模块缓存路径 '%0' 编译的，但该路径目前为 '%1'">;
def warn_pch_vfsoverlay_mismatch : Warning<
  "PCH was compiled with different VFS overlay files than are currently in use"
  "\n" "警告：PCH 是使用与当前使用的不同 VFS 覆盖文件编译的">,
  InGroup<DiagGroup<"pch-vfs-diff">>;
def note_pch_vfsoverlay_files : Note<
  "%select{PCH|current translation unit}0 has the following VFS overlays:\n%1"
  "\n" "提示：%select{PCH|当前翻译单元}0具有以下 VFS 覆盖：\n%1">;
def note_pch_vfsoverlay_empty : Note<
  "%select{PCH|current translation unit}0 has no VFS overlays"
  "\n" "提示：%select{PCH|当前翻译单元}0没有 VFS 覆盖">;

def err_ast_file_version_too_old : Error<
    "%select{PCH|module|precompiled}0 file '%1' uses an older format that is no longer supported"
    "\n" "错误：%select{PCH|模块|预编译}0 文件 '%1' 使用的较旧格式已不再受支持">;
def err_ast_file_version_too_new : Error<
    "%select{PCH|module|precompiled }0 file '%1' uses a newer format that cannot be read"
    "\n" "错误：%select{PCH|模块|预编译 }0 文件 '%1' 使用的较新格式无法读取">;
def err_ast_file_different_branch : Error<
    "%select{PCH|module|precompiled}0 file '%1' built from a different branch (%2) than the compiler (%3)"
    "\n" "错误：%select{PCH|模块|预编译}0 文件 '%1' 是从与编译器 (%3) 不同的分支 (%2) 构建的">;
def err_ast_file_with_compiler_errors : Error<
    "%select{PCH|module|precompiled}0 file '%1' contains compiler errors"
    "\n" "错误：%select{PCH|模块|预编译}0 文件 '%1' 包含编译器错误">;

def err_module_file_conflict : Error<
  "module '%0' is defined in both '%1' and '%2'"
  "\n" "错误：模块 '%0' 在 '%1' 和 '%2' 中都有定义">, DefaultFatal;
def err_ast_file_not_found : Error<
  "%select{PCH|module|precompiled}0 file '%1' not found"
  "\n" "错误：找不到 %select{PCH|模块|预编译}0 文件 '%1'">, DefaultFatal;
def note_ast_file_buffer_failed : Note<
  "unable to load buffer for precompiled file: %0"
  "\n" "提示：无法为预编译文件加载缓冲区：%0">;
def note_ast_file_signature_failed : Note<
  "unable to verify precompiled file signature: %0"
  "\n" "提示：无法验证预编译文件签名：%0">;
def err_ast_file_out_of_date : Error<
  "%select{PCH|module|precompiled}0 file '%1' is out of date and "
  "needs to be rebuilt"
  "\n" "错误：%select{PCH|模块|预编译}0 文件 '%1' 已过期，需要重新构建">, DefaultFatal;
def err_ast_file_invalid : Error<
  "file '%1' is not a valid %select{PCH|module|precompiled}0 file: %2"
  "\n" "错误：文件 '%1' 不是有效的 %select{PCH|模块|预编译}0 文件：%2">, DefaultFatal;
def note_module_file_imported_by : Note<
  "imported by %select{|module '%2' in }1'%0'"
  "\n" "提示：由 %select{|模块 '%2' 中的}1'%0' 导入">;
def err_module_file_not_module : Error<
  "precompiled file '%0' was not built as a module"
  "\n" "错误：预编译文件 '%0' 不是作为模块构建的">, DefaultFatal;
def err_module_file_missing_top_level_submodule : Error<
  "module file '%0' is missing its top-level submodule"
  "\n" "错误：模块文件 '%0' 缺少其顶层子模块">, DefaultFatal;
def note_module_file_conflict : Note<
  "compiled from '%0' and '%1'"
  "\n" "提示：从 '%0' 和 '%1' 编译">;

def remark_module_import : Remark<
  "importing module '%0'%select{| into '%3'}2 from '%1'"
  "\n" "备注：正在从 '%1' 导入模块 '%0'%select{| 到 '%3'}2">,
  ShowInSystemHeader,
  InGroup<ModuleImport>;
def remark_module_validation : Remark<
  "validating %0 input files in module '%1' from '%2'"
  "\n" "备注：正在从 '%2' 验证模块 '%1' 中的 %0 个输入文件">,
  ShowInSystemHeader,
  InGroup<ModuleValidation>;
def remark_module_check_relocation
    : Remark<"checking if module '%0' from '%1' has relocated"
      "\n" "备注：正在检查来自 '%1' 的模块 '%0' 是否已重定位">,
      ShowInSystemHeader,
      InGroup<ModuleValidation>;
def remark_module_relocated : Remark<"module '%0' relocated from '%1' to '%2'"
                              "\n" "备注：模块 '%0' 已从 '%1' 重定位到 '%2'">,
                              ShowInSystemHeader,
                              InGroup<ModuleValidation>;

def err_imported_module_not_found : Error<
    "module '%0' in precompiled file '%1' %select{(imported by precompiled file '%2') |}4"
    "is not defined in any loaded module map file; "
    "maybe you need to load '%3'?"
    "\n" "错误：预编译文件 '%1' 中的模块 '%0' %select{（由预编译文件 '%2' 导入） |}4"
    "未在任何已加载的模块映射文件中定义；也许您需要加载 '%3'？">, DefaultFatal;
def note_imported_by_pch_module_not_found : Note<
    "consider adding '%0' to the header search path"
    "\n" "提示：请考虑将 '%0' 添加到头文件搜索路径">;
def err_imported_module_modmap_changed : Error<
    "module '%0' %select{in|imported by}4 precompiled file '%1' found in a different module map file"
    " (%2) than when the importing precompiled file was built (%3)"
    "\n" "错误：模块 '%0' %select{位于预编译文件 '%1' 中|由预编译文件 '%1' 导入}4，"
    "找到的模块映射文件 (%2) 不同于构建导入它的预编译文件时 (%3) 的模块映射文件">, DefaultFatal;
def err_imported_module_relocated : Error<
    "module '%0' was built in directory '%1' but now resides in "
    "directory '%2'"
    "\n" "错误：模块 '%0' 构建于目录 '%1'，但现在位于目录 '%2'">, DefaultFatal;
def err_module_different_modmap : Error<
    "module '%0' %select{uses|does not use}1 additional module map '%2'"
    "%select{| not}1 used when the module was built"
    "\n" "错误：模块 '%0' %select{使用|不使用}1额外的模块映射 '%2'"
    "%select{|未}1在构建该模块时使用">;

def err_ast_file_macro_def_undef : Error<
    "macro '%0' was %select{defined|undef'd}1 in the precompiled file '%2' but "
    "%select{undef'd|defined}1 on the command line"
    "\n" "错误：宏 '%0' 在预编译文件 '%2' 中%select{已定义|已取消定义}1，但在命令行中"
    "%select{已取消定义|已定义}1">;
def err_ast_file_macro_def_conflict : Error<
    "definition of macro '%0' differs between the precompiled file '%3' ('%1') "
    "and the command line ('%2')"
    "\n" "错误：宏 '%0' 的定义在预编译文件 '%3'（'%1'）和命令行（'%2'）之间不同">;
def err_ast_file_undef : Error<
    "%select{command line contains|precompiled file '%1' was built with}0 "
    "'-undef' but %select{precompiled file '%1' was not built with it|"
    "it is not present on the command line}0"
    "\n" "错误：%select{命令行包含|预编译文件 '%1' 使用了}0 "
    "'-undef'，但%select{预编译文件 '%1' 未使用它构建|命令行中没有它}0">;
def err_ast_file_pp_detailed_record : Error<
    "%select{command line contains|precompiled file '%1' was built with}0 "
    "'-detailed-preprocessing-record' but %select{precompiled file '%1' was not "
    "built with it|it is not present on the command line}0"
    "\n" "错误：%select{命令行包含|预编译文件 '%1' 使用了}0 "
    "'-detailed-preprocessing-record'，但%select{预编译文件 '%1' 未使用它构建|命令行中没有它}0">;

def err_module_odr_violation_missing_decl : Error<
  "%q0 from module '%1' is not present in definition of %q2"
  "%select{ in module '%4'| provided earlier}3"
  "\n" "错误：来自模块 '%1' 的 %q0 不存在于 %q2 的定义中"
  "%select{ 在模块 '%4' 中| 先前提供}3">, NoSFINAE;
def note_module_odr_violation_no_possible_decls : Note<
  "definition has no member %0"
  "\n" "提示：定义没有成员 %0">;
def note_module_odr_violation_possible_decl : Note<
  "declaration of %0 does not match"
  "\n" "提示：%0 的声明不匹配">;

def err_module_odr_violation_different_instantiations : Error<
  "instantiation of %q0 is different in different modules"
  "\n" "错误：%q0 的实例化在不同模块中不同">;

def warn_duplicate_module_file_extension : Warning<
  "duplicate module file extension block name '%0'"
  "\n" "警告：重复的模块文件扩展块名称 '%0'">,
  InGroup<ModuleFileExtension>;

def warn_module_system_bit_conflict : Warning<
  "module file '%0' was validated as a system module and is now being imported "
  "as a non-system module; any difference in diagnostic options will be ignored"
  "\n" "警告：模块文件 '%0' 已验证为系统模块，现在作为非系统模块导入；"
  "任何诊断选项的差异都将被忽略">,
  InGroup<ModuleConflict>;

def warn_decls_in_multiple_modules : Warning<
  "declaration %0 is detected to be defined in multiple module units, first is from '%1' and second is from '%2'; "
  "the compiler may not be good at merging the definitions. "
  "\n" "警告：检测到声明 %0 在多个模块单元中定义，第一个来自 '%1'，第二个来自 '%2'；"
  "编译器可能不擅长合并这些定义。">,
  InGroup<DiagGroup<"decls-in-multiple-modules">>,
  DefaultIgnore;

def warn_module_file_mapping_mismatch
    : Warning<"loaded module file '%0' conflicts with imported file '%1'"
      "\n" "警告：加载的模块文件 '%0' 与导入的文件 '%1' 冲突">,
      InGroup<DiagGroup<"module-file-mapping-mismatch">>,
      DefaultIgnore;

def err_failed_to_find_module_file : Error<
  "failed to find module file for module '%0'"
  "\n" "错误：找不到模块 '%0' 的模块文件">;
} // let CategoryName

let CategoryName = "AST Serialization Issue" in {
def warn_module_uses_date_time : Warning<
  "%select{precompiled header|module}0 uses __DATE__ or __TIME__"
  "\n" "警告：%select{预编译头|模块}0 使用了 __DATE__ 或 __TIME__">,
  InGroup<DiagGroup<"pch-date-time">>;
def err_module_no_size_mtime_for_header : Error<
  "cannot emit module %0: %select{size|mtime}1 must be explicitly specified "
  "for missing header file \"%2\""
  "\n" "错误：无法发出模块 %0：对于缺失的头文件 \"%2\"，必须显式指定%select{大小|修改时间}1">;
def err_module_unable_to_hash_content : Error<
  "failed to hash content for '%0' because memory buffer cannot be retrieved"
  "\n" "错误：无法为 '%0' 计算内容哈希，因为无法检索内存缓冲区">;
} // let CategoryName
} // let Component
