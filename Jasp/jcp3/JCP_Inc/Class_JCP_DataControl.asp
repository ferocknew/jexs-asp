<%
	Class JCP_DataControl
		public DataTimes,FieldCount,FieldNames
		private Jconn,Jrs,fso
		public JPageConn		'专用于PageClass调用的数据库链接
		
		public function Open(DataSource)
			dim DataLink
			set fso=new JCP_File : fso.open
			if fso.FileE(DataSource) then
				DataLink="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DataSource
				set Jconn=Server.CreateObject("ADODB.Connection")
				Jconn.Open DataLink
				set JPageConn=Server.CreateObject("ADODB.Connection")
				JPageConn.Open DataLink
				set Jrs=Server.CreateObject("ADODB.Recordset")
				Open=true
			else
				Open=false
			end if
			DataTimes=0
		end function
		
		public sub close()
			Jconn.close
			set Jrs=nothing
			set Jconn=nothing
			set fso=nothing
		end sub
		
		public function Exe(sql)
			'response.write sql
			Set Exe=Jconn.execute(sql)
			DataTimes=DataTimes+1
		end function
		
		public function RsOpen(sql,rstype)
			Jrs.open sql,Jconn,1,rstype
			set RsOpen=Jrs
			DataTimes=DataTimes+1
		end function
		
		public function ReRsOpen(sql,rsname,rstype)
			execute("dim "&rsname)
			execute("set "&rsname&"=Server.CreateObject(""ADODB.Recordset"")")
			execute(rsname&".open sql,Jconn,1,rstype")
			execute("set ReRsOpen="&rsname)
			DataTimes=DataTimes+1
		end function
		
		public function GetRows(sql)
			Jrs.open sql,Jconn,1,1
			if not Jrs.eof then GetRows=Jrs.getRows()
			FieldCount=Jrs.fields.count
			if FieldCount>0 then
				dim ti,tName()
				redim tName(FieldCount-1)
				for ti=1 to FieldCount
					tName(ti-1)=Jrs.fields(ti-1).name
				next
				FieldNames=tName
			end if
			Jrs.close
			DataTimes=DataTimes+1
		end function
		
		public function FieldName(id)
			FieldName=tempFieldName(id)
		end function
				
		public sub RsClose()
			Jrs.close
		end sub

		Public Function CheckTable(TableName)
			On Error Resume Next
			Exe "select top 1 * From " & TableName
			If Err.Number <> 0 Then
				Err.Clear()
				CheckTable = False
			Else
				CheckTable = True
			End If
		End Function

		Public Function CreateTable(TableName,FieldList)
			Dim Sql
			Sql = "CREATE TABLE [" & TableName & "]"
			Exe Sql
			If Err.Number <> 0 Then
				Err.Clear()
				CreateTable = False
			Else
				CreateTable = True
			End If
		End Function

		Public Function DelTable(TableName)
			Dim Sql
			Sql = "drop TABLE [" & TableName & "]"
			Exe Sql
			If Err.Number <> 0 Then
				Err.Clear()
				DelTable = False
			Else
				DelTable = True
			End If
		End Function
		
		Public Function AddColumn(TableName,ColumnName,ColumnType,BlankYn)
			On Error Resume Next
			Exe "Alter Table [" & TableName & "] Add [" & ColumnName & "] " & ColumnType & ""
			if BlankYn then
				dim adox,tbl,col
				Set adox = Server.CreateObject("ADOX.Catalog")
				Set adox.ActiveConnection = Jconn
				Set tbl = adox.Tables(TableName)
				set col=tbl.Columns(ColumnName)
				col.Properties("Jet OLEDB:Allow Zero Length") = true '允许空字符串
				set col=nothing
				set tbl=nothing
				Set adox=nothing
			end if
			If Err.Number <> 0 Then
				Err.Clear
				AddColumn = Err.Description
			Else
				AddColumn = True
			End If
		End Function
		
		Public Function DelColumn(TableName,ColumnName)
			On Error Resume Next
			Exe "Alter Table [" & TableName & "] drop [" & ColumnName & "]"
			If Err.Number <> 0 Then 
				response.write Err.Description
				Err.Clear
				DelColumn = False
			Else
				DelColumn = True
			End If
		End Function

	end Class
%>