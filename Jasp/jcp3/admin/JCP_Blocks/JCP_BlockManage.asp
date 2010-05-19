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
		if(confirm("您确定要删除当前模块源吗？？")){
			if(!id){
				id="0";
				for(i=0;i<document.getElementsByName('BlockID').length;i++)
					if(document.getElementsByName('BlockID')[i].checked) id += "," + document.getElementsByName('BlockID')[i].value;
			}
			if(id=="0"){
				alert("请选择需要删除的模块源！");
				return false;
			}
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=delblock&blockid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("模块源删除出错啦！");
				doc.write(xml_BackCont);
			}
		}
	}
	function CopyBlock(id){
		if(confirm("您确定要复制当前模块源吗？")){
			startXmlRequest("POST","JCP_BlockAction_XML.asp?action=copyblock&blockid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				alert("模块源复制成功！");
				location.reload();
			}else{
				alert("模块源复制出错啦！");
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
	<div class="app_title">模块源管理</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('BlockID').length;i++)document.getElementsByName('BlockID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:120px;">名　　称</span><span class="distline"></span><span>版 本 号</span><span class="distline"></span><span style="width:300px;">说　　明</span><span class="distline"></span><span>操　　作</span>
		</div>
		<% 
		dim page,rs,rscount,pagesize,i
		pagesize=13
		set page=J.Page("id,blockname,blockversion,blockexplain,blockfolder,mainfile$JCP_Blocks$$id desc$id",pagesize)
		rscount=page.RecCount()
		rs=page.ResultSet()
		if rscount<1 then
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">暂无模块源！</div>"
		else
			for i=0 to ubound(rs,2)
				response.write "<div class=""list"">" & _
							   "<span style=""width:30px;""><input name=""BlockID"" id=""BlockID"" type=""checkbox"" value="""&rs(0,i)&""" class=""select""></span>" & _
							   "<span class=""distline_list""></span><span style=""width:120px;"">"&rs(1,i)&"</span>" & _
							   "<span class=""distline_list""></span><span>"&rs(2,i)&"</span>" & _
							   "<span class=""distline_list""></span><span style=""width:300px;text-align:left;padding-left:10px;"">"&rs(3,i)&"</span>" & _
							   "<span class=""distline_list""></span>" & _
							   		"<span>" & _
							   			"<span class=""mod_button"" title=""修改模块源"" onclick=""location='JCP_BlockEdit.asp?blockid="&rs(0,i)&"&Page="&request.QueryString("Page")&"'""></span>" & _
							   			"<span class=""push_button"" title=""新建模块"" onclick=""BlockCreate('"&rs(4,i)&"/"&rs(5,i)&"?src="&rs(4,i)&"')""></span>" & _
							   			"<span class=""del_button"" title=""删除模块源"" onclick=""DelBlock("&rs(0,i)&");""></span>" & _
							   		"</span>" & _
							   "</div>"
			next
		end if
		page.ShowPage()
		%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="添加模块源" onclick="BlocksAdd();">
		<input type=button class="system_button_00" value="删除所选项" onclick="DelBlock();">
		<input type=button class="system_button_00" value="查看现有模块" onclick="location='../JCP_BlockList/JCP_BlockManage.asp';">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>