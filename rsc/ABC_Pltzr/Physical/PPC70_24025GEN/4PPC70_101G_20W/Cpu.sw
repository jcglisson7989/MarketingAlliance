<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.2.4.149?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="diofilter" Source="MachineControl.diofilter.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="simonly" Source="MachineControl.simonly.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="alarms" Source="MachineControl.alarms.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="messages" Source="MachineControl.messages.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="machCtrl" Source="MachineControl.machCtrl.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="machzero" Source="MachineControl.machzero.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="vfdControl" Source="MachineControl.vfdControl.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="safety" Source="MachineControl.safety.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="counter" Source="Simulation.counter.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="machmode" Source="MachineControl.machmode.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="caseturner" Source="MachineControl.caseturner.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="blades" Source="MachineControl.blades.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="rowforming" Source="MachineControl.rowforming.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="transtable" Source="MachineControl.transtable.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="retainbar" Source="MachineControl.retainbar.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="squaring" Source="MachineControl.squaring.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="elevator" Source="MachineControl.elevator.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="elevmove" Source="MachineControl.elevmove.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="palletinfe" Source="MachineControl.palletinfcv.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="palletdisc" Source="MachineControl.palletdischarge.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="infcvidle" Source="MachineControl.infcvidle.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="palletinfa" Source="MachineControl.palletinfauto.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="animation" Source="MachineControl.animation.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="palProc" Source="MachineControl.palProc.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="drycycle" Source="MachineControl.drycycle.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="drycypal" Source="MachineControl.drycypal.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4">
    <Task Name="X64param" Source="ParameterDownload.X64_S44_Download.X64param.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="paiVFDX64" Source="paiComponents.paiBnRVFD.paiVFDX64.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8">
    <Task Name="paiHmi" Source="paiComponents.paiTemplate.paiHMI.paiHmi.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="paiFS" Source="paiComponents.paiFileService.paiFS.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="paiMp" Source="paiComponents.paiMp.paiMp.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="paiFileDT" Source="paiComponents.paiMp.paiFileDT.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="paiUser" Source="paiComponents.paiUser.paiUser.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="appHmi" Source="MachineControl.appHmi.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="appDraw" Source="MachineControl.appDraw.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="appCfgRec" Source="appConfigAndRecipes.appCfgRec.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="paiPingSer" Source="paiComponents.paiPing.paiPingService.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="read_data" Source="paiComponents.LibAsUSB1_ST.read_data.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
  </TaskClass>
  <VcDataObjects>
    <VcDataObject Name="WSVGA" Source="HMI.WSVGA.dob" Memory="UserROM" Language="Vc" WarningLevel="2" Compress="false" />
  </VcDataObjects>
  <Binaries>
    <BinaryObject Name="vccdt" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccbmp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccline" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcfile" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arial" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vctcal" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="WSVGA02" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcrt" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcmgr" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccstr" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcbclass" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccbtn" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcgclass" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcdsint" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcchtml" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccpwd" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcshared" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccddbox" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccscale" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arialbd" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcxml" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccnum" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccalarm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="visvc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccurl" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccslider" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcctext" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpdsw" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcfntttf" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccovl" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccshape" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ariblk" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="cour" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcctrend" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcclbox" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccpopup" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcdsloc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcchspot" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcalarm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="WSVGA01" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="WSVGA03" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpdvnc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpkat" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcnet" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccdbox" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpdi815" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcptelo" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpdihd" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpdi855" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpfppc7" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpk" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_4" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_3" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Config_2" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="vcpfar00" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="sprintf2" Source="paiComponents.Libraries.sprintf2.lby" Memory="None" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="bgringbuf" Source="paiComponents.Libraries.bgringbuf.lby" Memory="None" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="bglibas" Source="paiComponents.Libraries.bglibas.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIecCon" Source="Libraries.AsIecCon.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Operator" Source="Libraries.Operator.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsARCfg" Source="Libraries.AsARCfg.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsUPS" Source="Libraries.AsUPS.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsICMP" Source="Libraries.AsICMP.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpCom" Source="Libraries.MpCom.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpFile" Source="Libraries.MpFile.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpRecipe" Source="Libraries.MpRecipe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAlarm" Source="Libraries.MpAlarm.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="dvframe" Source="Libraries.dvframe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="visapi" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="vcresman" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="dataobj" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIOAcc" Source="Libraries.AsIOAcc.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsMem" Source="Libraries.AsMem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsMath" Source="Libraries.AsMath.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsEPL" Source="Libraries.AsEPL.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="CSV_File" Source="ParameterDownload.CSV_File.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="AsUSB" Source="Libraries.AsUSB.lby" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>