<%
nic.watersoft.commons.RwsUser userrec=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");

try{
	if(userrec==null){
		response.sendRedirect("/pred/commons/UnAuthorize.jsp");
	}
	else{
		if(userrec!=null && !userrec.getUserId().equals("ENC")) {
			response.sendRedirect("/pred/commons/UnAuthorize.jsp");
		}
	}
}catch(Exception dd){
	System.out.println("Exception at rws_enc_header1: " +dd);
}
%>
<%@ include file="/commons/Cache_Control.jsp"%>