<!--#include file="../JCP_Shared/asp_head.asp" -->
	<% 
dim rs,sql
rootid=J.NumberYn(request.QueryString("rootid"))
if request.querystring("action")=1 then '生成列表JS对象,以供显示列表名称调用
		sql="select classid,classname from JCP_class where parentpath like '%,"&rootid&",%' order by classid"
		set rs=J.Data.Exe(sql)
			response.write "var class_0={" &vbcrlf
			response.write "                             classname:""-""" &vbcrlf
			response.write "}" &vbcrlf
		do while not rs.eof
			response.write vbcrlf
			response.write "var class_"&rs("classid")&"={" &vbcrlf
			response.write "                             classname:"""&rs("classname")&"""" &vbcrlf
			response.write "}" &vbcrlf
			rs.movenext
		loop
		rs.close
else
		dim i,cur_classid,classname,rootid,itemid,sign,selected
		itemid=J.NumberYn(request.QueryString("itemid"))
		cur_classid=request.QueryString("classid")
		sql="select * from JCP_class where ','&parentpath like '%,"&rootid&",%' order by orderid"
		set rs=J.Data.Exe(sql)
		response.write "var temp_class=doc.getElementById(""Item_"&itemid&"_class"");"
			do while not rs.eof
				if rs("classname")&""="" then classname="No Name" else classname=rs("classname")
				if cur_classid=rs("classid") then selected=" selected" else selected=""
				sign=string(2*(rs("classgrade")-1),"　")
				if rs("parentid")>0 then
					if rs("classson")>0 then
						sign=sign & "◇"
					else
						sign=sign & "◆"
					end if
				end if
				response.write "temp_class.options[temp_class.length]=new Option('"&sign&" "&classname&"','"&rs("classid")&"');"
				if isNumeric(cur_classid) then
					if rs("classid")=Clng(cur_classid) then 
						response.write "temp_class.selectedIndex=temp_class.length-1;"
					end if
				end if
				rs.movenext
			loop
		rs.close
end if
		%>
<% J.close %>
