PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Row forming CV; Don't allow it to move if the row pusher is not home!" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnOnOffCV"/>
			<coil type="open" name="gMachineIO.dout.RowFormingRollers_M5"/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty or="true"/>
			<coil type="open" name="gMachineVFD[5].vfdCtrl.iMoveFwd"/>
		</row>
	</network>
	<network label="" comment="State CV control" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnOnOffStageCV"/>
			<line/>
			<coil type="open" name="gMachineVFD[6].vfdCtrl.iMoveFwd"/>
		</row>
	</network>
	<network label="" comment="Reset requests in case of an error." row="2" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnOnOffStageCV"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnOnOffCV"/>
		</row>
	</network>
	<network label="" comment="VFD Enable control" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<line/>
			<coil type="open" name="gMachineVFD[5].vfdCtrl.iEnable"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[6].vfdCtrl.iEnable"/>
		</row>
	</network>
	<network label="" comment="Set point for the row forming rollers velocity." row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.vfd[5].velocity_rpm"/>
			<function position="topbottom" type="DINT_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gMachineVFD[5].vfdCtrl.iVelocitySetPoint"/>
		</row>
	</network>
	<network label="" comment="Set point for the row staging rollers velocity." row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.vfd[6].velocity_rpm"/>
			<function position="topbottom" type="DINT_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gMachineVFD[6].vfdCtrl.iVelocitySetPoint"/>
		</row>
	</network>
	<network label="" comment="Set point for the pusher move velocity." row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.vfd[4].velocity_rpm"/>
			<function position="topbottom" type="DINT_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gMachineVFD[4].vfdCtrl.iVelocitySetPoint"/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Row pusher IO
===" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.RowPusherAtElevator_PR13"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.rowforming.isRowPusherAtElevator"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.RowPusherReturned_PR11"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
		</row>
	</network>
	<network label="" comment="VFD Enable control" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[4].vfdCtrl.iEnable"/>
		</row>
	</network>
	<network label="" comment="Reset HMI buttons for MOVE" row="3" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtElevator"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnPusherFwd"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gMachineIO.dout.RowPusherForward_M4F"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.btnZero" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Reset HMI buttons for MOVE" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnPusherRev"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gMachineIO.dout.RowPusherReturn_M4R"/>
		</row>
	</network>
	<network label="" comment="Move/Jog FWD" row="5" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnPusherFwdJog"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<contact type="closed" name="gCtrl.rowforming.isRowPusherAtElevator"/>
			<contact type="open" name="gCtrl.retainerbar.barIsUp"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtHome"/>
			<contact type="open" name="gCtrl.rowforming.allBladesDown"/>
			<coil type="open" name="gMachineVFD[4].vfdCtrl.iMoveFwd"/>
		</row>
		<row>
			<empty or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.rowforming.rowPusherOnDly" type="TON" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnPusherFwd"/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<coil type="open" name="gMachineIO.dout.RowPusherForward_M4F"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.dlyRowDoneToRowPush"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
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
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Move/Jog REV" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnPusherRev"/>
			<contact type="closed" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.allBladesDown"/>
			<coil type="open" name="gMachineVFD[4].vfdCtrl.iMoveRev"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnPusherRevJog" or="true"/>
			<empty/>
			<empty or="true"/>
			<coil type="open" name="gMachineIO.dout.RowPusherReturn_M4R"/>
		</row>
	</network>
	<network label="" comment="===================================================================================
Testing only: alows blocking of the elevator moves following layer forming" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.dropLayerToPalletBlock"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.isDropLayerToPalletAllowed"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.modeAuto"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.main.dropLayerToPalletBlock"/>
		</row>
	</network>
</networks>
END_PROGRAM




































