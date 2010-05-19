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
		if(confirm("您确定要删除当前模块吗？？")){
			if(!id){
				id="0";
				for(i=0;i<document.getElementsByName('BlockID').length;i++)
					if(document.getElementsByName('BlockID')[i].checked) id += "," + document.getElementsByName('BlockID')[i].value;
			}
			if(id=="0"){
				alert("请选择需要删除的模块！");
				return false;
			}
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=delblock&blockid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("模块删除出错啦！");
				doc.write(xml_BackCont);
			}
		}
	}
	function CopyBlock(id){
		if(confirm("您确定要复制当前模块吗？")){
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=copyblock&blockid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				alert("模块复制成功！");
				location.reload();
			}else{
				alert("模块复制出错啦！");
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
	<div class="app_title">模块管理</div>
	<div id="manage_tools">
		<span id="blocktype_box">
			<select name="blocktype" id="blocktype" onChange="BlockList()">
				<option value="">全部模块</option>"
				<% 
				dim i,selected
				for i=0 to ubound(J.Block)
					if Cstr(i)=replace(blocktype,"blocktype=","") then selected=" selected" else selected=""
					response.write "<option value="""&i&""""&selected&">"&J.Block(i)&"</option>"
				next
				%>
			</select>
		</span>
		<span id="newblock">（选择模块类别以查看）</span>
	</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('BlockID').length;i++)document.getElementsByName('BlockID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:120px;">名　　称</span><span class="distline"></span><span>类　　型</span><span class="distline"></span><span style="width:300px;">说　　明</span><span class="distline"></span><span>操　　作</span>
		</div>
		<% 
		dim page,rs,rscount,pagesize
		pagesize=13
		set page=J.Page("id,blockname,blocktype,blockexplain,blockfolder,blockeditfile$JCP_BlockList$"&blocktype&"$id desc$id",pagesize)
		rscount=page.RecCount()
		rs=page.ResultSet()
		if rscount<1 then
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">暂无模块！</div>"
		else
			for i=0 to ubound(rs,2)
				response.write "<div class=""list"">" & _
							   "<span style=""width:30px;""><input name=""BlockID"" id=""BlockID"" type=""checkbox"" value="""&rs(0,i)&""" class=""select""></span>" & _
							   "<span class=""distline_list""></span><span style=""width:120px;"">"&rs(1,i)&"</span>" & _
							   "<span class=""distline_list""></span><span>"&J.Block(rs(2,i))&"</span>" & _
							   "<span class=""distline_list""></span><span style=""width:300px;text-align:left;padding-left:10px;"">"&rs(3,i)&"</span>" & _
							   "<span class=""distline_list""></span>" & _
							   		"<span>" & _
							   			"<span class=""mod_button"" title=""修改模块"" onclick=""BlockEdit('"&rs(4,i)&"/"&rs(5,i)&"?blockid="&rs(0,i)&"');""></span>" & _
							   			"<span class=""del_button"" title=""删除模块"" onclick=""DelBlock("&rs(0,i)&");""></span>" & _
							   			"<span class=""copy_button"" title=""复制模块"" onclick=""CopyBlock("&rs(0,i)&");""></span>" & _
							   		"</span>" & _
							   "</div>"
			next
		end if
		page.ShowPage()
		%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="添加模块" onclick="location='../JCP_Blocks/JCP_BlockManage.asp';">
		<input type=button class="system_button_00" value="删除所选项" onclick="DelBlock();">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>