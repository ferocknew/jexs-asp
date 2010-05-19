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
		addPushCase("","","推送栏目首页　全站",0);
		addPushCase("","","推送栏目列表　全站",1);
		addPushCase("","","推送栏目内容　全站",2);
		addPushCase("","","推送独立页面　全站",3);
		addPushCase("","","推送数据JS　全站",5);
		addPushCase("","","推送网站首页",4);
	}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
		<div id="push_button">
			<input name="pushnow" type="button" class="system_button_00" value="更新全站所有数据 （空格）" onClick="PushCheck()">
		</div>
		<div style="float:left;width:100%;padding:10px;">说明：本功能将更新全站所有的静态页面，以及数据JS模块！</div>
		<script language="JavaScript">
			document.onkeypress=function keypush(){if(event.keyCode==32){document.all.pushnow.blur();document.all.pushnow.click();}}
			pushBar("0%","#FFFFFF","#000000","100%","20px","2px");
		</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
