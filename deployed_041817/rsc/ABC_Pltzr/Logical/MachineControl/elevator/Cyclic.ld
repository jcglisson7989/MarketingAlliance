PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="VFD Enable control" row="3" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.SafetyOk"/>
			<contact type="open" name="gCtrl.main.noMinorFault"/>
			<line/>
			<coil type="open" name="gMachineVFD[1].vfdCtrl.iEnable"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="closed" name="gMachineIO.din.ElevatorChainSlackLF_LS7" or="true"/>
			<empty/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="closed" name="gMachineIO.din.ElevatorChainSlackRT_LS8" or="true"/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Reset HMI buttons for MOVE" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtTop"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.elevator.hmiBtnElevatorFwd"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gMachineIO.din.ElevatorChainSlackLF_LS7"/>
			<contact type="open" name="gMachineIO.din.ElevatorChainSlackRT_LS8" or="true"/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Reset HMI buttons for MOVE" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtBottom"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.elevator.hmiBtnElevatorRev"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="=======================================================================================
Move/Jog FWD (Move UP); If chain slack present, allow UP move ONLY if stops blocks are active." row="4" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorFwd"/>
			<line/>
			<contact type="closed" name="gCtrl.elevator.elevatorIsAtTop"/>
			<contact type="closed" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwd"/>
			<contact type="closed" name="gCtrl.rowforming.isRowPusherAtElevator"/>
			<contact type="open" name="gCtrl.transfertable.isTableAtGrouping"/>
			<coil type="open" name="gMachineVFD[1].vfdCtrl.iMoveFwd"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.SafetyOk"/>
			<contact type="open" name="gCtrl.main.noMinorFault"/>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorFwdJog" or="true"/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorFwdJog" or="true"/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="closed" name="gMachineIO.din.ElevatorChainSlackLF_LS7" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="closed" name="gMachineIO.din.ElevatorChainSlackRT_LS8" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Move/Jog REV (Move DOWN); When stop blocks are active, elevator is allowed to move DOWN. However, moving down will cause chain slack once the stops are reached. After that, the only possibility is to drive the elevator UP." row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorRev"/>
			<contact type="closed" name="gCtrl.elevator.elevatorIsAtBottom"/>
			<contact type="open" name="gMachineIO.din.PalleteDischLightCurtain_OSSD1"/>
			<contact type="open" name="gMachineIO.din.PalleteDischLightCurtain_OSSD2"/>
			<contact type="closed" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwd"/>
			<contact type="closed" name="gCtrl.rowforming.isRowPusherAtElevator"/>
			<contact type="open" name="gCtrl.transfertable.isTableAtGrouping"/>
			<coil type="open" name="gMachineVFD[1].vfdCtrl.iMoveRev"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.SafetyOk"/>
			<contact type="open" name="gCtrl.main.noMajorFault"/>
			<contact type="open" name="gCtrl.main.noMinorFault" or="true"/>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorRevJog" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<contact type="closed" name="gCtrl.elevator.tmrPalletePEOn.Q" or="true"/>
			<empty/>
		</row>
	</network>
	<network label="" comment="============================================================================
Detection of elevator position" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.ElevatorAtGroupingLower_PR3"/>
			<contact type="open" name="gMachineIO.din.ElevatorAtGroupingRaise_PR4"/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsAtHome"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.ElevatorFullUp_PR1"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsAtTop"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.ElevatorFullDown_PR2"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsAtBottom"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.ElevatorAtGroupingLower_PR3"/>
			<contact type="closed" name="gMachineIO.din.ElevatorAtGroupingRaise_PR4"/>
			<contact type="closed" name="gMachineIO.din.ElevatorFullDown_PR2"/>
			<contact type="closed" name="gMachineIO.din.ElevatorFullUp_PR1"/>
			<coil type="open" name="gCtrl.elevator.elevatorIsUknownPosition"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.ElevatorAtGroupingLower_PR3"/>
			<contact type="open" name="gMachineIO.din.ElevatorAtGroupingRaise_PR4"/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsAboveNearHome"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.ElevatorAtGroupingLower_PR3"/>
			<contact type="closed" name="gMachineIO.din.ElevatorAtGroupingRaise_PR4"/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsBelowNearHome"/>
		</row>
	</network>
	<network label="" comment="Forward direction of the VFD is elevator move UP" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineVFD[1].vfdCtrl.oRunning"/>
			<contact type="closed" name="gMachineVFD[1].vfdOut.Control.Direction"/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsMovingUp"/>
		</row>
	</network>
	<network label="" comment="Reverse direction of the VFD is elevator move DOWN" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineVFD[1].vfdCtrl.oRunning"/>
			<contact type="open" name="gMachineVFD[1].vfdOut.Control.Direction"/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsMovingDw"/>
		</row>
	</network>
	<network label="" comment="Position is above home but unknown" row="2" column="0" commented="0">
		<row>
			<contact type="negative transition" name="gCtrl.elevator.elevatorIsAboveNearHome"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsMovingUp"/>
			<line/>
			<coil type="set" name="gCtrl.elevator.elevatorIsAboveHomeUnknown"/>
		</row>
		<row>
			<contact type="negative transition" name="gCtrl.elevator.elevatorIsAtTop"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsMovingDw" or="true"/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="positive transition" name="gCtrl.elevator.elevatorIsAboveNearHome"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsMovingDw"/>
			<line/>
			<coil type="reset" name="gCtrl.elevator.elevatorIsAboveHomeUnknown"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtTop"/>
			<line or="true"/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Position is below home but unknown" row="2" column="0" commented="0">
		<row>
			<contact type="negative transition" name="gCtrl.elevator.elevatorIsBelowNearHome"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsMovingDw"/>
			<line/>
			<coil type="set" name="gCtrl.elevator.elevatorIsBelowHomeUnknown"/>
		</row>
		<row>
			<contact type="negative transition" name="gCtrl.elevator.elevatorIsAtBottom"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsMovingUp" or="true"/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="positive transition" name="gCtrl.elevator.elevatorIsBelowNearHome"/>
			<contact type="open" name="gCtrl.elevator.elevatorIsMovingUp"/>
			<line/>
			<coil type="reset" name="gCtrl.elevator.elevatorIsBelowHomeUnknown"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtBottom"/>
			<line or="true"/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Elevator is above home" row="3" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsAboveNearHome"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsAboveHome"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtTop" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsAboveHomeUnknown" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Elevator is below home" row="3" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsBelowNearHome"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.elevator.elevatorIsBelowHome"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsAtBottom" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.elevator.elevatorIsBelowHomeUnknown" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
</networks>
END_PROGRAM



























