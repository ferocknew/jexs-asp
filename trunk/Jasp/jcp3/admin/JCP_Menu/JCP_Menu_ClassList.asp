<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<% 
	dim rs,teamids,actid,i:i=0
	actid=J.NumberYn(request.querystring("actid"))
%>
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Menu.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript" type="text/javascript">
<!--
var doc=document;
function ClassSet(){
	window.returnValue=doc.getElementById("Item_0_class").value;
	window.close();
}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div id="purviewListBox">
		<select id="Item_0_class" name="Item_0_class" style="width:274px;"></select>
		<script language="javascript">startXmlRequest("POST","../JCP_Script/JCP_Class_JS.asp?itemid=0&rootid=0&classid=<%= actid %>",null,"body","eval(xml_BackCont)","",false);</script>
	</div>
	<div style="width:100%;float:left;text-align:center;margin-top:10px;">
		<input type="button" class="system_button_00" value=" Éè ÖÃ " onClick="ClassSet();">
		<input type="button" class="system_button_00" value=" È¡ Ïû " onClick="window.close();">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>