// utility function to retrieve an expiration data in proper format;
  function getExpDate(days, hours, minutes)
  {
    var expDate = new Date();
    if(typeof(days) == "number" && typeof(hours) == "number" && typeof(hours) == "number")
    {
        expDate.setDate(expDate.getDate() + parseInt(days));
        expDate.setHours(expDate.getHours() + parseInt(hours));
        expDate.setMinutes(expDate.getMinutes() + parseInt(minutes));
        return expDate.toGMTString();
    }
  }

  //utility function called by getCookie()
  function getCookieVal(offset)
  {
    var endstr = document.cookie.indexOf(";", offset);
    if(endstr == -1)
    {
        endstr = document.cookie.length;
    }
    return unescape(document.cookie.substring(offset, endstr));
  }

  // primary function to retrieve cookie by name
  function getCookie(name)
  {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    while(i < clen)
    {
        var j = i + alen;
        if (document.cookie.substring(i, j) == arg)
        {
          return getCookieVal(j);
        }
        i = document.cookie.indexOf(" ", i) + 1;
        if(i == 0) break;
    }
    return;
  }
 
  // store cookie value with optional details as needed
  function setCookie(name, value, expires, path, domain, secure)
  {
    document.cookie = name + "=" + escape(value) +
        ((expires) ? "; expires=" + expires : "") +
        ((path) ? "; path=" + path : "") +
        ((domain) ? "; domain=" + domain : "") +
        ((secure) ? "; secure" : "");
  }

  // remove the cookie by setting ancient expiration date
  function deleteCookie(name,path,domain)
  {
    if(getCookie(name))
    {
        document.cookie = name + "=" +
          ((path) ? "; path=" + path : "") +
          ((domain) ? "; domain=" + domain : "") +
          "; expires=Thu, 01-Jan-70 00:00:01 GMT";
    }
  }

  //使用getCookie(name)函数来读取cookie中保存的值，参数name为cookie项的名称。如果该cookie项不存在则返回一个空字符串。 
  //使用setCookie()函数来保存cookie项的值，其中第一、二两个参数分别为cookie项的名称和值。如果想为其设置一个过期时间，那么就需要设置第三个参数，这里需要通过getExpDate()获得一个正确格式的参数。 
  //最后，使用deleteCookie()来删除一个已存在的cookie项，实际上是通过让该项过期。
  //cookie将数据保存在客户端。页面的脚本只能读取所在域和服务器的cookie值，如果域内有多个服务器，那么需要设置第五个参数，以指定服务器。浏览器的容量一般限定为每服务器20个name/value对，每个cookie项不超过4000个字符，更现实点，单个cookie项应少于2000字符，也就是说不要用cookie在客户端保存大容量数据。
  //不同的浏览器保存cookie的方式也有所不同。IE为每个域的cookie建立一个文本文件，而Netscape则将所有的cookie存储在同一个文本文件中。
  // 注意：cookie存放在客户端，所以会受到浏览器设置的影响，比如用户可能会禁用cookie。要检测浏览器是否支持cookie，使用属性navigator.cookieEnabled来判断。