<html>
<head>
<title><%= Session("SiteSystemName") & "   " & J.Version & " &copy; " & Session("SiteName") & " " & J.CopyRight %></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Normal.asp" rel="stylesheet" type="text/css">
<script language="JavaScript">

function Button(_name,_type,_width,_height,_top,_left,_value,_fontstyle){
	var buttonString="";
	if(_type==0){	//普通按钮
		buttonString = '<span id="' + _name + '" style="width:' + _width.toString() + 'px;margin-top:' + _top.toString() + 'px;margin-left:' + _left.toString() + 'px;cursor:hand;">' + 
					   '	<span style="float:left;">' +
					   '		<span style="width:100%;height:7px;">' +
					   '			<span style="float:left;"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/Button_Round_topleft.gif"></span>' +
					   '			<span style="float:left;width:' + (_width-14).toString() + 'px;height:7px;background-color:#FFFFFF;overflow:hidden;"></span>' +
					   '			<span style="float:right;"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/Button_Round_topright.gif"></span>' +
					   '		</span>' +
					   '		<span style="width:100%;height:' + (_height-14).toString() + 'px;background-color:#FFFFFF;"></span>' +
					   '		<span style="width:100%;height:7px;">' +
					   '			<span style="float:left;"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/Button_Round_bottomleft.gif"></span>' +
					   '			<span style="float:left;width:' + (_width-14).toString() + 'px;height:7px;background-color:#FFFFFF;overflow:hidden;"></span>' +
					   '			<span style="float:right;"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/Button_Round_bottomright.gif"></span>' +
					   '		</span>' +
					   '	</span>' +
					   '	<span style="float:left;width:100%;height:' + _height.toString() + 'px;margin-top:-' + _height.toString() + 'px;text-align:center;line-height:' + _height.toString() + 'px;' + _fontstyle + '" color="<%= session("Color_SystemFont") %>">' + _value + '</span>' +
					   '</span>';
	}else if(_type==102){	//左侧菜单下方按钮 文字在上，背景在下
		buttonString = '<span id="' + _name + '"  style="width:' + _width.toString() + 'px;margin-top:' + _top.toString() + 'px;margin-left:' + _left.toString() + 'px;cursor:hand;">' + 
					   '	<span style="float:left;width:100%;filter: Alpha(Opacity=10, FinishOpacity=50, Style=1, StartX=0, StartY=50, FinishX=0, FinishY=100);">' +
					   '		<span style="width:100%;height:' + (_height-7).toString() + 'px;background-color:#FFFFFF;border-left:1px solid #000000;border-right:1px solid #000000;"></span>' +
					   '		<span style="width:100%;height:7px;">' +
					   '			<span style="float:left;"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/Button_Round_bottomleft.gif"></span>' +
					   '			<span style="float:left;width:' + (_width-14).toString() + 'px;height:7px;background-color:#FFFFFF;overflow:hidden;border-bottom:1px solid #000000;"></span>' +
					   '			<span style="float:right;"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/Button_Round_bottomright.gif"></span>' +
					   '		</span>' +
					   '	</span>' +
					   '	<span style="float:left;width:100%;height:' + _height.toString() + 'px;margin-top:-' + _height.toString() + 'px;"><table style="width:100%;height:100%;"><tr><td style="width:100%;height:100%;text-align:center;color:<%= session("Color_SystemFont") %>;' + _fontstyle + '">' + _value + '</td></tr></table></span>' +
					   '</span>';
	}else if(_type==101){	//左侧菜单下方按钮 文字在下，背景在上
		buttonString = '<span id="' + _name + '"  style="width:' + _width.toString() + 'px;margin-top:' + _top.toString() + 'px;margin-left:' + _left.toString() + 'px;cursor:hand;">' + 
					   '	<span style="float:left;width:100%;height:' + _height.toString() + 'px;"><table style="width:100%;height:100%;"><tr><td style="width:100%;height:100%;text-align:center;color:<%= session("Color_SystemFont") %>;' + _fontstyle + '">' + _value + '</td></tr></table></span>' +
					   '	<span style="float:left;width:100%;filter: Alpha(Opacity=60, FinishOpacity=10, Style=1, StartX=0, StartY=0, FinishX=0, FinishY=50);margin-top:-' + _height.toString() + 'px;">' +
					   '		<span style="width:100%;height:' + (_height-7).toString() + 'px;background-color:#FFFFFF;border-left:1px solid #000000;border-right:1px solid #000000;"></span>' +
					   '		<span style="width:100%;height:7px;">' +
					   '			<span style="float:left;"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/Button_Round_bottomleft.gif"></span>' +
					   '			<span style="float:left;width:' + (_width-14).toString() + 'px;height:7px;background-color:#FFFFFF;overflow:hidden;border-bottom:1px solid #000000;"></span>' +
					   '			<span style="float:right;"><img src="<%= J.ManageUrlRoot %>JCP_Skin/<%= Session("SystemSkin") %>/images/Button_Round_bottomright.gif"></span>' +
					   '		</span>' +
					   '	</span>' +
					   '</span>';
	}
	
	document.write(buttonString);
}

function FullUrl2RelUrl(_url){			//地址修正,绝对地址 转 相对地址
	_url=_url.replace(/\%20/gi," ")
			 .replace(/<%= replace("http://" & J.Host & J.ManageUrlRoot ,"/","\/") %>/gi,"..\/")
			 .replace(/<%= replace("http://" & J.Host & J.SiteUrlRoot ,"/","\/") %>/gi,"..\/..\/");
	return _url;
}

function Page_Loaded(){
	if(document.all.Loading){document.all.Loading.style.display="none";}
	if(document.all.JCP_body){document.all.JCP_body.style.display="block";}
}
</script>
