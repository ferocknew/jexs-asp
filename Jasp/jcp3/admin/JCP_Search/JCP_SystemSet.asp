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
<!--#include file="../JCP_Shared/body.asp" -->

<% 
if request.querystring("action")="save" then
	S.MainOpen
	S.SystemSet request.form("csssheet"),_
				request.form("color_keyword"),_
				request.form("pagename"),_
				request.form("pgsize"),_
				request.form("searchshowsize"),_
				request.form("searchdatabase"),_
				request.form("searchfilefolder"),_
				request.form("searchfileext")
	S.MainClose
	response.write "<script>alert(""�µ����ñ���ɹ���"");location=""JCP_SystemSet.asp""</script>"
	response.end
end if
%>

	<div class="app_title">��������</div>
	  <form name="form1" method="post" action="?action=save" style="float:left;maring:0;padding:0;">
	  <fieldset style="margin:10px 0 0 0;"><legend>��������</legend>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�����ļ���</span>
			<span><input type="text" name="pagename" id="pagename"  value="<%= pagename %>"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>ϵͳ���⣺</span>
			<span><input type="text" name="searchdatabase" id="searchdatabase" value="<%= "../../" & J.ManageFolder & "/" & J.DataPath & "/" & J.DataName %>" readonly style="background-color:#EEEEEE;"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>����·����</span>
			<span><input type="text" name="searchfilefolder" id="searchfilefolder" value="<%= "../../" & J.WebPath %>" readonly style="background-color:#EEEEEE;"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�ļ���ʽ��</span>
			<span><input type="text" name="searchfileext" id="searchfileext" value="<%= J.FileExt %>" readonly style="background-color:#EEEEEE;"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>ÿҳ��ʾ��</span>
			<span><input name="pgsize" type="text" id="pgsize" value="<%= pgsize %>" size="4" onblur="IntCheck(this.value,this)"> ���������</span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>��ʾ������</span>
			<span><input name="searchshowsize" type="text" id="searchshowsize" value="<%= searchshowsize %>" size="4" onblur="IntCheck(this.value,this)">��ע�⣺��������йؼ���ǰ�������ʾ��������</span>
		</div>
	  </fieldset>
	  <fieldset style="margin:10px 0 0 0;"><legend>��ʽ����</legend>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>����ʽ��</span>
			<span><textarea  name="csssheet" rows="8" id="csssheet" style="width:100%"><%= replace(replace(csssheet,"};","}" & chr(13) & chr(10)),"""""","""") %></textarea>
			��ϵͳ��ʽ�����У�#JCP_Search_Result .ResultItem .Link .SystemID .ID .UpTime .Info_1 .Info_2 ...��
			</span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�� �� �֣�</span>
			<span><input name="color_keyword" type="text" id="color_keyword" onclick="setcolor(this.id);"  value="<%= color_keyword %>" size="6" readonly style="background-color:<%= color_keyword %>">��ע�⣺��������еĹؼ�����ɫ��</span>
		</div>
	  </fieldset>
 		<div style="width:100%;text-align:center;margin:10px 0 0 0;">
			<input type="submit" name="Submit" value="��������">����
			<input type="reset" name="Submit2" value="�����޸�">
		</div>
	  </form>
  <!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>