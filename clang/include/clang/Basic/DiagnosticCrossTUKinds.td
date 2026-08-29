//==--- DiagnosticCrossTUKinds.td - Cross Translation Unit diagnostics ----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

let Component = "CrossTU" in {

def err_ctu_error_opening : Error<
  "error opening '%0': required by the CrossTU functionality"
  "\n" "错误：打开 '%0' 时出错：CrossTU 功能需要它">;

def err_extdefmap_parsing : Error<
  "error parsing index file: '%0' line: %1 '<USR-Length>:<USR> <File-Path>' "
  "format expected"
  "\n" "错误：解析索引文件出错：'%0' 第 %1 行：应为 '<USR-Length>:<USR> <File-Path>' 格式">;

def err_invlist_parsing : Error<
  "error parsing invocation list file: '%0' line: %1 "
  "'<source-file>: [<compiler>, <arg1>, ...]' YAML mapping format expected"
  "\n" "错误：解析调用列表文件出错：'%0' 第 %1 行："
  "应为 '<source-file>: [<compiler>, <arg1>, ...]' YAML 映射格式">;

def err_multiple_def_index : Error<
  "multiple definitions are found for the same key in index"
  "\n" "错误：索引中为同一键找到了多个定义">;

def warn_multiple_entries_invlist : Warning<
  "multiple invocations for '%0' are found in the invocation list"
  "\n" "警告：在调用列表中找到了针对 '%0' 的多次调用">,
  InGroup<CrossTU>;

def warn_invlist_missing_file : Warning<
  "invocation for '%0' is missing in the invocation list"
  "\n" "警告：调用列表中缺少针对 '%0' 的调用">, InGroup<CrossTU>;

def warn_ctu_incompat_triple : Warning<
  "imported AST from '%0' had been generated for a different target, "
  "current: %1, imported: %2"
  "\n" "警告：从 '%0' 导入的 AST 是为不同的目标生成的，当前：%1，导入：%2">, InGroup<CrossTU>;

def warn_ctu_import_failure : Warning<
  "import of an external symbol for CTU failed: %0"
  "\n" "警告：为 CTU 导入外部符号失败：%0">, InGroup<CrossTU>;

def err_ctu_import_failure: Error<
  "import of an external symbol for CTU failed: %0"
  "\n" "错误：为 CTU 导入外部符号失败：%0">;

def remark_ctu_import_threshold_reached: Remark<
  "reached a the CTU-import threshold before trying to import definition"
  "\n" "备注：在尝试导入定义之前已达到 CTU 导入阈值">,
  InGroup<CrossTURemarks>;

def warn_ctu_incompat_lang : Warning<
  "imported AST from '%0' had been generated for a different language, "
  "current: %1, imported: %2"
  "\n" "警告：从 '%0' 导入的 AST 是为不同的语言生成的，当前：%1，导入：%2">, InGroup<CrossTU>;
}
