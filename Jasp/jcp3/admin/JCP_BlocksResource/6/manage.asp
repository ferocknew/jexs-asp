<%
dim pAttribute,rslist,i,k
pAttribute=split(BlockAttribute,"{$|}")

dim t_tableid,t_classfrom,t_subclass,t_classid,t_blockorderfield,t_blockorder,t_usedfields,t_blockelement,t_blockoutside,t_pgsize,t_outlink,t_blockpageinfo
dim t_tablename,t_classinfo,t_classrs,t_orderinfo,t_fieldlist,t_fields,t_fieldstitle,t_link
dim t_rscount,t_maxrsid,t_pgcount,t_prevpg,t_nextpg,sql

t_tableid=pAttribute(0)
t_classfrom=pAttribute(1)
t_subclass=pAttribute(2)
t_classid=pAttribute(3)
t_blockorderfield=pAttribute(4)
t_blockorder=pAttribute(5)
t_usedfields=pAttribute(6)
t_blockelement=pAttribute(7)
t_blockoutside=pAttribute(8)
t_pgsize=pAttribute(9)
t_outlink=pAttribute(10)
t_blockpageinfo=pAttribute(11)

t_tablename="Article_" & t_tableid
if t_classfrom="1" then t_classid=ClassID
if t_classid<>"" then
	dim t_classidparam:t_classidparam=split(t_classid,"&")
	t_classrs=J.Data.GetRows("select item_id from JCP_ArtSys where sys_id=" & t_tableid & " and item_type='class' order by item_order")
	for i=0 to ubound(t_classrs,2)
		t_classinfo=t_classinfo & " and " & t_classrs(0,i) & "_class=" & t_classidparam(i)
	next
end if
if t_blockorderfield<>"0" then t_orderinfo=t_blockorderfield & " " & t_blockorder
t_fieldlist=split(t_usedfields,"|"):t_fields=""
for i=0 to ubound(t_fieldlist)
	if t_fields="" then
		t_fields=split(t_fieldlist(i),"=")(0)
		t_fieldstitle=split(t_fieldlist(i),"=")(1)
	else
		t_fields=t_fields & "," & split(t_fieldlist(i),"=")(0)
		t_fieldstitle=t_fieldstitle & "," & split(t_fieldlist(i),"=")(1)
	end if
next
t_link=",id"
if instr(t_outlink,"_link")>0 then t_link=t_link & "," & t_outlink	

dim paramfields,paramfieldstitle,t_html
paramfields=split(t_fields,",")
paramfieldstitle=split(t_fieldstitle,",")

t_html=t_blockelement
for k=0 to ubound(paramfieldstitle)
	t_html=replace(t_html,paramfieldstitle(k),"[%= rs(" & k & ",ii) %]")
next
if instr(t_link,"_link")>0 then
	if TemplateType=4 then
		t_html=replace(t_html,"<link ","<a href=""[% if len(trim(rs(" & (ubound(paramfields) + 2) & ",ii) & "" ""))>8 then response.write rs(" & (ubound(paramfields) + 2) & ",ii) else response.write """ & J.WebPath & "/" & t_tableid & "," & replace(t_classid,"&",",") & "/Content"" & rs(" & (ubound(paramfields) + 1) & ",ii) & ""." & curJCP.FileExt & """ %]"" ")
	else
		t_html=replace(t_html,"<link ","<a href=""[% if len(trim(rs(" & (ubound(paramfields) + 2) & ",ii) & "" ""))>8 then response.write rs(" & (ubound(paramfields) + 2) & ",ii) else response.write ""../" & t_tableid & "," & replace(t_classid,"&",",") & "/Content"" & rs(" & (ubound(paramfields) + 1) & ",ii) & ""." & curJCP.FileExt & """ %]"" ")
	end if
else
	if TemplateType=4 then
		t_html=replace(t_html,"<link ","<a href=""" & J.WebPath & "/" & t_tableid & "," & replace(t_classid,"&",",") & "/Content" & "[%= rs(" & (ubound(paramfields) + 1) & ",ii) %]" & "." & curJCP.FileExt & """ ")
	else
		t_html=replace(t_html,"<link ","<a href=""../" & t_tableid & "," & replace(t_classid,"&",",") & "/Content" & "[%= rs(" & (ubound(paramfields) + 1) & ",ii) %]" & "." & curJCP.FileExt & """ ")
	end if
end if
t_html=replace(t_html,"</link>","</a>")
BlockHTML=BlockHTML & t_html

t_blockpageinfo=replace(t_blockpageinfo,"{分页信息}","[% page.ShowPage() %]")

BlockHTML="" & vbcrlf & _
	"<!--#include file=""../../JCP_Inc/Class_JCP.asp""-->" & vbcrlf & _
	"<" & "script language=""JavaScript"" src=""../../JCP_Script/showpage.js""><" & "/script>" & vbcrlf & _
	"[%" & vbcrlf & _
	"dim main,classid,pgsize" & vbcrlf & _
	"pgsize=" & t_pgsize & vbcrlf & _
	"" & vbcrlf & _
	"set Main=new JCP" & vbcrlf & _
	"Main.WebOpen server.mapPath(""../../" & curJCP.ManageFolder & "/" & curJCP.DataPath & "/" & curJCP.DataName & """)" & vbcrlf & _
	"" & vbcrlf & _
	"dim page,rscount,ii,rs" & vbcrlf & _
	"set page=Main.Page(""" & t_fields & t_link &"$" & t_tablename & "$deleted=0" & t_classinfo & "$" & t_orderinfo & "$id"",pgsize)" & vbcrlf & _
	"rscount=page.RecCount()" & vbcrlf & _
	"rs=page.ResultSet()" & vbcrlf & _
	"if rscount<1 then" & vbcrlf & _
	"	response.write ""暂无内容！""" & vbcrlf & _
	"else" & vbcrlf & _
	"	for ii=0 to Ubound(rs,2)" & vbcrlf & _
	"%]" & vbcrlf & _
	"		" & BlockHTML & vbcrlf & _
	"[%" & vbcrlf & _
	"	next" & vbcrlf & _
	"end if" & vbcrlf & _
	"%]" & vbcrlf & _
	t_blockpageinfo & vbcrlf & _
	"[%" & vbcrlf & _
	"Main.WebClose()" & vbcrlf & _
	"%]"

if instr(t_blockoutside,"列表")>0 then BlockHTML=replace(t_blockoutside,"列表",BlockHTML)
%>