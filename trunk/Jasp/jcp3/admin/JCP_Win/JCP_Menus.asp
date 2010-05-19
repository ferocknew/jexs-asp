<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Guide.css" rel="stylesheet" type="text/css">
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/MenuTree.asp"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
function Guide(url){
	if(!BlankYn(url)){
		if(url.toLowerCase().indexOf("http://")>-1) top.frames['main_box'].location=url;
		else if(url.toLowerCase().indexOf("../")>-1) top.frames['main_box'].location=url;
		else top.frames['main_box'].location="../.." + url;
	}
}

function SystemLoad(o){
	if(o){
		if(o.parentNode){
			var bindid=o.getAttribute("bindid");
			var classid=o.parentNode.getAttribute("classid");
			if(IntYn(classid)&&IntYn(bindid)){
				top.frames['main_box'].location="../JCP_ArtSys/JCP_ArtSys_Window.asp?actid=" + bindid + "&classid=" + classid;
			}
		}
	}
}

function MenuClick(o){
	if(o.previousSibling) o.previousSibling.click();
}
-->
</script>
<style>
<!--
body{
	background-color:<%= session("Color_Main") %>;
	color:<%= session("Color_SystemFont") %>;
	padding:0;
	overflow-x:hidden;
}
div,span,li,ul{
	color:<%= session("Color_SystemFont") %> !impartant;
}
#body_back{
	position:absolute;
	left:0;
	top:0;
	width:2000px;
	height:0;
	background-color:#FFFFFF;
	filter: Alpha(Opacity=20, FinishOpacity=40, Style=1, StartX=0, StartY=0, FinishX=0, FinishY=100);
}
-->
</style>
<!--#include file="../JCP_Shared/body.asp" -->
<div id="body_back"></div>
	<% 
		dim menutype
		menutype=J.NumberYn(request.QueryString("menutype"))

		dim rs,i,cur_classid,cur_classgrade,last_classson,last_classid,cur_topclassid,classname,sql,temp_order,indexid,listid,contentid,opened,urlbind
		sql="select * from JCP_menus where menutype=" & menutype & " order by orderid"
		set rs=J.Data.Exe(sql)
			cur_classgrade=0
			response.write "<div class=""TreeMenu"" id=""CategoryTree"">" & vbcrlf
			temp_order=0
			if rs.eof then response.Write "<br>　　没有导航菜单！"
			do while not rs.eof
				if rs("opened") then opened="Opened" else opened="Closed"
				if rs("menuname")&""="" then classname="No Name" else classname=rs("menuname")
				if rs("bindtype")=1 then urlbind=rs("bindcont") else urlbind=""
				if instr(session("JCP_AdminGuides"),"m"&rs("menuid")&",")>0 or session("JCP_AdminType")=0 then
					if last_classid>0 and cur_classgrade=rs("menugrade") and last_classson>0 then
						response.Write string(cur_classgrade,"	") & "</ul>" & vbcrlf
						response.Write string(cur_classgrade,"	") & "</li>" & vbcrlf
					end if
					if cur_classgrade>rs("menugrade") then
						if last_classson>0 then
							response.Write string(cur_classgrade,"	") & "</ul>" & vbcrlf
							response.Write string(cur_classgrade,"	") & "</li>" & vbcrlf
						end if
						for i=rs("menugrade") to cur_classgrade-1
							response.Write string(cur_classgrade-i+rs("menugrade")-1,"	") & "</ul>" & vbcrlf
							response.Write string(cur_classgrade-i+rs("menugrade")-1,"	") & "</li>" & vbcrlf
						next
					end if
					if cur_classgrade>0 and rs("menugrade")=1 then response.Write "</ul><br>" & vbcrlf
					if rs("menuson")>0 then
						if rs("parentid")=0 then response.Write "<ul>" & vbcrlf
						response.Write string(rs("menugrade"),"	") & "<li class="""&opened&" GuideTopMenu"" menuid="""&rs("menuid")&"""><span class=""GuideTopMenuBack""></span><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif"" onclick=""javascript:ChangeStatus(this);""><span class=""classitem"" onFocus=""javascript:blur();"" onclick=""javascript:MenuClick(this);"">" & classname & "</span>" & vbcrlf
						response.Write string(rs("menugrade"),"	") & "<ul id=""tree_item_"&rs("menuid")&""">" & vbcrlf
					else
						if rs("parentid")=0 then
							response.Write "<ul>" & vbcrlf
							if rs("bindtype")=1 then
								response.Write "	<li class="""&opened&" GuideTopMenu"" menuid="""&rs("menuid")&""" classid=""0""><span class=""GuideTopMenuBack""></span><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif"" onclick=""javascript:ChangeStatus(this);""><span class=""classitem"" onFocus=""javascript:blur();"" onclick=""javascript:Guide('"&rs("bindcont")&"');"">" & classname & "</span></li>" & vbcrlf
							elseif rs("bindtype")=3 then
								response.Write "	<li class="""&opened&" GuideTopMenu"" menuid="""&rs("menuid")&""" classid=""0""><span class=""GuideTopMenuBack""></span><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif"" onclick=""javascript:ChangeStatus(this);""><span class=""classitem"" onFocus=""javascript:blur();"" bindid="""&rs("bindcont")&""" onclick=""javascript:MenuClick(this);"">" & classname & "</span></li>" & vbcrlf
							else
								response.Write "	<li class="""&opened&" GuideTopMenu"" menuid="""&rs("menuid")&"""><span class=""GuideTopMenuBack""></span><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif"" onclick=""javascript:ChangeStatus(this);""><span class=""classitem"" onFocus=""javascript:blur();"" onclick=""javascript:MenuClick(this);"">" & classname & "</span></li>" & vbcrlf
							end if
						else
							response.Write string(rs("menugrade"),"	") & "<li class=""Child"" menuid="""&rs("menuid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""classitem"" onFocus=""javascript:blur();"" onclick=""javascript:Guide('"&urlbind&"');"">" & classname & "</span></li>" & vbcrlf
						end if
						if rs("bindtype")=2 then 
							response.write "<ul>"
							call SysBind_Load(rs("bindcont"))
							response.write "</ul>"
						elseif rs("bindtype")=3 then 
							call ClassBind_Load(rs("bindcont"))
						elseif rs("bindtype")=4 then 
							call ClassBindByNoRootClass_Load(rs("bindcont"))
						end if
					end if
					cur_classgrade=rs("menugrade")
					last_classid=rs("menuid")
					last_classson=rs("menuson")
				end if
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
'	<div id="pagetime" disabled>< < %= J.PageTime % > ></div>


sub SysBind_Load(classid)
	dim rd,title,url,turl,n
	set rd=J.Data.ReRsOpen("select * from JCP_AppSystem where menuid=" & classid,"rd",1)
	if not rd.eof then
		title=split(rd("submenutitle"),"|")
		url=split(rd("submenuurl"),"|")
		for n=0 to ubound(title)
			if instr(session("JCP_AdminGuides"),"m"&rs("menuid")&"_"&n&",")>0 or session("JCP_AdminType")=0 then
				if n<=ubound(url) then turl=url(n) else turl="../JCP_Win/JCP_Main.asp"
				response.Write "	<li class=""Child""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""classitem"" onFocus=""javascript:blur();"" onclick=""javascript:Guide('"&turl&"');"">"&title(n)&"</span></li>" & vbcrlf
			end if
		next
	end if
	rd.close
end sub

sub ClassBind_Load(classid)
	dim rss,rsopened,rsclassname,rscur_classgrade,rscur_classson,rscur_classid,jj,rootyn
	set rss=J.Data.ReRsOpen("select * from JCP_class where ','&parentpath like '%,"&classid&",%' order by orderid","rss",1)
	rscur_classgrade=0:rscur_classid=0:rscur_classson=0:rootyn=false
	if not rss.eof then
		if rss("parentid")=0 then rootyn=true
	end if
	if not rootyn then response.write "<ul>"

	do while not rss.eof
		if rss("opened") then rsopened="Opened" else rsopened="Closed"
		if rss("classname")&""="" then rsclassname="No Name" else rsclassname=rss("classname")
		if instr(session("JCP_AdminGuides"),"c"&rss("classid")&",")>0 or session("JCP_AdminType")=0 then
			if rscur_classid>0 and rscur_classgrade=rss("classgrade") and rscur_classson>0 then
				response.Write string(rscur_classgrade,"	") & "</ul>" & vbcrlf
				response.Write string(rscur_classgrade,"	") & "</li>" & vbcrlf
			end if
			if rscur_classgrade>rss("classgrade") then
				if rscur_classson>0 then
					response.Write string(rscur_classgrade,"	") & "</ul>" & vbcrlf
					response.Write string(rscur_classgrade,"	") & "</li>" & vbcrlf
				end if
				for jj=rss("classgrade") to rscur_classgrade-1
					response.Write string(rscur_classgrade-jj+rss("classgrade")-1,"	") & "</ul>" & vbcrlf
					response.Write string(rscur_classgrade-jj+rss("classgrade")-1,"	") & "</li>" & vbcrlf
				next
			end if
			if rscur_classgrade>0 and rss("classgrade")=1 then response.Write "</ul>" & vbcrlf
			if rss("classson")>0 then
				if rss("parentid")=0 then response.Write "<ul>" & vbcrlf
				response.Write string(rss("classgrade"),"	") & "<li id=""c"&rss("classid")&""" class="""&rsopened&""" classid="""&rss("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif"" onclick=""javascript:ChangeStatus_NoData(this);""><span class=""classitem"" onFocus=""javascript:blur();"" bindid="""&classid&""" onclick=""javascript:SystemLoad(this);"">" & rsclassname & "</span>" & vbcrlf
				response.Write string(rss("classgrade"),"	") & "<ul id=""tree_item_"&rss("classid")&""">" & vbcrlf
			else
				if rss("parentid")=0 then
					response.Write "<ul>" & vbcrlf
					response.Write "	<li id=""c"&rss("classid")&""" class="""&rsopened&""" classid="""&rss("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""classitem"" onFocus=""javascript:blur();"" bindid="""&classid&""" onclick=""javascript:SystemLoad(this);"">" & rsclassname & "</span></li>" & vbcrlf
				else
					response.Write string(rss("classgrade"),"	") & "<li id=""c"&rss("classid")&""" class=""Child"" classid="""&rss("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""classitem"" onFocus=""javascript:blur();"" bindid="""&classid&""" onclick=""javascript:SystemLoad(this);"">" & rsclassname & "</span></li>" & vbcrlf
				end if
			end if
			rscur_classgrade=rss("classgrade")
			rscur_classid=rss("classid")
			rscur_classson=rss("classson")
		end if
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

sub ClassBindByNoRootClass_Load(classid)
	dim rss,rsopened,rsclassname,rscur_classgrade,rscur_classson,rscur_classid,jj,rootyn
	set rss=J.Data.ReRsOpen("select * from JCP_class where ','&parentpath like '%,"&classid&",%' and classid<>" & classid & " order by orderid","rss",1)
	rscur_classgrade=0:rscur_classid=0:rscur_classson=0:rootyn=false
	if not rss.eof then
		if rss("parentid")=0 then rootyn=true
	else
		rss.close
		set rss=nothing
		set rss=J.Data.ReRsOpen("select * from JCP_class where ','&parentpath like '%,"&classid&",%' order by orderid","rss",1)
	end if
	if not rootyn then response.write "<ul>"

	do while not rss.eof
		if rss("opened") then rsopened="Opened" else rsopened="Closed"
		if rss("classname")&""="" then rsclassname="No Name" else rsclassname=rss("classname")
		if instr(session("JCP_AdminGuides"),"c"&rss("classid")&",")>0 or session("JCP_AdminType")=0 then
			if rscur_classid>0 and rscur_classgrade=rss("classgrade") and rscur_classson>0 then
				response.Write string(rscur_classgrade,"	") & "</ul>" & vbcrlf
				response.Write string(rscur_classgrade,"	") & "</li>" & vbcrlf
			end if
			if rscur_classgrade>rss("classgrade") then
				if rscur_classson>0 then
					response.Write string(rscur_classgrade,"	") & "</ul>" & vbcrlf
					response.Write string(rscur_classgrade,"	") & "</li>" & vbcrlf
				end if
				for jj=rss("classgrade") to rscur_classgrade-1
					response.Write string(rscur_classgrade-jj+rss("classgrade")-1,"	") & "</ul>" & vbcrlf
					response.Write string(rscur_classgrade-jj+rss("classgrade")-1,"	") & "</li>" & vbcrlf
				next
			end if
			if rscur_classgrade>0 and rss("classgrade")=1 then response.Write "</ul>" & vbcrlf
			if rss("classson")>0 then
				if rss("parentid")=0 then response.Write "<ul>" & vbcrlf
				response.Write string(rss("classgrade"),"	") & "<li id=""c"&rss("classid")&""" class="""&rsopened&""" classid="""&rss("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif"" onclick=""javascript:ChangeStatus_NoData(this);""><span class=""classitem"" onFocus=""javascript:blur();"" bindid="""&classid&""" onclick=""javascript:SystemLoad(this);"">" & rsclassname & "</span>" & vbcrlf
				response.Write string(rss("classgrade"),"	") & "<ul id=""tree_item_"&rss("classid")&""">" & vbcrlf
			else
				if rss("parentid")=0 then
					response.Write "<ul>" & vbcrlf
					response.Write "	<li id=""c"&rss("classid")&""" class="""&rsopened&""" classid="""&rss("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""classitem"" onFocus=""javascript:blur();"" bindid="""&classid&""" onclick=""javascript:SystemLoad(this);"">" & rsclassname & "</span></li>" & vbcrlf
				else
					response.Write string(rss("classgrade"),"	") & "<li id=""c"&rss("classid")&""" class=""Child"" classid="""&rss("classid")&"""><img class=s src=""../JCP_Skin/" & session("SystemSkin") & "/tree/s.gif""><span class=""classitem"" onFocus=""javascript:blur();"" bindid="""&classid&""" onclick=""javascript:SystemLoad(this);"">" & rsclassname & "</span></li>" & vbcrlf
				end if
			end if
			rscur_classgrade=rss("classgrade")
			rscur_classid=rss("classid")
			rscur_classson=rss("classson")
		end if
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
<script language="JavaScript">
<!--
	var styleSheet=document.styleSheets[0];
	var _GuideTopMenuBack;
	styleSheet.getRule = function(selectorText){
          for(var i=0;i<this.rules.length;i++){
               if(this.rules[i].selectorText == selectorText){
			   		_GuideTopMenuBack=this.rules[i];
                    return _GuideTopMenuBack;
               }
          }
          return null;
    }
	styleSheet.getRule(".GuideTopMenuBack");
	
	window.onresize=function(){
		if(parent.parent.main_height > 28) body_back.style.height=(parent.parent.main_height - 28) + "px";
		else body_back.style.height="0";
		body_back.style.top=document.body.scrollTop;
		//CategoryTree.style.width=(parent.parent.InsWidth + 3) + "px";
		//if(_GuideTopMenuBack) _GuideTopMenuBack.style.width=(parent.parent.InsWidth - 18) + "px";
	}
	document.body.onscroll=function(){
		body_back.style.top=document.body.scrollTop;
	}

	//知识1 document.styleSheets[0].rules(0).selectorText 获取样式对象名，如 body  .menu  #hi
	//知识2 document.styleSheets[0].rules(0).style.width 获取样式的内容，可修改  
		
-->
</script>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>
