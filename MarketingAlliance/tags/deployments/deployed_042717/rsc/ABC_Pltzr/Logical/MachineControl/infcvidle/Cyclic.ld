PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="===========================================================================
In auto mode, if both infeed CV-s run longer than IdleDelay, stop both CV-s" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.infeedcv.tmrInfeedCVIdle" type="TON"/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnOnOffCV"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnOnOffStageCV"/>
			<contact type="closed" name="gMachineIO.din.ProductAtInfeed_EE2"/>
			<contact type="closed" name="gCtrl.infeedcv.caseAtOneCaseOnlySection"/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnOnOffCV"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.infeedCVIdleTime"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty or="true"/>
			<coil type="reset" name="gCtrl.rowforming.hmiBtnOnOffStageCV"/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty or="true"/>
			<coil type="set" name="gCtrl.infeedcv.sleepState"/>
		</row>
	</network>
	<network label="" comment="In auto mode, if infeed CV sleep is active (both CV-s stopped), restart both at the raising edge of the product at infeed." row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.modeAuto"/>
			<contact type="open" name="gCtrl.infeedcv.sleepState"/>
			<contact type="positive transition" name="gMachineIO.din.ProductAtInfeed_EE2"/>
			<coil type="set" name="gCtrl.rowforming.hmiBtnOnOffCV"/>
		</row>
		<row>
			<empty/>
			<empty/>
			<empty or="true"/>
			<coil type="set" name="gCtrl.rowforming.hmiBtnOnOffStageCV"/>
		</row>
	</network>
	<network label="" comment="Clear infeed CV sleep state as soon as CV-s move or machine goes in NOT auto mode." row="3" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.modeAuto"/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.infeedcv.sleepState"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.rowforming.hmiBtnOnOffCV" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.rowforming.hmiBtnOnOffStageCV" or="true"/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
</networks>
END_PROGRAM

