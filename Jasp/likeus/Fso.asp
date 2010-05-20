<script Language="JScript" runat="server">
(function(){
	//创建FSO,File,Folder对象
	Jasp.Fso = _Fso = server.CreateObject("scripting.filesystemobject");
	Jasp.File = _File= {};
	Jasp.Folder = _Folder = {};

	//为_File对象扩展方法
	Jasp.extend(_File,{
		Get: function(path){
			return _Fso.GetFile(path);
		},
		Exist: function(path){
			return _Fso.FileExists(path);
		},
		Create: function(path){
			try{
				newfile=_Fso.CreateTextFile(path,true);
				newfile.close();
				return this.Get(path);
			}catch(e){
				Jasp.Error(e);
				response.write(Jasp._E);
				return ;
			}
		},
		
		
		
		Test: 'HI'
	});
	//Folder对象
})();
</script>