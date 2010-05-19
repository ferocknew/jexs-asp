<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_ArtSys.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript">
function SysDel(id){
	if(confirm("您确定要删除此系统？？\n\n注意：系统删除后，系统中的原有数据将全部丢失！！")){
		startXmlRequest("POST","JCP_ArtSys_Action.asp?action=del&menuid="+id,null,"body","alert(xml_BackCont)","",false)
		location.reload();
		top.frames['menus_box'].location.reload();
	}
}

function SysUnInstall(logo){
	if(confirm("您确定要卸载此系统？？\n\n注意：系统卸载后，系统中的原有数据将全部丢失！！")){
		startXmlRequest("POST","JCP_ArtSys_Action.asp?action=uninstall&logo="+logo,null,"body","","",false)
		if(xml_BackCont=="OK"){
			alert("系统卸载成功！！");
			location.reload();
			top.frames['menus_box'].location.reload();
		}else{
			alert("系统卸载出错了！\n\n原因：" + xml_BackCont);
		}
	}
}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">定制管理</div>
	<div class="manage_button"><a href="JCP_ArtSys.asp?sysid=0">新建系统</a></div>
	<div class="manage_button"><a href="JCP_ArtSys_Intro.asp">导入系统</a></div>
	<div id="fieldbox">
	<% 
		dim rs,cur_type
		cur_type=0
		set rs=J.Data.Exe("select menuid,menutitle,typeid,menulogo from JCP_AppSystem order by typeid,menuid")
		do while not rs.eof
			if rs("typeid")<>cur_type then
				if cur_type>0 then response.write "</fieldset>"
				if rs("typeid")=1 then
					response.write "<fieldset><legend>自建系统</legend>"
				elseif rs("typeid")=2 then
					response.write "<fieldset><legend>导入系统</legend>"
				end if
				cur_type=rs("typeid")
			end if
			if rs("typeid")=1 then
				response.write "<li class=sysitem>" & vbcrlf _
							 & "<span class=sysname>" & rs("menutitle") & "</span>" & vbcrlf _
							 & "<span class=mod_button onclick=""javascript:location='JCP_ArtSys.asp?sysid="&rs("menuid")&"';"" title=""修改""></span><span class=del_button onclick=""SysDel("&rs("menuid")&");"" title=""删除""></span>" & vbcrlf _
							 & "</li>" & vbcrlf
			elseif rs("typeid")=2 then
				response.write "<li class=sysitem>" & vbcrlf _
							 & "<span class=sysname>" & rs("menutitle") & "</span>" & vbcrlf _
							 & "<span class=del_button onclick=""SysUnInstall('"&rs("menulogo")&"');"" title=""卸载""></span>" & vbcrlf _
							 & "</li>" & vbcrlf
			end if
			rs.movenext
		loop
		if cur_type>0 then response.write "</fieldset>"
		rs.close
	%>
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>