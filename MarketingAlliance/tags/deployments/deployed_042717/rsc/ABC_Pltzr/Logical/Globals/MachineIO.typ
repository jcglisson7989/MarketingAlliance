(********************************************************************

 * COPYRIGHT -- Piedmont Automation Inc.

 ********************************************************************

 * File: MachineIO.typ

 * Author: goran

 * Created: Jun 1, 2015

 ********************************************************************

 *)
(*********************************************************************************							

Machine IO Structure								

*********************************************************************************)

TYPE
	machineIO_typ : 	STRUCT 
		din : machineDI_typ;
		dout : machineDO_typ;
	END_STRUCT;
END_TYPE

(*********************************************************************************							

	Machine Digital Inputs								

*********************************************************************************)

TYPE
	machineDI_typ : 	STRUCT 
		MCR : BOOL; (*Master Control Relay Energized*)
		Guard_DS1 : BOOL; (*Guard 1 Open DS1 # GUARD DOOR INSERTER*)
		Guard_DS2 : BOOL; (*Guard 2 Open DS2 # GUARD DOOR GROUPING RIGHT*)
		Guard_DS3 : BOOL; (*Guard 3 Open DS3 # GUARD DOOR DISPENSER*)
		Guard_DS4 : BOOL; (*Guard 4 Open DS4 # GUARD DOOR GROUPING LEFT*)
		Guard_DS5 : BOOL; (*Guard 5 Open DS5 # TBD*)
		Guard_DS6 : BOOL; (*Guard 6 Open DS6 # TBD*)
		EStop_PB1 : BOOL; (*EStop status 1 - PB1 - Enclosure*)
		EStop_PB2 : BOOL; (*EStop status 2 - PB2 - Infeed*)
		EStop_PB3 : BOOL; (*EStop status 3 - PB3 - Dispenser*)
		EStop_PB4 : BOOL; (*EStop status 4 - PB 4 - HMI*)
		EStop_PB5 : BOOL; (*EStop status 5 - PB5 - TBD*)
		EStop_PB6 : BOOL; (*EStop status 6 - PB6 - TBD*)
		MotorOverloads_OL : BOOL; (*MotorOverloads*)
		CustomerDischargeEnable_CR6 : BOOL; (*Customer Discharge Enable*)
		AirPressureSwitch_APS : BOOL; (*Air Pressure Switch APS*)
		PalletMagazineControl_SS2 : BOOL; (*Pallet Dispenser in Run Mode SS2*)
		PalleteDischLightCurtain_OSSD1 : BOOL; (*Pallete Dispenser Light Curtain CH A*)
		PalleteDischLightCurtain_OSSD2 : BOOL; (*Pallete Dispenser Light Curtain CH B*)
		ElevatorDetectPalletLayerLF_EE1 : BOOL; (*Detect Layer On Pallet EE1*)
		ProductAtStage_EE4Phy : BOOL;
		ProductAtStage_EE4TmrOn : TON;
		ProductAtStage_EE4TmrOf : TOF;
		ProductAtStage_EE4 : BOOL; (*Product/Case at Stage Position*)
		ElevatorDetectPalletLayerRT_EE3 : BOOL; (*Detect Layer On Pallet 2nd Eye EE3*)
		ZZZZZZZZZZZZZZZZZZZZZZZZZZZ : USINT;
		ElevatorFullUp_PR1 : BOOL; (*Elevator Full Up PR1*)
		ElevatorFullDown_PR2 : BOOL; (*Elevator Full Down PR2*)
		ElevatorAtGroupingRaise_PR4 : BOOL; (*Elevator @ Level for Raise PR4*)
		ElevatorAtGroupingLower_PR3 : BOOL; (*Elevator @ Level for Lower PR3*)
		ElevatorStopBlockRT_PR34 : BOOL; (*Elevator Stop Block Right Is Clear PR34*)
		ElevatorStopBlockLF_PR33 : BOOL; (*Elevator Stop Block Left Is Clear PR33*)
		ElevatorChainSlackRT_LS8 : BOOL; (*Elevator Chain Slack Right LS8*)
		ElevatorChainSlackLF_LS7 : BOOL; (*Elevator Chain Slack Left LS7*)
		TransferTableAtGrouping_PR6 : BOOL; (*Transfer Table At Grouping Side PR6*)
		TransferTableAtPallete_PR5 : BOOL; (*Table at Pallet Side PR5*)
		LayerStopBarDown_PR8 : BOOL; (*Layer Stop Bar/Stripper Bar is Down PR8*)
		LayerStopBarUp_PR7 : BOOL; (*Layer Stop Bar/Stripper Bar is Up PR7*)
		ProductAtInfeed_EE2Phy : BOOL; (*Product At Infeed Case / Counter EE2*)
		ProductAtInfeed_EE2TmrOn : TON; (*Product At Infeed Case / Counter EE2*)
		ProductAtInfeed_EE2TmrOf : TOF; (*Product At Infeed Case / Counter EE2*)
		ProductAtInfeed_EE2 : BOOL; (*Product At Infeed Case / Counter EE2*)
		RowTooLong_EE8Phy : BOOL;
		RowTooLong_EE8TmrOn : TON;
		RowTooLong_EE8TmrOf : TOF;
		RowTooLong_EE8 : BOOL; (*Comparison Count Row Too Long EE8*)
		RowPusherAtElevator_PR13 : BOOL; (*Row Pusher At Elevator PR13*)
		RowPusherReturned_PR11 : BOOL; (*Row Pusher Returned PR11*)
		PalletClawsAtTop_PR14 : BOOL; (*Pallet Dispenser at Top Position PR14*)
		PalletClawsAtMiddleLow_PR15 : BOOL; (*Pallet Dispenser Claws at Middle Position PR15*)
		PalletClawsAtMiddleHi_PR15A : BOOL; (*Pallet Claws at upper Middle*)
		PalletClawsAtBottom_PR16 : BOOL; (*Pallet Dispenser Claws at Bottom Position PR16*)
		PalletClawsClosedRT_PR18 : BOOL; (*Pallet Dispenser Right Claw Closed PR18*)
		PalletClawsClosedLF_PR20 : BOOL; (*Pallet Dispenser Left Claw Closed PR20*)
		PalletDispenserLowSupply_EE7 : BOOL; (*Pallet Dispenser Low Pallet Supply EE7*)
		PalletDispenserChainSlack_PR21 : BOOL; (*Pallet Dispenser Chain Slack PR21*)
		PalletDownOnDispenserCV_EE9 : BOOL; (*Pallet Dispenser Down on Dispenser Conveyor EE9*)
		ZZZZZZZZZZZZZZZZZZZZZZZZZZZ1 : USINT;
		Reset_PB : BOOL; (*Reset PushButton PB6*)
		PalletAtMachine_EE12 : BOOL; (*PalletAtMachine*)
		PalletAtDischarge_EE16 : BOOL; (*PalletAtDischarge*)
		Inserter_Control_In_Run_Mode : BOOL; (*Inserter Control in Run Mode SS3*)
		Inserter_Guard_Eye : BOOL; (*Inserter Guard Eye EE30*)
		Discharge_Guard_Eye : BOOL; (*Discharge Guard Eye EE5*)
		Pallet_On_Conveyor_2_After : BOOL; (*Pallet On Conveyor 2 After EE17*)
		Pallet_On_Conveyor_1_After : BOOL; (*Pallet On Conveyor 1 After EE16*)
		Drive1_Running : BOOL; (*Drive 1 Running VFD1*)
		Drive4_OverCurrent : BOOL; (*Drive 4 OverCurrent VFD4*)
		Motor_Protectors : BOOL; (*Motor Protectors OL*)
		Row_Pusher_At_PreGrouping : BOOL; (*Row Pusher At PreGrouping PR12*)
		Row_Pusher_Is_Down : BOOL; (*Row Pusher Is Down PR10*)
		Row_Pusher_Is_Up : BOOL; (*Row Pusher Is Up PR9*)
		MACHINE_ESTOPS_OK : BOOL; (*Machine ESTOPS*)
		ESTOPS_OK : BOOL; (*E-STOPS OKAY PB1*)
		Pallet_Chains_Are_Up : BOOL; (*Pallet Chains Are Up PR35*)
		Turn_Table_Is_Up_NOP : BOOL; (* TurnTable is Up-NOP PR23*)
		Turn_Table_Is_Down : BOOL; (* TurnTable is Down PR22*)
		Screen_Access : BOOL; (*Screen Access SS1*)
		AuxVFDsOk : BOOL; (*Auxiliar VFD's OK*)
		InserterAtMagazine : BOOL; (*Inserter At Magazine PR28*)
		InserterVacuumCupsIsDown : BOOL; (*Inserter Vacuum Cups Is Down PR27*)
		InserterIsDown : BOOL; (*Inserter is Down PR29*)
		InserterTierSheetBeltSlack : BOOL; (*Inserter Tier Sheet Belt Slack *)
		InserterLowTierSheetLevel : BOOL; (*Low Tier Sheet Level EE10*)
		InserterIsUp : BOOL; (*Inserter is Up PR26*)
		InserterSheetHeld : BOOL; (*Inserter Tier Sheet Held EE15*)
		Turn_Table_CW_Stop_Position : BOOL; (*Turn Table CW Stop Position PR24*)
	END_STRUCT;
END_TYPE

(*********************************************************************************							

	Machine Digital Outputs								

*********************************************************************************)

TYPE
	machineDO_typ : 	STRUCT 
		MachineFaultBeacon_LT1 : BOOL; (*Machine Fault Beacon LT1*)
		MachineOkBeacon_LT2 : BOOL; (*Machine OK Beacon LT2*)
		PalletLowSupplyBeacon_LT3 : BOOL; (*Pallet Low Supply Beacon Light LT3*)
		LayerStopBarRaise_M3F : BOOL; (*Layer Bar Raise M3F*)
		LayerStopBarLower_M3R : BOOL; (*Layer Bar Lower M3R*)
		RowFormingRollers_M5 : BOOL; (*Grouping Rollers M5*)
		ProductInfeedCV_M6 : BOOL; (*Product Infeed Belt M6*)
		PalletDispenserCV_M7 : BOOL; (*Pallet Dispenser Conveyor M7*)
		PalletDispenserRaise_M8F : BOOL; (*Pallet Dispenser Raise M8F*)
		PalletDispenserLower_M8R : BOOL; (*Pallet Dispenser Lower M8R*)
		CustomerMachineRunning_CR4 : BOOL; (*Customer Facing Machine Running CR4*)
		CustomerMachineRunning_CR5 : BOOL; (*Customer Facing Machine Running CR5*)
		AirDump_SOL0 : BOOL; (*Air Dump SOL0*)
		TransferTableToGrouping_M2R : BOOL; (*Transfer Table To Grouping M2R*)
		TransferTableToPallet_M2F : BOOL; (*Transfer Table To Pallet M2F*)
		RowPusherReturn_M4R : BOOL; (*VFD4 REV*)
		RowPusherForward_M4F : BOOL; (*VFD4 FWD*)
		PalletClawsOpen_SOL7B : BOOL; (*Open Pallet Dispenser Claws SOL7B*)
		PalletClawsClose_SOL7A : BOOL; (*Close Pallet Dispenser Claws SOL7A*)
		FrontSquaringRetract_SOL11B : BOOL; (*End/Front Squaring Retract SOL11B*)
		FrontSquaringExtend_SOL11A : BOOL; (*End/Front Squaring Extend SOL11A*)
		SideSquaringRetract_SOL8B : BOOL; (*Side Squaring Retract SOL8B*)
		SideSquaringExtend_SOL8A : BOOL; (*Side Squaring Extend SOL8A*)
		BladeStop1Up_SOL3A : BOOL; (*Blade Stop 1 Lower SOL3B*)
		BladeStop1Dw_SOL3B : BOOL; (*Blade Stop 1 Raise SOL3A*)
		BladeStop2Up_SOL4A : BOOL; (*Blade Stop 1 Lower SOL3B*)
		BladeStop2Dw_SOL4B : BOOL; (*Blade Stop 1 Raise SOL3A*)
		BladeStop3Up_SOL5A : BOOL; (*Blade Stop 1 Lower SOL3B*)
		BladeStop3Dw_SOL5B : BOOL; (*Blade Stop 1 Raise SOL3A*)
		BladeStop4Up_SOL6A : BOOL; (*Blade Stop 1 Lower SOL3B*)
		BladeStop4Dw_SOL6B : BOOL; (*Blade Stop 1 Raise SOL3A*)
		BladeStop5Up_SOL13A : BOOL; (*Blade Stop 1 Lower SOL3B*)
		BladeStop5Dw_SOL13B : BOOL; (*Blade Stop 1 Raise SOL3A*)
		BladeStop6Up_SOL14A : BOOL; (*Blade Stop 1 Lower SOL3B*)
		BladeStop6Dw_SOL14B : BOOL; (*Blade Stop 1 Raise SOL3A*)
		CaseTurnerLower_SOL2B : BOOL; (*Case Turner Lower SOL2B*)
		CaseTurnerRaise_SOL2A : BOOL; (*Case Turner Raise SOL2A*)
		ZZZZZZZZZZZZZZZZZZZZZZZZZZZ : USINT;
		Full_Pallet_Conveyor : BOOL; (*Full Pallet Conveyor #VFD11FWD*)
		Full_Pallet_Conveyor_1_After : BOOL; (*Full Pallet Conveyor 1 After VFD12 # VFD12 FWD*)
		InserterHorizontalBrakeRelay : BOOL; (*Inserter Horizontal Brake Relay*)
		InserterVerticalBrakeRelay : BOOL; (*Inserter Vertical Brake Relay*)
		ElevatorSlow : BOOL; (*VFD1 DI2*)
		ElevatorRaise : BOOL; (*VFD1 FWD*)
		ElevatorLower : BOOL; (*VFD1 REV*)
		ElevatorFast : BOOL; (*VFD1 D1*)
		RowPusherFast : BOOL; (*VFD4 DI1*)
		VFD1BrakeRelay : BOOL; (*VFD1 Brake Relay CR1*)
		BladeStop4Lower : BOOL; (*Blade Stop 4 Lower SV6B*)
		BladeStop4Raise : BOOL; (*Blade Stop 4 Raise SV6A*)
		BladeStop3Lower : BOOL; (*Blade Stop 3 Lower SV5B*)
		BladeStop3Raise : BOOL; (*Blade Stop 3 Raise SV5A*)
		BladeStop2Lower : BOOL; (*Blade Stop 2 Lower SV4B*)
		BladeStop2Raise : BOOL; (*Blade Stop 2 Raise SV4A*)
		RowPusherLower : BOOL; (*Row Pusher Lower SV1B*)
		RowPusherRaise : BOOL; (*Row Pusher Raise SV1A*)
		VFD4BrakeRelay : BOOL; (*VFD4 Brake Relay CR2*)
		SheetInserterToPalletizer : BOOL; (*Sheet Inserter To Palletizer VFD10 REV*)
		SheetInserterHorizontalFastSpeed : BOOL; (*Sheet Inserter Horizontal Fast Speed VFD10 DI1*)
		SheetInserterRaise : BOOL; (*Sheet Inserter Raise VFD9 REV*)
		SheetInserterLower : BOOL; (*Sheet Inserter Lower VFD9 FWD*)
		SheetInserterVerticalSlowSpeed : BOOL; (*Sheet Inserter Vertical Slow Speed VFD9 DI1*)
		SheetInserterLockout : BOOL; (*Sheet Inserter Lockout SV9*)
		SheetInserterVacuum : BOOL; (*Sheet Inserter Vacuum SV10*)
		SheetInserterToMagazine : BOOL; (*Sheet Inserter To Magazine VFD10 FWD*)
		PalletChainsLower : BOOL; (*Pallet Chains Lower SV12B*)
		PalletChainsRaise : BOOL; (*Pallet Chains Raise SV12A*)
		CustomerPalletDischargingSignal : BOOL; (*Customer Pallet Discharging Signal CR5*)
		BladeStop6Lower : BOOL; (*Blade Stop 6 Lower SOL14B*)
		BladeStop6Raise : BOOL; (*Blade Stop 6 Raise SOL14A*)
		BladeStop5Lower : BOOL; (*Blade Stop 5 Lower SV13B*)
		BladeStop5Raise : BOOL; (*Blade Stop 5 Raise SV13A*)
		GroupingRollersSlowSpeed : BOOL; (*GroupingRollersSlowSpeed*)
	END_STRUCT;
END_TYPE

(**)
