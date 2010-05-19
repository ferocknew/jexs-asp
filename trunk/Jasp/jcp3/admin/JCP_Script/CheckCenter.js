// JavaScript Document

var jRegs;

function Reg(regstrs,regobject,regtype){
	jRegs=null;
	var jreg=new RegExp(regstrs,regtype);
	var YN=jreg.test(regobject);
	if(YN){
		var jRegs=jreg.exec(regobject);
		if(jRegs==null){
			return true;
		}else{
			for(i=0;i<jRegs.length;i++)alert(jRegs[i]);
			return jRegs.length;
		}
	}else{
		return false;
	}
}

//是否是空格
function BlankYn(checkobj){
	if(checkobj){
		if(checkobj.length==0 || checkobj.replace(/(\s|　)/gi,"").length==0 || checkobj==null){
			return true;
		}else{
			return false;
		}
	}else return true;
}

//是否是数字
function IntYn(checkobj){
	return Reg("^-?(\\d+)$",checkobj,"gi");
}