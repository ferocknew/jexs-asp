<script Language="JScript" runat="server">
/*
 *Jasp ASP Library v0.1
 *
 * Copyright 2010, Trarck & Jonah.Fu
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 * Date: Tue May 18 10:33:48 2010 +0800
 */
if(!undefined)undefined==undefined;
var Jasp = function(o,c){
    return new Jasp.init(o,c);
};
var $ = Jasp,uuid=0,expando="Jasp"+(new Date).getTime();
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
Jasp.init = function(data,content){
    // Handle $(""), $(null), or $(undefined)
    if (!data) {
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
	cache:{},
	adoCache:[],
    output: function(data, type){
        var str = "";
        switch (type) {
            case "xml":
                switch (typeof(data)) {
                    case "array":
                        str = json2xml(data, false, "item");
                        break;
                    case "object":
                        str = json2xml([data], false, "item");
                        break;
                    default:
                        str = json2xml($.json.parse(data), false, "item");
                        break;
                }
                break;
            case "json":
                str = $.json.stringify(data);
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
		var ado=null;
		if(args){
			//if(args.expando) {
			//	ado= Jasp.cache(args.expando);
			//}else{
				ado=new Jasp.adodb(args);
			//	Jasp.cache(expando+uuid)=ado;
				Jasp.adoCache.push(ado);
			//}
		}else{
			ado=Jasp.adoCache[Jasp.adoCache.length-1];
		}
		return ado;
    },
    //vb相关根方法
    vb: function(data){
        return new Jasp.vbo(data);
    },
    // 输出js
    js: function(words, RType){
        if (RType == 1) {
            Jasp.output("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><scr" + "ipt>" + words + "</scr" + "ipt>");
            return this;
        }
        else {
            Jasp.output("<scr" + "ipt>" + words + "</scr" + "ipt>");
            return this;
        }
    }
});
Jasp.extend(Jasp.fn,{

});
Jasp.adodb= function(o){
    //o.Version ? this._conn = o : (o.conn ? this._conn = o.conn : this.connection(o));
	this.data=[];
	if(o){
		this._conn=o.Version?o:(o.conn?o.conn:this.connection(o));
	}
    //this.length=0;
};
Jasp.extend(Jasp.adodb, {
    connection: function(o,reCreate){
		if(!reCreate && this._conn) return this._conn;
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
		//conn._expando=expando+(++uuid);
		this._conn=conn;
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
        var rs = this._conn.Execute(sql);//=new ActiveXObject("ADODB.Recordset");
        //rs.Open(sql, this._conn,1,1);
        this._rs = rs;
        if (RType != null)
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
	getData:function(){
		return this.data;
	},
    get: function(){
        if (this.hasOwnProperty("data")) {
            return this.data;
        }
        else {
            return []
        }
        //if(rs==null){return [];}else{return this.data;}
    }
});
//vb数组操作
Jasp.vbo = function(data){
    this.vbdata = data;
}
Jasp.extend(Jasp.vbo.prototype, {
    getRows: function(FieldsNameArray_a, fieldslen, RType){
        this.data = Jasp.vBRows2Obj(this.vbdata, FieldsNameArray_a, fieldslen, RType);
        return this;
    },
    output: function(type){
        Jasp.output(this.data, type);
        return this;
    }
});
//转换对象
(function($){
    var parsefn = $.parsefn = function(data){
        if (typeof($.json.parse(data)) == "string" || typeof($.json.parse(data)) == "number") {
            this.Jsondata = [data];
        }
        else {
            this.Jsondata = $.json.parse(data);
        }
    };
    //string转对象的根方法
    $.extend({
        parse: function(data){
            return new parsefn(data)
        }
    })
    $.extend(parsefn.prototype, {
        output: function(type){
            $.output(this.Jsondata, type);
            return this;
        },
        get: function(){
            return this.Jsondata
        }
    });
})(Jasp);



// 转换xml
function json2xml(o, tab, tag){
    var toXml = function(v, name, ind){
        var xml = "";
        if (v instanceof Array) {
            for (var i = 0, n = v.length; i < n; i++)
                xml += ind + toXml(v[i], name, ind + "\t") + "\n";
        }
        else
            if (typeof(v) == "object") {
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
                        else
                            if (m == "#cdata")
                                xml += "<![CDATA[" + v[m] + "]]>";
                            else
                                if (m.charAt(0) != "@") {
                                    xml += toXml(v[m], m, ind + "\t");
                                }
                    }
                    xml += (xml.charAt(xml.length - 1) == "\n" ? ind : "") + "</" + name + ">";
                }
            }
            else {
                var d = "";
                d = String(v).replace(/&/g, "&amp;");
                xml += ind + "<" + name + ">" + d.toString().replace(/</g, "&lt;").replace(/>/g, "&gt;") + "</" + name + ">";
            }

        return xml;
    }, xml = "";
    if (o instanceof Array) {
        var t = {};
        t[tag] = o;
        o = t;
    }
    for (var m in o)
        xml += toXml(o[m], m, "");
    return tab ? xml.replace(/\t/g, tab) : xml.replace(/\t|\n/g, "");
}


// JSON type
(function($){
    var JSON = {};
    $.json = JSON;

    function f(n){
        // Format integers to have at least two digits.
        return n < 10 ? '0' + n : n;
    }

    if (typeof Date.prototype.toJSON !== 'function') {

        Date.prototype.toJSON = function(key){

            return isFinite(this.valueOf()) ? this.getUTCFullYear() + '-' +
            f(this.getUTCMonth() + 1) +
            '-' +
            f(this.getUTCDate()) +
            'T' +
            f(this.getUTCHours()) +
            ':' +
            f(this.getUTCMinutes()) +
            ':' +
            f(this.getUTCSeconds()) +
            'Z' : null;
        };

        String.prototype.toJSON = Number.prototype.toJSON = Boolean.prototype.toJSON = function(key){
            return this.valueOf();
        };
    }

    var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, gap, indent, meta = { // table of character substitutions
        '\b': '\\b',
        '\t': '\\t',
        '\n': '\\n',
        '\f': '\\f',
        '\r': '\\r',
        '"': '\\"',
        '\\': '\\\\'
    }, rep;

    /*
     function quote(string) {
     // If the string contains no control characters, no quote characters, and no
     // backslash characters, then we can safely slap some quotes around it.
     // Otherwise we must also replace the offending characters with safe escape
     // sequences.
     escapable.lastIndex = 0;
     return escapable.test(string) ?
     '"' + string.replace(escapable, function (a) {
     var c = meta[a];
     return typeof c === 'string' ? c :
     '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
     }) + '"' :
     '"' + string + '"';
     }
     */
    function quote(str){
        var i, j, aL1, aL2, c, p, jsEncode = "";

        aL1 = [0x22, 0x5C, 0x2F, 0x08, 0x0C, 0x0A, 0x0D, 0x09]
        aL2 = [0x22, 0x5C, 0x2F, 0x62, 0x66, 0x6E, 0x72, 0x74]
        for (i = 0; i < str.length; i++) {
            p = true
            c = str.substr(i, 1)
            for (j = 0; j < 8; j++) {
                if (c == String.fromCharCode(aL1[j])) {
                    jsEncode += "\\" + String.fromCharCode(aL2[j]);
                    p = false
                    break;
                }
            }

            if (p) {
                var a
                a = c.charCodeAt(0);
                if (a > 31 && a < 127) {
                    jsEncode = jsEncode + c
                }
                else
                    if (a > -1 || a < 65535) {
                        jsEncode = jsEncode + "\\u" + (new Array(4 - a.toString(16).length)).join("0") + a.toString(16)
                    }
            }
        }
        return '"' + jsEncode + '"';
    }


    function str(key, holder){

        // Produce a string from holder[key].

        var i, // The loop counter.
 k, // The member key.
 v, // The member value.
 length, mind = gap, partial, value = holder[key];

        // If the value has a toJSON method, call it to obtain a replacement value.

        if (value && typeof value === 'object' &&
        typeof value.toJSON === 'function') {
            value = value.toJSON(key);
        }

        // If we were called with a replacer function, then call the replacer to
        // obtain a replacement value.

        if (typeof rep === 'function') {
            value = rep.call(holder, key, value);
        }

        // What happens next depends on the value's type.

        switch (typeof value) {
            case 'date':
                return quote(String(value));
            case 'string':
                return quote(value);
            case 'number':

                // JSON numbers must be finite. Encode non-finite numbers as null.

                return isFinite(value) ? String(value) : 'null';

            case 'boolean':
            case 'null':

                // If the value is a boolean or null, convert it to a string. Note:
                // typeof null does not produce 'null'. The case is included here in
                // the remote chance that this gets fixed someday.

                return String(value);

            // If the type is 'object', we might be dealing with an object or an array or
            // null.

            case 'object':

                // Due to a specification blunder in ECMAScript, typeof null is 'object',
                // so watch out for that case.

                if (!value) {
                    return 'null';
                }

                // Make an array to hold the partial results of stringifying this object value.

                gap += indent;
                partial = [];

                // Is the value an array?

                if (Object.prototype.toString.apply(value) === '[object Array]') {

                    // The value is an array. Stringify every element. Use null as a placeholder
                    // for non-JSON values.

                    length = value.length;
                    for (i = 0; i < length; i += 1) {
                        partial[i] = str(i, value) || 'null';
                    }

                    // Join all of the elements together, separated with commas, and wrap them in
                    // brackets.

                    v = partial.length === 0 ? '[]' : gap ? '[\n' + gap +
                    partial.join(',\n' + gap) +
                    '\n' +
                    mind +
                    ']' : '[' + partial.join(',') + ']';
                    gap = mind;
                    return v;
                }

                // If the replacer is an array, use it to select the members to be stringified.

                if (rep && typeof rep === 'object') {
                    length = rep.length;
                    for (i = 0; i < length; i += 1) {
                        k = rep[i];
                        if (typeof k === 'string') {
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ': ' : ':') + v);
                            }
                        }
                    }
                }
                else {

                    // Otherwise, iterate through all of the keys in the object.

                    for (k in value) {
                        if (Object.hasOwnProperty.call(value, k)) {
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ': ' : ':') + v);
                            }
                        }
                    }
                }

                // Join all of the member texts together, separated with commas,
                // and wrap them in braces.

                v = partial.length === 0 ? '{}' : gap ? '{\n' + gap + partial.join(',\n' + gap) + '\n' +
                mind +
                '}' : '{' + partial.join(',') + '}';
                gap = mind;
                return v;
        }
    }

    // If the JSON object does not yet have a stringify method, give it one.

    if (typeof JSON.stringify !== 'function') {
        JSON.stringify = function(value, replacer, space){

            // The stringify method takes a value and an optional replacer, and an optional
            // space parameter, and returns a JSON text. The replacer can be a function
            // that can replace values, or an array of strings that will select the keys.
            // A default replacer method can be provided. Use of the space parameter can
            // produce text that is more easily readable.

            var i;
            gap = '';
            indent = '';

            // If the space parameter is a number, make an indent string containing that
            // many spaces.

            if (typeof space === 'number') {
                for (i = 0; i < space; i += 1) {
                    indent += ' ';
                }

                // If the space parameter is a string, it will be used as the indent string.

            }
            else
                if (typeof space === 'string') {
                    indent = space;
                }

            // If there is a replacer, it must be a function or an array.
            // Otherwise, throw an error.

            rep = replacer;
            if (replacer && typeof replacer !== 'function' &&
            (typeof replacer !== 'object' ||
            typeof replacer.length !== 'number')) {
                throw new Error('JSON.stringify');
            }

            // Make a fake root object containing our value under the key of ''.
            // Return the result of stringifying the value.

            return str('', {
                '': value
            });
        };
    }


    // If the JSON object does not yet have a parse method, give it one.

    if (typeof JSON.parse !== 'function') {
        JSON.parse = function(text, reviver){

            // The parse method takes a text and an optional reviver function, and returns
            // a JavaScript value if the text is a valid JSON text.

            var j;

            function walk(holder, key){

                // The walk method is used to recursively walk the resulting structure so
                // that modifications can be made.

                var k, v, value = holder[key];
                if (value && typeof value === 'object') {
                    for (k in value) {
                        if (Object.hasOwnProperty.call(value, k)) {
                            v = walk(value, k);
                            if (v !== undefined) {
                                value[k] = v;
                            }
                            else {
                                delete value[k];
                            }
                        }
                    }
                }
                return reviver.call(holder, key, value);
            }


            // Parsing happens in four stages. In the first stage, we replace certain
            // Unicode characters with escape sequences. JavaScript handles many characters
            // incorrectly, either silently deleting them, or treating them as line endings.

            text = String(text);
            cx.lastIndex = 0;
            if (cx.test(text)) {
                text = text.replace(cx, function(a){
                    return '\\u' +
                    ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
                });
            }

            // In the second stage, we run the text against regular expressions that look
            // for non-JSON patterns. We are especially concerned with '()' and 'new'
            // because they can cause invocation, and '=' because it can cause mutation.
            // But just to be safe, we want to reject all unexpected forms.

            // We split the second stage into 4 regexp operations in order to work around
            // crippling inefficiencies in IE's and Safari's regexp engines. First we
            // replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
            // replace all simple value tokens with ']' characters. Third, we delete all
            // open brackets that follow a colon or comma or that begin the text. Finally,
            // we look to see that the remaining characters are only whitespace or ']' or
            // ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.

            if (/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@').replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']').replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

                // In the third stage we use the eval function to compile the text into a
                // JavaScript structure. The '{' operator is subject to a syntactic ambiguity
                // in JavaScript: it can begin a block or an object literal. We wrap the text
                // in parens to eliminate the ambiguity.

                j = eval('(' + text + ')');

                // In the optional fourth stage, we recursively walk the new structure, passing
                // each name/value pair to a reviver function for possible transformation.

                return typeof reviver === 'function' ? walk({
                    '': j
                }, '') : j;
            }

            // If the text is not JSON parseable, then a SyntaxError is thrown.

            throw new SyntaxError('JSON.parse');
        };
    }
})(Jasp);
</script>