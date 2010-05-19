<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<!--#include file="../JCP_Shared/body.asp" -->
	<textarea id="editBox" style="width:100%;height:320px;margin-bottom:8px;" wrap="off"></textarea>
	<center>
		<input type="button" class="system_button_00" value="保存修改" onclick="SaveChange();">　　　
		<input type="button" class="system_button_00" value="取消修改" onclick="window.close();">
	</center>
	<div id="css_list">
		<script language="JavaScript">
			var doc=document;
			if(window.dialogArguments) var parentWin = window.dialogArguments;
			var content="";
			if(parentWin){
				var CurObject=parentWin.LastClickElement.tagName;
				if(parentWin.LastClickElement.id){var CurObjectID="." + parentWin.LastClickElement.id;}else{var CurObjectID="";}
			}else{
				var CurObject="DIV";
				var CurObjectID="";
			}
			doc.title=CurObject + CurObjectID + " 的内容编辑"
			editBox.value=content=parentWin.CodeFormat(parentWin.LastClickElement.innerHTML,"d2c");
			
			function SaveChange(){
				if(parentWin){
					if(editBox.value!=content){
						parentWin.LastClickElement.innerHTML=parentWin.CodeFormat(editBox.value,"c2d");
					}
					window.close();
				}
			}
		</script>
	</div>

<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>