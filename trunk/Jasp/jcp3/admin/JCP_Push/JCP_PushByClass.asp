<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Push.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" type="text/JavaScript">
	var doc=document;
	var UsedTime,PageCount,CurPage;
	var TempletType,TempletID;
	var ClassClub="",PushClass,PushPath;
	
	function PushNow(){
		if(doc.getElementById("model")){
			if(!confirm("��ȷ��Ҫ����ǰ̨��̬ҳ���𣿣�\n\n���²������ɻָ���")){return false;}
			Init();
			var now=new Date();
			UsedTime=now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds()
			doc.getElementById("ViewList").innerHTML="";
			PushBarImg.src="../JCP_Skin/<%= J.SystemSkin %>/images/pushbar.gif"
			PushBar.style.display="block";
			usedtime.innerHTML="�ܺ�ʱ��<font color=red>" + UsedTime + "</font>";
			//pagecount.innerHTML="������ҳ�棺<font color=red>" + PageCount + "</font>";
			pushinfo.innerHTML="״̬��<font color=green>��������ȡ������Ϣ</font>";
			Steps(1);
		}else{
			alert("δ����ģ����Ϣ������ִ�����Ͳ�����");
		}
	}
	
	function Init(){
		PushView.style.display="block";
		UsedTime=PageCount=PushClass=0;
		CurPage=PushPath="";
	}
	
	function Steps(stepnum){
		if(stepnum==1){                                   //����ģ�壬��ȡģ��ID������
			ListView("���Ϳ�ʼ ...");
			ListView("����ģ��");
			if(model.value.indexOf(",")>0){
				TempletID=Number(model.value.split(",")[0]);
				TempletType=Number(model.value.split(",")[1]);
				Steps(2);
			}else{
				ListView("<font color=red>δ���ֿ�ִ��ģ�壡</font>");
				Steps(4);
			}
		}else if(stepnum==2){                            //����ģ������������
			if(TempletType==0||TempletType==1||TempletType==2){
				ListView("��ģ����Ҫ�����Ϣ�������� >> ");
				if(ClassClub==""){
					ListView("<font color=red>δ���������Ϣ</font>",2);
					Steps(4);
				}else{
					PushClass=doc.getElementById(pushclassname.value).value;
					var t_ClassClub=ClassClub.substring(0,ClassClub.length-1).split(",");
					for(i=0;i<t_ClassClub.length;i++){
						if(i==0) PushPath=doc.getElementById(t_ClassClub[i]).value.toString();
						else PushPath+=","+ doc.getElementById(t_ClassClub[i]).value.toString();
					}
					ListView("<font color=blue>���</font>",2);
					Steps(3);
				}
			}else Steps(3);
		}else if(stepnum==3){                            //��ȡ���ͽ�������Ϣ
			if(TempletType==1){ 
				CurPage="http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %><%= J.WebPath %>/" + PushPath + "/List*.<%= J.FileExt %>";
				ListView("��Ŀ�б� <a href=\"http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %><%= J.WebPath %>/" + PushPath + "/List1.<%= J.FileExt %>\" target=_blank>" + CurPage + "</a> >> ");
				pushinfo.innerHTML="״̬��<font color=green>" + CurPage + "</font>";
			}else if(TempletType==2){ 
				CurPage="http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %><%= J.WebPath %>/Content_<%= request.QueryString("sysid") %>/Content*.<%= J.FileExt %>";
				ListView("����ҳ�� " + CurPage + " >> ");
				pushinfo.innerHTML="״̬��<font color=green> " + CurPage + "</font>";
			}else if(TempletType==0){ 
				CurPage="http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %><%= J.WebPath %>/" + PushPath + "/<%= J.IndexName %>.<%= J.FileExt %>";
				ListView("��Ŀ��ҳ <a href=\"http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %><%= J.WebPath %>/" + PushPath + "/<%= J.IndexName %>.<%= J.FileExt %>\" target=_blank>" + CurPage + "</a> >> ");
				pushinfo.innerHTML="״̬��<font color=green> " + CurPage + "</font>";
			}else if(TempletType==3){ 
				CurPage="http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %>SOLE/" + TempletID + ".<%= J.FileExt %>";
				ListView("����ҳ�� <a href=\"http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %>SOLE/" + TempletID + ".<%= J.FileExt %>\" target=_blank>" + CurPage + "</a> >> ");
				pushinfo.innerHTML="״̬��<font color=green> " + CurPage + "</font>";
			}else if(TempletType==4){ 
				CurPage="http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %><%= J.IndexName %>.<%= J.FileExt %>";
				ListView("վ����ҳ <a href=\"http://<%= request.ServerVariables("HTTP_HOST") %><%= J.SiteUrlRoot %><%= J.IndexName %>.<%= J.FileExt %>\" target=_blank>" + CurPage + "</a> >> ");
				pushinfo.innerHTML="״̬��<font color=green> " + CurPage + "</font>";
			}else{
				Steps(4);
				return false;
			}
			startXmlRequest("POST","JCP_Push_XML.asp?action=class&classid=" + PushClass + "&templetid=" + TempletID + "&pushpath=" + PushPath,null,"body","","",false);
			if(xml_BackCont=="OK") ListView("<font color=blue>���</font>",2);
			//else alert(xml_BackCont);
			else ViewList.innerHTML=xml_BackCont;
			//else ListView("<font color=red>������</font>",2);
			Steps(4);
		}else if(stepnum==4){                            //��������
			pushinfo.innerHTML="״̬��<font color=green>���ͽ���</font>";
			PushBar.style.display="none";
			ListView("���ͽ�����");
		}
	}
	
	function ListView(strs,type){
		if(type==2){
			doc.getElementById("ViewList").firstChild.innerHTML+=strs;
		}else{
			var now=new Date();
			var cont=doc.createElement('<div style="width:100%;text-align:left;"></div>');
			cont.innerHTML = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() + "��" + strs;
			ViewList.insertBefore(cont,doc.getElementById("ViewList").firstChild);
		}
	}
	
	function TemplateListDisplay(){
		var classparam=ClassClub.split(",");
		var classes=""
		if(classparam.length>1){
			TemplateLists.innerHTML="ģ�������С���";
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
	response.write "<div class=""app_title"">�������</div>"&vbcrlf
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
				response.Write("����ϵͳ��")
			else
				response.write "<br><br>����ѡ����Բ�����ϵͳ:"
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
				response.Write("����ϵͳ��")
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

		response.write "<br><br>��ѡ��������Ŀ�� "
		set rs=J.Data.Exe("select item_id,item_name,item_content from JCP_ArtSys where sys_id="&sysid&" and item_type='class' order by item_order")
		if rs.eof then
			response.write "��ǰϵͳ��������Ŀ!"
		else
			dim classnum:classnum=0
			do while not rs.eof
				classnum=classnum+1
				if rs("item_id")&"_class"=classname then
					dim rss
					set rss=J.Data.ReRsOpen("select classname from JCP_class where classid="&classid,"rss",1)
					if not rss.eof then
						response.write classnum & "." & rss(0)
						response.write "<input type=hidden id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"" value="""&classid&""">��"
					else
						response.write classnum & "." & "<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"" onchange=""TemplateListDisplay();""></select><script language=""javascript"">startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid="&rs("item_content")&"&classid="&rs("item_content")&""",null,""body"",""eval(xml_BackCont)"","""",false);</script>��"
					end if
					rss.close
				else
					response.write classnum & "." & "<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"" onchange=""TemplateListDisplay();""></select><script language=""javascript"">startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid="&rs("item_content")&"&classid="&rs("item_content")&""",null,""body"",""eval(xml_BackCont)"","""",false);</script>��"
				end if
				response.write "<script language=""javascript"">ClassClub += """&rs("item_id")&"_class,"";</script>"
				rs.movenext
			loop
		end if
		rs.close

		response.write "<br><br>��ѡ������ģ�壺 <span id=""TemplateLists""><script>TemplateListDisplay();</script></span>"
		%>
		<div id="push_button"><input name="pushnow" type="button" class="system_button_00" value="�������ɾ�̬ҳ�� ���ո�" onClick="PushNow()"></div>
		<div id="PushView" style="display:none;">
			<div>
				<span id="pagecount" style="display:none;"></span>
				<span id="usedtime"></span>
				<span id="pushinfo"></span>
			</div>
			<div id="PushBar" style="display:none;"><img id="PushBarImg" src="../JCP_Skin/<%= J.SystemSkin %>/images/tree04.gif"></div>
			<div id="ViewList"></div>
		</div>
		<script>LastContain=doc.getElementById("ViewList");</script>
		<% 
	end sub
	%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
