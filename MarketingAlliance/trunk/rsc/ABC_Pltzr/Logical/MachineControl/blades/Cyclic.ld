PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="============================================================================
Stop blades control 1. Blade can be up only if pusher is all the way back. Added support for blade quick raise (no timer delay) in order to handle a corner case when blades are quired to be up after a stage event takes place and the case is very close to the blades." row="5" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDown1"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick1"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop1Up_SOL3A"/>
		</row>
		<row>
			<empty or="true"/>
			<empty or="true"/>
			<empty or="true"/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.rowforming.bladeStopOnDly[0]" type="TON" or="true"/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick1" or="true"/>
			<empty or="true"/>
			<line/>
			<line/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.bladeStopOnDly1"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
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
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.BladeStop1Up_SOL3A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop1Dw_SOL3B"/>
		</row>
	</network>
	<network label="" comment="============================================================================
Stop blades control 2. Blade can be up only if pusher is all the way back." row="5" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDown2"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick2"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop2Up_SOL4A"/>
		</row>
		<row>
			<empty or="true"/>
			<empty or="true"/>
			<empty or="true"/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.rowforming.bladeStopOnDly[1]" type="TON" or="true"/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick2" or="true"/>
			<empty or="true"/>
			<line/>
			<line/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.bladeStopOnDly2"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
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
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.BladeStop2Up_SOL4A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop2Dw_SOL4B"/>
		</row>
	</network>
	<network label="" comment="============================================================================
Stop blades control 3. Blade can be up only if pusher is all the way back." row="5" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDown3"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick3"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop3Up_SOL5A"/>
		</row>
		<row>
			<empty or="true"/>
			<empty or="true"/>
			<empty or="true"/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.rowforming.bladeStopOnDly[2]" type="TON" or="true"/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick3" or="true"/>
			<empty or="true"/>
			<line/>
			<line/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.bladeStopOnDly3"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
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
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.BladeStop3Up_SOL5A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop3Dw_SOL5B"/>
		</row>
	</network>
	<network label="" comment="============================================================================
Stop blades control 4. Blade can be up only if pusher is all the way back." row="5" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDown4"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick4"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop4Up_SOL6A"/>
		</row>
		<row>
			<empty or="true"/>
			<empty or="true"/>
			<empty or="true"/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.rowforming.bladeStopOnDly[3]" type="TON" or="true"/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick4" or="true"/>
			<empty or="true"/>
			<line/>
			<line/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.bladeStopOnDly4"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
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
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.BladeStop4Up_SOL6A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop4Dw_SOL6B"/>
		</row>
	</network>
	<network label="" comment="============================================================================
Stop blades control 5. Blade can be up only if pusher is all the way back." row="5" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDown5"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick5"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop5Up_SOL13A"/>
		</row>
		<row>
			<empty or="true"/>
			<empty or="true"/>
			<empty or="true"/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.rowforming.bladeStopOnDly[4]" type="TON" or="true"/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick5" or="true"/>
			<empty or="true"/>
			<line/>
			<line/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.bladeStopOnDly5"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
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
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.BladeStop5Up_SOL13A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop5Dw_SOL13B"/>
		</row>
	</network>
	<network label="" comment="============================================================================
Stop blades control 6. Blade can be up only if pusher is all the way back." row="5" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDown6"/>
			<contact type="open" name="gCtrl.rowforming.isRowPusherAtHome"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick6"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop6Up_SOL14A"/>
		</row>
		<row>
			<empty or="true"/>
			<empty or="true"/>
			<empty or="true"/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gCtrl.rowforming.bladeStopOnDly[5]" type="TON" or="true"/>
			<empty/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.rowforming.hmiBtnStopBladeUpDownQuick6" or="true"/>
			<empty or="true"/>
			<line/>
			<line/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.bladeStopOnDly6"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
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
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.BladeStop6Up_SOL14A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.BladeStop6Dw_SOL14B"/>
		</row>
	</network>
</networks>
END_PROGRAM



























