<%
class FolderClass

	private ofolder

	'说明：类被创建时，自动调用
	'传参：无
	'返回：无
	private sub Class_Initialize()
		set ofolder = server.CreateObject("scripting.filesystemobject")
	end sub
	
	'说明：类被注销时，自动调用
	'传参：无
	'返回：无
	private sub Class_Terminate()
		Set ofolder = Nothing
	end sub
	
	''''''''''''''''''对象访问''''''''''''''''''
	
	'说明：获取一个文件夹对象
	'传参：path－文件夹绝对路径
	'返回：文件夹对象
	public function Folder(path)
		set Folder=ofolder.GetFolder(path)
	end function
	'用途：集合
	'　　　Files            返回指定文件夹中所有文件夹的集合。 
	'　　　SubFolders       返回指定文件夹中所有子文件夹的集合。 
	'用途：属性
	'　　　Attributes       设置或返回指定文件夹的属性。 
	'　　　DateCreated      返回指定文件夹被创建的日期和时间。 
	'　　　DateLastAccessed 返回指定文件夹最后被访问的日期和时间。 
	'　　　DateLastModified 返回指定文件夹最后被修改的日期和时间。 
	'　　　Drive            返回指定文件夹所在的驱动器的驱动器字母。 
	'　　　IsRootFolder     假如文件夹是根文件夹，则返回 ture，否则返回 false。 
	'　　　Name             设置或返回指定文件夹的名称。 
	'　　　ParentFolder     返回指定文件夹的父文件夹。 
	'　　　Path             返回指定文件的路径。 
	'　　　ShortName        返回指定文件夹的短名称。（8.3 命名约定） 
	'　　　ShortPath        返回指定文件夹的短路径。（8.3 命名约定） 
	'　　　Size             返回指定文件夹的大小。 
	'　　　Type             返回指定文件夹的类型。 
	'用途：方法
	'　　　Copy             把指定的文件夹从一个位置拷贝到另一个位置。 
	'　　　Delete           删除指定文件夹。 
	'　　　Move             把指定的文件夹从一个位置移动到另一个位置。 
	'　　　CreateTextFile   在指定的文件夹创建一个新的文本文件，并返回一个 TextStream 对象以访问这个文件。 

	''''''''''''''''''方法封装''''''''''''''''''
	
	'说明：判断某一文件夹是否存在
	'传参：path－文件夹的绝对路径
	'返回：T/F
	public function Exist(path)
		Exist = ofolder.FolderExists(path)
	end function
	
	'说明：创建一个新文件夹
	'传参：path－新文件夹的绝对路径
	'返回：无
	public sub Create(path)
		ofolder.CreateFolder(path)
	end sub

	'说明：创建一个新的临时随机文件夹
	'传参：path－文件夹的父路径
	'返回：新文件夹的绝对路径
	public function Temp(path)
		dim tname,ipath
		tname=ofolder.GetTempName()
		ipath=ofolder.BuildPath(path,tname)
		Create ipath
		Temp=ipath
	end function

	'说明：获取目标文件夹下的文件集合
	'传参：path－文件夹绝对路径
	'返回：文件集合
	public function Files(path)
		Files=ofolder.GetFolder(path).Files
	end function

	'说明：获取目标文件夹下的文件夹集合
	'传参：path－文件夹绝对路径
	'返回：文件夹集合
	public function Folders(path)
		Folders=ofolder.GetFolder(path).SubFolders
	end function

	'说明：删除一个文件，包括只读文件夹
	'传参：path－文件夹绝对路径
	'返回：无
	public sub Delete(path)
		ofolder.DeleteFolder path,True	
	end sub

	'说明：复制文件夹
	'传参：oldpath－源文件夹绝对路径
	'　　　newpath－新文件夹绝对路径
	'返回：无
	public sub Copy(oldpath,newpath)
		ofolder.CopyFolder oldpath,newpath
	end sub

	'说明：复制文件夹
	'传参：oldpath－源文件夹绝对路径
	'　　　newpath－新文件夹绝对路径
	'返回：无
	public sub Move(oldpath,newpath)
		ofolder.MoveFolder oldpath,newpath
	end sub

	'说明：获取文件夹路径对应的文件夹名称
	'传参：path－文件夹绝对路径
	'返回：字符串
	public function Name(path)
		Name=ofolder.GetFileName(path)
	end function

	'说明：修改文件夹的名字
	'传参：path－源文件夹绝对路径
	'　　　newname－新的名称
	'返回：无
	public sub Rename(path,newname)
		dim ifolder
		set ifolder=ofolder.GetFolder(path)
		ifolder.name=newname
		set ifolder=nothing
	end sub

	'说明：检查路径，不存在则创建
	'传参：path－文件夹绝对路径
	'返回：T/F
	public function Check(path)
		dim param,ipath
		path=replace(path,"/","\")
		param=split(path,"\")
		ipath=""
		for each ifolder in param
			if ipath="" then
				ipath=trim(ifolder)
			else
				ipath=ofolder.BuildPath(ipath,trim(ifolder))
			end if
			if not Exist(ipath) then Create(ipath)
		next
	end function

end class
%>
