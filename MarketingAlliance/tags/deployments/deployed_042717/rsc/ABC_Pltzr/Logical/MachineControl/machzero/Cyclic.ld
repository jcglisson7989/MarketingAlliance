PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.dout.BladeStop1Dw_SOL3B"/>
			<contact type="open" name="gMachineIO.dout.BladeStop2Dw_SOL4B"/>
			<contact type="open" name="gMachineIO.dout.BladeStop3Dw_SOL5B"/>
			<contact type="open" name="gMachineIO.dout.BladeStop4Dw_SOL6B"/>
			<contact type="open" name="gMachineIO.dout.BladeStop5Dw_SOL13B"/>
			<contact type="open" name="gMachineIO.dout.BladeStop6Dw_SOL14B"/>
			<coil type="open" name="gCtrl.rowforming.allBladesDown"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.rowforming.isStopBladeUsed1" or="true"/>
			<contact type="closed" name="gCtrl.rowforming.isStopBladeUsed2" or="true"/>
			<contact type="closed" name="gCtrl.rowforming.isStopBladeUsed3" or="true"/>
			<contact type="closed" name="gCtrl.rowforming.isStopBladeUsed4" or="true"/>
			<contact type="closed" name="gCtrl.rowforming.isStopBladeUsed5" or="true"/>
			<contact type="closed" name="gCtrl.rowforming.isStopBladeUsed6" or="true"/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.dout.CaseTurnerLower_SOL2B"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.allBladesDown"/>
			<contact type="open" name="gCtrl.transfertable.isTableAtGrouping"/>
			<contact type="open" name="gCtrl.palletDispenser.atTop"/>
			<contact type="open" name="gCtrl.retainerbar.barIsUp"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtHome"/>
			<contact type="closed" name="gCtrl.squaring.hmiBtnSidePlatesExtRet"/>
			<contact type="closed" name="gCtrl.squaring.hmiBtnFrontPlateExtRet"/>
			<coil type="open" name="gCtrl.main.isAtZero"/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<contact type="closed" name="gCtrl.palletDispenser.palletDispenserEquipped" or="true"/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<contact type="closed" name="gCtrl.squaring.frontSquaringEquipped" or="true"/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<coil type="set" name="gCtrl.main.zeroIsNeeded"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.modeManual"/>
			<contact type="closed" name="gCtrl.main.isAtZero" or="true"/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.isAtZero"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.main.zeroIsNeeded"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.modeMaintenance"/>
			<function position="topbottom" type="BOOL_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gCtrl.main.btnStartVisibility"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<function position="topbottom" type="BOOL_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gCtrl.main.btnNotInAutoModeVisibility"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="closed" name="gCtrl.main.modeMaintenance"/>
			<function position="topbottom" type="BOOL_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gCtrl.main.btnZeroVisibility"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<line or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="24" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.isAtZero"/>
			<contact type="open" name="gCtrl.main.btnZero"/>
			<line/>
			<coil type="reset" name="gCtrl.caseturner.hmiBtnCaseTurnerUpDown"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="set" name="gCtrl.rowforming.hmiBtnPusherRev"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDown1"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="set" name="gCtrl.transfertable.hmiBtnTableRev"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="set" name="gCtrl.retainerbar.hmiBtnRetainterBarRev"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="set" name="gCtrl.elevator.hmiBtnElevatorToGrouping"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.hmiBtnClawsLiftToTop"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.squaring.hmiBtnSidePlatesExtRet"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gMessages.msgActive[APP_MSG_PALLETE_COMPLETE]"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDown2"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDown3"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDown4"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDown5"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDown6"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.squaring.hmiBtnFrontPlateExtRet"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick1"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick2"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick3"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick4"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick5"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick6"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.caseturner.hmiAutoCaseTurn"/>
		</row>
	</network>
	<network label="" comment="" row="5" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnPusherRev"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.transfertable.hmiBtnTableRev"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.retainerbar.hmiBtnRetainterBarRev"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.elevator.hmiBtnElevatorToGrouping"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnClawsLiftToTop"/>
		</row>
	</network>
</networks>
END_PROGRAM



































