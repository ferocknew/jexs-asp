<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
dim requestS,xml,root,path,i,i1,i2,i3,curNode,curNode1,curNode2,curNode3,rs
dim t_systemname,t_systemlogo

if request.QueryString("action")="loadaimdata" then
	set rs=J.Data.Exe("select * from JCP_InterFace where inoutyn=false order by systemlogo,id")
	if not rs.eof then
		dim returnValue
		returnValue="["
		do while not rs.eof
			if t_systemlogo<>rs("systemlogo") then
				t_systemlogo=rs("systemlogo")
				t_systemname=rs("systemname")
				if returnValue="[" then
					returnValue=returnValue & "[""" & t_systemname & """,""" & t_systemlogo & """,["
				else
					returnValue=returnValue & "]],[""" & t_systemname & """,""" & t_systemlogo & """,["
				end if
			end if
			if right(returnValue,1)="[" then
				returnValue=returnValue & "[""" & rs("name") & """,""" & rs("logo") & """]"
			else
				returnValue=returnValue & ",[""" & rs("name") & """,""" & rs("logo") & """]"
			end if
			rs.movenext
		loop
		if returnValue<>"[" then
			returnValue=returnValue & "]]]"
			response.write returnValue
		else
			response.write "no data"
		end if
	else
		response.write "no data"
	end if
	rs.close
elseif request.QueryString("action")="configfilecheck" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.async = false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ�<br>Description: " & xml.parseError.reason & "<br>Line: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	set root = nothing
	set xml  = nothing
	
	do while instr(path,"//")>0
		path=replace(path,"//","/")
	loop
	
	path=server.MapPath(path)
	
	if J.fso.FileE(path) then response.write "OK" else response.write "ERROR"
elseif request.QueryString("action")="configcheck" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	
	path=server.MapPath(path)
	
	xml.Load(path)
	set root = xml.documentElement
	If xml.parseError.errorCode <> 0 Then 
		response.write "XML�ļ����� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	if _
		root.selectSingleNode("logo") is nothing or _
		root.selectSingleNode("name") is nothing or _
		root.selectSingleNode("type") is nothing or _
		root.selectSingleNode("version") is nothing or _
		root.selectSingleNode("author") is nothing or _
		root.selectSingleNode("link") is nothing or _
		root.selectSingleNode("copyright") is nothing or _
		root.selectSingleNode("explain") is nothing or _
		root.selectSingleNode("createtime") is nothing or _
		root.selectSingleNode("system-need") is nothing or _
		root.selectSingleNode("menus") is nothing or _
		root.selectSingleNode("database") is nothing or _
		root.selectSingleNode("path-info") is nothing or _
		root.selectSingleNode("param-out") is nothing _
	then 
		response.write "�����ļ������ṹ����"
		response.end
	end if
	
	'�ӿ�ϵͳ���
	if not root.selectSingleNode("system-need/system") is nothing then
		set curNode=root.selectSingleNode("system-need")
		for i=0 to curNode.childNodes.length-1		'�жϴ�������ӿ�ϵͳʱ�Ļ�����Ϣ
			if _
				curNode.childNodes(i).nodeName<>"system" or _
				curNode.childNodes(i).selectSingleNode("title") is nothing or _
				curNode.childNodes(i).selectSingleNode("logo") is nothing or _
				curNode.childNodes(i).selectSingleNode("intro-param") is nothing _
			then 
				response.write "ϵͳ�ӿڻ�����Ϣ����"
				set curNode=nothing
				response.end
			end if
			set curNode1=curNode.childNodes(i).selectSingleNode("intro-param")
			for i1=0 to curNode1.childNodes.length-1		'�жϴ�������ӿ�ϵͳʱ�Ľӿ���Ϣ
				if _
					curNode1.childNodes(i1).nodeName<>"param" or _
					curNode1.childNodes(i1).selectSingleNode("logo") is nothing or _
					curNode1.childNodes(i1).selectSingleNode("title") is nothing or _
					curNode1.childNodes(i1).selectSingleNode("need-logo") is nothing _
				then 
					response.write "ϵͳ�ӿڲ����ṹ����"
					set curNode=nothing
					set curNode1=nothing
					response.end
				end if
			next
			set curNode1=nothing
		next
		set curNode=nothing
	end if
	
	'���ܵ������
	if not root.selectSingleNode("menus/menu") is nothing then
		set curNode=root.selectSingleNode("menus")
		for i=0 to curNode.childNodes.length-1		'�жϴ��ڹ��ܵ���ʱ�Ļ�����Ϣ
			if _
				curNode.childNodes(i).nodeName<>"menu" or _
				curNode.childNodes(i).selectSingleNode("url") is nothing _
			then 
				response.write "���ܵ�����Ϣ�ṹ����"
				set curNode=nothing
				response.end
			end if
		next
		set curNode=nothing
	end if
	
	'���ݿ���Ϣ���
	if root.selectSingleNode("database").childNodes.length>0 then		'�жϴ������ݿ���Ϣʱ�Ļ�����Ϣ
		set curNode=root.selectSingleNode("database")
		if _
			curNode.selectSingleNode("path") is nothing or _
			curNode.selectSingleNode("name") is nothing or _
			curNode.selectSingleNode("type") is nothing or _
			curNode.selectSingleNode("version") is nothing or _
			curNode.selectSingleNode("tables") is nothing or _
			curNode.selectSingleNode("tables").childNodes.length=0 _
		then 
			response.write "���ݿ���Ϣ�ṹ����"
			set curNode=nothing
			response.end
		end if
		set curNode=nothing
	end if
	
	'����ļ���ַ���
	if root.selectSingleNode("path-info").childNodes.length>0 then		'�жϴ�������ļ�ʱ�Ļ�����Ϣ
		set curNode=root.selectSingleNode("path-info")
		if _
			curNode.selectSingleNode("fore-folder") is nothing or _
			curNode.selectSingleNode("back-folder") is nothing _
		then 
			response.write "ǰ����̨��ص�ַ�ṹ����"
			set curNode=nothing
			response.end
		end if
		set curNode=nothing
	end if
	
	'����������
	if not root.selectSingleNode("param-out/param") is nothing then
		set curNode=root.selectSingleNode("param-out")
		for i=0 to curNode.childNodes.length-1		'�жϴ��ڶ������ʱ�Ļ�����Ϣ
			if _
				curNode.childNodes(i).nodeName<>"param" or _
				curNode.childNodes(i).selectSingleNode("logo") is nothing or _
				curNode.childNodes(i).selectSingleNode("title") is nothing _
			then 
				response.write "���������Ϣ�ṹ����"
				set curNode=nothing
				response.end
			end if
		next
		set curNode=nothing
	end if
	
	
	set root = nothing
	set xml  = nothing
	
	response.write "OK"
elseif request.QueryString("action")="logoonlyonecheck" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	
	path=server.MapPath(path)
	
	xml.Load(path)
	set root = xml.documentElement
	If xml.parseError.errorCode <> 0 Then 
		response.write "XML�ļ����� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	
	if not root.selectSingleNode("logo") is nothing then	'ϵͳ��ʶ
		set rs=J.Data.Exe("select menuid from JCP_AppSystem where menulogo='" & J.Encode(root.selectSingleNode("logo").text) & "'")
		if not rs.eof then
			response.write "����ϵͳ�ı�ʶ�Ѿ������ڹ���ƽ̨�����޸ĺ����ԣ�"
			response.end
		end if
	end if	
	
	if not root.selectSingleNode("database/tables/table") is nothing then	'���ݿ���ļ�
		set curNode=root.selectSingleNode("database/tables")
		for i=0 to curNode.childNodes.length-1
			if J.Data.CheckTable(curNode.childNodes(i).text) then
				response.write "���ݿ��Ѿ����� ��" & curNode.childNodes(i).text & "�����޸ĺ����ԣ�"
				set curNode=nothing
				response.end
			end if
		next
		set curNode=nothing
	end if	
	
	set root = nothing
	set xml  = nothing
	
	response.write "OK"
elseif request.QueryString("action")="interfacecheck" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	
	path=server.MapPath(path)
	
	xml.Load(path)
	set root = xml.documentElement
	If xml.parseError.errorCode <> 0 Then 
		response.write "XML�ļ����� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	
	if not root.selectSingleNode("system-need/system") is nothing then	'������Ҫ�Խӵ�ϵͳ
		set curNode=root.selectSingleNode("system-need")
		dim paramCount:paramCount=0
		for i=0 to curNode.childNodes.length-1
			if not curNode.childNodes(i).selectSingleNode("intro-param/param") is nothing then
				paramCount=paramCount+curNode.childNodes(i).selectSingleNode("intro-param").childNodes.length
			end if
		next
		if paramCount=0 then response.write "no param" else response.write "has param"
		set curNode=nothing
	else
		response.write "no need"
	end if	
	
	set root = nothing
	set xml  = nothing
elseif request.QueryString("action")="savebinddata" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	
	dim bindcount,bindlist
	set bindlist = root.selectSingleNode("bindlist")
	bindcount = bindlist.childNodes.length
	
	if bindcount>0 then
		set rs=J.Data.RsOpen("select * from JCP_InterFace where id=0",3)
		for i=0 to bindcount-1
			rs.addnew
			rs("name")=bindlist.childNodes(i).selectSingleNode("needname").text
			rs("logo")=bindlist.childNodes(i).selectSingleNode("needlogo").text
			rs("systemname")=root.selectSingleNode("cursystemname").text
			rs("systemlogo")=root.selectSingleNode("cursystemlogo").text
			rs("aimid")=J.Data.Exe("select id from JCP_InterFace where logo='" & bindlist.childNodes(i).selectSingleNode("aimlogo").text & "' and systemlogo='" & bindlist.childNodes(i).selectSingleNode("aimsystemlogo").text & "'")(0)
			rs("inoutyn")=true
			rs.update
			
			J.SystemIntroList 0,1,"JCP_InterFace","id="&rs("id")	'��¼�������
			
		next
		rs.close
		response.write "OK"
	end if
	set bindlist=nothing
elseif request.QueryString("action")="systemsetup" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	
	path=server.MapPath(path)
	
	xml.Load(path)
	set root = xml.documentElement
	If xml.parseError.errorCode <> 0 Then 
		response.write "XML�ļ����� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
		
	t_systemlogo=root.selectSingleNode("logo").text
	t_systemname=root.selectSingleNode("name").text
	
	dim submenutitle,submenuurl
	submenutitle="":submenuurl=""
	if not root.selectSingleNode("menus/menu") is nothing then	'����ϵͳ����Ŀ¼
		set curNode=root.selectSingleNode("menus")
		for i=0 to curNode.childNodes.length-1
			if submenutitle="" and submenuurl="" then
				submenutitle=curNode.childNodes(i).selectSingleNode("title").text
				submenuurl="../" & t_systemlogo & "/" & curNode.childNodes(i).selectSingleNode("url").text
			else
				submenutitle = submenutitle & "|" & curNode.childNodes(i).selectSingleNode("title").text
				submenuurl = submenuurl & "|../" & t_systemlogo & "/" & curNode.childNodes(i).selectSingleNode("url").text
			end if
		next
		set curNode=nothing
	end if	
	J.Data.Exe("insert into JCP_AppSystem(menulogo,menutitle,submenutitle,submenuurl,typeid) values('" & t_systemlogo & "','" & t_systemname & "','" & submenutitle & "','" & submenuurl & "',2)")
	dim bindid:bindid=J.Data.Exe("select max(menuid) from JCP_AppSystem")(0)
			
	J.SystemIntroList 0,1,"JCP_AppSystem","menuid="&bindid	'��¼�������
	
	set rs=J.Data.RsOpen("select * from JCP_menus where menuid=0",3)
	rs.addnew
	rs("menuname")=t_systemname
	rs("rootid")=rs("menuid")
	rs("parentid")=0
	rs("parentpath")="0," & rs("menuid") & ","
	rs("menugrade")=1
	rs("menuson")=0
	rs("bindtype")=2
	rs("menutime")=date()
	rs("bindcont")=bindid
	rs("orderid")=J.Data.Exe("select max(orderid) from JCP_menus")(0) + 1
	rs.update
			
	J.SystemIntroList 0,1,"JCP_menus","menuid="&rs("menuid")	'��¼�������
	
	rs.close
	
	if not root.selectSingleNode("param-out/param") is nothing then	'���ڶ���ӿڹ������
		set curNode=root.selectSingleNode("param-out")
		for i=0 to curNode.childNodes.length-1
			J.Data.Exe("insert into JCP_InterFace(name,logo,systemname,systemlogo) values('"&curNode.childNodes(i).selectSingleNode("title").text&"','"&curNode.childNodes(i).selectSingleNode("logo").text&"','"&t_systemname&"','"&t_systemlogo&"')")
			
			J.SystemIntroList 0,1,"JCP_InterFace","id="&J.Data.Exe("select max(id) from JCP_InterFace")(0)	'��¼�������
			
		next
		set curNode=nothing
	end if	

	set root = nothing
	set xml  = nothing
	
	response.write "OK"
elseif request.QueryString("action")="filecopy" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	
	path=server.MapPath(path)
	
	xml.Load(path)
	set root = xml.documentElement
	If xml.parseError.errorCode <> 0 Then 
		response.write "XML�ļ����� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
		
	t_systemlogo=root.selectSingleNode("logo").text
	t_systemname=root.selectSingleNode("name").text
	
	if not root.selectSingleNode("path-info/fore-folder") is nothing then	'����ϵͳǰ̨Ŀ¼
		if root.selectSingleNode("path-info/fore-folder").text<>"" then J.fso.FolderC replace(Lcase(path),"config.xml","") & root.selectSingleNode("path-info/fore-folder").text,J.SiteRoot & t_systemlogo
		J.SystemIntroList 0,2,t_systemlogo,"front"	'��¼�������
	end if
	if not root.selectSingleNode("path-info/back-folder") is nothing then	'����ϵͳ��̨Ŀ¼
		if root.selectSingleNode("path-info/back-folder").text<>"" then J.fso.FolderC replace(Lcase(path),"config.xml","") & root.selectSingleNode("path-info/back-folder").text,J.ManageRoot & t_systemlogo
		J.SystemIntroList 0,2,t_systemlogo,"back"	'��¼�������
	end if
		
	response.write "OK"
elseif request.QueryString("action")="databasesetup" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	
	path=server.MapPath(path)
	
	xml.Load(path)
	set root = xml.documentElement
	If xml.parseError.errorCode <> 0 Then 
		response.write "XML�ļ����� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
		
	if not root.selectSingleNode("database/tables/table") is nothing then	'������Ҫ���Ƶ����ݱ�
		set curNode=root.selectSingleNode("database/tables")
		dim curTable,fromBase
		fromBase=replace(	replace(Lcase(path),"config.xml","") & replace(root.selectSingleNode("database/path").text,"/","\") & "\"	,"\\","\") & root.selectSingleNode("database/name").text
		for i=0 to curNode.childNodes.length-1
			curTable=curNode.childNodes(i).text
			if J.BlankTF(curTable) then
				''''''''''''''''''''''''''''''''''''
				'�������ݱ�����ͬʱ���Ʊ�������������ȣ��д���ǿ
				J.Data.Exe("select * into " & curTable & " from " & curTable & " in """ & fromBase & """")
				''''''''''''''''''''''''''''''''''''
				J.SystemIntroList 0,0,curTable,""	'��¼�������
			end if
		next
		set curNode=nothing
	end if
		
	response.write "OK"	
elseif request.QueryString("action")="purviewsetup" then
	
elseif request.QueryString("action")="configsetup" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	
	path=server.MapPath(path)
	
	xml.Load(path)
	set root = xml.documentElement
	If xml.parseError.errorCode <> 0 Then 
		response.write "XML�ļ����� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
		
	t_systemlogo=root.selectSingleNode("logo").text
	t_systemname=root.selectSingleNode("name").text
		
	set rs=J.Data.Exe("select a.*,b.logo,b.name from JCP_InterFace a left join (select id,logo,name from JCP_InterFace where inoutyn=false) b on a.aimid=b.id where a.systemlogo='"&t_systemlogo&"' and a.systemname='"&t_systemname&"' and a.inoutyn=true")
	dim interface:interface=""
	do while not rs.eof
		interface = interface & vbcrlf & "session(""" & rs("a.logo") & """)=session(""" & rs("b.logo") & """)"
		rs.movenext
	loop
	rs.close
	
	if interface<>"" then
		if not root.selectSingleNode("path-info/fore-folder") is nothing then J.fso.FileN J.SiteRoot & t_systemlogo & "/InterFace.asp","<" & "%" & vbcrlf & "'�ӿڲ�����ϵͳ��ʱ���ݹ���Աѡ���Զ�����" & vbcrlf & interface & vbcrlf & "%" & ">"
		J.fso.FileN J.ManageRoot & t_systemlogo & "/InterFace.asp","<" & "%" & vbcrlf & "'�ӿڲ�����ϵͳ��ʱ���ݹ���Աѡ���Զ�����" & vbcrlf & interface & vbcrlf & "%" & ">"
	end if
	
	J.fso.FileC path,J.ManageRoot & t_systemlogo & "\old_config.xml"
	
	response.write "OK"			
elseif request.QueryString("action")="logsetup" then
	set xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=false
	requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
	xml.loadXML(requestS)
	If xml.parseError.errorCode <> 0 Then 
		response.write "������ȷ����XML���ݣ� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
	set root = xml.documentElement
	path = root.selectSingleNode("path").text
	
	path=server.MapPath(path)
	
	xml.Load(path)
	set root = xml.documentElement
	If xml.parseError.errorCode <> 0 Then 
		response.write "XML�ļ����� ԭ��: " & xml.parseError.reason & " ��: " & xml.parseError.Line
		response.End()
	end if
		
	t_systemlogo=root.selectSingleNode("logo").text
	t_systemname=root.selectSingleNode("name").text

	J.Data.Exe "insert into JCP_SystemIntroLog(updatetype,objecttype,objectcontent,objectother,updatetime,systemlogo) select updatetype,objecttype,objectcontent,objectother,updatetime,'"&t_systemlogo&"' from JCP_SystemIntroList where sessionid='"&session.SessionID&"'"
	J.Data.Exe "delete from JCP_SystemIntroList where sessionid='"&session.SessionID&"'"
	
	response.write "OK"			
elseif request.QueryString("action")="unsetup" then
	if J.SystemIntroUnInstall(null) then
		response.write "OK"
	else
		response.write J.ErrStr
	end if
else
	response.write "ERROR"
end if
%>
<% J.close %>