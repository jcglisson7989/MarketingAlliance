UnmarkedObjectFolder := C:/Users/jcgli/Desktop/software_Aries_041217/AriesV2/Logical/HMI/hmilogic
MarkedObjectFolder := C:/Users/jcgli/Desktop/software_Aries_041217/AriesV2/Logical/HMI/hmilogic

$(AS_CPU_PATH)/hmilogic.br: \
	$(AS_PROJECT_CPU_PATH)/Cpu.per \
	FORCE \
	$(AS_CPU_PATH)/hmilogic/hmilogic.ox
	@"$(AS_BIN_PATH)/BR.AS.TaskBuilder.exe" "$(AS_CPU_PATH)/hmilogic/hmilogic.ox" -o "$(AS_CPU_PATH)/hmilogic.br" -v V1.00.0 -f "$(AS_CPU_PATH)/NT.ofs" -offsetLT "$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/LT.ofs" -T SG4  -M IA32  -B B4.26 -extConstants  -extOptions -D $(AS_CONFIGURATION) -r Cyclic8 -p 4 -s "HMI.hmilogic" -L "Acp10_MC: V3.16.1, Acp10man: V3.16.1, Acp10par: V3.16.1, Acp10sim: V3.16.1, ArTextSys: V*, AsANSL: V*, AsARCfg: V*, AsArLog: V*, AsArProf: V*, AsArSdm: V*, AsBrMath: V*, AsBrStr: V*, AsICMP: V*, AsIecCon: V*, AsIOTime: V*, AsMem: V*, AsTCP: V*, astime: V*, AsUDP: V*, AsUSB: V*, AsXml: V*, bglibasWBR: V*, brsystem: V*, DataObj: V*, FileIO: V*, jgLibC: V*, MAPPSuppor: V*, MpAlarm: V1.60.1, MpAxis: V1.60.1, MpCom: V1.60.1, MpFile: V1.60.1, MpRecipe: V1.60.1, MpWebXs: V1.60.1, MTData: V2.10.0, MTTypes: V1.03.0, NcGlobal: V3.16.1, operator: V*, runtime: V*, standard: V*, sys_lib: V*, wbrFltUtil: V*, wbrListSvc: V*, wbrLogSvc: V*, wbrMemSvc: V*, wbrPingSvc: V*, wbrsprintf: V*" -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.taskbuilder.exe"


$(AS_CPU_PATH)/hmilogic.xref: \
	$(AS_CPU_PATH)/hmilogic/hmilogic.xrefox
	@"$(AS_BIN_PATH)/BR.AS.CrossRefExtender.exe" "$(AS_CPU_PATH)/hmilogic/hmilogic.xrefox" -o "$(AS_CPU_PATH)/hmilogic.xref" -T SG4  -M IA32  -D $(AS_CONFIGURATION) -D _SG4 -D _DEFAULT_INCLUDES -include "$(AS_CPU_PATH)/Libraries.h" -I "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic" "$(AS_TEMP_PATH)/Includes/HMI/hmilogic"  "$(AS_TEMP_PATH)/Includes/HMI" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -l "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/HMIlocal.var" -s "HMI.hmilogic" -t "$(AS_TEMP_PATH)"

$(AS_CPU_PATH)/hmilogic/hmilogic.ox: \
	$(AS_CPU_PATH)/hmilogic/a.out \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.Backend.exe" "$(AS_CPU_PATH)/hmilogic/a.out" -o "$(AS_CPU_PATH)/hmilogic/hmilogic.ox" -T SG4 -r Cyclic8  -extOptions -D $(AS_CONFIGURATION)  -X "$(AS_CPU_PATH)/hmilogic/hmilogic.xrefox" -G V4.1.2  -secret "$(AS_PROJECT_PATH)_br.as.backend.exe"

$(AS_CPU_PATH)/hmilogic/a.out: \
	$(AS_CPU_PATH)/hmilogic/hmilogic.c.o \
	$(AS_CPU_PATH)/hmilogic/hmiParamList.c.o \
	$(AS_CPU_PATH)/hmilogic/hmiDialog.c.o \
	$(AS_CPU_PATH)/hmilogic/hmiAlert.c.o \
	$(AS_CPU_PATH)/hmilogic/loginCyclicLogic.c.o \
	$(AS_TEMP_PATH)/Archives/$(AS_CONFIGURATION)/$(AS_PLC)/libwbrsprintf_s.a \
	FORCE
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -link  -O "$(AS_CPU_PATH)//hmilogic/hmilogic.out.opt" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/hmilogic/hmilogic.c.o: \
	$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/hmilogic.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/hmilogic.c" -o "$(AS_CPU_PATH)/hmilogic/hmilogic.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "HMI.hmilogic" -t "$(AS_TEMP_PATH)" -I "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic" "$(AS_TEMP_PATH)/Includes/HMI/hmilogic"  "$(AS_TEMP_PATH)/Includes/HMI" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h"  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/hmilogic/hmiParamList.c.o: \
	$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/hmiParamList.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/hmiParamList.c" -o "$(AS_CPU_PATH)/hmilogic/hmiParamList.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "HMI.hmilogic" -t "$(AS_TEMP_PATH)" -I "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic" "$(AS_TEMP_PATH)/Includes/HMI/hmilogic"  "$(AS_TEMP_PATH)/Includes/HMI" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h"  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/hmilogic/hmiDialog.c.o: \
	$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/hmiDialog.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/hmiDialog.c" -o "$(AS_CPU_PATH)/hmilogic/hmiDialog.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "HMI.hmilogic" -t "$(AS_TEMP_PATH)" -I "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic" "$(AS_TEMP_PATH)/Includes/HMI/hmilogic"  "$(AS_TEMP_PATH)/Includes/HMI" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h"  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/hmilogic/hmiAlert.c.o: \
	$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/hmiAlert.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/hmiAlert.c" -o "$(AS_CPU_PATH)/hmilogic/hmiAlert.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "HMI.hmilogic" -t "$(AS_TEMP_PATH)" -I "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic" "$(AS_TEMP_PATH)/Includes/HMI/hmilogic"  "$(AS_TEMP_PATH)/Includes/HMI" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h"  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/hmilogic/loginCyclicLogic.c.o: \
	$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/loginCyclicLogic.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic/loginCyclicLogic.c" -o "$(AS_CPU_PATH)/hmilogic/loginCyclicLogic.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "HMI.hmilogic" -t "$(AS_TEMP_PATH)" -I "$(AS_PROJECT_PATH)/Logical/HMI/hmilogic" "$(AS_TEMP_PATH)/Includes/HMI/hmilogic"  "$(AS_TEMP_PATH)/Includes/HMI" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h"  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

-include $(AS_CPU_PATH)/Force.mak 



FORCE: