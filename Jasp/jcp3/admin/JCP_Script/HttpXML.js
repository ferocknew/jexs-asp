var xmlHttp,xml_BackCont;
var xmlDom,xmlRoot;
//���½�һXHR����

function createXMLHttpRequest() {

//�����IE����activexobject
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } 

//����������������XMLHttpRequest
    else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}
    
//��ʼ����

function startXmlRequest(sendtype,strURL,strSEND,strTYPE,strAction,strExp,YN) {
	xml_BackCont="";
    createXMLHttpRequest();
    //ָ����readyState���Ըı�ʱִ�еĺ���
    xmlHttp.onreadystatechange = function(){handleStateChange(strTYPE,strAction,strURL,strExp)};  
��  //����һ���µ�http���󣬲�ָ��������ķ�����URL�Լ���֤��Ϣ 
    xmlHttp.open(sendtype, strURL, YN); 
    //��������http�����������ջ�Ӧ 
    xmlHttp.send(strSEND);
}
    
function handleStateChange(strTYPE,strAction,strURL,strExp){
��  //4���ݽ������ 
    if(xmlHttp.readyState == 4){ 
        //200��������״̬ΪOK
        //if(xmlHttp.status == 200){
	������//���ظ������͵�����,strTYPE=xml >> responseXML , strTYPE=body >> responsebody , strTYPE=text >> responseText
            if(strTYPE=="xml"){
				xml_BackCont=xmlHttp.responseXML;
			}else if(strTYPE=="text"){
				xml_BackCont=xmlHttp.responseText;
			}else if(strTYPE=="body"){
				xml_BackCont=xmlHttp.responseBody;
				xml_BackCont=bytes2BSTR(xml_BackCont);
			}else{
				xml_BackCont="û������Դ��";
			}
			eval(strAction);
        //}else{
		//	xml_BackCont="����ִ�д���";
		//}
	}
}
/*
[0]uninitializedδ��ʼ��(��XMLHttpRequest��ʼǰ)
[1]loading(һ����ʼ��)
[2]loaded(һ��XMLHttpRequest�ӷ������˻����Ӧ)
[3]interactive(���������ӵ�������)
[4]complete(���)
*/
function AddContent(ParentObject,SubObjectID,SubObjectContent){
		var SubObject=document.createElement("DIV");
			if(SubObjectID!=null)SubObject.id=SubObjectID;
			SubObject.innerHTML=SubObjectContent;
		ParentObject.appendChild(SubObject);
}


function createXMLDom() {
	//�����IE
	xmlDom = new ActiveXObject("Microsoft.XMLDOM");
	xmlDom.async=false;
}

//��ʼ����

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
    

