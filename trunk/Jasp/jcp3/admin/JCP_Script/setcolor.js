<!--
function setcolor(object)
{
	var tempValue=eval("document.all." + object + '.value.replace("#","")');
	var arr = showModalDialog("../JCP_Article/JCP_EditTool/editor_selcolor.asp?oldcolor=" + tempValue, "", "dialogWidth:18.5em; dialogHeight:17.5em; help: no; scroll: no; status: no");
	if (arr != null) {
		eval("document.all." + object + ".value = arr");
	  	eval("document.all." + object + ".style.background=arr");
	  	eval("document.all." + object + "_colorbox.style.background=arr");
		
		if(object=="JCP_System_Color_MainFont"){
			document.all.prev_main.style.color=arr;
		}else if(object=="JCP_System_Color_SystemFont"){
			document.all.prev_system.style.color=arr;
		}else if(object=="JCP_System_Color_LightFont"){
			document.all.prev_light.style.color=arr;
		}else if(object=="JCP_System_Color_Main"){
			document.all.prev_box.style.background=arr;
			document.all.prev_title.style.background=arr;
		}else if(object=="JCP_System_Color_Back"){
			document.all.prev_cont.style.background=arr;
		}else if(object=="JCP_System_Color_Dip"){
			document.all.prev_box.style.borderRight="1px solid " + arr;
			document.all.prev_box.style.borderBottom="1px solid " + arr;
			document.all.prev_title.style.borderRight="1px solid " + arr;
			document.all.prev_title.style.borderBottom="1px solid " + arr;
			document.all.prev_cont.style.borderLeft="1px solid " + arr;
			document.all.prev_cont.style.borderTop="1px solid " + arr;
		}else if(object=="JCP_System_Color_Fleet"){
			document.all.prev_box.style.borderLeft="1px solid " + arr;
			document.all.prev_box.style.borderTop="1px solid " + arr;
			document.all.prev_title.style.borderLeft="1px solid " + arr;
			document.all.prev_title.style.borderTop="1px solid " + arr;
			document.all.prev_cont.style.borderRight="1px solid " + arr;
			document.all.prev_cont.style.borderBottom="1px solid " + arr;
		}
	}
	eval("document.all." + object + ".blur()");
}

// -->
