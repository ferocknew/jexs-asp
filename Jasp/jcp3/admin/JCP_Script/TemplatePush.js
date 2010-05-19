// JavaScript Document
var doc=document;
var PushCase=new Array();
var PushStartTime,PushEndTime;
var StepCount=1,CurStep=0;
var PushDelayTime=1; //毫秒
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
			else 		_showTime=_ms.toString() + " 毫秒";
		if(_lastTime>0) {_m =_lastTime % 60  ;_lastTime=parseInt(_lastTime / 60);}
			else if(_s) _showTime=_s.toString() + " 秒 " + _ms.toString() + " 毫秒";
		if(_lastTime>0) {_h =_lastTime % 24  ;_lastTime=parseInt(_lastTime / 24);}
			else if(_m) _showTime=_m.toString() + " 分 " + _s.toString() + " 秒 " + _ms.toString() + " 毫秒";
		if(_lastTime>0) {_d =_lastTime % 365 ;_y=parseInt(_lastTime / 365);}
			else if(_h) _showTime=_h.toString() + " 小时 " + _m.toString() + " 分 " + _s.toString() + " 秒 " + _ms.toString() + " 毫秒";
		if(_d)			_showTime=_d.toString() + " 天 " + _h.toString() + " 小时 " + _m.toString() + " 分 " + _s.toString() + " 秒 " + _ms.toString() + " 毫秒";
		if(_y)			_showTime=_y.toString() + " 年 " + _d.toString() + " 天 " + _h.toString() + " 小时 " + _m.toString() + " 分 " + _s.toString() + " 秒 " + _ms.toString() + " 毫秒";
		doc.getElementById("PushTime").innerHTML="推送耗时：" + _showTime;
	}else doc.getElementById("PushTime").innerHTML="推送耗时：...";
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
		if(!confirm("推送操作将覆盖前台现有页面，您确定执行吗？？")){
			IniSystem(); 
			return false;
		}
		PushState=true;
		PushStartTime=(new Date()).getTime();
		CcaseCollect=_caseCollect;
		doc.getElementById("push_button").disabled=true;
		Step_1();
	}else{
		//alert("推送正在进行中,请稍后再执行!");
		return false;
	}
}
function Step_1(){
	//系统初始化
	PushStateShow(">> 系统初始化");
	IniSystem(); 
	Step_2();
}
function Step_2(){
	//采集推送任务
	PushStateShow(">> 采集推送任务"); 
	eval(CcaseCollect);
	Step_3();
}
function Step_3(){
	//分析数据
	PushStateShow(">> 分析数据"); 
	if(PushCase.length>0){
		StepCount=PushCase.length + 2;
		setTimeout('Step_3_app()',PushDelayTime);
	}else{
		PushStateShow(">> 未发现推送任务，推送操作取消！"); 
		Step_4();
	}
}
function Step_3_app(){
	//开始推送
		PushStateShow(">> 开始推送 ↑↑↑"); 
		CurStep++;pushBar(curStep());
		setTimeout('Step_3_app_app()',PushDelayTime);
}
function Step_3_app_app(){
		var pushCaseStep=CurStep-1;
		PushStateShow(">> " + PushCase[pushCaseStep][2]); 
		startXmlRequest("POST","JCP_PushFunction.asp?casetype=" + PushCase[pushCaseStep][0] + "&casevalue=" + PushCase[pushCaseStep][1] + "&pushType=" + PushCase[pushCaseStep][3],null,"body","","",false);
		if(xml_BackCont.indexOf("OK")==0){
			if(xml_BackCont=="OK") PushStateShow('　　<font color=blue>完成</font>',2);
			else PushStateShow('　　<font color=blue>完成</font> <span style="color:green;cursor:hand;" onclick="if(this.innerHTML==\'查看\'){PushList' + pushCaseStep + '.style.display=\'block\';this.innerHTML=\'关闭\';}else{PushList' + pushCaseStep + '.style.display=\'none\';this.innerHTML=\'查看\';}">查看</span><div id="PushList' + pushCaseStep + '" class="ViewList_PushList" style="display:none;">' + xml_BackCont.replace("OK","") + '</div>',2);
		}else PushStateShow("　　<font color=red>" + xml_BackCont + "</font>",2);
		CurStep++;pushBar(curStep());
		if(pushCaseStep<PushCase.length-1){
			setTimeout('Step_3_app_app()',PushDelayTime);
		}else{
		//推送结束 
			CurStep++;pushBar(curStep());
			PushStateShow(">> 推送结束 ↓↓↓"); 
			setTimeout('Step_4()',PushDelayTime);
		}
}
function Step_4(){
	doc.getElementById("push_button").disabled=false;
	clearPushCase();
	PushState=false;
}