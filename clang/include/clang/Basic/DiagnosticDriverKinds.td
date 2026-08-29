//==--- DiagnosticDriverKinds.td - libdriver diagnostics ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

let Component = "Driver" in {

def err_drv_no_such_file : Error<"no such file or directory: '%0'"
  "\n" "错误：没有这样的文件或目录：'%0'">;
def err_drv_no_such_file_with_suggestion : Error<
  "no such file or directory: '%0'; did you mean '%1'?"
  "\n" "错误：没有这样的文件或目录：'%0'；您是指 '%1' 吗？">;
def err_drv_unsupported_opt : Error<"unsupported option '%0'"
  "\n" "错误：不支持的选项 '%0'">;
def err_drv_unsupported_opt_with_suggestion : Error<
  "unsupported option '%0'; did you mean '%1'?"
  "\n" "错误：不支持的选项 '%0'；您是指 '%1' 吗？">;
def err_drv_unsupported_opt_for_target : Error<
  "unsupported option '%0' for target '%1'"
  "\n" "错误：目标 '%1' 不支持的选项 '%0'">;
def err_drv_unsupported_opt_for_language_mode : Error<
  "unsupported option '%0' for language mode '%1'"
  "\n" "错误：语言模式 '%1' 不支持的选项 '%0'">;
def err_drv_unsupported_option_argument : Error<
  "unsupported argument '%1' to option '%0'"
  "\n" "错误：选项 '%0' 有不支持的实参 '%1'">;
def err_drv_unsupported_option_argument_for_target : Error<
  "unsupported argument '%1' to option '%0' for target '%2'"
  "\n" "错误：目标 '%2' 的选项 '%0' 有不支持的实参 '%1'">;
def err_drv_unknown_stdin_type : Error<
  "-E or -x required when input is from standard input"
  "\n" "错误：输入来自标准输入时需要使用 -E 或 -x">;
def err_drv_unknown_stdin_type_clang_cl : Error<
  "use /Tc or /Tp to set input type for standard input"
  "\n" "错误：使用 /Tc 或 /Tp 为标准输入设置输入类型">;
def err_drv_unknown_language : Error<"language not recognized: '%0'"
  "\n" "错误：无法识别的语言：'%0'">;
def err_drv_invalid_arch_name : Error<
  "invalid arch name '%0'"
  "\n" "错误：无效的架构名称 '%0'">;
def err_drv_invalid_riscv_arch_name : Error<
  "invalid arch name '%0', %1"
  "\n" "错误：无效的架构名称 '%0'，%1">;
def err_drv_invalid_riscv_cpu_name_for_target : Error<
  "cpu '%0' does not support rv%select{32|64}1"
  "\n" "错误：CPU '%0' 不支持 rv%select{32|64}1">;
def err_drv_invalid_riscv_mtune_string : Error<
  "invalid %select{-mtune|tune feature}0 string '%1': %2"
  "\n" "错误：无效的%select{-mtune|tune 特性}0字符串 '%1'：%2">;
def warn_drv_invalid_arch_name_with_suggestion : Warning<
  "ignoring invalid /arch: argument '%0'; for %select{64|32}1-bit expected one of %2"
  "\n" "警告：忽略无效的 /arch: 实参 '%0'；对于 %select{64|32}1 位，应为其中之一：%2">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_avr_mcu_not_specified : Warning<
  "no target microcontroller specified, please pass -mmcu=<mcu name>"
  "\n" "警告：未指定目标微控制器，请传递 -mmcu=<mcu name>">,
  InGroup<AVRRtlibLinkingQuirks>;
def warn_drv_avr_libc_not_found: Warning<
  "no avr-libc installation can be found on the system, "
  "cannot link standard libraries"
  "\n" "警告：系统上找不到 avr-libc 安装，无法链接标准库">,
  InGroup<AVRRtlibLinkingQuirks>;
def warn_drv_avr_family_linking_stdlibs_not_implemented: Warning<
  "support for linking stdlibs for microcontroller '%0' is not implemented"
  "\n" "警告：尚未实现针对微控制器 '%0' 链接标准库的支持">,
  InGroup<AVRRtlibLinkingQuirks>;
def warn_drv_avr_linker_section_addresses_not_implemented: Warning<
  "support for passing the data section address to the linker for "
  "microcontroller '%0' is not implemented"
  "\n" "警告：尚未实现针对微控制器 '%0' 将数据段地址传递给链接器的支持">,
  InGroup<AVRRtlibLinkingQuirks>;
def warn_drv_avr_stdlib_not_linked: Warning<
  "standard library not linked and so no interrupt vector table or "
  "compiler runtime routines will be linked"
  "\n" "警告：标准库未链接，因此不会链接任何中断向量表或编译器运行时例程">,
  InGroup<AVRRtlibLinkingQuirks>;
def err_drv_cuda_bad_gpu_arch : Error<"unsupported CUDA gpu architecture: %0"
  "\n" "错误：不支持的 CUDA GPU 架构：%0">;
def err_drv_offload_bad_gpu_arch : Error<"unsupported %0 gpu architecture: %1"
  "\n" "错误：不支持的 %0 GPU 架构：%1">;
def err_drv_offload_missing_gpu_arch : Error<
  "must pass in an explicit %0 gpu architecture to '%1'"
  "\n" "错误：必须向 '%1' 传递显式的 %0 GPU 架构">;
def err_drv_no_cuda_installation : Error<
  "cannot find CUDA installation; provide its path via '--cuda-path', or pass "
  "'-nocudainc' to build without CUDA includes"
  "\n" "错误：找不到 CUDA 安装；请通过 '--cuda-path' 提供其路径，或传递 "
  "'-nocudainc' 以在无 CUDA 头文件的情况下构建">;
def err_drv_no_cuda_libdevice : Error<
  "cannot find libdevice for %0; provide path to different CUDA installation "
  "via '--cuda-path', or pass '-nocudalib' to build without linking with "
  "libdevice"
  "\n" "错误：找不到 %0 的 libdevice；请通过 '--cuda-path' 提供其他 CUDA 安装的路径，"
  "或传递 '-nocudalib' 以在不链接 libdevice 的情况下构建">;

def err_drv_no_rocm_device_lib : Error<
  "cannot find ROCm device library%select{| for %1| for ABI version %1"
  "%select{|, which requires ROCm %3 or higher}2}0; provide its path via "
  "'--rocm-path' or '--rocm-device-lib-path', or pass '-nogpulib' to build "
  "without ROCm device library"
  "\n" "错误：找不到 ROCm 设备库%select{| 对于 %1| 对于 ABI 版本 %1"
  "%select{|，这需要 ROCm %3 或更高版本}2}0；请通过 "
  "'--rocm-path' 或 '--rocm-device-lib-path' 提供其路径，或传递 '-nogpulib' "
  "以在无 ROCm 设备库的情况下构建">;
def err_drv_no_hip_runtime : Error<
  "cannot find HIP runtime; provide its path via '--rocm-path', or pass "
  "'-nogpuinc' to build without HIP runtime"
  "\n" "错误：找不到 HIP 运行时；请通过 '--rocm-path' 提供其路径，或传递 "
  "'-nogpuinc' 以在无 HIP 运行时的情况下构建">;
def err_drv_no_hipstdpar_lib : Error<
  "cannot find HIP Standard Parallelism Acceleration library; provide it via "
  "'--hipstdpar-path'"
  "\n" "错误：找不到 HIP 标准并行加速库；请通过 '--hipstdpar-path' 提供它">;
def err_drv_no_hipstdpar_thrust_lib : Error<
  "cannot find rocThrust, which is required by the HIP Standard Parallelism "
  "Acceleration library; provide it via "
  "'--hipstdpar-thrust-path'"
  "\n" "错误：找不到 rocThrust，HIP 标准并行加速库需要它；"
  "请通过 '--hipstdpar-thrust-path' 提供它">;
def err_drv_no_hipstdpar_prim_lib : Error<
  "cannot find rocPrim, which is required by the HIP Standard Parallelism "
  "Acceleration library; provide it via '--hipstdpar-prim-path'"
  "\n" "错误：找不到 rocPrim，HIP 标准并行加速库需要它；"
  "请通过 '--hipstdpar-prim-path' 提供它">;

def err_drv_no_hipspv_device_lib : Error<
  "cannot find HIP device library%select{| for %1}0; provide its path via "
  "'--hip-path' or '--hip-device-lib-path', or pass '-nogpulib' to build "
  "without HIP device library"
  "\n" "错误：找不到 HIP 设备库%select{| 对于 %1}0；请通过 "
  "'--hip-path' 或 '--hip-device-lib-path' 提供其路径，或传递 '-nogpulib' "
  "以在无 HIP 设备库的情况下构建">;
def err_drv_hipspv_no_hip_path : Error<
  "'--hip-path' must be specified when offloading to SPIR-V unless '-nogpuinc' "
  "is given"
  "\n" "错误：卸载到 SPIR-V 时必须指定 '--hip-path'，除非给出了 '-nogpuinc'">;

// SYCL Windows-specific diagnostics
def err_drv_sycl_requires_dynamic_crt : Error<
  "SYCL requires dynamic C++ runtime (/MD or /MDd); "
  "static C++ runtime (/MT or /MTd) is not supported"
  "\n" "错误：SYCL 需要动态 C++ 运行时（/MD 或 /MDd）；"
  "不支持静态 C++ 运行时（/MT 或 /MTd）">;

def err_drv_no_spv_tools : Error<"cannot find SPIR-V Tools binary '%0', which "
                                 "is required for SPIR-V compilation. "
                                 "It can be obtained from your system package "
                                 "manager or from KhronosGroup/SPIRV-Tools "
                                 "on GitHub"
                                 "\n" "错误：找不到 SPIR-V 编译所需的 "
                                 "SPIR-V 工具二进制文件 '%0'。可以从系统包管理器"
                                 "或 GitHub 上的 KhronosGroup/SPIRV-Tools 获取它">;

def err_drv_undetermined_gpu_arch : Error<
  "cannot determine %0 architecture: %1; consider passing it via '%2'; "
  "environment variable CLANG_TOOLCHAIN_PROGRAM_TIMEOUT specifies the tool "
  "timeout (integer secs, <=0 is infinite)"
  "\n" "错误：无法确定 %0 架构：%1；请考虑通过 '%2' 传递它；"
  "环境变量 CLANG_TOOLCHAIN_PROGRAM_TIMEOUT 指定工具超时时间"
  "（整数秒，<=0 表示无限）">;

def warn_drv_multi_gpu_arch : Warning<
  "multiple %0 architectures are detected: %1; only the first one is used for "
  "'%2'"
  "\n" "警告：检测到多个 %0 架构：%1；只有第一个用于 '%2'">, InGroup<MultiGPU>;
def err_drv_cuda_version_unsupported : Error<
  "GPU arch %0 is supported by CUDA versions between %1 and %2 (inclusive), "
  "but installation at %3 is %4; use '--cuda-path' to specify a different CUDA "
  "install, pass a different GPU arch with '--cuda-gpu-arch', or pass "
  "'--no-cuda-version-check'"
  "\n" "错误：GPU 架构 %0 受介于 %1 和 %2（含）之间的 CUDA 版本支持，"
  "但 %3 处的安装为 %4；请使用 '--cuda-path' 指定其他 CUDA 安装，"
  "使用 '--cuda-gpu-arch' 传递不同的 GPU 架构，或传递 "
  "'--no-cuda-version-check'">;
def warn_drv_new_cuda_version: Warning<
  "CUDA version%0 is newer than the latest%select{| partially}1 supported version %2"
  "\n" "警告：CUDA 版本%0 比最新的%select{|部分}1受支持版本 %2 更新">,
  InGroup<CudaUnknownVersion>;
def warn_drv_partially_supported_cuda_version: Warning<
  "CUDA version %0 is only partially supported"
  "\n" "警告：CUDA 版本 %0 仅部分受支持">,
  InGroup<CudaUnknownVersion>;
def err_drv_cuda_host_arch : Error<
  "unsupported architecture '%0' for host compilation"
  "\n" "错误：主机编译不支持的架构 '%0'">;
def err_drv_mix_cuda_hip : Error<
  "mixed CUDA and HIP compilation is not supported"
  "\n" "错误：不支持混合 CUDA 和 HIP 编译">;
def err_drv_mix_offload : Error<
  "mixed %0 and %1 offloading compilation is not supported"
  "\n" "错误：不支持混合 %0 和 %1 卸载编译">;
def err_drv_bad_target_id : Error<
  "invalid target ID '%0'; format is a processor name followed by an optional "
  "colon-delimited list of features followed by an enable/disable sign (e.g., "
  "'gfx908:sramecc+:xnack-')"
  "\n" "错误：无效的目标 ID '%0'；格式是处理器名称后跟可选的冒号分隔的特性列表，"
  "再跟一个启用/禁用符号（例如 'gfx908:sramecc+:xnack-'）">;
def err_drv_bad_offload_arch_combo : Error<
  "invalid offload arch combinations: '%0' and '%1' (for a specific processor, "
  "a feature should either exist in all offload archs, or not exist in any "
  "offload archs)"
  "\n" "错误：无效的卸载架构组合：'%0' 和 '%1'（对于特定处理器，一个特性要么"
  "存在于所有卸载架构中，要么不存在于任何卸载架构中）">;
def err_drv_unsupported_option_for_offload_arch_req_feature : Error<
  "'%0' option for offload arch '%1' is not currently supported "
  "there. Use it with an offload arch containing '%2' instead"
  "\n" "错误：卸载架构 '%1' 当前不支持 '%0' 选项。"
  "请改用包含 '%2' 的卸载架构">;
def warn_drv_unsupported_option_for_offload_arch_req_feature : Warning<
  "ignoring '%0' option for offload arch '%1' as it is not currently supported "
  "there. Use it with an offload arch containing '%2' instead"
  "\n" "警告：由于卸载架构 '%1' 当前不支持 '%0' 选项，正在忽略它。"
  "请改用包含 '%2' 的卸载架构">,
  InGroup<OptionIgnored>;
def warn_drv_unsupported_option_for_target : Warning<
  "ignoring '%0' option as it is not currently supported for target '%1'"
  "\n" "警告：由于目标 '%1' 当前不支持 '%0' 选项，正在忽略它">,
  InGroup<OptionIgnored>;
def err_drv_unsupported_option_for_target : Error<
  "'%0' option is not currently supported for target '%1'"
  "\n" "错误：目标 '%1' 当前不支持 '%0' 选项">;
def warn_drv_unsupported_option_part_for_target : Warning<
  "ignoring '%0' in '%1' option as it is not currently supported for target '%2'"
  "\n" "警告：由于目标 '%2' 当前不支持 '%1' 选项中的 '%0'，正在忽略它">,
  InGroup<OptionIgnored>;
def err_drv_unsupported_option_part_for_target : Error<
  "'%0' in '%1' option is not currently supported for target '%2'"
  "\n" "错误：目标 '%2' 当前不支持 '%1' 选项中的 '%0'">;
def warn_drv_invalid_argument_for_flang : Warning<
  "'%0' is not valid for Fortran"
  "\n" "警告：'%0' 对 Fortran 无效">,
  InGroup<OptionIgnored>;
def warn_drv_unsupported_option_for_flang : Warning<
  "the argument '%0' is not supported for option '%1'. Mapping to '%1%2'"
  "\n" "警告：选项 '%1' 不支持实参 '%0'。映射为 '%1%2'">,
  InGroup<OptionIgnored>;
def warn_drv_unsupported_diag_option_for_flang : Warning<
  "the warning option '-%0' is not supported"
  "\n" "警告：不支持警告选项 '-%0'">,
  InGroup<OptionIgnored>;
def warn_drv_unsupported_option_for_processor : Warning<
  "ignoring '%0' option as it is not currently supported for processor '%1'"
  "\n" "警告：由于处理器 '%1' 当前不支持 '%0' 选项，正在忽略它">,
  InGroup<OptionIgnored>;
def warn_drv_unsupported_option_for_runtime : Warning<
  "ignoring '%0' option as it is not currently supported for runtime '%1'"
  "\n" "警告：由于运行时 '%1' 当前不支持 '%0' 选项，正在忽略它">,
  InGroup<OptionIgnored>;
def warn_drv_hexagon_reserved_caller_saved_reg : Warning<
  "reserving the caller-saved register '%0' may lead to incorrect code if it "
  "is not also reserved in all other translation units and libraries; you are "
  "responsible for ensuring the register is managed consistently"
  "\n" "警告：保留调用方保存的寄存器 '%0' 可能会导致不正确的代码，如果它没有"
  "在所有其他翻译单元和库中也被保留；您有责任确保该寄存器得到一致的管理">,
  InGroup<DiagGroup<"hexagon-reserved-caller-saved">>;
def warn_drv_unsupported_openmp_library : Warning<
  "the library '%0=%1' is not supported, OpenMP will not be enabled"
  "\n" "警告：不支持库 '%0=%1'，OpenMP 将不会启用">,
  InGroup<OptionIgnored>;
def warn_openmp_impl_incomplete : Warning<
  "OpenMP support for version %0 in flang is still incomplete"
  "\n" "警告：flang 中对版本 %0 的 OpenMP 支持仍不完整">,
  InGroup<ExperimentalOption>;
def warn_openmp_spec_incomplete : Warning<
  "the specification for OpenMP version %0 is still under development; "
  "the syntax and semantics of new features may be subject to change"
  "\n" "警告：OpenMP 版本 %0 的规范仍在开发中；"
  "新特性的语法和语义可能会发生变化">,
  InGroup<ExperimentalOption>;
def err_drv_invalid_thread_model_for_target : Error<
  "invalid thread model '%0' in '%1' for this target"
  "\n" "错误：此目标的 '%1' 中有无效的线程模型 '%0'">;
def err_drv_invalid_linker_name : Error<
  "invalid linker name in argument '%0'"
  "\n" "错误：实参 '%0' 中有无效的链接器名称">;
def err_drv_invalid_rtlib_name : Error<
  "invalid runtime library name in argument '%0'"
  "\n" "错误：实参 '%0' 中有无效的运行时库名称">;
def err_drv_unsupported_rtlib_for_platform : Error<
  "unsupported runtime library '%0' for platform '%1'"
  "\n" "错误：平台 '%1' 不支持的运行时库 '%0'">;
def err_drv_invalid_unwindlib_name : Error<
  "invalid unwind library name in argument '%0'"
  "\n" "错误：实参 '%0' 中有无效的展开库名称">;
def err_drv_unsupported_unwind_for_platform : Error<
  "unsupported unwind library '%0' for platform '%1'"
  "\n" "错误：平台 '%1' 不支持的展开库 '%0'">;
def err_drv_incompatible_unwindlib : Error<
  "--rtlib=libgcc requires --unwindlib=libgcc"
  "\n" "错误：--rtlib=libgcc 需要 --unwindlib=libgcc">;
def err_drv_incompatible_options : Error<
  "the combination of '%0' and '%1' is incompatible"
  "\n" "错误：'%0' 和 '%1' 的组合不兼容">;
def err_drv_invalid_cstdlib_name : Error<
  "invalid C library name in argument '%0'"
  "\n" "错误：实参 '%0' 中有无效的 C 库名称">;
def err_drv_invalid_stdlib_name : Error<
  "invalid library name in argument '%0'"
  "\n" "错误：实参 '%0' 中有无效的库名称">;
def err_drv_invalid_output_with_multiple_archs : Error<
  "cannot use '%0' output with multiple -arch options"
  "\n" "错误：不能将 '%0' 输出与多个 -arch 选项一起使用">;
def err_drv_no_input_files : Error<"no input files"
  "\n" "错误：没有输入文件">;
def err_drv_output_argument_with_multiple_files : Error<
  "cannot specify -o when generating multiple output files"
  "\n" "错误：生成多个输出文件时不能指定 -o">;
def err_drv_out_file_argument_with_multiple_sources : Error<
  "cannot specify '%0%1' when compiling multiple source files"
  "\n" "错误：编译多个源文件时不能指定 '%0%1'">;
def err_no_external_assembler : Error<
  "there is no external assembler that can be used on this platform"
  "\n" "错误：此平台上没有可用的外部汇编器">;
def err_drv_unable_to_remove_file : Error<
  "unable to remove file: %0"
  "\n" "错误：无法删除文件：%0">;
def err_drv_unable_to_set_working_directory : Error <
  "unable to set working directory: %0"
  "\n" "错误：无法设置工作目录：%0">;
def err_drv_command_failure : Error<
  "unable to execute command: %0"
  "\n" "错误：无法执行命令：%0">;
def err_drv_invalid_darwin_version : Error<
  "invalid Darwin version number: %0"
  "\n" "错误：无效的 Darwin 版本号：%0">;
def err_drv_invalid_diagnotics_hotness_threshold : Error<
  "invalid argument in '%0', only integer or 'auto' is supported"
  "\n" "错误：'%0' 中的实参无效，仅支持整数或 'auto'">;
def err_drv_invalid_diagnotics_misexpect_tolerance : Error<
  "invalid argument in '%0', only integers are supported"
  "\n" "错误：'%0' 中的实参无效，仅支持整数">;
def err_drv_missing_argument : Error<
  "argument to '%0' is missing (expected %1 value%s1)"
  "\n" "错误：'%0' 的实参缺失（应提供 %1 个值%s1）">;
def err_drv_invalid_Xarch_argument_with_args : Error<
  "invalid Xarch argument: '%0', options requiring arguments are unsupported"
  "\n" "错误：无效的 Xarch 实参：'%0'，不支持需要实参的选项">;
def err_drv_Xopenmp_target_missing_triple : Error<
  "cannot deduce implicit triple value for -Xopenmp-target, specify triple using -Xopenmp-target=<triple>"
  "\n" "错误：无法为 -Xopenmp-target 推断隐式三元组值，请使用 -Xopenmp-target=<triple> 指定三元组">;
def err_drv_invalid_Xopenmp_target_with_args : Error<
  "invalid -Xopenmp-target argument: '%0', options requiring arguments are unsupported"
  "\n" "错误：无效的 -Xopenmp-target 实参：'%0'，不支持需要实参的选项">;
def err_drv_argument_only_allowed_with : Error<
  "invalid argument '%0' only allowed with '%1'"
  "\n" "错误：无效的实参 '%0'，仅允许与 '%1' 一起使用">;
def err_drv_opt_unsupported_input_type : Error<
  "'%0' invalid for input of type %1"
  "\n" "错误：'%0' 对类型 %1 的输入无效">;
def err_drv_amdgpu_ieee_without_no_honor_nans : Error<
  "invalid argument '-mno-amdgpu-ieee' only allowed with relaxed NaN handling"
  "\n" "错误：无效的实参 '-mno-amdgpu-ieee'，仅允许在宽松的 NaN 处理下使用">;
def err_drv_argument_not_allowed_with : Error<
  "invalid argument '%0' not allowed with '%1'"
  "\n" "错误：无效的实参 '%0'，不允许与 '%1' 一起使用">;
def warn_drv_argument_not_allowed_with : Warning<
  "invalid argument '%0' not allowed with '%1'"
  "\n" "警告：无效的实参 '%0'，不允许与 '%1' 一起使用">,
  InGroup<OptionIgnored>;
def err_drv_sycl_requires_cxx17 : Error<
  "SYCL requires C++17 or later; '%0' is not supported"
  "\n" "错误：SYCL 需要 C++17 或更高版本；不支持 '%0'">;
def err_drv_cannot_open_randomize_layout_seed_file : Error<
  "cannot read randomize layout seed file '%0'"
  "\n" "错误：无法读取随机化布局种子文件 '%0'">;
def err_drv_invalid_version_number : Error<
  "invalid version number in '%0'"
  "\n" "错误：'%0' 中有无效的版本号">;
def err_drv_invalid_version_number_inferred
    : Error<"invalid version number '%0' inferred from '%1'"
    "\n" "错误：从 '%1' 推断出的版本号 '%0' 无效">;
def err_drv_missing_version_number : Error<"missing version number in '%0'"
  "\n" "错误：'%0' 中缺少版本号">;
def err_drv_kcfi_arity_unsupported_target : Error<
  "target '%0' is unsupported by -fsanitize-kcfi-arity"
  "\n" "错误：-fsanitize-kcfi-arity 不支持目标 '%0'">;
def err_drv_no_linker_llvm_support : Error<
  "'%0': unable to pass LLVM bit-code files to linker"
  "\n" "错误：'%0'：无法将 LLVM 位码文件传递给链接器">;
def err_drv_no_ast_support : Error<
  "'%0': unable to use AST files with this tool"
  "\n" "错误：'%0'：无法在此工具中使用 AST 文件">;
def err_drv_no_module_support : Error<
  "'%0': unable to use module files with this tool"
  "\n" "错误：'%0'：无法在此工具中使用模块文件">;
def err_drv_clang_unsupported : Error<
  "the clang compiler does not support '%0'"
  "\n" "错误：clang 编译器不支持 '%0'">;
def err_drv_clang_unsupported_opt_cxx_darwin_i386 : Error<
  "the clang compiler does not support '%0' for C++ on Darwin/i386"
  "\n" "错误：clang 编译器不支持 Darwin/i386 上用于 C++ 的 '%0'">;
def err_drv_clang_unsupported_opt_pg_darwin: Error<
  "the clang compiler does not support -pg option on %select{Darwin|versions of OS X 10.9 and later}0"
  "\n" "错误：clang 编译器不支持 %select{Darwin|OS X 10.9 及更高版本}0上的 -pg 选项">;
def err_drv_clang_unsupported_opt_faltivec : Error<
  "the clang compiler does not support '%0', %1"
  "\n" "错误：clang 编译器不支持 '%0'，%1">;
def err_drv_command_failed : Error<
  "%0 command failed with exit code %1 (use -v to see invocation)"
  "\n" "错误：%0 命令失败，退出码为 %1（使用 -v 查看调用）">;
def err_drv_compilationdatabase : Error<
  "compilation database '%0' could not be opened: %1"
  "\n" "错误：无法打开编译数据库 '%0'：%1">;
def err_drv_command_signalled : Error<
  "%0 command failed due to signal (use -v to see invocation)"
  "\n" "错误：%0 命令因信号而失败（使用 -v 查看调用）">;
def err_drv_force_crash : Error<
  "failing because %select{environment variable 'FORCE_CLANG_DIAGNOSTICS_CRASH' is set|'-gen-reproducer' is used}0"
  "\n" "错误：由于%select{环境变量 'FORCE_CLANG_DIAGNOSTICS_CRASH' 已设置|使用了 '-gen-reproducer'}0而失败">;
def err_drv_invalid_mfloat_abi : Error<
  "invalid float ABI '%0'"
  "\n" "错误：无效的浮点 ABI '%0'">;
def err_drv_invalid_mtp : Error<
  "invalid thread pointer reading mode '%0'"
  "\n" "错误：无效的线程指针读取模式 '%0'">;
def err_drv_missing_arg_mtp : Error<
  "missing argument to '%0'"
  "\n" "错误：'%0' 缺少实参">;
def warn_drv_missing_plugin_name : Warning<
  "missing plugin name in %0"
  "\n" "警告：%0 中缺少插件名称">,
  InGroup<InvalidCommandLineArgument>;
def warn_drv_missing_plugin_arg : Warning<
  "missing plugin argument for plugin %0 in %1"
  "\n" "警告：%1 中插件 %0 缺少插件实参">,
  InGroup<InvalidCommandLineArgument>;
def err_drv_invalid_argument_to_option : Error<
  "invalid argument '%0' to -%1"
  "\n" "错误：-%1 的实参 '%0' 无效">;
def err_drv_missing_sanitizer_ignorelist : Error<
  "missing sanitizer ignorelist: '%0'"
  "\n" "错误：缺少消毒器忽略列表：'%0'">;
def err_drv_malformed_sanitizer_ignorelist : Error<
  "malformed sanitizer ignorelist: '%0'"
  "\n" "错误：格式错误的消毒器忽略列表：'%0'">;
def err_drv_malformed_sanitizer_coverage_allowlist : Error<
  "malformed sanitizer coverage allowlist: '%0'"
  "\n" "错误：格式错误的消毒器覆盖允许列表：'%0'">;
def err_drv_malformed_sanitizer_coverage_ignorelist : Error<
  "malformed sanitizer coverage ignorelist: '%0'"
  "\n" "错误：格式错误的消毒器覆盖忽略列表：'%0'">;
def err_drv_malformed_sanitizer_metadata_ignorelist : Error<
  "malformed sanitizer metadata ignorelist: '%0'"
  "\n" "错误：格式错误的消毒器元数据忽略列表：'%0'">;
def err_drv_unsupported_static_sanitizer_darwin : Error<
  "static %0 runtime is not supported on darwin"
  "\n" "错误：darwin 上不支持静态 %0 运行时">;
def err_drv_duplicate_config : Error<
  "no more than one option '--config' is allowed"
  "\n" "错误：最多允许一个 '--config' 选项">;
def err_drv_cannot_open_config_file : Error<
  "configuration file '%0' cannot be opened: %1"
  "\n" "错误：无法打开配置文件 '%0'：%1">;
def err_drv_config_file_not_found : Error<
  "configuration file '%0' cannot be found"
  "\n" "错误：找不到配置文件 '%0'">;
def note_drv_config_file_searched_in : Note<
  "was searched for in the directory: %0"
  "\n" "提示：在目录中搜索过它：%0">;
def err_drv_cannot_read_config_file : Error<
  "cannot read configuration file '%0': %1"
  "\n" "错误：无法读取配置文件 '%0'：%1">;
def err_drv_arg_requires_bitcode_input: Error<
  "option '%0' requires input to be LLVM bitcode"
  "\n" "错误：选项 '%0' 要求输入为 LLVM 位码">;

def err_target_unsupported_arch
  : Error<"the target architecture '%0' is not supported by the target '%1'"
  "\n" "错误：目标 '%1' 不支持目标架构 '%0'">;
def err_cpu_unsupported_isa
  : Error<"CPU '%0' does not support '%1' execution mode"
  "\n" "错误：CPU '%0' 不支持 '%1' 执行模式">;
def err_arch_unsupported_isa
  : Error<"architecture '%0' does not support '%1' execution mode"
  "\n" "错误：架构 '%0' 不支持 '%1' 执行模式">;

def err_zos_target_release_discontinued
  : Error<"z/OS target level \"%0\" is discontinued"
  "\n" "错误：z/OS 目标级别 \"%0\" 已停止使用">;
def err_zos_target_unrecognized_release
  : Error<"z/OS target level \"%0\" is invalid"
  "\n" "错误：z/OS 目标级别 \"%0\" 无效">;

def err_drv_I_dash_not_supported : Error<
  "'%0' not supported, please use -iquote instead"
  "\n" "错误：不支持 '%0'，请改用 -iquote">;
def err_drv_unknown_argument : Error<"unknown argument: '%0'"
  "\n" "错误：未知的实参：'%0'">;
def err_drv_unknown_argument_with_suggestion : Error<
  "unknown argument '%0'; did you mean '%1'?"
  "\n" "错误：未知的实参 '%0'；您是指 '%1' 吗？">;
def warn_drv_unknown_argument_clang_cl : Warning<
  "unknown argument ignored in clang-cl: '%0'"
  "\n" "警告：clang-cl 中忽略的未知实参：'%0'">,
  InGroup<UnknownArgument>;
def warn_drv_unknown_argument_clang_cl_with_suggestion : Warning<
  "unknown argument ignored in clang-cl '%0'; did you mean '%1'?"
  "\n" "警告：clang-cl 中忽略的未知实参 '%0'；您是指 '%1' 吗？">,
  InGroup<UnknownArgument>;
def err_drv_unknown_target_triple : Error<"unknown target triple '%0'"
  "\n" "错误：未知的目标三元组 '%0'">;

def warn_drv_ycyu_different_arg_clang_cl : Warning<
  "support for '/Yc' and '/Yu' with different filenames not implemented yet; flags ignored"
  "\n" "警告：尚未实现对 '/Yc' 和 '/Yu' 使用不同文件名的支持；标志被忽略">,
  InGroup<ClangClPch>;
def warn_drv_yc_multiple_inputs_clang_cl : Warning<
  "support for '/Yc' with more than one source file not implemented yet; flag ignored"
  "\n" "警告：尚未实现对 '/Yc' 使用多个源文件的支持；标志被忽略">,
  InGroup<ClangClPch>;

def warn_drv_potentially_misspelled_joined_argument : Warning<
  "joined argument treated as '%0'; did you mean '%1'?"
  "\n" "警告：连接实参被当作 '%0'；您是指 '%1' 吗？">, InGroup<UnknownArgument>;

def err_drv_too_many_actions: Error<
    "only one action option is allowed. Got %0"
    "\n" "错误：只允许一个操作选项。得到 %0 个">;
def err_drv_invalid_value : Error<"invalid value '%1' in '%0'"
  "\n" "错误：'%0' 中的值 '%1' 无效">;
def err_drv_invalid_int_value : Error<"invalid integral value '%1' in '%0'"
  "\n" "错误：'%0' 中的整数值 '%1' 无效">;
def err_drv_invalid_escaped_command_line
    : Error<"invalid escaped command line: %0"
    "\n" "错误：无效的转义命令行：%0">;
def err_drv_invalid_value_with_suggestion : Error<
    "invalid value '%1' in '%0', expected one of: %2"
    "\n" "错误：'%0' 中的值 '%1' 无效，应为其中之一：%2">;
def err_drv_alignment_not_power_of_two : Error<"alignment is not a power of 2 in '%0'"
  "\n" "错误：'%0' 中的对齐不是 2 的幂">;
def err_drv_invalid_remap_file : Error<
    "invalid option '%0' not of the form <from-file>;<to-file>"
    "\n" "错误：无效的选项 '%0'，不是 <from-file>;<to-file> 形式">;
def err_drv_invalid_gcc_install_dir : Error<"'%0' does not contain a GCC installation"
  "\n" "错误：'%0' 不包含 GCC 安装">;
def err_drv_invalid_gcc_output_type : Error<
    "invalid output type '%0' for use with gcc tool"
    "\n" "错误：与 gcc 工具一起使用的输出类型 '%0' 无效">;
def err_drv_cc_print_options_failure : Error<
    "unable to open CC_PRINT_OPTIONS file: %0"
    "\n" "错误：无法打开 CC_PRINT_OPTIONS 文件：%0">;
def err_drv_lto_without_lld : Error<"LTO requires -fuse-ld=lld"
  "\n" "错误：LTO 需要 -fuse-ld=lld">;
def err_drv_preamble_format : Error<
    "incorrect format for -preamble-bytes=N,END"
    "\n" "错误：-preamble-bytes=N,END 的格式不正确">;
def err_drv_header_unit_extra_inputs : Error<
    "multiple inputs are not valid for header units (first extra '%0')"
    "\n" "错误：多个输入对头单元无效（第一个多余的 '%0'）">;
def warn_invalid_ios_deployment_target : Warning<
  "invalid iOS deployment version '%0', iOS 10 is the maximum deployment "
  "target for 32-bit targets"
  "\n" "警告：无效的 iOS 部署版本 '%0'，iOS 10 是 32 位目标的最大部署目标">, InGroup<InvalidIOSDeploymentTarget>,
  DefaultError;
def err_invalid_macos_32bit_deployment_target : Error<
  "32-bit targets are not supported when building for Mac Catalyst"
  "\n" "错误：为 Mac Catalyst 构建时不支持 32 位目标">;
def err_drv_invalid_os_in_arg : Error<"invalid OS value '%0' in '%1'"
  "\n" "错误：'%1' 中有无效的 OS 值 '%0'">;
def err_drv_conflicting_deployment_targets : Error<
  "conflicting deployment targets, both '%0' and '%1' are present in environment"
  "\n" "错误：冲突的部署目标，环境中同时存在 '%0' 和 '%1'">;
def err_arc_unsupported_on_runtime : Error<
  "-fobjc-arc is not supported on platforms using the legacy runtime"
  "\n" "错误：使用旧式运行时的平台上不支持 -fobjc-arc">;
def err_arc_unsupported_on_toolchain : Error< // feel free to generalize this
  "-fobjc-arc is not supported on versions of OS X prior to 10.6"
  "\n" "错误：OS X 10.6 之前的版本不支持 -fobjc-arc">;
def err_objc_weak_with_gc : Error<
  "-fobjc-weak is not supported in Objective-C garbage collection"
  "\n" "错误：Objective-C 垃圾回收中不支持 -fobjc-weak">;
def err_objc_weak_unsupported : Error<
  "-fobjc-weak is not supported on the current deployment target"
  "\n" "错误：当前部署目标不支持 -fobjc-weak">;
def err_drv_mg_requires_m_or_mm : Error<
  "option '-MG' requires '-M' or '-MM'"
  "\n" "错误：选项 '-MG' 需要 '-M' 或 '-MM'">;
def err_drv_unknown_objc_runtime : Error<
  "unknown or ill-formed Objective-C runtime '%0'"
  "\n" "错误：未知或非良构的 Objective-C 运行时 '%0'">;
def err_drv_invalid_cf_runtime_abi
  : Error<"invalid CoreFoundation Runtime ABI '%0'; must be one of "
          "'objc', 'standalone', 'swift', 'swift-5.0', 'swift-4.2', 'swift-4.1'"
          "\n" "错误：无效的 CoreFoundation 运行时 ABI '%0'；必须是 "
          "'objc'、'standalone'、'swift'、'swift-5.0'、'swift-4.2'、'swift-4.1' 之一">;
def err_drv_gnustep_objc_runtime_incompatible_binary : Error<
  "GNUstep Objective-C runtime version %0 incompatible with target binary format"
  "\n" "错误：GNUstep Objective-C 运行时版本 %0 与目标二进制格式不兼容">;
def err_drv_emit_llvm_link : Error<
   "-emit-llvm cannot be used when linking"
   "\n" "错误：链接时不能使用 -emit-llvm">;
def err_drv_optimization_remark_pattern : Error<
  "in pattern '%1': %0"
  "\n" "错误：在模式 '%1' 中：%0">;
def err_drv_optimization_remark_format : Error<
  "unknown remark serializer format: '%0'"
  "\n" "错误：未知的备注序列化器格式：'%0'">;
def err_drv_no_neon_modifier : Error<"[no]neon is not accepted as modifier, please use [no]simd instead"
  "\n" "错误：不接受 [no]neon 作为修饰符，请改用 [no]simd">;
def err_drv_invalid_omp_target : Error<"OpenMP target is invalid: '%0'"
  "\n" "错误：OpenMP 目标无效：'%0'">;
def err_drv_incompatible_omp_arch : Error<"OpenMP target architecture '%0' pointer size is incompatible with host '%1'"
  "\n" "错误：OpenMP 目标架构 '%0' 的指针大小与主机 '%1' 不兼容">;
def err_drv_omp_host_target_not_supported : Error<
  "target '%0' is not a supported OpenMP host target"
  "\n" "错误：目标 '%0' 不是受支持的 OpenMP 主机目标">;
def err_drv_expecting_fopenmp_with_fopenmp_targets : Error<
  "'-fopenmp-targets' must be used in conjunction with a '-fopenmp' option "
  "compatible with offloading; e.g., '-fopenmp=libomp' or '-fopenmp=libiomp5'"
  "\n" "错误：'-fopenmp-targets' 必须与兼容卸载的 '-fopenmp' 选项一起使用；"
  "例如 '-fopenmp=libomp' 或 '-fopenmp=libiomp5'">;
def err_drv_failed_to_deduce_target_from_arch : Error<
  "failed to deduce triple for target architecture '%0'; specify the triple "
  "using '-fopenmp-targets' and '-Xopenmp-target' instead"
  "\n" "错误：无法为目标架构 '%0' 推断三元组；请改用 "
  "'-fopenmp-targets' 和 '-Xopenmp-target' 指定三元组">;
def err_drv_omp_offload_target_missingbcruntime : Error<
  "no library '%0' found in the default clang lib directory or in LIBRARY_PATH"
  "; use '--libomptarget-%1-bc-path' to specify %1 bitcode library"
  "\n" "错误：在默认的 clang lib 目录或 LIBRARY_PATH 中找不到库 '%0'"
  "；请使用 '--libomptarget-%1-bc-path' 指定 %1 位码库">;
def err_drv_omp_offload_target_bcruntime_not_found : Error<
  "bitcode library '%0' does not exist"
  "\n" "错误：位码库 '%0' 不存在">;
def err_drv_omp_offload_target_cuda_version_not_support : Error<
  "NVPTX target requires CUDA 9.2 or above; CUDA %0 detected"
  "\n" "错误：NVPTX 目标需要 CUDA 9.2 或更高版本；检测到 CUDA %0">;
def warn_drv_omp_offload_target_duplicate : Warning<
  "OpenMP offloading target '%0' is similar to target '%1' already specified; "
  "will be ignored"
  "\n" "警告：OpenMP 卸载目标 '%0' 与已指定的目标 '%1' 相似；将被忽略">, InGroup<OpenMPTarget>;
def err_drv_unsupported_embed_bitcode
    : Error<"%0 is not supported with -fembed-bitcode"
    "\n" "错误：%0 不支持 -fembed-bitcode">;
def err_drv_bitcode_unsupported_on_toolchain : Error<
  "-fembed-bitcode is not supported on versions of iOS prior to 6.0"
  "\n" "错误：iOS 6.0 之前的版本不支持 -fembed-bitcode">;
def err_drv_negative_columns : Error<
  "invalid value '%1' in '%0', value must be 'none' or a positive integer"
  "\n" "错误：'%0' 中的值 '%1' 无效，值必须是 'none' 或正整数">;
def err_drv_small_columns : Error<
  "invalid value '%1' in '%0', value must be '%2' or greater"
  "\n" "错误：'%0' 中的值 '%1' 无效，值必须大于或等于 '%2'">;
def warn_drv_fraw_string_literals_in_cxx11 : Warning<
  "ignoring '-f%select{no-|}0raw-string-literals', which is only valid for C and C++ standards before C++11"
  "\n" "警告：忽略 '-f%select{no-|}0raw-string-literals'，它仅对 C++11 之前的 C 和 C++ 标准有效">,
  InGroup<UnusedCommandLineArgument>;

def err_drv_libclc_not_found : Error<"no libclc library '%0' found in the clang resource directory"
  "\n" "错误：在 clang 资源目录中找不到 libclc 库 '%0'">;

def err_drv_invalid_malign_branch_EQ : Error<
  "invalid argument '%0' to -malign-branch=; each element must be one of: %1"
  "\n" "错误：-malign-branch= 的实参 '%0' 无效；每个元素必须是其中之一：%1">;

def err_drv_print_header_env_var : Error<
  "environment variable CC_PRINT_HEADERS_%select{FORMAT|FILTERING}0 has invalid value %1"
  "\n" "错误：环境变量 CC_PRINT_HEADERS_%select{FORMAT|FILTERING}0 的值 %1 无效">;
def err_drv_print_header_env_var_combination : Error<
  "unsupported combination: CC_PRINT_HEADERS_FORMAT=%0 and CC_PRINT_HEADERS_FILTERING=%1"
  "\n" "错误：不支持的组合：CC_PRINT_HEADERS_FORMAT=%0 和 CC_PRINT_HEADERS_FILTERING=%1">;
def err_drv_print_header_env_var_invalid_format : Error<
  "environment variable CC_PRINT_HEADERS_FORMAT=%0 requires a compatible value for CC_PRINT_HEADERS_FILTERING"
  "\n" "错误：环境变量 CC_PRINT_HEADERS_FORMAT=%0 需要 CC_PRINT_HEADERS_FILTERING 的兼容值">;
def err_drv_print_header_cc1_invalid_combination : Error<
  "unsupported combination: -header-include-format=%0 and -header-include-filtering=%1"
  "\n" "错误：不支持的组合：-header-include-format=%0 和 -header-include-filtering=%1">;
def err_drv_print_header_cc1_invalid_filtering : Error<
  "-header-include-filtering=%0 requires a compatible value for -header-include-format"
  "\n" "错误：-header-include-filtering=%0 需要 -header-include-format 的兼容值">;
def err_drv_print_header_cc1_invalid_format : Error<
  "-header-include-format=%0 requires a compatible value for -header-include-filtering"
  "\n" "错误：-header-include-format=%0 需要 -header-include-filtering 的兼容值">;

def warn_O4_is_O3 : Warning<"-O4 is equivalent to -O3"
  "\n" "警告：-O4 等同于 -O3">, InGroup<Deprecated>;
def warn_drv_optimization_value : Warning<"optimization level '%0' is not supported; using '%1%2' instead"
  "\n" "警告：不支持优化级别 '%0'；改用 '%1%2'">,
  InGroup<InvalidCommandLineArgument>;
def warn_ignored_gcc_optimization : Warning<"optimization flag '%0' is not supported"
  "\n" "警告：不支持优化标志 '%0'">,
  InGroup<IgnoredOptimizationArgument>;
def warn_ignored_clang_option : Warning<"the flag '%0' has been deprecated and will be ignored"
  "\n" "警告：标志 '%0' 已弃用，将被忽略">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_unsupported_opt_for_target : Warning<
  "optimization flag '%0' is not supported for target '%1'"
  "\n" "警告：目标 '%1' 不支持优化标志 '%0'">,
  InGroup<IgnoredOptimizationArgument>;
def warn_drv_riscv_be_experimental : Warning<
  "big-endian RISC-V target support is experimental"
  "\n" "警告：大端 RISC-V 目标支持是实验性的">,
  InGroup<RISCVBEExperimental>;
def warn_drv_unsupported_debug_info_opt_for_target : Warning<
  "debug information option '%0' is not supported for target '%1'"
  "\n" "警告：目标 '%1' 不支持调试信息选项 '%0'">,
  InGroup<UnsupportedTargetOpt>;
def warn_drv_dwarf_version_limited_by_target : Warning<
  "debug information option '%0' is not supported; requires DWARF-%2 but "
  "target '%1' only provides DWARF-%3"
  "\n" "警告：不支持调试信息选项 '%0'；需要 DWARF-%2，但目标 '%1' 仅提供 DWARF-%3">,
  InGroup<UnsupportedTargetOpt>;
def warn_c_kext : Warning<
  "ignoring -fapple-kext which is valid for C++ and Objective-C++ only"
  "\n" "警告：忽略 -fapple-kext，它仅对 C++ 和 Objective-C++ 有效">;
def warn_ignoring_fdiscard_for_bitcode : Warning<
  "ignoring -fdiscard-value-names for LLVM Bitcode"
  "\n" "警告：忽略 LLVM 位码的 -fdiscard-value-names">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_input_file_unused : Warning<
  "%0: '%1' input unused%select{ when '%3' is present|}2"
  "\n" "警告：%0：'%1' 输入未使用%select{ 当存在 '%3' 时|}2">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_input_file_unused_by_cpp : Warning<
  "%0: '%1' input unused in cpp mode"
  "\n" "警告：%0：在 cpp 模式下输入 '%1' 未使用">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_preprocessed_input_file_unused : Warning<
  "%0: previously preprocessed input%select{ unused when '%2' is present|}1"
  "\n" "警告：%0：先前预处理过的输入%select{ 当存在 '%2' 时未使用|}1">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_unused_argument : Warning<
  "argument unused during compilation: '%0'"
  "\n" "警告：编译期间未使用的实参：'%0'">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_unused_x : Warning<
  "'-x %0' after last input file has no effect"
  "\n" "警告：最后一个输入文件之后的 '-x %0' 没有效果">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_empty_joined_argument : Warning<
  "joined argument expects additional value: '%0'"
  "\n" "警告：连接实参需要额外的值：'%0'">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_diagnostics_hotness_requires_pgo : Warning<
  "argument '%0' requires profile-guided optimization information"
  "\n" "警告：实参 '%0' 需要配置文件引导的优化信息">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_diagnostics_misexpect_requires_pgo : Warning<
  "argument '%0' requires profile-guided optimization information"
  "\n" "警告：实参 '%0' 需要配置文件引导的优化信息">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_clang_unsupported : Warning<
  "the clang compiler does not support '%0'"
  "\n" "警告：clang 编译器不支持 '%0'">;
def warn_drv_deprecated_arg : Warning<
  "argument '%0' is deprecated%select{|, use '%2' instead}1"
  "\n" "警告：实参 '%0' 已弃用%select{|，请改用 '%2'}1">, InGroup<Deprecated>;
def warn_drv_deprecated_arg_ofast : Warning<
  "argument '-Ofast' is deprecated; use '-O3' to enable only conforming optimizations, "
  "or consult the documentation for the same behavior"
  "\n" "警告：实参 '-Ofast' 已弃用；使用 '-O3' 仅启用符合规范的优化，"
  "或查阅文档了解相同行为">,
  InGroup<DeprecatedOFast>;
def warn_drv_deprecated_arg_ofast_for_flang : Warning<
  "argument '-Ofast' is deprecated; use '-O3 -ffast-math -fstack-arrays -fno-protect-parens' for the same behavior,"
  " or '-O3 -fstack-arrays' to enable only conforming optimizations"
  "\n" "警告：实参 '-Ofast' 已弃用；使用 '-O3 -ffast-math -fstack-arrays -fno-protect-parens' "
  "以获得相同行为，或使用 '-O3 -fstack-arrays' 仅启用符合规范的优化">,
  InGroup<DeprecatedOFast>;
def warn_drv_deprecated_custom : Warning<
  "argument '%0' is deprecated, %1"
  "\n" "警告：实参 '%0' 已弃用，%1">, InGroup<Deprecated>;
def warn_drv_assuming_mfloat_abi_is : Warning<
  "unknown platform, assuming -mfloat-abi=%0"
  "\n" "警告：未知平台，假定 -mfloat-abi=%0">;
def warn_drv_unsupported_float_abi_by_lib : Warning<
  "float ABI '%0' is not supported by current library"
  "\n" "警告：当前库不支持浮点 ABI '%0'">,
  InGroup<UnsupportedABI>;
def warn_drv_no_floating_point_registers: Warning<
  "'%0': selected processor lacks floating point registers"
  "\n" "警告：'%0'：所选处理器缺少浮点寄存器">,
  InGroup<UnsupportedABI>;
def warn_ignoring_ftabstop_value : Warning<
  "ignoring invalid -ftabstop value '%0', using default value %1"
  "\n" "警告：忽略无效的 -ftabstop 值 '%0'，使用默认值 %1">;
def warn_drv_overriding_option : Warning<
  "overriding '%0' option with '%1'"
  "\n" "警告：用 '%1' 覆盖 '%0' 选项">,
  InGroup<DiagGroup<"overriding-option">>;
def warn_drv_overriding_deployment_version
    : Warning<"overriding deployment version from '%0' to '%1'"
      "\n" "警告：将部署版本从 '%0' 覆盖为 '%1'">,
      InGroup<DiagGroup<"overriding-deployment-version">>;
def warn_drv_overriding_complex_range : Warning<
  "'%1' sets complex range to \"%3\" overriding the setting of \"%2\" that was implied by '%0'"
  "\n" "警告：'%1' 将复数范围设置为 \"%3\"，覆盖了由 '%0' 隐含的 \"%2\" 设置">,
  InGroup<DiagGroup<"overriding-complex-range">>;
def warn_drv_treating_input_as_cxx : Warning<
  "treating '%0' input as '%1' when in C++ mode, this behavior is deprecated"
  "\n" "警告：在 C++ 模式下将 '%0' 输入当作 '%1' 处理，此行为已弃用">,
  InGroup<Deprecated>;
def warn_drv_pch_not_first_include : Warning<
  "precompiled header '%0' was ignored because '%1' is not first '-include'"
  "\n" "警告：预编译头 '%0' 被忽略，因为 '%1' 不是第一个 '-include'">;
def warn_drv_pch_ignoring_gch_file : Warning<
  "precompiled header '%0' was ignored because it is not a clang PCH file"
  "\n" "警告：预编译头 '%0' 被忽略，因为它不是 clang PCH 文件">,
  InGroup<IgnoredGCH>;
def warn_drv_pch_ignoring_gch_dir : Warning<
  "precompiled header directory '%0' was ignored because it contains no clang PCH files"
  "\n" "警告：预编译头目录 '%0' 被忽略，因为它不包含 clang PCH 文件">,
  InGroup<IgnoredGCH>;
def warn_missing_sysroot : Warning<"no such sysroot directory: '%0'"
  "\n" "警告：没有这样的系统根目录：'%0'">,
  InGroup<DiagGroup<"missing-sysroot">>;
def warn_incompatible_sysroot : Warning<"using sysroot for '%0' but targeting '%1'"
  "\n" "警告：为 '%0' 使用系统根目录，但目标为 '%1'">,
  InGroup<DiagGroup<"incompatible-sysroot">>;
def warn_debug_compression_unavailable : Warning<"cannot compress debug sections (%0 not enabled)"
  "\n" "警告：无法压缩调试段（%0 未启用）">,
  InGroup<DiagGroup<"debug-compression-unavailable">>;
def warn_drv_disabling_vptr_no_rtti_default : Warning<
  "implicitly disabling vptr sanitizer because rtti wasn't enabled"
  "\n" "警告：由于未启用 rtti，正在隐式禁用 vptr 消毒器">,
  InGroup<AutoDisableVptrSanitizer>;
def warn_drv_object_size_disabled_O0 : Warning<
  "the object size sanitizer has no effect at -O0, but is explicitly enabled: %0"
  "\n" "警告：对象大小消毒器在 -O0 下没有效果，但已显式启用：%0">,
  InGroup<InvalidCommandLineArgument>, DefaultWarnNoWerror;
def warn_ignoring_verify_debuginfo_preserve_export : Warning<
  "ignoring -fverify-debuginfo-preserve-export=%0 because "
  "-fverify-debuginfo-preserve wasn't enabled"
  "\n" "警告：忽略 -fverify-debuginfo-preserve-export=%0，因为未启用 "
  "-fverify-debuginfo-preserve">,
  InGroup<UnusedCommandLineArgument>;
def warn_unsupported_branch_protection: Warning <
  "invalid branch protection option '%0' in '%1'"
  "\n" "警告：'%1' 中有无效的分支保护选项 '%0'">, InGroup<BranchProtection>;
def err_sls_hardening_arm_not_supported : Error<
  "-mharden-sls is only supported on armv7-a or later"
  "\n" "错误：-mharden-sls 仅支持 armv7-a 或更高版本">;
def warn_drv_large_data_threshold_invalid_code_model: Warning<
  "'%0' only applies to medium and large code models"
  "\n" "警告：'%0' 仅适用于中型和大型代码模型">,
  InGroup<UnusedCommandLineArgument>;
def warn_drv_math_errno_enabled_after_veclib: Warning<
  "math errno enabled by '%0' after it was implicitly disabled by '%1',"
  " this may limit the utilization of the vector library"
  "\n" "警告：'%0' 在 '%1' 隐式禁用 errno 之后启用了数学 errno，"
  "这可能会限制向量库的利用率">,
  InGroup<MathErrnoEnabledWithVecLib>;

def note_drv_command_failed_diag_msg : Note<
  "diagnostic msg: %0"
  "\n" "提示：诊断消息：%0">;
def note_drv_t_option_is_global : Note<
  "the last '/TC' or '/TP' option takes precedence over earlier instances"
  "\n" "提示：最后一个 '/TC' 或 '/TP' 选项优先于更早的实例">;
def note_drv_address_sanitizer_debug_runtime : Note<
  "AddressSanitizer doesn't support linking with debug runtime libraries yet"
  "\n" "提示：AddressSanitizer 尚不支持与调试运行时库链接">;
def note_drv_use_standard : Note<"use '%0'"
  "%select{| or '%3'|, '%3', or '%4'|, '%3', '%4', or '%5'}2 "
  "for '%1' standard"
  "\n" "提示：为 '%1' 标准使用 '%0'"
  "%select{| 或 '%3'|、'%3' 或 '%4'|、'%3'、'%4' 或 '%5'}2">;

def err_analyzer_config_no_value : Error<
  "analyzer-config option '%0' has a key but no value"
  "\n" "错误：analyzer-config 选项 '%0' 有键但没有值">;
def err_analyzer_config_multiple_values : Error<
  "analyzer-config option '%0' should contain only one '='"
  "\n" "错误：analyzer-config 选项 '%0' 应只包含一个 '='">;
def err_analyzer_config_invalid_input : Error<
  "invalid input for analyzer-config option '%0', that expects %1 value"
  "\n" "错误：analyzer-config 选项 '%0' 的输入无效，它期望 %1 值">;
def err_analyzer_config_unknown : Error<"unknown analyzer-config '%0'"
  "\n" "错误：未知的 analyzer-config '%0'">;
def err_analyzer_checker_option_unknown : Error<
  "checker '%0' has no option called '%1'"
  "\n" "错误：检查器 '%0' 没有名为 '%1' 的选项">;
def err_analyzer_checker_option_invalid_input : Error<
  "invalid input for checker option '%0', that expects %1"
  "\n" "错误：检查器选项 '%0' 的输入无效，它期望 %1">;
def err_analyzer_checker_incompatible_analyzer_option : Error<
  "checker cannot be enabled with analyzer option '%0' == %1"
  "\n" "错误：检查器不能与分析器选项 '%0' == %1 一起启用">;
def err_analyzer_not_built_with_z3 : Error<
  "analyzer constraint manager 'unsupported-z3' is only available if LLVM was "
  "built with -DLLVM_ENABLE_Z3_SOLVER=ON"
  "\n" "错误：分析器约束管理器 'unsupported-z3' 仅在 LLVM 使用 "
  "-DLLVM_ENABLE_Z3_SOLVER=ON 构建时才可用">;

def warn_drv_needs_hvx : Warning<
  "%0 requires HVX, use -mhvx/-mhvx= to enable it"
  "\n" "警告：%0 需要 HVX，使用 -mhvx/-mhvx= 启用它">,
  InGroup<OptionIgnored>;
def err_drv_needs_hvx : Error<
  "%0 requires HVX, use -mhvx/-mhvx= to enable it"
  "\n" "错误：%0 需要 HVX，使用 -mhvx/-mhvx= 启用它">;
def err_drv_needs_hvx_version : Error<
  "%0 is not supported on HVX %1"
  "\n" "错误：HVX %1 上不支持 %0">;

def err_drv_module_header_wrong_kind : Error<
  "header file '%0' input type '%1' does not match type of prior input "
  "in module compilation; use '-x %2' to override"
  "\n" "错误：头文件 '%0' 的输入类型 '%1' 与模块编译中先前输入的类别不匹配；"
  "使用 '-x %2' 覆盖">;
def err_drv_modules_validate_once_requires_timestamp : Error<
  "option '-fmodules-validate-once-per-build-session' requires "
  "'-fbuild-session-timestamp=<seconds since Epoch>' or '-fbuild-session-file=<file>'"
  "\n" "错误：选项 '-fmodules-validate-once-per-build-session' 需要 "
  "'-fbuild-session-timestamp=<seconds since Epoch>' 或 '-fbuild-session-file=<file>'">;

def err_test_module_file_extension_format : Error<
  "-ftest-module-file-extension argument '%0' is not of the required form "
  "'blockname:major:minor:hashed:user info'"
  "\n" "错误：-ftest-module-file-extension 实参 '%0' 不是所需的 "
  "'blockname:major:minor:hashed:user info' 形式">;

def err_drv_module_output_with_multiple_arch : Error<
  "option '-fmodule-output' cannot be used with multiple arch options"
  "\n" "错误：选项 '-fmodule-output' 不能与多个架构选项一起使用">;

def err_drv_reduced_module_output_overrided : Warning<
  "the implicit output of reduced BMI may be overrided by the output file specified by '--precompile'. "
  "please consider use '-fmodule-output=' to specify the output file for reduced BMI explicitly"
  "\n" "警告：缩减 BMI 的隐式输出可能被 '--precompile' 指定的输出文件覆盖。"
  "请考虑使用 '-fmodule-output=' 为缩减 BMI 显式指定输出文件">,
  InGroup<DiagGroup<"reduced-bmi-output-overrided">>;

def err_drv_modules_driver_requires_reduced_bmi : Error<
  "'-fmodules-driver' is currently incompatible with '-fno-modules-reduced-bmi'"
  "\n" "错误：'-fmodules-driver' 当前与 '-fno-modules-reduced-bmi' 不兼容">;
def remark_performing_driver_managed_module_build : Remark<
  "performing driver managed module build"
  "\n" "备注：正在执行驱动程序管理的模块构建">, InGroup<ModulesDriver>;
def remark_modules_manifest_not_found : Remark<
  "standard modules manifest file not found; import of standard library "
  "modules not supported"
  "\n" "备注：找不到标准模块清单文件；不支持导入标准库模块">,
  InGroup<ModulesDriver>;
def remark_using_modules_manifest : Remark<
  "using standard modules manifest file '%0'"
  "\n" "备注：正在使用标准模块清单文件 '%0'">,
  InGroup<ModulesDriver>;
def err_modules_manifest_failed_parse : Error<
  "failure while parsing standard modules manifest: '%0'"
  "\n" "错误：解析标准模块清单时失败：'%0'">;
def err_default_modules_cache_not_available : Error<
  "unable to determine the default -fmodules-cache-path. Please specify it "
  "explicitly using -fmodules-cache-path or the CLANG_MODULE_CACHE_PATH "
  "environment variable"
  "\n" "错误：无法确定默认的 -fmodules-cache-path。请使用 -fmodules-cache-path "
  "或 CLANG_MODULE_CACHE_PATH 环境变量显式指定它">;
def err_dependency_scan_failed : Error<
  "failed to perform dependency scan"
  "\n" "错误：无法执行依赖扫描">;
def err_modules_driver_named_module_redefinition : Error<
  "duplicate definitions of C++20 named module '%0' in '%1' and '%2'"
  "\n" "错误：在 '%1' 和 '%2' 中重复定义了 C++20 具名模块 '%0'">;
def remark_printing_module_graph : Remark<
  "printing module dependency graph"
  "\n" "备注：正在打印模块依赖图">,
  InGroup<ModulesDriver>;
def err_module_defined_outside_of_module_source : Error<
  "module '%0' is defined in file '%1', but module declarations are only "
  "allowed in C++ module inputs; use the '.cppm' extension or '-x c++module'"
  "\n" "错误：模块 '%0' 定义在文件 '%1' 中，但模块声明只允许出现在 C++ "
  "模块输入中；请使用 '.cppm' 扩展名或 '-x c++module'">;

def warn_drv_delayed_template_parsing_after_cxx20 : Warning<
  "-fdelayed-template-parsing is deprecated after C++20"
  "\n" "警告：-fdelayed-template-parsing 在 C++20 之后已弃用">,
  InGroup<DiagGroup<"delayed-template-parsing-in-cxx20">>;

def err_drv_extract_api_wrong_kind : Error<
  "header file '%0' input '%1' does not match the type of prior input "
  "in api extraction; use '-x %2' to override"
  "\n" "错误：头文件 '%0' 的输入 '%1' 与 API 提取中先前输入的类别不匹配；"
  "使用 '-x %2' 覆盖">;

def err_drv_missing_symbol_graph_dir: Error<
  "must provide a symbol graph output directory using "
  "'--symbol-graph-dir=<directory>'"
  "\n" "错误：必须使用 '--symbol-graph-dir=<directory>' "
  "提供符号图输出目录">;

def err_drv_unexpected_symbol_graph_output : Error<
  "unexpected output symbol graph '%1'; please provide "
  "'--symbol-graph-dir=<directory>' instead"
  "\n" "错误：意外的输出符号图 '%1'；请改用 "
  "'--symbol-graph-dir=<directory>'">;

def warn_slash_u_filename : Warning<"'/U%0' treated as the '/U' option"
  "\n" "警告：'/U%0' 被当作 '/U' 选项处理">,
  InGroup<DiagGroup<"slash-u-filename">>;
def note_use_dashdash : Note<
  "use '--' to treat subsequent arguments as filenames"
  "\n" "提示：使用 '--' 将后续实参视为文件名">;

def err_drv_ropi_rwpi_incompatible_with_pic : Error<
  "embedded and GOT-based position independence are incompatible"
  "\n" "错误：嵌入式与基于 GOT 的位置无关性不兼容">;
def err_drv_ropi_incompatible_with_cxx : Error<
  "ROPI is not compatible with c++"
  "\n" "错误：ROPI 与 C++ 不兼容">;

def err_stack_tagging_requires_hardware_feature : Error<
  "'-fsanitize=memtag-stack' requires hardware support (+memtag). For Armv8 or "
  "Armv9, try compiling with -march=armv8a+memtag or -march=armv9a+memtag"
  "\n" "错误：'-fsanitize=memtag-stack' 需要硬件支持（+memtag）。对于 Armv8 或 "
  "Armv9，请尝试使用 -march=armv8a+memtag 或 -march=armv9a+memtag 编译">;

def err_cmse_pi_are_incompatible : Error<
  "cmse is not compatible with %select{RWPI|ROPI}0"
  "\n" "错误：cmse 与%select{RWPI|ROPI}0不兼容">;

def warn_target_unsupported_nan2008 : Warning<
  "ignoring '-mnan=2008' option because the '%0' architecture does not support it"
  "\n" "警告：因为 '%0' 架构不支持 '-mnan=2008' 选项，正在忽略它">,
  InGroup<UnsupportedNan>;
def warn_target_unsupported_nanlegacy : Warning<
  "ignoring '-mnan=legacy' option because the '%0' architecture does not support it"
  "\n" "警告：因为 '%0' 架构不支持 '-mnan=legacy' 选项，正在忽略它">,
  InGroup<UnsupportedNan>;
def warn_target_unsupported_abslegacy : Warning<
  "ignoring '-mabs=legacy' option because the '%0' architecture does not support it"
  "\n" "警告：因为 '%0' 架构不支持 '-mabs=legacy' 选项，正在忽略它">,
  InGroup<UnsupportedAbs>;
def warn_target_unsupported_abs2008 : Warning<
  "ignoring '-mabs=2008' option because the '%0' architecture does not support it"
  "\n" "警告：因为 '%0' 架构不支持 '-mabs=2008' 选项，正在忽略它">,
  InGroup<UnsupportedAbs>;
def warn_target_unsupported_compact_branches : Warning<
  "ignoring '-mcompact-branches=' option because the '%0' architecture does not"
  " support it"
  "\n" "警告：因为 '%0' 架构不支持 '-mcompact-branches=' 选项，正在忽略它">, InGroup<UnsupportedCB>;
def warn_target_unsupported_extension : Warning<
  "ignoring extension '%0' because the '%1' architecture does not support it"
  "\n" "警告：因为 '%1' 架构不支持扩展 '%0'，正在忽略它">,
   InGroup<InvalidCommandLineArgument>;
def warn_drv_unsupported_gpopt : Warning<
  "ignoring '-mgpopt' option as it cannot be used with %select{|the implicit"
  " usage of }0-mabicalls"
  "\n" "警告：由于 '-mgpopt' 选项不能与%select{|的隐式使用 }0-mabicalls "
  "一起使用，正在忽略它">,
  InGroup<UnsupportedGPOpt>;
def warn_drv_unsupported_longcalls : Warning<
  "ignoring '-mlong-calls' option as it is not currently supported with "
  "%select{|the implicit usage of }0-mabicalls"
  "\n" "警告：由于当前不支持将 '-mlong-calls' 选项与"
  "%select{|的隐式使用 }0-mabicalls 一起使用，正在忽略它">,
  InGroup<OptionIgnored>;
def warn_drv_unsupported_pic_with_mabicalls : Warning<
  "ignoring '%0' option as it cannot be used with "
  "%select{implicit usage of|}1 -mabicalls and the N64 ABI"
  "\n" "警告：由于 '%0' 选项不能与"
  "%select{隐式使用|}1 -mabicalls 和 N64 ABI 一起使用，正在忽略它">,
  InGroup<OptionIgnored>;
def err_drv_unsupported_noabicalls_pic : Error<
  "position-independent code requires '-mabicalls'"
  "\n" "错误：位置无关代码需要 '-mabicalls'">;
def err_drv_unsupported_indirect_jump_opt : Error<
  "'-mindirect-jump=%0' is unsupported with the '%1' architecture"
  "\n" "错误：'%1' 架构不支持 '-mindirect-jump=%0'">;
def err_drv_unknown_indirect_jump_opt : Error<
  "unknown '-mindirect-jump=' option '%0'"
  "\n" "错误：未知的 '-mindirect-jump=' 选项 '%0'">;
def err_drv_unsupported_fpatchable_function_entry_argument : Error<
  "the second argument of '-fpatchable-function-entry' must be smaller than the first argument"
  "\n" "错误：'-fpatchable-function-entry' 的第二个实参必须小于第一个实参">;

def warn_drv_unable_to_find_directory_expected : Warning<
  "unable to find %0 directory, expected to be in '%1' found via %2"
  "\n" "警告：无法找到 %0 目录，预期位于通过 %2 找到的 '%1' 中">,
  InGroup<InvalidOrNonExistentDirectory>, DefaultIgnore;

def warn_drv_ps_force_pic : Warning<
  "option '%0' was ignored by the %1 toolchain, using '-fPIC'"
  "\n" "警告：选项 '%0' 被 %1 工具链忽略，改用 '-fPIC'">,
  InGroup<OptionIgnored>;

def err_drv_defsym_invalid_format : Error<"defsym must be of the form: sym=value: %0"
  "\n" "错误：defsym 必须采用 sym=value 形式：%0">;
def err_drv_defsym_invalid_symval : Error<"value is not an integer: %0"
  "\n" "错误：值不是整数：%0">;
def warn_drv_msvc_not_found : Warning<
  "unable to find a Visual Studio installation; "
  "try running Clang from a developer command prompt"
  "\n" "警告：找不到 Visual Studio 安装；"
  "请尝试从开发人员命令提示符运行 Clang">,
  InGroup<DiagGroup<"msvc-not-found">>;

def warn_drv_fuse_ld_path : Warning<
  "'-fuse-ld=' taking a path is deprecated; use '--ld-path=' instead"
  "\n" "警告：'-fuse-ld=' 采用路径的形式已弃用；请改用 '--ld-path='">,
  InGroup<FUseLdPath>, DefaultIgnore;

def warn_drv_fine_grained_bitfield_accesses_ignored : Warning<
  "option '-ffine-grained-bitfield-accesses' cannot be enabled together with a sanitizer; flag ignored"
  "\n" "警告：选项 '-ffine-grained-bitfield-accesses' 不能与消毒器一起启用；标志被忽略">,
  InGroup<OptionIgnored>;

def err_drv_profile_instrument_use_path_with_no_kind : Error<
  "option '-fprofile-instrument-use-path=' requires -fprofile-instrument-use=<kind>"
  "\n" "错误：选项 '-fprofile-instrument-use-path=' 需要 -fprofile-instrument-use=<kind>">;

def note_drv_verify_prefix_spelling : Note<
  "-verify prefixes must start with a letter and contain only alphanumeric"
  " characters, hyphens, and underscores"
  "\n" "提示：-verify 前缀必须以字母开头，并且只包含字母数字"
  "字符、连字符和下划线">;

def note_command_line_code_loc_requirement
    : Note<"-code-completion-at=<file>:<line>:<column> requires <line> and "
           "<column> to be integers greater than zero"
           "\n" "提示：-code-completion-at=<file>:<line>:<column> 要求 "
           "<line> 和 <column> 为大于零的整数">;

def warn_drv_global_isel_incomplete : Warning<
  "-fglobal-isel support for the '%0' architecture is incomplete"
  "\n" "警告：对 '%0' 架构的 -fglobal-isel 支持不完整">,
  InGroup<GlobalISel>;

def warn_drv_global_isel_incomplete_opt : Warning<
  "-fglobal-isel support is incomplete for this architecture at the current optimization level"
  "\n" "警告：在当前优化级别下，此架构的 -fglobal-isel 支持不完整">,
  InGroup<GlobalISel>;

def warn_drv_moutline_unsupported_opt : Warning<
  "'%0' does not support '-moutline'; flag ignored"
  "\n" "警告：'%0' 不支持 '-moutline'；标志被忽略">,
  InGroup<OptionIgnored>;

def warn_drv_moutline_atomics_unsupported_opt : Warning<
  "'%0' does not support '-%1'; flag ignored"
  "\n" "警告：'%0' 不支持 '-%1'；标志被忽略">,
  InGroup<OptionIgnored>;

def warn_drv_darwin_sdk_invalid_settings : Warning<
  "SDK settings were ignored as 'SDKSettings.json' could not be parsed"
  "\n" "警告：由于无法解析 'SDKSettings.json'，SDK 设置被忽略">,
  InGroup<DiagGroup<"darwin-sdk-settings">>;

def err_missing_sysroot : Error<"no such sysroot directory: '%0'"
  "\n" "错误：没有这样的系统根目录：'%0'">;
def err_drv_darwin_sdk_missing_arclite : Error<
  "SDK does not contain 'libarclite' at the path '%0'; try increasing the minimum deployment target"
  "\n" "错误：SDK 在路径 '%0' 处不包含 'libarclite'；请尝试提高最低部署目标">;

def err_drv_trivial_auto_var_init_stop_after_missing_dependency : Error<
  "'-ftrivial-auto-var-init-stop-after=*' is used without "
  "'-ftrivial-auto-var-init=zero' or '-ftrivial-auto-var-init=pattern'"
  "\n" "错误：'-ftrivial-auto-var-init-stop-after=*' 在没有 "
  "'-ftrivial-auto-var-init=zero' 或 '-ftrivial-auto-var-init=pattern' 的情况下使用">;

def err_drv_trivial_auto_var_init_stop_after_invalid_value : Error<
  "'-ftrivial-auto-var-init-stop-after=*' only accepts positive integers"
  "\n" "错误：'-ftrivial-auto-var-init-stop-after=*' 只接受正整数">;

def err_drv_trivial_auto_var_init_max_size_missing_dependency : Error<
  "'-ftrivial-auto-var-init-max-size=*' is used without "
  "'-ftrivial-auto-var-init=zero' or '-ftrivial-auto-var-init=pattern'"
  "\n" "错误：'-ftrivial-auto-var-init-max-size=*' 在没有 "
  "'-ftrivial-auto-var-init=zero' 或 '-ftrivial-auto-var-init=pattern' 的情况下使用">;

def err_drv_trivial_auto_var_init_max_size_invalid_value : Error<
  "'-ftrivial-auto-var-init-max-size=*' only accepts positive integers (in bytes)"
  "\n" "错误：'-ftrivial-auto-var-init-max-size=*' 只接受正整数（以字节为单位）">;

def warn_drv_msp430_hwmult_unsupported : Warning<
  "the given MCU does not support hardware multiply, but '-mhwmult' is set to "
  "%0"
  "\n" "警告：给定的 MCU 不支持硬件乘法，但 '-mhwmult' 设置为 %0">, InGroup<InvalidCommandLineArgument>;
def warn_drv_msp430_hwmult_mismatch : Warning<
  "the given MCU supports %0 hardware multiply, but '-mhwmult' is set to %1"
  "\n" "警告：给定的 MCU 支持 %0 硬件乘法，但 '-mhwmult' 设置为 %1">,
   InGroup<InvalidCommandLineArgument>;
def warn_drv_msp430_hwmult_no_device : Warning<
  "no MCU device specified, but '-mhwmult' is set to 'auto', assuming no "
  "hardware multiply; use '-mmcu' to specify an MSP430 device, or '-mhwmult' "
  "to set the hardware multiply type explicitly"
  "\n" "警告：未指定 MCU 设备，但 '-mhwmult' 设置为 'auto'，假定没有硬件乘法；"
  "请使用 '-mmcu' 指定 MSP430 设备，或使用 '-mhwmult' 显式设置硬件乘法类型">,
  InGroup<InvalidCommandLineArgument>;

def warn_drv_libstdcxx_not_found : Warning<
  "include path for libstdc++ headers not found; pass '-stdlib=libc++' on the "
  "command line to use the libc++ standard library instead"
  "\n" "警告：找不到 libstdc++ 头文件的包含路径；请在命令行传递 "
  "'-stdlib=libc++' 以改用 libc++ 标准库">,
  InGroup<DiagGroup<"stdlibcxx-not-found">>;

def err_drv_cannot_mix_options : Error<"cannot specify '%1' along with '%0'"
  "\n" "错误：不能将 '%1' 与 '%0' 一起指定">;

def err_drv_invalid_object_mode : Error<
  "OBJECT_MODE setting %0 is not recognized and is not a valid setting"
  "\n" "错误：OBJECT_MODE 设置 %0 无法识别，不是有效的设置">;

def err_roptr_requires_data_sections: Error<"-mxcoff-roptr is supported only with -fdata-sections"
  "\n" "错误：-mxcoff-roptr 仅支持与 -fdata-sections 一起使用">;
def err_roptr_cannot_build_shared: Error<"-mxcoff-roptr is not supported with -shared"
  "\n" "错误：-mxcoff-roptr 不支持与 -shared 一起使用">;

def err_invalid_cxx_abi : Error<"invalid C++ ABI name '%0'"
  "\n" "错误：无效的 C++ ABI 名称 '%0'">;
def err_unsupported_cxx_abi : Error<"C++ ABI '%0' is not supported on target triple '%1'"
  "\n" "错误：目标三元组 '%1' 不支持 C++ ABI '%0'">;

def note_cc1_round_trip_original : Note<"original arguments in round-trip: %0"
  "\n" "提示：往返中的原始实参：%0">;
def note_cc1_round_trip_generated : Note<
  "generated arguments #%0 in round-trip: %1"
  "\n" "提示：往返中生成的实参 #%0：%1">;
def remark_cc1_round_trip_generated : Remark<
  "generated arguments #%0 in round-trip: %1"
  "\n" "备注：往返中生成的实参 #%0：%1">, InGroup<RoundTripCC1Args>;
def err_cc1_round_trip_fail_then_ok : Error<
  "original arguments parse failed, then succeeded in round-trip"
  "\n" "错误：原始实参解析失败，随后在往返中成功">;
def err_cc1_round_trip_ok_then_fail : Error<
  "generated arguments parse failed in round-trip"
  "\n" "错误：往返中生成的实参解析失败">;
def err_cc1_round_trip_mismatch : Error<
  "generated arguments do not match in round-trip"
  "\n" "错误：往返中生成的实参不匹配">;
def err_cc1_unbounded_vscale_min : Error<
  "minimum vscale must be an unsigned integer greater than 0"
  "\n" "错误：最小 vscale 必须是大于 0 的无符号整数">;

def err_conflicting_matrix_layout_flags: Error<
  "-fmatrix-memory-layout=%0 conflicts with -mllvm -matrix-default-layout=%1"
  "\n" "错误：-fmatrix-memory-layout=%0 与 -mllvm -matrix-default-layout=%1 冲突">;

def err_drv_using_omit_rtti_component_without_no_rtti : Error<
  "-fexperimental-omit-vtable-rtti call only be used with -fno-rtti"
  "\n" "错误：-fexperimental-omit-vtable-rtti 只能与 -fno-rtti 一起使用">;

def err_drv_ssp_missing_offset_argument : Error<
  "'%0' is used without '-mstack-protector-guard-offset', and there is no default"
  "\n" "错误：'%0' 在没有 '-mstack-protector-guard-offset' 的情况下使用，且没有默认值">;

def err_drv_only_one_offload_target_supported : Error<
  "only one offload target is supported"
  "\n" "错误：只支持一个卸载目标">;
def err_drv_invalid_or_unsupported_offload_target : Error<
  "invalid or unsupported offload target: '%0'"
  "\n" "错误：无效或不支持的卸载目标：'%0'">;
def err_drv_cuda_offload_only_emit_bc : Error<
  "CUDA offload target is supported only along with --emit-llvm"
  "\n" "错误：CUDA 卸载目标仅支持与 --emit-llvm 一起使用">;

def warn_drv_jmc_requires_debuginfo : Warning<
  "%0 requires debug info. Use %1 or debug options that enable debugger's "
  "stepping function; option ignored"
  "\n" "警告：%0 需要调试信息。请使用 %1 或启用调试器单步功能的调试选项；"
  "选项被忽略">,
  InGroup<OptionIgnored>;

def warn_drv_fjmc_for_elf_only : Warning<
  "-fjmc works only for ELF; option ignored"
  "\n" "警告：-fjmc 仅适用于 ELF；选项被忽略">,
  InGroup<OptionIgnored>;

def warn_target_override_arm64ec : Warning<
  "/arm64EC has been overridden by specified target: %0; option ignored"
  "\n" "警告：/arm64EC 已被指定目标覆盖：%0；选项被忽略">,
  InGroup<OptionIgnored>;

def err_drv_target_variant_invalid : Error<
  "unsupported '%0' value '%1'; use 'ios-macabi' instead"
  "\n" "错误：不支持的 '%0' 值 '%1'；请改用 'ios-macabi'">;

def err_drv_invalid_directx_shader_module : Error<
  "invalid profile : %0"
  "\n" "错误：无效的配置文件：%0">;
def err_drv_dxc_invalid_matrix_layout : Error<
  "cannot specify /Zpr and /Zpc together"
  "\n" "错误：不能同时指定 /Zpr 和 /Zpc">;
def err_drv_dxc_missing_target_profile : Error<
  "target profile option (-T) is missing"
  "\n" "错误：缺少目标配置文件选项（-T）">;
def err_drv_dxc_Fre_requires_Fo_metal
    : Error<"-Fre option requires -Fo option when targeting Metal"
    "\n" "错误：面向 Metal 时，-Fre 选项需要 -Fo 选项">;
def err_drv_dxc_invalid_shader_hash
    : Error<"cannot specify both /Zss and /Zsb"
    "\n" "错误：不能同时指定 /Zss 和 /Zsb">;
def err_drv_hlsl_unsupported_target : Error<
  "HLSL code generation is unsupported for target '%0'"
  "\n" "错误：目标 '%0' 不支持 HLSL 代码生成">;
def err_drv_hlsl_bad_shader_required_in_target : Error<
  "%select{shader model|Vulkan environment|shader stage}0 is required as %select{OS|environment}1 in target '%2' for HLSL code generation"
  "\n" "错误：为进行 HLSL 代码生成，目标 '%2' 中需要"
  "%select{着色器模型|Vulkan 环境|着色器阶段}0作为%select{OS|环境}1">;
def err_drv_hlsl_16bit_types_unsupported: Error<
  "'%0' option requires target HLSL Version >= 2018%select{| and shader model >= 6.2}1, but HLSL Version is '%2'%select{| and shader model is '%3'}1"
  "\n" "错误：'%0' 选项要求目标 HLSL 版本 >= 2018%select{| 且着色器模型 >= 6.2}1，"
  "但 HLSL 版本为 '%2'%select{| 且着色器模型为 '%3'}1">;
def err_drv_hlsl_bad_shader_unsupported : Error<
  "%select{shader model|Vulkan environment|shader stage}0 '%1' in target '%2' is invalid for HLSL code generation"
  "\n" "错误：目标 '%2' 中的%select{着色器模型|Vulkan 环境|着色器阶段}0 '%1' "
  "对 HLSL 代码生成无效">;
def warn_drv_dxc_missing_dxv : Warning<
  "dxv not found; resulting DXIL will not be validated or signed for use in "
  "release environment"
  "\n" "警告：找不到 dxv；生成的 DXIL 将不会经过验证或签名以用于发布环境">, InGroup<DXILValidation>;
def warn_drv_dxc_missing_spirv_val : Warning<
  "spirv-val not found; resulting SPIR-V will not be validated"
  "\n" "警告：找不到 spirv-val；生成的 SPIR-V 将不会经过验证">,
  InGroup<SPIRVValidation>;

def err_drv_invalid_range_dxil_validator_version : Error<
  "invalid validator version : %0; validator version must be less than or "
  "equal to current internal version"
  "\n" "错误：无效的验证器版本：%0；验证器版本必须小于或等于当前内部版本">;
def err_drv_invalid_format_dxil_validator_version : Error<
  "invalid validator version : %0; format of validator version is "
  "\"<major>.<minor>\" (ex:\"1.4\")"
  "\n" "错误：无效的验证器版本：%0；验证器版本的格式为 "
  "\"<major>.<minor>\"（例如：\"1.4\"）">;
def err_drv_invalid_empty_dxil_validator_version : Error<
  "invalid validator version : %0; if validator major version is 0, minor "
  "version must also be 0"
  "\n" "错误：无效的验证器版本：%0；如果验证器主版本为 0，次版本也必须为 0">;

def warn_drv_sarif_format_unstable : Warning<
  "diagnostic formatting in SARIF mode is currently unstable"
  "\n" "警告：SARIF 模式下的诊断格式当前不稳定">,
  InGroup<DiagGroup<"sarif-format-unstable">>;

def warn_drv_loongarch_conflicting_implied_val : Warning<
  "ignoring '%0' as it conflicts with that implied by '%1' (%2)"
  "\n" "警告：忽略 '%0'，因为它与 '%1' 隐含的值冲突 (%2)">,
  InGroup<OptionIgnored>;
def err_drv_loongarch_invalid_mfpu_EQ : Error<
  "invalid argument '%0' to -mfpu=; must be one of: 64, 32, none, 0 (alias for none)"
  "\n" "错误：-mfpu= 的实参 '%0' 无效；必须是其中之一：64、32、none、0（none 的别名）">;
def err_drv_loongarch_wrong_fpu_width : Error<
  "wrong fpu width; %select{LSX|LASX}0 depends on 64-bit FPU"
  "\n" "错误：FPU 宽度错误；%select{LSX|LASX}0依赖 64 位 FPU">;
def err_drv_loongarch_invalid_simd_option_combination : Error<
  "invalid option combination; LASX depends on LSX"
  "\n" "错误：无效的选项组合；LASX 依赖 LSX">;
def err_drv_loongarch_invalid_msimd_EQ : Error<
  "invalid argument '%0' to -msimd=; must be one of: none, lsx, lasx"
  "\n" "错误：-msimd= 的实参 '%0' 无效；必须是其中之一：none、lsx、lasx">;

def err_drv_expand_response_file : Error<
  "failed to expand response file: %0"
  "\n" "错误：无法展开响应文件：%0">;

def warn_drv_missing_multilib : Warning<
  "no multilib found matching flags: %0"
  "\n" "警告：没有找到与标志匹配的多库：%0">,
  InGroup<DiagGroup<"missing-multilib">>;
def note_drv_available_multilibs : Note<
  "available multilibs are:%0"
  "\n" "提示：可用的多库为：%0">;
def err_drv_multilib_custom_error : Error<
  "multilib configuration error: %0"
  "\n" "错误：多库配置错误：%0">;
def warn_drv_multilib_not_available_for_target: Warning<
  "no multilib structure encoded for Arm, Aarch64 and PPC targets"
  "\n" "警告：没有为 Arm、Aarch64 和 PPC 目标编码多库结构">,
  InGroup<DiagGroup<"multilib-not-found">>;

def err_drv_experimental_crel : Error<
  "-Wa,--allow-experimental-crel must be specified to use -Wa,--crel. "
  "CREL is experimental and uses a non-standard section type code"
  "\n" "错误：必须指定 -Wa,--allow-experimental-crel 才能使用 -Wa,--crel。"
  "CREL 是实验性的，使用非标准的段类型代码">;

def err_drv_experimental_sframe : Error<
  "-Wa,--allow-experimental-sframe must be specified to use -Wa,--gsframe. "
  "SFrames are experimental and may be removed at any time without warning"
  "\n" "错误：必须指定 -Wa,--allow-experimental-sframe 才能使用 -Wa,--gsframe。"
  "SFrames 是实验性的，可能随时被移除而不另行通知">;

def warn_android_unversioned_fallback : Warning<
  "using unversioned Android target directory %0 for target %1; unversioned "
  "directories will not be used in Clang 19 -- provide a versioned directory "
  "for the target version or lower instead"
  "\n" "警告：为目标 %1 使用未版本化的 Android 目标目录 %0；未版本化的目录"
  "将不会在 Clang 19 中使用——请改为为目标版本或更低版本提供版本化目录">,
  InGroup<DiagGroup<"android-unversioned-fallback">>;

def err_drv_triple_version_invalid : Error<
  "version '%0' in target triple '%1' is invalid"
  "\n" "错误：目标三元组 '%1' 中的版本 '%0' 无效">;

def warn_missing_include_dirs : Warning<
  "no such include directory: '%0'"
  "\n" "警告：没有这样的包含目录：'%0'">, InGroup<MissingIncludeDirs>, DefaultIgnore;

def err_drv_malformed_warning_suppression_mapping : Error<
  "failed to process suppression mapping file '%0': %1"
  "\n" "错误：无法处理抑制映射文件 '%0'：%1">;

def warn_drv_openacc_without_cir
    : Warning<"OpenACC directives will result in no runtime behavior; use "
              "-fclangir to enable runtime effect"
              "\n" "警告：OpenACC 指令将不会产生运行时行为；请使用 "
              "-fclangir 以启用运行时效果">,
      InGroup<SourceUsesOpenACC>;

def warn_drv_gcc_install_dir_libstdcxx : Warning<
    "future releases of the clang compiler will prefer GCC installations "
    "containing libstdc++ include directories; '%0' would be chosen over '%1'"
    "\n" "警告：clang 编译器的未来版本将优先选择包含 libstdc++ 包含目录的 "
    "GCC 安装；将选择 '%0' 而不是 '%1'">,
    InGroup<DiagGroup<"gcc-install-dir-libstdcxx">>;

def err_drv_reflection_requires_cxx26 : Error<
  "option '%0' is only supported when compiling in C++26 mode"
  "\n" "错误：选项 '%0' 仅在 C++26 模式下编译时受支持">;
}
