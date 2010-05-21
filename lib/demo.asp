<%@language="vbscript" codepage="65001"%>
<script language="JScript" runat="server" src="Jasp.js"></script>
<script language="JScript" runat="server" src="Jasp.date.js"></script>
<script runat="server" language="javascript">
Response.Write("111")
</script>
<%
datetime=Jasp.date("2010年05月11日","yyyy年MM月dd日").format("yyyy-MM-dd hh:mm:ss").Get()

'Response.Write(Year(datetime))

%>
