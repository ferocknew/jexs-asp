// JavaScript Document
function JS_topclass_add(WinBox,WinBox_Body){
	WinBox_Body.innerHTML='<iframe frameborder="0" scrolling="no" style="width:100%;height:100%;" src="../JCP_Class/JCP_TopClass.asp?action=add&winbox=' + WinBox +'"></iframe>';
}

function JS_ArtSys(WinBox,WinBox_Body){
	alert(main_box.EditeElement("edit"));
	var html=main_box.EditeElement("edit");
	WinBox_Body.innerHTML=html;
}
 
function JS_Push(WinBox,WinBox_Body){
	main_box.Steps(WinBox,WinBox_Body);
}
 
function JS_Close_Push(){
	document.frames["main_box"].clearTimeout(document.frames["main_box"].closetimer);
} 
 