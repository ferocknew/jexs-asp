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
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	
	function Deltemplate(id){
		if(confirm("您确定要删除当前模板吗？？")){
			if(!id){
				id="0";
				for(i=0;i<document.getElementsByName('templateID').length;i++)
					if(document.getElementsByName('templateID')[i].checked) id += "," + document.getElementsByName('templateID')[i].value;
			}
			if(id=="0"){
				alert("请选择需要删除的模板！");
				return false;
			}
			startXmlRequest("POST","JCP_TemplateAction_XML.asp?action=deltemplate&templateid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("模板删除出错啦！");
				doc.write(xml_BackCont);
			}
		}
	}
	function Copytemplate(id){
		if(confirm("您确定要复制当前模板吗？")){
			startXmlRequest("POST","JCP_TemplateAction_XML.asp?action=copytemplate&templateid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				alert("模板复制成功！");
				location.reload();
			}else{
				alert("模板复制出错啦！");
				doc.write(xml_BackCont);
			}
		}
	}
	function templateList(){
		location='?templatetype=' + doc.getElementById("templatetype").value.toString();
	}
	
	function templateEdit(templatesid){
		location="JCP_TemplateAdd.asp?action=template&Page=<%= request.QueryString("Page") %>&templateid=" + templatesid + "&templatetype=<%= request.querystring("templatetype") %>";
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">模板管理</div>
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
		<span id="newtemplate"><input type=button class="system_button_00" value="添加模板" onclick="location='JCP_TemplateAdd.asp';"></span>
	</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('templateID').length;i++)document.getElementsByName('templateID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:120px;">名　　称</span><span class="distline"></span><span>类　　型</span><span class="distline"></span><span style="width:300px;">说　　明</span><span class="distline"></span><span>操　　作</span>
		</div>
		<% 
		dim page,rs,rscount,pagesize
		pagesize=13
		set page=J.Page("id,templatename,templatetype,templateexp$JCP_Template$"&templatetype&"$id desc$id",pagesize)
		rscount=page.RecCount()
		rs=page.ResultSet()
		if rscount<1 then
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">暂无模板！</div>"
		else
			for i=0 to ubound(rs,2)
				response.write "<div class=""list"">" & _
							   "<span style=""width:30px;""><input name=""templateID"" id=""templateID"" type=""checkbox"" value="""&rs(0,i)&""" class=""select""></span>" & _
							   "<span class=""distline_list""></span><span style=""width:120px;"">"&rs(1,i)&"</span>" & _
							   "<span class=""distline_list""></span><span>"&J.Model(rs(2,i))&"</span>" & _
							   "<span class=""distline_list""></span><span style=""width:300px;text-align:left;padding-left:10px;"">"&rs(3,i)&"</span>" & _
							   "<span class=""distline_list""></span>" & _
							   		"<span>" & _
							   			"<span class=""mod_button"" title=""修改模板"" onclick=""templateEdit("&rs(0,i)&");""></span>" & _
							   			"<span class=""del_button"" title=""删除模板"" onclick=""Deltemplate("&rs(0,i)&");""></span>" & _
							   			"<span class=""copy_button"" title=""复制模板"" onclick=""Copytemplate("&rs(0,i)&");""></span>" & _
							   		"</span>" & _
							   "</div>"
			next
		end if
		page.ShowPage()
		%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="删除所选项" onclick="Deltemplate();">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>