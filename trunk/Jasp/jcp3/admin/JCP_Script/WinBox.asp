// �๦�ܲ㴰��
// �汾��Version 1.0
// ���ߣ�������ʿ QQ:37802181 E-mail:likeus918@163.com (ϣ������������Ϣ���Ա㴫������)
// ��ӭ����ʹ���߽���
/*
  ����: WinBox_Create(ID,STYLE,LEFT,TOP,WIDTH,HEIGHT,TITLE,POSITION_TYPE);
  
			ID: �ַ�����
				����ID��ֵ����Ψһ
		 STYLE: �ַ�����
				������ʽ����ѡ������ left,close_only,no_button,no_title,no_float,modal�������ʹ��
				      left  ������LEFT��TOP���õ�ֵΪ���Ͻ�λ�ã���������չ
				close_only  ����ֻ��ʾ���رա���ť
				 no_button  ���ڲ���ʾ�κΰ�ť
				  no_title  ����û�б�������Ϊ�ޱ��ⴰ�ڣ���ťȫ��ʧЧ
				     modal  ģʽ���ڣ��б����ڵ�����ֹ��������
				  no_float  �Ǹ������ڣ������� <div></div> �ڣ�����ID����CSS��ʽ
				  Ĭ��Ϊ�� ������׼���ڣ��� ����������С����ť����ԭ��ť���رհ�ť 
		  LEFT: ��ֵ����
				���STYLE:leftʹ�ã�������Ч
		   TOP: ��ֵ����
				���STYLE:leftʹ�ã�������Ч
		 WIDTH: ��ֵ����
				�������������
		HEIGHT: ��ֵ����
				�����������߶�
		 TITLE: �ַ�����
				���ڱ��⣬�ɺ�����ͼ�꣨���֡�ͼƬ��
 POSITION_TYPE: ��ֵ����
 				��������ڸ�����λ�ã���ѡ������ 1,2,3
				1 ����λ��position:absolute;
				2 ����λ��position:relative;
				3 ����λ��position������;
				
  ע�⣺����������Զ������봰�ڣɣĶ�Ӧ�ĺ��������������봰������
  ������������ʽΪ��function JS_���ڣɣ�(WinBox,WinBox_Content){}
  ������WinBox -- ���ڶ�����    WinBox_Content -- �������������ƣ�����������������
		
  ʾ��: WinBox_Create("YEAH","left,no_title",300,200,400,300,"�� �ҵ��",1);'
  		WinBox_Create("we","no_float,no_title",0,0,200,100,"�� ����",3);
*/

var doc=document;
var docall=document.all;
var Wins="|";					//�������ڿ⣬Ĭ��ֵ����Ϊ��ֱ�ߣ�"|"
var WinBox_Window_LoadTime=10;	//���ڵĴ�������ʱ����ΪN����
var WinBox_Window_LoadRate=5;	//���ڵĴ�������Ƶ��ΪN+1��N+2��
var WinBox_Width_ini=180;		//���ڳ�ʼ�����
var WinBox_Height_ini=1;		//���ڳ�ʼ���߶� 

//  --  ����ͼƬ���뿪ʼ
var Sys_WinWidth,Sys_WinHeight,WinBox_Img_Top_01,WinBox_Img_Top_02,WinBox_Img_Top_03,WinBox_Img_Top_01_no,WinBox_Img_Top_02_no,WinBox_Img_Top_03_no,WinBox_Img_Center_01,WinBox_Img_Center_02,WinBox_Img_Center_03,WinBox_Img_Bottom_01,WinBox_Img_Bottom_02,WinBox_Img_Bottom_03,WinBox_Img_Small,WinBox_Img_Rebig,WinBox_Img_Close,WinBox_Img_CloseOnly,WinBox_Img_Loader;
var WinBox_01 = new Image();var WinBox_02 = new Image();var WinBox_03 = new Image();var WinBox_01_no = new Image();var WinBox_02_no = new Image();var WinBox_03_no = new Image();var WinBox_04 = new Image();var WinBox_05 = new Image();var WinBox_06 = new Image();var WinBox_07 = new Image();var WinBox_08 = new Image();var WinBox_09 = new Image();var WinBox_10 = new Image();var WinBox_11 = new Image();var WinBox_12 = new Image();var WinBox_13 = new Image();var WinBox_14 = new Image(); 
WinBox_Img_Top_01    = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/top_01.gif";
WinBox_Img_Top_02    = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/top_02.jpg";
WinBox_Img_Top_03    = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/top_03.gif";
WinBox_Img_Top_01_no = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/top_01_core.gif";
WinBox_Img_Top_02_no = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/top_02_core.jpg";
WinBox_Img_Top_03_no = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/top_03_core.gif";
WinBox_Img_Center_01 = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/left.jpg";
WinBox_Img_Center_02 = "#FFF";					//Ψһ��һ�������ֵΪ ��ɫ(�磺#FFF) �� ͼƬ��ַ���磺url(image/**.gif)����
WinBox_Img_Center_03 = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/right.jpg";
WinBox_Img_Bottom_01 = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/bottom_01.gif";
WinBox_Img_Bottom_02 = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/bottom_02.jpg";
WinBox_Img_Bottom_03 = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/bottom_03.gif";
WinBox_Img_Loader    = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/loader.gif";
WinBox_Img_Small     = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/small.jpg";
WinBox_Img_Rebig     = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/rebig.jpg";
WinBox_Img_Close     = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/close.jpg";
WinBox_Img_CloseOnly = "../JCP_Skin/<%= session("SystemSkin") %>/WinBox/close_only.jpg";
WinBox_01.src = WinBox_Img_Top_01;WinBox_02.src = WinBox_Img_Top_02;WinBox_03.src = WinBox_Img_Top_03;WinBox_01_no.src = WinBox_Img_Top_01_no;WinBox_02_no.src = WinBox_Img_Top_02_no;WinBox_03_no.src = WinBox_Img_Top_03_no;WinBox_04.src = WinBox_Img_Center_01;WinBox_05.src = WinBox_Img_Center_02;WinBox_06.src = WinBox_Img_Center_03;WinBox_07.src = WinBox_Img_Bottom_01;WinBox_08.src = WinBox_Img_Bottom_02;WinBox_09.src = WinBox_Img_Bottom_03;WinBox_10.src = WinBox_Img_Loader;WinBox_11.src = WinBox_Img_Small;WinBox_12.src = WinBox_Img_Rebig;WinBox_13.src = WinBox_Img_Close;WinBox_14.src = WinBox_Img_CloseOnly;
//  --  ����ͼƬ�������

//  --  ���ڳߴ���㿪ʼ
var WinBox_Left_Width=WinBox_01.width;
var WinBox_Right_Width=WinBox_03.width;
var WinBox_Top_Height=WinBox_01.height;
var WinBox_Bottom_Height=WinBox_07.height;
var WinBox_Top_Height_no=WinBox_01_no.height;
//  --  ���ڳߴ�������
//var WinBox_Current_zIndex;
function WinBox_Ini(){
	Sys_WinWidth=doc.body.clientWidth;
	Sys_WinHeight=doc.body.clientHeight;
}
function WinBox_Create(WinBox_Name,WinBox_OpenType,WinBox_Left,WinBox_Top,WinBox_Content_Width,WinBox_Content_Height,WinBox_Title,WinBox_PositionType){
	if(WinBox_Name==null||WinBox_Name.toString()==""){
		alert("����ʧ�ܣ�\n\n���ܴ���û��ID�Ĵ��ڣ�");
		return false;
	}else if(Wins.indexOf("|" + WinBox_Name + "|")>=0){
		alert("����ʧ�ܣ�\n\n���������ڵ�ID�Ѿ����ڣ�");
		return false;
	}else{
		if(WinBox_OpenType.indexOf("no_float")<0){
			WinBox_Ini();
			var WinBox_Title_Buttons="";
			if(WinBox_OpenType.indexOf("close_only")>=0){    			//����ֻ���֡��رա���ť
				WinBox_Title_Buttons+='<div class="close" title="�ر�" onclick="javascript:WinBox_Close(\'' + WinBox_Name + '\');"><img src="' + WinBox_Img_CloseOnly + '" border="0"></div>';
			}else if(WinBox_OpenType.indexOf("no_button")>=0){		//���ڲ������κΰ�ť
				WinBox_Title_Buttons="";
			}else{														//���ڳ���ȫ����ť���رա���ԭ����С����
				WinBox_Title_Buttons+='<div class="close" title="�ر�" onclick="javascript:WinBox_Close(\'' + WinBox_Name + '\');"><img src="' + WinBox_Img_Close + '" border="0"></div><div class="rebig"><img src="' + WinBox_Img_Rebig + '" border="0"></div><div class="small"><img src="' + WinBox_Img_Small + '" border="0"></div>';
			}
			var subWin=Wins.split("|");
			var divHTML='<div id="' + WinBox_Name + '" style="z-index:' + subWin.length.toString() + ';" class="WinBox WinBox_Select" onmousedown="WinBox_Select(this);startgrap(this);" onmouseup="stopgrap(this);" onmousemove="grap(this);"></div>';
			var div=doc.createElement(divHTML);
			var divContentHTML="";
			if(WinBox_OpenType.indexOf("no_title")>=0){
				divContentHTML='<div class="TitleBar" style="height:' + WinBox_Top_Height_no + 'px;"><div class="TitleBar_Left" style="width:' + WinBox_Left_Width + 'px;background:url(' + WinBox_Img_Top_01_no + ') no-repeat 0 0;"></div><div class="TitleBar_Title" id="WinBox_Title_' + WinBox_Name + '" style="background:url(' + WinBox_Img_Top_02_no + ') repeat 0 0;"></div><div class="TitleBar_Right" style="width:' + WinBox_Right_Width + 'px;" style="background:url(' + WinBox_Img_Top_03_no + ') no-repeat 0 0;"></div></div>'
			}else{
				divContentHTML='<div class="TitleBar" style="height:' + WinBox_Top_Height + 'px;"><div class="TitleBar_Left" style="width:' + WinBox_Left_Width + 'px;background:url(' + WinBox_Img_Top_01 + ') no-repeat 0 0;"></div><div class="TitleBar_Title" id="WinBox_Title_' + WinBox_Name + '" style="background:url(' + WinBox_Img_Top_02 + ') repeat 0 0;">' + WinBox_Title_Buttons + '<div class="Title_back">' + WinBox_Title + '</div><div class="Title">' + WinBox_Title + '</div></div><div class="TitleBar_Right" style="width:' + WinBox_Right_Width + 'px;" style="background:url(' + WinBox_Img_Top_03 + ') no-repeat 0 0;"></div></div>'
			}
			div.innerHTML = divContentHTML +
							'<div class="Content" id="WinBox_ContentBox_' + WinBox_Name + '"><div class="Content_Left" style="width:' + WinBox_Left_Width + 'px;background:url(' + WinBox_Img_Center_01 + ') repeat 0 0;"></div><div class="WinBox_Content" id="WinBox_Content_' + WinBox_Name + '" style="background:' + WinBox_Img_Center_02 + ';"><div id="Loader"><img src="' + WinBox_Img_Loader + '" style="valign:middle;"><span class="Load_Font">�����У����Ժ� ......</span></div></div><div class="Content_Right" style="width:' + WinBox_Right_Width + 'px;background:url(' + WinBox_Img_Center_03 + ') repeat 0 0;"></div></div>'+
							'<div class="BottomBar" style="height:' + WinBox_Bottom_Height + 'px;background:url(' + WinBox_Img_Bottom_01 + ') no-repeat 0 0;""><div class="BottomBar_Left" style="width:' + WinBox_Left_Width + 'px;"></div><div class="BottomBar_Center" id="WinBox_BottomBar_' + WinBox_Name + '" style="background:url(' + WinBox_Img_Bottom_02 + ') repeat 0 0;"></div><div class="BottomBar_Right" style="width:' + WinBox_Right_Width + 'px;background:url(' + WinBox_Img_Bottom_03 + ') no-repeat 0 0;"></div></div>';
			if(WinBox_OpenType.indexOf("left")>=0){
				div.style.left=WinBox_Left.toString() + "px";
				div.style.top=WinBox_Top.toString() + "px";
			}else{
				div.style.left=(parseInt(Sys_WinWidth-WinBox_Width_ini-WinBox_Left_Width-WinBox_Right_Width)/2).toString() + "px";
				div.style.top=(parseInt(Sys_WinHeight-WinBox_Height_ini-WinBox_Top_Height-WinBox_Bottom_Height)/2).toString() + "px";
			}
			div.style.width=(WinBox_Width_ini+WinBox_Left_Width+WinBox_Right_Width).toString() + "px";
			if(WinBox_OpenType.indexOf("no_title")>=0){
				div.style.height=(WinBox_Height_ini+WinBox_Top_Height_no+WinBox_Bottom_Height).toString() + "px";
			}else{
				div.style.height=(WinBox_Height_ini+WinBox_Top_Height+WinBox_Bottom_Height).toString() + "px";
			}
			if(WinBox_PositionType==1){
				div.style.position="absolute";
			}else if(WinBox_PositionType==2){
				div.style.position="relative";
			}
			
			Wins=Wins + WinBox_Name + "|";						//���½����ڵ�ID���봰�ڿ�(Wins)						
			if(subWin.length>2){
				for(i=1;i<subWin.length-1;i++){
					eval('docall.' + subWin[i] + '.className="WinBox WinBox_unSelect"');	//�½�����ǰ�������д������ó�unSelect״̬
				}
			}
			if(WinBox_OpenType.indexOf("modal")>=0){
				var div_modal=doc.createElement('<div id="Modal_' + WinBox_Name + '" class="WinBox_modal"></div>');
				doc.body.appendChild(div_modal);							//�����´��ڵı����ڸǲ�
			}
			doc.body.appendChild(div);							//�����´���
			eval('docall.WinBox_Title_' + WinBox_Name + '.style.width="' + WinBox_Width_ini.toString() + 'px"');			//��ʼ�������е���سߴ�
			eval('docall.WinBox_Content_' + WinBox_Name + '.style.width="' + WinBox_Width_ini.toString() + 'px"');   
			eval('docall.WinBox_BottomBar_' + WinBox_Name + '.style.width="' + WinBox_Width_ini.toString() + 'px"');
			eval('docall.WinBox_ContentBox_' + WinBox_Name + '.style.height="' + WinBox_Height_ini.toString() + 'px"');
			WinBox_Load(WinBox_Name,WinBox_OpenType,WinBox_Content_Width,WinBox_Content_Height);		//������������ 
		
		}else{
			var divContentHTML,divHTML,divPosition;
			if(WinBox_OpenType.indexOf("no_title")>=0){
				divContentHTML='<div class="TitleBar" style="height:' + WinBox_Top_Height_no + 'px;"><div class="TitleBar_Left" style="width:' + WinBox_Left_Width + 'px;background:url(' + WinBox_Img_Top_01_no + ') no-repeat 0 0;"></div><div class="TitleBar_Title" id="WinBox_Title_' + WinBox_Name + '" style="background:url(' + WinBox_Img_Top_02_no + ') repeat 0 0;width:' + WinBox_Content_Width.toString() + 'px;"></div><div class="TitleBar_Right" style="width:' + WinBox_Right_Width + 'px;" style="background:url(' + WinBox_Img_Top_03_no + ') no-repeat 0 0;"></div></div>'
			}else{
				divContentHTML='<div class="TitleBar" style="height:' + WinBox_Top_Height + 'px;"><div class="TitleBar_Left" style="width:' + WinBox_Left_Width + 'px;background:url(' + WinBox_Img_Top_01 + ') no-repeat 0 0;"></div><div class="TitleBar_Title" id="WinBox_Title_' + WinBox_Name + '" style="background:url(' + WinBox_Img_Top_02 + ') repeat 0 0;width:' + WinBox_Content_Width.toString() + 'px;"><div class="Title_back">' + WinBox_Title + '</div><div class="Title">' + WinBox_Title + '</div></div><div class="TitleBar_Right" style="width:' + WinBox_Right_Width + 'px;" style="background:url(' + WinBox_Img_Top_03 + ') no-repeat 0 0;"></div></div>'
			}
			divContentHTML = divContentHTML +
							'<div class="Content" id="WinBox_ContentBox_' + WinBox_Name + '" style="height:' + WinBox_Content_Height.toString() + 'px;"><div class="Content_Left" style="width:' + WinBox_Left_Width + 'px;background:url(' + WinBox_Img_Center_01 + ') repeat 0 0;"></div><div class="WinBox_Content" id="WinBox_Content_' + WinBox_Name + '" style="background:' + WinBox_Img_Center_02 + ';width:' + WinBox_Content_Width.toString() + 'px;"><div id="Loader"><img src="' + WinBox_Img_Loader + '" style="valign:middle;"><span class="Load_Font">�����У����Ժ� ......</span></div></div><div class="Content_Right" style="width:' + WinBox_Right_Width + 'px;background:url(' + WinBox_Img_Center_03 + ') repeat 0 0;"></div></div>'+
							'<div class="BottomBar" style="height:' + WinBox_Bottom_Height + 'px;background:url(' + WinBox_Img_Bottom_01 + ') no-repeat 0 0;""><div class="BottomBar_Left" style="width:' + WinBox_Left_Width + 'px;"></div><div class="BottomBar_Center" id="WinBox_BottomBar_' + WinBox_Name + '" style="background:url(' + WinBox_Img_Bottom_02 + ') repeat 0 0;width:' + WinBox_Content_Width.toString() + 'px;"></div><div class="BottomBar_Right" style="width:' + WinBox_Right_Width + 'px;background:url(' + WinBox_Img_Bottom_03 + ') no-repeat 0 0;"></div></div>';
			if(WinBox_PositionType==1){
				divPosition="absolute";
			}else if(WinBox_PositionType==2){
				divPosition="relative";
			}else divPosition="";
			if(WinBox_OpenType.indexOf("no_title")>=0){
				divHTML='<div id="' + WinBox_Name + '" style="height:' + (WinBox_Content_Height+WinBox_Top_Height_no+WinBox_Bottom_Height).toString() + ';width:' + (WinBox_Content_Width+WinBox_Left_Width+WinBox_Right_Width).toString() + ';position:' + divPosition + ';" class="WinBox WinBox_Select">' + divContentHTML + '</div>';
			}else{
				divHTML='<div id="' + WinBox_Name + '" style="height:' + (WinBox_Content_Height+WinBox_Top_Height+WinBox_Bottom_Height).toString() + ';width:' + (WinBox_Content_Width+WinBox_Left_Width+WinBox_Right_Width).toString() + ';position:' + divPosition + ';" class="WinBox WinBox_Select">' + divContentHTML + '</div>';
			}
			document.write(divHTML); 
		}
	}
}
function WinBox_Load(WinBox_Name,WinBox_OpenType,WinBox_Content_Width,WinBox_Content_Height){
	var temp_Height_add,temp_Height_add_last,temp_Width_add,temp_Width_add_last;
	temp_Height_add = parseInt((WinBox_Content_Height-WinBox_Height_ini)/WinBox_Window_LoadRate);
	temp_Width_add  = parseInt((WinBox_Content_Width-WinBox_Width_ini)/WinBox_Window_LoadRate);
	setTimeout("WinBox_Window_Load('" + WinBox_Name + "','" + WinBox_OpenType + "'," + WinBox_Content_Width + "," + WinBox_Content_Height + "," + temp_Width_add + "," + temp_Height_add + ")",WinBox_Window_LoadTime);	//���ڵĴ�������
}
function WinBox_Window_Load(WinBox_Name,WinBox_OpenType,WinBox_Content_Width,WinBox_Content_Height,temp_Width_add,temp_Height_add){
	var temp_Height,temp_Width,temp_Width_dist,temp_Height_dist,temp_Left,temp_Top;
	temp_Height=parseInt(eval('docall.WinBox_ContentBox_' + WinBox_Name + '.style.height').toLowerCase().replace("px",""));
	temp_Width =parseInt(eval('docall.WinBox_Content_' + WinBox_Name + '.style.width').toLowerCase().replace("px",""));
	temp_Left=parseInt(eval('docall.' + WinBox_Name + '.style.left').toLowerCase().replace("px",""));
	temp_Top =parseInt(eval('docall.' + WinBox_Name + '.style.top').toLowerCase().replace("px",""));
	temp_Width_dist =WinBox_Content_Width-temp_Width;
	temp_Height_dist=WinBox_Content_Height-temp_Height;
	if(temp_Height_dist>0||temp_Width_dist>0){
		if(temp_Width_dist<temp_Width_add && temp_Width_dist>0) temp_Width_add=temp_Width_dist;
		if(temp_Height_dist<temp_Height_add && temp_Height_dist>0) temp_Height_add=temp_Height_dist;
		temp_Width+=temp_Width_add;
		temp_Height+=temp_Height_add;
		eval('docall.' + WinBox_Name + '.style.width="' + (temp_Width+20).toString() + 'px"');
		eval('docall.' + WinBox_Name + '.style.height="' + (temp_Height+40).toString() + 'px"');
		if(WinBox_OpenType.indexOf("left")<0){
			eval('docall.' + WinBox_Name + '.style.left="' + (temp_Left-parseInt(temp_Width_add/2)).toString() + 'px"');
			eval('docall.' + WinBox_Name + '.style.top="' + (temp_Top-parseInt(temp_Height_add/2)).toString() + 'px"');
		}
		eval('docall.WinBox_Title_' + WinBox_Name + '.style.width="' + temp_Width.toString() + 'px"');			
		eval('docall.WinBox_Content_' + WinBox_Name + '.style.width="' + temp_Width.toString() + 'px"');
		eval('docall.WinBox_BottomBar_' + WinBox_Name + '.style.width="' + temp_Width.toString() + 'px"');
		eval('docall.WinBox_ContentBox_' + WinBox_Name + '.style.height="' + temp_Height.toString() + 'px"');
		setTimeout("WinBox_Window_Load('" + WinBox_Name + "','" + WinBox_OpenType + "'," + WinBox_Content_Width + "," + WinBox_Content_Height + "," + temp_Width_add + "," + temp_Height_add + ")",WinBox_Window_LoadTime);
	}else{
		try{		//�����������룬�����븡���������ƶ�Ӧ��JS����
			if(typeof(eval("JS_" + WinBox_Name))=="function") eval("JS_" + WinBox_Name + "(WinBox_Name,WinBox_Content_" + WinBox_Name + ")");
			//eval("WinBox_Content_" + WinBox_Name).style.align="left";
		}catch(e){alert("���ڴ򿪺󣬵������ݺ�������");}
	}
	clearTimeout();
	return false;
}
function WinBox_Select(WinBox_Selected){					//�����л�ʱ�����ú�����͸���ȡ�z-indexֵ
	selectZindex=WinBox_Selected.style.zIndex;
	var subWin=Wins.split("|");
		if(subWin.length>2){
			for(i=1;i<subWin.length-1;i++){
				if(WinBox_Selected.id!=subWin[i]){
					eval('docall.' + subWin[i] + '.className="WinBox WinBox_unSelect"');
					if(eval('docall.' + subWin[i] + '.style.zIndex')>selectZindex) eval('docall.' + subWin[i] + '.style.zIndex--');
				}
			}
		}
	WinBox_Selected.className="WinBox WinBox_Select";			//��ѡ�д���͸��������
	WinBox_Selected.style.zIndex=100+subWin.length-1;			//��ѡ�д���z-indexֵ����
} 
function WinBox_Close(WinBox_Closed){
	try{		//�رմ��ڣ������븡���������ƶ�Ӧ�Ĺر�JS������Ŀǰ�޴��ݲ���
		if(typeof(eval("JS_Close_" + WinBox_Closed))=="function") eval("JS_Close_" + WinBox_Closed + "()");
	}catch(e){
		//alert("���ڹر�ǰ�����ùر�ǰ��������");
	}
	Wins=Wins.replace(WinBox_Closed + "|","");
	doc.body.removeChild(doc.getElementById(WinBox_Closed));
	if(doc.getElementById("Modal_" + WinBox_Closed)){
		doc.body.removeChild(doc.getElementById("Modal_" + WinBox_Closed));
	}
}

//����Ϊ�����ƶ����ƺ���
var moveable = false;
function startgrap(obj){                        
	if(event.button==1||event.button==2){
		//obj.setCapture();
		x0 = event.clientX;
		y0 = event.clientY;
		x1 = parseInt(obj.style.left);
		y1 = parseInt(obj.style.top);
		moveable = true;
	}
}

function stopgrap(obj){
	if(moveable){
		obj.releaseCapture();
		moveable = false;
	}
}

function grap(obj){
	if(moveable){
		if(event.clientX>4&&event.clientX<doc.body.clientWidth-4&&event.clientY>4&&event.clientY<doc.body.clientHeight){               
			obj.style.left = x1 + event.clientX - x0;
			obj.style.top  = y1 + event.clientY - y0;
		}
	}
}
