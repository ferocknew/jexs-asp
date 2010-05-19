<!--#include file="../INC/Class_Search.asp"-->
<%
S.MainOpen

dim aid,sid
sid=S.Main.NumberYn(request.querystring("sid"))
aid=S.Main.NumberYn(request.querystring("aid"))

dim J,rssurl
set J=new JCP
J.WebOpen server.MapPath(searchdatabase)
set rs=J.data.RsOpen("select * from Article_" & sid & " where id=" & aid,1)
if rs.eof then
	response.write "<script>alert(""未找到您需要的数据信息！"");</script>"
	url=""
else
	dim ii
	url=sid
	for ii=0 to rs.fields.count-1
		if instr(rs(ii).name,"_class")>0 then url=url & "," & rs(ii)
	next
end if
rs.close
J.WebClose

S.MainClose

if url<>"" then response.redirect searchfilefolder & "/" & url & "/Content" & aid & "." & searchfileext
%>