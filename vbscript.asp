<%@language="vbscript" codepage="65001"%>
<script Language="JScript" runat="server" src="lib/Jasp.js"></script>
<%
Session.CodePage=65001
oo="{""provider"":""access"",""dataSource"":""db/db.mdb""}"
set conn=Jasp.adodb.connection(Jasp.parse(oo).Get())

set rs=server.CreateObject("adodb.recordset")
rs.Open "select * From [testUser]",conn,1,1
data=rs.GetRows()
rs.close:Set rs=Nothing


temp=Split("id,user,test,next,time",",")
'Set rs=Jasp.VBRows2Obj(data,temp,5)
'Set rs=Jasp.ado(conn).exec("select * From [testUser] where (id=11111)").getData()'.Get()
'Response.Write(rs.length)
'
'Set rs=Jasp.ado().exec("select * From [testUser] ",0).getData()'.Get()
'Response.Write(rs.length)
'Jasp.adodb.close(conn)

Set rs=Jasp.ado(conn).exec("select id,username,[userTime] From [testUser] order by id").Get()
Response.Write(rs.[1].userTime)
%>