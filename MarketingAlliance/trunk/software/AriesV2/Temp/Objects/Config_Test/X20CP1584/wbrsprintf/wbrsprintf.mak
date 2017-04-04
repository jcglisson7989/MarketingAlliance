UnmarkedObjectFolder := C:/Users/jcgli/Desktop/MarketingAlliance_033117/trunk/software/AriesV2/Logical/Libraries/wbrServices/wbrsprintf
MarkedObjectFolder := C:/Users/jcgli/Desktop/MarketingAlliance_033117/trunk/software/AriesV2/Logical/Libraries/wbrServices/wbrsprintf

$(AS_STATIC_ARCHIVES_PATH)/libwbrsprintf_s.a: \
	$(AS_CPU_PATH)/wbrsprintf/cvtflasc.c.o \
	$(AS_CPU_PATH)/wbrsprintf/ofmt.c.o \
	$(AS_CPU_PATH)/wbrsprintf/wbrsprintf.c.o \
	FORCE
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -staticlink "$(AS_CPU_PATH)/wbrsprintf/cvtflasc.c.o" "$(AS_CPU_PATH)/wbrsprintf/ofmt.c.o" "$(AS_CPU_PATH)/wbrsprintf/wbrsprintf.c.o"  -o "$(AS_STATIC_ARCHIVES_PATH)/libwbrsprintf_s.a"  -G V4.1.2  -T SG4  -M IA32   -extOptions -D $(AS_CONFIGURATION) -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/wbrsprintf/a.out: \
	$(AS_CPU_PATH)/wbrsprintf/cvtflasc.c.o \
	$(AS_CPU_PATH)/wbrsprintf/ofmt.c.o \
	$(AS_CPU_PATH)/wbrsprintf/wbrsprintf.c.o \
	FORCE
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" -link "$(AS_CPU_PATH)/wbrsprintf/cvtflasc.c.o" "$(AS_CPU_PATH)/wbrsprintf/ofmt.c.o" "$(AS_CPU_PATH)/wbrsprintf/wbrsprintf.c.o"  -o "$(AS_CPU_PATH)/wbrsprintf/a.out"  -G V4.1.2  -T SG4  -M IA32  -$placeholder_archiv_files -specs=I386specs -Wl,-q,-T,bur_elf_i386.x  -extOptions -D $(AS_CONFIGURATION)

$(AS_CPU_PATH)/wbrsprintf/cvtflasc.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf/cvtflasc.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf/cvtflasc.c" -o "$(AS_CPU_PATH)/wbrsprintf/cvtflasc.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.wbrServices.wbrsprintf" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" "$(AS_TEMP_PATH)/Includes/Libraries/wbrServices/wbrsprintf" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _WBRSPRINTF_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/wbrsprintf/ofmt.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf/ofmt.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf/ofmt.c" -o "$(AS_CPU_PATH)/wbrsprintf/ofmt.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.wbrServices.wbrsprintf" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" "$(AS_TEMP_PATH)/Includes/Libraries/wbrServices/wbrsprintf" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _WBRSPRINTF_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

$(AS_CPU_PATH)/wbrsprintf/wbrsprintf.c.o: \
	$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf/wbrsprintf.c \
	FORCE 
	@"$(AS_BIN_PATH)/BR.AS.CCompiler.exe" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf/wbrsprintf.c" -o "$(AS_CPU_PATH)/wbrsprintf/wbrsprintf.c.o"  -T SG4  -M IA32  -B B4.26 -G V4.1.2  -s "Libraries.wbrServices.wbrsprintf" -t "$(AS_TEMP_PATH)" -r Library -I "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" "$(AS_TEMP_PATH)/Includes/Libraries/wbrServices/wbrsprintf" "$(AS_TEMP_PATH)/Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrServices_C_Includes" "$(AS_PROJECT_PATH)/Logical/Libraries/wbrServices/wbrsprintf" -trigraphs -fno-asm -D _DEFAULT_INCLUDES -D _SG4 -fPIC -O0 -g -Wall -include "$(AS_CPU_PATH)/Libraries.h" -D _WBRSPRINTF_EXPORT  -extOptions -D $(AS_CONFIGURATION) -x c -P "$(AS_PROJECT_PATH)" -secret "$(AS_PROJECT_PATH)_br.as.ccompiler.exe"

-include $(AS_CPU_PATH)/Force.mak 



FORCE: