// JavaScript Document
function Reg(regstrs,regobject,regtype,regaction){
	var jreg=new RegExp(regstrs,regtype);
	var YN=jreg.test(regobject);
	alert(regstrs + "|" + YN)
	if(YN){
		var jRegs=jreg.exec(regobject);
		alert(jRegs.length);
		for(i=0;i<jRegs.length;i++){
			regobject=regobject.replace(jRegs[i],regaction + jRegs[i] + ">")
			alert(jRegs[i]);
		}
		return regobject;
	}else{
		return false;
	}
}