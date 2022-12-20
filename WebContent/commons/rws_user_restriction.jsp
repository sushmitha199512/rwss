<%@page import="nic.watersoft.commons.Constants"%>
<html>
<%
	 	nic.watersoft.commons.RwsUser user = (nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)|| user.getUserId().substring(4).equals("EE") ))) {
			response.sendRedirect("/pred/commons/UnAuthorize.jsp");
		}
%>
</html>