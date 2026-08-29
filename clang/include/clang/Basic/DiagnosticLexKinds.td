//==--- DiagnosticLexKinds.td - liblex diagnostics ------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Lexer Diagnostics
//===----------------------------------------------------------------------===//

let Component = "Lex", CategoryName = "Lexical or Preprocessor Issue" in {

def null_in_char_or_string : Warning<
  "null character(s) preserved in %select{char|string}0 literal"
  "\n" "警告：%select{字符|字符串}0 字面量中保留了空字符">,
  InGroup<NullCharacter>;
def null_in_file : Warning<"null character ignored"
  "\n" "警告：忽略空字符">, InGroup<NullCharacter>;
def warn_nested_block_comment : Warning<"'/*' within block comment"
  "\n" "警告：块注释中包含 '/*'">,
  InGroup<Comment>;
def escaped_newline_block_comment_end : Warning<
  "escaped newline between */ characters at block comment end"
  "\n" "警告：块注释末尾的 */ 字符之间有转义的换行">,
  InGroup<Comment>;
def backslash_newline_space : Warning<
  "backslash and newline separated by space"
  "\n" "警告：反斜杠和换行之间有空格">,
  InGroup<DiagGroup<"backslash-newline-escape">>;

// Digraphs.
def warn_cxx98_compat_less_colon_colon : Warning<
  "'<::' is treated as digraph '<:' (aka '[') followed by ':' in C++98"
  "\n" "警告：在 C++98 中，'<::' 被视为二合字母 '<:'（即 '['）后跟 ':'">,
  InGroup<CXX98Compat>, DefaultIgnore;

def warn_cxx17_compat_spaceship : Warning<
  "'<=>' operator is incompatible with C++ standards before C++20"
  "\n" "警告：'<=>' 运算符与 C++20 之前的 C++ 标准不兼容">,
  InGroup<CXXPre20Compat>, DefaultIgnore;
def warn_cxx20_compat_spaceship : Warning<
  "'<=>' is a single token in C++20; "
  "add a space to avoid a change in behavior"
  "\n" "警告：在 C++20 中 '<=>' 是单个标记；请添加空格以避免行为发生变化">,
  InGroup<CXX20Compat>;

// Trigraphs.
def trigraph_ignored : Warning<"trigraph ignored"
  "\n" "警告：忽略三字符组">, InGroup<Trigraphs>;
def trigraph_ignored_block_comment : Warning<
  "ignored trigraph would end block comment"
  "\n" "警告：被忽略的三字符组会结束块注释">, InGroup<Trigraphs>;
def trigraph_ends_block_comment : Warning<"trigraph ends block comment"
  "\n" "警告：三字符组结束了块注释">,
    InGroup<Trigraphs>;
def trigraph_converted : Warning<"trigraph converted to '%0' character"
  "\n" "警告：三字符组转换为 '%0' 字符">,
    InGroup<Trigraphs>;

def ext_multi_line_line_comment : Extension<"multi-line // comment"
  "\n" "警告：多行 // 注释">,
    InGroup<Comment>;
def ext_line_comment : Extension<
  "// comments are not allowed in this language"
  "\n" "警告：此语言不允许 // 注释">,
  InGroup<Comment>;
def warn_no_newline_eof : Warning<"no newline at end of file"
  "\n" "警告：文件末尾没有换行">,
  InGroup<NewlineEOF>, DefaultIgnore;

def ext_dollar_in_identifier : Extension<"'$' in identifier"
  "\n" "警告：标识符中出现 '$'">,
  InGroup<DiagGroup<"dollar-in-identifier-extension">>;
def ext_charize_microsoft : Extension<
  "charizing operator #@ is a Microsoft extension"
  "\n" "警告：字符化运算符 #@ 是 Microsoft 扩展">,
  InGroup<MicrosoftCharize>;
def ext_comment_paste_microsoft : Extension<
  "pasting two '/' tokens into a '//' comment is a Microsoft extension"
  "\n" "警告：将两个 '/' 标记粘贴成 '//' 注释是 Microsoft 扩展">,
  InGroup<MicrosoftCommentPaste>;
def ext_ctrl_z_eof_microsoft : Extension<
  "treating Ctrl-Z as end-of-file is a Microsoft extension"
  "\n" "警告：将 Ctrl-Z 视为文件末尾是 Microsoft 扩展">,
  InGroup<MicrosoftEndOfFile>;

def ext_token_used : Extension<"extension used"
  "\n" "警告：使用了扩展">,
  InGroup<DiagGroup<"language-extension-token">>;

def warn_cxx11_keyword : Warning<"'%0' is a keyword in C++11"
  "\n" "警告：'%0' 是 C++11 中的关键字">,
  InGroup<CXX11Compat>, DefaultIgnore;
def warn_cxx20_keyword : Warning<"'%0' is a keyword in C++20"
  "\n" "警告：'%0' 是 C++20 中的关键字">,
  InGroup<CXX20Compat>, DefaultIgnore;
def warn_c99_keyword : Warning<"'%0' is a keyword in C99"
  "\n" "警告：'%0' 是 C99 中的关键字">,
  InGroup<C99Compat>, DefaultIgnore;
def warn_c23_keyword : Warning<"'%0' is a keyword in C23"
  "\n" "警告：'%0' 是 C23 中的关键字">,
  InGroup<C23Compat>, DefaultIgnore;

def ext_unterminated_char_or_string : ExtWarn<
  "missing terminating %select{'|'\"'}0 character"
  "\n" "警告：缺少终止 %select{'|'\"'}0 字符">, InGroup<InvalidPPToken>;
def ext_empty_character : ExtWarn<"empty character constant"
  "\n" "警告：空字符常量">,
  InGroup<InvalidPPToken>;
def err_unterminated_block_comment : Error<"unterminated /* comment"
  "\n" "错误：未终止的 /* 注释">;
def err_invalid_character_to_charify : Error<
  "invalid argument to convert to character"
  "\n" "错误：要转换为字符的实参无效">;
def err_unterminated___pragma : Error<"missing terminating ')' character"
  "\n" "错误：缺少终止的 ')' 字符">;

def err_conflict_marker : Error<"version control conflict marker in file"
  "\n" "错误：文件中存在版本控制冲突标记">;

def err_counter_overflow : Error<
  "'__COUNTER__' value cannot exceed 2'147'483'647"
  "\n" "错误：'__COUNTER__' 的值不能超过 2'147'483'647">;
def ext_counter : Extension<
  "'__COUNTER__' is a C2y extension"
  "\n" "警告：'__COUNTER__' 是 C2y 扩展">, InGroup<C2y>, SuppressInSystemMacro;
def warn_counter : Warning<
  "'__COUNTER__' is incompatible with standards before C2y"
  "\n" "警告：'__COUNTER__' 与 C2y 之前的标准不兼容">,
  InGroup<CPre2yCompat>, DefaultIgnore, SuppressInSystemMacro;

def err_raw_delim_too_long : Error<
  "raw string delimiter longer than 16 characters"
  "; use PREFIX( )PREFIX to delimit raw string"
  "\n" "错误：原始字符串分隔符超过 16 个字符"
  "；请使用 PREFIX( )PREFIX 界定原始字符串">;
def err_invalid_char_raw_delim : Error<
  "invalid character '%0' in raw string delimiter"
  "; use PREFIX( )PREFIX to delimit raw string"
  "\n" "错误：原始字符串分隔符中有无效字符 '%0'"
  "；请使用 PREFIX( )PREFIX 界定原始字符串">;
def err_invalid_newline_raw_delim : Error<
  "invalid newline character in raw string delimiter"
  "; use PREFIX( )PREFIX to delimit raw string"
  "\n" "错误：原始字符串分隔符中有无效的换行字符"
  "；请使用 PREFIX( )PREFIX 界定原始字符串">;
def err_unterminated_raw_string : Error<
  "raw string missing terminating delimiter )%0\""
  "\n" "错误：原始字符串缺少终止分隔符 )%0\"">;
def warn_cxx98_compat_raw_string_literal : Warning<
  "raw string literals are incompatible with C++98"
  "\n" "警告：原始字符串字面量与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;

def warn_cxx26_compat_raw_string_literal_character_set : Warning<
  " '%0' in a raw string literal delimiter is incompatible "
  "with standards before C++2c"
  "\n" "警告：原始字符串字面量分隔符中的 '%0' 与 C++2c 之前的标准不兼容">,
  InGroup<CXXPre26Compat>, DefaultIgnore;
def ext_cxx26_raw_string_literal_character_set : Extension<
  " '%0' in a raw string literal delimiter is a C++2c extension"
  "\n" "警告：原始字符串字面量分隔符中的 '%0' 是 C++2c 扩展">,
  InGroup<CXX26>, DefaultIgnore;

def warn_multichar_character_literal : Warning<
  "multi-character character constant"
  "\n" "警告：多字符字符常量">, InGroup<MultiChar>;
def warn_four_char_character_literal : Warning<
  "multi-character character constant"
  "\n" "警告：多字符字符常量">, InGroup<FourByteMultiChar>, DefaultIgnore;


// Unicode and UCNs
def err_invalid_utf8 : Error<
  "source file is not valid UTF-8"
  "\n" "错误：源文件不是有效的 UTF-8">;
def warn_invalid_utf8_in_comment : Extension<
  "invalid UTF-8 in comment"
  "\n" "警告：注释中有无效的 UTF-8">, InGroup<DiagGroup<"invalid-utf8">>;
def err_character_not_allowed : Error<
  "unexpected character <U+%0>"
  "\n" "错误：意外的字符 <U+%0>">;
def err_character_not_allowed_identifier : Error<
  "character <U+%0> not allowed %select{in|at the start of}1 an identifier"
  "\n" "错误：字符 <U+%0> 不允许出现在标识符%select{中|的开头}1">;
def ext_unicode_whitespace : ExtWarn<
  "treating Unicode character as whitespace"
  "\n" "警告：将 Unicode 字符视为空白">,
  InGroup<DiagGroup<"unicode-whitespace">>;
def warn_utf8_symbol_homoglyph : Warning<
  "treating Unicode character <U+%0> as an identifier character rather than "
  "as '%1' symbol"
  "\n" "警告：将 Unicode 字符 <U+%0> 视为标识符字符，而不是 '%1' 符号">, InGroup<DiagGroup<"unicode-homoglyph">>;
def warn_utf8_symbol_zero_width : Warning<
  "identifier contains Unicode character <U+%0> that is invisible in "
  "some environments"
  "\n" "警告：标识符包含在某些环境中不可见的 Unicode 字符 <U+%0>">, InGroup<DiagGroup<"unicode-zero-width">>;
def ext_mathematical_notation : ExtWarn<
  "mathematical notation character <U+%0> in an identifier is a Clang extension"
  "\n" "警告：标识符中的数学记法字符 <U+%0> 是 Clang 扩展">,
  InGroup<DiagGroup<"mathematical-notation-identifier-extension">>;

def ext_delimited_escape_sequence : Extension<
  "%select{delimited|named}0 escape sequences are a %select{C++23|C2y|Clang}1 "
  "extension"
  "\n" "警告：%select{分隔|具名}0 转义序列是%select{C++23|C2y|Clang}1 扩展">, InGroup<DiagGroup<"delimited-escape-sequence-extension">>;
def warn_cxx23_delimited_escape_sequence : Warning<
  "%select{delimited|named}0 escape sequences are incompatible with C++ "
  "standards before C++23"
  "\n" "警告：%select{分隔|具名}0 转义序列与 C++23 之前的 C++ 标准不兼容">, InGroup<CXXPre23Compat>, DefaultIgnore;
def warn_c2y_delimited_escape_sequence : Warning<
  "delimited escape sequences are incompatible with C standards before C2y"
  "\n" "警告：分隔转义序列与 C2y 之前的 C 标准不兼容">,
  InGroup<CPre2yCompat>, DefaultIgnore;

def err_delimited_escape_empty : Error<
  "delimited escape sequence cannot be empty"
  "\n" "错误：分隔转义序列不能为空">;
def err_delimited_escape_missing_brace: Error<
  "expected '{' after '\\%0' escape sequence"
  "\n" "错误：'\\%0' 转义序列后应为 '{'">;
def err_delimited_escape_invalid : Error<
  "invalid digit '%0' in escape sequence"
  "\n" "错误：转义序列中有无效的数字 '%0'">;
def err_hex_escape_no_digits : Error<
  "\\%0 used with no following hex digits"
  "\n" "错误：\\%0 后面没有十六进制数字">;
def err_invalid_ucn_name : Error<
  "'%0' is not a valid Unicode character name"
  "\n" "错误：'%0' 不是有效的 Unicode 字符名称">;
def note_invalid_ucn_name_loose_matching : Note<
  "character names in Unicode escape sequences are sensitive to case and whitespaces"
  "\n" "提示：Unicode 转义序列中的字符名称区分大小写和空白">;
def note_invalid_ucn_name_candidate : Note<
  "did you mean %0 (%1)?"
  "\n" "提示：您是指 %0 (%1) 吗？">;
def note_invalid_ucn_name_character : Note<
  "character %0 cannot appear in a Unicode character name"
  "\n" "提示：字符 %0 不能出现在 Unicode 字符名称中">;

def warn_ucn_escape_no_digits : Warning<
  "\\%0 used with no following hex digits; "
  "treating as '\\' followed by identifier"
  "\n" "警告：\\%0 后面没有十六进制数字；将其视为 '\\' 后跟标识符">, InGroup<Unicode>;
def err_ucn_escape_incomplete : Error<
  "incomplete universal character name"
  "\n" "错误：不完整的通用字符名称">;
def warn_delimited_ucn_incomplete : Warning<
  "incomplete delimited universal character name; "
  "treating as '\\' '%0' '{' identifier"
  "\n" "警告：不完整的带分隔符通用字符名称；将其视为 '\\' '%0' '{' 标识符">, InGroup<Unicode>;
def warn_delimited_ucn_empty : Warning<
  "empty delimited universal character name; "
  "treating as '\\' '%0' '{' '}'"
  "\n" "警告：空的带分隔符通用字符名称；将其视为 '\\' '%0' '{' '}'">, InGroup<Unicode>;
def warn_ucn_escape_incomplete : Warning<
  "incomplete universal character name; "
  "treating as '\\' followed by identifier"
  "\n" "警告：不完整的通用字符名称；将其视为 '\\' 后跟标识符">, InGroup<Unicode>;
def note_ucn_four_not_eight : Note<"did you mean to use '\\u'?"
  "\n" "提示：您是指使用 '\\u' 吗？">;

def err_ucn_escape_basic_scs : Error<
  "character '%0' cannot be specified by a universal character name"
  "\n" "错误：字符 '%0' 不能通过通用字符名称指定">;
def err_ucn_control_character : Error<
  "universal character name refers to a control character"
  "\n" "错误：通用字符名称引用了控制字符">;
def err_ucn_escape_invalid : Error<"invalid universal character"
  "\n" "错误：无效的通用字符">;
def warn_ucn_escape_surrogate : Warning<
  "universal character name refers to a surrogate character"
  "\n" "警告：通用字符名称引用了代理字符">,
  InGroup<Unicode>;

def warn_c99_compat_unicode_id : Warning<
  "%select{using this character in an identifier|starting an identifier with "
  "this character}0 is incompatible with C99"
  "\n" "警告：%select{在标识符中使用此字符|用此字符开始一个标识符}0与 C99 不兼容">,
  InGroup<C99Compat>, DefaultIgnore;

def warn_cxx98_compat_literal_ucn_escape_basic_scs : Warning<
  "specifying character '%0' with a universal character name "
  "is incompatible with C++98"
  "\n" "警告：用通用字符名称指定字符 '%0' 与 C++98 不兼容">, InGroup<CXX98Compat>, DefaultIgnore;
def warn_cxx98_compat_literal_ucn_control_character : Warning<
  "universal character name referring to a control character "
  "is incompatible with C++98"
  "\n" "警告：引用控制字符的通用字符名称与 C++98 不兼容">, InGroup<CXX98Compat>, DefaultIgnore;
def warn_c23_compat_literal_ucn_escape_basic_scs : Warning<
  "specifying character '%0' with a universal character name is "
  "incompatible with C standards before C23"
  "\n" "警告：用通用字符名称指定字符 '%0' 与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def warn_c23_compat_literal_ucn_control_character : Warning<
  "universal character name referring to a control character "
  "is incompatible with C standards before C23"
  "\n" "警告：引用控制字符的通用字符名称与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def warn_ucn_not_valid_in_c89 : Warning<
  "universal character names are only valid in C99 or C++; "
  "treating as '\\' followed by identifier"
  "\n" "警告：通用字符名称仅在 C99 或 C++ 中有效；将其视为 '\\' 后跟标识符">, InGroup<Unicode>;
def warn_ucn_not_valid_in_c89_literal : ExtWarn<
  "universal character names are only valid in C99 or C++"
  "\n" "警告：通用字符名称仅在 C99 或 C++ 中有效">, InGroup<Unicode>;


// Literal
def ext_nonstandard_escape : Extension<
  "use of non-standard escape character '\\%0'"
  "\n" "警告：使用了非标准的转义字符 '\\%0'">;
def ext_unknown_escape : ExtWarn<"unknown escape sequence '\\%0'"
  "\n" "警告：未知的转义序列 '\\%0'">,
  InGroup<DiagGroup<"unknown-escape-sequence">>;
def err_invalid_digit : Error<
  "invalid digit '%0' in %select{decimal|octal|binary}1 constant"
  "\n" "错误：%select{十进制|八进制|二进制}1 常量中有无效的数字 '%0'">;
def err_invalid_suffix_constant : Error<
  "invalid suffix '%0' on %select{integer|floating|fixed-point}1 constant"
  "\n" "错误：%select{整数|浮点|定点}1 常量上的后缀 '%0' 无效">;
def warn_cxx11_compat_digit_separator : Warning<
  "digit separators are incompatible with C++ standards before C++14"
  "\n" "警告：数字分隔符与 C++14 之前的 C++ 标准不兼容">,
  InGroup<CXXPre14Compat>, DefaultIgnore;
def warn_c23_compat_digit_separator : Warning<
  "digit separators are incompatible with C standards before C23"
  "\n" "警告：数字分隔符与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def err_digit_separator_not_between_digits : Error<
  "digit separator cannot appear at %select{start|end}0 of digit sequence"
  "\n" "错误：数字分隔符不能出现在数字序列的%select{开头|末尾}0">;
def warn_char_constant_too_large : Warning<
  "character constant too long for its type"
  "\n" "警告：字符常量对其类型来说过长">;
def err_multichar_character_literal : Error<
  "%select{wide|Unicode}0 character literals may not contain multiple characters"
  "\n" "错误：%select{宽|Unicode}0 字符字面量不能包含多个字符">;
def err_exponent_has_no_digits : Error<"exponent has no digits"
  "\n" "错误：指数没有数字">;
def err_hex_constant_requires : Error<
  "hexadecimal floating %select{constant|literal}0 requires "
  "%select{an exponent|a significand}1"
  "\n" "错误：十六进制浮点%select{常量|字面量}0需要%select{指数|有效数字}1">;
def ext_hex_constant_invalid : Extension<
  "hexadecimal floating constants are a C99 feature"
  "\n" "警告：十六进制浮点常量是 C99 特性">, InGroup<C99>;
def ext_hex_literal_invalid : Extension<
  "hexadecimal floating literals are a C++17 feature"
  "\n" "警告：十六进制浮点字面量是 C++17 特性">, InGroup<CXX17>;
def warn_cxx17_hex_literal : Warning<
  "hexadecimal floating literals are incompatible with "
  "C++ standards before C++17"
  "\n" "警告：十六进制浮点字面量与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17CompatPedantic>, DefaultIgnore;
def ext_octal_literal : Extension<
  "octal integer literals are a C2y extension"
  "\n" "警告：八进制整数字面量是 C2y 扩展">, InGroup<C2y>;
def ext_cpp_octal_literal : Extension<
  "octal integer literals are a Clang extension"
  "\n" "警告：八进制整数字面量是 Clang 扩展">,
  InGroup<DiagGroup<"octal-prefix-extension">>;
def warn_c2y_compat_octal_literal : Warning<
  "octal integer literals are incompatible with standards before C2y"
  "\n" "警告：八进制整数字面量与 C2y 之前的标准不兼容">,
  InGroup<CPre2yCompat>, DefaultIgnore;
def warn_unprefixed_octal_deprecated : Warning<
  "octal literals without a '0o' prefix are deprecated"
  "\n" "警告：不带 '0o' 前缀的八进制字面量已弃用">,
  InGroup<DeprecatedOctalLiterals>;
def ext_binary_literal : Extension<
  "binary integer literals are a C23 extension"
  "\n" "警告：二进制整数字面量是 C23 扩展">, InGroup<C23>;
def warn_c23_compat_binary_literal : Warning<
  "binary integer literals are incompatible with C standards before C23"
  "\n" "警告：二进制整数字面量与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def ext_binary_literal_cxx14 : Extension<
  "binary integer literals are a C++14 extension"
  "\n" "警告：二进制整数字面量是 C++14 扩展">, InGroup<CXX14BinaryLiteral>;
def warn_cxx11_compat_binary_literal : Warning<
  "binary integer literals are incompatible with C++ standards before C++14"
  "\n" "警告：二进制整数字面量与 C++14 之前的 C++ 标准不兼容">,
  InGroup<CXXPre14CompatBinaryLiteral>, DefaultIgnore;
def err_pascal_string_too_long : Error<"Pascal string is too long"
  "\n" "错误：Pascal 字符串太长">;
def err_escape_too_large : Error<
  "%select{hex|octal}0 escape sequence out of range"
  "\n" "错误：%select{十六进制|八进制}0 转义序列超出范围">;
def ext_string_too_long : Extension<"string literal of length %0 exceeds "
  "maximum length %1 that %select{C90|ISO C99|C++}2 compilers are required to "
  "support"
  "\n" "警告：长度为 %0 的字符串字面量超过了%select{C90|ISO C99|C++}2 编译器须支持的最大长度 %1">, InGroup<OverlengthStrings>;
def err_character_too_large : Error<
  "character too large for enclosing character literal type"
  "\n" "错误：字符对于包含它的字符字面量类型来说过大">;
def err_exec_charset_conversion_failed
    : Error<"conversion to literal encoding failed: '%0'"
  "\n" "错误：转换为字面量编码失败：'%0'">;
def warn_c99_compat_unicode_literal : Warning<
  "unicode literals are incompatible with C99"
  "\n" "警告：Unicode 字面量与 C99 不兼容">,
  InGroup<C99Compat>, DefaultIgnore;
def warn_cxx98_compat_unicode_literal : Warning<
  "unicode literals are incompatible with C++98"
  "\n" "警告：Unicode 字面量与 C++98 不兼容">,
  InGroup<CXX98Compat>, DefaultIgnore;
def warn_cxx14_compat_u8_character_literal : Warning<
  "unicode literals are incompatible with C++ standards before C++17"
  "\n" "警告：Unicode 字面量与 C++17 之前的 C++ 标准不兼容">,
  InGroup<CXXPre17Compat>, DefaultIgnore;
def warn_c17_compat_u8_character_literal : Warning<
  "unicode literals are incompatible with C standards before C23"
  "\n" "警告：Unicode 字面量与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def warn_cxx11_compat_user_defined_literal : Warning<
  "identifier after literal will be treated as a user-defined literal suffix "
  "in C++11"
  "\n" "警告：在 C++11 中，字面量后的标识符将被视为用户定义字面量后缀">, InGroup<CXX11Compat>, DefaultIgnore;
def warn_cxx11_compat_reserved_user_defined_literal : Warning<
  "identifier after literal will be treated as a reserved user-defined literal "
  "suffix in C++11"
  "\n" "警告：在 C++11 中，字面量后的标识符将被视为保留的用户定义字面量后缀">,
  InGroup<CXX11CompatReservedUserDefinedLiteral>, DefaultIgnore;
def ext_reserved_user_defined_literal : ExtWarn<
  "invalid suffix on literal; C++11 requires a space between literal and "
  "identifier"
  "\n" "警告：字面量上的后缀无效；C++11 要求在字面量和标识符之间有空格">, InGroup<ReservedUserDefinedLiteral>, DefaultError;
def ext_ms_reserved_user_defined_literal : ExtWarn<
  "invalid suffix on literal; C++11 requires a space between literal and "
  "identifier"
  "\n" "警告：字面量上的后缀无效；C++11 要求在字面量和标识符之间有空格">, InGroup<ReservedUserDefinedLiteral>;
def err_unsupported_string_concat : Error<
  "unsupported non-standard concatenation of string literals"
  "\n" "错误：不支持的字符串字面量非标准连接">;

def warn_unevaluated_string_prefix : Warning<
  "encoding prefix '%0' on an unevaluated string literal has no effect"
  "%select{| and is incompatible with c++2c}1"
  "\n" "警告：不求值字符串字面量上的编码前缀 '%0' 没有效果"
  "%select{|，并且与 c++2c 不兼容}1">,
  InGroup<DiagGroup<"invalid-unevaluated-string">>;
def err_unevaluated_string_prefix : Error<
  "an unevaluated string literal cannot have an encoding prefix"
  "\n" "错误：不求值字符串字面量不能有编码前缀">;
def err_unevaluated_string_udl : Error<
  "an unevaluated string literal cannot be a user-defined literal"
  "\n" "错误：不求值字符串字面量不能是用户定义字面量">;
def err_unevaluated_string_invalid_escape_sequence : Error<
  "invalid escape sequence '%0' in an unevaluated string literal"
  "\n" "错误：不求值字符串字面量中有无效的转义序列 '%0'">;
def err_string_concat_mixed_suffix : Error<
  "differing user-defined suffixes ('%0' and '%1') in string literal "
  "concatenation"
  "\n" "错误：字符串字面量连接中有不同的用户定义后缀（'%0' 和 '%1'）">;
def err_pp_invalid_udl : Error<
  "%select{character|integer}0 literal with user-defined suffix "
  "cannot be used in preprocessor constant expression"
  "\n" "错误：带用户定义后缀的%select{字符|整数}0 字面量不能用于预处理器常量表达式">;
def err_bad_string_encoding : Error<
  "illegal character encoding in string literal"
  "\n" "错误：字符串字面量中有非法的字符编码">;
def warn_bad_string_encoding : ExtWarn<
  "illegal character encoding in string literal"
  "\n" "警告：字符串字面量中有非法的字符编码">,
  InGroup<InvalidSourceEncoding>;
def err_bad_character_encoding : Error<
  "illegal character encoding in character literal"
  "\n" "错误：字符字面量中有非法的字符编码">;
def warn_bad_character_encoding : ExtWarn<
  "illegal character encoding in character literal"
  "\n" "警告：字符字面量中有非法的字符编码">,
  InGroup<InvalidSourceEncoding>;
def err_lexing_string : Error<"failure when lexing a string literal"
  "\n" "错误：词法分析字符串字面量时失败">;
def err_lexing_char : Error<"failure when lexing a character literal"
  "\n" "错误：词法分析字符字面量时失败">;
def err_lexing_numeric : Error<"failure when lexing a numeric literal"
  "\n" "错误：词法分析数字字面量时失败">;
def err_placeholder_in_source : Error<"editor placeholder in source file"
  "\n" "错误：源文件中存在编辑器占位符">;

//===----------------------------------------------------------------------===//
// Preprocessor Diagnostics
//===----------------------------------------------------------------------===//

let CategoryName = "User-Defined Issue" in {
def pp_hash_warning : Warning<"%0"
  "\n" "警告：%0">,
  InGroup<PoundWarning>, ShowInSystemHeader;
def err_pp_hash_error : Error<"%0"
  "\n" "错误：%0">;
}

def pp_include_next_in_primary : Warning<
  "#include_next in primary source file; "
  "will search from start of include path"
  "\n" "警告：主源文件中的 #include_next；将从包含路径的开头开始搜索">,
  InGroup<DiagGroup<"include-next-outside-header">>;
def pp_include_macros_out_of_predefines : Error<
  "the #__include_macros directive is only for internal use by -imacros"
  "\n" "错误：#__include_macros 指令仅供 -imacros 内部使用">;
def pp_include_next_absolute_path : Warning<
  "#include_next in file found relative to primary source file or found by "
  "absolute path; will search from start of include path"
  "\n" "警告：相对于主源文件找到的文件或按绝对路径找到的文件中的 #include_next；将从包含路径的开头开始搜索">,
  InGroup<DiagGroup<"include-next-absolute-path">>;
def ext_c99_whitespace_required_after_macro_name : ExtWarn<
  "ISO C99 requires whitespace after the macro name"
  "\n" "警告：ISO C99 要求在宏名称后有空白">, InGroup<C99>;
def ext_missing_whitespace_after_macro_name : ExtWarn<
  "whitespace required after macro name"
  "\n" "警告：宏名称后需要空白">;
def warn_missing_whitespace_after_macro_name : Warning<
  "whitespace recommended after macro name"
  "\n" "警告：建议在宏名称后添加空白">;

class NonportablePath : Warning<
  "non-portable path to file '%0'; specified path differs in case from file"
  " name on disk"
  "\n" "警告：文件 '%0' 的路径不可移植；指定路径与磁盘上的文件名大小写不同">;
def pp_nonportable_path : NonportablePath,
  InGroup<NonportableIncludePath>;
def pp_nonportable_system_path : NonportablePath, DefaultIgnore,
  InGroup<NonportableSystemIncludePath>;

class NonportablePathTrailing : Warning<
  "non-portable path to file '%0'; specified path contains trailing"
  " %select{whitespace|dot}1"
  "\n" "警告：文件 '%0' 的路径不可移植；指定路径包含尾部%select{空白|点}1">;
def pp_nonportable_path_trailing : NonportablePathTrailing,
  InGroup<NonportableIncludePath>;
def pp_nonportable_system_path_trailing : NonportablePathTrailing, DefaultIgnore,
  InGroup<NonportableSystemIncludePath>;
def pp_nonportable_path_separator : Warning<
  "non-portable path to file '%0'; specified path contains backslashes"
  "\n" "警告：文件 '%0' 的路径不可移植；指定路径包含反斜杠">,
  DefaultIgnore, InGroup<NonportableIncludePathSeparator>;

def pp_pragma_once_in_main_file : Warning<"#pragma once in main file"
  "\n" "警告：主文件中的 #pragma once">,
  InGroup<DiagGroup<"pragma-once-outside-header">>;
def pp_pragma_sysheader_in_main_file : Warning<
  "#pragma system_header ignored in main file"
  "\n" "警告：主文件中的 #pragma system_header 被忽略">,
  InGroup<DiagGroup<"pragma-system-header-outside-header">>;

def err_illegal_use_of_flt_eval_macro : Error<
  "'__FLT_EVAL_METHOD__' cannot be expanded inside a scope containing "
  "'#pragma clang fp eval_method'"
  "\n" "错误：'__FLT_EVAL_METHOD__' 不能在包含 '#pragma clang fp eval_method' 的作用域内展开">;

def pp_poisoning_existing_macro : Warning<"poisoning existing macro"
  "\n" "警告：正在污染现有宏">;
def pp_out_of_date_dependency : Warning<
  "current file is older than dependency %0"
  "\n" "警告：当前文件比依赖 %0 更旧">;
def ext_pp_undef_builtin_macro : ExtWarn<"undefining builtin macro"
  "\n" "警告：正在取消定义内置宏">,
  InGroup<BuiltinMacroRedefined>;
def ext_pp_redef_builtin_macro : ExtWarn<"redefining builtin macro"
  "\n" "警告：正在重新定义内置宏">,
  InGroup<BuiltinMacroRedefined>;
def pp_disabled_macro_expansion : Warning<
  "disabled expansion of recursive macro"
  "\n" "警告：已禁用递归宏的展开">, DefaultIgnore,
  InGroup<DiagGroup<"disabled-macro-expansion">>;
def pp_macro_not_used : Warning<"macro is not used"
  "\n" "警告：宏未被使用">, DefaultIgnore,
  InGroup<DiagGroup<"unused-macros">>;
def warn_pp_undef_identifier : Warning<
  "%0 is not defined, evaluates to 0"
  "\n" "警告：%0 未定义，求值为 0">,
  InGroup<UndefinedIdentifier>, DefaultIgnore;
def warn_pp_undef_true_identifier : Warning<
  "'true' is not defined, evaluates to 0"
  "\n" "警告：'true' 未定义，求值为 0">,
  InGroup<UndefinedTrueIdentifier>;
def warn_pp_undef_prefix : Warning<
  "%0 is not defined, evaluates to 0"
  "\n" "警告：%0 未定义，求值为 0">,
  InGroup<DiagGroup<"undef-prefix">>, DefaultIgnore;
def warn_pp_ambiguous_macro : Warning<
  "ambiguous expansion of macro %0"
  "\n" "警告：宏 %0 的展开有歧义">, InGroup<AmbiguousMacro>;
def note_pp_ambiguous_macro_chosen : Note<
  "expanding this definition of %0"
  "\n" "提示：正在展开 %0 的这个定义">;
def note_pp_ambiguous_macro_other : Note<
  "other definition of %0"
  "\n" "提示：%0 的另一个定义">;
def warn_pp_macro_hides_keyword : Extension<
  "keyword is hidden by macro definition"
  "\n" "警告：关键字被宏定义隐藏">, InGroup<KeywordAsMacro>;
def warn_pp_macro_is_reserved_id : Warning<
  "macro name is a reserved identifier"
  "\n" "警告：宏名称是保留标识符">, DefaultIgnore,
  InGroup<ReservedIdAsMacro>;
def warn_pp_macro_is_reserved_attribute_id : Warning<
  "%0 is a reserved attribute identifier"
  "\n" "警告：%0 是保留的特性标识符">, DefaultIgnore,
  InGroup<ReservedAttributeIdentifier>;
def warn_pp_objc_macro_redef_ignored : Warning<
  "ignoring redefinition of Objective-C qualifier macro"
  "\n" "警告：忽略 Objective-C 限定符宏的重新定义">,
  InGroup<DiagGroup<"objc-macro-redefinition">>;
def warn_pp_identifier_is_cpp_keyword : Warning<
  "identifier %0 conflicts with a C++ keyword"
  "\n" "警告：标识符 %0 与 C++ 关键字冲突">,
  InGroup<CppKeywordInC>, DefaultIgnore;

def pp_invalid_string_literal : Warning<
  "invalid string literal, ignoring final '\\'"
  "\n" "警告：无效的字符串字面量，忽略末尾的 '\\'">;
def warn_pp_expr_overflow : Warning<
  "integer overflow in preprocessor expression"
  "\n" "警告：预处理器表达式中的整数溢出">;
def warn_pp_convert_to_positive : Warning<
  "%select{left|right}0 side of operator converted from negative value to "
  "unsigned: %1"
  "\n" "警告：运算符的%select{左|右}0侧从负值转换为无符号值：%1">;

def ext_pp_import_directive : Extension<"#import is a language extension"
  "\n" "警告：#import 是语言扩展">,
  InGroup<DiagGroup<"import-preprocessor-directive-pedantic">>;
def err_pp_import_directive_ms : Error<
  "#import of type library is an unsupported Microsoft feature"
  "\n" "错误：#import 类型库是不受支持的 Microsoft 特性">;
def ext_pp_include_search_ms : ExtWarn<
  "#include resolved using non-portable Microsoft search rules as: %0"
  "\n" "警告：#include 使用不可移植的 Microsoft 搜索规则解析为：%0">,
  InGroup<MicrosoftInclude>;

def ext_pp_ident_directive : Extension<"#ident is a language extension"
  "\n" "警告：#ident 是语言扩展">;
def ext_pp_include_next_directive : Extension<
  "#include_next is a language extension"
  "\n" "警告：#include_next 是语言扩展">, InGroup<GNUIncludeNext>;

def ext_pp_warning_directive : Extension<
  "#warning is a %select{C23|C++23}0 extension"
  "\n" "警告：#warning 是%select{C23|C++23}0 扩展">;
def warn_cxx23_compat_warning_directive : Warning<
  "#warning is incompatible with C++ standards before C++23"
  "\n" "警告：#warning 与 C++23 之前的 C++ 标准不兼容">,
  InGroup<CXXPre23Compat>, DefaultIgnore;
def warn_c23_compat_warning_directive : Warning<
  "#warning is incompatible with C standards before C23"
  "\n" "警告：#warning 与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def ext_pp_embed_directive : ExtWarn<
  "#embed is a %select{C23|Clang}0 extension"
  "\n" "警告：#embed 是%select{C23|Clang}0 扩展">,
  InGroup<C23>;
def warn_compat_pp_embed_directive : Warning<
  "#embed is incompatible with C standards before C23"
  "\n" "警告：#embed 与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def err_pp_embed_dup_params : Error<
  "cannot specify parameter '%0' twice in the same '#embed' directive"
  "\n" "错误：不能在同一个 '#embed' 指令中两次指定参数 '%0'">;
def err_pp_embed_device_file : Error<
  "device files are not yet supported by '#embed' directive"
  "\n" "错误：'#embed' 指令尚不支持设备文件">;

def ext_pp_extra_tokens_at_eol : ExtWarn<
  "extra tokens at end of #%0 directive"
  "\n" "警告：#%0 指令末尾有额外的标记">, InGroup<ExtraTokens>;

def ext_pp_comma_expr : Extension<"comma operator in operand of #if"
  "\n" "警告：#if 的操作数中有逗号运算符">;
def ext_pp_bad_vaargs_use : Extension<
  "__VA_ARGS__ can only appear in the expansion of a C99 variadic macro"
  "\n" "警告：__VA_ARGS__ 只能出现在 C99 可变参数宏的展开中">;

def ext_pp_bad_vaopt_use
    : ExtWarn<
          "__VA_OPT__ can only appear in the expansion of a variadic macro"
          "\n" "警告：__VA_OPT__ 只能出现在可变参数宏的展开中">,
      InGroup<VariadicMacros>;

def err_pp_missing_lparen_in_vaopt_use : Error<
  "missing '(' following __VA_OPT__"
  "\n" "错误：__VA_OPT__ 后缺少 '('">;
def err_pp_vaopt_nested_use : Error<
  "__VA_OPT__ cannot be nested within its own replacement tokens"
  "\n" "错误：__VA_OPT__ 不能嵌套在其自身的替换标记中">;

def err_vaopt_paste_at_start : Error<
  "'##' cannot appear at start of __VA_OPT__ argument"
  "\n" "错误：'##' 不能出现在 __VA_OPT__ 实参的开头">;

def err_vaopt_paste_at_end
    : Error<"'##' cannot appear at end of __VA_OPT__ argument"
  "\n" "错误：'##' 不能出现在 __VA_OPT__ 实参的末尾">;

def ext_pp_macro_redef : ExtWarn<"%0 macro redefined"
  "\n" "警告：宏 %0 被重新定义">, InGroup<MacroRedefined>;
def ext_variadic_macro : Extension<"variadic macros are a C99 feature"
  "\n" "警告：可变参数宏是 C99 特性">,
  InGroup<VariadicMacros>;
def warn_cxx98_compat_variadic_macro : Warning<
  "variadic macros are incompatible with C++98"
  "\n" "警告：可变参数宏与 C++98 不兼容">,
  InGroup<CXX98CompatPedantic>, DefaultIgnore;
def ext_named_variadic_macro : Extension<
  "named variadic macros are a GNU extension"
  "\n" "警告：具名可变参数宏是 GNU 扩展">, InGroup<VariadicMacros>;
def err_embedded_directive : Error<"embedding a %select{|#}0%1 directive "
                                   "within macro arguments is not supported"
  "\n" "错误：不支持在宏实参内嵌入%select{|#}0%1 指令">;
def ext_embedded_directive : Extension<
  "embedding a directive within macro arguments has undefined behavior"
  "\n" "警告：在宏实参内嵌入指令具有未定义行为">,
  InGroup<DiagGroup<"embedded-directive">>;
def ext_c_missing_varargs_arg : Extension<
  "passing no argument for the '...' parameter of a variadic macro is "
  "a C23 extension"
  "\n" "警告：不为可变参数宏的 '...' 参数传实参是 C23 扩展">, InGroup<VariadicMacroArgumentsOmitted>;
def ext_cxx_missing_varargs_arg : Extension<
  "passing no argument for the '...' parameter of a variadic macro is "
  "a C++20 extension"
  "\n" "警告：不为可变参数宏的 '...' 参数传实参是 C++20 扩展">, InGroup<VariadicMacroArgumentsOmitted>;
def warn_c17_compat_missing_varargs_arg : Warning<
  "passing no argument for the '...' parameter of a variadic macro is "
  "incompatible with C standards before C23"
  "\n" "警告：不为可变参数宏的 '...' 参数传实参与 C23 之前的 C 标准不兼容">,
  InGroup<VariadicMacroArgumentsOmitted>, DefaultIgnore;
def warn_cxx17_compat_missing_varargs_arg : Warning<
  "passing no argument for the '...' parameter of a variadic macro is "
  "incompatible with C++ standards before C++20"
  "\n" "警告：不为可变参数宏的 '...' 参数传实参与 C++20 之前的 C++ 标准不兼容">,
  InGroup<CXXPre20Compat>, DefaultIgnore;
def ext_empty_fnmacro_arg : Extension<
  "empty macro arguments are a C99 feature"
  "\n" "警告：空宏实参是 C99 特性">, InGroup<C99>;
def warn_cxx98_compat_empty_fnmacro_arg : Warning<
  "empty macro arguments are incompatible with C++98"
  "\n" "警告：空宏实参与 C++98 不兼容">,
  InGroup<CXX98CompatPedantic>, DefaultIgnore;
def note_macro_here : Note<"macro %0 defined here"
  "\n" "提示：宏 %0 在此定义">;
def note_macro_expansion_here : Note<"expansion of macro %0 requested here"
  "\n" "提示：在此请求展开宏 %0">;

def ext_pp_opencl_variadic_macros : Extension<
  "variadic macros are a Clang extension in OpenCL"
  "\n" "警告：可变参数宏是 OpenCL 中的 Clang 扩展">;
def err_opencl_logical_exclusive_or : Error<
  "^^ is a reserved operator in OpenCL"
  "\n" "错误：^^ 是 OpenCL 中的保留运算符">;

def ext_pp_gnu_line_directive : Extension<
  "this style of line directive is a GNU extension"
  "\n" "警告：这种样式的行指令是 GNU 扩展">,
  InGroup<GNULineMarker>;
def err_pp_invalid_directive : Error<
  "invalid preprocessing directive%select{|, did you mean '#%1'?}0"
  "\n" "错误：无效的预处理指令%select{|，您是指 '#%1' 吗？}0">;
def warn_pp_invalid_directive : Warning<
  err_pp_invalid_directive.Summary>, InGroup<DiagGroup<"unknown-directives">>;
def err_pp_unknown_parameter : Error<
  "unknown%select{ | embed}0 preprocessor parameter '%1'"
  "\n" "错误：未知的%select{ | embed}0预处理器参数 '%1'">;
def err_pp_directive_required : Error<
  "%0 must be used within a preprocessing directive"
  "\n" "错误：%0 必须在预处理指令中使用">;
def err_pp_file_not_found : Error<"'%0' file not found"
  "\n" "错误：找不到 '%0' 文件">, DefaultFatal;
def err_pp_through_header_not_found : Error<
  "'%0' required for precompiled header not found"
  "\n" "错误：找不到预编译头所需的 '%0'">, DefaultFatal;
def err_pp_through_header_not_seen : Error<
  "#include of '%0' not seen while attempting to "
  "%select{create|use}1 precompiled header"
  "\n" "错误：尝试%select{创建|使用}1 预编译头时未看到 '%0' 的 #include">, DefaultFatal;
def err_pp_pragma_hdrstop_not_seen : Error<
  "#pragma hdrstop not seen while attempting to use precompiled header"
  "\n" "错误：尝试使用预编译头时未看到 #pragma hdrstop">,
  DefaultFatal;
def warn_pp_macro_def_mismatch_with_pch : Warning<
  "definition of macro %0 does not match definition in precompiled header"
  "\n" "警告：宏 %0 的定义与预编译头中的定义不匹配">,
  InGroup<ClangClPch>;
def warn_pp_hdrstop_filename_ignored : Warning<
  "#pragma hdrstop filename not supported, "
  "/Fp can be used to specify precompiled header filename"
  "\n" "警告：不支持 #pragma hdrstop 文件名，可以使用 /Fp 指定预编译头文件名">,
  InGroup<ClangClPch>;
def remark_pp_search_path_usage : Remark<
  "search path used: '%0'"
  "\n" "备注：使用的搜索路径：'%0'">,
  InGroup<UsedSearchPath>;
def err_pp_file_not_found_angled_include_not_fatal : Error<
  "'%0' file not found with <angled> %select{include|import}1; "
  "use \"quotes\" instead"
  "\n" "错误：找不到带 <angled> %select{包含|导入}1 的 '%0' 文件；请改用 \"quotes\"">;
def err_pp_file_not_found_typo_not_fatal
    : Error<"'%0' file not found, did you mean '%1'?"
  "\n" "错误：找不到 '%0' 文件，您是指 '%1' 吗？">;
def note_pp_framework_without_header : Note<
  "did not find header '%0' in framework '%1' (loaded from '%2')"
  "\n" "提示：在框架 '%1' 中未找到头文件 '%0'（从 '%2' 加载）">;
def err_pp_error_opening_file : Error<
  "error opening file '%0': %1"
  "\n" "错误：打开文件 '%0' 时出错：%1">, DefaultFatal;
def err_pp_including_mainfile_in_preamble : Error<
  "main file cannot be included recursively when building a preamble"
  "\n" "错误：构建 preamble 时不能递归包含主文件">;
def err_pp_empty_filename : Error<"empty filename"
  "\n" "错误：空的文件名">;
def err_pp_include_too_deep : Error<"#include nested too deeply"
  "\n" "错误：#include 嵌套太深">;
def err_pp_expects_filename : Error<"expected \"FILENAME\" or <FILENAME>"
  "\n" "错误：应为 \"FILENAME\" 或 <FILENAME>">;
def err_pp_macro_not_identifier : Error<"macro name must be an identifier"
  "\n" "错误：宏名称必须是标识符">;
def err_pp_missing_macro_name : Error<"macro name missing"
  "\n" "错误：缺少宏名称">;
def err_pp_missing_rparen_in_macro_def : Error<
  "missing ')' in macro parameter list"
  "\n" "错误：宏参数列表中缺少 ')'">;
def err_pp_invalid_tok_in_arg_list : Error<
  "invalid token in macro parameter list"
  "\n" "错误：宏参数列表中有无效的标记">;
def err_pp_expected_ident_in_arg_list : Error<
  "expected identifier in macro parameter list"
  "\n" "错误：宏参数列表中应为标识符">;
def err_pp_expected_comma_in_arg_list : Error<
  "expected comma in macro parameter list"
  "\n" "错误：宏参数列表中应为逗号">;
def err_pp_duplicate_name_in_arg_list : Error<
  "duplicate macro parameter name %0"
  "\n" "错误：重复的宏参数名称 %0">;
def err_pp_stringize_not_parameter : Error<
  "'%select{#|#@}0' is not followed by a macro parameter"
  "\n" "错误：'%select{#|#@}0' 后面没有宏参数">;
def err_pp_malformed_ident : Error<"invalid #ident directive"
  "\n" "错误：无效的 #ident 指令">;
def err_pp_unterminated_conditional : Error<
  "unterminated conditional directive"
  "\n" "错误：未终止的条件指令">;
def pp_err_else_after_else : Error<"#else after #else"
  "\n" "错误：#else 之后出现 #else">;
def pp_err_elif_after_else : Error<
  "%select{#elif|#elifdef|#elifndef}0 after #else"
  "\n" "错误：#else 之后出现 %select{#elif|#elifdef|#elifndef}0">;
def pp_err_else_without_if : Error<"#else without #if"
  "\n" "错误：没有 #if 的 #else">;
def pp_err_elif_without_if : Error<
  "%select{#elif|#elifdef|#elifndef}0 without #if"
  "\n" "错误：没有 #if 的 %select{#elif|#elifdef|#elifndef}0">;
def err_pp_endif_without_if : Error<"#endif without #if"
  "\n" "错误：没有 #if 的 #endif">;
def err_pp_expected_value_in_expr : Error<"expected value in expression"
  "\n" "错误：表达式中应为值">;
def err_pp_expected_rparen : Error<"expected ')' in preprocessor expression"
  "\n" "错误：预处理器表达式中应为 ')'">;
def err_pp_expected_eol : Error<
  "expected end of line in preprocessor expression"
  "\n" "错误：预处理器表达式中应为行尾">;
def err_pp_expected_after : Error<"missing %1 after %0"
  "\n" "错误：%0 之后缺少 %1">;
def err_pp_nested_paren : Error<"nested parentheses not permitted in %0"
  "\n" "错误：%0 中不允许嵌套括号">;
def err_pp_colon_without_question : Error<"':' without preceding '?'"
  "\n" "错误：':' 前面没有 '?'">;
def err_pp_division_by_zero : Error<
  "division by zero in preprocessor expression"
  "\n" "错误：预处理器表达式中除以零">;
def err_pp_remainder_by_zero : Error<
  "remainder by zero in preprocessor expression"
  "\n" "错误：预处理器表达式中除以零取余">;
def err_pp_expr_bad_token_binop : Error<
  "token is not a valid binary operator in a preprocessor subexpression"
  "\n" "错误：标记不是预处理器子表达式中有效的二元运算符">;
def err_pp_expr_bad_token_lparen : Error<
  "function-like macro %0 is not defined"
  "\n" "错误：函数式宏 %0 未定义">;
def err_pp_expr_bad_token_start_expr : Error<
  "invalid token at start of a preprocessor expression"
  "\n" "错误：预处理器表达式开头有无效的标记">;
def err_pp_invalid_poison : Error<"can only poison identifier tokens"
  "\n" "错误：只能污染标识符标记">;
def err_pp_used_poisoned_id : Error<"attempt to use a poisoned identifier"
  "\n" "错误：尝试使用已污染的标识符">;

def err_feature_check_malformed : Error<
  "builtin feature check macro requires a parenthesized identifier"
  "\n" "错误：内置特性检查宏需要带括号的标识符">;

def warn_has_warning_invalid_option :
   ExtWarn<"__has_warning expected option name (e.g. \"-Wundef\")"
  "\n" "警告：__has_warning 应为选项名称（例如 \"-Wundef\"）">,
   InGroup<MalformedWarningCheck>;

def err_pp_identifier_arg_not_identifier : Error<
  "cannot convert %0 token to an identifier"
  "\n" "错误：无法将 %0 标记转换为标识符">;

def warn_pragma_include_alias_mismatch_angle :
   ExtWarn<"angle-bracketed include <%0> cannot be aliased to double-quoted "
   "include \"%1\""
  "\n" "警告：尖括号包含 <%0> 不能别名为双引号包含 \"%1\"">, InGroup<UnknownPragmas>;
def warn_pragma_include_alias_mismatch_quote :
   ExtWarn<"double-quoted include \"%0\" cannot be aliased to angle-bracketed "
   "include <%1>"
  "\n" "警告：双引号包含 \"%0\" 不能别名为尖括号包含 <%1>">, InGroup<UnknownPragmas>;
def warn_pragma_include_alias_expected :
   ExtWarn<"pragma include_alias expected '%0'"
  "\n" "警告：pragma include_alias 应为 '%0'">,
   InGroup<UnknownPragmas>;
def warn_pragma_include_alias_expected_filename :
   ExtWarn<"pragma include_alias expected include filename"
  "\n" "警告：pragma include_alias 应为包含文件名">,
   InGroup<UnknownPragmas>;

// - #pragma warning(...)
def warn_pragma_warning_expected :
  ExtWarn<"#pragma warning expected '%0'"
  "\n" "警告：#pragma warning 应为 '%0'">,
  InGroup<UnknownPragmas>;
def warn_pragma_warning_spec_invalid :
  ExtWarn<"#pragma warning expected 'push', 'pop', 'default', 'disable',"
          " 'error', 'once', 'suppress', 1, 2, 3, or 4"
  "\n" "警告：#pragma warning 应为 'push'、'pop'、'default'、'disable'、"
          "'error'、'once'、'suppress'、1、2、3 或 4">,
  InGroup<UnknownPragmas>;
def warn_pragma_warning_push_level :
  ExtWarn<"#pragma warning(push, level) requires a level between 0 and 4"
  "\n" "警告：#pragma warning(push, level) 要求级别在 0 到 4 之间">,
  InGroup<UnknownPragmas>;
def warn_pragma_warning_expected_number :
  ExtWarn<"#pragma warning expected a warning number"
  "\n" "警告：#pragma warning 应为警告编号">,
  InGroup<UnknownPragmas>;

// - #pragma deprecated(...)
def warn_pragma_deprecated_macro_use :
  ExtWarn<"macro %0 has been marked as deprecated%select{|: %2}1"
  "\n" "警告：宏 %0 已被标记为已弃用%select{|：%2}1">,
  InGroup<DeprecatedPragma>;

// - #pragma clang restrict_expansion(...)
def warn_pragma_restrict_expansion_macro_use :
  ExtWarn<"macro %0 has been marked as unsafe for use in headers"
          "%select{|: %2}1"
  "\n" "警告：宏 %0 已被标记为在头文件中使用不安全"
          "%select{|：%2}1">,
  InGroup<RestrictExpansionMacro>;

// - Note for macro annotations.
def note_pp_macro_annotation :
  Note<"macro marked '%select{deprecated|restrict_expansion|final}0' here"
  "\n" "提示：宏在此处被标记为'%select{deprecated|restrict_expansion|final}0'">;

// - #pragma clang final(...)
def warn_pragma_final_macro :
  ExtWarn<"macro %0 has been marked as final and should not be "
          "%select{undefined|redefined}1"
  "\n" "警告：宏 %0 已被标记为 final，不应%select{取消定义|重新定义}1">,
  InGroup<FinalMacro>,  ShowInSystemHeader;

// - #pragma execution_character_set(...)
def warn_pragma_exec_charset_expected :
  ExtWarn<"#pragma execution_character_set expected '%0'"
  "\n" "警告：#pragma execution_character_set 应为 '%0'">,
  InGroup<UnknownPragmas>;
def warn_pragma_exec_charset_spec_invalid :
  ExtWarn<"#pragma execution_character_set expected 'push' or 'pop'"
  "\n" "警告：#pragma execution_character_set 应为 'push' 或 'pop'">,
  InGroup<UnknownPragmas>;
def warn_pragma_exec_charset_push_invalid :
   ExtWarn<"#pragma execution_character_set invalid value '%0', only 'UTF-8' is supported"
  "\n" "警告：#pragma execution_character_set 的值 '%0' 无效，仅支持 'UTF-8'">,
   InGroup<UnknownPragmas>;

def err__Pragma_malformed : Error<
  "_Pragma takes a parenthesized string literal"
  "\n" "错误：_Pragma 需要带括号的字符串字面量">;
def err_pragma_message_malformed : Error<
  "pragma %select{message|warning|error}0 requires parenthesized string"
  "\n" "错误：pragma %select{message|warning|error}0 需要带括号的字符串">;
def err_pragma_push_pop_macro_malformed : Error<
   "pragma %0 requires a parenthesized string"
  "\n" "错误：pragma %0 需要带括号的字符串">;
def warn_pragma_pop_macro_no_push : Warning<
   "pragma pop_macro could not pop '%0', no matching push_macro"
  "\n" "警告：pragma pop_macro 无法弹出 '%0'，没有匹配的 push_macro">,
  InGroup<IgnoredPragmas>;
def warn_pargma_push_pop_macro_empty_string : Warning<
   "'#pragma %select{push_macro|pop_macro}0' expected a non-empty string"
  "\n" "警告：'#pragma %select{push_macro|pop_macro}0' 应为非空字符串">,
  InGroup<IgnoredPragmas>;
def warn_pragma_message : Warning<"%0"
  "\n" "警告：%0">,
   InGroup<PoundPragmaMessage>, DefaultWarnNoWerror;
def err_pragma_message : Error<"%0"
  "\n" "错误：%0">;
def warn_pragma_ignored : Warning<"unknown pragma ignored"
  "\n" "警告：忽略未知 pragma">,
   InGroup<UnknownPragmas>, DefaultIgnore;
def ext_on_off_switch_syntax :
   ExtWarn<"expected 'ON' or 'OFF' or 'DEFAULT' in pragma"
  "\n" "警告：pragma 中应为 'ON' 或 'OFF' 或 'DEFAULT'">,
   InGroup<UnknownPragmas>;
def ext_pragma_syntax_eod :
   ExtWarn<"expected end of directive in pragma"
  "\n" "警告：pragma 中应为指令结尾">,
   InGroup<UnknownPragmas>;
def warn_pragma_diagnostic_invalid :
   ExtWarn<"pragma diagnostic expected 'error', 'warning', 'ignored', 'fatal',"
            " 'push', or 'pop'"
  "\n" "警告：pragma diagnostic 应为 'error'、'warning'、'ignored'、'fatal'、"
            "'push' 或 'pop'">,
   InGroup<UnknownPragmas>;
def warn_pragma_diagnostic_cannot_pop :
   ExtWarn<"pragma diagnostic pop could not pop, no matching push"
  "\n" "警告：pragma diagnostic pop 无法弹出，没有匹配的 push">,
   InGroup<UnknownPragmas>;
def warn_pragma_diagnostic_invalid_option :
   ExtWarn<"pragma diagnostic expected option name (e.g. \"-Wundef\")"
  "\n" "警告：pragma diagnostic 应为选项名称（例如 \"-Wundef\"）">,
   InGroup<UnknownPragmas>;
def warn_pragma_diagnostic_invalid_token :
   ExtWarn<"unexpected token in pragma diagnostic"
  "\n" "警告：pragma diagnostic 中有意外的标记">,
   InGroup<UnknownPragmas>;
def warn_pragma_diagnostic_unknown_warning :
   ExtWarn<"unknown warning group '%0', ignored"
  "\n" "警告：未知的警告组 '%0'，已忽略">,
   InGroup<UnknownWarningOption>;
// - #pragma __debug
def warn_pragma_debug_missing_command : Warning<
  "missing debug command"
  "\n" "警告：缺少调试命令">, InGroup<IgnoredPragmas>;
def warn_pragma_debug_unexpected_command : Warning<
  "unexpected debug command '%0'"
  "\n" "警告：意外的调试命令 '%0'">, InGroup<IgnoredPragmas>;
def warn_pragma_debug_unknown_module : Warning<
  "unknown module '%0'"
  "\n" "警告：未知的模块 '%0'">, InGroup<IgnoredPragmas>;
def warn_pragma_debug_unable_to_find_module : Warning<
  "unable to find module '%0'"
  "\n" "警告：无法找到模块 '%0'">, InGroup<IgnoredPragmas>;
// #pragma module
def err_pp_expected_module_name : Error<
  "expected %select{identifier after '.' in |}0module name"
  "\n" "错误：应为%select{'.' 之后的标识符 |}0模块名称">;
def err_pp_module_begin_wrong_module : Error<
  "must specify '-fmodule-name=%0' to enter %select{|submodule of }1"
  "this module%select{ (current module is %3)|}2"
  "\n" "错误：必须指定 '-fmodule-name=%0' 才能进入此模块%select{|的子模块}1"
  "%select{（当前模块为 %3）|}2">;
def err_pp_module_begin_no_module_map : Error<
  "no module map available for module %0"
  "\n" "错误：没有可用于模块 %0 的模块映射">;
def err_pp_module_begin_no_submodule : Error<
  "submodule %0.%1 not declared in module map"
  "\n" "错误：子模块 %0.%1 未在模块映射中声明">;
def err_pp_module_begin_without_module_end : Error<
  "no matching '#pragma clang module end' for this "
  "'#pragma clang module begin'"
  "\n" "错误：此 '#pragma clang module begin' 没有匹配的 '#pragma clang module end'">;
def err_pp_module_end_without_module_begin : Error<
  "no matching '#pragma clang module begin' for this "
  "'#pragma clang module end'"
  "\n" "错误：此 '#pragma clang module end' 没有匹配的 '#pragma clang module begin'">;
def note_pp_module_begin_here : Note<
  "entering module '%0' due to this pragma"
  "\n" "提示：由于此 pragma 进入模块 '%0'">;
def err_pp_module_build_missing_end : Error<
  "no matching '#pragma clang module endbuild' for this '#pragma clang module build'"
  "\n" "错误：此 '#pragma clang module build' 没有匹配的 '#pragma clang module endbuild'">;

def err_defined_macro_name : Error<"'defined' cannot be used as a macro name"
  "\n" "错误：'defined' 不能用作宏名称">;
def err_defined_in_pp_embed : Error<
  "'defined' cannot appear within this context"
  "\n" "错误：'defined' 不能出现在此上下文中">;
def err_paste_at_start : Error<
  "'##' cannot appear at start of macro expansion"
  "\n" "错误：'##' 不能出现在宏展开的开头">;
def err_paste_at_end : Error<"'##' cannot appear at end of macro expansion"
  "\n" "错误：'##' 不能出现在宏展开的末尾">;
def ext_paste_comma : Extension<
  "token pasting of ',' and '__VA_ARGS__' is a GNU extension%select{|; "
  "consider using '__VA_OPT__(,)' instead}0"
  "\n" "警告：将 ',' 和 '__VA_ARGS__' 粘贴成标记是 GNU 扩展%select{|；"
  "请考虑改用 '__VA_OPT__(,)'}0">,
  InGroup<GNUZeroVariadicMacroArguments>;
def err_unterm_macro_invoc : Error<
  "unterminated function-like macro invocation"
  "\n" "错误：未终止的函数式宏调用">;
def err_too_many_args_in_macro_invoc : Error<
  "too many arguments provided to function-like macro invocation"
  "\n" "错误：函数式宏调用提供的实参太多">;
def note_suggest_parens_for_macro : Note<
  "parentheses are required around macro argument containing braced "
  "initializer list"
  "\n" "提示：包含花括号初始化列表的宏实参需要括号">;
def note_init_list_at_beginning_of_macro_argument : Note<
  "cannot use initializer list at the beginning of a macro argument"
  "\n" "提示：不能在宏实参的开头使用初始化列表">;
def err_too_few_args_in_macro_invoc : Error<
  "too few arguments provided to function-like macro invocation"
  "\n" "错误：函数式宏调用提供的实参太少">;
def err_pp_bad_paste : Error<
  "pasting formed '%0', an invalid preprocessing token"
  "\n" "错误：粘贴形成了 '%0'，一个无效的预处理标记">;
def ext_pp_bad_paste_ms : ExtWarn<
  "pasting formed '%0', an invalid preprocessing token"
  "\n" "警告：粘贴形成了 '%0'，一个无效的预处理标记">, DefaultError,
  InGroup<DiagGroup<"invalid-token-paste">>;
def err_pp_operator_used_as_macro_name : Error<
  "C++ operator %0 (aka %1) used as a macro name"
  "\n" "错误：C++ 运算符 %0（即 %1）被用作宏名称">;
def ext_pp_operator_used_as_macro_name : Extension<
  err_pp_operator_used_as_macro_name.Summary>, InGroup<MicrosoftCppMacro>;
def err_pp_illegal_floating_literal : Error<
  "floating point literal in preprocessor expression"
  "\n" "错误：预处理器表达式中的浮点字面量">;
def err_pp_line_requires_integer : Error<
  "#line directive requires a positive integer argument"
  "\n" "错误：#line 指令需要正整数实参">;
def ext_pp_line_zero : Extension<
  "#line directive with zero argument is a GNU extension"
  "\n" "警告：实参为零的 #line 指令是 GNU 扩展">,
  InGroup<GNUZeroLineDirective>;
def err_pp_line_invalid_filename : Error<
  "invalid filename for #line directive"
  "\n" "错误：#line 指令的文件名无效">;
def warn_pp_line_decimal : Warning<
  "%select{#line|GNU line marker}0 directive interprets number as decimal, not octal"
  "\n" "警告：%select{#line|GNU 行标记}0 指令将数字解释为十进制，而不是八进制">;
def err_pp_line_digit_sequence : Error<
  "%select{#line|GNU line marker}0 directive requires a simple digit sequence"
  "\n" "错误：%select{#line|GNU 行标记}0 指令需要简单的数字序列">;
def err_pp_linemarker_requires_integer : Error<
  "line marker directive requires a positive integer argument"
  "\n" "错误：行标记指令需要正整数实参">;
def err_pp_linemarker_invalid_filename : Error<
  "invalid filename for line marker directive"
  "\n" "错误：行标记指令的文件名无效">;
def err_pp_linemarker_invalid_flag : Error<
  "invalid flag line marker directive"
  "\n" "错误：无效的标志行标记指令">;
def err_pp_linemarker_invalid_pop : Error<
  "invalid line marker flag '2': cannot pop empty include stack"
  "\n" "错误：无效的行标记标志 '2'：无法弹出空的包含栈">;
def ext_pp_line_too_big : Extension<
  "C requires #line number to be less than %0, allowed as extension"
  "\n" "警告：C 要求 #line 编号小于 %0，作为扩展允许">;
def warn_cxx98_compat_pp_line_too_big : Warning<
  "#line number greater than 32767 is incompatible with C++98"
  "\n" "警告：大于 32767 的 #line 编号与 C++98 不兼容">,
  InGroup<CXX98CompatPedantic>, DefaultIgnore;

def warn_c23_compat_pp_directive : Warning<
  "use of a '#%select{<BUG IF SEEN>|elifdef|elifndef}0' directive "
  "is incompatible with C standards before C23"
  "\n" "警告：使用 '#%select{<BUG IF SEEN>|elifdef|elifndef}0' 指令与 C23 之前的 C 标准不兼容">,
  InGroup<CPre23Compat>, DefaultIgnore;
def ext_c23_pp_directive : ExtWarn<
  "use of a '#%select{<BUG IF SEEN>|elifdef|elifndef}0' directive "
  "is a C23 extension"
  "\n" "警告：使用 '#%select{<BUG IF SEEN>|elifdef|elifndef}0' 指令是 C23 扩展">,
  InGroup<C23>;
def warn_cxx23_compat_pp_directive : Warning<
  "use of a '#%select{<BUG IF SEEN>|elifdef|elifndef}0' directive "
  "is incompatible with C++ standards before C++23"
  "\n" "警告：使用 '#%select{<BUG IF SEEN>|elifdef|elifndef}0' 指令与 C++23 之前的 C++ 标准不兼容">,
  InGroup<CXXPre23Compat>, DefaultIgnore;
def ext_cxx23_pp_directive : ExtWarn<
  "use of a '#%select{<BUG IF SEEN>|elifdef|elifndef}0' directive "
  "is a C++23 extension"
  "\n" "警告：使用 '#%select{<BUG IF SEEN>|elifdef|elifndef}0' 指令是 C++23 扩展">,
  InGroup<CXX23>;

def err_pp_visibility_non_macro : Error<"no macro named %0"
  "\n" "错误：没有名为 %0 的宏">;

def err_pp_arc_cf_code_audited_syntax : Error<"expected 'begin' or 'end'"
  "\n" "错误：应为 'begin' 或 'end'">;
def err_pp_double_begin_of_arc_cf_code_audited : Error<
  "already inside '#pragma clang arc_cf_code_audited'"
  "\n" "错误：已经在 '#pragma clang arc_cf_code_audited' 内部">;
def err_pp_unmatched_end_of_arc_cf_code_audited : Error<
  "not currently inside '#pragma clang arc_cf_code_audited'"
  "\n" "错误：当前不在 '#pragma clang arc_cf_code_audited' 内部">;
def err_pp_include_in_arc_cf_code_audited : Error<
  "cannot %select{#include files|import headers}0 "
  "inside '#pragma clang arc_cf_code_audited'"
  "\n" "错误：在 '#pragma clang arc_cf_code_audited' 内部不能%select{#include 文件|导入头文件}0">;
def err_pp_eof_in_arc_cf_code_audited : Error<
  "'#pragma clang arc_cf_code_audited' was not ended within this file"
  "\n" "错误：'#pragma clang arc_cf_code_audited' 未在此文件内结束">;

def warn_pp_date_time : Warning<
  "expansion of date or time macro is not reproducible"
  "\n" "警告：日期或时间宏的展开不可重现">,
  ShowInSystemHeader, DefaultIgnore, InGroup<DiagGroup<"date-time">>;

// Module map parsing
def remark_mmap_parse : Remark<
  "parsing modulemap '%0'"
  "\n" "备注：正在解析模块映射 '%0'">, ShowInSystemHeader, InGroup<ModuleMap>;
def remark_mmap_load : Remark<
  "loading modulemap '%0'"
  "\n" "备注：正在加载模块映射 '%0'">, ShowInSystemHeader, InGroup<ModuleMap>;
def remark_mmap_load_module : Remark<
  "loading parsed module '%0'"
  "\n" "备注：正在加载已解析的模块 '%0'">, ShowInSystemHeader, InGroup<ModuleMap>;
def err_mmap_unknown_token : Error<"skipping stray token"
  "\n" "错误：跳过游离的标记">;
def err_mmap_expected_module : Error<"expected module declaration"
  "\n" "错误：应为模块声明">;
def err_mmap_expected_module_name : Error<"expected module name"
  "\n" "错误：应为模块名称">;
def err_mmap_expected_lbrace : Error<"expected '{' to start module '%0'"
  "\n" "错误：应为 '{' 以开始模块 '%0'">;
def err_mmap_expected_rbrace : Error<"expected '}'"
  "\n" "错误：应为 '}'">;
def note_mmap_lbrace_match : Note<"to match this '{'"
  "\n" "提示：以匹配此 '{'">;
def err_mmap_expected_rsquare : Error<"expected ']' to close attribute"
  "\n" "错误：应为 ']' 以结束属性">;
def note_mmap_lsquare_match : Note<"to match this ']'"
  "\n" "提示：以匹配此 ']'">;
def err_mmap_expected_member : Error<
  "expected umbrella, header, submodule, or module export"
  "\n" "错误：应为伞头文件、头文件、子模块或模块导出">;
def err_mmap_expected_header : Error<"expected a header name after '%0'"
  "\n" "错误：'%0' 之后应为头文件名">;
def err_mmap_expected_mmap_file : Error<"expected a module map file name"
  "\n" "错误：应为模块映射文件名">;
def err_mmap_module_redefinition : Error<
  "redefinition of module '%0'"
  "\n" "错误：模块 '%0' 的重新定义">;
def note_mmap_prev_definition : Note<"previously defined here"
  "\n" "提示：先前在此定义">;
def err_mmap_umbrella_clash : Error<
  "umbrella for module '%0' already covers this directory"
  "\n" "错误：模块 '%0' 的伞头文件已覆盖此目录">;
def warn_mmap_duplicate_header_ownership : Warning<
  "header '%0' is owned by multiple modules"
  "\n" "警告：头文件 '%0' 由多个模块拥有">,
  InGroup<DiagGroup<"duplicate-header-ownership">>, DefaultIgnore;
def note_mmap_header_owned_by : Note<
  "header owned by module '%0' here"
  "\n" "提示：头文件在此由模块 '%0' 拥有">;
def note_mmap_header_covered_by_umbrella : Note<
  "header covered by umbrella for module '%0' here"
  "\n" "提示：头文件在此被模块 '%0' 的伞头文件覆盖">;
def err_mmap_module_id : Error<
  "expected a module name or '*'"
  "\n" "错误：应为模块名称或 '*'">;
def err_mmap_expected_library_name : Error<
  "expected %select{library|framework}0 name as a string"
  "\n" "错误：应为字符串形式的%select{库|框架}0名称">;
def err_mmap_config_macro_submodule : Error<
  "configuration macros are only allowed in top-level modules"
  "\n" "错误：配置宏只允许出现在顶层模块中">;
def err_mmap_use_decl_submodule : Error<
  "use declarations are only allowed in top-level modules"
  "\n" "错误：use 声明只允许出现在顶层模块中">;
def err_mmap_expected_config_macro : Error<
  "expected configuration macro name after ','"
  "\n" "错误：',' 之后应为配置宏名称">;
def err_mmap_expected_conflicts_comma : Error<
  "expected ',' after conflicting module name"
  "\n" "错误：冲突的模块名称之后应为 ','">;
def err_mmap_expected_conflicts_message : Error<
  "expected a message describing the conflict with '%0'"
  "\n" "错误：应为描述与 '%0' 冲突的消息">;
def err_mmap_missing_module_unqualified : Error<
  "no module named '%0' visible from '%1'"
  "\n" "错误：从 '%1' 看不到名为 '%0' 的模块">;
def err_mmap_missing_module_qualified : Error<
  "no module named '%0' in '%1'"
  "\n" "错误：'%1' 中没有名为 '%0' 的模块">;
def err_mmap_missing_parent_module: Error<
  "no module named '%0' %select{found|in '%2'}1, "
  "parent module must be defined before the submodule"
  "\n" "错误：名为 '%0' 的模块%select{未找到|在 '%2' 中未找到}1，父模块必须在子模块之前定义">;
def err_mmap_top_level_inferred_submodule : Error<
  "only submodules and framework modules may be inferred with wildcard syntax"
  "\n" "错误：只有子模块和框架模块可以使用通配符语法推断">;
def err_mmap_inferred_no_umbrella : Error<
  "inferred submodules require a module with an umbrella"
  "\n" "错误：推断的子模块需要带伞头文件的模块">;
def err_mmap_inferred_framework_submodule : Error<
  "inferred submodule cannot be a framework submodule"
  "\n" "错误：推断的子模块不能是框架子模块">;
def err_mmap_explicit_inferred_framework : Error<
  "inferred framework modules cannot be 'explicit'"
  "\n" "错误：推断的框架模块不能是 'explicit'">;
def err_mmap_missing_exclude_name : Error<
  "expected excluded module name"
  "\n" "错误：应为被排除的模块名称">;
def err_mmap_inferred_redef : Error<
  "redefinition of inferred submodule"
  "\n" "错误：推断子模块的重新定义">;
def err_mmap_expected_lbrace_wildcard : Error<
  "expected '{' to start inferred submodule"
  "\n" "错误：应为 '{' 以开始推断的子模块">;
def err_mmap_expected_inferred_member : Error<
  "expected %select{module exclusion with 'exclude'|'export *'}0"
  "\n" "错误：应为%select{使用 'exclude' 的模块排除|'export *'}0">;
def err_mmap_expected_export_wildcard : Error<
  "only '*' can be exported from an inferred submodule"
  "\n" "错误：只能从推断的子模块导出 '*'">;
def err_mmap_explicit_top_level : Error<
  "'explicit' is not permitted on top-level modules"
  "\n" "错误：顶层模块上不允许 'explicit'">;
def err_mmap_nested_submodule_id : Error<
  "qualified module name can only be used to define modules at the top level"
  "\n" "错误：限定模块名称只能用于在顶层定义模块">;
def err_mmap_expected_feature : Error<"expected a feature name"
  "\n" "错误：应为特性名称">;
def err_mmap_expected_attribute : Error<"expected an attribute name"
  "\n" "错误：应为属性名称">;
def warn_mmap_unknown_attribute : Warning<"unknown attribute '%0'"
  "\n" "警告：未知的属性 '%0'">,
  InGroup<IgnoredAttributes>;
def warn_mmap_mismatched_private_submodule : Warning<
  "private submodule '%0' in private module map, expected top-level module"
  "\n" "警告：私有模块映射中的私有子模块 '%0'，应为顶层模块">,
  InGroup<PrivateModule>;
def warn_mmap_mismatched_private_module_name : Warning<
  "expected canonical name for private module '%0'"
  "\n" "警告：私有模块 '%0' 应为规范名称">,
  InGroup<PrivateModule>;
def note_mmap_rename_top_level_private_module : Note<
  "rename '%0' to ensure it can be found by name"
  "\n" "提示：重命名 '%0' 以确保可以按名称找到它">;
def warn_mmap_incomplete_framework_module_declaration : Warning<
  "skipping '%0' because module declaration of '%1' lacks the 'framework' qualifier"
  "\n" "警告：跳过 '%0'，因为 '%1' 的模块声明缺少 'framework' 限定符">,
  InGroup<IncompleteFrameworkModuleDeclaration>;
def note_mmap_add_framework_keyword : Note<
  "use 'framework module' to declare module '%0'"
  "\n" "提示：使用 'framework module' 声明模块 '%0'">;

def err_mmap_duplicate_header_attribute : Error<
  "header attribute '%0' specified multiple times"
  "\n" "错误：多次指定头文件属性 '%0'">;
def err_mmap_invalid_header_attribute_value : Error<
  "expected integer literal as value for header attribute '%0'"
  "\n" "错误：头文件属性 '%0' 的值应为整数字面量">;
def err_mmap_expected_header_attribute : Error<
  "expected a header attribute name ('size' or 'mtime')"
  "\n" "错误：应为头文件属性名称（'size' 或 'mtime'）">;
def err_mmap_conflicting_export_as : Error<
  "conflicting re-export of module '%0' as '%1' or '%2'"
  "\n" "错误：将模块 '%0' 作为 '%1' 或 '%2' 重新导出的冲突">;
def warn_mmap_redundant_export_as : Warning<
  "module '%0' already re-exported as '%1'"
  "\n" "警告：模块 '%0' 已作为 '%1' 重新导出">,
  InGroup<PrivateModule>;
def err_mmap_submodule_export_as : Error<
  "only top-level modules can be re-exported as public"
  "\n" "错误：只有顶层模块可以作为 public 重新导出">;
def err_mmap_qualified_export_as : Error<
  "a module can only be re-exported as another top-level module"
  "\n" "错误：模块只能作为另一个顶层模块重新导出">;

def warn_quoted_include_in_framework_header : Warning<
  "double-quoted include \"%0\" in framework header, "
  "expected angle-bracketed instead"
  "\n" "警告：框架头文件中的双引号包含 \"%0\"，应为尖括号包含"
  >, InGroup<FrameworkHdrQuotedInclude>, DefaultIgnore;
def warn_framework_include_private_from_public : Warning<
  "public framework header includes private framework header '%0'"
  "\n" "警告：公共框架头文件包含私有框架头文件 '%0'"
  >, InGroup<FrameworkIncludePrivateFromPublic>;
def warn_header_shadowing : Warning<
  "multiple candidates for header '%0' found; "
  "directory '%1' chosen, ignoring others including '%2'"
  "\n" "警告：找到多个头文件 '%0' 的候选；选择目录 '%1'，忽略其他包括 '%2' 的候选">,
  InGroup<ShadowHeader>, DefaultIgnore;
def warn_deprecated_module_dot_map : Warning<
  "'%0' as a module map name is deprecated, rename it to %select{module.modulemap|module.private.modulemap}1%select{| in the 'Modules' directory of the framework}2"
  "\n" "警告：'%0' 作为模块映射名称已弃用，请将其重命名为%select{module.modulemap|module.private.modulemap}1%select{| 框架的 'Modules' 目录中}2">,
  InGroup<DeprecatedModuleDotMap>;

def remark_pp_include_directive_modular_translation : Remark<
  "treating #%select{include|import|include_next|__include_macros}0 as an "
  "import of module '%1'"
  "\n" "备注：将 #%select{include|import|include_next|__include_macros}0 视为模块 '%1' 的导入">, InGroup<ModuleIncludeDirectiveTranslation>;
def note_implicit_top_level_module_import_here : Note<
  "submodule of top-level module '%0' implicitly imported here"
  "\n" "提示：顶层模块 '%0' 的子模块在此隐式导入">;
def warn_uncovered_module_header : Warning<
  "umbrella header for module '%0' does not include header '%1'"
  "\n" "警告：模块 '%0' 的伞头文件不包含头文件 '%1'">,
  InGroup<IncompleteUmbrella>;
def warn_mmap_umbrella_dir_not_found : Warning<
  "umbrella directory '%0' not found"
  "\n" "警告：找不到伞目录 '%0'">,
  InGroup<IncompleteUmbrella>;
def err_expected_id_building_module : Error<
  "expected a module name in '__building_module' expression"
  "\n" "错误：'__building_module' 表达式中应为模块名称">;
def warn_use_of_private_header_outside_module : Warning<
  "use of private header from outside its module: '%0'"
  "\n" "警告：在其模块外部使用私有头文件：'%0'">,
  InGroup<DiagGroup<"private-header">>, DefaultError;
def err_undeclared_use_of_module : Error<
  "module %0 does not depend on a module exporting '%1'"
  "\n" "错误：模块 %0 不依赖导出 '%1' 的模块">;
def err_undeclared_use_of_module_indirect : Error<
  "module %0 does not directly depend on a module exporting '%1', which is part of indirectly-used module %2"
  "\n" "错误：模块 %0 不直接依赖导出 '%1' 的模块，后者是间接使用的模块 %2 的一部分">;
def err_undeclared_use_of_module_private : Error<
  "module %0 does not depend on a module exporting '%1', which is part of module %2, although its private module does"
  "\n" "错误：模块 %0 不依赖导出 '%1' 的模块，后者是模块 %2 的一部分，尽管其私有模块确实依赖">;
def warn_non_modular_include_in_framework_module : Warning<
  "include of non-modular header inside framework module '%0': '%1'"
  "\n" "警告：框架模块 '%0' 内包含非模块化头文件：'%1'">,
  InGroup<NonModularIncludeInFrameworkModule>, DefaultIgnore;
def warn_non_modular_include_in_module : Warning<
  "include of non-modular header inside module '%0': '%1'"
  "\n" "警告：模块 '%0' 内包含非模块化头文件：'%1'">,
  InGroup<NonModularIncludeInModule>, DefaultIgnore;
def warn_module_conflict : Warning<
  "module '%0' conflicts with already-imported module '%1': %2"
  "\n" "警告：模块 '%0' 与已导入的模块 '%1' 冲突：%2">,
  InGroup<ModuleConflict>;
def warn_mmap_path_outside_directory : Warning<
  "path refers outside of the module directory; such paths in implicitly "
  "discovered module maps are deprecated"
  "\n" "警告：路径引用到模块目录之外；隐式发现的模块映射中的此类路径已弃用">,
  InGroup<DiagGroup<"module-map-path-outside-directory">>, DefaultIgnore;
def warn_mmap_deprecated_symlink_to_modular_header : Warning<
  "header '%0' may be a symlink to '%1' owned by module '%2'; "
  "symlinks to modular headers are deprecated, replace with a textual "
  "forwarding header"
  "\n" "警告：头文件 '%0' 可能是由模块 '%2' 拥有的 '%1' 的符号链接；"
  "到模块化头文件的符号链接已弃用，请改用文本转发头文件">,
  InGroup<DiagGroup<"mmap-deprecated-symlink-to-modular-header">>,
  DefaultIgnore;
def note_mmap_module_defined_here : Note<"module defined here"
  "\n" "提示：模块在此定义">;

// C++20 modules
def err_pp_module_name_is_macro : Error<
  "%select{module|partition}0 name component %1 cannot be a object-like macro"
  "\n" "错误：%select{模块|分区}0名称组件 %1 不能是类对象宏">;
def err_pp_module_expected_ident : Error<
  "expected %select{identifier after '.' in |}0module name"
  "\n" "错误：应为%select{'.' 之后的标识符 |}0模块名称">;
def err_pp_unexpected_tok_after_module_name : Error<
  "unexpected preprocessing token '%0' after module name, "
  "only ';' and '[' (start of attribute specifier sequence) are allowed"
  "\n" "错误：模块名称之后有意外的预处理标记 '%0'，只允许 ';' 和 '['（特性说明符序列的开头）">;
def warn_pp_extra_tokens_at_module_directive_eol
    : Warning<"extra tokens after semicolon in '%0' directive"
  "\n" "警告：'%0' 指令中分号之后有额外的标记">,
      InGroup<ExtraTokens>;
def err_pp_module_decl_in_header
    : Error<"module declaration must not come from an #include directive"
  "\n" "错误：模块声明不得来自 #include 指令">;
def err_pp_cond_span_module_decl
    : Error<"module directive lines are not allowed on lines controlled "
    "by preprocessor conditionals"
  "\n" "错误：由预处理器条件控制的行上不允许模块指令行">;
def err_header_import_semi_in_macro : Error<
  "semicolon terminating header import declaration cannot be produced "
  "by a macro"
  "\n" "错误：终止头文件导入声明的分号不能由宏产生">;
def err_header_import_not_header_unit : Error<
  "header file %0 (aka '%1') cannot be imported because "
  "it is not known to be a header unit"
  "\n" "错误：头文件 %0（即 '%1'）无法导入，因为未知它是头单元">;
def warn_pp_include_angled_in_module_purview : Warning<
  "'#include <filename>' attaches the declarations to the named module '%0'"
  ", which is not usually intended; consider moving that directive before "
  "the module declaration"
  "\n" "警告：'#include <filename>' 将声明附加到具名模块 '%0'，"
  "这通常不是有意的；请考虑将该指令移到模块声明之前">,
  InGroup<DiagGroup<"include-angled-in-module-purview">>;

def warn_header_guard : Warning<
  "%0 is used as a header guard here, followed by #define of a different macro"
  "\n" "警告：%0 在此处用作头文件保护，其后是不同宏的 #define">,
  InGroup<DiagGroup<"header-guard">>;
def note_header_guard : Note<
  "%0 is defined here; did you mean %1?"
  "\n" "提示：%0 在此定义；您是指 %1 吗？">;

def warn_defined_in_object_type_macro : Warning<
  "macro expansion producing 'defined' has undefined behavior"
  "\n" "警告：产生 'defined' 的宏展开具有未定义行为">,
  InGroup<ExpansionToDefined>;
def warn_defined_in_function_type_macro : Extension<
  "macro expansion producing 'defined' has undefined behavior"
  "\n" "警告：产生 'defined' 的宏展开具有未定义行为">,
  InGroup<ExpansionToDefined>;

let CategoryName = "Nullability Issue" in {

def err_pp_assume_nonnull_syntax : Error<"expected 'begin' or 'end'"
  "\n" "错误：应为 'begin' 或 'end'">;
def err_pp_double_begin_of_assume_nonnull : Error<
  "already inside '#pragma clang assume_nonnull'"
  "\n" "错误：已经在 '#pragma clang assume_nonnull' 内部">;
def err_pp_unmatched_end_of_assume_nonnull : Error<
  "not currently inside '#pragma clang assume_nonnull'"
  "\n" "错误：当前不在 '#pragma clang assume_nonnull' 内部">;
def err_pp_include_in_assume_nonnull : Error<
  "cannot %select{#include files|import headers}0 "
  "inside '#pragma clang assume_nonnull'"
  "\n" "错误：在 '#pragma clang assume_nonnull' 内部不能%select{#include 文件|导入头文件}0">;
def err_pp_eof_in_assume_nonnull : Error<
  "'#pragma clang assume_nonnull' was not ended within this file"
  "\n" "错误：'#pragma clang assume_nonnull' 未在此文件内结束">;

}

let CategoryName = "Dependency Directive Source Scanner Issue" in {

def err_dep_source_scanner_missing_semi_after_at_import : Error<
  "could not find ';' after @import"
  "\n" "错误：在 @import 之后找不到 ';'">;
def err_dep_source_scanner_unexpected_tokens_at_import : Error<
  "unexpected extra tokens at end of @import declaration"
  "\n" "错误：@import 声明末尾有意外多余的标记">;

}

def err_pp_double_begin_pragma_unsafe_buffer_usage :
Error<"already inside '#pragma unsafe_buffer_usage'"
"\n" "错误：已经在 '#pragma unsafe_buffer_usage' 内部">;

def err_pp_unmatched_end_begin_pragma_unsafe_buffer_usage :
Error<"not currently inside '#pragma unsafe_buffer_usage'"
"\n" "错误：当前不在 '#pragma unsafe_buffer_usage' 内部">;

def err_pp_unclosed_pragma_unsafe_buffer_usage :
Error<"'#pragma unsafe_buffer_usage' was not ended"
"\n" "错误：'#pragma unsafe_buffer_usage' 未结束">;

def err_pp_pragma_unsafe_buffer_usage_syntax :
Error<"expected 'begin' or 'end'"
"\n" "错误：应为 'begin' 或 'end'">;
}
