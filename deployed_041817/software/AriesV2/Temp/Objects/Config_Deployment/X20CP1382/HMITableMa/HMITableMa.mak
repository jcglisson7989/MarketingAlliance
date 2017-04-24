UnmarkedObjectFolder := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/HMI/HMITableManager
MarkedObjectFolder := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/HMI/HMITableManager

$(AS_CPU_PATH)/HMITableMa.br: \
	$(AS_PROJECT_CPU_PATH)/Cpu.per \
	FORCE \
	$(AS_CPU_PATH)/HMITableMa/HMITableMa.ox
	@"$(AS_BIN_PATH)/BR.AS.TaskBuilder.exe" "$(AS_CPU_PATH)/HMITableMa/HMITableMa.ox" -o "$(AS_CPU_PATH)/HMITableMa.br" -v V1.00.0 -f "$(AS_CPU_PATH)/NT.ofs" -offsetLT "$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/LT.ofs" -T SG4  -M IA32  -B B4.26 -extConstants  -extOptions -D $(AS_CONFIGURATION) -d "runtime: V* - V*,asieccon: V* - V*" -r Cyclic8 -p 6 -s "HMI.HMITableManager" -L "Acp10_MC: V3.16.1, Acp10man: V3.16.1, Acp10par: V3.16.1, Acp10sim: V3.16.1, ArTextSys: V*, AsANSL: V*, AsARCfg: V*, AsArLog: V*, AsArProf: V*, AsArSdm: V*, AsBrMath: V*, AsBrStr: V*, AsICMP: V*, AsIecCon: V*, AsIOTime: V*, AsMem: V*, AsTCP: V*, astime: V*, AsUDP: V*, AsUSB: V*, AsXml: V*, bglibasWBR: V*, brsystem: V*, DataObj: V*, FileIO: V*, jgLibC: V*, MAPPSuppor: V*, MpAlarm: V1.60.1, MpAxis: V1.60.1, MpCom: V1.60.1, MpFile: V1.60.1, MpRecipe: V1.60.1, MpWebXs: V1.60.1, MTData: V2.10.0, MTTypes: V1.03.0, NcGlobal: V3.16.1, operator: V*, runtime: V*, standard: V*, sys_lib: V*, wbrFltUtil: V*, wbrListSvc: V*, wbrLogSvc: V*, wbrMemSvc: V*, wbrPingSvc: V*, wbrsprintf: V*" -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.taskbuilder.exe"

$(AS_CPU_PATH)/HMITableMa/HMITableMa.ox: \
	$(AS_CPU_PATH)/HMITableMa/a.out \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.Backend.exe" "$(AS_CPU_PATH)/HMITableMa/a.out" -o "$(AS_CPU_PATH)/HMITableMa/HMITableMa.ox" -T SG4 -r Cyclic8  -extOptions -D $(AS_CONFIGURATION)  -G V4.1.2  -secret "$(AS_PROJECT_PATH)_br.as.backend.exe"

$(AS_CPU_PATH)/HMITableMa/a.out: \
	$(AS_CPU_PATH)/HMITableMa/Main.st.o \
	FORCE
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -link  -O "$(AS_CPU_PATH)//HMITableMa/HMITableMa.out.opt" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/HMITableMa.xref: \
	$(AS_CPU_PATH)/HMITableMa/Main.st.xrefo
	@"$(AS_BIN_PATH)/BR.AS.IECCrossRefLinker.exe"  "$(AS_CPU_PATH)/HMITableMa/Main.st.xrefo" -o "$(AS_CPU_PATH)/HMITableMa.xref"

$(AS_CPU_PATH)/HMITableMa/Main.st.o: \
	$(AS_PROJECT_PATH)/Logical/HMI/HMITableManager/Main.st \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.IecCompiler.exe" "$(AS_PROJECT_PATH)/Logical/HMI/HMITableManager/Main.st" -o "$(AS_CPU_PATH)/HMITableMa/Main.st.o"  -O "$(AS_CPU_PATH)//HMITableMa/Main.st.o.opt" -secret "$(AS_PROJECT_PATH)_br.as.ieccompiler.exe"

-include $(AS_CPU_PATH)/Force.mak 



FORCE: