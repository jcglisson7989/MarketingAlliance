UnmarkedObjectFolder := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/Libraries/wbrServices/bglibasWBR
MarkedObjectFolder := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/Libraries/wbrServices/bglibasWBR

$(AS_CPU_PATH)/bglibasWBR.br: \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/ANSIC.lby \
	FORCE \
	$(AS_CPU_PATH)/bglibasWBR/bglibasWBR.ox
	@"$(AS_BIN_PATH)/BR.AS.TaskBuilder.exe" "$(AS_CPU_PATH)/bglibasWBR/bglibasWBR.ox" -o "$(AS_CPU_PATH)/bglibasWBR.br" -v V0.10.8 -f "$(AS_CPU_PATH)/NT.ofs" -offsetLT "$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/LT.ofs" -T SG4  -M IA32  -B B4.26 -extConstants  -extOptions -D $(AS_CONFIGURATION) -d "standard: V* - V*,wbrLogSvc: V* - V*" -r Library -R "Modified by WBR beginning 2015-01-13"  -s "Libraries.wbrServices.bglibasWBR" -L "Acp10_MC: V3.16.1, Acp10man: V3.16.1, Acp10par: V3.16.1, Acp10sim: V3.16.1, ArTextSys: V*, AsANSL: V*, AsARCfg: V*, AsArLog: V*, AsArProf: V*, AsArSdm: V*, AsBrMath: V*, AsBrStr: V*, AsICMP: V*, AsIecCon: V*, AsIOTime: V*, AsMem: V*, AsTCP: V*, astime: V*, AsUDP: V*, AsUSB: V*, AsXml: V*, bglibasWBR: V*, brsystem: V*, DataObj: V*, FileIO: V*, jgLibC: V*, MAPPSuppor: V*, MpAlarm: V1.60.1, MpAxis: V1.60.1, MpCom: V1.60.1, MpFile: V1.60.1, MpRecipe: V1.60.1, MpWebXs: V1.60.1, MTData: V2.10.0, MTTypes: V1.03.0, NcGlobal: V3.16.1, operator: V*, runtime: V*, standard: V*, sys_lib: V*, wbrFltUtil: V*, wbrListSvc: V*, wbrLogSvc: V*, wbrMemSvc: V*, wbrPingSvc: V*, wbrsprintf: V*" -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.taskbuilder.exe"


$(AS_CPU_PATH)/bglibasWBR.xref: \
	$(AS_CPU_PATH)/bglibasWBR/bglibasWBR.xrefox
	@"$(AS_BIN_PATH)/BR.AS.CrossRefExtender.exe" "$(AS_CPU_PATH)/bglibasWBR/bglibasWBR.xrefox" -o "$(AS_CPU_PATH)/bglibasWBR.xref" -r Library -T SG4  -M IA32  -D $(AS_CONFIGURATION) -D _SG4 -D _DEFAULT_INCLUDES -include "$(AS_CPU_PATH)/Libraries.h" -I "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR" "$(AS_TEMP_PATH)/Includes/Libraries/wbrServices/bglibasWBR" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -l "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bglibasWBR.typ" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bglibasWBR.var" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bglibasWBR.fun" -s "Libraries.wbrServices.bglibasWBR" -t "$(AS_TEMP_PATH)"

$(AS_CPU_PATH)/bglibasWBR/bglibasWBR.ox: \
	$(AS_CPU_PATH)/bglibasWBR/a.out \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.Backend.exe" "$(AS_CPU_PATH)/bglibasWBR/a.out" -o "$(AS_CPU_PATH)/bglibasWBR/bglibasWBR.ox" -T SG4 -r Library  -extOptions -D $(AS_CONFIGURATION)  -X "$(AS_CPU_PATH)/bglibasWBR/bglibasWBR.xrefox" -G V4.1.2  -secret "$(AS_PROJECT_PATH)_br.as.backend.exe"

$(AS_CPU_PATH)/bglibasWBR/a.out: \
	$(AS_CPU_PATH)/bglibasWBR/bgssm.c.o \
	$(AS_CPU_PATH)/bglibasWBR/bgfifo.c.o \
	$(AS_CPU_PATH)/bglibasWBR/bgTimer1ms.c.o \
	$(AS_TEMP_PATH)/Archives/$(AS_CONFIGURATION)/$(AS_PLC)/libwbrsprintf_s.a \
	FORCE
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -link  -O "$(AS_CPU_PATH)//bglibasWBR/bglibasWBR.out.opt" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/bglibasWBR/bgssm.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bgssm.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bgssm.c" -o "$(AS_CPU_PATH)/bglibasWBR/bgssm.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.wbrServices.bglibasWBR" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR" "$(AS_TEMP_PATH)/Includes/Libraries/wbrServices/bglibasWBR" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _BGLIBASWBR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/bglibasWBR/bgfifo.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bgfifo.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bgfifo.c" -o "$(AS_CPU_PATH)/bglibasWBR/bgfifo.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.wbrServices.bglibasWBR" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR" "$(AS_TEMP_PATH)/Includes/Libraries/wbrServices/bglibasWBR" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _BGLIBASWBR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/bglibasWBR/bgTimer1ms.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bgTimer1ms.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bgTimer1ms.c" -o "$(AS_CPU_PATH)/bglibasWBR/bgTimer1ms.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.wbrServices.bglibasWBR" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR" "$(AS_TEMP_PATH)/Includes/Libraries/wbrServices/bglibasWBR" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _BGLIBASWBR_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

-include $(AS_CPU_PATH)/Force.mak 



FORCE: