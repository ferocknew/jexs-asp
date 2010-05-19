<!--#include file="../../JCP_Search/Inc/Class_Search.asp" -->
<% 
	dim J
	set J=new JCP
	J.open null
%>
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	
	function CreateObject(){
		var oN=doc.getElementById("objectName");
		if(!BlankYn(oN.value)){
			var oL=doc.getElementById("objectList");
			var maxL=0;
			if(oL.length>0) maxL=parseInt(oL.options[oL.length-1].value) + 1;
				else maxL=1;
			oL.options[oL.length]=new Option(oN.value,maxL);
			oN.value="";
			SameObject();
		}else{
			alert("请认真填写对象名称！");
		}
		oN.select();
		oN.focus();
	}
	function DeleteObject(){
		if(confirm("您确定要删除此搜索对象？？")){
			var oL=doc.getElementById("objectList");
			var bL=doc.getElementById("bindList");
			if(parseInt(oL.value)>0){
				if(bL.length>0){
					var _length=bL.length;
					for(j=0;j<bL.length;j++){
						if((bL.options[j].value + "$").indexOf("|" + oL.value + "$")>0){
							bL.remove(j);
							j=-1;
						}
					}
					if(_length!=bL.length) SameSystem();
				}
				oL.remove(oL.selectedIndex);
				SameObject();
			}else alert("请选择要删除的搜索对象！");
		}
	}
	function SameObject(){
		var oL=doc.getElementById("objectList");
		var oLE=doc.getElementById("objectListElement");
		if(oL.length>0){
			oLE.length=0;
			for(i=0;i<oL.length;i++){
				oLE.options[oLE.length]=new Option(oL.options[i].text,oL.options[i].value);
			}
			oL.selectedIndex=oL.length-1;
		}else oLE.length=0;
	}
	
	var systemElements=new Array();
	
	function SystemList(menuid){
		var sE=systemElements["system_" + menuid];
		var sL=doc.getElementById("systemList");
		alert(systemElements.length);
		if(sE){
			sL.length=0;
			for(i=0;i<sE.length;i++){
				sL.options[sL.length]=new Option(sE[i].name,sE[i]);
			}
		}
	}
	
	function BindSystem(){
		var sN=doc.getElementById("systemName");
		var sL=doc.getElementById("systemList");
		var oL=doc.getElementById("objectList");
		var bL=doc.getElementById("bindList");
		if(sN && sL && oL && bL){
			if(sL.selectedIndex>-1 && oL.selectedIndex>0){
				var optionValue=sN.value + "|" + sL.value + "|" + oL.value;
				var optionText="[" + sN.options[sN.selectedIndex].text + "]" + sL.options[sL.selectedIndex].text + " ∞ " + oL.options[oL.selectedIndex].text;
				if(BindCheck(optionValue)) bL.options[bL.length]=new Option(optionText,optionValue);
				SameSystem();
			}
		}
	}
	function BindCheck(curValue){
		var bL=doc.getElementById("bindList");
		if(bL.length>0){
			for(i=0;i<bL.length;i++){
				if(bL.options[i].value==curValue){	
					alert("此项绑定已经存在，不用重复输入！");
					return false;
					break;
				}
			}
			return true;
		}else return true;
	}
	function DeleteBindItem(){
		if(confirm("您确定要删除此绑定记录？？")){
			var bL=doc.getElementById("bindList");
			if(bL){
				if(bL.selectedIndex>-1) bL.remove(bL.selectedIndex);
			}
			SameSystem();
		}
	}
	
	function SameSystem(){
		var bL=doc.getElementById("bindList");
		var sN=doc.getElementById("systemName");
		var sLE=doc.getElementById("systemListElement");
		var tBL=doc.getElementById("trueBindList");
		sLE.length=1;
		tBL.value="";
		if(bL.length>0){
			var sysids="|";
			for(i=0;i<bL.length;i++){
				var cursysid = bL.options[i].value.split("|")[0];
				if(sysids.indexOf("|" + cursysid + "|")<0) sysids += cursysid + "|";
				if(i==0) tBL.value += bL.options[i].value + "|" + bL.options[i].text.replace(/^(\S*\s*)+(∞ )/gi,"");
					else  tBL.value += "||" + bL.options[i].value + "|" + bL.options[i].text.replace(/^(\S*\s*)+(∞ )/gi,"");
			}
			var sysid=sysids.split("|");
			for(i=0;i<sysid.length;i++){
				if(sysid[i]){
					for(j=0;j<sN.length;j++){
						if(parseInt(sN[j].value)==parseInt(sysid[i])) sLE.options[sLE.length]=new Option(sN.options[j].text,sN.options[j].value);
					}
				}
			}
		}
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->

<% 
if request.querystring("action")="newsearch" then
	S.MainOpen
	dim searchName,bindList,objectListElement,systemListElement,stylesheet
	searchName=request.Form("searchName")
	bindList=request.Form("trueBindList")
	objectListElement=request.Form("objectListElement")
	systemListElement=request.Form("systemListElement")
	stylesheet=request.Form("stylesheet")
	
	S.NewSearch searchName,bindList,objectListElement,systemListElement,stylesheet
	
	S.MainClose
	J.close
	
	response.redirect "../../" & SameManagePath & "Inc/Action.asp?action=newsearch2js"
	response.end
end if
%>


	<div class="app_title">留言管理</div>
	
  <div class="list_box">
  <form name="form1" method="post" action="?action=newsearch">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><fieldset><legend>搜索引擎名称</legend>
            <input type="text" name="searchName">
            </fieldset></td>
      </tr>
      <tr><td height=10></td></tr>
      <tr>
        <td><fieldset><legend>创建搜索对象</legend>
            <input type="text" name="objectName" id="objectName">
            <input type="button" name="Submit2" value="创建对象" onclick="CreateObject();">
            </fieldset></td>
      </tr>
      <tr><td height=10></td></tr>
      <tr>
        <td><fieldset>
            <legend>设置搜索范围</legend>
            <table border="0" cellspacing="6" cellpadding="0">
              <tr align="center"> 
                <td width="140"> <select name="systemName" id="systemName" size="1" style="width:100%" onchange="SystemList(this.value);">
                    <option value="0" selected>查看现有系统</option>
                    <% 
					dim menuids
					menuids=""
					set jrs=J.data.RsOpen("select menuid,menutitle from JCP_AppSystem where typeid=1 order by menuid",1)
					do while not jrs.eof
						response.write "<option value=""" & jrs("menuid") & """>" & jrs("menutitle") & "</option>"
						if menuids="" then menuids=jrs("menuid") else menuids=menuids & "|" & jrs("menuid")
						jrs.movenext
					loop
					jrs.close
					
					sub FindElement(sysid)
						dim srs,paramsysid,idi
						if sysid&""<>"" then
							response.write vbcrlf & "<script language=""JavaScript"">" & vbcrlf
							if instr(sysid&"","|")>0 then
								paramsysid=split(sysid,"|")
								for idi=0 to ubound(paramsysid)
									set srs=J.data.ReRsOpen("select id,item_id,item_type,item_name from JCP_ArtSys where sys_id=" & paramsysid(idi) & " and item_type in ('text','edit') order by item_order","srs",1)
									response.write vbcrlf & "systemElements[systemElements.length]=['system_" & paramsysid(idi) & "',new Array()];" & vbcrlf
									do while not srs.eof
										response.write "systemElements[systemElements.length-1][1][systemElements[systemElements.length-1][1].length]=['" & srs("id") & "','" & srs("item_name") & "','" & srs("item_id") & "_" & srs("item_type") & "'];" & vbcrlf
										srs.movenext
									loop
									srs.close
								next
							else
								set srs=J.data.ReRsOpen("select id,item_id,item_type,item_name from JCP_ArtSys where sys_id=" & sysid & " and item_type in ('text','edit') order by item_order","srs",1)
								response.write vbcrlf & "systemElements[systemElements.length]=['system_" & sysid & "',new Array()];" & vbcrlf
								do while not srs.eof
									response.write "systemElements[systemElements.length-1][1][systemElements[systemElements.length-1][1].length]=['" & srs("id") & "','" & srs("item_name") & "','" & srs("item_id") & "_" & srs("item_type") & "'];" & vbcrlf
									srs.movenext
								loop
								srs.close
							end if
							response.write "</script>"
						end if
					end sub
					%>
                  </select></td>
                <td width="140" rowspan="2"><p> 
                    <select name="objectList">
                      <option value="0" selected>现有对象</option>
                    </select>
                  </p>
                  <p> 
                    <input type="button" name="Submit3" value="删除此对象" onclick="DeleteObject();">
                  </p>
                  <p> 
                    <input type="button" name="Submit4" value="绑定此对象" onclick="BindSystem();">
                  </p>
                  <p> 
                    <input type="button" name="Submit5" value="删除此绑定" onclick="DeleteBindItem();">
                    <input name="trueBindList" type="hidden" id="trueBindList">
                  </p></td>
                <td width="240" rowspan="2"><select name="bindList" id="bindList" size="12" style="width:100%">
                  </select></td>
              </tr>
              <tr align="center">
                <td> <select name="systemList" id="systemList" size="10" style="width:100%">
                  </select> <% FindElement menuids %> <script language="JavaScript">
				<!--
					function SystemList(menuid){
						var sE=systemElements;
						var sL=doc.getElementById("systemList");
						if(parseInt(menuid)>0){
							if(sE){
								for(j=0;j<sE.length;j++){
									if(sE[j][0]=="system_" + menuid){
										sL.length=0;
										for(i=0;i<sE[j][1].length;i++){
											sL.options[sL.length]=new Option(sE[j][1][i][1],sE[j][1][i][0] + "|" + sE[j][1][i][2]);
										}
									}
								}
							}
						}else sL.length=0;
					}
				-->
				</script> </td>
              </tr>
            </table>
            </fieldset></td>
      </tr>
      <tr><td height=10></td></tr>
      <tr>
        <td><fieldset>
            <legend>设置相关参数</legend>
            <table width="100%" border="0" cellspacing="6" cellpadding="0">
              <tr>
                <td>默认搜索对象： 
                  <select name="objectListElement">
                    <option value="0" selected>所有对象</option>
                  </select></td>
              </tr>
              <tr>
                <td>默认搜索范围： 
                  <select name="systemListElement">
                    <option value="0" selected>所有系统</option>
                  </select></td>
              </tr>
            </table>
            </fieldset></td>
      </tr>
      <tr>
          <td height=10></td>
        </tr>
      <tr>
        <td><fieldset>
            <legend>设置搜索样式
            </legend>
			可用对象名称：关键字（JCP_Search_KeyWord）、搜索对象（JCP_Search_Object）、搜索范围（JCP_Search_Range）
            <textarea name="stylesheet" id="stylesheet" rows="6" style="width:100%;">
<input type="text" name="JCP_Search_KeyWord" id="JCP_Search_KeyWord">
<select name="JCP_Search_Object" id="JCP_Search_Object"></select>
<select name="JCP_Search_Range" id="JCP_Search_Range"></select>
<input type="submit" name="JCP_Search_Button" value="搜索"></textarea>
			</fieldset></td>
      </tr>
      <tr><td height=10></td></tr>
      <tr>
        <td align="center">
            <input type="submit" name="Submit" value="新建搜索引擎　生成调用代码">
        </td>
      </tr>
    </table>
  </form>
  </div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>