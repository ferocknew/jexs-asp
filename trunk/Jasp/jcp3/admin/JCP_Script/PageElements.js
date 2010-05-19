// JavaScript Document
var doc=document;
var curElement;
var Items=new Array;
var curitem=new Object;

function getProp(Element_Type){
	switch(Element_Type)
	{
		case "class":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 exps:doc.getElementById(curElement + "_class_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,160);
			if(arr){
				doc.getElementById(curElement + "_label").innerText=arr.split("{$|}")[0];
				doc.getElementById(curElement + "_class_label").innerText=arr.split("{$|}")[1];
			}
			break;
		case "text":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_text").style.width,
					 exps:doc.getElementById(curElement + "_text_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,186);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "link":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_link").style.width,
					 exps:doc.getElementById(curElement + "_link_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,186);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "tag":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_tag").style.width,
					 exps:doc.getElementById(curElement + "_tag_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,186);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "textarea":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_textarea").style.width,
					 height:doc.getElementById(curElement + "_textarea").style.height,
					 exps:doc.getElementById(curElement + "_textarea_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,210);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "number":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_number").style.width,
					 height:doc.getElementById(curElement + "_number").style.height,
					 exps:doc.getElementById(curElement + "_number_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,186);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "radio":
			var temp_exps;
			for(var i=1;i<=doc.getElementsByName(curElement + "_radio").length;i++) if(i==1){temp_exps=doc.getElementById(curElement + "_radio_label_" + i).innerText;}else{temp_exps+="{$|}" + doc.getElementById(curElement + "_radio_label_" + i).innerText;}
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 exps:temp_exps,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",236,230);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "checkbox":
			var temp_exps;
			for(var i=1;i<=eval(curElement + "_checkbox_counter").value;i++) if(i==1){temp_exps=doc.getElementById(curElement + "_checkbox_label_" + i).innerText;}else{temp_exps+="{$|}" + doc.getElementById(curElement + "_checkbox_label_" + i).innerText;}
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 exps:temp_exps,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",236,230);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "file":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_file").style.width,
					 exps:doc.getElementById(curElement + "_file_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,186);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "upload":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_upload").style.width,
					 exps:doc.getElementById(curElement + "_upload_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,186);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "pics":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_pics").style.width,
					 size:doc.getElementById(curElement + "_pics").getAttribute("size"),
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,186);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "edit":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_edit").style.width,
					 height:doc.getElementById(curElement + "_edit").style.height,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,186);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		case "map":
			curitem={
					 type:Element_Type,
					 label:doc.getElementById(curElement + "_label").innerText,
					 width:doc.getElementById(curElement + "_map").style.width,
					 height:doc.getElementById(curElement + "_map").style.height,
					 exps:doc.getElementById(curElement + "_map_label").innerText,
					 boxwidth:doc.getElementById(curElement).style.width
					 }
			var arr=ModelWin("JCP_ArtSys_Prop.asp",250,210);
			if(arr) doc.getElementById(curElement).innerHTML=arr;
			break;
		default:return false;
	}
	
}

function AddElement(Element_Type){
		var rndnum,content;
		do{ rndnum=top.Rand(1000);}while(doc.getElementById("Item_" + rndnum))
		var div=doc.createElement('<div class="Items" item_type="' + Element_Type + '" style="width:100%;"></div>');
		div.id="Item_" + rndnum;
		var HTML='<span id="' + "Item_" + rndnum + '_label" class="label">默认名称：</span>';
		
		switch(Element_Type)
		{
			case "class":
				content='<select id="Item_' + rndnum + '_class" name="Item_' + rndnum + '_class"></select><label id="Item_' + rndnum + '_class_label" style="padding-left:10px;">填写说明</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改类别属性"></span>';
				break;
			case "text":
				content='<input type="text" id="Item_' + rndnum + '_text" name="Item_' + rndnum + '_text" style="width:200px;"><label id="Item_' + rndnum + '_text_label" style="padding-left:10px;">填写说明</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改文字框属性"></span>';
				break;
			case "link":
				content='<input type="text" id="Item_' + rndnum + '_link" name="Item_' + rndnum + '_link" style="width:200px;"><label id="Item_' + rndnum + '_link_label" style="padding-left:10px;">外链说明</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改外链框属性"></span>';
				break;
			case "tag":
				content='<input type="text" id="Item_' + rndnum + '_tag" name="Item_' + rndnum + '_tag" style="width:200px;"><label id="Item_' + rndnum + '_tag_label" style="padding-left:10px;">（关键字词/标签TAG，以“,”分隔）</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改Tag标签属性"></span>';
				break;
			case "textarea":
				content='<textarea id="Item_' + rndnum + '_textarea" name="Item_' + rndnum + '_textarea" style="width:400px;height:100px;"></textarea><label id="Item_' + rndnum + '_textarea_label" style="padding-left:10px;">填写说明</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改文本区属性"></span>';
				break;
			case "number":
				content='<input type="text" id="Item_' + rndnum + '_number" name="Item_' + rndnum + '_number" style="width:40px;" value="0"><label id="Item_' + rndnum + '_number_label" style="padding-left:10px;">填写说明</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改数字框属性"></span>';
				break;
			case "radio":
				content='<input type="radio" id="Item_' + rndnum + '_radio" name="Item_' + rndnum + '_radio" value="1" style="border:0;" checked class="select"><label id="Item_' + rndnum + '_radio_label_1">单选一</label> '+
						'<input type="radio" id="Item_' + rndnum + '_radio" name="Item_' + rndnum + '_radio" value="2" style="border:0;" class="select"><label id="Item_' + rndnum + '_radio_label_2">单选二</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改单选框属性"></span>';
				break;
			case "checkbox":
				content='<input type="checkbox" id="Item_' + rndnum + '_checkbox_1" name="Item_' + rndnum + '_checkbox_1" value="true" style="border:0;" class="select"><label id="Item_' + rndnum + '_checkbox_label_1">选项说明</label><input name="Item_' + rndnum + '_checkbox_counter" type="hidden" value="1">';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改多选框属性"></span>';
				break;
			case "file":
				content='<input type="file" id="Item_' + rndnum + '_file" name="Item_' + rndnum + '_file" style="width:400px;"><label id="Item_' + rndnum + '_file_label" style="padding-left:10px;">文件类型：*.*</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改文件框属性"></span>';
				break;
			case "upload":
				content='<input type="text" id="Item_' + rndnum + '_upload" name="Item_' + rndnum + '_upload" style="width:200px;"><input type="button" value="查找" onclick="FindUploadFile(\'Item_' + rndnum + '_upload\');" style="height:18px;padding-top:1px;margin-left:4px;"><label id="Item_' + rndnum + '_upload_label" style="padding-left:10px;">文件说明</label>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改文件框属性"></span>';
				break;
			case "pics":
				content='<iframe id="Item_' + rndnum + '_picwin" src="../JCP_Tools/JCP_UploadPics.asp?objectid=' + rndnum + '&type=addpic" frameborder=0 scrolling=no class="borderon_rev" style="margin:0;padding:0;width:520px;height:60px;"></iframe>' +
						'<div>现有：<span id="Item_' + rndnum + '_picscount" style="color:red;">0</span> 幅　<span onclick="pics_Manage(\'Item_' + rndnum + '_pics\',\'up\');" style="cursor:hand;"><span class="up_button"></span>上移</span> <span onclick="pics_Manage(\'Item_' + rndnum + '_pics\',\'down\');" style="cursor:hand;"><span class="down_button"></span>下移</span> <span onclick="pics_Manage(\'Item_' + rndnum + '_pics\',\'mod\');" style="cursor:hand;"><span class="mod_button"></span>修改</span> <span onclick="pics_Manage(\'Item_' + rndnum + '_pics\',\'del\');" style="cursor:hand;"><span class="del_button"></span>删除</span></div>' +
                		'<input type="hidden" id="Item_' + rndnum + '_picsid" name="Item_' + rndnum + '_picsid" value="' + rndnum + '">' +
						'<select name="Item_' + rndnum + '_pics" id="Item_' + rndnum + '_pics" size="10" style="width:540px;"></select>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改多图框属性"></span>';
				break;
			case "edit":
				content='<iframe id="Item_' + rndnum + '_edit" src="../ewebeditor/ewebeditor.htm?id=Item_' + rndnum + '_edit_content" frameborder=0 scrolling=no class="borderon_rev" style="padding-top:0px;width:600px;height:496px;"></iframe>'+
                		'<input type="hidden" id="Item_' + rndnum + '_edit_content" name="Item_' + rndnum + '_edit_content">';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改编辑框属性"></span>';
				break;
			case "button":
				content='<input type="submit" id="Item_' + rndnum + '_submit" name="Item_' + rndnum + '_submit" value=" 确 定 ">　　'+
						'<span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="del_button" onclick="curElement=\'' + "Item_" + rndnum + '\';EditElement(\'del\');" title="删除此项"></span>　　'+
						'<input type="reset" id="Item_' + rndnum + '_reset" name="Item_' + rndnum + '_reset" value=" 重 置 ">';
				HTML='<span class="sys_button">'+content+'</span>';
				break;
			case "map":
				content='纬度<input type="text" id="Item_' + rndnum + '_mapx" name="Item_' + rndnum + '_mapx" style="width:60px;" value="3787440" readonly> 经度<input type="text" id="Item_' + rndnum + '_mapy" name="Item_' + rndnum + '_mapy" style="width:60px;" value="11259944" readonly> 缩放级<input type="text" id="Item_' + rndnum + '_mapzoom" name="Item_' + rndnum + '_mapzoom" style="width:30px;" value="5" readonly>　　<label id="Item_' + rndnum + '_map_label" style="padding-left:10px;">填写说明</label>' +
						'<iframe id="Item_' + rndnum + '_map" src="../JCP_Shared/map.asp?objectid=' + rndnum + '&mapx=3787440&mapy=11259944&mapzoom=5" frameborder=0 scrolling=no class="borderon_rev" style="padding-top:0px;width:600px;height:500px;"></iframe>'+
						'<script language=javascript>document.getElementById("Item_' + rndnum + '_map").src="../JCP_Shared/map.asp?objectid=' + rndnum + '&mapx=" + document.getElementById("Item_' + rndnum + '_mapx").value + "&mapy=" + document.getElementById("Item_' + rndnum + '_mapy").value + "&mapzoom=" + document.getElementById("Item_' + rndnum + '_mapzoom").value;</script>';
				HTML+='<span class="content">'+content+'</span>'+
					  '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + "Item_" + rndnum + '\';getProp(\'' + Element_Type + '\');" title="修改地图项属性"></span>';
				break;
			default: 
				return false;
		}
		
		if(Element_Type=="button") div.innerHTML=HTML;
		else div.innerHTML=HTML+'<span class="del_button" onclick="curElement=\'' + "Item_" + rndnum + '\';EditElement(\'del\');" title="删除此项"></span></span>';
		
		doc.getElementById("ArtSys").appendChild(div);
		
		if(Element_Type=="class"){
			startXmlRequest("POST","../JCP_Script/JCP_Class_JS.asp?itemid=" + rndnum + "&rootid=0",null,"body","eval(xml_BackCont);","",false);
		}
}

function EditElement(Action){
	if(Action=="edit"){
		var Element_Type=dialogArguments.curitem["type"];
		var html;
		
		switch(Element_Type){
			case "class":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">填写说明：</span><span class="text"><input type="text" id="ArtSys_class_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			case "text":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">文字框长度：</span><span class="text"><input type="text" id="ArtSys_text_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">填写说明：</span><span class="text"><input type="text" id="ArtSys_text_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			case "link":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">文字框长度：</span><span class="text"><input type="text" id="ArtSys_link_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">填写说明：</span><span class="text"><input type="text" id="ArtSys_link_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			case "tag":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">标签框长度：</span><span class="text"><input type="text" id="ArtSys_tag_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">填写说明：</span><span class="text"><input type="text" id="ArtSys_tag_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			case "textarea":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">文本区宽度：</span><span class="text"><input type="text" id="ArtSys_textarea_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">文本区高度：</span><span class="text"><input type="text" id="ArtSys_textarea_height" value="' + dialogArguments.curitem.height + '"></span></div>'+
					 '<div class="item"><span class="label">填写说明：</span><span class="text"><input type="text" id="ArtSys_textarea_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			case "number":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">数字框长度：</span><span class="text"><input type="text" id="ArtSys_number_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">填写说明：</span><span class="text"><input type="text" id="ArtSys_number_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			case "radio":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><input type="text" id="radio_name" style="width:130px;"> <input type="button" class="system_button_00" name="Button" value="添加" onclick="if(!BlankYn(radio_name.value)){ArtSys_radio.options[ArtSys_radio.length]=new Option(radio_name.value,radio_name.value);};radio_name.value=\'\';radio_name.focus();"> <input type="button" class="system_button_00" name="Button" value="修改" onclick="if(!BlankYn(radio_name.value)&&IntYn(ArtSys_radio.selectedIndex)){ArtSys_radio.options[ArtSys_radio.selectedIndex]=new Option(radio_name.value,radio_name.value);};radio_name.value=\'\';radio_name.focus();"></div>'+
					 '<div class="item"><select id="ArtSys_radio" size="1" multiple style="width:210px;height:48px;" onchange="radio_name.value=this.value;" onDblClick="if(this.selectedIndex>=0)this.remove(this.selectedIndex);radio_name.value=\'\';">';
					 var temp_exps=dialogArguments.curitem.exps.split("{$|}");
					 for(var i=1;i<=temp_exps.length;i++) html+='  <option value="' + temp_exps[i-1] + '">' + temp_exps[i-1] + '</option>';
				html+='</select></div><div class="item" style="text-align:left;">* 双击可删除　* 默认选中第一项</div>';
				break;
			case "checkbox":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><input type="text" id="checkbox_name" style="width:130px;"> <input type="button" class="system_button_00" name="Button" value="添加" onclick="if(!BlankYn(checkbox_name.value)){ArtSys_checkbox.options[ArtSys_checkbox.length]=new Option(checkbox_name.value,checkbox_name.value);};checkbox_name.value=\'\';checkbox_name.focus();"> <input type="button" class="system_button_00" name="Button" value="修改" onclick="if(!BlankYn(checkbox_name.value)&&IntYn(ArtSys_checkbox.selectedIndex)){ArtSys_checkbox.options[ArtSys_checkbox.selectedIndex]=new Option(checkbox_name.value,checkbox_name.value);};checkbox_name.value=\'\';checkbox_name.focus();"></div>'+
					 '<div class="item"><select id="ArtSys_checkbox" size="1" multiple style="width:210px;height:48px;" onchange="checkbox_name.value=this.value;" onDblClick="if(this.selectedIndex>=0)this.remove(this.selectedIndex);checkbox_name.value=\'\';">';
					 var temp_exps=dialogArguments.curitem.exps.split("{$|}");
					 for(var i=1;i<=temp_exps.length;i++) html+='  <option value="' + temp_exps[i-1] + '">' + temp_exps[i-1] + '</option>';
				html+='</select></div><div class="item" style="text-align:left;">* 双击可删除</div>';
				break;
			case "file":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">文件框长度：</span><span class="text"><input type="text" id="ArtSys_file_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">文件说明：</span><span class="text"><input type="text" id="ArtSys_file_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			case "upload":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">文件框长度：</span><span class="text"><input type="text" id="ArtSys_upload_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">文件说明：</span><span class="text"><input type="text" id="ArtSys_upload_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			case "pics":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">图片库宽度：</span><span class="text"><input type="text" id="ArtSys_pics_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">图片库高度：</span><span class="text"><input type="text" id="ArtSys_pics_size" value="' + dialogArguments.curitem.size + '" onblur="IntCheck(this.value,this);"></span></div>';
				break;
			case "edit":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">编辑框宽度：</span><span class="text"><input type="text" id="ArtSys_edit_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">编辑框高度：</span><span class="text"><input type="text" id="ArtSys_edit_height" value="' + dialogArguments.curitem.height + '"></span></div>';
				break;
			case "map":
				html='<div class="item"><span class="label">标签名称：</span><span class="text"><input type="text" id="ArtSys_label" value="' + dialogArguments.curitem.label + '"></span></div>'+
					 '<div class="item"><span class="label">地图框长度：</span><span class="text"><input type="text" id="ArtSys_map_width" value="' + dialogArguments.curitem.width + '"></span></div>'+
					 '<div class="item"><span class="label">地图框高度：</span><span class="text"><input type="text" id="ArtSys_map_height" value="' + dialogArguments.curitem.height + '"></span></div>'+
					 '<div class="item"><span class="label">填写说明：</span><span class="text"><input type="text" id="ArtSys_map_label" value="' + dialogArguments.curitem.exps + '"></span></div>';
				break;
			default:
				html="error";
		}
		
		if(html=="error") html='<br>属性值获取有误，请及时检查！<br><br><div class="button"><input type="button" class="system_button_00" value=" 取 消 " onclick="window.close();"></button>';
		else html += '<div class="item"><span class="label">排版宽度：</span><span class="text"><input type="text" id="ArtSys_boxwidth" value="' + dialogArguments.curitem.boxwidth + '"></span></div>' +
					 '<div class="button"><input type="button" class="system_button_00" value=" 修 改 " onclick="EditElement(\'update\');"> <input type="button" class="system_button_00" value=" 取 消 " onclick="window.close();"></button>';
		doc.write(html);
	}else if(Action=="update"){
		var Element_Type=dialogArguments.curitem["type"];
		dialogArguments.document.getElementById(dialogArguments.curElement).style.width=ArtSys_boxwidth.value;
		var div='<span id="' + dialogArguments.curElement + '_label" class="label">' + ArtSys_label.value + '</span>';
		switch(Element_Type)
		{
			case "class":
				div=ArtSys_label.value + "{$|}" + ArtSys_class_label.value;
				break;
			case "text":
				var content='<input type="text" id="' + dialogArguments.curElement + '_text" name="' + dialogArguments.curElement + '_text" style="width:' + ArtSys_text_width.value + ';">';
				content+='<label id="' + dialogArguments.curElement + '_text_label" style="padding-left:10px;">' + ArtSys_text_label.value + '</label>'
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改文字框属性"></span>';
				break;
			case "link":
				var content='<input type="text" id="' + dialogArguments.curElement + '_link" name="' + dialogArguments.curElement + '_link" style="width:' + ArtSys_link_width.value + ';">';
				content+='<label id="' + dialogArguments.curElement + '_link_label" style="padding-left:10px;">' + ArtSys_link_label.value + '</label>'
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改外链框属性"></span>';
				break;
			case "tag":
				var content='<input type="text" id="' + dialogArguments.curElement + '_tag" name="' + dialogArguments.curElement + '_tag" style="width:' + ArtSys_tag_width.value + ';">';
				content+='<label id="' + dialogArguments.curElement + '_tag_label" style="padding-left:10px;">' + ArtSys_tag_label.value + '</label>'
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改Tag标签属性"></span>';
				break;
			case "textarea":
				var content='<textarea id="' + dialogArguments.curElement + '_textarea" name="' + dialogArguments.curElement + '_textarea" style="width:' + ArtSys_textarea_width.value + ';height:' + ArtSys_textarea_height.value + ';"></textarea>';
				content+='<label id="' + dialogArguments.curElement + '_textarea_label" style="padding-left:10px;">' + ArtSys_textarea_label.value + '</label>'
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改文本区属性"></span>';
				break;
			case "number":
				var content='<input type="text" id="' + dialogArguments.curElement + '_number" name="' + dialogArguments.curElement + '_number" style="width:' + ArtSys_number_width.value + ';" value="0">';
				content+='<label id="' + dialogArguments.curElement + '_number_label" style="padding-left:10px;">' + ArtSys_number_label.value + '</label>'
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改数字框属性"></span>';
				break;
			case "radio":
				var checked=" checked";
				var content="";
				for(i=1;i<=ArtSys_radio.length;i++){
					if(i>1) checked="";
					content+='<input type="radio" id="' + dialogArguments.curElement + '_radio" name="' + dialogArguments.curElement + '_radio" value="' + i + '" style="border:0;"' + checked + ' class="select"><label id="' + dialogArguments.curElement + '_radio_label_' + i + '">'+ ArtSys_radio.options[i-1].value + '</label> ';
				}
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改单选框属性"></span>';
				break;
			case "checkbox":
				var checked=" checked";
				var content="";
				for(i=1;i<=ArtSys_checkbox.length;i++){
					if(ArtSys_checkbox.options[i-1].selected){checked=" checked";}else{checked="";}
					content+='<input type="checkbox" id="' + dialogArguments.curElement + '_checkbox_' + i + '" name="' + dialogArguments.curElement + '_checkbox_' + i + '" value="true" style="border:0;"' + checked + ' class="select"><label id="' + dialogArguments.curElement + '_checkbox_label_' + i + '">'+ ArtSys_checkbox.options[i-1].value + '</label> ';
				}
				div+='<span class="content">'+content+'<input name="' + dialogArguments.curElement + '_checkbox_counter" type="hidden" value="' + ArtSys_checkbox.length + '"></span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改多选框属性"></span>';
				break;
			case "file":
				var content='<input type="file" id="' + dialogArguments.curElement + '_file" name="' + dialogArguments.curElement + '_file" style="width:' + ArtSys_file_width.value + ';">';
				content+='<label id="' + dialogArguments.curElement + '_file_label" style="padding-left:10px;">' + ArtSys_file_label.value + '</label>'
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改文件框属性"></span>';
				break;
			case "upload":
				var content='<input type="text" id="' + dialogArguments.curElement + '_upload" name="' + dialogArguments.curElement + '_upload" style="width:' + ArtSys_upload_width.value + ';"><input type="button" value="查找" onclick="FindUploadFile(\'' + dialogArguments.curElement + '_upload\');" style="height:18px;padding-top:1px;margin-left:4px;">';
				content+='<label id="' + dialogArguments.curElement + '_upload_label" style="padding-left:10px;">' + ArtSys_upload_label.value + '</label>'
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改文字框属性"></span>';
				break;
			case "pics":
				var temp_objectid=dialogArguments.curElement.replace("Item_","");
				var content='<iframe id="Item_' + temp_objectid + '_picwin" src="../JCP_Tools/JCP_UploadPics.asp?objectid=' + temp_objectid + '&type=addpic" frameborder=0 scrolling=no class="borderon_rev" style="margin:0;padding:0;width:520px;height:60px;"></iframe>' +
							'<div>现有：<span id="Item_' + temp_objectid + '_picscount" style="color:red;">0</span> 幅　<span onclick="pics_Manage(\'Item_' + temp_objectid + '_pics\',\'up\');" style="cursor:hand;"><span class="up_button"></span>上移</span> <span onclick="pics_Manage(\'Item_' + temp_objectid + '_pics\',\'down\');" style="cursor:hand;"><span class="down_button"></span>下移</span> <span onclick="pics_Manage(\'Item_' + temp_objectid + '_pics\',\'mod\');" style="cursor:hand;"><span class="mod_button"></span>修改</span> <span onclick="pics_Manage(\'Item_' + temp_objectid + '_pics\',\'del\');" style="cursor:hand;"><span class="del_button"></span>删除</span></div>' +
							'<input type="hidden" id="Item_' + temp_objectid + '_picsid" name="Item_' + temp_objectid + '_picsid" value="' + temp_objectid + '">' +
							'<select name="Item_' + temp_objectid + '_pics" id="Item_' + temp_objectid + '_pics" size="' + ArtSys_pics_size.value + '" style="width:' + ArtSys_pics_width.value + ';"></select>';
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改文件框属性"></span>';
				break;
			case "edit":
				var content='<iframe id="' + dialogArguments.curElement + '_edit" src="../ewebeditor/ewebeditor.htm?id=' + dialogArguments.curElement + '_edit_content" frameborder=0 scrolling=no class="borderon_rev" style="padding-top:0px;width:' + ArtSys_edit_width.value + ';height:' + ArtSys_edit_height.value + ';"></iframe>'+
                			'<input type="hidden" id="' + dialogArguments.curElement + '_edit_content" name="' + dialogArguments.curElement + '_edit_content">';
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改编辑框属性"></span>';
				break;
			case "map":
				var content='纬度<input type="text" id="' + dialogArguments.curElement + '_mapx" name="' + dialogArguments.curElement + '_mapx" style="width:60px;" value="3787440" readonly> 经度<input type="text" id="' + dialogArguments.curElement + '_mapy" name="' + dialogArguments.curElement + '_mapy" style="width:60px;" value="11259944" readonly> 缩放级<input type="text" id="' + dialogArguments.curElement + '_mapzoom" name="' + dialogArguments.curElement + '_mapzoom" style="width:30px;" value="5" readonly>　　<label id="' + dialogArguments.curElement + '_map_label" style="padding-left:10px;">'+ArtSys_map_label.value+'</label>' +
						'<iframe id="' + dialogArguments.curElement + '_map" src="" frameborder=0 scrolling=no class="borderon_rev" style="padding-top:0px;width:'+ArtSys_map_width.value+';height:'+ArtSys_map_height.value+';"></iframe>' +
						'<script language=javascript>document.getElementById("' + dialogArguments.curElement + '_map").src="../JCP_Shared/map.asp?objectid=' + dialogArguments.curElement.replace("Item_","") + '&mapx=" + document.getElementById("' + dialogArguments.curElement + '_mapx").value + "&mapy=" + document.getElementById("' + dialogArguments.curElement + '_mapy").value + "&mapzoom=" + document.getElementById("' + dialogArguments.curElement + '_mapzoom").value;</script>';
				div+='<span class="content">'+content+'</span>'+
					 '<span class="tools"><span class="up_button" onclick="SwapItem(this,\'up\')"></span><span class="down_button" onclick="SwapItem(this,\'down\')"></span><span class="mod_button" onclick="curElement=\'' + dialogArguments.curElement + '\';getProp(\'' + Element_Type + '\');" title="修改地图项属性"></span>';
				break;
			default: 
				return false;
		}
		
		if(Element_Type!="class") div+='<span class="del_button" onclick="curElement=\'' + dialogArguments.curElement + '\';EditElement(\'del\');" title="删除此项"></span>';
		window.returnValue=div;
		window.close();
	}else if(Action=="del"){
		//var YN=confirm("您确定要删除当前项？？");
		//if(YN) 
			doc.getElementById(curElement).removeNode(true);
	}
}

function SwapItem(o,type){
	var curr_item=o.parentNode.parentNode;
	if(type=="up"&&curr_item.previousSibling!=null){
		curr_item.swapNode(curr_item.previousSibling);
	}else if(type=="down"&&curr_item.nextSibling!=null){
		curr_item.swapNode(curr_item.nextSibling);
	}
}

function SaveBook(){
	if(!LogoCheck()) return false;
	var root=doc.getElementById("ArtSys").childNodes;
	if(root.length>0){
		var xml="<?xml version=\"1.0\" encoding=\"gb2312\"?>" + "\r" + "<root>" + "\r";
		for(i=0;i<root.length;i++){
			curElement=root[i];
			var temp_item_type=curElement.getAttribute("item_type");
			var temp_label="";
			var temp_item_name="";
			var temp_content="";
			if(temp_item_type=="radio"){
				for(var j=1;j<doc.getElementsByName(curElement.id + "_" + temp_item_type).length;j++){
					if(j>1) temp_label+="{$|}" + doc.getElementById(curElement.id + "_" + temp_item_type + "_label_" + j).innerText;
					else temp_label=doc.getElementById(curElement.id + "_" + temp_item_type + "_label_" + j).innerText;
				}
			}else if(temp_item_type=="checkbox"){
				for(var j=1;j<=eval(curElement.id + "_checkbox_counter").value;j++){
					if(j>1) temp_label+="{$|}" + doc.getElementById(curElement.id + "_" + temp_item_type + "_label_" + j).innerText;
					else temp_label=doc.getElementById(curElement.id + "_" + temp_item_type + "_label_" + j).innerText;
				}
			}else if(temp_item_type!="button"&&temp_item_type!="edit"&&temp_item_type!="pics"){
				temp_label=doc.getElementById(curElement.id + "_" + temp_item_type + "_label").innerText;
			}
			if(temp_item_type=="button") temp_item_name="";
				else temp_item_name=doc.getElementById(curElement.id + "_label").innerText;
			if(temp_item_type=="class") temp_content=eval(curElement.id + "_class").value;
				else temp_content=curElement.outerHTML.replace(/(<)/g,"[[").replace(/(>)/g,"]]").replace(/(\&)/g,"＆").replace(/(\+)/g,"＋");
			xml+='	<item>' + "\r";
			xml+='		<sys_id>' + SysId + '</sys_id>' + "\r" +
				 '		<sys_name>' + sysname.value + '</sys_name>' + "\r" +
				 '		<sys_logo>' + syslogo.value + '</sys_logo>' + "\r" +
				 '		<item_id>' + curElement.id + '</item_id>' + "\r" +
				 '		<item_type>' + temp_item_type + '</item_type>' + "\r" +
				 '		<item_name>' + temp_item_name + '</item_name>' + "\r" +
				 '		<item_label>' + temp_label + '</item_label>' + "\r" +
				 '		<item_content>' + temp_content + '</item_content>' + "\r" +
				 '		<item_order>' + (i+1) + '</item_order>' + "\r";
			xml+='	</item>' + "\r";
		}
		xml+='</root>';
		//alert(xml);
		startXmlRequest("POST","JCP_ArtSys_Action.asp",UrlEncoding(xml),"body","eval(xml_BackCont);","",false)
		
	}else{
		alert("失败：定制页面不包含任何内容！");
		//location.reload();
		return false;
	}
}

function LogoCheck(){
	startXmlRequest("POST","JCP_ArtSys_Action.asp?action=logocheck&menuid=" + SysId + "&menulogo=" + doc.getElementById("syslogo").value,null,"body","","",false);
	if(xml_BackCont=="OK"){
		return true;
	}else{
		alert("系统的标识已经存在，请重新修改！");
		doc.getElementById("syslogo").focus();
		doc.getElementById("syslogo").select();
		return false;
	}
}

//////////////////////////////////////


function pics_Manage(obj,type){
	var o=doc.getElementById(obj);
	if(o.length>0){
		if(o.selectedIndex>-1){
			if(type=="del"){
				if(confirm("您确定要从组图中删除当前图片？？")){
					startXmlRequest("POST","JCP_ArtAction_XML.asp?actid=0&action=delpics?curl=" + o.value,null,"body","","",false)
					if(xml_BackCont=="OK"){
						o.options.remove(o.selectedIndex);
						doc.getElementById(o.id + "count").innerHTML=o.length;
					}else{
						alert("图片删除出错！");
					}
				}
				doc.getElementById(obj.replace("pics","picwin")).src='../JCP_Tools/JCP_UploadPics.asp?objectid=' + obj.replace("_pics","").replace("Item_","") + '&type=editpic';
			}else if(type=="mod"&&o.selectedIndex>-1){
				doc.getElementById(obj.replace("pics","picwin")).src='../JCP_Tools/JCP_UploadPics.asp?objectid=' + obj.replace("_pics","").replace("Item_","") + '&type=editonepic&orderid=' + (o.selectedIndex+1).toString();
			}else if(type=="up"&&o.selectedIndex>0){
				startXmlRequest("POST","JCP_ArtAction_XML.asp?actid=" + (o.selectedIndex+1) + "&action=uppics",null,"body","","",false)
				if(xml_BackCont=="OK"){
					var picvalue=o.value;
					var pictitle=o.options[o.selectedIndex].innerText;
					var picid=o.selectedIndex;
					o.options[picid]=new Option(o.options[picid-1].innerText,o.options[picid-1].value);
					o.options[picid-1]=new Option(pictitle,picvalue);
					o.selectedIndex=picid-1;
				}else{
					alert("图片库纪录上移出错！");
					alert(xml_BackCont);
				}
				doc.getElementById(obj.replace("pics","picwin")).src='../JCP_Tools/JCP_UploadPics.asp?objectid=' + obj.replace("_pics","").replace("Item_","") + '&type=editpic';
			}else if(type=="down"&&o.selectedIndex<o.length-1){
				startXmlRequest("POST","JCP_ArtAction_XML.asp?actid=" + (o.selectedIndex+1) + "&action=downpics",null,"body","","",false)
				if(xml_BackCont=="OK"){
					var picvalue=o.value;
					var pictitle=o.options[o.selectedIndex].innerText;
					var picid=o.selectedIndex;
					o.options[picid]=new Option(o.options[picid+1].innerText,o.options[picid+1].value);
					o.options[picid+1]=new Option(pictitle,picvalue);
					o.selectedIndex=picid+1;
				}else{
					alert("图片库纪录下移出错！");
					alert(xml_BackCont);
				}
				doc.getElementById(obj.replace("pics","picwin")).src='../JCP_Tools/JCP_UploadPics.asp?objectid=' + obj.replace("_pics","").replace("Item_","") + '&type=editpic';
			}
		}else alert("请选择操作的图片！");
	}else alert("组图中不存在记录！");
}