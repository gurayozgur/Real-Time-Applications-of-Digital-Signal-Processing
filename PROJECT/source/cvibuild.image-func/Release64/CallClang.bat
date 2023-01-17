@set INCLUDE=
@set LIB=
@set FileNum=%1
@shift
@set CCAction=%1
@shift
@set SrcFileName=%1
@shift
@set ObjFileName=%1
@shift
@set OutFileName=%1
@shift
@set REST=%1 %2 %3 %4 %5 %6 %7 %8 %9
@rem c:\Users\User\Desktop\ee433 eben
@echo %CCAction%ing %FileNum% %SrcFileName%
@"c:\program files (x86)\national instruments\cvi2020\bin\clang\3.3\clang.exe"  -cc1  -nostdsysteminc  -fno-builtin-include-notes -cvi-file-encoding=ansi -fcvi-decorate-path-names -target-cpu x86-64  %REST% -std=c99   -O2   @"Clang_no_dep_options.txt"  @"Clang_options.txt" -D_CVI_="2000"  -D_NI_x64_="1"  -D_NI_mswin_="1"  -D_NI_mswin64_="1"  -D_CVI_DLL_="1"  -D_LINK_CVIRTE_="1"  -D_CVI_FDS_="1"  -D_CVI_USE_FUNCS_FOR_VARS_="1"  -D__DEFALIGN="8"  -D_NI_VC_="220"  -D_WIN32="1"  -D_WIN64="1"  -DWIN32="1"  -DWIN64="1"  -D__WIN32__="1"  -D__WIN64__="1"  -D_WINDOWS="1"  -D__NT__="1"  -D_M_X64="1"  -D_M_AMD64="1"  -D__FLAT__="1"  -D_PUSHPOP_SUPPORTED="1"  -D_CVI_C99_EXTENSIONS_="1"  -DNDEBUG="1"  -D_CVI_PROFILE_LEVEL_="0"  -D_TARGET_FILE_VERSION_="\"1.0.0.0\""  -D_TARGET_PRODUCT_VERSION_="\"1.0.0.0\""  -D_CVI_CONFIGURATION_NAME_="\"Release64\""  -D_CVI_RTE_SHARED_="1"  -DWIN32_LEAN_AND_MEAN  -o %ObjFileName%  %SrcFileName%  > %OutFileName% 2>&1
@if %errorlevel% neq 0 goto err
@echo %CCAction% succeeded for %FileNum% %SrcFileName%
@exit 0
:err
@echo %CCAction% failed for %FileNum% %SrcFileName%
@exit 1
