<!--#include file="../JCP_Shared/asp_head.asp" -->
<% 
dim actid,rs,display_order,i
actid=J.NumberYn(request.querystring("actid"))

if request.querystring("action")="display" then
	display_order=request.QueryString("order")
	J.Data.Exe("update JCP_ArtSys set display=1,display_order="&display_order&" where id="&actid)
	response.write "OK"
elseif request.QueryString("action")="undisplay" then
	display_order=request.QueryString("order")
	J.Data.Exe("update JCP_ArtSys set display=0 where id="&actid)
	J.Data.Exe("update JCP_ArtSys set display_order=display_order-1 where display_order>"&display_order)
	response.write "OK"
elseif request.QueryString("action")="pagesize" then
	dim pagesize
	pagesize=J.NumberYn(request.querystring("pagesize"))
	J.Data.Exe("update JCP_ArtSys set item_id="&pagesize&" where id="&actid)
	response.write "OK"
elseif request.QueryString("action")="display_width" then
	dim actwidth
	actwidth=J.NumberYn(request.querystring("actwidth"))
	J.Data.Exe("update JCP_ArtSys set display_width="&actwidth&" where id="&actid)
	response.write "OK"
elseif request.QueryString("action")="delfile" then
	dim sysid,itemid
	sysid=J.NumberYn(request.querystring("sysid"))
	itemid=J.NumberYn(request.querystring("itemid"))
	J.fso.FileD(server.MapPath(J.Data.Exe("select Item_"&itemid&"_file from Article_"&sysid&" where id="&actid)(0)))
	J.Data.Exe("update Article_"&sysid&" set Item_"&itemid&"_file='' where id="&actid)
	response.write "OK"
elseif request.QueryString("action")="delpics" then
	dim delpic,orderid
	delpic=request.querystring("picurl")
	J.UrlCheck delpic
	set rs=J.Data.Exe("select orderid from JCP_TempUpFiles where picurl='"&delpic&"'")
	if not rs.eof then orderid=rs(0)
	rs.close
	if orderid&""<>"" then
		J.fso.FileD(server.MapPath(delpic))
		J.Data.Exe("delete from JCP_TempUpFiles where picurl='"&delpic&"'")
		J.Data.Exe("update JCP_TempUpFiles set orderid=orderid-1 where orderid>"&orderid)
	end if
	response.write "OK"
elseif request.QueryString("action")="uppics" then
	set rs=J.Data.RsOpen("select top 2 orderid from JCP_TempUpFiles where orderid<="&actid&" order by orderid desc",3)
	if not rs.eof then
		if rs.recordcount=2 then
			for i=1 to 2
				if i=1 then
					rs(0)=rs(0)-1
				else
					rs(0)=rs(0)+1
				end if
				rs.movenext
			next
		else
			response.write "error"
		end if
	else
		response.write "error"
	end if
	rs.close
	response.write "OK"
elseif request.QueryString("action")="downpics" then
	set rs=J.Data.RsOpen("select top 2 orderid from JCP_TempUpFiles where orderid>="&actid&" order by orderid",3)
	if not rs.eof then
		if rs.recordcount=2 then
			for i=1 to 2
				if i=1 then
					rs(0)=rs(0)+1
				else
					rs(0)=rs(0)-1
				end if
				rs.movenext
			next
		else
			response.write "error"
		end if
	else
		response.write "error"
	end if
	rs.close
	response.write "OK"
elseif request.QueryString("action")="classfind" then
	dim object
	object=request.QueryString("object")
	set rs=J.Data.Exe("select id,item_id,item_name,item_content from JCP_ArtSys where sys_id="&actid&" and item_type='class'")
		if rs.eof then
			response.write object&".innerHTML="">> 此系统无类别"";" & vbcrlf
		else
			dim classStrs:classStrs=""
			response.write object&".innerHTML="""";" & vbcrlf
			do while not rs.eof
				response.write object&".innerHTML+='<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"">' +" & vbcrlf _
							 & "				  		 '	<option value=""-1"">"&replace(rs("item_name"),"：","")&"</option>' +" & vbcrlf _
							 & "						 '</select> ';" & vbcrlf _
							 & "startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid="&rs("item_content")&"&classid="&request.querystring(rs("item_id")&"_class")&""",null,""body"",""eval(xml_BackCont)"","""",false);" & vbcrlf
				classStrs=classStrs&" + \'&"&rs("item_id")&"_class=\' + "&rs("item_id")&"_class.value"
				rs.movenext
			loop
			response.write object&".innerHTML+='<input type=button class=""system_button_00"" value=""查看文章"" onclick=""javascript:location=\'?sysid="&actid&"\'"&classStrs&";"">';" & vbcrlf
		end if
end if
 %>
<% J.close %>