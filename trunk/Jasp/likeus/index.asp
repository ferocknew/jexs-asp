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
response.write Jasp.Fso.File.Exist()
response.write "<br>2 "
response.write Jasp.Fso.File.get()
response.write "<br>3 "
response.write Jasp.Fso.File.get(server.MapPath("HI.txt"))
response.write "<br>4 "
response.write Jasp.Fso.File.Exist(server.MapPath("HI.txt"))
response.write "<br>5 "
response.write Jasp.Fso.File.Create(server.MapPath("HI.txt")).output()
response.write "<br>6 "
response.write Jasp.Fso.File.Create(server.MapPath("HI3.txt")).get()
%>