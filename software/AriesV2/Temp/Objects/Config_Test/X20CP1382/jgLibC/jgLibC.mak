UnmarkedObjectFolder := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Logical/Libraries/jgLibC
MarkedObjectFolder := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Logical/Libraries/jgLibC

$(AS_CPU_PATH)/jgLibC.br: \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/ANSIC.lby \
	$(AS_CPU_PATH)/jgLibC/jgLibC.ox
	@"$(AS_BIN_PATH)/BR.AS.TaskBuilder.exe" "$(AS_CPU_PATH)/jgLibC/jgLibC.ox" -o "$(AS_CPU_PATH)/jgLibC.br" -v V1.00.0 -f "$(AS_CPU_PATH)/NT.ofs" -offsetLT "$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/LT.ofs" -T SG4  -M IA32  -B B4.26 -extConstants  -extOptions -D $(AS_CONFIGURATION) -d "standard: V* - V*" -r Library -s "Libraries.jgLibC" -L "Acp10_MC: V3.16.1, Acp10man: V3.16.1, Acp10par: V3.16.1, ArTextSys: V0.16.0, AsANSL: V*, AsARCfg: V*, AsArLog: V*, AsArProf: V*, AsArSdm: V*, AsBrMath: V*, AsBrStr: V*, AsICMP: V*, AsIecCon: V*, AsIOTime: V*, AsMem: V*, AsTCP: V*, astime: V*, AsUDP: V*, AsUSB: V*, AsXml: V*, bglibasWBR: V*, brsystem: V*, DataObj: V*, FileIO: V*, jgLibC: V*, MAPPSuppor: V*, MpAlarm: V1.60.1, MpAxis: V1.60.1, MpCom: V1.60.1, MpFile: V1.60.1, MpRecipe: V1.60.1, MpWebXs: V1.60.1, MTBasics: V2.21.0, MTData: V2.10.0, MTFilter: V2.10.0, MTProfile: V2.10.0, MTTypes: V1.03.0, NcGlobal: V3.16.1, operator: V*, runtime: V*, standard: V*, sys_lib: V*, wbrFltUtil: V*, wbrListSvc: V*, wbrLogSvc: V*, wbrMemSvc: V*, wbrPingSvc: V*, wbrsprintf: V*" -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.taskbuilder.exe"


$(AS_CPU_PATH)/jgLibC.xref: \
	$(AS_CPU_PATH)/jgLibC/jgLibC.xrefox
	@"$(AS_BIN_PATH)/BR.AS.CrossRefExtender.exe" "$(AS_CPU_PATH)/jgLibC/jgLibC.xrefox" -o "$(AS_CPU_PATH)/jgLibC.xref" -r Library -T SG4  -M IA32  -D $(AS_CONFIGURATION) -D _SG4 -D _DEFAULT_INCLUDES -include "$(AS_CPU_PATH)/Libraries.h" -I "$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC" "$(AS_TEMP_PATH)/Includes/Libraries/jgLibC" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -l "$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Types.typ" "$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Constants.var" "$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/jgLibC.fun" -s "Libraries.jgLibC" -t "$(AS_TEMP_PATH)"

$(AS_CPU_PATH)/jgLibC/jgLibC.ox: \
	$(AS_CPU_PATH)/jgLibC/a.out
	@"$(AS_BIN_PATH)/BR.AS.Backend.exe" "$(AS_CPU_PATH)/jgLibC/a.out" -o "$(AS_CPU_PATH)/jgLibC/jgLibC.ox" -T SG4 -r Library  -extOptions -D $(AS_CONFIGURATION)  -X "$(AS_CPU_PATH)/jgLibC/jgLibC.xrefox" -G V4.1.2  -secret "$(AS_PROJECT_PATH)_br.as.backend.exe"

$(AS_CPU_PATH)/jgLibC/a.out: \
	$(AS_CPU_PATH)/jgLibC/Debounce_Signal.c.o \
	$(AS_CPU_PATH)/jgLibC/Indexer_Helper_functions.c.o \
	$(AS_TEMP_PATH)/Archives/$(AS_CONFIGURATION)/$(AS_PLC)/libwbrsprintf_s.a
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -link  -O "$(AS_CPU_PATH)//jgLibC/jgLibC.out.opt" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/jgLibC/Debounce_Signal.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Debounce_Signal.c \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/jgLibC.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Types.typ \
	$(AS_PROJECT_PATH)/Logical/Libraries/standard/standard.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bglibasWBR.fun \
	$(AS_TEMP_PATH)/Includes/jgLibC.h \
	$(AS_TEMP_PATH)/Includes/standard.h \
	$(AS_TEMP_PATH)/Includes/bglibasWBR.h \
	$(AS_TEMP_PATH)/Includes/wbrLogSvc.h \
	$(AS_TEMP_PATH)/Includes/AsArLog.h \
	$(AS_TEMP_PATH)/Includes/runtime.h \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf/wbrsprintf.h \
	$(AS_TEMP_PATH)/Includes/wbrListSvc.h \
	$(AS_TEMP_PATH)/Includes/wbrMemSvc.h \
	$(AS_TEMP_PATH)/Includes/AsMem.h
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Debounce_Signal.c" -o "$(AS_CPU_PATH)/jgLibC/Debounce_Signal.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.jgLibC" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC" "$(AS_TEMP_PATH)/Includes/Libraries/jgLibC" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _JGLIBC_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/jgLibC/Indexer_Helper_functions.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Indexer_Helper_functions.c \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/jgLibC.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Types.typ \
	$(AS_PROJECT_PATH)/Logical/Libraries/standard/standard.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bglibasWBR.fun \
	$(AS_TEMP_PATH)/Includes/jgLibC.h \
	$(AS_TEMP_PATH)/Includes/standard.h
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Indexer_Helper_functions.c" -o "$(AS_CPU_PATH)/jgLibC/Indexer_Helper_functions.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.jgLibC" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC" "$(AS_TEMP_PATH)/Includes/Libraries/jgLibC" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _JGLIBC_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

-include $(AS_CPU_PATH)/Force.mak 

