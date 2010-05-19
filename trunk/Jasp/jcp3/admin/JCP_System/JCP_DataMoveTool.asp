<!--#include file="../JCP_Shared/asp_head.asp" -->

<% 
dim curid,armid,armcount
if request.querystring("action")="movecheck" then
	curid=cint(request.querystring("curid"))
	armid=cint(request.querystring("armid"))
	dim curcount
	curcount=J.data.Exe("select count(ArticleID) from TempArticle where moveyn=false and ClassID=" & curid)(0)
	armcount=J.data.Exe("select count(id) from Article_3 where Item_946_class=" & armid)(0)
	response.write "<script>parent.document.getElementById('MoveRsCount').innerHTML='将有 " & curcount & " 条数据被牵移，目标库现有 " & armcount & " 条数据！　[<span style=""cursor:hand;"" onclick=""javascript:document.getElementById(\'MoveResult\').innerHTML=\'<font color=blue>步骤一</font>　数据牵移中…<br>\';document.getElementById(\'MoveFrame\').src=\'?action=movenow&curid=" & curid & "&armid=" & armid & "\';"">确定</span>]';</script>"
	response.end
elseif request.querystring("action")="movenow" then
	curid=cint(request.querystring("curid"))
	armid=cint(request.querystring("armid"))
	dim mrs,i
	set mrs=J.data.RsOpen("select * from TempArticle where moveyn=false and ClassID=" & curid,3)
	do while not mrs.eof
		dim trs
		set trs=J.data.ReRsOpen("select * from Article_3 where id=0","trs",3)
		trs.addnew
		trs("Item_914_text")=replace(mrs("Title"),"'","&#039;")
		trs("Item_946_class")=armid
		trs("Item_449_text")=mrs("Author")
		trs("Item_119_text")=replace(mrs("CopyFrom"),"'","&#039;")
		trs("Item_843_edit")=replace(mrs("Content"),"'","&#039;")
		trs("UpTime")=mrs("UpdateTime")
		trs("Userid")=1
		trs.update
		trs.close
		set trs=nothing
		mrs("moveyn")=true
		mrs.movenext
	loop
	mrs.close
	armcount=J.data.Exe("select count(id) from Article_3 where Item_946_class=" & armid)(0)
	response.write "<script>parent.document.getElementById('MoveResult').innerHTML+='<font color=blue>步骤二</font>　牵移完成，目标库现有 " & armcount & " 条数据！';</script>"
	response.end
end if
%>


<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_System.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<!--#include file="../JCP_Shared/body.asp" -->
<div class="app_title">数据牵移工具</div>
<% J.fso.FolderN server.MapPath("../../new_HI") %>
  <table width="607" border="0" cellspacing="8" cellpadding="0">
    <tr> 
      <td width="69">当前类别：</td>
      <td width="132"> <select name="curselect" id="curselect">
          <% 
	  dim srs
	  set srs=J.data.Exe("select distinct a.ClassID,ClassName from TempArticle a,TempArticleClass b where a.ClassID=b.ClassID order by a.ClassID")
	  do while not srs.eof
	  %>
          <option value="<%= srs(0) %>"><%= srs(1) %></option>
          <% 
	  	srs.movenext
	  loop
	  srs.close
	  %>
        </select></td>
      <td width="69">目标类别：</td>
      <td width="137">
	  <select name="armselect" id="armselect">
          <% 
	  set srs=J.data.Exe("select classid,classname from JCP_class")
	  do while not srs.eof
	  %>
          <option value="<%= srs(0) %>"><%= srs(1) %></option>
          <% 
	  	srs.movenext
	  loop
	  srs.close
	  %>
        </select></td>
      <td width="152"><input name="submit" type="button" class="system_button_00" value="执行牵移" onclick="document.getElementById('MoveRsCount').innerHTML='';document.getElementById('MoveResult').innerHTML='';document.getElementById('MoveFrame').src='?action=movecheck&curid=' + document.getElementById('curselect').value + '&armid=' + document.getElementById('armselect').value;"></td>
    </tr>
    <tr> 
      <td colspan="5" id="MoveRsCount"></td>
    </tr>
    <tr> 
      <td colspan="5" id="MoveResult"></td>
    </tr>
  </table>
  <div><iframe id="MoveFrame" name="MoveFrame" src="about:blank" width=0 height=0></iframe></div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>