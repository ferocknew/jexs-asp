<!--#include file="../../JCP_Shared/asp_head.asp" -->
<!--#include file="../../JCP_Shared/head.asp" -->
<script language="VBScript" src="../../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	doc.title="VBS模块 新建窗口　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
	
	function FromCheck(){
		if(BlockNameCheck()==false) return false;
		return true;
	}
	
	function BlockNameCheck(){
		var o=doc.getElementById("blockname");
		startXmlRequest("POST","../../JCP_BlockList/JCP_BlockAction_XML.asp?action=blocknamecheck&blockname=" + o.value,null,"body","","",false);
		if(xml_BackCont!="OK"){
			alert("模块名称已经存在，请更换！");
			o.select();
			return false;
		}
	}
-->
</script>
<base target="_self">
<!--#include file="../../JCP_Shared/body.asp" -->
<form name="blockform" method="post" action="action.asp?action=createblock" style="margin:0;">
    <table width="100%" height="352" border="0" cellpadding="4" cellspacing="0">
      <tr> 
        <td width="60" height="29" align="right">模块名称：</td>
        <td colspan="2"><input type=text id=blockname name=blockname value="VBS生成模块" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);"> 
        </td>
      </tr>
      <tr> 
        <td height="29" align="right">模块说明：</td>
        <td colspan="2"><input type=text id=blockexplain name=blockexplain value="直接编写VBS文件代码，以供多页面调用" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);" style="width:100%;"></td>
      </tr>
      <tr> 
        <td height="265" colspan="3"><textarea name="blockcontent" id="blockcontent" style="width:100%;height:100%;">' VBScript脚本代码

</textarea></td>
      </tr>
      <tr> 
        <td colspan="3" align="center">
		  <input type=hidden id=blocktype name=blocktype value="6"> 
          <input type="hidden" name="blockfolder" id="blockfolder" value="<%= request.QueryString("src") %>"> 
          <input type=submit class="system_button_00" value="新建模块" onclick="doc.all.blockform.onsubmit=function(){return FromCheck()};">
          　　 
          <input type=button class="system_button_00" value="取消创建" onclick="javascript:window.close();"> 
        </td>
      </tr>
    </table>
</form>		
<script language=javascript>
	reSize(500,400);
</script>
<!--#include file="../../JCP_Shared/foot.asp" -->
<% J.close %>