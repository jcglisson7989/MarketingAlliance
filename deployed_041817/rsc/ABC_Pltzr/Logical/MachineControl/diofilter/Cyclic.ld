PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="===========================================================================
EE2 - On/Off debounce" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gMachineIO.din.ProductAtInfeed_EE2TmrOn" type="TON"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gMachineIO.din.ProductAtInfeed_EE2TmrOf" type="TOF"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gMachineIO.din.ProductAtInfeed_EE2Phy"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TOF"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gMachineIO.din.ProductAtInfeed_EE2"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.EE2OnDebounce"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.EE2OfDebounce"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TOF"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="===========================================================================
EE8 - On/Off debounce" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gMachineIO.din.RowTooLong_EE8TmrOn" type="TON"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gMachineIO.din.RowTooLong_EE8TmrOf" type="TOF"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gMachineIO.din.RowTooLong_EE8Phy"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TOF"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gMachineIO.din.RowTooLong_EE8"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.EE8OnDebounce"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.EE8OfDebounce"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TOF"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="===========================================================================
EE4 - On/Off debounce" row="4" column="0" commented="0">
		<row>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gMachineIO.din.ProductAtStage_EE4TmrOn" type="TON"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<functionblock position="header" name="gMachineIO.din.ProductAtStage_EE4TmrOf" type="TOF"/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gMachineIO.din.ProductAtStage_EE4Phy"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<functionblock position="top" type="TOF"><input name="IN"/><output name="Q"/></functionblock>
			<coil type="open" name="gMachineIO.din.ProductAtStage_EE4"/>
		</row>
		<row>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.EE4OnDebounce"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<analog type="input" name="gPallete.palCfg.palSettings.timers.EE4OfDebounce"/>
			<function position="top" type="MUL"><input name="" extensible="true"/><output name="42"/></function>
			<function position="topbottom" type="REAL_TO_TIME"><input name="IN"/><output name="12"/></function>
			<functionblock position="bottom" type="TOF"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
		</row>
		<row>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<analog type="input" name="1000"/>
			<function position="bottom" type="MUL"><input name="" extensible="true"/></function>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
</networks>
END_PROGRAM


























