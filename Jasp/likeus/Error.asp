<script Language="JScript" runat="server">
(function($){
	//创建ERROR对象
	$.Error = function(e){
		$.Error._E=e;
	};
	
	$.extend($.Error,{
		output: function(){
			_output = this._E ? this._E.description : undefined;
			this._E = undefined;
			return _output;
		}
	});
})(Jasp);
</script>