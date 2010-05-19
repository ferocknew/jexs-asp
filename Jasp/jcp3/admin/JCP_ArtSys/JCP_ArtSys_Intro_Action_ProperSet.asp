<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<!--#include file="../JCP_Shared/body.asp" -->
<% if request.QueryString("action")="interfaceset" then %>
    <table width="374" height="269" border="0" cellpadding="0" cellspacing="0">
      <tr> 
        <td width="60" height="41">所需系统：</td>
        <td width="126">
			<select id="_NeedSystemName" name="_NeedSystemName" onChange="DataDisplay();">
            	<option selected>请选择系统</option>
            </select>
		</td>
        <td width="60">现有系统：</td>
        <td width="126">
			<select id="_AimSystemName" name="_AimSystemName" onChange="AimDataDisplay(true);" oldindex="0">
            	<option selected>请选择系统</option>
            </select>
		</td>
      </tr>
      <tr valign="top"> 
        <td height="99" colspan="4"><table width="100%" height="99" border="0" cellpadding="0" cellspacing="0">
            <tr align="center">
              <td width="43%" height="89">
			  	<select name="_NeedSystemItems" id="_NeedSystemItems" size="1" multiple style="width:100%;height:100%;">
                </select></td>
              <td width="14%"><input type="button" class="system_button_00" name="Submit3" value="绑定" onClick="bindData();">
                <br>
                <br>
                <input type="button" class="system_button_00" name="Submit32" value="删除" onClick="deleteData();"></td>
              <td width="43%"><select name="_AimSystemItems" id="_AimSystemItems" size="1" multiple style="width:100%;height:100%;">
                </select></td>
            </tr>
          </table></td>
      </tr>
      <tr align="center"> 
        <td height="95" colspan="4"><select name="_BindList" id="_BindList" size="1" multiple style="width:100%;height:100%;">
          </select></td>
      </tr>
      <tr> 
        <td height="34" colspan="4" align="center">
		  <input type="submit" class="system_button_00" name="Submit" value="绑定接口" onClick="saveBindData();">　
          <input type="button" class="system_button_00" name="Submit2" value="跳过绑定" onclick="window.returnValue='SKIP';window.close();">
		  
			<input type=hidden name="CurSystemLogo" id="CurSystemLogo" value="">
		</td>
      </tr>
    </table>
  <script language="JavaScript">
<!--
	var doc=document;
	var parentWin = window.dialogArguments;
	startXmlDom(parentWin.path + "/config.xml");
	
	var systemNodes=xmlRoot.selectSingleNode("system-need");
	doc.title=xmlRoot.selectSingleNode("name").text;
	doc.getElementById("CurSystemLogo").value=xmlRoot.selectSingleNode("logo").text;
	var _need=doc.getElementById("_NeedSystemName");
	var _needItem=doc.getElementById("_NeedSystemItems");
	var _aim=doc.getElementById("_AimSystemName");
	var _aimItem=doc.getElementById("_AimSystemItems");
	var _bindList=doc.getElementById("_BindList");
	
	var SystemList=new Array();	//格式  [need_system_name,[[need_item_name,need_item_logo],[need_item_name,need_item_logo],...],aim_system_name,aim_system_logo,[need_item_logo=aim_item_logo,need_item_logo=aim_item_logo,...]]
	var rData=new Array();			//格式	[[aim_system_name,aim_system_logo,[[aim_item_name,aim_item_logo],[aim_item_name,aim_item_logo],...]],[aim_system_name,aim_system_logo,[[aim_item_name,aim_item_logo],[aim_item_name,aim_item_logo],...]],...]
	
	if(systemNodes){
		for(i=0;i<systemNodes.childNodes.length;i++){
			if(systemNodes.childNodes[i].selectSingleNode("intro-param/param")){
				_need.options[_need.length]=new Option(systemNodes.childNodes[i].selectSingleNode("title").text,i);
				var paramNodes=systemNodes.childNodes[i].selectSingleNode("intro-param");
				var paramItems=new Array();
				for(j=0;j<paramNodes.childNodes.length;j++){
					paramItems[paramItems.length]=[paramNodes.childNodes[j].selectSingleNode("title").text,paramNodes.childNodes[j].selectSingleNode("logo").text];
				}
				SystemList[SystemList.length]=[systemNodes.childNodes[i].selectSingleNode("title").text,paramItems,null,null,null];  //[所需名称，所需明细，目标名称，目标标识，匹配结果]
			}
		}
	}
	
	if(_need.length>1) _need.options.remove(0);
	
	function AimDataGet(){
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=loadaimdata",null,"body","","",false)
		if(xml_BackCont!="no data"){
			eval("rData=" + xml_BackCont);
			for(i=0;i<rData.length;i++){
				_aim.options[_aim.length]=new Option(rData[i][0],rData[i][1]);
			}
		}
	}
	
	AimDataGet();
	
	function AimDataDisplay(changeyn){
		if(SystemList[_need.selectedIndex][2]&&changeyn){
			if(confirm("更新目标系统将导致原绑定数据丢失，继续吗？")){
				var _aimIndex=_aim.selectedIndex-1;
				_aimItem.length=0;
				if(_aimIndex>-1){
					for(i=0;i<rData[_aimIndex][2].length;i++){
						_aimItem.options[_aimItem.length]=new Option(rData[_aimIndex][2][i][0],rData[_aimIndex][2][i][1]);
					}
				}
				_aim.setAttribute("oldindex",_aim.selectedIndex);
				
				clearBindData(_need.selectedIndex);
				_bindList.length=0;
			}else{
				_aim.selectedIndex=parseInt(_aim.getAttribute("oldindex"));
			}
		}else{
			var _aimIndex=_aim.selectedIndex-1;
			_aimItem.length=0;
			if(_aimIndex>-1){
				for(i=0;i<rData[_aimIndex][2].length;i++){
					_aimItem.options[_aimItem.length]=new Option(rData[_aimIndex][2][i][0],rData[_aimIndex][2][i][1]);
				}
			}
			_aim.setAttribute("oldindex",_aim.selectedIndex);
		}
	}
	
	function DataDisplay(){
		var _needIndex=_need.options[_need.selectedIndex].value;
		if(_need.options[_needIndex].value){
			_needItem.options.length=0;
			for(i=0;i<SystemList[_needIndex][1].length;i++){
				_needItem.options[_needItem.length]=new Option(SystemList[_needIndex][1][i][0],SystemList[_needIndex][1][i][1]);
			}
		}
		_bindList.length=0;
		if(SystemList[_need.selectedIndex][2]){
			_aim.value=SystemList[_need.selectedIndex][3];
			AimDataDisplay();
			
			var _curList=SystemList[_need.selectedIndex][4];
			for(i=0;i<_curList.length;i++){
				var _needLogo=_curList[i].split("=")[0];
				var _aimLogo=_curList[i].split("=")[1];
				var _newItem=value2text("need",_need.selectedIndex,_needLogo) + " ∞ " + "[" + SystemList[_need.selectedIndex][2] + "]" + value2text("aim",_aim.selectedIndex-1,_aimLogo);
				var _newValue=_needLogo;
				_bindList.options[_bindList.length]=new Option(_newItem,_newValue);
			}
		}
	}
	
	function value2text(_type,_index,_value){
		if(_type=="need"){
			for(j=0;j<SystemList[_index][1].length;j++){
				if(SystemList[_index][1][j][1]==_value){
					return SystemList[_index][1][j][0];
					break;
				}
			}
		}else{
			for(j=0;j<rData[_index][2].length;j++){
				if(rData[_index][2][j][1]==_value){
					return rData[_index][2][j][0];
					break;
				}
			}
		}
	}
	
	DataDisplay();

	function bindData(){
		if(_needItem.selectedIndex<0){
			alert("请在左侧列表中选择一项！");
			return false;
		}else if(_aimItem.selectedIndex<0){
			alert("请在右侧列表中选择一项！");
			return false;
		}else{
			var _newItem=_needItem.options[_needItem.selectedIndex].text + " ∞ " + "[" + _aim.options[_aim.selectedIndex].text + "]" + _aimItem.options[_aimItem.selectedIndex].text;
			var _newValue=_needItem.options[_needItem.selectedIndex].value;
			
			if(!SystemList[_need.selectedIndex][2]){
				SystemList[_need.selectedIndex][2]=_aim.options[_aim.selectedIndex].text;
				SystemList[_need.selectedIndex][3]=_aim.options[_aim.selectedIndex].value;
			}
			
			var _sameIndex=bindDataCheck(_newValue);
			if(_sameIndex<0){
				_bindList.options[_bindList.length]=new Option(_newItem,_newValue);
				
				if(!SystemList[_need.selectedIndex][4]) SystemList[_need.selectedIndex][4]=new Array();
				SystemList[_need.selectedIndex][4][SystemList[_need.selectedIndex][4].length]=_needItem.options[_needItem.selectedIndex].value + "=" + _aimItem.options[_aimItem.selectedIndex].value;
			}else{
				if(confirm("正添加的绑定已经存在，是否覆盖！")){
					_bindList.options[_sameIndex]=new Option(_newItem,_newValue);
					
					SystemList[_need.selectedIndex][4][_sameIndex]=_needItem.options[_needItem.selectedIndex].value + "=" + _aimItem.options[_aimItem.selectedIndex].value;
				}
			}
			_needItem.selectedIndex=_aimItem.selectedIndex=-1;
		}
	}

	function bindDataCheck(_value){
		for(i=0;i<_bindList.length;i++){
			if(_value==_bindList.options[i].value) return i;
		}
		return -1;
	}
	
	function clearBindData(_index){
		SystemList[_index][2]=SystemList[_index][3]=SystemList[_index][4]=null;
	}

	function deleteData(){
		if(_bindList.selectedIndex<0) alert("请在下面的列表选择要删除的项！");
		else{
			SystemList[_need.selectedIndex][4].splice(_bindList.selectedIndex,1);
			_bindList.options.remove(_bindList.selectedIndex);
			if(_bindList.options.length==0) SystemList[_need.selectedIndex][2]=SystemList[_need.selectedIndex][3]=SystemList[_need.selectedIndex][4]=null;
			_bindList.selectedIndex=-1;
		}
	}
	
	function saveBindData(){
		var bindcount=0;		//
		var xml='<?xml version="1.0" encoding="gb2312"?>';
		xml += '<binddate>';
		xml += '<cursystemname>' + URLEncoding(doc.title) + '</cursystemname>';
		xml += '<cursystemlogo>' + doc.getElementById("CurSystemLogo").value + '</cursystemlogo>';
		xml += '<bindlist>';
		for(i=0;i<SystemList.length;i++){
			if(SystemList[i][2]){
				for(k=0;k<SystemList[i][4].length;k++){
					xml += '<param>'
						 + '<needname>' + URLEncoding(value2text("need",i,SystemList[i][4][k].split("=")[0])) + '</needname>'
						 + '<needlogo>' + SystemList[i][4][k].split("=")[0] + '</needlogo>'
						 + '<aimlogo>' + SystemList[i][4][k].split("=")[1] + '</aimlogo>'
						 + '<aimsystemlogo>' + SystemList[i][3] + '</aimsystemlogo>'
						 + '</param>';
				}
				bindcount++;
			}
		}
		xml += '</bindlist>';
		xml += '</binddate>';
		
		if(bindcount>0){
			startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=savebinddata",xml,"body","","",false)
			if(xml_BackCont=="OK"){
				window.returnValue="OK";
			}else{
				window.returnValue="ERROR";
			}
			window.close();
		}else{
			alert("绑定设置为空，请完善！");
			return false;
		}
	}
-->
</script>
<% else %>
<% end if %>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>