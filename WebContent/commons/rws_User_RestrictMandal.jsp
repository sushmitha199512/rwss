<html>
<%
		nic.watersoft.commons.RwsUser user = (nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		if(!(user.getUserId()!=null && (user.getUserId().equals("admin") ))) {
			response.sendRedirect("/pred/commons/UnAuthorize.jsp");
		}

%>
</html>