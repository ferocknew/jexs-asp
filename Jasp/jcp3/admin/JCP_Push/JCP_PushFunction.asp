<!--#include file="../JCP_Shared/asp_head.asp" -->
<%
dim casetype,casevalue,pushType,viewpath
casetype=trim(request.querystring("casetype"))
casevalue=trim(request.querystring("casevalue"))
pushType=trim(request.querystring("pushType"))

Server.ScriptTimeout=999999

if J.NumberTF(pushType) then
	dim ptype,pvalue,i,pushelements,tPushPath,tPushResult,tPathList,paramPathList
	pushelements=""
	ptype=split(casetype,",")
	pvalue=split(casevalue,",")
	if ubound(ptype)=ubound(pvalue) then
		for i=0 to ubound(ptype)
			select case ptype(i)
				case "s"
					pushelements=pushelements & """"&replace(pvalue(i),"|","&")&""","
				case "i"
					pushelements=pushelements & Cstr(pvalue(i)) & ","
				case else
					response.write "模板参数传递有误(禁止的参数类型)！"
					response.end
			end select
		next
		J.Template.PushList=""
		select case pushType
			case "0"	'classIndex
				execute "tPushResult=J.Template.PushClassIndex(Array("&pushelements&"J))"
			case "1"	'classList
				execute "tPushResult=J.Template.PushClassList(Array("&pushelements&"J))"
			case "2"	'classContent
				execute "tPushResult=J.Template.PushClassContent(Array("&pushelements&"J))"
			case "3"	'sole
				execute "tPushResult=J.Template.PushSole(Array("&pushelements&"J))"
			case "4"	'index
				execute "tPushResult=J.Template.PushIndex(Array("&pushelements&"J))"
			case "5"	'dataJS
				execute "tPushResult=J.Template.PushDataJS(Array("&pushelements&"J))"
			case else
				response.write "模板参数传递有误(禁止的推送类型)！"
				response.end
		end select
		if tPushResult=false then
			response.write J.Template.TemplateResult
		else
			paramPathList=split(J.Template.PushList,"|")
			for i=1 to ubound(paramPathList)
				tPathList=tPathList & "<span><a href=""" + paramPathList(i) + """ target=""_blank"">" + paramPathList(i) + "</a></span>"
			next
			response.write "OK" & tPathList
		end if
	else
		response.write "模板参数传递有误(数量不匹配)！"
	end if
else
	response.write "模板参数传递有误(为空)！"
end if
%>
<% J.close %>