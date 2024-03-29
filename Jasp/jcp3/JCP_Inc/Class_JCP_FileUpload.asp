<%
Class UpLoadClass

	Private p_MaxSize,p_FileType,p_SavePath,p_AutoSave,p_Error
	Private objForm,binForm,binItem,strDate,lngTime
	Public	FormItem,FileItem

	Public Property Get Version
		Version="Rumor UpLoadClass Version 2.0"
	End Property

	Public Property Get Error
		Error=p_Error
	End Property

	Public Property Get MaxSize
		MaxSize=p_MaxSize
	End Property
	Public Property Let MaxSize(lngSize)
		if isNumeric(lngSize) then
			p_MaxSize=clng(lngSize)
		end if
	End Property

	Public Property Get FileType
		FileType=p_FileType
	End Property
	Public Property Let FileType(strType)
		p_FileType=strType
	End Property

	Public Property Get SavePath
		SavePath=p_SavePath
	End Property
	Public Property Let SavePath(strPath)
		p_SavePath=replace(strPath,chr(0),"")
	End Property

	Public Property Get AutoSave
		AutoSave=p_AutoSave
	End Property
	Public Property Let AutoSave(byVal Flag)
		select case Flag
			case 0:
			case 1:
			case 2:
			case false:Flag=2
			case else:Flag=0
		end select
		p_AutoSave=Flag
	End Property

	Private Sub Class_Initialize
		p_Error	   = -1
		p_MaxSize  = 10240000
		p_FileType = "*"
		p_SavePath = "/"
		p_AutoSave = 0
		strDate	   = replace(cstr(Date()),"-","")
		lngTime	   = clng(timer()*1000)
		Set binForm = Server.CreateObject("ADODB.Stream")
		Set binItem = Server.CreateObject("ADODB.Stream")
		Set objForm = Server.CreateObject("Scripting.Dictionary")
		objForm.CompareMode = 1
	End Sub

	Private Sub Class_Terminate
		objForm.RemoveAll
		Set objForm = nothing
		Set binItem = nothing
		Set binForm = nothing
	End Sub

	Public Sub Open()
		if p_Error=-1 then
			p_Error=0
		else
			Exit Sub
		end if
		Dim lngRequestSize,binRequestData,strFormItem,strFileItem
		Const strSplit="'"">"
		lngRequestSize=Request.TotalBytes
		if lngRequestSize<1 then
			p_Error=4
			Exit Sub
		end if
		binRequestData=Request.BinaryRead(lngRequestSize)
		binForm.Type = 1
		binForm.Open
		binForm.Write binRequestData

		Dim bCrLf,strSeparator,intSeparator
		bCrLf=ChrB(13)&ChrB(10)

		intSeparator=InstrB(1,binRequestData,bCrLf)-1
		strSeparator=LeftB(binRequestData,intSeparator)

		Dim p_start,p_end,strItem,strInam,intTemp,strTemp
		Dim strFtyp,strFnam,strFext,lngFsiz
		p_start=intSeparator+2
		Do
			p_end  =InStrB(p_start,binRequestData,bCrLf&bCrLf)+3
			binItem.Type=1
			binItem.Open
			binForm.Position=p_start
			binForm.CopyTo binItem,p_end-p_start
			binItem.Position=0
			binItem.Type=2
			binItem.Charset="gb2312"
			strItem=binItem.ReadText
			binItem.Close()

			p_start=p_end
			p_end  =InStrB(p_start,binRequestData,strSeparator)-1
			binItem.Type=1
			binItem.Open
			binForm.Position=p_start
			lngFsiz=p_end-p_start-2
			binForm.CopyTo binItem,lngFsiz

			intTemp=Instr(39,strItem,"""")
			strInam=Mid(strItem,39,intTemp-39)

			if Instr(intTemp,strItem,"filename=""")<>0 then
			if not objForm.Exists(strInam&"_From") then
				strFileItem=strFileItem&strSplit&strInam
				if binItem.Size<>0 then
					intTemp=intTemp+13
					strFtyp=Mid(strItem,Instr(intTemp,strItem,"Content-Type: ")+14)
					strTemp=Mid(strItem,intTemp,Instr(intTemp,strItem,"""")-intTemp)
					intTemp=InstrRev(strTemp,"\")
					strFnam=Mid(strTemp,intTemp+1)
					objForm.Add strInam&"_Type",strFtyp
					objForm.Add strInam&"_Name",strFnam
					objForm.Add strInam&"_Path",Left(strTemp,intTemp)
					objForm.Add strInam&"_Size",lngFsiz
					if Instr(intTemp,strTemp,".")<>0 then
						strFext=Mid(strTemp,InstrRev(strTemp,".")+1)
					else
						strFext=""
					end if
					if left(strFtyp,6)="image/" then
						binItem.Position=0
						binItem.Type=1
						strTemp=binItem.read(10)
						if strcomp(strTemp,chrb(255) & chrb(216) & chrb(255) & chrb(224) & chrb(0) & chrb(16) & chrb(74) & chrb(70) & chrb(73) & chrb(70),0)=0 then
							if Lcase(strFext)<>"jpg" then strFext="jpg"
							binItem.Position=3
							do while not binItem.EOS
								do
									intTemp = ascb(binItem.Read(1))
								loop while intTemp = 255 and not binItem.EOS
								if intTemp < 192 or intTemp > 195 then
									binItem.read(Bin2Val(binItem.Read(2))-2)
								else
									Exit do
								end if
								do
									intTemp = ascb(binItem.Read(1))
								loop while intTemp < 255 and not binItem.EOS
							loop
							binItem.Read(3)
							objForm.Add strInam&"_Height",Bin2Val(binItem.Read(2))
							objForm.Add strInam&"_Width",Bin2Val(binItem.Read(2))
						elseif strcomp(leftB(strTemp,8),chrb(137) & chrb(80) & chrb(78) & chrb(71) & chrb(13) & chrb(10) & chrb(26) & chrb(10),0)=0 then
							if Lcase(strFext)<>"png" then strFext="png"
							binItem.Position=18
							objForm.Add strInam&"_Width",Bin2Val(binItem.Read(2))
							binItem.Read(2)
							objForm.Add strInam&"_Height",Bin2Val(binItem.Read(2))
						elseif strcomp(leftB(strTemp,6),chrb(71) & chrb(73) & chrb(70) & chrb(56) & chrb(57) & chrb(97),0)=0 or strcomp(leftB(strTemp,6),chrb(71) & chrb(73) & chrb(70) & chrb(56) & chrb(55) & chrb(97),0)=0 then
							if Lcase(strFext)<>"gif" then strFext="gif"
							binItem.Position=6
							objForm.Add strInam&"_Width",BinVal2(binItem.Read(2))
							objForm.Add strInam&"_Height",BinVal2(binItem.Read(2))
						elseif strcomp(leftB(strTemp,2),chrb(66) & chrb(77),0)=0 then
							if Lcase(strFext)<>"bmp" then strFext="bmp"
							binItem.Position=18
							objForm.Add strInam&"_Width",BinVal2(binItem.Read(4))
							objForm.Add strInam&"_Height",BinVal2(binItem.Read(4))
						end if
					end if
					objForm.Add strInam&"_Ext",strFext
					objForm.Add strInam&"_From",p_start
					intTemp=GetFerr(lngFsiz,strFext)
					if p_AutoSave<>2 then
						objForm.Add strInam&"_Err",intTemp
						if intTemp=0 then
							if p_AutoSave=0 then
								strFnam=GetTimeStr()
								if strFext<>"" then strFnam=strFnam&"."&strFext
							end if
							binItem.SaveToFile Server.MapPath(p_SavePath&strFnam),2
							objForm.Add strInam,strFnam
						end if
					end if
				else
					objForm.Add strInam&"_Err",-1
				end if
			end if
			else
				binItem.Position=0
				binItem.Type=2
				binItem.Charset="gb2312"
				strTemp=binItem.ReadText
				if objForm.Exists(strInam) then
					objForm(strInam) = objForm(strInam)&","&strTemp
				else
					strFormItem=strFormItem&strSplit&strInam
					objForm.Add strInam,strTemp
				end if
			end if

			binItem.Close()
			p_start = p_end+intSeparator+2
		loop Until p_start+3>lngRequestSize
		FormItem=split(strFormItem,strSplit)
		FileItem=split(strFileItem,strSplit)
	End Sub

	Private Function GetTimeStr()
		lngTime=lngTime+1
		GetTimeStr=strDate&lngTime
	End Function

	Private Function GetFerr(lngFsiz,strFext)
		dim intFerr
		intFerr=0
		if lngFsiz>p_MaxSize and p_MaxSize>0 then
			if p_Error=0 or p_Error=2 then p_Error=p_Error+1
			intFerr=intFerr+1
		end if
		if p_FileType<>"*" then
			if Instr(1,Lcase("/"&p_FileType&"/"),Lcase("/"&strFext&"/"))=0 and p_FileType<>"" then
				if p_Error<2 then p_Error=p_Error+2
				intFerr=intFerr+2
			end if
		end if
		GetFerr=intFerr
	End Function

	Public Function Save(Item,strFnam)
		Save=false
		if objForm.Exists(Item&"_From") then
			dim intFerr,strFext
			strFext=objForm(Item&"_Ext")
			intFerr=GetFerr(objForm(Item&"_Size"),strFext)
			if objForm.Exists(Item&"_Err") then
				if intFerr=0 then
					objForm(Item&"_Err")=0
				end if
			else
				objForm.Add Item&"_Err",intFerr
			end if
			if intFerr<>0 then Exit Function
			if VarType(strFnam)=2 then
				select case strFnam
					case 0:strFnam=GetTimeStr()
						if strFext<>"" then strFnam=strFnam&"."&strFext
					case 1:strFnam=objForm(Item&"_Name")
				end select
			end if
			binItem.Type = 1
			binItem.Open
			binForm.Position = objForm(Item&"_From")
			binForm.CopyTo binItem,objForm(Item&"_Size")
			binItem.SaveToFile Server.MapPath(p_SavePath&strFnam),2
			binItem.Close()
			if objForm.Exists(Item) then
				objForm(Item)=strFnam
			else
				objForm.Add Item,strFnam
			end if
			Save=true
		end if
	End Function

	Public Function GetData(Item)
		GetData=""
		if objForm.Exists(Item&"_From") then
			if GetFerr(objForm(Item&"_Size"),objForm(Item&"_Ext"))<>0 then Exit Function
			binForm.Position = objForm(Item&"_From")
			GetData=binFormStream.Read(objForm(Item&"_Size"))
		end if
	End Function

	Public Function Form(Item)
		if objForm.Exists(Item) then
			Form=objForm(Item)
		else
			Form=""
		end if
	End Function

	Private Function BinVal2(bin)
		dim lngValue,I
		lngValue = 0
		for I = lenb(bin) to 1 step -1
			lngValue = lngValue *256 + ascb(midb(bin,I,1))
		next
		BinVal2=lngValue
	End Function

	Private Function Bin2Val(bin)
		dim lngValue,I
		lngValue = 0
		for I = 1 to lenb(bin)
			lngValue = lngValue *256 + ascb(midb(bin,I,1))
		next
		Bin2Val=lngValue
	End Function

End Class
%>
