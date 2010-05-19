<% dim pAttribute,rslist,i,k
pAttribute=split(BlockAttribute,"{$|}")

dim t_tableid,t_classfrom,t_subclass,t_classid,t_blockorderfield,t_blockorder,t_usedfields,t_blockelement,t_blockoutside,t_pgsize,t_outlink
dim t_tablename,t_classinfo,t_classrs,t_orderinfo,t_fieldlist,t_fields,t_fieldstitle,t_link
dim sql

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

t_tablename="Article_" & t_tableid
if t_classfrom="1" then t_classid=ClassID
if t_classid<>"" then
	dim t_classidparam:t_classidparam=split(t_classid,"&")
	t_classrs=J.Data.GetRows("select item_id from JCP_ArtSys where sys_id=" & t_tableid & " and item_type='class' order by item_order")
	for i=0 to ubound(t_classrs,2)
		t_classinfo=t_classinfo & " and " & t_classrs(0,i) & "_class=" & t_classidparam(i)
	next
end if
if t_blockorderfield<>"0" then t_orderinfo=" order by " & t_blockorderfield & " " & t_blockorder
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

sql="select top " & t_pgsize & " " & t_fields & t_link & " from " & t_tablename & " where deleted=0" & t_classinfo & t_orderinfo
'response.write sql
rslist=J.Data.GetRows(sql)
if isempty(rslist) then
	BlockHTML="document.write('暂无内容！');"
else
	dim paramfields,paramfieldstitle,t_html
	paramfields=split(t_fields,",")
	paramfieldstitle=split(t_fieldstitle,",")
	for i=0 to ubound(rslist,2)
		t_html=t_blockelement
		for k=0 to ubound(rslist,1)-ubound(split(t_link,","))
			t_html=replace(t_html,paramfieldstitle(k),rslist(k,i)&"")
		next
		if instr(t_link,"_link")>0 then
			if len(rslist(ubound(rslist,1),i))>8 then
				t_html=replace(t_html,"<link ","<a href=""" & rslist(ubound(rslist,1),i) & """ ")
			else
				if TemplateType=4 then
					t_html=replace(t_html,"<link ","<a href=""../../" & J.WebPath & "/" & t_tableid & "," & replace(t_classid,"&",",") & "/Content" & rslist(ubound(rslist,1)-1,i) & "." & J.FileExt & """ ")
				else
					t_html=replace(t_html,"<link ","<a href=""../../" & J.WebPath & "/" & t_tableid & "," & replace(t_classid,"&",",") & "/Content" & rslist(ubound(rslist,1)-1,i) & "." & J.FileExt & """ ")
				end if
			end if
		else
			if TemplateType=4 then
				t_html=replace(t_html,"<link ","<a href=""../../" & J.WebPath & "/" & t_tableid & "," & replace(t_classid,"&",",") & "/Content" & rslist(ubound(rslist,1),i) & "." & J.FileExt & """ ")
			else
				t_html=replace(t_html,"<link ","<a href=""../../" & J.WebPath & "/" & t_tableid & "," & replace(t_classid,"&",",") & "/Content" & rslist(ubound(rslist,1),i) & "." & J.FileExt & """ ")
			end if
		end if
		t_html=replace(t_html,"</link>","</a>")
		BlockHTML=BlockHTML & t_html & vbcrlf
	next
end if

if instr(t_blockoutside,"列表")>0 then BlockHTML=replace(t_blockoutside,"列表",BlockHTML)
%>