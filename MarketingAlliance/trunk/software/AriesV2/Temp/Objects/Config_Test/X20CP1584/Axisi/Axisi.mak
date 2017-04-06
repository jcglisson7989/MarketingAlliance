UnmarkedObjectFolder := C:/Users/admin/Desktop/MarketingAlliance_040417/software/AriesV2/Logical/Axisobj/Axisi
MarkedObjectFolder := C:/Users/admin/Desktop/MarketingAlliance_040417/software/AriesV2/Logical/Axisobj/Axisi

$(AS_CPU_PATH)/Axisi.br: \
	$(AS_PROJECT_PATH)/Logical/Axisobj/Axisi/Axisi.ax \
 	FORCE 
	@"$(AS_BIN_PATH)/BR.MC.Builder.exe"   "$(AS_PROJECT_PATH)/Logical/Axisobj/Axisi/Axisi.ax" -o "$(AS_CPU_PATH)/Axisi.br" -T SG4  -B B4.26 -v V1.00.0 -s "Axisobj.Axisi" -L "Acp10_MC: V3.16.2, Acp10man: V3.16.2, Acp10par: V3.16.2, NcGlobal: V3.16.2" -P "$(AS_PROJECT_PATH)"  -extOptions -D $(AS_CONFIGURATION) -secret "$(AS_PROJECT_PATH)_br.mc.builder.exe"

FORCE: