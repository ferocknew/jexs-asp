<!--#include file="../INC/Class_Search.asp"-->
<style><%= csssheet %></style>
<%
S.MainOpen
dim searchid
searchid=session("JCP_Search_ID")
if S.Main.NumberTF(request.form("JCP_Search_Type")) then 
	searchid=request.form("JCP_Search_Type")
	session("JCP_Search_ID")=""
	session("JCP_Search_Keyword")=""
	session("JCP_Search_SQL")=""
	session("JCP_Search_TrueItem")=""
end if

sub SearchInputBox(sid)
	if S.Main.NumberTF(sid) then
		response.write "<script language=""javascript"" src=""../../jcp_search/JS/" & sid & ".js""><script>"
	end if
end sub

sub SearchResult(sid)
	dim keyword,sql,trueitem
	if trim(session("JCP_Search_SQL")&" ")="" or trim(session("JCP_Search_TrueItem")&" ")="" then
		dim searchobject,searchrange,sqlrange
		sid=S.Main.NumberYn(sid)
		keyword=S.Main.BlankYn(request.form("JCP_Search_KeyWord"))
		keyword=replace(replace(replace(keyword,"'",""),"""",""),"$","")
		searchobject=S.Main.NumberYn(request.form("JCP_Search_Object"))
		searchrange=S.Main.NumberYn(request.form("JCP_Search_Range"))
		
		if searchobject>0 then
			if searchrange>0 then
				set srs=S.Main.data.RsOpen("select searchsystemid,searchobjectorder,searchcolumn from searchrange where searchid=" & sid & " and searchobjectorder=" & searchobject & " and searchsystemid=" & searchrange & " order by searchsystemid,searchobjectorder",1)
			else
				set srs=S.Main.data.RsOpen("select searchsystemid,searchobjectorder,searchcolumn from searchrange where searchid=" & sid & " and searchobjectorder=" & searchobject & " order by searchsystemid,searchobjectorder",1)
			end if
		else
			if searchrange>0 then
				set srs=S.Main.data.RsOpen("select searchsystemid,searchobjectorder,searchcolumn from searchrange where searchid=" & sid & " and searchsystemid=" & searchrange & " order by searchsystemid,searchobjectorder",1)
			else
				set srs=S.Main.data.RsOpen("select searchsystemid,searchobjectorder,searchcolumn from searchrange where searchid=" & sid & " order by searchsystemid,searchobjectorder",1)
			end if
		end if
		dim cursystemid,selectsql,wheresql,rsi
		cursystemid=0
		sql=""
		rsi=0
		trueitem="systemid,id,UpTime"
		do while not srs.eof
			if cursystemid<>srs("searchsystemid") then
				cursystemid=srs("searchsystemid")
				rsi=1
				selectsql=srs("searchcolumn") & " as searchcolumn" & rsi
				wheresql=srs("searchcolumn") & " like '%" & replace(keyword,"'","") & "%'"
			else
				rsi=rsi+1
				selectsql=selectsql & "," & srs("searchcolumn") & " as searchcolumn" & rsi
				wheresql=wheresql & " or " & srs("searchcolumn") & " like '%" & keyword & "%'"
			end if
			if not instr(trueitem,"searchcolumn" & rsi)>0 then trueitem = trueItem & ",searchcolumn" & rsi
			srs.movenext
			
			if srs.eof then
				if sql<>"" then
					sql = sql & " UNION select " & cursystemid & " as systemid,id,UpTime," & selectsql & " from Article_" & cursystemid & " where " & wheresql & " order by id desc"
				else
					sql = sql & "select " & cursystemid & " as systemid,id,UpTime," & selectsql & " from Article_" & cursystemid & " where " & wheresql & " order by id desc"
				end if
			else
				if cursystemid<>srs("searchsystemid") then
					if sql<>"" then
						sql = sql & " UNION select " & cursystemid & " as systemid,id,UpTime," & selectsql & " from Article_" & cursystemid & " where " & wheresql & " order by id desc"
					else
						sql = "select " & cursystemid & " as systemid,id,UpTime," & selectsql & " from Article_" & cursystemid & " where " & wheresql & " order by id desc"
					end if
				end if
			end if
		loop
		srs.close
		session("JCP_Search_Keyword")=keyword
		session("JCP_Search_SQL")=sql
		session("JCP_Search_TrueItem")=trueitem
		session("JCP_Search_ID")=sid
	else
		searchid=session("JCP_Search_ID")
		keyword=session("JCP_Search_Keyword")
		sql=session("JCP_Search_SQL")
		trueitem=session("JCP_Search_TrueItem")
	end if
	%>
	<script language="JavaScript" src="../JS/showpage.js"></script>
	<%  
	dim J
	set J=new JCP
	J.WebOpen server.MapPath(searchdatabase)
	dim page,rscount,jj,ii,temp_listcount,rs,truesize,truecolcount
	temp_listcount=0
	set page=J.Page(trueitem & "$(" & sql & ")$$UpTime desc$id",pgsize)
	rscount=page.RecCount()
	rs=page.ResultSet()
	response.write "<div id=""JCP_Search_Result"">"
	if rscount<1 then
		response.write "没有搜索到合适的结果！"
	else
		columncount=ubound(rs,1)
		truesize=Ubound(rs,2)
		for jj=0 to truesize
			response.write "<div class=""ResultItem"">"
			for ii=0 to columncount-3
				response.write "<div class=""Info_" & ii+1 & """>" & S.SearchItemShow(S.Main.ClearHtml(rs(ii+3,jj)),keyword) & "</div>"
			next
			response.write "<div class=""Link""><a href=""SearchShow.asp?sid=" & rs(0,jj) & "&aid=" & rs(1,jj) & """ target=""_blank"">查看详情</a></div>"
			response.write "<div class=""SystemID"">" & rs(0,jj) & "</div>"
			response.write "<div class=""ID"">" & rs(1,jj) & "</div>"
			response.write "<div class=""UpTime"">发布时间：" & rs(2,jj) & "</div>"
			response.write "</div>"
		next
	end if
	page.ShowPage()
	response.write "</div>"
	J.WebClose
end sub

if S.Main.NumberTF(searchid) then
	SearchResult searchid
end if

S.MainClose
%>