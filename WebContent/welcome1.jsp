<%
String uri = (String)request.getRequestURI();
String qs = request.getQueryString();
if(qs!=null)uri += "?"+qs;
StringBuffer uriBuf = new StringBuffer(uri);
boolean predFlag = false;
if(uriBuf.indexOf("pred")!=-1)predFlag = true;
if(predFlag)
{
%>
<font face="verdana" size="2" color="red"><b>This Page has moved. Please wait you will automatically redirected </font><BR>
<meta http-equiv="refresh" content="5;url=http://rwss.ap.nic.in/"><font face="verdana" size="2" color="black">If your browser doesn't automatically redirect 
<a href="http://rwss.ap.nic.in/"><font face="verdana" size="2" color="blue">Click Here</a></b></font>
<%}else{%>
<HTML>
<HEAD>
<TITLE>Official Website of RWSS</TITLE>
</HEAD>
<FRAMESET ROWS="0%,*" COLS="," frameborder = "0">
	 <FRAME SRC="#" NAME="atop" scrolling = "no" noresize="noresize">
	<FRAME SRC="rws_login_frm.jsp" NAME="top" scrolling = "yes" noresize="noresize">
</FRAMESET>
</HTML>
<%}%>