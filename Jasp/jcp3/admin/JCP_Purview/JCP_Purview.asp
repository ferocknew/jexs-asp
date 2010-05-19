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
			startXmlRequest("GET","JCP_Purview_Action.asp?action=addteam",null,"body","","",false);
			if(IntYn(xml_BackCont)){
				var curid=doc.getElementsByName('ModelID').length;
				var div=doc.createElement('<div class="list" actid="' + xml_BackCont + '"></div>');
				div.innerHTML='<span style="width:30px;"><input type="checkbox" id="checkbox_' + curid + '" name="ModelID" class="select" value="' + xml_BackCont + '"></span><span class="distline_list"></span>' +
							'<span style="width:180px;" onDblClick="TextChange(this,\'NameChange(o)\');">未命名</span><span class="distline_list"></span>' +
							'<span style="width:180px;">' +
								'<select id="purvteam_' + curid + '" name="purvteam_' + curid + '" onChange="PurvSet(this);" style="margin-top:1px">' +
									'<option value=""0"">未设置权限明细</option>' +
									'<option value="0">────────</option>' +
									'<option value="-1">设置功能权限</option>' +
								'</select>' +
							'</span><span class="distline_list"></span>' +
							'<span style="width:180px;">' +
								'<span guideid="' + xml_BackCont + '" onclick="MenuSet(this);" style="cursor:hand;">>> 进入设置</span>' +
							'</span>';
				doc.getElementById("purview_list").appendChild(div);
			}else{
				alert("添加新权限组出错！");
				alert(xml_BackCont);
				return false;
			}
			break;
		case "delteampurv":
			if(confirm("您确定要删除选中权限组的明细项？？")){
				var delteampurvid="0";var delteampurvcount=0;
				for(i=0;i<doc.getElementsByName('ModelID').length;i++){
					if(doc.getElementsByName('ModelID')[i].checked){
						delteampurvid +="," + document.getElementsByName('ModelID')[i].value;
						delteampurvcount++;
					}
				}
				if(delteampurvcount>0){
					for(i=0;i<doc.getElementsByName('ModelID').length;i++){
						if(doc.getElementsByName('ModelID')[i].checked){
							var team=doc.getElementById('purvteam_' + i);
							if(team.value>0){
								startXmlRequest("GET","JCP_Purview_Action.asp?action=delteampurv&delteampurvid=" + team.value + "&teamid=" + team.parentNode.parentNode.getAttribute("actid"),null,"body","","",false);
								if(xml_BackCont=="OK"){
									if(team.length==3) team.options[0]=new Option("未设置权限明细",0);
									else team.options.remove(team.selectedIndex);
									team.selectedIndex=0;
								}else alert("删除权限明细出错！");
							}//else alert("权限绑定地址ID传递有误！");
							doc.getElementsByName('ModelID')[i].checked=false;
						}
					}
				}else alert("请选择需要删除的权限明细项！");
			}
			break;
		case "del":
			if(confirm("您确定要删除选中的权限组？？")){
				var delid="0";var delcount=0;
				for(i=0;i<doc.getElementsByName('ModelID').length;i++){
					if(doc.getElementsByName('ModelID')[i].checked){
						delid +="," + document.getElementsByName('ModelID')[i].value;
						delcount++;
					}
				}
				if(delcount>0){
					startXmlRequest("GET","JCP_Purview_Action.asp?action=delteam&delid=" + delid,null,"body","","",false);
					if(xml_BackCont=="OK"){
						var purvlength=doc.getElementsByName('ModelID').length;
						for(i=purvlength-1;i>=0;i--){
							if(doc.getElementsByName('ModelID')[i].checked) document.getElementsByName('ModelID')[i].parentNode.parentNode.removeNode(true);
						}
					}else{
						alert("删除新权限组出错！");
						alert(xml_BackCont);
						return false;
					}
				}else alert("请选择需要删除的权限组！");
			}
			break;
		default:return false;
	}
	doc.getElementById('checkboxs').checked=false;
}

function NameChange(o){
	if(o){
		if(!BlankYn(o.value)){
			startXmlRequest("GET","JCP_Purview_Action.asp?action=modteamname&name=" + o.value + "&modid=" + o.parentNode.parentNode.getAttribute("actid"),null,"body","","",false);
			if(xml_BackCont=="OK"){
				return true;
			}else{
				alert("权限组描述修改有误！！");
			}
		}else{
			alert("权限组描述不能为空！！");
			o.focus();
			o.select();
		}
	}else{
		alert("权限组描述修改有误！！");
	}
}

function PurvSet(o){
	if(o.value==-1){
		var arr=ModelWin("JCP_Purview_List.asp?actid=" + o.parentNode.parentNode.getAttribute("actid"),300,486);
		if(arr){
			try{
				eval(arr);
			}catch(e){return false;}
		}else{
			o.selectedIndex=0;
		}
	}else if(o.value==0) o.selectedIndex=0;
}
function MenuSet(o){
	var arr=ModelWin("JCP_Menu_List.asp?actid=" + o.getAttribute("guideid"),300,486);
}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">权限设置</div>
	<div class="manage_button_cur">权 限 组</div>
    <div class="manage_button"><a href="JCP_Purview_Manage.asp">权限细则</a></div>
	<div class="purview_buttons">
		<input name="add" type="button" class="system_button_00" value="新建权限组" onclick="Manage('add');">
		<input name="del" type="button" class="system_button_00" value="删除权限组" onclick="Manage('del');">
		<!--input name="mod" type="button" class="system_button_00" value="删除权限明细" onclick="Manage('delteampurv');"-->
	</div>
	<div class="list_box" id="purview_list">
		<div class="list_title">
			<span style="width:30px;"><input type="checkbox" id="checkboxs" name="checkboxs" class="select" onclick="for(i=0;i<document.getElementsByName('ModelID').length;i++)document.getElementsByName('ModelID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:180px;">权限组描述</span><span class="distline"></span><span style="width:180px;">功能权限</span><span class="distline"></span><span style="width:180px;">导航权限</span>
		</div>
	<% 
	dim rs,i:i=0
	set rs=J.Data.Exe("select JCP_purview.*,JCP_purviewteam.* from JCP_purviewteam left join JCP_purview on ','&JCP_purviewteam.purv_ids&',' like '%,'&JCP_purview.id&',%' order by JCP_purviewteam.id,purv_name")
	if rs.eof then
	%>
		<div class="list">暂时没有权限组信息！</div>
	<% 
	else
		dim curpurid
		do while not rs.eof
			if curpurid<>rs("JCP_purviewteam.id") then
	%>
		<div class="list" actid="<%= rs("JCP_purviewteam.id") %>">
			<span style="width:30px;"><input type="checkbox" id="checkbox_<%= i %>" name="ModelID" class="select" value="<%= rs("JCP_purviewteam.id") %>"></span><span class="distline_list"></span><span style="width:180px;" onDblClick="TextChange(this,'NameChange(o)');"><%= rs("team_name") %></span><span class="distline_list"></span><span style="width:180px;">
				<select id="purvteam_<%= i %>" name="purvteam_<%= i %>" onChange="PurvSet(this);" style="margin-top:1px">
				<%
				i=i+1
				curpurid=rs("JCP_purviewteam.id")
			end if
			if rs("purv_name")&""="" then
				response.write "<option value=""0"">未设置权限明细</option>" & vbcrlf
			else
				response.write "<option value="""&rs("JCP_purview.id")&""">" & rs("purv_name") & "</option>" & vbcrlf
			end if
			rs.movenext
			if rs.eof then
				%>
					<option value="0">────────</option>
					<option value="-1">设置功能权限</option>
				</select>
			</span><span class="distline_list"></span><span style="width:180px;">
				<span guideid="<%= curpurid %>" onclick="MenuSet(this);" style="cursor:hand;">>> 进入设置</span>
			</span>
		</div>
	<% 
			else
				if curpurid<>rs("JCP_purviewteam.id") then
				%>
					<option value="0">────────</option>
					<option value="-1">设置功能权限</option>
				</select>
			</span><span class="distline_list"></span><span style="width:180px;">
				<span guideid="<%= curpurid %>" onclick="MenuSet(this);" style="cursor:hand;">>> 进入设置</span> 
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
		<input name="add" type="button" class="system_button_00" value="新建权限组" onclick="Manage('add');">
		<input name="del" type="button" class="system_button_00" value="删除权限组" onclick="Manage('del');">
		<!--input name="mod" type="button" class="system_button_00" value="删除权限明细" onclick="Manage('delteampurv');"-->
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>