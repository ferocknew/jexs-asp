<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Templates.css" rel="stylesheet" type="text/css">
<style>
	body{overflow:hidden;background-color:<%= session("Color_Main") %>;}
</style>
<script language="JavaScript">
	var parentWin = window.dialogArguments;
	var doc=document;
	document.title="模板工具箱　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
	window.onunload=function(){
		try{
			if(parentWin.document.getElementById("mini_TemplateToolBox")) parentWin.document.getElementById("mini_TemplateToolBox").style.display="block";
		}catch(e){
			return false;
		}
	}
	window.onresize=WinReSize;
	
	function WinReSize(){
		if(doc.body.clientHeight){
			var newHeight=doc.body.clientHeight-70;
			var newWidth=doc.body.clientWidth-52;
			if(newHeight<200) newHeight=200;
			doc.getElementById("blockToolsBox").style.height=newHeight;
			doc.getElementById("blockToolsBox").style.width=newWidth;
		}
	}
	
	function ToolChange(num){
		var urls=new Array();
		var buttons=new Array();
		urls[0]="JCP_TemplateTools_BlockApps.asp";
		urls[1]="JCP_TemplateTools_Blocks.asp";
		buttons[0]="button_blockapp";
		buttons[1]="button_blockresource";
		for(i=0;i<2;i++){
			var curobj=doc.getElementById(buttons[i]);
			if(i==num){
				curobj.className="button_selected";
				doc.getElementById("ToolFrame").src=urls[i];
			}else{
				curobj.className="button_unselected";
			}
		}
	}
	
	function ToolExpDisplay(strs){
		if(strs==null||!strs||strs=="") doc.getElementById("ToolExp").innerHTML="选择您需要的操作！";
		else doc.getElementById("ToolExp").innerHTML=strs;
	}
	
	function BlockAdd(id,exps){
		/*
		var pFDoc=parentWin.DesignFrame.document;
		if(parentWin.DesignType=="design"){
			var element=pFDoc.createElement('<img src="../JCP_Skin/<%= Session("SystemSkin") %>/images/block.gif" blockname="' + exps + '" blockid="' + id + '">');
			if(parentWin.LastClickElement){
				switch(parentWin.LastClickElement.tagName){
					case "BODY":
					case "DIV":
					case "SPAN":
						if(parentWin.LastClickElement.innerHTML=="&nbsp;") parentWin.LastClickElement.innerHTML="";
						parentWin.LastClickElement.appendChild(element);
						break;
					default:return false;
				}
			}else{
				if(parentWin.DesignFrame.document.body.innerHTML=="&nbsp;") parentWin.DesignFrame.document.body.innerHTML="";
				parentWin.DesignFrame.document.body.appendChild(element);
			}
			parentWin.GetFrame();
		}else if(parentWin.DesignType=="code"){
			parentWin.DocumentCode.focus();
			parentWin.document.selection.createRange().text='<block blockname="' + exps + '" blockid="' + id + '">';
			//parentWin.SetFrame();
		}
		*/
		parentWin.BlockAdd(id,exps);
	}
</script> 
<!--#include file="../JCP_Shared/body.asp" -->
	<div id="blockToolsBox">
		<iframe id="ToolFrame" scrolling="auto" frameborder="0" src="JCP_TemplateTools_BlockApps.asp" width="100%" height="100%"></iframe>
	</div>
	<div id="button_blockapp" class="button_selected" onclick="ToolChange(0);">应用模块</div>
	<div id="button_blockresource" class="button_unselected" onclick="ToolChange(1);">模块源</div>
	<div style="float:left;width:100%;height:2px;overflow:hidden;border-top:1px solid <%= session("Color_Dip") %>;border-bottom:1px solid <%= session("Color_Fleet") %>;margin:6px 0 2px 0;"></div>
	<div id="ToolExp" disabled>选择您需要的操作！</div>
	<div style="float:left;width:100%;height:2px;overflow:hidden;border-top:1px solid <%= session("Color_Dip") %>;border-bottom:1px solid <%= session("Color_Fleet") %>;margin:0 0 6px 0;"></div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>