<%
	Class JCP

		public Host,SiteRoot,SiteUrlRoot,ManageRoot,ManageUrlRoot,ManageFolder,CurrentManagePath,ErrStr,Version
		public SiteName,SiteSystemName,SiteURL,SystemSkin,DataPath,DataName,SystemLogo,UploadPath,WebPath,ScriptPath,WebCssPath,FileExt,IndexName,CopyRight,DataSource_Web,Color_MainFont,Color_SystemFont,Color_LightFont,Color_Main,Color_Back,Color_Dip,Color_Fleet,Top_Height,Menu_Width,DataSource
		private WebConfig_XML,PageStartTime,PageEndTime
		public Data,fso,Template,Upload
		public Block,Model
		
		private sub Initialize()
			SiteManagePath()'获取站点及后台地址
			Version       = "JCP V3.0"
			Block=Array("普通数据模块","分页列表模块","内容显示模块","数据JS模块","替换型模块","JS 脚本模块","VB 脚本模块")
			Model=Array("栏目首页","栏目列表","栏目内容","独立页面","网站首页")
		end sub
		
		private sub SiteManagePath()
			'获取站点及后台地址
			if (isempty(session("JCP_WebConfig"))) or (not cbool(session("JCP_WebConfig"))) then
				dim temp_url
				temp_url=request.ServerVariables("URL")
				temp_url=left(temp_url,instrRev(temp_url,"/")-1)
				Host=request.ServerVariables("HTTP_HOST")
				ManageUrlRoot = left(temp_url,instrRev(temp_url,"/"))
				SiteUrlRoot   = left(left(ManageUrlRoot,len(ManageUrlRoot)-1),instrrev(left(ManageUrlRoot,len(ManageUrlRoot)-1),"/"))
				ManageRoot    = server.MapPath(ManageUrlRoot) & "\"
				SiteRoot      = server.MapPath(SiteUrlRoot) & "\"
				ManageFolder  = right(server.MapPath(ManageUrlRoot),len(server.MapPath(ManageUrlRoot))-instrRev(server.MapPath(ManageUrlRoot),"\"))
				session("Host")    = Host
				session("ManageUrlRoot")    = ManageUrlRoot
				session("SiteUrlRoot")      = SiteUrlRoot
				session("SiteRoot")         = SiteRoot
				session("ManageRoot")       = ManageRoot
				session("ManageFolder")     = ManageFolder
			else
				Host    		 = session("Host")
				ManageUrlRoot    = session("ManageUrlRoot")
				SiteUrlRoot      = session("SiteUrlRoot")
				SiteRoot         = session("SiteRoot")
				ManageRoot       = session("ManageRoot")
				ManageFolder     = session("ManageFolder")
			end if
			
			CurrentManagePath=replace(lcase(request.ServerVariables("URL")),lcase(ManageUrlRoot),"")
			dim paramFolders,paramFolderI
			paramFolders=split(CurrentManagePath,"/")
			CurrentManagePath=""
			for paramFolderI=0 to ubound(paramFolders)-1
				CurrentManagePath = CurrentManagePath & paramFolders(paramFolderI) & "/"
			next
		end sub
		
		public sub WebConfig()
			Object_Check  '系统必要的对象检查
			WebConfig_XML = "JCP_XML\WebConfig.xml"  '配置文件
			session("WebConfig_XML") = WebConfig_XML 
			dim xml,xmlroot,xmlitems
			set xml=server.CreateObject("Microsoft.XMLDOM")
			xml.Async=false
			if fso.FileE(ManageRoot & WebConfig_XML) then 
				xml.Load(ManageRoot & WebConfig_XML)
				set xmlroot = xml.documentElement
				SiteName   		 = xmlroot.selectSingleNode("JCP_Site_Name").text
				SiteURL   		 = xmlroot.selectSingleNode("JCP_Site_URL").text
				SiteSystemName   = xmlroot.selectSingleNode("JCP_Site_System_Name").text
				SystemSkin 		 = xmlroot.selectSingleNode("JCP_System_Skin").text
				DataPath   		 = xmlroot.selectSingleNode("JCP_Database_Path").text
				DataName   		 = xmlroot.selectSingleNode("JCP_Database_Name").text
				SystemLogo 		 = xmlroot.selectSingleNode("JCP_System_Logo").text
				UploadPath 		 = xmlroot.selectSingleNode("JCP_UploadPath").text
				WebPath    		 = xmlroot.selectSingleNode("JCP_WebPath").text
				ScriptPath    	 = xmlroot.selectSingleNode("JCP_ScriptPath").text
				WebCssPath 		 = xmlroot.selectSingleNode("JCP_WebCssPath").text
				FileExt    		 = xmlroot.selectSingleNode("JCP_HTMLFileExt").text
				IndexName  		 = xmlroot.selectSingleNode("JCP_HTMLFile_Index").text
				Color_MainFont   = xmlroot.selectSingleNode("JCP_System_Color_MainFont").text
				Color_SystemFont = xmlroot.selectSingleNode("JCP_System_Color_SystemFont").text
				Color_LightFont  = xmlroot.selectSingleNode("JCP_System_Color_LightFont").text
				Color_Main       = xmlroot.selectSingleNode("JCP_System_Color_Main").text
				Color_Back       = xmlroot.selectSingleNode("JCP_System_Color_Back").text
				Color_Dip        = xmlroot.selectSingleNode("JCP_System_Color_Dip").text
				Color_Fleet      = xmlroot.selectSingleNode("JCP_System_Color_Fleet").text
				CopyRight        = xmlroot.selectSingleNode("JCP_System_CopyRight").text
				Top_Height       = xmlroot.selectSingleNode("JCP_Win_Top_Height").text
				Menu_Width       = xmlroot.selectSingleNode("JCP_Win_Menu_Width").text
				Session_Load "in"
				set xmlroot=nothing
				session("JCP_WebConfig")=true
			else
				ErrStr="对不起，系统无法找到配置文件！"
				ErrOpen("exit")
			end if
			set xml=nothing
		end sub
	
		public sub Open(tempDataSource)
			if isempty(session("SystemStartTime")) or session("SystemStartTime")="" then session("SystemStartTime")=now()
			UrlCheck request.ServerVariables("QUERY_STRING")
			PageStartTime=timer()    '记录开始时间
			Initialize          '初始化
			JCP_Login
			Fso_Load
			if (isempty(session("JCP_WebConfig"))) or (not cbool(session("JCP_WebConfig"))) then WebConfig() else Session_Load("out")
			AdminPurv_Check
			Data_Load(tempDataSource)
			Template_Load
			Upload_Load
		end sub
	
		public sub WebOpen(tempDataSource)
			UrlCheck request.ServerVariables("QUERY_STRING")
			PageStartTime=timer()    '记录开始时间
			Fso_Load
			Data_Load_With(tempDataSource)
			Upload_Load
		end sub
		
		public sub Close()
			fso.close
			Data.close
			Template.close
			set Upload=nothing
		end sub
		
		public sub WebClose()
			fso.close
			Data.close
			set Upload=nothing
		end sub
		
		private sub Fso_Load()
			set fso=new JCP_File
			fso.open
		end sub
		
		private sub Data_Load(tempDataSource)
			set Data=new JCP_DataControl   '连接数据库
			if tempDataSource=null or tempDataSource&""="" then DataSource = ManageRoot & DataPath & "\" & DataName else DataSource=tempDataSource
			if not Data.open(DataSource) then
				ErrStr="对不起，待连接的数据库不存在！"
				ErrOpen("stop")
			end if
		end sub
		
		private sub Data_Load_With(tempDataSource)
			set Data=new JCP_DataControl   '连接数据库
			if not Data.open(tempDataSource) then
				ErrStr="对不起，待连接的数据库不存在！"
				ErrOpen("stop")
			end if
		end sub
		
		private sub Template_Load()
			set Template=new JCP_Template
			Template.open
		end sub
		
		private sub Upload_Load()
			set Upload=New UpLoadClass
			dim t_savepath:t_savepath=fso.FolderN(SiteRoot & UploadPath)
			if t_savepath<>true then
				ErrStr="对不起，默认上传路径创建有误！\n\n原因：" & t_savepath
				ErrOpen("exit")
			end if
		end sub
		
		public function Page(temp_SQL,temp_PageSize)
			set Page=new Class_ShowoPage
			With Page
				.Conn=Data.JPageConn			'得到数据库连接对象
				.DbType="AC"
				'数据库类型,AC为access,MSSQL为sqlserver2000,MSSQL_SP为存储过程版,MYSQL为mysql,PGSQL为PostGreSql
				.RecType=0
				'取记录总数方法(0执行count,1自写sql语句取,2固定值)
				.RecSql=0
				'如果RecType＝1则=取记录sql语句，如果是2=数值，等于0=""
				.RecTerm=1
				'取从记录条件是否有变化(0无变化,1有变化,2不设置cookies也就是及时统计，适用于搜索时候)
				.CookieName="recac"	'如果RecTerm＝2,cookiesname="",否则写cookiesname
				.Order=0			'排序(0顺序1降序),注意要和下面sql里面主键ID的排序对应
				.PageSize=temp_PageSize		'每页记录条数
				.JsUrl="../JCP_Script/"			'show_page.js的路径
				.Sql=temp_SQL '字段,表,条件(不需要where),排序(不需要ORDER BY),主键ID
			End With
		end function
		
		public sub Session_Load(loadtype)
			if loadtype="in" then
				session("SiteName")         = SiteName
				session("SiteURL")          = SiteURL
				session("SiteSystemName")   = SiteSystemName
				session("SystemSkin")       = SystemSkin
				session("SystemLogo")       = SystemLogo
				session("UploadPath")       = UploadPath
				session("DataPath")         = DataPath
				session("DataName")         = DataName
				session("WebPath")          = WebPath
				session("ScriptPath")       = ScriptPath
				session("WebCssPath")       = WebCssPath
				session("FileExt")          = FileExt
				session("IndexName")        = IndexName
				session("Color_MainFont")   = Color_MainFont
				session("Color_SystemFont") = Color_SystemFont
				session("Color_LightFont")  = Color_LightFont
				session("Color_Main")       = Color_Main
				session("Color_Back")       = Color_Back
				session("Color_Dip")        = Color_Dip
				session("Color_Fleet")      = Color_Fleet
				session("CopyRight")        = CopyRight
				session("Top_Height")       = Top_Height
				session("Menu_Width")       = Menu_Width
			elseif loadtype="out" then
				SiteName         = session("SiteName")
				SiteURL          = session("SiteURL")
				SiteSystemName   = session("SiteSystemName")
				SystemSkin       = session("SystemSkin")
				SystemLogo       = session("SystemLogo")
				UploadPath       = session("UploadPath")
				DataPath         = session("DataPath")
				DataName         = session("DataName")
				WebPath          = session("WebPath")
				ScriptPath       = session("ScriptPath")
				WebCssPath       = session("WebCssPath")
				FileExt          = session("FileExt")
				IndexName        = session("IndexName")
				Color_MainFont   = session("Color_MainFont")
				Color_SystemFont = session("Color_SystemFont") 
				Color_LightFont  = session("Color_LightFont")
				Color_Main       = session("Color_Main")
				Color_Back       = session("Color_Back")
				Color_Dip        = session("Color_Dip")
				Color_Fleet      = session("Color_Fleet")
				CopyRight        = session("CopyRight")
				Top_Height       = session("Top_Height")
				Menu_Width       = session("Menu_Width")
			end if
		end sub
		
		private sub JCP_Login()
			if (isempty(session("JCP_Login"))) or (not cbool(session("JCP_Login"))) then
				if not instr(lcase(request.ServerVariables("URL")),"login_check.asp")>0 then 
					session("JCP_LoginPage")=true
					response.Write("<script>top.location="""&ManageUrlRoot&"""</script>")
				end if
			end if
		end sub
		
		Public Sub JCP_Logout()
			response.Write "<script language=""javascript"">"
			response.Write "top.location='" & ManageUrlRoot & "JCP_Login/Logout.asp';"
			response.Write "</script>"
			response.End()
		End Sub
		
		Public Sub Admin_Guide_Purv_Load()
			if session("JCP_AdminType")>0 and session("JCP_AdminPurv")>0 then
				dim ars,purv_ids,guide_ids
				set ars=Data.ReRsOpen("select purv_ids,guide_ids from JCP_purviewteam where id=" & session("JCP_AdminPurv"),"ars",1)
				if not ars.eof then
					purv_ids = ars(0) & ""
					session("JCP_AdminGuides") = ars(1) & ""
				else
					purv_ids = ""
					session("JCP_AdminGuides") = ""
				end if
				ars.close
				if purv_ids<>"" then
					dim brs,purv_urls
					set brs=Data.ReRsOpen("select purv_url from JCP_purview,JCP_purviewlist where JCP_purview.id=JCP_purviewlist.purv_id and JCP_purview.id in ("&purv_ids&") order by JCP_purview.id,JCP_purviewlist.id","brs",1)
					if not brs.eof then
						purv_urls=Cstr(brs.recordcount)
						do while not brs.eof
							purv_urls = purv_urls & "{$|}" & brs(0)
							brs.movenext
						loop
						session("JCP_AdminPurvUrls")=split(purv_urls,"{$|}")
					else
						session("JCP_AdminPurvUrls")=Array("0","")
					end if
					brs.close
				else
					session("JCP_AdminPurvUrls")=Array("0","")
				end if
			else
				session("JCP_AdminGuides") = ""
				session("JCP_AdminPurvUrls")=Array("0","")
			end if
		End Sub
		
		Public Sub AdminPurv_Check()
			if session("JCP_AdminType")<>0 then 
				dim cururl,urlii,checkpass:checkpass=false
				cururl=lcase(request.ServerVariables("URL")&"?"&request.ServerVariables("QUERY_STRING"))
				if not instr(cururl,"login_check.asp")>0 then
					if isempty(session("JCP_AdminPurvUrls")) then
						JCP_Logout
					else
						if Cint(session("JCP_AdminPurvUrls")(0))>0 then
							for urlii=1 to ubound(session("JCP_AdminPurvUrls"))
								if instr(cururl,replace(session("JCP_AdminPurvUrls")(urlii),"../",lcase(ManageFolder) & "/"))>0 then checkpass=true
							next
						end if
					end if
					if not checkpass then
						if instr(cururl,lcase(ManageFolder) & "/jcp_win")>0 then
							ErrStr="您无权访问 " & Version & " " & SiteName & " " & CopyRight
							ErrOpen("exit")
						else
							ErrStr="您无权访问 " & Version & " " & SiteName & " " & CopyRight
							ErrOpen("stop")
						end if
					end if
				end if
			end if
		End Sub

		private sub Object_Check()
			if not IsObjInstalled("scripting.filesystemobject") then ErrStr="对不起，您的服务器不支持FSO功能！":ErrOpen("exit")
			if not IsObjInstalled("ADODB.Connection") then ErrStr="对不起，您的服务器不支持ADODB数据库操作功能！":ErrOpen("exit")
			if not IsObjInstalled("Microsoft.XMLDOM") then ErrStr="对不起，您的服务器不支持XML调用功能！":ErrOpen("exit")
			if not (IsObjInstalled("Microsoft.XMLHTTP") or IsObjInstalled("MSXML2.XMLHTTP"))  then ErrStr="对不起，您的服务器不支持XML调用功能！":ErrOpen("exit")
		end sub
		
		public Function ErrOpen(ErrType)
			select case ErrType
				case "exit"
					response.Write "<script language=""javascript"">"
					response.Write "alert('" & ErrStr & "！\n\n系统即将重启 ...');"
					response.Write "top.location='" & ManageUrlRoot & "JCP_Login/Logout.asp';"
					response.Write "</script>"
					response.End()
				case "back"
					response.Write "<script language=""javascript"">"
					response.Write "alert('对不起！\n\n" & ErrStr & "');"
					response.Write "history.back();"
					response.Write "</script>"
					response.End()
				case "stop"
					response.Write "<script language=""javascript"">"
					response.Write "alert('对不起！\n\n" & ErrStr & "');"
					response.Write "</script>"
					response.End()
				case "goon"
					response.Write "<script language=""javascript"">"
					response.Write "alert('" & ErrStr & "');"
					response.Write "</script>"
				case "close"
					response.Write "<script language=""javascript"">"
					response.Write "alert('" & ErrStr & "');"
					response.Write "window.close();"
					response.Write "</script>"
				case else
			end select
			ErrStr=""
		end Function
		
		private Function IsObjInstalled(strClassString)
			On Error Resume Next
			IsObjInstalled = False
			Err = 0
			Dim xTestObj
			Set xTestObj = Server.CreateObject(strClassString)
			If 0 = Err Then IsObjInstalled = True
			Set xTestObj = Nothing
			Err = 0
		End Function

		public function Encode(strs)
			strs=strs&""
			strs=replace(strs,"&","&amp;")
			strs=replace(strs,"<","&lt;")
			strs=replace(strs,">","&gt;")
			strs=replace(strs,"""","&quot;")
			strs=replace(strs," ","&nbsp;")
			strs=replace(strs,"'","&#039;")
			Encode = strs
		End Function
		
		public function UnEncode(strs)
			strs=strs&""
			strs=replace(strs,"&lt;","<")
			strs=replace(strs,"&gt;",">")
			strs=replace(strs,"&quot;","""")
			strs=replace(strs,"&nbsp;"," ")
			strs=replace(strs,"&amp;","&")
			strs=replace(strs,"&#039;","'")
			UnEncode = strs
		End Function
		
		public Function DataTimes
			DataTimes="数据操作：" & Data.DataTimes & "次"
		end Function
		
		public Function PageTime()
			PageEndTime=timer()
			PageTime="执行时间：" & FormatNumber((PageEndTime-PageStartTime)*1000,3,-1) & "毫秒　" & DataTimes
		end Function
		
		public sub Menus_Box()
			response.Write("<div id=""menus""><iframe id=""menus_box"" scrolling=""no"" frameborder=""0"" src=""../JCP_Win/JCP_MenuBox.asp"" ></iframe></div>")
		end sub
		
		public sub Main_Box()
			dim mainbox_url
			if Isnull(session("MainBox_URL")) or session("MainBox_URL")="" then mainbox_url="../JCP_Win/JCP_Main.asp" else mainbox_url=session("MainBox_URL")
			response.Write("<div id=""main""><iframe id=""main_box"" frameborder=""0"" src="""&mainbox_url&""" ></iframe></div>")
			session("MainBox_URL")=""
		end sub
		
		public Function B2S(bstr) 
			dim i,temp,bchr
			If not IsNull(bstr) Then
				for i = 1 to lenb(bstr)
					bchr = midb(bstr,i,1)
					If ascb(bchr) > 127 Then '遇到双字节，得两个字符一起处理
						temp = temp & chr(ascw(midb(bstr, i+1, 1) & bchr))
						i = i+1 
					Else 
						temp = temp & chr(ascb(bchr))
					End If 
				next 
			End If 
			B2S = temp 
		End Function
		
		public Function URLDecode(enStr)
			on error resume next
		  	dim deStr,strSpecial
		  	dim c,i,v
			deStr=""
			strSpecial="!""#$%&'()*+,.-_/:;<=>?@[\]^`{|}~%"
			for i=1 to len(enStr)
			  c=Mid(enStr,i,1)
			  if c="%" then
				v=eval("&h"+Mid(enStr,i+1,2))
				if err>0 then  '存在不能进行十六进制转换的可能,如 %hgc ,其中g不在0-F之间  此处代码需要改进
					err=0
				    deStr=deStr&c
				else
					if inStr(strSpecial,chr(v))>0 then
					  deStr=deStr&chr(v)
					  i=i+2
					else
					  v=eval("&h"+ Mid(enStr,i+1,2) + Mid(enStr,i+4,2))
					  deStr=deStr & chr(v)
					  i=i+5
					end if
				end if
			  else
				if c="+" then
				  deStr=deStr&" "
				else
				  deStr=deStr&c
				end if
			  end if
			next
			URLDecode=deStr
		End function
		
		public Function NumberYn(StrNum)
			if NumberTF(StrNum) then
				if instr(StrNum,".")>0 then
					NumberYn=FormatNumber(StrNum,len(StrNum)-instr(StrNum,"."))
				else
					NumberYn=int(StrNum)
				end if
			else
				NumberYn=false
				ErrStr="对不起，需要的参数必须为数字！"
				ErrOpen("back")
			end if
		end Function
		
		public Function NumberTF(StrNum)
			if isNumeric(StrNum) and len(StrNum)>0 then
				NumberTF=true	'为数字
			else
				NumberTF=false	'非数字
			end if
		end Function
		
		public Function BlankYn(Strs)
			if BlankTF(Strs) then
				BlankYn=Strs
			else
				BlankYn=false
				ErrStr="对不起，字符为空！"
				ErrOpen("back")
			end if
		end Function
		
		public Function BlankTF(Strs)
			dim t_Strs
			t_Strs=trim(Strs&"")
			t_Strs=replace(t_Strs," ","")
			t_Strs=replace(t_Strs,"　","")
			if t_Strs<>"" then
				BlankTF=true	'不为空
			else
				BlankTF=false	'空
			end if
		end Function
		
		public function eWebAmend(sCont,sType)   '修正eWebAmend编辑器内图片地址与JCP系统的误差
			if sType="save" then
				eWebAmend=replace(sCont,"../../"&session("UploadPath"),"../"&session("UploadPath"))
			elseif sType="mod" then
				eWebAmend=replace(sCont,"../"&session("UploadPath"),"../../"&session("UploadPath"))
			end if
		end function
		
		public sub UrlCheck(temp_url)
			if instr(temp_url,"'")>0 or instr(temp_url,";")>0 or instr(temp_url,"""")>0 then
				ErrStr="您访问的地址带有非法字符，请确认！！"
				ErrOpen("back")
			end if
		end sub
		
		public function SafeYn(tempstrs)
			if instr(tempstrs,"'")>0 or instr(tempstrs,";")>0 or instr(tempstrs,"""")>0 then
				SafeYn=false
			else
				SafeYn=true
			end if
		end function
		
		public function MD5(strs)
			dim temp_md5
			set temp_md5=new Class_MD5
			MD5=temp_md5.MD5(strs)
			set temp_md5=nothing
		end function
		
		public function KeyCheck(strs)
			strs=trim(strs&"")
			strs=replace(strs," ",",")
			strs=replace(strs,"　",",")
			strs=replace(strs,"，",",")
			strs=replace(strs,"、",",")
			strs=replace(strs,"|",",")
			KeyCheck=strs
		end function
		
		public function SystemIntroList(updatetype,objecttype,objectcontent,objectother)	'导入插件系统时记录的临时操作记录，以便出错时卸载
			on error resume next
			Data.Exe("insert into JCP_SystemIntroList(updatetype,objecttype,objectcontent,objectother,sessionid) values("&updatetype&","&objecttype&",'"&objectcontent&"','"&objectother&"','"&session.SessionID&"')")
		end function
		
		public function SystemIntroUnInstall(uninstall_systemlogo)	'根据导入插件系统时记录的临时操作记录，卸载加载
			on error resume next
			Err.Clear
			dim unrs
			if uninstall_systemlogo<>"" and not isnull(uninstall_systemlogo) then
				set unrs=Data.Exe("select * from JCP_SystemIntroLog where systemlogo='"&uninstall_systemlogo&"'")
			else
				set unrs=Data.Exe("select * from JCP_SystemIntroList where sessionid='"&session.SessionID&"'")
			end if
			do while not unrs.eof
				select case unrs("objecttype")
					case 0	'table
						if unrs("updatetype")=0 then	'create
							if Data.CheckTable(unrs("objectcontent")) then Data.DelTable unrs("objectcontent")
						elseif unrs("updatetype")=1 then	'delete
						elseif unrs("updatetype")=2 then	'move
						end if
					case 1	'record
						if unrs("updatetype")=0 then	'create
							Data.Exe "delete from " & unrs("objectcontent") & " where " & unrs("objectother")
						elseif unrs("updatetype")=1 then	'delete
						elseif unrs("updatetype")=2 then	'move
						end if
					case 2	'folder
						if unrs("updatetype")=0 then	'create
							if unrs("objectother")="front" then
								fso.FolderD SiteRoot & unrs("objectcontent")
							elseif unrs("objectother")="back" then
								fso.FolderD ManageRoot & unrs("objectcontent")
							end if
						elseif unrs("updatetype")=1 then	'delete
						elseif unrs("updatetype")=2 then	'move
						end if
					case 3	'file
						if unrs("updatetype")=0 then	'create
							if unrs("objectother")="front" then
								fso.FileD SiteRoot & unrs("objectcontent")
							elseif unrs("objectother")="back" then
								fso.FileD ManageRoot & unrs("objectcontent")
							end if
						elseif unrs("updatetype")=1 then	'delete
						elseif unrs("updatetype")=2 then	'move
						end if
				end select
				unrs.movenext
			loop
			unrs.close
			if uninstall_systemlogo<>"" and not isnull(uninstall_systemlogo) then
				if Err.Number=0 then Data.Exe "delete from JCP_SystemIntroLog where systemlogo='"&uninstall_systemlogo&"'"
			else
				if Err.Number=0 then Data.Exe "delete from JCP_SystemIntroList where sessionid='"&session.SessionID&"'"
			end if
			If Err.Number <> 0 Then
				ErrStr = Err.Description
				SystemIntroUnInstall = False
			Else
				SystemIntroUnInstall = True
			End If
		end function

		public Function getIP() 
			Dim strIPAddr 
			If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" OR InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then 
				strIPAddr = Request.ServerVariables("REMOTE_ADDR") 
			ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then 
				strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1) 
			ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then 
				strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1) 
			Else 
				strIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
			End If 
			getIP = Trim(Mid(strIPAddr, 1, 30)) 
		End Function 
		
		public function SameSystemInfo()
			dim forePath
			forePath=server.mapPath("../../" & CurrentManagePath)
			if fso.FolderE(forePath) then
				fso.FileN forePath & "/SameConfig.asp","<" & "%" & vbcrlf _
																& "'基本设置" & vbcrlf _
																& "const SameManageFolder=""" & ManageFolder & """" & vbcrlf _
																& "const SameManagePath=""" & CurrentManagePath & """" & vbcrlf _
																& "%" & ">"
			end if
		end function
		
		public Function ClearHtml(strs)
			Dim re
			Set re = New RegExp
			re.Pattern = "<[^>]+>"
			re.Global = True
			re.IgnoreCase = True
			re.MultiLine = True
			ClearHtml = re.Replace(strs,"")
		end Function
	
	end Class
%>
<!--#include file="Class_JCP_File.asp" -->
<!--#include file="Class_JCP_DataControl.asp" -->
<!--#include file="Class_JCP_Template.asp" -->
<!--#include file="Class_JCP_ShowPage.asp" -->
<!--#include file="Class_JCP_MD5.asp" -->
<!--#include file="Class_JCP_FileUpload.asp" -->
