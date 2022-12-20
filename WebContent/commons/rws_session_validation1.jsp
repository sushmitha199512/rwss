<jsp:useBean id="RWS_USER" scope="session" class="nic.watersoft.commons.RwsUser" />
<% nic.watersoft.commons.RwsUser loguserss=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
try{
		if(loguserss==null)
		{
			response.sendRedirect("./expire.do");
		}
		else{
			String loguseridd = loguserss.getUserId();
			if(loguseridd==null)
			{
				response.sendRedirect("./expire.do");
			}
		}
	}
catch(Exception dd){}
%>