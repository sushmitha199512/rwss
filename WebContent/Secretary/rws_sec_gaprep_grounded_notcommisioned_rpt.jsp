<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_session_validation.jsp"%>
<%@ include file="/reports/conn.jsp" %>

<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="#" onClick="window.close();">Close</a>
</td>
	</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" >Works(s) Admin Sanctioned - Not Commenced with >1 year(s) of Time Period </td><td align="right" class="rptHeading" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>Division  </b></td>
<td class=btext ><b>Work ID   </b></td>
<td class=btext ><b>Work Name </b></td>    
<td class=btext ><b>Admin Sanction Date   </b></td>  
<td class=btext ><b>Grounded Date</b></td>  
<td class=btext ><b>Sanction Amount   </b></td>  
  
</tr>

	<%try
      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       String distname1="",distname2="";
       qry="SELECT  b.dname,d.DIVISION_OFFICE_NAME,a.work_id,WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(to_char(c.GROUNDING_DATE,'dd/mm/yyyy'),'-'),nvl(SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL a,rws_district_tbl  b,rws_work_commencement_tbl c,rws_division_office_tbl d where a.work_id=c.work_id  and substr(a.work_id,5,2)=b.dcode and substr(a.work_id,5,2)=d.CIRCLE_OFFICE_CODE  and substr(a.office_code,4,1)=d.division_office_code and ADMIN_DATE is  not null and sysdate - ADMIN_DATE>365  and a.TYPE_OF_ASSET  in(03)  and c.GROUNDING_DATE is null  and  work_cancel_dt is null  group by  b.dname,a.work_id,WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(to_char(c.GROUNDING_DATE,'dd/mm/yyyy'),'-'),nvl(SANCTION_AMOUNT,'0'),d.DIVISION_OFFICE_NAME order by b.dname";
       //System.out.println("qry***********"+qry);
       rs1=stmt1.executeQuery(qry);
       while(rs1.next())
       {
          distname1 = ""+rs1.getString(1);
	      
           

		%>
			    
                
               <%if(!distname1.equals(distname2)){ %>
                <tr>
	            <td class=btext colspan="6" align="center" bgcolor="orange">&nbsp;<%=rs1.getString(1)%> </td>
                </tr>
                <%}
                 %>
                
                <tr>
                
                <td class=rptValue>&nbsp;<%=count++%> </td>
				<td class=rptValue>&nbsp;<%=rs1.getString(2)%> </td>    
				<td class=rptValue><%=rs1.getString(3)%>   </td>  
				<td class=rptValue><%=rs1.getString(4)%>   </td>  
				<td class=rptValue align="center"><%=rs1.getString(5)%>  </td>  
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

