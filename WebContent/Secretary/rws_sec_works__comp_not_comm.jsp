<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_session_validation.jsp"%>
<%@ include file="/reports/conn.jsp" %>

<%
Date date = new Date(); 
SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
String datenewformat = formatter.format(date);
%>

<script language="JavaScript">
function wopen(url, name, w, h)
{
	w += 32;
	h += 96;
	var win = window.open(url, name,  'width=' + w + ', height=' + h + ', ' +  'location=yes, menubar=no, ' +  'status=yes, toolbar=no, scrollbars=yes, resizable=yes'); 
 	win.focus();
}
function viewWorks(URL)
{
	var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

</script>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;</td>
	          <!--   <td class="bwborder"><a href="./rws_sec_gaprep_grounded_notcompl_wrks_rpt_xls.jsp" >Excel</a>&nbsp;|&nbsp;</td> -->
				<td class="bwborder"><a href="#" onClick="window.close();">Close</a></td>
			</tr>  
		</table>
		
		<%/* request.setAttribute("mode", mode); */ %>
	</caption>	
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" >Works(s) Completed - Not Commissioned </td><td align="right" class="rptHeading" >*** Rupees in Lakhs</td>
	</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr align=center>
		<td class=btext ><b>SLNO</b></td>
		<td class=btext ><b>Division</b></td>
		<td class=btext ><b>Work ID</b></td>
		<td class=btext ><b>Work Name </b></td>  
		<td class=btext ><b>Programme Name</b></td>  
		<td class=btext ><b>Admin Sanction Date</b></td>  
		<td class=btext ><b>Grounded Date</b></td>  
		<td class=btext ><b>Complete Date</b></td>  
		<td class=btext ><b>Sanction Amount</b></td>   
	</tr>
	<%try
      { int count=1;
       Statement stmt1=null,stmt2=null;
       ResultSet rs1=null,rs2=null;
       String qry="",qry2="",prog_codes="";
       qry2="select programme_code from RWS_PROGRAMME_TBL where NRDWP_RELATED='Y'  order by PROGRAMME_CODE";
       stmt2=conn.createStatement();
       rs2=stmt2.executeQuery(qry2);
       while(rs2.next())
       {
    	   if(prog_codes.equals(""))
    	   prog_codes="'"+rs2.getString("programme_code")+"'";
    	   else{
    		   prog_codes+=",'"+rs2.getString("programme_code")+"'"; 
    	   }    	   
       }
       prog_codes+=",'04'"; 
      // System.out.println("Programme codes"+prog_codes);
       stmt1=conn.createStatement();
       String distname1="",distname2="";
       qry="SELECT distinct b.dname,d.DIVISION_OFFICE_NAME,a.work_id,WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),to_char(c.GROUNDING_DATE,'dd/mm/yyyy'),SANCTION_AMOUNT,pr.programme_name,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy')  FROM RWS_WORK_ADMN_TBL a,rws_district_tbl b,rws_work_commencement_tbl c,rws_division_office_tbl d,rws_programme_tbl pr,rws_work_completion_tbl comp  where pr.programme_code=Substr(a.work_id,1,2) and a.work_id=comp.work_id and pr.programme_code in ("+prog_codes+") and substr(a.work_id,5,2)=b.dcode and substr(a.work_id,5,2)=d.CIRCLE_OFFICE_CODE  and substr(a.office_code,4,1)=d.division_office_code and  a.work_id=c.work_id and work_cancel_dt is null and DATE_OF_COMPLETION>='01-APR-"+datenewformat+"' and DATE_OF_COMM is null";
             qry+=" group by  b.dname,a.work_id,WORK_NAME ,ADMIN_DATE,SANCTION_AMOUNT,c.GROUNDING_DATE,d.division_office_name,pr.programme_name,DATE_OF_COMPLETION order by  b.dname";
       //System.out.println("qry***********"+qry);
       rs1=stmt1.executeQuery(qry);
       while(rs1.next())
       {
         		distname1 = ""+rs1.getString(1);%>                  
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
				<td class=rptValue><%=rs1.getString(8)%>   </td>
				<td class=rptValue><%=rs1.getString(5)%>  </td>  
				<td class=rptValue align="right"><%=rs1.getString(6)%>  </td>  
				<td class=rptValue align="right"><%=rs1.getString(9)%>  </td> 
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

