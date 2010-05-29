<%@language="VBscript" codepage="65001"%>
<%response.charset="utf-8"%>
<!--#include file="Jasp.asp"-->
<hr />
<img src="CheckCode.asp?checkcodeid=test" width="80" height="30">=<%=Jasp.checkcode.check(Session("CheckCode_test"),"test")%>
<img src="CheckCode.asp?checkcodeid=HIHI">=<%=Session("CheckCode_HIHI")%>
<img src="CheckCode.asp?">=<%=Session("CheckCode")%>
<hr />
<img src="CheckCode.asp?checkcodeid=zhtest&type=zh" width="90" height="30">=<%=Session("CheckCode_zhtest")%>
<img src="CheckCode.asp?checkcodeid=zhHIHI&type=zh">=<%=Session("CheckCode_zhHIHI")%>
