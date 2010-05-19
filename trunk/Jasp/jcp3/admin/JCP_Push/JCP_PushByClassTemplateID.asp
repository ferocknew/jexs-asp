<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Push.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/TemplatePush.js"></script>
<script language="JavaScript" type="text/JavaScript">
	var doc=document;
	var ClassClub="",PushClass,TemplateID;
	
	function PushCheck(){
		if(ClassClub.indexOf(",")>0){
			if(doc.getElementById("model")){
				PushNow("PushCollect();");
			}else{
				alert("没有模板数据，在当前推送方式下不能完成推送操作！");
				IniSystem();
			}
		}else{
			alert("没有类别信息，在当前推送方式下不能完成推送操作！");
			IniSystem();
		}
	}
	
	function PushCollect(){
		var _classobj=ClassClub.split(",");
		var _casevalue="";_caseexp="";_pushtype="";
		for(i=0;i<_classobj.length-1;i++){
			if(i==0){
				_casevalue = eval(_classobj[i] + ".value");
			}else{
				_casevalue += "|" + eval(_classobj[i] + ".value");
			}
		}
		_pushtype=doc.getElementById("model").value.split(",")[1];
		if(_pushtype=="0") _caseexp="推送栏目首页　栏目ID：" + _casevalue + "　模板：" + doc.getElementById("model").options[doc.getElementById("model").selectedIndex].text;
		else if(_pushtype=="1") _caseexp="推送栏目列表　栏目ID：" + _casevalue + "　模板：" + doc.getElementById("model").options[doc.getElementById("model").selectedIndex].text;
		else if(_pushtype=="2") _caseexp="推送栏目内容　栏目ID：" + _casevalue + "　模板：" + doc.getElementById("model").options[doc.getElementById("model").selectedIndex].text;
		_casevalue += "," + doc.getElementById("model").value.split(",")[0];
		addPushCase("s,i",_casevalue,_caseexp,_pushtype)
	}
	
	function TemplateListDisplay(){
		var classparam=ClassClub.split(",");
		var classes=""
		if(classparam.length>1){
			TemplateLists.innerHTML="模板载入中……";
			for(i=0;i<classparam.length;i++){
				if(classparam[i]!=""){
					if(doc.getElementById(classparam[i])){
						classes += "&" + classparam[i] + "=" + doc.getElementById(classparam[i]).value;
					}
				}
			}
			startXmlRequest("POST","JCP_Push_XML.asp?action=templatelistdisplay" + classes + "&sysid=<%= request.querystring("sysid") %>",null,"body","","",false);
			TemplateLists.innerHTML=xml_BackCont;
		}
	}
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<script language="JavaScript">
	document.onkeypress=function keypush(){if(event.keyCode==32){document.all.pushnow.blur();document.all.pushnow.click();}}
	</script>
	<%
	response.write "<div class=""app_title"">类别推送</div>"&vbcrlf
	dim sysid,rs,classstrs,classname,classid,queryi
	if instrRev(request.ServerVariables("QUERY_STRING"),"&")>0 then
		classstrs=split(request.ServerVariables("QUERY_STRING"),"&")
		for queryi=0 to ubound(classstrs)
			if instr(classstrs(queryi),"_class=")>0 then
				classname=trim(split(classstrs(queryi),"=")(0))
				classid=trim(split(classstrs(queryi),"=")(1))
				if isnumeric(classid) and classid<>"" then
					classid=Clng(classid)
				else
					classname=""
					classid=0
				end if
				exit for
			else
				classname=""
				classid=0
			end if
		next
	else
		classname=""
		classid=0
	end if
	sysid=trim(request.QueryString("sysid")&"")
	if sysid="" then
		SysList
	else
		if isnumeric(sysid) then
			sysid=CLng(sysid)
			PushByClass
		else
			SysList
		end if
	end if
	
	sub SysList()
			set rs=J.Data.Exe("select menuid,menutitle from JCP_AppSystem where typeid=1 order by menuid")
			if rs.eof then
				response.Write("暂无系统！")
			else
				response.write "<br><br>　请选择可以操作的系统:"
				do while not rs.eof
					response.write "<li class=sysitem><span class=""sysname""><a href=""?sysid="&rs("menuid")&"&sysname="&rs("menutitle")&""">"&rs("menutitle")&"</a></span></li>"
					rs.movenext
				loop
			end if
			rs.close
	end sub
	
	sub PushByClass()
		if classname="" then
			set rs=J.Data.Exe("select menuid,menutitle from JCP_AppSystem where typeid=1 order by menuid")
			if rs.eof then
				response.Write("暂无系统！")
			else
				do while not rs.eof
					if sysid=rs("menuid") then
						response.write "<div class=manage_button_cur>"&rs("menutitle")&"</div>"
					else
						response.write "<div class=manage_button><a href=""?sysid="&rs("menuid")&"&sysname="&rs("menutitle")&""">"&rs("menutitle")&"</a></div>"
					end if
					rs.movenext
				loop
			end if
			rs.close
			response.write "<br>"
		end if

		response.write "<br><br>　选择推送栏目： "
		set rs=J.Data.Exe("select item_id,item_name,item_content from JCP_ArtSys where sys_id="&sysid&" and item_type='class' order by item_order")
		if rs.eof then
			response.write "当前系统不包含栏目!"
		else
			dim classnum:classnum=0
			do while not rs.eof
				classnum=classnum+1
				if rs("item_id")&"_class"=classname then
					dim rss
					set rss=J.Data.ReRsOpen("select classname from JCP_class where classid="&classid,"rss",1)
					if not rss.eof then
						response.write classnum & "." & rss(0)
						response.write "<input type=hidden id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"" value="""&classid&""">　"
					else
						response.write classnum & "." & "<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"" onchange=""TemplateListDisplay();""></select><script language=""javascript"">startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid="&rs("item_content")&"&classid="&rs("item_content")&""",null,""body"",""eval(xml_BackCont)"","""",false);</script>　"
					end if
					rss.close
				else
					response.write classnum & "." & "<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"" onchange=""TemplateListDisplay();""></select><script language=""javascript"">startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid="&rs("item_content")&"&classid="&rs("item_content")&""",null,""body"",""eval(xml_BackCont)"","""",false);</script>　"
				end if
				response.write "<script language=""javascript"">ClassClub += """&rs("item_id")&"_class,"";</script>"
				rs.movenext
			loop
		end if
		rs.close

		response.write "<br><br>　选择推送模板： <span id=""TemplateLists""><script>TemplateListDisplay();</script></span>"
		%>
		<div id="push_button"><input name="pushnow" type="button" class="system_button_00" value="立即生成静态页面 （空格）" onClick="PushCheck()"></div>
		<div style="height:20px;"></div>
		<script language="JavaScript">
			pushBar("0%","#FFFFFF","#000000","100%","20px","2px");
		</script>
		<% 
	end sub
	%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
