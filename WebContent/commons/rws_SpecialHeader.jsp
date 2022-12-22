<%@ page import="java.io.*,java.util.*,java.text.*" %>
<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="htmlel" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>

<div id="content1"><noscript>
<meta http-equiv="refresh" content="0;url=/pred/EnableJS.html">
</noscript></div>
<%
String uri = (String)request.getRequestURI();

 java.text.SimpleDateFormat fmt= new java.text.SimpleDateFormat("dd/MM/yyyy");


String qs = request.getQueryString();
if(qs!=null)uri += "?"+qs;

Enumeration valsNames = request.getParameterNames();
while(valsNames.hasMoreElements())
{
	String value = (String)valsNames.nextElement();
	////System.out.println(value);
		uri += "&"+value+ "=" + request.getParameter(value);

}
boolean flagChecking = false;
//System.out.println("uri:"+uri);

StringBuffer uriBuf = new StringBuffer(uri);
if(uriBuf.indexOf("script")!=-1)flagChecking = true;
if(uriBuf.indexOf("img")!=-1)flagChecking = true;
//if(uriBuf.indexOf("src")!=-1)flagChecking = true;
if(uriBuf.indexOf("iframe")!=-1)flagChecking = true;
if(uriBuf.indexOf("EMBED")!=-1)flagChecking = true;
if(uriBuf.indexOf("OBJECT")!=-1)flagChecking = true;
if(uriBuf.indexOf("alert")!=-1)flagChecking = true;

if(flagChecking){
try{response.sendRedirect("/pred/pred_mal_page.jsp");}catch(Exception e){}
}

%>
<script language="JavaScript">
//
window.onbeforeunload = doUnload;
function doUnload()
{ 
 if(getIEversion()<=6)
  {
   if ( (window.event.clientX > 999 && window.event.clientX <1023)  && (window.event.clientY < -90 && window.event.clientY > -139))
    {
     alert("Logout...");
	 location.href="/pred/rws_logout.jsp";
	}
  }

  if(getIEversion()>6)
    {
		if ( (window.event.clientX > 999 && window.event.clientX <1023)  && (window.event.clientY < -69 && window.event.clientY > -169))
		  {
		    alert("Logout...");
			location.href="/pred/rws_logout.jsp";
		  }
    }
} 
// 
function getIEversion()
{
var ua = window.navigator.userAgent
var msie = ua.indexOf ( "MSIE " )

if ( msie > 0 ) // If Internet Explorer, return version number
return parseInt (ua.substring (msie+5, ua.indexOf (".", msie )))
else // If another browser, return 0
return 0
}
</script>

<html>
<head>
<%if(request.getParameter("loginMode")==null || request.getParameter("loginMode").equals("watersoft")){ %>
<title><bean:message  key="app.title" /></title>
<%}else if(request.getParameter("loginMode")!=null && request.getParameter("loginMode").equals("prajapatham")){ %>
<title>Prajapatham</title>
<%} %>
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/rwsstyle.css'/>">
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/theme1.css'/>">
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/menu.css'/>">
<script language="JavaScript" src="<rws:context page='/resources/javascript/calendar.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/calendarfuture.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/rwsscript.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/menu.js' />"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/jquery-1.4.2.js' />"></script>
<!--  <script language="JavaScript" src="<rws:context page='/resources/javascript/menu_items.js' />"></script>  -->

<script language="JavaScript" src="<rws:context page='/resources/javascript/menu_tpl.js' />"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/ajax.js' />"></script>