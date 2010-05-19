<!--#include file="../JCP_Shared/asp_head.asp" -->
<% 
dim rs,classid,templetid,pushpath,sysid,i,querys

if request.QueryString("action")="templatelistdisplay" then
	sysid=request.QueryString("sysid")
	if sysid<>"" then J.NumberYn sysid else sysid="0"
	querys=split(lcase(request.ServerVariables("QUERY_STRING")),"&")
	dim classparam,classes:classes=""
	for i=0 to ubound(querys)
		if instr(querys(i),"_class")>0 and instr(querys(i),"item_")>0 then
			classparam=split(querys(i),"=")
			if IsNumeric(classparam(1)) then
				if classes="" then
					classes="%," & classparam(1) & ",%" 
				else
					classes= classes & "|%," & classparam(1) & ",%"
				end if
			end if
		end if
	next
		if classes<>"" then classes=" and templateclassids & ',' like '" & classes & "'"
		
		set rs=J.Data.Exe("select id,templatename,templatetype from JCP_Template where templatetableid="&sysid&classes&" order by templatetype")
		if rs.eof then
			response.write "未找到与当前栏目绑定的模板！"
		else
			response.write " <select id=""model"" name=""model"">"
			do while not rs.eof
				response.write "<option value="""&rs("id")&","&rs("templatetype")&""">"&rs("templatename")&"</option>"
				rs.movenext
			loop
			response.write "</select>"
		end if
		rs.close
elseif request.QueryString("action")="clearpushinfo" then
	J.Data.Exe "delete from JCP_AutoPushInfo where sessionid=" & session.SessionID & " and adminid=" & session("JCP_AdminID")
	response.write "OK"
end if

%>
<% J.close %>