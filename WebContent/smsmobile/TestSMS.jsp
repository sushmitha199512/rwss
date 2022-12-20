<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="nic.watersoft.smsmobile.Rws_PhoneNumbersArray"%>
<%@page import="nic.watersoft.smsmobile.NicSmsGateway"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try
{
String result = "Authentication Failed Please try From Another Mobile";
NicSmsGateway sms = new NicSmsGateway();
String message=sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", "9440440672", result);
out.println("MESSAGE"+message);
}
catch(Exception ex)
{
	out.println("***SMS EXCEPTION"+ex);
	
}



%>



</body>
</html>