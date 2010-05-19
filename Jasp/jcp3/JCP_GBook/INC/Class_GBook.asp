<!--#include file="../InterFace.asp"-->
<!--#include file="../SameConfig.asp"-->
<!--#include file="../SystemSet.asp"-->
<% 
Const AllowHost="localhost,swqh.com"		'which hosts are allowed to link this systemfile!

class GBook

	Public Main,Same
	private grs

'构造函数，在使用 set new 创建对象时，自动执行

	private sub class_initialize()
		dim RefHost,RefPath,CurHost
		RefPath=replace(replace(replace(lcase(request.ServerVariables("HTTP_REFERER")),"\","/"),"http://",""),"www.","")
		if RefPath<>"" then
			RefHost=left(RefPath,instr(RefPath,"/")-1)
			CurHost=lcase(request.ServerVariables("HTTP_HOST"))
			if not instr(AllowHost,RefHost)>0 then
				if RefHost<>CurHost then
					response.write "<br><br><center>Don't do this,please! ^_^</center>"
					response.end
				end if
			end if
		end if
	end sub
	
	Private function PathModify()
		'生成修正地址，以网站根目录为参照
		dim tempCurrentPath
		tempCurrentPath=lcase(request.ServerVariables("URL"))
		if instr(tempCurrentPath,"/main/")>0 then 
			PathModify="../../"
		elseif instr(tempCurrentPath,lcase("/" & SameManageFolder & "/" & SameManagePath))>0 then
			PathModify="../../"
		elseif instr(tempCurrentPath,lcase("/" & SameManagePath & "inc/"))>0 then
			PathModify="../../"
		else
			PathModify="../"
		end if
	end function
	
	Public function MainOpen()
		'打开数据主库
		set Main=new JCP
		Main.WebOpen server.mapPath(PathModify & SameManageFolder & "/" & SameManagePath & "Database/JCP_GBook.mdb")
	end Function
	
	Public function MainClose()
		Main.WebClose()
	end function
	
	Public function SameOpen()
		'打开数据主库，同步系统设置专用
		set Same=new JCP
		Same.WebOpen server.mapPath("Database/JCP_GBook.mdb")
	end Function
	
	Public function SameClose()
		Same.WebClose()
	end function
	
	public function NewMsg(username,msgtitle,msgcontent)
		if not Main.BlankTF(username) then username="匿名"
		if not Main.BlankTF(msgtitle) then usertitle=""
		if not Main.BlankTF(msgcontent) then msgcontent=""
		
		set grs=Main.data.RsOpen("select * from msg where id=0",3)
		grs.addnew
		grs("username")=username
		grs("msgtitle")=msgtitle
		grs("msgcontent")=msgcontent
		grs("showyn")=not passyn
		grs("intime")=now()
		grs.update
		grs.close
	end function
	
	public function EditMsg(id,username,msgtitle,msgcontent)
		if Main.BlankTF(username) then username="匿名"
		if Main.BlankTF(msgtitle) then usertitle="无"
		if Main.BlankTF(msgcontent) then msgcontent="无"
		
		set grs=Main.data.RsOpen("select * from msg where id=" & id,3)
		if not grs.eof then
			grs("username")=username
			grs("msgtitle")=msgtitle
			grs("msgcontent")=msgcontent
			grs.update
		end if
		grs.close
	end function
	
	public function DelMsg(id)
		Main.NumberYN replace(id,",","")
		Main.NumberYN left(id,1)
		Main.NumberYN right(id,1)
		Main.Exe "delete from msg where id in (" & id & ")"
	end function
	
	public function ReplyMsg(id,reply)
		set grs=Main.data.RsOpen("select reply from msg where id=" & id,3)
		if not grs.eof then
			grs("reply")=reply
			grs.update
		end if
		grs.close
	end function
	
	public function ShowMsg(id)
		set grs=Main.data.RsOpen("select * from msg where id=" & id,1)
		if not grs.eof then
			ShowMsg=grs.GetRows()
		else
			ShowMsg=Empty
		end if
		grs.close
	end function
	
	public MsgCount,MsgPageCount
	public function ListMsg(curpage,showtype)
		if showtype=-1 then	'显示未通过留言
			set grs=Main.data.RsOpen("select * from msg where showyn=false order by id desc",1)
		elseif showtype=0 then	'显示所有留言
			set grs=Main.data.RsOpen("select * from msg order by id desc",1)
		elseif showtype=1 then	'显示已审核留言
			set grs=Main.data.RsOpen("select * from msg where showyn=true order by id desc",1)
		end if
		if not grs.eof then
			dim arrayrs,rssize,i
			grs.pagesize=pgsize
			MsgCount=grs.recordcount
			MsgPageCount=grs.pagecount
			if curpage>MsgPageCount then curpage=MsgPageCount
			if curpage<1 then curpage=1
			grs.absolutepage=curpage
			if MsgCount-curpage*pgsize>=0 then rssize=pgsize-1 else rssize=MsgCount-(curpage-1)*pgsize-1
			redim arrayrs(6,rssize)
			for i=0 to rssize
				arrayrs(0,i)=grs("id")
				arrayrs(1,i)=Main.Encode(grs("username"))
				arrayrs(2,i)=Main.Encode(grs("msgtitle"))
				arrayrs(3,i)=Main.Encode(grs("msgcontent"))
				arrayrs(4,i)=Main.Encode(grs("msgreply"))
				arrayrs(5,i)=grs("intime")
				arrayrs(6,i)=grs("showyn")
				grs.movenext
			next
			ListMsg=arrayrs
		else
			ListMsg=Empty
		end if
		grs.close
	end function
		
	public function SystemSet(color_font_system1,color_font_content1,color_font_title1,color_font_username1,color_font_time1,color_font_reply1, _
								color_bg_title1,color_bg_content1,color_bg_reply1, _
								color_border1, _
								passyn,pagename1,pgsize1)
		dim sethtml,forePath
		sethtml="<" & "%" & vbcrlf _
				& "const color_font_system=""" & color_font_system1 & """" & vbcrlf _
				& "const color_font_content=""" & color_font_content1 & """" & vbcrlf _
				& "const color_font_title=""" & color_font_title1 & """" & vbcrlf _
				& "const color_font_username=""" & color_font_username1 & """" & vbcrlf _
				& "const color_font_time=""" & color_font_time1 & """" & vbcrlf _
				& "const color_font_reply=""" & color_font_reply1 & """" & vbcrlf _
				& "const color_bg_title=""" & color_bg_title1 & """" & vbcrlf _
				& "const color_bg_content=""" & color_bg_content1 & """" & vbcrlf _
				& "const color_bg_reply=""" & color_bg_reply1 & """" & vbcrlf _
				& "const color_border=""" & color_border1 & """" & vbcrlf & vbcrlf _
				& "const passyn=" & passyn & vbcrlf _
				& "const pagename=""" & pagename1 & """" & vbcrlf _
				& "const pgsize=""" & pgsize1 & """" & vbcrlf _
				& "%" & ">"
		forePath=server.mapPath(PathModify & J.CurrentManagePath)
		if J.fso.FolderE(forePath) then J.fso.FileN forePath & "/SystemSet.asp",sethtml
	end function
	
	public function MsgFace(msg)
		dim facei
		for facei=1 to 11
			msg=replace(msg&"","[face:" & facei & "]","<img src=""../images/" & facei & ".gif"" align=""absmiddle"">")
		next
		MsgFace=msg
	end function
	
end class
%>
<!--#include file="../../JCP_Inc/Class_JCP.asp"-->
<%
dim G
set G=new GBook
%>
