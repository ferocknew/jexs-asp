<%
dim pAttribute,rsguide,guidei
pAttribute=split(BlockAttribute,"{$|}")

dim t_discsign,t_needlink,guidestrs
dim paramClassID,classParentPath,t_guideClassID,t_guideClassID_sql
dim sql

t_discsign=pAttribute(0)
t_needlink=pAttribute(1)

if t_needlink="true" then
	guidestrs="<a href="""&J.SiteUrlRoot&""">首页</a>"
else
	guidestrs="首页"
end if

if ClassID<>"" then
	if instr(ClassID,"&")>0 then
		paramClassID=split(ClassID,"&")
		if ubound(paramClassID)>=TemplateGuideOrder-1 then
			classParentPath=J.Data.Exe("select parentpath from JCP_class where classid=" & paramClassID(TemplateGuideOrder-1))(0)
			for guidei=0 to ubound(paramClassID)
				if guidei=0 then
					if guidei=TemplateGuideOrder-1 then
						t_guideClassID="导航ID"
						t_guideClassID_sql="%,导航ID,%"
					else
						t_guideClassID=paramClassID(guidei)
						t_guideClassID_sql="%," & paramClassID(guidei) & ",%"
					end if
				else
					if guidei=TemplateGuideOrder-1 then
						t_guideClassID=t_guideClassID & ",导航ID"
						t_guideClassID_sql=t_guideClassID_sql & "|%,导航ID,%"
					else
						t_guideClassID=t_guideClassID & "," & paramClassID(guidei)
						t_guideClassID_sql=t_guideClassID_sql & "|%," & paramClassID(guidei) & ",%"
					end if
				end if
			next
		else
			classParentPath="0"
		end if
	else
		classParentPath=J.Data.Exe("select parentpath from JCP_class where classid=" & ClassID)(0)
		t_guideClassID="导航ID"
		t_guideClassID_sql="%,导航ID,%"
	end if
	
	if right(classParentPath,1)="," then classParentPath=left(classParentPath,len(classParentPath)-1)
	
	sql="select classid,classname from JCP_class where classid in (" & classParentPath & ") order by orderid"
	set rsguide=J.Data.ReRsOpen(sql,"rsguide",1)
	do while not rsguide.eof
		if t_needlink="true" then
			dim g_rs,g_webpath,g_file,g_guideClassID,g_guideClassID_sql
			g_guideClassID=replace(t_guideClassID,"导航ID",rsguide("classid"))
			g_guideClassID_sql=replace(t_guideClassID_sql,"导航ID",rsguide("classid"))
			if instr(g_guideClassID_sql,"|")>0 then
				'set g_rs=J.Data.ReRsOpen("select top 1 TemplateType,TemplateHtmlPathYN,TemplateHtmlPath,TemplateClassIDs from ((select top 1 1 as toporder,TemplateType,TemplateHtmlPathYN,TemplateHtmlPath,TemplateClassIDs from JCP_Template where TemplateTableID=" & TemplateTableID & " and TemplateClassIDs & ',' like '" & g_guideClassID_sql & "' order by TemplateType) union (select top 1 2 as toporder,TemplateType,TemplateHtmlPathYN,TemplateHtmlPath,TemplateClassIDs from JCP_Template where TemplateClassIDs & ',' like '%," & rsguide("classid") & ",%' and TemplateClassIDs not like '%|%' order by TemplateType)) order by toporder","g_rs",1)
				set g_rs=J.Data.ReRsOpen("select top 1 * from (select top 1 TemplateType,TemplateHtmlPathYN,TemplateHtmlPath,TemplateClassIDs,1 as toporder from JCP_Template where TemplateTableID=" & TemplateTableID & " and TemplateClassIDs & ',' like '" & g_guideClassID_sql & "'and TemplateType<2 order by TemplateType asc union all select top 1 TemplateType,TemplateHtmlPathYN,TemplateHtmlPath,TemplateClassIDs,2 as toporder from JCP_Template where TemplateClassIDs & ',' like '%," & rsguide("classid") & ",%' and TemplateClassIDs not like '%|%' and TemplateType=0) order by toporder","g_rs",1)
			else
				set g_rs=J.Data.ReRsOpen("select top 1 TemplateType,TemplateHtmlPathYN,TemplateHtmlPath,TemplateClassIDs from JCP_Template where TemplateTableID=" & TemplateTableID & " and TemplateClassIDs & ',' like '" & g_guideClassID_sql & "' order by TemplateType","g_rs",1)
			end if
			if g_rs.eof then
				guidestrs=guidestrs & t_discsign & rsguide("classname")
			else
				if g_rs("TemplateHtmlPathYN") then g_webpath=g_rs("TemplateHtmlPath") else g_webpath=J.WebPath
				if g_rs("TemplateType")=0 then
					if instr(g_rs("TemplateClassIDs"),"|")>0 then
						g_file = g_guideClassID & "/" & J.IndexName & "." & J.FileExt
					else
						g_file = rsguide("classid") & "/" & J.IndexName & "." & J.FileExt
					end if
					guidestrs=guidestrs & t_discsign & "<a href=""" & J.SiteUrlRoot & g_webpath & "/" & g_file & """>" & rsguide("classname") & "</a>"
				elseif g_rs("TemplateType")=1 then 
					g_file=TemplateTableID & "," & g_guideClassID & "," & TemplateGuideOrder & "/"
					guidestrs=guidestrs & t_discsign & "<a href=""" & J.SiteUrlRoot & g_webpath & "/" & g_file & """>" & rsguide("classname") & "</a>"
				else
					guidestrs=guidestrs & t_discsign & rsguide("classname")
				end if
			end if
			g_rs.close
		else
			guidestrs=guidestrs & t_discsign & rsguide("classname")
		end if
		rsguide.movenext
	loop
	rsguide.close
end if
	
BlockHTML=guidestrs
		
%>