$(AS_CPU_PATH)/acp10cfg.br: \
	$(AS_PROJECT_CPU_PATH)/Motion/Acp10cfg.ncc \
	$(AS_PROJECT_PATH)/physical/config_test/x20cp1382/motion/acp10cfg.ncc \
	$(AS_PROJECT_PATH)/physical/config_test/hardware.hw \
	$(AS_PROJECT_PATH)/physical/config_test/x20cp1382/motion/acp10map.ncm
	@"$(AS_BIN_PATH)/BR.MC.Builder.exe" "$(AS_PROJECT_CPU_PATH)/Motion/Acp10cfg.ncc"  -a "$(AS_PROJECT_CONFIG_PATH)/Hardware.hw" -m "$(AS_PROJECT_CPU_PATH)/Motion/Acp10map.ncm" -L "Acp10_MC: V3.16.1, Acp10man: V3.16.1, Acp10par: V3.16.1, NcGlobal: V3.16.1" -P "$(AS_PROJECT_PATH)" -o "$(AS_CPU_PATH)/acp10cfg.br" -T SG4  -s "Config_Test.X20CP1382.Motion"  -extOptions -D $(AS_CONFIGURATION) -secret "$(AS_PROJECT_PATH)_br.mc.builder.exe"

-include $(AS_CPU_PATH)/Force.mak 
