// JavaScript Document
var Tree_obj,Tree_id;
var MenuBarColor ='<%= session("Color_Dip") %>';


function PopupMouseRightButtonUpMenu(o,id){
	Tree_obj=o;
	Tree_id=id;
	if(MouseMenu.style.visibility=='visible') MouseMenu.style.visibility='hidden';
	if (event.clientX+150 > document.body.clientWidth) MouseMenu.style.left=event.clientX+document.body.scrollLeft-150;
		 else MouseMenu.style.left=event.clientX+document.body.scrollLeft;
	if (event.clientY+DivH > document.body.clientHeight) MouseMenu.style.top=event.clientY+document.body.scrollTop-DivH;
		 else MouseMenu.style.top=event.clientY+document.body.scrollTop;
	MouseMenu.style.visibility='visible';
	return false;
}

function DrawMouseRightButtonUpMenu(){
	DivH=2;
	//oSelection = document.selection;
	var HrStr='<tr><td align=\"center\" valign=\"middle\" height=\"2\"><TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"128\" height=\"2\"><tr><td height=\"1\" bgcolor=\"<%= session("Color_Dip") %>\"><\/td><\/tr><tr><td height=\"1\" bgcolor=\"<%= session("Color_fleet") %>\"><\/td><\/tr><\/TABLE><\/td><\/tr>';
	var MenuItemStr1='<tr><td align=\"center\" valign=\"middle\" height=\"20\"><TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"132\"><tr><td valign=\"middle\" height=\"16\" class=\"MouseOut\" onMouseOver=\"this.className=\'MouseOver\'\" onMouseOut=\"this.className=\'MouseOut\'\" onclick=\"'
	var MenuItemStr2="<\/td><\/tr><\/TABLE><\/td><\/tr>";

	var ManageMenu=[
				 'javascript:ChangeTitle(Tree_obj,Tree_id,\'mod\');\">　修改当前项',
				 'javascript:Menu_Add(Tree_obj,Tree_id);\">添加子分类',
				 'javascript:ChangeTitle_over(Tree_obj,Tree_id,\'del\');\">删除 ...',
				 'javascript:Move(Tree_obj,Tree_id,\'up\');\">上移 ↑',
				 'javascript:Move(Tree_obj,Tree_id,\'down\');\">下移 ↓',
				 'javascript:MenuBindUrl(Tree_obj,Tree_id);\">绑定至地址',
				 'javascript:MenuBindSys(Tree_obj,Tree_id);\">绑定至系统',
				 'javascript:MenuBindClass(Tree_obj,Tree_id,3);\">绑定至分类(显示根类)',
				 'javascript:MenuBindClass(Tree_obj,Tree_id,4);\">绑定至分类(不显根类)',
				 'javascript:MenuBindClear(Tree_obj,Tree_id);\">撤销绑定',
				 'javascript:ChangeType(Tree_obj,Tree_id);\">变更属性'
				];

	var MenuStr='';
	
	for(i=0;i<ManageMenu.length;i++)
	   {
		MenuStr+=MenuItemStr1+ManageMenu[i]+MenuItemStr2;
		DivH+=20;
		
		if(i==2||i==4||i==8){
			MenuStr+=HrStr;
			DivH+=2;
		}
	   }
   
	if(ManageMenu.length>0)
	  {
	   MenuStr+=HrStr;
	   DivH+=2;
	  }

	var aboutMenu=[
				'MouseMenu.style.visibility=\'hidden\';alert(\'感谢您使用晋唐产品！\')">关于 ...'
				]
	for(i=0;i<aboutMenu.length;i++)
	   {
		MenuStr+=MenuItemStr1+aboutMenu[i]+MenuItemStr2;
		DivH+=20;
	   }

	var MenuTop = '<DIV id=\"MouseMenu\" class=\"div1\" style=\"position:absolute; left:0px; top:0px; width=150;height='+DivH+'; z-index:1; visibility:hidden;\" oncontextmenu=\"javascript:return false;\">\n' +
				 '<TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"div2\">\n' +
				 '<tr>\n' +
				 '<td bgcolor=\"' + MenuBarColor+ '\" width=\"50\" valign=\"top\" align=\"center\" style=\"padding:4px 0 0 0;\"><font color=\"<%= session("Color_fleet") %>\">分类管理</font>\n' +
				 '<\/td>\n'+ 
				 '<td bgcolor=\"<%= session("Color_Main") %>\">\n'+ 
				 '<TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\">';
	var MenuBottom = '<\/TABLE><\/td><\/tr><\/TABLE><\/DIV>';
	document.write(MenuTop+MenuStr+MenuBottom);

	document.body.onclick=new Function('if(event.srcElement.tagName !=\'INPUT\') MouseMenu.style.visibility=\'hidden\'');
	document.body.onscroll=new Function('MouseMenu.style.visibility=\'hidden\';');
	document.body.onselectstart=new Function('MouseMenu.style.visibility=\'hidden\';');
	window.onresizestart=new Function('MouseMenu.style.visibility=\'hidden\';');
}
