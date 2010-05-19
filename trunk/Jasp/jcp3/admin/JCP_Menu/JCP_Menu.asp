<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Menu.css" rel="stylesheet" type="text/css">
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/tree.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/MenuTree.asp"></script>
<script language="JavaScript" src="../JCP_Script/Menu_PopMenu.asp"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
	DrawMouseRightButtonUpMenu()
	
	function MenuBindClass(o,id,type){	//type=3 显示根类别    type=4 不显示根类别
		MouseMenu.style.visibility='hidden';
		if(id>0){
			if(doc.getElementById("tree_item_" + id)){
				alert("不能为含有子类别的项设置绑定操作！");
			}else{
				var binddiv,bindclass=0;
				if(!o.parentNode.childNodes[2]){
					binddiv=doc.createElement('<span bindtype="0" bindcont="" class="bindstate"></span>');
					binddiv.id="Band" + id;
					o.parentNode.appendChild(binddiv);
				}else{
					binddiv=o.parentNode.childNodes[2];
					if(binddiv.getAttribute("bindtype")>0&&binddiv.getAttribute("bindtype")!=3&&binddiv.getAttribute("bindtype")!=4){
						alert("已经绑定项，不能再绑定至栏目！");
						return false;
					}else if(binddiv.getAttribute("bindtype")==3||binddiv.getAttribute("bindtype")==4){
						bindclass=binddiv.getAttribute("bindcont");
					}else if(binddiv.getAttribute("bindtype")==0){
						bindclass=0;
					}else{
						alert("错误的绑定参数！");
						return ;
					}
				}
				var arr=ModelWin("JCP_Menu_ClassList.asp?actid=" + bindclass,300,80);
				if(IntYn(arr)){
					try{
						if(arr!=binddiv.getAttribute("bindcont")||type!=parseInt(binddiv.getAttribute("bindtype"))){
							startXmlRequest("GET","JCP_Menu_Action.asp?action=classbind&menuid=" + id + "&classid=" + arr + "&bindtype=" + type,null,"body","","",false);
							if(xml_BackCont=="OK"){
								if(type==3){
									binddiv.innerHTML="<font color=red>绑至栏目 [ID=" + arr + "] (显示根类)</font>";
									binddiv.setAttribute("bindtype",3)
								}else if(type==4){
									binddiv.innerHTML="<font color=red>绑至栏目 [ID=" + arr + "] (不显根类)</font>";
									binddiv.setAttribute("bindtype",4)
								}
								binddiv.setAttribute("bindcont",arr)
							}else{
								alert("导航绑定栏目操作出错！");
								//doc.write(xml_BackCont);
							}
						}
					}catch(e){
						alert("绑定ID传递有误！");
						return false;
					}
				}else{
					return false;
				}
			}
		}
	}
	
	function MenuBindUrl(o,id){
		MouseMenu.style.visibility='hidden';
		if(id>0){
			if(doc.getElementById("tree_item_" + id)){
				alert("不能为含有子类别的项设置绑定操作！");
			}else{
				var binddiv;
				if(!o.parentNode.childNodes[2]){
					binddiv=doc.createElement('<span id="Band' + id + '" bindtype="0" bindcont="" class="bindstate"></span>');
					o.parentNode.appendChild(binddiv);
				}else{
					binddiv=o.parentNode.childNodes[2];
					if(binddiv.getAttribute("bindtype")>0&&binddiv.getAttribute("bindtype")!=1){
						alert("已经绑定项，不能再绑定至地址！");
						return false;
					}
				}
				var filePath = FindServerFile();
				if(filePath) filePath=filePath.toLowerCase();
				if(filePath=="nofile"||!filePath){
					return false;
				}else{
					try{
						if(filePath!=binddiv.innerText){
							startXmlRequest("GET","JCP_Menu_Action.asp?action=urlbind&menuid=" + id + "&url=" + filePath.replace(/&/g,"—"),null,"body","","",false);
							if(xml_BackCont=="OK"){
								binddiv.innerHTML=filePath;
								binddiv.setAttribute("bindtype","1");
								binddiv.setAttribute("bindcont",filePath);
							}else{
								alert("导航绑定地址出错！");
								//doc.write(xml_BackCont);
							}
						}
					}catch(e){
						alert("绑定地址传递有误！");
						return false;
					}
				}
			}
		}
	}
	
	function MenuBindSys(o,id){
		MouseMenu.style.visibility='hidden';
		if(id>0){
			if(doc.getElementById("tree_item_" + id)){
				alert("不能为含有子类别的项设置绑定操作！");
			}else{
				var binddiv,bindclass=0;
				if(!o.parentNode.childNodes[2]){
					binddiv=doc.createElement('<span bindtype="0" bindcont="" class="bindstate"></span>');
					binddiv.id="Band" + id;
					o.parentNode.appendChild(binddiv);
				}else{
					binddiv=o.parentNode.childNodes[2];
					if(binddiv.getAttribute("bindtype")>0&&binddiv.getAttribute("bindtype")!=2){
						alert("已经绑定项，不能再绑定至系统！");
						return false;
					}else if(binddiv.getAttribute("bindtype")==2){
						bindclass=binddiv.getAttribute("bindcont");
					}else if(binddiv.getAttribute("bindtype")==0){
						bindclass=0;
					}
				}
				var arr=ModelWin("JCP_Menu_SysList.asp?actid=" + bindclass,300,80);
				if(IntYn(arr)){
					try{
						if(arr!=binddiv.getAttribute("bindcont")){
							startXmlRequest("GET","JCP_Menu_Action.asp?action=sysbind&menuid=" + id + "&sysid=" + arr,null,"body","","",false);
							if(xml_BackCont=="OK"){
								binddiv.innerHTML="<font color=blue>绑至系统 [ID=" + arr + "]</font>";
								binddiv.setAttribute("bindtype",2)
								binddiv.setAttribute("bindcont",arr)
							}else{
								alert("导航绑定系统操作出错！");
								//doc.write(xml_BackCont);
							}
						}
					}catch(e){
						alert("绑定ID传递有误！");
						return false;
					}
				}else{
					return false;
				}
			}
		}
	}
	
	function MenuBindClear(o,id){
		if(confirm("您确定要撤销当前的绑定设置？？")){
			if(o.parentNode.childNodes[2]&&(o.parentNode.childNodes[2].getAttribute("bindid")>0||o.parentNode.childNodes[2].innerText!="")){
				startXmlRequest("GET","JCP_Menu_Action.asp?action=clearbind&menuid=" + id,null,"body","","",false);
				if(xml_BackCont=="OK"){
					o.parentNode.childNodes[2].innerHTML="";
					o.parentNode.childNodes[2].setAttribute("bindtype",0);
					o.parentNode.childNodes[2].setAttribute("bindcont","");
				}else{
					alert("撤销导航绑定出错！");
				}
			}else{
				alert("当前类别项不能执行撤销绑定操作！");
			}
		}
	}
	
	function Move(o,id,type){
		MouseMenu.style.visibility='hidden';
		if(type=="up"){
			if(o.parentNode.previousSibling){
				var curid=id;
				var actid=o.parentNode.previousSibling.getAttribute("menuid");
				startXmlRequest("GET","JCP_Menu_Action.asp?action=upsibling&curid=" + curid + "&actid=" + actid,null,"body","","",false);
				if(xml_BackCont=="OK"){
					o.parentNode.swapNode(o.parentNode.previousSibling);
				}else{
					alert("向上移动出错！");
					doc.write(xml_BackCont);
				}
			}else alert("不能再向上移动！");
		}else if(type=="down"){
			if(o.parentNode.nextSibling){
				var curid=id;
				var actid=o.parentNode.nextSibling.getAttribute("menuid");
				startXmlRequest("GET","JCP_Menu_Action.asp?action=downsibling&curid=" + curid + "&actid=" + actid,null,"body","","",false);
				if(xml_BackCont=="OK"){
					o.parentNode.swapNode(o.parentNode.nextSibling);
				}else{
					alert("向下移动出错！");
					doc.write(xml_BackCont);
				}
			}else alert("不能再向下移动！");
		}
	}

	function ChangeType(o,id){
		MouseMenu.style.visibility='hidden';
		var arr=ModelWin("JCP_Menu_TypeSet.asp?menuid=" + id,300,80);
		if(arr=="OK"){
			alert("成功修改当前栏目的属性值！");
			top.frames["menus_box"].location.reload();
		}
	}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	
	<% 
		dim rs,i,cur_menuid,cur_menugrade,cur_topmenuid,menuname,rootid,sql,opened,bindyn
		response.write "<div class=""app_title"">系统导航</div>"&vbcrlf
		sql="select * from JCP_menus order by orderid"
		response.write "<div class=""manage_button"" style=""width:100px;"" onclick=""Menu_Add(doc.getElementById('CategoryTree'),0);"">创建导航分类</div>"&vbcrlf
		response.write "<div class=""manage_button"" style=""width:100px;"" onclick=""javascript:top.frames['menus_box'].location.reload();"">>> 更新导航</div>"&vbcrlf
		set rs=J.Data.Exe(sql)
			cur_menugrade=0
			response.write "<div class=""TreeMenu"" id=""CategoryTree""><ul>" & vbcrlf
			do while not rs.eof
				if rs("opened") then opened="Opened" else opened="Closed"
				if rs("menuname")&""="" then menuname="No Name" else menuname=rs("menuname")
				if rs("bindtype")=4 then 
					bindyn="<font color=red>绑至栏目 [ID="&rs("bindcont")&"] (不显根类)</font>" 
				elseif rs("bindtype")=3 then 
					bindyn="<font color=red>绑至栏目 [ID="&rs("bindcont")&"] (显示根类)</font>" 
				elseif rs("bindtype")=2 then
					bindyn="<font color=blue>绑至系统 [ID="&rs("bindcont")&"]</font>" 
				elseif rs("bindtype")=1 then
					bindyn=rs("bindcont")
				else
					bindyn=""
				end if
				if cur_menugrade>rs("menugrade") then
					for i=rs("menugrade") to cur_menugrade-1
						response.Write string(cur_menugrade-i+rs("menugrade")-1,"	") & "</ul>" & vbcrlf
						response.Write string(cur_menugrade-i+rs("menugrade")-1,"	") & "</li>" & vbcrlf
					next
				end if
				'if cur_menugrade>0 and rs("menugrade")=1 then response.Write "</ul>" & vbcrlf
				if rs("menuson")>0 then
					'if rs("parentid")=0 then response.Write "<ul>" & vbcrlf
					response.Write string(rs("menugrade"),"	") & "<li class="""&opened&""" menuid="""&rs("menuid")&""" sonnum="""&rs("menuson")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif"" onclick=""javascript:ChangeStatus(this);""><span class=""menuitem"" onFocus=""javascript:blur();"" onDblClick=""javascript:ChangeTitle(this,"&rs("menuid")&",'mod');"" oncontextmenu=""javascript:return PopupMouseRightButtonUpMenu(this,"&rs("menuid")&");"">" & menuname & "</span><span id=""Bind"&rs("menuid")&""" bindtype="""&rs("bindtype")&""" bindcont="""&rs("bindcont")&""" class=""bindstate"">"&bindyn&"</span>" & vbcrlf
					response.Write string(rs("menugrade"),"	") & "<ul id=""tree_item_"&rs("menuid")&""">" & vbcrlf
				else
					if rs("parentid")=0 then
						'response.Write "<ul>" & vbcrlf
						response.Write "	<li class="""&opened&""" menuid="""&rs("menuid")&""" sonnum="""&rs("menuson")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""menuitem"" onFocus=""javascript:blur();"" onDblClick=""javascript:ChangeTitle(this,"&rs("menuid")&",'mod');"" oncontextmenu=""javascript:return PopupMouseRightButtonUpMenu(this,"&rs("menuid")&");"">" & menuname & "</span><span id=""Bind"&rs("menuid")&""" bindtype="""&rs("bindtype")&""" bindcont="""&rs("bindcont")&""" class=""bindstate"">"&bindyn&"</span></li>" & vbcrlf
					else
						response.Write string(rs("menugrade"),"	") & "<li class=""Child"" menuid="""&rs("menuid")&""" sonnum="""&rs("menuson")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""menuitem"" onFocus=""javascript:blur();"" onDblClick=""javascript:ChangeTitle(this,"&rs("menuid")&",'mod');"" oncontextmenu=""javascript:return PopupMouseRightButtonUpMenu(this,"&rs("menuid")&");"">" & menuname & "</span><span id=""Bind"&rs("menuid")&""" bindtype="""&rs("bindtype")&""" bindcont="""&rs("bindcont")&""" class=""bindstate"">"&bindyn&"</span></li>" & vbcrlf
					end if
				end if
				cur_menugrade=rs("menugrade")
				rs.movenext
				if rs.eof then
					for i=1 to cur_menugrade
						response.Write string(cur_menugrade-i,"	") & "</ul>" & vbcrlf
						if i<cur_menugrade then response.Write string(cur_menugrade-i,"	") & "</li>" & vbcrlf
					next
				end if
			loop
			response.write "</div>"
		rs.close
		%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
