<%@language="VBscript" codepage="65001"%>
<%
response.charset="utf-8"
%>
<!--#include file="Jasp.asp"-->
<!--#include file="Error.asp"-->
<!--#include file="Fso.asp"-->
<hr />
<%
response.write "<br>1 "
'response.write Jasp.fso.folder().tempCreate(server.MapPath("./")).get()
response.write "<br>2 "
response.write Jasp.fso.folder(server.MapPath("test")).create().get()
response.write "<br>3 "
response.write Jasp.fso.folder(server.MapPath("test")).move(server.MapPath("./")).get()
response.write "<br>4 "
response.write Jasp.fso.folder(server.MapPath("test")).name()
response.write "<br>5 "
response.write Jasp.fso.folder(server.MapPath("test")).rename("testme").get()
response.write "<br>6 "
response.write Jasp.fso.folder().check().get()





response.write "<br>100 "
response.write typename(Jasp.Fso.folder().clear())
response.write "<br>1001 "
response.write typename(Jasp.Fso.get())
%>