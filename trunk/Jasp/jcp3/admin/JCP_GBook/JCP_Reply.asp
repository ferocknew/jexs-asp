<%
	Response.CacheControl = "no-cache"
	Response.Expires = 0
%>
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
<script language="JavaScript">
<!--
	var doc=document;
		
	function Passmsg(id){
		if(confirm("ƒ˙»∑∂®“™…Û∫À¥À¡Ù—‘¬£ø£ø")){
			startXmlRequest("POST","../../JCP_GBook/inc/Action.asp?action=passmsg&msgid=" + id,null,"body","","",false);
			if(xml_BackCont=="OK"){
				location.reload();
			}else{
				alert("¡Ù—‘…Û∫À ß∞‹¿≤£°");
				doc.write(xml_BackCont);
			}
		}
	}
	

function FormCheck(){
	if(document.all.form1.msgreply.value.replace(/[\s°°]/gi,"")==""){
		alert("ªÿ∏¥ƒ⁄»›≤ªƒ‹Œ™ø’£°");
		document.all.form1.msgreply.select();
		document.all.form1.msgreply.focus();
		return false;
	}else{
		return true;
	}
}

function InsertFace(faceid){
	document.all.form1.msgreply.focus();
	document.selection.createRange().text="[face:" + faceid + "]";
}
-->
</script>
<base target="_self">
<!--#include file="../JCP_Shared/body.asp" -->
<% 
dim msgid
msgid=J.NumberYN(request.querystring("msgid"))
G.MainOpen
set grs=G.Main.data.RsOpen("select msgreply from msg where id="&msgid,1)
if not grs.eof then
%>
	<div class="app_title">¡Ù—‘ªÿ∏¥</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="float:left;">
  <tr> 
    <td><form action="../../JCP_GBook/INC/Action.asp?action=replymsg&msgid=<%= msgid %>" method="post" name="form1" style="padding:0;margin:0;" onsubmit="return FormCheck();">
        <table width="100%" border="0" cellspacing="2" cellpadding="0" style="margin:10px 0 0 0;">
          <tr> 
            <td><textarea name="msgreply" rows="6" style="width:340px;font-size:12px;"><%= G.Main.Encode(grs("msgreply")) %></textarea></td>
            <td width="140" align="center"><table width="100%" border="0" cellspacing="4" cellpadding="0">
                <tr align="center"> 
                  <td><img src="../../JCP_GBook/images/1.gif" width="15" height="15" onClick="InsertFace(1);" style="cursor:hand;"></td>
                  <td><img src="../../JCP_GBook/images/2.gif" width="15" height="15" onClick="InsertFace(2);" style="cursor:hand;"></td>
                  <td><img src="../../JCP_GBook/images/3.gif" width="16" height="16" onClick="InsertFace(3);" style="cursor:hand;"></td>
                </tr>
                <tr align="center"> 
                  <td><img src="../../JCP_GBook/images/4.gif" width="15" height="15" onClick="InsertFace(4);" style="cursor:hand;"></td>
                  <td><img src="../../JCP_GBook/images/5.gif" width="16" height="16" onClick="InsertFace(5);" style="cursor:hand;"></td>
                  <td><img src="../../JCP_GBook/images/6.gif" width="15" height="15" onClick="InsertFace(6);" style="cursor:hand;"></td>
                </tr>
                <tr align="center"> 
                  <td><img src="../../JCP_GBook/images/7.gif" width="15" height="15" onClick="InsertFace(7);" style="cursor:hand;"></td>
                  <td><img src="../../JCP_GBook/images/8.gif" width="15" height="15" onClick="InsertFace(8);" style="cursor:hand;"></td>
                  <td><img src="../../JCP_GBook/images/9.gif" width="15" height="15" onClick="InsertFace(9);" style="cursor:hand;"></td>
                </tr>
                <tr align="center"> 
                  <td><img src="../../JCP_GBook/images/10.gif" width="15" height="15" onClick="InsertFace(10);" style="cursor:hand;"></td>
                  <td><img src="../../JCP_GBook/images/11.gif" width="15" height="15" onClick="InsertFace(11);" style="cursor:hand;"></td>
                  <td>&nbsp;</td>
                </tr>
              </table></td>
          </tr>
          <tr align="center"> 
            <td height="39" colspan="3"><input type="submit" name="Submit" value="¡¢º¥ªÿ∏¥" style="font-size:12px;">
              °°°° 
              <input type="reset" name="Submit2" value="÷ÿ–¬ÃÓ–¥" style="font-size:12px;"> </td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
<%
end if
grs.close
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>