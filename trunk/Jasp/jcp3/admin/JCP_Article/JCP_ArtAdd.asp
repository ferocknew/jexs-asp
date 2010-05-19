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

dim sysid,classstrs,classname,classid,queryi,classcheck
classcheck=false	'判断当前传递的类别ID，是否对应显示/隐藏类别选项
sysid=J.NumberYn(request.querystring("sysid"))
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

if instr(classname,"class")>0 then
	dim t_classid
	t_classid=J.NumberYn(request.QueryString(classname))
	if t_classid>0 then classcheck=true else classcheck=false
end if
%>
<form action="JCP_ArtAction.asp?<%= request.ServerVariables("QUERY_STRING") %>&action=add" method="post" enctype="multipart/form-data" name="form1">
	<div class="app_title">数据添加</div>
	<div id="ArtSys" style="background:<%= session("Color_Back") %>;">
<% 
	dim content
	set rs=J.Data.Exe("select * from JCP_ArtSys where sys_id="&sysid&" and item_order>0 order by item_order")
	do while not rs.eof
		content=rs("item_content")
		if rs("item_type")="button" then
			content="<DIV class=Items item_type=""button""><SPAN class=sys_button><INPUT type=submit value="" 确 定 "" name=Item_submit id=Item_submit>　　　　<INPUT id=Item_reset type=reset value="" 重 置 "" name=Item_reset></SPAN></DIV>"
		elseif rs("item_type")="class" then
			if classname=rs("item_id")&"_class" and classcheck then
				session("temp_ClassID_Add_"&rs("item_id"))=classid
				content= "	<input type=""hidden"" id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"" value="""&classid&""">"
			else
				content= "	<DIV class=""Items"" id="""&rs("item_id")&""" item_type=""class"">"_
						&"		<SPAN class=label id="&rs("item_id")&"_label>"&rs("item_name")&"</SPAN>"_
						&"		<SPAN class=content>"_
						&"			<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class""></select>"_
						&"			<LABEL id="&rs("item_id")&"_class_label style=""PADDING-LEFT: 10px"">"&rs("item_label")&"</LABEL>"_
						&"		</SPAN>"_
						&"	<script language=""javascript"">startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid="&rs("item_content")&"&classid="&session("temp_ClassID_Add_"&rs("item_id"))&""",null,""body"",""eval(xml_BackCont)"","""",false);</script>" _
						&"	</DIV>"
			end if
		else
			content=left(content,instr(content,"<SPAN class=tools>")-1) & "</DIV>"
		end if
		response.Write content &vbcrlf
		rs.movenext
	loop
	rs.close
%>	</div>
</form>
  <!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>