<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
var doc=document;
doc.title="ͼƬ���ҡ���������������������������������������������������";
var FileType="<%= request.QueryString("filetype") %>";
var PathType="<%= request.QueryString("pathtype") %>";
var FileUrl="<%= request.QueryString("fileurl") %>";

function sourceSelect(){
	if(doc.getElementsByName("FileSource")[0].checked){
		doc.getElementById("wwwFile").disabled=false;
		doc.getElementById("localFile").disabled=true;
		doc.getElementById("serverFile").disabled=true;
		doc.getElementById("serverButton").disabled=true;
	}else if(doc.getElementsByName("FileSource")[1].checked){
		doc.getElementById("wwwFile").disabled=true;
		doc.getElementById("localFile").disabled=true;
		doc.getElementById("serverFile").disabled=false;
		doc.getElementById("serverButton").disabled=false;
	}else{
		doc.getElementById("wwwFile").disabled=true;
		doc.getElementById("localFile").disabled=false;
		doc.getElementById("serverFile").disabled=true;
		doc.getElementById("serverButton").disabled=true;
	}
}

function returnNow(){
	if(doc.getElementsByName("FileSource")[0].checked){
		if(BlankYn(doc.getElementById("wwwFile").value)){
			alert("����ȷ��д���Ի������ķ��ʵ�ַ��\n\n��ַ����Ϊ�գ�");
			return false;
		}else if(doc.getElementById("wwwFile").value.toLowerCase().indexOf("http://")!=0){
			alert("����ȷ��д���Ի������ķ��ʵ�ַ��\n\n��ַ������ http:// ��ͷ��");
			return false;
		}else{
			window.returnValue=doc.getElementById("wwwFile").value;
			window.close();
			return false;
		}
	}else if(doc.getElementsByName("FileSource")[1].checked){
		if(BlankYn(doc.getElementById("serverFile").value)){
			alert("����ȷѡ�����Ա�վ�ķ��ʵ�ַ��\n\n��ַ����Ϊ�գ�");
			return false;
		}else{
			window.returnValue=doc.getElementById("serverFile").value;
			window.close();
			return false;
		}
	}else{
		doc.all.uploadForm.action="?action=upload&pathtype=" + PathType + "&filetype=" + FileType;
	}
}
-->
</script>
<base target="_self">
<!--#include file="../JCP_Shared/body.asp" -->
<% 
dim action,fileurl

action=request.QueryString("action")
fileurl=request.QueryString("fileurl")

if action="upload" then
	dim pathtype,t_UploadPath,filetype,UploadYn,returnPath
	
	pathtype=request.QueryString("pathtype")
	filetype=request.QueryString("filetype")
	if J.BlankTF(filetype) then J.Upload.FileType=filetype
	
	if pathtype="1" then	'Ĭ�ϵ���վǰ��ͼƬ�ļ��� /images ��
		UploadPath=J.SiteRoot & "images"
		UploadYn=J.fso.FolderN(t_UploadPath & "\images")
		if UploadYn then
			J.Upload.SavePath=J.SiteUrlRoot & "images/"
			returnPath="../../images/"
		else
			J.ErrStr="�Բ�����վĬ��ͼƬ�ļ��в��ܱ�������\n\n����ԭ��"&UploadYn
			J.ErrOpen("close")
		end if
	else	'Ĭ���Ե�������Ϊ�ļ��У���������Ĭ�ϵ�ϵͳ�ϴ��ļ�����
		dim TodayPath:TodayPath=Cstr(Date())
		t_UploadPath=J.SiteRoot & J.UploadPath
		UploadYn=J.fso.FolderN(t_UploadPath & "\" & TodayPath)
		if UploadYn then
			J.Upload.SavePath=J.SiteUrlRoot & J.UploadPath & "/" & TodayPath & "/"
			returnPath="../../" & J.UploadPath & "/" & TodayPath & "/"
		else
			J.ErrStr="�Բ��𣬽����ϴ�·������\n\n����ԭ��"&UploadYn
			J.ErrOpen("close")
		end if
	end if
	
	J.Upload.open()
	
	
	if J.BlankTF(J.Upload.Form("localFile")) then
		%>
		<script language="JavaScript">
		<!--
		window.returnValue="<%= returnPath & J.Upload.Form("localFile") %>";
		window.close();
		-->
		</script>
		<%  
		response.end
	else
		if J.Upload.Error=2 then
			%>
			<script language="JavaScript">
			<!--
			doc.body.onload=function(){
				alert("ֻ���ϴ���ʽΪ��<%= filetype %>�����ļ���");
				doc.getElementsByName("FileSource")[2].click();
				Page_Loaded();
			}
			-->
			</script>
			<%  
		else
			%>
			<script language="JavaScript">
			<!--
			doc.body.onload=function(){
				alert("����ȷѡ�񱾵��ļ�������Ϊ�գ�");
				doc.getElementsByName("FileSource")[2].click();
				Page_Loaded();
			}
			-->
			</script>
			<%  
		end if
	end if
end if
%>
  <form action="" method="post" enctype="multipart/form-data" name="uploadForm" onSubmit="return returnNow();">
    <table border="0" cellspacing="0" cellpadding="4">
      <tr> 
        <td>�ļ������ڣ�</td>
      </tr>
      <tr> 
        <td onClick="doc.getElementsByName('FileSource')[0].click();"><input name="FileSource" type="radio" value="www" checked class="select" onClick="sourceSelect()">������ 
          <input type="text" name="wwwFile" id="wwwFile" style="width:300px;" value="http://"></td>
      </tr>
      <tr> 
        <td onClick="doc.getElementsByName('FileSource')[1].click();"><input name="FileSource" type="radio" value="server" class="select" onClick="sourceSelect()">������ 
          <input type="text" name="serverFile" id="serverFile" style="width:235px;" disabled readonly><input type="button" name="serverButton" id="serverButton" value="���..." style="margin-left:2px;width:64px;" onClick="FindServerFile('serverFile');" disabled class="system_button_00"></td>
      </tr>
      <tr> 
        <td onClick="doc.getElementsByName('FileSource')[2].click();"><input type="radio" name="FileSource" value="local" class="select" onClick="sourceSelect()">���ػ� 
          <input type="file" style="width:300px;" name="localFile" id="localFile" disabled></td>
      </tr>
      <tr>
        <td align="center"><input type="submit" name="Submit" value="ȷ ��" class="system_button_00">��
          <input type="button" name="Submit2" value="�� ��" onClick="window.returnValue='noFile';window.close();" class="system_button_00">��
		  <input type="button" name="Submit3" value="�� ��" onClick="window.close();" class="system_button_00"></td>
      </tr>
    </table>
  </form>
<%
if J.BlankTF(fileurl) then
	if instr(lcase(fileurl),"http://")=1 then
		%>
		<script language="JavaScript">
		<!--
			doc.getElementsByName("FileSource")[0].click();
			doc.getElementById("wwwFile").value="<%= fileurl %>";
		-->
		</script>
		<%  
	else
		%>
		<script language="JavaScript">
		<!--
			doc.getElementsByName("FileSource")[1].click();
			doc.getElementById("serverFile").value="<%= fileurl %>";
		-->
		</script>
		<%  
	end if
end if
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>