PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Messages
============================================================================

-
-
-" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="closed" name="gMachineIO.dout.CaseTurnerLower_SOL2B"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_ZERO_CASETURNER]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="closed" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_ZERO_ROWPUSHER]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="closed" name="gCtrl.rowforming.allBladesDown"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_ZERO_BLADESTOP]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="closed" name="gCtrl.transfertable.isTableAtGrouping"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_ZERO_TABLE]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="closed" name="gCtrl.palletDispenser.atTop"/>
			<contact type="open" name="gCtrl.palletDispenser.palletDispenserEquipped"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_ZERO_PALLETELIFT]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="closed" name="gCtrl.elevator.elevatorIsAtHome"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_ZERO_ELEVATOR]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="closed" name="gCtrl.retainerbar.barIsUp"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_ZERO_RETAINERBAR]"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.zeroIsNeeded"/>
			<contact type="open" name="gCtrl.squaring.hmiBtnSidePlatesExtRet"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_ZERO_SQUARING]"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.squaring.hmiBtnFrontPlateExtRet" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.ElevatorStopBlockLF_PR33"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_STOP_BLOCK_LF]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.ElevatorStopBlockRT_PR34"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_STOP_BLOCK_RT]"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gMachineVFD[11].vfdCtrl.iMoveFwd"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMessages.msgActive[APP_MSG_PALLETE_EXITING]"/>
		</row>
	</network>
</networks>
END_PROGRAM




















