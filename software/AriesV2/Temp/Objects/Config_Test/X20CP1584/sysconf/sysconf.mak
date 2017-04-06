$(AS_CPU_PATH)/sysconf.br: \
	FORCE \
	$(AS_PROJECT_CONFIG_PATH)/Hardware.hw 
	@"$(AS_BIN_PATH)/BR.AS.ConfigurationBuilder.exe" "$(AS_PROJECT_CONFIG_PATH)/Hardware.hw"  -c Config_Test -sysconf -S "X20CP1584" -F 1.5 -o "$(AS_CPU_PATH)/sysconf.br" -T SG4  -B B4.26 -P "$(AS_PROJECT_PATH)" -s "Config_Test"  -extOptions -D $(AS_CONFIGURATION) -secret "$(AS_PROJECT_PATH)_br.as.configurationbuilder.exe"

FORCE:

-include $(AS_CPU_PATH)/Force.mak 
