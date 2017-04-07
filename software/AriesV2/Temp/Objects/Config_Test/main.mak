SHELL = cmd.exe
CYGWIN=nontsec
export PATH := C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\TortoiseSVN\bin;C:\Program Files\Git\cmd;C:\Program Files (x86)\Skype\Phone\;C:\Program Files\TortoiseGit\bin;C:\Users\jcgli\AppData\Local\Microsoft\WindowsApps;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\jcgli\AppData\Local\Microsoft\WindowsApps;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode
export AS_BUILD_MODE := BuildAndTransfer
export AS_VERSION := 4.2.7.54 SP
export AS_COMPANY_NAME :=  
export AS_USER_NAME := jcgli
export AS_PATH := C:/BrAutomation/AS42
export AS_BIN_PATH := C:/BrAutomation/AS42/Bin-en
export AS_PROJECT_PATH := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2
export AS_PROJECT_NAME := AriesV2
export AS_SYSTEM_PATH := C:/BrAutomation/AS/System
export AS_VC_PATH := C:/BrAutomation/AS42/AS/VC
export AS_TEMP_PATH := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Temp
export AS_CONFIGURATION := Config_Test
export AS_BINARIES_PATH := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Binaries
export AS_GNU_INST_PATH := C:/BrAutomation/AS42/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := $(AS_GNU_INST_PATH)/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/BrAutomation/AS42/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := $(AS_GNU_INST_PATH_SUB_MAKE)/bin
export AS_INSTALL_PATH := C:/BrAutomation/AS42
export WIN32_AS_PATH := "C:\BrAutomation\AS42"
export WIN32_AS_BIN_PATH := "C:\BrAutomation\AS42\Bin-en"
export WIN32_AS_PROJECT_PATH := "C:\Users\jcgli\Desktop\software_Aries_040717\AriesV2"
export WIN32_AS_SYSTEM_PATH := "C:\BrAutomation\AS\System"
export WIN32_AS_VC_PATH := "C:\BrAutomation\AS42\AS\VC"
export WIN32_AS_TEMP_PATH := "C:\Users\jcgli\Desktop\software_Aries_040717\AriesV2\Temp"
export WIN32_AS_BINARIES_PATH := "C:\Users\jcgli\Desktop\software_Aries_040717\AriesV2\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\BrAutomation\AS42\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "$(WIN32_AS_GNU_INST_PATH)\\bin" 
export WIN32_AS_INSTALL_PATH := "C:\BrAutomation\AS42"

.suffixes:

ProjectMakeFile:

	@cmd /c "SubWCRev.exe $(AS_PROJECT_PATH) $(AS_PROJECT_PATH)\Logical\Libraries\wbrServices\InitSP\runFirst\template_info.txt $(AS_PROJECT_PATH)\Logical\Libraries\wbrServices\InitSP\runFirst\svninfo.c"

	@"$(AS_BIN_PATH)/BR.AS.AnalyseProject.exe" "$(AS_PROJECT_PATH)/AriesV2.apj" -t "$(AS_TEMP_PATH)" -c "$(AS_CONFIGURATION)" -o "$(AS_BINARIES_PATH)"   -sfas -buildMode "BuildAndTransfer"  

	@$(AS_GNU_BIN_PATH)/mingw32-make.exe -r -f 'C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Temp/Objects/$(AS_CONFIGURATION)/X20CP1382/#cpu.mak' -k 

