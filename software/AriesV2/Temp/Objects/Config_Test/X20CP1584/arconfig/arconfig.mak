$(AS_CPU_PATH)/arconfig.br: \
	FORCE \
	$(AS_PROJECT_CONFIG_PATH)/Hardware.hw \
	$(AS_PROJECT_CPU_PATH)/IoMap.iom 
	@"$(AS_BIN_PATH)/BR.AS.ConfigurationBuilder.exe" "$(AS_PROJECT_CONFIG_PATH)/Hardware.hw" "$(AS_PROJECT_CPU_PATH)/IoMap.iom"  -arconfig -L "Acp10_MC: V3.16.2, Acp10man: V3.16.2, Acp10par: V3.16.2, NcGlobal: V3.16.2" -c Config_Test -v V1.00.0 -S "X20CP1584" -F 1.5 -o "$(AS_CPU_PATH)/arconfig.br" "$(AS_CPU_PATH)/ChannelConfiguration.xml" "$(AS_CPU_PATH)/HardwareConfiguration.xml" "$(AS_CPU_PATH)/ReActionTechnologyConfiguration.xml" -T SG4  -B B4.26 -P "$(AS_PROJECT_PATH)" -s "Config_Test"  -extOptions -D $(AS_CONFIGURATION) -secret "$(AS_PROJECT_PATH)_br.as.configurationbuilder.exe"

FORCE:

-include $(AS_CPU_PATH)/Force.mak 
