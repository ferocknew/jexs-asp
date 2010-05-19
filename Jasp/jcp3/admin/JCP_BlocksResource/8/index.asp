<!--#include file="../../JCP_Shared/asp_head.asp" -->
<!--#include file="../../JCP_Shared/head.asp" -->
<script language="VBScript" src="../../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	doc.title="浏览导航模块 新建窗口　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
	
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
  <table width="100%" height="101" border="0" cellpadding="4" cellspacing="0">
    <tr> 
      <td width="60" height="29" align="right">模块名称：</td>
      <td><input type=text id=blockname name=blockname value="浏览导航模块" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);"> 
      </td>
    </tr>
    <tr> 
      <td height="29" align="right">模块说明：</td>
      <td><input type=text id=blockexplain name=blockexplain value="用户访问页面时，显示所在位置" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);" style="width:100%;"></td>
    </tr>
    <tr> 
      <td height="12" align="right">分隔符号：</td>
      <td><input name="discsign" type="text" id="discsign" size="8" value=" >> " onChange="discsign_demo.innerHTML='首页' + this.value + '当前位置';" onKeyUp="discsign_demo.innerHTML='首页' + this.value + '当前位置';">
        （效果：<span id="discsign_demo">首页 >> 当前位置</span>） </td>
    </tr>
    <tr> 
      <td height="24" align="right">添加链接：</td>
      <td><input name="needlink" type="checkbox" id="needlink" value="true" class="select">
        是</td>
    </tr>
    <tr align="center"> 
      <td height="12" colspan="2"> <input type=hidden id=blocktype name=blocktype value="0"> 
        <input type="hidden" name="blockfolder" id="blockfolder" value="<%= request.QueryString("src") %>"> 
        <input type=submit class="system_button_00" value="新建模块" onclick="doc.all.blockform.onsubmit=function(){return FromCheck()};">
        　　 
        <input type=button class="system_button_00" value="取消创建" onclick="javascript:window.close();"> 
      </td>
    </tr>
  </table>
</form>		
<script language=javascript>
reSize(400,190);
</script>
<!--#include file="../../JCP_Shared/foot.asp" -->
<% J.close %>