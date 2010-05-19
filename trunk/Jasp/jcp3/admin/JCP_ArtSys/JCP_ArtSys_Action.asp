<!--#include file="../JCP_Shared/asp_head.asp" -->
<% 
if request.QueryString("action")="del" then
	on error resume next
	dim menuid,classcol,rss,k
	menuid=J.NumberYN(request.QueryString("menuid"))
	rss=J.Data.GetRows("select item_id & '_class' from JCP_ArtSys where sys_id="&menuid&" and item_type='class'")
	k=ubound(rss,2)
	if err=0 then
		for k=0 to ubound(rss,2)
			classcol=rss(0,k)
			J.Data.Exe("update (select artcount from Article_"&menuid&",class where "&classcol&"=classid) set artcount=artcount-1")
		next
	else
		err=0
	end if
	
	sql="delete from JCP_AppSystem where menuid="&menuid
	J.Data.Exe(sql)
	if J.Data.CheckTable("Article_"&menuid) then J.Data.DelTable("Article_"&menuid)
	sql="delete from JCP_ArtSys where sys_id="&menuid
	J.Data.Exe(sql)

	response.write "成功删除此系统！！"
	response.end
elseif request.QueryString("action")="uninstall" then
	dim systemlogo
	if J.BlankTF(request.QueryString("logo")) then
		systemlogo=request.QueryString("logo")
		if J.SystemIntroUnInstall(systemlogo) then
			response.write "OK"
		else
			response.write J.ErrStr
		end if
	else
		response.write "传递的卸载参数有误！！"
	end if
	response.end
elseif request.QueryString("action")="logocheck" then
	dim logoid,logo,logors
	logoid=J.NumberYN(request.QueryString("menuid"))
	logo=J.BlankYN(request.QueryString("menulogo"))
	set logors=J.Data.Exe("select menuid from JCP_AppSystem where menuid<>"&logoid&" and menulogo='"&logo&"'")
	if logors.eof then
		response.write "OK"
	else
		response.write "Error"
	end if 
	logors.close
	response.end
end if

'xml载入的两种方法

dim requestS,xml,root,SysItem
dim rs
set xml = Server.CreateObject("Microsoft.XMLDOM")
xml.async = false
'方法一
'xml.load request  '在没有中文的情况下可以使用，在不转换的情况下可以用requestText获取正常中文

'方法二
requestS=J.URLDecode(J.B2S(request.BinaryRead(request.TotalBytes)))
xml.loadXML(requestS)

If xml.parseError.errorCode <> 0 Then 
	response.write "不能正确接收数据" & "Description: " & xml.parseError.reason & "<br>Line: " & xml.parseError.Line
End If

set root = xml.documentElement
dim sys_id,sys_name,sys_logo,item_id,item_type,item_name,item_label,item_content,item_order,temp_sysid
dim item_ids,EditTimes:item_ids="'0'":EditTimes=false
dim sql,i
temp_sysid=0
for each SysItem in root.childNodes
	sys_id       = SysItem.selectSingleNode("sys_id").text
	sys_name     = SysItem.selectSingleNode("sys_name").text
	sys_logo     = SysItem.selectSingleNode("sys_logo").text
	item_id      = SysItem.selectSingleNode("item_id").text
	item_type    = SysItem.selectSingleNode("item_type").text
	item_name    = SysItem.selectSingleNode("item_name").text
	item_label   = SysItem.selectSingleNode("item_label").text
	item_content = replace(replace(replace(replace(SysItem.selectSingleNode("item_content").text,"[[","<"),"]]",">"),"＆","&"),"＋","+")
	item_order   = SysItem.selectSingleNode("item_order").text
	
	item_ids=item_ids&",'"&item_id&"'"
	
	if temp_sysid=0 then
		set rs=J.Data.RsOpen("select * from JCP_AppSystem where menuid="&sys_id,3)
		if rs.eof then 
			rs.addnew
			sys_id=rs("menuid")
			rs("submenutitle")="数据添加|数据管理|页面推送"
			rs("submenuurl")="../JCP_Article/JCP_ArtAdd.asp?sysid="&sys_id&"|../JCP_Article/JCP_ArtManage.asp?sysid="&sys_id&"|../JCP_Push/JCP_PushByClassTemplateID.asp?sysid="&sys_id&"&sysname="&sys_name
			rs("typeid")=1
		end if
		rs("menutitle")=sys_name
		rs("menulogo")=sys_logo
		rs.update
		rs.close
		temp_sysid=sys_id
	else
		sys_id=temp_sysid
	end if
	
	set rs=J.Data.RsOpen("select * from JCP_ArtSys where sys_id="&sys_id&" and item_id='"&item_id&"'",3)
	if rs.eof then
		rs.addnew
		rs("sys_id")=sys_id
		rs("item_id")=item_id
		rs("item_type")=item_type
		rs("item_name")=item_name
		rs("item_label")=item_label
		rs("item_content")=item_content
		rs("item_order")=item_order
		ArtSys_Add sys_id,item_id,item_type,item_label
	else
		if item_type="checkbox" then
			if rs("item_label")<>item_label then
				dim old_label_num,new_label_num
				old_label_num=ubound(split(rs("item_label")&"","{$|}"))+1
				new_label_num=ubound(split(item_label&"","{$|}"))+1
				if old_label_num>new_label_num then
					for i=new_label_num+1 to old_label_num
						J.Data.DelColumn "Article_"&sys_id,item_id & "_" & rs("item_type") & "_" & i
					next
				elseif old_label_num<new_label_num then
					for i=old_label_num+1 to new_label_num
						J.Data.AddColumn "Article_"&sys_id , item_id & "_" & rs("item_type") & "_" & i , "smallint default 0" ,false
					next
				end if
			end if
		end if
		rs("item_label")=item_label
		rs("item_name")=item_name
		rs("item_content")=item_content
		rs("item_order")=item_order
	end if
	rs.update
	rs.close
next
dim pagesizeYN
pagesizeYN=false
set rs=J.Data.RsOpen("select * from JCP_ArtSys where sys_id="&sys_id&" and item_id not in ("&item_ids&")",3)
do while not rs.eof
	if rs("item_type")="checkbox" then
		dim label_num
		label_num=ubound(split(rs("item_label")&"","{$|}"))+1
		for i=1 to label_num
			J.Data.DelColumn "Article_"&sys_id,rs("item_id") & "_checkbox_" & i
		next
	elseif rs("item_type")="pics" then
		J.Data.DelColumn "Article_"&sys_id,rs("item_id") & "_pics"
		J.Data.DelColumn "Article_"&sys_id,rs("item_id") & "_pics_title"
		J.Data.DelColumn "Article_"&sys_id,rs("item_id") & "_pics_count"
	elseif rs("item_type")="map" then
		J.Data.DelColumn "Article_"&sys_id,rs("item_id")
		J.Data.DelColumn "Article_"&sys_id,rs("item_id") & "_mapx"
		J.Data.DelColumn "Article_"&sys_id,rs("item_id") & "_mapy"
	else
		if rs("item_type")<>"button" and rs("item_type")<>"pagesize" then J.Data.DelColumn "Article_"&sys_id,rs("item_id") & "_" & rs("item_type")
	end if
	if rs("item_type")="pagesize" then
		pagesizeYN=true
	else
		rs.delete
	end if
	rs.movenext
loop
if not pagesizeYN then
	rs.addnew
	rs("sys_id")=sys_id
	rs("item_id")="20"
	rs("item_type")="pagesize"
	rs("item_name")="列表长度"
	rs("item_label")="默认为:每页20条"
	rs("display")=1
	rs.update
end if
rs.close

if EditTimes then 
	'response.write "top.frames['menus_box'].location.reload();alert('系统定制成功！\n\n"&J.DataTimes&"');location='JCP_ArtSys.asp?sysid="&sys_id&"';"
	response.write "alert('系统定制成功！\n\n"&J.DataTimes&"');location='JCP_ArtSys.asp?sysid="&sys_id&"';"
else
	response.write "alert('系统定制成功！');"
	'response.write "alert('系统定制成功！\n\n"&J.DataTimes&"');"
end if

sub ArtSys_Add(sysid,itemid,itemtype,itemlabel)
	if not J.Data.CheckTable("Article_"&sysid) then
		if J.Data.CreateTable("Article_"&sysid,"") then
			J.Data.AddColumn "Article_"&sysid , "id" , "counter PRIMARY KEY" ,false
			J.Data.AddColumn "Article_"&sysid , "UpTime" , "datetime default now()" ,false
			J.Data.AddColumn "Article_"&sysid , "deleted" , "integer default 0" ,false
			J.Data.AddColumn "Article_"&sysid , "hits" , "integer default 0" ,false
			J.Data.AddColumn "Article_"&sysid , "userid" , "integer default 0" ,false
			EditTimes=true
		else
			'建表失败
		end if
	end if
	select case itemtype
		case "pics"
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype , "memo null" ,true
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype & "_title" , "memo null" ,true
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype & "_count" , "integer default 0" ,false
		case "textarea","edit"
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype , "memo null" ,true
		case "number","radio","class"
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype , "integer default 0" ,false
		case "checkbox"
			dim label_num
			label_num=ubound(split(itemlabel&"","{$|}"))+1
			for i=1 to label_num
				J.Data.AddColumn "Article_"&sys_id , item_id & "_" & itemtype & "_" & i , "smallint default 0" ,false
			next
		case "map"
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype , "integer default 0" ,false
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype & "x" , "varchar(12) null" ,false
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype & "y" , "varchar(12) null" ,false
		case else
			J.Data.AddColumn "Article_"&sysid , itemid & "_" & itemtype , "varchar(255) null" ,true
	end select
end sub
%>
<% J.close %>