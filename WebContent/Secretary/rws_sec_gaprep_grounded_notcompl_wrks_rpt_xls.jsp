
<%@ include file="/reports/conn.jsp" %>


<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"    ALIGN=CENTER>

	
<tr bgcolor="#8A9FCD" align="center" >
		<td align="center" class="rptHeading"  colspan=7>Works(s) Grounded - Not Completed with >3 year(s) of Time Period </td>
		</tr>
		<tr bgcolor="#8A9FCD" align="center" >
		<td align="center" class="rptHeading"  colspan=7>*** Rupees in Lakhs</td>
		</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1   ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>Division  </b></td>
<td class=btext ><b>Work ID   </b></td>

<td class=btext ><b>Work Name </b></td>
<td class=btext ><b>Programme Name   </b></td>    
<td class=btext ><b>Admin Sanction Date   </b></td>  
<td class=btext ><b>Grounded Date</b></td>  
<td class=btext ><b>Sanction Amount   </b></td>  
  
</tr>

	<%

	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "inline; filename="
			+ "rws_sec_gaprep_xls.jsp");
	
	//System.out.println("***********");
	try
      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       String distname1="",distname2="";
       qry="SELECT distinct b.dname,d.DIVISION_OFFICE_NAME,a.work_id,WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),to_char(c.GROUNDING_DATE,'dd/mm/yyyy'),SANCTION_AMOUNT,pr.programme_name  FROM RWS_WORK_ADMN_TBL a,rws_district_tbl b,rws_work_commencement_tbl c,rws_division_office_tbl d,rws_programme_tbl pr  where pr.programme_code=Substr(a.work_id,1,2) and substr(a.work_id,5,2)=b.dcode and substr(a.work_id,5,2)=d.CIRCLE_OFFICE_CODE  and substr(a.office_code,4,1)=d.division_office_code and  a.work_id=c.work_id and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date>3*365  and a.TYPE_OF_ASSET  in(03)  and c.GROUNDING_DATE is not null group by  b.dname,a.work_id,WORK_NAME ,ADMIN_DATE,SANCTION_AMOUNT,c.GROUNDING_DATE,d.division_office_name,pr.programme_name order by  b.dname";
       //System.out.println("qry***********"+qry);
       rs1=stmt1.executeQuery(qry);
       
       while(rs1.next())
       {
          distname1 = ""+rs1.getString(1);
	      
           

		%>
			    
                
               <%if(!distname1.equals(distname2)){ %>
                <tr>
	            <td class=btext colspan="6" align="center" >&nbsp;<%=rs1.getString(1)%> </td>
                </tr>
                <%}
                 %>
                
                <tr>
                
                <td class=rptValue>&nbsp;<%=count++%> </td>
				<td class=rptValue>&nbsp;<%=rs1.getString(2)%> </td>    
				<td class=rptValue>&nbsp;<%=rs1.getString(3)%>   </td>
				  
				<td class=rptValue><%=rs1.getString(4)%>   </td> 
				<td class=rptValue>&nbsp;<%=rs1.getString(8)%>   </td> 
				<td class=rptValue><%=rs1.getString(5)%>  </td>  
				<td class=rptValue align="right"><%=rs1.getString(6)%>  </td>  
                <td class=rptValue align="right"><%=rs1.getString(7)%>  </td>  
				</tr>
		<% 
           distname2 = distname1;
       }
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

