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
		LoadError.innerHTML=strs + '����[<span onclick="javascript:window.close();" style="cursor:hand;">�ر�</span>]';
	}
	
	function FindConfig(){
		State("����ģ��Դ�������ļ�...����");
		startXmlRequest("POST","JCP_BlockAction_XML.asp?action=findconfig&src=" + blockfolder,null,"body","","",false);
		if(xml_BackCont=="OK"){
			State("�ɹ�",2);
			return true;
		}else{
			State("ʧ��",2);
			Close("�����ˣ�δ�Ҽ�ģ��Դ�����ļ���");
			return false;
		}
	}
	
	function CheckConfig(){
		State("���������ļ�...����");
		startXmlRequest("POST","JCP_BlockAction_XML.asp?action=checkconfig&src=" + blockfolder,null,"body","","",false);
		if(xml_BackCont=="OK"){
			State("�ɹ�",2);
			return true;
		}else{
			State("ʧ��",2);
			Close("�����ˣ�ģ��Դ�����ļ���ʽ����");
			return false;
		}
	}
	
	function LoadConfig(){
		State("���������ļ�...����");
		startXmlRequest("POST","JCP_BlockAction_XML.asp?action=loadconfig&src=" + blockfolder,null,"body","","",false);
		if(xml_BackCont=="OK"){
			State("�ɹ�",2);
			return true;
		}else{
			State("ʧ��",2);
			Close("�����ˣ�ģ��Դ�����ļ����ز��ɹ���");
			return false;
		}
	}
	
	function EndLoad(){
		LoadError.innerHTML='<font color=green>��ϲ��ģ��Դ���سɹ�������[<span onclick="javascript:window.close();" style="cursor:hand;">�ر�</span>]</font>';
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
<div>
	<div><img src="../JCP_Skin/<%= session("SystemSkin") %>/images/loadbar.gif" style="width:100%;"></div>
	<div id="LoadList" style="padding-top:6px;">����ģ��Դ...</div>
	<div id="LoadError" style="padding-top:4px;color:red;">-------------------------------------> [<span onclick="javascript:window.close();" style="cursor:hand;">�ر�</span>]</div>
</div>
<script language="JavaScript" defer>
	if(FindConfig())
		if(CheckConfig())
			if(LoadConfig())
	EndLoad();
</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>