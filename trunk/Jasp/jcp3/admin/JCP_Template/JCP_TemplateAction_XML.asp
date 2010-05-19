<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
dim rs,templatename,templateid,i

if request.querystring("action")="templatenamecheck" then
	templatename=J.BlankYn(request.querystring("templatename"))
	templateid=J.NumberYN(request.querystring("templateid"))
	set rs=J.Data.Exe("select id from JCP_Template where templatename='"&templatename&"' and id<>" & templateid)
	if rs.eof then
		response.write "OK"
	end if
	rs.close
elseif request.querystring("action")="deltemplate" then
	dim t_templateid
	templateid=request.querystring("templateid")
	if replace(templateid,",","")<>"" then J.NumberYn replace(templateid,",","")
	J.Data.Exe("delete from JCP_Template where id in ("&templateid&")")
	t_templateid=split(templateid,",")
	for i=0 to ubound(t_templateid)
		if J.fso.FileE(J.SiteRoot & J.WebCssPath & "\Template_" & t_templateid(i) & ".CSS") then J.fso.FileD J.SiteRoot & J.WebCssPath & "\Template_" & t_templateid(i) & ".CSS"
	next
	response.write "OK"
elseif request.querystring("action")="copytemplate" then
	templateid=J.NumberYn(request.querystring("templateid"))
	set rs=J.Data.Exe("select * from JCP_Template where id="&templateid)
	if rs.eof then
		response.write "ERROR"
	else
		dim rss,modyn,copyi,t_templatename
		templatename=rs("templatename")
		modyn=true
		copyi=0
		do while modyn
			copyi=copyi+1
			t_templatename=templatename & " 复件" & copyi
			set rss=J.Data.ReRsOpen("select * from JCP_Template where templatename='"&t_templatename&"'","rss",3)
			if rss.eof then
				rss.addnew
				rss("templatename")=t_templatename
				rss("templateexp")=rs("templateexp")
				rss("templatetype")=rs("templatetype")
				rss("templatecode")=rs("templatecode")
				rss("TemplateTableID")=rs("TemplateTableID")
				rss("TemplateClassIDs")=rs("TemplateClassIDs")
				rss("TemplateGuideOrder")=rs("TemplateGuideOrder")
				rss("TemplateHtmlPathYN")=rs("TemplateHtmlPathYN")
				rss("TemplateHtmlPath")=rs("TemplateHtmlPath")
				rss.update
				if J.fso.FileE(J.SiteRoot & J.WebCssPath & "\Template_" & rs("id") & ".CSS") then J.fso.FileC J.SiteRoot & J.WebCssPath & "\Template_" & rs("id") & ".CSS",J.SiteRoot & J.WebCssPath & "\Template_" & rss("id") & ".CSS"
				rss.close
				modyn=false
				response.write "OK"
			end if
		loop
	end if
	rs.close
elseif request.querystring("action")="gettableclass" or request.querystring("action")="gettableclassedit" then
	dim tableid,classids,cur_classid,itemnames,ids,guideorder
	cur_classid=""
	itemnames=""
	ids=""
	tableid=J.NumberYn(request.querystring("tableid"))
	guideorder=J.NumberYn(request.QueryString("guideorder"))
	if request.querystring("action")="gettableclassedit" then
		dim requestS,xml,root
		set xml = Server.CreateObject("Microsoft.XMLDOM")
		xml.async = false
		requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
		xml.loadXML(requestS)
		If xml.parseError.errorCode <> 0 Then response.write "不能正确接收数据" & "Description: " & xml.parseError.reason & "<br>Line: " & xml.parseError.Line
		set root = xml.documentElement
		classids = root.selectSingleNode("classids").text
		set root = nothing
		set xml  = nothing
	else
		classids=request.querystring("classids")
	end if
	
	set rs=J.Data.Exe("select item_content,item_name,item_id from JCP_ArtSys where item_type='class' and sys_id="&tableid&" order by display_order")
	do while not rs.eof
		if cur_classid="" then
			cur_classid=rs(0)
			itemnames=rs(1)
			ids=rs(2)
		else
			cur_classid=cur_classid & "," & rs(0)
			itemnames=itemnames & "," & rs(1)
			ids=ids & "," & rs(2)
		end if
		rs.movenext
	loop
	rs.close
	
	if cur_classid<>"" then
		dim classname,rootid,itemid,sign,selected,sql,classparam,nameparam,idparam,inclass,t_classids
		classparam=split(cur_classid,",")
		inclass=split(classids&"|","|")
		for i=0 to ubound(classparam)
			response.write "<select name=""TemplateTableClassSelect"&i&""" id=""TemplateTableClassSelect"&i&""" size=""4"" onClick=""TemplateTable_SetClass(this);"" onDblClick=""TemplateTable_SetClass(this,true);"">"
			sql="select * from JCP_class where ','&parentpath like '%,"&classparam(i)&",%' order by orderid"
			set rs=J.Data.Exe(sql)
				do while not rs.eof
					if rs("classname")&""="" then classname="No Name" else classname=rs("classname")
					sign=string(2*(rs("classgrade")-1),"　")
					if rs("parentid")>0 then
						if rs("classson")>0 then
							sign=sign & "◇"
						else
							sign=sign & "◆"
						end if
					end if
					if i<=ubound(inclass) then t_classids=inclass(i) & "," else t_classids=""
					if instr(t_classids,"," & rs("classid") & ",")>0 then 
						response.write "<option value="""&rs("classid")&""" title="""&rs("parentpath")&""">√| "&sign&" "&classname&"</option>"
					else
						response.write "<option value="""&rs("classid")&""" title="""&rs("parentpath")&""">　| "&sign&" "&classname&"</option>"
					end if
					rs.movenext
				loop
			rs.close
			response.write "</select>"
		next
		response.write "<div style=""padding-top:4px;"">导航采用： <select name=""TemplateTableGuideSelect"" id=""TemplateTableGuideSelect"">"
		nameparam=split(itemnames,",")
		idparam=split(ids,",")
		for i=0 to ubound(nameparam)
			if guideorder=Cstr(i+1) then
				response.write "<option value="""&(i+1)&""" selected>" & nameparam(i) & "</option>"
			else
				response.write "<option value="""&(i+1)&""">" & nameparam(i) & "</option>"
			end if
		next
		response.write "</select></div>"
	end if
end if
%>
<% J.close %>