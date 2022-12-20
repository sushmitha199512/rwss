
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>


<form>
<%

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "GrievanceStatusAbstract.xls");

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
Statement stmt6=null,stmt3=null;
Statement stmt8=null;
ResultSet rs8=null;
Statement stmt7=null;
ResultSet rs7=null;
ResultSet rs6=null;
ResultSet rs3=null;
String attend="";
int wno=0;
int gwno=0;
String a="";
int s=0;

String fromdate=(String)session.getAttribute("fromdate");
String todate=(String)session.getAttribute("todate");

	
System.out.println("fromdate"+fromdate);
		
System.out.println("todate"+todate);


int compaintno=0;
int attendedno=0;

String dcode1="";
String query2="";




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
		<td align="center" class="rptHeading" colspan="14">Grievance Status Abstract Report</td>
</tr>
<tr bgcolor="" align="center">
		<td align="center" class="rptHeading" colspan="14">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext rowspan=3 >Sl.No</td>
               
               <td class=btext rowspan=3 >Date</td>
               <td class=btext  colspan="26">District</td>
                 <td class=btext  rowspan=2 colspan="2">Total</td>
              
            
			   
			  
			   </tr>
			  
			  <tr>
			  <%String qry="select  d.dcode,d.dname from rws_district_tbl d where d.dcode<>'16'  order by d.dcode";
			  
			  stmt1=conn.createStatement();
			  rs1=stmt1.executeQuery(qry);
			  while (rs1.next())
				{
				  %>
				  <td class=btext colspan="2" ><%=rs1.getString(2)%></td> 
			<%
				}
			  %>
			  </tr>
			 
			   <tr>
			    <td class=btext>No</td>
              <td class=btext >Attended No</td>
              
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
              <td class=btext >Attended No</td>
              
                <td class=btext>No</td>
                <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
             <td class=btext >Attended No</td>
             
                <td class=btext>No</td>
            <td class=btext >Attended No</td>
            
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
              <td class=btext >Attended No</td>
                <td class=btext>No</td>
              <td class=btext >Attended No</td>
               
			  </tr>
			  
			   
<% 
try
{
	String query = "";
	 
  query="select distinct to_char(COMPLAINT_DATE,'dd/mm/yyyy') from RWS_GENERIC_COMPLAINTS_REG_TBL where COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') order by to_char(COMPLAINT_DATE,'dd/mm/yyyy') ";  
    stmt2=conn.createStatement();
   
   rs2=stmt2.executeQuery(query); 
   System.out.println("first qry..."+query);

   
   while(rs2.next())
      {
	   int gcompaintno1=0;
	   int attendedno1=0;
      %>
      <tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs2.getString(1)%></td>
      <%
      
      
       String complaint=rs2.getString(1);
      query2="select dcode,dname from rws_district_tbl  order by dcode ";
      System.out.println("query2"+query2);
      stmt8=conn.createStatement();
      rs8=stmt8.executeQuery(query2);
      while(rs8.next())
      {
     dcode1=rs8.getString(1);
   query="select distinct count(complaint_no),count(ATTENDED_DATE ),to_date(COMPLAINT_DATE,'dd/mm/yyyy') from RWS_GENERIC_COMPLAINTS_REG_TBL where COMPLAINT_DATE=to_date('"+rs2.getString(1)+"','dd/mm/yyyy') and substr(habitation_code,1,2)='"+dcode1+"' group by to_date(COMPLAINT_DATE,'dd/mm/yyyy'),substr(habitation_code,1,2) order by to_date(COMPLAINT_DATE,'dd/mm/yyyy')";  
   stmt3=conn.createStatement();
  
  rs3=stmt3.executeQuery(query); 
  System.out.println("first qry. 1212.."+query);

  
  if(rs3.next())
     {
     
       compaintno=rs3.getInt(1);
       attendedno=rs3.getInt(2);
       
      
    
   %>
     <td class=rptValue><a href="#" onclick="viewWorks('rws_grievance_status_drill.jsp?dcode=<%=dcode1%>&dname=<%=rs8.getString(2)%>&date=<%=rs2.getString(1)%>')"><%=compaintno%></a></td>
     <td class=rptValue><a href="#" onclick="viewWorks('rws_grievance_status_drill1.jsp?dcode=<%=dcode1%>&dname=<%=rs8.getString(2)%>&date=<%=rs2.getString(1)%>')"><%=attendedno%></a></td>
       <%
     }
  else{
	  compaintno=0;
	  attendedno=0;
			
		%>
				
        <td class=rptValue><%=compaintno%></td>
     <td class=rptValue><%=attendedno%></td>      
				
				
<%			

  }

  gcompaintno1+=compaintno;
  attendedno1+=attendedno;
     %>
  
  
     <%
  
     }
     
   
	%>
	
	<td class=rptValue><a href="#" onclick="viewWorks('rws_grievance_status_drill2.jsp?date=<%=rs2.getString(1)%>')"><%=gcompaintno1%></a></td>
     <td class=rptValue><a href="#" onclick="viewWorks('rws_grievance_status_drill3.jsp?date=<%=rs2.getString(1)%>')"><%=attendedno1%></a></td>   
	</tr>
	
	
		<%
}}
catch(Exception e)
{
System.out.println(""+e);
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
