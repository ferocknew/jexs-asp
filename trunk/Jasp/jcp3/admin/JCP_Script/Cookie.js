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

  //ʹ��getCookie(name)��������ȡcookie�б����ֵ������nameΪcookie������ơ������cookie������򷵻�һ�����ַ����� 
  //ʹ��setCookie()����������cookie���ֵ�����е�һ�������������ֱ�Ϊcookie������ƺ�ֵ�������Ϊ������һ������ʱ�䣬��ô����Ҫ���õ�����������������Ҫͨ��getExpDate()���һ����ȷ��ʽ�Ĳ����� 
  //���ʹ��deleteCookie()��ɾ��һ���Ѵ��ڵ�cookie�ʵ������ͨ���ø�����ڡ�
  //cookie�����ݱ����ڿͻ��ˡ�ҳ��Ľű�ֻ�ܶ�ȡ������ͷ�������cookieֵ����������ж������������ô��Ҫ���õ������������ָ���������������������һ���޶�Ϊÿ������20��name/value�ԣ�ÿ��cookie�����4000���ַ�������ʵ�㣬����cookie��Ӧ����2000�ַ���Ҳ����˵��Ҫ��cookie�ڿͻ��˱�����������ݡ�
  //��ͬ�����������cookie�ķ�ʽҲ������ͬ��IEΪÿ�����cookie����һ���ı��ļ�����Netscape�����е�cookie�洢��ͬһ���ı��ļ��С�
  // ע�⣺cookie����ڿͻ��ˣ����Ի��ܵ���������õ�Ӱ�죬�����û����ܻ����cookie��Ҫ���������Ƿ�֧��cookie��ʹ������navigator.cookieEnabled���жϡ�