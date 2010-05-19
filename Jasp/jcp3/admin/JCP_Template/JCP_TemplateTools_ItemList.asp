<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Templates.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
	function ItemExp(strs){
		parent.ToolExpDisplay(strs);
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<span id="div" class="templatetools_item" onMouseOver="ItemExp('插入Div标签');" onMouseOut="ItemExp();" onClick="parent.CreateElement('div');">div</span>
	<span id="span" class="templatetools_item" onMouseOver="ItemExp('插入Span标签');" onMouseOut="ItemExp();" onClick="parent.CreateElement('span');">span</span>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>