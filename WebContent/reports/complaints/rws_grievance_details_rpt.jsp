<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>
<form>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	
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
			


			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
			<td   class="bwborder"><a href="./rws_grievance_details_rpt_xls.jsp?fromDate=<%=fromdate%>&toDate=<%=todate%>">Excel</a></td> 
			<td class="bwborder"><a href="#" onclick="window.print()" >Print</a></td>
			</tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

<tr align="right">
<td class="bwborder"></td>
				
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" colspan="12">Grievances Details Report</td>
</tr>
<tr bgcolor="" align="center">
		<td align="center" class="rptHeading" colspan="12">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>

                <td class=gridhdbg >Sl.No</td>
               
                <td class=gridhdbg >Date</td>
                <td class=gridhdbg >District/</br>Mandal/<br>Panchayat/<br>Village</td>
            
            	 <td class=gridhdbg >Habitation</td>
			    <td class=gridhdbg >Petitioner Name/<br>Phone&nbsp;No/<br>Email</td>
			     <td class=gridhdbg >Problem&nbsp;Description</td>
			    <td class=gridhdbg >Grievance&nbsp;Related&nbsp;To</td>
		   <td class=gridhdbg >Grievance&nbsp;Category</td>
		   <td class=gridhdbg >Grievance&nbsp;Entry&nbsp;Category</td>
			   <td class=gridhdbg >Description&nbsp;on&nbsp;Action</td>
			    <td class=gridhdbg >Attended Date</td>
			     <td class=gridhdbg >Whether Message sent to Petitioner (Yes/NO)</td>
			   </tr>
			  
			   
<% 
try
{
	String query = "";
	 
  query="select to_char(COMPLAINT_DATE,'dd/mm/yyyy'),DNAME,MNAME,PNAME,VNAME,PANCH_NAME,NAME,PHONE_NO,COMPLAINT_DESC,ACTION_DESC,to_char(ATTENDED_DATE,'dd/mm/yyyy'),MESSAGE_SENT,PANCH_CODE,nvl(GRIEVANCE_RELATED_TO,'-'),nvl(GRIEVANCE_CATEGORY,'-'),nvl(GRIEVANCE_ENTRY_CATEGORY,'-'),nvl(EMAILID,'-') from  rws_generic_complaints_reg_tbl a,rws_complete_hab_view b where PANCH_CODE=HABITATION_CODE and COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL and URBAN_WATER='R' order by COMPLAINT_DATE";
  //System.out.println("query---"+query);
    stmt2=conn.createStatement();
   
   rs2=stmt2.executeQuery(query); 
   

   
   while(rs2.next())
      {
	   
	   String yn="";
	   if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
      %>
      <tr bgcolor="#ffffff">
				<td class="<%=style %>" style="text-align: left;" align="center"><%=sno++%></td>
				<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(1)%></td>
				<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(2)%>/<br><%=rs2.getString(3)%>/<br><%=rs2.getString(4)%>/<br><%=rs2.getString(5)%></td>
				
				<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(6)%>(<%=rs2.getString(13)%>)</td>
				<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(7)%>/<br><%=rs2.getString(8)%>/<br><%=rs2.getString(17)%></td>
				<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(9)%></td>
				<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(14)%></td> 
				  <td class="<%=style %>" style="text-align: left;"><%=rs2.getString(15)%></td> 
				  <td class="<%=style %>" style="text-align: left;"><%=rs2.getString(16)%></td>
				<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(10)%></td>
				<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(11)%></td>
				<%
				if(rs2.getString(12)==null){
					yn="";
				}
				else if(rs2.getString(12).equals("Y")){
					yn="Yes";
				}
				else if(rs2.getString(12).equals("N")){
					yn="No";
				}
				
				%>
				<td class="<%=style %>" style="text-align: left;"><%=yn%></td>
			</tr>
      <%
      
      }
   rs2.close();
   stmt2.close();
  
     %>
	
   
   
	
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
