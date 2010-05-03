<%@language="jscript" codepage="65001"%>
<script Language="JScript" runat="server" src="lib/Jexs-lib.js"></script>
<script Language="JScript" runat="server" src="lib/Jexs-json.js"></script>

<script Language="JScript" runat="server">
Session.CodePage=65001;
createConnection(0,"db/db.mdb")
var rs = new ActiveXObject("ADODB.Recordset");
var rs = new ActiveXObject("ADODB.Recordset")
rs.Open("Select * From [testUser]",Conn,1)
//Response.Write(JSON.stringify(test_data))
//Response.Write(Jexs.DBobj(rs)[0].ID)
rs.Open("Select * From [testUser]",Conn,1,1);
Response.Write(JSON.stringify(Jexs.ADO2Obj("Select * From [testUser]",Conn)))
//var new_Array={list:transArray(rs.GetRows.toArray(),rs.Fields.Count)};
//Response.Write(rs.GetRows.toArray())//dd,0
</script>
