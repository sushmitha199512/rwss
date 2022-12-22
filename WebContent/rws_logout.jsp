<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<% 	
	nic.watersoft.admin.Logger logger=new nic.watersoft.admin.Logger();
	Boolean flag=(Boolean)session.getAttribute("AGENCY");
	nic.watersoft.admin.LogBean logBean=logger.getLogBean(request,(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER"));
	nic.watersoft.admin.AdminDAO adminDAO=new nic.watersoft.admin.AdminDAO();
	//new begin
		nic.watersoft.admin.LogoutDAO logoutDAO=new nic.watersoft.admin.LogoutDAO();
		String Result = null;
		boolean adminResult = false;
	//new end
	try{		
			adminResult = adminDAO.log(logBean,request); System.out.println("adminResult :"+adminResult);
			Result = logoutDAO.logoutupdate(logBean, request);//new
			System.gc();
		    session.getAttributeNames();
		    session.invalidate();	
	   }
	catch(Exception ex)
	  {
		    ex.printStackTrace();
	  }
 %>
<!-- <meta HTTP-EQUIV="REFRESH" content="0; url=http://rwss.ap.nic.in/pred/"> -->
<script>
window.history.forward();
document.location.href="<%=request.getContextPath()%>";
alert("<%=Result%>");
</script>
