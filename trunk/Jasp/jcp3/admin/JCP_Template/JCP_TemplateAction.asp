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
			<div class="manage_exp">��ģ����ӳɹ���</div>
			<div class="result_button"><span>[<a href="JCP_TemplateAdd.asp">�������</a>]</span><span>[<a href="JCP_TemplateManage.asp" onMouseMove="javascript:window.status='�������';">�������</a>]</span></div>
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
		'�ռ��Զ���������ı�Ҫ��Ϣ    ��ʼ
		J.Template.PushInfo "",TemplateID,0,TemplateType,J
		'����
	''''''''''''''''''''''''''''''''''''''''''''''
		%>
		<div class="result">
			<div class="manage_exp">ģ���޸ĳɹ���</div>
			<div class="result_button"><span>[<a href="JCP_TemplateAdd.asp?action=template&templateid=<%= TemplateID %>&Page=<%= request.querystring("Page") %>&templatetype=<%= request.QueryString("templatetype") %>">�����޸�</a>]</span><span>[<a href="JCP_TemplateAdd.asp">�½�ģ��</a>]</span><span>[<a href="JCP_TemplateManage.asp?Page=<%= request.QueryString("Page") %>&templatetype=<%= request.QueryString("templatetype") %>" onMouseMove="javascript:window.status='�������';">�������</a>]</span></div>
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

'ģ�����ģ����ʽ��Ŀǰ���ṩ�˹���	
	'if instr(blockids,",")>0 then
	'	dim rss
	'	set rss=J.Data.ReRsOpen("select id,blockname,blockstyle from JCP_BlockList where id in ("&blockids&") and blockstyle<>'' order by id","rss",1)
	'	do while not rss.eof
	'		tStyle = tStyle & "/* ģ����ʽ�����ƣ�" & rss("blockname") & "��ID��" & rss("id") & " */" & vbcrlf & vbcrlf & rss("blockstyle") & vbcrlf & vbcrlf & vbcrlf
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