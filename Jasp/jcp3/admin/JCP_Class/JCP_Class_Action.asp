<!--#include file="../JCP_Shared/asp_head.asp" -->
<% 
dim action,rs,rootid,parentid,classid,classname,classgrade,orderid,sql,parentpath,temp_actRs
action=request.QueryString("action")

if action="add" then
	parentid=request.QueryString("id")
	classname=request.QueryString("classname")
	orderid=0
	rootid=0
	
	if isnumeric(parentid) then
		if parentid>0 then
			set rs=J.Data.Exe("select top 1 orderid from JCP_class where parentpath like '%,"&parentid&",%' order by orderid desc")
			if not rs.eof then orderid=rs(0)
			rs.close
			sql="update JCP_class set orderid=orderid+1 where orderid>" & orderid
			J.Data.Exe(sql)
		else
			set rs=J.Data.Exe("select top 1 orderid from JCP_class order by orderid desc")
			if not rs.eof then orderid=rs(0)
			rs.close
		end if
	else
		response.Write("error")
		response.End()
	end if
	
	set rs=J.Data.RsOpen("select * from JCP_class where classid=" & parentid,3)
	if not rs.eof then rootid=rs("rootid"):parentpath=rs("parentpath")
	if rs.eof then classgrade=1 else classgrade=rs("classgrade")+1
	rs.addnew
	rs("classname")=classname
	rs("parentid")=parentid
	rs("classgrade")=classgrade
	rs("orderid")=orderid+1
	rs("classtime")=date()
	rs("opened")=true
	if rootid=0 then 
		rootid=rs("classid")
		parentpath="0,"
	end if
	rs("rootid")=rootid
	rs("parentpath")=parentpath&rs("classid")&","
	rs.update
	sql="update JCP_class set classson=classson+1 where classid=" & parentid
	J.Data.Exe(sql)
	response.Write rs("classid")
elseif action="mod" then
	classid=request.QueryString("id")
	classname=request.QueryString("classname")

	set rs=J.Data.RsOpen("select * from JCP_class where classid=" & classid,3)
	if rs.eof then
		rs.eof
		response.Write("error")
		response.end
	else
		rs("classname")=classname
		parentid=rs("parentid")
		rs.update
	end if
	rs.close
	response.Write classid
elseif action="del" then
	classid=request.QueryString("id")

	set rs=J.Data.RsOpen("select * from JCP_class where parentpath like '%,"&classid&",%' order by orderid asc",3)
	if rs.eof then
		rs.close
		response.Write("error")
		response.end
	else
		temp_actRs=rs.recordcount
		orderid=rs("orderid")
		parentid=rs("parentid")
		rs.close
		sql="delete from JCP_class where parentpath like '%,"&classid&",%'"
		J.Data.Exe(sql)
		sql="update JCP_class set orderid=orderid-"&temp_actRs&" where orderid>" & orderid
		J.Data.Exe(sql)
		sql="update JCP_class set classson=classson-1 where classid=" & parentid
		J.Data.Exe(sql)
	end if
	response.Write "del_OK"
elseif action="opened" then
	classid=J.NumberYn(request.QueryString("id"))
	J.Data.Exe("update JCP_class set opened = not opened where classid="&classid)
	response.write "OK"
end if
%>
<% J.close %>
