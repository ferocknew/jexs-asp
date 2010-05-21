<script Language="JScript" runat="server">
(function($){
	var fso = {}, file = {}, folder = {};
	var _fso = server.CreateObject("scripting.filesystemobject");
	$.extend(fso,{
		get: function(){
			return _fso;
		},
		file: file,
		folder: folder
	});
	$.extend(file,{
		_file: undefined,
		_stream: undefined,
		get: function(path){
			try{
				this._file = path ? _fso.GetFile(path) : this._file;
			}catch(e){
				this._file = undefined;
				$.Error(e);
			}
			return this._file;
		},
		exist: function(path){
			this._file = path ? (_fso.FileExists(path) ? this.get(path) : undefined) : this._file;
			return typeof(this._file) === "object";
		},
		create: function(path){
			this._file = undefined;
			if(path){
				try{
					_fso.CreateTextFile(path,true).close();
					this._file = this.get(path);
				}catch(e){
					$.Error(e);
				}
			}; 
			return this;
		},
		output: function(type){
			return $.output(this._file,type);
		}
	});
	
	$.extend({
		fso: fso
	});
/*
	//为_File对象扩展方法
	var _Fso = server.CreateObject("scripting.filesystemobject");
	//创建FSO,File,Folder对象
	$.extend({
		Fso:{
			Get: function(){
				return _Fso;
			},
			File: {
				Get: function(path){
					return _Fso.GetFile(path);
				},
				Exist: function(path){
					return _Fso.FileExists(path)?this.Get(path):null;
				},
				Create: function(path){
					try{
						newfile=_Fso.CreateTextFile(path,true);
						newfile.close();
						return this.Get(path);
					}catch(e){
						$.Error(e);
						return $.Error.output();
					}
				},
				Test: 'HI',
				output: function(type){
					$.output(this, type);
				} 
			},
			Folder: {
				
			}
		}
	});

	
	//Folder对象
	var Folder = {};
*/
})(Jasp);
</script>