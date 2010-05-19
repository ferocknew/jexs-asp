<!--#include file="../JCP_Shared/asp_head.asp" -->
<% 
dim action,rs,rootid,parentid,parent_menutype,menuid,menuname,menugrade,orderid,sql,parentpath,temp_actRs,curid,actid
action=request.QueryString("action")

if action="add" then
	parentid=request.QueryString("id")
	menuname=request.QueryString("menuname")
	orderid=0
	rootid=0
	
	if isnumeric(parentid) then
		if parentid>0 then
			set rs=J.Data.Exe("select top 1 orderid from JCP_menus where parentpath like '%,"&parentid&",%' order by orderid desc")
			if not rs.eof then orderid=rs(0)
			rs.close
			sql="update JCP_menus set orderid=orderid+1 where orderid>" & orderid
			J.Data.Exe(sql)
			parent_menutype=J.Data.Exe("select menutype from JCP_menus where menuid=" & parentid)(0)
		else
			set rs=J.Data.Exe("select top 1 orderid from JCP_menus order by orderid desc")
			if not rs.eof then orderid=rs(0)
			rs.close
			parent_menutype=0
		end if
	else
		response.Write("error")
		response.End()
	end if
	
	set rs=J.Data.RsOpen("select * from JCP_menus where menuid=" & parentid,3)
	if not rs.eof then rootid=rs("rootid"):parentpath=rs("parentpath")
	if rs.eof then menugrade=1 else menugrade=rs("menugrade")+1
	rs.addnew
	rs("menuname")=menuname
	rs("parentid")=parentid
	rs("menugrade")=menugrade
	rs("orderid")=orderid+1
	rs("menutime")=date()
	rs("menutype")=parent_menutype
	rs("opened")=true
	if rootid=0 then 
		rootid=rs("menuid")
		parentpath="0,"
	end if
	rs("rootid")=rootid
	rs("parentpath")=parentpath&rs("menuid")&","
	rs.update
	sql="update JCP_menus set menuson=menuson+1 where menuid=" & parentid
	J.Data.Exe(sql)
	response.Write rs("menuid")
elseif action="mod" then
	menuid=request.QueryString("id")
	menuname=request.QueryString("menuname")

	set rs=J.Data.RsOpen("select * from JCP_menus where menuid=" & menuid,3)
	if rs.eof then
		rs.eof
		response.Write("error")
		response.end
	else
		rs("menuname")=menuname
		parentid=rs("parentid")
		rs.update
	end if
	rs.close
	response.Write menuid
elseif action="del" then
	menuid=request.QueryString("id")

	set rs=J.Data.RsOpen("select * from JCP_menus where parentpath like '%,"&menuid&",%' order by orderid asc",3)
	if rs.eof then
		rs.close
		response.Write("error")
		response.end
	else
		temp_actRs=rs.recordcount
		orderid=rs("orderid")
		parentid=rs("parentid")
		rs.close
		sql="delete from JCP_menus where parentpath like '%,"&menuid&",%'"
		J.Data.Exe(sql)
		sql="update JCP_menus set orderid=orderid-"&temp_actRs&" where orderid>" & orderid
		J.Data.Exe(sql)
		sql="update JCP_menus set menuson=menuson-1 where menuid=" & parentid
		J.Data.Exe(sql)
	end if
	response.Write "del_OK"
elseif action="opened" then
	menuid=J.NumberYn(request.QueryString("id"))
	J.Data.Exe("update JCP_menus set opened = not opened where menuid="&menuid)
	response.write "OK"
elseif action="classbind" then
	dim classid,bindtype
	classid=J.NumberYn(request.QueryString("classid"))
	menuid=J.NumberYn(request.QueryString("menuid"))
	bindtype=J.NumberYn(request.QueryString("bindtype"))
	J.Data.Exe("update JCP_menus set bindtype=" & bindtype & ",bindcont='"&classid&"' where menuid="&menuid)
	response.write "OK"
elseif action="sysbind" then
	dim sysid
	sysid=J.NumberYn(request.QueryString("sysid"))
	menuid=J.NumberYn(request.QueryString("menuid"))
	J.Data.Exe("update JCP_menus set bindtype=2,bindcont='"&sysid&"' where menuid="&menuid)
	response.write "OK"
elseif action="urlbind" then
	dim url
	menuid=J.NumberYn(request.QueryString("menuid"))
	url=J.BlankYn(request.QueryString("url"))
	J.Data.Exe("update JCP_menus set bindtype=1,bindcont='"&replace(url,"¡ª","&")&"' where menuid="&menuid)
	response.write "OK"
elseif action="clearbind" then
	menuid=J.NumberYn(request.QueryString("menuid"))
	J.Data.Exe("update JCP_menus set bindtype=0,bindcont='' where menuid="&menuid)
	response.write "OK"
elseif action="upsibling" then
	curid=J.NumberYn(request.QueryString("curid"))
	actid=J.NumberYn(request.QueryString("actid"))
	dim upid1,upid2,upcount:upid1=0:upid2=0:upcount=0
	
	set rs=J.Data.RsOpen("select menuid,orderid from JCP_menus where menuid in ("&actid&","&curid&")",1)
	if rs.recordcount=2 then
		do while not rs.eof
			if rs("menuid")=actid then upid1=rs("orderid") else upid2=rs("orderid")
			rs.movenext
		loop
		upcount=J.Data.Exe("select count(menuid) from JCP_menus where parentpath like '%,"&curid&",%'")(0)
		J.Data.Exe "update JCP_menus set orderid=orderid+"&upcount&" where orderid>="&upid1&" and orderid<"&upid2
		J.Data.Exe "update JCP_menus set orderid=orderid-"&Cstr(upid2-upid1)&" where parentpath like '%,"&curid&",%'"
		response.write "OK"
	end if
	rs.close
elseif action="downsibling" then
	curid=J.NumberYn(request.QueryString("curid"))
	actid=J.NumberYn(request.QueryString("actid"))
	dim downid1,downid2,downcount:downid1=0:downid2=0:downcount=0
	
	set rs=J.Data.RsOpen("select menuid,orderid from JCP_menus where menuid in ("&actid&","&curid&")",1)
	if rs.recordcount=2 then
		do while not rs.eof
			if rs("menuid")=curid then downid1=rs("orderid") else downid2=rs("orderid")
			rs.movenext
		loop
		downcount=J.Data.Exe("select count(menuid) from JCP_menus where parentpath like '%,"&actid&",%'")(0)
		J.Data.Exe "update JCP_menus set orderid=orderid+"&downcount&" where orderid>="&downid1&" and orderid<"&downid2
		J.Data.Exe "update JCP_menus set orderid=orderid-"&Cstr(downid2-downid1)&" where parentpath like '%,"&actid&",%'"
		response.write "OK"
	end if
	rs.close
elseif action="typechange" then
	curid=J.NumberYn(request.QueryString("menuid"))
	actid=J.NumberYn(request.QueryString("acttype"))
	
	J.Data.Exe "update JCP_menus set menutype=" & actid & " where parentpath like '%," & curid & ",%'"
	response.write "OK"
end if
%>
<% J.close %>
