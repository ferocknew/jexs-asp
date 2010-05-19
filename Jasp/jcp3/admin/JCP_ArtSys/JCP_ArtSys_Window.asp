<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<style>
<!--
	body{
		padding:0;
		scroll:none;
		background:<%= session("Color_Main") %>;
		overflow-y:hidden;
	}
	#GuideBar{
		height:26px;
	}
-->
</style>
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_ArtSys.css" rel="stylesheet" type="text/css">
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_MutiMenu.asp" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript" src="../JCP_Script/ArtSys_Guide.js"></script>
<script language="JavaScript" type="text/JavaScript">
	window.onresize = timeResize;

	var doc=document;
	function winResize(){
		var win_height =doc.body.clientHeight;
		var win_width  =doc.body.clientWidth;
			
		if(win_height>26&&win_width>0){
			if(doc.getElementById("Sub_Main_Box")){
				doc.getElementById("Sub_Main_Box").style.width=win_width;
				doc.getElementById("Sub_Main_Box").style.height=win_height-26;
			}
		}
	}
	function timeResize(){
		winResize();
		setTimeout("winResize()",100);
	}
	function MainUrl(url){
		Sub_Main_Box.location=url;
	}
</script>
</head>

<body onLoad="javascript:Page_Loaded();winResize();">
<div id="Loading" class="Loading"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/loader.gif" align="absmiddle">　<span>载入中，请稍候 ......</span></div>
<div id="JCP_body">
<%
dim actid,classid,rs,title,url,turl,n,tyn,querystrs

actid=J.NumberYn(request.QueryString("actid"))
classid=J.NumberYn(request.QueryString("classid"))
tyn=false

set rs=J.Data.Exe("select JCP_AppSystem.*,item_id from JCP_AppSystem,JCP_ArtSys where menuid=sys_id and item_type='class' and item_content='"&actid&"'")
if not rs.eof then
	querystrs="sysid=" & rs("menuid")
	response.write "<script language=""JavaScript"" type=""text/JavaScript"">" & vbcrlf
	response.write "var menuHierarchy = [" & vbcrlf
	do while not rs.eof
		title=split(rs("submenutitle"),"|")
		url=split(rs("submenuurl"),"|")
		response.write "['" & rs("menutitle") & "','javascript:MainUrl(""../JCP_Article/JCP_ArtManage.asp?sysid="&rs("menuid")&"&" & rs("item_id") & "_class=" & classid & """);'," & vbcrlf
		for n=0 to ubound(title)
			if n>0 then response.write ","
			if n<=ubound(url) then turl=url(n) else turl="../JCP_Win/JCP_Main.asp"
			if instr(lcase(turl),"jcp_artadd.asp")>0 or instr(lcase(turl),"jcp_pushbyclasstemplateid.asp")>0 then turl=turl & "&" & rs("item_id") & "_class=" & classid
			if instr(lcase(turl),"jcp_artmanage.asp")>0 then
				turl=turl & "&" & rs("item_id") & "_class=" & classid
				if not tyn then
					querystrs=querystrs & "&" & rs("item_id") & "_class=" & classid
					tyn=true
				end if
			end if
			
			response.Write "['"&title(n)&"','javascript:MainUrl("""&turl&""");']" & vbcrlf
		next
		response.write "]," & vbcrlf
		rs.movenext
	loop
	response.write "['推送页面','javascript:MainUrl(""../JCP_Push/JCP_PushByClassTemplateID.asp"")']" & vbcrlf
	response.write "]" & vbcrlf
	response.write "</script>" & vbcrlf
else
end if
rs.close
%>
<div id="ArtSys_Box">
<% 
	if tyn then 
		response.write "	<iframe id=""Sub_Main_Box"" frameborder=""0"" src=""""></iframe>"
	else
		response.write "<span style=""width:200px;float:left;margin:20px"">未发现可绑定系统！</span>"
	end if
%>
</div>
<script language="JavaScript" type="text/JavaScript">
<% 
	if tyn then 
		response.write "	MainUrl(""../JCP_Article/JCP_ArtManage.asp?"&querystrs&""");"
		response.write "	new menu (menuHierarchy, menuConfig);"
	end if
%>
</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>