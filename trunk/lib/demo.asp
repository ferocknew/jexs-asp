<%@language="vbscript" codepage="65001"%>
<script Language="JScript" runat="server" src="../lib/Jasp-json.js"></script>
<script Language="JScript" runat="server" src="../lib/Jasp.js"></script>
<script Language="JScript" runat="server">
Response.Write($.parse("[123123]").get().length)
</script>