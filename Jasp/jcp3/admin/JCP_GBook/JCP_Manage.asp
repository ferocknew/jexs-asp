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
		if(confirm("��ȷ��Ҫ��˴������𣿣�")){
			startXmlRequest("POST","../../JCP_GBook/inc/Action.asp?action=passmsg&msgid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("�������ʧ������");
				doc.write(xml_BackCont);
			}
		}
	}
	
	function Delmsg(id){
		if(confirm("��ȷ��Ҫɾ���������𣿣�")){
			startXmlRequest("POST","../../JCP_GBook/inc/Action.asp?action=delmsg&msgid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("����ɾ��ʧ������");
				doc.write(xml_BackCont);
			}
		}
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">���Թ���</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('templateID').length;i++)document.getElementsByName('templateID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:100px;">�ǡ���</span><span class="distline"></span><span style="width:300px;">�ꡡ����</span><span class="distline"></span><span style="width:120px;">����ʱ��</span><span class="distline"></span><span style="width:60px;">�ظ�</span><span class="distline"></span><span style="width:60px;">���</span><span class="distline"></span><span>�١�����</span>
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
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">û�����ԣ�</div>"
		else
			for msgi=0 to ubound(msgs,2)
				if not G.Main.BlankTF(msgs(4,msgi)) then replyyn="<font color=" & session("Color_LightFont") & ">��</font>" else replyyn="��"
				if not G.Main.BlankTF(msgs(2,msgi)) then msgtitle="-" else msgtitle=msgs(2,msgi)
				if not msgs(6,msgi) then showyn="<font color=" & session("Color_LightFont") & ">��</font>" else showyn="��"
				response.write "<div class=""list"" style=""padding:4px 0 4px 0;"">" & _
							   "<span style=""width:30px;float:left;""><input name=""templateID"" id=""templateID"" type=""checkbox"" value="""&msgs(0,msgi)&""" class=""select""></span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:100px;float:left;padding-top:5px;"">" & msgs(1,msgi) & "</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:300px;float:left;padding-top:5px;""><a href=""javascript:LookMsg("&msgs(0,msgi)&")"">"& msgtitle &"</a></span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:120px;float:left;padding-top:5px;"">"&msgs(5,msgi)&"</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:60px;float:left;padding-top:5px;"">"&replyyn&"</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:60px;float:left;padding-top:5px;"">"&showyn&"</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span>" & _
							   		"<span style=""float:left;padding-top:5px;"">" & _
							   			"<span class=""push_button"" title=""�ظ�"" onclick=""Replymsg("&msgs(0,msgi)&");""></span>" & _
							   			"<span class=""lock_button"" title=""���"" onclick=""Passmsg("&msgs(0,msgi)&");""></span>" & _
							   			"<span class=""del_button"" title=""ɾ��"" onclick=""Delmsg("&msgs(0,msgi)&");""></span>" & _
							   		"</span>" & _
							   "</div>"
			next

			response.write    "<div style=""float:left;width:100%;text-align:right;font-size:12px;padding:6px;"">" _
							& "ҳ�Σ�" & page & "/" & G.MsgPageCount & "��" _
							& "ÿҳ " & pgsize & " ����" _
							& "�� " & G.MsgCount & " ����" _
							& "<a href=""?page=1"" style=""text-decoration:none;"">��ҳ</a> " _
							& "<a href=""?page=" & page-1 & """ style=""text-decoration:none;"">��ҳ</a> " _
							& "<a href=""?page=" & page+1 & """ style=""text-decoration:none;"">��ҳ</a> " _
							& "<a href=""?page=" & G.MsgPageCount & """ style=""text-decoration:none;"">βҳ</a> " _
							& "</div>"

		end if
		G.MainClose
		%>
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>