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
		alert('[����ҳ]���õ�ַ��\n\n<' + 'script language="javascript" src="../../jcp_search/JS/' + id + '.js"></' + 'script>' + "\n\n" + "���ϵ�ַ�Ѿ����Ƶ������壡");
	}
	
	function Delsearch(id){
		if(confirm("��ȷ��Ҫɾ��ѡ�õ����������𣿣�")){
			var ids="0";
			for(i=0;i<document.getElementsByName('ArtID').length;i++)
				if(document.getElementsByName('ArtID')[i].checked) ids += "," + document.getElementsByName('ArtID')[i].value;
			if(ids=="0"){
				alert("��ѡ��Ҫɾ�������");
			}else{
				startXmlRequest("POST","../../JCP_Search/inc/Action.asp?action=deletesearch&searchid=" + ids,null,"body","","",false);
				if(xml_BackCont=="OK"){
					location.reload();
				}else{
					alert("����ɾ��ʧ������");
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
	<div class="app_title">���Թ���</div>
	<div class="list_box">
		<div class="list_title">
			<span style="width:30px;"><input name="SelectAll" type="checkbox" class="select" onclick="for(i=0;i<document.getElementsByName('ArtID').length;i++)document.getElementsByName('ArtID')[i].checked=this.checked;"></span><span class="distline"></span><span style="width:40px;">ID</span><span class="distline"></span><span style="width:300px;">��������</span><span class="distline"></span><span style="width:120px;">����ʱ��</span><span class="distline"></span><span>�١�����</span>
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
			response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">û���������棡</div>"
		else
			for listi=0 to ubound(lists,2)
				response.write "<div class=""list"" style=""padding:4px 0 4px 0;"">" & _
							   "<span style=""width:30px;float:left;""><input name=""ArtID"" id=""ArtID" & lists(0,listi) & """ type=""checkbox"" value="""&lists(0,listi)&""" class=""select""></span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:40px;float:left;padding-top:5px;"">" & lists(0,listi) & "</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:300px;float:left;padding-top:5px;"">" & S.Main.Encode(lists(1,listi)) & "</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span><span style=""width:120px;float:left;padding-top:5px;"">"&lists(2,listi)&"</span>" & _
							   "<span class=""distline_list"" style=""float:left;""></span>" & _
							   		"<span style=""float:left;padding-top:5px;"">" & _
							   			"<span class=""mod_button"" title=""�޸�"" onclick=""location='JCP_EditSearch.asp?searchid=" & lists(0,listi) & "';""></span>" & _
							   			"<span class=""push_button"" title=""���Ƶ��õ�ַ"" onclick=""CopyUrl("&lists(0,listi)&");""></span>" & _
							   			"<span class=""del_button"" title=""ɾ��"" onclick=""DelSet("&lists(0,listi)&");Delsearch();""></span>" & _
							   		"</span>" & _
							   "</div>"
			next

			response.write    "<div style=""float:left;width:100%;text-align:right;font-size:12px;padding:6px;"">" _
							& "ҳ�Σ�" & page & "/" & S.searchPageCount & "��" _
							& "ÿҳ " & curpgsize & " ����" _
							& "�� " & S.searchCount & " ����" _
							& "<a href=""?page=1"" style=""text-decoration:none;"">��ҳ</a> " _
							& "<a href=""?page=" & page-1 & """ style=""text-decoration:none;"">��ҳ</a> " _
							& "<a href=""?page=" & page+1 & """ style=""text-decoration:none;"">��ҳ</a> " _
							& "<a href=""?page=" & S.searchPageCount & """ style=""text-decoration:none;"">βҳ</a> " _
							& "</div>"

		end if
		S.MainClose
		%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="�½���������" onclick="javascript:location='JCP_NewSearch.asp';">
		<input type=button class="system_button_00" value="ɾ����ѡ��" onclick="Delsearch();">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>