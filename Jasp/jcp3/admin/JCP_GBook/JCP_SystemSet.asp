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
<!--#include file="../JCP_Shared/body.asp" -->

<% 
if request.querystring("action")="save" then
	G.MainOpen
	G.SystemSet request.form("color_font_system"),_
				request.form("color_font_content"),_
				request.form("color_font_title"),_
				request.form("color_font_username"),_
				request.form("color_font_time"),_
				request.form("color_font_reply"),_
				request.form("color_bg_title"),_
				request.form("color_bg_content"),_
				request.form("color_bg_reply"),_
				request.form("color_border"),_
				request.form("passyn"),_
				request.form("pagename"),_
				request.form("pgsize")
	G.MainClose
	response.write "<script>alert(""�µ����ñ���ɹ���"");location=""JCP_SystemSet.asp""</script>"
	response.end
end if
%>

	<div class="app_title">��������</div>
	  <form name="form1" method="post" action="?action=save" style="float:left;maring:0;padding:0;">
	  <fieldset style="margin:10px 0 0 0;"><legend>ϵͳ��ɫ</legend>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>ϵͳ���֣�</span>
			<span><input type="text" name="color_font_system" id="color_font_system" style="background-color:<%= color_font_system %>;" value="<%= color_font_system %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�������֣�</span>
			<span><input type="text" name="color_font_content" id="color_font_content" style="background-color:<%= color_font_content %>;" value="<%= color_font_content %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�������֣�</span>
			<span><input type="text" name="color_font_title" id="color_font_title" style="background-color:<%= color_font_title %>;" value="<%= color_font_title %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�ǳ����֣�</span>
			<span><input type="text" name="color_font_username" id="color_font_username" style="background-color:<%= color_font_username %>;" value="<%= color_font_username %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>ʱ�����֣�</span>
			<span><input type="text" name="color_font_time" id="color_font_time" style="background-color:<%= color_font_time %>;" value="<%= color_font_time %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�ظ����֣�</span>
			<span><input type="text" name="color_font_reply" id="color_font_reply" style="background-color:<%= color_font_reply %>;" value="<%= color_font_reply %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>���ⱳ����</span>
			<span><input type="text" name="color_bg_title" id="color_bg_title" style="background-color:<%= color_bg_title %>;" value="<%= color_bg_title %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>���Ա�����</span>
			<span><input type="text" name="color_bg_content" id="color_bg_content" style="background-color:<%= color_bg_content %>;" value="<%= color_bg_content %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�ظ�������</span>
			<span><input type="text" name="color_bg_reply" id="color_bg_reply" style="background-color:<%= color_bg_reply %>;" value="<%= color_bg_reply %>" onclick="setcolor(this.id);" readonly></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>���߿�</span>
			<span><input type="text" name="color_border" id="color_border" style="background-color:<%= color_border %>;" value="<%= color_border %>" onclick="setcolor(this.id);" readonly></span>
		</div>
	  </fieldset>
	  <fieldset style="margin:10px 0 0 0;"><legend>��������</legend>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>Ĭ����ˣ�</span>
			<span><input type="radio" name="passyn" value="false" <% if not passyn then response.write "checked" %> class="select">�ǡ�<input type="radio" name="passyn" value="true" <% if passyn then response.write "checked" %> class="select">��</span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�����ļ���</span>
			<span><input type="text" name="pagename" id="pagename"  value="<%= pagename %>"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>�б��ȣ�</span>
			<span><input type="text" name="pgsize" id="pgsize" value="<%= pgsize %>"></span>
		</div>
	  </fieldset>
 		<div style="width:100%;text-align:center;margin:10px 0 0 0;">
			<input type="submit" name="Submit" value="��������">����
			<input type="reset" name="Submit2" value="�����޸�">
		</div>
	  </form>
  <!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>