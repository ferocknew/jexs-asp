<%@language="vbscript" codepage="65001"%>
<script Language="JScript" runat="server" src="../lib/Jexs-json.js"></script>
<script Language="JScript" runat="server" src="../lib/jexs.js"></script>
version:
<%
Response.Write(Jexs.version);
%>