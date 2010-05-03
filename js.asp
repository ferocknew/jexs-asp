<script Language="JScript" runat="server" src="lib/Jexs-json.js"></script>
<script Language="JScript" runat="server">
var Jexs = function() {
	return new Jexs.fn.init(arguments);
}
Jexs.fn = Jexs.prototype = {
	init:function() {
	this.length = 0;
	//var args = Array.prototype.slice.call(arguments,0);
	Array.prototype.push.apply(this,arguments[0]);
	return this;
	},
	show:function() {
	Array.prototype.slice.call(this,0).join("$");
	return this;
	},
	hide:function() {
		return this;
	}
}
Jexs.fn.init.prototype = Jexs.fn;


Response.Write(JSON.stringify(Jexs(["0",1,2,3,4,5]).show()))
</script>