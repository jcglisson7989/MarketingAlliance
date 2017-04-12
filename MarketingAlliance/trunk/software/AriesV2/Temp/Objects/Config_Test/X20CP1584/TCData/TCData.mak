$(AS_CPU_PATH)/TCData/TCData.imx: \
	$(AS_PROJECT_PATH)/Logical/HMI/PV_RecCfg_Texts/Config.tmx \
	$(AS_PROJECT_PATH)/Logical/HMI/PV_RecCfg_Texts/Recipe.tmx \
	FORCE \
	$(AS_PROJECT_CPU_PATH)/TextSystem/TC.textconfig 
	@"$(AS_BIN_PATH)/BR.AS.Textsystem.Builder.exe" "$(AS_PROJECT_PATH)/Logical/HMI/PV_RecCfg_Texts/Config.tmx $(AS_PROJECT_PATH)/Logical/HMI/PV_RecCfg_Texts/Recipe.tmx" -o "$(AS_CPU_PATH)/TCData/TCData.imx" -c "$(AS_PROJECT_CPU_PATH)/TextSystem/TC.textconfig" -I "$(AS_SYSTEM_PATH)/B0426 $(AS_INSTALL_PATH)/AS/TechnologyPackages/mapp/1.60.1 $(AS_INSTALL_PATH)/AS/TechnologyPackages/TextSystem/n.d"  -P "$(AS_PROJECT_PATH)"  -extOptions -D $(AS_CONFIGURATION)

$(AS_CPU_PATH)/TCData/TCData.s18d: \
	$(AS_CPU_PATH)/TCData/TCData.imx 
	@"$(AS_BIN_PATH)/BR.AS.MsgCompiler.exe" "$(AS_CPU_PATH)/TCData/TCData.imx" -o "$(AS_CPU_PATH)/TCData/TCData.s18d"

$(AS_CPU_PATH)/TCData.br: \
	$(AS_CPU_PATH)/TCData/TCData.s18d 
	@"$(AS_BIN_PATH)/BR.AS.BuildBrModule.exe" "$(AS_CPU_PATH)/TCData/TCData.s18d" -o "$(AS_CPU_PATH)/TCData.br" -t TextModule

