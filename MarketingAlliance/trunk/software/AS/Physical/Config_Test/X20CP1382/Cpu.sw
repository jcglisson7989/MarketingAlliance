<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.2.7.54 SP?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="runFirst" Source="UserLibraries.wbrServices.InitSP.runFirst.prg" Memory="UserROM" Language="ANSIC" BuildOptions="-D &quot;str(x)=#x&quot; -D AS_PROJ=str($(AS_PROJECT_NAME)) -D AS_CFG=str($(AS_CONFIGURATION)) -D &quot;AS_VERS=str($(AS_VERSION))&quot; -D &quot;AS_USER=str($(AS_USER_NAME))&quot; -D &quot;AS_CMPNY=str($(AS_COMPANY_NAME))&quot; -D &quot;AS_BUILD_MODE=str($(AS_BUILD_MODE))&quot;" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8">
    <Task Name="wbrService" Source="UserLibraries.wbrServices.Cyclic.wbrService.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="HMITableMa" Source="pkgPVListView.HMITableManager.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="paiHmi" Source="paiComponents.paiTemplate.paiHMI.paiHmi.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="AlarmX" Source="pkgAlert.AlarmX.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="ComLogger" Source="pkgAlert.ComLogger.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="File_Handl" Source="pkgData.File_Handling.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="paiFS" Source="paiComponents.paiFileService.paiFS.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <Task Name="Recipe_Han" Source="pkgRecCfg.Recipe_Handling.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="paiUser" Source="paiComponents.paiUser.paiUser.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
  </TaskClass>
  <DataObjects>
    <DataObject Name="Acp10sys" Source="" Memory="UserROM" Language="Binary" />
    <DataObject Name="Arnc0sys" Source="" Memory="UserROM" Language="Binary" />
  </DataObjects>
  <NcDataObjects>
    <NcDataObject Name="acp10etxen" Source="acp10etxen.dob" Memory="UserROM" Language="Ett" />
  </NcDataObjects>
  <VcDataObjects>
    <VcDataObject Name="WSVGA" Source="HMI.WSVGA.dob" Memory="UserROM" Language="Vc" WarningLevel="2" Compress="false" />
  </VcDataObjects>
  <Binaries>
    <BinaryObject Name="vccpopup" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccddbox" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="LinkUserX" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="deltaTch" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="LinkLogin" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="deltaCtrl" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="deltaPath" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="cncSpindle" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="cncAxes" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="deltaJoint" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="cncSystem" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Energy" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="verabd" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcbclass" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccscale" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ariblk" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcxml" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpdsw" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccdt" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccurl" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="WSVGA02" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arialbd" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcchspot" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcdsloc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccshape" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcdsint" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcalarm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcctrend" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccbmp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcctext" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcclbox" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcrt" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccbtn" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccstr" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcchtml" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arial" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccline" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcfntttf" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcfile" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcshared" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccovl" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="WSVGA03" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccnum" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccslider" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="aplib" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcinter" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcgclass" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vera" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Acp10map" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arnc0cfg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Arnc0map" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="acp10cfg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="AlarmXHist" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="File_Mgmt" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="webXs" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="RecCfg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlarmXCore" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="WSVGA01" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vctcal" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcmgr" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcnet" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpdvnc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="visvc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vcpfar00" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vclibvc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TC" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccalarm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccdbox" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vccpwd" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="cour" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="wbrsprintf" Source="UserLibraries.wbrServices.wbrsprintf.lby" Memory="None" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="bgringbuf" Source="paiComponents.Libraries.bgringbuf.lby" Memory="None" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="sprintf2" Source="paiComponents.Libraries.sprintf2.lby" Memory="None" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ArEventLog" Source="Libraries.ArEventLog.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArProf" Source="Libraries.AsArProf.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsMem" Source="Libraries.AsMem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ArTextSys" Source="Libraries.ArTextSys.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsANSL" Source="Libraries.AsANSL.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsARCfg" Source="Libraries.AsARCfg.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArSdm" Source="Libraries.AsArSdm.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsBrMath" Source="Libraries.AsBrMath.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsBrWStr" Source="Libraries.AsBrWStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsCont" Source="Libraries.AsCont.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsHost" Source="Libraries.AsHost.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsICMP" Source="Libraries.AsICMP.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIO" Source="Libraries.AsIO.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIOAcc" Source="Libraries.AsIOAcc.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIODiag" Source="Libraries.AsIODiag.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIOTime" Source="Libraries.AsIOTime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsFltGen" Source="Libraries.AsFltGen.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsMath" Source="Libraries.AsMath.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsOpcUac" Source="Libraries.AsOpcUac.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsPciStr" Source="Libraries.AsPciStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsXml" Source="Libraries.AsXml.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsTCP" Source="Libraries.AsTCP.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsUDP" Source="Libraries.AsUDP.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="dvframe" Source="Libraries.dvframe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsUSB" Source="Libraries.AsUSB.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsWStr" Source="Libraries.AsWStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpCom" Source="Libraries.MpCom.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAlarmX" Source="Libraries.MpAlarmX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAudit" Source="Libraries.MpAudit.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="vclib" Source="Libraries.vclib.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="visapi" Source="Libraries.visapi.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpFile" Source="Libraries.MpFile.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpRecipe" Source="Libraries.MpRecipe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpWebXs" Source="Libraries.MpWebXs.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="vncserv" Source="Libraries.vncserv.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="wbrMemSvc" Source="UserLibraries.wbrServices.wbrMemSvc.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="wbrListSvc" Source="UserLibraries.wbrServices.wbrListSvc.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="wbrLogSvc" Source="UserLibraries.wbrServices.wbrLogSvc.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="bglibasWBR" Source="UserLibraries.wbrServices.bglibasWBR.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="wbrPingSvc" Source="UserLibraries.wbrServices.wbrPingSvc.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="wbrFltUtil" Source="UserLibraries.wbrServices.wbrSvcUtilities.wbrFltUtil.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="wbrBytUtil" Source="UserLibraries.wbrServices.wbrSvcUtilities.wbrBytUtil.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="wbrBitUtil" Source="UserLibraries.wbrServices.wbrSvcUtilities.wbrBitUtil.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="AsIecCon" Source="Libraries.AsIecCon.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="operator" Source="Libraries.operator.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="VA_Setup" Source="UserLibraries.jgLibs.VA_Setup.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="jgUtils" Source="UserLibraries.jgLibs.jgUtils.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="paiPVTable" Source="pkgPVListView.paiPVTable.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="AsEPL" Source="Libraries.AsEPL.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArLog" Source="Libraries.AsArLog.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="jgLibC" Source="UserLibraries.jgLibs.jgLibC.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="Acp10man" Source="Libraries.Acp10man.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10par" Source="Libraries.Acp10par.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="NcGlobal" Source="Libraries.NcGlobal.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10sdc" Source="Libraries.Acp10sdc.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10sim" Source="Libraries.Acp10sim.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10_MC" Source="Libraries.Acp10_MC.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAxis" Source="Libraries.MpAxis.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="vcresman" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="powerlnk" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="aruser" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>