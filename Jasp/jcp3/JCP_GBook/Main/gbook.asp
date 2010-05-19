<!--#include file="../INC/Class_GBook.asp"-->
<%
if request.querystring("action")="new" then
	G.MainOpen
	G.NewMsg request.form("username"),request.form("msgtitle"),request.form("msgcontent")
	G.MainClose
	if passyn then
		response.write "<script>alert(""您的留言发布成功，管理审核后即可显示！"");location=""" & pagename & """</script>"
	else
		response.redirect pagename
	end if
	response.end
end if

	function MsgTable(id,username,msgtitle,msgcontent,msgreply,intime)
%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="float:left;border:1px solid <%= color_border %>;margin:6px 0 6px 0;">
		  <tr bgcolor="<%= color_bg_title %>">
			<td height="28" width="80" align="right" style="font-size:12px;color:<%= color_font_system %>;">昵　　称：</td>
			<td style="font-size:12px;color:<%= color_font_system %>;">
				<div style="float:left;font-size:12px;color:<%= color_font_username %>;"><%= username %></div>
				<div style="float:left;font-size:12px;color:<%= color_font_system %>;">　在【</div>
				<div style="float:left;font-size:12px;color:<%= color_font_time %>;"><%= intime %></div>
				<div style="float:left;font-size:12px;color:<%= color_font_system %>;">】说：</div>
				<div style="float:left;font-size:12px;color:<%= color_font_title %>;"><%= msgtitle %></div>
			</td>
		  </tr>
		  <tr bgcolor="<%= color_bg_content %>">
			<td height="32" align="right" valign="top" style="font-size:12px;padding:8px 0 0 0;color:<%= color_font_system %>;line-height:1.6;">留言内容：</td>
			<td style="text-align:left;font-size:12px;padding:8px 0 8px 0;color:<%= color_font_content %>;line-height:1.6;"><%= G.MsgFace(msgcontent) %></td>
		  </tr>
		  <tr bgcolor="<%= color_bg_reply %>">
			<td height="32" align="right" valign="top" style="font-size:12px;padding:8px 0 0 0;color:<%= color_font_system %>;line-height:1.6;">回　　复：</td>
			<td style="text-align:left;font-size:12px;padding:8px 0 8px 0;color:<%= color_font_content %>;line-height:1.6;"><%= G.MsgFace(msgreply) %></td>
		  </tr>
		</table>
<% 
 	end function
	
	function ListPage(totalpage,totalrs,curpage)
		response.write    "<div style=""width:100%;text-align:right;font-size:12px;color:" & color_font_system & ";padding:6px;"">" _
						& "页次：" & curpage & "/" & totalpage & "　" _
						& "每页 " & pgsize & " 条　" _
						& "共 " & totalrs & " 条　" _
						& "<a href=""" & pagename & "?page=1"" style=""text-decoration:none;"">首页</a> " _
						& "<a href=""" & pagename & "?page=" & curpage-1 & """ style=""text-decoration:none;"">上页</a> " _
						& "<a href=""" & pagename & "?page=" & curpage+1 & """ style=""text-decoration:none;"">下页</a> " _
						& "<a href=""" & pagename & "?page=" & totalpage & """ style=""text-decoration:none;"">尾页</a> " _
						& "</div>"
	end function
	
	function MsgPublishBox()
%>
<script language="JavaScript">
<!--
function FormCheck(){
	if(document.all.form1.msgcontent.value.replace(/[\s　]/gi,"")==""){
		alert("留言内容不能为空！");
		document.all.form1.msgcontent.select();
		document.all.form1.msgcontent.focus();
		return false;
	}else{
		return true;
	}
}

function InsertFace(faceid){
	document.all.form1.msgcontent.focus();
	document.selection.createRange().text="[face:" + faceid + "]";
}
-->
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid <%= color_border %>;margin:6px 0 6px 0;">
  <tr> 
    <td height="28" bgcolor="<%= color_bg_title %>" style="font-size:12px;padding:0 0 0 10px;">我要留言</td>
  </tr>
  <tr> 
    <td><form action="<%= pagename %>?action=new" method="post" name="form1" target="_self" style="padding:0;margin:0;" onsubmit="return FormCheck();">
        <table width="100%" border="0" cellspacing="2" cellpadding="0" style="margin:10px 0 0 0;">
          <tr bgcolor="<%= color_bg_content %>"> 
            <td width="80" align="right" valign="top" style="font-size:12px;padding:6px 0 0 0;color:<%= color_font_system %>;">昵　　称：</td>
            <td><input name="username" type="text" size="50" maxlength="20" style="font-size:12px;"></td>
            <td width="140" align="center">&nbsp;</td>
          </tr>
          <tr bgcolor="<%= color_bg_content %>"> 
            <td align="right" valign="top" style="font-size:12px;padding:6px 0 0 0;color:<%= color_font_system %>;">留言标题：</td>
            <td><input name="msgtitle" type="text" size="50" maxlength="50" style="font-size:12px;"></td>
            <td width="140" align="center">&nbsp;</td>
          </tr>
          <tr bgcolor="<%= color_bg_content %>"> 
            <td align="right" valign="top" style="font-size:12px;padding:6px 0 0 0;color:<%= color_font_system %>;">留　　言：</td>
            <td style="padding:0 0 10px 0;"><textarea name="msgcontent" rows="6" style="width:100%;font-size:12px;"></textarea></td>
            <td width="140" align="center"><table width="100%" border="0" cellspacing="4" cellpadding="0">
                <tr align="center"> 
                  <td><img src="../images/1.gif" width="15" height="15" onClick="InsertFace(1);" style="cursor:hand;"></td>
                  <td><img src="../images/2.gif" width="15" height="15" onClick="InsertFace(2);" style="cursor:hand;"></td>
                  <td><img src="../images/3.gif" width="16" height="16" onClick="InsertFace(3);" style="cursor:hand;"></td>
                </tr>
                <tr align="center"> 
                  <td><img src="../images/4.gif" width="15" height="15" onClick="InsertFace(4);" style="cursor:hand;"></td>
                  <td><img src="../images/5.gif" width="16" height="16" onClick="InsertFace(5);" style="cursor:hand;"></td>
                  <td><img src="../images/6.gif" width="15" height="15" onClick="InsertFace(6);" style="cursor:hand;"></td>
                </tr>
                <tr align="center"> 
                  <td><img src="../images/7.gif" width="15" height="15" onClick="InsertFace(7);" style="cursor:hand;"></td>
                  <td><img src="../images/8.gif" width="15" height="15" onClick="InsertFace(8);" style="cursor:hand;"></td>
                  <td><img src="../images/9.gif" width="15" height="15" onClick="InsertFace(9);" style="cursor:hand;"></td>
                </tr>
                <tr align="center"> 
                  <td><img src="../images/10.gif" width="15" height="15" onClick="InsertFace(10);" style="cursor:hand;"></td>
                  <td><img src="../images/11.gif" width="15" height="15" onClick="InsertFace(11);" style="cursor:hand;"></td>
                  <td>&nbsp;</td>
                </tr>
              </table></td>
          </tr>
          <tr align="center" bgcolor="<%= color_bg_title %>"> 
            <td height="39" colspan="3"><input type="submit" name="Submit" value="我要留言" style="font-size:12px;">
              　　 
              <input type="reset" name="Submit2" value="重新填写" style="font-size:12px;"> </td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
<%  	
	end function
	
	G.MainOpen
	
	dim list,listi,page
	page=request.querystring("page")
	if not G.main.NumberTF(page) then page=1
	page=cint(page)
	list=G.ListMsg(page,1)
	if not IsEmpty(list) then
		for listi=0 to ubound(list,2)
			MsgTable list(0,listi),G.main.Encode(list(1,listi)),G.main.Encode(list(2,listi)),G.main.Encode(list(3,listi)),G.main.Encode(list(4,listi)),list(5,listi)
		next
	else
%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid <%= color_border %>;margin:4px 0 4px 0;">
		  <tr> 
			<td bgcolor="<%= color_bg_content %>" style="font-size:12px;padding:8px;">
				暂时没有留言！
			</td>
		  </tr>
		</table>
<% 
	end if
	
	ListPage G.MsgPageCount,G.MsgCount,page
	
	MsgPublishBox
	
	G.MainClose
%>