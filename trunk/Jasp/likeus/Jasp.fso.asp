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
		get: function(){					//返回基于path的file对象
			try{
				if(this.path){
					return _fso.GetFile(this.path);
				}else return ;
			}catch(e){
				$.Error(e);
				return ;
			}
		},
		exist: function(){					//判断文件是否存在
			return _fso.FileExists(this.path);
		},
		create: function(){					//创建文件
			try{
				if(this.path)
					_fso.CreateTextFile(this.path,true).close();
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		tempCreate: function(path){			//创建随机临时文件
			try{
				var _name = _fso.GetTempName();
				_fso.GetFolder(path).CreateTextFile(_name).close();
				this.path = _fso.BuildPath(path,_name);
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		read: function(){					//读取文件内容
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
		write: function(content){			//写入文件内容
			try{
				if(this.path && content){
					var _fs = _fso.OpenTextFile(this.path,2,true);
					_fs.Write(content);
					this.outputObject = _fs.ReadAll();
					_fs.close();
				}
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		append: function(content){			//追加文件内容文件内容
			try{
				if(this.path && content){
					var _fs = _fso.OpenTextFile(this.path,8,true);
					_fs.Write(content);
					this.outputObject = _fs.ReadAll();
					_fs.close();
				}
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		stream: function(){					//获取基于path的文件流对象，用完请关闭.close()
			try{
				return _fso.OpenTextFile(this.path,1);
			}catch(e){
				$.Error(e);
				return ;
			}
		},
		Delete: function(){					//删除文件
			try{
				_fso.DeleteFile(this.path,true);
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		copy: function(newpath,newname){	//拷贝文件
			try{
				if(newname)
					_newpath = _fso.BuildPath(newpath,newname);
				else
					_newpath = _fso.BuildPath(newpath,_fso.GetFileName(this.path));
				_fso.CopyFile(this.path,_newpath,true);
				this.path = _newpath;
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		move: function(newpath,newname){	//移动文件
			try{
				if(newname)
					_newpath = _fso.BuildPath(newpath,newname);
				else
					_newpath = _fso.BuildPath(newpath,_fso.GetFileName(this.path));
				_fso.MoveFile(this.path,_newpath);
				this.path = _newpath;
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		name: function(){					//获取文件名
			try{
				return _fso.GetFileName(this.path);
			}catch(e){
				$.Error(e);
				return ;
			}
		},
		rename: function(newname){			//重命名文件
			try{
				_file = this.get(this.path);
				_file.name = newname
				this.path = _file.path;
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		ext: function(){					//获取文件扩展名
			try{
				return _fso.GetExtensionName(this.path);
			}catch(e){
				$.Error(e);
				return ;
			}
		},

		clear: function(){					//清除fso对象
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
		get: function(){					//返回基于path的folder对象
			if(this.path){
				try{
					return _fso.GetFolder(this.path);
				}catch(e){
					$.Error(e);
					return ;
				}
			}else return ;
		},
		exist: function(){					//文件夹是否存在
			return _fso.FolderExists(this.path);
		},
		create: function(){					//创建文件夹
			try{
				_fso.CreateFolder(this.path);
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		tempCreate: function(path){			//创建随机临时文件夹
			try{
				var _name = _fso.GetTempName();
				this.path = _fso.BuildPath(path,_name);
				this.create();
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		files: function(){					//读取当前文件夹下的文件集合
			try{
				return _fso.GetFolder(this.path).Files
			}catch(e){
				$.Error(e);
				return ;
			}
		},
		folders: function(content){			//读取当前文件夹下的文件夹集合
			try{
				return _fso.GetFolder(this.path).SubFolders
			}catch(e){
				$.Error(e);
				return ;
			}
		},
		Delete: function(){					//删除文件夹
			try{
				_fso.DeleteFolder(this.path,true);
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		copy: function(newpath,newname){	//拷贝文件夹
			try{
				if(newname)
					_newpath = _fso.BuildPath(newpath,newname);
				else
					_newpath = _fso.BuildPath(newpath,_fso.GetFileName(this.path));
				_fso.CopyFolder(this.path,_newpath,true);
				this.path = _newpath;
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		move: function(newpath,newname){	//移动文件夹
			try{
				if(newname)
					_newpath = _fso.BuildPath(newpath,newname);
				else
					_newpath = _fso.BuildPath(newpath,_fso.GetFileName(this.path));
				_fso.MoveFolder(this.path,_newpath);
				this.path = _newpath;
			}catch(e){
				$.Error(e);
			}
			return this;
		},
		name: function(){					//获取文件夹名称
			try{
				return _fso.GetFileName(this.path);
			}catch(e){
				$.Error(e);
				return ;
			}
		},
		rename: function(newname){			//重命名文件夹
			try{
				_folder = this.get(this.path);
				_folder.name = newname
				this.path = _folder.path;
			}catch(e){
				$.Error(e);
			}

			return this;
		},
		check: function(){					//检查路径，不存在则创建
			try{
				_subpath = this.path.replace(/\//g,"\\").split("\\");
				var _path;
				for(_folder in _subpath){
					_truefolder = _subpath[_folder].replace(/(^\s*)|(\s*$)/g, ""); 
					_path = _path ? _fso.BuildPath(_path,_truefolder) : _truefolder;
					response.write(_path + "|");
					this.path = _path;
					if(!this.exist()) this.create();
				}
			}catch(e){
				$.Error(e);
				this.path = undefined;
			}
			return this;
		},
		clear: function(){					//清除fso对象
			$.fso.clear();
		}
	});
	
	//为$扩展fso对象
	$.extend({
		fso: new fso()
	});
	
})(Jasp);
</script>