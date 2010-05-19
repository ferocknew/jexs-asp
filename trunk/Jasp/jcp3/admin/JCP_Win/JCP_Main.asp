<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link rel="stylesheet" href="../JCP_Skin/<%= session("SystemSkin") %>/css/JCP_Normal.asp" type="text/css">
</head>

<body>
<table width="100%" border="0" cellspacing="10" cellpadding="0">
  <tr> 
    <td><%= Session("SiteSystemName") & "   " & J.Version & " &copy; " & Session("SiteName") & " " & J.CopyRight %></td> 
  </tr>
  <tr> 
    <td>
       >> 您好，亲爱的<font color="<%= session("Color_LightFont") %>"><%=session("JCP_AdminName") %></font>，您的身份是<font color="<%= session("Color_LightFont") %>">
	   <%
		if session("JCP_AdminType")=0 then
			response.write "超级管理员" 
		else
			dim rs
			set rs=J.Data.Exe("select team_name from JCP_purviewteam where id="&session("JCP_AdminPurv"))
			if not rs.eof then
				response.write rs(0)
				if session("JCP_AdminType")=1 then response.write "（全局）"
				if session("JCP_AdminType")=2 then response.write "（局部）"
			else
				response.write "未知身份（无权限）"
			end if
			rs.close
		end if
	   %>
	   </font>
    </td>
  </tr>
  <tr> 
    <td>
      <%= "您当前的ＩＰ为：" & request.ServerVariables("REMOTE_ADDR") %>
    </td>
  </tr>
  <tr> 
    <td>&nbsp; </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
</table>
</p>
</body>
</html>
<% J.close %>