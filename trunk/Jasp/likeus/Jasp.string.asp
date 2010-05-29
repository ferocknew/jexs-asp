<script Language="JScript" runat="server">
(function($){
	var _string;
	//创建string对象
	var string = function(str){
		_string = str;
		return this;
	};
	$.extend(string.prototype,{
		times: function(n) {
			var s = _string, total = [];
			while(n) {
				if (n & 1) total[total.length] = s;
				s += s;
				n = n>>1;
			}
			_string = total.join('');
			return this;
			/* 以下是实现同样效果的2种代码，只是效果可能差点
			return Array.prototype.join.call({length:n+1}, this);
			return (new Array(n+1)).join(this);
			*/
		},
		//以下函数扩展自VBScript
		hex: function(){
			_string = vb.fn_hex(_string);
			return this;
		},
		chrB: function(){
			_string = vb.fn_chrB(_string);
			return this;
		},
		lenB: function(){
			return vb.fn_lenB(_string);
		},
		ascB: function(){
			_string = vb.fn_ascB(_string);
			return this;
		},
		leftB: function(length){
			_string = vb.fn_leftB(_string, length);
			return this;
		},
		midB: function(start, length){
			_string = vb.fn_midB(_string, start, length);
			return this;
		},
		rightB: function(length){
			_string = vb.fn_rightB(_string, length);
			return this;
		},
		chr: function(){
			_string = vb.fn_chr(_string);
			return this;
		},
		len: function(){
			return vb.fn_len(_string);
		},
		asc: function(){
			_string = vb.fn_asc(_string);
			return this;
		},
		chrW: function(){
			_string = vb.fn_chrW(_string);
			return this;
		},
		ascW: function(){
			_string = vb.fn_ascW(_string);
			return this;
		},
		left: function(length){
			_string = vb.fn_left(_string, length);
			return this;
		},
		mid: function(start, length){
			_string = vb.fn_mid(_string, start, length);
			return this;
		},
		right: function(length){
			_string = vb.fn_right(_string, length);
			return this;
		},
		cLng: function(){
			_string = vb.fn_cLng(_string);
			return this;
		},
		strConv: function(type){
			_string = vb.fn_strConv(_string, type);
			return this;
		},
		output: function(){
			return _string;
		}
	});
	
	$.extend({
		string: function(str){ return new string(str) }
	});
})(Jasp);
</script>
<%
'VBScript的函数借用
set vb = new Jasp_VBS_String

class Jasp_VBS_String

	'封装hex
	function fn_hex(str)
		fn_hex = hex(str)
	end function
	'封装chrB
	function fn_chrB(str)
		fn_chrB = chrB(str)
	end function
	'封装lenB
	function fn_lenB(str)
		fn_lenB = lenB(str)
	end function
	'封装ascB
	function fn_ascB(str)
		fn_ascB = ascB(str)
	end function
	'封装leftB
	function fn_leftB(str, l)
		fn_leftB = leftB(str, l)
	end function
	'封装midB
	function fn_midB(str, s, l)
		fn_midB = midB(str, s, l)
	end function
	'封装rightB
	function fn_rightB(str, l)
		fn_rightB = rightB(str, l)
	end function

	'封装chr
	function fn_chr(str)
		fn_chr = chr(str)
	end function
	'封装len
	function fn_len(str)
		fn_len = len(str)
	end function
	'封装asc
	function fn_asc(str)
		fn_asc = asc(str)
	end function

	'封装chrW
	function fn_chrW(str)
		fn_chrW = chrW(str)
	end function
	'封装chrW
	function fn_ascW(str)
		fn_ascW = ascW(str)
	end function

	'封装left
	function fn_left(str, l)
		fn_left = left(str, l)
	end function
	'封装mid
	function fn_mid(str, s, l)
		fn_mid = mid(str, s, l)
	end function
	'封装right
	function fn_right(str, l)
		fn_right = right(str, l)
	end function
	'封装cLng
	function fn_cLng(str)
		fn_cLng = cLng(str)
	end function
	
	function fn_strConv(str, types)
		fn_strConv = StrConv(str, types)
	end function
	
end class
%>
