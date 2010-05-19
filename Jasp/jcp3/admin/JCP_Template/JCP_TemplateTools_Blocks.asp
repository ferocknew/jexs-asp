<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Templates.css" rel="stylesheet" type="text/css">
<style>
	body{
		overflow-x:hidden;
		padding:0;
	}
</style>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
	function mouseovering(o){
		o.className="BlocksList moveover";
	}
	function mouseouting(o){
		o.className="BlocksList";
	}
	function ItemExp(strs){
		parent.ToolExpDisplay(strs);
	}
	
	function BlockCreate(createpath){
		var arr=ModelWin(createpath,100,100);
	}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
<% 
dim rs
set rs=J.Data.Exe("select id,blockname,blockexplain,blockfolder,mainfile from JCP_Blocks order by id desc")
if rs.eof then
	response.write "<span>本站暂无模块源！</span>"
else
	do while not rs.eof
		response.write "<span class=""BlocksList"" title="""&rs("blockname")&""" onMouseOver=""mouseovering(this);ItemExp('"&rs("blockexplain")&"');"" onMouseOut=""mouseouting(this);ItemExp();"" onDblClick=""BlockCreate('"&rs("blockfolder")&"/"&rs("mainfile")&"?src="&rs("blockfolder")&"');""><font face=""webdings"">\</font> "&rs("blockname")&"</span>"
		rs.movenext
	loop
end if
rs.close
%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>