<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	
	function DelBlock(id){
		if(confirm("��ȷ��Ҫɾ����ǰģ��Դ�𣿣�")){
			if(!id){
				id="0";
				for(i=0;i<document.getElementsByName('BlockID').length;i++)
					if(document.getElementsByName('BlockID')[i].checked) id += "," + document.getElementsByName('BlockID')[i].value;
			}
			if(id=="0"){
				alert("��ѡ����Ҫɾ����ģ��Դ��");
				return false;
			}
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=delblock&blockid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("ģ��Դɾ����������");
				doc.write(xml_BackCont);
			}
		}
	}
	function CopyBlock(id){
		if(confirm("��ȷ��Ҫ���Ƶ�ǰģ��Դ��")){
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=copyblock&blockid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				alert("ģ��Դ���Ƴɹ���");
				location.reload();
			}else{
				alert("ģ��Դ���Ƴ�������");
				doc.write(xml_BackCont);
			}
		}
	}
	
	function BlockCreate(blockpath){
		var arr=ModelWin(blockpath,100,100);
	}
	
	function BlocksAdd(){
		var arr = FindServerFile();
		if(arr!="noFile") ModelWin("JCP_BlockAdd.asp?src=" + arr,300,100);
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">ģ��Դ����</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('BlockID').length;i++)document.getElementsByName('BlockID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:120px;">��������</span><span class="distline"></span><span>�� �� ��</span><span class="distline"></span><span style="width:300px;">˵������</span><span class="distline"></span><span>�١�����</span>
		</div>
		<% 
		dim page,rs,rscount,pagesize,i
		pagesize=13
		set page=J.Page("id,blockname,blockversion,blockexplain,blockfolder,mainfile$JCP_Blocks$$id desc$id",pagesize)
		rscount=page.RecCount()
		rs=page.ResultSet()
		if rscount<1 then
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">����ģ��Դ��</div>"
		else
			for i=0 to ubound(rs,2)
				response.write "<div class=""list"">" & _
							   "<span style=""width:30px;""><input name=""BlockID"" id=""BlockID"" type=""checkbox"" value="""&rs(0,i)&""" class=""select""></span>" & _
							   "<span class=""distline_list""></span><span style=""width:120px;"">"&rs(1,i)&"</span>" & _
							   "<span class=""distline_list""></span><span>"&rs(2,i)&"</span>" & _
							   "<span class=""distline_list""></span><span style=""width:300px;text-align:left;padding-left:10px;"">"&rs(3,i)&"</span>" & _
							   "<span class=""distline_list""></span>" & _
							   		"<span>" & _
							   			"<span class=""mod_button"" title=""�޸�ģ��Դ"" onclick=""location='JCP_BlockEdit.asp?blockid="&rs(0,i)&"&Page="&request.QueryString("Page")&"'""></span>" & _
							   			"<span class=""push_button"" title=""�½�ģ��"" onclick=""BlockCreate('"&rs(4,i)&"/"&rs(5,i)&"?src="&rs(4,i)&"')""></span>" & _
							   			"<span class=""del_button"" title=""ɾ��ģ��Դ"" onclick=""DelBlock("&rs(0,i)&");""></span>" & _
							   		"</span>" & _
							   "</div>"
			next
		end if
		page.ShowPage()
		%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="���ģ��Դ" onclick="BlocksAdd();">
		<input type=button class="system_button_00" value="ɾ����ѡ��" onclick="DelBlock();">
		<input type=button class="system_button_00" value="�鿴����ģ��" onclick="location='../JCP_BlockList/JCP_BlockManage.asp';">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>