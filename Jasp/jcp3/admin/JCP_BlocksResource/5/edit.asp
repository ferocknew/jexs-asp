<!--#include file="../../JCP_Shared/asp_head.asp" -->
<!--#include file="../../JCP_Shared/head.asp" -->
<script language="VBScript" src="../../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	doc.title="�滻��ģ�� �༭���ڡ�������������������������������������������������������������";
	
	function FromCheck(){
		return true;
	}
-->
</script>
<base target="_self">
<!--#include file="../../JCP_Shared/body.asp" -->
<form name="blockform" method="post" action="action.asp?action=editblock&blockid=<%= request.QueryString("blockid") %>" style="margin:0;">
    <table width="100%" height="352" border="0" cellpadding="4" cellspacing="0">
      <tr> 
        <td width="60" height="29" align="right">ģ�����ƣ�</td>
        <td colspan="2"><input type=text id=blockname name=blockname value="�滻��HTML����ģ��" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);"> 
        </td>
      </tr>
      <tr> 
        <td height="29" align="right">ģ��˵����</td>
        <td colspan="2"><input type=text id=blockexplain name=blockexplain value="ֱ�ӱ�дHTML���룬�Թ���ģ���滻ʽ����" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);" style="width:100%;"></td>
      </tr>
      <tr> 
        <td height="265" colspan="3"><textarea name="blockcontent" id="blockcontent" style="width:100%;height:100%;"><!-- �滻��HTML���� -->

</textarea></td>
      </tr>
      <tr> 
        <td colspan="3" align="center">
		  <input type=hidden id="blocktype" name="blocktype" value="4"> 
          <input type="hidden" name="blockfolder" id="blockfolder" value="<%= request.QueryString("src") %>"> 
          <input type=submit class="system_button_00" value="�޸�ģ��" onclick="doc.all.blockform.onsubmit=function(){return FromCheck()};">
          ���� 
          <input type=button class="system_button_00" value="ȡ���޸�" onclick="javascript:window.close();">
        </td>
      </tr>
    </table>
</form>
<script language=javascript>
	reSize(500,400);
<% 
dim rs,blockid,BlockAttribute,tproperty,i
blockid=J.NumberYN(request.querystring("blockid"))
set rs=J.Data.Exe("select blockname,blocktype,blockexplain,blockfolder,BlockAttribute from JCP_BlockList where id="&blockid)
if not rs.eof then
	response.write "doc.getElementById('blockname').value='" & rs("blockname") & "';" & vbcrlf
	response.write "doc.getElementById('blocktype').value='" & rs("blocktype") & "';" & vbcrlf
	response.write "doc.getElementById('blockfolder').value='" & rs("blockfolder") & "';" & vbcrlf
	response.write "doc.getElementById('blockexplain').value='" & rs("blockexplain") & "';" & vbcrlf
	
	BlockAttribute=replace(replace(replace(rs("BlockAttribute"),"<","&lt;"),"""","&quot;"),chr(13)&chr(10),"\n")
	response.write "var blockcontent=""" & BlockAttribute & """;" & vbcrlf
	response.write "doc.getElementById('blockcontent').value=blockcontent.replace(/&quot;/gi,'""').replace(/&lt;/gi,'\<');" & vbcrlf
end if
rs.close
%>
</script>
<!--#include file="../../JCP_Shared/foot.asp" -->
<% J.close %>