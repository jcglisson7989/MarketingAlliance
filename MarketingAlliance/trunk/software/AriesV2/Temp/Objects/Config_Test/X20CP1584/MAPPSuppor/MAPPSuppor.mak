UnmarkedObjectFolder := C:/Users/admin/Desktop/MarketingAlliance_040417/software/AriesV2/Logical/Libraries/MAPPSuppor
MarkedObjectFolder := C:/Users/admin/Desktop/MarketingAlliance_040417/software/AriesV2/Logical/Libraries/MAPPSuppor

$(AS_CPU_PATH)/MAPPSuppor.br: \
	$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/ANSIC.lby \
	FORCE \
	$(AS_CPU_PATH)/MAPPSuppor/MAPPSuppor.ox
	@"$(AS_BIN_PATH)/BR.AS.TaskBuilder.exe" "$(AS_CPU_PATH)/MAPPSuppor/MAPPSuppor.ox" -o "$(AS_CPU_PATH)/MAPPSuppor.br" -v V1.00.0 -f "$(AS_CPU_PATH)/NT.ofs" -offsetLT "$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/LT.ofs" -T SG4  -M IA32  -B B4.26 -extConstants  -extOptions -D $(AS_CONFIGURATION) -d "standard: V* - V*,sys_lib: V* - V*,wbrLogSvc: V* - V*,ArTextSys: V* - V*" -r Library -R "library (written/managed by J. Glisson) containing functions for ACPu err acknowledgement, HMI param table construction, HMI param table activation to the common layer"  -s "Libraries.MAPPSuppor" -L "Acp10_MC: V3.16.2, Acp10man: V3.16.2, Acp10par: V3.16.2, ArTextSys: V0.16.0, AsANSL: V*, AsARCfg: V*, AsArLog: V*, AsArProf: V*, AsArSdm: V*, AsBrMath: V*, AsBrStr: V*, AsICMP: V*, AsIecCon: V*, AsIOTime: V*, AsMem: V*, AsTCP: V*, astime: V*, AsUDP: V*, AsUSB: V*, AsXml: V*, bglibasWBR: V*, brsystem: V*, DataObj: V*, FileIO: V*, jgLibC: V*, MAPPSuppor: V*, MpAlarm: V1.60.1, MpAxis: V1.60.1, MpCom: V1.60.1, MpFile: V1.60.1, MpRecipe: V1.60.1, MpWebXs: V1.60.1, MTBasics: V2.21.0, MTData: V2.10.0, MTFilter: V2.10.0, MTProfile: V2.10.0, MTTypes: V1.03.0, NcGlobal: V3.16.2, operator: V*, runtime: V*, standard: V*, sys_lib: V*, wbrFltUtil: V*, wbrListSvc: V*, wbrLogSvc: V*, wbrMemSvc: V*, wbrPingSvc: V*, wbrsprintf: V*" -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.taskbuilder.exe"


$(AS_CPU_PATH)/MAPPSuppor.xref: \
	$(AS_CPU_PATH)/MAPPSuppor/MAPPSuppor.xrefox
	@"$(AS_BIN_PATH)/BR.AS.CrossRefExtender.exe" "$(AS_CPU_PATH)/MAPPSuppor/MAPPSuppor.xrefox" -o "$(AS_CPU_PATH)/MAPPSuppor.xref" -r Library -T SG4  -M IA32  -D $(AS_CONFIGURATION) -D _SG4 -D _DEFAULT_INCLUDES -include "$(AS_CPU_PATH)/Libraries.h" -I "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -l "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/MAPPSuppor.typ" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/HMIparamList.typ" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/MAPPSuppor.var" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/MAPPSuppor.fun" -s "Libraries.MAPPSuppor" -t "$(AS_TEMP_PATH)"

$(AS_CPU_PATH)/MAPPSuppor/MAPPSuppor.ox: \
	$(AS_CPU_PATH)/MAPPSuppor/a.out \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.Backend.exe" "$(AS_CPU_PATH)/MAPPSuppor/a.out" -o "$(AS_CPU_PATH)/MAPPSuppor/MAPPSuppor.ox" -T SG4 -r Library  -extOptions -D $(AS_CONFIGURATION)  -X "$(AS_CPU_PATH)/MAPPSuppor/MAPPSuppor.xrefox" -G V4.1.2  -secret "$(AS_PROJECT_PATH)_br.as.backend.exe"

$(AS_CPU_PATH)/MAPPSuppor/a.out: \
	$(AS_CPU_PATH)/MAPPSuppor/hmiParamList.c.o \
	$(AS_CPU_PATH)/MAPPSuppor/bgstring.c.o \
	$(AS_CPU_PATH)/MAPPSuppor/bgsprintf.c.o \
	$(AS_CPU_PATH)/MAPPSuppor/FBK_Init_Logbook.c.o \
	$(AS_CPU_PATH)/MAPPSuppor/hmiTableFBK_typ.c.o \
	$(AS_CPU_PATH)/MAPPSuppor/ActivateHMITable.c.o \
	$(AS_TEMP_PATH)/Archives/$(AS_CONFIGURATION)/$(AS_PLC)/libwbrsprintf_s.a \
	FORCE
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -link  -O "$(AS_CPU_PATH)//MAPPSuppor/MAPPSuppor.out.opt" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/MAPPSuppor/hmiParamList.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/hmiParamList.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/hmiParamList.c" -o "$(AS_CPU_PATH)/MAPPSuppor/hmiParamList.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.MAPPSuppor" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _MAPPSUPPOR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/MAPPSuppor/bgstring.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/bgstring.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/bgstring.c" -o "$(AS_CPU_PATH)/MAPPSuppor/bgstring.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.MAPPSuppor" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _MAPPSUPPOR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/MAPPSuppor/bgsprintf.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/bgsprintf.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/bgsprintf.c" -o "$(AS_CPU_PATH)/MAPPSuppor/bgsprintf.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.MAPPSuppor" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _MAPPSUPPOR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/MAPPSuppor/FBK_Init_Logbook.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/FBK_Init_Logbook.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/FBK_Init_Logbook.c" -o "$(AS_CPU_PATH)/MAPPSuppor/FBK_Init_Logbook.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.MAPPSuppor" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _MAPPSUPPOR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/MAPPSuppor/hmiTableFBK_typ.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/hmiTableFBK_typ.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/hmiTableFBK_typ.c" -o "$(AS_CPU_PATH)/MAPPSuppor/hmiTableFBK_typ.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.MAPPSuppor" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _MAPPSUPPOR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/MAPPSuppor/ActivateHMITable.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/ActivateHMITable.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor/ActivateHMITable.c" -o "$(AS_CPU_PATH)/MAPPSuppor/ActivateHMITable.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.MAPPSuppor" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes/Libraries/MAPPSuppor" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _MAPPSUPPOR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

-include $(AS_CPU_PATH)/Force.mak 



FORCE: