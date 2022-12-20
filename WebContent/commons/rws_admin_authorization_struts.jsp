
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="nic.watersoft.commons.Constants"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Watersoft</title>
</head>
<body>



<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");

			String userid = users.getUserId();

               if(userid!=null && !userid.equals(Constants.ADMIN) && !userid.equals(Constants.LAKH_USER)){            	   
            	   response.sendRedirect("/pred/commons/rws_not_authorization.jsp");
               }
%>

</body>
</html>