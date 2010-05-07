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

function json2xml(o, tab,tag) {
   var toXml = function(v, name, ind) {
      var xml = "";
	  if (v instanceof Array) {
         for (var i=0, n=v.length; i<n; i++)
            xml += ind + toXml(v[i], name, ind+"\t") + "\n";
      }
      else if (typeof(v) == "object") {

         var hasChild = false;
         xml += ind + "<" + name;

         for (var m in v) {
            if (m.charAt(0) == "@")
               xml += " " + m.substr(1) + "=\"" + v[m].toString() + "\"";
            else
               hasChild = true;
         }
         xml += hasChild ? ">" : "/>";

         if (hasChild) {
            for (var m in v) {
               if (m == "#text")
                  xml += v[m];
               else if (m == "#cdata")
                  xml += "<![CDATA[" + v[m] + "]]>";
               else if (m.charAt(0) != "@"){
                  xml += toXml(v[m], m, ind+"\t");

				  }
            }

            xml += (xml.charAt(xml.length-1)=="\n"?ind:"") + "</" + name + ">";
         }
      }
      else {

         xml += ind + "<" + name + ">" + String(v).toString().replace("<","&lt;").replace(">","&gt;") +  "</" + name + ">";
      }

      return xml;
   }, xml="";

  if( o instanceof Array){
	 var t={};
	 t[tag]=o;
	 o=t;

   }
   for (var m in o)
      xml += toXml(o[m], m, "");
   return tab ? xml.replace(/\t/g, tab) : xml.replace(/\t|\n/g, "");
}
</script>
<%

oo="{""provider"":""access"",""dataSource"":""../db/db.mdb""}"
set conn1=Jexs.Adodb.connection(JSON.parse(oo))
Set obj=Jexs.ado(conn1).execute("select * from [testUser]",1).getData()
'Response.Write(Jexs.output(obj,"json"))
'Jexs.ado(conn1).execute("select * from [testUser]",1).output("json")
'Response.End()


jsoncode="[{""ID"":1,""userName"":""test"",""userSex"":""boy"",""userTest"":2,""userTime"":""Mon Apr 26 22:33:59 UTC+0800 2010""},{""ID"":2,""userName"":""test"",""userSex"":""boy"",""userTest"":2,""userTime"":""Mon Apr 26 22:33:59 UTC+0800 2010""},{""ID"":3,""userName"":""\u6211\u4eec"",""userSex"":""http:\/\/www.online.sh.cn"",""userTest"":4,""userTime"":""Mon Apr 26 22:33:59 UTC+0800 2010""}]"
Response.Charset = "utf-8"
Response.ContentType="text/xml"
Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
Response.Write("<root>")
Response.Write(json2xml(obj,false,"item"))
Response.Write("</root>")

'Call Jexs.js("alert('我们');",1)
%>