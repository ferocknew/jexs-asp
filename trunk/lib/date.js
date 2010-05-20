(function($){
	$.declare('YH.date', {}, {
		days :[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
		/**
		 * 判断是否润年
		 * @param {Date} dateObject
		 */
		isLeapYear: function(dateObject){
			var year = dateObject.getFullYear();
			return !(year % 400) || (!(year % 4) && !!(year % 100));
		},
		/**
		 * 取得月份中的天数
		 * @param {Date} dateObject
		 * @return number
		 */
		getDaysInMonth: function(dateObject){
			var month = dateObject.getMonth();
			if (month == 1 && this.isLeapYear(dateObject)) {
				return 29;
			}
			return this.days[month];
		},
		getDayOfYear:function(dateObject){
			var firstDate=new Date(dateObject.getFullYear(),0,1);
			var ft=firstDate.getTime();
			var nt=dateObject.getTime();
			return Math.floor((nt-ft)/86400000)+1;
		},
		getWeekOfYear:function(dateObject){
			var dayOfYear=this.getDayOfYear(dateObject);
			var firstDayOfYear = new Date(dateObject.getFullYear(), 0, 1).getDay();
			firstDayOfYear=firstDayOfYear==0?7:firstDayOfYear;
			return Math.ceil((dayOfYear + firstDayOfYear - 1) / 7);
		},
		/**
		 * 取得某年第N周的开始结束时间
		 * 星期一到星期天
		 * @param {int} year
		 * @param {int} week
		 */
		beweek: function(year, week){
			var firstDate = new Date(year, 0, 1);//取得年中的第一天
			var firstWeekDay = firstDate.getDay();//取得第一天是星期几
			firstWeekDay=firstWeekDay==0?7:firstWeekDay;
			var beginDate = new Date(), endDate = new Date(), beginTime = 0;
			beginTime = (week* 7 -firstWeekDay-6) * 86400000 + firstDate.getTime();//第几周的开始日期(week-1) * 7 - (firstWeekDay-1)=week* 7 -firstWeekDay-6
			beginDate.setTime(beginTime);
			endDate.setTime(beginTime + 6 * 86400000);//第几周的结束日期
			return [beginDate, endDate];
		},
		/**
		 * 日期格式化
		 * 改自dojo
		 * @param {Date} dateObject
		 * @param {string} pattern
		 */
		dateFormat: function(dateObject, pattern){
			return pattern.replace(/([a-z])\1*/ig, function(match){
				var s, pad;
				var c = match.charAt(0);
				var l = match.length;
				switch (c) {
					case 'y':
						s = dateObject.getFullYear();
						switch (l) {
							case 1:
								break;
							case 2:
								s = String(s);
								s = s.substr(s.length - 2);
								break;
							default:
								pad = true;
						}
						break;
					case 'Q':
					case 'q':
						s = Math.ceil((dateObject.getMonth() + 1) / 3);
						pad = true;
						break;
					case 'M':
						var m = dateObject.getMonth();
						s = m + 1;
						pad = true;
						break;
					case 'w':
						var firstDay = 0;
						//s = dojo.date.locale._getWeekOfYear(dateObject, firstDay); pad = true;
						break;
					case 'd':
						s = dateObject.getDate();
						pad = true;
						break;
					case 'D':
						//s = dojo.date.locale._getDayOfYear(dateObject); pad = true;
						break;
					case 'E':
						var d = dateObject.getDay();
						s = d + 1;
						pad = true;
						break;
					case 'a':
						//var timePeriod = (dateObject.getHours() < 12) ? 'am' : 'pm';
						//s = bundle[timePeriod];
						break;
					case 'h':
					case 'H':
					case 'K':
					case 'k':
						var h = dateObject.getHours();
						// strange choices in the date format make it impossible to write this succinctly
						switch (c) {
							case 'h': // 1-12
								s = (h % 12) || 12;
								break;
							case 'H': // 0-23
								s = h;
								break;
							case 'K': // 0-11
								s = (h % 12);
								break;
							case 'k': // 1-24
								s = h || 24;
								break;
						}
						pad = true;
						break;
					case 'm':
						s = dateObject.getMinutes();
						pad = true;
						break;
					case 's':
						s = dateObject.getSeconds();
						pad = true;
						break;
					case 'S':
						s = Math.round(dateObject.getMilliseconds() * Math.pow(10, l - 3));
						pad = true;
						break;
					default:

				}
				if (pad) {
					s += '';
					while (s.length < l)
						s = '0' + s;
				}
				return s;
			});
		},
		/**
		 * 格式化整数值时间
		 * @param {int} time
		 * @param {string} pattern
		 */
		timeFormat: function(time, pattern){
			var d = new Date();
			d.setTime(time);
			return this.dateFormat(d, pattern);
		},
		/**
		 * 处理日期
		 * 改至dojo
		 * @param {String} value
		 * @param {String} pattern
		 */
		dateParse: function(value,pattern){
			var tokens = [],options={},
				regexp = this._buildDateTimeRE(tokens,{},pattern);
			var re = new RegExp("^" + regexp + "$","i");
			var match = re.exec(value);
			if (!match) {
				return null;
			}
			var widthList = ['abbr', 'wide', 'narrow'];
			var result = [1970, 0, 1, 0, 0, 0, 0]; // will get converted to a Date at the end
			var amPm = "",v;
			for(var i=1,len=match.length; i<len;i++){
				var token = tokens[i-1];
				var l = token.length;
				v=match[i];
				switch (token.charAt(0)) {
					case 'y':
						if (l != 2 && options.strict) {
							//interpret year literally, so '5' would be 5 A.D.
							result[0] = v;
						} else {
							if (v < 100) {
								v = Number(v);
								//choose century to apply, according to a sliding window
								//of 80 years before and 20 years after present year
								var year = '' + new Date().getFullYear();
								var century = year.substring(0, 2) * 100;
								var cutoff = Math.min(Number(year.substring(2, 4)) + 20, 99);
								var num = (v < cutoff) ? century + v : century - 100 + v;
								result[0] = num;
							} else {
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
						} else {
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
			} else if (amPm === 'a' && hours == 12) {
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
				} else {
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
						} else {
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
		/**
		 * 补0
		 * @param {Object} s
		 * @param {Object} len
		 */
		_pad: function(s, len){
			s = s.toString();
			while (s.length < len)
				s = '0' + s;
			return s;
		},
		/**
		 * 字符过虑
		 * @param {String} str
		 * @param {String} except
		 */

		escapeString: function(str, except){
			//	return str.replace(/([\f\b\n\t\r[\^$|?*+(){}])/gm, "\\$1"); // string
			return str.replace(/([\.$?*!=:|{}\(\)\[\]\\\/^])/g, function(ch){
				if (except && except.indexOf(ch) != -1) {
					return ch;
				}
				return "\\" + ch;
			}); // String
		}
	});
})(Jasp);
