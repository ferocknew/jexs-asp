<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Push.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/TemplatePush.js"></script>
<script language="JavaScript" type="text/JavaScript">
	var doc=document;
	
	function PushCheck(){
		PushNow("PushCollect();");
	}
	
	function PushCollect(){
		addPushCase("","","������վ��ҳ",4);
	}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
		<div id="push_button">
			<input name="pushnow" type="button" class="system_button_00" value="������վ��ҳ ���ո�" onClick="PushCheck()">
		</div>
		<div style="float:left;width:100%;padding:10px;">˵���������ܽ�ͬʱ����ȫվ�Ķ���ҳ�桢����JSģ�鼰��վ��ҳ��</div>
		<script language="JavaScript">
			document.onkeypress=function keypush(){if(event.keyCode==32){document.all.pushnow.blur();document.all.pushnow.click();}}
			pushBar("0%","#FFFFFF","#000000","100%","20px","2px");
		</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
