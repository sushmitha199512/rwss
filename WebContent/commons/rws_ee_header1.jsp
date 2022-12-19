<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Watersoft</title>
</head>
<body>


<%nic.watersoft.commons.RwsUser userInfo=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");

if(userInfo!=null){
String userId = userInfo.getUserId();

               if(userId!=null && !userId.equals("EE-Budget")){
            	   
            	   response.sendRedirect("../commons/rws_not_authorization.jsp");
               }
}
%>

<%@ include file="/commons/Cache_Control.jsp"%>

</body>
</html>