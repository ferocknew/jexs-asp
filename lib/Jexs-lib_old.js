var Jexs = {
    Version: 0.01,
    RQ: SafeData(Request.QueryString),
    RF: SafeData(Request.Form)
}
Jexs.arrySort = function(objectit){
    return objectit.sort(new Function("a", "b", "return a-b;"));
}
//安全请求
function SafeData(fn){
    return function(Str, RType){
        var TempStr = fn(Str) + "";
        switch (RType) {
            case 0:
                TempStr = TempStr.replace("'", "''");
                break;
        }
        return TempStr;
    };
}

// SQL查询转对象 只读
Jexs.ADO2Obj = function(SQL, ReConn, RType){
    var rs = new ActiveXObject("ADODB.Recordset");
    rs.Open(SQL, ReConn, 1, 1);
	if(rs.EOF||rs.BOF)return [];
    var FieldsName = new Array();//字段名
    for (var i = 0; i < rs.Fields.Count; i++) {
        FieldsName[i] = rs.Fields(i).Name;
    }
    var fieldslen = rs.Fields.Count;
    var arr = rs.GetRows.toArray();
    var len = arr.length / fieldslen, data = [], sp;
    for (var i = 0; i < len; i++) {
        data[i] = new Array();
        sp = i * fieldslen;
        if (RType == 1) {
            var temp_obj = {};
            for (var j = 0; j < fieldslen; j++) {
                temp_obj[FieldsName[j]] = arr[sp + j];
            }
            data[i] = temp_obj
        }
        else {
            for (var j = 0; j < fieldslen; j++)
                data[i][j] = arr[sp + j];
        }
    }
    return data;
    rs = null;
}
//VBArray GetRows转obj,FieldsNameArray必须是数组,fieldslen为实际字段数
Jexs.VBRows2Obj=function(DbGetRows,FieldsNameArray_a,fieldslen,RType) {
	var FieldsNameArray = FieldsNameArray_a.toArray();
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
}

//打开数据库
function createConnection(IsSqlDataBase, strPath, SqlUsername, SqlPassword, SqlDatabaseName, SqlLocalName){
    try {
        Conn = Server.CreateObject("ADODB.Connection");
        if (IsSqlDataBase == "0") {
            Conn.connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath(strPath);
        }
        else {
            Conn.connectionString = "Provider = Sqloledb; User ID = " + SqlUsername + "; Password = " + SqlPassword + "; Initial Catalog = " + SqlDatabaseName + "; Data Source = " + SqlLocalName + ";"

        }
        Conn.open();
    }
    catch (e) {
        Response.Write('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />数据库连接出错，请检查连接字串!');
        Response.End
    }
}

//*************************************
//关闭数据库
//*************************************
function CloseDB(){
    try {
        Conn.close();
        Conn = null;
    }
    catch (e) {
    }
}
/*
Function: trim()
Description:
Returns:
History:
20050202 2215GMT    v1      Andrew Urquhart     Comment added
*/
function trim() {
    var strInput = String(this);

    if (typeof strInput == "undefined" || strInput == null) {
        return this;
    }

    return strInput.replace(/^\s+|\s+$/g, "");
}
/*
Function: objectEnumerate()
Description: Overrides the default implicit cast to string function for Objects in order to enumerate their contents in CSV format
Returns: CSV String
History:
20060203 1256GMT    v1      Andrew Urquhart     Created
*/
function objectEnumerate() {
    var a = [];
    for (var e in this) {
        var strType = typeof this[e];
        if (strType != "function") {
            a.push(e + ":" + (strType == "string" ? "\"" : "") + ("" + this[e]).replace(/"/g,"\\\"") + (strType == "string" ? "\"" : ""))
        }
    }
    return "{" + a.join(", ") + "}";
}
/*
Function: isNumber()
Description:
Returns:
History:
20060608 0928BST    v1      Andrew Urquhart     Created
*/
function isNumber(varData) {
    if (typeof varData !== "number" || isNaN(varData)) {
        return false;
    }
    return true;
}


/*
Function: isBoolean()
Description:
Returns:
History:
20060608 0928BST    v1      Andrew Urquhart     Created
*/
function isBoolean(varData) {
    if (typeof varData === "boolean") {
        return true;
    }
    return false;
}
/*
Function: isNumber()
Description:
Returns:
History:
20060608 0928BST    v1      Andrew Urquhart     Created
*/
function isNumber(varData) {
    if (typeof varData !== "number" || isNaN(varData)) {
        return false;
    }
    return true;
}


/*
Function: isBoolean()
Description:
Returns:
History:
20060608 0928BST    v1      Andrew Urquhart     Created
*/
function isBoolean(varData) {
    if (typeof varData === "boolean") {
        return true;
    }
    return false;
}
/*
Function: hEnc()
Description: Sugar wrapper for Server.HTMLEncode to cope with nulls and undefined values
Returns: String
History:
20060330 1447BST    v1      Andrew Urquhart     Created
*/
function hEnc(strRawHTML) {
    return (strRawHTML === null || strRawHTML === undefined ? "" : Server.HTMLEncode(strRawHTML));
}


/*
Function: uEnc()
Description: Sugar wrapper for Server.URLEncode to cope with nulls and undefined values
Returns: String
History:
20060413 1053BST    v1      Andrew Urquhart     Created
*/
function uEnc(strData) {
    return (strData === null || strData === undefined || (typeof strData == "number" && isNaN(strData)) ? "" : Server.URLEncode(strData));
}