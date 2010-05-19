/*
*######################################
* eWebEditor v3.60 - Advanced online web based WYSIWYG HTML editor.
* Copyright (c) 2003-2006 eWebSoft.com
*
* For further information go to http://www.ewebsoft.com/
* This copyright notice MUST stay intact for use.
*######################################
*/


var sMenuHr="<tr><td align=center valign=middle height=2><TABLE border=0 cellpadding=0 cellspacing=0 width="+(lang["UIMenuWidth"]-22)+" height=2><tr><td height=1 class=HrShadow><\/td><\/tr><tr><td height=1 class=HrHighLight><\/td><\/tr><\/TABLE><\/td><\/tr>";
var sMenu1="<TABLE border=0 cellpadding=0 cellspacing=0 class=Menu width="+lang["UIMenuWidth"]+"><tr><td width=18 valign=bottom align=center style='background:url(sysimage/contextmenu.gif);background-position:bottom;'><\/td><td width="+(lang["UIMenuWidth"]-18)+" class=RightBg><TABLE border=0 cellpadding=0 cellspacing=0>";
var sMenu2="<\/TABLE><\/td><\/tr><\/TABLE>";

var oPopupMenu = null;
if (BrowserInfo.IsIE55OrMore){
	oPopupMenu = window.createPopup();
}


function getMenuRow(s_Disabled, s_Event, s_Image, s_Html) {
	var s_MenuRow = "";
	s_MenuRow = "<tr><td align=center valign=middle><TABLE border=0 cellpadding=0 cellspacing=0 width="+(lang["UIMenuWidth"]-18)+"><tr "+s_Disabled+"><td valign=middle height=20 class=MouseOut onMouseOver=this.className='MouseOver'; onMouseOut=this.className='MouseOut';";
	if (s_Disabled==""){
		s_MenuRow += " onclick=\"parent."+s_Event+";parent.oPopupMenu.hide();\"";
	}
	s_MenuRow += ">"
	if (s_Image !=""){
		s_MenuRow += "&nbsp;<img border=0 src='buttonimage/"+config.ButtonDir+"/"+s_Image+"' width=20 height=20 align=absmiddle "+s_Disabled+">&nbsp;";
	}else{
		s_MenuRow += "&nbsp;";
	}
	s_MenuRow += s_Html+"<\/td><\/tr><\/TABLE><\/td><\/tr>";
	return s_MenuRow;

}


function getFormatMenuRow(menu, html, image){
	var s_Disabled = "";
	if (!eWebEditor.document.queryCommandEnabled(menu)){
		s_Disabled = "disabled";
	}
	var s_Event = "format('"+menu+"')";
	var s_Image = menu+".gif";
	if (image){
		s_Image = image;
	}
	return getMenuRow(s_Disabled, s_Event, s_Image, html)
}


function getTableMenuRow(what){
	var s_Menu = "";
	var s_Disabled = "disabled";
	switch(what){
	case "TableInsert":
		if (!isTableSelected()) s_Disabled="";
		s_Menu += getMenuRow(s_Disabled, "TableInsert()", "tableinsert.gif", lang["TableInsert"])
		break;
	case "TableProp":
		if (isTableSelected()||isCursorInTableCell()) s_Disabled="";
		s_Menu += getMenuRow(s_Disabled, "TableProp()", "tableprop.gif", lang["TableProp"])
		break;
	case "TableCell":
		if (isCursorInTableCell()) s_Disabled="";
		s_Menu += getMenuRow(s_Disabled, "TableCellProp()", "tablecellprop.gif", lang["TableCellProp"])
		s_Menu += getMenuRow(s_Disabled, "TableCellSplit()", "tablecellsplit.gif", lang["TableCellSplit"])
		s_Menu += sMenuHr;
		s_Menu += getMenuRow(s_Disabled, "TableRowProp()", "tablerowprop.gif", lang["TableRowProp"])
		s_Menu += getMenuRow(s_Disabled, "TableRowInsertAbove()", "tablerowinsertabove.gif", lang["TableRowInsertAbove"]);
		s_Menu += getMenuRow(s_Disabled, "TableRowInsertBelow()", "tablerowinsertbelow.gif", lang["TableRowInsertBelow"]);
		s_Menu += getMenuRow(s_Disabled, "TableRowMerge()", "tablerowmerge.gif", lang["TableRowMerge"]);
		s_Menu += getMenuRow(s_Disabled, "TableRowSplit(2)", "tablerowsplit.gif", lang["TableRowSplit"]);
		s_Menu += getMenuRow(s_Disabled, "TableRowDelete()", "tablerowdelete.gif", lang["TableRowDelete"]);
		s_Menu += sMenuHr;
		s_Menu += getMenuRow(s_Disabled, "TableColInsertLeft()", "tablecolinsertleft.gif", lang["TableColInsertLeft"]);
		s_Menu += getMenuRow(s_Disabled, "TableColInsertRight()", "tablecolinsertright.gif", lang["TableColInsertRight"]);
		s_Menu += getMenuRow(s_Disabled, "TableColMerge()", "tablecolmerge.gif", lang["TableColMerge"]);
		s_Menu += getMenuRow(s_Disabled, "TableColSplit(2)", "tablecolsplit.gif", lang["TableColSplit"]);
		s_Menu += getMenuRow(s_Disabled, "TableColDelete()", "tablecoldelete.gif", lang["TableColDelete"]);
		break;
	}
	return s_Menu;
}


function showContextMenu(event){
	if (!bEditMode) return false;

	var width = lang["UIMenuWidth"];
	var height = 0;
	var lefter = event.clientX;
	var topper = event.clientY;

	var oPopDocument = oPopupMenu.document;
	var oPopBody = oPopupMenu.document.body;

	var sMenu="";
	
	sMenu += getFormatMenuRow("cut", lang["Cut"]);
	sMenu += getFormatMenuRow("copy", lang["Copy"]);
	sMenu += getFormatMenuRow("paste", lang["Paste"]);
	sMenu += getFormatMenuRow("delete", lang["Delete"]);
	sMenu += getFormatMenuRow("selectall", lang["SelectAll"]);
	sMenu += sMenuHr;
	height += 102;

	if (isCursorInTableCell()){
		sMenu += getTableMenuRow("TableProp");
		sMenu += getTableMenuRow("TableCell");
		sMenu += sMenuHr;
		height += 286;
	}

	if (isControlSelected("TABLE")){
		sMenu += getTableMenuRow("TableProp");
		sMenu += sMenuHr;
		height += 22;
	}

	if (isControlSelected("IMG")){
		sMenu += getMenuRow("", "showDialog('img.htm', true)", "img.gif", lang["CMenuImg"]);
		sMenu += sMenuHr;
		sMenu += getMenuRow("", "zIndex('forward')", "forward.gif", lang["zIndexForward"]);
		sMenu += getMenuRow("", "zIndex('backward')", "backward.gif", lang["zIndexBackward"]);
		sMenu += sMenuHr;
		height += 64;
	}

	sMenu += getMenuRow("", "findReplace()", "findreplace.gif", lang["FindReplace"]);
	height += 20;

	sMenu = sMenu1 + sMenu + sMenu2;

	oPopDocument.open();
	oPopDocument.write(config.StyleMenuHeader+sMenu);
	oPopDocument.close();

	height+=2;
	if(lefter+width > document.body.clientWidth) lefter=lefter-width;
	//if(topper+height > document.body.clientHeight) topper=topper-height;

	oPopupMenu.show(lefter, topper, width, height, eWebEditor.document.body);
	return false;

}


function showToolMenu(menu){
	if (!bEditMode) return false;
	var sMenu = ""
	var width = lang["UIMenuWidth"];
	var height = 0;

	var lefter = event.clientX;
	var leftoff = event.offsetX
	var topper = event.clientY;
	var topoff = event.offsetY;

	var oPopDocument = oPopupMenu.document;
	var oPopBody = oPopupMenu.document.body;

	switch(menu){
	case "table":
		sMenu += getTableMenuRow("TableInsert");
		sMenu += getTableMenuRow("TableProp");
		sMenu += sMenuHr;
		sMenu += getTableMenuRow("TableCell");
		height = 306;
		break;
	case "form":
		sMenu += getFormatMenuRow("InsertInputText", lang["FormText"], "formtext.gif");
		sMenu += getFormatMenuRow("InsertTextArea", lang["FormTextArea"], "formtextarea.gif");
		sMenu += getFormatMenuRow("InsertInputRadio", lang["FormRadio"], "formradio.gif");
		sMenu += getFormatMenuRow("InsertInputCheckbox", lang["FormCheckbox"], "formcheckbox.gif");
		sMenu += getFormatMenuRow("InsertSelectDropdown", lang["FormDropdown"], "formdropdown.gif");
		sMenu += getFormatMenuRow("InsertButton", lang["FormButton"], "formbutton.gif");
		height = 120;
		break;
	case "zoom":
		for (var i=0; i<aZoomSize.length; i++){
			if (aZoomSize[i]==nCurrZoomSize){
				sMenu += getMenuRow("", "doZoom("+aZoomSize[i]+")", "checked.gif", aZoomSize[i]+"%");
			}else{
				sMenu += getMenuRow("", "doZoom("+aZoomSize[i]+")", "space.gif", aZoomSize[i]+"%");
			}
			height += 20;
		}
		break;
	}
	
	sMenu = sMenu1 + sMenu + sMenu2;
	
	oPopDocument.open();
	oPopDocument.write(config.StyleMenuHeader+sMenu);
	oPopDocument.close();

	height+=2;
	if(lefter+width > document.body.clientWidth) lefter=lefter-width+22;

	oPopupMenu.show(lefter - leftoff - 2, topper - topoff + 22, width, height, document.body);

	return false;
}

