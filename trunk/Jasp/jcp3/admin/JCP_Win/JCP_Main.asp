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
       >> ���ã��װ���<font color="<%= session("Color_LightFont") %>"><%=session("JCP_AdminName") %></font>�����������<font color="<%= session("Color_LightFont") %>">
	   <%
		if session("JCP_AdminType")=0 then
			response.write "��������Ա" 
		else
			dim rs
			set rs=J.Data.Exe("select team_name from JCP_purviewteam where id="&session("JCP_AdminPurv"))
			if not rs.eof then
				response.write rs(0)
				if session("JCP_AdminType")=1 then response.write "��ȫ�֣�"
				if session("JCP_AdminType")=2 then response.write "���ֲ���"
			else
				response.write "δ֪��ݣ���Ȩ�ޣ�"
			end if
			rs.close
		end if
	   %>
	   </font>
    </td>
  </tr>
  <tr> 
    <td>
      <%= "����ǰ�ģɣ�Ϊ��" & request.ServerVariables("REMOTE_ADDR") %>
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