<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
if request.QueryString("action")="saveblockfile" then
	dim src,filecontent
	src=request.form("src")
	filecontent=request.form("filecontent")
	if J.fso.FileE(server.MapPath(src)) then
		J.fso.FileN server.MapPath(src),filecontent
		%>
		<script language=javascript>
			alert("ģ��Դ�ļ��Ѿ��ɹ��޸�!");
			location="JCP_BlockAction.asp";
		</script>
		<%
	else
		%>
		<script language=javascript>
			alert("����Ҫ�޸ĵ�ģ��Դ�ļ�������!");
			location="JCP_BlockAction.asp";
		</script>
		<%
	end if
else
%>
	<form name="blockform" method="post" action="JCP_BlockAction.asp?action=saveblockfile" style="margin:0;">
		<input type="text" name="src" id="src" value="">
		<textarea id="filecontent" name="filecontent"></textarea>
	</form>
<%  
end if
%>
<% J.close %>