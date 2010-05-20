<%@language="vbscript" codepage="65001"%>
<script language="JScript" runat="server" src="Jasp.js"></script>
<script language="JScript" runat="server" src="Jasp.date.js"></script>
<script  runat="server" language="javascript">
//$.date("2000-09-09 12:12:12","yyyy-MM-dd hh:mm:ss").format("yy-MM").output()
</script>
<%
dateNow=Jasp.date("2010年05月11日","yyyy年MM月dd日").format("yyyy/MM/dd hh:mm:ss").Get()
Response.Write(DateDiff("d",Now(),dateNow))
%>
