<% if session("JCP_LoginPage") then 
	if session("JCP_Login") then response.redirect "JCP_Win/"
%>
<html>
<head>
<title>登陆 <%= Session("SiteSystemName") & "   "  & " &copy; " & Session("SiteName") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Normal.asp" rel="stylesheet" type="text/css">
<script language="JavaScript" src="JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
function Page_Loaded(){
	if(document.all.Loading){document.all.Loading.style.display="none";}
	if(document.all.JCP_body){document.all.JCP_body.style.display="block";}
}
function formcheck(){
	if(BlankCheck(document.all.adminname.value,document.all.adminname)){
		if(BlankCheck(document.all.adminpwd.value,document.all.adminpwd)){
			if(BlankCheck(document.all.checkcode.value,document.all.checkcode)){
				return true;
			}return false;
		}return false;
	}return false;
}
</script>
<style>
body{
	margin:0;
	padding:0;
	overflow:hidden;
}
td{
	color:#FFFFFF;
}
</style>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onLoad="javascript:Page_Loaded();document.all.adminname.focus();" onKeyPress="if(event.keyCode==13){Login.submit();}">
<div id="Loading" class="Loading"><img src="JCP_Skin/<%= Session("SystemSkin") %>/images/loader.gif" align="absmiddle">　<span>载入中，请稍候 ......</span></div>
<div id="JCP_body">
<div align="center">
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <form name="Login" method="post" action="JCP_Login/Login_Check.asp" onSubmit="javascript:return formcheck();">
      <table width="100%" height="345" border="0" cellpadding="0" cellspacing="0" background="JCP_Skin/<%= session("SystemSkin") %>/index/new_003.jpg">
        <tr> 
          <td height="151" align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center"><img src="JCP_Skin/<%= session("SystemSkin") %>/index/logo.jpg" width="429" height="75"></td>
                <td width="120">
				<input type="image" style="border:0px; width:85px; height:76px;cursor:hand;" onFocus="javascript:blur();" src="JCP_Skin/<%= session("SystemSkin") %>/index/new_001.jpg">
                </td>
                <td><table width="158" border="0" cellspacing="0" cellpadding="2">
                    <tr> 
                      <td width="154">用户名： 
                        <input name="adminname" type="text" style="width:80px;"></td>
                    </tr>
                    <tr> 
                      <td>密　码： 
                        <input name="adminpwd" type="password" style="width:80px;"></td>
                    </tr>
                    <tr> 
                      <td>验证码： 
                        <input type="text" name="checkcode" style="width:33px;">
						<img src="../JCP_Inc/Class_JCP_CheckCode.asp" align="absmiddle" onClick="this.src=this.src;" title="点击可以刷新验证码" style="cursor:hand;"> 
                      </td>
                    </tr>
                  </table>
                  </td>
              </tr>
            </table>
            
          </td>
        </tr>
      </table>
      </form>
</div>
<% else %>
	<div style="width:100%;height:100%;"><iframe style="width:100%;height:100%;" frameborder="0" src="JCP_Win/"></iframe></div>
<% end if %>
<!--#include file="JCP_Shared/foot.asp" -->