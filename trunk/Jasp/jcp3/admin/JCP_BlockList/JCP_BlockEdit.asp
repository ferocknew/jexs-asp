<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<!--#include file="../JCP_Shared/body.asp" -->
<% 
dim rs,blockid
blockid=J.NumberYN(request.QueryString("blockid"))
set rs=J.Data.Exe("select blockfolder,blockeditfile from JCP_BlockList where id="&blockid)
if not rs.eof then
	response.Redirect(rs("blockfolder") & "/" & rs("blockeditfile") & "?blockid=" & blockid)
else
	%>
  <table width="100%" height="60%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td align="center">
	  <script language="JavaScript">
		reSize(300,140);
		document.write('您要修改的模块不存在！<br><br>');
		document.write('[<span onclick="javascript:window.close();" style="cursor:hand;">关闭窗口</span>]');
	  </script>
	  </td>
    </tr>
  </table>
  <%  
end if
rs.close
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>