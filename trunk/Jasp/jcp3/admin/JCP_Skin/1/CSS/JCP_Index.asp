body{
	padding:2px 1px 2px 2px;
	background:<%= session("Color_Main") %> !important;
	overflow-y:hidden;
}

#JCP{
	padding:0;
	margin:0;
	width:100%;
	border-left:1px solid <%= session("Color_Dip") %>;
	border-top:1px solid <%= session("Color_Dip") %>;
	border-right:1px solid <%= session("Color_Fleet") %>;
	border-bottom:1px solid <%= session("Color_Fleet") %>;
}
#top{
	float:left;
	margin:-<%= session("Top_Height") %>px 0 0 0;
	padding:0;
	width:100%;
	height:<%= session("Top_Height") %>px;
	border-left:1px solid <%= session("Color_Fleet") %>;
	border-top:1px solid <%= session("Color_Fleet") %>;
	border-right:1px solid <%= session("Color_Dip") %>;
	border-bottom:1px solid <%= session("Color_Dip") %>;
}
#top_back{
	float:left;
	margin:0;
	width:100%;
	height:<%= session("Top_Height") %>px;
	border-left:1px solid <%= session("Color_Fleet") %>;
	border-top:1px solid <%= session("Color_Fleet") %>;
	border-right:1px solid <%= session("Color_Dip") %>;
	border-bottom:1px solid <%= session("Color_Dip") %>;
	background-color:#FFFFFF;
	filter: Alpha(Opacity=80, FinishOpacity=0, Style=1, StartX=0, StartY=0, FinishX=0, FinishY=30);
}
#top #logo{
	float:left;
	padding:8px;
}
#top h1{
	font-size:28px;
	font-family:ºÚÌå,Á¥Êé;
	color:<%= session("Color_SystemFont") %>;
	margin:0;
	padding:0;
}
#top .copyright{
	margin:0 0 0 4px;
	color:<%= session("Color_SystemFont") %>;
	padding:0;
}
#tool_button{
	float:right;
	margin:10px 6px 0 0;
}
#tool_button .button{
	height:43px;
	padding:0;
	margin:0 4px 0 0;
	padding:0;
	behavior:url('../JCP_Script/Onfocus.htc');
	cursor:hand;
}
#tool_button .button img{
	float:left;
	margin:3px;
}

#body{
	float:left;
	width:100%;
	padding:2px 2px 1px 2px;
	border-left:1px solid <%= session("Color_Fleet") %>;
	border-top:1px solid <%= session("Color_Fleet") %>;
	border-right:1px solid <%= session("Color_Dip") %>;
	border-bottom:1px solid <%= session("Color_Dip") %>;
}


#menus,#main{float:left;}
#main{margin:0;}
#menus_box{
	width:0;
	height:0;
	display:none;
}
#main_box{
	width:0;
	height:0;
	display:none;
	border-left:1px solid <%= session("Color_Dip") %>;
	border-top:1px solid <%= session("Color_Dip") %>;
	border-right:1px solid <%= session("Color_Fleet") %>;
	border-bottom:1px solid <%= session("Color_Fleet") %>;
}

#copyright{
	float:left;
	width:100%;
	height:20px;
	text-align:center;
	margin:0;
	padding:0;
	color:<%= session("Color_SystemFont") %>;
	border-left:1px solid <%= session("Color_Fleet") %>;
	border-top:1px solid <%= session("Color_Fleet") %>;
	border-right:1px solid <%= session("Color_Dip") %>;
	border-bottom:1px solid <%= session("Color_Dip") %>;
}
#copyright_back{
	float:left;
	background-color:#000000;
	width:100%;
	height:20px;
	margin:-20px 0 0 0;
	filter: Alpha(Opacity=0, FinishOpacity=30, Style=1, StartX=0, StartY=40, FinishX=0, FinishY=100);
}

#resizeBar{
	float:left;
	width:0;
	height:0;
	border-left:1px solid <%= session("Color_Fleet") %>;
	border-right:1px solid <%= session("Color_Fleet") %>;
	overflow:hidden;
	cursor:e-resize;
}
#DicLine{
	background-color:<%= session("Color_Dip") %>;
	filter:alpha(opacity=30);
}