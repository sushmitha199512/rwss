<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>


<%
   String scheme=(String)session.getAttribute("scheme");
   String programe=(String)session.getAttribute("programe");
String yr=(String)session.getAttribute("yr");
  String circleOfficeCode=request.getParameter("ccode");
  String divCode=request.getParameter("divCode");
 %>
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
		<td align="center" class="rptHeading" >Works(s) Completed - Not Commisioned </td><td align="right" class="rptHeading" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>DISTRICT   </b></td>

<td class=btext ><b>Division  </b></td>
<td class=btext ><b>Work ID   </b></td>
<td class=btext ><b>Work Name </b></td>    
<td class=btext ><b>Admin Sanction Date   </b></td>  
<td class=btext ><b>Completion Date</b></td>  
<td class=btext ><b>Commisioned Date</b></td>  
<td class=btext ><b>Sanction Amount   </b></td> 
<td class=btext ><b>Remarks   </b></td> 
 
  
</tr>

	<%try
      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       String distname1="",distname2="";

        String spillOverCommNotCompQuery="SELECT d.dname,b.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),nvl(to_char(DATE_OF_COMM,'dd/mm/yyyy'),'-'),nvl(SANCTION_AMOUNT,'0'),nvl(w.remarks,'-') FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_completion_tbl c,rws_district_tbl  d where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"'  and work_cancel_dt is null and  substr(w.work_id,5,2)=d.dcode and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and b.circle_office_code='"+circleOfficeCode +"' and b.division_office_code='"+divCode+"' and  c.work_id=W.work_id and c.DATE_OF_COMPLETION is  not null  and c.DATE_OF_COMM is null and  w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverCommNotCompQuery+="and w.type_of_asset in("+scheme+")";
}
 spillOverCommNotCompQuery+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"')) order by to_char(ADMIN_DATE,'dd/mm/yyyy') desc";
      // qry="SELECT  b.dname,d.DIVISION_OFFICE_NAME,a.work_id,WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),to_char(c.GROUNDING_DATE,'dd/mm/yyyy'),to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),nvl(to_char(DATE_OF_COMM,'dd/mm/yyyy'),'-') , nvl(SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL a,rws_district_tbl  b,rws_work_commencement_tbl c,rws_division_office_tbl d,rws_work_completion_tbl e where a.work_id=c.work_id and c.work_id=e.work_id  and substr(a.work_id,5,2)=b.dcode and substr(a.work_id,5,2)=d.CIRCLE_OFFICE_CODE  and substr(a.office_code,4,1)=d.division_office_code and DATE_OF_COMPLETION is  not null  and DATE_OF_COMM is null and sysdate - DATE_OF_COMPLETION>3*365  and a.TYPE_OF_ASSET  in(03) group by  b.dname,a.work_id,WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),to_char(c.GROUNDING_DATE,'dd/mm/yyyy'),to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),to_char(DATE_OF_COMM,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0') ,d.DIVISION_OFFICE_NAME order by b.dname";
       System.out.println("qry***********"+spillOverCommNotCompQuery);
       rs1=stmt1.executeQuery(spillOverCommNotCompQuery);
       while(rs1.next())
       {
        %>

                <tr>
	           
                <td class=rptValue>&nbsp;<%=count++%> </td>
 <td  class=rptLabel align="center">&nbsp;<%=rs1.getString(1)%> </td>
         
				<td class=rptValue>&nbsp;<%=rs1.getString(2)%> </td>    
				<td class=rptValue><%=rs1.getString(3)%>   </td>  
				<td class=rptValue><%=rs1.getString(4)%>   </td>  
				<td class=rptValue align="center"><%=rs1.getString(5)%>  </td>  
				<td class=rptValue align="right"><%=rs1.getString(6)%>  </td> 
                <td class=rptValue align="right"><%=rs1.getString(7)%>  </td>
				<td class=rptValue align="right"><%=rs1.getString(8)%>  </td>
<td class=rptValue align="right"><%=rs1.getString(9)%>  </td>
			
				</tr>
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

