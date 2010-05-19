<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_ArtSys.css" rel="stylesheet" type="text/css">
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Article.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/PageElements.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
</head>

<body>
<div id="JCP_body" style="display:block !important;">
<% 
dim rs
set rs=J.Data.Exe("select * from JCP_TempUpFiles where pictime<#"&date()&"# or sessionid="&session.SessionID)
if not rs.eof then
	do while not rs.eof
		if rs("picurl")&""<>"" then J.fso.FileD server.MapPath(rs("picurl"))
		rs.movenext
	loop
	J.Data.Exe "delete from JCP_TempUpFiles where pictime<#"&date()&"# or sessionid="&session.SessionID
end if
rs.close

dim sysid,actid,classstrs,classname,classid,queryi
sysid=J.NumberYn(request.querystring("sysid"))
actid=J.NumberYn(replace(request.querystring("actid"),"0,",""))
if instrRev(request.ServerVariables("QUERY_STRING"),"&")>0 then
	classstrs=split(request.ServerVariables("QUERY_STRING"),"&")
	for queryi=0 to ubound(classstrs)
		if instr(classstrs(queryi),"_class=")>0 then
			classname=trim(split(classstrs(queryi),"=")(0))
			classid=trim(split(classstrs(queryi),"=")(1))
			if isnumeric(classid) and classid<>"" then
				classid=Clng(classid)
			else
				classname=""
				classid=0
			end if
			exit for
		else
			classname=""
			classid=0
		end if
	next
else
	classname=""
	classid=0
end if

if isNumeric(replace(actid,",","")) then
	dim editDiv
	editDiv = "	<form action=""JCP_ArtAction.asp?"&request.ServerVariables("QUERY_STRING")&"&action=mod"" method=""post"" enctype=""multipart/form-data"" name=""form1"">" & vbcrlf _
			& "		<div class=""app_title"">数据修改</div>" & vbcrlf _
			& "			<div id=""ArtSys"">" & vbcrlf

		dim content,item_title,table_items,temp_item_label,item_count,i
		item_count=0
		table_items="id"
		set rs=J.Data.Exe("select * from JCP_ArtSys where sys_id="&sysid&" and item_order>0 order by item_order")
		do while not rs.eof
'-------------------------------------------------
			content=rs("item_content")
			if rs("item_type")="button" then
				content="<DIV class=Items item_type=""button""><SPAN class=sys_button><INPUT type=submit value="" 修 改 "" name=Item_submit>　　　　<INPUT id=Item_reset type=button class=""system_button_00"" value="" 返 回 "" name=Item_reset onclick=""javascript:location='JCP_ArtManage.asp?"&split(request.ServerVariables("QUERY_STRING"),"&actid=")(0)&"';""></SPAN></DIV>"
			elseif rs("item_type")="class" then
				if classname=rs("item_id")&"_class" then
					content= "	<input type=""hidden"" id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"" value="""&classid&""">"
				else
					content= "<DIV class=""Items"" id="""&rs("item_id")&""" item_type=""class"">"_
							&"		<SPAN class=label id="&rs("item_id")&"_label>"&rs("item_name")&"</SPAN>"_
							&"		<SPAN class=content>"_
							&"			<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class""></select>"_
							&"			<LABEL id="&rs("item_id")&"_class_label style=""PADDING-LEFT: 10px"">"&rs("item_label")&"</LABEL>"_
							&"		</SPAN>"_
							&"	<script language=""javascript"">startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid="&rs("item_content")&""",null,""body"",""eval(xml_BackCont)"","""",false);</script>"_
							&"	</DIV>"
				end if
			elseif rs("item_type")="map" then
				content=left(content,instr(content,"<SCRIPT ")-1)
			else
				content=left(content,instr(content,"<SPAN class=tools>")-1) & "</DIV>"
			end if
			editDiv = editDiv & content & vbcrlf
'-------------------------------------------------
			item_title=""
			select case rs("item_type")
				case "checkbox"
					temp_item_label=split(rs("item_label")&"","{$|}")
					for i=0 to ubound(temp_item_label)
						item_title=item_title&","&rs("item_id")&"_"&rs("item_type")&"_"&(i+1)
						item_count=item_count+1
					next
				case "button","pagesize"
				case "pics"
					item_title=","&rs("item_id")&"_"&rs("item_type")&","&rs("item_id")&"_"&rs("item_type")&"_title"
					item_count=item_count+2
				case "map"
					item_title=","&rs("item_id")&"_"&rs("item_type")&","&rs("item_id")&"_"&rs("item_type")&"x,"&rs("item_id")&"_"&rs("item_type")&"y"
					item_count=item_count+3
				case else
					item_title=","&rs("item_id")&"_"&rs("item_type")
					item_count=item_count+1
			end select
			table_items=table_items&item_title
'-------------------------------------------------
			rs.movenext
		loop
		rs.close
		editDiv = editDiv & "		</div>" & vbcrlf _
				& "	</form>" & vbcrlf

		set rs=J.Data.Exe("select "&table_items&" from Article_"&sysid&" where id="&actid)
		if rs.eof then
			rs.close
			%>
			<div class="result">
				<div class="manage_exp">需要修改的记录不存在！</div>
				<div class="result_button"><span>[<a href="javascript:location='JCP_ArtManage.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&actid=")(0) %>';" onMouseMove="javascript:window.status='返回管理';">返回管理</a>]</span></div>
			</div>
			<%  
		else
			response.write editDiv
			dim items,sItem
			items=split(table_items,",")
			response.write "	<script language=""javascript"">" & vbcrlf
			for each sItem in items
				if instr(sItem,"class")>0 then
					if rs(sItem)&"0"<>"0" then response.write "		doc.all."&sItem&".value="&rs(sItem)&";" & vbcrlf
				elseif instr(sItem,"text")>0 and not instr(sItem,"textarea")>0 then
					response.write "		doc.all."&sItem&".value=""" & replace(replace(rs(sItem)&"","""","\"""),">","\>") & """;" & vbcrlf
				elseif instr(sItem,"link")>0 then
					response.write "		doc.all."&sItem&".value=""" & replace(replace(rs(sItem)&"","""","\"""),">","\>") & """;" & vbcrlf
				elseif instr(sItem,"tag")>0 then
					response.write "		doc.all."&sItem&".value=""" & replace(replace(rs(sItem)&"","""","\"""),">","\>") & """;" & vbcrlf
				elseif instr(sItem,"textarea")>0 then
					response.write "		doc.all."&sItem&".value=""" & replace(replace(replace(rs(sItem)&"","""","\"""),">","\>"),chr(13)&Chr(10),"\n") & """;" & vbcrlf
				elseif instr(sItem,"number")>0 then
					if rs(sItem)&"0"="0" then response.write "		doc.all."&sItem&".value=0;" & vbcrlf else response.write "		doc.all."&sItem&".value="&rs(sItem)&";" & vbcrlf
				elseif instr(sItem,"radio")>0 then
					if rs(sItem)&"0"<>"0" then response.write "		for(i=0;i<doc.getElementsByName("""&sItem&""").length;i++) (doc.getElementsByName("""&sItem&""")[i].value=="&rs(sItem)&")?doc.getElementsByName("""&sItem&""")[i].checked=true:doc.getElementsByName("""&sItem&""")[i].checked=false;" & vbcrlf
				elseif instr(sItem,"checkbox")>0 then
					if rs(sItem)=1 then response.write "		doc.all."&sItem&".checked=true;" & vbcrlf else response.write "		doc.all."&sItem&".checked=false;" & vbcrlf
				elseif instr(sItem,"file")>0 then
					if rs(sItem)&"0"<>"0" then
						sItem=replace(sItem,"_file","")
						response.write "		var temp_"&sItem&"=doc.getElementById("""&sItem&""").childNodes[1].innerHTML;" & vbcrlf _
									 & "		doc.getElementById("""&sItem&""").childNodes[1].innerHTML='<img src=""../JCP_Skin/"&Session("SystemSkin")&"/images/math.gif"" align=""absmiddle"" title=""已上传："&rs(sItem&"_file")&""" style=""cursor:hand;margin:0 0 0 10px;"" onclick=""javascript:window.open(\'"&rs(sItem&"_file")&"\');""> [<a href=""javascript:"&sItem&"_upload();"">删除，重新上传</a>]';" & vbcrlf _
									 & "		doc.getElementById("""&sItem&""").childNodes[1].style.margin=""5px 0 0 0"";" & vbcrlf _
									 & "		function "&sItem&"_upload(){" & vbcrlf _
									 & "			if(confirm(""您确定要删除当前文件？？"")){" & vbcrlf _
									 & "				startXmlRequest(""POST"",""JCP_ArtAction_XML.asp?sysid="&sysid&"&actid="&actid&"&itemid="&replace(sItem,"Item_","")&"&action=delfile"",null,""body"","""","""",false);" & vbcrlf _
									 & "				if(xml_BackCont==""OK""){" & vbcrlf _
									 & "					doc.getElementById("""&sItem&""").childNodes[1].innerHTML=temp_"&sItem&";" & vbcrlf _
									 & "					doc.getElementById("""&sItem&""").childNodes[1].style.margin="""";" & vbcrlf _
									 & "				}else{" & vbcrlf _
									 & "					alert(""现有文件删除失败！"" + xml_BackCont)" & vbcrlf _
									 & "				}" & vbcrlf _
									 & "			}" & vbcrlf _
									 & "		}" & vbcrlf
					end if
				elseif instr(sItem,"upload")>0 then
					response.write "		doc.all."&sItem&".value=""" & replace(replace(rs(sItem)&"","""","\"""),">","\>") & """;" & vbcrlf
				elseif instr(sItem,"pics")>0 and not instr(sItem,"pics_title")>0 then
					if instr(rs(sItem)&"","{|}")>0 then
						dim picurl,pictitle
						picurl=split(rs(sItem)&"","{|}")
						pictitle=split(rs(sItem&"_title")&"","{|}")
						for i=0 to ubound(picurl)
							response.write "		doc.all."&sItem&".options[doc.all."&sItem&".length]=new Option("""&picurl(i)&" ["&replace(pictitle(i),chr(13)&chr(10)," ")&"]"","""&picurl(i)&""");" & vbcrlf
							J.Data.Exe "insert into JCP_TempUpFiles(picname,picurl,sessionid,pictype,objectid,orderid) values('"&replace(pictitle(i),"'","''")&"','"&picurl(i)&"',"&session.SessionID&",'edit',"&replace(replace(sItem,"Item_",""),"_pics","")&","&i+1&")"
						next
					elseif rs(sItem)&""<>"" and not instr(rs(sItem)&"","{|}")>0 then
						response.write "		doc.all."&sItem&".options[doc.all."&sItem&".length]=new Option("""&rs(sItem)&" ["&replace(rs(sItem&"_title"),chr(13)&chr(10)," ")&"]"","""&rs(sItem)&""");" & vbcrlf
						J.Data.Exe "insert into JCP_TempUpFiles(picname,picurl,sessionid,pictype,objectid,orderid) values('"&replace(rs(sItem&"_title"),"'","''")&"','"&rs(sItem)&"',"&session.SessionID&",'edit',"&replace(replace(sItem,"Item_",""),"_pics","")&",1)"
					end if
					response.write "		doc.getElementById("""&sItem&"count"").innerHTML=doc.all."&sItem&".length;" & vbcrlf
				elseif instr(sItem,"edit")>0 then
					response.write "		doc.all."&sItem&"_content.value=""" & replace(replace(replace(rs(sItem)&"","""","\"""),">","\>"),chr(13)&Chr(10),"\n") & """;" & vbcrlf
				elseif instr(sItem,"map")>0 and not instr(sItem,"mapx")>0 and not instr(sItem,"mapy")>0 then	
					response.write "		document.getElementById("""&sItem&"x"").value=" & rs(sItem&"x") & ";"
					response.write "		document.getElementById("""&sItem&"y"").value=" & rs(sItem&"y") & ";"
					response.write "		document.getElementById("""&sItem&"zoom"").value=" & rs(sItem) & ";"
					response.write "		document.getElementById("""&sItem&""").src=""../JCP_Shared/map.asp?objectid="&replace(replace(sItem,"Item_",""),"_map","")&"&mapx="" + document.getElementById("""&sItem&"x"").value + ""&mapy="" + document.getElementById("""&sItem&"y"").value + ""&mapzoom="" + document.getElementById("""&sItem&"zoom"").value;"
				end if
			next
			response.write "	</script>" & vbcrlf
		end if
		rs.close
	%>
<% 
else
	%>
	<div class="result">
		<div class="manage_exp">数据传输有误！</div>
		<div class="result_button"><span>[<a href="javascript:location='JCP_ArtManage.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&actid=")(0) %>';" onMouseMove="javascript:window.status='返回管理';">返回管理</a>]</span></div>
	</div>
	<%  
end if
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>