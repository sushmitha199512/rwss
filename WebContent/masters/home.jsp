
<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId(); 
System.out.println("UserId:"+userid);

if(userid!=null && (userid.equals("admin") || userid.equals("100000"))){
%>
<jsp:forward page="/dashboards/rws_admin_dashboard.jsp" />
<% 
} else if(userid!=null && userid.equals("ENC")){
	%>
	<jsp:forward page="/dashboards/rws_enc_dashboard.jsp" />
	<% 
} else if(userid!=null && userid.equals("200000")){
	%>
	<jsp:forward page="/dashboards/ur_urban_dashboard.jsp" />
	<% 
else if(userid!=null && userid.substring(4,6).equals("EE")){
%>
<jsp:forward page="/dashboards/rws_ee_dashboard.jsp" />

<% 
}
else if(userid!=null && userid.substring(4,6).equals("DR")){
%>
<jsp:forward page="/dashboards/rws_drought_dashboard.jsp" />
<% 
}
else if(userid!=null && userid.substring(4,6).equals("AO"))
{
%>
<jsp:forward page="/dashboards/rws_ao_dashboard.jsp" />
<% 
}
else if(userid!=null && userid.substring(4,6).equals("vqc"))
{
%>
<jsp:forward page="/dashboards/rws_vqc_dashboard.jsp" />
<% 
}
else if(userid!=null && userid.equals("secrwss")){
%>
<jsp:forward page="/dashboards/rws_sec_dashboard.jsp" />
<% 
} else if(userid!=null && userid.equals("guest")){ 
%>
<jsp:forward page="/dashboards/rws_guest_dashboard.jsp" />
<% 
} else if(userid!=null && userid.equals("EE-Budget")){ 
	%>
	<jsp:forward page="/dashboards/rws_ee_budget_dashboard.jsp" />
	<% 
	} else if(userid!=null) {
%>
<jsp:forward page="/dashboards/rws_user_dashboard.jsp"/>
<% 
}else {

}
%>
