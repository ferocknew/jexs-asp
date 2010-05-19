<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<style>
<!--
	#css_list{
		float:left;
		width:250px;
		height:300px;
		padding:8px;
		overflow-y:auto;
		margin-right:4px;
		border:1px inset;
	}
	#css_list .cssitem{
		float:left;
		width:100%;
		margin:1px;
	}
	#css_list .cssitem span{
		float:left;
		margin-right:1px;
	}
	
	.label{
		float:left;
		height:22px;
		padding-top:6px;
		width:66px;
	}
	.text{
		float:left;
		width:32px;
		height:22px;
		font-size:14px;
	}
	.up{
		width:17px;
		height:10px;
		margin:0 2px 0 0;
		border:0;
		background:url(../JCP_Skin/<%= Session("SystemSkin") %>/images/spinner-normal.gif) no-repeat left top;
	}
	.down{
		width:17px;
		height:10px;
		margin:2px 2px 0 0;
		border:0;
		background:url(../JCP_Skin/<%= Session("SystemSkin") %>/images/spinner-normal.gif) no-repeat left -12px;
	}
	#css_list .cssitem span .select{
		font-size:14px;
	}
	#css_list .cssitem span .select_list{
		float:left;
		font-size:14px;
		width:140px;
		margin-left:-123px;
	}
	#css_list .cssitem span .select_list_text{
		float:left;
		width:123px;
		height:22px;
		font-size:14px;
		border-right:0px;
	}
	.color{
		width:53px;
		height:22px;
		font-size:14px;
	}
	.file{
		float:left;
		width:100px;
		height:22px;
		font-size:14px;
	}
	.filebutton{
		float:left;
		height:22px;
		margin-left:1px;
		padding-top:3px;
	}
	.samebutton{
		float:left;
		height:22px;
		padding-top:3px;
		margin:1px 0 0 2px;
	}
	#css_list .cssitem hr{
		float:center;
		width:80%;
		height:1px;
	}
	#css_view{
		float:left;
		width:300px;
		height:260px;
		overflow:auto;
		background-image:url(../JCP_Skin/<%= Session("SystemSkin") %>/images/transparent.gif);
		border:1px inset;
	}
	#csscode_box{
		float:left;
		width:300px;
		height:260px;
	}
	#css_sheet,#style_sheet{
		float:left;
		width:100%;
		height:130px;
	}
	#editobject{
		float:left;
		width:290px;
		padding:6px 0 0 4px;
	}
	
	.buttons{
		float:left;
		width:294px;
		padding:2px 0 0 98px;
	}
-->
</style>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	if(window.dialogArguments) var parentWin = window.dialogArguments;
	var cssSheet="";
	var styleSheet="";
	
	cssToJsMap = new Array;
	cssToJsMap["background"]	=	"background";
	cssToJsMap["background-attachment"]	=	"backgroundAttachment";
	cssToJsMap["background-color"]	=	"backgroundColor";
	cssToJsMap["background-image"]	=	"backgroundImage";
	cssToJsMap["background-position"]	=	"backgroundPosition";
	cssToJsMap["background-position-x"]	=	"backgroundPositionX";
	cssToJsMap["background-position-y"]	=	"backgroundPositionY";
	cssToJsMap["background-repeat"]	=	"backgroundRepeat";
	cssToJsMap["behavior"]	=	"behavior";
	cssToJsMap["border"]	=	"border";
	cssToJsMap["border-bottom"]	=	"borderBottom";
	cssToJsMap["border-bottom-color"]	=	"borderBottomColor";
	cssToJsMap["border-bottom-style"]	=	"borderBottomStyle";
	cssToJsMap["border-bottom-width"]	=	"borderBottomWidth";
	cssToJsMap["border-color"]	=	"borderColor";
	cssToJsMap["border-left"]	=	"borderLeft";
	cssToJsMap["border-left-color"]	=	"borderLeftColor";
	cssToJsMap["border-left-style"]	=	"borderLeftStyle";
	cssToJsMap["border-left-width"]	=	"borderLeftWidth";
	cssToJsMap["border-right"]	=	"borderRight";
	cssToJsMap["border-right-color"]	=	"borderRightColor";
	cssToJsMap["border-right-style"]	=	"borderRightStyle";
	cssToJsMap["border-right-width"]	=	"borderRightWidth";
	cssToJsMap["border-style"]	=	"borderStyle";
	cssToJsMap["border-top"]	=	"borderTop";
	cssToJsMap["border-top-color"]	=	"borderTopColor";
	cssToJsMap["border-top-style"]	=	"borderTopStyle";
	cssToJsMap["border-top-width"]	=	"borderTopWidth";
	cssToJsMap["border-width"]	=	"borderWidth";
	cssToJsMap["bottom"]	=	"bottom";
	cssToJsMap["clear"]	=	"Clear";
	cssToJsMap["clip"]	=	"clip";
	cssToJsMap["color"]	=	"color";
	cssToJsMap["cursor"]	=	"cursor";
	cssToJsMap["direction"]	=	"direction";
	cssToJsMap["display"]	=	"display";
	cssToJsMap["filter"]	=	"filter";
	cssToJsMap["font"]	=	"font";
	cssToJsMap["font-family"]	=	"fontFamily";
	cssToJsMap["font-size"]	=	"fontSize";
	cssToJsMap["font-style"]	=	"fontStyle";
	cssToJsMap["font-variant"]	=	"fontVariant";
	cssToJsMap["font-weight"]	=	"fontWeight";
	cssToJsMap["height"]	=	"height";
	cssToJsMap["layout-flow"]	=	"layoutFlow";
	cssToJsMap["layout-grid"]	=	"layoutGrid";
	cssToJsMap["layout-grid-char"]	=	"layoutGridChar";
	cssToJsMap["layout-grid-line"]	=	"layoutGridLine";
	cssToJsMap["layout-grid-mode"]	=	"layoutGridMode";
	cssToJsMap["layout-grid-type"]	=	"layoutGridType";
	cssToJsMap["left"]	=	"left";
	cssToJsMap["letter-spacing"]	=	"letterSpacing";
	cssToJsMap["line-break"]	=	"lineBreak";
	cssToJsMap["line-height"]	=	"lineHeight";
	cssToJsMap["margin"]	=	"margin";
	cssToJsMap["margin-bottom"]	=	"marginBottom";
	cssToJsMap["margin-left"]	=	"marginLeft";
	cssToJsMap["margin-right"]	=	"marginRight";
	cssToJsMap["margin-top"]	=	"marginTop";
	cssToJsMap["overflow"]	=	"overflow";
	cssToJsMap["overflow-x"]	=	"overflowX";
	cssToJsMap["overflow-y"]	=	"overflowY";
	cssToJsMap["padding"]	=	"padding";
	cssToJsMap["padding-bottom"]	=	"paddingBottom";
	cssToJsMap["padding-left"]	=	"paddingLeft";
	cssToJsMap["padding-right"]	=	"paddingRight";
	cssToJsMap["padding-top"]	=	"paddingTop";
	cssToJsMap["page-break-after"]	=	"pageBreakAfter";
	cssToJsMap["page-break-before"]	=	"pageBreakBefore";
	cssToJsMap["position"]	=	"position";
	cssToJsMap["right"]	=	"right";
	cssToJsMap["scrollbar-3dlight-color"]	=	"scrollbar3dLightColor";
	cssToJsMap["scrollbar-arrow-color"]	=	"scrollbarArrowColor";
	cssToJsMap["scrollbar-base-color"]	=	"scrollbarBaseColor";
	cssToJsMap["scrollbar-darkshadow-color"]	=	"scrollbarDarkShadowColor";
	cssToJsMap["scrollbar-face-color"]	=	"scrollbarFaceColor";
	cssToJsMap["scrollbar-highlight-color"]	=	"scrollbarHighlightColor";
	cssToJsMap["scrollbar-shadow-color"]	=	"scrollbarShadowColor";
	cssToJsMap["scrollbar-track-color"]	=	"scrollbarTrackColor";
	cssToJsMap["float"]	=	"float";
	cssToJsMap["text-align"]	=	"textAlign";
	cssToJsMap["text-align-last"]	=	"textAlignLast";
	cssToJsMap["text-autospace"]	=	"textAutospace";
	cssToJsMap["text-decoration"]	=	"textDecoration";
	cssToJsMap["text-indent"]	=	"textIndent";
	cssToJsMap["text-justify"]	=	"textJustify";
	cssToJsMap["text-kashida-space"]	=	"textKashidaSpace";
	cssToJsMap["text-overflow"]	=	"";
	cssToJsMap["text-transform"]	=	"textTransform";
	cssToJsMap["text-underline-position"]	=	"textUnderlinePosition";
	cssToJsMap["top"]	=	"top";
	cssToJsMap["unicode-bidi"]	=	"unicodeBidi";
	cssToJsMap["visibility"]	=	"visibility";
	cssToJsMap["white-space"]	=	"whiteSpace";
	cssToJsMap["width"]	=	"width";
	cssToJsMap["word-break"]	=	"wordBreak";
	cssToJsMap["word-spacing"]	=	"wordSpacing";
	cssToJsMap["word-wrap"]	=	"wordWrap";
	cssToJsMap["writing-mode"]	=	"writingMode";
	cssToJsMap["z-index"]	=	"zIndex";
	cssToJsMap["zindex"]	=	"zIndex";
	cssToJsMap["zoom"]	=	"zoom";
	////////////////////////////////////
	//非CSS样式属性,但需要保存的项
	cssToJsMap["src"]="";
		
	function CssItem(objs){
		var objparam=objs.split(" | ")
		doc.write('<div class="cssitem">');
		for(j=0;j<objparam.length;j++){
			eval(objparam[j]);
		}
		doc.write("</div>");
	}
	
	function label(strs){
		document.write('<label class="label">' + strs + '</label>');
	}
	function numText(objname){
		var objcontent='<span><input type="text" value="" id="' + objname + '" class="text" onchange="cssCreate();"></span>' + 
						'<span><input type="button" value="" class="up system_button_00" onMouseDown="Up(\'' + objname + '\');"><br>' +
						'<input type="button" value="" class="down system_button_00" onclick="Down(\'' + objname + '\');"></span>';
		doc.write(objcontent);
	}
	function selectBox(objname,titles,values){
		var objcontent='<span><select id="' + objname + '" class="select" onchange="cssCreate();">';
		var titleparam=titles.split(",");
		if(!values) values=titles;
		var valueparam=values.split(",");
		for(i=0;i<titleparam.length;i++){
			objcontent += '<option value="' + valueparam[i] + '">' + titleparam[i] + '</option>';
		}
		objcontent += '</select></span>';
		doc.write(objcontent);
	}
	function selectList(objname,titles,values){
		var objcontent='<span><input type="text" value="" id="' + objname + '" class="select_list_text" onchange="cssCreate();"></span><span><select id="' + objname + '_select" class="select_list" onchange="javascript:' + objname + '.value=this.value;' + objname + '.select();cssCreate();">';
		var titleparam=titles.split(",");
		if(!values) values=titles;
		var valueparam=values.split(",");
		for(i=0;i<titleparam.length;i++){
			objcontent += '<option value="' + valueparam[i] + '">' + titleparam[i] + '</option>';
		}
		objcontent += '</select></span>';
		doc.write(objcontent);
	}
	function colorText(objname){
		var objcontent='<span><input type="text" value="" id="' + objname + '" class="color" onclick="setcolor(\'' + objname + '\');cssCreate();" onchange="cssCreate();"></span>';
		doc.write(objcontent);
	}
	function fileText(objname){
		var objcontent='<span><input type="text" value="" id="' + objname + '" class="file" onchange="cssCreate();"><input type="button" value="游览" class="filebutton system_button_00" onclick="FindUploadFile(\'' + objname + '\',1);cssCreate();"></span>';
		doc.write(objcontent);
	}
	function distLine(){
		doc.write("<hr>");
	}
		
	function Up(objname){
		var o=doc.getElementById(objname);
		if(IntYn(o.value)) o.value++;
			else o.value=0;
		cssCreate();
	}
	function Down(objname){
		var o=doc.getElementById(objname);
		if(IntYn(o.value)) o.value--;
			else o.value=0;
		cssCreate();
	}
	
	function setSame(comstrs){
		var objcontent='<span><input type="button" value="下同" class="samebutton system_button_00" onclick="' + comstrs + ';cssCreate();"></span>';
		doc.write(objcontent);
	}
	
	function CssElement(elementexp){
		switch(elementexp){
			case "color":
				CssItem('label("字体颜色：") | colorText("color")');
				break;
			case "backgroundColor":
				CssItem('label("背景颜色：") | colorText("backgroundColor")');
				break;
			case "borderWidth":
				CssItem('label("边框宽度：") |  numText("borderWidth") | selectBox("borderWidth_ext","px,pt,em,ex,pc,cm,mm,%") | setSame("borderTopWidth.value=borderRightWidth.value=borderBottomWidth.value=borderLeftWidth.value=borderWidth.value;borderTopWidth_ext.value=borderRightWidth_ext.value=borderBottomWidth_ext.value=borderLeftWidth_ext.value=borderWidth_ext.value;")');
				break;
			case "borderTopWidth":
				CssItem('label("上边宽度：") |  numText("borderTopWidth") | selectBox("borderTopWidth_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "borderRightWidth":
				CssItem('label("右边宽度：") |  numText("borderRightWidth") | selectBox("borderRightWidth_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "borderBottomWidth":
				CssItem('label("底边宽度：") |  numText("borderBottomWidth") | selectBox("borderBottomWidth_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "borderLeftWidth":
				CssItem('label("左边宽度：") | numText("borderLeftWidth") | selectBox("borderLeftWidth_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "borderColor":
				CssItem('label("边框颜色：") | colorText("borderColor") | setSame("borderTopColor.value=borderRightColor.value=borderBottomColor.value=borderLeftColor.value=borderColor.value;borderTopColor.style.backgroundColor=borderRightColor.style.backgroundColor=borderBottomColor.style.backgroundColor=borderLeftColor.style.backgroundColor=borderColor.style.backgroundColor;")');
				break;
			case "borderTopColor":
				CssItem('label("上边颜色：") | colorText("borderTopColor")');
				break;
			case "borderRightColor":
				CssItem('label("右边颜色：") | colorText("borderRightColor")');
				break;
			case "borderBottomColor":
				CssItem('label("底边颜色：") | colorText("borderBottomColor")');
				break;
			case "borderLeftColor":
				CssItem('label("左边颜色：") | colorText("borderLeftColor")');
				break;
			case "borderStyle":
				CssItem('label("边框样式：") | selectBox("borderStyle",",solid,double,groove,ridge,inset,outset,dashed,dotted") | setSame("borderTopStyle.value=borderRightStyle.value=borderBottomStyle.value=borderLeftStyle.value=borderStyle.value;")');
				break;
			case "borderTopStyle":
				CssItem('label("上边样式：") | selectBox("borderTopStyle",",solid,double,groove,ridge,inset,outset,dashed,dotted")');
				break;
			case "borderRightStyle":
				CssItem('label("右边样式：") | selectBox("borderRightStyle",",solid,double,groove,ridge,inset,outset,dashed,dotted")');
				break;
			case "borderBottomStyle":
				CssItem('label("底边样式：") | selectBox("borderBottomStyle",",solid,double,groove,ridge,inset,outset,dashed,dotted")');
				break;
			case "borderLeftStyle":
				CssItem('label("左边样式：") | selectBox("borderLeftStyle",",solid,double,groove,ridge,inset,outset,dashed,dotted")');
				break;
			case "width":
				CssItem('label("整体宽度：") | numText("width") | selectBox("width_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "height":
				CssItem('label("整体高度：") | numText("height") | selectBox("height_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "overflow":
				CssItem('label("溢出选项：") | selectList("overflow",",visible,hidden,scroll,auto")');
				break;
			case "overflowX":
				CssItem('label("横向溢出：") | selectList("overflowX",",visible,hidden,scroll,auto")');
				break;
			case "overflowY":
				CssItem('label("纵向溢出：") | selectList("overflowY",",visible,hidden,scroll,auto")');
				break;
			case "padding":
				CssItem('label("内侧边距：") | numText("padding") | selectBox("padding_ext","px,pt,em,ex,pc,cm,mm,%") | setSame("paddingTop.value=paddingRight.value=paddingBottom.value=paddingLeft.value=padding.value;paddingTop_ext.value=paddingRight_ext.value=paddingBottom_ext.value=paddingLeft_ext.value=padding_ext.value;")');
				break;
			case "paddingTop":
				CssItem('label("上内边距：") | numText("paddingTop") | selectBox("paddingTop_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "paddingRight":
				CssItem('label("右内边距：") | numText("paddingRight") | selectBox("paddingRight_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "paddingBottom":
				CssItem('label("底内边距：") | numText("paddingBottom") | selectBox("paddingBottom_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "paddingLeft":
				CssItem('label("左内边距：") | numText("paddingLeft") | selectBox("paddingLeft_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "margin":
				CssItem('label("外侧边距：") | numText("margin") | selectBox("margin_ext","px,pt,em,ex,pc,cm,mm,%") | setSame("marginTop.value=marginRight.value=marginBottom.value=marginLeft.value=margin.value;marginTop_ext.value=marginRight_ext.value=marginBottom_ext.value=marginLeft_ext.value=margin_ext.value;")');
				break;
			case "marginTop":
				CssItem('label("上外边距：") | numText("marginTop") | selectBox("marginTop_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "marginRight":
				CssItem('label("右外边距：") | numText("marginRight") | selectBox("marginRight_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "marginBottom":
				CssItem('label("底外边距：") | numText("marginBottom") | selectBox("marginBottom_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "marginLeft":
				CssItem('label("左外边距：") | numText("marginLeft") | selectBox("marginLeft_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "fontFamily":
				CssItem('label("文字字体：") | selectList("fontFamily",",serif,sans-serif,cursive,fantasy,monospace,楷体,黑体,宋体,幼圆,隶书")');
				break;
			case "fontSize":
				CssItem('label("字体大小：") | selectList("fontSize",",12px,9pt,xx-small,x-small,small,large,x-large,xx-large")');
				break;
			case "fontWeight":
				CssItem('label("文字粗细：") | selectList("fontWeight",",normal,bold")');
				break;
			case "fontStyle":
				CssItem('label("文字样式：") | selectList("fontStyle",",normal,italic,oblique")');
				break;
			case "fontVariant":
				CssItem('label("文字变量：") | selectList("fontVariant",",normal,small-caps")');
				break;
			case "lineHeight":
				CssItem('label("文字行高：") | numText("lineHeight") | selectBox("lineHeight_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "clear":
				CssItem('label("清除属性：") | selectList("Clear",",left,right,both,none")');
				break;
			case "float":
				CssItem('label("浮动属性：") | selectList("float",",left,right,none")');
				break;
			case "textAlign":
				CssItem('label("水平排列：") | selectList("textAlign",",left,right,center,justify")');
				break;
			case "textDecoration":
				CssItem('label("文本修饰：") | selectList("textDecoration",",none,underline,overline,underline overline,line-through,blink")');
				break;
			case "textIndent":
				CssItem('label("文本缩进：") | numText("textIndent") | selectBox("textIndent_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "letterSpacing":
				CssItem('label("文字间距：") | numText("letterSpacing") | selectBox("letterSpacing_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "wordSpacing":
				CssItem('label("字母间距：") | numText("wordSpacing") | selectBox("wordSpacing_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "textTransform":
				CssItem('label("文本转换：") | selectList("textTransform",",none,capitalize,lowercase,uppercase")');
				break;
			case "verticalAlign":
				CssItem('label("垂直排列：") | selectList("verticalAlign",",baseline,top,middle,bottom,text-top,text-bottom,super,sub,3em,30%")');
				break;
			case "backgroundImage":
				CssItem('label("背景图片：") | fileText("backgroundImage")');
				break;
			case "backgroundRepeat":
				CssItem('label("背景拉伸：") | selectList("backgroundRepeat",",repeat,repeat-x,repeat-y,no-repeat")');
				break;
			case "backgroundPosition":
				CssItem('label("背景定位：") | selectList("backgroundPosition",",left,right,bottom,top,left top,left bottom,right top,right bottom,10px 10px,10% 10%")');
				break;
			case "backgroundAttachment":
				CssItem('label("附加属性：") | selectList("backgroundAttachment",",fixed,scroll")');
				break;
			case "display":
				CssItem('label("显示属性：") | selectList("display",",none,block,inline,run-in,compact,list-item,marker")');
				break;
			case "visibility":
				CssItem('label("是否可见：") | selectList("visibility",",visible,hidden")');
				break;
			case "position":
				CssItem('label("资源定位：") | selectList("position",",static,relative,absolute,fixed")');
				break;
			case "top":
				CssItem('label("顶部距离：") | numText("top") | selectBox("top_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "left":
				CssItem('label("左边距离：") | numText("left") | selectBox("left_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "right":
				CssItem('label("右边距离：") | numText("right") | selectBox("right_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "bottom":
				CssItem('label("底部距离：") | numText("bottom") | selectBox("bottom_ext","px,pt,em,ex,pc,cm,mm,%")');
				break;
			case "zIndex":
				CssItem('label("优先等级：") | numText("zIndex")');
				break;
			case "cursor":
				CssItem('label("鼠标指针：") | selectList("cursor",",crosshair,default,pointer,move,text,wait,help,n-resize,s-resize,w-resize,e-resize,ne-resize,nw-resize,se-resize,sw-resize")');
				break;
			case "src":
				CssItem('label("图片地址：") | fileText("src")');
				break;
			default:return false;
		}
	}

	function cssListDisplay(tagname){
			switch(tagname){
				case "IMG":
					CssElement("src");
						CssItem('distLine()');
					CssElement("width");
					CssElement("height");
						CssItem('distLine()');
					CssElement("margin");
					CssElement("marginTop");
					CssElement("marginRight");
					CssElement("marginBottom");
					CssElement("marginLeft");
						CssItem('distLine()');
					CssElement("borderWidth");
					CssElement("borderTopWidth");
					CssElement("borderRightWidth");
					CssElement("borderBottomWidth");
					CssElement("borderLeftWidth");
					CssElement("borderColor");
					CssElement("borderTopColor");
					CssElement("borderRightColor");
					CssElement("borderBottomColor");
					CssElement("borderLeftColor");
					CssElement("borderStyle");
					CssElement("borderTopStyle");
					CssElement("borderRightStyle");
					CssElement("borderBottomStyle");
					CssElement("borderLeftStyle");
						CssItem('distLine()');
					CssElement("clear");
					CssElement("float");
						CssItem('distLine()');
					CssElement("backgroundImage");
					CssElement("backgroundRepeat");
					CssElement("backgroundPosition");
					CssElement("backgroundAttachment");
						CssItem('distLine()');
					CssElement("display");
					CssElement("visibility");
					CssElement("position");
					CssElement("top");
					CssElement("left");
					CssElement("right");
					CssElement("bottom");
					CssElement("zIndex");
						CssItem('distLine()');
					CssElement("cursor");
					break;
				default:
					CssElement("float");
					CssElement("clear");
						CssItem('distLine()');
					CssElement("width");
					CssElement("height");
					CssElement("backgroundColor");
						CssItem('distLine()');
					CssElement("margin");
					CssElement("marginTop");
					CssElement("marginRight");
					CssElement("marginBottom");
					CssElement("marginLeft");
						CssItem('distLine()');
					CssElement("padding");
					CssElement("paddingTop");
					CssElement("paddingRight");
					CssElement("paddingBottom");
					CssElement("paddingLeft");
						CssItem('distLine()');
					CssElement("backgroundImage");
					CssElement("backgroundRepeat");
					CssElement("backgroundPosition");
					CssElement("backgroundAttachment");
						CssItem('distLine()');
					CssElement("color");
					CssElement("fontFamily");
					CssElement("fontSize");
					CssElement("fontWeight");
					CssElement("fontStyle");
					CssElement("fontVariant");
					CssElement("lineHeight");
					CssElement("textAlign");
					CssElement("textDecoration");
					CssElement("textIndent");
					CssElement("letterSpacing");
					CssElement("wordSpacing");
					CssElement("textTransform");
					CssElement("verticalAlign");
						CssItem('distLine()');
					CssElement("borderWidth");
					CssElement("borderTopWidth");
					CssElement("borderRightWidth");
					CssElement("borderBottomWidth");
					CssElement("borderLeftWidth");
					CssElement("borderColor");
					CssElement("borderTopColor");
					CssElement("borderRightColor");
					CssElement("borderBottomColor");
					CssElement("borderLeftColor");
					CssElement("borderStyle");
					CssElement("borderTopStyle");
					CssElement("borderRightStyle");
					CssElement("borderBottomStyle");
					CssElement("borderLeftStyle");
						CssItem('distLine()');
					CssElement("overflow");
					CssElement("overflowX");
					CssElement("overflowY");
						CssItem('distLine()');
					CssElement("position");
					CssElement("top");
					CssElement("left");
					CssElement("right");
					CssElement("bottom");
					CssElement("display");
					CssElement("visibility");
					CssElement("zIndex");
						CssItem('distLine()');
					CssElement("cursor");
			}
			return true;
	}

	function viewObject(tagname){
			switch(tagname){
				case "BODY":
					doc.write('<DIV id="testObject">欢迎使用JCP v3.0<br>　　内容管理系统</DIV>');
					break;
				case "IMG":
					if(parentWin.LastClickElement.src){
						cssToJsMap["src"]=FullUrl2RelUrl(parentWin.LastClickElement.src);
						if(parentWin.LastClickElement.getAttribute("height")) parentWin.LastClickElement.removeAttribute("height");
						if(parentWin.LastClickElement.getAttribute("width")) parentWin.LastClickElement.removeAttribute("width");
						doc.write('<' + tagname + ' id="testObject" src="' + cssToJsMap["src"] + '">');
					}else{
						doc.write('<' + tagname + ' id="testObject" src="../JCP_Skin/<%= Session("SystemSkin") %>/images/LOGO.jpg">');
					}
					break;
				case "TABLE":
					doc.write('<' + tagname + ' id="testObject"><tr><td>欢迎使用JCP v3.0<br>　　内容管理系统</td></tr></' + tagname + '>');
					break;
				case "TD":
					doc.write('<table><tr><' + tagname + ' id="testObject">欢迎使用JCP v3.0<br>　　内容管理系统</' + tagname + '></tr></table>');
					break;
				default:
					doc.write('<' + tagname + ' id="testObject">欢迎使用JCP v3.0<br>　　内容管理系统</' + tagname + '>');
			}
	}

	function cssCreate(){
		cssSheet="";
		styleSheet="";
		if(doc.getElementById("color")&&!BlankYn(color.value)) cssSheet += "color : " + color.value + ";";
		if(doc.getElementById("backgroundColor")&&!BlankYn(backgroundColor.value)) cssSheet += "background-color : " + backgroundColor.value + ";";
		if(doc.getElementById("borderWidth")&&!BlankYn(borderWidth.value)) cssSheet += "border-width : " + borderWidth.value + borderWidth_ext.value + ";";
		if(doc.getElementById("borderTopWidth")&&!BlankYn(borderTopWidth.value)) cssSheet += "border-top-width : " + borderTopWidth.value + borderTopWidth_ext.value + ";";
		if(doc.getElementById("borderRightWidth")&&!BlankYn(borderRightWidth.value)) cssSheet += "border-right-width : " + borderRightWidth.value + borderRightWidth_ext.value + ";";
		if(doc.getElementById("borderBottomWidth")&&!BlankYn(borderBottomWidth.value)) cssSheet += "border-bottom-width : " + borderBottomWidth.value + borderBottomWidth_ext.value + ";";
		if(doc.getElementById("borderLeftWidth")&&!BlankYn(borderLeftWidth.value)) cssSheet += "border-left-width : " + borderLeftWidth.value + borderLeftWidth_ext.value + ";";
		if(doc.getElementById("borderColor")&&!BlankYn(borderColor.value)) cssSheet += "border-color : " + borderColor.value + ";";
		if(doc.getElementById("borderTopColor")&&!BlankYn(borderTopColor.value)) cssSheet += "border-top-color : " + borderTopColor.value + ";";
		if(doc.getElementById("borderRightColor")&&!BlankYn(borderRightColor.value)) cssSheet += "border-right-color : " + borderRightColor.value + ";";
		if(doc.getElementById("borderBottomColor")&&!BlankYn(borderBottomColor.value)) cssSheet += "border-bottom-color : " + borderBottomColor.value + ";";
		if(doc.getElementById("borderLeftColor")&&!BlankYn(borderLeftColor.value)) cssSheet += "border-left-color : " + borderLeftColor.value + ";";
		if(doc.getElementById("borderStyle")&&!BlankYn(borderStyle.value)) cssSheet += "border-style : " + borderStyle.value + ";";
		if(doc.getElementById("borderTopStyle")&&!BlankYn(borderTopStyle.value)) cssSheet += "border-top-style : " + borderTopStyle.value + ";";
		if(doc.getElementById("borderRightStyle")&&!BlankYn(borderRightStyle.value)) cssSheet += "border-right-style : " + borderRightStyle.value + ";";
		if(doc.getElementById("borderBottomStyle")&&!BlankYn(borderBottomStyle.value)) cssSheet += "border-bottom-style : " + borderBottomStyle.value + ";";
		if(doc.getElementById("borderLeftStyle")&&!BlankYn(borderLeftStyle.value)) cssSheet += "border-left-style : " + borderLeftStyle.value + ";";
		if(doc.getElementById("width")&&!BlankYn(width.value)) cssSheet += "width : " + width.value + width_ext.value + ";";
		if(doc.getElementById("height")&&!BlankYn(height.value)) cssSheet += "height : " + height.value + height_ext.value + ";";
		if(doc.getElementById("overflow")&&!BlankYn(overflow.value)) cssSheet += "overflow : " + overflow.value + ";";
		if(doc.getElementById("overflowX")&&!BlankYn(overflowX.value)) cssSheet += "overflow-x : " + overflowX.value + ";";
		if(doc.getElementById("overflowY")&&!BlankYn(overflowY.value)) cssSheet += "overflow-y : " + overflowY.value + ";";
		if(doc.getElementById("padding")&&!BlankYn(padding.value)) cssSheet += "padding : " + padding.value + padding_ext.value + ";";
		if(doc.getElementById("paddingTop")&&!BlankYn(paddingTop.value)) cssSheet += "padding-top : " + paddingTop.value + paddingTop_ext.value + ";";
		if(doc.getElementById("paddingRight")&&!BlankYn(paddingRight.value)) cssSheet += "padding-right : " + paddingRight.value + paddingRight_ext.value + ";";
		if(doc.getElementById("paddingBottom")&&!BlankYn(paddingBottom.value)) cssSheet += "padding-bottom : " + paddingBottom.value + paddingBottom_ext.value + ";";
		if(doc.getElementById("paddingLeft")&&!BlankYn(paddingLeft.value)) cssSheet += "padding-left : " + paddingLeft.value + paddingLeft_ext.value + ";";
		if(doc.getElementById("margin")&&!BlankYn(margin.value)) cssSheet += "margin : " + margin.value + margin_ext.value + ";";
		if(doc.getElementById("marginTop")&&!BlankYn(marginTop.value)) cssSheet += "margin-top : " + marginTop.value + marginTop_ext.value + ";";
		if(doc.getElementById("marginRight")&&!BlankYn(marginRight.value)) cssSheet += "margin-right : " + marginRight.value + marginRight_ext.value + ";";
		if(doc.getElementById("marginBottom")&&!BlankYn(marginBottom.value)) cssSheet += "margin-bottom : " + marginBottom.value + marginBottom_ext.value + ";";
		if(doc.getElementById("marginLeft")&&!BlankYn(marginLeft.value)) cssSheet += "margin-left : " + marginLeft.value + marginLeft_ext.value + ";";
		if(doc.getElementById("fontFamily")&&!BlankYn(fontFamily.value)) cssSheet += "font-family : " + fontFamily.value + ";";
		if(doc.getElementById("fontSize")&&!BlankYn(fontSize.value)) cssSheet += "font-size : " + fontSize.value + ";";
		if(doc.getElementById("fontWeight")&&!BlankYn(fontWeight.value)) cssSheet += "font-weight : " + fontWeight.value + ";";
		if(doc.getElementById("fontStyle")&&!BlankYn(fontStyle.value)) cssSheet += "font-style : " + fontStyle.value + ";";
		if(doc.getElementById("fontVariant")&&!BlankYn(fontVariant.value)) cssSheet += "font-variant : " + fontVariant.value + ";";
		if(doc.getElementById("lineHeight")&&!BlankYn(lineHeight.value)) cssSheet += "line-height : " + lineHeight.value + lineHeight_ext.value + ";";
		if(doc.getElementById("Clear")&&!BlankYn(Clear.value)) cssSheet += "clear : " + Clear.value + ";";
		if(doc.getElementById("float")&&!BlankYn(float.value)) cssSheet += "float : " + float.value + ";";
		if(doc.getElementById("textAlign")&&!BlankYn(textAlign.value)) cssSheet += "text-align : " + textAlign.value + ";";
		if(doc.getElementById("textDecoration")&&!BlankYn(textDecoration.value)) cssSheet += "text-decoration : " + textDecoration.value + ";";
		if(doc.getElementById("textIndent")&&!BlankYn(textIndent.value)) cssSheet += "text-indent : " + textIndent.value + textIndent_ext.value + ";";
		if(doc.getElementById("letterSpacing")&&!BlankYn(letterSpacing.value)) cssSheet += "letter-spacing : " + letterSpacing.value + letterSpacing_ext.value + ";";
		if(doc.getElementById("wordSpacing")&&!BlankYn(wordSpacing.value)) cssSheet += "word-spacing : " + wordSpacing.value + wordSpacing_ext.value + ";";
		if(doc.getElementById("textTransform")&&!BlankYn(textTransform.value)) cssSheet += "text-transform : " + textTransform.value + ";";
		if(doc.getElementById("verticalAlign")&&!BlankYn(verticalAlign.value)) cssSheet += "vertical-align : " + verticalAlign.value + ";";
		if(doc.getElementById("backgroundImage")&&!BlankYn(backgroundImage.value)) cssSheet += "background-image : url(" + backgroundImage.value + ");";
		if(doc.getElementById("backgroundRepeat")&&!BlankYn(backgroundRepeat.value)) cssSheet += "background-repeat : " + backgroundRepeat.value + ";";
		if(doc.getElementById("backgroundPosition")&&!BlankYn(backgroundPosition.value)) cssSheet += "background-position : " + backgroundPosition.value + ";";
		if(doc.getElementById("backgroundAttachment")&&!BlankYn(backgroundAttachment.value)) cssSheet += "background-attachment : " + backgroundAttachment.value + ";";
		if(doc.getElementById("display")&&!BlankYn(display.value)) cssSheet += "display : " + display.value + ";";
		if(doc.getElementById("visibility")&&!BlankYn(visibility.value)) cssSheet += "visibility : " + visibility.value + ";";
		if(doc.getElementById("position")&&!BlankYn(position.value)) cssSheet += "position : " + position.value + ";";
		if(doc.getElementById("top")&&!BlankYn(top.value)) cssSheet += "top : " + top.value + top_ext.value + ";";
		if(doc.getElementById("left")&&!BlankYn(left.value)) cssSheet += "left : " + left.value + left_ext.value + ";";
		if(doc.getElementById("right")&&!BlankYn(right.value)) cssSheet += "right : " + right.value + right_ext.value + ";";
		if(doc.getElementById("bottom")&&!BlankYn(bottom.value)) cssSheet += "bottom : " + bottom.value + bottom_ext.value + ";";
		if(doc.getElementById("zIndex")&&!BlankYn(zIndex.value)) cssSheet += "z-index : " + zIndex.value + ";";
		if(doc.getElementById("cursor")&&!BlankYn(cursor.value)) cssSheet += "cursor : " + cursor.value + ";";
		
		
		styleSheet=cssSheet.replace(/\;/g,"; ").replace(/ : /g,": ");
		cssSheet=cssSheet.replace(/\;/g,";\n");
		
		css_sheet.value=cssSheet;
		style_sheet.value=styleSheet;
		
		cssSetToObject();
	}
	
	function cssGet(){
		var curStyle=testObject.runtimeStyle;
		var cssParams=new Object();
		var cssItems=curStyle.cssText.split(";");
		for(i=0;i<cssItems.length;i++){
			var acssItem=cssItems[i].split(":");
			cssParams[sTrim(acssItem[0]).toLowerCase()]=sTrim(acssItem[1]);
		}
		////////////////////////////
		//非CSS样式控制的属性,如src align width target ...
		if(cssToJsMap["src"]&&doc.getElementById("src")) src.value=cssToJsMap["src"];
		if(parentWin.LastClickElement.height&&doc.getElementById("height")){
			if(!cssParams["height"]){
				if(parentWin.LastClickElement.height==parseInt(parentWin.LastClickElement.height).toString()) cssParams["height"]=parentWin.LastClickElement.height + "px";
				else  cssParams["height"]=parentWin.LastClickElement.height;
			}
			if(!cssParams["width"]){
				if(parentWin.LastClickElement.width==parseInt(parentWin.LastClickElement.width).toString()) cssParams["width"]=parentWin.LastClickElement.width + "px";
				else  cssParams["width"]=parentWin.LastClickElement.width;
			}
		}
		////////////////////////////
		for(aParam in cssParams){
			switch(aParam){
				case "background-attachment":
				case "background-position":
				case "background-repeat":
				case "cursor":
				case "clear":
				case "display":
				case "float":
				case "font-family":
				case "font-size":
				case "font-style":
				case "font-variant":
				case "font-weight":
				case "overflow":
				case "overflow-x":
				case "overflow-y":
				case "position":
				case "text-align":
				case "text-decoration":
				case "text-transform":
				case "vertical-align":
				case "visibility":
					eval(cssToJsMap[aParam] + '.value=cssParams[aParam]');
					eval(cssToJsMap[aParam] + '_select.value=cssParams[aParam]');
					break;
				////////////////////////////
				case "border-width":
				case "border-top-width":
				case "border-right-width":
				case "border-bottom-width":
				case "border-left-width":
				case "bottom":
				case "height":
				case "left":
				case "letter-spacing":
				case "line-height":
				case "margin":
				case "margin-top":
				case "margin-right":
				case "margin-bottom":
				case "margin-left":
				case "padding":
				case "padding-top":
				case "padding-right":
				case "padding-bottom":
				case "padding-left":
				case "right":
				case "text-indent":
				case "top":
				case "width":
				case "word-spacing":
					eval(cssToJsMap[aParam] + '.value=parseInt(cssParams[aParam])');
					eval(cssToJsMap[aParam] + '_ext.value=sTrim(cssParams[aParam].replace(parseInt(cssParams[aParam]),""))');
					break;
				////////////////////////////
				case "background-color":
				case "border-color":
				case "border-top-color":
				case "border-right-color":
				case "border-bottom-color":
				case "border-left-color":
				case "color":
					eval(cssToJsMap[aParam] + '.value=cssParams[aParam]');
					eval(cssToJsMap[aParam] + '.style.backgroundColor=cssParams[aParam]');
					break;
				////////////////////////////
				case "background-image":
					eval(cssToJsMap[aParam] + '.value=cssParams[aParam].replace("url(","").replace(")","")');
					break;
				////////////////////////////
				case "border-style":
				case "border-top-style":
				case "border-right-style":
				case "border-bottom-style":
				case "border-left-style":
				case "zindex":
				case "z-index":
					eval(cssToJsMap[aParam] + '.value=cssParams[aParam]');
					break;
				////////////////////////////
				case "border":
				case "border-top":
				case "border-right":
				case "border-bottom":
				case "border-left":
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Color')){
						eval(cssToJsMap[aParam] + 'Color.value=curStyle.' + cssToJsMap[aParam] + 'Color');
						eval(cssToJsMap[aParam] + 'Color.style.backgroundColor=curStyle.' + cssToJsMap[aParam] + 'Color');
					}
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Width')){
						eval(cssToJsMap[aParam] + 'Width.value=parseInt(curStyle.' + cssToJsMap[aParam] + 'Width)');
						eval(cssToJsMap[aParam] + 'Width_ext.value=sTrim(curStyle.' + cssToJsMap[aParam] + 'Width.replace(parseInt(curStyle.' + cssToJsMap[aParam] + 'Width),""))');
					}
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Style')){
						eval(cssToJsMap[aParam] + 'Style.value=curStyle.' + cssToJsMap[aParam] + 'Style');
					}
					break;
				////////////////////////////
				case "font":
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Weight')){
						eval(cssToJsMap[aParam] + 'Weight.value=curStyle.' + cssToJsMap[aParam] + 'Weight');
						eval(cssToJsMap[aParam] + 'Weight_select.value=curStyle.' + cssToJsMap[aParam] + 'Weight');
					}else{
						eval(cssToJsMap[aParam] + 'Weight.value="normal"');
						eval(cssToJsMap[aParam] + 'Weight_select.value="normal"');
					}
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Style')){
						eval(cssToJsMap[aParam] + 'Style.value=curStyle.' + cssToJsMap[aParam] + 'Style');
						eval(cssToJsMap[aParam] + 'Style_select.value=curStyle.' + cssToJsMap[aParam] + 'Style');
					}else{
						eval(cssToJsMap[aParam] + 'Style.value="normal"');
						eval(cssToJsMap[aParam] + 'Style_select.value="normal"');
					}
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Variant')){
						eval(cssToJsMap[aParam] + 'Variant.value=curStyle.' + cssToJsMap[aParam] + 'Variant');
						eval(cssToJsMap[aParam] + 'Variant_select.value=curStyle.' + cssToJsMap[aParam] + 'Variant');
					}else{
						eval(cssToJsMap[aParam] + 'Variant.value="normal"');
						eval(cssToJsMap[aParam] + 'Variant_select.value="normal"');
					}
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Size')){
						eval(cssToJsMap[aParam] + 'Size.value=curStyle.' + cssToJsMap[aParam] + 'Size');
						eval(cssToJsMap[aParam] + 'Size_select.value=curStyle.' + cssToJsMap[aParam] + 'Size');
					}else{
						eval(cssToJsMap[aParam] + 'Size.value="normal"');
						eval(cssToJsMap[aParam] + 'Size_select.value="normal"');
					}
					if(eval('curStyle.lineHeight')){
						eval('lineHeight.value=parseInt(curStyle.lineHeight)');
						eval('lineHeight_ext.value=sTrim(curStyle.lineHeight.replace(parseInt(curStyle.lineHeight),""))');
					}
					break;
				////////////////////////////
				case "background":
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Image')){
						eval(cssToJsMap[aParam] + 'Image.value=curStyle.' + cssToJsMap[aParam] + 'Image.replace("url(","").replace(")","")');
					}
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Color')){
						eval(cssToJsMap[aParam] + 'Color.value=curStyle.' + cssToJsMap[aParam] + 'Color');
						eval(cssToJsMap[aParam] + 'Color.style.backgroundColor=curStyle.' + cssToJsMap[aParam] + 'Color');
					}
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Attachment')){
						eval(cssToJsMap[aParam] + 'Attachment.value=curStyle.' + cssToJsMap[aParam] + 'Attachment');
						eval(cssToJsMap[aParam] + 'Attachment_select.value=curStyle.' + cssToJsMap[aParam] + 'Attachment');
					}else{
						eval(cssToJsMap[aParam] + 'Attachment.value="scroll"');
						eval(cssToJsMap[aParam] + 'Attachment_select.value="scroll"');
					}
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Repeat')){
						eval(cssToJsMap[aParam] + 'Repeat.value=curStyle.' + cssToJsMap[aParam] + 'Repeat');
						eval(cssToJsMap[aParam] + 'Repeat_select.value=curStyle.' + cssToJsMap[aParam] + 'Repeat');
					}else{
						eval(cssToJsMap[aParam] + 'Repeat.value="repeat"');
						eval(cssToJsMap[aParam] + 'Repeat_select.value="repeat"');
					}
					break;
					if(eval('curStyle.' + cssToJsMap[aParam] + 'Position')){
						eval(cssToJsMap[aParam] + 'Position.value=sTrim(curStyle.' + cssToJsMap[aParam] + 'Position.replace("50%",""))');
						eval(cssToJsMap[aParam] + 'Position_select.value=sTrim(curStyle.' + cssToJsMap[aParam] + 'Position.replace("50%",""))');
					}else{
						eval(cssToJsMap[aParam] + 'Position.value="left top"');
						eval(cssToJsMap[aParam] + 'Position_select.value="left top"');
					}
					break;
				////////////////////////////
				case "background-image":
					eval(cssToJsMap[aParam] + '.value=cssParams[aParam].replace("url(","").replace(")","")');
					break;
				////////////////////////////
			}
		}
	}
	
	function cssSetToObject(){
		if(testObject) testObject.runtimeStyle.cssText=styleSheet;
		////////////////////////////
		//非CSS样式控制的属性,如src align width target ...
		if(cssToJsMap["src"]&&doc.getElementById("src")) testObject.src=src.value;
		////////////////////////////
	}
	
	function cssReturn(){
		if(parentWin){
			if(parentWin.LastClickElement){
				parentWin.LastClickElement.style.cssText=styleSheet;
				////////////////////////////
				//非CSS样式控制的属性,如src align width target ...
				if(cssToJsMap["src"]&&doc.getElementById("src")) parentWin.LastClickElement.src=src.value;
				////////////////////////////
				parentWin.GetFrame()
			}
		}
		window.close();	
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div id="css_list">
		<script language="JavaScript">
			if(parentWin){
				var CurObject=parentWin.LastClickElement.tagName;
				if(parentWin.LastClickElement.id){var CurObjectID="." + parentWin.LastClickElement.id;}else{var CurObjectID="";}
				styleSheet=parentWin.LastClickElement.style.cssText;
			}else{
				var CurObject="DIV";
				var CurObjectID="";
				styleSheet="";
			}
			doc.title=CurObject + CurObjectID + " 的CSS样式设计"
			cssListDisplay(CurObject);
		</script>
	</div>
	<div id="css_view" style="display:block;">
		<script language="JavaScript">
			viewObject(CurObject);
			cssSetToObject()
			cssGet();
		</script>
	</div>
	<div id="csscode_box" style="display:none;">
		<textarea id="css_sheet" class="csssheet" readonly></textarea>
		<textarea id="style_sheet" class="stylesheet" readonly></textarea>
		<script language="JavaScript">
			cssCreate();
		</script>
	</div>
	<div id="editobject">编辑对象：<script language="JavaScript">doc.write(CurObject + CurObjectID);</script></div>
	<div class="buttons">
		<input type="button" value="CSS源码" class="system_button_00" onclick="var disp=csscode_box.style.display;csscode_box.style.display=css_view.style.display;css_view.style.display=disp;if(this.value=='CSS源码'){this.value='CSS预览';}else{this.value='CSS源码';}">
		<input type="button" value="应用样式" onclick="cssReturn();" class="system_button_00">
		<input type="button" value="关闭" onclick="window.close();" class="system_button_00">
	</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>