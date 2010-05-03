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
Function parseJSON(str)
	If Not IsObject(scriptCtrl) Then
		Set scriptCtrl = Server.CreateObject("MSScriptControl.ScriptControl")
		scriptCtrl.Language = "JScript"
		scriptCtrl.AddCode "function ActiveXObject() {}" ' 覆盖 ActiveXObject
		scriptCtrl.AddCode "function GetObject() {}" ' 覆盖 ActiveXObject
		scriptCtrl.AddCode "Array.prototype.get = function(x) { return this[x]; }; var result = null;"
	End If
On Error Resume Next
	scriptCtrl.ExecuteStatement "result = " & str & ";"
	Set parseJSON = scriptCtrl.CodeObject.result
If Err Then
	Err.Clear
	Set parseJSON = Nothing
End If
End Function

oo="{""provider"":""access"",""dataSource"":""../db/db.mdb""}"
set conn1=Jexs.Adodb.connection(JSON.parse(oo))
set obj=Jexs.ado(conn1).execute("Select * From [testUser]",0).data
Response.Write(obj.length)
%>