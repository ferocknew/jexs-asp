<% 
	Option Explicit
	
	Response.CacheControl = "no-cache"
	Response.Expires = -1
	
%>
<!--#include file="../../JCP_Inc/Class_JCP.asp" -->
<% 
	dim J
	set J=new JCP
	J.open null
%>

