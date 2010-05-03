var Jexs=function(o){
    return new Jexs.init(o);
};
Jexs.extend=function(){
    // copy reference to target object
    var target = arguments[0] || {}, i = 1, length = arguments.length, deep = false, options, name, src, copy;

    // Handle a deep copy situation
    if ( typeof target === "boolean" ) {
        deep = target;
        target = arguments[1] || {};
        // skip the boolean and the target
        i = 2;
    }

    // Handle case when target is a string or something (possible in deep copy)
    if ( typeof target !== "object" && typeof target !== "function"  ) {
        target = {};
    }

    // extend jQuery itself if only one argument is passed
    if ( length === i ) {
        target = this;
        --i;
    }

    for ( ; i < length; i++ ) {
        // Only deal with non-null/undefined values
        if ( (options = arguments[ i ]) != null ) {
            // Extend the base object
            for ( name in options ) {
                src = target[ name ];
                copy = options[ name ];

                // Prevent never-ending loop
                if ( target === copy ) {
                    continue;
                }

                // Recurse if we're merging object literal values or arrays
                if ( deep && copy && (typeof target == "object"  || typeof target == "array"  ) ) {
                    var clone = src && ( typeof target == "object"  || typeof target == "array"  ) ? src
                        : typeof target == "array" ? [] : {};

                    // Never move original objects, clone them
                    target[ name ] = Jexs.extend( deep, clone, copy );

                // Don't bring in undefined values
                } else if ( copy !== undefined ) {
                    target[ name ] = copy;
                }
            }
        }
    }

    // Return the modified object
    return target;
};
Jexs.init=function(){
    
};
Jexs.init.prototype =Jexs.prototype;
Jexs.extend(Jexs.prototype,{
    version:"0.1",
    output:function(str,type){
      Jexs.output(str,type); 
    }
});
Jexs.fn=Jexs.prototype;
Jexs.extend({
   output:function(data,type){
        var str="";
        switch (type){
            case "xml":
                break;
            case "json":
                str=JSON.stringify(data);
                break;
            default:
                str=data;
                break;
        }
        Response.Write(str);
   }, 
   vBRows2Obj:function(DbGetRows,FieldsNameArray_a,fieldslen,RType) {
		var FieldsNameArray =FieldsNameArray_a.toArray?FieldsNameArray_a.toArray():FieldsNameArray_a;
		var arr=DbGetRows.toArray();
		var len=arr.length/fieldslen,data=[],sp;
		for(var i=0;i<len;i++) {
			data[i]=new Array();
			sp=i*fieldslen;
			if (FieldsNameArray.length < fieldslen) {
				J_temp = FieldsNameArray.length;
			}else{
				J_temp=fieldslen;
			}
			if (RType == 1) {
				var temp_obj = {};
				for (var j = 0; j < J_temp; j++) {
					temp_obj[FieldsNameArray[j]] = arr[sp + j];
				}
				data[i] = temp_obj
			}
			else {
				for (var j = 0; j < J_temp; j++)
					data[i][j] = arr[sp + j];
			}
		}
		return data;
	},
   ado:function(args){
        return new Jexs.adodb(args)
   }
});
Jexs.adodb=function(o){
   o.Version?this._conn=o:(o.conn ? this._conn=o.conn : this.connection(o));
   //this.length=0;
};
Jexs.extend(Jexs.adodb,{
    connection:function(o){
        var conn;
        try {
            conn = Server.CreateObject("ADODB.Connection");
            switch (o.provider){
                case "access":
                    conn.connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath(o.dataSource);
                    break;
                case "sqlserver":
                    conn.connectionString = "Provider = Sqloledb; User ID = " + o.user + "; Password = " + o.password + "; Initial Catalog = " + o.databaseName + "; Data Source = " + o.dataSource + ";"
                    break;
                default:
                    break;
            }
            conn.open();
        }
        catch (e) {
            Jexs.output('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />数据库连接出错，请检查连接字串!');
            Response.End
        }
        return conn;
    },
     close:function(conn){
         try {
            conn .close();
            conn  = null;
        }
        catch (e) {
        }
    }
});
Jexs.extend(Jexs.adodb.prototype,{
    connection:function(o){
        this._conn=Jexs.adodb.connection(o);
        return this;
    },
    close:function(){
        Jexs.adodb.close(this._conn);
        return this;
    },
    execute:function(sql,RType){
        var rs =this._conn.Execute(sql);//=new ActiveXObject("ADODB.Recordset");
        //rs.Open(sql, this._conn,1,1);
		this._rs=rs;
        if(RType!=null) this.fetch(RType);
        return this;
    },
    output:function(type){
        Jexs.output(this.data,type);
        return this;
    },
    getConn:function(){
        return this._conn;
    },
    fetch:function(RType){
		var rs=this._rs;
		if(rs.EOF||rs.BOF)return [];
        var FieldsName = new Array();//字段名
        for (var i = 0; i < rs.Fields.Count; i++) {
            FieldsName[i] = rs.Fields(i).Name;
        }
        this.data=Jexs.vBRows2Obj(rs.GetRows,FieldsName, rs.Fields.Count,RType);
        rs = null;
		this._rs=null;
		//this.length=0;
		//Array.prototype.push.apply(this,this.data);
        return this;
    },
	getData:function(){
		return this.data;
	}
    
});
