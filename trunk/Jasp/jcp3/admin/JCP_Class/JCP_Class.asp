<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Class.css" rel="stylesheet" type="text/css">
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/tree.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/Tree.asp"></script>
<script language="JavaScript" src="../JCP_Script/PopMenu.asp"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript">
		DrawMouseRightButtonUpMenu()
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	
	<% 
		dim rs,i,cur_classid,cur_classgrade,cur_topclassid,classname,rootid,sql,opened
		rootid=request.QueryString("rootid")
		if isnumeric(rootid) and len(rootid)>0 then
			response.write "<div class=""app_title"">栏目管理</div>"&vbcrlf
			sql="select * from JCP_class where rootid="&rootid&" order by orderid"
		else
			response.write "<div class=""app_title"">系统栏目</div>"&vbcrlf
			sql="select * from JCP_class order by orderid"
			response.write "<div class=""app_button"" onclick=""Class_Add(doc.getElementById('CategoryTree'),0);"">创建系统分类</div>"&vbcrlf
		end if
		set rs=J.Data.Exe(sql)
			cur_classgrade=0
			response.write "<div class=""TreeMenu"" id=""CategoryTree"">" & vbcrlf
			do while not rs.eof
				if rs("opened") then opened="Opened" else opened="Closed"
				if rs("classname")&""="" then classname="No Name" else classname=rs("classname")
				if cur_classgrade>rs("classgrade") then
					for i=rs("classgrade") to cur_classgrade-1
						response.Write string(cur_classgrade-i+rs("classgrade")-1,"	") & "</ul>" & vbcrlf
						response.Write string(cur_classgrade-i+rs("classgrade")-1,"	") & "</li>" & vbcrlf
					next
				end if
				if cur_classgrade>0 and rs("classgrade")=1 then response.Write "</ul>" & vbcrlf
				if rs("classson")>0 then
					if rs("parentid")=0 then response.Write "<ul>" & vbcrlf
					response.Write string(rs("classgrade"),"	") & "<li class="""&opened&""" classid="""&rs("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif"" onclick=""javascript:ChangeStatus(this);""><span class=""classitem"" onFocus=""javascript:blur();"" onDblClick=""javascript:ChangeTitle(this,"&rs("classid")&",'mod');"" oncontextmenu=""javascript:return PopupMouseRightButtonUpMenu(this,"&rs("classid")&");"">" & classname & "</span>　[ID："&rs("classid")&"] [子栏目："&rs("classson")&"] [文章数："&rs("artcount")&"]" & vbcrlf
					response.Write string(rs("classgrade"),"	") & "<ul id=""tree_item_"&rs("classid")&""">" & vbcrlf
				else
					if rs("parentid")=0 then
						response.Write "<ul>" & vbcrlf
						response.Write "	<li class="""&opened&""" classid="""&rs("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""classitem"" onFocus=""javascript:blur();"" onDblClick=""javascript:ChangeTitle(this,"&rs("classid")&",'mod');"" oncontextmenu=""javascript:return PopupMouseRightButtonUpMenu(this,"&rs("classid")&");"">" & classname & "</span>　[ID："&rs("classid")&"] [子栏目："&rs("classson")&"] [文章数："&rs("artcount")&"]</li>" & vbcrlf
					else
						response.Write string(rs("classgrade"),"	") & "<li class=""Child"" classid="""&rs("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""classitem"" onFocus=""javascript:blur();"" onDblClick=""javascript:ChangeTitle(this,"&rs("classid")&",'mod');"" oncontextmenu=""javascript:return PopupMouseRightButtonUpMenu(this,"&rs("classid")&");"">" & classname & "</span>　[ID："&rs("classid")&"] [子栏目："&rs("classson")&"] [文章数："&rs("artcount")&"]</li>" & vbcrlf
					end if
				end if
				cur_classgrade=rs("classgrade")
				rs.movenext
				if rs.eof then
					for i=1 to cur_classgrade
						response.Write string(cur_classgrade-i,"	") & "</ul>" & vbcrlf
						if i<cur_classgrade then response.Write string(cur_classgrade-i,"	") & "</li>" & vbcrlf
					next
				end if
			loop
			response.write "</div>"
		rs.close
'	<div id="pagetime" disabled>< < %= J.PageTime % > ></div>
		%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
