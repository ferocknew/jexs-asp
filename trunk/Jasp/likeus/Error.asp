<script Language="JScript" runat="server">
(function($){
	//创建ERROR对象
	$.Error = function(e){
		$.Error._E=e;
	};
	
	$.extend($.Error,{
		output: function(){
			return this._E.description;
		}
	});
})(Jasp);
</script>