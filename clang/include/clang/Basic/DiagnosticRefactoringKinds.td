//==--- DiagnosticRefactoringKinds.td - refactoring diagnostics -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Refactoring Diagnostics
//===----------------------------------------------------------------------===//

let Component = "Refactoring" in {

let CategoryName = "Refactoring Invocation Issue" in {

def err_refactor_no_selection : Error<"refactoring action cannot be initiated "
  "without a selection"
  "\n" "错误：无法在未选择的情况下启动重构操作">;
def err_refactor_selection_no_symbol : Error<"there is no symbol at the given "
  "location"
  "\n" "错误：给定位置没有符号">;
def err_refactor_selection_invalid_ast : Error<"the provided selection does "
  "not overlap with the AST nodes of interest"
  "\n" "错误：提供的选区与感兴趣的 AST 节点不重叠">;

def err_refactor_code_outside_of_function : Error<"the selected code is not a "
  "part of a function's / method's body"
  "\n" "错误：所选代码不是函数/方法体的一部分">;
def err_refactor_extract_simple_expression : Error<"the selected expression "
  "is too simple to extract"
  "\n" "错误：所选表达式过于简单，无法提取">;
def err_refactor_extract_prohibited_expression : Error<"the selected "
  "expression cannot be extracted"
  "\n" "错误：所选表达式无法提取">;

}

} // end of Refactoring diagnostics
