// JavaScript Document
function ModelWin(url,width,height){
	var arr = window.showModalDialog(url, window, "dialogWidth:" + width + "px;dialogHeight:" + height + "px;help:no;scroll:no;status:no");
	return arr;
}

function HTMLEncode(strs){
	strs=strs.replace(/\&/g,"&amp;");
	strs=strs.replace(/\</g,"&lt;");
	strs=strs.replace(/\>/g,"&gt;");
	strs=strs.replace(/\"/g,"&quot;");
	strs=strs.replace(/ /g,"&nbsp;");
	strs=strs.replace(/'/g,"&#039;");
	return strs;
}

function HTMLUnEncode(strs){
	strs=strs.replace(/\&lt\;/g,"<");
	strs=strs.replace(/\&gt\;/g,">");
	strs=strs.replace(/\&quot\;/g,"\"");
	strs=strs.replace(/\&nbsp\;/g," ");
	strs=strs.replace(/\&amp\;/g,"&");
	strs=strs.replace(/\&#039\;/g,"'");
	return strs;
}

function setcolor(object)
{
	var tempValue=document.getElementById(object).value.replace("#","");
	var arr = showModalDialog("../JCP_Shared/editor_selcolor.asp?oldcolor=" + tempValue, "", "dialogWidth:18.5em; dialogHeight:17.5em; help: no; scroll: no; status: no");
	if (arr != null && arr != "blank") {
		if(arr=="#NaNNaNNaN") arr="#FFFFFF";
		document.getElementById(object).value=arr;
		document.getElementById(object).style.background=arr;
	}else if (arr == "blank") {
		document.getElementById(object).value="";
		document.getElementById(object).style.background="#FFFFFF";
	}
	document.getElementById(object).blur();
}

//������д���֣�������ʾ
function IntCheck(tValue,o){
	if(!IntYn(tValue))
	{
		alert("������д���֣�");
		if(o){o.select();o.focus();}
		return false;
	}else return true;
}

//����Ϊ�գ�������ʾ
function BlankCheck(tValue,o){
	if(BlankYn(tValue))
	{
		alert("����Ϊ�գ����޸ģ�");
		if(o){o.select();o.focus();}
		return false;
	}else return true;
}

//�ַ�����������
function LenCheck(tValue,len,o){
	if(tValue.length>len)
	{
		alert("�ַ�������Ϊ��" + tValue.length + "��" + "���Ƴ���Ϊ��" + len + "\n\n���޸ģ�");
		if(o){o.select();o.focus();}
		return false;
	}else return true;
}

function FindPic(actid){
	var arr=ModelWin("JCP_ServerView.asp",504,400);
	if(actid){
		if(arr) document.getElementById(actid).value=arr;
		//else document.getElementById(id).value="";
	}else{
		if(arr) return arr;
		else return "noFile";
	}
}


function FindServerFile(actid){
	if(actid){
		var arr=ModelWin("../JCP_Tools/JCP_ServerFileView.asp?fileurl=" + document.getElementById(actid).value,504,400);
		if(arr){
			if(arr=="noFile") document.getElementById(actid).value="";
			else document.getElementById(actid).value=arr;
		}
		else return false;
	}else{
		var arr=ModelWin("../JCP_Tools/JCP_ServerFileView.asp",504,400);
		if(arr){
			return arr;
		}
		else return false;
	}
}

function FindUploadFile(actid,pathtype,filetype){
	var _pathtype="",_filetype="";
	if(actid){
		if(pathtype) _pathtype="&pathtype=" + pathtype.toString();
		if(filetype) _filetype="&filetype=" + filetype;
		var arr=ModelWin("../JCP_Tools/JCP_UploadFile.asp?fileurl=" + document.getElementById(actid).value + _pathtype + _filetype,400,190);
		if(arr){
			if(arr=="noFile") document.getElementById(actid).value="";
			else document.getElementById(actid).value=arr;
		}
		else return false;
	}else{
		if(pathtype) _pathtype="pathtype=" + pathtype + "&";
		if(filetype) _filetype="filetype=" + filetype + "&";
		var arr=ModelWin("../JCP_Tools/JCP_UploadFile.asp" + _pathtype + _filetype,400,190);
		if(arr){
			return arr;
		}
		else return false;
	}
}

function TextChange(o,act,illegalstrs){
	if(!act) act="";
	if(!illegalstrs) illegalstrs="";
	if(o.innerHTML.indexOf("<")>=0 && o.innerHTML.indexOf(">")>=0){
		if(!confirm("Ҫ�޸ĵ������ƺ����б�ǩ,��ȷ��Ҫ��������")) return false;
	}
	o.innerHTML='<input id="TextBox" type=text style="width:100px;height:18px;border:1px dotted #666;" value="' + o.innerHTML + '" title="' + o.innerHTML + '" onBlur="TextChangeOver(this,\'' + act + '\',\'' + illegalstrs + '\');">';
	o.childNodes[0].focus();
	o.childNodes[0].select();
}
function TextChangeOver(o,act,illegalstrs){
	if(IllegalCheck(o.value,o,illegalstrs)){
		if(o.value!=o.getAttribute("title")){
			if(act!=""){
				if(eval(act)) o.parentNode.innerHTML=o.value;
				else{
					if(confirm("�޸�ʧ�ܣ���\n\n[ȷ��] ��ԭ���ݡ�[ȡ��] �����޸�")) o.parentNode.innerHTML=o.getAttribute("title");
					else{
						o.select();
						o.focus();
						return false;
					}
				}
			}else o.parentNode.innerHTML=o.value;
		}else{
			o.parentNode.innerHTML=o.getAttribute("title");
		}
	}
}

function IllegalCheck(checkvalue,checkobj,illstrs,rangtype){				//rangtype-true/false �Ƿ��ڵ�ǰƥ���ִ��� true-���ִ���ƥ�� false-���ִ���ƥ��,Ĭ��Ϊtrue
	var t_illstrs= (illstrs&&illstrs!="")?illstrs:'\\/:*?"<>|\'';
	if(rangtype==false){
		for(i=0;i<checkvalue.length;i++){
			if(t_illstrs.indexOf(checkvalue.charAt(i))<0){
				alert("���зǷ��ַ���" + checkvalue.charAt(i).toString() + "������ɾ����");
				if(checkobj){
					checkobj.focus();
					checkobj.select();
				}
				return false;
				break;
			}
		}
	}else{
		for(i=0;i<t_illstrs.length;i++){
			if(checkvalue.indexOf(t_illstrs.charAt(i))>-1){
				alert("���зǷ��ַ���" + t_illstrs.charAt(i).toString() + "������ɾ����");
				if(checkobj){
					checkobj.focus();
					checkobj.select();
				}
				return false;
				break;
			}
		}
	}
	return true;
}

	
function reSize(w,h){
	window.dialogWidth  = w.toString() + "px";
	window.dialogHeight = h.toString() + "px";
}
this.resize=this.ReSize=reSize;
