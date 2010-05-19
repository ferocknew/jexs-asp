<%
	Class JCP_File

		private fso
		
		public sub open()
			set fso = server.CreateObject("scripting.filesystemobject")
		end sub
		
		public function FileE(filepath)
			if fso.FileExists(filepath) then FileE=true else FileE=false
		end function
		
		public sub FileN(filepath,filecont)                              '新建文件
			on error resume next
			err.clear
			if FolderFill(filepath,"file") then
				dim fcr
				set fcr=fso.CreateTextFile(filepath,true)
				fcr.write filecont
				fcr.close
				set fcr=nothing
			end if
		end sub

		public function FileT(filepath,opentype)                              '读取文件
			on error resume next
			err.clear
			dim fo
			set fo=fso.OpenTextFile(filepath,opentype)					'opentype 1-for read 2-for write 8-for append
			if err>0 then FileT=err.description  
			FileT=fo.ReadAll()
			fo.close
			set fo=nothing
		end function

		public sub FileD(filepath)
			on error resume next
			err.clear
			if FileE(filepath) then fso.DeleteFile filepath,True
		end sub

		public function FileC(oldfile,newfile)
			if fso.FileExists(oldfile) then
				if FolderFill(newfile,"file") then	
					fso.CopyFile oldfile,newfile
					FileC=true
				else
					FileC=false
				end if
			else
				FileC=false
			end if
		end function

		public function FolderE(folderpath)
			if fso.FolderExists(folderpath) then FolderE=true else FolderE=false
		end function
		
		public function FolderN(folderpath)
			On Error Resume Next
			if not FolderE(folderpath) then FolderFill folderpath,"folder" else FolderN=true
			If Err.Number <> 0 Then 
				Err.Clear
				FolderN=err.description
			else
				FolderN=true
			end if
		end function

		public function FolderG(folderpath)
			if fso.FolderExists(folderpath) then set FolderG=fso.GetFolder(folderpath)
		end function

		public function FolderD(folderpath)
			if fso.FolderExists(folderpath) then fso.DeleteFolder folderpath,true
		end function

		public function FolderR(oldfoler,newfolder)
			if fso.FolderExists(oldfoler) then fso.MoveFolder oldfoler,newfolder
		end function

		public function FolderC(oldfoler,newfolder)
			if fso.FolderExists(oldfoler) then fso.CopyFolder oldfoler,newfolder
		end function
		
		public sub close()
			set fso = nothing
		end sub

		private function FolderFill(byval fillpath,pathtype)
			dim pathparam,filli,fillnum,t_path
			fillpath=replace(lcase(fillpath),"/","\")
			t_path=lcase(server.mappath("../../"))
			fillpath=replace(fillpath,t_path,"")
			if instr(fillpath,"\")>0 then
				pathparam=split(fillpath,"\")
				if pathtype="file" then
					fillnum=ubound(pathparam)-1
				elseif pathtype="folder" then
					fillnum=ubound(pathparam)
				end if
				for filli=0 to fillnum
					if pathparam(filli)<>"" then
						t_path=t_path & "\" & pathparam(filli)
						if not FolderE(t_path) then fso.CreateFolder t_path
					end if
				next
			else
				if pathtype="folder" then
					if fillpath<>"" then
						t_path=t_path & "\" & fillpath
						if not FolderE(t_path) then fso.CreateFolder t_path
					end if
				end if				
			end if
			FolderFill=FolderE(t_path)
		end function

	end Class
%>