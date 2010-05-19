<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
dim rs
if request.QueryString("action")="addpic" or request.QueryString("action")="editpic" or request.QueryString("action")="editonepic" then
%>
<%  
	dim UploadPath,UploadYn,objectid,Today,maxorderid,editorderid,action
	
	action=request.QueryString("action")
	objectid=J.NumberYn(request.QueryString("objectid"))
	if action="editonepic" then editorderid=J.NumberYn(request.QueryString("orderid"))
	
	UploadPath=J.SiteRoot & J.UploadPath
	UploadYn=J.fso.FolderN(UploadPath)
	if UploadYn then
		Today=Date()
		UploadYn=J.fso.FolderN(UploadPath & "\" & Today)
		if UploadYn then
			J.Upload.FileType="*"
			J.Upload.SavePath=J.SiteUrlRoot & J.UploadPath & "/" & Today & "/"
		else
			J.ErrStr="对不起，今日上传路径有误！\n\n出错原因："&UploadYn
			J.ErrOpen("back")
		end if
	else
		J.ErrStr="对不起，上传路径有误！\n\n出错原因："&UploadYn
		J.ErrOpen("back")
	end if
	
	J.Upload.open()
	
	if trim(J.Upload.Form("pic")&"")<>"" then
		if action="editonepic" then
			set rs=J.Data.RsOpen("select * from JCP_TempUpFiles where sessionid="&session.SessionID&" and objectid="&objectid&" and orderid="&editorderid,3)
			if not rs.eof then
				rs("picname")=J.Upload.Form("picname")
				rs("picurl")="../../" & J.UploadPath & "/" & Today & "/" & J.Upload.Form("pic")
				rs.update
				rs.close
				response.write "<script language=javascript>" & vbcrlf _
							 & "var curselect=parent.document.getElementById(""Item_"&objectid&"_pics"");" & vbcrlf _
							 & "curselect.options["&(editorderid-1)&"]=new Option("""&"../../" & J.UploadPath & "/" & Today & "/" & J.Upload.Form("pic")&" ["&replace(J.Upload.Form("picname"),chr(13)&chr(10)," ")&"]"&""","""&"../../" & J.UploadPath & "/" & Today & "/" & J.Upload.Form("pic")&""");" & vbcrlf _
							 & "parent.document.getElementById(""Item_"&objectid&"_picscount"").innerHTML=curselect.length;" & vbcrlf _
							 & "</script>"
			end if
		else
			set rs=J.Data.RsOpen("select top 1 * from JCP_TempUpFiles where sessionid="&session.SessionID&" order by orderid desc",3)
			if not rs.eof then maxorderid=rs("orderid") else maxorderid=0
			rs.addnew
			rs("picname")=J.Upload.Form("picname")
			rs("picurl")="../../" & J.UploadPath & "/" & Today & "/" & J.Upload.Form("pic")
			rs("sessionid")=session.SessionID
			'if request.QueryString("action")="addpic" then rs("pictype")="add"
			'if request.QueryString("action")="editpic" then rs("pictype")="edit"
			rs("objectid")=objectid
			rs("orderid")=maxorderid+1
			rs.update
			rs.close
			response.write "<script language=javascript>" & vbcrlf _
						 & "var curselect=parent.document.getElementById(""Item_"&objectid&"_pics"");" & vbcrlf _
						 & "curselect.options[curselect.length]=new Option("""&"../../" & J.UploadPath & "/" & Today & "/" & J.Upload.Form("pic")&" ["&replace(J.Upload.Form("picname"),chr(13)&chr(10)," ")&"]"&""","""&"../../" & J.UploadPath & "/" & Today & "/" & J.Upload.Form("pic")&""");" & vbcrlf _
						 & "parent.document.getElementById(""Item_"&objectid&"_picscount"").innerHTML=curselect.length;" & vbcrlf _
						 & "</script>"
		end if
	else
		if action="editonepic" then
			dim picexits,picurl
			set rs=J.Data.RsOpen("select * from JCP_TempUpFiles where sessionid="&session.SessionID&" and objectid="&objectid&" and orderid="&editorderid,3)
			if not rs.eof then
				rs("picname")=J.Upload.Form("picname")
				picurl=rs("picurl")&""
				if picurl<>"" then picexits=true else picexits=false
				rs.update
				rs.close
				if not picexits then
					response.write "<script language=javascript>" & vbcrlf _
								 & "var curselect=parent.document.getElementById(""Item_"&objectid&"_pics"");" & vbcrlf _
								 & "curselect.options["&(editorderid-1)&"]=new Option(""文件待上传... ["&replace(J.Upload.Form("picname"),chr(13)&chr(10)," ")&"]"&""",""文件待上传..."");" & vbcrlf _
								 & "parent.document.getElementById(""Item_"&objectid&"_picscount"").innerHTML=curselect.length;" & vbcrlf _
								 & "alert(""文件不能为空！"");" & vbcrlf _
								 & "location='?objectid="&objectid&"&type="&action&"&orderid="&editorderid&"';" & vbcrlf _
								 & "</script>"
					J.close
					response.End()
				else
					response.write "<script language=javascript>" & vbcrlf _
								 & "var curselect=parent.document.getElementById(""Item_"&objectid&"_pics"");" & vbcrlf _
								 & "curselect.options["&(editorderid-1)&"]=new Option("""&picurl&" ["&replace(J.Upload.Form("picname"),chr(13)&chr(10)," ")&"]"&""","""&picurl&""");" & vbcrlf _
								 & "parent.document.getElementById(""Item_"&objectid&"_picscount"").innerHTML=curselect.length;" & vbcrlf _
								 & "</script>"
				end if
			end if
		end if
	end if
	if action="editonepic" then action="editpic"
	response.write "<script language=javascript>" & vbcrlf _
				 & "location='JCP_UploadPics.asp?objectid="&objectid&"&type="&action&"';" & vbcrlf _
				 & "</script>"
	J.close
	response.End()
elseif request.QueryString("action")="delonepic" then
	dim delorderid,delobjectid
	delorderid=J.NumberYn(request.QueryString("orderid"))
	delobjectid=J.NumberYn(request.QueryString("objectid"))
	set rs=J.Data.RsOpen("select * from JCP_TempUpFiles where sessionid="&session.SessionID&" and orderid="&delorderid&" and objectid="&delobjectid,3)
	if rs.eof then
		response.write "Error:未找见单图记录！"
	else
		J.fso.FileD server.mappath(rs("picurl"))
		rs("picurl")=""
		response.write "OK"
	end if
	rs.update
	rs.close
	J.close
	response.End()
end if
%>
<!--#include file="../JCP_Shared/head.asp" -->
<style>
body{
	padding:0 !important;
}
#picname{
	width:400px;
}
#pic{
	width:400px;
}
</style>
<!--#include file="../JCP_Shared/body.asp" -->
<% 
dim workyn
if instr(lcase(request.ServerVariables("HTTP_REFERER")),"jcp_artadd.asp")>0 or instr(lcase(request.ServerVariables("HTTP_REFERER")),"jcp_artedit.asp")>0 or instr(lcase(request.ServerVariables("HTTP_REFERER")),"jcp_uploadpics.asp")>0 then 
	workyn=true
else
	workyn=false
end if

if request.QueryString("type")="addpic" or request.QueryString("type")="editpic" then
%>
  <form action="../JCP_Tools/JCP_UploadPics.asp?action=<%= request.QueryString("type") %>&objectid=<%= request.QueryString("objectid") %>" method="post" enctype="multipart/form-data" name="form1">
    <textarea name="picname" id="picname"></textarea> （文件描述，可空）
    <br>
    <input type="file" name="pic" id="pic">
    <input type="<% if workyn then %>submit<% else %>Button<% end if %>" name="Submit" value="上传文件">
  </form>
<% 
elseif request.QueryString("type")="editonepic" then
	dim modid
	modid=request.QueryString("orderid")
	set rs=J.Data.Exe("select * from JCP_TempUpFiles where sessionid="&session.SessionID&" and orderid="&modid&" order by orderid desc")
	if not rs.eof then
%>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
  <form action="../JCP_Tools/JCP_UploadPics.asp?action=<%= request.QueryString("type") %>&objectid=<%= request.QueryString("objectid") %>(%22derid=<%= request.QueryString("orderid") %>" method="post" enctype="multipart/form-data" name="form1">
    <textarea name="picname" id="picname"><%= rs("picname") %></textarea> （文件描述，可空）
    <br>
	<div id="picbox">
		<input type="file" name="pic" id="pic">
		<input type="<% if workyn then %>submit<% else %>Button<% end if %>" name="Submit" value="修改文件">
	</div>
<% 
		if rs("picurl")<>"" then
			dim sItem:sItem="picbox"
			response.write "<script language=javascript>" & vbcrlf _
						 & "		var doc=document;" & vbcrlf _
						 & "		var temp_"&sItem&"=doc.getElementById("""&sItem&""").innerHTML;" & vbcrlf _
						 & "		doc.getElementById("""&sItem&""").innerHTML='<img src=""../JCP_Skin/"&Session("SystemSkin")&"/images/math.gif"" align=""absmiddle"" title=""已上传："&rs("picurl")&""" style=""cursor:hand;margin:0 0 0 10px;"" onclick=""javascript:window.open(\'"&rs("picurl")&"\');""> [<a href=""javascript:"&sItem&"_upload();"">删除文件，重新上传</a>]　　<input type=button class=""system_button_00"" onclick=""javascript:location=\'?type=editpic&objectid="&request.QueryString("objectid")&"\';"" value=""取消修改""> <input type=submit value=""修改文件"">';" & vbcrlf _
						 & "		doc.getElementById("""&sItem&""").style.margin=""5px 0 0 0"";" & vbcrlf _
						 & "		function "&sItem&"_upload(){" & vbcrlf _
						 & "			if(confirm(""您确定要删除当前文件？？"")){" & vbcrlf _
						 & "				startXmlRequest(""POST"",""?action=delonepic&orderid="&modid&"&objectid="&request.QueryString("objectid")&""",null,""body"","""","""",false);" & vbcrlf _
						 & "				if(xml_BackCont==""OK""){" & vbcrlf _
						 & "					doc.getElementById("""&sItem&""").innerHTML=temp_"&sItem&";" & vbcrlf _
						 & "					doc.getElementById("""&sItem&""").style.margin="""";" & vbcrlf _
						 & "					parent.document.getElementById(""Item_"&request.QueryString("objectid")&"_pics"").options["&(modid-1)&"]=new Option(""文件待上传... ["" + doc.getElementById(""picname"").value + ""]"&""",""文件待上传..."");" & vbcrlf _
						 & "				}else{" & vbcrlf _
						 & "					alert(""现有文件删除失败！"" + xml_BackCont)" & vbcrlf _
						 & "				}" & vbcrlf _
						 & "			}" & vbcrlf _
						 & "		}" & vbcrlf _
						 & "</script>" & vbcrlf
		end if
%>
  </form>
<% 
	end if
end if
%>
  <!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>