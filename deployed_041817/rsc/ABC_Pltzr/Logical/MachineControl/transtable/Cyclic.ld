PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Set point for the pusher move velocity." row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.vfd[2].velocity_rpm"/>
			<function position="topbottom" type="DINT_TO_INT"><input name="IN"/><output name="3"/></function>
			<analog type="output" name="gMachineVFD[2].vfdCtrl.iVelocitySetPoint"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="===========================================================================
Table IO
==" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.TransferTableAtGrouping_PR6"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.transfertable.isTableAtGrouping"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.TransferTableAtPallete_PR5"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.transfertable.isTableAtPallete"/>
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
			<coil type="open" name="gMachineVFD[2].vfdCtrl.iEnable"/>
		</row>
	</network>
	<network label="" comment="Reset HMI buttons for MOVE" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.transfertable.isTableAtPallete"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.transfertable.hmiBtnTableFwd"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.transfertable.hmiBtnTableFwdJog"/>
		</row>
	</network>
	<network label="" comment="Reset HMI buttons for MOVE" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.transfertable.isTableAtGrouping"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.transfertable.hmiBtnTableRev"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.transfertable.hmiBtnTableRevJog"/>
		</row>
	</network>
	<network label="" comment="Move/Jog FWD" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.transfertable.hmiBtnTableFwd"/>
			<contact type="closed" name="gCtrl.transfertable.isTableAtPallete"/>
			<contact type="closed" name="gMachineIO.din.ElevatorDetectPalletLayerLF_EE1"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[2].vfdCtrl.iMoveFwd"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.transfertable.hmiBtnTableFwdJog" or="true"/>
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
			<contact type="open" name="gCtrl.transfertable.hmiBtnTableRev"/>
			<contact type="closed" name="gCtrl.transfertable.isTableAtGrouping"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineVFD[2].vfdCtrl.iMoveRev"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.transfertable.hmiBtnTableRevJog" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
</networks>
END_PROGRAM




















