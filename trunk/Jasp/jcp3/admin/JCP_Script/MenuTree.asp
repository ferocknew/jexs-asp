// JavaScript Document
	var doc = document;

	function ChangeStatus(o)
	{
		if (o.parentNode)
		{
			startXmlRequest("GET","../JCP_Menu/JCP_Menu_Action.asp?action=opened&id=" + o.parentNode.getAttribute("menuid"),null,"body","","",false);
			if(xml_BackCont=="OK"){
				if (o.parentNode.className == "Opened GuideTopMenu")
				{
					o.parentNode.className = "Closed GuideTopMenu";
				}
				else
				{
					o.parentNode.className = "Opened GuideTopMenu";
				}
			}else{
				if (o.parentNode.className == "Opened GuideTopMenu")
				{
					alert("类别树收起出错！");
					document.write(xml_BackCont);
				}
				else
				{
					alert("类别树展开出错！");
				}
			}
		}
	}

	function ChangeStatus_NoData(o)
	{
		if (o.parentNode)
		{
			if (o.parentNode.className == "Opened")
			{
				o.parentNode.className = "Closed";
			}
			else
			{
				o.parentNode.className = "Opened";
			}
		}
	}
	
	function ChangeTitle(o,id,type){
		if(id==0) o.outerHTML='<input type="text" id="changing_title" style="border:1px dotted black;font:12px tahoma,宋体,sans-serif;" value="' + o.innerText + '" onBlur="javascript:ChangeTitle_over(this,' + id + ',\'' + type + '\');" onKeyPress="javascript:if(event.keyCode==13)this.blur();">';
		else{
			if(o.innerText=="No Name"){
				o.outerHTML='<input type="text" id="changing_title" style="border:1px dotted black;font:12px tahoma,宋体,sans-serif;" title="" value="" onBlur="javascript:ChangeTitle_over(this,' + id + ',\'' + type + '\');" onKeyPress="javascript:if(event.keyCode==13)this.blur();">';
			}else{
				o.outerHTML='<input type="text" id="changing_title" style="border:1px dotted black;font:12px tahoma,宋体,sans-serif;" title="' + o.innerText + '" value="' + o.innerText + '" onBlur="javascript:ChangeTitle_over(this,' + id + ',\'' + type + '\');" onKeyPress="javascript:if(event.keyCode==13)this.blur();">';
			}
		}
		changing_title.focus();
		changing_title.select();
	}
	
	function ChangeTitle_over(o,id,type){   //id: 添加时传递parentid，修改时传递自身menuid
		if(type=="add"||type=="mod"){
			if(BlankYn(o.value)){
				if(type=="add"){
					Tree_Item_Delete(o);
				}else if(type=="mod"){
					o.value=o.title;
					alert("类别名称不能为空！");
					if(event.keyCode!=13){
						o.focus();
						o.select();
					}
				}
				return false;
			}else{
				if(o.value==o.title){
					o.outerHTML='<span class="menuitem" onDblClick="javascript:ChangeTitle(this,' + id + ',\'' + type + '\');" oncontextmenu="javascript:return PopupMouseRightButtonUpMenu(this,' + id + ');">' + o.value + '</span>';
				}else{
					startXmlRequest("GET","JCP_Menu_Action.asp?action=" + type + "&id=" + id + "&menuname=" + escape(o.value),null,"body","Tree_Result(" + o.id + ",'" + type + "')","",true);
				}
			}
		}else if(type=="del"){
			MouseMenu.style.visibility="hidden";
			var delYn=confirm("您确定要删除当前分类项？？");
			if(delYn) startXmlRequest("GET","JCP_Menu_Action.asp?action=" + type + "&id=" + id,null,"body","Tree_Item_Delete(Tree_obj)","",true);
			else return false;
		}
	}
		
	function Menu_Next(o){
		top.frames['menus_box'].location.reload();
	}
	
	function Menu_Add(o,parentid){
		var addyn;
		if(o.parentNode.childNodes[2]){
			if(o.parentNode.childNodes[2].getAttribute("bindtype")==0) addyn=true;
			else addyn=false;
		}else{
			addyn=true;
		}
		if((parentid>0 && addyn)||parentid==0){
			if(o.parentNode.className=="Closed") ChangeStatus(o);
			if(parentid>0){
				var temp_ul="tree_item_" + o.parentNode.getAttribute("menuid").toString();
				var ul=doc.getElementById(temp_ul);
				var img=doc.createElement('<img class=s src="../JCP_Skin/<%= session("SystemSkin") %>/tree/s.gif">');
				var span=doc.createElement('<span></span>');
				var li=doc.createElement('<li class="Child"></li>');
				span.innerText="";
				li.appendChild(img);
				li.appendChild(span);
				if(ul){
					ul.appendChild(li);
				}else{
					ul=doc.createElement('<ul></ul>');
					ul.id="tree_item_" + parentid;
					ul.appendChild(li);
					o.parentNode.appendChild(ul);
				}
			}else{
				var img=doc.createElement('<img class=s src="../JCP_Skin/<%= session("SystemSkin") %>/tree/s.gif">');
				var span=doc.createElement('<span></span>');
				var li=doc.createElement('<li class="Opened"></li>');
				//var ul=doc.createElement('<ul></ul>');
				span.innerText="";
				li.appendChild(img);
				li.appendChild(span);
				//ul.appendChild(li);
				//o.appendChild(ul);
				o.childNodes[0].appendChild(li);
			}
			ChangeTitle(span,parentid,"add");
		}else{
			MouseMenu.style.visibility='hidden';
			alert("已经绑定的项不能添加子类别！");
			return false;
		}
	}
	
	function Tree_Result(o,type){
		if(IntYn(xml_BackCont)){
			if(type=="add"){
				if(o.parentNode.parentNode.parentNode.tagName=="LI"){
					o.parentNode.parentNode.parentNode.className="Opened";
					o.parentNode.parentNode.parentNode.childNodes[0].outerHTML='<img class=s src="../JCP_Skin/<%= session("SystemSkin") %>/tree/s.gif" onclick="javascript:ChangeStatus(this);">';
					o.parentNode.outerHTML='<li class="Child" menuid="' + xml_BackCont + '"><img class=s src="../JCP_Skin/<%= session("SystemSkin") %>/tree/s.gif"><span class="menuitem" onDblClick="javascript:ChangeTitle(this,' + xml_BackCont + ',\'mod\');" oncontextmenu="javascript:return PopupMouseRightButtonUpMenu(this,' + xml_BackCont + ');">' + o.value + '</span></li>';
				}else if(o.parentNode.parentNode.parentNode.tagName=="DIV"){
					o.parentNode.outerHTML='<li class="Opened" menuid="' + xml_BackCont + '"><img class=s src="../JCP_Skin/<%= session("SystemSkin") %>/tree/s.gif"><span class="menuitem" onDblClick="javascript:ChangeTitle(this,' + xml_BackCont + ',\'mod\');" oncontextmenu="javascript:return PopupMouseRightButtonUpMenu(this,' + xml_BackCont + ');">' + o.value + '</span></li>';
				}
			}else{
				o.outerHTML='<span class="menuitem" onDblClick="javascript:ChangeTitle(this,' + xml_BackCont + ',\'mod\');" oncontextmenu="javascript:return PopupMouseRightButtonUpMenu(this,' + xml_BackCont + ');">' + o.value + '</span>';
			}
			//alert("分类操作成功！");
		}else{
			alert("分类增加有误，请检查！");
			if(event.keyCode!=13){
				o.focus();
				o.select();
			}
			return false;
		}
	}
	
	function Tree_Item_Delete(o){
		if(o.parentNode.parentNode.childNodes.length==1){
			if(o.parentNode.parentNode.parentNode.parentNode.parentNode.tagName=="LI"){
				o.parentNode.parentNode.parentNode.className="Child";
				o.parentNode.parentNode.parentNode.childNodes[0].outerHTML='<img class=s src="../JCP_Skin/<%= session("SystemSkin") %>/tree/s.gif">';
			}else if(o.parentNode.parentNode.parentNode.parentNode.parentNode.tagName=="DIV"){
				o.parentNode.parentNode.parentNode.childNodes[0].outerHTML='<img class=s src="../JCP_Skin/<%= session("SystemSkin") %>/tree/s.gif">';
			}
			//if(o.parentNode.parentNode.parentNode.tagName=="DIV") top.frames['menus_box'].location.reload();
			o.parentNode.parentNode.removeNode(true);
		}
		else o.parentNode.removeNode(true);
	}