<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
dim rs,blockname,blockid,i
dim configxml,xml,xmlroot,xmlitems,xmlitem

if request.querystring("action")="delblock" then
	dim t_blockid
	blockid=request.querystring("blockid")
	J.Data.Exe("delete from JCP_Blocks where id in ("&blockid&")")
	response.write "OK"
elseif request.querystring("action")="findconfig" then
	if J.fso.FileE(server.MapPath(request.QueryString("src"))&"\config.xml") then response.write "OK"
elseif request.querystring("action")="checkconfig" then
	configxml=server.MapPath(request.QueryString("src"))&"\config.xml"
	if J.fso.FileE(configxml) then
		set xml=server.CreateObject("Microsoft.XMLDOM")
		xml.Async=true
		xml.Load(configxml)
		set xmlroot = xml.documentElement
		xmlitem=0
		xmlitem = xmlitem + xmlroot.getElementsByTagName("name").length + _
							xmlroot.getElementsByTagName("version").length + _
							xmlroot.getElementsByTagName("author").length + _
							xmlroot.getElementsByTagName("link").length + _
							xmlroot.getElementsByTagName("copyright").length + _
							xmlroot.getElementsByTagName("explain").length + _
							xmlroot.getElementsByTagName("createtime").length + _
							xmlroot.getElementsByTagName("mainfile").length + _
							xmlroot.getElementsByTagName("filelist").length
		if xmlitem = 9 then response.write "OK"
		set xmlroot=nothing
		set xml=nothing
	end if
elseif request.querystring("action")="loadconfig" then
	configxml=server.MapPath(request.QueryString("src"))&"\config.xml"
	if J.fso.FileE(configxml) then
		set xml=server.CreateObject("Microsoft.XMLDOM")
		xml.Async=true
		xml.Load(configxml)
		set xmlroot = xml.documentElement
		dim tname,tversion,tauthor,tlink,tcopyright,texplain,tcreatetime,tmainfile,filecount,tfilelist
		tname=xmlroot.selectSingleNode("name").text
		tversion=xmlroot.selectSingleNode("version").text
		tauthor=xmlroot.selectSingleNode("author").text
		tlink=xmlroot.selectSingleNode("link").text
		tcopyright=xmlroot.selectSingleNode("copyright").text
		texplain=xmlroot.selectSingleNode("explain").text
		tcreatetime=xmlroot.selectSingleNode("createtime").text
		tmainfile=xmlroot.selectSingleNode("mainfile").text
		filecount=xmlroot.getElementsByTagName("file").length
		tfilelist=""
		for i=0 to filecount-1
			if xmlroot.selectSingleNode("filelist").childNodes(i).getElementsByTagName("filename").length=1 and xmlroot.selectSingleNode("filelist").childNodes(i).getElementsByTagName("filename").length=1 then
				if tfilelist="" then
					tfilelist=xmlroot.selectSingleNode("filelist").childNodes(i).selectSingleNode("filename").text & "|" & xmlroot.selectSingleNode("filelist").childNodes(i).selectSingleNode("filepath").text
				else
					tfilelist=tfilelist & "{$|}" & xmlroot.selectSingleNode("filelist").childNodes(i).selectSingleNode("filename").text & "|" & xmlroot.selectSingleNode("filelist").childNodes(i).selectSingleNode("filepath").text
				end if
			end if
		next
		
		set rs = J.Data.RsOpen("select * from JCP_Blocks where id=0",3)
		rs.addnew
		rs("blockname")=tname
		rs("blockversion")=tversion
		rs("blockauthor")=tauthor
		rs("authorlink")=tlink
		rs("copyright")=tcopyright
		rs("blockexplain")=texplain
		rs("createtime")=tcreatetime
		rs("blockfolder")=request.QueryString("src")
		rs("mainfile")=tmainfile
		rs("filelist")=tfilelist
		rs.update
		rs.close
		response.write "OK"
		set xmlroot=nothing
		set xml=nothing
	end if
elseif request.querystring("action")="findfile" then
	if J.fso.FileE(server.MapPath(request.QueryString("src"))) then
		response.write J.fso.FileT(server.MapPath(request.QueryString("src")),1)
	else
		response.write "Error"
	end if
end if
%>
<% J.close %>