<%
class FileClass

	'说明：
	'传参：
	'返回：
	private ofile

	'说明：类被创建时，自动调用
	'传参：无
	'返回：无
	private sub Class_Initialize()
		set ofile = server.CreateObject("scripting.filesystemobject")
	end sub
	
	'说明：类被注销时，自动调用
	'传参：无
	'返回：无
	private sub Class_Terminate()
		Set ofile = Nothing
	end sub
	
	''''''''''''''''''对象访问''''''''''''''''''
	
	'说明：获取一个文件对象
	'传参：path－文件绝对路径
	'返回：文件对象
	public function File(path)
		set File=ofile.GetFile(path)
	end function
	'用途：属性访问
	'　　　Attributes       设置或返回指定文件的属性。 
	'　　　DateCreated      返回指定文件创建的日期和时间。 
	'　　　DateLastAccessed 返回指定文件最后被访问的日期和时间。 
	'　　　DateLastModified 返回指定文件最后被修改的日期和时间。 
	'　　　Drive            返回指定文件或文件夹所在的驱动器的驱动器字母。 
	'　　　Name             设置或返回指定文件的名称。 
	'　　　ParentFolder     返回指定文件或文件夹的父文件夹对象。 
	'　　　Path             返回指定文件的路径。 
	'　　　ShortName        返回指定文件的短名称（8.3 命名约定）。 
	'　　　ShortPath        返回指定文件的短路径（8.3 命名约定）。 
	'　　　Size             返回指定文件的尺寸（字节）。 
	'　　　Type             返回指定文件的类型。 
	'用途：方法 
	'　　　Copy 把指定文件从一个位置拷贝到另一个位置。 
	'　　　Delete 删除指定文件。 
	'　　　Move 把指定文件从一个位置移动到另一个位置。 
	'　　　OpenAsTextStream 打开指定文件，并返回一个 TextStream 对象以便访问此文件。 
	
	'说明：获取文件数据流对象
	'传参：path－文件绝对路径
	'　　　mode－1(for read) 2(for write) 8(for append)
	'　　　format－0(以ASCII打开) -1(以UniCode打开) -2(系统默认)
	'返回：数据流对象
	'备注：数据流用完后，记得用.close关闭
	public function TextStream(path,mode,format)
		dim ifile
		ifile=File(path)
		set File=ifile.OpenAsTextStream(mode,format)
	end function
	'用途：属性访问
	'　　　AtEndOfLine 在 TextStream 文件中，如果文件指针正好位于行尾标记的前面，那么该属性值返回 True；否则返回 False。 
	'　　　AtEndOfStream 如果文件指针在 TextStream 文件末尾，则该属性值返回 True；否则返回 False。 
	'　　　Column 返回 TextStream 文件中当前字符位置的列号。 
	'　　　Line 返回 TextStream 文件中的当前行号。 
	'用途：方法
	'　　　Close 关闭一个打开的 TextStream 文件。 
	'　　　Read 从一个 TextStream 文件中读取指定数量的字符并返回结果（得到的字符串）。 
	'　　　ReadAll 读取整个 TextStream 文件并返回结果。 
	'　　　ReadLine 从一个 TextStream 文件读取一整行（到换行符但不包括换行符）并返回结果。 
	'　　　Skip 当读一个 TextStream 文件时跳过指定数量的字符。 
	'　　　SkipLine 当读一个 TextStream 文件时跳过下一行。 
	'　　　Write 写一段指定的文本（字符串）到一个 TextStream 文件。 
	'　　　WriteLine 写入一段指定的文本（字符串）和换行符到一个 TextStream 文件中。 
	'　　　WriteBlankLines 写入指定数量的换行符到一个 TextStream 文件中。 

	''''''''''''''''''方法封装''''''''''''''''''
	
	'说明：判断某一文件是否存在
	'传参：path－文件的绝对路径
	'返回：T/F
	public function Exist(path)
		Exist = ofile.FileExists(path)
	end function
	
	'说明：创建一个新文件，文本方式
	'传参：path－新文件的绝对路径
	'　　　content－新文件的内容
	'返回：无
	public sub Create(path)
		dim newfile
		set newfile=ofile.CreateTextFile(path,true)
		newfile.close		
	end sub

	'说明：创建一个新的临时随机文件
	'传参：path－文件存放的绝对路径
	'返回：新文件的绝对路径
	public function Temp(path)
		dim tname,ifolder,ifile
		tname=ofile.GetTempName()
		set ifolder=ofile.GetFolder(path)
		set ifile=ifolder.CreateTextFile(tname)
		Temp=ifile.path
		set ifolder=nothing
		set ifile=nothing
	end function

	'说明：记取一个文件，文本方式
	'传参：path－文件绝对路径
	'返回：字符串
	public function Read(path)
		dim fs
		set fs=ofile.OpenTextFile(path,1)
		Read=fs.ReadAll()
		fs.close
	end function

	'说明：在一个文件中，重新写入内容
	'传参：path－文件绝对路径
	'　　　content－要写入的内容
	'返回：无
	public sub Write(path,content)
		dim fs
		set fs=ofile.OpenTextFile(path,2)
		fs.write content
		fs.close		
	end sub

	'说明：在一个文件中，追加内容
	'传参：path－文件绝对路径，content－要追加的内容
	'返回：无
	public sub Append(path,content)
		dim fs
		set fs=ofile.OpenTextFile(path,8)
		fs.write content
		fs.close		
	end sub

	'说明：删除一个文件，包括只读文件
	'传参：path－文件绝对路径
	'返回：无
	public sub Delete(path)
		ofile.DeleteFile path,True	
	end sub

	'说明：复制文件
	'传参：oldpath－源文件绝对路径
	'　　　newpath－新文件绝对路径
	'　　　overwrite－是否覆盖，T/F
	'返回：无
	public sub Copy(oldpath,newpath,overwrite)
		ofile.CopyFile oldpath,newpath,overwrite
	end sub

	'说明：移动文件
	'传参：oldpath－源文件绝对路径
	'　　　newpath－目标文件夹
	'返回：无
	public sub Move(oldpath,newpath)
		ofile.MoveFile oldpath,newpath
	end sub

	'说明：获取文件路径对应的文件名称
	'传参：path－文件绝对路径
	'返回：字符串
	public function Name(path)
		Name=ofile.GetFileName(path)
	end function

	'说明：修改文件的名字
	'传参：path－源文件绝对路径
	'　　　newname－新的名称
	'返回：无
	public sub ReName(path,newname)
		dim ifile
		set ifile=File(path)
		ifile.name=newname
		set ifile=nothing
	end sub

	'说明：获取文件的扩展名
	'传参：path－文件绝对路径
	'返回：字符串
	public function Ext(path)
		Ext=ofile.GetExtensionName(path)
	end function

	'说明：以某编码格式读取文本文件
	'传参：path－源文件绝对路径
	'　　　codeset－读取编码，如UTF-8
	'返回：带编码格式字符串
	public function ReadByCode(path,codeset)
		dim stm
		set stm=server.CreateObject("adodb.stream")
		stm.Type=2 '以本模式读取
		stm.mode=3 
		stm.charset=codeset
		stm.open
		stm.loadfromfile path
		ReadByCode=stm.readtext
		stm.Close
		set stm=nothing
	end function

	'说明：以某编码格式写入文本文件
	'传参：path－目标文件的绝对路径
	'　　　content－要写入的内容
	'　　　codeset－写入时编码，如UTF-8
	'返回：无
	public sub WriteByCode(path,content,codeset)
		dim stm
		set stm=server.CreateObject("adodb.stream")
		stm.Type=2 '以本模式读取
		stm.mode=3
		stm.charset=codeset
		stm.open
		stm.WriteText content
		stm.SaveToFile path,2    
		stm.flush
		stm.Close
		set stm=nothing
	end sub	

	'说明：加载XML数据流
	'传参：xmlstrs－XML数据流
	'返回：XMLDOM对象
	public function Xml(xmlstrs)
		dim dom
		set dom = Server.CreateObject("Microsoft.XMLDOM")
		dom.async = false
		dom.loadXML(xmlstrs)
		Xml=dom
		set dom=nothing
	end function

	'说明：封装XML数据流
	'传参：xmlstrs－XML数据主体
	'　　　codeset－XML编码（如UTF-8）
	'返回：XML数据流字符串
	public function XmlSteam(xmlstrs,codeset)
		XmlSteam="<?xml version=""1.0"" encoding=""" & codeset & """?>" & vbcrlf & _
			 	 "<root>" & vbcrlf & _
			 	  xmlstrs & vbcrlf & _
			 	 "</root>"
	end function
	
end class
%>
