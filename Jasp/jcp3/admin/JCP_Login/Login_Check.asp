<!--#include file="../JCP_Shared/asp_head.asp" -->
<% 
if request.form("checkcode")=Session("GetCode") then
	dim rs,logined
	set rs=J.Data.Exe("select * from JCP_admin where adminname='"&request.form("adminname")&"'")
	if rs.eof then
		response.write "<script>alert(""用户名不存在！"");history.back()</script>"
	else
		if rs("adminpwd")=J.Md5(request.form("adminpwd")) then
			session("JCP_AdminName")=rs("adminname")
			session("JCP_AdminID")=rs("adminid")
			session("JCP_AdminType")=rs("admintype")
			session("JCP_AdminPurv")=rs("adminpurv")
			session("JCP_Login")=true
			logined=true
			J.Admin_Guide_Purv_Load
		else
			response.write "<script>alert(""密码错误！"");history.back()</script>"
		end if
	end if
	rs.close
	if logined then response.redirect "../JCP_Win/"
else
	response.write "<script>alert(""您输入的验证码不正确！"");history.back()</script>"
end if
%>
<% J.close %>