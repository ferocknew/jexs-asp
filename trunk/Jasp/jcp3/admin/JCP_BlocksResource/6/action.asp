<!--#include file="../../JCP_Shared/asp_head.asp" -->
<!--#include file="../../JCP_Shared/head.asp" -->
<script language="VBScript" src="../../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	doc.title="ģ���½����ڡ�������������������������������������������������������������";
-->
</script>
<base target="_self">
<!--#include file="../../JCP_Shared/body.asp" -->
<%
dim rs,blockname,blocktype,blockexplain,tableid,classfrom,subclass,classid,blockorderfield,blockorder,usedfields,blockelement,blockoutside,pgsize,blockfolder,blockeditfile,outlink,blockpageinfo,BlockAttribute,blockid
	blockname=request.Form("blockname")
	blocktype=request.Form("blocktype")
	blockexplain=request.Form("blockexplain")
	tableid=request.Form("TableList")
	classfrom=request.Form("classfrom")
	subclass=request.Form("SubClass")
	classid=request.Form("classid")
	blockorderfield=request.Form("orderitemlist")
	blockorder=request.Form("blockorder")
	usedfields=request.Form("usedfields")
	blockelement=request.Form("blockelement")
	blockoutside=request.Form("blockoutside")
	pgsize=request.Form("pagesize")
	blockfolder=request.Form("blockfolder")
	outlink=request.Form("outlink")
	blockpageinfo=request.Form("blockpageinfo")
	blocktype=J.NumberYN(blocktype)
	pgsize=J.NumberYN(pgsize)
	
	BlockAttribute=tableid & "{$|}" & _	
				  classfrom & "{$|}" & _	
				  subclass & "{$|}" & _	
				  classid & "{$|}" & _	
				  blockorderfield & "{$|}" & _	
				  blockorder & "{$|}" & _	
				  usedfields & "{$|}" & _	
				  blockelement & "{$|}" & _	
				  blockoutside & "{$|}" & _	
				  pgsize & "{$|}" & _	
				  outlink & "{$|}" & _
				  blockpageinfo	

if request.QueryString("action")="createblock" then
	set rs=J.Data.RsOpen("select * from JCP_BlockList where id=0",3)
	rs.addnew
	rs("blockname")=blockname
	rs("blocktype")=blocktype
	rs("blockexplain")=blockexplain
	rs("BlockAttribute")=BlockAttribute
	rs("blockfolder")=blockfolder
	rs("blockeditfile")="edit.asp"
	rs("blockmanage")=J.fso.FileT(server.MapPath("manage.asp"),1)
	blockid=rs("id")
	rs.update
	rs.close
	%>
  <table width="100%" height="60%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td align="center">
	  <script language="JavaScript">
		document.write('ģ����ӳɹ���<br><br>');
	  	if(window.dialogArguments){
			if(window.dialogArguments.parent.BlockAdd){
				document.write('[<a href="javascript:window.dialogArguments.parent.BlockAdd(<%= blockid %>,\'<%= blockname %>\');window.close();">����ģ��</a>] [<a href="edit.asp?blockid=<%= blockid %>">�����޸�</a>] [<a href="javascript:window.close();">�رմ���</a>]');
			}else{
				document.write('[<a href="edit.asp?blockid=<%= blockid %>">�����޸�</a>] [<a href="javascript:window.close();">�رմ���</a>]');
			}
		}else{
			document.write('[<a href="edit.asp?blockid=<%= blockid %>">�����޸�</a>] [<a href="javascript:window.close();">�رմ���</a>]');
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
		rs("blockmanage")=J.fso.FileT(server.MapPath("manage.asp"),1)
		blockid=rs("id")
		rs.update
	''''''''''''''''''''''''''''''''''''''''''''''
		'�ռ��Զ���������ı�Ҫ��Ϣ    ��ʼ
		J.Template.ModifyByBlock blockid,blocktype,J
		'����
	''''''''''''''''''''''''''''''''''''''''''''''
		%>
	  <table width="100%" height="60%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		  <td align="center">
		  <script language="JavaScript">
			document.write('ģ���޸ĳɹ���<br><br>');
			if(window.dialogArguments){
				if(window.dialogArguments.BlockAdd){
					document.write('[<a href="javascript:window.dialogArguments.BlockAdd(<%= blockid %>,\'<%= blockname %>\');window.close();">������ģ��</a>] [<a href="edit.asp?blockid=<%= blockid %>">�����޸�</a>] [<a href="javascript:window.close();">�رմ���</a>]');
				}else{
					document.write('[<a href="edit.asp?blockid=<%= blockid %>">�����޸�</a>] [<a href="javascript:window.close();">�رմ���</a>]');
				}
			}else{
				document.write('[<a href="edit.asp?blockid=<%= blockid %>">�����޸�</a>] [<a href="javascript:window.close();">�رմ���</a>]');
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