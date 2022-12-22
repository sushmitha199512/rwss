<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;


String fromdate=request.getParameter("fromDate");
String todate=request.getParameter("toDate");
System.out.println("From Date:"+fromdate);

int sno=1;
int sanamt=0,bankamt=0,gsanamt=0,gbankamt=0;

%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
				
			
			</tr>  
		</table>
	</caption>
	

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> <font color="red"><b>Amount in Rs. lakhs</b></font></td>
</tr>




	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> PAO Refund Report</td>
</tr>


</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext >Sl.No</td>
               <td class=btext >work Id</td>
               <td class=btext > Work Name</td>
               <td class=btext >Sanction AMT</td>
               <td class=btext  >Pao Refund AMT</td> 
			   <td class=btext  >Date</td> 
			  <td class=btext  >REFUND CHQ_NO</td> 
			   <td class=btext  >REMARKS</td> 
			  
		</tr>
<% 
try
{
     //String qry = "select distinct division_office_code,division_office_name,circle_office_code from rws_division_office_tbl order by division_office_code";
     
     String qry="select a.work_id,a.work_name,a.SANCTION_AMOUNT,b.refund_bill_amount, to_char(b.update_date,'dd/mm/yyyy'),b.REFUND_CHQ_NO,b.REMARKS from rws_work_admn_tbl a,rws_div_work_pao_refund_tbl b where a.work_id=b.work_id and REFUND_FLAG='p'";
     
     System.out.println("district11........:"+qry);
   	 stmt1=conn.createStatement();
     rs1=stmt1.executeQuery(qry);
    
  while (rs1.next())
	{ 
	  sanamt=rs1.getInt(3);
	  bankamt=rs1.getInt(4);
	       	
	%>    
<tr>
				<td class=rptValue><%=sno++ %></td>
				<td class=rptValue NOWRAP><%=rs1.getString(1)%></td>
				<td class=rptValue NOWRAP><%=rs1.getString(2)%></td>
				<td class=rptValue NOWRAP><%=sanamt%></td>
				<td class=rptValue NOWRAP><%=bankamt%></td>
				<td class=rptValue NOWRAP><%=rs1.getString(5) %></td>
				<td class=rptValue NOWRAP><%=rs1.getString(6) %></td>
				<td class=rptValue NOWRAP><%=rs1.getString(7) %></td>
						
               </tr>	
               	
<%	
gsanamt=sanamt+gsanamt;
gbankamt=bankamt+gbankamt;
}
     %>
	<td></td>
	<td></td>
	<td class=btext align=right>Total</td>
	<td class=rptValue NOWRAP><%=gsanamt%></td>
	<td class=rptValue NOWRAP><%=gbankamt%></td>
	
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

