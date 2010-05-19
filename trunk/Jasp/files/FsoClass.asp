<!--#include file="FileClass.asp"-->
<!--#include file="FolderClass.asp"-->
<%
class FsoClass

	public File,Folder,Fso

	'说明：类被创建时，自动调用
	'传参：无
	'返回：无
	private sub Class_Initialize()
		set File = new FileClass
		set Folder = new FolderClass
		set Fso = Create()
	end sub
	
	'说明：类被注销时，自动调用
	'传参：无
	'返回：无
	private sub Class_Terminate()
		Set File = Nothing
		Set Folder = Nothing
		set Fso = nothing
	end sub
	
	''''''''''''''''''对象访问''''''''''''''''''
	
	'说明：获取一个FSO对象
	'传参：无
	'返回：FSO对象
	public function Create()
		set Create=server.CreateObject("scripting.filesystemobject")
	end function
	'用途：属性
	'　　　Drives              返回本地计算机上所有驱动器对象的集合。 
	'用途：方法
	'　　　BuildPath           将一个名称追加到已有的路径后 
	'　　　CopyFile            从一个位置向另一个位置拷贝一个或多个文件。 
	'　　　CopyFolder          从一个位置向另一个位置拷贝一个或多个文件夹。 
	'　　　CreateFolder        创建新文件夹。 
	'　　　CreateTextFile      创建文本文件，并返回一个 TextStream 对象。 
	'　　　DeleteFile          删除一个或者多个指定的文件。 
	'　　　DeleteFolder        删除一个或者多个指定的文件夹。 
	'　　　DriveExists         检查指定的驱动器是否存在。 
	'　　　FileExists          检查指定的文件是否存在。 
	'　　　FolderExists        检查某个文件夹是否存在。 
	'　　　GetAbsolutePathName 针对指定的路径返回从驱动器根部起始的完整路径。 
	'　　　GetBaseName         返回指定文件或者文件夹的基名称。 
	'　　　GetDrive            返回指定路径中所对应的驱动器的 Drive 对象。 
	'　　　GetDriveName        返回指定的路径的驱动器名称。 
	'　　　GetExtensionName    返回在指定的路径中最后一个成分的文件扩展名。 
	'　　　GetFile             返回一个针对指定路径的 File 对象。 
	'　　　GetFileName         返回在指定的路径中最后一个成分的文件名。 
	'　　　GetFolder           返回一个针对指定路径的 Folder 对象。 
	'　　　GetParentFolderName 返回在指定的路径中最后一个成分的父文件名称。 
	'　　　GetSpecialFolder    返回某些 Windows 的特殊文件夹的路径。 
	'　　　GetTempName         返回一个随机生成的文件或文件夹。 
	'　　　MoveFile            从一个位置向另一个位置移动一个或多个文件。 
	'　　　MoveFolder          从一个位置向另一个位置移动一个或多个文件夹。 
	'　　　OpenTextFile        打开文件，并返回一个用于访问此文件的 TextStream 对象。 

end class
%>
