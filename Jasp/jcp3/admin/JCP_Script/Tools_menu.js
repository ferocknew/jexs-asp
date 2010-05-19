function HiddenMenu() {
    if(FrameState){
        iniFrameCols=main.testframeset.cols
        main.testframeset.cols="0,*"
        FrameState=0
        hidemenuLabel.innerHTML="<img src='../JCP_Skin/<%= session("JCP_System_Skin") %>/systemtool/open.gif'  alt='开启导航菜单' class=\"opacity1\" onmouseover=\"this.className='opacity2'\" onmouseout=\"this.className='opacity1'\">"
    }else{
        main.testframeset.cols=iniFrameCols
        FrameState=1
        hidemenuLabel.innerHTML="<img src='../JCP_Skin/<%= session("JCP_System_Skin") %>/systemtool/close.gif'  alt='关闭导航菜单' class=\"opacity1\" onmouseover=\"this.className='opacity2'\" onmouseout=\"this.className='opacity1'\">"
    }
}

if ((navigator.appName.indexOf('Microsoft')+1)) {
document.write('<style type="text/css"> .opacity1 {filter:alpha(opacity=50)} .opacity2 {filter:alpha(opacity=100)} </style>'); }
if ((navigator.appName.indexOf('Netscape')+1)) {
document.write('<style type="text/css"> .opacity1 {-moz-opacity:0.5} .opacity2 {-moz-opacity:1} </style>'); }
else {
document.write(''); }
