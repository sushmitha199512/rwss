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


<!-- <meta HTTP-EQUIV="REFRESH" content="0; url=http://rwss.ap.nic.in/pred/"> -->
<%@ include file="/commons/rws_alert.jsp"%>
<script>
window.history.forward();
document.location.href="<%=request.getContextPath()%>";
</script>