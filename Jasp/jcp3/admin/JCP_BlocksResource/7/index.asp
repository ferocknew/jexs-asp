<!--#include file="../../JCP_Shared/asp_head.asp" -->
<!--#include file="../../JCP_Shared/head.asp" -->
<script language="VBScript" src="../../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	doc.title="������ʾģ�� �½����ڡ�������������������������������������������������������������";
	
	function FromCheck(){
		if(BlockNameCheck()==false) return false;
		if(TableIdCheck()==false) return false;
		if(UsedFieldsCheck()==false) return false;
		if(BlockElementCheck()==false) return false;
		return true;
	}
	
	function BlockNameCheck(){
		var o=doc.getElementById("blockname");
		startXmlRequest("POST","../../JCP_BlockList/JCP_BlockAction_XML.asp?action=blocknamecheck&blockname=" + o.value,null,"body","","",false);
		if(xml_BackCont!="OK"){
			alert("ģ�������Ѿ����ڣ��������");
			o.select();
			return false;
		}
	}
	
	function TableIdCheck(){
		var o=doc.getElementById("TableList");
		if(o.selectedIndex==0){
			alert("��ѡ��Ŀ��ϵͳ!");
			o.focus();
			return false;
		}
	}
	
	function UsedFieldsCheck(){
		var o=doc.getElementById("UsedFields");
		if(BlankYn(o.value)){
			alert("�봴����������!");
			doc.getElementById("TableItemList").focus();
			return false;
		}
	}
	
	function BlockElementCheck(){
		var o=doc.getElementById("blockelement");
		if(BlankYn(o.value)){
			alert("�봴����������!");
			o.select();
			return false;
		}
	}
-->
</script>
<base target="_self">
<!--#include file="../../JCP_Shared/body.asp" -->
<form name="blockform" method="post" action="action.asp?action=createblock" style="margin:0;">
  <table width="100%" height="101" border="0" cellpadding="4" cellspacing="0">
    <tr> 
      <td width="60" height="29" align="right">ģ�����ƣ�</td>
      <td colspan="2"><input type=text id=blockname name=blockname value="������ʾģ��" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);">
        </td>
    </tr>
    <tr> 
      <td height="29" align="right">ģ��˵����</td>
      <td colspan="2"><input type=text id=blockexplain name=blockexplain value="��������������ʾ�������ݷ�ҳ����" onblur="IllegalCheck(this.value,this);BlankCheck(this.value,this);" style="width:100%;"></td>
    </tr>
    <tr> 
      <td height="29" align="right">Ŀ��ϵͳ��</td>
      <td colspan="2"><select name="TableList" id="TableList" onchange="TableItemListShow();">
          <option value="0" selected>��ѡ��Ŀ��ϵͳ</option>
        </select></td>
    </tr>
    <tr> 
      <td align="right">�������ݣ�</td>
      <td><select name="TableItemList" id="TableItemList" onchange="if(this.selectedIndex==0){ReplaceString.value='';}else{ReplaceString.value=this.options[this.selectedIndex].text;ReplaceString.select();}">
            <option value="0" selected>��ѡ���ֶ�</option>
            <option value="id">��¼ID</option>
            <option value="uptime">����ʱ��</option>
            <option value="hits">�����</option>
          </select> <input type="button" class="system_button_00" name="Button" value="���" onclick="UsedFieldsSet('add');"> <input type="button" class="system_button_00" name="Button2" value="ɾ��" onclick="UsedFieldsSet('del');"> 
      </td>
      <td rowspan="2" valign="top" width="180"><select name="tempUsedFields" size="4" id="tempUsedFields" style="width:100%;" ondblclick="alert(UsedFields.value);"></select></td>
    </tr>
    <tr> 
      <td align="right">�滻�ַ���</td>
      <td><input type="text" name="ReplaceString" style="width:200px;"> <input type="hidden" name="UsedFields" id="UsedFields"></td>
    </tr>
    <tr> 
      <td height="12" align="right">������ʽ��</td>
      <td colspan="2"><textarea name="blockelement" id="blockelement" style="width:100%;height:60px;"><div><link target="_blank">���� ��ʱ�䣩</div></textarea></td>
    </tr>
    <tr> 
      <td height="24" align="right">�ⲿ���룺</td>
      <td colspan="2"><textarea name="blockoutside" id="blockoutside" style="width:100%;height:60px;"></textarea></td>
    </tr>
    <!--tr> 
        <td height="24" align="right">��ҳ���룺</td>
      <td colspan="2"><textarea name="blockpageinfo" id="blockpageinfo" style="width:100%;height:60px;"><div>
<span>ҳ�Σ�{��ǰҳ��}/{��ҳ��} ÿҳ{ÿҳ����}�� ��{������}��</span>
<span>
<a href="{��ҳ}">��ҳ</a>
<a href="{��ҳ}">��ҳ</a>
<a href="{��ҳ}">��ҳ</a>
<a href="{βҳ}">βҳ</a>
</span>
</div></textarea></td>
    </tr-->
    <tr align="center"> 
        <td height="12" colspan="3"> <input type=hidden id=blocktype name=blocktype value="2">
          <input type="hidden" name="blockfolder" id="blockfolder" value="<%= request.QueryString("src") %>">
          <input name="OutLink" type="hidden" id="OutLink" value="">
          <input type=submit class="system_button_00" value="�½�ģ��" onclick="doc.all.blockform.onsubmit=function(){return FromCheck()};">����
		<input type=button class="system_button_00" value="ȡ������" onclick="javascript:window.close();">
	  </td>
    </tr>
  </table>
</form>		
<script language=javascript>
reSize(500,380);

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
	doc.getElementById('ReplaceString').value='';
	TableItemList.options.length=4;
	TableItemList.selectedIndex=0;
	doc.getElementById("tempUsedFields").options.length=0;
	UsedFieldsChange();
	if(doc.getElementById('TableList').value!='0'){
		eval('var _tableitems=Table'+doc.getElementById('TableList').value);
		if(_tableitems){
			for(i=0;i<_tableitems.length;i++){
				if(_tableitems[i][2]=='link'){
					doc.getElementById("OutLink").value=_tableitems[i][0] + "_" + _tableitems[i][2];
				}else if(_tableitems[i][2]=='pics'){
					TableItemList.options[TableItemList.options.length]=new Option(_tableitems[i][1],_tableitems[i][0] + "_" + _tableitems[i][2]);
					TableItemList.options[TableItemList.options.length]=new Option("���ļ�����(" + i + ')',_tableitems[i][0] + "_" + _tableitems[i][2] + "_title");
				}else{
					TableItemList.options[TableItemList.options.length]=new Option(_tableitems[i][1],_tableitems[i][0] + "_" + _tableitems[i][2]);
				}
			}
		}
	}
}

function UsedFieldsSet(setType){
	if(setType=="add"){
		var o1=doc.getElementById("TableItemList");
		var o2=doc.getElementById("ReplaceString");
		var o3=doc.getElementById("tempUsedFields");
		if(o1.selectedIndex==0){
			alert("��ѡ�񴴽�������ֶ���Ŀ!");
			o1.focus();
		}else{
			if(BlankYn(o2.value)){
				alert("�ֶ���Ŀ��Ӧ���滻���ֲ���Ϊ��!");
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
						alert("��ǰ�ֶ���Ŀ�Ѿ�����,�����!");
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
			if(confirm("��ȷ��Ҫɾ����ǰ�ֶ���Ŀ��??")){
				o1.options.remove(o1.selectedIndex);
				UsedFieldsChange();
			}
		}else{
			alert("��ѡ��Ҫɾ�����ֶ���Ŀ!");
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

TableListShow();
</script>
<!--#include file="../../JCP_Shared/foot.asp" -->
<% J.close %>