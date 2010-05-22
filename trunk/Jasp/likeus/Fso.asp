<script Language="JScript" runat="server">
(function($){
	var _fso;
	
	//创建fso对象
	var fso = function(){
		_fso = server.CreateObject("scripting.filesystemobject");
		return this;
	}
	//为fso对象扩展方法
	$.extend(fso.prototype,{
		get: function(){
			return _fso;
		},
		clear: function(){
			_fso = undefined;
		},
		file: function(path){return new file(path)},
		folder: function(path){return new folder(path)}
	});
	
	//创建file对象
	var file = function(path){
		this.path = path ? path : undefined;
		return this;
	};
	//为file对象扩展方法
	$.extend(file.prototype,{
		get: function(){			//返回file基于path的文件对象
			try{
				if(this.path){
					return _fso.GetFile(this.path);
				}else return ;
			}catch(e){
				$.Error(e);
				return ;
			}
		},
		exist: function(){			//判断文件是否存在
			return _fso.FileExists(this.path);
		},
		create: function(){			//创建文件
			try{
				if(this.path)
					_fso.CreateTextFile(this.path,true).close();
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		tempCreate: function(path){	//创建随机临时文件
			try{
				var _name = _fso.GetTempName();
				_fso.GetFolder(path).CreateTextFile(_name).close();
				this.path = _fso.BuildPath(path,_name);
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		read: function(){			//读取文件内容
			try{
				if(this.path){
					var _fs = _fso.OpenTextFile(this.path,1,true);
					this.outputObject = _fs.AtEndOfLine ? undefined : _fs.ReadAll();
					_fs.close();
				}
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		write: function(content){	//写入文件内容
			try{
				if(this.path && content){
					var _fs = _fso.OpenTextFile(this.path,2,true);
					_fs.Write(content);
					_fs.close();
				}
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		append: function(content){	//追加文件内容文件内容
			try{
				if(this.path && content){
					var _fs = _fso.OpenTextFile(this.path,8,true);
					_fs.Write(content);
					_fs.close();
				}
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		Delete: function(){			//删除文件
			try{
				_fso.DeleteFile(this.path,true);
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		copy: function(newpath){	//拷贝文件
			try{
				_fso.CopyFile(this.path,newpath,true);
				this.path = _fso.BuildPath(newpath,_fso.GetFileName(this.path));
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		move: function(newpath){
			try{
				_fso.MoveFile(this.path,newpath);
				this.path = _fso.BuildPath(newpath,_fso.GetFileName(this.path));
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		name: function(){
			try{
				return _fso.GetFileName(this.path);
			}catch(e){
				$.Error(e);
				return ;
			}
		},
		rename: function(newname){
			try{
				_file = this.get(this.path);
				_file.name = newname
				this.path = _file.path;
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		ext: function(){
			try{
				return _fso.GetExtensionName(this.path);
			}catch(e){
				$.Error(e);
				return ;
			}
		},

		clear: function(){
			$.fso.clear();
		},
		outputObject: undefined,
		output: function(type){
			return $.output(this.outputObject,type);
		}
	});
	
	//创建folder对象
	var folder = function(path){
		this.path = path;
		return this;
	};
	//为folder对象扩展方法
	$.extend(folder.prototype,{
		get: function(){
			if(this.path){
				try{
					return _fso.GetFolder(this.path);
				}catch(e){
					$.Error(e);
					return ;
				}
			}else return ;
		},
		exist: function(){
			return _fso.FolderExists(this.path);
		},
		
		//
		//

		clear: function(){
			$.fso.clear();
		},
		outputObject: undefined,
		output: function(type){
			return $.output(this.outputObject,type);
		}
	});
	
	//为$扩展fso对象
	$.extend({
		fso: new fso()
	});
	
})(Jasp);
</script>