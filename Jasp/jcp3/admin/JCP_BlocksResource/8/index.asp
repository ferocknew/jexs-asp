<!--#include file="../../JCP_Shared/asp_head.asp" -->
<!--#include file="../../JCP_Shared/head.asp" -->
<script language="VBScript" src="../../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	doc.title="�������ģ�� �½����ڡ�������������������������������������������������������������";
	
	function FromCheck(){
		if(BlockNameCheck()==false) return false;
		return true;
	}
	
	function BlockNameCheck(){
		var o=doc.getElementById("blockname");
		startXmlRequest("POST","../../JCP_BlockList/JCP_BlockAction_XML.asp?action=blocknamecheck&blockname=" + o.value,null,"body","","",false);
		if(xml_BackCont!="OK"){
			alert("ģ�������Ѿ����ڣ��������");
			o.select();
			return false;
		}
	}
-->
</script>
<base target="_self">
<!--#include file="../../JCP_Shared/body.asp" -->
<form name="blockform" method="post" action="action.asp?action=createblock" style="margin:0;">
  <table width="100%" height="101" border="0" cellpadding="4" cellspacing="0">
    <tr> 
      <td width="60" height="29" align="right">ģ�����ƣ�</td>
      <td><input type=text id=blockname name=blockname value="�������ģ��" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);"> 
      </td>
    </tr>
    <tr> 
      <td height="29" align="right">ģ��˵����</td>
      <td><input type=text id=blockexplain name=blockexplain value="�û�����ҳ��ʱ����ʾ����λ��" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);" style="width:100%;"></td>
    </tr>
    <tr> 
      <td height="12" align="right">�ָ����ţ�</td>
      <td><input name="discsign" type="text" id="discsign" size="8" value=" >> " onChange="discsign_demo.innerHTML='��ҳ' + this.value + '��ǰλ��';" onKeyUp="discsign_demo.innerHTML='��ҳ' + this.value + '��ǰλ��';">
        ��Ч����<span id="discsign_demo">��ҳ >> ��ǰλ��</span>�� </td>
    </tr>
    <tr> 
      <td height="24" align="right">������ӣ�</td>
      <td><input name="needlink" type="checkbox" id="needlink" value="true" class="select">
        ��</td>
    </tr>
    <tr align="center"> 
      <td height="12" colspan="2"> <input type=hidden id=blocktype name=blocktype value="0"> 
        <input type="hidden" name="blockfolder" id="blockfolder" value="<%= request.QueryString("src") %>"> 
        <input type=submit class="system_button_00" value="�½�ģ��" onclick="doc.all.blockform.onsubmit=function(){return FromCheck()};">
        ���� 
        <input type=button class="system_button_00" value="ȡ������" onclick="javascript:window.close();"> 
      </td>
    </tr>
  </table>
</form>		
<script language=javascript>
reSize(400,190);
</script>
<!--#include file="../../JCP_Shared/foot.asp" -->
<% J.close %>