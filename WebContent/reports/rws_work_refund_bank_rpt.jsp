<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null;


String div=request.getParameter("division");
//System.out.println("division:"+div);

String year=request.getParameter("year");
//System.out.println("year Date:"+year);
String refund=request.getParameter("refund");
//System.out.println("refund:"+refund);
int sno=1;
int sanamt=0,bankamt=0,gsanamt=0,gbankamt=0,paoamt=0,gpaoamt=0,sanamt4=0,sanamt3=0,bankamt3=0,bankamt4=0,gsanamt1=0,gbankamt13=0;

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
		<td align="center" class="rptHeading" colspan="8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Refund Report &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red"></font></td>
</tr>


</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>




               <td class=btext rowspan=2>Sl.No</td>
               <td class=btext rowspan=2>Work Id</td>
               <td class=btext rowspan=2>Work Name</td>
               <td class=btext rowspan=2>Sanction AMT(in lakhs)</td>
               <td class=btext rowspan=2>Admin Sanction Date</td>
               <td class=btext colspan=4 >BANK</td>
               <td class=btext colspan=4 >PAO</td>
               
               
              
               
               
               </tr>
              <tr>
               
<td class=btext>BANK Refund AMT(in Rs)</td>
<td class=btext>Date</td>
<td class=btext>Refund Cheque No</td>
<td class=btext>Remarks</td>
<td class=btext>PAO Refund AMT(in Rs)</td>
                 <td class=btext>Date</td>
                  <td class=btext>Refund Cheque No</td>
                  <td class=btext>Remarks</td>
              
              </tr>
              
   <tr><td></td>
<td>1</td>
<td>2</td>
<td>3</td>
<td>4</td>
<td>5</td>
<td>6</td>
<td>7</td>
<td>8</td>
<td>9</td>
<td>10</td>
<td>11</td>


</tr>

              
             
<% 
try
{
     //String qry = "select distinct division_office_code,division_office_name,circle_office_code from rws_division_office_tbl order by division_office_code";
        stmt2=conn.createStatement();
      
     String qry="select a.work_id,a.work_name,a.SANCTION_AMOUNT,b.refund_bill_amount,c.refund_bill_amount, nvl(to_char(b.update_date,'dd/mm/yyyy'),'-'),b.REFUND_CHQ_NO,nvl(b.REMARKS,'-'),to_char(ADMIN_DATE) from rws_work_admn_tbl a,rws_div_work_bank_refund_tbl b,rws_div_work_pao_refund_tbl c where a.work_id=b.work_id and  b.work_id=c.work_id and b.REFUND_FLAG='p'";
    // System.out.println("district1999........:"+qry);
   	 stmt1=conn.createStatement();
     rs1=stmt1.executeQuery(qry);
   
  while (rs1.next())
	{ 
	  sanamt=rs1.getInt(3);
	  bankamt=rs1.getInt(4);
	  paoamt=rs1.getInt(5);
%>	  <tr>
		<td class=rptValue><%=sno++ %></td>
		<td class=rptValue NOWRAP><%=rs1.getString(1)%></td>
		<td class=rptValue NOWRAP><%=rs1.getString(2)%></td>
		<td class=rptValue NOWRAP><%=sanamt%></td>
		<td class=rptValue NOWRAP><%=rs1.getString(9)%></td>
		<td class=rptValue NOWRAP><%=bankamt%></td>

              <td class=rptValue NOWRAP><%=paoamt%></td>
			<td class=rptValue NOWRAP>-</td>
			<td class=rptValue NOWRAP>-</td>
			<td class=rptValue NOWRAP>-</td>

		<td class=rptValue NOWRAP><%=rs1.getString(5) %></td>
		<td class=rptValue NOWRAP><%=rs1.getString(6) %></td>
		<td class=rptValue NOWRAP><%=rs1.getString(7) %></td>
	  <%
	  
	}
	  
	  
	  
	  stmt3=conn.createStatement();
      
	     String qry2="select a.work_id,a.work_name,a.SANCTION_AMOUNT,b.refund_bill_amount,nvl(to_char(b.update_date,'dd/mm/yyyy'),'-'),b.REFUND_CHQ_NO,nvl(b.REMARKS,'-'),to_char(ADMIN_DATE) from rws_work_admn_tbl a,rws_div_work_bank_refund_tbl b where a.work_id=b.work_id and b.REFUND_FLAG='p'";
	    // System.out.println("bank11........:"+qry2);
	   	 stmt3=conn.createStatement();
	     rs3=stmt3.executeQuery(qry2);
	   
	  while (rs3.next())
		{ 
		  sanamt3=rs3.getInt(3);
		  bankamt3=rs3.getInt(4);
		  
	%>	  <tr>
	<td class=rptValue><%=sno++ %></td>
		<td class=rptValue NOWRAP><%=rs3.getString(1)%></td>
		<td class=rptValue NOWRAP><%=rs3.getString(2)%></td>
		<td class=rptValue NOWRAP><%=sanamt3%></td>
		<td class=rptValue NOWRAP><%=rs3.getString(8)%></td>
		<td class=rptValue NOWRAP><%=bankamt3%></td>
		
			<td class=rptValue NOWRAP><%=rs3.getString(5) %></td>
			<td class=rptValue NOWRAP><%=rs3.getString(6) %></td>
			<td class=rptValue NOWRAP><%=rs3.getString(7) %></td>
			<td class=rptValue NOWRAP>-</td>
			<td class=rptValue NOWRAP>-</td>
			<td class=rptValue NOWRAP>-</td>
			<td class=rptValue NOWRAP>-</td>
		  <%
gsanamt1=sanamt3+gsanamt1;
		  
		 
gbankamt13=bankamt3+gbankamt13;	  
//System.out.println(gbankamt13);
		}
	  
	  	    
	    
	  
		  stmt4=conn.createStatement();
	      
		     String qry4="select a.work_id,a.work_name,a.SANCTION_AMOUNT,b.refund_bill_amount, nvl(to_char(b.update_date,'dd/mm/yyyy'),'-'),b.REFUND_CHQ_NO,nvl(b.REMARKS,'-'),to_char(ADMIN_DATE) from rws_work_admn_tbl a,rws_div_work_pao_refund_tbl b where a.work_id=b.work_id and b.REFUND_FLAG='p'";
		     //System.out.println("district4........:"+qry4);
		   	 stmt4=conn.createStatement();
		     rs4=stmt4.executeQuery(qry4);
		   
		  while(rs4.next())
			{ 
			  sanamt4=rs4.getInt(3);
			  bankamt4=rs4.getInt(4);
			  
		%>	  <tr>
		<td class=rptValue><%=sno++ %></td>
		<td class=rptValue NOWRAP><%=rs4.getString(1)%></td>
		<td class=rptValue NOWRAP><%=rs4.getString(2)%></td>
		<td class=rptValue NOWRAP><%=sanamt4%></td>
		<td class=rptValue NOWRAP><%=rs4.getString(8)%></td>
		<td class=rptValue NOWRAP>-</td>
			<td class=rptValue NOWRAP>-</td>
			<td class=rptValue NOWRAP>-</td>
			<td class=rptValue NOWRAP>-</td>
		<td class=rptValue NOWRAP><%=bankamt4%></td>
		
				<td class=rptValue NOWRAP><%=rs4.getString(5) %></td>
				<td class=rptValue NOWRAP><%=rs4.getString(6) %></td>
				<td class=rptValue NOWRAP><%=rs4.getString(7) %></td>
				</tr>
			  <%
			  			}
	  
	  
          gsanamt+=sanamt4+gsanamt1+sanamt;	  
		  gbankamt+= bankamt+gbankamt13;
		  gpaoamt+=paoamt+bankamt4+gpaoamt;
	  
		  
	 
	    
  %>
	</tr>
	<td></td>
	<td></td>
	
	<td class=btext align=right>Total</td>
	<td class=btext><%=gsanamt%></td>
	<td>-</td>
	<td class=btext><%=gbankamt%></td>
		<td> -</td>
	    <td>-</td>
	    	<td>-</td>
	    	<td class=btext><%=gpaoamt%></td>
	<td class=btext>-</td>
	<td class=btext>-</td>
	<td class=btext>-</td>

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

