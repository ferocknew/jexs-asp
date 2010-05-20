<%@language="VBscript" codepage="65001"%>
<%
response.charset="utf-8"
%>
<!--#include file="Jasp.asp"-->
<!--#include file="Fso.asp"-->
<!--#include file="Error.asp"-->
<hr />
<%
response.write "<br>"
response.write typename(Jasp.Fso)
response.write "<br>"
response.write typename(Jasp.File.Create("c:\HI.txt"))
%>