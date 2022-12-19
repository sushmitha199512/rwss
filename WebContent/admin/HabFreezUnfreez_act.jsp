<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@page import="nic.watersoft.admin.Rws_Hab_Freeze_Unfreeze_DAO"%>
<%@page import="nic.watersoft.commons.Constants"%>
<%@page import="nic.watersoft.commons.RwsUser"%>
<%
Rws_Hab_Freeze_Unfreeze_DAO dao=new Rws_Hab_Freeze_Unfreeze_DAO();
String fyear= request.getParameter("fyear");
System.out.println(fyear);
String message="";


	int hisyear=Integer.parseInt(fyear)-2;
	int preyear=Integer.parseInt(fyear)-1;					 	
	String pyear=String.valueOf(preyear);
	String upyear=fyear.substring(2,4);
	boolean myqry= dao.getHabFreezUnfreez(hisyear,pyear,upyear);	
	System.out.println("myqry :"+myqry);
	if(myqry==true){	
		
		message="Batch processed Successfully";
}
else {	
	message="Batch cannot be processed.Already habitation data was processed for "+fyear;
}
	request.setAttribute("message",message);
%>
<jsp:forward page="HabFreezUnfreez.jsp"/>