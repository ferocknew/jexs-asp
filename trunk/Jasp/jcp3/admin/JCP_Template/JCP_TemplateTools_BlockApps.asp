<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Templates.css" rel="stylesheet" type="text/css">
<style>
	body{
		overflow-x:hidden;
		padding:0;
	}
</style>
<script language="JavaScript">
	function mouseovering(o){
		o.className="BlocksList moveover";
	}
	function mouseouting(o){
		o.className="BlocksList";
	}
	function BlockAdd(id,exps){
		parent.BlockAdd(id,exps);
	}
	function ItemExp(strs){
		parent.ToolExpDisplay(strs);
	}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
<% 
dim rs,curtype
set rs=J.Data.Exe("select id,blockname,blocktype,blockexplain from JCP_BlockList order by blocktype,id desc")
if rs.eof then
	response.write "<span>本站暂无应用模块！</span>"
else
	curtype=-1
	do while not rs.eof
		if curtype<>rs("blocktype") then
			curtype=rs("blocktype")
			response.write "<span class=""BlockTypeName""><font face=""webdings"">4</font>"& J.Block(curtype) & "</span>"
		end if
		response.write "<span class=""BlocksList"" title="""&rs("blockexplain")&""" onMouseOver=""mouseovering(this);ItemExp('"&rs("blockexplain")&"');"" onMouseOut=""mouseouting(this);ItemExp();"" onDblClick=""BlockAdd("&rs("id")&",'"&rs("blockname")&"');""><font face=""webdings"">\</font> "&rs("blockname")&"</span>"
		rs.movenext
	loop
end if
rs.close
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>