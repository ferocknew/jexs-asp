<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<!--#include file="../JCP_Shared/body.asp" -->
<%  
if request.QueryString("action")="template" then
	dim TemplateName,TemplateExp,TemplateID,TemplateType,TemplateCode,TemplateTableID,TemplateClassIDs,TemplateGuideOrder,TemplateHtmlPathYN,TemplateHtmlPath,TemplateBlockIDs
	TemplateName=request.Form("Template_Name")
	TemplateExp=request.Form("Template_Exp")
	TemplateID=request.Form("Template_ID")
	TemplateType=request.Form("Template_Type")
	TemplateCode=request.Form("Template_Code")
	TemplateTableID=request.Form("Template_TableID")
	TemplateClassIDs=request.Form("Template_ClassIDs")
	TemplateGuideOrder=request.Form("Template_GuideOrder")
	TemplateHtmlPathYN=Cbool(request.Form("Template_HtmlPathYN"))
	if TemplateHtmlPathYN then TemplateHtmlPath=request.Form("Template_HtmlPath") else TemplateHtmlPath=""
	dim rs
	set rs=J.Data.RsOpen("select * from JCP_Template where id=" & TemplateID,3)
	TemplateBlockIDs=TemplateStyle
	if rs.eof then
		rs.addnew
		rs("TemplateName")=TemplateName
		rs("TemplateExp")=TemplateExp
		rs("TemplateType")=TemplateType
		rs("TemplateCode")=TemplateCode
		rs("TemplateTableID")=TemplateTableID
		rs("TemplateClassIDs")=TemplateClassIDs
		rs("TemplateGuideOrder")=TemplateGuideOrder
		rs("TemplateHtmlPathYN")=TemplateHtmlPathYN
		rs("TemplateHtmlPath")=TemplateHtmlPath
		rs("TemplateBlockIDs")=TemplateBlockIDs
		rs.update
		%>
		<div class="result">
			<div class="manage_exp">新模板添加成功！</div>
			<div class="result_button"><span>[<a href="JCP_TemplateAdd.asp">继续添加</a>]</span><span>[<a href="JCP_TemplateManage.asp" onMouseMove="javascript:window.status='进入管理';">进入管理</a>]</span></div>
		</div>
		<%
	else
		rs("templatename")=TemplateName
		rs("TemplateExp")=TemplateExp
		rs("TemplateType")=TemplateType
		rs("TemplateCode")=TemplateCode
		rs("TemplateTableID")=TemplateTableID
		rs("TemplateClassIDs")=TemplateClassIDs
		rs("TemplateGuideOrder")=TemplateGuideOrder
		rs("TemplateHtmlPathYN")=TemplateHtmlPathYN
		rs("TemplateHtmlPath")=TemplateHtmlPath
		rs("TemplateBlockIDs")=TemplateBlockIDs
		rs.update
	''''''''''''''''''''''''''''''''''''''''''''''
		'收集自动推送所需的必要信息    开始
		J.Template.PushInfo "",TemplateID,0,TemplateType,J
		'结束
	''''''''''''''''''''''''''''''''''''''''''''''
		%>
		<div class="result">
			<div class="manage_exp">模板修改成功！</div>
			<div class="result_button"><span>[<a href="JCP_TemplateAdd.asp?action=template&templateid=<%= TemplateID %>&Page=<%= request.querystring("Page") %>&templatetype=<%= request.QueryString("templatetype") %>">重新修改</a>]</span><span>[<a href="JCP_TemplateAdd.asp">新建模板</a>]</span><span>[<a href="JCP_TemplateManage.asp?Page=<%= request.QueryString("Page") %>&templatetype=<%= request.QueryString("templatetype") %>" onMouseMove="javascript:window.status='进入管理';">进入管理</a>]</span></div>
		</div>
		<%
	end if
	rs.close
else

end if

function TemplateStyle()
	dim re,match,matches,rere,blockids,tStyle,tBlockid
	set re=new RegExp
	set rere=new RegExp
	re.pattern="<\s*block(\s+blockid=""?\d+""?)?(\s+blockname=""?[^<>]+""?)?(\s+blockid=""?\d+""?)?\s*>"
	rere.pattern="blockid=""?(\d+)""?"
	re.IgnoreCase=True
	rere.IgnoreCase=True
	re.Global=true
	rere.Global=true
	set matches=re.Execute(TemplateCode)
	tStyle=""
	blockids="0"
	for each match in matches
		tBlockid=replace(replace(Lcase(rere.Execute(match.value).item(0)),"blockid=",""),"""","")
		if not(instr(","&blockids&",",","&tBlockid&",")>0) then blockids = blockids & "," & tBlockid
	next
	set matches=nothing
	set re=nothing

'模板组合模块样式表，目前不提供此功能	
	'if instr(blockids,",")>0 then
	'	dim rss
	'	set rss=J.Data.ReRsOpen("select id,blockname,blockstyle from JCP_BlockList where id in ("&blockids&") and blockstyle<>'' order by id","rss",1)
	'	do while not rss.eof
	'		tStyle = tStyle & "/* 模块样式　名称：" & rss("blockname") & "　ID：" & rss("id") & " */" & vbcrlf & vbcrlf & rss("blockstyle") & vbcrlf & vbcrlf & vbcrlf
	'		rss.movenext
	'	loop
	'	rss.close
	'end if
	
	if tStyle<>"" then
		J.fso.FolderN J.SiteRoot & J.WebCssPath
		J.fso.FileN J.SiteRoot & J.WebCssPath & "\Template_" & TemplateID & ".CSS",tStyle
	else
		if J.fso.FileE(J.SiteRoot & J.WebCssPath & "\Template_" & TemplateID & ".CSS") then J.fso.FileD J.SiteRoot & J.WebCssPath & "\Template_" & TemplateID & ".CSS"
	end if
	
	if blockids="0" then TemplateStyle="" else TemplateStyle=right(blockids,len(blockids)-2)
end function
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>