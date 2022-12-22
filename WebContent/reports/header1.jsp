<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<HTML>
<HEAD>
<TITLE>WATERSOFT</TITLE>
<link rel="stylesheet" type="text/css" href="/pred/resources/style/rwsstyle.css">
<script language="JavaScript" src="/pred/resources/javascript/utils.js"></script>
<script language="JavaScript" src="/pred/resources/javascript/calendar.js"></script>
<%
	String sessionid = request.getSession().getId(); 
				System.out.println("sessionid :"+sessionid);
	response.setHeader("Set-Cookie", "key=value; secure=true;HttpOnly; SameSite=true");
%>