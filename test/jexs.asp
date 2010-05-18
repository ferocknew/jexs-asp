<%@language="vbscript" codepage="65001"%>
<script Language="JScript" runat="server" src="../lib/Jexs-json.js"></script>
<script Language="JScript" runat="server" src="../lib/jexs.js"></script>

<script Language="JScript" runat="server">
Session.CodePage=65001;
//var conn1=Jexs.Ado.connection({provider:"access",dataSource:"../db/db.mdb"});
//Jexs.ado(conn1).execute("Select * From [testUser]",1).output("json");
//Response.Write(d);

//createConnection(0,"db/db.mdb")
//var rs = new ActiveXObject("ADODB.Recordset");
//var rs = new ActiveXObject("ADODB.Recordset")
//rs.Open("Select * From [testUser]",Conn,1)
////Response.Write(JSON.stringify(test_data))
////Response.Write(Jexs.DBobj(rs)[0].ID)
//rs.Open("Select * From [testUser]",Conn,1,1);
//Response.Write(JSON.stringify(Jexs.ADO2Obj("Select * From [testUser]",Conn)))
//var new_Array={list:transArray(rs.GetRows.toArray(),rs.Fields.Count)};
//Response.Write(rs.GetRows.toArray())//dd,0


</script>
<%

oo="{""provider"":""access"",""dataSource"":""../db/db.mdb""}"
set conn=Jexs.Adodb.connection(JSON.parse(oo))
Set obj=Jexs.ado(conn).execute("select * from [testUser] order by id",1).getData()
'Response.Write(Jexs.output(obj,"json"))
'Response.Charset = "utf-8"
'Response.ContentType="text/xml"
'Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
Response.Write("<root>")
'Jexs.ado(conn).execute("select * from [testUser]",1).output("xml")
Jexs.parse("[1,2,3,4,5]").output("json")
Response.Write("</root>")
Response.End()
%>