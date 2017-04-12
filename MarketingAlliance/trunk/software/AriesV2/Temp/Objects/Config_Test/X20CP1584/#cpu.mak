SHELL = cmd.exe
export AS_PLC := X20CP1584
export AS_TEMP_PLC := X20CP1584
export AS_CPU_PATH := $(AS_TEMP_PATH)/Objects/$(AS_CONFIGURATION)/$(AS_PLC)
export AS_CPU_PATH_2 := C:/Users/jcgli/Desktop/software_Aries_041217/AriesV2/Temp//Objects/$(AS_CONFIGURATION)/$(AS_PLC)
export AS_PROJECT_CONFIG_PATH := $(AS_PROJECT_PATH)/Physical/$(AS_CONFIGURATION)
export AS_PROJECT_CPU_PATH := $(AS_PROJECT_CONFIG_PATH)/$(AS_PLC)
export AS_STATIC_ARCHIVES_PATH := $(AS_TEMP_PATH)/Archives/$(AS_CONFIGURATION)/$(AS_PLC)
export WIN32_AS_CPU_PATH := $(WIN32_AS_TEMP_PATH)\Objects\$(AS_CONFIGURATION)\$(AS_PLC)
export WIN32_AS_ACTIVE_CONFIG_PATH := $(WIN32_AS_PROJECT_PATH)\Physical\$(AS_CONFIGURATION)\$(AS_PLC)


CpuMakeFile: \
$(AS_CPU_PATH)/ashwd.br \
$(AS_CPU_PATH)/asfw.br \
$(AS_CPU_PATH)/sysconf.br \
$(AS_CPU_PATH)/arconfig.br \
$(AS_CPU_PATH)/acp10map.br \
$(AS_CPU_PATH)/acp10cfg.br \
$(AS_STATIC_ARCHIVES_PATH)/libwbrsprintf_s.a \
$(AS_CPU_PATH)/wbrPingSvc.br \
$(AS_CPU_PATH)/wbrPingSvc.xref \
$(AS_CPU_PATH)/wbrMemSvc.br \
$(AS_CPU_PATH)/wbrMemSvc.xref \
$(AS_CPU_PATH)/wbrLogSvc.br \
$(AS_CPU_PATH)/wbrLogSvc.xref \
$(AS_CPU_PATH)/wbrListSvc.br \
$(AS_CPU_PATH)/wbrListSvc.xref \
$(AS_CPU_PATH)/wbrFltUtil.br \
$(AS_CPU_PATH)/wbrFltUtil.xref \
$(AS_CPU_PATH)/MAPPSuppor.br \
$(AS_CPU_PATH)/MAPPSuppor.xref \
$(AS_CPU_PATH)/jgLibC.br \
$(AS_CPU_PATH)/jgLibC.xref \
$(AS_CPU_PATH)/bglibasWBR.br \
$(AS_CPU_PATH)/bglibasWBR.xref \
$(AS_CPU_PATH)/ForceIO.br \
$(AS_CPU_PATH)/ForceIO.xref \
$(AS_CPU_PATH)/Creaser.br \
$(AS_CPU_PATH)/Creaser.xref \
$(AS_CPU_PATH)/ForceIO1.br \
$(AS_CPU_PATH)/ForceIO1.xref \
$(AS_CPU_PATH)/LineContro.br \
$(AS_CPU_PATH)/LineContro.xref \
$(AS_CPU_PATH)/Recipe_Han.br \
$(AS_CPU_PATH)/Recipe_Han.xref \
$(AS_CPU_PATH)/hmilogic.br \
$(AS_CPU_PATH)/hmilogic.xref \
$(AS_CPU_PATH)/HMITableMa.br \
$(AS_CPU_PATH)/HMITableMa.xref \
$(AS_CPU_PATH)/File_Handl.br \
$(AS_CPU_PATH)/File_Handl.xref \
$(AS_CPU_PATH)/ComLogger.br \
$(AS_CPU_PATH)/ComLogger.xref \
$(AS_CPU_PATH)/acp10etxen.br \
$(AS_CPU_PATH)/Axisa.br \
$(AS_CPU_PATH)/Axisi.br \
$(AS_CPU_PATH)/Visu1.br \
$(AS_CPU_PATH)/iomap.br \
$(AS_CPU_PATH)/MAPP_File.br \
$(AS_CPU_PATH)/MAPP_Rec.br \
$(AS_CPU_PATH)/MAPP_Cfg.br \
$(AS_CPU_PATH)/MAPP_Web.br \
$(AS_CPU_PATH)/MAPP_Alm.br \
$(AS_CPU_PATH)/Alarm.br \
$(AS_CPU_PATH)/Data_Log.br \
$(AS_CPU_PATH)/Config.br \
$(AS_CPU_PATH)/TC.br \
$(AS_CPU_PATH)/TCData.br \
$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/Transfer.lst


$(AS_BINARIES_PATH)/$(AS_CONFIGURATION)/$(AS_PLC)/Transfer.lst: \
	FORCE
	@"$(AS_BIN_PATH)/BR.AS.FinalizeBuild.exe" "$(AS_PROJECT_PATH)/AriesV2.apj" -t "$(AS_TEMP_PATH)" -o "$(AS_BINARIES_PATH)" -c "$(AS_CONFIGURATION)" -i "C:/BrAutomation/AS42" -S "X20CP1584"  -all -A "X20CP1584" -pil   -swFiles "$(AS_PROJECT_PATH)/Physical/Config_Test/X20CP1584/Cpu.sw" -Z "GMC: 3.16.2, mapp: 1.60.1, mappView: 1.2.1, TextSystem: n.d, Connectivity: n.d, AAS: n.d" -C "/RT=1000 /AM=* /SDT=5 /DAIP=192.168.10.10 /REPO=11159 /ANSL=1 /PT=11169" -D "/IF=tcpip /LOPO=11159 /SA=1" -M IA32 -T SG4

#nothing to do (just call module make files)

include $(AS_CPU_PATH)/TCData/TCData.mak
include $(AS_CPU_PATH)/TC/TC.mak
include $(AS_CPU_PATH)/Config/Config.mak
include $(AS_CPU_PATH)/Data_Log/Data_Log.mak
include $(AS_CPU_PATH)/Alarm/Alarm.mak
include $(AS_CPU_PATH)/MAPP_Alm/MAPP_Alm.mak
include $(AS_CPU_PATH)/MAPP_Web/MAPP_Web.mak
include $(AS_CPU_PATH)/MAPP_Cfg/MAPP_Cfg.mak
include $(AS_CPU_PATH)/MAPP_Rec/MAPP_Rec.mak
include $(AS_CPU_PATH)/MAPP_File/MAPP_File.mak
include $(AS_CPU_PATH)/iomap/iomap.mak
include $(AS_CPU_PATH)/Visu1/Visu1.mak
include $(AS_CPU_PATH)/Axisi/Axisi.mak
include $(AS_CPU_PATH)/Axisa/Axisa.mak
include $(AS_CPU_PATH)/acp10etxen/acp10etxen.mak
include $(AS_CPU_PATH)/ComLogger/ComLogger.mak
include $(AS_CPU_PATH)/File_Handl/File_Handl.mak
include $(AS_CPU_PATH)/HMITableMa/HMITableMa.mak
include $(AS_CPU_PATH)/hmilogic/hmilogic.mak
include $(AS_CPU_PATH)/Recipe_Han/Recipe_Han.mak
include $(AS_CPU_PATH)/LineContro/LineContro.mak
include $(AS_CPU_PATH)/ForceIO1/ForceIO1.mak
include $(AS_CPU_PATH)/Creaser/Creaser.mak
include $(AS_CPU_PATH)/ForceIO/ForceIO.mak
include $(AS_CPU_PATH)/bglibasWBR/bglibasWBR.mak
include $(AS_CPU_PATH)/jgLibC/jgLibC.mak
include $(AS_CPU_PATH)/MAPPSuppor/MAPPSuppor.mak
include $(AS_CPU_PATH)/wbrFltUtil/wbrFltUtil.mak
include $(AS_CPU_PATH)/wbrListSvc/wbrListSvc.mak
include $(AS_CPU_PATH)/wbrLogSvc/wbrLogSvc.mak
include $(AS_CPU_PATH)/wbrMemSvc/wbrMemSvc.mak
include $(AS_CPU_PATH)/wbrPingSvc/wbrPingSvc.mak
include $(AS_CPU_PATH)/wbrsprintf/wbrsprintf.mak
include $(AS_CPU_PATH)/acp10cfg/acp10cfg.mak
include $(AS_CPU_PATH)/acp10map/acp10map.mak
include $(AS_CPU_PATH)/arconfig/arconfig.mak
include $(AS_CPU_PATH)/sysconf/sysconf.mak
include $(AS_CPU_PATH)/asfw/asfw.mak
include $(AS_CPU_PATH)/ashwd/ashwd.mak

.DEFAULT:
#nothing to do (need this target for prerequisite files that don't exit)

FORCE:
