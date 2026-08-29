//==--- DiagnosticInstallAPIKinds.td - installapi diagnostics -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// InstallAPI Diagnostics
//===----------------------------------------------------------------------===//

let Component = "InstallAPI" in {
let CategoryName = "Command line" in {
def err_cannot_write_file : Error<"cannot write file '%0': %1"
  "\n" "错误：无法写入文件 '%0'：%1">;
def err_no_install_name : Error<"no install name specified: add -install_name <path>"
  "\n" "错误：未指定安装名称：请添加 -install_name <path>">;
def err_no_output_file: Error<"no output file specified"
  "\n" "错误：未指定输出文件">;
def err_no_such_header_file : Error<"no such %select{public|private|project}1 header file: '%0'"
  "\n" "错误：没有这样的%select{公共|私有|项目}1头文件：'%0'">;
def warn_no_such_excluded_header_file : Warning<"no such excluded %select{public|private}0 header file: '%1'"
  "\n" "警告：没有这样的已排除%select{公共|私有}0头文件：'%1'">, InGroup<InstallAPIViolation>;
def warn_glob_did_not_match: Warning<"glob '%0' did not match any header file"
  "\n" "警告：glob '%0' 未匹配任何头文件">, InGroup<InstallAPIViolation>;
def err_no_such_umbrella_header_file : Error<"%select{public|private|project}1 umbrella header file not found in input: '%0'"
  "\n" "错误：在输入中找不到%select{公共|私有|项目}1伞头文件：'%0'">;
def err_cannot_find_reexport : Error<"cannot find re-exported %select{framework|library}0: '%1'"
  "\n" "错误：找不到重新导出的%select{框架|库}0：'%1'">;
def err_no_matching_target : Error<"no matching target found for target variant '%0'"
  "\n" "错误：为目标变体 '%0' 找不到匹配的目标">;
def err_unsupported_vendor : Error<"vendor '%0' is not supported: '%1'"
  "\n" "错误：不支持供应商 '%0'：'%1'">;
def err_unsupported_environment : Error<"environment '%0' is not supported: '%1'"
  "\n" "错误：不支持环境 '%0'：'%1'">;
def err_unsupported_os : Error<"os '%0' is not supported: '%1'"
  "\n" "错误：不支持操作系统 '%0'：'%1'">;
def err_cannot_read_input_list : Error<"could not read %0 input list '%1': %2"
  "\n" "错误：无法读取 %0 输入列表 '%1'：%2">;
def err_invalid_label: Error<"label '%0' is reserved: use a different label name for -X<label>"
  "\n" "错误：标签 '%0' 已被保留：请为 -X<label> 使用不同的标签名称">;
def err_directory_scanning: Error<"could not read directory '%0': %1"
  "\n" "错误：无法读取目录 '%0'：%1">;
def err_more_than_one_library: Error<"more than one framework/dynamic library found"
  "\n" "错误：找到多个框架/动态库">;
} // end of command line category.

let CategoryName = "Verification" in {
// Diagnostics about symbols.
def warn_target: Warning<"violations found for %0"
  "\n" "警告：为 %0 找到了违规">, InGroup<InstallAPIViolation>;
def err_library_missing_symbol : Error<"declaration has external linkage, but dynamic library doesn't have symbol '%0'"
  "\n" "错误：声明具有外部连接，但动态库没有符号 '%0'">;
def warn_library_missing_symbol : Warning<"declaration has external linkage, but dynamic library doesn't have symbol '%0'"
  "\n" "警告：声明具有外部连接，但动态库没有符号 '%0'">, InGroup<InstallAPIViolation>;
def err_library_hidden_symbol : Error<"declaration has external linkage, but symbol has internal linkage in dynamic library '%0'"
  "\n" "错误：声明具有外部连接，但动态库 '%0' 中的符号具有内部连接">;
def warn_library_hidden_symbol : Warning<"declaration has external linkage, but symbol has internal linkage in dynamic library '%0'"
  "\n" "警告：声明具有外部连接，但动态库 '%0' 中的符号具有内部连接">, InGroup<InstallAPIViolation>;
def warn_header_hidden_symbol : Warning<"symbol exported in dynamic library, but marked hidden in declaration '%0'"
  "\n" "警告：符号在动态库中导出，但在声明 '%0' 中标记为隐藏">, InGroup<InstallAPIViolation>;
def err_header_hidden_symbol : Error<"symbol exported in dynamic library, but marked hidden in declaration '%0'"
  "\n" "错误：符号在动态库中导出，但在声明 '%0' 中标记为隐藏">;
def err_header_symbol_missing : Error<"no declaration found for exported symbol '%0' in dynamic library"
  "\n" "错误：在动态库中找不到导出的符号 '%0' 的声明">;
def warn_header_symbol_missing : Warning<"no declaration was found for exported symbol '%0' in dynamic library"
  "\n" "警告：在动态库中找不到导出的符号 '%0' 的声明">, InGroup<InstallAPIViolation>;
def warn_header_availability_mismatch : Warning<"declaration '%0' is marked %select{available|unavailable}1,"
  " but symbol is %select{not |}2exported in dynamic library"
  "\n" "警告：声明 '%0' 被标记为%select{可用|不可用}1，但符号%select{未|}2在动态库中导出">, InGroup<InstallAPIViolation>;
def err_header_availability_mismatch : Error<"declaration '%0' is marked %select{available|unavailable}1,"
  " but symbol is %select{not |}2exported in dynamic library"
  "\n" "错误：声明 '%0' 被标记为%select{可用|不可用}1，但符号%select{未|}2在动态库中导出">;
def warn_dylib_symbol_flags_mismatch : Warning<"dynamic library symbol '%0' is "
  "%select{weak defined|thread local}1, but its declaration is not"
  "\n" "警告：动态库符号 '%0' 为%select{弱定义|线程局部}1，但其声明不是">, InGroup<InstallAPIViolation>;
def warn_header_symbol_flags_mismatch : Warning<"declaration '%0' is "
  "%select{weak defined|thread local}1, but symbol is not in dynamic library"
  "\n" "警告：声明 '%0' 为%select{弱定义|线程局部}1，但动态库中没有该符号">, InGroup<InstallAPIViolation>;
def err_dylib_symbol_flags_mismatch : Error<"dynamic library symbol '%0' is "
  "%select{weak defined|thread local}1, but its declaration is not"
  "\n" "错误：动态库符号 '%0' 为%select{弱定义|线程局部}1，但其声明不是">;
def err_header_symbol_flags_mismatch : Error<"declaration '%0' is "
  "%select{weak defined|thread local}1, but symbol is not in dynamic library"
  "\n" "错误：声明 '%0' 为%select{弱定义|线程局部}1，但动态库中没有该符号">;

// Diagnostics about load commands.
def err_architecture_mismatch : Error<"architectures do not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：架构不匹配：'%0'（提供）对比 '%1'（找到）">;
def warn_platform_mismatch : Warning<"platform does not match: '%0' (provided) vs '%1' (found)"
  "\n" "警告：平台不匹配：'%0'（提供）对比 '%1'（找到）">, InGroup<InstallAPIViolation>;
def err_platform_mismatch : Error<"platform does not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：平台不匹配：'%0'（提供）对比 '%1'（找到）">;
def err_install_name_mismatch : Error<"install_name does not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：install_name 不匹配：'%0'（提供）对比 '%1'（找到）">;
def err_current_version_mismatch : Error<"current_version does not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：current_version 不匹配：'%0'（提供）对比 '%1'（找到）">;
def err_compatibility_version_mismatch : Error<"compatibility_version does not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：compatibility_version 不匹配：'%0'（提供）对比 '%1'（找到）">;
def err_appextension_safe_mismatch : Error<"the ApplicationExtensionSafe flag does not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：ApplicationExtensionSafe 标志不匹配：'%0'（提供）对比 '%1'（找到）">;
def err_shared_cache_eligiblity_mismatch : Error<"the NotForDyldSharedCache flag does not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：NotForDyldSharedCache 标志不匹配：'%0'（提供）对比 '%1'（找到）">;
def err_no_twolevel_namespace : Error<"flat namespace libraries are not supported"
  "\n" "错误：不支持扁平命名空间库">;
def err_parent_umbrella_missing: Error<"parent umbrella missing from %0: '%1'"
  "\n" "错误：父伞头文件从 %0 中缺失：'%1'">;
def err_parent_umbrella_mismatch : Error<"parent umbrella does not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：父伞头文件不匹配：'%0'（提供）对比 '%1'（找到）">;
def err_reexported_libraries_missing : Error<"re-exported library missing from %0: '%1'"
  "\n" "错误：重新导出的库从 %0 中缺失：'%1'">;
def err_reexported_libraries_mismatch : Error<"re-exported libraries do not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：重新导出的库不匹配：'%0'（提供）对比 '%1'（找到）">;
def err_allowable_clients_missing : Error<"allowable client missing from %0: '%1'"
  "\n" "错误：允许的客户端从 %0 中缺失：'%1'">;
def err_allowable_clients_mismatch : Error<"allowable clients do not match: '%0' (provided) vs '%1' (found)"
  "\n" "错误：允许的客户端不匹配：'%0'（提供）对比 '%1'（找到）">;
def warn_rpaths_missing : Warning<"runpath search paths missing from %0: '%1'"
  "\n" "警告：运行路径搜索路径从 %0 中缺失：'%1'">, InGroup<InstallAPIViolation>;
def warn_rpaths_mismatch : Warning<"runpath search paths do not match: '%0' (provided) vs '%1' (found)"
  "\n" "警告：运行路径搜索路径不匹配：'%0'（提供）对比 '%1'（找到）">, InGroup<InstallAPIViolation>;
} // end of Verification category.

} // end of InstallAPI component
