PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Blink generator." row="3" column="0" commented="0">
		<row>
			<empty/>
			<functionblock position="header" name="gCtrl.main.tmrBlinkOn" type="TON"/>
			<empty/>
			<functionblock position="header" name="gCtrl.main.tmrBlinkOff" type="TOF"/>
			<empty/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.tmrBlinkOff.Q"/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<functionblock position="top" type="TOF"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gCtrl.main.blink"/>
		</row>
		<row>
			<analog type="input" name="T#700ms"/>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<analog type="input" name="T#700ms"/>
			<functionblock position="bottom" type="TOF"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
	</network>
	<network label="" comment="Utility bit: AlwaysOn" row="1" column="0" commented="0">
		<row>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.alwaysOnBit"/>
		</row>
	</network>
	<network label="" comment="Guard door ok signal." row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.Guard_DS1"/>
			<contact type="closed" name="gMachineIO.din.Guard_DS2"/>
			<contact type="closed" name="gMachineIO.din.Guard_DS3"/>
			<contact type="closed" name="gMachineIO.din.Guard_DS4"/>
			<contact type="closed" name="gMachineIO.din.Guard_DS5"/>
			<line/>
			<coil type="open" name="gCtrl.main.guardDoorsOk"/>
		</row>
	</network>
	<network label="" comment="Safety Circuit status" row="3" column="0" commented="0">
		<row>
			<empty/>
			<functionblock position="header" name="gCtrl.main.tmrMCROnDelay" type="TON"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gMachineIO.din.MCR"/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.SafetyOk"/>
		</row>
		<row>
			<analog type="input" name="T#1s"/>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="EStop circuit status." row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.EStop_PB1"/>
			<contact type="closed" name="gMachineIO.din.EStop_PB2"/>
			<contact type="closed" name="gMachineIO.din.EStop_PB3"/>
			<contact type="closed" name="gMachineIO.din.EStop_PB4"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.EStopOk"/>
		</row>
	</network>
	<network label="" comment="No major fault.TODO: Add discharge light curtains!" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.guardDoorsOk"/>
			<contact type="open" name="gCtrl.main.EStopOk"/>
			<contact type="open" name="gMachineIO.din.MotorOverloads_OL"/>
			<contact type="closed" name="gAlarms.alarmActive[APP_ALARM_HWMODULE]"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.noMajorFault"/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.CustomerMachineRunning_CR5"/>
		</row>
	</network>
	<network label="" comment="VFD-s faults. TODO: add configuration for optional VFD-s." row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineVFD[1].vfdCtrl.oFault"/>
			<contact type="closed" name="gMachineVFD[2].vfdCtrl.oFault"/>
			<contact type="closed" name="gMachineVFD[4].vfdCtrl.oFault"/>
			<contact type="closed" name="gMachineVFD[11].vfdCtrl.oFault"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.VFDsNoFaults"/>
		</row>
	</network>
	<network label="" comment="Minor fault." row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.ElevatorChainSlackLF_LS7"/>
			<contact type="open" name="gMachineIO.din.ElevatorChainSlackRT_LS8"/>
			<contact type="open" name="gMachineIO.din.PalletDispenserChainSlack_PR21"/>
			<contact type="open" name="gCtrl.main.VFDsNoFaults"/>
			<contact type="open" name="gMachineIO.din.PalleteDischLightCurtain_OSSD1"/>
			<contact type="open" name="gMachineIO.din.PalleteDischLightCurtain_OSSD2"/>
			<contact type="closed" name="gAlarms.oIsAlarmNotAck"/>
			<coil type="open" name="gCtrl.main.noMinorFault"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<contact type="closed" name="gCtrl.palletDispenser.palletDispenserEquipped" or="true"/>
			<empty or="true"/>
			<contact type="open" name="gCtrl.palletDischarge.muteLightCurtainDuringDischarge"/>
			<line or="true"/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Machine fault indicator (RED Light)." row="3" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.noMajorFault"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.MachineFaultBeacon_LT1"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noMinorFault" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.elevatorStopBlockActive" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Machine Air Dump Solenoid control. (GREEN Light)." row="3" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.SafetyOk"/>
			<contact type="open" name="gCtrl.main.noMajorFault"/>
			<contact type="open" name="gCtrl.main.noMinorFault"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.AirDump_SOL0"/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty or="true"/>
			<contact type="closed" name="gCtrl.main.elevatorStopBlockActive"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.MachineOkBeacon_LT2"/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.noFaults"/>
		</row>
	</network>
	<network label="" comment="======================================================================================
Elevatgor Stop blocks are used for securing the elevator from moving down." row="2" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.ElevatorStopBlockLF_PR33"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.elevatorStopBlockActive"/>
		</row>
		<row>
			<contact type="closed" name="gMachineIO.din.ElevatorStopBlockRT_PR34" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
</networks>
END_PROGRAM





















