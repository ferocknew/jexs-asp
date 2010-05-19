<!--#include file="../JCP_Shared/asp_head.asp" -->
	<% 
	dim templatetype
	templatetype=trim(request.querystring("templatetype"))
	if isnumeric(templatetype) then
		if templatetype="" then 
			templatetype=""
		else
			templatetype=Cint(templatetype)
			if templatetype>ubound(J.Model) or templatetype<-1 then 
				templatetype=""
			else
				templatetype="templatetype="&templatetype
			end if
		end if
	else
		templatetype=""
	end if
	%>
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Push.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/TemplatePush.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	
	function PushCheck(){
		PushNow("PushCollect();");
	}
	
	function PushCollect(){
		var Template=document.getElementsByName('templateID');
		for(i=0;i<Template.length;i++){
			if(Template[i].checked){
				switch(Template[i].getAttribute("TemplateType"))
				{
					case "0":
						addPushCase("i",Template[i].value,"推送栏目首页　模板ID：" + Template[i].value +"　模板名称：" + Template[i].getAttribute("TemplateName"),0);
						break;
					case "1":
						addPushCase("i",Template[i].value,"推送栏目列表　模板ID：" + Template[i].value +"　模板名称：" + Template[i].getAttribute("TemplateName"),1);
						break;
					case "2":
						addPushCase("i",Template[i].value,"推送栏目内容　模板ID：" + Template[i].value +"　模板名称：" + Template[i].getAttribute("TemplateName"),2);
						break;
					case "3":
						addPushCase("i",Template[i].value,"推送独立页面　模板ID：" + Template[i].value +"　模板名称：" + Template[i].getAttribute("TemplateName"),3);
						break;
					case "4":
						addPushCase("i",Template[i].value,"推送网站首页　模板ID：" + Template[i].value +"　模板名称：" + Template[i].getAttribute("TemplateName"),4);
						break;
					default: return false;
				}
			}
		}
	}

	function templateList(){
		location='?templatetype=' + doc.getElementById("templatetype").value.toString();
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">模板推送</div>
	<div class="list_box" id="TemplateListBox" style="display:block;">
		<div id="manage_tools">
			<span id="templatetype_box">
				<select name="templatetype" id="templatetype" onChange="templateList()">
					<option value="">全部模板</option>"
					<% 
					dim i,selected
					for i=0 to ubound(J.Model)
						if Cstr(i)=replace(templatetype,"templatetype=","") then selected=" selected" else selected=""
						response.write "<option value="""&i&""""&selected&">"&J.Model(i)&"</option>"
					next
					%>
				</select>
			</span>
		</div>
		<div class="list_title" style="margin-top:4px;">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('templateID').length;i++)document.getElementsByName('templateID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:120px;">名　　称</span><span class="distline"></span><span>类　　型</span><span class="distline"></span><span style="width:300px;">说　　明</span>
		</div>
		<% 
		dim rs
		if templatetype<>"" then templatetype="where " & templatetype
		rs=J.Data.GetRows("select id,templatename,templatetype,templateexp from JCP_Template "&templatetype&" order by id desc")
		if isnull(rs) then
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">暂无模板！</div>"
		else
			for i=0 to ubound(rs,2)
				response.write "<div class=""list"">" & _
							   "<span style=""width:30px;""><input name=""templateID"" id=""templateID"" type=""checkbox"" value="""&rs(0,i)&""" class=""select"" TemplateType="""&rs(2,i)&""" TemplateName="""&rs(1,i)&"""></span>" & _
							   "<span class=""distline_list""></span><span style=""width:120px;"">"&rs(1,i)&"</span>" & _
							   "<span class=""distline_list""></span><span>"&J.Model(rs(2,i))&"</span>" & _
							   "<span class=""distline_list""></span><span style=""width:300px;text-align:left;padding-left:10px;"">"&rs(3,i)&"</span>" & _
							   "</div>"
			next
		end if
		%>
	</div>
		<div id="push_button">
			<input name="pushnow" type="button" class="system_button_00" value="按选择模板更新页面 （空格）" onClick="PushCheck()">
			<input name="pushcaseview" type="button" class="system_button_00" value="查看/关闭 模板列表" onClick="if(TemplateListBox.style.display=='none'){TemplateListBox.style.display='block'}else{TemplateListBox.style.display='none'}">
		</div>
		<div style="float:left;width:100%;padding:10px;">
			说明：本功能将按选择的模板对前台页面进行精确更新！
		</div>
		<script language="JavaScript">
			document.onkeypress=function keypush(){if(event.keyCode==32){document.all.pushnow.blur();document.all.pushnow.click();}}
			pushBar("0%","#FFFFFF","#000000","100%","20px","2px");
		</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>