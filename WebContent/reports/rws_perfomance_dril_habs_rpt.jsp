<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
  
String workid=(String)request.getParameter("workid");
String type=(String)request.getParameter("type");

  
 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="#" onClick="javascript:history.go(-1);">Back</a>&nbsp;|&nbsp;<a href="#" onClick="window.close();">Close</a>
</td>
	</tr>  
		</table>
	</caption>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>DISTRICT   </b></td>
<td class=btext ><b>HAB CODE</b></td>    
<td class=btext ><b>HAB NAME   </b></td>  
<td class=btext ><b>COVERAGE STATUS  </b></td>

  </tr>


<%try
      { 
		int count=1;
       Statement stmt1=null;       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
	     String distname1="",distname2="";
String query="";

if(type.equals("1")){

 query="select d.dname,b.panch_code,b.panch_name,c.coverage_status from rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl b,RWS_HABITATION_DIRECTORY_TBL c,rws_district_tbl  d  where  a.work_id='"+workid+"' and substr(a.hab_code,1,2)=d.dcode and a.hab_code=b.panch_code and b.panch_code=c.hab_code ";

} else if(type.equals("2")){
	 query="select d.dname,b.panch_code,b.panch_name,c.coverage_status from RWS_WORK_COMP_HAB_LNK_TBL a,rws_panchayat_raj_tbl b,RWS_HABITATION_DIRECTORY_TBL c,rws_district_tbl  d  where  a.work_id='"+workid+"' and substr(a.hab_code,1,2)=d.dcode and a.hab_code=b.panch_code and b.panch_code=c.hab_code ";

}
//System.out.println("QueryHabs:"+query);
       rs1=stmt1.executeQuery(query);
       while(rs1.next())
       {

 %>
<tr>
<td class=rptValue>&nbsp;<%=count++%> </td>
 <td  class=rptValue align="center"><%=rs1.getString(1)%> </td>
         
				<td class=rptValue>&nbsp;<%=rs1.getString(2)%> </td>    
				<td class=rptValue><%=rs1.getString(3)%>   </td>  
				<td class=rptValue><%=rs1.getString(4)%>   </td>  
				
</tr>

<% 
}
}catch(Exception e){
e.printStackTrace();
}


%>

