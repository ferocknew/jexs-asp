<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Article.css" rel="stylesheet" type="text/css">
<!--#include file="../JCP_Shared/body.asp" -->
<% 
dim sysid,rs,i
sysid=J.NumberYn(request.querystring("sysid"))

if request.QueryString("action")="disp" then
%>
	<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
	<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
	<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
	<script language="JavaScript" type="text/JavaScript">
		function CulChange(o,type){
			var tempid,tempindex,tempo;
			tempindex=o.selectedIndex;
			if(tempindex>=0){
				tempid=o.value;
				if(type=="display"){
					tempo=document.all.disp_box;
					startXmlRequest("POST","JCP_ArtAction_XML.asp?action=display&actid=" + o.value + "&order=" + (tempo.length+1),null,"body","","",false)
					if(xml_BackCont=="OK"){
						tempo.options[tempo.length]=new Option(o.options[tempindex].innerText,o.value);
						o.options.remove(tempindex);
					}else alert("数据库操作有误，不能完成显示设置！");
				}else if(type=="undisplay"){
					tempo=document.all.old_box;
					startXmlRequest("POST","JCP_ArtAction_XML.asp?action=undisplay&actid=" + o.value + "&order=" + (o.selectedIndex+1),null,"body","","",false)
					if(xml_BackCont=="OK"){
						tempo.options[tempo.length]=new Option(o.options[tempindex].innerText,o.value);
						o.options.remove(tempindex);
					}else alert("数据库操作有误，不能完成显示设置！");
				}
			}
		}
		
		function ChangePageSize(o){
			if(IntYn(pagesize.value)){
				if(pagesize.value>0){
					startXmlRequest("POST","JCP_ArtAction_XML.asp?action=pagesize&actid=" + o + "&pagesize=" + pagesize.value,null,"body","","",false)
					if(xml_BackCont=="OK") alert("列表长度设置成功！");
					else alert("数据库操作有误，不能完成显示设置！");
				}else{
					alert("请输入一个大于0的数字!");
					pagesize.value=10;
					pagesize.focus();
				}
			}else{
				alert("请输入一个数字!");
				pagesize.value=10;
				pagesize.focus();
			}
		}
	</script>
    <div class="manage_title" style="background-color:<%= session("Color_Main") %>;"><a href="JCP_ArtManage.asp?sysid=<%= sysid %>">文章管理</a></div>
	<div class="manage_title" style="background-color:<%= session("Color_Fleet") %>;">显示设置</div>
	<div id="display_box">
		<fieldset><legend>列表长度</legend>
	  	<% 
		set rs=J.Data.Exe("select id,item_id from JCP_ArtSys where sys_id="&sysid&" and item_type='pagesize'")
		if not rs.eof then
		%>
			每页显示: <input name="pagesize" id="pagesize" type="text" value="<%= rs("item_id") %>" size="4"> 条 <input name="OK" type="button" value="立即设置" onclick="ChangePageSize(<%= rs("id") %>)" class="system_button_00">
		<%  
		end if
		rs.close
		%>
		</fieldset>
		<br>
		<fieldset><legend>显示字段</legend>
	  <select name="old_box" id="old_box" size="1" multiple onDblClick="CulChange(this,'display');">
	  	<% 
		dim selected
		selected=" selected"
		set rs=J.Data.Exe("select id,item_name,item_id,item_type from JCP_ArtSys where sys_id="&sysid&" and display=0 and item_type<>'button' and item_order>0")
		do while not rs.eof
			response.write "<option value="""&rs("id")&""""&selected&">"&replace(rs("item_name"),"：","")&" ["&rs("item_id")&"] ["&rs("item_type")&"]"&"</option>"&vbcrlf
			selected=""
			rs.movenext
		loop
		rs.close
		%>
	  </select>
    <label style="width:60px;text-align:center;"> 双击选项 可左右移动</label>
    <select name="disp_box" id="disp_box" size="1" multiple onDblClick="CulChange(this,'undisplay');">
	  	<% 
		selected=" selected"
		set rs=J.Data.Exe("select id,item_name,item_id,item_type from JCP_ArtSys where sys_id="&sysid&" and display=1 and item_type<>'button' and item_order>0 order by display_order")
		do while not rs.eof
			response.write "<option value="""&rs("id")&""""&selected&">"&replace(rs("item_name")&"","：","")&" ["&rs("item_id")&"] ["&rs("item_type")&"]"&"</option>"&vbcrlf
			selected=""
			rs.movenext
		loop
		rs.close
		%>
	  </select>
		</fieldset>
	</div>
  <% 
else
%>
<script language="JavaScript" src="../JCP_Script/JCP_Class_JS.asp?action=1&rootid=<%= sysid %>"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
		var doc=document;
		var obj,objid,x0,x1;
		var moveable = false;
		function startgrap(temp_obj,temp_objid)
        {
			obj=temp_obj;
			objid=temp_objid;
            if(event.button==1)
            {
            	moveline.setCapture();
				x0 = event.clientX;
                moveable = true;
                moveline.style.left = event.clientX;
 				moveline.style.display="block";
           }
         }
        function stopgrap()
        {
            if(moveable)
            {
				x1 = parseInt(moveline.style.left);
                moveline.releaseCapture();
                moveable = false;
				moveline.style.display="none";
				var tempwidth=parseInt(doc.getElementsByName(obj)[0].style.width) + (x1-x0);
				if(x1!=x0){
					if(tempwidth>0){
						if(tempwidth>400){
							alert("单项宽度不能超过400px！");
							tempwidth=400;
						}
						startXmlRequest("POST","JCP_ArtAction_XML.asp?action=display_width&actid=" + objid + "&actwidth=" + tempwidth,null,"body","","",false)
						if(xml_BackCont=="OK"){
							for(i=0;i<doc.getElementsByName(obj).length;i++)
								doc.getElementsByName(obj)[i].style.width =tempwidth;
						}
					}else alert("单项宽度不能小于0！");
				}
            }
        }
		
        function grap()
        {
             if(moveable)
                {
				 	if(event.clientX>4&&event.clientX<doc.body.clientWidth-4&&event.clientY>4&&event.clientY<doc.body.clientHeight){               
                    moveline.style.left = event.clientX;
				}
            }
        }
		
		function ManageArt(sType){
			var items=doc.getElementsByName("ArtID");
			var item_select="0";
			var item_select_count=0;
			for(i=0;i<items.length;i++){
				if(items[i].checked){
					item_select+="," + items[i].value;
					item_select_count++;
				}
			}
			if(item_select_count<1){
				alert("请选择需要操作的记录!");
			}else{
				if(sType=="mod"){
					if(item_select_count==1){
						location="JCP_ArtEdit.asp?<%= request.ServerVariables("QUERY_STRING") %>&actid=" + item_select;
					}else alert("一次只能修改一条记录!");
				}else if(sType=="del"){
					if(confirm("您确定要执行删除操作？？")) location="JCP_ArtAction.asp?<%= request.ServerVariables("QUERY_STRING") %>&action=del&actid=" + item_select;
				}
			}
			return false;
		}
//-->
</script>

	<div class="manage_button_cur">文章管理</div>
	<div class="manage_button"><a href="JCP_ArtManage.asp?action=disp&sysid=<%= sysid %>">显示设置</a></div>
	<div class="class_display">
		<% 
		set rs=J.Data.Exe("select id,item_id,item_name,item_content from JCP_ArtSys where sys_id="&sysid&" and item_type='class'")
		if not rs.eof then response.write "选择显示类别： "
		do while not rs.eof
			response.write vbcrlf
			response.write "		<select id="""&rs("item_id")&"_class"" name="""&rs("item_id")&"_class"">" & vbcrlf _
						 & "			<option value=""-1"">"&replace(rs("item_name"),"：","")&"</option>" & vbcrlf _
						 & "		</select>" & vbcrlf _
						 & "		<script language=""javascript"">startXmlRequest(""POST"",""../JCP_Script/JCP_Class_JS.asp?itemid="&replace(rs("item_id"),"Item_","")&"&rootid="&rs("item_content")&"&classid="&session("temp_ClassID_List_"&rs("item_id"))&""",null,""body"",""eval(xml_BackCont)"","""",false);</script>"
			rs.movenext
		loop
		rs.close
		%>
	</div>
	<div class="list_box">
<% 
	if J.Data.CheckTable("Article_"&sysid) then
		dim table_items,temp_table_items,item_title,item_count,div_title,display_width,temp_display_width,temp_item_label,list_pagesize
		table_items="id"
		display_width="30"
		item_count=0
		div_title="		<div class=""list_title"">"
		div_title=div_title&"<span style=""width:30px;""><input name=""SelectAll"" type=""checkbox"" class=""select"" onclick=""for(i=0;i<document.getElementsByName('ArtID').length;i++)document.getElementsByName('ArtID')[i].checked=this.checked;""></span><span class=""distline"" onmousedown=""alert('此项不能移动！');""></span>"
		set rs=J.Data.Exe("select id,item_id,item_type,item_name,item_label,display_width from JCP_ArtSys where sys_id="&sysid&" and display=1 order by display_order")
		if not rs.eof then
			do while not rs.eof
				item_title=""
				if rs("item_type")="checkbox" then
					temp_item_label=split(rs("item_label")&"","{$|}")
					for i=0 to ubound(temp_item_label)
						item_title=item_title&","&rs("item_id")&"_"&rs("item_type")&"_"&(i+1)
						display_width=display_width&","&rs("display_width")
						item_count=item_count+1
						div_title=div_title&"<span style=""width:"&rs("display_width")&"px;"" name=""col_"&item_count&""" id=""col_"&item_count&""">"&server.HTMLEncode(temp_item_label(i))&"</span><span class=""distline"" onmousedown=""startgrap('col_"&item_count&"',"&rs("id")&");""></span>"
					next
				elseif rs("item_type")="pagesize" then
					list_pagesize=rs("item_id")
				else
					item_title=","&rs("item_id")&"_"&rs("item_type")
					display_width=display_width&","&rs("display_width")
					item_count=item_count+1
					div_title=div_title&"<span style=""width:"&rs("display_width")&"px;"" name=""col_"&item_count&""" id=""col_"&item_count&""">"&server.HTMLEncode(replace(rs("item_name")&"","：",""))&"</span><span class=""distline"" onmousedown=""startgrap('col_"&item_count&"',"&rs("id")&");""></span>"
					if rs("item_type")="radio" then response.write "<script>var "&rs("item_id")&"_radio=new Array("""&replace(rs("item_label"),"{$|}",""",""")&""");</script>"
				end if
				table_items=table_items&item_title
				rs.movenext
			loop
		end if
		div_title=div_title&"<span style=""width:140px;"">发布时间</span>"
		div_title=div_title&"</div>"
		table_items=table_items&",Uptime"
		rs.close
		if table_items="" then
			response.Write("没有设置任何显示项！")
		else
			response.write div_title&vbcrlf
			dim page,rscount,jj,temp_listcount
			temp_listcount=0
			set page=J.Page(table_items&"$Article_"&sysid&"$deleted=0$id desc$id",list_pagesize)
			rscount=page.RecCount()
			rs=page.ResultSet()
			if rscount<1 then
				response.write "<div class=""list"" style=""padding:6px 0 0 8px;margin-bottom:8px;"">您还没有添加文章！</div>"
			else
				temp_display_width=split(display_width,",")
				temp_table_items=split(table_items,",")
				temp_listcount=Ubound(rs,2)
				For i=0 To temp_listcount
					response.write "		<div class=""list"">"
					response.write "<span style=""width:"&temp_display_width(0)&"px;""><input name=""ArtID"" id=""ArtID"" type=""checkbox"" value="""&rs(0,i)&""" class=""select""></span><span class=""distline_list""></span>"
					for jj=1 to item_count
						if instr(temp_table_items(jj),"checkbox")>0 then
							if rs(jj,i)=1 then
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&""">√</span><span class=""distline_list""></span>"
							else
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&""">×</span><span class=""distline_list""></span>"
							end if
						elseif instr(temp_table_items(jj),"class")>0 then
							if rs(jj,i)&""="" then
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&""">-</span><span class=""distline_list""></span>"
							else
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&"""><script>document.write(class_"&rs(jj,i)&".classname);</script></span><span class=""distline_list""></span>"
							end if
						elseif instr(temp_table_items(jj),"radio")>0 then
							if rs(jj,i)&""="" then
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&""">-</span><span class=""distline_list""></span>"
							else
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&"""><script>document.write("&temp_table_items(jj)&"["&(rs(jj,i)-1)&"]);</script></span><span class=""distline_list""></span>"
							end if
						elseif instr(temp_table_items(jj),"file")>0 then
							if rs(jj,i)&""="" then
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&""">-</span><span class=""distline_list""></span>"
							else
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&""" class=""file""><img src=""../JCP_Skin/"&Session("SystemSkin")&"/images/math.gif"" title="""&rs(jj,i)&""" onclick=""javascript:window.open('"&rs(jj,i)&"');""></span><span class=""distline_list""></span>"
							end if
						else
							if rs(jj,i)&""="" then
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&""">-</span><span class=""distline_list""></span>"
							else
								response.write "<span style=""width:"&temp_display_width(jj)&"px;"" name=""col_"&jj&""" id=""col_"&jj&""">"&server.HTMLEncode(rs(jj,i))&"</span><span class=""distline_list""></span>"
							end if
						end if
					next
					response.write "<span style=""width:140px;"">"&rs(item_count+1,i)&"</span>"
					response.write "</div>"&vbcrlf
				next
				page.ShowPage()
%>
				<div class="article_button">
					<input name="mod" type="button" value="修改选中项" onclick="ManageArt('mod');" class="system_button_00">
					<input name="mod" type="button" value="删除选中项" onclick="ManageArt('del');" class="system_button_00">
				</div>
<%  
			end if
		end if
	end if
	response.write "<div>"&J.PageTime&"</div>"

end if
%>
	</div>
	<% response.write "	<div id=""moveline"" style=""height:"&(24+24*(temp_listcount+1))&"px;left:10px;"" onmouseup=""stopgrap();"" onmousemove=""grap();""></div>"&vbcrlf %>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>