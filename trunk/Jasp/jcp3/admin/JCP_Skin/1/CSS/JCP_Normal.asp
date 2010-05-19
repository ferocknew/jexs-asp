body{
	padding:10px;
	margin:0;
	background:<%= session("Color_Back") %>;
	cursor:url('../JCP_Skin/<%= session("SystemSkin") %>/images/mouse.ani');
	scrollbar-3dlight-color: <%= session("Color_Main") %>;
	scrollbar-darkshadow-color: <%= session("Color_Main") %>;
	scrollbar-highlight-color: <%=session("Color_Fleet") %>;
	scrollbar-shadow-color: <%= session("Color_Dip") %>;
	scrollbar-face-color: <%= session("Color_Main") %>;
	SCROLLBAR-ARROW-COLOR: <%= session("Color_Dip") %>; 
	scrollbar-track-color: <%=session("Color_Fleet") %>;
}

#JCP_body{
	display:none;
}

body,td,select,textarea,input,span,div{
	word-break:break-all;
	font-size:12px;
	color: <%= session("Color_MainFont") %>;
	align:absmiddle;
}
.select{
	border:0;
	behavior:url('../JCP_Script/Onfocus.htc');
}

a {
	color: <%= session("Color_MainFont") %>;
	text-decoration: none;
	behavior:url('../JCP_Script/Onfocus.htc');
}

input,textarea{
	border-left:1px solid <%= session("Color_Dip") %>;
	border-top:1px solid <%= session("Color_Dip") %>;
	border-right:1px solid <%= session("Color_Dip") %>;
	border-bottom:1px solid <%= session("Color_Dip") %>;
	font-size:12px;
}
fieldset{
	border:3px double <%= session("Color_Dip") %>;
	font-size:12px;
	padding:0 10px 4px 10px;
}
legend{
	color: <%= session("Color_MainFont") %>;
	font-weight:bold;
}

.system_button_00{
	background-color:<%= session("Color_Main") %>;
	color:<%= session("Color_SystemFont") %>;
	padding-top:1px;
	height:18px;
}

.fleft{float:left;}
.fright{float:right;}
.Tleft{text-align:left;}
.Tcenter{text-align:center;}
.Tright{text-align:right;}

.borderon {
	font-size: 12px;
	background-color: <%= session("Color_Main") %>;
	border-color: <%=session("Color_Fleet")&" "&session("Color_Dip")&" "&session("Color_Dip")&" "&session("Color_Fleet") %>;
	border-style: solid;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
}

.Loading{
	clear:both;
	width:100%;
	text-align:center;
	height:80px;
	padding:20px 0 0 0;
}

#pagetime{
	width:100%;
	text-align:right;
	line-height:200%;
}

//右键菜单
.div1 { border-top:buttonface 1px solid;border-left:buttonface 1px solid;border-bottom:windowframe 1px solid;border-right:windowframe 1px solid;}
.div2 { border-top:window 1px solid;border-left:window 1px solid;border-bottom:buttonshadow 1px solid;border-right:buttonshadow 1px solid;}
.MouseOver {background-color:<%= session("Color_Fleet") %>;color:<%= session("Color_Dip") %>;font-size: 12px;cursor:hand;}
.list_MouseOver {background-color:highlight;color:highlighttext;font-size: 12px;cursor:hand;}
.MouseOut {color:<%= session("Color_SystemFont") %>;font-size: 12px;}


.app_title{
	float:left;
	width:100%;
	margin:0 0 4px 0;
	padding:6px 10px 2px 10px;
	background:<%= session("Color_Main") %>;
	border-bottom:3px double <%= session("Color_Dip") %>;
	color:<%= session("Color_SystemFont") %>;
	filter: Alpha(Opacity=10, FinishOpacity=90, Style=1, StartX=0, StartY=0, FinishX=0, FinishY=30);
}

.manage_button{
	float:left;
	text-align:center;
	width:80px;
	margin:0 8px 0 0;
	padding:5px 10px 2px 10px;
	border:1px solid <%= session("Color_Dip") %>;
	background-color:<%= session("Color_Main") %>;
	color:<%= session("Color_SystemFont") %>;
}
.manage_button a{
	color:<%= session("Color_SystemFont") %>;
}
.manage_button_cur{
	float:left;
	text-align:center;
	width:80px;
	margin:0 8px 0 0;
	padding:5px 10px 2px 10px;
	border:1px solid <%= session("Color_Dip") %>;
	background-color:<%= session("Color_Fleet") %>;
	color:<%= session("Color_MainFont") %>;
}
.app_button{
	float:left;
	margin:0 4px 0 0;
	padding:4px 6px 2px 6px;
	background-color:<%= session("Color_Main") %>;
	color:<%= session("Color_SystemFont") %>;
	cursor:hand;
}

/* 模板设计调用的小窗口界面样式表 */
.TabTitle_cur{
	background:<%= session("Color_Main") %>;
	float:left;
	height:24px;
	width:60px;
	text-align:center;
	padding:6px 0 0 0;
	margin:0 2px 0 0;
	border-left:1px solid <%= session("Color_Disp") %>;
	border-top:1px solid <%= session("Color_Disp") %>;
	border-right:1px solid <%= session("Color_Disp") %>;
	position:relative;
}
.TabTitle_oth{
	background:<%= session("Color_Back") %>;
	float:left;
	height:22px;
	width:60px;
	margin:2px 2px 0 0;
	text-align:center;
	padding:5px 0 0 0;
	border:1px solid <%= session("Color_Disp") %>;
	z-index:10;
	position:relative;
	cursor:hand;
}
.TabBody{
	border:1px solid <%= session("Color_Disp") %>;
	margin:-1px 0 0 0;
	padding:0 0 0 2px;
	width:100%;
	background:<%= session("Color_Main") %>;
	display:auto;
}
.tab_cur{
	display:block;
}
.tab_oth{
	display:none;
}

.mod_button{
	background:url(../images/mod.gif) no-repeat 0 0;
	width:15px !important;
	height:15px !important;
	cursor:hand;
}
.up_button{
	background:url(../images/up.gif) no-repeat 0 0;
	width:15px !important;
	height:15px !important;
	cursor:hand;
}
.down_button{
	background:url(../images/down.gif) no-repeat 0 0;
	width:15px !important;
	height:15px !important;
	cursor:hand;
}
.del_button{
	background:url(../images/del.gif) no-repeat 0 0;
	width:15px !important;
	height:15px !important;
	cursor:hand;
}
.new_button{
	background:url(../images/new.gif) no-repeat 0 0;
	width:15px !important;
	height:15px !important;
	cursor:hand;
}
.lock_button{
	background:url(../images/lock.gif) no-repeat 0 0;
	width:15px !important;
	height:15px !important;
	cursor:hand;
}
.copy_button{
	background:url(../images/copy.gif) no-repeat 0 0;
	width:15px !important;
	height:15px !important;
	cursor:hand;
}
.push_button{
	background:url(../images/push.gif) no-repeat 0 0;
	width:15px !important;
	height:15px !important;
	cursor:hand;
}



.sysname{
	margin:8px 0 0 0;
}
.sysitem{
	float:left;
	width:100%;
	margin:8px 0 0 10px;
	clear:both;
	padding-left:20px;
	background:url(../images/math.gif) no-repeat left top;
}

/* JCP系统数据列表统一样式，含拖放线样式 */
.list_box{
	margin:10px 0 0 0;
	width:100%;
	float:left;
	/*
	border:3px double <%= session("Color_Dip") %>;
	padding:2px;
	*/
}
.list_box .list_title{
	float:left;
	width:100%;
	height:24px;
	margin:0;
	border:1px solid <%= session("Color_Dip") %>;
	background:<%= session("Color_Main") %>;
}
.list_box .list_title span{
	color:<%= session("Color_SystemFont") %>;
}
.list_box .list{
	float:left;
	width:100%;
	height:24px;
	margin:0;
	border-bottom:1px solid <%= session("Color_Dip") %>;
	border-right:1px solid <%= session("Color_Dip") %>;
	border-left:1px solid <%= session("Color_Dip") %>;
	background:<%= session("Color_Back") %>;
}
.list_box .fonttop{
	padding-top:6px;
}
.list_box .list_title span{
	text-align:center;
	width:100px;
}
.list_box .list span{
	text-align:center;
	width:100px;
}
.list_buttons{
	width:100%;
	float:left;
	text-align:center;
	margin:0 0 8px 0;
}

.distline{
	width:1px !important;
	height:14px;
	background:<%= session("Color_Fleet") %>;
	margin:-16px 0 0 0;
}
.distline_drop{
	width:1px !important;
	height:14px;
	background:<%= session("Color_Fleet") %>;
	margin:-16px 0 0 0;
	cursor: e-resize;
}
.distline_list{
	width:1px !important;
	height:14px;
	margin:-16px 0 0 0;
}
#moveline{
	width:0px;
	border-left:1px dotted <%= session("Color_Dip") %>;
	position:absolute;
	top:45px;
	display:none;
}

/* 操作结果页面样式 */
.result{
	width:100%;
	padding-top:60px;
	text-align:center;
}
.manage_exp{
	height:30px;
}
.result_button span{
	margin:8px;
}

.moveover{
	background-color:#FFFF00;
}

/* 主窗口中如果存在子级Frame窗口 */
#Sub_Main_Box{
	width:100%;
	height:100%;
}

/* 导航窗口 */
.GuideTopMenu{
	padding-left:6px;
}
.GuideTopMenuBack{
	background-color:<%= session("Color_Main") %>;
	width:130px;
	height:17px;
	margin:0 -150px 0 -6px;
	border:3px double <%= session("Color_Main") %>;
	filter: Alpha(Opacity=100, FinishOpacity=0, Style=1, StartX=0, StartY=0, FinishX=100, FinishY=0);
	position:absolute;
	z-Index:-1;
}