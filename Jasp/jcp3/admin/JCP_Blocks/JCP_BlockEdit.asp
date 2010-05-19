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
		filecontent.value='\n　　请从上方的模块源文件列表中选择您想修改的文件!';
		if(filelist.value!='0'){
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=findfile&src=" + filelist.value,null,"body","","",false);
			if(xml_BackCont=="Error"){
				alert("您要修改的文件不存在,请确认！");
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
			//alert("请选择要修改的模块源文件!");
			filelist.focus();
		}
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
<div class="app_title">模块源修改</div>
<% 
	dim blockid,rs
	blockid=J.NumberYn(request.querystring("blockid"))
	set rs=J.Data.Exe("select * from JCP_Blocks where id="&blockid)
	if rs.eof then
		%>
		<div class="result">
			<div class="manage_exp">未发现需要修改的模块源！</div>
			<div class="result_button"><span>[<a href="javascript:history.back();">返回管理</a>]</span>
			</div>
		</div>
		<%
	else
%>
	<div class="blockbody_item">
		<span class="title">模块源名称：</span>
		<span class="content"><strong><%= rs("blockname") & " " & rs("blockversion") %></strong></span>
	</div>
	<div class="blockbody_item">
		<span class="title">模块源说明：</span>
		<span class="content"><strong><%= rs("blockexplain") %></strong></span>
	</div>
	<div class="blockbody_item">
		<span class="title">模块源信息：</span>
		<span class="content"><strong><%= rs("blockauthor") %>(设计者)　<%= rs("authorlink") %>　<%= rs("copyright") %>　创建于<%= rs("createtime") %></strong></span>
	</div>
	<div class="blockbody_item">
		<span class="title">模块源文件：
			<select id="filelist" onchange="FindFile();document.body.focus();">
				<option value="0">请选择要编辑的文件</option>
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
			<input type="button" class="system_button_00" name="Submit" value=" 修改模块源 " onclick="FormSubmit();">
			<input type="button" class="system_button_00" name="Submit2" value=" 管理模块源 " onclick="location='JCP_BlockManage.asp?Page=<%= request.QueryString("Page") %>'">
		</span>
		<span class="content">
			<textarea id="filecontent" name="filecontent" style="width:100%;height:300px;margin-top:10px;" wrap="off" onpropertychange='if(this.scrollHeight<304){this.style.posHeight=300;}else{this.style.posHeight=this.scrollHeight + 20;}'>
	
　　请从上方的模块源文件列表中选择您想修改的文件!</textarea>
			<iframe id="saveFrame" height="0" width="0" scrolling="no" frameborder="0" src="JCP_BlockAction.asp" ></iframe>
		</span>
	</div>
<% 
	end if
	rs.close
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>