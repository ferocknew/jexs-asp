<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Blocks.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
		
	function FindFile(){
		filecontent.value='\n��������Ϸ���ģ��Դ�ļ��б���ѡ�������޸ĵ��ļ�!';
		if(filelist.value!='0'){
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=findfile&src=" + filelist.value,null,"body","","",false);
			if(xml_BackCont=="Error"){
				alert("��Ҫ�޸ĵ��ļ�������,��ȷ�ϣ�");
				filelist.value="0";
			}else{
				filecontent.value=xml_BackCont;
			}
		}
	}
	
	function FormSubmit(){
		if(filelist.value!='0'){
			saveFrame.document.getElementById("src").value=filelist.value;
			saveFrame.document.getElementById("filecontent").value=filecontent.value;
			saveFrame.document.blockform.submit();
		}else{
			//alert("��ѡ��Ҫ�޸ĵ�ģ��Դ�ļ�!");
			filelist.focus();
		}
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
<div class="app_title">ģ��Դ�޸�</div>
<% 
	dim blockid,rs
	blockid=J.NumberYn(request.querystring("blockid"))
	set rs=J.Data.Exe("select * from JCP_Blocks where id="&blockid)
	if rs.eof then
		%>
		<div class="result">
			<div class="manage_exp">δ������Ҫ�޸ĵ�ģ��Դ��</div>
			<div class="result_button"><span>[<a href="javascript:history.back();">���ع���</a>]</span>
			</div>
		</div>
		<%
	else
%>
	<div class="blockbody_item">
		<span class="title">ģ��Դ���ƣ�</span>
		<span class="content"><strong><%= rs("blockname") & " " & rs("blockversion") %></strong></span>
	</div>
	<div class="blockbody_item">
		<span class="title">ģ��Դ˵����</span>
		<span class="content"><strong><%= rs("blockexplain") %></strong></span>
	</div>
	<div class="blockbody_item">
		<span class="title">ģ��Դ��Ϣ��</span>
		<span class="content"><strong><%= rs("blockauthor") %>(�����)��<%= rs("authorlink") %>��<%= rs("copyright") %>��������<%= rs("createtime") %></strong></span>
	</div>
	<div class="blockbody_item">
		<span class="title">ģ��Դ�ļ���
			<select id="filelist" onchange="FindFile();document.body.focus();">
				<option value="0">��ѡ��Ҫ�༭���ļ�</option>
				<% 
				dim filelist,pfile,pfileinfo,i
				filelist=rs("filelist")&""
				pfile=split(filelist,"{$|}")
				for i=0 to ubound(pfile)
					if not instr(pfile(i),"|")>0 then exit for
					pfileinfo=split(pfile(i),"|")
					if ubound(pfileinfo)=1 then
						response.write "<option value="""&rs("blockfolder")&"/"&pfileinfo(1)&""">"&pfileinfo(0)&"</option>"
					end if
				next
				%>
			</select>
			<input type="button" class="system_button_00" name="Submit" value=" �޸�ģ��Դ " onclick="FormSubmit();">
			<input type="button" class="system_button_00" name="Submit2" value=" ����ģ��Դ " onclick="location='JCP_BlockManage.asp?Page=<%= request.QueryString("Page") %>'">
		</span>
		<span class="content">
			<textarea id="filecontent" name="filecontent" style="width:100%;height:300px;margin-top:10px;" wrap="off" onpropertychange='if(this.scrollHeight<304){this.style.posHeight=300;}else{this.style.posHeight=this.scrollHeight + 20;}'>
	
��������Ϸ���ģ��Դ�ļ��б���ѡ�������޸ĵ��ļ�!</textarea>
			<iframe id="saveFrame" height="0" width="0" scrolling="no" frameborder="0" src="JCP_BlockAction.asp" ></iframe>
		</span>
	</div>
<% 
	end if
	rs.close
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>