<!--#include file="../../JCP_Shared/asp_head.asp" -->
<!--#include file="../../JCP_Shared/head.asp" -->
<script language="VBScript" src="../../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	doc.title="模块新建窗口　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
-->
</script>
<base target="_self">
<!--#include file="../../JCP_Shared/body.asp" -->
<%
dim rs,blockname,blocktype,blockexplain,blockcontent,blockfolder,BlockAttribute,blockid
	blockname=request.Form("blockname")
	blocktype=request.Form("blocktype")
	blockexplain=request.Form("blockexplain")
	blockcontent=request.Form("blockcontent")
	blockfolder=request.Form("blockfolder")
	blocktype=J.NumberYN(blocktype)
	
	BlockAttribute=blockcontent	

if request.QueryString("action")="createblock" then
	set rs=J.Data.RsOpen("select * from JCP_BlockList where id=0",3)
	rs.addnew
	rs("blockname")=blockname
	rs("blocktype")=blocktype
	rs("blockexplain")=blockexplain
	rs("BlockAttribute")=BlockAttribute
	rs("blockfolder")=blockfolder
	rs("blockeditfile")="edit.asp"
	rs("blockmanage")=""
	blockid=rs("id")
	rs.update
	rs.close
	
	'''''''''''''''''''''''''''
	J.fso.FolderN J.SiteRoot & J.ScriptPath
	J.fso.FileN J.SiteRoot & J.ScriptPath & "\" & blockid & ".js",BlockAttribute
	%>
  <table width="100%" height="60%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td align="center">
	  <script language="JavaScript">
		document.write('模块添加成功！<br><br>');
	  	if(window.dialogArguments){
			if(window.dialogArguments.parent.BlockAdd){
				document.write('[<a href="javascript:window.dialogArguments.parent.BlockAdd(<%= blockid %>,\'<%= blockname %>\');window.close();">插入模板</a>] [<a href="edit.asp?blockid=<%= blockid %>">重新修改</a>] [<a href="javascript:window.close();">关闭窗口</a>]');
			}else{
				document.write('[<a href="edit.asp?blockid=<%= blockid %>">重新修改</a>] [<a href="javascript:window.close();">关闭窗口</a>]');
			}
		}else{
			document.write('[<a href="edit.asp?blockid=<%= blockid %>">重新修改</a>] [<a href="javascript:window.close();">关闭窗口</a>]');
		}
	  </script>
	  </td>
    </tr>
  </table>
  <%  
elseif request.QueryString("action")="editblock" then
	blockid=J.NumberYN(request.QueryString("blockid"))
	set rs=J.Data.RsOpen("select * from JCP_BlockList where id=" & blockid,3)
	if not rs.eof then
		rs("blockname")=blockname
		rs("blocktype")=blocktype
		rs("blockexplain")=blockexplain
		rs("BlockAttribute")=BlockAttribute
		rs("blockfolder")=blockfolder
		rs("blockeditfile")="edit.asp"
		rs("blockmanage")=""
		blockid=rs("id")
		rs.update
	''''''''''''''''''''''''''''''''''''''''''''''
		'收集自动推送所需的必要信息    开始
		J.Template.ModifyByBlock blockid,blocktype,J
		'结束
	''''''''''''''''''''''''''''''''''''''''''''''
		'''''''''''''''''''''''''''
		J.fso.FolderN J.SiteRoot & J.ScriptPath
		J.fso.FileN J.SiteRoot & J.ScriptPath & "\" & blockid & ".js",BlockAttribute
		%>
	  <table width="100%" height="60%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		  <td align="center">
		  <script language="JavaScript">
			document.write('模块修改成功！<br><br>');
			if(window.dialogArguments){
				if(window.dialogArguments.BlockAdd){
					document.write('[<a href="javascript:window.dialogArguments.BlockAdd(<%= blockid %>,\'<%= blockname %>\');window.close();">更新至模板</a>] [<a href="edit.asp?blockid=<%= blockid %>">重新修改</a>] [<a href="javascript:window.close();">关闭窗口</a>]');
				}else{
					document.write('[<a href="edit.asp?blockid=<%= blockid %>">重新修改</a>] [<a href="javascript:window.close();">关闭窗口</a>]');
				}
			}else{
				document.write('[<a href="edit.asp?blockid=<%= blockid %>">重新修改</a>] [<a href="javascript:window.close();">关闭窗口</a>]');
			}
		  </script>
		  </td>
		</tr>
	  </table>
	  <%  
	end if
	rs.close
end if
%>
<!--#include file="../../JCP_Shared/foot.asp" -->
<% J.close %>