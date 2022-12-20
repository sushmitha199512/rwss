<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<% 
//This code makes an entry of logout into the log table
nic.watersoft.admin.Logger logger=new nic.watersoft.admin.Logger();
nic.watersoft.admin.LogBean logBean=logger.getLogBean(request,(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER"));
nic.watersoft.admin.AdminDAO adminDAO=new nic.watersoft.admin.AdminDAO();
adminDAO.log(logBean,request);
//end of code

try
{
	System.gc();
    session.getAttributeNames();
    session.invalidate();
}
catch (java.lang.Exception isse)
{
   // System.out.println("session already invalidated");
}
 %>



<noscript>
<meta http-equiv="refresh" content="0;url=/pred/rws_login_frm.jsp">
</noscript>
