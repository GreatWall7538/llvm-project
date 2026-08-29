//==--- DiagnosticCategories.td - Diagnostic Category Definitions ---------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

class CatInlineAsm : DiagCategory<"Inline Assembly Issue" "\n" "内联汇编问题">;
class CatSourceMgr : DiagCategory<"SourceMgr Reported Issue" "\n" "SourceMgr 报告的问题">;
class CatBackend : DiagCategory<"Backend Issue" "\n" "后端问题">;
