<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	var SetupDelayTime=100; //毫秒
	var IntroState=false;
	var srb,path;
	
	function SetupNow(){
		if(doc.getElementById("systempath").value!=""){
			path=HTMLEncode(doc.getElementById("systempath").value);
			srb=doc.getElementById("SetupReviewBox");
			srb.innerHTML="";
			IntroState=true;
			SetupReview("系统导入开始 目标系统地址：" + path);
			setTimeout("ConfigFileCheck()",SetupDelayTime);
		}else{
			alert("请先指定待导入系统的目标文件夹！");
		}
	}
	
	function ConfigFileCheck(){
		SetupReview("系统配置文件检测 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=configfilecheck",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("ConfigCheck()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：需要的配置文件不存在！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function ConfigCheck(){
		SetupReview("系统配置文件分析 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=configcheck",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("LogoOnlyOneCheck()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：配置文件的结构不符合标准！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function LogoOnlyOneCheck(){
		SetupReview("系统各项标识唯一性检测 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=logoonlyonecheck",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("InterfaceCheck()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：导入系统的某些标识与管理平台重复，请修改！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function InterfaceCheck(){
		SetupReview("系统接口配对设置 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=interfacecheck",xml,"body","","",false);
		if(xml_BackCont=="no need"){
			SetupReview("<font color=green>通过</font>",2);
			setTimeout("SystemSetup()",SetupDelayTime);
		}else if(xml_BackCont=="no param"){
			SetupReview("<font color=green>跳过</font>",2);
			setTimeout("SystemSetup()",SetupDelayTime);
		}else if(xml_BackCont=="has param"){
			SetupReview("<font color=blue>配对中 ...</font>",2);
			setTimeout("InterfaceSet()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：系统接口配对设置出错了！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function InterfaceSet(){
		var interfaceRt=ModelWin("JCP_ArtSys_Intro_Action_ProperSet.asp?action=interfaceset",400,320);
		if(interfaceRt=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("SystemSetup()",SetupDelayTime);
		}else if(interfaceRt=="SKIP"){
			SetupReview("<font color=blue>跳过绑定</font>",2);
			setTimeout("SystemSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>绑定出错了</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function SystemSetup(){
		SetupReview("将系统、系统栏目创建至管理平台 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=systemsetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("FileCopy()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：系统创建出错！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function FileCopy(){
		SetupReview("拷贝相关文件 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=filecopy",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("DatabaseSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：拷贝相关文件出错！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function DatabaseSetup(){
		SetupReview("创建数据表 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=databasesetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("ConfigSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：创建数据表出错！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
/*	
	function PurviewSetup(){
		SetupReview("为系统创建相应权限及权限组 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=purviewsetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("ConfigSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：创建系统相应权限(组)出错！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function BlockSetup(){
		SetupReview("将系统模块创建至管理平台 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=blocksetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("ConfigSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：创建模块出错！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
*/
	function ConfigSetup(){
		SetupReview("将系统配置文件创建至管理平台 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=configsetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>成功</font>",2);
			setTimeout("LogSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：重建系统配置文件出错！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function LogSetup(){
		SetupReview("保存系统导入日志 ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=logsetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			IntroState=false;
			SetupReview("<font color=green>成功</font>",2);
			top.frames["menus_box"].location.reload();			//刷新左侧导航栏
			setTimeout("SetupClose(true)",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>失败：日志文件创建出错！</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>失败：" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function SetupClose(err){
		if(err) SetupReview("系统导入<font color=green><b>成功</b></font>！");
			else SetupReview("系统导入<font color=red><b>失败</b></font>！");
		if(!IntroState) SetupReview("系统导入结束！");
	}
	
	function UnSetup(){
		SetupReview("<font color=red>因系统导入出错，进入卸载流程</font> ...");
		IntroState=false;
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=unsetup",null,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>完成</font>",2);
		}else{
			SetupReview("<font color=blue>卸载出错！</font>",2);
			SetupReview("<font color=blue>" + xml_BackCont + "</font>");
		}
		SetupClose(false);
	}
	
	function SetupReview(strs,num){
		if(num){
			srb.lastChild.innerHTML += "	" + strs
		}else{
			var t_Div=doc.createElement("<div></div>");
			t_Div.innerHTML=strs;
			srb.appendChild(t_Div);
		}
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">导入系统</div>
	<div class="manage_button"><a href="JCP_ArtSys_Manage.asp">返回管理</a></div>
	<div class="manage_button_cur">导入系统</div>
	<div style="float:left;width:100%;text-align:center;">
		<hr style="width:100%;height:1px;">
		<input type="text" id="systempath" name="systempath" value="" readonly style="width:200px;">
		<input type="button" class="system_button_00" value="查找系统目录" onClick="SetupReviewBox.innerHTML='** 请选择目标系统地址！';FindServerFile('systempath');">
		<input type="button" class="system_button_00" value="执行导入" onClick="SetupNow()">
		<hr style="width:100%;height:1px;">
	</div>
	<div id="SetupReviewBox" style="line-height:1.6;">** 请选择目标系统地址！</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>