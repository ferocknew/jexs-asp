<!--#include file="Jasp.asp"-->
<%
	if request.querystring("type")="zh" then
		'中文验证码
		Jasp.checkcode.createZH(request("checkcodeid"))
	else
		'数字验证码
		Jasp.checkcode.set("bgRed",255).create(request("checkcodeid"))
	end if
%>
