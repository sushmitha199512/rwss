<%@ page import="nic.watersoft.proposals.*" %>
<%
      String totHabs = request.getParameter("selHabs");
String proposalId=(String)session.getAttribute("selectedWorkId");
      String habsarray[]={};
session.setAttribute("proposalId",proposalId);
String status="Added Successfully";
 System.out.println("Proposal Id:"+ proposalId);
String tabName1="";
try{

            if(totHabs!=null){
				if(proposalId!=null){
			String code = proposalId.substring(6,8);
				habsarray=totHabs.split("@@");
			 	if(!(code.equals("11")|| code.equals("12")|| code.equals("13")|| code.equals("14")))
				{
					tabName1 = "rws_hab_selected_temp_tbl";
				}
				else if(code.equals("11"))
				{
					tabName1 = "rws_sch_selected_temp_tbl";
				}
				else if(code.equals("12"))
				{
					tabName1 = "rws_lab_selected_temp_tbl";
				}else if(code.equals("13"))
				{
					tabName1 = "rws_angan_selected_temp_tbl";
				}
				else if(code.equals("14"))
				{
					tabName1 = "rws_pi_selected_temp_tbl";
				}
				ProposalDAO proposalDAO=new ProposalDAO();
				proposalDAO.saveHabsToTempTable(tabName1,habsarray,session.getId(),proposalId);
                      				
				}

%>
<%=status %>
<% 
 }else{
status="Adding failed";
%>
<%=status %>
<% 
}
}catch(Exception e){ 
e.printStackTrace();}
 %>
