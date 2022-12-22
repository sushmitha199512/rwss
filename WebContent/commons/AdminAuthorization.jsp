<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Watersoft</title>
</head>
<body>
<%
    nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String GeneralUser = (String) session.getAttribute("GeneralAdmin");
	String GeneralSuccess = (String) session.getAttribute("su");
	String userid = null;
	if(GeneralUser != null && GeneralSuccess!=null){
		if(users != null ){
			userid = users.getUserId();	
             if(userid!=null && (!userid.equals("admin") && !userid.equals("100000") && !userid.equals("EE-Budget"))){		            	   
          	   response.sendRedirect("../commons/rws_not_authorization.jsp");
             }
		}else{
			 response.sendRedirect("../masters/sessionExpired.jsp");
		}
	}else if(users != null){
		userid = users.getUserId();	
		if(userid != null  &&  !(userid.substring(userid.length()-3).equals("000") || userid.substring(userid.length()-2).equals("EE")))
			 response.sendRedirect("../commons/rws_not_authorization.jsp");
			
	}
	else{
		 response.sendRedirect("../commons/rws_not_authorization.jsp");
	}
%>

</body>
</html>