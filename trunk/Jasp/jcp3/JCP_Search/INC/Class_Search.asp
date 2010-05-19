<!--#include file="../InterFace.asp"-->
<!--#include file="../SameConfig.asp"-->
<!--#include file="../SystemSet.asp"-->
<% 
Const AllowHost="localhost,swph.com"		'which hosts are allowed to link this systemfile!

class Search

	Public Main,Same
	private srs

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
	
	private function FileName()
		dim systempagename
		systempagename="search.asp"
		if Main.fso.FileE(server.mappath("../../JCP_Search/main/" & pagename)) then FileName=pagename else FileName=systempagename
	end function
	
	Public function MainOpen()
		'打开数据主库
		set Main=new JCP
		Main.WebOpen server.mapPath(PathModify & SameManageFolder & "/" & SameManagePath & "Database/JCP_Search.mdb")
	end Function
	
	Public function MainClose()
		Main.WebClose()
	end function
	
	public function NewSearch(sn,bl,oe,se,ss)
		dim nsid
		set srs=Main.data.RsOpen("select * from search where id=0",3)
		srs.addnew
		srs("searchname")=sn
		srs("objectelement")=oe
		srs("systemelement")=se
		srs("stylesheet")=ss
		srs.update
		nsid=srs("id")
		srs.close
		
		dim parambl,parami,itembl,objectids
		parambl=split(bl,"||")
		objectids="||"
		set srs=Main.data.RsOpen("select * from searchrange where id=0",3)
			for parami=0 to ubound(parambl)
				itembl=split(parambl(parami),"|")
				srs.addnew
				srs("searchid")=nsid
				srs("searchsystemid")=cint(itembl(0))
				srs("searchrangeid")=cint(itembl(1))
				srs("searchcolumn")=itembl(2)
				srs("searchobjectorder")=cint(itembl(3))
				srs.update
				if not instr(objectids,"|" & itembl(3) & "|")>0 then Main.data.exe "insert into searchobject(searchid,searchobjectorder,searchobjectname) values(" & nsid & "," & itembl(3) & ",'" & itembl(4) & "')"
				objectids = objectids & itembl(3) & "|"
			next
		srs.close
	end function
	
	public function EditSearch(nsid,sn,bl,oe,se,ss)
		set srs=Main.data.RsOpen("select * from search where id=" & nsid,3)
		srs("searchname")=sn
		srs("objectelement")=oe
		srs("systemelement")=se
		srs("stylesheet")=Main.unEncode(ss)
		srs.update
		srs.close
		
		Main.data.Exe "delete from searchobject where searchid=" & nsid
		Main.data.Exe "delete from searchrange where searchid=" & nsid
		
		dim parambl,parami,itembl,objectids
		parambl=split(bl,"||")
		objectids="||"
		set srs=Main.data.RsOpen("select * from searchrange where id=0",3)
			for parami=0 to ubound(parambl)
				itembl=split(parambl(parami),"|")
				srs.addnew
				srs("searchid")=nsid
				srs("searchsystemid")=cint(itembl(0))
				srs("searchrangeid")=cint(itembl(1))
				srs("searchcolumn")=itembl(2)
				srs("searchobjectorder")=cint(itembl(3))
				srs.update
				if not instr(objectids,"|" & itembl(3) & "|")>0 then Main.data.exe "insert into searchobject(searchid,searchobjectorder,searchobjectname) values(" & nsid & "," & itembl(3) & ",'" & itembl(4) & "')"
				objectids = objectids & itembl(3) & "|"
			next
		srs.close
	end function
	
	public function Search2JS(typeid)
		if typeid=-1 then
			set srs=Main.data.RsOpen("select top 1 * from search order by id desc",1)		'生成最新一条
		elseif typeid=0 then
			set srs=Main.data.RsOpen("select * from search order by id",1)				'生成所有
		else
			set srs=Main.data.RsOpen("select * from search where id=" & typeid,1)		'生成typeid指定的一条 
		end if
		
		dim cont,ors,systemids
		do while not srs.eof
			cont="document.write('" & replace(srs("stylesheet"),chr(13) & chr(10),"") & "');" & vbcrlf
			if srs("objectelement")>0 then
				set ors=Main.data.ReRsOpen("select * from searchobject where searchid=" & srs("id") & " order by searchobjectorder","ors",1)
				cont = cont & "var jso=document.getElementById('JCP_Search_Object');" & vbcrlf
				do while not ors.eof
					cont = cont & "jso.options[jso.length]=new Option('" & ors("searchobjectname") & "','" & ors("searchobjectorder") & "');" & vbcrlf
					ors.movenext
				loop
				cont = cont & "jso.value='" & srs("objectelement") & "';" & vbcrlf
				ors.close
			else
				cont = cont & "document.write('<input type=hidden name=JCP_Search_Object value=0>');" & vbcrlf
			end if
			if srs("systemelement")>0 then
				set rrs=Main.data.ReRsOpen("select distinct searchsystemid from searchrange where searchid=" & srs("id") & " order by searchsystemid","rrs",1)
				systemids=""
				do while not rrs.eof
					if systemids="" then systemids=rrs("searchsystemid") else systemids=systemids & "," & rrs("searchsystemid")
					rrs.movenext
				loop
				rrs.close
				set rrs=J.data.ReRsOpen("select menuid,menutitle from JCP_AppSystem where menuid in(" & systemids & ") order by menuid","rrs",1)
				cont = cont & "var jsr=document.getElementById('JCP_Search_Range');" & vbcrlf
				do while not ors.eof
					cont = cont & "jsr.options[jsr.length]=new Option('" & rrs("menutitle") & "','" & rrs("menuid") & "');" & vbcrlf
					ors.movenext
				loop
				cont = cont & "jsr.value='" & srs("systemelement") & "';" & vbcrlf
				rrs.close
			else
				cont = cont & "document.write('<input type=hidden name=JCP_Search_Range value=0>');" & vbcrlf
			end if
			cont = "document.write('<form name=""JCP_Search_Form"" id=""JCP_Search_Form"" style=""margin:0;padding:0;"" method=""post"" action=""../../JCP_Search/main/" & FileName & """ target=""_blank"">');" & vbcrlf & _
				   "document.write('<input type=hidden name=JCP_Search_Type value=""" & srs("id") & """>');" & vbcrlf & _
				   cont & _
				   "document.write('</form>');" & vbcrlf
			Main.fso.fileN server.mappath(PathModify & SameManagePath & "JS/" & srs("id") & ".js"),cont
			if typeid=-1 then Search2JS=srs("id")
			srs.movenext
		loop
		srs.close
	end function	
	
	public SearchCount,SearchPageCount
	public function ListSearch(curpgsize,curpage)
		set srs=Main.data.RsOpen("select * from search order by id desc",1)
		if not srs.eof then
			dim arrayrs,rssize,i
			srs.pagesize=curpgsize
			SearchCount=srs.recordcount
			SearchPageCount=srs.pagecount
			if curpage>SearchPageCount then curpage=SearchPageCount
			if curpage<1 then curpage=1
			srs.absolutepage=curpage
			if SearchCount-curpage*curpgsize>=0 then rssize=curpgsize-1 else rssize=SearchCount-(curpage-1)*curpgsize-1
			redim arrayrs(2,rssize)
			for i=0 to rssize
				arrayrs(0,i)=srs("id")
				arrayrs(1,i)=srs("searchname")
				arrayrs(2,i)=srs("intime")
				srs.movenext
			next
			ListSearch=arrayrs
		else
			ListSearch=Empty
		end if
		srs.close
	end function
	
	public function DeleteSearch(sid)
		Main.data.Exe "delete from searchrange where searchid in (" & sid & ")"
		Main.data.Exe "delete from searchobject where searchid in (" & sid & ")"
		Main.data.Exe "delete from search where id in (" & sid & ")"
		if instr(sid,",")>0 then
			dim paramid,parami
			paramid=split(sid,",")
			for parami=0 to ubound(paramid)
				Main.fso.FileD server.mappath("../../" & SameManagePath & "JS/" & paramid(parami) & ".js")
			next
		end if
	end function
	
	public function SearchItemShow(strs,word)
		dim startnum,endnum,strsnum
		strsnum=len(strs)
		startnum=instr(strs,word)
		endnum=startnum-1+len(word)
		if startnum=0 then
			if strsnum>searchshowsize*2 then
				SearchItemShow=left(strs,searchshowsize*2) & "…"
			else
				if strsnum=0 then
					SearchItemShow="…"
				else
					SearchItemShow=strs
				end if
			end if
		else
			if strsnum>searchshowsize*2+len(word) then
				dim startstrs,endstrs,slen,elen
				startstrs=left(strs,startnum-1)
				slen=len(startstrs)
				endstrs=right(strs,strsnum-endnum)
				elen=len(endstrs)
				if slen<searchshowsize then
					if elen<searchshowsize then
						SearchItemShow=startstrs & "<font color=""" & color_keyword & """>" & word & "</font>" & replace(endstrs,word,"<font color=""" & color_keyword & """>" & word & "</font>")
					else
						SearchItemShow=startstrs & "<font color=""" & color_keyword & """>" & word & "</font>" & replace(left(endstrs,searchshowsize),word,"<font color=""" & color_keyword & """>" & word & "</font>") & "…"
					end if
				else
					if elen<searchshowsize then
						SearchItemShow="…" & right(startstrs,searchshowsize) & "<font color=""" & color_keyword & """>" & word & "</font>" & replace(endstrs,word,"<font color=""" & color_keyword & """>" & word & "</font>")
					else
						SearchItemShow="…" & right(startstrs,searchshowsize) & "<font color=""" & color_keyword & """>" & word & "</font>" & replace(left(endstrs,searchshowsize),word,"<font color=""" & color_keyword & """>" & word & "</font>") & "…"
					end if
				end if
			else
				SearchItemShow=replace(strs,word,"<font color=""" & color_keyword & """>" & word & "</font>")
			end if
		end if
	end function
	
	public function SystemSet(csssheet1,color_keyword1,pagename1,pgsize1,searchshowsize1,searchdatabase1,searchfilefolder1,searchfileext1)
		dim sethtml,forePath
		sethtml="<" & "%" & vbcrlf _
				& "const csssheet=""" & replace(replace(replace(csssheet1,"}" & chr(13)&chr(10),"};"),chr(13)&chr(10),""),"""","""""") & """" & vbcrlf _
				& "const color_keyword=""" & color_keyword1 & """" & vbcrlf & vbcrlf _
				& "const pagename=""" & pagename1 & """" & vbcrlf _
				& "const pgsize=" & pgsize1 & vbcrlf _
				& "const searchshowsize=" & searchshowsize1 & vbcrlf & vbcrlf _
				& "const searchdatabase=""" & searchdatabase1 & """" & vbcrlf _
				& "const searchfilefolder=""" & searchfilefolder1 & """" & vbcrlf _
				& "const searchfileext=""" & searchfileext1 & """" & vbcrlf _
				& "%" & ">"
		forePath=server.mapPath(PathModify & J.CurrentManagePath)
		if Main.fso.FolderE(forePath) then Main.fso.FileN forePath & "/SystemSet.asp",sethtml
	end function
end class
%>
<!--#include file="../../JCP_Inc/Class_JCP.asp"-->
<%
dim S
set S=new Search
%>
