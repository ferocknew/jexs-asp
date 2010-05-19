/*
 *Jasp ASP Library v0.1
 *
 * Copyright 2010, Trarck & Jonah.Fu
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 * Date: Tue May 18 10:33:48 2010 +0800
 */
var Jasp = function(o){
    return new Jasp.init(o);
};
var $=Jasp;
Jasp.extend = function(){
    // copy reference to target object
    var target = arguments[0] || {}, i = 1, length = arguments.length, deep = false, options, name, src, copy;
    // Handle a deep copy situation
    if (typeof target === "boolean") {
        deep = target;
        target = arguments[1] || {};
        // skip the boolean and the target
        i = 2;
    }
    // Handle case when target is a string or something (possible in deep copy)
    if (typeof target !== "object" && typeof target !== "function") {
        target = {};
    }
    // extend jQuery itself if only one argument is passed
    if (length === i) {
        target = this;
        --i;
    }
    for (; i < length; i++) {
        // Only deal with non-null/undefined values
        if ((options = arguments[i]) != null) {
            // Extend the base object
            for (name in options) {
                src = target[name];
                copy = options[name];
                // Prevent never-ending loop
                if (target === copy) {
                    continue;
                }
                // Recurse if we're merging object literal values or arrays
                if (deep && copy && (typeof target == "object" || typeof target == "array")) {
                    var clone = src && (typeof target == "object" || typeof target == "array") ? src : typeof target == "array" ? [] : {};
                    // Never move original objects, clone them
                    target[name] = Jasp.extend(deep, clone, copy);
                    // Don't bring in undefined values
                }
                else
                    if (copy !== undefined) {
                        target[name] = copy;
                    }
            }
        }
    }
    // Return the modified object
    return target;
};
Jasp.init = function(data){
	// Handle $(""), $(null), or $(undefined)
	if ( !data ) {
		return this;
	}
};
Jasp.init.prototype = Jasp.prototype;
Jasp.extend(Jasp.prototype, {
    output: function(str, type){
        Jasp.output(str, type);
    }
});
Jasp.fn = Jasp.prototype;
Jasp.extend({
	version: "0.1",
    output: function(data, type){
        var str = "";
        switch (type) {
            case "xml":
				switch(typeof(data)){
					case "array":
						str = json2xml(data,false,"item");
						break;
					case "object":
						str = json2xml([data],false,"item");
						break;
				}
                break;
            case "json":
                str = JSON.stringify(data);
                break;
            default:
                str = data;
                break;
        }
        Response.Write(str);
    },
    vBRows2Obj: function(DbGetRows, FieldsNameArray_a, fieldslen, RType){
        var FieldsNameArray = FieldsNameArray_a.toArray ? FieldsNameArray_a.toArray() : FieldsNameArray_a;
        var arr = DbGetRows.toArray();
        var len = arr.length / fieldslen, data = [], sp;
        for (var i = 0; i < len; i++) {
            data[i] = new Array();
            sp = i * fieldslen;
            if (FieldsNameArray.length < fieldslen) {
                J_temp = FieldsNameArray.length;
            }
            else {
                J_temp = fieldslen;
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
	//adodb根方法
    ado: function(args){
        return new Jasp.adodb(args)
    },
	//vb相关根方法
	vb:function(data){
		return new Jasp.vbo(data);
	},
	// 输出js
	js: function(words, RType){
        if (RType == 1) {
            Jasp.output("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><script>" + words + "</script>");
			return this;
        }
        else {
            Jasp.output("<script>" + words + "</script>");
			return this;
        }
    }
});
Jasp.adodb = function(o){
    o.Version ? this._conn = o : (o.conn ? this._conn = o.conn : this.connection(o));
    //this.length=0;
};
Jasp.extend(Jasp.adodb, {
    connection: function(o){
        var conn;
        try {
            conn = Server.CreateObject("ADODB.Connection");
            switch (o.provider) {
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
            Jasp.output('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />数据库连接出错，请检查连接字串!');
            Response.End
        }
        return conn;
    },
    close: function(conn){
        try {
            conn.close();
            conn = null;
        }
        catch (e) {
        }
    }
});
Jasp.extend(Jasp.adodb.prototype, {
    connection: function(o){
        this._conn = Jasp.adodb.connection(o);
        return this;
    },
    close: function(){
        Jasp.adodb.close(this._conn);
        return this;
    },
    exec: function(sql, RType){
		if(!RType)RType=1;
        var rs = this._conn.Execute(sql);
        this._rs = rs;
		this.fetch(RType);
        return this;
    },
    output: function(type){
        Jasp.output(this.get(), type);
        return this;
    },
    getConn: function(){
        return this._conn;
    },
    fetch: function(RType){
        var rs = this._rs;
        if (rs.EOF || rs.BOF)
            return [];
        var FieldsName = new Array();//字段名
        for (var i = 0; i < rs.Fields.Count; i++) {
            FieldsName[i] = rs.Fields(i).Name;
        }
        this.data = Jasp.vBRows2Obj(rs.GetRows, FieldsName, rs.Fields.Count, RType);
        rs = null;
        this._rs = null;
        //this.length=0;
        //Array.prototype.push.apply(this,this.data);
        return this;
    },
    get: function(){
		if (this.hasOwnProperty("data")) {return this.data;
		}else{return []}
		//if(rs==null){return [];}else{return this.data;}
    }
});
//vb数组操作
Jasp.vbo=function(data){
	this.vbdata=data;
}
Jasp.extend(Jasp.vbo.prototype,{
	getRows:function(FieldsNameArray_a, fieldslen, RType){
		this.data=Jasp.vBRows2Obj(this.vbdata,FieldsNameArray_a, fieldslen, RType);
		return this;
	},
	output: function(type){
        Jasp.output(this.data, type);
        return this;
    }
});
//转换对象
(function($){
	var parsefn=$.parsefn=function(data){
		if (typeof(JSON.parse(data))=="string"||typeof(JSON.parse(data))=="number") {
			this.Jsondata=[data];
		}else{
			this.Jsondata=JSON.parse(data);
		}
	};
	//string转对象的根方法
	$.extend({parse:function(data){return new parsefn(data)}})
	$.extend(parsefn.prototype,{
		output: function(type){
			$.output(this.Jsondata, type);
			return this;
		},
		get:function(){
			return this.Jsondata
		}
	});
})(Jasp);


// 转换xml
function json2xml(o, tab,tag) {
	var toXml = function(v, name, ind) {
	var xml = "";
	if (v instanceof Array) {
		for (var i=0, n=v.length; i<n; i++)
			xml += ind + toXml(v[i], name, ind+"\t") + "\n";
	}
	else if (typeof(v) == "object") {
		var hasChild = false;
		xml += ind + "<" + name;
		for (var m in v) {
			if (m.charAt(0) == "@")
			xml += " " + m.substr(1) + "=\"" + v[m].toString() + "\"";
			else
			hasChild = true;
		}
		xml += hasChild ? ">" : "/>";
		if (hasChild) {
			for (var m in v) {
				if (m == "#text")
					xml += v[m];
				else if (m == "#cdata")
					xml += "<![CDATA[" + v[m] + "]]>";
				else if (m.charAt(0) != "@"){
					xml += toXml(v[m], m, ind+"\t");
				}
			}
			xml += (xml.charAt(xml.length-1)=="\n"?ind:"") + "</" + name + ">";
		}
	}
	else {
		var d="";
		d=String(v).replace(/&/g,"&amp;");
		xml += ind + "<" + name + ">" + d.toString().replace(/</g,"&lt;").replace(/>/g,"&gt;") +  "</" + name + ">";
	}

	return xml;
	}, xml="";
	if( o instanceof Array){
		var t={};
		t[tag]=o;
		o=t;
	}
	for (var m in o)
	xml += toXml(o[m], m, "");
	return tab ? xml.replace(/\t/g, tab) : xml.replace(/\t|\n/g, "");
}