<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%


nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String userid =null;
if(users!=null){
 userid = users.getUserId();
}
System.out.println("WEb Name:"+request.getRequestURI());
String remoteIp=request.getRemoteAddr();
System.out.println("UserId:"+userid);
System.out.println("remoteIp:"+remoteIp);
//125.16.9.134
if(!remoteIp.equals("164.100.12.13") && (userid==null ) ){
	%>
	<jsp:forward page="rws_not_authorization.jsp" /> 
			<%
		%>
	
	<%
}


%>