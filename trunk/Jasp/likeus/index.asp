<%@language="VBscript" codepage="65001"%>
<%
response.charset="utf-8"
%>
<!--#include file="Jasp.asp"-->
<!--#include file="Error.asp"-->
<!--#include file="Fso.asp"-->
<hr />
<%
response.write "<br>0 "
response.write typename(Jasp.Fso.get())
response.write "<br>1 "
response.write Jasp.Fso.File(server.MapPath("HI.txt")).get()
response.write "<br>2 "
response.write Jasp.Fso.File().get()
response.write "<br>3 "
response.write Jasp.Fso.File().Exist()
response.write "<br>4 "
response.write Jasp.Fso.File(server.MapPath("HI.txt")).Exist()
response.write "<br>5 "
response.write Jasp.Fso.File(server.MapPath("HI.txt")).Create().Exist()
response.write "<br>6 "
response.write Jasp.Fso.File().get()
response.write "<br>7 "
response.write Jasp.Fso.File(server.MapPath("HI3.txt")).Create().get()
	response.write "<br>&nbsp; &nbsp;"
	set f = Jasp.Fso.File(server.MapPath("HI3.txt"))
	response.write f.Create().get().path
response.write "<br>8 "
response.write Jasp.Fso.File(server.MapPath("HI3.txt")).output()
response.write "<br>9 "
response.write Jasp.Fso.File(server.MapPath("HI3.txt")).Create().output()
response.write "<br>10 "
response.write Jasp.Fso.File(server.MapPath("HI3.txt")).output()
response.write "<br>11 "
response.write Jasp.Fso.File().tempCreate(server.MapPath("./")).get()
response.Write("　　随机文件生成测试成功")
response.write "<br>12 "
response.write Jasp.Fso.File(server.MapPath("HI4.txt")).write("I this over!").read().output()
response.write "<br>13 "
response.write Jasp.Fso.File(server.MapPath("HI3.txt")).read().output()
response.write "<br>14 "
response.write Jasp.Fso.File(server.MapPath("HI4.txt")).append("append now!").read().output()
response.write "<br>15 "
response.write Jasp.Fso.File(server.MapPath("HI4.txt")).delete().exist()
response.write "<br>16 "
response.write Jasp.Fso.File(server.MapPath("HI3.txt")).move(server.MapPath("../")).get()
response.write "　　诡异原因：" & Jasp.Error.output()
response.write "<br>17 "
response.write Jasp.Fso.File(server.MapPath("HI3.txt")).copy(server.MapPath("../")).get()
response.write "　　诡异原因：" & Jasp.Error.output()
response.write "<br>18 "
response.write Jasp.Fso.File("gg").name()
response.write "<br>19 "
response.write Jasp.Fso.File(server.MapPath("HI3.txt")).rename("HIme.txt").get()
response.write "　　" & Jasp.Error.output()
response.write "<br>20 "
response.write Jasp.Fso.File("s.s").ext()
response.write Jasp.Error.output()





response.write "<br>100 "
response.write typename(Jasp.Fso.File().clear())
response.write "<br>1001 "
response.write typename(Jasp.Fso.get())
%>