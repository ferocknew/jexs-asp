<!--#include file="Class_GBook.asp"-->
<% 
G.MainOpen

if request.QueryString("action")="passmsg" then
	dim passid
	passid=G.main.NumberYN(request.querystring("msgid"))
	G.main.data.Exe "update msg set showyn=not showyn where id=" & passid
	response.write "OK"
elseif request.QueryString("action")="delmsg" then
	dim delid
	delid=G.main.NumberYN(request.querystring("msgid"))
	G.main.data.Exe "delete from msg where id=" & delid
	response.write "OK"
elseif request.QueryString("action")="replymsg" then
	dim reply,replyid
	replyid=G.main.NumberYN(request.querystring("msgid"))
	reply=request.form("msgreply")
	set grs=G.Main.data.RsOpen("select msgreply from msg where id=" & replyid,3)
	if not grs.eof then
		grs("msgreply")=reply
		grs.update
		response.write "<script>alert(""回复成功！"");window.returnValue=""OK"";window.close();</script>"
	else
		response.write "<script>alert(""回复失败，未找见您要回复的留言！"");window.returnValue=null;window.close();</script>"
	end if
	grs.close
end if

G.MainClose
%>