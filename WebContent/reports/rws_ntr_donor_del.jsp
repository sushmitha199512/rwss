<%@page import="nic.watersoft.works.Rws_Ntr_Sujala_HabSponsor_Details_DAO"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
//System.out.println("Deleleeeeee");
Rws_Ntr_Sujala_HabSponsor_Details_DAO dao=new Rws_Ntr_Sujala_HabSponsor_Details_DAO();
String message = dao.deleteNtrHabDetails(request.getParameter("habCode"), request.getParameter("date"));
//System.out.println("mesage    "+message);
if(message != null)
{	
%>
	<script>
	var mess="<%=message%>";
	alert(mess);
	</script>
<%
}

%>
<jsp:include page="rws_ntr_sujala_gov_donor_rpt.jsp" />




