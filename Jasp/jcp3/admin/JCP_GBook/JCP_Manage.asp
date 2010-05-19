<!--#include file="../../JCP_GBook/Inc/Class_GBook.asp" -->
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
	
	function Replymsg(id){
		if(ModelWin("JCP_Reply.asp?msgid=" + id,500,230)) location.reload();
	}
	
	function LookMsg(id){
		if(ModelWin("JCP_Show.asp?msgid=" + id,400,300)) location.reload();
	}
	
	function Passmsg(id){
		if(confirm("您确定要审核此留言吗？？")){
			startXmlRequest("POST","../../JCP_GBook/inc/Action.asp?action=passmsg&msgid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("留言审核失败啦！");
				doc.write(xml_BackCont);
			}
		}
	}
	
	function Delmsg(id){
		if(confirm("您确定要删除此留言吗？？")){
			startXmlRequest("POST","../../JCP_GBook/inc/Action.asp?action=delmsg&msgid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("留言删除失败啦！");
				doc.write(xml_BackCont);
			}
		}
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">留言管理</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('templateID').length;i++)document.getElementsByName('templateID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:100px;">昵　称</span><span class="distline"></span><span style="width:300px;">标　　题</span><span class="distline"></span><span style="width:120px;">发表时间</span><span class="distline"></span><span style="width:60px;">回复</span><span class="distline"></span><span style="width:60px;">审核</span><span class="distline"></span><span>操　　作</span>
		</div>
		<% 
		G.MainOpen
		dim msgs,msgi,page
		dim replyyn,showyn,msgtitle
		page=request.querystring("page")
		if not G.main.NumberTF(page) then page=1
		page=cint(page)
		msgs=G.ListMsg(page,0)
		if isEmpty(msgs) then
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">没有留言！</div>"
		else
			for msgi=0 to ubound(msgs,2)
				if not G.Main.BlankTF(msgs(4,msgi)) then replyyn="<font color=" & session("Color_LightFont") & ">×</font>" else replyyn="√"
				if not G.Main.BlankTF(msgs(2,msgi)) then msgtitle="-" else msgtitle=msgs(2,msgi)
				if not msgs(6,msgi) then showyn="<font color=" & session("Color_LightFont") & ">×</font>" else showyn="√"
				response.write "<div class=""list"" style=""padding:4px 0 4px 0;"">" & _
							   "<span style=""width:30px;float:left;""><input name=""templateID"" id=""templateID"" type=""checkbox"" value="""&msgs(0,msgi)&""" class=""select""></span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:100px;float:left;padding-top:5px;"">" & msgs(1,msgi) & "</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:300px;float:left;padding-top:5px;""><a href=""javascript:LookMsg("&msgs(0,msgi)&")"">"& msgtitle &"</a></span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:120px;float:left;padding-top:5px;"">"&msgs(5,msgi)&"</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:60px;float:left;padding-top:5px;"">"&replyyn&"</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:60px;float:left;padding-top:5px;"">"&showyn&"</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span>" & _
							   		"<span style=""float:left;padding-top:5px;"">" & _
							   			"<span class=""push_button"" title=""回复"" onclick=""Replymsg("&msgs(0,msgi)&");""></span>" & _
							   			"<span class=""lock_button"" title=""审核"" onclick=""Passmsg("&msgs(0,msgi)&");""></span>" & _
							   			"<span class=""del_button"" title=""删除"" onclick=""Delmsg("&msgs(0,msgi)&");""></span>" & _
							   		"</span>" & _
							   "</div>"
			next

			response.write    "<div style=""float:left;width:100%;text-align:right;font-size:12px;padding:6px;"">" _
							& "页次：" & page & "/" & G.MsgPageCount & "　" _
							& "每页 " & pgsize & " 条　" _
							& "共 " & G.MsgCount & " 条　" _
							& "<a href=""?page=1"" style=""text-decoration:none;"">首页</a> " _
							& "<a href=""?page=" & page-1 & """ style=""text-decoration:none;"">上页</a> " _
							& "<a href=""?page=" & page+1 & """ style=""text-decoration:none;"">下页</a> " _
							& "<a href=""?page=" & G.MsgPageCount & """ style=""text-decoration:none;"">尾页</a> " _
							& "</div>"

		end if
		G.MainClose
		%>
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>