<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_System.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<!--#include file="../JCP_Shared/body.asp" -->
<div class="app_title">系统配置</div>
<form name="form1" method="post" action="JCP_System_Action.asp?action=setsystem">
<div id="SetBody"> 
	<fieldset>
		<legend>网站配置</legend>
			<div class="setItem">
				<span class="label">网站名称：</span>
				<span class="content"><input type="text" id="sitename" name="sitename" value="<%= session("SiteName") %>" onblur="BlankCheck(this.value,this)"></span>
			</div>
			<div class="setItem">
				<span class="label">网站地址：</span>
				<span class="content"><input type="text" id="siteurl" name="siteurl" value="<%= session("SiteURL") %>" class="newWidth" onblur="BlankCheck(this.value,this)">（例如 http://www.sjrx.com）</span>
			</div>
			<div class="setItem">
				<span class="label">系统名称：</span>
				<span class="content"><input type="text" id="sitesystemname" name="sitesystemname" value="<%= session("SiteSystemName") %>" class="newWidth" onblur="BlankCheck(this.value,this)"></span>
			</div>
			<div class="setItem">
				<span class="label">系统Logo：</span>
				<span class="content"><input type="text" id="systemlogo" name="systemlogo" value="<%= session("SystemLogo") %>" ondblclick="this.select();" class="newWidth"></span>
				<span class="button"><input type="button" value="游览图片" onclick="javascript:FindUploadFile('systemlogo')" class="system_button_00"></span>
			</div>
			<div class="setItem">
				<span class="label">网站版权：</span>
				<span class="content"><input type="text" id="copyright" name="copyright" value="<%= session("CopyRight") %>" class="newWidth"></span>
			</div>
	</fieldset>
	<fieldset>
		<legend>页面配置</legend>
			<div class="setItem">
				<span class="label">上传文件夹：</span>
				<span class="content"><input type="text" id="uploadpath" name="uploadpath" value="<%= session("UploadPath") %>" onblur="BlankCheck(this.value,this);IllegalCheck(this.value,this,null)"></span>
			</div>
			<div class="setItem">
				<span class="label">静态页面文件夹：</span>
				<span class="content"><input type="text" id="webpath" name="webpath" value="<%= session("WebPath") %>" onblur="BlankCheck(this.value,this);IllegalCheck(this.value,this,null)"></span>
			</div>
			<div class="setItem">
				<span class="label">脚本文件夹：</span>
				<span class="content"><input type="text" id="scriptpath" name="scriptpath" value="<%= session("ScriptPath") %>" onblur="BlankCheck(this.value,this);IllegalCheck(this.value,this,null)"></span>
			</div>
			<div class="setItem">
				<span class="label">样式文件夹：</span>
				<span class="content"><input type="text" id="webcsspath" name="webcsspath" value="<%= session("WebCssPath") %>" onblur="BlankCheck(this.value,this);IllegalCheck(this.value,this,null)"></span>
			</div>
			<div class="setItem">
				<span class="label">文件后缀：</span>
				<span class="content"><input type="text" id="fileext" name="fileext" value="<%= session("FileExt") %>" onblur="BlankCheck(this.value,this);IllegalCheck(this.value,this,null)">（可选：.html .htm ...）</span>
			</div>
			<div class="setItem">
				<span class="label">首页文件名：</span>
				<span class="content"><input type="text" id="indexname" name="indexname" value="<%= session("IndexName") %>" onblur="BlankCheck(this.value,this);IllegalCheck(this.value,this,null)">（可选：index default ...）</span>
			</div>
	</fieldset>
	<fieldset>
		<legend>数据配置</legend>
			<div class="setItem">
				<span class="label">数据库文件夹：</span>
				<span class="content"><input type="text" id="datapath" name="datapath" value="<%= session("DataPath") %>" onblur="BlankCheck(this.value,this);IllegalCheck(this.value,this,null)"></span>
			</div>
			<div class="setItem">
				<span class="label">数据库名：</span>
				<span class="content"><input type="text" id="dataname" name="dataname" value="<%= session("DataName") %>" onblur="BlankCheck(this.value,this);IllegalCheck(this.value,this,null)"></span>
			</div>
	</fieldset>
	<fieldset>
		<legend>颜色配置</legend>
			<div class="leftbox">
				<div class="setItem">
					<span class="label">系统主色调：</span>
					<span class="content"><input type="text" id="colormain" name="colormain" value="<%= session("Color_Main") %>" style="color:<%= session("Color_Main") %>;background:<%= session("Color_Main") %>;cursor:hand;" class="newWidth3" onclick="javascript:setcolor('colormain');this.style.color=this.value;colorDisplay()" onblur="BlankCheck(this.value,this)"></span>
				</div>
				<div class="setItem">
					<span class="label">系统背景色：</span>
					<span class="content"><input type="text" id="colorback" name="colorback" value="<%= session("Color_Back") %>" style="color:<%= session("Color_Back") %>;background:<%= session("Color_Back") %>;cursor:hand;" class="newWidth3" onclick="javascript:setcolor('colorback');this.style.color=this.value;colorDisplay()" onblur="BlankCheck(this.value,this)"></span>
				</div>
				<div class="setItem">
					<span class="label">系统字体：</span>
					<span class="content"><input type="text" id="systemfont" name="systemfont" value="<%= session("Color_SystemFont") %>" style="color:<%= session("Color_SystemFont") %>;background:<%= session("Color_SystemFont") %>;cursor:hand;" class="newWidth3" onclick="javascript:setcolor('systemfont');this.style.color=this.value;colorDisplay()" onblur="BlankCheck(this.value,this)"></span>
				</div>
				<div class="setItem">
					<span class="label">程序字体：</span>
					<span class="content"><input type="text" id="mainfont" name="mainfont" value="<%= session("Color_MainFont") %>" style="color:<%= session("Color_MainFont") %>;background:<%= session("Color_MainFont") %>;cursor:hand;" class="newWidth3" onclick="javascript:setcolor('mainfont');this.style.color=this.value;colorDisplay()" onblur="BlankCheck(this.value,this)"></span>
				</div>
				<div class="setItem">
					<span class="label">突出字体：</span>
					<span class="content"><input type="text" id="lightfont" name="lightfont" value="<%= session("Color_LightFont") %>" style="color:<%= session("Color_LightFont") %>;background:<%= session("Color_LightFont") %>;cursor:hand;" class="newWidth3" onclick="javascript:setcolor('lightfont');this.style.color=this.value;colorDisplay()" onblur="BlankCheck(this.value,this)"></span>
				</div>
				<div class="setItem">
					<span class="label">边框阴影：</span>
					<span class="content"><input type="text" id="colordip" name="colordip" value="<%= session("Color_Dip") %>" style="color:<%= session("Color_Dip") %>;background:<%= session("Color_Dip") %>;cursor:hand;" class="newWidth3" onclick="javascript:setcolor('colordip');this.style.color=this.value;colorDisplay()" onblur="BlankCheck(this.value,this)"></span>
				</div>
				<div class="setItem">
					<span class="label">边框高光：</span>
					<span class="content"><input type="text" id="colorfleet" name="colorfleet" value="<%= session("Color_Fleet") %>" style="color:<%= session("Color_Fleet") %>;background:<%= session("Color_Fleet") %>;cursor:hand;" class="newWidth3" onclick="javascript:setcolor('colorfleet');this.style.color=this.value;colorDisplay()" onblur="BlankCheck(this.value,this)"></span>
				</div>
			</div>
			<div class="rightbox">
				<div id="dispbox">
					<div id="mainbox">
						<div id="topbox">晋唐网站管理系统</div>
						<div id="bottombox">
							<div id="leftbox">导航菜单<br>系统文字</div>
							<div id="resizebox"></div>
							<div id="bodybox">
								<div id="mainfontbox">主体文字</div>
								<div id="lightfontbox">突出文字</div>
							</div>
						</div>
					</div>
				</div>
<script language=javascript>
	var doc=document;
	function colorDisplay(){
		doc.getElementById("dispbox").style.background=doc.getElementById("colormain").value;
		doc.getElementById("mainbox").style.borderColor=doc.getElementById("colordip").value + " " + doc.getElementById("colorfleet").value + " " + doc.getElementById("colorfleet").value + " " + doc.getElementById("colordip").value;
		doc.getElementById("bottombox").style.borderColor=doc.getElementById("colorfleet").value + " " + doc.getElementById("colordip").value + " " + doc.getElementById("colordip").value + " " + doc.getElementById("colorfleet").value;
		doc.getElementById("topbox").style.borderColor=doc.getElementById("colorfleet").value + " " + doc.getElementById("colordip").value + " " + doc.getElementById("colordip").value + " " + doc.getElementById("colorfleet").value;
		doc.getElementById("topbox").style.color=doc.getElementById("systemfont").value;
		doc.getElementById("leftbox").style.color=doc.getElementById("systemfont").value;
		doc.getElementById("resizebox").style.borderColor=doc.getElementById("colorfleet").value + " " + doc.getElementById("colordip").value + " " + doc.getElementById("colordip").value + " " + doc.getElementById("colorfleet").value;
		doc.getElementById("resizebox").style.background=doc.getElementById("colordip").value;
		doc.getElementById("bodybox").style.borderColor=doc.getElementById("colordip").value + " " + doc.getElementById("colorfleet").value + " " + doc.getElementById("colorfleet").value + " " + doc.getElementById("colordip").value;
		doc.getElementById("bodybox").style.background=doc.getElementById("colorback").value;
		doc.getElementById("mainfontbox").style.color=doc.getElementById("mainfont").value;
		doc.getElementById("lightfontbox").style.color=doc.getElementById("lightfont").value;
	}
	function resetDisplay(colors){
		if(!colors) colors="#E4E7E9,#F2F3F4,#000000,#333333,#FF0000,#737373,#FFFFFF";
		var paramcolor=colors.split(",");
		doc.getElementById("colormain").style.color=doc.getElementById("colormain").style.background=doc.getElementById("colormain").value=paramcolor[0];
		doc.getElementById("colorback").style.color=doc.getElementById("colorback").style.background=doc.getElementById("colorback").value=paramcolor[1];
		doc.getElementById("systemfont").style.color=doc.getElementById("systemfont").style.background=doc.getElementById("systemfont").value=paramcolor[2];
		doc.getElementById("mainfont").style.color=doc.getElementById("mainfont").style.background=doc.getElementById("mainfont").value=paramcolor[3];
		doc.getElementById("lightfont").style.color=doc.getElementById("lightfont").style.background=doc.getElementById("lightfont").value=paramcolor[4];
		doc.getElementById("colordip").style.color=doc.getElementById("colordip").style.background=doc.getElementById("colordip").value=paramcolor[5];
		doc.getElementById("colorfleet").style.color=doc.getElementById("colorfleet").style.background=doc.getElementById("colorfleet").value=paramcolor[6];
		colorDisplay();
	}
</script>
				<script language=javascript>colorDisplay();</script>
			</div>
			<div class="colorbutton">
				<span style="background-color:#FFAAAA;" onClick="resetDisplay('#FFAAAA,#FFE3E3,#8D5D5D,#8D5D5D,#3CC43C,#CC8888,#FFDDDD');"></span>
				<span style="background-color:#FFFFAA;" onClick="resetDisplay('#FFFFAA,#FFFFDD,#C7C717,#C7C717,#72C43C,#DDDD93,#FFFFEB');"></span>
				<span style="background-color:#AAFFAA;" onClick="resetDisplay('#AAFFAA,#E8FFE8,#5EA25E,#5EA25E,#BB7444,#88CC88,#E8FFE8');"></span>
				<span style="background-color:#AAAAFF;" onClick="resetDisplay('#AAAAFF,#EEEEFF,#666699,#666699,#C43CC4,#8888CC,#E3E3FF');"></span>
				<span style="background-color:#FFAAFF;" onClick="resetDisplay('#FFAAFF,#FFE8FF,#885B88,#885B88,#3CC43C,#EE9FEE,#FFE3FF');"></span>
				
				<span style="background-color:#EBA948;" onClick="resetDisplay('#EBA948,#FAE8CE,#6E4F22,#6E4F22,#4822DD,#BC873A,#F4D19D');"></span>
				<span style="background-color:#E6E61A;" onClick="resetDisplay('#E6E61A,#F8F8C2,#7B7B0E,#7B7B0E,#33CC33,#B8B815,#F3F394');"></span>
				<span style="background-color:#6BE61A;" onClick="resetDisplay('#6BE61A,#D8F8C2,#397B0E,#397B0E,#D52B2B,#5DC717,#B0F285');"></span>
				<span style="background-color:#22DD92;" onClick="resetDisplay('#22DD92,#D3F8E9,#106744,#106744,#C48D3C,#1BB175,#98EFCC');"></span>
				<span style="background-color:#226DDD;" onClick="resetDisplay('#226DDD,#C4D8F6,#0B244A,#0B244A,#C43C3C,#1951A6,#89B1ED');"></span>
				
				<span style="background-color:#C211EE;" onClick="resetDisplay('#C211EE,#EFC0FA,#4E075F,#4E075F,#4DB34D,#9B0EBE,#DA70F5');"></span>
				<span style="background-color:#F4607E;" onClick="resetDisplay('#F4607E,#FCD5DD,#411A22,#411A22,#3C3CC4,#D3536D,#F8A0B2');"></span>
				<span style="background-color:#DD2222;" onClick="resetDisplay('#DD2222,#F6C4C4,#2C0707,#2C0707,#44BBBB,#A21919,#EB7A7A');"></span>
				<span style="background-color:#AAAA88;" onClick="resetDisplay('');"></span>
				<span style="background-color:#88AA88;" onClick="resetDisplay('');"></span>
				
				<span style="background-color:#44AAAA;" onClick="resetDisplay('');"></span>
				<span style="background-color:#4444AA;" onClick="resetDisplay('');"></span>
				<span style="background-color:#AA44AA;" onClick="resetDisplay('');"></span>
				<span style="background-color:#AAAA44;" onClick="resetDisplay('');"></span>
				<span style="background-color:#44AA44;" onClick="resetDisplay('');"></span>
				
				<span style="background-color:#00AAAA;" onClick="resetDisplay('');"></span>
				<span style="background-color:#0000AA;" onClick="resetDisplay('');"></span>
				<span style="background-color:#AA00AA;" onClick="resetDisplay('');"></span>
				<span style="background-color:#AAAA00;" onClick="resetDisplay('');"></span>
				<span style="background-color:#00AA00;" onClick="resetDisplay('');"></span>
				<div><input type="button" value="恢复标配" onclick="resetDisplay()" class="system_button_00"></div>
			</div>
	</fieldset>
	<fieldset>
		<legend>框架配置</legend>
			<div class="setItem">
				<span class="label">头部框架高度：</span>
				<span class="content"><input type="text" id="topheight" name="topheight" value="<%= session("Top_Height") %>" class="newWidth2" onblur="IntCheck(this.value,this)"> px</span>
			</div>
			<div class="setItem">
				<span class="label">左侧导航宽度：</span>
				<span class="content"><input type="text" id="menuwidth" name="menuwidth" value="<%= session("Menu_Width") %>" class="newWidth2" onblur="IntCheck(this.value,this)"> px</span>
			</div>
	</fieldset>
</div>
<div class="buttons">
	<input type="submit" value="保存/应用 修改配置" class="system_button_00">
</div>
</form>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>