UnmarkedObjectFolder := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Physical/Config_Test/X20CP1584/TextSystem
MarkedObjectFolder := C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Physical/Config_Test/X20CP1584/TextSystem

$(AS_CPU_PATH)/TC.br: \
	$(AS_PROJECT_CPU_PATH)/TextSystem/TC.textconfig \
 	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.SystemConfiguration.Builder.exe"   "$(AS_PROJECT_CPU_PATH)/TextSystem/TC.textconfig" -o "$(AS_CPU_PATH)/TC.br" -zip  -extOptions -D $(AS_CONFIGURATION) -B B4.26 -z n.d -P "$(AS_PROJECT_PATH)" -c "$(AS_CONFIGURATION)" -secret "$(AS_PROJECT_PATH)_br.as.systemconfiguration.builder.exe"

FORCE: