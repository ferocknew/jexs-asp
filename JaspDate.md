TOC
Jasp

## Date数据操作插件 ##
根方法：$.date(String,Vcode)<br />
String:任何格式的日期字符串<br />
Vcode:对日期字符串的格式解释<br />
<br />
<br />
其他支持方法：<br />
$.date(DateTime)：将DateTime数据转成Date对象（此情况下，VBScript下也可以调用JScript下的Date方法）<br />
<br />
<br />
支持方法：<br />
format("yyyy-MM-dd hh:mm:ss"):y=年，M=月，d=日，h=时，m=分，s=秒，注意月的M是大写，格式化成任意格式，返回Jasp对象<br />
get():获取Jscript原始对象<br />
output()：Jasp的输出方法，默认String输出，支持Json和xml格式（item list）<br />
<br />
<br />
JScript方法：

---

$.date("2000-09-09 12:12:12","yyyy-MM-dd hh:mm:ss").format("yy-MM").get()


VBScript方法：

---

dateNow=Jasp.date("2010年05月11日","yyyy年MM月dd日").format("yyyy/MM/dd hh:mm:ss").Get()
Response.Write(DateDiff("d",Now(),dateNow))