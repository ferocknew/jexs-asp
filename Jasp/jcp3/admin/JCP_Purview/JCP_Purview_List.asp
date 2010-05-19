<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<% 
	dim rs,teamids,actid,i:i=0
	actid=J.NumberYn(request.querystring("actid"))
%>
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Purview.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript" type="text/javascript">
<!--
var doc=document;
function PurviewSet(){
	var id="0";var count=0;
	for(i=0;i<doc.getElementsByName('ModelID').length;i++){
		if(doc.getElementsByName('ModelID')[i].checked){
			id +="," + document.getElementsByName('ModelID')[i].value;
			count++;
		}
	}
	window.returnValue='o.options.length=0;';
	if(count>0){
		startXmlRequest("GET","JCP_Purview_Action.asp?action=setteam&teamids=" + id.substring(2,id.length) + "&teamid=<%= actid %>",null,"body","","",false);
		if(xml_BackCont) window.returnValue+=xml_BackCont;
	}else{
		startXmlRequest("GET","JCP_Purview_Action.asp?action=setteam&teamids=&teamid=<%= actid %>",null,"body","","",false);
		window.returnValue+='o.options.add(new Option("未设置权限明细",0));';
	}
	window.returnValue+='o.options.add(new Option("────────",0));' +
						'o.options.add(new Option("添加权限明细",-1));';
	window.close();
}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div id="purviewListBox">
		<div class="item" style="background-color:#EFEFEF;">
			<span class="item_checkbox"><input type="checkbox" id="checkboxs" name="checkboxs" class="select" onclick="for(i=0;i<document.getElementsByName('ModelID').length;i++)document.getElementsByName('ModelID')[i].checked=this.checked;"></span>
			<span class="item_title">权限描述</span>
		</div>
	<% 
	teamids=J.Data.Exe("select ','&purv_ids&',' from JCP_purviewteam where id="&actid)(0)
	set rs=J.Data.Exe("select * from JCP_purview order by purv_name")
	if rs.eof then
	%>
		<div class="item">暂时没有权限信息！</div>
	<% 
	else
		dim curpurid
		do while not rs.eof
	%>
		<div class="item" actid="<%= rs("id") %>">
			<span class="item_checkbox"><input type="checkbox" id="checkbox_<%= i %>" name="ModelID" class="select" value="<%= rs("id") %>" <% if instr(teamids,","&rs("id")&",")>0 then response.write "checked" %>></span>
			<span class="item_title" onDblClick="TextChange(this,'NameChange(o)');"><%= rs("purv_name") %></span>
		</div>
	<%
			i=i+1
			rs.movenext
		loop
	end if
	rs.close
	%>
	</div>
	<div style="width:100%;float:left;text-align:center;margin-top:10px;">
		<input type="button" class="system_button_00" value=" 设 置 " onClick="PurviewSet();">
		<input type="button" class="system_button_00" value=" 取 消 " onClick="window.close();">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>