######################################################
#                                                    #
# Automatic generated Makefile for Visual Components #
#                                                    #
#                  Do NOT edit!                      #
#                                                    #
######################################################

VCC:=@"$(AS_BIN_PATH)/br.vc.pc.exe"
LINK:=@"$(AS_BIN_PATH)/BR.VC.Link.exe"
MODGEN:=@"$(AS_BIN_PATH)/BR.VC.ModGen.exe"
VCPL:=@"$(AS_BIN_PATH)/BR.VC.PL.exe"
VCHWPP:=@"$(AS_BIN_PATH)/BR.VC.HWPP.exe"
VCDEP:=@"$(AS_BIN_PATH)/BR.VC.Depend.exe"
VCFLGEN:=@"$(AS_BIN_PATH)/BR.VC.lfgen.exe"
VCREFHANDLER:=@"$(AS_BIN_PATH)/BR.VC.CrossReferenceHandler.exe"
VCXREFEXTENDER:=@"$(AS_BIN_PATH)/BR.AS.CrossRefVCExtender.exe"
RM=CMD /C DEL
PALFILE_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Palette.vcr
VCCFLAGS_Visup=-server -proj Visup -vc "$(AS_PROJECT_PATH)/Logical/HMI/Visup/VCObject.vc" -prj_path "$(AS_PROJECT_PATH)" -temp_path "$(AS_TEMP_PATH)" -cfg $(AS_CONFIGURATION) -plc $(AS_PLC) -plctemp $(AS_TEMP_PLC) -cpu_path "$(AS_CPU_PATH)"
VCFIRMWARE=4.26.3
VCFIRMWAREPATH=$(AS_VC_PATH)/Firmware/V4.26.3/SG4
VCOBJECT_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/VCObject.vc
VCSTARTUP="vcstart.br"
VCLOD="vclod.br"
VCSTPOST="vcstpost.br"
TARGET_FILE_Visup=$(AS_CPU_PATH)/Visup.br
OBJ_SCOPE_Visup=HMI
PRJ_PATH_Visup=$(AS_PROJECT_PATH)
SRC_PATH_Visup=$(AS_PROJECT_PATH)/Logical/$(OBJ_SCOPE_Visup)/Visup
TEMP_PATH_Visup=$(AS_TEMP_PATH)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/Visup
TEMP_PATH_Shared=$(AS_TEMP_PATH)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/VCShared
TEMP_PATH_ROOT_Visup=$(AS_TEMP_PATH)
VC_LIBRARY_LIST_Visup=$(TEMP_PATH_Visup)/libraries.vci
VC_XREF_BUILDFILE_Visup=$(AS_TEMP_PATH)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/vcxref.build
VC_XREF_CLEANFILE=$(AS_TEMP_PATH)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/vcxref.clean
VC_LANGUAGES_Visup=$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr
CPUHWC="$(TEMP_PATH_Visup)/cpuhwc.vci"
VC_STATIC_OPTIONS_Visup="$(TEMP_PATH_Visup)/vcStaticOptions.xml"
VC_STATIC_OPTIONS_Shared="$(TEMP_PATH_Shared)/vcStaticOptions.xml"
# include Shared and Font Makefile (only once)
	include $(AS_TEMP_PATH)/objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/VCFntDat/Font_Visup.mak
ifneq ($(VCINC),1)
	VCINC=1
	include $(AS_TEMP_PATH)/objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/VCShared/VCShared.mak
endif

DEPENDENCIES_Visup=-d vcgclass -profile "False"
DEFAULT_STYLE_SHEET_Visup=Source[local].StyleSheet[Color]
SHARED_MODULE=$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/vcshared.br
LFNTFLAGS_Visup=-P "$(AS_PROJECT_PATH)" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)"
BDRFLAGS_Visup=-P "$(AS_PROJECT_PATH)" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)"

# Local Libs
LIB_LOCAL_OBJ_Visup=$(TEMP_PATH_Visup)/localobj.vca

# Hardware sources
PANEL_HW_OBJECT_Visup=$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/Visup/dis.Hardware.vco
PANEL_HW_VCI_Visup=$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/Visup/dis.Hardware.vci
PANEL_HW_SOURCE_Visup=C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Physical/Config_Deployment/Hardware.hw 
DIS_OBJECTS_Visup=$(PANEL_HW_OBJECT_Visup) $(KEYMAP_OBJECTS_Visup)

# KeyMapping flags
$(TEMP_PATH_Visup)/dis.PS2-Keyboard4.vco: $(AS_PROJECT_PATH)/Physical/Config_Deployment/X20CP1382/VC/PS2-Keyboard4.dis
	$(VCHWPP) -f "$(PANEL_HW_SOURCE_Visup)" -o "$(subst .vco,.vci,$(TEMP_PATH_Visup)/dis.PS2-Keyboard4.vco)" -n Visup -d Visup -pal "$(PALFILE_Visup)" -c "$(AS_CONFIGURATION)" -p "$(AS_PLC)" -ptemp "$(AS_TEMP_PLC)" -B "B4.26" -L "" -hw "$(CPUHWC)" -warninglevel 2 -so $(VC_STATIC_OPTIONS_Visup) -sos $(VC_STATIC_OPTIONS_Shared) -keyboard "$(AS_PROJECT_PATH)/Physical/Config_Deployment/X20CP1382/VC/PS2-Keyboard4.dis" -fp "$(AS_VC_PATH)/Firmware/V4.26.3/SG4" -prj "$(AS_PROJECT_PATH)" -apj "AriesV2" -sfas -vcob "$(VCOBJECT_Visup)"
	$(VCC) -f "$(subst .vco,.vci,$@)" -o "$@" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -k "$(VCVK_SOURCES_Visup)" $(VCCFLAGS_Visup) -p Visup -sfas

KEYMAP_SOURCES_Visup=$(AS_PROJECT_PATH)/Physical/Config_Deployment/X20CP1382/VC/PS2-Keyboard4.dis 
KEYMAP_OBJECTS_Visup=$(TEMP_PATH_Visup)/dis.PS2-Keyboard4.vco 

# All Source Objects
TXTGRP_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/AriesMachineSMTexts.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/AriesPrcsSMTexts.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/LoginLevels.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_AUTOTUNE_MODE.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_AUTOTUNE_ORIENTATION.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_FF_MODE_ENUM.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_HOME_DIR_ENUM.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_HOME_MODE.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_HOME_OPTION_ENUM.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_Limit_Status.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_MOVE_DIRECTION.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_Power_On_Status.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_Read_Mode.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_STOP_PHASE.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MpButtons_PageTexts.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/Tabs_30_Config.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/Tabs_50_Diagnostics.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/WebURLs.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/AppLabels_0.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/DateTimeHeader.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MM_Left_Titles.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/Tabs_20_Recipe.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/Tabs_40_Login.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_PLCOpen_State.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_COMMAND_EXECUTE_ENUM.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_COMM_SEVERITIES.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_FACILITIES_eNUM.txtgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_INTERNAL_ERROR_ENUM.txtgrp 

FNINFO_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/DefaultFont.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/Info.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/MpButton.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/MpDefault.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/MpDefault_0.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/MpDefault_3.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/MpHtml_SDM.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/MpInfo.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/MpInput.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/MpPads.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_10.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_11.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_12.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_13.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_15.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_17.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_18.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_22.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_26.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_6.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_7.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_8.fninfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Fonts/rockwell_9.fninfo 

BMINFO_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_alertmsg_border.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_border_nav_listviewbox_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_dialog_check.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_dialog_x.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_down_1_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_down_2_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_pvlistview_box.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_up_1_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_up_2_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_AlphaPad_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_AlphaPad_pressed_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_EditPad.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_EditPad_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadHor.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadHor_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadVer.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadVer_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPadLimits_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPadLimits_pressed_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_Large_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_pressed_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_pressed_Large_0.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_AcknowledgeReset.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_NotQuit.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_Quit.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_ResetAcknowledge.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpBorderSlider09x09.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_control.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_control_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_decrease.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_decrease_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_default.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_default_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_device_selected_left.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_device_unselected_left.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_error.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_bottom1.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_bottom.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_left.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_pres_bottom.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_press_left.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_increase.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_increase_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_off.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_on.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_radio_selected.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_radio_unselected.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_ready.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_multi.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_multi_press.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_left.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_left_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_right.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_right_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_multi.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_multi_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small_checked.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small_gray.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerAlarm.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerInformation.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerWarning.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowLeft.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowRight.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowUp.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_BMP.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_CSV.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_DOC.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_FILE.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_FOLDER.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_HTML.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_JPG.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_TXT.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_XLS.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_XML.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFrameHeader.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFrameInvisible.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpGroupControl.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderCenterless.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderInactiveCenterless.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderInactive.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorder.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_lowerPressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_lower.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric2Pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric2.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numericPressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_upperPressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_upper.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_lowerPressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_lower.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric2Pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric2.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numericPressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_upperPressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_upper.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadHor.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadHor_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadVer.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadVer_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_Numpad.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_Numpad_pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorderDown.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorderLeft.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorder.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpMpFile_ArrowDown.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpOutputBorder.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpProgressBorder.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_BLK_114x220.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_BLU_114x220.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_GRN_114x221.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_RED_114x221.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/checkbox_small.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/checkbox_small_checked.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/logoMarketingAllianceInc.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Diagnostics_64x64_Pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Engineer_64x64_Pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Gears_64x64_Pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Home_64x64_Pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Recipe_64x64_Pressed.bminfo \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Security_64x64_Pressed.bminfo 

BMGRP_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/Pads.bmgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MM_Left_Bmaps_sel.bmgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpAlarmAcknowledgeState.bmgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpBorders.bmgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpComSeveritiesEnum.bmgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpFileIcons.bmgrp \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpPads.bmgrp 

PAGE_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/PageEmpty.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg00_Startup.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg10_Home_Dashboard.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg20_Recipe_1_Select.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg21_Recipe_2_PVListView.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg30_Config_1_Select.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg31_Config_2_PVListView.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg40_Login_1_Main.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg41_Login_2_Operator.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg42_Login_3_Setup.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg43_Login_4_Engineer.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg50_Diagnostics_1_Alarms.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg51_Diagnostics_2_Alarm_History.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg52_Diagnostics_3_SDM.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg53_Diagnostics_4_FileExplorer.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg54_Diagnostics_5_Motion_1.page \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg55_Diagnostics_6_Information.page 

LAYER_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Background.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MSG_Alert.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Global_Overlay.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Login_Main.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_Alarm_Basic.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_Alarm_History.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_ComLogger.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_File_Manager.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_File_Message.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_Recipe_Control.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_Recipe_Message.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MSG_Dialog.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Motion_MAPP_Axis_Power_Home.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Motion_MAPP_Axis_Setup.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/UI_Change_Lang.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/pvListViewMain.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Navigation_Left.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Tabs_20_Recipe.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Tabs_30_Config.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Tabs_40_Login.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Tabs_50_Diagnostics.layer \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Motion_MAPP_Axis_Lefthand_Choice.layer 

VCS_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/StyleSheets/Color.vcs 

BDR_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Flat_grey.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Sunken.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/AS_border_AlertMessage.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/AS_border_nav.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Flat_black.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Flat_grey.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/HAS_pvlistviewbox_border.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Control_pressed.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Device_Select_Left.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Device_Unselect_Left.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Multi_Scroll_Down.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Multi_Scroll_Dwn_press.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Multi_Scroll_Up.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Multi_Scroll_Up_press.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scoll_Up.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scoll_Up_pressed.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Down.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Down_pressed.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Left.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Left_pressed.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Right.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Right_pressed.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_pressed.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_FrameInvisible.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_InputBorder.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_OutputBorder.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_SliderBorder09.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_TabActive.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Panel_BLK.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Panel_BLU.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Panel_GRN.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Panel_RED.bdr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Raised.bdr 

TPR_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/TouchPads/MpNavigationPad_ver.tpr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TouchPads/NumPad.tpr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TouchPads/MpAlphaPad.tpr \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/TouchPads/MpNumPad.tpr 

TDC_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Trends/TrendData.tdc 

CLM_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/Header_Tab_Sel_Txt.clm \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/MAPP_Read_Valid.clm \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/MSG_Alert_Text.clm \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/Motion_Button.clm \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/Sensor_0_White_1_Grn.clm \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/Sensor_0_White_1_Red.clm \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/cmpAriesUIIndicator.clm \
	$(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/cmpAriesBoardFeedingLamp.clm 

VCVK_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/VirtualKeys.vcvk 

VCR_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Palette.vcr 

# Runtime Object sources
VCR_OBJECT_Visup=$(TEMP_PATH_Visup)/vcrt.vco
VCR_SOURCE_Visup=$(SRC_PATH_Visup)/package.vcp
# All Source Objects END

#Panel Hardware
$(PANEL_HW_VCI_Visup): $(PANEL_HW_SOURCE_Visup) $(VC_LIBRARY_LIST_Visup) $(KEYMAP_SOURCES_Visup)
	$(VCHWPP) -f "$<" -o "$@" -n Visup -d Visup -pal "$(PALFILE_Visup)" -c "$(AS_CONFIGURATION)" -p "$(AS_PLC)" -ptemp "$(AS_TEMP_PLC)" -B "B4.26" -L "" -verbose "False" -profile "False" -hw "$(CPUHWC)" -warninglevel 2 -so $(VC_STATIC_OPTIONS_Visup) -sos $(VC_STATIC_OPTIONS_Shared) -fp "$(AS_VC_PATH)/Firmware/V4.26.3/SG4" -sfas -prj "$(AS_PROJECT_PATH)" -apj "AriesV2" -vcob "$(VCOBJECT_Visup)"

$(PANEL_HW_OBJECT_Visup): $(PANEL_HW_VCI_Visup) $(PALFILE_Visup) $(VC_LIBRARY_LIST_Visup)
	$(VCC) -f "$(subst .vco,.vci,$@)" -o "$@" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -k "$(VCVK_SOURCES_Visup)" $(VCCFLAGS_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


# Pages
PAGE_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/page., $(notdir $(PAGE_SOURCES_Visup:.page=.vco)))

$(TEMP_PATH_Visup)/page.PageEmpty.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/PageEmpty.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg00_Startup.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg00_Startup.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg10_Home_Dashboard.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg10_Home_Dashboard.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg20_Recipe_1_Select.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg20_Recipe_1_Select.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg21_Recipe_2_PVListView.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg21_Recipe_2_PVListView.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg30_Config_1_Select.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg30_Config_1_Select.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg31_Config_2_PVListView.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg31_Config_2_PVListView.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg40_Login_1_Main.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg40_Login_1_Main.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg41_Login_2_Operator.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg41_Login_2_Operator.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg42_Login_3_Setup.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg42_Login_3_Setup.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg43_Login_4_Engineer.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg43_Login_4_Engineer.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg50_Diagnostics_1_Alarms.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg50_Diagnostics_1_Alarms.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg51_Diagnostics_2_Alarm_History.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg51_Diagnostics_2_Alarm_History.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg52_Diagnostics_3_SDM.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg52_Diagnostics_3_SDM.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg53_Diagnostics_4_FileExplorer.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg53_Diagnostics_4_FileExplorer.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg54_Diagnostics_5_Motion_1.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg54_Diagnostics_5_Motion_1.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/page.Pg55_Diagnostics_6_Information.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Pages/Pg55_Diagnostics_6_Information.page $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds "$(SRC_PATH_Visup)/StyleSheets/Color.vcs" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#Pages END




# Stylesheets
VCS_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/vcs., $(notdir $(VCS_SOURCES_Visup:.vcs=.vco)))

$(TEMP_PATH_Visup)/vcs.Color.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/StyleSheets/Color.vcs
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -P "$(AS_PROJECT_PATH)" -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#Stylesheets END




# Layers
LAYER_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/layer., $(notdir $(LAYER_SOURCES_Visup:.layer=.vco)))

$(TEMP_PATH_Visup)/layer.Background.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Background.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MSG_Alert.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MSG_Alert.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Global_Overlay.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Global_Overlay.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Login_Main.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Login_Main.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MAPP_UI_Alarm_Basic.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_Alarm_Basic.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MAPP_UI_Alarm_History.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_Alarm_History.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MAPP_UI_ComLogger.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_ComLogger.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MAPP_UI_File_Manager.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_File_Manager.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MAPP_UI_File_Message.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_File_Message.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MAPP_UI_Recipe_Control.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_Recipe_Control.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MAPP_UI_Recipe_Message.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MAPP_UI_Recipe_Message.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.MSG_Dialog.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/MSG_Dialog.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Motion_MAPP_Axis_Power_Home.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Motion_MAPP_Axis_Power_Home.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Motion_MAPP_Axis_Setup.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Motion_MAPP_Axis_Setup.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.UI_Change_Lang.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/UI_Change_Lang.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.pvListViewMain.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/pvListViewMain.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Navigation_Left.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Navigation_Left.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Tabs_20_Recipe.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Tabs_20_Recipe.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Tabs_30_Config.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Tabs_30_Config.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Tabs_40_Login.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Tabs_40_Login.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Tabs_50_Diagnostics.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Tabs_50_Diagnostics.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/layer.Motion_MAPP_Axis_Lefthand_Choice.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Layers/Motion_MAPP_Axis_Lefthand_Choice.layer $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -ds $(DEFAULT_STYLE_SHEET_Visup) -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#Layers END




# Virtual Keys
VCVK_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/vcvk., $(notdir $(VCVK_SOURCES_Visup:.vcvk=.vco)))

$(TEMP_PATH_Visup)/vcvk.VirtualKeys.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/VirtualKeys.vcvk
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas

$(VCVK_OBJECTS_Visup): $(VC_LANGUAGES_Visup)

#Virtual Keys END




# Touch Pads
TPR_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/tpr., $(notdir $(TPR_SOURCES_Visup:.tpr=.vco)))

$(TEMP_PATH_Visup)/tpr.MpNavigationPad_ver.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TouchPads/MpNavigationPad_ver.tpr
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -prj "C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/HMI/Visup" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/tpr.NumPad.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TouchPads/NumPad.tpr
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -prj "C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/HMI/Visup" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/tpr.MpAlphaPad.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TouchPads/MpAlphaPad.tpr
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -prj "C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/HMI/Visup" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/tpr.MpNumPad.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TouchPads/MpNumPad.tpr
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup) -prj "C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Logical/HMI/Visup" -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#Touch Pads END




# Text Groups
TXTGRP_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/txtgrp., $(notdir $(TXTGRP_SOURCES_Visup:.txtgrp=.vco)))

$(TEMP_PATH_Visup)/txtgrp.AriesMachineSMTexts.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/AriesMachineSMTexts.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.AriesPrcsSMTexts.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/AriesPrcsSMTexts.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.LoginLevels.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/LoginLevels.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_AUTOTUNE_MODE.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_AUTOTUNE_MODE.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_AUTOTUNE_ORIENTATION.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_AUTOTUNE_ORIENTATION.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_FF_MODE_ENUM.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_FF_MODE_ENUM.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_HOME_DIR_ENUM.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_HOME_DIR_ENUM.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_HOME_MODE.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_HOME_MODE.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_HOME_OPTION_ENUM.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_HOME_OPTION_ENUM.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_Limit_Status.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_Limit_Status.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_MOVE_DIRECTION.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_MOVE_DIRECTION.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_Power_On_Status.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_Power_On_Status.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_Read_Mode.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_Read_Mode.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_STOP_PHASE.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_STOP_PHASE.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MpButtons_PageTexts.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MpButtons_PageTexts.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.Tabs_30_Config.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/Tabs_30_Config.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.Tabs_50_Diagnostics.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/Tabs_50_Diagnostics.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.WebURLs.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/WebURLs.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.AppLabels_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/AppLabels_0.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.DateTimeHeader.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/DateTimeHeader.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MM_Left_Titles.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MM_Left_Titles.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.Tabs_20_Recipe.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/Tabs_20_Recipe.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.Tabs_40_Login.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/Tabs_40_Login.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_Axis_PLCOpen_State.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_Axis_PLCOpen_State.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_COMMAND_EXECUTE_ENUM.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_COMMAND_EXECUTE_ENUM.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_COMM_SEVERITIES.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_COMM_SEVERITIES.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_FACILITIES_eNUM.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_FACILITIES_eNUM.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/txtgrp.MAPP_INTERNAL_ERROR_ENUM.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/TextGroups/MAPP_INTERNAL_ERROR_ENUM.txtgrp $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#Text Groups END




# BitmapGroups
BMGRP_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/bmgrp., $(notdir $(BMGRP_SOURCES_Visup:.bmgrp=.vco)))

$(TEMP_PATH_Visup)/bmgrp.Pads.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/Pads.bmgrp
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bmgrp.MM_Left_Bmaps_sel.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MM_Left_Bmaps_sel.bmgrp
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bmgrp.MpAlarmAcknowledgeState.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpAlarmAcknowledgeState.bmgrp
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bmgrp.MpBorders.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpBorders.bmgrp
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bmgrp.MpComSeveritiesEnum.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpComSeveritiesEnum.bmgrp
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bmgrp.MpFileIcons.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpFileIcons.bmgrp
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bmgrp.MpPads.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/BitmapGroups/MpPads.bmgrp
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#BitmapGroups END




# Bitmaps
BMINFO_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/bminfo., $(notdir $(BMINFO_SOURCES_Visup:.bminfo=.vco)))

$(TEMP_PATH_Visup)/bminfo.HAS_alertmsg_border.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_alertmsg_border.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_alertmsg_border.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.HAS_border_nav_listviewbox_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_border_nav_listviewbox_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_border_nav_listviewbox_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.HAS_dialog_check.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_dialog_check.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_dialog_check.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.HAS_dialog_x.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_dialog_x.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_dialog_x.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.HAS_down_1_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_down_1_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_down_1_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.HAS_down_2_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_down_2_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_down_2_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.HAS_pvlistview_box.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_pvlistview_box.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_pvlistview_box.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.HAS_up_1_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_up_1_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_up_1_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.HAS_up_2_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_up_2_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/HAS_up_2_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_AlphaPad_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_AlphaPad_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_AlphaPad_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_AlphaPad_pressed_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_AlphaPad_pressed_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_AlphaPad_pressed_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_EditPad.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_EditPad.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_EditPad.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_EditPad_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_EditPad_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_EditPad_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_ListPadHor.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadHor.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadHor.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_ListPadHor_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadHor_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadHor_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_ListPadVer.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadVer.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadVer.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_ListPadVer_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadVer_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_ListPadVer_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_NumPadLimits_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPadLimits_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPadLimits_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_NumPadLimits_pressed_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPadLimits_pressed_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPadLimits_pressed_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_NumPad_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_NumPad_Large_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_Large_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_Large_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_NumPad_pressed_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_pressed_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_pressed_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Key_NumPad_pressed_Large_0.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_pressed_Large_0.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Key_NumPad_pressed_Large_0.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpAlarm_AcknowledgeReset.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_AcknowledgeReset.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_AcknowledgeReset.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpAlarm_NotQuit.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_NotQuit.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_NotQuit.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpAlarm_Quit.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_Quit.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_Quit.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpAlarm_ResetAcknowledge.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_ResetAcknowledge.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpAlarm_ResetAcknowledge.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpBorderSlider09x09.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpBorderSlider09x09.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpBorderSlider09x09.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_control.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_control.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_control.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_control_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_control_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_control_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_decrease.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_decrease.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_decrease.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_decrease_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_decrease_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_decrease_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_default.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_default.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_default.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_default_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_default_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_default_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_device_selected_left.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_device_selected_left.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_device_selected_left.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_device_unselected_left.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_device_unselected_left.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_device_unselected_left.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_error.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_error.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_error.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_global_area.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_global_area_bottom1.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_bottom1.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_bottom1.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_global_area_bottom.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_bottom.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_bottom.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_global_area_left.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_left.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_left.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_global_area_pres_bottom.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_pres_bottom.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_pres_bottom.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_global_area_press_left.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_press_left.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_press_left.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_global_area_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_global_area_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_increase.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_increase.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_increase.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_increase_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_increase_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_increase_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_off.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_off.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_off.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_on.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_on.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_on.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_radio_selected.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_radio_selected.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_radio_selected.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_radio_unselected.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_radio_unselected.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_radio_unselected.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_ready.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_ready.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_ready.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_down.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_down_multi.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_multi.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_multi.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_down_multi_press.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_multi_press.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_multi_press.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_down_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_down_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_left.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_left.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_left.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_left_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_left_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_left_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_right.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_right.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_right.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_right_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_right_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_right_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_up.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_up_multi.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_multi.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_multi.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_up_multi_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_multi_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_multi_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpButton_scroll_up_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpButton_scroll_up_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpCheckbox_small.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpCheckbox_small_checked.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small_checked.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small_checked.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpCheckbox_small_gray.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small_gray.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpCheckbox_small_gray.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpComLoggerAlarm.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerAlarm.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerAlarm.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpComLoggerInformation.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerInformation.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerInformation.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpComLoggerWarning.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerWarning.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpComLoggerWarning.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_ArrowLeft.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowLeft.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowLeft.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_ArrowRight.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowRight.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowRight.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_ArrowUp.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowUp.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_ArrowUp.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_BMP.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_BMP.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_BMP.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_CSV.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_CSV.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_CSV.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_DOC.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_DOC.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_DOC.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_FILE.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_FILE.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_FILE.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_FOLDER.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_FOLDER.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_FOLDER.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_HTML.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_HTML.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_HTML.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_JPG.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_JPG.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_JPG.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_TXT.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_TXT.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_TXT.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_XLS.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_XLS.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_XLS.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFile_XML.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_XML.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFile_XML.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFrameHeader.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFrameHeader.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFrameHeader.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpFrameInvisible.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFrameInvisible.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpFrameInvisible.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpGroupControl.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpGroupControl.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpGroupControl.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpInputBorderCenterless.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderCenterless.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderCenterless.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpInputBorderInactiveCenterless.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderInactiveCenterless.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderInactiveCenterless.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpInputBorderInactive.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderInactive.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorderInactive.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpInputBorder.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorder.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpInputBorder.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_AlphaPad_lowerPressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_lowerPressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_lowerPressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_AlphaPad_lower.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_lower.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_lower.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_AlphaPad_numeric2Pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric2Pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric2Pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_AlphaPad_numeric2.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric2.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric2.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_AlphaPad_numericPressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numericPressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numericPressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_AlphaPad_numeric.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_numeric.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_AlphaPad_upperPressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_upperPressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_upperPressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_AlphaPad_upper.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_upper.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_AlphaPad_upper.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_EditPad_lowerPressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_lowerPressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_lowerPressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_EditPad_lower.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_lower.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_lower.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_EditPad_numeric2Pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric2Pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric2Pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_EditPad_numeric2.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric2.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric2.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_EditPad_numericPressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numericPressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numericPressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_EditPad_numeric.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_numeric.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_EditPad_upperPressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_upperPressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_upperPressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_EditPad_upper.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_upper.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_EditPad_upper.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_ListPadHor.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadHor.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadHor.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_ListPadHor_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadHor_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadHor_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_ListPadVer.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadVer.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadVer.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_ListPadVer_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadVer_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_ListPadVer_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_Numpad.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_Numpad.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_Numpad.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpKey_Numpad_pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_Numpad_pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpKey_Numpad_pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpLabelBorderDown.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorderDown.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorderDown.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpLabelBorderLeft.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorderLeft.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorderLeft.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpLabelBorder.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorder.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpLabelBorder.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpMpFile_ArrowDown.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpMpFile_ArrowDown.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpMpFile_ArrowDown.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpOutputBorder.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpOutputBorder.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpOutputBorder.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.MpProgressBorder.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpProgressBorder.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/MpProgressBorder.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Panel_BLK_114x220.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_BLK_114x220.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_BLK_114x220.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Panel_BLU_114x220.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_BLU_114x220.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_BLU_114x220.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Panel_GRN_114x221.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_GRN_114x221.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_GRN_114x221.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.Panel_RED_114x221.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_RED_114x221.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/Panel_RED_114x221.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.checkbox_small.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/checkbox_small.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/checkbox_small.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.checkbox_small_checked.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/checkbox_small_checked.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/checkbox_small_checked.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.logoMarketingAllianceInc.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/logoMarketingAllianceInc.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/logoMarketingAllianceInc.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.nav_Diagnostics_64x64_Pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Diagnostics_64x64_Pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Diagnostics_64x64_Pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.nav_Engineer_64x64_Pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Engineer_64x64_Pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Engineer_64x64_Pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.nav_Gears_64x64_Pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Gears_64x64_Pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Gears_64x64_Pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.nav_Home_64x64_Pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Home_64x64_Pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Home_64x64_Pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.nav_Recipe_64x64_Pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Recipe_64x64_Pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Recipe_64x64_Pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/bminfo.nav_Security_64x64_Pressed.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Security_64x64_Pressed.bminfo $(AS_PROJECT_PATH)/Logical/HMI/Visup/Bitmaps/nav_Security_64x64_Pressed.png
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#Bitmaps END




# Trend Data Configuration
TDC_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/tdc., $(notdir $(TDC_SOURCES_Visup:.tdc=.vco)))

$(TEMP_PATH_Visup)/tdc.TrendData.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/Trends/TrendData.tdc
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#Trend Data Configuration END




# ColorMap Table
CLM_OBJECTS_Visup = $(addprefix $(TEMP_PATH_Visup)/clm., $(notdir $(CLM_SOURCES_Visup:.clm=.vco)))

$(TEMP_PATH_Visup)/clm.Header_Tab_Sel_Txt.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/Header_Tab_Sel_Txt.clm
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/clm.MAPP_Read_Valid.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/MAPP_Read_Valid.clm
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/clm.MSG_Alert_Text.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/MSG_Alert_Text.clm
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/clm.Motion_Button.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/Motion_Button.clm
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/clm.Sensor_0_White_1_Grn.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/Sensor_0_White_1_Grn.clm
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/clm.Sensor_0_White_1_Red.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/Sensor_0_White_1_Red.clm
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/clm.cmpAriesUIIndicator.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/cmpAriesUIIndicator.clm
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


$(TEMP_PATH_Visup)/clm.cmpAriesBoardFeedingLamp.vco: $(AS_PROJECT_PATH)/Logical/HMI/Visup/ColorMaps/cmpAriesBoardFeedingLamp.clm
	 $(VCC) -f "$<" -o "$@" -l "$(AS_PROJECT_PATH)/Logical/VCShared/Languages.vcr" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -pal "$(PALFILE_Visup)" $(VCCFLAGS_Visup)  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas


#ColorMap Table END


#
# Borders
#
BDR_SOURCES_Visup=$(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Flat_grey.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Sunken.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/AS_border_AlertMessage.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/AS_border_nav.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Flat_black.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Flat_grey.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/HAS_pvlistviewbox_border.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Control_pressed.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Device_Select_Left.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Device_Unselect_Left.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Multi_Scroll_Down.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Multi_Scroll_Dwn_press.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Multi_Scroll_Up.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Multi_Scroll_Up_press.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scoll_Up.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scoll_Up_pressed.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Down.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Down_pressed.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Left.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Left_pressed.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Right.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_Scroll_Right_pressed.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_Button_pressed.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_FrameInvisible.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_InputBorder.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_OutputBorder.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_SliderBorder09.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Mp_TabActive.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Panel_BLK.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Panel_BLU.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Panel_GRN.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Panel_RED.bdr $(AS_PROJECT_PATH)/Logical/HMI/Visup/Borders/Raised.bdr 
BDR_OBJECTS_Visup=$(TEMP_PATH_Visup)/bdr.Bordermanager.vco
$(TEMP_PATH_Visup)/bdr.Bordermanager.vco: $(BDR_SOURCES_Visup)
	$(VCC) -f "$<" -o "$@" -pkg "$(SRC_PATH_Visup)" $(BDRFLAGS_Visup) $(VCCFLAGS_Visup) -p Visup$(SRC_PATH_Visup)
#
# Logical fonts
#
$(TEMP_PATH_Visup)/lfnt.de.vco: $(TEMP_PATH_Visup)/de.lfnt $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" $(LFNTFLAGS_Visup) $(VCCFLAGS_Visup) -p Visup -sfas
$(TEMP_PATH_Visup)/lfnt.en.vco: $(TEMP_PATH_Visup)/en.lfnt $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" $(LFNTFLAGS_Visup) $(VCCFLAGS_Visup) -p Visup -sfas
$(TEMP_PATH_Visup)/lfnt.pt.vco: $(TEMP_PATH_Visup)/pt.lfnt $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" $(LFNTFLAGS_Visup) $(VCCFLAGS_Visup) -p Visup -sfas
$(TEMP_PATH_Visup)/lfnt.es.vco: $(TEMP_PATH_Visup)/es.lfnt $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" $(LFNTFLAGS_Visup) $(VCCFLAGS_Visup) -p Visup -sfas
$(TEMP_PATH_Visup)/lfnt.sv.vco: $(TEMP_PATH_Visup)/sv.lfnt $(VC_LANGUAGES_Visup)
	 $(VCC) -f "$<" -o "$@" $(LFNTFLAGS_Visup) $(VCCFLAGS_Visup) -p Visup -sfas
LFNT_OBJECTS_Visup=$(TEMP_PATH_Visup)/lfnt.de.vco $(TEMP_PATH_Visup)/lfnt.en.vco $(TEMP_PATH_Visup)/lfnt.pt.vco $(TEMP_PATH_Visup)/lfnt.es.vco $(TEMP_PATH_Visup)/lfnt.sv.vco 

#Runtime Object
$(VCR_OBJECT_Visup) : $(VCR_SOURCE_Visup)
	$(VCC) -f "$<" -o "$@" -cv "$(AS_PROJECT_PATH)/Logical/VCShared/ControlVersion.cvinfo" -sl en $(VCCFLAGS_Visup) -rt  -p Visup -so $(VC_STATIC_OPTIONS_Visup) -vcr 4263 -sfas
# Local resources Library rules
LIB_LOCAL_RES_Visup=$(TEMP_PATH_Visup)/localres.vca
$(LIB_LOCAL_RES_Visup) : $(TEMP_PATH_Visup)/Visup02.ccf

# Bitmap Library rules
LIB_BMP_RES_Visup=$(TEMP_PATH_Visup)/bmpres.vca
$(LIB_BMP_RES_Visup) : $(TEMP_PATH_Visup)/Visup03.ccf
$(BMGRP_OBJECTS_Visup) : $(PALFILE_Visup) $(VC_LANGUAGES_Visup)
$(BMINFO_OBJECTS_Visup) : $(PALFILE_Visup)

BUILD_FILE_Visup=$(TEMP_PATH_Visup)/BuildFiles.arg
$(BUILD_FILE_Visup) : BUILD_FILE_CLEAN_Visup $(BUILD_SOURCES_Visup)
BUILD_FILE_CLEAN_Visup:
	$(RM) /F /Q "$(BUILD_FILE_Visup)" 2>nul
#All Modules depending to this project
PROJECT_MODULES_Visup=$(AS_CPU_PATH)/Visup01.br $(AS_CPU_PATH)/Visup02.br $(AS_CPU_PATH)/Visup03.br $(FONT_MODULES_Visup) $(SHARED_MODULE)

# General Build rules

$(TARGET_FILE_Visup): $(PROJECT_MODULES_Visup) $(TEMP_PATH_Visup)/Visup.prj
	$(MODGEN) -so $(VC_STATIC_OPTIONS_Visup) -fw "$(VCFIRMWAREPATH)" -m $(VCSTPOST) -v V1.00.0 -f "$(TEMP_PATH_Visup)/Visup.prj" -o "$@" -vc "$(VCOBJECT_Visup)" $(DEPENDENCIES_Visup) $(addprefix -d ,$(notdir $(PROJECT_MODULES_Visup:.br=)))

$(AS_CPU_PATH)/Visup01.br: $(TEMP_PATH_Visup)/Visup01.ccf
	$(MODGEN) -so $(VC_STATIC_OPTIONS_Visup) -fw "$(VCFIRMWAREPATH)" -m $(VCLOD) -v V1.00.0 -b -vc "$(VCOBJECT_Visup)" -f "$<" -o "$@" $(DEPENDENCIES_Visup)

$(AS_CPU_PATH)/Visup02.br: $(TEMP_PATH_Visup)/Visup02.ccf
	$(MODGEN) -so $(VC_STATIC_OPTIONS_Visup) -fw "$(VCFIRMWAREPATH)" -m $(VCLOD) -v V1.00.0 -b -vc "$(VCOBJECT_Visup)" -f "$<" -o "$@" $(DEPENDENCIES_Visup)

$(AS_CPU_PATH)/Visup03.br: $(TEMP_PATH_Visup)/Visup03.ccf
	$(MODGEN) -so $(VC_STATIC_OPTIONS_Visup) -fw "$(VCFIRMWAREPATH)" -m $(VCLOD) -v V1.00.0 -b -vc "$(VCOBJECT_Visup)" -f "$<" -o "$@" $(DEPENDENCIES_Visup)

# General Build rules END
$(LIB_LOCAL_OBJ_Visup) : $(TEMP_PATH_Visup)/Visup01.ccf

# Main Module
$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/VCShared/Visup.vcm:
$(TEMP_PATH_Visup)/Visup.prj: $(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/VCShared/Visup.vcm
	$(VCDEP) -m "$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/VCShared/Visup.vcm" -s "$(AS_CPU_PATH)/VCShared/Shared.vcm" -p "$(AS_PATH)/AS/VC/Firmware" -c "$(AS_CPU_PATH)" -fw "$(VCFIRMWAREPATH)" -hw "$(CPUHWC)" -so $(VC_STATIC_OPTIONS_Visup) -o Visup -proj Visup
	$(VCPL) $(notdir $(PROJECT_MODULES_Visup:.br=,4)) Visup,2 -o "$@" -p Visup -vc "Visup" -verbose "False" -fl "$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/VCShared/Visup.vcm" -vcr "$(VCR_SOURCE_Visup)" -prj "$(AS_PROJECT_PATH)" -warningLevel2 -sfas
	$(VCREFHANDLER) -X "C:/Users/Admin/Desktop/MarketingAlliance_Aries_Merge/software/AriesV2/Temp/Objects/Config_Deployment/X20CP1382/vcxref.build" -o "$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/" -verbose "False" -profile "False" -ds "$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/VCShared/dpt.DataPointList.vcxref" -warninglevel 2 -sfas
	$(VCXREFEXTENDER) "$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/Visup/Visup.xrefvc" -o "$(TEMP_PATH_ROOT_Visup)/Objects/$(AS_CONFIGURATION)/$(AS_TEMP_PLC)/Visup.xref" -P "$(AS_PROJECT_PATH)/" -c "$(AS_CONFIGURATION)" -S "$(AS_PLC)" -t "$(AS_TEMP_PATH)" 

# 01 Module

DEL_TARGET01_LFL_Visup=$(TEMP_PATH_Visup)\Visup01.ccf.lfl
$(TEMP_PATH_Visup)/Visup01.ccf: $(LIB_SHARED) $(SHARED_CCF) $(LIB_BMP_RES_Visup) $(TEMP_PATH_Visup)/Visup03.ccf $(LIB_LOCAL_RES_Visup) $(TEMP_PATH_Visup)/Visup02.ccf $(DIS_OBJECTS_Visup) $(PAGE_OBJECTS_Visup) $(VCS_OBJECTS_Visup) $(VCVK_OBJECTS_Visup) $(VCRT_OBJECTS_Visup) $(TPR_OBJECTS_Visup) $(TXTGRP_OBJECTS_Visup) $(LAYER_OBJECTS_Visup) $(VCR_OBJECT_Visup) $(TDC_OBJECTS_Visup) $(TRD_OBJECTS_Visup) $(TRE_OBJECTS_Visup) $(PRC_OBJECTS_Visup) $(SCR_OBJECTS_Visup)
	-@CMD /Q /C if exist "$(DEL_TARGET01_LFL_Visup)" DEL /F /Q "$(DEL_TARGET01_LFL_Visup)" 2>nul
	@$(VCFLGEN) "$@.lfl" "$(LIB_SHARED)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(LIB_BMP_RES_Visup)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(LIB_LOCAL_RES_Visup)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(DIS_OBJECTS_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" -mask .page -vcp "$(AS_PROJECT_PATH)/Logical/HMI/Visup/Package.vcp" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(VCS_OBJECTS_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" -mask .vcvk -vcp "$(AS_PROJECT_PATH)/Logical/HMI/Visup/Package.vcp" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(VCRT_OBJECTS_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(TPR_OBJECTS_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" -mask .txtgrp -vcp "$(AS_PROJECT_PATH)/Logical/HMI/Visup/Package.vcp" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" -mask .layer -vcp "$(AS_PROJECT_PATH)/Logical/HMI/Visup/Package.vcp" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(VCR_OBJECT_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" -mask .tdc -vcp "$(AS_PROJECT_PATH)/Logical/HMI/Visup/Package.vcp" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" -mask .trd -vcp "$(AS_PROJECT_PATH)/Logical/HMI/Visup/Package.vcp" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(SCR_OBJECTS_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	$(LINK) "$@.lfl" -o "$@" -p Visup -lib "$(LIB_LOCAL_OBJ_Visup)" -P "$(AS_PROJECT_PATH)" -m "local objects" -profile "False" -warningLevel2 -vcr 4263 -sfas
# 01 Module END

# 02 Module

DEL_TARGET02_LFL_Visup=$(TEMP_PATH_Visup)\Visup02.ccf.lfl
$(TEMP_PATH_Visup)/Visup02.ccf: $(LIB_SHARED) $(SHARED_CCF) $(LIB_BMP_RES_Visup) $(TEMP_PATH_Visup)/Visup03.ccf $(BDR_OBJECTS_Visup) $(LFNT_OBJECTS_Visup) $(CLM_OBJECTS_Visup)
	-@CMD /Q /C if exist "$(DEL_TARGET02_LFL_Visup)" DEL /F /Q "$(DEL_TARGET02_LFL_Visup)" 2>nul
	@$(VCFLGEN) "$@.lfl" "$(LIB_SHARED)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(LIB_BMP_RES_Visup)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(BDR_OBJECTS_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(LFNT_OBJECTS_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" "$(CLM_OBJECTS_Visup:.vco=.vco|)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	$(LINK) "$@.lfl" -o "$@" -p Visup -lib "$(LIB_LOCAL_RES_Visup)" -P "$(AS_PROJECT_PATH)" -m "local resources" -profile "False" -warningLevel2 -vcr 4263 -sfas
# 02 Module END

# 03 Module

DEL_TARGET03_LFL_Visup=$(TEMP_PATH_Visup)\Visup03.ccf.lfl
$(TEMP_PATH_Visup)/Visup03.ccf: $(LIB_SHARED) $(SHARED_CCF) $(BMGRP_OBJECTS_Visup) $(BMINFO_OBJECTS_Visup) $(PALFILE_Visup)
	-@CMD /Q /C if exist "$(DEL_TARGET03_LFL_Visup)" DEL /F /Q "$(DEL_TARGET03_LFL_Visup)" 2>nul
	@$(VCFLGEN) "$@.lfl" "$(LIB_SHARED)" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" -mask .bmgrp -vcp "$(AS_PROJECT_PATH)/Logical/HMI/Visup/Package.vcp" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	@$(VCFLGEN) "$@.lfl" -mask .bminfo -vcp "$(AS_PROJECT_PATH)/Logical/HMI/Visup/Package.vcp" -temp "$(TEMP_PATH_Visup)" -prj "$(PRJ_PATH_Visup)" -sfas
	$(LINK) "$@.lfl" -o "$@" -p Visup -lib "$(LIB_BMP_RES_Visup)" -P "$(AS_PROJECT_PATH)" -m "bitmap resources" -profile "False" -warningLevel2 -vcr 4263 -sfas
# 03 Module END

