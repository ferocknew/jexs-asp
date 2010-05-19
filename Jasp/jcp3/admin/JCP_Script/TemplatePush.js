// JavaScript Document
var doc=document;
var PushCase=new Array();
var PushStartTime,PushEndTime;
var StepCount=1,CurStep=0;
var PushDelayTime=1; //����
var CcaseCollect;
var PushState=false;

function pushBar(fwidth,bg,fg,bwidth,bheight,fpadding){
	var _PushBar=doc.getElementById("PushBar");
	if(!_PushBar){
		var PushBarHTML='<div style="overflow:hidden;">' +
						'	<div id="PushBar" style="overflow:hidden;height:100%;float:left;text-align:center;"></div>' +
						'</div>' +
						'<div id="PushTime" style="width:100%;padding:6px 0 6px 4px;"></div>' +
						'<div id="PushState" style="width:100%;padding:padding:6px 0 6px 4px;"></div>';
		doc.write(PushBarHTML);
		_PushBar=doc.getElementById("PushBar");
	}
	if(bwidth) _PushBar.parentNode.style.width=bwidth;
	if(bheight) _PushBar.parentNode.style.height=bheight;
	if(fpadding) _PushBar.style.paddingTop=fpadding;
	if(bg){
		_PushBar.parentNode.style.background=bg;
		_PushBar.style.border="1px solid " + bg;
		_PushBar.style.color=bg;
	}
	if(fg){
		_PushBar.style.background=fg;
		_PushBar.parentNode.style.border="1px solid " + fg;
	}
	if(fwidth){
		_PushBar.style.width=fwidth;
		_PushBar.innerHTML=fwidth;
	}
}

function curStep(){
	var _curstep=parseInt(CurStep / StepCount * 100);
	return _curstep.toString() + "%";
}

function pushTime(){
	if(PushStartTime){
		PushEndTime=(new Date()).getTime();
		var _showTime,_ms,_s,_m,_h,_d,_y,_lastTime;
		_lastTime=PushEndTime-PushStartTime;
						 _ms=_lastTime % 1000;_lastTime=parseInt(_lastTime / 1000);
		if(_lastTime>0)	{_s =_lastTime % 60  ;_lastTime=parseInt(_lastTime / 60);}
			else 		_showTime=_ms.toString() + " ����";
		if(_lastTime>0) {_m =_lastTime % 60  ;_lastTime=parseInt(_lastTime / 60);}
			else if(_s) _showTime=_s.toString() + " �� " + _ms.toString() + " ����";
		if(_lastTime>0) {_h =_lastTime % 24  ;_lastTime=parseInt(_lastTime / 24);}
			else if(_m) _showTime=_m.toString() + " �� " + _s.toString() + " �� " + _ms.toString() + " ����";
		if(_lastTime>0) {_d =_lastTime % 365 ;_y=parseInt(_lastTime / 365);}
			else if(_h) _showTime=_h.toString() + " Сʱ " + _m.toString() + " �� " + _s.toString() + " �� " + _ms.toString() + " ����";
		if(_d)			_showTime=_d.toString() + " �� " + _h.toString() + " Сʱ " + _m.toString() + " �� " + _s.toString() + " �� " + _ms.toString() + " ����";
		if(_y)			_showTime=_y.toString() + " �� " + _d.toString() + " �� " + _h.toString() + " Сʱ " + _m.toString() + " �� " + _s.toString() + " �� " + _ms.toString() + " ����";
		doc.getElementById("PushTime").innerHTML="���ͺ�ʱ��" + _showTime;
	}else doc.getElementById("PushTime").innerHTML="���ͺ�ʱ��...";
}

function addPushCase(caseType,caseValue,caseExp,pushType){
	PushCase[PushCase.length]=[caseType,caseValue,caseExp,pushType];
}

function clearPushCase(){
	PushCase=new Array();
	PushStartTime="";
}

function PushStateShow(strs,type){
	if(type==2){
		doc.getElementById("PushState").firstChild.innerHTML += strs;
	}else{
		var cont=doc.createElement('<div class="ViewListItem"></div>');
		cont.innerHTML = strs;
		doc.getElementById("PushState").insertBefore(cont,doc.getElementById("PushState").firstChild);
	}
	pushTime();
}

function IniSystem(){
	doc.getElementById("PushState").innerHTML="";
	doc.getElementById("PushTime").innerHTML="";
	CurStep=0;StepCount=1;
	pushBar(curStep());
}
	
function PushNow(_caseCollect){
	if(!PushState){
		if(!confirm("���Ͳ���������ǰ̨����ҳ�棬��ȷ��ִ���𣿣�")){
			IniSystem(); 
			return false;
		}
		PushState=true;
		PushStartTime=(new Date()).getTime();
		CcaseCollect=_caseCollect;
		doc.getElementById("push_button").disabled=true;
		Step_1();
	}else{
		//alert("�������ڽ�����,���Ժ���ִ��!");
		return false;
	}
}
function Step_1(){
	//ϵͳ��ʼ��
	PushStateShow(">> ϵͳ��ʼ��");
	IniSystem(); 
	Step_2();
}
function Step_2(){
	//�ɼ���������
	PushStateShow(">> �ɼ���������"); 
	eval(CcaseCollect);
	Step_3();
}
function Step_3(){
	//��������
	PushStateShow(">> ��������"); 
	if(PushCase.length>0){
		StepCount=PushCase.length + 2;
		setTimeout('Step_3_app()',PushDelayTime);
	}else{
		PushStateShow(">> δ���������������Ͳ���ȡ����"); 
		Step_4();
	}
}
function Step_3_app(){
	//��ʼ����
		PushStateShow(">> ��ʼ���� ������"); 
		CurStep++;pushBar(curStep());
		setTimeout('Step_3_app_app()',PushDelayTime);
}
function Step_3_app_app(){
		var pushCaseStep=CurStep-1;
		PushStateShow(">> " + PushCase[pushCaseStep][2]); 
		startXmlRequest("POST","JCP_PushFunction.asp?casetype=" + PushCase[pushCaseStep][0] + "&casevalue=" + PushCase[pushCaseStep][1] + "&pushType=" + PushCase[pushCaseStep][3],null,"body","","",false);
		if(xml_BackCont.indexOf("OK")==0){
			if(xml_BackCont=="OK") PushStateShow('����<font color=blue>���</font>',2);
			else PushStateShow('����<font color=blue>���</font> <span style="color:green;cursor:hand;" onclick="if(this.innerHTML==\'�鿴\'){PushList' + pushCaseStep + '.style.display=\'block\';this.innerHTML=\'�ر�\';}else{PushList' + pushCaseStep + '.style.display=\'none\';this.innerHTML=\'�鿴\';}">�鿴</span><div id="PushList' + pushCaseStep + '" class="ViewList_PushList" style="display:none;">' + xml_BackCont.replace("OK","") + '</div>',2);
		}else PushStateShow("����<font color=red>" + xml_BackCont + "</font>",2);
		CurStep++;pushBar(curStep());
		if(pushCaseStep<PushCase.length-1){
			setTimeout('Step_3_app_app()',PushDelayTime);
		}else{
		//���ͽ��� 
			CurStep++;pushBar(curStep());
			PushStateShow(">> ���ͽ��� ������"); 
			setTimeout('Step_4()',PushDelayTime);
		}
}
function Step_4(){
	doc.getElementById("push_button").disabled=false;
	clearPushCase();
	PushState=false;
}