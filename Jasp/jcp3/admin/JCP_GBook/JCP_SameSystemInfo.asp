<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">ͬ��ϵͳ����</div>
	<div class="list_box">&nbsp;
<%
dim PlugName
dim requestS,xml,root
set xml = Server.CreateObject("Microsoft.XMLDOM")
xml.async = false
xml.load(J.ManageRoot & replace(J.CurrentManagePath,"/","\") & "old_config.xml")
If xml.parseError.errorCode <> 0 Then 
	response.write "������ȷ��������" & "Description: " & xml.parseError.reason & "<br>Line: " & xml.parseError.Line
	PlugName="��ǰ���"
else
	set root = xml.documentElement
	PlugName = root.selectSingleNode("//jcp-plug//name").text
end if
set root = nothing
set xml  = nothing

if request.QueryString("action")="samenow" then
	J.SameSystemInfo	
	response.Redirect("?action=OK")
elseif request.QueryString("action")="OK" then
	response.write "<script>alert(""ͬ���ɹ���"");location=""JCP_SameSystemInfo.asp"";</script>"
end if
%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="����ͬ��ϵͳĿ¼��ǰ̨" onclick="location='?action=samenow';">
		<br><br>�á�<%= PlugName %>����Ӧλ�ڲ�ͬ�ļ����µĹ���ϵͳ<br><br>�����ڡ�<font color="<%= session("Color_LightFont") %>">�°�װ<%= PlugName %></font>����<font color="<%= session("Color_LightFont") %>">�޸�<%= PlugName %>����</font>����<font color="<%= session("Color_LightFont") %>">�޸Ĺ����̨�ļ�����</font>��ʱ��ִ�д˲�����
	</div>

<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>