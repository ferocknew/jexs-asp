<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_ArtSys.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
	var SysId=<%= J.NumberYn(request.QueryString("sysid")) %>;
</script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/PageElements.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
</head>

<body>
<div id="JCP_body" style="display:block !important;">
	<div class="app_title">ϵͳ����</div>
	<div class="buttonbox">
		<div class="app_button" onClick="AddElement('class');">�ࡡ��</div>
		<div class="app_button" onClick="AddElement('text');">�ı���</div>
		<div class="app_button" onClick="AddElement('link');">������</div>
		<div class="app_button" onClick="AddElement('textarea');">�ı���</div>
		<div class="app_button" onClick="AddElement('number');">���ֿ�</div>
		<div class="app_button" onClick="AddElement('radio');">��ѡ��</div>
		<div class="app_button" onClick="AddElement('checkbox');">��ѡ��</div>
		<div class="app_button" onClick="AddElement('file');">�ļ���</div>
		<div class="app_button" onClick="AddElement('upload');">�ļ���</div>
		<div class="app_button" onClick="AddElement('pics');">��ͼ��</div>
		<div class="app_button" onClick="AddElement('edit');">�༭��</div>
		<div class="app_button" onClick="AddElement('button');">��ť��</div>
	</div>
	<div id="ArtSys" style="background-color:<%= session("Color_Back") %>;">
	<% 
	dim rs
	set rs=J.Data.Exe("select * from JCP_ArtSys where sys_id="&J.NumberYn(request.QueryString("sysid"))&" and item_order>0 order by item_order")
	do while not rs.eof
		if rs("item_type")="class" then
			response.write "	<DIV class=""Items"" id="""&rs("item_id")&""" item_type=""class"">"
			response.write "		<SPAN class=label id="&rs("item_id")&"_label>"&rs("item_name")&"</SPAN>"
			response.write "		<SPAN class=content>"
			response.write "			<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class""></select>"
			response.write "			<LABEL id="&rs("item_id")&"_class_label style=""PADDING-LEFT: 10px"">"&rs("item_label")&"</LABEL>"
			response.write "		</SPAN>"
			response.write "		<script language=""javascript"">startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid=0&classid="&rs("item_content")&""",null,""body"",""eval(xml_BackCont)"","""",false);</script>"
			response.write "		<SPAN class=tools>"
			response.write "			<SPAN class=up_button onclick=""SwapItem(this,'up')""></SPAN>"
			response.write "			<SPAN class=down_button onclick=""SwapItem(this,'down')""></SPAN>"
			response.write "			<SPAN class=mod_button title=�޸�������� onclick=""curElement='"&rs("item_id")&"';getProp('class');""></SPAN>"
			response.write "			<SPAN class=del_button title=ɾ������ onclick=""curElement='"&rs("item_id")&"';EditElement('del');""></SPAN>"
			response.write "		</SPAN>"
			response.write "	</DIV>"
		else
			response.write rs("item_content")&vbcrlf
		end if
		rs.movenext
	loop
	rs.close
	%>
	</div>
	<% 
	dim sysname,syslogo
	set rs=J.Data.Exe("select menutitle,menulogo from JCP_AppSystem where menuid="&request.QueryString("sysid"))
	if rs.eof then
		sysname="δ����"
		syslogo="SystemLogo"
	else
		sysname=rs(0)
		syslogo=rs(1)
	end if
	rs.close
	%>
	<div class=sysname>
		ϵͳ���ƣ�<input name="sysname" id="sysname" type="text" value="<%= sysname %>" onblur="javascript:BlankCheck(this.value,this);IllegalCheck(this.value,this);">��
		ϵͳ��ʶ��<input name="syslogo" id="syslogo" type="text" value="<%= syslogo %>" onblur="javascript:BlankCheck(this.value,this);IllegalCheck(this.value,this,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',false);">��* ��ʶ����Ψһ����ֻ����<font color="<%= session("Color_LightFont") %>">��ĸ</font>��ɣ�
	</div>
	<div class="save">
		<input name="save" type="button" class="system_button_00" value="Ӧ������" onClick="SaveBook();">��������
		<input name="save" type="button" class="system_button_00" value="��������" onclick="location.reload();">��������
		<input name="save" type="button" class="system_button_00" value="���ع���" onclick="location='JCP_ArtSys_Manage.asp';">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>