<!--#include file="../JCP_Shared/asp_head.asp" -->
<% 
on error resume next
err=0
dim FreshYn:FreshYn=false

if request.QueryString("action")="setsystem" then
	
	if request.Form("datapath")<>session("DataPath") then
		if not J.fso.FolderE(J.ManageRoot & request.Form("datapath")) then
			J.fso.FolderN J.ManageRoot & request.Form("datapath")
			if err>0 then
				J.ErrStr= err.description & "，新的数据库文件夹无法建立!"
				J.ErrOpen("back")
				err=0
			else
				if J.fso.FileE(J.ManageRoot & session("DataPath") & "\" & session("DataName")) then
					if request.Form("dataname")<>session("DataName") then
						J.fso.FileC J.ManageRoot & session("DataPath") & "\" & session("DataName"),J.ManageRoot & request.Form("datapath") & "\" & request.Form("dataname")
					else
						J.fso.FileC J.ManageRoot & session("DataPath") & "\" & session("DataName"),J.ManageRoot & request.Form("datapath") & "\" & session("DataName")
					end if
				end if
				J.fso.FolderD J.ManageRoot & session("DataPath")
				if err>0 then
					J.ErrStr= err.description & " 删除旧数据库文件夹，请手动操作!"
					J.ErrOpen("goon")
					err=0
				end if
			end if
		end if
	else
		if J.fso.FileE(J.ManageRoot & session("DataPath") & "\" & session("DataName")) then
			if request.Form("dataname")<>session("DataName") then
				J.fso.FileC J.ManageRoot & session("DataPath") & "\" & session("DataName"),J.ManageRoot & request.Form("datapath") & "\" & request.Form("dataname")
				J.fso.FileD J.ManageRoot & session("DataPath") & "\" & session("DataName")
				if err>0 then
					J.ErrStr= err.description & " 删除旧数据库文件，请手动操作!"
					J.ErrOpen("goon")
					err=0
				end if
			end if
		end if
	end if
	if request.Form("sitename")<>session("SiteName") or request.Form("siteurl")<>session("SiteURL") or request.Form("sitesystemname")<>session("SiteSystemName") or request.Form("systemlogo")<>session("SystemLogo") or request.Form("mainfont")<>session("Color_MainFont") or request.Form("systemfont")<>session("Color_SystemFont") or request.Form("lightfont")<>session("Color_LightFont") or request.Form("colormain")<>session("Color_Main") or request.Form("colorback")<>session("Color_Back") or request.Form("colordip")<>session("Color_Dip") or request.Form("colorfleet")<>session("Color_Fleet") or request.Form("copyright")<>session("CopyRight") or request.Form("menuwidth")<>session("Menu_Width") or request.Form("topheight")<>session("Top_Height") then FreshYn=true

	J.SiteName   		 = request.Form("sitename")
	J.SiteURL   		 = request.Form("siteurl")
	J.SiteSystemName     = request.Form("sitesystemname")
	J.DataPath   		 = request.Form("datapath")
	J.DataName   		 = request.Form("dataname")
	J.SystemLogo 		 = request.Form("systemlogo")
	J.UploadPath 		 = request.Form("uploadpath")
	J.WebPath    		 = request.Form("webpath")
	J.ScriptPath    	 = request.Form("scriptpath")
	J.WebCssPath 		 = request.Form("webcsspath")
	J.FileExt    		 = request.Form("fileext")
	J.IndexName  		 = request.Form("indexname")
	J.Color_MainFont     = request.Form("mainfont")
	J.Color_SystemFont   = request.Form("systemfont")
	J.Color_LightFont    = request.Form("lightfont")
	J.Color_Main         = request.Form("colormain")
	J.Color_Back         = request.Form("colorback")
	J.Color_Dip          = request.Form("colordip")
	J.Color_Fleet        = request.Form("colorfleet")
	J.CopyRight          = request.Form("copyright")
	J.Top_Height         = request.Form("topheight")
	J.Menu_Width         = request.Form("menuwidth")
	J.DataSource         = J.ManageRoot & J.DataPath & "\" & J.DataName
		
	dim xml,xmlroot,xmlitems
	set xml=server.CreateObject("Microsoft.XMLDOM")
	xml.Async=true
	if J.fso.FileE(J.ManageRoot & session("WebConfig_XML")) then 
		xml.Load(J.ManageRoot & session("WebConfig_XML"))
		set xmlroot = xml.documentElement
		xmlroot.selectSingleNode("JCP_Site_Name").text               = J.SiteName
		xmlroot.selectSingleNode("JCP_Site_URL").text                = J.SiteURL
		xmlroot.selectSingleNode("JCP_Site_System_Name").text        = J.SiteSystemName
		xmlroot.selectSingleNode("JCP_System_Skin").text             = J.SystemSkin
		xmlroot.selectSingleNode("JCP_Database_Path").text           = J.DataPath
		xmlroot.selectSingleNode("JCP_Database_Name").text           = J.DataName
		xmlroot.selectSingleNode("JCP_System_Logo").text             = J.SystemLogo
		xmlroot.selectSingleNode("JCP_UploadPath").text              = J.UploadPath
		xmlroot.selectSingleNode("JCP_WebPath").text                 = J.WebPath
		xmlroot.selectSingleNode("JCP_ScriptPath").text              = J.ScriptPath
		xmlroot.selectSingleNode("JCP_WebCssPath").text              = J.WebCssPath
		xmlroot.selectSingleNode("JCP_HTMLFileExt").text             = J.FileExt
		xmlroot.selectSingleNode("JCP_HTMLFile_Index").text          = J.IndexName
		xmlroot.selectSingleNode("JCP_System_Color_MainFont").text   = J.Color_MainFont
		xmlroot.selectSingleNode("JCP_System_Color_SystemFont").text = J.Color_SystemFont
		xmlroot.selectSingleNode("JCP_System_Color_LightFont").text  = J.Color_LightFont
		xmlroot.selectSingleNode("JCP_System_Color_Main").text       = J.Color_Main
		xmlroot.selectSingleNode("JCP_System_Color_Back").text       = J.Color_Back
		xmlroot.selectSingleNode("JCP_System_Color_Dip").text        = J.Color_Dip
		xmlroot.selectSingleNode("JCP_System_Color_Fleet").text      = J.Color_Fleet
		xmlroot.selectSingleNode("JCP_System_CopyRight").text        = J.CopyRight
		xmlroot.selectSingleNode("JCP_Win_Top_Height").text          = J.Top_Height
		xmlroot.selectSingleNode("JCP_Win_Menu_Width").text          = J.Menu_Width
		
		xml.save(J.ManageRoot & session("WebConfig_XML"))
		J.Session_Load "in"
		set xmlroot=nothing
		
		if FreshYn then
			session("MainBox_URL")="../JCP_System/JCP_SystemSet.asp"
			response.write  "<script language=""javascript"">" & vbcrlf & _
							"	alert('系统配置已保存，系统将重载 ...');" & vbcrlf & _
							"	top.location.reload();" & vbcrlf & _
							"</script>"
		else
			response.write  "<script language=""javascript"">" & vbcrlf & _
							"	alert('系统配置已保存！');" & vbcrlf & _
							"	location='JCP_SystemSet.asp';" & vbcrlf & _
							"</script>"
		end if
	else
		J.ErrStr="对不起，系统无法找到配置文件！"
		J.ErrOpen("back")
	end if
	set xml=nothing
end if
%>
<% J.close %>