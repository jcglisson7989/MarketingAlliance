PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Set point for the pusher move velocity." row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.vfd[12].velocity_rpm"/>
			<function position="topbottom" type="DINT_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gMachineVFD[12].vfdCtrl.iVelocitySetPoint"/>
		</row>
	</network>
	<network label="" comment="VFD Enable control" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[12].vfdCtrl.iEnable"/>
		</row>
	</network>
	<network label="" comment="Move/Jog FWD" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd"/>
			<line/>
			<coil type="open" name="gMachineVFD[12].vfdCtrl.iMoveFwd"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwdJog"/>
			<contact type="closed" name="gMachineIO.din.PalletAtDischarge_EE16" or="true"/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Move/Jog REV" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVRev"/>
			<line/>
			<coil type="open" name="gMachineVFD[12].vfdCtrl.iMoveRev"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVRevJog" or="true"/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="===============================================================================
Reset Move Commands" row="4" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVRevJog"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwdJog" or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVRev"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.btnStop" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="===============================================================================
Pallet Discharge Logic" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.palletDischarge.dischargePESensorTmrOf" type="TOF"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gMachineIO.din.PalletAtDischarge_EE16"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TOF"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gCtrl.palletDischarge.dischargePESensor"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.EE16OfDebounce"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TOF"><input name="PT"/><output name="ET"/></functionblock>
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
	<network label="" comment="Discharge CV stop time delay" row="5" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.palletDischarge.dischargeTmr" type="TON"/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDischarge.dischargePESensor"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwd"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.onDlyPalleteDischargeEE16"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty or="true"/>
			<coil type="reset" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd"/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<coil type="reset" name="gCtrl.elevator.hmiBtnElevatorToAbovePallete"/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<coil type="reset" name="gCtrl.palletDischarge.palletManualExitRequest"/>
		</row>
	</network>
	<network label="" comment="Reset discharge CV moves is Eleveator moves." row="4" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorFwd"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwd"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorFwdJog" or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorRev" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorRevJog" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Signal for pallet discharge state machine when exiting pallet is allowed;
Pallet is allowed to exit when:
-elevator is at the top
-or the elevator is above the pallet(i.e. Pallet EE is clear) and the manual pallet request has not been set (i.e. event [2])" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="closed" name="gCtrl.palletDischarge.dischargePESensor"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtTop"/>
			<line/>
			<coil type="open" name="gCtrl.palletDischarge.isDischargeAllowed"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<contact type="closed" name="gCtrl.elevator.tmrPalletePEOff.Q"/>
			<contact type="closed" name="gPallete.ctrlProc.ssmLayer.event[2]" or="true"/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Pallet discharge complete signal. Used by the pallet discharge state machine" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="closed" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd"/>
			<line/>
			<coil type="open" name="gCtrl.palletDischarge.dischargeDN"/>
		</row>
	</network>
	<network label="" comment="=====================================================================================
Mute Light Curtain During Pallet Discharge; Time delay at the end of the move before LC is enabled again. In case of LC violation during e-stop, a 60 sec allows recovery." row="4" column="0" commented="0">
		<row>
			<empty/>
			<functionblock position="header" name="gCtrl.palletDischarge.dischargeMuteTmr" type="TOF"/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd"/>
			<functionblock position="top" type="TOF"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<coil type="open" name="gCtrl.palletDischarge.muteLightCurtainDuringDischarge"/>
		</row>
		<row>
			<analog type="input" name="T#5s"/>
			<functionblock position="bottom" type="TOF"><input name="PT"/><output name="ET"/></functionblock>
			<empty or="true"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDischarge.dischargeRecoveryIP"/>
			<line/>
			<line/>
			<line or="true"/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="3" column="0" commented="0">
		<row>
			<empty/>
			<functionblock position="header" name="gCtrl.palletDischarge.dischargeMuteRecoveryTmr" type="TON"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDischarge.dischargeRecoveryIP"/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="reset" name="gCtrl.palletDischarge.dischargeRecoveryIP"/>
		</row>
		<row>
			<analog type="input" name="T#60s"/>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
	</network>
	<network label="" comment="Changed logic on 9/21/2016 - mute button visible wo. login " row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.PalleteDischLightCurtain_OSSD1"/>
			<contact type="open" name="gMachineIO.din.PalleteDischLightCurtain_OSSD2"/>
			<line/>
			<coil type="open" name="gCtrl.palletDischarge.dischargeRecoveryVisible2"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.palletDischarge.dischargeRecoveryIP"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDischarge.dischargeRecoveryVisible2"/>
			<function position="topbottom" type="BOOL_TO_UINT"><input name="IN"/><output name="6"/></function>
			<analog type="output" name="gCtrl.palletDischarge.dischargeRecoveryVisible"/>
		</row>
	</network>
	<network label="" comment="=============================================================================================
Manual pallet exit request
When button pressed, request flaf is latched
If discharge EE16 and pallet EE1 sensor are both clear, exit and discharge CV-s are turned ON
The request is reset either by the EE16 or by pressing again at the same HMI button" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gCtrl.palletDischarge.hmiBtnPalletManualExit"/>
			<contact type="closed" name="gCtrl.palletDischarge.palletManualExitRequest"/>
			<coil type="set" name="gCtrl.palletDischarge.palletManualExitRequest"/>
		</row>
	</network>
	<network label="" comment="" row="4" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.btnZero"/>
			<contact type="open" name="gCtrl.palletDischarge.palletManualExitRequest"/>
			<line/>
			<coil type="reset" name="gCtrl.palletDischarge.palletManualExitRequest"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.btnStop" or="true"/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwd"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.elevator.hmiBtnElevatorToAbovePallete"/>
		</row>
	</network>
	<network label="" comment="If EE1 is covered, CV-s SHALL NOT move hence request Elevator to go above the pallet." row="3" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gCtrl.palletDischarge.palletManualExitRequest"/>
			<contact type="closed" name="gCtrl.elevator.tmrPalletePEOff.Q"/>
			<contact type="closed" name="gCtrl.palletDischarge.dischargePESensor"/>
			<coil type="set" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwd"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<empty/>
			<empty or="true"/>
			<coil type="set" name="gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<contact type="open" name="gCtrl.palletDischarge.dischargePESensor"/>
			<line/>
			<coil type="set" name="gCtrl.elevator.hmiBtnElevatorToAbovePallete"/>
		</row>
	</network>
</networks>
END_PROGRAM




























