<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Article.css" rel="stylesheet" type="text/css">
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">��ӽ��</div>
<% 
dim rs,sysid,actid,rss,objectid
sysid=J.NumberYn(request.querystring("sysid"))
dim UploadPath,UploadYn,Today,UpItem,i,UpItemName,classid,tags,tRs
classid="0"

if request.querystring("action")="add" then
	UploadPath=J.SiteRoot & J.UploadPath
	UploadYn=J.fso.FolderN(UploadPath)
	if UploadYn then
		Today=Date()
		UploadYn=J.fso.FolderN(UploadPath & "\" & Today)
		if UploadYn then
			J.Upload.FileType="*"
			J.Upload.SavePath=J.SiteUrlRoot & J.UploadPath & "/" & Today & "/"
		else
			J.ErrStr="�Բ��𣬽����ϴ�·������\n\n����ԭ��"&UploadYn
			J.ErrOpen("back")
		end if
	else
		J.ErrStr="�Բ����ϴ�·������\n\n����ԭ��"&UploadYn
		J.ErrOpen("back")
	end if
	
	J.Upload.open()
	
	'on error resume next
	set rs=J.Data.RsOpen("select * from Article_"&sysid&" where id=0",3)
	rs.addnew
	classid="0"
	for each UpItem in J.Upload.FormItem
		if UpItem&""<>"" and UpItem<>"Item_submit" then
			if instr(UpItem,"checkbox_counter")>0 then
				UpItemName=replace(UpItem,"counter","")
				for i=1 to Cint(J.Upload.Form(UpItem))
					if J.Upload.Form(UpItemName & i)&""<>"" then rs(UpItemName & i)=1
				next
			elseif instr(UpItem,"edit")>0 then
				rs(replace(UpItem,"_content",""))=J.Upload.Form(UpItem)
			elseif instr(UpItem,"picsid")>0 then
				objectid=replace(replace(UpItem,"Item_",""),"_picsid","")
				set rss=J.Data.ReRsOpen("select * from JCP_TempUpFiles where sessionid="&session.SessionID&" and objectid="&objectid&" order by orderid","rts",1)
				dim addpicscount
				addpicscount=0
				do while not rss.eof
					if trim(rs("Item_"&objectid&"_pics")&"")="" then 
						if rss("picurl")&""<>"" then
							rs("Item_"&objectid&"_pics")=rss("picurl")
							rs("Item_"&objectid&"_pics_title")=rss("picname")
							addpicscount=addpicscount+1
						end if
					else
						if rss("picurl")&""<>"" then
							rs("Item_"&objectid&"_pics")=rs("Item_"&objectid&"_pics")&"{|}"&rss("picurl")
							rs("Item_"&objectid&"_pics_title")=rs("Item_"&objectid&"_pics_title")&"{|}"&rss("picname")
							addpicscount=addpicscount+1
						end if
					end if
					rss.movenext
				loop
				rs("Item_"&objectid&"_pics_count")=addpicscount
				rss.close
				J.Data.Exe("delete from JCP_TempUpFiles where sessionid="&session.SessionID&" and objectid="&objectid)
			elseif instr(UpItem,"class")>0 then 
				session("temp_ClassID_Add_"&replace(UpItem,"_class",""))=J.Upload.Form(UpItem)
				classid=classid & "," & J.Upload.Form(UpItem)
				rs(UpItem)=trim(J.Upload.Form(UpItem))
			elseif instr(UpItem,"tag")>0 then
				tags=split(J.Upload.form(UpItem),",")
				for i=0 to ubound(tags)
					if not instr(tags(i),"'")>0 and tags(i)&""<>"" then
						set tRs=J.Data.Exe("select id from JCP_tags where tagname='"&trim(tags(i))&"'")
						if tRs.eof then
							J.Data.Exe("insert into JCP_tags(tagname) values('"&trim(tags(i))&"')")
						end if
						set tRs=nothing
					end if
				next
				rs(UpItem)=trim(J.Upload.Form(UpItem))
			elseif instr(UpItem,"mapzoom")>0 then
				rs(replace(UpItem,"mapzoom","map"))=trim(J.Upload.Form(UpItem))
			elseif instr(UpItem,"checkbox")>0 or (instr(UpItem,"pics")>0 and not instr(UpItem,"picsid")>0) then 
				'�������ݿ����
			else
				rs(UpItem)=trim(J.Upload.Form(UpItem))
			end if
		end if
	next
	
	for each UpItem in J.Upload.FileItem
		if UpItem&""<>"" and J.Upload.Form(UpItem)&""<>"" then
			rs(UpItem)="../../" & J.UploadPath & "/" & Today & "/" & J.Upload.Form(UpItem)
		end if
	next
	
	rs("userid")=session("JCP_AdminID")
	
	rs.update
	''''''''''''''''''''''''''''''''''''''''''''''
		'�ռ��Զ���������ı�Ҫ��Ϣ    ��ʼ
		dim push_classid
		if instr(classid,",")>0 then
			push_classid=replace(right(classid,len(classid)-2),",","&")
			J.Template.PushInfo push_classid,0,rs("id"),2,J
			J.Template.PushInfo push_classid,0,0,1,J
			J.Template.PushInfo push_classid,0,0,0,J
		end if
		'����
	''''''''''''''''''''''''''''''''''''''''''''''
	rs.close
	
	J.Data.Exe("update JCP_class set artcount=artcount+1 where classid in ("&classid&")")
	%>
	<div class="result">
		<div class="manage_exp">������ӳɹ���</div>
		<div class="result_button"><span>[<a href="JCP_ArtAdd.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&action")(0) %>">�������</a>]</span><span>[<a href="JCP_ArtManage.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&action")(0) %>">���ع���</a>]</span></div>
	</div>
	<%  
elseif request.querystring("action")="del" then
	actid=request.QueryString("actid")
	if isNumeric(replace(actid,",","")) then
		dim colname,colcount,colstr
		set rs=J.Data.Exe("select item_id from JCP_ArtSys where sys_id="&sysid&" and item_type='class'")
		do while not rs.eof
			colname=colname & "," & rs("item_id") & "_class"
			colstr=colstr & " & ',' & " & rs("item_id") & "_class"
			rs.movenext
		loop
		if len(colname)>0 then colname=right(colname,len(colname)-1)
		if len(colstr)>0 then colstr=right(colstr,len(colstr)-9)
		colstr=colstr & " as col"
		colcount=len(colname)-len(replace(colname,",",""))
		rs.close
		J.Data.Exe("update (select artcount from JCP_class,(select "&colname&" from Article_"&sysid&" where id in ("&actid&")) where classid in ("&colname&")) set artcount=artcount-1")
		set rs=J.Data.Exe("select id,"&colstr&" from Article_"&sysid&" where id in ("&actid&")")
		do while not rs.eof
	''''''''''''''''''''''''''''''''''''''''''''''
		'�ռ��Զ���������ı�Ҫ��Ϣ    ��ʼ
			J.Template.PushInfo rs(1),0,rs(0),2,J
			J.Template.PushInfo rs(1),0,0,1,J
			J.Template.PushInfo rs(1),0,0,0,J
		'����
	''''''''''''''''''''''''''''''''''''''''''''''
			rs.movenext
		loop
		rs.close
		J.Data.Exe "delete from Article_"&sysid&" where id in ("&actid&")"
		%>
		<div class="result">
			<div class="manage_exp">��ѡ��¼�Ѿ��ɹ�ɾ����</div>
			<div class="result_button"><span>[<a href="javascript:history.back();" onMouseMove="javascript:window.status='���ع���';">���ع���</a>]</span><span>[<a href="JCP_ArtAdd.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&action")(0) %>">�������</a>]</span></div>
		</div>
		<%  
	else
		%>
		<div class="result">
			<div class="manage_exp">���ݼ�¼���������޷�ִ��ɾ��������</div>
			<div class="result_button"><span>[<a href="javascript:history.back();">������һ��</a>]</span><span>[<a href="JCP_ArtAdd.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&action")(0) %>">�������</a>]</span></div>
		</div>
		<%  
	end if
elseif request.querystring("action")="mod" then
	actid=J.NumberYn(request.QueryString("actid"))
	UploadPath=J.SiteRoot & J.UploadPath
	UploadYn=J.fso.FolderN(UploadPath)
	if UploadYn then
		Today=Date()
		UploadYn=J.fso.FolderN(UploadPath & "\" & Today)
		if UploadYn then
			J.Upload.FileType="*"
			J.Upload.SavePath=J.SiteUrlRoot & J.UploadPath & "/" & Today & "/"
		else
			J.ErrStr="�Բ��𣬽����ϴ�·������\n\n����ԭ��"&UploadYn
			J.ErrOpen("back")
		end if
	else
		J.ErrStr="�Բ����ϴ�·������\n\n����ԭ��"&UploadYn
		J.ErrOpen("back")
	end if
	
	J.Upload.open()
	
	'on error resume next
	set rs=J.Data.RsOpen("select * from Article_"&sysid&" where id in (" & actid & ")",3)
	if rs.eof then
		rs.close
		%>
		<div class="result">
			<div class="manage_exp">��Ҫ�޸ĵļ�¼�����ڣ�</div>
			<div class="result_button"><span>[<a href="javascript:history.back();" onMouseMove="javascript:window.status='�����޸�';">�����޸�</a>]</span><span>[<a href="JCP_ArtAdd.asp?sysid=<%= sysid %>">�������</a>]</span></div>
		</div>
		<% 
	else
		dim push_classid_old,push_classid_new
		for each UpItem in J.Upload.FormItem
			if UpItem&""<>"" and UpItem<>"Item_submit" then
				if instr(UpItem,"checkbox_counter")>0 then
					UpItemName=replace(UpItem,"counter","")
					for i=1 to Cint(J.Upload.Form(UpItem))
						if J.Upload.Form(UpItemName & i)&""<>"" then rs(UpItemName & i)=1
					next
				elseif instr(UpItem,"edit")>0 then
					rs(replace(UpItem,"_content",""))=J.Upload.Form(UpItem)
				elseif instr(UpItem,"picsid")>0 then
					objectid=replace(replace(UpItem,"Item_",""),"_picsid","")
					set rss=J.Data.ReRsOpen("select * from JCP_TempUpFiles where sessionid="&session.SessionID&" and objectid="&objectid&" order by orderid","rts",1)
					rs("Item_"&objectid&"_pics")=""
					rs("Item_"&objectid&"_pics_title")=""
					dim editpicscount
					editpicscount=0
					do while not rss.eof
						if trim(rs("Item_"&objectid&"_pics")&"")="" then 
							if rss("picurl")&""<>"" then
								rs("Item_"&objectid&"_pics")=rss("picurl")
								rs("Item_"&objectid&"_pics_title")=rss("picname")
								editpicscount=editpicscount+1
							end if
						else
							if rss("picurl")&""<>"" then
								rs("Item_"&objectid&"_pics")=rs("Item_"&objectid&"_pics")&"{|}"&rss("picurl")
								rs("Item_"&objectid&"_pics_title")=rs("Item_"&objectid&"_pics_title")&"{|}"&rss("picname")
								editpicscount=editpicscount+1
							end if
						end if
						rss.movenext
					loop
					rs("Item_"&objectid&"_pics_count")=editpicscount
					rss.close
					J.Data.Exe("delete from JCP_TempUpFiles where sessionid="&session.SessionID&" and objectid="&objectid)
				elseif instr(UpItem,"tag")>0 then
					if rs(UpItem)<>trim(J.Upload.form(UpItem)) then
						tags=split(J.Upload.form(UpItem),",")
						for i=0 to ubound(tags)
							if not instr(tags(i),"'")>0 and tags(i)&""<>"" then
								set tRs=J.Data.Exe("select id from JCP_tags where tagname='"&tags(i)&"'")
								if tRs.eof then
									J.Data.Exe("insert into JCP_tags(tagname) values('"&tags(i)&"')")
								end if
								set tRs=nothing
							end if
						next
					end if
					rs(UpItem)=trim(J.Upload.Form(UpItem))
				elseif instr(UpItem,"class")>0 then 
					session("temp_ClassID_Add_"&replace(UpItem,"_class",""))=J.Upload.Form(UpItem)
					dim t_classid
					if rs(UpItem)&""="" then t_classid=0 else t_classid=rs(UpItem)
					if t_classid<>Cint(J.Upload.Form(UpItem)) then
						if t_classid>0 then J.Data.Exe("update JCP_class set artcount=artcount-1 where classid="&t_classid)
						J.Data.Exe("update JCP_class set artcount=artcount+1 where classid="&J.Upload.Form(UpItem))
						rs(UpItem)=trim(J.Upload.Form(UpItem))
						push_classid_old=push_classid_old & "," & t_classid
						push_classid_new=push_classid_new & "," & trim(J.Upload.Form(UpItem))
					else
						push_classid_old=push_classid_old & "," & t_classid
						push_classid_new=push_classid_new & "," & t_classid
					end if
				elseif instr(UpItem,"mapzoom")>0 then
					rs(replace(UpItem,"mapzoom","map"))=trim(J.Upload.Form(UpItem))
				elseif instr(UpItem,"checkbox")>0 or (instr(UpItem,"pics")>0 and not instr(UpItem,"picsid")>0) then 
					'�������ݿ����
				else
					rs(UpItem)=trim(J.Upload.Form(UpItem))
				end if
			end if
		next
		
		for each UpItem in J.Upload.FileItem
			if UpItem&""<>"" and J.Upload.Form(UpItem)&""<>"" then
				rs(UpItem)="../../" & J.UploadPath & "/" & Today & "/" & J.Upload.Form(UpItem)
			end if
		next
		rs.update
	''''''''''''''''''''''''''''''''''''''''''''''
		'�ռ��Զ���������ı�Ҫ��Ϣ    ��ʼ
		if instr(push_classid_old,",")>0 then
			push_classid_old=replace(right(push_classid_old,len(push_classid_old)-1),",","&")
			J.Template.PushInfo push_classid_old,0,rs("id"),2,J
			J.Template.PushInfo push_classid_old,0,0,1,J
			J.Template.PushInfo push_classid_old,0,0,0,J
		end if
		if push_classid_new<>push_classid_old and instr(push_classid_new,",")>0 then
			push_classid_new=replace(right(push_classid_new,len(push_classid_new)-1),",","&")
			J.Template.PushInfo push_classid_new,0,rs("id"),2,J
			J.Template.PushInfo push_classid_new,0,0,1,J
			J.Template.PushInfo push_classid_new,0,0,0,J
		end if
		'����
	''''''''''''''''''''''''''''''''''''''''''''''
		rs.close
		%>
		<div class="result">
			<div class="manage_exp">��¼�޸ĳɹ���</div>
			<div class="result_button"><span>[<a href="JCP_ArtManage.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&actid=")(0) %>">���ع���</a>]</span><span>[<a href="JCP_ArtEdit.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&actid=")(0) %>&actid=0,<%= actid %>">�����޸�</a>]</span><span>[<a href="JCP_ArtAdd.asp?<%= split(request.ServerVariables("QUERY_STRING"),"&actid=")(0) %>">�������</a>]</span></div>
		</div>
		<% 
	end if
end if
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>