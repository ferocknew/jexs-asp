<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<% 
dim rs
%>
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Admin.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" type="text/javascript">
<!--
	var doc=document;
	
	function Check(){
		if(BlankYn(doc.all.form1.adminname.value)){
			alert("�ʻ�����Ϊ�գ�");
			doc.all.form1.adminname.focus();
			doc.all.form1.adminname.select();
			return false;
		}
		if(BlankYn(doc.all.form1.adminpwd.value)){
			alert("��������Ϊ�գ�");
			doc.all.form1.adminpwd.focus();
			doc.all.form1.adminpwd.select();
			return false;
		}
		if(doc.all.form1.adminpwd.value!=doc.all.form1.adminpwdcheck.value){
			alert("��������Ŀ�����뱣��һ�£�");
			doc.all.form1.adminpwdcheck.focus();
			doc.all.form1.adminpwdcheck.select();
			return false;
		}
	}
	
	function AreaSelect(o){
		if(o.value==0){
			doc.all.form1.adminpurv.value=0;
			doc.all.form1.adminpurv.disabled=true;
		}else{
			doc.all.form1.adminpurv.disabled=false;
		}
	}
	
	function DelAdmin(id){
		if(confirm("��ȷ��Ҫɾ�����ʻ�����")) location="JCP_Admin_Action.asp?action=deladmin&actid=" + id;
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
<div class="app_title">�û�����</div>
  <div id="adminset"> 
    <form name="form1" method="post" action="JCP_Admin_Action.asp?action=addadmin" onSubmit="return Check();">
		<div class="item">
			<span class="label">�����ʻ���</span>
			<span class="cont"><input type="text" name="adminname" id="adminname"></span>
		</div>
		<div class="item">
			<span class="label">�ڡ����</span>
			<span class="cont"><input type="password" name="adminpwd" id="adminpwd"></span>
		</div>
		<div class="item">
			<span class="label">�ظ����</span>
			<span class="cont"><input type="password" name="adminpwdcheck" id="adminpwdcheck"></span>
		</div>
		<div class="item">
			<span class="label">ְ�ܷ�Χ��</span>
			<span class="cont">
				<input type="radio" name="adminarea" value="0" class="select" onclick="javascript:AreaSelect(this);"> ��������Ա
				<input name="adminarea" type="radio" class="select" value="1" onclick="javascript:AreaSelect(this);" checked> ȫ�ֹ���Ա 
				<input type="radio" name="adminarea" value="2" class="select" onclick="javascript:AreaSelect(this);"> �ֲ�����Ա 
			</span>
		</div>
		<div class="item">
			<span class="label">ְ��������</span>
			<span class="cont"><textarea name="adminexp" id="adminexp"></textarea></span>
		</div>
		<div class="item">
			<span class="label">�� �� �飺</span> 
			<span class="cont">
				<select name="adminpurv" id="adminpurv">
					<option value="0">��Ȩ��</option>
					<% 
					set rs=J.Data.Exe("select id,team_name from JCP_purviewteam order by id")
					do while not rs.eof
						response.write "<option value="""&rs("id")&""">"&rs("team_name")&"</option>"
						rs.movenext
					loop
					rs.close
					%>
				</select>
			</span>
		</div>
 		<div class="item">
			<span class="buttons">
				<input type="submit" id="add" value=" �� �� �� �� " class="system_button_00">
			</span> 
		</div>
   </form>
  </div>
<div id="adminlist">
	<div class="app_title">�����û�</div>
	<div class="admintype"><font face="webdings">4</font> ��������Ա</div>
	<% 
	set rs=J.Data.RsOpen("select * from JCP_admin where admintype=0 order by adminname",1)
	do while not rs.eof
		if rs.recordcount=1 then
			response.write "<div class=""adminitem"">�� <a href=""JCP_Admin_Edit.asp?actid="&rs("adminid")&""">"&rs("adminname")&"</a></div>"
		else
			response.write "<div class=""adminitem"">�� <a href=""JCP_Admin_Edit.asp?actid="&rs("adminid")&""">"&rs("adminname")&"</a> <a href=""javascript:DelAdmin("&rs("adminid")&")""><font face=""webdings"">r</font></a></div>"
		end if
		rs.movenext
	loop
	rs.close
	set rs=J.Data.Exe("select JCP_admin.*,team_name from JCP_admin left join JCP_purviewteam on JCP_admin.adminpurv=JCP_purviewteam.id where admintype>0 order by adminpurv desc")
	dim curpurv:curpurv=-1
	dim purvname,area
	do while not rs.eof
		if rs("adminpurv")>0 then purvname=rs("team_name") else purvname="��Ȩ��"
		if rs("admintype")=1 then area="��" else area="��"
		if curpurv<>rs("adminpurv") then
			response.write "<div class=""admintype""><font face=""webdings"">4</font> "&purvname&"</div>"
			curpurv=rs("adminpurv")
		end if
		response.write "<div class=""adminitem"">�� <a href=""JCP_Admin_Edit.asp?actid="&rs("adminid")&""">"&rs("adminname")&"</a> "&area&" <a href=""javascript:DelAdmin("&rs("adminid")&")""><font face=""webdings"">r</font></a></div>"
		rs.movenext
	loop
	rs.close
	%>
</div>
<div id="exp">
	�� ȫ�ֹ���Ա���ܿ�����ͬȨ�������оֲ�����Ա���Լ��Ĳ�������<br>
	�� �ֲ�����Ա���������Լ��Ĳ�������
</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>