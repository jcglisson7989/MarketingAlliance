UnmarkedObjectFolder := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/Auxiliary_Services_Control/Recipe_Handling
MarkedObjectFolder := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/Auxiliary_Services_Control/Recipe_Handling

$(AS_CPU_PATH)/Recipe_Han.br: \
	$(AS_PROJECT_CPU_PATH)/Cpu.per \
	FORCE \
	$(AS_CPU_PATH)/Recipe_Han/Recipe_Han.ox
	@"$(AS_BIN_PATH)/BR.AS.TaskBuilder.exe" "$(AS_CPU_PATH)/Recipe_Han/Recipe_Han.ox" -o "$(AS_CPU_PATH)/Recipe_Han.br" -v V1.00.0 -f "$(AS_CPU_PATH)/NT.ofs" -offsetLT "$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/LT.ofs" -T SG4  -M IA32  -B B4.26 -extConstants  -extOptions -D $(AS_CONFIGURATION) -d "runtime: V* - V*,asieccon: V* - V*" -r Cyclic8 -p 4 -s "Auxiliary_Services_Control.Recipe_Handling" -L "Acp10_MC: V3.16.1, Acp10man: V3.16.1, Acp10par: V3.16.1, Acp10sim: V3.16.1, ArTextSys: V*, AsANSL: V*, AsARCfg: V*, AsArLog: V*, AsArProf: V*, AsArSdm: V*, AsBrMath: V*, AsBrStr: V*, AsICMP: V*, AsIecCon: V*, AsIOTime: V*, AsMem: V*, AsTCP: V*, astime: V*, AsUDP: V*, AsUSB: V*, AsXml: V*, bglibasWBR: V*, brsystem: V*, DataObj: V*, FileIO: V*, jgLibC: V*, MAPPSuppor: V*, MpAlarm: V1.60.1, MpAxis: V1.60.1, MpCom: V1.60.1, MpFile: V1.60.1, MpRecipe: V1.60.1, MpWebXs: V1.60.1, MTData: V2.10.0, MTTypes: V1.03.0, NcGlobal: V3.16.1, operator: V*, runtime: V*, standard: V*, sys_lib: V*, wbrFltUtil: V*, wbrListSvc: V*, wbrLogSvc: V*, wbrMemSvc: V*, wbrPingSvc: V*, wbrsprintf: V*" -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.taskbuilder.exe"

$(AS_CPU_PATH)/Recipe_Han/Recipe_Han.ox: \
	$(AS_CPU_PATH)/Recipe_Han/a.out \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.Backend.exe" "$(AS_CPU_PATH)/Recipe_Han/a.out" -o "$(AS_CPU_PATH)/Recipe_Han/Recipe_Han.ox" -T SG4 -r Cyclic8  -extOptions -D $(AS_CONFIGURATION)  -G V4.1.2  -secret "$(AS_PROJECT_PATH)_br.as.backend.exe"

$(AS_CPU_PATH)/Recipe_Han/a.out: \
	$(AS_CPU_PATH)/Recipe_Han/Cyclic.st.o \
	$(AS_CPU_PATH)/Recipe_Han/Init.st.o \
	$(AS_CPU_PATH)/Recipe_Han/Exit.st.o \
	$(AS_CPU_PATH)/Recipe_Han/Set_Default_Recipe_Values.st.o \
	$(AS_CPU_PATH)/Recipe_Han/Set_Default_Config_Values.st.o \
	FORCE
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -link  -O "$(AS_CPU_PATH)//Recipe_Han/Recipe_Han.out.opt" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/Recipe_Han.xref: \
	$(AS_CPU_PATH)/Recipe_Han/Cyclic.st.xrefo \
	$(AS_CPU_PATH)/Recipe_Han/Init.st.xrefo \
	$(AS_CPU_PATH)/Recipe_Han/Exit.st.xrefo \
	$(AS_CPU_PATH)/Recipe_Han/Set_Default_Recipe_Values.st.xrefo \
	$(AS_CPU_PATH)/Recipe_Han/Set_Default_Config_Values.st.xrefo
	@"$(AS_BIN_PATH)/BR.AS.IECCrossRefLinker.exe"  "$(AS_CPU_PATH)/Recipe_Han/Cyclic.st.xrefo" "$(AS_CPU_PATH)/Recipe_Han/Init.st.xrefo" "$(AS_CPU_PATH)/Recipe_Han/Exit.st.xrefo" "$(AS_CPU_PATH)/Recipe_Han/Set_Default_Recipe_Values.st.xrefo" "$(AS_CPU_PATH)/Recipe_Han/Set_Default_Config_Values.st.xrefo" -o "$(AS_CPU_PATH)/Recipe_Han.xref"

$(AS_CPU_PATH)/Recipe_Han/Cyclic.st.o: \
	$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Cyclic.st \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.IecCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Cyclic.st" -o "$(AS_CPU_PATH)/Recipe_Han/Cyclic.st.o"  -O "$(AS_CPU_PATH)//Recipe_Han/Cyclic.st.o.opt" -secret "$(AS_PROJECT_PATH)_br.as.ieccompiler.exe"

$(AS_CPU_PATH)/Recipe_Han/Init.st.o: \
	$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Init.st \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.IecCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Init.st" -o "$(AS_CPU_PATH)/Recipe_Han/Init.st.o"  -O "$(AS_CPU_PATH)//Recipe_Han/Init.st.o.opt" -secret "$(AS_PROJECT_PATH)_br.as.ieccompiler.exe"

$(AS_CPU_PATH)/Recipe_Han/Exit.st.o: \
	$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Exit.st \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.IecCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Exit.st" -o "$(AS_CPU_PATH)/Recipe_Han/Exit.st.o"  -O "$(AS_CPU_PATH)//Recipe_Han/Exit.st.o.opt" -secret "$(AS_PROJECT_PATH)_br.as.ieccompiler.exe"

$(AS_CPU_PATH)/Recipe_Han/Set_Default_Recipe_Values.st.o: \
	$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Set_Default_Recipe_Values.st \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.IecCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Set_Default_Recipe_Values.st" -o "$(AS_CPU_PATH)/Recipe_Han/Set_Default_Recipe_Values.st.o"  -O "$(AS_CPU_PATH)//Recipe_Han/Set_Default_Recipe_Values.st.o.opt" -secret "$(AS_PROJECT_PATH)_br.as.ieccompiler.exe"

$(AS_CPU_PATH)/Recipe_Han/Set_Default_Config_Values.st.o: \
	$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Set_Default_Config_Values.st \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.IecCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Auxiliary_Services_Control/Recipe_Handling/Set_Default_Config_Values.st" -o "$(AS_CPU_PATH)/Recipe_Han/Set_Default_Config_Values.st.o"  -O "$(AS_CPU_PATH)//Recipe_Han/Set_Default_Config_Values.st.o.opt" -secret "$(AS_PROJECT_PATH)_br.as.ieccompiler.exe"

-include $(AS_CPU_PATH)/Force.mak 



FORCE: