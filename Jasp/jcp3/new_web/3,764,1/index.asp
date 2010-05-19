<HTML><HEAD><TITLE>民生期货有限公司</TITLE><LINK href="../../new_Web/SOLE/26.html" type=text/css rel=stylesheet></HEAD>
<BODY style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BACKGROUND-IMAGE: url(../../images/bj.jpg); PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; TEXT-ALIGN: center">
<DIV id=menuDiv style="Z-INDEX: 1000; VISIBILITY: hidden; WIDTH: 1px; POSITION: absolute; HEIGHT: 1px; BACKGROUND-COLOR: #9cc5f8"></DIV>
<DIV style="WIDTH: 770px"><IMG height=149 src="../../images/top3.jpg" width=770></DIV>
<DIV style="OVERFLOW: hidden; WIDTH: 770px; HEIGHT: 6px; BACKGROUND-COLOR: #ffffff">&nbsp;</DIV>
<DIV id=guidebar style="BACKGROUND-POSITION: left -1px; BACKGROUND-IMAGE: url(../../images/tdh.jpg); OVERFLOW: hidden; WIDTH: 770px; PADDING-TOP: 6px; HEIGHT: 25px; TEXT-ALIGN: center"><script language="javascript" src="../../new_Script/37.js"></script></DIV>
<DIV style="BACKGROUND-IMAGE: url(../../images/tdhx3.jpg); WIDTH: 770px; HEIGHT: 53px">
<DIV style="MARGIN-TOP: 12px; FLOAT: left; MARGIN-LEFT: 10px; WIDTH: 110px; MARGIN-RIGHT: 10px; HEIGHT: 31px"><IMG height=31 src="../../images/gjz.gif" width=110></DIV>
<DIV style="MARGIN-TOP: 16px; FLOAT: left; MARGIN-LEFT: 10px; WIDTH: 500px; MARGIN-RIGHT: 10px; TEXT-ALIGN: left"><!-- 替换型HTML代码 -->

<script language="javascript" src="../../jcp_search/JS/57.js"></script>
</DIV></DIV>
<DIV style="WIDTH: 770px; BACKGROUND-COLOR: #ffffff">
<DIV style="FLOAT: left; WIDTH: 180px">
<DIV style="PADDING-TOP: 10px"><A href="http://202.97.134.215/index.jsp" target=_blank><IMG height=51 src="../../images/wsjycx.jpg" width=177 border=0></A> </DIV>
<DIV><A href="../../JCP_GBook/Main/" target=_blank><IMG height=120 src="../../images/zjzx.jpg" width=180 border=0></A> </DIV>
<DIV><IMG height=268 src="../../images/lxwm.jpg" width=180></DIV></DIV>
<DIV style="FLOAT: left; WIDTH: 590px">
<DIV id=path style="PADDING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-WEIGHT: bold; FONT-SIZE: 13px; PADDING-BOTTOM: 6px; WIDTH: 100%; COLOR: #48dd22; PADDING-TOP: 10px; TEXT-ALIGN: left"><a href="/2008/wcqh/">首页</a> >> 民生期货 >> 公司动态 >> <a href="/2008/wcqh/new_Web/3,764,1/">分析师介绍</a></DIV>
<DIV style="PADDING-LEFT: 56px; FONT-SIZE: 13px; BACKGROUND-IMAGE: url(../../images/ejdh.jpg); WIDTH: 100%; PADDING-TOP: 10px; HEIGHT: 34px; TEXT-ALIGN: left">文章列表

</DIV>
<DIV style="BACKGROUND-IMAGE: url(../../images/ejbj.jpg); WIDTH: 100%; BACKGROUND-REPEAT: repeat-y; HEIGHT: 400px">
<!--#include file="../../JCP_Inc/Class_JCP.asp"-->
<script language="JavaScript" src="../../JCP_Script/showpage.js"></script>
<%
dim main,classid,pgsize
pgsize=30

set Main=new JCP
Main.WebOpen server.mapPath("../../wcqhbackmanagebase/wcqh_Database/access_database.mdb")

dim page,rscount,ii,rs
set page=Main.Page("uptime,Item_914_text,id,Item_360_link$Article_3$deleted=0 and Item_946_class=764$id desc$id",pgsize)
rscount=page.RecCount()
rs=page.ResultSet()
if rscount<1 then
	response.write "暂无内容！"
else
	for ii=0 to Ubound(rs,2)
%>
		<DIV style="BACKGROUND-POSITION: 6px 6px; BACKGROUND-IMAGE: url(../../images/dot.gif); WIDTH: 100%; LINE-HEIGHT: 16px; BACKGROUND-REPEAT: no-repeat;text-align:left;padding:4px 4px 0 20px;height:20px;over-flow:hidden;"><span style="float:right;padding:0 4px 0 0;"><%= rs(0,ii) %></span><a href="<% if len(trim(rs(3,ii) & " "))>8 then response.write rs(3,ii) else response.write "../3,764/Content" & rs(2,ii) & ".html" %>" target="_blank"><%= rs(1,ii) %></a></DIV>
<%
	next
end if
%>
<div style="padding:10px;text-align:right;"><% page.ShowPage() %></div>
<%
Main.WebClose()
%></DIV>
<DIV><IMG height=3 src="../../images/ejboot.jpg" width=590></DIV></DIV></DIV>
<DIV style="OVERFLOW: hidden; WIDTH: 770px; HEIGHT: 6px; BACKGROUND-COLOR: #ffffff">&nbsp;</DIV>
<DIV style="FONT-SIZE: 13px; BACKGROUND-IMAGE: url(../../images/yjbk.jpg); WIDTH: 770px; LINE-HEIGHT: 20px; PADDING-TOP: 30px; BACKGROUND-REPEAT: repeat-x; HEIGHT: 100px"><script language="javascript" src="../../new_Script/36.js"></script></DIV>

</BODY></HTML>