<!--#include file="../../JCP_Search/Inc/Class_Search.asp" -->
<% 
	dim J
	set J=new JCP
	J.open null
%>
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	
	function CopyUrl(id){
		window.clipboardData.setData('text','<' + 'script language="javascript" src="../../jcp_search/JS/' + id + '.js"></' + 'script>');
		alert('[非首页]调用地址：\n\n<' + 'script language="javascript" src="../../jcp_search/JS/' + id + '.js"></' + 'script>' + "\n\n" + "以上地址已经复制到剪贴板！");
	}
	
	function Delsearch(id){
		if(confirm("您确定要删除选用的搜索引擎吗？？")){
			var ids="0";
			for(i=0;i<document.getElementsByName('ArtID').length;i++)
				if(document.getElementsByName('ArtID')[i].checked) ids += "," + document.getElementsByName('ArtID')[i].value;
			if(ids=="0"){
				alert("请选择要删除的项！！");
			}else{
				startXmlRequest("POST","../../JCP_Search/inc/Action.asp?action=deletesearch&searchid=" + ids,null,"body","","",false);
				if(xml_BackCont=="OK"){
					location.reload();
				}else{
					alert("引擎删除失败啦！");
					doc.write(xml_BackCont);
				}
			}
		}
	}
	
	function DelSet(id){
		var _item=doc.getElementById("ArtID" + id);
		if(_item) _item.checked = true;
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">留言管理</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('ArtID').length;i++)document.getElementsByName('ArtID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:40px;">ID</span><span class="distline"></span><span style="width:300px;">引擎名称</span><span class="distline"></span><span style="width:120px;">创建时间</span><span class="distline"></span><span>操　　作</span>
		</div>
		<% 
		S.MainOpen
		dim lists,listi,page,curpgsize
		dim replyyn,showyn,searchtitle
		page=request.querystring("page")
		if not S.main.NumberTF(page) then page=1
		page=cint(page)
		curpgsize=12
		lists=S.ListSearch(curpgsize,page)
		if isEmpty(lists) then
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">没有搜索引擎！</div>"
		else
			for listi=0 to ubound(lists,2)
				response.write "<div class=""list"" style=""padding:4px 0 4px 0;"">" & _
							   "<span style=""width:30px;float:left;""><input name=""ArtID"" id=""ArtID" & lists(0,listi) & """ type=""checkbox"" value="""&lists(0,listi)&""" class=""select""></span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:40px;float:left;padding-top:5px;"">" & lists(0,listi) & "</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:300px;float:left;padding-top:5px;"">" & S.Main.Encode(lists(1,listi)) & "</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:120px;float:left;padding-top:5px;"">"&lists(2,listi)&"</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span>" & _
							   		"<span style=""float:left;padding-top:5px;"">" & _
							   			"<span class=""mod_button"" title=""修改"" onclick=""location='JCP_EditSearch.asp?searchid=" & lists(0,listi) & "';""></span>" & _
							   			"<span class=""push_button"" title=""复制调用地址"" onclick=""CopyUrl("&lists(0,listi)&");""></span>" & _
							   			"<span class=""del_button"" title=""删除"" onclick=""DelSet("&lists(0,listi)&");Delsearch();""></span>" & _
							   		"</span>" & _
							   "</div>"
			next

			response.write    "<div style=""float:left;width:100%;text-align:right;font-size:12px;padding:6px;"">" _
							& "页次：" & page & "/" & S.searchPageCount & "　" _
							& "每页 " & curpgsize & " 条　" _
							& "共 " & S.searchCount & " 条　" _
							& "<a href=""?page=1"" style=""text-decoration:none;"">首页</a> " _
							& "<a href=""?page=" & page-1 & """ style=""text-decoration:none;"">上页</a> " _
							& "<a href=""?page=" & page+1 & """ style=""text-decoration:none;"">下页</a> " _
							& "<a href=""?page=" & S.searchPageCount & """ style=""text-decoration:none;"">尾页</a> " _
							& "</div>"

		end if
		S.MainClose
		%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="新建搜索引擎" onclick="javascript:location='JCP_NewSearch.asp';">
		<input type=button class="system_button_00" value="删除所选项" onclick="Delsearch();">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>