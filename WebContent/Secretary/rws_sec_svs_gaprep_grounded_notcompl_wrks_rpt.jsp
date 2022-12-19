<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_session_validation.jsp"%>

<form>
<table border =0 cellspacing = 0 cellpadding = 0 width="85%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="#" onClick="window.close();">Close</a>
</td>
	</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg">SVS Works(s) Grounded - Not Completed with >2 year(s) of Time Period </td><td align="right" class="gridhdbg" >*** Rupees in Lakhs</td>
</tr>
</table>
<table border =0 cellspacing = 0 cellpadding = 0 width="85%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr align=center>
<td class="gridhdbg"><b>SLNO   </b></td>
<td class="gridhdbg" ><b>Division  </b></td>
<td class="gridhdbg" ><b>Programme </b></td>
<td class="gridhdbg" ><b>Sub Programme </b></td>
<td class="gridhdbg" ><b>Work ID   </b></td>
<td class="gridhdbg" ><b>Work Name </b></td>    
<td class="gridhdbg" ><b>Admin Sanction Date   </b></td>  
<td class="gridhdbg" ><b>Grounded Date</b></td>  
<td class="gridhdbg" ><b>Sanction Amount   </b></td>  
  
</tr>

	<%
	int styleCount=0;  String style="";
	
	try
	      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       String distname1="",distname2="";
       qry="SELECT distinct b.dname,d.DIVISION_OFFICE_NAME,a.work_id,WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),to_char(c.GROUNDING_DATE,'dd/mm/yyyy'),SANCTION_AMOUNT,p.programme_name,sp.subprogramme_name  FROM RWS_WORK_ADMN_TBL a,rws_district_tbl b,rws_work_commencement_tbl c,rws_division_office_tbl d ,rws_programme_tbl p,rws_subprogramme_tbl sp where substr(a.work_id,5,2)=b.dcode and substr(a.work_id,5,2)=d.CIRCLE_OFFICE_CODE  and substr(a.office_code,4,1)=d.division_office_code and substr(a.work_id,1,2) =p.programme_code and substr(a.work_id,1,2) =sp.programme_code and substr(a.work_id,3,2) =sp.subprogramme_code and a.work_id=c.work_id and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date>2*365  and a.category_code=2  and c.GROUNDING_DATE is not null group by  b.dname,a.work_id,WORK_NAME ,ADMIN_DATE,SANCTION_AMOUNT,c.GROUNDING_DATE,d.division_office_name ,p.programme_name,sp.subprogramme_name order by  b.dname";
       System.out.println("qry***********"+qry);
       rs1=stmt1.executeQuery(qry);
       if(rs1.next())
       {
       while(rs1.next())
       {
          distname1 = ""+rs1.getString(1);
	      
           
          if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
		%>
			    
                
               <%if(!distname1.equals(distname2)){ %>
                <tr>
	            <td class="gridhdbg" colspan="9" align="center" bgcolor="orange">&nbsp;<%=rs1.getString(1)%> </td>
                </tr>
                <%}
                 %>
                
                <tr>
                
                <td class="<%=style%>" style="text-align: left;">&nbsp;<%=count++%> </td>
				<td class="<%=style%>" style="text-align: left;">&nbsp;<%=rs1.getString(2)%> </td>   
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(8)%> </td>   
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(9)%> </td>  
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(3)%></td>  
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(4)%></td>  
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(5)%></td>  
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(6)%></td>  
                <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(7)%></td>  
				</tr>
		<% 
           distname2 = distname1;
       }
       }
       else
       {
    	   %>
   		<script>
   			alert("There are no Works");
   			window.close();
   		</script>
   		<%
       }
       
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

