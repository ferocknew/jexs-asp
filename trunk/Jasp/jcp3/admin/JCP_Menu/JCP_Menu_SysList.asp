<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<% 
	dim rs,teamids,actid,checked,i:i=0
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
		<select id="Item_0_class" name="Item_0_class" style="width:274px;">
		<% 
			set rs=J.Data.Exe("select menuid,menutitle from JCP_AppSystem where typeid=1 order by menuid")
			do while not rs.eof
				if actid=rs("menuid") then checked=" checked" else checked=""
				response.write "<option value="""&rs("menuid")&""""&checked&">" & rs("menutitle") & "</option>" & vbcrlf
				rs.movenext
			loop
			rs.close
		%>
		</select>
	</div>
	<div style="width:100%;float:left;text-align:center;margin-top:10px;">
		<input type="button" class="system_button_00" value=" Éè ÖÃ " onClick="ClassSet();">
		<input type="button" class="system_button_00" value=" È¡ Ïû " onClick="window.close();">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>