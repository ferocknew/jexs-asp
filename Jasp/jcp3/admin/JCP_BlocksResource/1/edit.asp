<!--#include file="../../JCP_Shared/asp_head.asp" -->
<!--#include file="../../JCP_Shared/head.asp" -->
<script language="VBScript" src="../../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	doc.title="普通数据模块 修改窗口　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
	
	function FromCheck(){
		if(TableIdCheck()==false) return false;
		if(UsedFieldsCheck()==false) return false;
		if(BlockElementCheck()==false) return false;
		return true;
	}
	
	function BlockNameCheck(){
		var o=doc.getElementById("blockname");
		startXmlRequest("POST","../../JCP_BlockList/JCP_BlockAction_XML.asp?action=blocknamecheck&blockname=" + o.value,null,"body","","",false);
		if(xml_BackCont!="OK"){
			alert("模块名称已经存在，请更换！");
			o.select();
			return false;
		}
	}
	
	function TableIdCheck(){
		var o=doc.getElementById("TableList");
		if(o.selectedIndex==0){
			alert("请选择目标系统!");
			o.focus();
			return false;
		}
	}
	
	function UsedFieldsCheck(){
		var o=doc.getElementById("UsedFields");
		if(BlankYn(o.value)){
			alert("请创建调用内容!");
			doc.getElementById("TableItemList").focus();
			return false;
		}
	}
	
	function BlockElementCheck(){
		var o=doc.getElementById("blockelement");
		if(BlankYn(o.value)){
			alert("请创建调用内容!");
			o.select();
			return false;
		}
	}
-->
</script>
<base target="_self">
<!--#include file="../../JCP_Shared/body.asp" -->
<form name="blockform" method="post" action="action.asp?action=editblock&blockid=<%= request.querystring("blockid") %>" style="margin:0;">
  <table width="100%" height="101" border="0" cellpadding="4" cellspacing="0">
    <tr> 
      <td width="60" height="29" align="right">模块名称：</td>
      <td colspan="2"><input type=text id=blockname name=blockname value="限数文字列表" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);">
        </td>
    </tr>
    <tr> 
      <td height="29" align="right">模块说明：</td>
      <td colspan="2"><input type=text id=blockexplain name=blockexplain value="用于TOP10、热点、最新等有限数量的短列表" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);" style="width:100%;"></td>
    </tr>
    <tr> 
      <td height="29" align="right">目标系统：</td>
      <td colspan="2"><select name="TableList" id="TableList" onchange="TableItemListShow();">
          <option value="0" selected>请选择目标系统</option>
        </select></td>
    </tr>
    <tr> 
      <td height="29" align="right">栏目信息：</td>
      <td colspan="2"><input type="radio" name="ClassFrom" id="ClassFrom" class="select" checked onclick="ClassStateSet(1);" value="1">
        来自模板 
        <input type="radio" name="ClassFrom" id="ClassFrom" class="select" onclick="ClassStateSet(2);" value="2">
        自定义
		<input name="SubClass" type="checkbox" id="SubClass" value="yes" class="select">
          含子栏目(是否)</td>
    </tr>
    <tr> 
      <td height="29" align="right">栏目设置：</td>
      <td colspan="2"><span id="ClassListBox" disabled>暂无栏目选项...</span> <input type="hidden" id="classid" name="classid" value=""></td>
    </tr>
    <tr> 
      <td height="12" align="right">排序依据：</td>
      <td colspan="2"><select name="OrderItemList" id="OrderItemList">
            <option value="0" selected>请选择字段</option>
            <option value="id">记录ID</option>
            <option value="uptime">发布时间</option>
            <option value="hits">点击量</option>
          </select>
        排序方式： <select name="blockorder" id="blockorder">
          <option value="desc" selected>降序</option>
          <option value="asc">升序</option>
        </select></td>
    </tr>
    <tr> 
      <td align="right">调用内容：</td>
      <td><select name="TableItemList" id="TableItemList" onchange="if(this.selectedIndex==0){ReplaceString.value='';}else{ReplaceString.value=this.options[this.selectedIndex].text;ReplaceString.select();}">
            <option value="0" selected>请选择字段</option>
            <option value="id">记录ID</option>
            <option value="uptime">发布时间</option>
            <option value="hits">点击量</option>
          </select> <input type="button" class="system_button_00" name="Button" value="添加" onclick="UsedFieldsSet('add');"> <input type="button" class="system_button_00" name="Button2" value="删除" onclick="UsedFieldsSet('del');"> 
      </td>
      <td rowspan="2" valign="top" width="180"><select name="tempUsedFields" size="4" id="tempUsedFields" style="width:100%;" ondblclick="alert(UsedFields.value);"></select></td>
    </tr>
    <tr> 
      <td align="right">替换字符：</td>
      <td><input type="text" name="ReplaceString" style="width:200px;"> <input type="hidden" name="UsedFields" id="UsedFields"></td>
    </tr>
    <tr> 
      <td height="12" align="right">单条样式：</td>
      <td colspan="2"><textarea name="blockelement" id="blockelement" style="width:100%;height:60px;"></textarea></td>
    </tr>
    <tr> 
      <td height="24" align="right">外部代码：</td>
      <td colspan="2"><textarea name="blockoutside" id="blockoutside" style="width:100%;height:60px;"></textarea></td>
    </tr>
    <tr> 
      <td height="12" align="right">显示数量：</td>
      <td colspan="2"><input type="text" name="PageSize" id="PageSize" style="width:20px;" value="10" onblur="IntCheck(this.value,this);">
        条</td>
    </tr>
    <tr align="center"> 
        <td height="12" colspan="3"> <input type=hidden id=blocktype name=blocktype value="0">
          <input type="hidden" name="blockfolder" id="blockfolder" value="<%= request.QueryString("src") %>">
          <input name="OutLink" type="hidden" id="OutLink" value="">
          <input type=submit class="system_button_00" value="修改模块" onclick="doc.all.blockform.onsubmit=function(){return FromCheck()};">　　
		<input type=button class="system_button_00" value="取消修改" onclick="javascript:window.close();">
	  </td>
    </tr>
  </table>
</form>		
<script language=javascript>
reSize(500,500);

<% 
dim listrs,menuids
menuids="0"
set listrs=J.Data.Exe("select menuid,menutitle from JCP_AppSystem where typeid=1 order by menuid")
if not listrs.eof then
	response.write "var TableClub=new Array();" & vbcrlf
	do while not listrs.eof
		response.write "TableClub[TableClub.length]=['"&listrs("menuid")&"','"&listrs("menutitle")&"'];" & vbcrlf
		menuids=menuids & "," & listrs("menuid")
		listrs.movenext
	loop
end if
listrs.close
if instr(menuids,",")>0 then
	set listrs=J.Data.Exe("select sys_id,item_id,item_name,item_type,item_content from JCP_ArtSys where item_order>0 and item_type<>'button' and sys_id in ("&menuids&") order by sys_id,item_order")
	if not listrs.eof then
		dim curmenuid
		do while not listrs.eof
			if curmenuid <> listrs("sys_id") then
				curmenuid=listrs("sys_id")
				response.write "var Table" & curmenuid & "=new Array();" & vbcrlf
			end if
			if listrs("item_type")="class" then
				response.write "Table" & curmenuid & "[Table" & curmenuid & ".length]=['"&listrs("item_id")&"','"&listrs("item_name")&"','"&listrs("item_type")&"','"&listrs("item_content")&"'];" & vbcrlf
			else
				response.write "Table" & curmenuid & "[Table" & curmenuid & ".length]=['"&listrs("item_id")&"','"&listrs("item_name")&"','"&listrs("item_type")&"',''];" & vbcrlf
			end if
			listrs.movenext
		loop
	end if
	listrs.close
end if
%>

function TableListShow(){
	if(TableClub.length>0){
		var TableList=doc.getElementById('TableList');
		for(i=0;i<TableClub.length;i++) TableList.options[TableList.options.length]=new Option(TableClub[i][1],TableClub[i][0]);
	}
}

function TableItemListShow(){
	var TableItemList=doc.getElementById('TableItemList');
	var OrderItemList=doc.getElementById('OrderItemList');
	doc.getElementById('ReplaceString').value='';
	ClassListBox.innerHTML='暂无栏目选项...';
	doc.getElementById('classid').value='';
	TableItemList.options.length=4;
	OrderItemList.options.length=4;
	TableItemList.selectedIndex=0;
	OrderItemList.selectedIndex=0;
	doc.getElementById("tempUsedFields").options.length=0;
	UsedFieldsChange();
	doc.getElementsByName('ClassFrom')[0].click();
	if(doc.getElementById('TableList').value!='0'){
		eval('var _tableitems=Table'+doc.getElementById('TableList').value);
		if(_tableitems){
			for(i=0;i<_tableitems.length;i++){
				if(_tableitems[i][2]=='link'){
					doc.getElementById("OutLink").value=_tableitems[i][0] + "_" + _tableitems[i][2];
				}else{
					TableItemList.options[TableItemList.options.length]=new Option(_tableitems[i][1],_tableitems[i][0] + "_" + _tableitems[i][2]);
					OrderItemList.options[OrderItemList.options.length]=new Option(_tableitems[i][1],_tableitems[i][0] + "_" + _tableitems[i][2]);
					if(_tableitems[i][2]=='class') ClassListBox.innerHTML = ClassListBox.innerHTML.replace('暂无栏目选项...','') + '<select name="' + _tableitems[i][0] + '_class" id="' + _tableitems[i][0] + '_class" title="' + _tableitems[i][3] + '" disabled onchange="ClassGet();"></select> ';
				}
			}
		}
	}
}

function ClassStateSet(_state){
	if(_state==1){
		ClassListBox.disabled=true;
		var selects=ClassListBox.getElementsByTagName('select');
		for(i=0;i<selects.length;i++) selects[i].disabled=true;
		doc.getElementById("classid").value="";
	}else if(_state==2||_state==3){
		ClassListBox.disabled=false;
		var selects=ClassListBox.getElementsByTagName('select');
		for(i=0;i<selects.length;i++){
			selects[i].disabled=false;
			if(selects[i].options.length<=1) startXmlRequest("POST","../../JCP_Script/JCP_Class_JS.asp?itemid=" + selects[i].id.replace('Item_','').replace('_class','') + "&rootid=" + selects[i].title + "&classid=0",null,"body","eval(xml_BackCont)","",false);
		}
		ClassGet();
	}
}

function ClassGet(){
	var selects=ClassListBox.getElementsByTagName('select');
	var classid=doc.getElementById('classid');
	classid.value='';
	for(i=0;i<selects.length;i++){
		if(classid.value=='') classid.value=selects[i].value;
		else classid.value += '&' + selects[i].value;
	}
}

function ClassSet(){
	var selects=ClassListBox.getElementsByTagName('select');
	var classid=doc.getElementById('classid').value;
	var pclassid=classid.split("&");
	if(pclassid.length==selects.length){
		for(i=0;i<selects.length;i++){
			selects[i].value=pclassid[i];
		}
	}
}

function UsedFieldsSet(setType){
	if(setType=="add"){
		var o1=doc.getElementById("TableItemList");
		var o2=doc.getElementById("ReplaceString");
		var o3=doc.getElementById("tempUsedFields");
		if(o1.selectedIndex==0){
			alert("请选择创建所需的字段项目!");
			o1.focus();
		}else{
			if(BlankYn(o2.value)){
				alert("字段项目对应的替换文字不能为空!");
			}else{
				if(IllegalCheck(o2.value,o2)){
					var haveYN=false;
					for(i=0;i<o3.length;i++){
						if(o3.options[i].text==o1.options[o1.selectedIndex].text){
							haveYN=true;
							o1.focus();
							break;
						}
					}
					if(haveYN){
						alert("当前字段项目已经存在,请更换!");
					}else{
						o3.options[o3.options.length]=new Option(o1.options[o1.selectedIndex].text + ' -> ' + o2.value,o1.value + '=' + o2.value);
						o1.selectedIndex=0;
						o2.value='';
						UsedFieldsChange();
					}
				}
			}
		}
	}else if(setType=="del"){
		var o1=doc.getElementById("tempUsedFields");
		if(o1.selectedIndex>-1){
			if(confirm("您确定要删除当前字段项目吗??")){
				o1.options.remove(o1.selectedIndex);
				UsedFieldsChange();
			}
		}else{
			alert("请选择要删除的字段项目!");
			o1.selectedIndex=0;
		}
	}
}
function UsedFieldsChange(){
	var o4=doc.getElementById("tempUsedFields");
	var o5=doc.getElementById("UsedFields");
	o5.value='';
	for(i=0;i<o4.length;i++){
		if(o5.value==''){
			o5.value += o4.options[i].value;
		}else{
			o5.value += '|' + o4.options[i].value;
		}
	}
}
function UsedFieldsReturn(){
	var o1=doc.getElementById("TableItemList");
	var o4=doc.getElementById("tempUsedFields");
	var o5=doc.getElementById("UsedFields");
	if(!BlankYn(o5.value)){
		var fList=o5.value.split("|");
		for(i=0;i<fList.length;i++){
			var pItem=fList[i].split("=");
			if(pItem.length=2){
				for(j=0;j<o1.length;j++){
					if(o1.options[j].value==pItem[0]) o4.options[o4.length]=new Option(o1.options[j].text + ' -> ' + pItem[1],fList[i]);
				}
			}
		}
	}
}

TableListShow();

<% 
dim rs,blockid,BlockAttribute,tproperty,i
blockid=J.NumberYN(request.querystring("blockid"))
set rs=J.Data.Exe("select blockname,blocktype,blockexplain,blockfolder,BlockAttribute from JCP_BlockList where id="&blockid)
if not rs.eof then
	response.write "doc.getElementById('blockname').value='" & rs("blockname") & "';" & vbcrlf
	response.write "doc.getElementById('blocktype').value='" & rs("blocktype") & "';" & vbcrlf
	response.write "doc.getElementById('blockfolder').value='" & rs("blockfolder") & "';" & vbcrlf
	response.write "doc.getElementById('blockexplain').value='" & rs("blockexplain") & "';" & vbcrlf
	
	BlockAttribute=rs("BlockAttribute")
	tproperty=split(BlockAttribute,"{$|}")
	if ubound(tproperty)=10 then
		response.write "doc.getElementById('TableList').value='" & tproperty(0) & "';TableItemListShow();" & vbcrlf
		response.write "doc.getElementsByName('ClassFrom')["&(Cint(tproperty(1))-1)&"].click();" & vbcrlf
		if tproperty(2)="yes" then response.write "doc.getElementById('SubClass').checked=true;" & vbcrlf
		response.write "doc.getElementById('classid').value='" & tproperty(3) & "';ClassSet();" & vbcrlf
		response.write "doc.getElementById('OrderItemList').value='" & tproperty(4) & "';" & vbcrlf
		response.write "doc.getElementById('blockorder').value='" & tproperty(5) & "';" & vbcrlf
		response.write "doc.getElementById('UsedFields').value='" & tproperty(6) & "';UsedFieldsReturn();" & vbcrlf
		response.write "var strs01=""" & replace(replace(replace(tproperty(7),"<","&lt;"),"""","&quot;"),chr(13)&chr(10),"\n") & """;" & vbcrlf
		response.write "var strs02=""" & replace(replace(replace(tproperty(8),"<","&lt;"),"""","&quot;"),chr(13)&chr(10),"\n") & """;" & vbcrlf
		response.write "doc.getElementById('blockelement').value=strs01.replace(/&quot;/gi,'""').replace(/&lt;/gi,'\<');" & vbcrlf
		response.write "doc.getElementById('blockoutside').value=strs02.replace(/&quot;/gi,'""').replace(/&lt;/gi,'\<');" & vbcrlf
		response.write "doc.getElementById('PageSize').value='" & tproperty(9) & "';" & vbcrlf
	end if
end if
rs.close
%>
</script>
<!--#include file="../../JCP_Shared/foot.asp" -->
<% J.close %>