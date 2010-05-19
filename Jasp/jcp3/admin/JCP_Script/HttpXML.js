var xmlHttp,xml_BackCont;
var xmlDom,xmlRoot;
//先新建一XHR对象

function createXMLHttpRequest() {

//如果是IE，用activexobject
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } 

//如果其它浏览器就用XMLHttpRequest
    else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}
    
//开始函数

function startXmlRequest(sendtype,strURL,strSEND,strTYPE,strAction,strExp,YN) {
	xml_BackCont="";
    createXMLHttpRequest();
    //指定当readyState属性改变时执行的函数
    xmlHttp.onreadystatechange = function(){handleStateChange(strTYPE,strAction,strURL,strExp)};  
　  //创建一个新的http请求，并指定此请求的方法、URL以及验证信息 
    xmlHttp.open(sendtype, strURL, YN); 
    //发送请求到http服务器并接收回应 
    xmlHttp.send(strSEND);
}
    
function handleStateChange(strTYPE,strAction,strURL,strExp){
　  //4数据接收完毕 
    if(xmlHttp.readyState == 4){ 
        //200返回请求状态为OK
        //if(xmlHttp.status == 200){
	　　　//返回各种类型的数据,strTYPE=xml >> responseXML , strTYPE=body >> responsebody , strTYPE=text >> responseText
            if(strTYPE=="xml"){
				xml_BackCont=xmlHttp.responseXML;
			}else if(strTYPE=="text"){
				xml_BackCont=xmlHttp.responseText;
			}else if(strTYPE=="body"){
				xml_BackCont=xmlHttp.responseBody;
				xml_BackCont=bytes2BSTR(xml_BackCont);
			}else{
				xml_BackCont="没有数据源！";
			}
			eval(strAction);
        //}else{
		//	xml_BackCont="数据执行错误！";
		//}
	}
}
/*
[0]uninitialized未初始化(在XMLHttpRequest开始前)
[1]loading(一旦初始化)
[2]loaded(一旦XMLHttpRequest从服务器端获得响应)
[3]interactive(当对象连接到服务器)
[4]complete(完成)
*/
function AddContent(ParentObject,SubObjectID,SubObjectContent){
		var SubObject=document.createElement("DIV");
			if(SubObjectID!=null)SubObject.id=SubObjectID;
			SubObject.innerHTML=SubObjectContent;
		ParentObject.appendChild(SubObject);
}


function createXMLDom() {
	//如果是IE
	xmlDom = new ActiveXObject("Microsoft.XMLDOM");
	xmlDom.async=false;
}

//开始函数

function startXmlDom(_element,_type){
	xml_BackCont="";
	createXMLDom();
	if(_type){
		xmlDom.loadXml(_element);
	}else{
		xmlDom.load(_element);
	}
	xmlRoot=xmlDom.documentElement;
}
    

