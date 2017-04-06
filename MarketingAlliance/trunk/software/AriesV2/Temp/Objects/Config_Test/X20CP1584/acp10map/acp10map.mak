$(AS_CPU_PATH)/acp10map.br: \
	FORCE \
	$(AS_PROJECT_CPU_PATH)/Motion/Acp10map.ncm 
	@"$(AS_BIN_PATH)/BR.MC.Builder.exe" "$(AS_PROJECT_CPU_PATH)/Motion/Acp10map.ncm"  -v V1.00.0 -a "$(AS_PROJECT_CONFIG_PATH)/Hardware.hw" -L "Acp10_MC: V3.16.2, Acp10man: V3.16.2, Acp10par: V3.16.2, NcGlobal: V3.16.2" -P "$(AS_PROJECT_PATH)" -o "$(AS_CPU_PATH)/Acp10map.br" -T SG4  -s "Config_Test.X20CP1584.Motion"  -extOptions -D $(AS_CONFIGURATION) -secret "$(AS_PROJECT_PATH)_br.mc.builder.exe"

FORCE:

-include $(AS_CPU_PATH)/Force.mak 
