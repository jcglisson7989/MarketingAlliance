PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gConfigApp.system.simulationMode"/>
			<function position="topbottom" type="UDINT_TO_BOOL"><input name="IN"/><output name="1"/></function>
			<coil type="jump" name="SIMONLY"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<line/>
			<line/>
			<line/>
			<coil type="return"/>
		</row>
	</network>
	<network label="SIMONLY" comment="" row="8" column="0" commented="0">
		<row>
			<contact type="open" name="TRUE"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.din.MCR"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.din.AirPressureSwitch_APS"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.din.ElevatorChainSlackLF_LS7"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.din.ElevatorChainSlackRT_LS8"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.din.PalleteDischLightCurtain_OSSD1"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.din.PalleteDischLightCurtain_OSSD2"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.din.MotorOverloads_OL"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.din.PalletDispenserChainSlack_PR21"/>
		</row>
	</network>
	<network label="" comment="SIMONLY: When HMI request are made, set coresponsing Inputs for simulation." row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.rowforming.hmiBtnPusherRev"/>
			<line/>
			<line/>
			<coil type="set" name="gMachineIO.din.RowPusherReturned_PR11"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.rowforming.hmiBtnPusherFwd"/>
			<line/>
			<line/>
			<coil type="set" name="gMachineIO.din.RowPusherAtElevator_PR13"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.transfertable.hmiBtnTableRev"/>
			<line/>
			<line/>
			<coil type="set" name="gMachineIO.din.TransferTableAtGrouping_PR6"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.transfertable.hmiBtnTableFwd"/>
			<line/>
			<line/>
			<coil type="set" name="gMachineIO.din.TransferTableAtPallete_PR5"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.elevator.hmiBtnElevatorToGrouping"/>
			<line/>
			<line/>
			<coil type="set" name="gMachineIO.din.ElevatorAtGroupingLower_PR3"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="set" name="gMachineIO.din.ElevatorAtGroupingRaise_PR4"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToTop"/>
			<line/>
			<line/>
			<coil type="set" name="gMachineIO.din.PalletClawsAtTop_PR14"/>
		</row>
	</network>
</networks>
END_PROGRAM



















