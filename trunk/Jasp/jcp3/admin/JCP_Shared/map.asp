<% 
dim objectid,mapy,mapx,mapzoom
objectid=request.querystring("objectid")
mapx=request.QueryString("mapx")
mapy=request.QueryString("mapy")
mapzoom=request.QueryString("mapzoom")
%>
<html>
<head>
<title>山西旅游网 >> 在线地图</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript" src="http://api.51ditu.com/js/maps.js"></script>
</head>

<body>
<div id="myMap" style="position:relative; width:100%; height:100%;"></div>
<script language="javascript">
var maps = new LTMaps( "myMap" ); 

maps.centerAndZoom(new LTPoint(<%= mapy %>,<%= mapx %>),<%= mapzoom %>);
 
var StandMap = new LTStandMapControl();
var Scale = new LTScaleControl();

maps.addControl( StandMap );
maps.addControl( Scale );

maps.handleKeyboard(); //键盘操作支持
maps.handleMouseScroll();//鼠标滚轮支持

var control = new LTMarkControl();
maps.addControl( control );

function getPoi(){
	var poi = control.getMarkControlPoint();
	//alert( "纬度：" + poi.getLatitude() + "\n经度：" + poi.getLongitude() ); 
	maps.centerAndZoom(new LTPoint(poi.getLongitude(),poi.getLatitude()) , maps.zoom );
	parent.document.getElementById("Item_<%= objectid %>_mapx").value=poi.getLatitude();
	parent.document.getElementById("Item_<%= objectid %>_mapy").value=poi.getLongitude();
	parent.document.getElementById("Item_<%= objectid %>_mapzoom").value=maps.zoom;
}
LTEvent.addListener( control , "mouseup" , getPoi );

var MarkButton=document.getElementsByTagName("input")[0];
var div=MarkButton.parentNode;
MarkButton.style.display="none";
div.style.fontSize="12";
div.style.background="#000";
div.style.color="#FFF";
div.style.padding="3px 2px 0 4px";
div.style.cursor="hand";
div.onclick=function(){MarkButton.click()}; 
div.appendChild(document.createTextNode("获取地图数据")); 
</script> 
</body>
</html>
