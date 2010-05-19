<!--#include file="../../JCP_Search/Inc/Class_Search.asp" -->
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
<!--#include file="../JCP_Shared/body.asp" -->

<% 
if request.querystring("action")="save" then
	S.MainOpen
	S.SystemSet request.form("csssheet"),_
				request.form("color_keyword"),_
				request.form("pagename"),_
				request.form("pgsize"),_
				request.form("searchshowsize"),_
				request.form("searchdatabase"),_
				request.form("searchfilefolder"),_
				request.form("searchfileext")
	S.MainClose
	response.write "<script>alert(""新的配置保存成功！"");location=""JCP_SystemSet.asp""</script>"
	response.end
end if
%>

	<div class="app_title">界面设置</div>
	  <form name="form1" method="post" action="?action=save" style="float:left;maring:0;padding:0;">
	  <fieldset style="margin:10px 0 0 0;"><legend>基本配置</legend>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>调用文件：</span>
			<span><input type="text" name="pagename" id="pagename"  value="<%= pagename %>"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>系统主库：</span>
			<span><input type="text" name="searchdatabase" id="searchdatabase" value="<%= "../../" & J.ManageFolder & "/" & J.DataPath & "/" & J.DataName %>" readonly style="background-color:#EEEEEE;"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>生成路径：</span>
			<span><input type="text" name="searchfilefolder" id="searchfilefolder" value="<%= "../../" & J.WebPath %>" readonly style="background-color:#EEEEEE;"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>文件格式：</span>
			<span><input type="text" name="searchfileext" id="searchfileext" value="<%= J.FileExt %>" readonly style="background-color:#EEEEEE;"></span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>每页显示：</span>
			<span><input name="pgsize" type="text" id="pgsize" value="<%= pgsize %>" size="4" onblur="IntCheck(this.value,this)"> 条搜索结果</span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>显示字数：</span>
			<span><input name="searchshowsize" type="text" id="searchshowsize" value="<%= searchshowsize %>" size="4" onblur="IntCheck(this.value,this)">（注意：搜索结果中关键字前、后各显示的字数）</span>
		</div>
	  </fieldset>
	  <fieldset style="margin:10px 0 0 0;"><legend>样式设置</legend>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>主样式表：</span>
			<span><textarea  name="csssheet" rows="8" id="csssheet" style="width:100%"><%= replace(replace(csssheet,"};","}" & chr(13) & chr(10)),"""""","""") %></textarea>
			（系统样式名称有：#JCP_Search_Result .ResultItem .Link .SystemID .ID .UpTime .Info_1 .Info_2 ...）
			</span>
		</div>
 		<div style="width:100%;padding:4px 20px 4px 20px;">
			<span>关 键 字：</span>
			<span><input name="color_keyword" type="text" id="color_keyword" onclick="setcolor(this.id);"  value="<%= color_keyword %>" size="6" readonly style="background-color:<%= color_keyword %>">（注意：搜索结果中的关键字颜色）</span>
		</div>
	  </fieldset>
 		<div style="width:100%;text-align:center;margin:10px 0 0 0;">
			<input type="submit" name="Submit" value="保存设置">　　
			<input type="reset" name="Submit2" value="重新修改">
		</div>
	  </form>
  <!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>