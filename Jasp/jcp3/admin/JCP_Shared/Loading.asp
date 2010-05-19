<html>
<head>
<title>载入中，请稍候 ......</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style>
	body{
		margin:0;
		background:<%= session("Color_Back") %>;
		cursor:url('../JCP_Skin/<%= session("SystemSkin") %>/images/mouse.ani');
	}
	td{
		word-break:break-all;
		font-size:12px;
		color: <%= session("Color_MainFont") %>;
	}
</style>
</head>

<body>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="middle"><img src="../JCP_Skin/<%= Session("SystemSkin") %>/images/loader.gif" align="absmiddle">　<span>载入中，请稍候 ......</span></td>
  </tr>
</table>
</body>
</html>
