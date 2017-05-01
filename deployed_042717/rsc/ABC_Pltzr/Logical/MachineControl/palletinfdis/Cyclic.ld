PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gConfigApp.options.palletDispenserOption"/>
			<function position="topbottom" type="UDINT_TO_BOOL"><input name="IN"/><output name="1"/></function>
			<coil type="open" name="gCtrl.palletDispenser.palletDispenserEquipped"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.palletDispenser.palletDispenserEquipped"/>
			<function position="topbottom" type="BOOL_TO_USINT"><input name="IN"/><output name="5"/></function>
			<coil type="open" name="gCtrl.palletDispenser.palletDispenserEquippedVis"/>
		</row>
	</network>
	<network label="" comment="===========================================================================+
Pallet Lift IO
==" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.PalletClawsAtTop_PR14"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.palletDispenser.atTop"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.PalletClawsAtMiddleHi_PR15A"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.palletDispenser.atMidHi"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.PalletClawsAtMiddleLow_PR15"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.palletDispenser.atMidLo"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.PalletClawsAtBottom_PR16"/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.palletDispenser.atBottom"/>
		</row>
	</network>
	<network label="" comment="===========================================================================+
Pallet Claws Lift Control
Pallet Lift JOG Down  " row="4" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftDwJog"/>
			<contact type="closed" name="gCtrl.palletDispenser.atBottom"/>
			<coil type="open" name="gMachineIO.dout.PalletDispenserLower_M8R"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToBottom"/>
			<contact type="closed" name="gCtrl.palletDispenser.flagMoveUp" or="true"/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDispenser.flagClawsLiftToMidHi" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDispenser.flagClawsLiftToMidLo" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToBottom"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.flagMoveUp"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToTop"/>
			<line/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.flagMoveUp"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToMidHi"/>
			<contact type="open" name="gCtrl.palletDispenser.atTop"/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.flagMoveUp"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.flagClawsLiftToMidHi"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToMidLo"/>
			<contact type="open" name="gCtrl.palletDispenser.atTop"/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.flagClawsLiftToMidLo"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.palletDispenser.atMidHi" or="true"/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.flagMoveUp"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToMidHi"/>
			<contact type="open" name="gCtrl.palletDispenser.atBottom"/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.flagMoveUp"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.palletDispenser.atMidLo" or="true"/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.flagClawsLiftToMidHi"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToMidLo"/>
			<contact type="open" name="gCtrl.palletDispenser.atBottom"/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.flagClawsLiftToMidLo"/>
		</row>
		<row>
			<empty/>
			<empty or="true"/>
			<line/>
			<coil type="set" name="gCtrl.palletDispenser.flagMoveUp"/>
		</row>
	</network>
	<network label="" comment="Pallet Lift JOG UP" row="4" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.PalletDispenserLower_M8R"/>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftUpJog"/>
			<contact type="closed" name="gCtrl.palletDispenser.atTop"/>
			<coil type="open" name="gMachineIO.dout.PalletDispenserRaise_M8F"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnClawsLiftToTop"/>
			<contact type="open" name="gCtrl.palletDispenser.flagMoveUp" or="true"/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDispenser.flagClawsLiftToMidLo" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDispenser.flagClawsLiftToMidHi" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.atTop"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnClawsLiftToTop"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.atMidHi"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnClawsLiftToMidHi"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.flagClawsLiftToMidHi"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.atMidLo"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnClawsLiftToMidLo"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.flagClawsLiftToMidLo"/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.atBottom"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnClawsLiftToBottom"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="============================================================================
Pallet claws control" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose"/>
			<line/>
			<coil type="open" name="gMachineIO.dout.PalletClawsClose_SOL7A"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.PalletClawsClose_SOL7A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.PalletClawsOpen_SOL7B"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="1">
		<row>
			<contact type="closed" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<coil type="reset" name="gMachineIO.dout.PalletClawsClose_SOL7A"/>
		</row>
	</network>
</networks>
END_PROGRAM




















