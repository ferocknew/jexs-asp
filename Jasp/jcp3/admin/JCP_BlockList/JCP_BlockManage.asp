<!--#include file="../JCP_Shared/asp_head.asp" -->
	<% 
	dim blocktype
	blocktype=trim(request.querystring("blocktype"))
	if isnumeric(blocktype) then
		if blocktype="" then 
			blocktype=""
		else
			blocktype=Cint(blocktype)
			if blocktype>ubound(J.Block) or blocktype<-1 then 
				blocktype=""
			else
				blocktype="blocktype="&blocktype
			end if
		end if
	else
		blocktype=""
	end if
	%>
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	
	function DelBlock(id){
		if(confirm("��ȷ��Ҫɾ����ǰģ���𣿣�")){
			if(!id){
				id="0";
				for(i=0;i<document.getElementsByName('BlockID').length;i++)
					if(document.getElementsByName('BlockID')[i].checked) id += "," + document.getElementsByName('BlockID')[i].value;
			}
			if(id=="0"){
				alert("��ѡ����Ҫɾ����ģ�飡");
				return false;
			}
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=delblock&blockid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("ģ��ɾ����������");
				doc.write(xml_BackCont);
			}
		}
	}
	function CopyBlock(id){
		if(confirm("��ȷ��Ҫ���Ƶ�ǰģ����")){
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=copyblock&blockid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				alert("ģ�鸴�Ƴɹ���");
				location.reload();
			}else{
				alert("ģ�鸴�Ƴ�������");
				doc.write(xml_BackCont);
			}
		}
	}
	function BlockList(){
		location='?blocktype=' + doc.getElementById("blocktype").value.toString();
	}
	
	function BlockEdit(blockeditpath){
		var arr=ModelWin(blockeditpath,100,100);
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">ģ�����</div>
	<div id="manage_tools">
		<span id="blocktype_box">
			<select name="blocktype" id="blocktype" onChange="BlockList()">
				<option value="">ȫ��ģ��</option>"
				<% 
				dim i,selected
				for i=0 to ubound(J.Block)
					if Cstr(i)=replace(blocktype,"blocktype=","") then selected=" selected" else selected=""
					response.write "<option value="""&i&""""&selected&">"&J.Block(i)&"</option>"
				next
				%>
			</select>
		</span>
		<span id="newblock">��ѡ��ģ������Բ鿴��</span>
	</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('BlockID').length;i++)document.getElementsByName('BlockID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:120px;">��������</span><span class="distline"></span><span>�ࡡ����</span><span class="distline"></span><span style="width:300px;">˵������</span><span class="distline"></span><span>�١�����</span>
		</div>
		<% 
		dim page,rs,rscount,pagesize
		pagesize=13
		set page=J.Page("id,blockname,blocktype,blockexplain,blockfolder,blockeditfile$JCP_BlockList$"&blocktype&"$id desc$id",pagesize)
		rscount=page.RecCount()
		rs=page.ResultSet()
		if rscount<1 then
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">����ģ�飡</div>"
		else
			for i=0 to ubound(rs,2)
				response.write "<div class=""list"">" & _
							   "<span style=""width:30px;""><input name=""BlockID"" id=""BlockID"" type=""checkbox"" value="""&rs(0,i)&""" class=""select""></span>" & _
							   "<span class=""distline_list""></span><span style=""width:120px;"">"&rs(1,i)&"</span>" & _
							   "<span class=""distline_list""></span><span>"&J.Block(rs(2,i))&"</span>" & _
							   "<span class=""distline_list""></span><span style=""width:300px;text-align:left;padding-left:10px;"">"&rs(3,i)&"</span>" & _
							   "<span class=""distline_list""></span>" & _
							   		"<span>" & _
							   			"<span class=""mod_button"" title=""�޸�ģ��"" onclick=""BlockEdit('"&rs(4,i)&"/"&rs(5,i)&"?blockid="&rs(0,i)&"');""></span>" & _
							   			"<span class=""del_button"" title=""ɾ��ģ��"" onclick=""DelBlock("&rs(0,i)&");""></span>" & _
							   			"<span class=""copy_button"" title=""����ģ��"" onclick=""CopyBlock("&rs(0,i)&");""></span>" & _
							   		"</span>" & _
							   "</div>"
			next
		end if
		page.ShowPage()
		%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="���ģ��" onclick="location='../JCP_Blocks/JCP_BlockManage.asp';">
		<input type=button class="system_button_00" value="ɾ����ѡ��" onclick="DelBlock();">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>