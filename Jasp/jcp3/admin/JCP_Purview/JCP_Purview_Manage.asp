<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Purview.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript" type="text/javascript">
<!--
var doc=document;
function Manage(type){
	switch(type){
		case "add":
			startXmlRequest("GET","JCP_Purview_Action.asp?action=add",null,"body","","",false);
			if(IntYn(xml_BackCont)){
				var curid=doc.getElementsByName('ModelID').length;
				var div=doc.createElement('<div class="list" actid="' + xml_BackCont + '"></div>');
				div.innerHTML='<span style="width:30px;"><input type="checkbox" id="checkbox_' + curid + '" name="ModelID" class="select" value="' + xml_BackCont + '"></span><span class="distline_list"></span>' +
							'<span style="width:200px;" onDblClick="TextChange(this,\'NameChange(o)\');">δ����</span><span class="distline_list"></span>' +
							'<span style="width:200px;">' +
								'<select id="purvteam_' + curid + '" name="purvteam_' + curid + '" onChange="PurvUrl(this);" style="margin-top:1px;">' +
									'<option value=""0"">δ��Ȩ�ް�����</option>' +
									'<option value="0">����������������</option>' +
									'<option value="-1">��Ӱ󶨵�ַ</option>' +
								'</select>' +
							'</span>';
				doc.getElementById("purview_list").appendChild(div);
			}else{
				alert("�����Ȩ����Ŀ����");
				alert(xml_BackCont);
				return false;
			}
			break;
		case "delurl":
			if(confirm("��ȷ��Ҫɾ��ѡ��Ȩ����İ󶨵�ַ����")){
				var delurlid="0";var delurlcount=0;
				for(i=0;i<doc.getElementsByName('ModelID').length;i++){
					if(doc.getElementsByName('ModelID')[i].checked){
						delurlid +="," + document.getElementsByName('ModelID')[i].value;
						delurlcount++;
					}
				}
				if(delurlcount>0){
					for(i=0;i<doc.getElementsByName('ModelID').length;i++){
						if(doc.getElementsByName('ModelID')[i].checked){
							var team=doc.getElementById('purvteam_' + i);
							if(team.value>0){
								startXmlRequest("GET","JCP_Purview_Action.asp?action=delurl&delurlid=" + team.value,null,"body","","",false);
								if(xml_BackCont=="OK"){
									if(team.length==3) team.options[0]=new Option("δ��Ȩ�ް�����",0);
									else team.options.remove(team.selectedIndex);
									team.selectedIndex=0;
								}else alert("ɾ��Ȩ�ް󶨵�ַ����");
							}//else alert("Ȩ�ް󶨵�ַID��������");
							doc.getElementsByName('ModelID')[i].checked=false;
						}
					}
				}else alert("��ѡ����Ҫɾ����Ȩ�ް󶨵�ַ��");
			}
			break;
		case "del":
			if(confirm("��ȷ��Ҫɾ��ѡ�е�Ȩ�����")){
				var delid="0";var delcount=0;
				for(i=0;i<doc.getElementsByName('ModelID').length;i++){
					if(doc.getElementsByName('ModelID')[i].checked){
						delid +="," + document.getElementsByName('ModelID')[i].value;
						delcount++;
					}
				}
				if(delcount>0){
					startXmlRequest("GET","JCP_Purview_Action.asp?action=del&delid=" + delid,null,"body","","",false);
					if(xml_BackCont=="OK"){
						var purvlength=doc.getElementsByName('ModelID').length;
						for(i=purvlength-1;i>=0;i--){
							if(doc.getElementsByName('ModelID')[i].checked) document.getElementsByName('ModelID')[i].parentNode.parentNode.removeNode(true);
						}
					}else{
						alert("ɾ����Ȩ����Ŀ����");
						alert(xml_BackCont);
						return false;
					}
				}else alert("��ѡ����Ҫɾ����Ȩ���");
			}
			break;
		default:return false;
	}
	doc.getElementById('checkboxs').checked=false;
}

function NameChange(o){
	if(o){
		if(!BlankYn(o.value)){
			startXmlRequest("GET","JCP_Purview_Action.asp?action=modname&name=" + o.value + "&modid=" + o.parentNode.parentNode.getAttribute("actid"),null,"body","","",false);
			if(xml_BackCont=="OK"){
				return true;
			}else{
				alert("Ȩ�������޸����󣡣�");
			}
		}else{
			alert("Ȩ����������Ϊ�գ���");
			o.focus();
			o.select();
		}
	}else{
		alert("Ȩ�������޸����󣡣�");
	}
}

function PurvUrl(o){
	if(o.value==-1){
		var filePath = FindServerFile().toLowerCase();
		if(filePath=="nofile"){
			o.selectedIndex=0;
		}else{
			startXmlRequest("GET","JCP_Purview_Action.asp?action=addurl&filepath=" + filePath + "&actid=" + o.parentNode.parentNode.getAttribute("actid"),null,"body","","",false);
			if(IntYn(xml_BackCont)){
				if(o.options[0].value==0){
					o.options[0]=new Option(filePath,xml_BackCont);
					o.selectedIndex=0;
				}else{
					o.options[o.length]=new Option(o.options[o.length-1].innerText,o.options[o.length-1].value);
					o.options[o.length-2]=new Option(o.options[o.length-3].innerText,o.options[o.length-3].value);
					o.options[o.length-3]=new Option(filePath,xml_BackCont);
					o.selectedIndex=o.length-3;
				}
			}else alert("Ȩ����󶨵�ַ����");
		}
	}else if(o.value==0) o.selectedIndex=0;
}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">Ȩ������</div>
	<div class="manage_button"><a href="JCP_Purview.asp">Ȩ �� ��</a></div>
    <div class="manage_button_cur">Ȩ��ϸ��</div>
	<div class="purview_buttons">
		<input name="add" type="button" class="system_button_00" value="�����Ȩ��" onclick="Manage('add');">
		<input name="del" type="button" class="system_button_00" value="ɾ��Ȩ��" onclick="Manage('del');">
		<input name="mod" type="button" class="system_button_00" value="ɾ���Ѱ󶨵�ַ" onclick="Manage('delurl');">
	</div>
	<div id="purview_list" class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input type="checkbox" id="checkboxs" name="checkboxs" class="select" onclick="for(i=0;i<document.getElementsByName('ModelID').length;i++)document.getElementsByName('ModelID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:200px;">Ȩ��ϸ������</span><span class="distline"></span><span style="width:200px;">Ȩ�ް󶨵�ַ</span>
		</div>
	<% 
	dim rs,i:i=0
	set rs=J.Data.Exe("select JCP_purview.*,JCP_purviewlist.* from JCP_purview left join JCP_purviewlist on JCP_purview.id=JCP_purviewlist.purv_id order by JCP_purview.id")
	if rs.eof then
	%>
		<div class="list">��ʱû��Ȩ��������Ϣ��</div>
	<% 
	else
		dim curpurid
		do while not rs.eof
			if curpurid<>rs("JCP_purview.id") then
	%>
		<div class="list" actid="<%= rs("JCP_purview.id") %>">
			<span style="width:30px;"><input type="checkbox" id="checkbox_<%= i %>" name="ModelID" class="select" value="<%= rs("JCP_purview.id") %>"></span><span class="distline_list"></span><span style="width:200px;" onDblClick="TextChange(this,'NameChange(o)');"><%= rs("purv_name") %></span><span class="distline_list"></span><span style="width:200px;">
				<select id="purvteam_<%= i %>" name="purvteam_<%= i %>" onChange="PurvUrl(this);" style="margin-top:1px;">
				<%
				i=i+1
				curpurid=rs("JCP_purview.id")
			end if
			if rs("purv_url")&""="" then
				response.write "<option value=""0"">δ��Ȩ�ް�����</option>" & vbcrlf
			else
				response.write "<option value="""&rs("JCP_purviewlist.id")&""">" & rs("purv_url") & "</option>" & vbcrlf
			end if
			rs.movenext
			if rs.eof then
				%>
					<option value="0">����������������</option>
					<option value="-1">��Ӱ󶨵�ַ</option>
				</select>
			</span>
		</div>
	<% 
			else
				if curpurid<>rs("JCP_purview.id") then
				%>
					<option value="0">����������������</option>
					<option value="-1">��Ӱ󶨵�ַ</option>
				</select>
			</span>
		</div>
	<% 
				end if
			end if
		loop
	end if
	rs.close
	%>
	</div>
	<div class="purview_buttons">
		<input name="add" type="button" class="system_button_00" value="�����Ȩ��" onclick="Manage('add');">
		<input name="del" type="button" class="system_button_00" value="ɾ��Ȩ��" onclick="Manage('del');">
		<input name="mod" type="button" class="system_button_00" value="ɾ���Ѱ󶨵�ַ" onclick="Manage('delurl');">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>