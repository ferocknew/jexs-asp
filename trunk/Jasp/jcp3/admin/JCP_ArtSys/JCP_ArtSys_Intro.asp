<!--#include file="../JCP_Shared/asp_head.asp" -->
<!--#include file="../JCP_Shared/head.asp" -->
<script language="VBScript" src="../JCP_Script/HttpXML.vbs"></script>
<script language="JavaScript" src="../JCP_Script/HttpXML.js"></script>
<script language="JavaScript" src="../JCP_Script/CheckCenter.js"></script>
<script language="JavaScript" src="../JCP_Script/ToolsCenter.js"></script>
<script language="JavaScript">
<!--
	var doc=document;
	var SetupDelayTime=100; //����
	var IntroState=false;
	var srb,path;
	
	function SetupNow(){
		if(doc.getElementById("systempath").value!=""){
			path=HTMLEncode(doc.getElementById("systempath").value);
			srb=doc.getElementById("SetupReviewBox");
			srb.innerHTML="";
			IntroState=true;
			SetupReview("ϵͳ���뿪ʼ Ŀ��ϵͳ��ַ��" + path);
			setTimeout("ConfigFileCheck()",SetupDelayTime);
		}else{
			alert("����ָ��������ϵͳ��Ŀ���ļ��У�");
		}
	}
	
	function ConfigFileCheck(){
		SetupReview("ϵͳ�����ļ���� ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=configfilecheck",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("ConfigCheck()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ���Ҫ�������ļ������ڣ�</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function ConfigCheck(){
		SetupReview("ϵͳ�����ļ����� ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=configcheck",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("LogoOnlyOneCheck()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ������ļ��Ľṹ�����ϱ�׼��</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function LogoOnlyOneCheck(){
		SetupReview("ϵͳ�����ʶΨһ�Լ�� ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=logoonlyonecheck",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("InterfaceCheck()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�����ϵͳ��ĳЩ��ʶ�����ƽ̨�ظ������޸ģ�</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function InterfaceCheck(){
		SetupReview("ϵͳ�ӿ�������� ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=interfacecheck",xml,"body","","",false);
		if(xml_BackCont=="no need"){
			SetupReview("<font color=green>ͨ��</font>",2);
			setTimeout("SystemSetup()",SetupDelayTime);
		}else if(xml_BackCont=="no param"){
			SetupReview("<font color=green>����</font>",2);
			setTimeout("SystemSetup()",SetupDelayTime);
		}else if(xml_BackCont=="has param"){
			SetupReview("<font color=blue>����� ...</font>",2);
			setTimeout("InterfaceSet()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�ϵͳ�ӿ�������ó����ˣ�</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function InterfaceSet(){
		var interfaceRt=ModelWin("JCP_ArtSys_Intro_Action_ProperSet.asp?action=interfaceset",400,320);
		if(interfaceRt=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("SystemSetup()",SetupDelayTime);
		}else if(interfaceRt=="SKIP"){
			SetupReview("<font color=blue>������</font>",2);
			setTimeout("SystemSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>�󶨳�����</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function SystemSetup(){
		SetupReview("��ϵͳ��ϵͳ��Ŀ����������ƽ̨ ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=systemsetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("FileCopy()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�ϵͳ��������</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function FileCopy(){
		SetupReview("��������ļ� ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=filecopy",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("DatabaseSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ���������ļ�����</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function DatabaseSetup(){
		SetupReview("�������ݱ� ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=databasesetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("ConfigSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ��������ݱ����</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
/*	
	function PurviewSetup(){
		SetupReview("Ϊϵͳ������ӦȨ�޼�Ȩ���� ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=purviewsetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("ConfigSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�����ϵͳ��ӦȨ��(��)����</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function BlockSetup(){
		SetupReview("��ϵͳģ�鴴��������ƽ̨ ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=blocksetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("ConfigSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�����ģ�����</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
*/
	function ConfigSetup(){
		SetupReview("��ϵͳ�����ļ�����������ƽ̨ ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=configsetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>�ɹ�</font>",2);
			setTimeout("LogSetup()",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ��ؽ�ϵͳ�����ļ�����</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function LogSetup(){
		SetupReview("����ϵͳ������־ ...");
		var xml = "<?xml version=\"1.0\" encoding=\"gb2312\"?>" +
				  "<root><path>" +  path + "/config.xml</path></root>";
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=logsetup",xml,"body","","",false);
		if(xml_BackCont=="OK"){
			IntroState=false;
			SetupReview("<font color=green>�ɹ�</font>",2);
			top.frames["menus_box"].location.reload();			//ˢ����ർ����
			setTimeout("SetupClose(true)",SetupDelayTime);
		}else if(xml_BackCont=="ERROR"){
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ���־�ļ���������</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}else{
			IntroState=false;
			SetupReview("<font color=red>ʧ�ܣ�" + xml_BackCont + "</font>",2);
			setTimeout("UnSetup()",SetupDelayTime);
		}
	}
	
	function SetupClose(err){
		if(err) SetupReview("ϵͳ����<font color=green><b>�ɹ�</b></font>��");
			else SetupReview("ϵͳ����<font color=red><b>ʧ��</b></font>��");
		if(!IntroState) SetupReview("ϵͳ���������");
	}
	
	function UnSetup(){
		SetupReview("<font color=red>��ϵͳ�����������ж������</font> ...");
		IntroState=false;
		startXmlRequest("POST","JCP_ArtSys_Intro_Action.asp?action=unsetup",null,"body","","",false);
		if(xml_BackCont=="OK"){
			SetupReview("<font color=green>���</font>",2);
		}else{
			SetupReview("<font color=blue>ж�س���</font>",2);
			SetupReview("<font color=blue>" + xml_BackCont + "</font>");
		}
		SetupClose(false);
	}
	
	function SetupReview(strs,num){
		if(num){
			srb.lastChild.innerHTML += "	" + strs
		}else{
			var t_Div=doc.createElement("<div></div>");
			t_Div.innerHTML=strs;
			srb.appendChild(t_Div);
		}
	}
-->
</script>
<!--#include file="../JCP_Shared/body.asp" -->
	<div class="app_title">����ϵͳ</div>
	<div class="manage_button"><a href="JCP_ArtSys_Manage.asp">���ع���</a></div>
	<div class="manage_button_cur">����ϵͳ</div>
	<div style="float:left;width:100%;text-align:center;">
		<hr style="width:100%;height:1px;">
		<input type="text" id="systempath" name="systempath" value="" readonly style="width:200px;">
		<input type="button" class="system_button_00" value="����ϵͳĿ¼" onClick="SetupReviewBox.innerHTML='** ��ѡ��Ŀ��ϵͳ��ַ��';FindServerFile('systempath');">
		<input type="button" class="system_button_00" value="ִ�е���" onClick="SetupNow()">
		<hr style="width:100%;height:1px;">
	</div>
	<div id="SetupReviewBox" style="line-height:1.6;">** ��ѡ��Ŀ��ϵͳ��ַ��</div>
<!--#include file="../JCP_Shared/foot.asp" -->
<% J.close %>