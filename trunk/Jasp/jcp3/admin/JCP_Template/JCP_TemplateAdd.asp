<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Templates.css" rel="stylesheet" type="text/css">
<style>
	body{overflow:hidden;}
</style>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/Cookie.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript" type="text/javascript">
<!--
	var doc=document;
	var LastElement=new Object();
	var LastClickElement=new Object();
	var Scripts=new Object();
	var StatusObjects=new Array();
	var LastClickElementPath="";
	var LastClickElementPosPath="";
	var GridYN=false;
	var DesignType="design";
	var TemplateID=0;
	var PropertyOpen=true;
	var CheckHeight=94;
	var TableID=0,ClassIDs="",GuideOrder=1;
	var ElementList="body,div,span,table,td,img,li,ul";	//系统目前涉及的对象列表

	
	var TemplateContent='<html>' + '\n' +
						 '<head>' + '\n' +
						 '<title>我的网页</title>' + '\n' +
						 '</head>' + '\n' + '\n' +
						 '<body>' + '\n' +
						 '</body>' + '\n' +
						 '</html>';
	var TemplateGridStyle='<style>' + ElementList + '{border:dotted 1px #AAAFFF;}</style>';
	var TemplateAlinkStyle='<style>a {poorfish:expression(this.onclick=function kill(){return false})}</style>';

	function Status(){
		var fdoc=doc.getElementById("DesignFrame").document;
		if(LastElement.tagName){
			StatusObjects.length=0;	//清空状态栏对象列表
			var tempStrs="";
			var tempID="";
			if(LastElement.id){tempID= "." + LastElement.id;}else{tempID="";}
			if(LastElement==LastClickElement){
				if(LastElement.getAttribute("blockid")){
					if(LastElement.getAttribute("blockname")) tempStrs="<strong>" + HTMLEncode("<BLOCK." + LastElement.getAttribute("blockname") + ">") + "</strong>";
					else tempStrs="<strong>" + HTMLEncode("<BLOCK>") + "</strong>";
				}else{
					tempStrs="<strong>" + HTMLEncode("<" + LastElement.tagName + tempID + ">") + "</strong>";
				}
			}else{
				if(LastElement.getAttribute("blockid")){
					if(LastElement.getAttribute("blockname")) tempStrs=HTMLEncode("<BLOCK." + LastElement.getAttribute("blockname") + ">");
					else tempStrs=HTMLEncode("<BLOCK>");
					
				}else{
					tempStrs=HTMLEncode("<" + LastElement.tagName + tempID + ">");
				}
			}
			var tempParent=LastElement;
			StatusObjects[StatusObjects.length]=tempParent;
			tempStrs='<span onclick="SelectElement(StatusObjects[0]);" onmouseover="wantElement(this,true);" onmouseout="wantElement(this);">' + tempStrs + '</span>';
			while(tempParent&&tempParent.parentNode&&tempParent.parentNode.tagName&&tempParent.parentNode.tagName!="HTML"){
				tempParent=tempParent.parentNode;
				if(tempParent.id){tempID= "." + tempParent.id;}else{tempID="";}
				tempStrs = '<span onclick="SelectElement(StatusObjects[' + StatusObjects.length + ']);" onmouseover="wantElement(this,true);" onmouseout="wantElement(this);">' + HTMLEncode("<" + tempParent.tagName + tempID + ">") + '</span>' + tempStrs;
				StatusObjects[StatusObjects.length]=tempParent;
			}
			DesignStatus.innerHTML = tempStrs;
			DesignFrame.focus();
		}else{
			DesignStatus.innerHTML=HTMLEncode("欢迎使用JCP模板设计器");
		}
	}
	
	function wantElement(o,type){
		if(type){
			o.runtimeStyle.borderLeft=o.style.borderTop="1px solid <%= session("Color_Fleet") %>";
			o.runtimeStyle.borderRight=o.style.borderBottom="1px solid <%= session("Color_Dip") %>";
		}else{
			o.runtimeStyle.borderLeft=o.style.borderTop="";
			o.runtimeStyle.borderRight=o.style.borderBottom="";
		}
	}
	
	function WinReSize(){
		var newHeight=doc.body.clientHeight-CheckHeight;
		if(newHeight<100) newHeight=100;
		doc.getElementById("DesignFrame").style.height=newHeight;
		doc.getElementById("DocumentCode").style.height=newHeight;
	}
	
	function TemplatePropertyDownUp(){
		if(PropertyOpen){
			CheckHeight=276;
			TemplatePropertyBox_DownUp.innerHTML="66";
			TemplatePropertyBox.style.display="block";
			WinReSize();
			PropertyOpen=false;
			if(navigator.cookieEnabled) setCookie("PropertyOpen","true");
		}else{
			CheckHeight=94;
			TemplatePropertyBox_DownUp.innerHTML="55";
			TemplatePropertyBox.style.display="none";
			WinReSize();
			PropertyOpen=true;
			if(navigator.cookieEnabled) setCookie("PropertyOpen","false");
		}
	}
	
	function TitleCheck(o){
		if(BlankCheck(o.value,o) && IllegalCheck(o.value,o)){
			startXmlRequest("POST","JCP_TemplateAction_XML.asp?action=templatenamecheck&templatename=" + o.value + "&templateid=" + TemplateID,null,"body","","",false);
			if(xml_BackCont!="OK"){
				alert("模板名称已经存在，请更换！");
				return false;
			}else return true;
		}else{
			return false;
		}
	}
	
	function ExpCheck(o){
		if(BlankCheck(o.value,o) && IllegalCheck(o.value,o)){
			return true;
		}else{
			return false;
		}
	}
	
	function TemplateTools(){
		TemplateToolWindow=showModelessDialog('JCP_TemplateTools.asp',window,'dialogWidth:200px;dialogHeight:400px;dialogLeft:' + (doc.body.clientWidth-54) + 'px;dialogTop:230px;help:no;toolbar:no;menubar:no;scrollbars:no;fullscreen:no;resizable:yes;directories:0;location:no;status:no');   
		doc.getElementById("mini_TemplateToolBox").style.display="none";
	}
	

///////////////////////////////////////////////////////////////
//代码和设计窗口转换时过滤脚本程序，  未实现
/*	var xml;
 	document.write('<XML ID="xmlData">' + TemplateContent + '</XML>');
	function ScriptManage(manageType){
		switch(manageType){
			case "toCode":
				
				break;
			case "toDesign":
				Scripts="";
				var sLib=DesignFrame.document.getElementsByTagName("script");
				for(i=0;i<sLib.length;i++) {
					var sParam = new Object();
					sParam["language"] = sLib[i].getAttribute("language");
					sParam["src"]      = sLib[i].getAttribute("src");
					sParam["type"]     = sLib[i].getAttribute("type");
					sParam["defer"]    = sLib[i].getAttribute("defer");
					sParam["runat"]    = sLib[i].getAttribute("runat");
					sParam["content"]  = sLib[i].innerHTML;
					Scripts[sLib[i]]=sParam;
				}
				break;
			default:return false;
		}
	}
	function XmlLoad(loadType){
		switch(loadType){
			case "toCode":
				xmlData.innerHTML=DesignFrame.document.documentElement.outerHTML;
				break;
			case "toDesign":
				xmlData.innerHTML=DocumentCode.value;
				break;
			default:return false;
		}
		var xmlDoc=new ActiveXObject("MSXML2.DOMDocument"); 
		xmlDoc.loadXML(xmlData.innerHTML);
		alert(xmlDoc.documentElement.childNodes[0].sourceIndex);
	}
*/
///////////////////////////////////////////////////////////////
	
	function CodeFormat(codestrs,ftype){
		if(ftype=="d2c"){				//设计 转 代码
			codestrs = FullUrl2RelUrl(codestrs);
			codestrs = codestrs.replace(/<!--scr?ipt/gi,"<scr" + "ipt")
							   .replace(/<\/scr?ipt-->/gi,"</scr" + "ipt>")
							   .replace(/on#mouseover/gi,"onMouseOver")
							   .replace(/on#mouseout/gi,"onMouseOut")
							   .replace(/on#mousemove/gi,"onMouseMove")
							   .replace(/on#keypress/gi,"onKeyPress")
							   .replace(/on#keydown/gi,"onKeyDown")
							   .replace(/on#keyup/gi,"onKeyUp")
							   .replace(/on#click/gi,"onClick")
							   .replace(/on#dblclick/gi,"onDblClick")
							   .replace(/ (style=)?"?poorfish: function kill\(\)\{return false\}"?/gi,"")
							   .replace(/<img src=\"..\/JCP_Skin\/<%= Session("SystemSkin") %>\/images\/block.gif\" /gi,"<block ");
			codestrs=eval('codestrs.replace(/' + TemplateGridStyle.replace(/\{/gi,"\\\{").replace(/\}/gi,"\\\}").replace(/\//gi,"\\\/") + '/gi,"").replace(/' + TemplateAlinkStyle.replace(/\{/gi,"\\\{").replace(/\}/gi,"\\\}").replace(/\//gi,"\\\/").replace(/\./gi,"\\\.").replace(/\(/gi,"\\\(").replace(/\)/gi,"\\\)") + '/gi,"");');
		}else if(ftype=="c2d"){		//代码 转 设计
			codestrs = codestrs.replace(/<scr?ipt/gi,"<!--script")
							   .replace(/<\/scr?ipt>/gi,"</script-->")
							   .replace(/onmouseover/gi,"on#mouseover")
							   .replace(/onmouseout/gi,"on#mouseout")
							   .replace(/onmousemove/gi,"on#mousemove")
							   .replace(/onkeypress/gi,"on#keypress")
							   .replace(/onkeydown/gi,"on#keydown")
							   .replace(/onkeyup/gi,"on#keyup")
							   .replace(/onclick/gi,"on#click")
							   .replace(/ondblclick/gi,"on#dblclick");
			if(GridYN){
				codestrs = codestrs.replace(/<block /gi,"<img src=\"..\/JCP_Skin\/<%= Session("SystemSkin") %>\/images\/block.gif\" ") + TemplateGridStyle + TemplateAlinkStyle;
			}else{
				codestrs = codestrs.replace(/<block /gi,"<img src=\"..\/JCP_Skin\/<%= Session("SystemSkin") %>\/images\/block.gif\" ") + TemplateAlinkStyle;
			}
		
		}
		return codestrs;
	}

	function TemplateCode(){
		DocumentCode.value=TemplateContent;
	}
	function GetFrame(){
		var _code=DesignFrame.document.documentElement.outerHTML;
		DocumentCode.value=CodeFormat(_code,"d2c");
	}
	function SetFrame(){
		var Fdoc=DesignFrame.document;
		Fdoc.open();
		Fdoc.write(CodeFormat(DocumentCode.value,"c2d"));
		//Fdoc.body.contentEditable="true";    //使设计窗口可编辑
		//Fdoc.body.style.cursor="default";
		//Fdoc.execCommand("2D-Position",true,true);
		//Fdoc.execCommand("MultipleSelection", true, true);
		//Fdoc.execCommand("LiveResize", true, true);
		
		Fdoc.close();
		DesignWinApp();
		LastElement="";        //清除原有对象
		LastClickElement="";   //清除原有对象
		if(GridYN){  //设置网格打开时对象的样式
			//alert(Fdoc.getElementsByTagName("div").length);//.runtimeStyle.cssText="border:1px dotted #cccccc";
		}
		Status();
	}
	
	function GridSet(){
		if(DesignType=="design"){
			if(GridYN) GridYN=false;
				else GridYN=true;
			SetFrame();
		}else alert("只能在设计模式下设置网格！");
	}
	
	function DesignWinApp(){
		DesignFrame.Over=function(){
			switch(DesignFrame.event.srcElement.tagName){
				default:
					if(LastElement){
						if(LastElement.runtimeStyle.cssText.toLowerCase().indexOf("#ff0000")>-1){
							LastElement.runtimeStyle.cssText="";
						}
					}
					LastElement=DesignFrame.event.srcElement;
					if(LastElement.runtimeStyle.cssText=="") LastElement.runtimeStyle.cssText ="border:1px solid #FF0000;";
					if(!LastClickElement) Status();
			}
		}
		DesignFrame.Click=function(){
			switch(DesignFrame.event.srcElement.tagName){
				default:
					if(LastClickElement){
						if(LastClickElement.runtimeStyle.cssText.toLowerCase().indexOf("green")>-1){
							LastClickElement.runtimeStyle.cssText="";
						}
					}
					LastClickElement=DesignFrame.event.srcElement;
					LastClickElement.runtimeStyle.cssText="border:1px solid green;";
					Status();
			}
		}
		DesignFrame.DblClick=function(){
			switch(DesignFrame.event.srcElement.tagName){
				case "IMG":
					if(DesignFrame.event.srcElement.getAttribute("blockname") && DesignFrame.event.srcElement.getAttribute("blockid")){
						BlockEdit(DesignFrame.event.srcElement.getAttribute("blockid"));
					}else{
						StyleSet();
					}
					break;
				default:
					StyleSet();
			}
		}
		DesignFrame.KeyDown=function(){
			if ((DesignFrame.event.ctrlKey)&&(DesignFrame.event.keyCode==67)) CopyElement();	//复制         
			if ((DesignFrame.event.ctrlKey)&&(DesignFrame.event.keyCode==86)) PasteElement();	//粘贴          
			if ((DesignFrame.event.ctrlKey)&&(DesignFrame.event.keyCode==88)) CutElement();	//剪切         
			if (DesignFrame.event.keyCode==46||DesignFrame.event.keyCode==8) {DelElement();	return false;}	//删除         
		}
		DesignFrame.document.body.onmouseover=DesignFrame.Over;
		DesignFrame.document.body.onclick=DesignFrame.Click;
		DesignFrame.document.body.ondblclick=DesignFrame.DblClick;
		DesignFrame.document.body.onkeydown=DesignFrame.KeyDown;
												
	}
	
	function StyleSet(){
		if(!ElementCheck("css")) return false;
		if(LastClickElement) ModelWin("JCP_CSS_Designer.asp",582,352);
	}
	
	function ContentEdit(){
		if(!ElementCheck("edit")) return false;
		if(LastClickElement){
			ModelWin("JCP_Content_Edit.asp",400,400);
			GetFrame();
		}
	}
	
	function SelectElement(o){
		DesignFrame.focus();
		if(LastClickElement){
			if(LastClickElement.runtimeStyle.cssText.toLowerCase().indexOf("green")>-1){
				LastClickElement.runtimeStyle.cssText="";
			}
		}
		LastElement=LastClickElement=o;
		LastClickElement.runtimeStyle.cssText="border:1px solid green;";
		Status();
	}
	
	function CopyElement(){
		if(!ElementCheck("copy")) return false;
		if(DesignType=="design"){
			if(LastClickElement && LastClickElement!=""){
				switch(LastClickElement.tagName){
					case "BODY":
					case "TD":
						window.clipboardData.setData('text',CodeFormat(LastClickElement.innerHTML,"d2c"));
						break;
					default:
						window.clipboardData.setData('text',CodeFormat(LastClickElement.outerHTML,"d2c"));
				}
			}else alert("请选择需要复制的对象！");
		}else if(DesignType=="code"){
			DocumentCode.focus();
			window.clipboardData.setData('text',document.selection.createRange().text)
		}
	}
	
	function CutElement(){
		if(!ElementCheck("cut")) return false;
		if(DesignType=="design"){
			if(LastClickElement && LastClickElement!=""){
				switch(LastClickElement.tagName){
					case "BODY":
					case "TD":
						window.clipboardData.setData('text',CodeFormat(LastClickElement.innerHTML,"d2c"));
						break;
					default:
						window.clipboardData.setData('text',CodeFormat(LastClickElement.outerHTML,"d2c"));
				}
				DelElement();
			}else alert("请选择需要剪切的对象！");
		}else if(DesignType=="code"){
			DocumentCode.focus();
			window.clipboardData.setData('text',document.selection.createRange().text);
			document.selection.createRange().text="";
		}
	}
	
	function PasteElement(){
		if(!ElementCheck("paste")) return false;
		if(DesignType=="design"){
			if(LastClickElement && LastClickElement!=""){
				try{
					switch(LastClickElement.tagName){
						case "TABLE":
						case "IMG":
							if(window.clipboardData.getData("text")) LastClickElement.parentNode.innerHTML += window.clipboardData.getData("text");
							break;
						default:
							if(window.clipboardData.getData("text")){
								if(LastClickElement.innerHTML=="&nbsp;") LastClickElement.innerHTML = window.clipboardData.getData("text");
								else LastClickElement.innerHTML += window.clipboardData.getData("text");
							}
					}
					GetFrame();
				}catch(e){
					alert("出错了！\n\n原因：某些对象不建议嵌套使用\n\n例如：LI");
					return false;
				}
			}else alert("请选择需要粘贴的位置！");
		}else if(DesignType=="code"){
			DocumentCode.focus();
			if(window.clipboardData.getData("text")) document.selection.createRange().text=window.clipboardData.getData("text");
			//SetFrame();
		}
	}
	
	function DelElement(){
		if(!ElementCheck("delete")) return false;
		if(DesignType=="design"){
			if(LastClickElement && LastClickElement!=""){
				switch(LastClickElement.tagName){
					case "BODY":
					case "TD":
						LastClickElement.innerHTML = "&nbsp;";
						break;
					default:
						var pElement=LastClickElement.parentNode;
						LastClickElement.removeNode(true);
						if(pElement.innerHTML=="") pElement.innerHTML="&nbsp;";
						LastElement=LastClickElement="";
						Status();
				}
				GetFrame();
			}else alert("请选择需要删除的对象！");
		}else if(DesignType=="code"){
			DocumentCode.focus();
			doc.selection.createRange().text="";
			//SetFrame();
		}
	}
	
	function DesignTypeChange(){
		if(DesignType=="design"){
			DesignType="code";
			DocumentCode_Box.style.display="block";
			DesignFrame_Box.style.display="none";
			DesignStatus.innerHTML = "编辑HTML源代码";
			doc.getElementById("codetype").innerHTML="设计";
		}else{
			DesignType="design";
			SetFrame();
			DesignFrame_Box.style.display="block";
			DocumentCode_Box.style.display="none";
			doc.getElementById("codetype").innerHTML="代码";
		}
	}	
	
	function BlockEdit(blockid){
		var arr=ModelWin("../JCP_BlockList/JCP_BlockEdit.asp?blockid=" + blockid,100,100);
	}
	
	function BlockAdd(id,exps){
		if(!ElementCheck("create")) return false;
		var pFDoc=DesignFrame.document;
		if(DesignType=="design"){
			var element=pFDoc.createElement('<img src="../JCP_Skin/<%= Session("SystemSkin") %>/images/block.gif" blockname="' + exps + '" blockid="' + id + '">');
			if(LastClickElement){
				switch(LastClickElement.tagName){
					case "TABLE":
					case "IMG":
						if(LastClickElement.getAttribute("blockname") && LastClickElement.getAttribute("blockid")){
							LastClickElement.parentNode.replaceChild(element,LastClickElement);
							LastElement=element;
							element.click();
						}
						break;
					default:
						if(LastClickElement.innerHTML=="&nbsp;") LastClickElement.innerHTML="";
						LastClickElement.appendChild(element);
				}
			}else{
				if(DesignFrame.document.body.innerHTML=="&nbsp;") DesignFrame.document.body.innerHTML="";
				DesignFrame.document.body.appendChild(element);
			}
			GetFrame();
		}else if(DesignType=="code"){
			DocumentCode.focus();
			doc.selection.createRange().text='<block blockname="' + exps + '" blockid="' + id + '">';
			//SetFrame();
		}
	}
	
	function CreateElement(elementtype){
		if(!ElementCheck("create")) return false;
		var element=new Object();
		switch(elementtype.toUpperCase()){
			case "IMG":
				var src=ModelWin("../JCP_Tools/JCP_UploadFile.asp?filetype=gif/jpg/png/psd",400,190);
				if(src){
					element=DesignFrame.document.createElement(elementtype);
					element.src=src;
				}else return false;
				break;
			default:
				element=DesignFrame.document.createElement(elementtype);
				element.innerHTML="&nbsp;";
		}
		if(LastClickElement){
			switch(LastClickElement.tagName){
				case "TABLE":
				case "IMG":
					if(DesignType=="design"){
						if(LastClickElement.innerHTML=="&nbsp;") LastClickElement.innerHTML="";
						LastClickElement.parentNode.appendChild(element);
						SelectElement(element);
						GetFrame();
					}else if(DesignType=="code"){
						DocumentCode.focus();
						document.selection.createRange().text=element.outerHTML;
					}
					break;
				default:
					if(DesignType=="design"){
						if(LastClickElement.innerHTML=="&nbsp;") LastClickElement.innerHTML="";
						LastClickElement.appendChild(element);
						SelectElement(element);
						GetFrame();
					}else if(DesignType=="code"){
						DocumentCode.focus();
						document.selection.createRange().text=element.outerHTML;
					}
			}
		}else{
			if(DesignType=="design"){
				if(DesignFrame.document.body.innerHTML=="&nbsp;") DesignFrame.document.body.innerHTML="";
				DesignFrame.document.body.appendChild(element);
				SelectElement(element);
				GetFrame();
			}else if(DesignType=="code"){
				DocumentCode.focus();
				document.selection.createRange().text=element.outerHTML;
			}
		}
	}
	
	function ElementCheck(checktype){	//选中对象是否支持以下操作
		var checkUnList="";	//不支持的对象列表，以半角逗号分隔
		var checkStr="";
		switch(checktype){
			case "create":
				checkUnList="";
				checkStr="不支持在当前对象[tagName]中创建其它子对象！";
				break;
			case "css":
				checkUnList="";
				checkStr="不支持对当前对象[tagName]的ＣＳＳ样式修改！";
				break;
			case "edit":
				checkUnList="table,img";
				checkStr="不支持对当前对象[tagName]的内容编辑！";
				break;
			case "copy":
				checkUnList="";
				checkStr="当前对象[tagName]不支持复制操作！";
				break;
			case "cut":
				checkUnList="";
				checkStr="当前对象[tagName]不支持复制操作！";
				break;
			case "paste":
				checkUnList="";
				checkStr="当前对象[tagName]不能接受复制内容！";
				break;
			case "delete":
				checkUnList="";
				checkStr="当前对象[tagName]不支持删除操作！";
				break;
			case "create":
				checkUnList="";
				checkStr="当前对象[tagName]不能创建子对象！";
				break;
			default:return false;
		}
		if(LastClickElement){
			if(("," + ElementList + ",").toLowerCase().indexOf("," + LastClickElement.tagName.toLowerCase() + ",")<0){
				alert("系统目前不支持此对象[" + LastClickElement.tagName + "]的任何操作!");
				return false;
			}else{
				var paramElement=checkUnList.split(",");
				for(i=0;i<paramElement.length;i++){
					if(paramElement[i]==LastClickElement.tagName.toLowerCase()){
						alert(checkStr.replace("tagName",LastClickElement.tagName.toUpperCase()));
						return false;
						break;
					}
				}
				return true;
			}
		}else return true;
	}
	
	function BlockSave(){
		doc.all.Template_Name.value=TemplateName.value;
		doc.all.Template_Exp.value=TemplateExp.value;
		doc.all.Template_ID.value=TemplateID;
		doc.all.Template_Type.value=TemplateType.value;
		doc.all.Template_Code.value=DocumentCode.value;
		doc.all.Template_TableID.value=TemplateTable.value;
		doc.all.Template_ClassIDs.value=TemplateTableClass.value;
		if(doc.getElementById("TemplateTableGuideSelect")) doc.all.Template_GuideOrder.value=TemplateTableGuideSelect.value;
		if(HtmlPathY.checked){doc.all.Template_HtmlPathYN.value=true;}else{doc.all.Template_HtmlPathYN.value=false;};
		doc.all.Template_HtmlPath.value=HtmlPath.value;
		doc.all.TemplateForm.submit();
	}
	
<% 
dim rs,templateid,editYN,tableid
editYN=false
templateid=request.QueryString("templateid")
if isnumeric(templateid) then
	templateid=cLng(templateid)
	if templateid>0 then
		set rs=J.Data.Exe("select * from JCP_Template where id=" & templateid)
		if not rs.eof then
			response.write "	TemplateID=" & rs("id") & ";" & vbcrlf
			response.write "	TableID=" & rs("TemplateTableID") & ";" & vbcrlf
			response.write "	ClassIDs='" & rs("TemplateClassIDs") & "';" & vbcrlf
			response.write "	GuideOrder=" & rs("TemplateGuideOrder") & ";" & vbcrlf & vbcrlf
			response.write "	function EditDataSet(){" & vbcrlf & _
							"		TemplateType.value=" & rs("TemplateType") & ";" & vbcrlf & _
							"		TemplateName.value='" & rs("TemplateName") & "';" & vbcrlf & _
							"		TemplateExp.value='" & rs("TemplateExp") & "';" & vbcrlf & _
							"		TemplateContent=HTMLUnEncode('" & J.Encode(replace(replace(rs("TemplateCode"),"\","\\"),chr(13) & chr(10),"\n")) & "');" & vbcrlf & _
							"		TemplateTable.value=" & rs("TemplateTableID") & ";" & vbcrlf & _
							"		TemplateTableClass.value=ClassIDs;" & vbcrlf
			if rs("TemplateHtmlPathYN") then
				response.write "		HtmlPathY.checked=true;" & vbcrlf
				response.write "		HtmlPathN.checked=false;" & vbcrlf
				response.write "		HtmlPath.value='" & rs("TemplateHtmlPath") & "';" & vbcrlf
				response.write "		HtmlPath.disabled=false;" & vbcrlf
			else
				response.write "		HtmlPathY.checked=false;" & vbcrlf
				response.write "		HtmlPathN.checked=true;" & vbcrlf
				response.write "		HtmlPath.disabled=true;" & vbcrlf
			end if
			response.write "	}" & vbcrlf & vbcrlf
			editYN=true
			tableid=rs("TemplateTableID")
		end if
		rs.close
	end if
end if
%>

	function TemplateTable_GetClassSelect(t_tableid){
		if(t_tableid && t_tableid>0){
			if (t_tableid==TableID){
				var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  		  "<root><classids>" +  ClassIDs + "</classids></root>";
				startXmlRequest("POST","JCP_TemplateAction_XML.asp?action=gettableclassedit&tableid=" + t_tableid + "&guideorder=" + GuideOrder,xml,"body","","",false);
			}else startXmlRequest("POST","JCP_TemplateAction_XML.asp?action=gettableclass&tableid=" + t_tableid + "&guideorder=1",null,"body","","",false);
			//alert(xml_BackCont);
			if(xml_BackCont){
				TemplateTableClassBox.innerHTML=xml_BackCont;
			}else return false;
		}else TemplateTableClassBox.innerHTML="";
	}
	function TemplateTable_GetClass(){
		var selecti=0;
		TemplateTableClass.value="";
		while(doc.getElementById("TemplateTableClassSelect" + selecti.toString())){
			var o=doc.getElementById("TemplateTableClassSelect" + selecti.toString());
			if(selecti>0) TemplateTableClass.value += ",|";
			for(i=0;i<o.options.length;i++){
				if(o.options[i].text.indexOf("√|")>-1) TemplateTableClass.value += "," + o.options[i].value;
			}
			selecti++;
		}
	}
	function TemplateTable_SetClass(o,dblyn){
		var classyn=false;
		if(dblyn){
			if(o.options[o.selectedIndex].text.indexOf("　|")>-1){
				o.options[o.selectedIndex].text=o.options[o.selectedIndex].text.replace("　|","√|");
				classyn=true;
			}else{
				o.options[o.selectedIndex].text=o.options[o.selectedIndex].text.replace("√|","　|");
				classyn=false;
			}
			if(o.options[o.selectedIndex].text.indexOf("　|")>-1){
				o.options[o.selectedIndex].text=o.options[o.selectedIndex].text.replace("　|","√|");
				classyn=true;
			}else{
				o.options[o.selectedIndex].text=o.options[o.selectedIndex].text.replace("√|","　|");
				classyn=false;
			}
			for(i=0;i<o.options.length;i++){
				if(o.options[i].title.indexOf("," + o.options[o.selectedIndex].value + ",")>0){
					if(classyn) o.options[i].text=o.options[i].text.replace("　|","√|");
					else o.options[i].text=o.options[i].text.replace("√|","　|");
				}
			}
		}else{
			if(o.options[o.selectedIndex].text.indexOf("　|")>-1){
				o.options[o.selectedIndex].text=o.options[o.selectedIndex].text.replace("　|","√|");
				classyn=true;
			}else{
				o.options[o.selectedIndex].text=o.options[o.selectedIndex].text.replace("√|","　|");
				classyn=false;
			}
		}
		TemplateTable_GetClass();
	}
	
	window.onresize=WinReSize;
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">模板设计</div>
	<div id="Toolbar">
		<div class="Sub_Toolbar">
			<span class="distinctline"></span>
			<span class="signtool" onClick="CreateElement('div');">DIV</span>
			<span class="signtool" onClick="CreateElement('span');">SPAN</span>
			<span class="signtool" onClick="CreateElement('li');">LI</span>
			<span class="signtool" onClick="CreateElement('img');">IMG</span>
			<span class="distinctline"></span>
			<span class="distinctline"></span>
			<span class="signtool" onClick="ContentEdit();">编辑</span>
			<span class="signtool" onClick="StyleSet();">CSS</span>
			<span class="distinctline"></span>
			<span class="distinctline"></span>
			<span id="copybutton" onClick="CopyElement();">复制</span>
			<span id="copybutton" onClick="CutElement();">剪切</span>
			<span id="pastebutton" onClick="PasteElement();">粘贴</span>
			<span id="delbutton" onClick="DelElement();">删除</span>
			<span class="distinctline"></span>
			<span class="distinctline"></span>
			<span id="designgrid" onClick="GridSet();">网格</span>
			<span class="distinctline"></span>
			<span class="distinctline"></span>
			<span id="codetype" onClick="DesignTypeChange();">代码</span>
			<span class="distinctline"></span>
			<span class="distinctline"></span>
			<span id="codetype" onClick="location='JCP_TemplateManage.asp?Page=<%= request.QueryString("Page") %>&templatetype=<%= request.QueryString("templatetype") %>';">返回管理</span>
			<span id="codetype" onClick="BlockSave();">保存模板</span>
			<span id="mini_TemplateToolBox" style="display:block;float:right;" onclick="TemplateTools()">模板工具箱</span>
		</div>
	</div>
    <div id="DesignBox">
		<div id="DesignFrame_Box" style="display:block;float:left;"><iframe id="DesignFrame" scrolling="yes" frameborder="0" src="about:blank" width="100%" height="0"></iframe></div>
    	<div id="DocumentCode_Box" style="display:none;float:left;"><textarea id="DocumentCode" style="width:100%;height:100%;margin:-1px 0 -1px 0;" wrap="off" onChange="//SetFrame();" onKeyUp="//SetFrame();"></textarea></div>
    </div>
	<div id="DesignStatusBox">
		<span id="TemplatePropertyBox_DownUp" onClick="TemplatePropertyDownUp();">55</span>
		<span id="DesignStatus"></span>
	</div>
	<div id="TemplatePropertyBox" style="display:none;">
		<div class="propertyItem">
			<span id="TemplateTitleBox">模板名称：
				<input id="TemplateName" value="未定义">
			</span>
			<span id="TemplateTypeBox">模板类型：
				<select id="TemplateType" name="TemplateType" onchange="if(HtmlPathY.checked){HtmlPathN.click();};">
					<%
					dim i
					for i=0 to ubound(J.Model)
						response.write "<option value=""" & i & """>" & J.Model(i) & "</option>"
					next
					%>
				</select>
			</span>
		</div>
		<div class="propertyItem">
			<span id="TemplateExpBox">模板说明：
				<input id="TemplateExp" value="无说明">
			</span>
		</div>
		<div class="propertyItem">
			<span id="TemplateTableTitle">应用系统：
				<select id="TemplateTable" name="TemplateTable" onChange="javascript:TemplateTable_GetClassSelect(this.value);">
					<%
					response.write "<option value=""0"">选择应用系统</option>"
					set rs=J.Data.Exe("select menuid,menutitle from JCP_AppSystem where typeid=1 order by menuid")
					do while not rs.eof 
						response.write "<option value=""" & rs(0) & """>" & rs(1) & "</option>"
						rs.movenext
					loop
					rs.close
					%>
				</select><input type="hidden" id="TemplateTableClass" name="TemplateTableClass" value="">
			</span>
			<span id="TemplateTableClassBox"><% if editYN then response.write "<script>TemplateTable_GetClassSelect(" & tableid & ");</script>" %></span>
		</div>
		<div class="propertyItem">
			<span id="TemplateHtmlPathBox">
				页面发布：<input type="radio" id="HtmlPathN" name="HtmlPathYN" value="" class="select" checked onclick="HtmlPath.disabled=true;HtmlPath.value='';">默认位置
				<input type="radio" id="HtmlPathY" name="HtmlPathYN" value="" class="select" onclick="HtmlPath.disabled=false;HtmlPath.select();">自定义
				<input type="text" id="HtmlPath" name="HtmlPath" value="" disabled onfocus="if(BlankYn(this.value)){if(TemplateType.value==4){this.value='<%= J.IndexName & "." & J.FileExt %>'}else if(TemplateType.value==3){this.value='filename<%= "." & J.FileExt %>'}else{this.value='<%= J.WebPath %>'}};" onblur="if(BlankYn(this.value)){if(TemplateType.value==4){this.value='<%= J.IndexName & "." & J.FileExt %>'}else{this.value='<%= J.WebPath %>'}};IllegalCheck(this.value,this);">
			</span>
		</div>
	</div>
	<form name="TemplateForm" method="post" action="JCP_TemplateAction.asp?action=template&Page=<%= request.QueryString("Page") %>&templatetype=<%= request.QueryString("templatetype") %>">
		<input type="hidden" id="Template_Name" name="Template_Name" value="">
		<input type="hidden" id="Template_Exp" name="Template_Exp" value="">
		<input type="hidden" id="Template_ID" name="Template_ID" value="">
		<input type="hidden" id="Template_Type" name="Template_Type" value="">
		<input type="hidden" id="Template_Code" name="Template_Code" value="">
		<input type="hidden" id="Template_TableID" name="Template_TableID" value="">
		<input type="hidden" id="Template_ClassIDs" name="Template_ClassIDs" value="">
		<input type="hidden" id="Template_GuideOrder" name="Template_GuideOrder" value="1">
		<input type="hidden" id="Template_HtmlPathYN" name="Template_HtmlPathYN" value="">
		<input type="hidden" id="Template_HtmlPath" name="Template_HtmlPath" value="">
	</form>
<!--#include file="../JCP_Shared/foot.asp" -->
<script language="JavaScript" defer>
	if(navigator.cookieEnabled){
		var _PropertyOpen=getCookie("PropertyOpen");
		if(_PropertyOpen){
			if(_PropertyOpen=="false") PropertyOpen=false;
			else PropertyOpen=true;
		}
	}
	TemplatePropertyDownUp();			
	<% if editYN then response.write "EditDataSet();" %>
	TemplateCode();
	Status();
	doc.onload=SetFrame();
</script>
<% J.close %>