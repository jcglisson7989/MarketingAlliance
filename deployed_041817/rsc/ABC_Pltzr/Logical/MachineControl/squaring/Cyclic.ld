PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<analog type="input" name="gConfigApp.options.frontSquaringOption"/>
			<function position="topbottom" type="UDINT_TO_BOOL"><input name="IN"/><output name="1"/></function>
			<coil type="open" name="gCtrl.squaring.frontSquaringEquipped"/>
		</row>
	</network>
	<network label="" comment="=====================================================================================
Side Squaring" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.squaring.hmiBtnSidePlatesExtRet"/>
			<line/>
			<coil type="open" name="gMachineIO.dout.SideSquaringExtend_SOL8A"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.SideSquaringExtend_SOL8A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.SideSquaringRetract_SOL8B"/>
		</row>
	</network>
	<network label="" comment="=====================================================================================
Front Squaring" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.squaring.hmiBtnFrontPlateExtRet"/>
			<line/>
			<coil type="open" name="gMachineIO.dout.FrontSquaringExtend_SOL11A"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.dout.FrontSquaringExtend_SOL11A"/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.FrontSquaringRetract_SOL11B"/>
		</row>
	</network>
</networks>
END_PROGRAM















