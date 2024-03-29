<% 
	Option Explicit
	
	Response.CacheControl = "no-cache"
	Response.Expires = -1
	
%>
<!--#include file="../../../JCP_Inc/Class_JCP.asp" -->
<% 
	dim J
	set J=new JCP
	J.open ""

'######################################
' eWebEditor v3.60 - Advanced online web based WYSIWYG HTML editor.
' Copyright (c) 2003-2006 eWebSoft.com
'
' For further information go to http://www.ewebsoft.com/
' This copyright notice MUST stay intact for use.
'######################################
%>
<!--#include file="upfileclass.asp"-->

<%
Server.ScriptTimeOut = 1800

Dim aStyle(1),JCP_UploadPath
J.fso.FolderN server.MapPath("../../../"&session("UploadPath"))
J.fso.FolderN server.MapPath("../../../"&session("UploadPath")&"/"&date())
JCP_UploadPath="../../"&session("UploadPath")&"/"&date()&"/"
aStyle(1) = "coolblue|||blue|||coolblue|||"&JCP_UploadPath&"|||550|||350|||rar|zip|exe|doc|xls|chm|hlp|||swf|||gif|jpg|jpeg|bmp|||rm|mp3|wav|mid|midi|ra|avi|mpg|mpeg|asf|asx|wma|mov|||gif|jpg|jpeg|bmp|||10000|||10000|||10000|||10000|||10000|||1|||1|||EDIT|||1|||0|||0|||||||||1|||0|||COOL界面，蓝色主调，标准风格，部分常用按钮，标准适合界面宽度，默认样式|||1|||zh-cn|||0|||500|||300|||0|||版权所有...|||000000|||12|||宋体||||||0|||jpg|jpeg|||300|||FFFFFF|||1"

Dim aToolbar(3)
aToolbar(1) = "1|||TBHandle|FormatBlock|FontName|FontSize|ZoomSelect|Bold|Italic|UnderLine|StrikeThrough|SuperScript|SubScript|TBSep|JustifyLeft|JustifyCenter|JustifyRight|JustifyFull|||格式工具栏|||1"
aToolbar(2) = "1|||TBHandle|Cut|Copy|Paste|PasteText|PasteWord|FindReplace|Delete|RemoveFormat|TBSep|UnDo|ReDo|SelectAll|UnSelect|TBSep|OrderedList|UnOrderedList|Indent|Outdent|Paragraph|TBSep|ForeColor|BgColor|BackColor|BackImage|TBSep|absolutePosition|zIndexForward|zIndexBackward|||常用工具栏|||2"
aToolbar(3) = "1|||TBHandle|Image|Flash|Media|File|TBSep|TableMenu|FormMenu|ShowBorders|TBSep|Fieldset|HorizontalRule|Marquee|CreateLink|Anchor|Map|Unlink|TBSep|Symbol|Emot|NowDate|NowTime|Quote|Code|Page|RemoteUpload|TBSep|Maximize|About|||高级工具栏|||3"


Dim sType, sStyleName
Dim sAllowExt, nAllowSize, sUploadDir, nUploadObject, nAutoDir, sBaseUrl, sContentPath
Dim sFileExt, sOriginalFileName, sSaveFileName, sPathFileName, nFileNum

Call InitUpload()

Dim sAction
sAction = UCase(Trim(Request.QueryString("action")))

Select Case sAction
Case "REMOTE"
	Call DoRemote()
Case "SAVE"
	Call ShowForm()
	Call DoSave()
Case Else
	Call ShowForm()
End Select


Sub ShowForm()
%>
<HTML>
<HEAD>
<TITLE>eWebEditor</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript" src="../dialog/dialog.js"></script>
<link href='../dialog/dialog.css' type='text/css' rel='stylesheet'>
</head>
<body class=upload>

<form action="?action=save&type=<%=sType%>&style=<%=sStyleName%>" method=post name=myform enctype="multipart/form-data">
<input type=file name=uploadfile size=1 style="width:100%" onchange="originalfile.value=this.value">
<input type=hidden name=originalfile value="">
</form>

<script language=javascript>

var sAllowExt = "<%=sAllowExt%>";

function CheckUploadForm() {
	if (!IsExt(document.myform.uploadfile.value,sAllowExt)){
		parent.UploadError('lang["ErrUploadInvalidExt"]+":'+sAllowExt+'"');
		return false;
	}
	return true
}

var oForm = document.myform ;
oForm.attachEvent("onsubmit", CheckUploadForm) ;
if (! oForm.submitUpload) oForm.submitUpload = new Array() ;
oForm.submitUpload[oForm.submitUpload.length] = CheckUploadForm ;
if (! oForm.originalSubmit) {
	oForm.originalSubmit = oForm.submit ;
	oForm.submit = function() {
		if (this.submitUpload) {
			for (var i = 0 ; i < this.submitUpload.length ; i++) {
				this.submitUpload[i]() ;
			}
		}
		this.originalSubmit() ;
	}
}

try {
	parent.UploadLoaded();
}
catch(e){
}

</script>

</body>
</html>
<% 
End Sub 


Sub DoSave()
	Call DoUpload_Class()
	
	sPathFileName = JCP_UploadPath & sSaveFileName
	Call OutScript("parent.UploadSaved('" & sPathFileName & "','');var obj=parent.dialogArguments.dialogArguments;if (!obj) obj=parent.dialogArguments;try{obj.addUploadFile('" & sOriginalFileName & "', '" & sSaveFileName & "', '" & sPathFileName & "');} catch(e){} ")
End Sub

Sub DoRemote()
	Dim sContent, i
	For i = 1 To Request.Form("eWebEditor_UploadText").Count 
		sContent = sContent & Request.Form("eWebEditor_UploadText")(i) 
	Next
	If sAllowExt <> "" Then
		sContent = ReplaceRemoteUrl(sContent, sAllowExt)
	End If

	Response.Write "<HTML><HEAD><meta http-equiv='Content-Type' content='text/html; charset=gb2312'><TITLE>eWebEditor</TITLE></head><body>" & _
		"<input type=hidden id=UploadText value=""" & inHTML(sContent) & """>" & _
		"</body></html>"

	Call OutScriptNoBack("parent.setHTML(UploadText.value);try{parent.addUploadFile('" & sOriginalFileName & "', '" & sSaveFileName & "', '" & sPathFileName & "');} catch(e){} parent.remoteUploadOK();")

End Sub

Sub DoUpload_Class()
	On Error Resume Next
	Dim oUpload, oFile
	Set oUpload = New upfile_class

	oUpload.GetData nAllowSize*1024

	If oUpload.Err > 0 Then
		Select Case oUpload.Err
		Case 1
			Call OutScript("parent.UploadError('lang[""ErrUploadInvalidFile""]')")
		Case 2
			Call OutScript("parent.UploadError('lang[""ErrUploadSizeLimit""]+"":" & nAllowSize & "KB""')")
		End Select
	End If

	Set oFile = oUpload.File("uploadfile")
	sFileExt = LCase(oFile.FileExt)
	Call CheckValidExt(sFileExt)
	sOriginalFileName = oFile.FileName
	sSaveFileName = GetRndFileName(sFileExt)

	Dim str_Mappath
	str_Mappath = Server.Mappath(sUploadDir & sSaveFileName)
	sFileExt = LCase(Mid(str_Mappath, InstrRev(str_Mappath, ".") + 1))
	Call CheckValidExt(sFileExt)

	oFile.SaveToFile str_Mappath
	
	Set oFile = Nothing
	Set oUpload = Nothing
End Sub

Function GetRndFileName(sExt)
	Dim sRnd
	Randomize
	sRnd = Int(900 * Rnd) + 100
	GetRndFileName = FormatTime(Now(), 5) & sRnd & "." & sExt
End Function

Sub OutScript(str)
	Response.Write "<script language=javascript>" & str & ";history.back()</script>"
	Response.End
End Sub
Sub OutScriptNoBack(str)
	Response.Write "<script language=javascript>" & str & "</script>"
End Sub

Sub CheckValidExt(sExt)
	Dim b, i, aExt
	b = False
	aExt = Split(sAllowExt, "|")
	For i = 0 To UBound(aExt)
		If LCase(aExt(i)) = sExt Then
			b = True
			Exit For
		End If
	Next
	If b = False Then
		Call OutScript("parent.UploadError('lang[""ErrUploadInvalidExt""]+"":" & sAllowExt & """')")
	End If
End Sub

Sub InitUpload()
	sType = UCase(Trim(Request.QueryString("type")))
	sStyleName = Trim(Request.QueryString("style"))

	Dim i, aStyleConfig, bValidStyle
	bValidStyle = False
	For i = 1 To Ubound(aStyle)
		aStyleConfig = Split(aStyle(i), "|||")
		If Lcase(sStyleName) = Lcase(aStyleConfig(0)) Then
			bValidStyle = True
			Exit For
		End If
	Next

	If bValidStyle = False Then
		OutScript("parent.UploadError('lang[""ErrInvalidStyle""]')")
	End If

	sBaseUrl = aStyleConfig(19)
	nUploadObject = Clng(aStyleConfig(20))
	nAutoDir = CLng(aStyleConfig(21))
	
	If session("channel_path") <> "" Then
		sUploadDir = session("channel_path")
	Else
		sUploadDir = aStyleConfig(3)
	End If
	If Left(sUploadDir, 1) <> "/" Then
		sUploadDir = "../" & sUploadDir
	End If

	Select Case sBaseUrl
	Case "0"
		sContentPath = aStyleConfig(23)
	Case "1"
		sContentPath = RelativePath2RootPath(sUploadDir)
	Case "2"
		sContentPath = RootPath2DomainPath(RelativePath2RootPath(sUploadDir))
	End Select

	Select Case sType
	Case "REMOTE"
		sAllowExt = aStyleConfig(10)
		nAllowSize = Clng(aStyleConfig(15))
	Case "FILE"
		sAllowExt = aStyleConfig(6)
		nAllowSize = Clng(aStyleConfig(11))
	Case "MEDIA"
		sAllowExt = aStyleConfig(9)
		nAllowSize = Clng(aStyleConfig(14))
	Case "FLASH"
		sAllowExt = aStyleConfig(7)
		nAllowSize = Clng(aStyleConfig(12))
	Case Else
		sAllowExt = aStyleConfig(8)
		nAllowSize = Clng(aStyleConfig(13))
	End Select

End Sub

Function RelativePath2RootPath(url)
	Dim sTempUrl
	sTempUrl = url
	If Left(sTempUrl, 1) = "/" Then
		RelativePath2RootPath = sTempUrl
		Exit Function
	End If

	Dim sWebEditorPath
	sWebEditorPath = Request.ServerVariables("SCRIPT_NAME")
	sWebEditorPath = Left(sWebEditorPath, InstrRev(sWebEditorPath, "/") - 1)
	Do While Left(sTempUrl, 3) = "../"
		sTempUrl = Mid(sTempUrl, 4)
		sWebEditorPath = Left(sWebEditorPath, InstrRev(sWebEditorPath, "/") - 1)
	Loop
	RelativePath2RootPath = sWebEditorPath & "/" & sTempUrl
End Function

Function RootPath2DomainPath(url)
	Dim sHost, sPort
	sHost = Split(Request.ServerVariables("SERVER_PROTOCOL"), "/")(0) & "://" & Request.ServerVariables("HTTP_HOST")
	sPort = Request.ServerVariables("SERVER_PORT")
	If sPort <> "80" Then
		sHost = sHost & ":" & sPort
	End If
	RootPath2DomainPath = sHost & url
End Function

Function ReplaceRemoteUrl(sHTML, sExt)
	Dim s_Content
	s_Content = sHTML
	If IsObjInstalled("Microsoft.XMLHTTP") = False then
		ReplaceRemoteUrl = s_Content
		Exit Function
	End If
	
	Dim re, RemoteFile, RemoteFileurl, SaveFileName, SaveFileType
	Set re = new RegExp
	re.IgnoreCase  = True
	re.Global = True
	re.Pattern = "((http|https|ftp|rtsp|mms):(\/\/|\\\\){1}(([A-Za-z0-9_-])+[.]){1,}(net|com|cn|org|cc|tv|[0-9]{1,3})([^ \f\n\r\t\v\""\'\>]*\/)(([^ \f\n\r\t\v\""\'\>])+[.]{1}(" & sExt & ")))"

	Set RemoteFile = re.Execute(s_Content)
	Dim a_RemoteUrl(), n, i, bRepeat
	n = 0
	' to no repeat array
	For Each RemoteFileurl in RemoteFile
		If n = 0 Then
			n = n + 1
			Redim a_RemoteUrl(n)
			a_RemoteUrl(n) = RemoteFileurl
		Else
			bRepeat = False
			For i = 1 To UBound(a_RemoteUrl)
				If UCase(RemoteFileurl) = UCase(a_RemoteUrl(i)) Then
					bRepeat = True
					Exit For
				End If
			Next
			If bRepeat = False Then
				n = n + 1
				Redim Preserve a_RemoteUrl(n)
				a_RemoteUrl(n) = RemoteFileurl
			End If
		End If		
	Next
	' start replace
	nFileNum = 0
	For i = 1 To n
		SaveFileType = Mid(a_RemoteUrl(i), InstrRev(a_RemoteUrl(i), ".") + 1)
		SaveFileName = GetRndFileName(SaveFileType)
		If SaveRemoteFile(SaveFileName, a_RemoteUrl(i)) = True Then
			nFileNum = nFileNum + 1
			If nFileNum > 0 Then
				sOriginalFileName = sOriginalFileName & "|"
				sSaveFileName = sSaveFileName & "|"
				sPathFileName = sPathFileName & "|"
			End If
			sOriginalFileName = sOriginalFileName & Mid(a_RemoteUrl(i), InstrRev(a_RemoteUrl(i), "/") + 1)
			sSaveFileName = sSaveFileName & SaveFileName
			sPathFileName = sPathFileName & sContentPath & SaveFileName
			s_Content = Replace(s_Content, a_RemoteUrl(i), sContentPath & SaveFileName, 1, -1, 1)
		End If
	Next

	ReplaceRemoteUrl = s_Content
End Function

Function SaveRemoteFile(s_LocalFileName, s_RemoteFileUrl)
	Dim Ads, Retrieval, GetRemoteData
	Dim bError
	bError = False
	SaveRemoteFile = False
	On Error Resume Next
	Set Retrieval = Server.CreateObject("Microsoft.XMLHTTP")
	With Retrieval
		.Open "Get", s_RemoteFileUrl, False, "", ""
		.Send
		GetRemoteData = .ResponseBody
	End With
	Set Retrieval = Nothing

	If LenB(GetRemoteData) > nAllowSize*1024 Then
		bError = True
	Else
		Set Ads = Server.CreateObject("Adod" & "b.S" & "tream")
		With Ads
			.Type = 1
			.Open
			.Write GetRemoteData
			.SaveToFile Server.MapPath(sUploadDir & s_LocalFileName), 2
			.Cancel()
			.Close()
		End With
		Set Ads=nothing
	End If

	If Err.Number = 0 And bError = False Then
		SaveRemoteFile = True
	Else
		Err.Clear
	End If
End Function

Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function

Function inHTML(str)
	Dim sTemp
	sTemp = str
	inHTML = ""
	If IsNull(sTemp) = True Then
		Exit Function
	End If
	sTemp = Replace(sTemp, "&", "&amp;")
	sTemp = Replace(sTemp, "<", "&lt;")
	sTemp = Replace(sTemp, ">", "&gt;")
	sTemp = Replace(sTemp, Chr(34), "&quot;")
	inHTML = sTemp
End Function

Function FormatTime(s_Time, n_Flag)
	Dim y, m, d, h, mi, s
	FormatTime = ""
	If IsDate(s_Time) = False Then Exit Function
	y = cstr(year(s_Time))
	m = cstr(month(s_Time))
	If len(m) = 1 Then m = "0" & m
	d = cstr(day(s_Time))
	If len(d) = 1 Then d = "0" & d
	h = cstr(hour(s_Time))
	If len(h) = 1 Then h = "0" & h
	mi = cstr(minute(s_Time))
	If len(mi) = 1 Then mi = "0" & mi
	s = cstr(second(s_Time))
	If len(s) = 1 Then s = "0" & s
	Select Case n_Flag
	Case 1
		FormatTime = y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s
	Case 2
		FormatTime = y & "-" & m & "-" & d
	Case 3
		FormatTime = h & ":" & mi & ":" & s
	Case 4
		FormatTime = y & m & d
	Case 5
		FormatTime = y & m & d & h & mi & s
	End Select
End Function
%>