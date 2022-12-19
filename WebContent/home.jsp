
<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId(); 
	Boolean flag=(Boolean)session.getAttribute("AGENCY");
	  if(userid==null){            	   
   	   response.sendRedirect("./expire.do");
      }
     // System.out.println("flag:" +flag);
    // System.out.println("userid.substring(3,6) :"+userid.substring(3,6));
if( userid!=null && flag==true){
%>
<jsp:forward page="/dashboards/rws_grievance_dashboard.jsp" />
<% 
} else if(userid!=null  && (userid.equals("admin") || userid.equals("100000"))){
%>
<jsp:forward page="/dashboards/rws_admin_dashboard.jsp" />
<% 
} else if(userid!=null && userid.equals("minrwss")){
	%>
	<jsp:forward page="/dashboards/rws_minister_dashboard.jsp" />
	<% 
} else if(userid!=null && userid.equals("secrwss")){
	%>
	<jsp:forward page="/dashboards/rws_sec_dashboard.jsp" />
	<% 
} else if(userid!=null && userid.substring(0,1).equals("2")){
	%>
	<jsp:forward page="/dashboards/ur_urban_dashboard.jsp" />
	<% 	
} else if(userid!=null && userid.equals("EE-Budget")){ 
		%>
		<jsp:forward page="/dashboards/rws_ee_budget_dashboard.jsp" />
		<% 
		} else if(userid!=null && userid.equals("guest")){ 
	%>
	<jsp:forward page="/dashboards/rws_guest_dashboard.jsp" />
	<% 
	} else if(userid!=null && userid.equals("aprwssp")){
	%>
	<jsp:forward page="/dashboards/rws_world_bank_dashboard.jsp" />
	<% 
	}else if(userid!=null && (userid.equals("cerwss") || userid.equals("pdswsm") || userid.equals("pdccdu") || userid.equals("ce_stp") || userid.equals("ce_nab") || userid.equals("ce_vqc"))){
		%>
		<jsp:forward page="/dashboards/rws_ce_dashboard.jsp" />
		<% 
		}else if(userid!=null && userid.equals("ENC")){
	%>
	<jsp:forward page="/dashboards/rws_enc_dashboard.jsp" />
	
	<% 
		}else if(userid!=null && userid.substring(3,6).equals("vqc")){
	%>
	<jsp:forward page="/dashboards/rws_vqc_dashboard.jsp" />
	
	
	<% 
	}  else if(userid!=null && userid.substring(4,6).equals("EE")){
%>
<jsp:forward page="/dashboards/rws_ee_dashboard.jsp" />
<% 
}else if(userid!=null && userid.substring(4,6).equals("DR")){
%>
<jsp:forward page="/dashboards/rws_drought_dashboard.jsp" />
<% 
} else if(userid!=null && userid.substring(4,6).equals("AO")){
%>
<jsp:forward page="/dashboards/rws_ao_dashboard.jsp" />
<% 
} else if(userid!=null && userid.substring(4,6).equals("WQ")){
%>
<jsp:forward page="/dashboards/rws_WQ_dashboard.jsp" />

<% 
} 
else if(userid!=null && userid.substring(0,3).equals("col")){ 
	%>
	<jsp:forward page="/dashboards/rws_collector_dashboard.jsp" />
	<% 
	}
else if(userid!=null) {
%>
<jsp:forward page="/dashboards/rws_user_dashboard.jsp" />
<% 
}else {
	//System.out.println("home.jsp else");
}
%>
