<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<!--#include file="../JCP_Shared/body.asp" -->
<%
dim adminid,adminname,adminpwd,adminexp,admintype,adminpurv,rs

if request.QueryString("action")="addadmin" then
	adminname=J.BlankYn(request.Form("adminname"))
	if not J.SafeYn(adminname) then
		response.write "[<a href=""javascript:history.back();"">返回</a>]　"
		J.ErrStr="管理帐户含有非法字符，请修改！！"
		J.ErrOpen("back")
	end if
	adminpwd=J.BlankYn(request.Form("adminpwd"))
	adminexp=request.Form("adminexp")
	admintype=J.NumberYn(request.Form("adminarea"))
	if admintype>0 then
		adminpurv=J.NumberYn(request.Form("adminpurv"))
	else
		adminpurv=0
	end if
	set rs=J.Data.RsOpen("select * from JCP_admin where adminname='"&adminname&"'",3)
	if rs.eof then
		rs.addnew
		rs("adminname")=adminname
		rs("adminpwd")=J.MD5(adminpwd)
		rs("adminexp")=adminexp
		rs("admintype")=admintype
		rs("adminpurv")=adminpurv
		rs.update
		response.write "<script language=""javascript"">alert(""帐户已成功创建！"");history.back();</script>"
	else
		response.write "<script language=""javascript"">alert(""帐户已经存在，请立即更换！"");history.back();</script>"
	end if
	rs.close
elseif request.QueryString("action")="editadmin" then
	adminid=J.NumberYn(request.Form("actid"))
	adminname=J.BlankYn(request.Form("adminname"))
	if not J.SafeYn(adminname) then
		response.write "[<a href=""javascript:history.back();"">返回</a>]　"
		J.ErrStr="管理帐户含有非法字符，请修改！！"
		J.ErrOpen("back")
	end if
	adminpwd=request.Form("adminpwd")&""
	adminexp=request.Form("adminexp")
	admintype=J.NumberYn(request.Form("adminarea"))
	if admintype>0 then
		adminpurv=J.NumberYn(request.Form("adminpurv"))
	else
		adminpurv=0
	end if
	set rs=J.Data.RsOpen("select * from JCP_admin where adminid="&adminid,3)
	if not rs.eof then
		rs("adminname")=adminname
		if adminpwd<>"" then rs("adminpwd")=J.MD5(adminpwd)
		rs("adminexp")=adminexp
		rs("admintype")=admintype
		rs("adminpurv")=adminpurv
		rs.update
		response.write "<script language=""javascript"">alert(""帐户已成功修改！"");history.back();</script>"
	else
		response.write "<script language=""javascript"">alert(""帐户不存在！"");history.back();</script>"
	end if
	rs.close
elseif request.QueryString("action")="deladmin" then
	adminid=J.NumberYn(request.Querystring("actid"))
	set rs=J.Data.RsOpen("select * from JCP_admin where adminid="&adminid,3)
	if not rs.eof then
		adminname=rs("adminname")
		rs.delete
		rs.update
		response.write "<script language=""javascript"">alert(""成功删除帐户（"&adminname&"）！"");history.back();</script>"
	else
		response.write "<script language=""javascript"">alert(""帐户不存在！"");history.back();</script>"
	end if
	rs.close
end if
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>