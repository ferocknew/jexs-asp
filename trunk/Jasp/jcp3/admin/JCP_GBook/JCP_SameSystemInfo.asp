<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">同步系统配置</div>
	<div class="list_box">&nbsp;
<%
dim PlugName
dim requestS,xml,root
set xml = Server.CreateObject("Microsoft.XMLDOM")
xml.async = false
xml.load(J.ManageRoot & replace(J.CurrentManagePath,"/","\") & "old_config.xml")
If xml.parseError.errorCode <> 0 Then 
	response.write "不能正确接收数据" & "Description: " & xml.parseError.reason & "<br>Line: " & xml.parseError.Line
	PlugName="当前插件"
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
	response.write "<script>alert(""同步成功！"");location=""JCP_SameSystemInfo.asp"";</script>"
end if
%>
	</div>
	<div class="list_buttons">
		<input type=button class="system_button_00" value="立即同步系统目录至前台" onclick="location='?action=samenow';">
		<br><br>让“<%= PlugName %>”适应位于不同文件夹下的管理系统<br><br>所以在“<font color="<%= session("Color_LightFont") %>">新安装<%= PlugName %></font>”或“<font color="<%= session("Color_LightFont") %>">修改<%= PlugName %>参数</font>”或“<font color="<%= session("Color_LightFont") %>">修改管理后台文件夹名</font>”时，执行此操作！
	</div>

<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>