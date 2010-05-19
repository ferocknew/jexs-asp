<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<% 
	dim teamids,actid
	actid=J.NumberYn(request.querystring("actid"))
	teamids=J.Data.Exe("select ','&guide_ids&',' from JCP_purviewteam where id="&actid)(0)
%>
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Guide.css" rel="stylesheet" type="text/css">
<style>.classitem{cursor:default !important;}</style>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/MenuTree.asp"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
function Select(o){
	if(o.checked){
		try{
			while (o.parentNode.parentNode.parentNode.childNodes[0].tagName){
				if(o.parentNode.parentNode.parentNode.childNodes[0].tagName.toUpperCase()=="INPUT"){
					o.parentNode.parentNode.parentNode.childNodes[0].checked=true;
				}
				o=o.parentNode.parentNode.parentNode.childNodes[0];
			}
		}catch(e){
			return false;
		}
	}else{
		var subs=o.parentNode.getElementsByTagName("input");
		if(subs.length>1){
			for(i=1;i<subs.length;i++){
				subs[i].checked=false;
			}
		}else return false;
	}
}

function PurviewSet(){
	var teamids="";
	var o=doc.getElementsByName('menupurv');
	for(i=0;i<o.length;i++){
		if(o[i].checked){
			teamids += o[i].value + ",";
		}
	}
	startXmlRequest("GET","JCP_Purview_Action.asp?action=setguideteam&teamids=" + teamids + "&teamid=<%= actid %>",null,"body","","",false);
	if(xml_BackCont=="OK") alert("导航权限设置成功！");
	else{
		alert("失败：导航权限设置出错！");
		alert(xml_BackCont);
	}
	window.close();
}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
<div class="app_title">导航权限设置</div>
<div id="Purv_Menu_List">
	<% 
		dim rs,i,cur_classid,cur_classgrade,cur_topclassid,classname,sql,temp_order,indexid,listid,contentid,opened,urlbind,checked
		sql="select * from JCP_menus order by orderid"
		set rs=J.Data.Exe(sql)
			cur_classgrade=0
			response.write "<div class=""TreeMenu"" id=""CategoryTree"">" & vbcrlf
			temp_order=0
			if rs.eof then response.Write "<br>　　没有绑定项！"
			do while not rs.eof
				if rs("opened") then opened="Opened" else opened="Opened"
				if rs("menuname")&""="" then classname="No Name" else classname=rs("menuname")
				if rs("bindtype")=1 then urlbind=rs("bindcont") else urlbind=""
				if instr(teamids,"m"&rs("menuid")&",")>0 then checked=" checked" else checked=""
				if cur_classgrade>rs("menugrade") then
					for i=rs("menugrade") to cur_classgrade-1
						response.Write string(cur_classgrade-i+rs("menugrade")-1,"	") & "</ul>" & vbcrlf
						response.Write string(cur_classgrade-i+rs("menugrade")-1,"	") & "</li>" & vbcrlf
					next
				end if
				if cur_classgrade>0 and rs("menugrade")=1 then response.Write "</ul><br>" & vbcrlf
				if rs("menuson")>0 then
					if rs("parentid")=0 then response.Write "<ul>" & vbcrlf
					response.Write string(rs("menugrade"),"	") & "<li class="""&opened&""" menuid="""&rs("menuid")&"""><input type=""checkbox"" class=""select"" id=""menupurv"" name=""menupurv"" value=""m"&rs("menuid")&""""&checked&" onclick=""javascript:Select(this);""><span class=""classitem"" onFocus=""javascript:blur();"">" & classname & "</span>" & vbcrlf
					response.Write string(rs("menugrade"),"	") & "<ul id=""tree_item_"&rs("menuid")&""">" & vbcrlf
				else
					if rs("parentid")=0 then
						response.Write "<ul>" & vbcrlf
						if rs("bindtype")=3 then
							response.Write "	<li class="""&opened&""" menuid="""&rs("menuid")&""" classid=""0""><input type=""checkbox"" class=""select"" id=""menupurv"" name=""menupurv"" value=""m"&rs("menuid")&""""&checked&" onclick=""javascript:Select(this);""><span class=""classitem"" onFocus=""javascript:blur();"">" & classname & "</span></li>" & vbcrlf
						else
							response.Write "	<li class="""&opened&""" menuid="""&rs("menuid")&"""><input type=""checkbox"" class=""select"" id=""menupurv"" name=""menupurv"" value=""m"&rs("menuid")&""""&checked&" onclick=""javascript:Select(this);""><span class=""classitem"" onFocus=""javascript:blur();"">" & classname & "</span></li>" & vbcrlf
						end if
					else
						response.Write string(rs("menugrade"),"	") & "<li class=""Child"" menuid="""&rs("menuid")&"""><input type=""checkbox"" class=""select"" id=""menupurv"" name=""menupurv"" value=""m"&rs("menuid")&""""&checked&" onclick=""javascript:Select(this);""><span class=""classitem"" onFocus=""javascript:blur();"">" & classname & "</span></li>" & vbcrlf
					end if
					if rs("bindtype")=2 then 
						response.write "<ul>"
						call SysBind_Load(rs("bindcont"))
						response.write "</ul>"
					elseif rs("bindtype")=3 then 
						call ClassBind_Load(rs("bindcont"))
					end if
				end if
				cur_classgrade=rs("menugrade")
				rs.movenext
				if rs.eof then
					for i=1 to cur_classgrade
						response.Write string(cur_classgrade-i,"	") & "</ul>" & vbcrlf
						if i<cur_classgrade then response.Write string(cur_classgrade-i,"	") & "</li>" & vbcrlf
					next
				end if
				temp_order=temp_order+1
			loop
			response.write "</div>"
		rs.close
%>
</div>
	<div style="width:100%;float:left;text-align:center;margin-top:10px;">
		<input type="button" class="system_button_00" value=" 设 置 " onClick="PurviewSet();">
		<input type="button" class="system_button_00" value=" 取 消 " onClick="window.close();">
	</div>
<% 
'	<div id="pagetime" disabled>< < %= J.PageTime % > ></div>


sub SysBind_Load(classid)
	dim rd,title,url,turl,n,tchecked
	set rd=J.Data.ReRsOpen("select * from JCP_AppSystem where menuid=" & classid,"rd",1)
	if not rd.eof then
		title=split(rd("submenutitle"),"|")
		url=split(rd("submenuurl"),"|")
		for n=0 to ubound(title)
			if instr(teamids,"m"&rs("menuid")&"_"&n&",")>0 then tchecked=" checked" else tchecked=""
			if n<=ubound(url) then turl=url(n) else turl="../JCP_Win/JCP_Main.asp"
			response.Write "	<li class=""Child""><input type=""checkbox"" class=""select"" id=""menupurv"" name=""menupurv"" value=""m"&rs("menuid")&"_"&n&""""&tchecked&" onclick=""javascript:Select(this);""><span class=""classitem"" onFocus=""javascript:blur();"">"&title(n)&"</span></li>" & vbcrlf
		next
	end if
	rd.close
end sub

sub ClassBind_Load(classid)
	dim rss,rsopened,rsclassname,rscur_classgrade,jj,rootyn,ttchecked
	set rss=J.Data.ReRsOpen("select * from JCP_class where ','&parentpath like '%,"&classid&",%' order by orderid","rss",1)
	rscur_classgrade=0:rootyn=false
	if not rss.eof then
		if rss("parentid")=0 then rootyn=true
	end if
	if not rootyn then response.write "<ul>"

	do while not rss.eof
		if rss("opened") then rsopened="Opened" else rsopened="Opened"
		if rss("classname")&""="" then rsclassname="No Name" else rsclassname=rss("classname")
		if instr(teamids,"c"&rss("classid")&",")>0 then ttchecked=" checked" else ttchecked=""
		if rscur_classgrade>rss("classgrade") then
			for jj=rss("classgrade") to rscur_classgrade-1
				response.Write string(rscur_classgrade-jj+rss("classgrade")-1,"	") & "</ul>" & vbcrlf
				response.Write string(rscur_classgrade-jj+rss("classgrade")-1,"	") & "</li>" & vbcrlf
			next
		end if
		if rscur_classgrade>0 and rss("classgrade")=1 then response.Write "</ul>" & vbcrlf
		if rss("classson")>0 then
			if rss("parentid")=0 then response.Write "<ul>" & vbcrlf
			response.Write string(rss("classgrade"),"	") & "<li class="""&rsopened&""" classid="""&rss("classid")&"""><input type=""checkbox"" class=""select"" id=""menupurv"" name=""menupurv"" value=""c"&rss("classid")&""""&ttchecked&" onclick=""javascript:Select(this);""><span class=""classitem"" onFocus=""javascript:blur();"">" & rsclassname & "</span>" & vbcrlf
			response.Write string(rss("classgrade"),"	") & "<ul id=""tree_item_"&rss("classid")&""">" & vbcrlf
		else
			if rss("parentid")=0 then
				response.Write "<ul>" & vbcrlf
				response.Write "	<li class="""&rsopened&""" classid="""&rss("classid")&"""><input type=""checkbox"" class=""select"" id=""menupurv"" name=""menupurv"" value=""c"&rss("classid")&""""&ttchecked&" onclick=""javascript:Select(this);""><span class=""classitem"" onFocus=""javascript:blur();"">" & rsclassname & "</span></li>" & vbcrlf
			else
				response.Write string(rss("classgrade"),"	") & "<li class=""Child"" classid="""&rss("classid")&"""><input type=""checkbox"" class=""select"" id=""menupurv"" name=""menupurv"" value=""c"&rss("classid")&""""&ttchecked&" onclick=""javascript:Select(this);""><span class=""classitem"" onFocus=""javascript:blur();"">" & rsclassname & "</span></li>" & vbcrlf
			end if
		end if
		rscur_classgrade=rss("classgrade")
		rss.movenext
		if rss.eof then
			for jj=1 to rscur_classgrade
				response.Write string(rscur_classgrade-jj,"	") & "</ul>" & vbcrlf
				if jj<rscur_classgrade then response.Write string(rscur_classgrade-jj,"	") & "</li>" & vbcrlf
			next
		end if
	loop
	
	if not rootyn then response.write "</ul>"
	rss.close
end sub
		%>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
