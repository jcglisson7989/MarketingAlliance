PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Mode control: Maintenance" row="4" column="0" commented="0">
		<row>
			<contact type="closed" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gPaiHmiRTMenu.iMenuSelectItem[0]"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gPaiHmiRTMenu.oMenuDisabledItems[1]"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gPaiHmiRTMenu.oMenuDisabledItems[2]"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gPaiHmiRTMenu.oMenuDisabledItems[0]"/>
		</row>
	</network>
	<network label="" comment="Mode control: Manual" row="4" column="0" commented="0">
		<row>
			<contact type="positive transition" name="gCtrl.main.noFaults"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gPaiHmiRTMenu.iMenuSelectItem[1]"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gPaiHmiRTMenu.oMenuDisabledItems[0]"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gPaiHmiRTMenu.oMenuDisabledItems[1]"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gPaiHmiRTMenu.oMenuDisabledItems[2]"/>
		</row>
	</network>
	<network label="" comment="Model: Maintenance" row="3" column="0" commented="0">
		<row>
			<contact type="open" name="gPaiHmiRTMenu.oMenuSelectedItems[0]"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gCtrl.main.modeMaintenance"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.main.modeManual"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.main.modeAuto"/>
		</row>
	</network>
	<network label="" comment="Mode: Manual" row="3" column="0" commented="0">
		<row>
			<contact type="open" name="gPaiHmiRTMenu.oMenuSelectedItems[1]"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.main.modeMaintenance"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gCtrl.main.modeManual"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.main.modeAuto"/>
		</row>
	</network>
	<network label="" comment="Model: Auto" row="3" column="0" commented="0">
		<row>
			<contact type="open" name="gPaiHmiRTMenu.oMenuSelectedItems[2]"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.main.modeMaintenance"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.main.modeManual"/>
		</row>
		<row>
			<empty or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gCtrl.main.modeAuto"/>
		</row>
	</network>
	<network label="" comment="" row="1" column="0" commented="0">
		<row>
			<contact type="open" name="gPaiHmiRTMenu.oMenuPressedItems[1]"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gCtrl.main.btnStop"/>
		</row>
	</network>
</networks>
END_PROGRAM










