<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<style>
<!--
body{
	margin:0;
	padding:0;
	background-color:<%= session("Color_Main") %>;
}

.BoxBorder{
	filter: Alpha(Opacity=50);
}

.bl{border-left:1px solid <%= session("Color_Dip") %>;}
.br{border-right:1px solid <%= session("Color_Dip") %>;}
.bt{border-top:1px solid <%= session("Color_Dip") %>;}
.bb{border-bottom:1px solid <%= session("Color_Dip") %>;}
-->
</style>
<script language="JavaScript">
<!--
	function ButtonChange(type){
		if(type==1){
			document.getElementById("menusbox_1").style.display="block";
			document.getElementById("menu_button_line").style.left="42px";
		}else if(type==0){
			document.getElementById("menusbox_1").style.display="none";
			document.getElementById("menu_button_line").style.left="1px";
		}
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
  <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td width="4" rowspan="2"><img class="BoxBorder bl bt" src="../JCP_Skin/1/images/white.gif" width="100%" height="100%"></td>
      <td height="4"><img class="BoxBorder bt" src="../JCP_Skin/1/images/white.gif" width="100%" height="100%"></td>
      <td width="4" rowspan="2"><img class="BoxBorder br bt" src="../JCP_Skin/1/images/white.gif" width="100%" height="100%"></td>
    </tr>
    <tr> 
      <td>
	  <iframe id="menusbox_1" scrolling="auto" frameborder="0" src="../JCP_Win/JCP_Menus.asp?menutype=1" style="width:100%;height:100%;display:none;"></iframe>
	  <iframe id="menusbox_0" scrolling="auto" frameborder="0" src="../JCP_Win/JCP_Menus.asp?menutype=0" style="width:100%;height:100%;display:block;"></iframe>
	  </td>
    </tr>
    <tr> 
      <td height="4" colspan="3">
	  	<img class="BoxBorder bb bl br" src="../JCP_Skin/1/images/white.gif" width="100%" height="100%"><div id="menu_button_line" style="position:relative;width:38px;height:1px;background-color:#FFF;margin-top:-1px;overflow:hidden;filter: Alpha(Opacity=60);"></div>
	  </td>
    </tr>
    <tr> 
      <td height="20" colspan="3">
		<script language="JavaScript">
		  	Button("normal_button",102,40,20,0,0,"∆’Õ®");
		  	Button("system_button",102,40,20,0,1,"œµÕ≥");
		  	normal_button.onclick=function(){ButtonChange(0)};
			system_button.onclick=function(){ButtonChange(1)};
			document.getElementById("menu_button_line").style.left="1px";
		</script>	
	  </td>
    </tr>
  </table>
  <!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>