<%@language="vbscript" codepage="65001"%>
<script Language="JScript" runat="server" src="lib/Jexs.js"></script>
<script Language="JScript" runat="server" src="lib/Jexs-json.js"></script>

<%
Session.CodePage=65001
Call createConnection(0,"db/db.mdb")

set rs=server.CreateObject("adodb.recordset")
rs.Open "select * From [testUser]",conn,1,1
data=rs.GetRows()


temp=Split("id,user,test,next,time",",")
Set showvb=Jexs.VBRows2Obj(data,temp,5)

%>