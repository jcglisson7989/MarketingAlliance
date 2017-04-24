PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Alarms
============================================================================
Alarm 0 - see HWModule fault detection
-
-
-" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.Guard_DS1"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_DS1]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.Guard_DS2"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_DS2]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.Guard_DS3"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_DS3]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.Guard_DS4"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_DS4]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.Guard_DS5"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_DS5]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.Guard_DS6"/>
			<contact type="open" name="FALSE"/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_DS6]"/>
		</row>
	</network>
	<network label="" comment="============================================================================
E-Stop Alarms
===" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.EStop_PB1"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ESTOP1]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.EStop_PB2"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ESTOP2]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.EStop_PB3"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ESTOP3]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.EStop_PB4"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ESTOP4]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.EStop_PB5"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ESTOP5]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.EStop_PB6"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ESTOP6]"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Motor OL
===" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.MotorOverloads_OL"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_MOTOROL]"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
MCR
===" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.MCR"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_MCR]"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Air
===" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.AirPressureSwitch_APS"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_AIRPRESSURE]"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Chain Slack
===" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.ElevatorChainSlackLF_LS7"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ELEV_CHAINSLACK_LF]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.ElevatorChainSlackRT_LS8"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ELEV_CHAINSLACK_RT]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.palletDispenserEquipped"/>
			<contact type="closed" name="gMachineIO.din.PalletDispenserChainSlack_PR21"/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ELEV_PALLETDISPENS]"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
VFD
===" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.VFDsNoFaults"/>
			<line/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_VFD]"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Alarm Ack Needed
===" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gAlarms.oIsAlarmActive"/>
			<contact type="open" name="gAlarms.oIsAlarmNotAck"/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ALARMACKNEEDED]"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Light Curtains" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.PalleteDischLightCurtain_OSSD1"/>
			<contact type="closed" name="gCtrl.palletDischarge.muteLightCurtainDuringDischarge"/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_LIGHT_CURTAIN_OSSD1]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.PalleteDischLightCurtain_OSSD2"/>
			<contact type="closed" name="gCtrl.palletDischarge.muteLightCurtainDuringDischarge"/>
			<line/>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_LIGHT_CURTAIN_OSSD2]"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Jam Alarm - Case Infeed EE2" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.infeedcv.tmrJamAtCaseInSensorEE2" type="TON"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gCtrl.infeedcv.infeedCvOn"/>
			<contact type="open" name="gMachineIO.din.ProductAtInfeed_EE2"/>
			<line/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_INFEED_JAM]"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.JamAlarmTmAtInfeedEE2"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Jam Alarm - Row Too Long EE8" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.infeedcv.tmrJamAtCaseOutSensorEE8" type="TON"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gMachineIO.din.RowTooLong_EE8"/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ROW_TOO_LONG]"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.JamAlarmTmAtRowToLongEE8"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Pallet Program Not Loaded" row="6" column="0" commented="0">
		<row>
			<analog type="input" name="gPallete.palCfgLayers[0].palCfgRows[0].palCfgCmds[0].cmdCase"/>
			<function position="top" type="EQ"><input name="" extensible="true"/><output name="1"/></function>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<function position="top" type="AND"><input name="" extensible="true"/><output name="40"/></function>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_INVALID_PROGRAM]"/>
		</row>
		<row>
			<analog type="input" name="0"/>
			<function position="bottom" type="EQ"><input name="" extensible="true"/></function>
			<analog type="input" name="gPallete.palCfgLayers[0].palCfgRows[0].palCfgCmds[0].cmdBlade"/>
			<function position="top" type="EQ"><input name="" extensible="true"/><output name="1"/></function>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<function position="middle" type="AND"><input name="" extensible="true"/></function>
			<empty/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty/>
			<analog type="input" name="0"/>
			<function position="bottom" type="EQ"><input name="" extensible="true"/></function>
			<analog type="input" name="gPallete.palCfgLayers[0].palCfgRows[0].palCfgCmds[0].cmdFeature"/>
			<function position="top" type="EQ"><input name="" extensible="true"/><output name="1"/></function>
			<line/>
			<line/>
			<line/>
			<function position="middle" type="AND"><input name="" extensible="true"/></function>
			<empty/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<analog type="input" name="0"/>
			<function position="bottom" type="EQ"><input name="" extensible="true"/></function>
			<analog type="input" name="gPallete.palCfgLayers[0].palCfgRows[0].palCfgCmds[0].cmdExtra"/>
			<function position="top" type="EQ"><input name="" extensible="true"/><output name="1"/></function>
			<function position="middle" type="AND"><input name="" extensible="true"/></function>
			<empty/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<analog type="input" name="0"/>
			<function position="bottom" type="EQ"><input name="" extensible="true"/></function>
			<function position="middle" type="AND"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<function position="bottom" type="AND"><input name="" extensible="true"/></function>
			<empty/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Pallet Exiting timeout alarm" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.palletDischarge.palleteExitTmoutTmr" type="TON"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gMachineVFD[11].vfdCtrl.iMoveFwd"/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_PALLET_EXIT_TIMEOUT]"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.palletExitAlarmTm"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Row forming jam alarm. When case passes by EE2 but does exits by EE8. Section between EE2 and EE8 is called 'OneCaseOnlySection'" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.infeedcv.tmrJamRowForming" type="TON"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gMachineVFD[5].vfdCtrl.iMoveFwd"/>
			<contact type="open" name="gMachineVFD[6].vfdCtrl.iMoveFwd"/>
			<contact type="open" name="gCtrl.infeedcv.caseAtOneCaseOnlySection"/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gAlarms.alarmActive[APP_ALARM_ROW_FORMING_JAM]"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.JamAlarmTmRowForming"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="13" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.btnFaultAck"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[0].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[1].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[2].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[3].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[4].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[5].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[6].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[7].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[8].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[9].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[10].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[11].vfdOut.Control.FaultReset"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[12].vfdOut.Control.FaultReset"/>
		</row>
	</network>
</networks>
END_PROGRAM




























