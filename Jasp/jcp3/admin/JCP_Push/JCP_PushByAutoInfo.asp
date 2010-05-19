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
<%
	dim rs,t_templatename,t_classinfo,sql
	sql="select JCP_AutoPushInfo.*,JCP_Template.TemplateName from JCP_AutoPushInfo left join JCP_Template on JCP_AutoPushInfo.templateid=JCP_Template.id where adminid=" & session("JCP_AdminID")
	set rs=J.Data.RsOpen(sql,3)
	if not rs.eof then
		response.write "		addPushCase("""","""",""推送网站首页"",4);" & vbcrlf
		response.write "		addPushCase("""","""",""推送独立页面　全站"",3);" & vbcrlf
		response.write "		addPushCase("""","""",""推送数据JS　全站"",5);" & vbcrlf
	end if
	do while not rs.eof
		if rs("templatename")&""<>"" then t_templatename="模板："&rs("templatename") else t_templatename="模板ID："&rs("templateid")
		t_classinfo=replace(rs("classinfo"),"&","|")
		select case rs("pushtype")
			case 0
				if rs("templateid")>0 and rs("classinfo")<>"" then
					response.write "		addPushCase(""s,i"","""&t_classinfo&","&rs("templateid")&""",""推送栏目首页　栏目ID："&t_classinfo&"　"&t_templatename&""",0);" & vbcrlf
				elseif rs("classinfo")<>"" then
					response.write "		addPushCase(""s"","""&t_classinfo&""",""推送栏目首页　栏目ID："&t_classinfo&""",0);" & vbcrlf
				elseif rs("templateid")>0 then
					response.write "		addPushCase(""i"","""&rs("templateid")&""",""推送栏目首页　模板ID："&rs("templateid")&"　"&t_templatename&""",0);" & vbcrlf
				else
					response.write "		addPushCase("""","""",""推送栏目首页　全站"",0);" & vbcrlf
				end if
			case 1
				if rs("templateid")>0 and rs("classinfo")<>"" then
					response.write "		addPushCase(""s,i"","""&t_classinfo&","&rs("templateid")&""",""推送栏目列表　栏目ID："&t_classinfo&"　"&t_templatename&""",1);" & vbcrlf
				elseif rs("classinfo")<>"" then
					response.write "		addPushCase(""s"","""&t_classinfo&""",""推送栏目列表　栏目ID："&t_classinfo&""",1);" & vbcrlf
				elseif rs("templateid")>0 then
					response.write "		addPushCase(""i"","""&rs("templateid")&""",""推送栏目列表　模板ID："&rs("templateid")&"　"&t_templatename&""",1);" & vbcrlf
				else
					response.write "		addPushCase("""","""",""推送栏目列表　全站"",1);" & vbcrlf
				end if
			case 2
				if rs("articleid")>0 and rs("classinfo")<>"" and rs("templateid")>0 then
					response.write "		addPushCase(""s,s,i"","""&t_classinfo&","&rs("articleid")&","&rs("templateid")&""",""栏目内容页面　栏目ID："&t_classinfo&"　"&t_templatename&"　数据ID："&rs("articleid")&""",2);" & vbcrlf
				elseif rs("articleid")>0 and rs("classinfo")<>"" then
					response.write "		addPushCase(""s,s"","""&t_classinfo&","&rs("articleid")&""",""推送栏目内容　栏目ID："&t_classinfo&"　数据ID："&rs("articleid")&""",2);" & vbcrlf
				elseif rs("templateid")>0 and rs("classinfo")<>"" then
					response.write "		addPushCase(""s,i"","""&t_classinfo&","&rs("templateid")&""",""推送栏目内容　栏目ID："&t_classinfo&"　"&t_templatename&""",2);" & vbcrlf
				elseif rs("classinfo")<>"" then
					response.write "		addPushCase(""s"","""&t_classinfo&""",""推送栏目内容　栏目ID："&t_classinfo&""",2);" & vbcrlf
				elseif rs("templateid")>0 then
					response.write "		addPushCase(""i"","""&rs("templateid")&""",""推送栏目内容　模板ID："&rs("templateid")&"　"&t_templatename&""",2);" & vbcrlf
				else
					response.write "		addPushCase("""","""",""推送栏目内容　全站"",2);" & vbcrlf
				end if
			case 3,4,5
		end select
		rs("sessionid")=session.SessionID
		rs.movenext
	loop
	rs.close
%>
	}
	
	function ClearPushInfo(){
		if(confirm("您确定已经更新这些请求??\n\n是否清空自动更新表的收集的推送请求？")){
			startXmlRequest("POST","JCP_Push_XML.asp?action=clearpushinfo",null,"body","","",false);
			if(xml_BackCont=="OK"){
				alert("现有推送请求已经完全删除！");
				location.reload();
			}else alert("现有推送请求删除失败了，请检查系统！");
		}
	}

	function PushCaseView(){
		if(PushCaseViewBox.innerHTML==""){
			if(PushCase.length>0){
				var _viewList="";
				for(i=0;i<PushCase.length;i++) _viewList += (i+1).toString() + ". " + PushCase[i][2] + "<br>";	
				PushCaseViewBox.innerHTML = _viewList; 
				PushCaseViewBox.style.display="block";
			}else alert("未发现任何推送任务!");
		}else{
			PushCaseViewBox.style.display="none";
			PushCaseViewBox.innerHTML="";
		}
		clearPushCase();
	}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
		<div id="push_button">
			<input name="pushnow" type="button" class="system_button_00" value="自动更新相关修改页面 （空格）" onClick="PushCheck()">
			<input name="pushcaseview" type="button" class="system_button_00" value="查看/关闭 推送任务" onClick="if(PushCaseViewBox.innerHTML==''){PushCollect()};PushCaseView();">
			<input name="pushclear" type="button" class="system_button_00" value="清空自动更新请求表" onClick="ClearPushInfo()">
		</div>
		<div id="PushCaseViewBox" style="padding-left:10px;display:none;"></div>
		<div style="float:left;width:100%;padding:10px;">
			说明：本功能将有“选择性”地更新被修改页面，同时更新所有独立页面、数据JS模块和网站首页！
		</div>
		<script language="JavaScript">
			document.onkeypress=function keypush(){if(event.keyCode==32){document.all.pushnow.blur();document.all.pushnow.click();}}
			pushBar("0%","#FFFFFF","#000000","100%","20px","2px");
		</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
