<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
dim rs,blockname,blockid,i

if request.querystring("action")="blocknamecheck" then
	blockname=J.BlankYn(request.querystring("blockname"))
	set rs=J.Data.Exe("select id from JCP_BlockList where blockname='"&blockname&"'")
	if rs.eof then
		response.write "OK"
	end if
	rs.close
elseif request.querystring("action")="delblock" then
	dim t_blockid
	blockid=request.querystring("blockid")
	set rs=J.Data.Exe("select id,blocktype from JCP_BlockList where blocktype in (3,5,6) and id in ("&blockid&")")
	do while not rs.eof
		if rs("blocktype")=3 or rs("blocktype")=5 then
			J.fso.FileD J.SiteRoot & J.ScriptPath & "\" & rs("id") & ".js"
		elseif rs("blocktype")=6 then
			J.fso.FileD J.SiteRoot & J.ScriptPath & "\" & rs("id") & ".vbs"
		end if
		rs.movenext
	loop
	rs.close
	J.Data.Exe("delete from JCP_BlockList where id in ("&blockid&")")
	response.write "OK"
elseif request.querystring("action")="copyblock" then
	blockid=J.NumberYn(request.querystring("blockid"))
	set rs=J.Data.Exe("select * from JCP_BlockList where id="&blockid)
	if rs.eof then
		response.write "ERROR"
	else
		dim rss,modyn,copyi,t_blockname
		blockname=rs("blockname")
		modyn=true
		copyi=0
		do while modyn
			copyi=copyi+1
			t_blockname=blockname & " ¸´¼þ" & copyi
			set rss=J.Data.ReRsOpen("select * from JCP_BlockList where blockname='"&t_blockname&"'","rss",3)
			if rss.eof then
				rss.addnew
				rss("blockname")=t_blockname
				rss("blocktype")=rs("blocktype")
				rss("blockexplain")=rs("blockexplain")
				rss("BlockAttribute")=rs("BlockAttribute")
				rss("blockeditfile")=rs("blockeditfile")
				rss("blockmanage")=rs("blockmanage")
				rss("blockfolder")=rs("blockfolder")
				rss.update
				if rs("blocktype")=3 or rs("blocktype")=5 then
					J.fso.FileC J.SiteRoot & J.ScriptPath & "\" & rs("id") & ".js",J.SiteRoot & J.ScriptPath & "\" & rss("id") & ".js"
				elseif rs("blocktype")=6 then
					J.fso.FileC J.SiteRoot & J.ScriptPath & "\" & rs("id") & ".vbs",J.SiteRoot & J.ScriptPath & "\" & rss("id") & ".vbs"
				end if
				rss.close
				modyn=false
				response.write "OK"
			end if
		loop
	end if
	rs.close
end if
%>
<% J.close %>