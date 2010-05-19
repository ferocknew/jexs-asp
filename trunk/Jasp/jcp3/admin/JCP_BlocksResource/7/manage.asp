<%
dim pAttribute,rscont,i,k
pAttribute=split(BlockAttribute,"{$|}")

dim t_tableid,t_classid,t_usedfields,t_blockelement,t_blockoutside
dim t_tablename,t_fieldlist,t_fields,t_fieldstitle,t_link
dim t_articleid
dim t_pgcount,t_prevpg,t_nextpg,sql

t_tableid=pAttribute(0)
t_usedfields=pAttribute(1)
t_blockelement=pAttribute(2)
t_blockoutside=pAttribute(3)

t_articleid=ArticleID
t_tablename="Article_" & t_tableid
t_classid=ClassID
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

	
	sql="select " & t_fields & t_link & " from " & t_tablename & " where id=" & t_articleid
	rscont=J.Data.GetRows(sql)
	
	
		dim paramfields,paramfieldstitle,t_html,t_content,t_fieldtitle,tcontent,conti,contentpageinfo,t_blockhtml
		paramfields=split(t_fields,",")
		paramfieldstitle=split(t_fieldstitle,",")
		for i=0 to ubound(rscont,2)
			t_html=t_blockelement
			t_content="":t_fieldtitle=""
			for k=0 to ubound(rscont,1)-ubound(split(t_link,","))
				if instr(rscont(k,i),"[NextPage]")>0 and t_content="" and t_fieldtitle="" then
					t_content=rscont(k,i)
					t_fieldtitle=paramfieldstitle(k)
				else
					t_html=replace(t_html,paramfieldstitle(k),rscont(k,i)&"")
				end if
			next
			BlockHTML=BlockHTML & t_html & vbcrlf
		next
		
		tcontent=split(t_content,"[NextPage]")
		if ubound(tcontent)>0 then
			t_blockhtml=BlockHTML:BlockHTML=""
			if instr(t_blockoutside,"列表")>0 then t_blockhtml=replace(t_blockoutside,"列表",t_blockhtml)
			for contj=0 to ubound(tcontent)
				for conti=0 to ubound(tcontent)
					t_prevpg=contj:if t_prevpg<1 then t_prevpg=1
					t_nextpg=contj+2:if t_nextpg>ubound(tcontent)+1 then t_nextpg=ubound(tcontent)+1
					if conti=0 then
						contentpageinfo="<div style=""width:100%;text-align:center;"" class=""ContentPageInfo"">"
						if t_prevpg=1 then
							contentpageinfo=contentpageinfo & "<a href=""Content" & ArticleID & "." & J.FileExt & """>上页</a> "
						else
							contentpageinfo=contentpageinfo & "<a href=""Content" & ArticleID & "_" & t_prevpg & "." & J.FileExt & """>上页</a> "
						end if
					end if
					if contj=conti then
						contentpageinfo= contentpageinfo & " >" & (conti+1) & "< "
					else
						if conti=0 then
							contentpageinfo= contentpageinfo & " <a href=""Content" & ArticleID & "." & J.FileExt & """>[" & (conti+1) & "]</a> "
						else
							contentpageinfo= contentpageinfo & " <a href=""Content" & ArticleID & "_" & (conti+1) & "." & J.FileExt & """>[" & (conti+1) & "]</a> "
						end if
					end if
					if conti=ubound(tcontent) then contentpageinfo=contentpageinfo & " <a href=""Content" & ArticleID & "_" & t_nextpg & "." & J.FileExt & """>下页</a></div>"
				next

				tcontent(contj) = tcontent(contj) & contentpageinfo
				if contj<ubound(tcontent) then
					BlockHTML =BlockHTML & replace(t_blockhtml,t_fieldtitle,tcontent(contj)) & "[NextPage]"
				else
					BlockHTML =BlockHTML & replace(t_blockhtml,t_fieldtitle,tcontent(contj))
				end if
			next
		else
			BlockHTML=replace(BlockHTML,t_fieldtitle,t_content)
			if instr(t_blockoutside,"列表")>0 then BlockHTML=replace(t_blockoutside,"列表",BlockHTML)
		end if
%>