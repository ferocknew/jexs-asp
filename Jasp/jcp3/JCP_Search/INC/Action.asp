<!--#include file="Class_Search.asp"-->
<% 
S.MainOpen

dim nsid

if request.QueryString("action")="newsearch2js" then
	nsid=S.Search2JS(-1)
	%>
	<div class="result">
		<div class="manage_exp">���������洴���ɹ���
			<table><tr><td align=left>
			<br>[�ס�ҳ] ���ô��룺<%= S.Main.Encode("<script language=""javascript"" src=""" & SameManagePath & "JS/" & nsid & ".js""></script>") %>
			<br><br>[����ҳ] ���ô��룺<%= S.Main.Encode("<script language=""javascript"" src=""../../" & SameManagePath & "JS/" & nsid & ".js""></script>") %>
			<br><br>
			</td></tr></table>
		</div>
		<div class="result_button"><span>[<a href="../../<%= SameManageFolder & "/" & SameManagePath %>JCP_NewSearch.asp">��������</a>]</span><span>[<a href="../../<%= SameManageFolder & "/" & SameManagePath %>JCP_Manage.asp">���ع���</a>]</span></div>
	</div>
	<% 
elseif request.QueryString("action")="editsearch2js" then
	nsid=S.Main.NumberYn(request.querystring("searchid"))
	S.Search2JS nsid
	%>
	<div class="result">
		<div class="manage_exp">���������޸ĳɹ���
			<table><tr><td align=left>
			<br>[�ס�ҳ] ���ô��룺<%= S.Main.Encode("<script language=""javascript"" src=""" & SameManagePath & "JS/" & nsid & ".js""></script>") %>
			<br><br>[����ҳ] ���ô��룺<%= S.Main.Encode("<script language=""javascript"" src=""../../" & SameManagePath & "JS/" & nsid & ".js""></script>") %>
			<br><br>
			</td></tr></table>
		</div>
		<div class="result_button"><span>[<a href="../../<%= SameManageFolder & "/" & SameManagePath %>JCP_NewSearch.asp">��������</a>]</span><span>[<a href="../../<%= SameManageFolder & "/" & SameManagePath %>JCP_Manage.asp">���ع���</a>]</span></div>
	</div>
	<% 
elseif request.querystring("action")="deletesearch" then
	dim dids
	dids=request.querystring("searchid")
	S.Main.NumberYN replace(dids,",","")
	S.DeleteSearch dids
	response.write "OK"
end if

S.MainClose
%>