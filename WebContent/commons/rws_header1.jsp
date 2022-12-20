<!-- <head><meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=10; IE=11; IE=12; IE=EDGE" />
  <meta charset="UTF-8"></head> -->
<div id="content1"><noscript>
<meta http-equiv="refresh" content="0;url=/pred/EnableJS.html">
</noscript></div>
<link rel="icon" href="../images/favicon.ico" type="image/x-icon" />   
<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />  
<%@ page import="java.io.*,java.util.*,java.text.*" %>
<%@ page import="nic.watersoft.commons.*" %>

<%java.text.SimpleDateFormat fmt= new java.text.SimpleDateFormat("dd/MM/yyyy");%>
<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="htmlel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<%
String uri = (String)request.getRequestURI();
String qs = request.getQueryString();
if(qs!=null)uri += "?"+qs;

Enumeration valsNames = request.getParameterNames();
while(valsNames.hasMoreElements())
{
	String value = (String)valsNames.nextElement();
//System.out.println(value);
		uri += "&"+value+ "=" + request.getParameter(value);
}
//System.out.println("uri:"+uri);
boolean flagChecking = false;
StringBuffer uriBuf = new StringBuffer(uri);
if(uriBuf.indexOf("script")!=-1)flagChecking = true;
if(uriBuf.indexOf("img")!=-1)flagChecking = true;
if(uriBuf.indexOf("src")!=-1)flagChecking = true;
if(uriBuf.indexOf("iframe")!=-1)flagChecking = true;
if(uriBuf.indexOf("EMBED")!=-1)flagChecking = true;
if(uriBuf.indexOf("OBJECT")!=-1)flagChecking = true;
if(uriBuf.indexOf("alert")!=-1)flagChecking = true;

//System.out.println("flagChecking:"+flagChecking);
if(!flagChecking)
{
	final StringBuffer result = new StringBuffer();
	final StringCharacterIterator iterator = new StringCharacterIterator(uri);
	char character =  iterator.current();
	while (character != CharacterIterator.DONE ){
	 if (character == '<' || character == '>'  || character == '\\') {
		 flagChecking = true;
	  }
	  character = iterator.next();
	}
}
//System.out.println("flagChecking:"+flagChecking);
if(flagChecking){
	//System.out.println("Error");
try{response.sendRedirect("/pred/pred_mal_page.jsp");}catch(Exception e){}
} 
/* RwsUser user1 = (RwsUser) session.getAttribute("RWS_USER");
if(user1 == null){
	
	response.sendRedirect("/pred/pred_mal_page.jsp");
} */
%>


<script language="JavaScript">
//disable back button
function preventBack() { // alert("Logout1...");
window.history.forward();
//location.href="/pred/rws_logout.jsp";
}
setTimeout(preventBack(), 0);
/* window.onunload = function () {  //location.href="/pred/home.jsp";
	window.location.reload();
	//break;
	//return false;
	
}; */
window.onunload = function () {  //location.href="/pred/home.jsp";
	window.location.reload();
	//break;
	//return false;
};


 <%%>
 
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

<!--  
<script language="JavaScript">
//Added By Sai Prasad
	var message = "Not allowed here."; 
	function rtclickcheck(keyp){ if (navigator.appName == "Netscape" && keyp.which == 3){ 	alert(message); return false; } 
	if (navigator.appVersion.indexOf("MSIE") != -1 && event.button == 2) { 	alert(message); 	return false; } } 
	document.onmousedown = rtclickcheck;
</script>
-->

<script language="JavaScript" type="text/javascript">

//Hides all status bar messages
//Added by Sai Prasad(31-05-2012)

function hidestatus(){
window.status='WATERSOFT'
return true
}

if (document.layers)
document.captureEvents(Event.MOUSEOVER | Event.MOUSEOUT)

document.onmouseover=hidestatus
document.onmouseout=hidestatus
</script>

<html>
<head>

<%if(request.getParameter("loginMode")==null || request.getParameter("loginMode").equals("watersoft")){ %>
<title><bean:message  key="app.title" /></title>
<%}else if(request.getParameter("loginMode")!=null && request.getParameter("loginMode").equals("prajapatham")){ %>
<title>Prajapatham</title>
<%} %>
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/jquery.ui.all.css'/>">
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

<!-- <script>
$(document).ready(function(){
	 //alert("Alert"+history.go(-1));
	//window.location.reload();
	});
</script> -->
<!-- <body>
<p id="demo"></p>
</body> -->
<%@ include file="/commons/Cache_Control.jsp"%>