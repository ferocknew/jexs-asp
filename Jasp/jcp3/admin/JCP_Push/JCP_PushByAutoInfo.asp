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
		response.write "		addPushCase("""","""",""������վ��ҳ"",4);" & vbcrlf
		response.write "		addPushCase("""","""",""���Ͷ���ҳ�桡ȫվ"",3);" & vbcrlf
		response.write "		addPushCase("""","""",""��������JS��ȫվ"",5);" & vbcrlf
	end if
	do while not rs.eof
		if rs("templatename")&""<>"" then t_templatename="ģ�壺"&rs("templatename") else t_templatename="ģ��ID��"&rs("templateid")
		t_classinfo=replace(rs("classinfo"),"&","|")
		select case rs("pushtype")
			case 0
				if rs("templateid")>0 and rs("classinfo")<>"" then
					response.write "		addPushCase(""s,i"","""&t_classinfo&","&rs("templateid")&""",""������Ŀ��ҳ����ĿID��"&t_classinfo&"��"&t_templatename&""",0);" & vbcrlf
				elseif rs("classinfo")<>"" then
					response.write "		addPushCase(""s"","""&t_classinfo&""",""������Ŀ��ҳ����ĿID��"&t_classinfo&""",0);" & vbcrlf
				elseif rs("templateid")>0 then
					response.write "		addPushCase(""i"","""&rs("templateid")&""",""������Ŀ��ҳ��ģ��ID��"&rs("templateid")&"��"&t_templatename&""",0);" & vbcrlf
				else
					response.write "		addPushCase("""","""",""������Ŀ��ҳ��ȫվ"",0);" & vbcrlf
				end if
			case 1
				if rs("templateid")>0 and rs("classinfo")<>"" then
					response.write "		addPushCase(""s,i"","""&t_classinfo&","&rs("templateid")&""",""������Ŀ�б���ĿID��"&t_classinfo&"��"&t_templatename&""",1);" & vbcrlf
				elseif rs("classinfo")<>"" then
					response.write "		addPushCase(""s"","""&t_classinfo&""",""������Ŀ�б���ĿID��"&t_classinfo&""",1);" & vbcrlf
				elseif rs("templateid")>0 then
					response.write "		addPushCase(""i"","""&rs("templateid")&""",""������Ŀ�б�ģ��ID��"&rs("templateid")&"��"&t_templatename&""",1);" & vbcrlf
				else
					response.write "		addPushCase("""","""",""������Ŀ�б�ȫվ"",1);" & vbcrlf
				end if
			case 2
				if rs("articleid")>0 and rs("classinfo")<>"" and rs("templateid")>0 then
					response.write "		addPushCase(""s,s,i"","""&t_classinfo&","&rs("articleid")&","&rs("templateid")&""",""��Ŀ����ҳ�桡��ĿID��"&t_classinfo&"��"&t_templatename&"������ID��"&rs("articleid")&""",2);" & vbcrlf
				elseif rs("articleid")>0 and rs("classinfo")<>"" then
					response.write "		addPushCase(""s,s"","""&t_classinfo&","&rs("articleid")&""",""������Ŀ���ݡ���ĿID��"&t_classinfo&"������ID��"&rs("articleid")&""",2);" & vbcrlf
				elseif rs("templateid")>0 and rs("classinfo")<>"" then
					response.write "		addPushCase(""s,i"","""&t_classinfo&","&rs("templateid")&""",""������Ŀ���ݡ���ĿID��"&t_classinfo&"��"&t_templatename&""",2);" & vbcrlf
				elseif rs("classinfo")<>"" then
					response.write "		addPushCase(""s"","""&t_classinfo&""",""������Ŀ���ݡ���ĿID��"&t_classinfo&""",2);" & vbcrlf
				elseif rs("templateid")>0 then
					response.write "		addPushCase(""i"","""&rs("templateid")&""",""������Ŀ���ݡ�ģ��ID��"&rs("templateid")&"��"&t_templatename&""",2);" & vbcrlf
				else
					response.write "		addPushCase("""","""",""������Ŀ���ݡ�ȫվ"",2);" & vbcrlf
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
		if(confirm("��ȷ���Ѿ�������Щ����??\n\n�Ƿ�����Զ����±���ռ�����������")){
			startXmlRequest("POST","JCP_Push_XML.asp?action=clearpushinfo",null,"body","","",false);
			if(xml_BackCont=="OK"){
				alert("�������������Ѿ���ȫɾ����");
				location.reload();
			}else alert("������������ɾ��ʧ���ˣ�����ϵͳ��");
		}
	}

	function PushCaseView(){
		if(PushCaseViewBox.innerHTML==""){
			if(PushCase.length>0){
				var _viewList="";
				for(i=0;i<PushCase.length;i++) _viewList += (i+1).toString() + ". " + PushCase[i][2] + "<br>";	
				PushCaseViewBox.innerHTML = _viewList; 
				PushCaseViewBox.style.display="block";
			}else alert("δ�����κ���������!");
		}else{
			PushCaseViewBox.style.display="none";
			PushCaseViewBox.innerHTML="";
		}
		clearPushCase();
	}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
		<div id="push_button">
			<input name="pushnow" type="button" class="system_button_00" value="�Զ���������޸�ҳ�� ���ո�" onClick="PushCheck()">
			<input name="pushcaseview" type="button" class="system_button_00" value="�鿴/�ر� ��������" onClick="if(PushCaseViewBox.innerHTML==''){PushCollect()};PushCaseView();">
			<input name="pushclear" type="button" class="system_button_00" value="����Զ����������" onClick="ClearPushInfo()">
		</div>
		<div id="PushCaseViewBox" style="padding-left:10px;display:none;"></div>
		<div style="float:left;width:100%;padding:10px;">
			˵���������ܽ��С�ѡ���ԡ��ظ��±��޸�ҳ�棬ͬʱ�������ж���ҳ�桢����JSģ�����վ��ҳ��
		</div>
		<script language="JavaScript">
			document.onkeypress=function keypush(){if(event.keyCode==32){document.all.pushnow.blur();document.all.pushnow.click();}}
			pushBar("0%","#FFFFFF","#000000","100%","20px","2px");
		</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
