UnmarkedObjectFolder := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Logical/acp10etxen
MarkedObjectFolder := C:/Users/jcgli/Desktop/software_Aries_040717/AriesV2/Logical/acp10etxen

$(AS_CPU_PATH)/acp10etxen.br: \
	$(AS_PROJECT_PATH)/Logical/acp10etxen/acp10etxen.ett
	@"$(AS_BIN_PATH)/BR.MC.Builder.exe"   "$(AS_PROJECT_PATH)/Logical/acp10etxen/acp10etxen.ett" -o "$(AS_CPU_PATH)/acp10etxen.br" -T SG4  -B B4.26 -v V1.00.0 -s "acp10etxen" -L "Acp10_MC: V3.16.1, Acp10man: V3.16.1, Acp10par: V3.16.1, NcGlobal: V3.16.1" -P "$(AS_PROJECT_PATH)"  -extOptions -D $(AS_CONFIGURATION) -secret "$(AS_PROJECT_PATH)_br.mc.builder.exe"

