//日期处理插件
(function($){
    var date = {
        dateParse: function(value, pattern){
            var tokens = [], options = {}, regexp = this._buildDateTimeRE(tokens, {}, pattern);
            var re = new RegExp("^" + regexp + "$", "i");
            var match = re.exec(value);
            if (!match) {
                return null;
            }
            var widthList = ['abbr', 'wide', 'narrow'];
            var result = [1970, 0, 1, 0, 0, 0, 0]; // will get converted to a Date at the end
            var amPm = "", v;
            for (var i = 1, len = match.length; i < len; i++) {
                var token = tokens[i - 1];
                var l = token.length;
                v = match[i];
                switch (token.charAt(0)) {
                    case 'y':
                        if (l != 2 && options.strict) {
                            //interpret year literally, so '5' would be 5 A.D.
                            result[0] = v;
                        }
                        else {
                            if (v < 100) {
                                v = Number(v);
                                //choose century to apply, according to a sliding window
                                //of 80 years before and 20 years after present year
                                var year = '' + new Date().getFullYear();
                                var century = year.substring(0, 2) * 100;
                                var cutoff = Math.min(Number(year.substring(2, 4)) + 20, 99);
                                var num = (v < cutoff) ? century + v : century - 100 + v;
                                result[0] = num;
                            }
                            else {
                                //we expected 2 digits and got more...
                                if (options.strict) {
                                    return false;
                                }
                                //interpret literally, so '150' would be 150 A.D.
                                //also tolerate '1950', if 'yyyy' input passed to 'yy' format
                                result[0] = v;
                            }
                        }
                        break;
                    case 'M':
                        if (l > 2) {
                        //do something
                        }
                        else {
                            v--;
                        }
                        result[1] = v;
                        break;
                    case 'E':
                    case 'e':
                        break;
                    case 'D':
                        result[1] = 0;
                    case 'd':
                        result[2] = v;
                        break;
                    case 'a': //am/pm
                        break;
                    case 'K': //hour (1-24)
                        if (v == 24) {
                            v = 0;
                        }
                    case 'h': //hour (1-12)
                    case 'H': //hour (0-23)
                    case 'k': //hour (0-11)
                        if (v > 23) {
                            return false;
                        }
                        result[3] = v;
                        break;
                    case 'm': //minutes
                        result[4] = v;
                        break;
                    case 's': //seconds
                        result[5] = v;
                        break;
                    case 'S': //milliseconds
                        result[6] = v;
                }
            }

            var hours = +result[3];
            if (amPm === 'p' && hours < 12) {
                result[3] = hours + 12; //e.g., 3pm -> 15
            }
            else
                if (amPm === 'a' && hours == 12) {
                    result[3] = 0; //12am -> 0
                }

            //TODO: implement a getWeekday() method in order to test
            //validity of input strings containing 'EEE' or 'EEEE'...

            var dateObject = new Date(result[0], result[1], result[2], result[3], result[4], result[5], result[6]); // Date
            if (options.strict) {
                dateObject.setFullYear(result[0]);
            }
            return dateObject; // Date
        },
        /**
         * 日期格式替换成正则表达式
         * @param {Array} tokens
         * @param {Object} options
         * @param {String} pattern
         * @return RegExp
         */
        _buildDateTimeRE: function(tokens, options, pattern){
            pattern = this.escapeString(pattern);
            tokens = tokens || [];
            options = options || [];

            if (!options.strict) {
                pattern = pattern.replace(" a", " ?a");
            } // kludge to tolerate no space before am/pm
            return pattern.replace(/([a-z])\1*/ig, function(match){
                // Build a simple regexp.  Avoid captures, which would ruin the tokens list
                var s;
                var c = match.charAt(0);
                var l = match.length;
                var p2 = '', p3 = '';
                if (options.strict) {
                    if (l > 1) {
                        p2 = '0' + '{' + (l - 1) + '}';
                    }
                    if (l > 2) {
                        p3 = '0' + '{' + (l - 2) + '}';
                    }
                }
                else {
                    p2 = '0?';
                    p3 = '0{0,2}';
                }
                switch (c) {
                    case 'y':
                        s = '\\d{2,4}';
                        break;
                    case 'M':
                        s = (l > 2) ? '\\S+?' : p2 + '[1-9]|1[0-2]';
                        break;
                    case 'D':
                        s = p2 + '[1-9]|' + p3 + '[1-9][0-9]|[12][0-9][0-9]|3[0-5][0-9]|36[0-6]';
                        break;
                    case 'd':
                        s = '[12]\\d|' + p2 + '[1-9]|3[01]';
                        break;
                    case 'w':
                        s = p2 + '[1-9]|[1-4][0-9]|5[0-3]';
                        break;
                    case 'E':
                        s = '\\S+';
                        break;
                    case 'h': //hour (1-12)
                        s = p2 + '[1-9]|1[0-2]';
                        break;
                    case 'k': //hour (0-11)
                        s = p2 + '\\d|1[01]';
                        break;
                    case 'H': //hour (0-23)
                        s = p2 + '\\d|1\\d|2[0-3]';
                        break;
                    case 'K': //hour (1-24)
                        s = p2 + '[1-9]|1\\d|2[0-4]';
                        break;
                    case 'm':
                    case 's':
                        s = '[0-5]\\d';
                        break;
                    case 'S':
                        s = '\\d{' + l + '}';
                        break;
                    case 'a':
                        var am = options.am || 'AM';
                        var pm = options.pm || 'PM';
                        if (options.strict) {
                            s = am + '|' + pm;
                        }
                        else {
                            s = am + '|' + pm;
                            if (am != am.toLowerCase()) {
                                s += '|' + am.toLowerCase();
                            }
                            if (pm != pm.toLowerCase()) {
                                s += '|' + pm.toLowerCase();
                            }
                            if (s.indexOf('.') != -1) {
                                s += '|' + s.replace(/\./g, "");
                            }
                        }
                        s = s.replace(/\./g, "\\.");
                        break;
                    default:
                        // case 'v':
                        // case 'z':
                        // case 'Z':
                        s = ".*";
                    //				console.debug("parse of date format, pattern=" + pattern);
                }

                if (tokens) {
                    tokens.push(match);
                }

                return "(" + s + ")"; // add capture
            }).replace(/[\xa0 ]/g, "[\\s\\xa0]"); // normalize whitespace.  Need explicit handling of \xa0 for IE.
        },
        escapeString: function(str, except){
            //	return str.replace(/([\f\b\n\t\r[\^$|?*+(){}])/gm, "\\$1"); // string
            return str.replace(/([\.$?*!=:|{}\(\)\[\]\\\/^])/g, function(ch){
                if (except && except.indexOf(ch) != -1) {
                    return ch;
                }
                return "\\" + ch;
            }); // String
        }
    }
    var datefn = function(value, pattern){
		if (typeof value=="date") {
			 this._date =new Date(value);
		}else{
			this._date = date.dateParse(value, pattern);
		}
    }
    $.extend({
        date: function(value, pattern){
            return new datefn(value, pattern)
        }
    });
    $.extend(datefn.prototype, {
        output: function(type){
			switch(typeof (this._date)){
				case "string":
					this._date=[this._date];
					break;
				case "date":
					this._date=[this._date+""];
					break;
				case "object":
					this._date=[this._date.toString()];
					break;
			}
            $.output(this._date, type);
            return this;
        },
        get: function(){
            return this._date;
        },
        format: function(format) //author: meizz
        {
            var o = {
                "M+": this._date.getMonth() + 1, //month
                "d+": this._date.getDate(), //day
                "h+": this._date.getHours(), //hour
                "m+": this._date.getMinutes(), //minute
                "s+": this._date.getSeconds(), //second
                "q+": Math.floor((this._date.getMonth() + 3) / 3), //quarter
                "S": this._date.getMilliseconds() //millisecond
            }
            if (/(y+)/.test(format))
                format = format.replace(RegExp.$1, (this._date.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(format))
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
            this._date = format;
            return this;
        }
    });
})(Jasp);
