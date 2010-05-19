<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Blocks.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	var blockfolder="<%= request.QueryString("src") %>";
	
	window.onunload=function(){window.dialogArguments.location.reload();}
	
	function State(strs,type){
		if(type==2){
			LoadList.innerHTML+=strs;
		}else{
			LoadList.innerHTML=strs;
		}
	}
	
	function Close(strs){
		LoadError.innerHTML=strs + '　　[<span onclick="javascript:window.close();" style="cursor:hand;">关闭</span>]';
	}
	
	function FindConfig(){
		State("查找模块源的配置文件...　　");
		startXmlRequest("POST","JCP_BlockAction_XML.asp?action=findconfig&src=" + blockfolder,null,"body","","",false);
		if(xml_BackCont=="OK"){
			State("成功",2);
			return true;
		}else{
			State("失败",2);
			Close("出错了，未找见模块源配置文件！");
			return false;
		}
	}
	
	function CheckConfig(){
		State("分析配置文件...　　");
		startXmlRequest("POST","JCP_BlockAction_XML.asp?action=checkconfig&src=" + blockfolder,null,"body","","",false);
		if(xml_BackCont=="OK"){
			State("成功",2);
			return true;
		}else{
			State("失败",2);
			Close("出错了，模块源配置文件格式有误！");
			return false;
		}
	}
	
	function LoadConfig(){
		State("加载配置文件...　　");
		startXmlRequest("POST","JCP_BlockAction_XML.asp?action=loadconfig&src=" + blockfolder,null,"body","","",false);
		if(xml_BackCont=="OK"){
			State("成功",2);
			return true;
		}else{
			State("失败",2);
			Close("出错了，模块源配置文件加载不成功！");
			return false;
		}
	}
	
	function EndLoad(){
		LoadError.innerHTML='<font color=green>恭喜，模块源加载成功！　　[<span onclick="javascript:window.close();" style="cursor:hand;">关闭</span>]</font>';
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
<div>
	<div><img src="../JCP_Skin/<%= session("SystemSkin") %>/images/loadbar.gif" style="width:100%;"></div>
	<div id="LoadList" style="padding-top:6px;">加载模块源...</div>
	<div id="LoadError" style="padding-top:4px;color:red;">-------------------------------------> [<span onclick="javascript:window.close();" style="cursor:hand;">关闭</span>]</div>
</div>
<script language="JavaScript" defer>
	if(FindConfig())
		if(CheckConfig())
			if(LoadConfig())
	EndLoad();
</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>