<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
if request.querystring("action")="findIndex" then
	if J.fso.FileE(J.SiteRoot & J.IndexName & "." & J.FileExt) then response.write "OK"
	response.end
end if
%>
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Index.asp" rel="stylesheet" type="text/css">
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/WinBox.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/Rand.js"></script>
<script language="JavaScript" src="../JCP_Script/WinBox.asp"></script>
<script language="JavaScript" src="../JCP_Script/WinBox_Action_JS.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript">
var InsHeight=<%= session("Top_Height") %>;	//ͷ���߶�
var InsWidth=<%= session("Menu_Width") %>;	//���˵����
var heightCheck=34;	//�߶��޲�ֵ
var widthCheck=18;	//����޲�ֵ
var InsLeft=0;
var main_height=main_width=0;
window.onresize=win_resize;

function win_resize(){
	var win_height =doc.body.clientHeight;
	var win_width  =doc.body.clientWidth;
	main_height=win_height-InsHeight-heightCheck;
	main_width =win_width-InsWidth-widthCheck;
		
	if(main_height>0&&main_width>0){
		docall.menus_box.style.width   = InsWidth + "px";
		docall.menus_box.style.height  = (main_height +1) + "px";
		docall.main_box.style.width    = main_width + "px";
		docall.main_box.style.height   = main_height + "px";
		docall.menus_box.style.display ="block";
		docall.main_box.style.display  ="block";
		docall.resizeBar.style.width   = "5px";
		docall.resizeBar.style.height  = (main_height + 1) + "px";
		docall.DicLine.style.width   = "5px";
		docall.DicLine.style.height  = main_height + "px";
	}
}

	if ((navigator.appName.indexOf('Microsoft')+1)) {
		document.write('<style type="text/css"> .opacity1 {filter:alpha(opacity=70)} .opacity2 {filter:alpha(opacity=100)} </style>'); }
	if ((navigator.appName.indexOf('Netscape')+1)) {
		document.write('<style type="text/css"> .opacity1 {-moz-opacity:0.7} .opacity2 {-moz-opacity:1} </style>'); }
	else {
		document.write(''); 
	}
	

		var x0;
		var moveable = false;
		function startgrap()
        {
            if(event.button==1)
            {
            	DicLine.setCapture();
				x0 = event.clientX;
				DicLine.style.left=docall.resizeBar.offsetLeft + 4;
				DicLine.style.top=InsHeight + 6;
				DicLine.style.display="block";
                moveable = true;
           }
         }
        function stopgrap()
        {
            if(moveable)
            {
                DicLine.releaseCapture();
				DicLine.style.display="none";
				main_width =doc.body.clientWidth-InsWidth-widthCheck;
				docall.menus_box.style.width   = InsWidth + "px";
				docall.main_box.style.width    = main_width + "px";
                moveable = false;
				if(InsWidth>0 && !guideYn){
					menukey.childNodes[0].src="../JCP_Skin/<%= Session("SystemSkin") %>/systemtool/close.gif";
					guideYn=true;
				}
            }
        }
		
        function grap()
        {
             if(moveable)
                {
				 	if(event.clientX>4&&event.clientX<doc.body.clientWidth-4&&event.clientY>4&&event.clientY<doc.body.clientHeight){               
					var tWidth = parseInt(docall.menus_box.style.width) + (event.clientX - x0);
					var tMainWidth = doc.body.clientWidth-InsWidth-widthCheck;
					if(tWidth<=<%= session("Menu_Width") %>){
						InsWidth=<%= session("Menu_Width") %>;
					}else if(doc.body.clientWidth-tWidth-widthCheck<=<%= session("Menu_Width") %>){
						InsWidth=doc.body.clientWidth-<%= session("Menu_Width") %>-widthCheck;
					}else{
						DicLine.style.left=event.clientX-4;
						InsWidth = tWidth;
					}
				}
            }
        }
		
		var guideYn=true;
		var guideWidth=InsWidth;
		function GuideState(){
			if(guideYn){
				guideWidth=InsWidth;
				InsWidth=0;
				guideYn=false;
				menukey.childNodes[0].src="../JCP_Skin/<%= Session("SystemSkin") %>/systemtool/open.gif";
			}else{
				InsWidth=guideWidth;
				guideYn=true;
				menukey.childNodes[0].src="../JCP_Skin/<%= Session("SystemSkin") %>/systemtool/close.gif";
			}
			win_resize();
		}
		
		function RefreshMainBox(){
			if(top.frames['main_box'].frames['Sub_Main_Box']) top.frames['main_box'].frames['Sub_Main_Box'].location.reload();
			else top.frames['main_box'].location.reload();
		}
		
		function down(obj){
			obj.style.margin='4px 2px 2px 4px';
		}
		
		function up(obj){
			obj.style.margin='3px';
		}
		
		function webIndex(){
			startXmlRequest("GET","?action=findIndex",null,"body","","",false);
			if(xml_BackCont=="OK"){
				window.open('<%= J.SiteUrlRoot & J.IndexName & "." & J.FileExt %>');
			}else{
				alert("��վ��ҳ��δ���ɣ�������[��ҳģ��]���ٷ��ʣ�");
			}
		}
		
		function help(){
			window.open('http://www.lvolvo.com');
		}
</script>
</head>

<body onLoad="javascript:Page_Loaded();win_resize();WinBox_Ini();">
<div id="DicLine" style="display:none;left:0;top:0;width:0;height:0;position:absolute;" onMouseMove="grap();" onMouseUp="stopgrap();"></div>
<div id="JCP">
	<div id="top_back"></div>
	<div id="top">
		<div id="logo">
			<h1><% if session("SystemLogo")&""<>"" then response.write replace("<img src=""" & session("SystemLogo") & """>","//","/") else response.write session("SiteSystemName") %></h1>
			<div class="copyright"><%= J.Version & " &copy; " & session("SiteName") & " " & J.CopyRight %></div>
		</div>
		<div id="tool_button">
			<span id="menukey" class="button">
				<img src="../JCP_Skin/1/systemtool/close.gif" alt='��ʾ/���� �����˵�' class="opacity1" onClick="GuideState()" onmousedown="down(this)" onmouseup="up(this)" onmouseover="javascript:window.status='��ʾ/���� �����˵�';this.className='opacity2';" onmouseout="this.className='opacity1';"></span>
			<span id="back" class="button">
				<img src="../JCP_Skin/1/systemtool/back.gif" alt="����" class="opacity1" onclick='javascript:history.go(-1)' onmousedown="down(this)" onmouseup="up(this)" onmouseover="this.className='opacity2';javascript:window.status='����';" onmouseout="this.className='opacity1';"></span>
			<span id="goon" class="button">
				<img src="../JCP_Skin/1/systemtool/goon.gif" alt="ǰ��" class="opacity1" onclick='javascript:history.go(1)' onmousedown="down(this)" onmouseup="up(this)" onmouseover="this.className='opacity2';window.status='ǰ��';" onmouseout="this.className='opacity1';"></span>
			<span id="home" class="button">
				<img src="../JCP_Skin/1/systemtool/home.gif" alt="վ����ҳ" class="opacity1" onclick="javascript:webIndex();" onmousedown="down(this)" onmouseup="up(this)" onmouseover="javascript:window.status='ϵͳ��ҳ';this.className='opacity2';" onmouseout="this.className='opacity1';"></span>
			<span id="refresh" class="button">
				<img src="../JCP_Skin/1/systemtool/refresh.gif" alt="ˢ��" class="opacity1" onClick="javascript:RefreshMainBox()" onmousedown="down(this)" onmouseup="up(this)" onmouseover="javascript:window.status='ˢ��';this.className='opacity2';" onmouseout="this.className='opacity1';"></span>
			<span id="help" class="button">
				<img src="../JCP_Skin/1/systemtool/help.gif" alt="����" class="opacity1" onclick="javascript:help();" onmousedown="down(this)" onmouseup="up(this)" onmouseover="javascript:window.status='����';this.className='opacity2';" onmouseout="this.className='opacity1';"></span>
			<span id="exit" class="button">
				<img src="../JCP_Skin/1/systemtool/exit.gif" alt="�˳�" class="opacity1" onClick="javascript:location='../JCP_Login/Logout.asp';" onmousedown="down(this)" onmouseup="up(this)" onmouseover="javascript:window.status='�˳�';this.className='opacity2';" onmouseout="this.className='opacity1';"></span>
		</div>
	</div>
	<div id="body">
		<div id="Loading" class="Loading"><img src="../JCP_Skin/1/images/loader.gif" width="24" height="24" align="absmiddle">��<span>ϵͳ������ ......</span></div>
		<% J.Menus_Box %>
		<div id="resizeBar" onmousedown="startgrap();"></div>
		<% J.Main_Box %>
	</div>
	<div id="copyright">
		<%= J.Version & " &copy; " & session("SiteName") & " " & J.CopyRight %>
	</div>
	<div id="copyright_back"></div>
	<iframe frameborder="0" width="0" height="0" src="JCP_ReSaveSession.asp"></iframe>
</div>
</body>
</html>
<% J.close %>