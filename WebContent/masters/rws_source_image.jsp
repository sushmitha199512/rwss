
<%@page import="java.io.OutputStream"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
System.out.println("inside showfile");
response.setHeader("Cache-Control", "no-store");  
response.setHeader("Pragma", "no-cache");  
response.setDateHeader("Expires", 0);  
//response.setContentType("application/pdf");
response.setContentType("image/gif");
//response.setContentType("text/html;charset=UTF-8");
OutputStream out1=response.getOutputStream();
byte a[]=(byte[])session.getAttribute("copyData");
System.out.println(a.length);
out1.write(a);
out.flush();
out1.close();

%>


