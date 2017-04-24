PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.caseturner.hmiBtnCaseTurnerUpDown"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.CaseTurnerRaise_SOL2A"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.CaseTurnerRaise_SOL2A"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.CaseTurnerLower_SOL2B"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gMachineIO.dout.CaseTurnerRaise_SOL2A"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gCtrl.caseturner.hmiAutoCaseTurn"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gCtrl.caseturner.hmiBtnCaseTurnerUpDown"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.caseturner.hmiAutoCaseTurn"/>
		</row>
	</network>
	<network label="" comment="Case turner is raised based on the command from the PalletProcessor in the moment when case enteres OneCaseOnlySection. The case turned is lowered after a specified delay time." row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.caseturner.tmrCaseTurnerActive" type="TON"/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.caseturner.hmiBtnCaseTurnerUpDown"/>
			<contact type="open" name="gCtrl.infeedcv.caseAtOneCaseOnlySection"/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<coil type="reset" name="gCtrl.caseturner.hmiAutoCaseTurn"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.onTmCaseTurner"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty or="true"/>
			<coil type="reset" name="gCtrl.caseturner.hmiBtnCaseTurnerUpDown"/>
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
		</row>
	</network>
</networks>
END_PROGRAM

















