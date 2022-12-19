<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>

<%

	
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;

String fromdate=request.getParameter("fromDate");
String todate=request.getParameter("toDate");






int styleCount=0;
String style="";


int sno=1;


%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			


			

<tr align="right">
<td class="bwborder"></td>
				
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" colspan="14">Action Taken Report</td>
</tr>
<tr bgcolor="" align="center">
		<td align="center" class="gridhdbg" colspan="14">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>

               <td class=gridhdbg >Sl.No</td>
               
              
               <td class=gridhdbg >District</td>
               <td class=gridhdbg >Transportation</td>
               <td class=gridhdbg >Hiring of Source</td>
               <td class=gridhdbg >Flushing/Deepening</td>
            	<td class=gridhdbg >Scheme Repaired</td>
            	<td class=gridhdbg >Scheme Repair pending</td>
			   <td class=gridhdbg >Proposal Stage</td>
			    <td class=gridhdbg >No DW Problem</td>
			   <td class=gridhdbg >HP's Repaired</td>
			    <td class=gridhdbg >Pipelines Rectified</td>
			    <td class=gridhdbg >Complaint not factual</td>
			     <td class=gridhdbg >GP For Maintenance</td>
			     <td class=gridhdbg >Total</td>
			    
			   </tr>
			  <tr >
			  <td class=gridhdbg align="center">1</td>
               
               <td class=gridhdbg align="center">2</td>
               <td class=gridhdbg align="center">3</td>
               <td class=gridhdbg align="center">4</td>
               <td class=gridhdbg align="center">5</td>
            	<td class=gridhdbg align="center">6</td>
            	<td class=gridhdbg align="center">7</td>
			   <td class=gridhdbg align="center">8</td>
			    <td class=gridhdbg align="center">9</td>
			   <td class=gridhdbg align="center" >10</td>
			    <td class=gridhdbg align="center">11</td>
			     <td class=gridhdbg align="center" >12</td>
			     <td class=gridhdbg align="center">13</td>
			       <td class=gridhdbg align="center">14</td>
			  </tr>
			   
<% 
try
{
	int dwp1=0,dwp2=0,dwp3=0,dwp4=0,dwp5=0,dwp6=0,dwp7=0,dwp8=0,dwp9=0,dwp10=0,dwp11=0;
	int totdwp1=0,totdwp2=0,totdwp3=0,totdwp4=0,totdwp5=0,totdwp6=0,totdwp7=0,totdwp8=0,totdwp9=0,totdwp10=0,tTotal=0,totdwp11=0;
	String query = "";
	query="select DCODE,DNAME from rws_district_tbl order by DCODE";
	stmt1=conn.createStatement();
	 rs1=stmt1.executeQuery(query); 
	 while(rs1.next()){
	 
  query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='transportation' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
    stmt2=conn.createStatement();
  
   rs2=stmt2.executeQuery(query); 
   
   if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
   
   if(rs2.next())
      {
	   dwp1=rs2.getInt(1);
	   %>
	    <tr bgcolor="#ffffff">
				<td class="<%=style %>" style="text-align: center;"><%=sno++%></td>
				<td class="<%=style %>" style="text-align: left;"><%=rs1.getString(2)%></td>
				<td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=transportation&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp1%></a></td>
	  
	   <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='Hiring of Source' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp2=rs2.getInt(1);
      %>
      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=Hiring of Source&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp2%></a></td>
       <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='Flushing/Deepening' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp3=rs2.getInt(1);
      %>
       
      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=Flushing/Deepening&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp3%></a></td>
       <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='Scheme Repaired' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp4=rs2.getInt(1);
      %>
       <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=Scheme Repaired&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp4%></a></td>
       <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='Scheme Repair pending' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp5=rs2.getInt(1);
      %>
      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=Scheme Repair pending&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp5%></a></td>
       <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='Proposal Stage' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp6=rs2.getInt(1);
      %>
       <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=Proposal Stage&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp6%></a></td>
       <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='No DW Problem' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp7=rs2.getInt(1);
      %>
      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=No DW Problem&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp7%></a></td>
      <%
      }
   rs2.close();
   stmt2.close();
   
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='HPs repaired' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp8=rs2.getInt(1);
      %>
       <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=HPs repaired&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp8%></a></td>
      <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='Pipelines rectified' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp9=rs2.getInt(1);
      %>
       <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=Pipelines rectified&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp9%></a></td>
            
      <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='Complaint not factual' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  dwp10=rs2.getInt(1);
      %>
       <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=Complaint not factual&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp10%></a></td>
        <%
      }
   rs2.close();
   stmt2.close();
   query="select count(ACTION_TAKEN) from rws_generic_complaints_reg_tbl where ACTION_TAKEN='GP For Maintenance' and substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
 dwp11=rs2.getInt(1);
      %>
      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=GP For Maintenance&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=dwp11%></a></td>
      <%
      }
   rs2.close();
   stmt2.close();
  
	   int total=dwp1+dwp2+dwp3+dwp4+dwp5+dwp6+dwp7+dwp8+dwp9+dwp10+dwp11;
      %>
     
		<td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Action_Taken_drill_rpt.jsp?actionTaken=ALL&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=total%></a></td>		
				
			</tr>
      <%
      totdwp1=totdwp1+dwp1;
      totdwp2=totdwp2+dwp2;
      totdwp3=totdwp3+dwp3;
      totdwp4=totdwp4+dwp4;
      totdwp5=totdwp5+dwp5;
      totdwp6=totdwp6+dwp6;
      totdwp7=totdwp7+dwp7;
      totdwp8=totdwp8+dwp8;
      totdwp9=totdwp9+dwp9;
      totdwp10=totdwp10+dwp10;
      totdwp11=totdwp11+dwp11;
      tTotal=tTotal+total;
      
	 }
	 %>
	  <tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp1 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp2 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp3 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp4 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp5 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp6 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp7 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp8 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp9 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp10 %></td>
<td class="gridhdbg" style="text-align: right;"><%=totdwp11 %></td>
<td class="gridhdbg" style="text-align: right;"><%=tTotal %></td>
</tr>
<%
    
}
catch(Exception e)
{
e.printStackTrace();
}
finally
{
	try
	{
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
		if(rs2 != null )
		{
			rs2.close();
		}
		if(stmt2 != null )
		{
			stmt2.close();
		}
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
</form>

</td></tr>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</span>
