PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio Version=3.0.71?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="Reset HMI buttons for MOVE of the RETAINER BAR  
Move REV&gt; Going UP
Move FWD&gt; Going DOWN" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.retainerbar.barDwOffDlyTmr.Q"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.retainerbar.hmiBtnRetainterBarFwd"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.retainerbar.hmiBtnRetainterBarFwdJog"/>
		</row>
	</network>
	<network label="" comment="Reset HMI buttons for MOVE" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.retainerbar.barIsUp"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.retainerbar.hmiBtnRetainterBarRev"/>
		</row>
		<row>
			<contact type="closed" name="gCtrl.main.noFaults" or="true"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.retainerbar.hmiBtnRetainterBarRevJog"/>
		</row>
	</network>
	<network label="" comment="Move/Jog FWD" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="gCtrl.main.noFaults"/>
			<contact type="open" name="gCtrl.retainerbar.hmiBtnRetainterBarFwd"/>
			<contact type="closed" name="gCtrl.retainerbar.barDwOffDlyTmr.Q"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.LayerStopBarLower_M3R"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.retainerbar.hmiBtnRetainterBarFwdJog" or="true"/>
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
			<contact type="open" name="gCtrl.retainerbar.hmiBtnRetainterBarRev"/>
			<contact type="closed" name="gCtrl.retainerbar.barIsUp"/>
			<line/>
			<line/>
			<line/>
			<coil type="open" name="gMachineIO.dout.LayerStopBarRaise_M3F"/>
		</row>
		<row>
			<empty or="true"/>
			<contact type="open" name="gCtrl.retainerbar.hmiBtnRetainterBarRevJog" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Virtual switches are required due to a possbility that a real prox is overshoot while bar is moving. As a result bar may not stop." row="4" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.LayerStopBarUp_PR7"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gCtrl.retainerbar.barIsUp"/>
		</row>
		<row>
			<empty/>
			<functionblock position="header" name="gCtrl.retainerbar.revTimer" type="TON" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gMachineIO.dout.LayerStopBarRaise_M3F"/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<analog type="input" name="T#2000ms"/>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.LayerStopBarUp_PR7"/>
			<contact type="open" name="gMachineIO.dout.LayerStopBarLower_M3R"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.retainerbar.barIsUp"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.retainerbar.barIsDown"/>
			<line or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="Virtual switches are required due to a possbility that a real prox is overshoot while bar is moving. As a result bar may not stop. On dly for the down prox is used to adjust the down position of the retainter bar." row="4" column="0" commented="0">
		<row>
			<contact type="open" name="gMachineIO.din.LayerStopBarDown_PR8"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="set" name="gCtrl.retainerbar.barIsDown"/>
		</row>
		<row>
			<empty/>
			<functionblock position="header" name="gCtrl.retainerbar.fwdTimer" type="TON" or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gMachineIO.dout.LayerStopBarLower_M3R"/>
			<functionblock position="top" type="TON" or="true"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<analog type="input" name="T#2000ms"/>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="closed" name="gMachineIO.din.LayerStopBarDown_PR8"/>
			<contact type="open" name="gMachineIO.dout.LayerStopBarRaise_M3F"/>
			<line/>
			<line/>
			<line/>
			<line/>
			<coil type="reset" name="gCtrl.retainerbar.barIsDown"/>
		</row>
		<row>
			<contact type="open" name="gCtrl.retainerbar.barIsUp"/>
			<line or="true"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
	<network label="" comment="" row="3" column="0" commented="0">
		<row>
			<empty/>
			<functionblock position="header" name="gCtrl.retainerbar.barDwOffDlyTmr" type="TON"/>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<contact type="open" name="gCtrl.retainerbar.barIsDown"/>
			<functionblock position="top" type="TON"><input name="IN"/><output name="Q"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
		<row>
			<analog type="input" name="gCtrl.retainerbar.barDwDlyTmXms"/>
			<functionblock position="bottom" type="TON"><input name="PT"/><output name="ET"/></functionblock>
			<empty/>
			<empty/>
			<empty/>
			<empty/>
		</row>
	</network>
</networks>
END_PROGRAM
















