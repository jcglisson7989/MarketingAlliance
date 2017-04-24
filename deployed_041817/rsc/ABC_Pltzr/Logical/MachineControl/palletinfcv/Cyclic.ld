PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Set point for the pusher move velocity." row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.vfd[11].velocity_rpm"/>
			<function position="topbottom" type="DINT_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gMachineVFD[11].vfdCtrl.iVelocitySetPoint"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="VFD Enable control" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[11].vfdCtrl.iEnable"/>
		</row>
	</network>
	<network label="" comment="Move/Jog FWD" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwd"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[11].vfdCtrl.iMoveFwd"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwdJog" or="true"/>
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
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnPalletInCVRev"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[11].vfdCtrl.iMoveRev"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnPalletInCVRevJog" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="4" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnPalletInCVRevJog"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwd"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.palletDispenser.hmiBtnPalletInCVFwdJog" or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.palletDispenser.hmiBtnPalletInCVRev"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.btnStop" or="true"/>
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





















