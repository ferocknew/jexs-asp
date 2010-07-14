(function($){
    var _objectData = {
        PageSize: 10, //每页记录数的默认值10
        Order: ">", //默认排序
        Size: "MAX",
        WhereOther: "", //默认条件
        RecType: 1, //默认统计方式
        CookieName: "getpagenum_cookie",
        RecTerm: 2
    };
    
    
    
    var dbfn = function(data){
        this._conn = $.adodb.connection(data);
    }
    
    $.extend({
        db: function(data){
            return new dbfn(data)
        }
    })
    $.extend(dbfn.prototype, {
		getOption:function(o){
			//this._option=_objectData;
			Response.Write(o);
			return this;
		},
        exec: function(sql){
            var rs = this._conn.Execute(sql);//=new ActiveXObject("ADODB.Recordset");
            //rs.Open(sql, this._conn,1,1);
            this._rs = rs;
            return this;
        },
        get: function(){
            return this._conn
        }
    });
})(Jasp)
