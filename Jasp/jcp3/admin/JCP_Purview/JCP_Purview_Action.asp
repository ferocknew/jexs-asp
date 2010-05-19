<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
if request.QueryString("action")="add" then
	dim addrs
	set addrs=J.Data.RsOpen("select * from JCP_purview where id=0",3)
	addrs.addnew
	addrs("purv_name")="Î´ÃüÃû"
	addrs.update
	response.write addrs("id")
	addrs.close
elseif request.QueryString("action")="del" then
	dim delrs,delid
	delid=request.QueryString("delid")
	J.NumberYn replace(delid,",","")
	J.Data.Exe "delete from JCP_purviewlist where purv_id in("&delid&")"
	J.Data.Exe "delete from JCP_purview where id in("&delid&")"
	response.write "OK"
elseif request.QueryString("action")="modname" then
	dim modname,modid
	modname=J.BlankYn(request.QueryString("name"))
	modid=J.NumberYn(request.QueryString("modid"))
	J.Data.Exe("update JCP_purview set purv_name='"&modname&"' where id="&modid)
	response.write "OK"
elseif request.QueryString("action")="addurl" then
	dim filepath,actid,urlrs
	filepath=J.BlankYn(request.QueryString("filepath"))
	actid=J.NumberYn(request.QueryString("actid"))
	set urlrs=J.Data.RsOpen("select * from JCP_purviewlist where id=0",3)
	urlrs.addnew
	urlrs("purv_id")=actid
	urlrs("purv_url")=filepath
	urlrs.update
	response.write urlrs("id")
	urlrs.close
elseif request.QueryString("action")="delurl" then
	dim delurlid
	delurlid=request.QueryString("delurlid")
	J.NumberYn delurlid
	J.Data.Exe "delete from JCP_purviewlist where id="&delurlid
	response.write "OK"

elseif request.QueryString("action")="addteam" then
	dim addteamrs
	set addteamrs=J.Data.RsOpen("select * from JCP_purviewteam where id=0",3)
	addteamrs.addnew
	addteamrs("team_name")="Î´ÃüÃû"
	addteamrs.update
	response.write addteamrs("id")
	addteamrs.close
elseif request.QueryString("action")="delteam" then
	dim delteamrs,delteamid
	delteamid=request.QueryString("delid")
	J.NumberYn replace(delteamid,",","")
	J.Data.Exe "delete from JCP_purviewteam where id in("&delteamid&")"
	response.write "OK"
elseif request.QueryString("action")="modteamname" then
	dim modteamname,modteamid
	modteamname=J.BlankYn(request.QueryString("name"))
	modteamid=J.NumberYn(request.QueryString("modid"))
	J.Data.Exe("update JCP_purviewteam set team_name='"&modteamname&"' where id="&modteamid)
	response.write "OK"
elseif request.QueryString("action")="setteam" then
	dim teamids,setteamid,setteamrs
	teamids=request.QueryString("teamids")
	setteamid=J.NumberYn(request.QueryString("teamid"))
	J.Data.Exe("update JCP_purviewteam set purv_ids='"&teamids&"' where id="&setteamid)
	set setteamrs=J.Data.Exe("select * from JCP_purview where id in("&teamids&") order by purv_name")
	do while not setteamrs.eof
		response.write "o.options.add(new Option("""&setteamrs("purv_name")&""","&setteamrs("id")&"));"
		setteamrs.movenext
	loop
	setteamrs.close
elseif request.QueryString("action")="delteampurv" then
	dim delteampurvid,delpurvactid,delteampurvids
	delteampurvid=J.NumberYn(request.QueryString("delteampurvid"))
	delpurvactid=J.NumberYn(request.QueryString("teamid"))
	delteampurvids=J.Data.Exe("select 's,'&purv_ids&',e' from JCP_purviewteam where id="&delpurvactid)(0)
	delteampurvids=replace(replace(replace(replace(replace(delteampurvids,","&delteampurvid&",",","),"s,",""),",e",""),"s",""),"e","")
	J.Data.Exe "update JCP_purviewteam set purv_ids='"&delteampurvids&"' where id="&delpurvactid
	response.write "OK"
elseif request.QueryString("action")="setguideteam" then
	dim gteamids,gteamid
	gteamids=request.QueryString("teamids")
	gteamid=J.NumberYn(request.QueryString("teamid"))
	J.Data.Exe("update JCP_purviewteam set guide_ids='"&gteamids&"' where id="&gteamid)
	response.write "OK"
end if
%>
<% J.close %>