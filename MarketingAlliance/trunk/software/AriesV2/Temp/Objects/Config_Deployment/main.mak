SHELL = cmd.exe
CYGWIN=nontsec
export PATH := C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\TortoiseSVN\bin;C:\Program Files (x86)\WinMerge;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode
export AS_BUILD_MODE := Rebuild
export AS_VERSION := 4.2.8.54 SP
export AS_COMPANY_NAME :=  
export AS_USER_NAME := Admin
export AS_PATH := C:/BrAutomation/AS42
export AS_BIN_PATH := C:/BrAutomation/AS42/Bin-en
export AS_PROJECT_PATH := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2
export AS_PROJECT_NAME := AriesV2
export AS_SYSTEM_PATH := C:/BrAutomation/AS/System
export AS_VC_PATH := C:/BrAutomation/AS42/AS/VC
export AS_TEMP_PATH := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Temp
export AS_CONFIGURATION := Config_Deployment
export AS_BINARIES_PATH := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Binaries
export AS_GNU_INST_PATH := C:/BrAutomation/AS42/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := $(AS_GNU_INST_PATH)/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/BrAutomation/AS42/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := $(AS_GNU_INST_PATH_SUB_MAKE)/bin
export AS_INSTALL_PATH := C:/BrAutomation/AS42
export WIN32_AS_PATH := "C:\BrAutomation\AS42"
export WIN32_AS_BIN_PATH := "C:\BrAutomation\AS42\Bin-en"
export WIN32_AS_PROJECT_PATH := "C:\Users\Admin\Desktop\MarketingAlliance_Aries_Merge\software\AriesV2"
export WIN32_AS_SYSTEM_PATH := "C:\BrAutomation\AS\System"
export WIN32_AS_VC_PATH := "C:\BrAutomation\AS42\AS\VC"
export WIN32_AS_TEMP_PATH := "C:\Users\Admin\Desktop\MarketingAlliance_Aries_Merge\software\AriesV2\Temp"
export WIN32_AS_BINARIES_PATH := "C:\Users\Admin\Desktop\MarketingAlliance_Aries_Merge\software\AriesV2\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\BrAutomation\AS42\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "$(WIN32_AS_GNU_INST_PATH)\\bin" 
export WIN32_AS_INSTALL_PATH := "C:\BrAutomation\AS42"

.suffixes:

ProjectMakeFile:

	@cmd /c "SubWCRev.exe $(AS_PROJECT_PATH) $(AS_PROJECT_PATH)\Logical\Libraries\wbrServices\InitSP\runFirst\template_info.txt $(AS_PROJECT_PATH)\Logical\Libraries\wbrServices\InitSP\runFirst\svninfo.c"

	@"$(AS_BIN_PATH)/BR.AS.AnalyseProject.exe" "$(AS_PROJECT_PATH)/AriesV2.apj" -t "$(AS_TEMP_PATH)" -c "$(AS_CONFIGURATION)" -o "$(AS_BINARIES_PATH)"   -sfas -buildMode "Rebuild"  

	@$(AS_GNU_BIN_PATH)/mingw32-make.exe -r -f 'C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Temp/Objects/$(AS_CONFIGURATION)/X20CP1382/#cpu.mak' -k 

