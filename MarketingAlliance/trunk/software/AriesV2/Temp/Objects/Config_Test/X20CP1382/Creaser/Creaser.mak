UnmarkedObjectFolder := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Logical/Application/Creaser
MarkedObjectFolder := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Logical/Application/Creaser

$(AS_CPU_PATH)/Creaser.br: \
	$(AS_PROJECT_CPU_PATH)/Cpu.per \
	$(AS_CPU_PATH)/Creaser/Creaser.ox
	@"$(AS_BIN_PATH)/BR.AS.TaskBuilder.exe" "$(AS_CPU_PATH)/Creaser/Creaser.ox" -o "$(AS_CPU_PATH)/Creaser.br" -v V1.00.0 -f "$(AS_CPU_PATH)/NT.ofs" -offsetLT "$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/LT.ofs" -T SG4  -M IA32  -B B4.26 -extConstants  -extOptions -D $(AS_CONFIGURATION) -d "runtime: V* - V*,asieccon: V* - V*" -r Cyclic1 -p 3 -s "Application.Creaser" -L "Acp10_MC: V3.16.1, Acp10man: V3.16.1, Acp10par: V3.16.1, ArTextSys: V0.16.0, AsANSL: V*, AsARCfg: V*, AsArLog: V*, AsArProf: V*, AsArSdm: V*, AsBrMath: V*, AsBrStr: V*, AsICMP: V*, AsIecCon: V*, AsIOTime: V*, AsMem: V*, AsTCP: V*, astime: V*, AsUDP: V*, AsUSB: V*, AsXml: V*, bglibasWBR: V*, brsystem: V*, DataObj: V*, FileIO: V*, jgLibC: V*, MAPPSuppor: V*, MpAlarm: V1.60.1, MpAxis: V1.60.1, MpCom: V1.60.1, MpFile: V1.60.1, MpRecipe: V1.60.1, MpWebXs: V1.60.1, MTBasics: V2.21.0, MTData: V2.10.0, MTFilter: V2.10.0, MTProfile: V2.10.0, MTTypes: V1.03.0, NcGlobal: V3.16.1, operator: V*, runtime: V*, standard: V*, sys_lib: V*, wbrFltUtil: V*, wbrListSvc: V*, wbrLogSvc: V*, wbrMemSvc: V*, wbrPingSvc: V*, wbrsprintf: V*" -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.taskbuilder.exe"

$(AS_CPU_PATH)/Creaser/Creaser.ox: \
	$(AS_CPU_PATH)/Creaser/a.out
	@"$(AS_BIN_PATH)/BR.AS.Backend.exe" "$(AS_CPU_PATH)/Creaser/a.out" -o "$(AS_CPU_PATH)/Creaser/Creaser.ox" -T SG4 -r Cyclic1  -extOptions -D $(AS_CONFIGURATION)  -G V4.1.2  -secret "$(AS_PROJECT_PATH)_br.as.backend.exe"

$(AS_CPU_PATH)/Creaser/a.out: \
	$(AS_CPU_PATH)/Creaser/Main.st.o
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -link  -O "$(AS_CPU_PATH)//Creaser/Creaser.out.opt" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/Creaser.xref: \
	$(AS_CPU_PATH)/Creaser/Main.st.xrefo
	@"$(AS_BIN_PATH)/BR.AS.IECCrossRefLinker.exe"  "$(AS_CPU_PATH)/Creaser/Main.st.xrefo" -o "$(AS_CPU_PATH)/Creaser.xref"

$(AS_CPU_PATH)/Creaser/Main.st.o: \
	$(AS_PROJECT_PATH)/Logical/Application/Creaser/Main.st \
	$(AS_PROJECT_PATH)/Logical/Libraries/MpAxis/MpAxis.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/MpCom/MpCom.typ \
	$(AS_PROJECT_PATH)/Logical/Libraries/MpAxis/MpAxis.typ \
	$(AS_PROJECT_PATH)/Logical/Libraries/MpAxis/MpAxisError.typ \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/jgLibC.fun \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/bglibasWBR/bglibasWBR.fun \
	$(AS_PROJECT_PATH)/Logical/Application/Creaser/Variables.var \
	$(AS_PROJECT_PATH)/Physical/$(AS_CONFIGURATION)/$(AS_PLC)/Cpu.per \
	$(AS_PROJECT_PATH)/Logical/GlobalConstants.var \
	$(AS_PROJECT_PATH)/Logical/Machine.typ \
	$(AS_PROJECT_PATH)/Logical/Generic_Rec_Cfg.typ \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrMemSvc/wbrMemSvc.typ \
	$(AS_PROJECT_PATH)/Logical/Libraries/jgLibC/Types.typ \
	$(AS_PROJECT_PATH)/Logical/Libraries/standard/standard.fun \
	$(AS_PROJECT_PATH)/Physical/$(AS_CONFIGURATION)/$(AS_PLC)/mapp/Config.mpaxisbasic \
	$(AS_PROJECT_PATH)/Logical/Libraries/Acp10man/Acp10man.typ \
	$(AS_PROJECT_PATH)/Logical/Application/Creaser/Action_Creaser_Idx.st \
	$(AS_PROJECT_PATH)/Logical/Application/Creaser/Action_Manage_Update_Total_Runtime.st \
	$(AS_PROJECT_PATH)/Logical/Application/Creaser/Action_Start_Feeder.st \
	$(AS_PROJECT_PATH)/Logical/Application/Creaser/Action_Transition_Feed_Vel_Additive.st
	@"$(AS_BIN_PATH)/BR.AS.IecCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Application/Creaser/Main.st" -o "$(AS_CPU_PATH)/Creaser/Main.st.o"  -O "$(AS_CPU_PATH)//Creaser/Main.st.o.opt" -secret "$(AS_PROJECT_PATH)_br.as.ieccompiler.exe"

-include $(AS_CPU_PATH)/Force.mak 

