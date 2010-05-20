<script Language="JScript" runat="server">
var Jasp;
(function(){
	Jasp =function(o){
		return new Jasp.init(o);
	};
	Jasp.extend = function(){
		// copy reference to target object
		var target = arguments[0] || {}, i = 1, length = arguments.length, deep = false, options, name, src, copy;
		// Handle a deep copy situation
		if (typeof target === "boolean") {
			deep = target;
			target = arguments[1] || {};
			// skip the boolean and the target
			i = 2;
		}
		// Handle case when target is a string or something (possible in deep copy)
		if (typeof target !== "object" && typeof target !== "function") {
			target = {};
		}
		// extend jQuery itself if only one argument is passed
		if (length === i) {
			target = this;
			--i;
		}
		for (; i < length; i++) {
			// Only deal with non-null/undefined values
			if ((options = arguments[i]) != null) {
				// Extend the base object
				for (name in options) {
					src = target[name];
					copy = options[name];
					// Prevent never-ending loop
					if (target === copy) {
						continue;
					}
					// Recurse if we're merging object literal values or arrays
					if (deep && copy && (typeof target == "object" || typeof target == "array")) {
						var clone = src && (typeof target == "object" || typeof target == "array") ? src : typeof target == "array" ? [] : {};
						// Never move original objects, clone them
						target[name] = Jasp.extend(deep, clone, copy);
						// Don't bring in undefined values
					}
					else
						if (copy !== undefined) {
							target[name] = copy;
						}
				}
			}
		}
		// Return the modified object
		return target;
	};
	Jasp.init = function(){};
	Jasp.init.prototype = Jasp.prototype;
	Jasp.extend(Jasp.prototype, {
		output: function(str, type){
			Jasp.output(str, type);
		}
	});
	Jasp.fn = Jasp.prototype;
	Jasp.extend({
		version: "0.1"
	});
})();
</script>