<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<!--#include file="../JCP_Shared/body.asp" -->
<% 
	dim menuid,rs
	menuid=J.NumberYN(request.QueryString("menuid"))
	
	set rs=J.Data.Exe("select menuname,menutype,parentid from JCP_menus where menuid=" & menuid)
	if rs.eof then
		response.write "û���ҵ���Ӧ����Ŀ��¼��<script>window.close();</script>"
	else
		if rs("parentid")=0 then
			response.write "<script>var typeset="&rs("menutype")&";var menuid="&menuid&";</script>"
			response.write "<div style=""text-align:center;width:100%;margin-bottom:8px;""><b>" & rs("menuname") & "</b>��"
			if rs("menutype")=0 then
				response.write "<input type=radio id=typeset1 name=typeset value=0 checked class=select>��ͨ��Ŀ��"
				response.write "<input type=radio id=typeset2 name=typeset value=1 class=select>ϵͳ��Ŀ"
			else
				response.write "<input type=radio id=typeset1 name=typeset value=0 class=select>��ͨ��Ŀ��"
				response.write "<input type=radio id=typeset2 name=typeset value=1 checked class=select>ϵͳ��Ŀ"
			end if
			response.write "</div>"
			response.write "<center><input type=button class=""system_button_00"" value=""Ӧ�ø���"" onclick=""SaveSet();"">����<input type=button class=""system_button_00"" value=""ȡ������"" onclick=""window.close();""></center>"
		else
			response.write "<center>ֻ�ж�����Ŀ�������ô��<br><br><input type=button class=""system_button_00"" value=""ȡ������"" onclick=""window.close();""></center>"
		end if
	end if
	rs.close
%>
<script language="JavaScript">
	document.title="���ĵ�ǰ��Ŀ������ֵ����������������";
	
	function SaveSet(){
		var curtype=0;
		if(typeset1.checked) curtype=0;
		if(typeset2.checked) curtype=1;
		if(curtype!=typeset){
			startXmlRequest("GET","JCP_Menu_Action.asp?action=typechange&menuid=" + menuid + "&acttype=" + curtype,null,"body","","",false);
			if(xml_BackCont=="OK") window.returnValue="OK";
			else alert(xml_BackCont);
		}
		window.close();
	}
</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>