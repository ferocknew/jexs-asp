<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<link href="../JCP_Skin/<%= Session("SystemSkin") %>/CSS/JCP_Block.css" rel="stylesheet" type="text/css">
<style>
body{
	padding:0;
}
</style>
<script language="JavaScript" type="text/JavaScript">
		var doc=document;
		var curItem=doc.body;
		var selectedObject=curPath="";
		var ViewImg = new Image();
		var eventX=eventY=0;
		
		function Over(o){
			if(o.tagName=="SPAN"){
				if(o.className!="ServerView_focus") o.className="ServerView_over";
			}
		}
		function Out(o){
			if(o.tagName=="SPAN"){
				if(o.className!="ServerView_focus") o.className="ServerView_out";
			}
		}
		function Hit(o){
			if(o){
				if(o.tagName=="SPAN"){
					if(o!=curItem){
						if(curItem!=null) curItem.className="ServerView_out";
						o.className="ServerView_focus";
						curItem=o;
						selectedObject=doc.getElementById(o.id).getAttribute("jcp");
						curPathValue();
					}
				}
			}else if(event.srcElement.tagName=="DIV"){
				if(curItem!=null) curItem.className="ServerView_out";
				curItem=null;
				selectedObject="";
				curPathValue();
			}
		}
		function curPathValue(){
			if(selectedObject){
				var t_selectedObject;
				if(curPath=="/"){
					t_selectedObject=curPath + selectedObject;
				}else{
					t_selectedObject=curPath + "/" + selectedObject;
				}
				doc.getElementById("url").value=t_selectedObject;
			}else doc.getElementById("url").value=ServerPath.innerText;
		}
		function rValue(){
			if(doc.getElementById("url").value.toLowerCase().indexOf("/<%= J.ManageFolder %>")>-1){
				window.returnValue=doc.getElementById("url").value.toLowerCase().replace("/<%= J.ManageFolder %>","..");
			}else{
				window.returnValue="../.." + doc.getElementById("url").value.toLowerCase();
			}
			window.close();
		}
		function PicView(o,key){
			if(key=="on"){
				ViewImg.src="../.." + curPath + "/" + doc.getElementById(o.id).getAttribute("jcp");
				ViewImg.onload=PicViewReSize;
			}else if(key=="off"){
				PicViewer.style.left="600px";
				PicViewer.style.top="500px";
				PicViewer.style.display="none";
				PicViewImg.src="";
				PicViewImg_Size.innerHTML = "";
				PicViewImg_Size_back.innerHTML = "";
			}
		}
		function PicViewReSize(){
			PicViewImg.src=ViewImg.src;
			PicViewImg_Size.innerHTML = ViewImg.width + "×" + ViewImg.height;
			PicViewImg_Size_back.innerHTML = ViewImg.width + "×" + ViewImg.height;
			var temp_width,temp_height,temp_size=180;
			if(ViewImg.width>=ViewImg.height){
				temp_width=temp_size;
				temp_height=temp_size*ViewImg.height/ViewImg.width;
			}else{
				temp_height=temp_size;
				temp_width=temp_size*ViewImg.width/ViewImg.height;
			}
			if(eventX<=250) PicViewer.style.left=(496 - 12 - temp_width) + "px";
				else PicViewer.style.left="0";
			if(eventY<=200) PicViewer.style.top=(346 - 12 - temp_height) + "px";
				else PicViewer.style.top="38px";
			PicViewImg.width  = temp_width;
			PicViewImg.height = temp_height;
			PicViewer.style.display="block";
		}
		function ReportXY(){
			eventX=event.x;
			eventY=event.y;
		}
</script>
<base target="_self">
<!--#include file="../JCP_Shared/body.asp" -->
<script language="JavaScript" type="text/JavaScript">
	doc.body.onclick=Hit;
	doc.body.onmousemove=ReportXY;
</script>
<% 
	dim path,parentPath,aPath,mPath,folder,subFos,subFis,subFo,subFi
	path=request.QueryString("path")
	if path="" then path=session("temp_ServerViewPath")
	if instr(path,"../")>0 or instr(path,"..\")>0 then
		J.ErrStr="访问地址非法！"
		J.ErrOpen("exit")
	else
		path="/" & replace(path,"\","/")
		do while instr(path,"//")>0
			path=replace(path,"//","/")
		loop
		
		mPath=right(path,len(path)-1)
		if instr(mPath,"/")>0 then mPath=left(mPath,instr(mPath,"/")-1)
		'if lcase(mPath)=lcase(J.ManageFolder) then
			'response.write "非法访问！"&path
			'response.end
		'end if
		
		if instr(path,"/")>0 then
			parentPath=left(path,instrRev(path,"/")-1)
		else
			parentPath=path
		end if
		if parentPath="" then parentPath="/"
		
		aPath=J.SiteRoot & replace(path,"/","\")
		do while instr(aPath,"\\")>0
			aPath=replace(aPath,"\\","\")
		loop
		if J.fso.FolderE(aPath) then
			session("temp_ServerViewPath")=path
			response.write "<script>curPath="""&path&""";</script>"
			set folder=J.fso.FolderG(aPath)
			set subFos=folder.subfolders
			set subFis=folder.files
			%>
			<div id="ServerView_Menu">
				<span><img src="../JCP_Skin/<%= session("SystemSkin") %>/images/ParentFolder.gif" title="返回上一级目录" onclick='form1.action="?path=<%= parentPath %>";form1.submit();'></span>
				<span><img src="../JCP_Skin/<%= session("SystemSkin") %>/images/Refresh.gif" title="刷新当前目录" onclick="form1.submit();"></span>
				<span><img src="../JCP_Skin/<%= session("SystemSkin") %>/images/SelectPath.gif" title="返回当前选中对象" onclick="rValue();"></span>
			</div>
			<div id="ServerView_Box">
			<%  dim i
				i=0
				for each subFo in subFos
					i=i+1
					'if lcase(subFo.name)<>lcase(J.ManageFolder) then 
					response.write "<span id=""Folder_"&i&""" class=""ServerView_out"" onClick=""Hit(this);"" onMouseOver=""Over(this);"" onMouseOut=""Out(this);"" onDblClick='form1.action=""?path="&path&"/" & subFo.name& """;form1.submit();' jcp="""&subFo.name&"""><img src=""../JCP_Skin/"&session("SystemSkin")&"/images/folder.gif""><br>" & subFo.name & "</span>"
				next
				for each subFi in subFis
					i=i+1
					select case subFi.type
						case "GIF 图像","PNG 图像","PSD 文件","图标","Cursor File","TIF 图像","BMP 图像","动画光标"
							response.write "<span id=""File_"&i&""" class=""ServerView_out"" onClick=""Hit(this);"" onMouseOver=""Over(this);PicView(this,'on');"" onMouseOut=""Out(this);PicView(this,'off');"" title=""类型："&subFi.type&vbcrlf&"大小："&formatnumber((subFi.size/1000),3,-1)&" k"&vbcrlf&"名称："&subFi.name&""" jcp="""&subFi.name&""" onDblClick=""rValue();""><img src=""../JCP_Skin/"&session("SystemSkin")&"/images/gif.gif""><br>" & subFi.name & "</span>"
						case "JPEG 图像"
							response.write "<span id=""File_"&i&""" class=""ServerView_out"" onClick=""Hit(this);"" onMouseOver=""Over(this);PicView(this,'on');"" onMouseOut=""Out(this);PicView(this,'off');"" title=""类型："&subFi.type&vbcrlf&"大小："&formatnumber((subFi.size/1000),3,-1)&" k"&vbcrlf&"名称："&subFi.name&""" jcp="""&subFi.name&""" onDblClick=""rValue();""><img src=""../JCP_Skin/"&session("SystemSkin")&"/images/jpg.gif""><br>" & subFi.name & "</span>"
						case else
							response.write "<span id=""File_"&i&""" class=""ServerView_out"" onClick=""Hit(this);"" onMouseOver=""Over(this);"" onMouseOut=""Out(this);"" title=""类型："&subFi.type&vbcrlf&"大小："&formatnumber((subFi.size/1000),3,-1)&" k"&vbcrlf&"名称："&subFi.name&""" jcp="""&subFi.name&""" onDblClick=""rValue();""><img src=""../JCP_Skin/"&session("SystemSkin")&"/images/file.gif""><br>" & subFi.name & "</span>"
					end select
				next
			%>
			</div>
			<div id="ServerView_Url">
				<span class="title">路径：</span>
				<span class="urlbox"><input type="text" id="url" name="url" value=""></span>
				<span class="urlback"></span>
			</div>
			<div id="ServerPath" disabled><%= path %><span id="eventxy"></span></div>
			<script language="JavaScript">curPathValue();</script>
			<form name="form1" method="post" action=""></form>
			<%  
		else
			J.ErrStr="访问地址不存在！"
			J.ErrOpen("exit")
		end if
	end if
	
	function getName(sName,sSize)
		dim i,tSize,tName,subStr
		tSize=0:tName=""
		for i=1 to len(sName)
			if tSize>sSize then exit for
			subStr=mid(sName,i,1)
			if asc(subStr)<0 then
				tSize=tSize+2
			else
				tSize=tSize+1
			end if
			if tSize>sSize then exit for
			tName=tName & subStr
		next
		getName=tName
	end function
%>
</div>
<div id="PicViewer" style="position:absolute;left:600px;top:500px;display:auto;padding:6px;background:url(../JCP_Skin/<%= session("SystemSkin") %>/images/transparent.gif);text-align:center;border:1px solid #000000;"><img id="PicViewImg"><span id="PicViewImg_Size_back" style="float:left;position:absolute;left:9px;top:7px;color:#FFF;"></span><span id="PicViewImg_Size" style="float:left;position:absolute;left:8px;top:6px;color:#000;"></span></div>
</body>
</html>
<% J.close %>