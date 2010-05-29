<script Language="JScript" runat="server">
(function($){
	//创建error对象
	$.error = function(e){
		$.error._e=e;
	};
	
	$.extend($.error,{
		output: function(){
			_output = this._e ? this._e.description : undefined;
			this._e = undefined;
			return _output;
		}
	});
})(Jasp);
</script>