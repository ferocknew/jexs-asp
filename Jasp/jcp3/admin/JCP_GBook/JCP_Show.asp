<%
	Response.CacheControl = "no-cache"
	Response.Expires = 0
%>
<!--#include file="../../JCP_GBook/Inc/Class_GBook.asp" -->
<% 
	dim J
	set J=new JCP
	J.open null
%>
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<base target="_self">
<!--#include file="../JCP_Shared/body.asp" -->
<% 
dim msgid
msgid=J.NumberYN(request.querystring("msgid"))
G.MainOpen
set grs=G.Main.data.RsOpen("select msgcontent from msg where id="&msgid,1)
if not grs.eof then
%>
	<div class="app_title">≤Èø¥¡Ù—‘</div>
	<div style="float:left;width:100%;height:260px;overflow:auto;"><%= G.MsgFace(G.Main.Encode(grs("msgcontent"))) %></div>
<%
end if
grs.close
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>