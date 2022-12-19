<html>
<%
	nic.watersoft.commons.RwsUser user = (nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	if(user.getUserId()!=null && (user.getUserId().equals(nic.watersoft.commons.Constants.SEC_USER)) || user.getUserId().equals(nic.watersoft.commons.Constants.ENC)) {}else{
	response.sendRedirect("/pred/commons/UnAuthorize.jsp");
	}
%>
</html>  