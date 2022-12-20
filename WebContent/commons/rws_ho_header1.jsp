<%
String userss = (String)session.getAttribute("hoLogged");
try{
	if(userss==null)response.sendRedirect("../commons/UnAuthorize.jsp");
	else{
		if(userss!=null && !userss.equals("true")) {
			%>
				<jsp:forward page="../commons/UnAuthorize.jsp"/>
			<%
		}
	}
}catch(Exception dd){}
%>
<%@ include file="/commons/Cache_Control.jsp"%>