<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>

<body>
<p align="right">
<%
String ccode=null,eoatno=null,dcode=null,sdcode=null,circlecode=null,divisioncode=null,subdivisioncode=null, programcode=null;
int slno=0;

ccode=request.getParameter("ccode");
dcode=request.getParameter("dcode");
sdcode=request.getParameter("sdcode");
eoatno=request.getParameter("eoatno");
circlecode=request.getParameter("circlecode");
divisioncode=request.getParameter("divisioncode");

%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_eoat_rpt_frm.jsp">Back</td> 
				</tr>
			</table>
		</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=32>Eoat Details Of&nbsp;<%=eoatno%></font></td>	
	</tr>
	    <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Eoat Date</td>
		<td class=btext >Cost Escalation<br>Sought</td>
		<td class=btext >Eoat Period</td>
		<td class=btext >Eoat Old<br>RefNo1</td>
		<td class=btext >Eoat Old<br>RefDt1</td>
		<td class=btext >Eoat Old<br>RefNo2</td>
		<td class=btext >Eoat Old<br>RefDt2</td>
		<td class=btext >Fine<br>Imposed</td>
		<td class=btext >Fine<br>Recovered</td>
        <td class=btext >Reasons For Not<br>RecovFine</td>
		<td class=btext >Officer Resp1</td>
		<td class=btext >Officer Resp2</td>
		<td class=btext >Officer Resp3</td>
		<td class=btext >Exempt Recomm<br>BySE</td>
		<td class=btext >Total Days<br>Exempt By SE</td>
		<td class=btext >Rate Of<br>Penalty</td>
		<td class=btext >Total<br>Penalty</td>
		<td class=btext >Reasons By<br>Contractor</td>
		<td class=btext>Contractor Rep<br>Upd Made</td>
		<td class=btext>Agreement Copy<br>Penalty Upd</td>
		<td class=btext>Supp Document<br>For Exemp Upd</td>
		<td class=btext>AEE<br>Recommend</td> 
		<td class=btext>DEE<br>Recommend</td>
		<td class=btext>EE<br>Recommend</td>
		<td class=btext>SE<br>Recommend</td>
		<td class=btext>CE<br>Recommend</td>
		<td class=btext>Eoat Grant<br>Authority</td>
		<td class=btext>Supp AgreeNo</td>
		<td class=btext>Supp AgreeDt</td>
		<td class=btext>Prepared By</td>
		<td class=btext>Prepared Date</td>
		</tr>
<%
       

	   try
		{
	   String str=" ";
	   
         if(ccode!=null && eoatno!=null)
			{
	   //out.println("in circle all,program al and  subprog all or subprog nt sel ,year all,month,al");
	   
	   str="select DISTINCT nvl(to_Char(EOAT_DATE,'dd-Mon-yyyy'),'-'),COST_ESCALATION_SOUGHT,EOAT_PERIOD,nvl(EOAT_OLD_REF_NO1,'-'),    nvl(to_Char(EOAT_OLD_REF_DT1,'dd-Mon-yyyy'),'-'),nvl(EOAT_OLD_REF_NO2,'-'),nvl(to_Char(EOAT_OLD_RED_DT2,'dd-Mon-yyyy'),'-'),FINE_IMPOSED,FINE_RECOVERED,    nvl(REASONS_FOR_NOT_RECOV_FINE,'-'),nvl(OFFICER_RESP1,'-'),nvl(OFFICER_RESP2,'-'),nvl(OFFICER_RESP3,'-'),nvl(EXEMPT_RECOMM_BY_SE,'-'),nvl(TOTAL_DAYS_EXEMPT_BY_SE,'-'),RATE_OF_PENALTY,TOTAL_PENALITY ,nvl(REASONS_BY_CONTRACTOR,'-') ,     nvl(CONTRACTOR_REP_MADE_UPD,'-'),nvl(AGREEMENT_COPY_PENALITY_UPD,'-'),nvl(SUPP_DOCUMENT_FOR_EXEMP_UPD,'-'),nvl(AEE_RECOMMEND,'-'),nvl(DEE_RECOMMEND,'-'),nvl(EE_RECOMMEND,'-'),nvl(SE_RECOMMEND,'-'),nvl(CE_RECOMMEND,'-'),nvl(EOAT_GRANT_AUTHORITY,'-'),nvl(SUPP_AGREE_NO,'-'), nvl(to_Char(SUPP_AGREE_DT,'dd-Mon-yyyy'),'-'),nvl(PREPARED_BY,'-'),nvl(to_Char(PREPARED_DATE,'dd-Mon-yyyy'),'-') from rws_eoat_tbl  where circle_office_code='"+ccode+"' and eoat_order_no='"+eoatno+"'";   
       // int slno=0;
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
 <td class=rptValue><%=++slno%></td>
<td class=rptValue><%=rs.getString(1)%></td>      			
 <td class=rptValue><%=rs.getFloat(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>	
<td class=rptValue><%=rs.getString(4)%></td>	
<td class=rptValue><%=rs.getString(5)%></td>	
<td class=rptValue><%=rs.getString(6)%></td>	
<td class=rptValue><%=rs.getString(7)%></td>	
<td class=rptValue><%=rs.getFloat(8)%></td>	
<td class=rptValue><%=rs.getString(9)%></td>
<td class=rptValue><%=rs.getString(10)%></td>      			
<td class=rptValue><%=rs.getString(11)%></td>
<td class=rptValue><%=rs.getString(12)%></td>	
<td class=rptValue><%=rs.getString(13)%></td>	
<td class=rptValue><%=rs.getString(14)%></td>	
<td class=rptValue><%=rs.getString(15)%></td>	
<td class=rptValue><%=rs.getFloat(16)%></td>	
<td class=rptValue><%=rs.getFloat(17)%></td>	
<td class=rptValue><%=rs.getString(18)%></td>
<td class=rptValue><%=rs.getString(19)%></td>
<td class=rptValue><%=rs.getString(20)%></td>	
<td class=rptValue><%=rs.getString(21)%></td>	
<td class=rptValue><%=rs.getString(22)%></td>
<td class=rptValue><%=rs.getString(23)%></td>	
<td class=rptValue><%=rs.getString(24)%></td>	
<td class=rptValue><%=rs.getString(25)%></td>	
<td class=rptValue><%=rs.getString(26)%></td>
<td class=rptValue><%=rs.getString(27)%></td>      			
<td class=rptValue><%=rs.getString(28)%></td>
<td class=rptValue><%=rs.getString(29)%></td>	
<td class=rptValue><%=rs.getString(30)%></td>	
<td class=rptValue><%=rs.getString(31)%></td>	
</tr>
<%}
		  ps.close(); 
		rs.close();   
	   }

	    if(circlecode!=null && dcode!=null && eoatno!=null)
			{
	   //out.println("in circle all,program al and  subprog all or subprog nt sel ,year all,month,al");
	   
	   str="select DISTINCT nvl(to_Char(EOAT_DATE,'dd-Mon-yyyy'),'-'),COST_ESCALATION_SOUGHT,EOAT_PERIOD,nvl(EOAT_OLD_REF_NO1,'-'),    nvl(to_Char(EOAT_OLD_REF_DT1,'dd-Mon-yyyy'),'-'),nvl(EOAT_OLD_REF_NO2,'-'),nvl(to_Char(EOAT_OLD_RED_DT2,'dd-Mon-yyyy'),'-'),FINE_IMPOSED,FINE_RECOVERED,    nvl(REASONS_FOR_NOT_RECOV_FINE,'-'),nvl(OFFICER_RESP1,'-'),nvl(OFFICER_RESP2,'-'),nvl(OFFICER_RESP3,'-'),nvl(EXEMPT_RECOMM_BY_SE,'-'),nvl(TOTAL_DAYS_EXEMPT_BY_SE,'-'),RATE_OF_PENALTY,TOTAL_PENALITY ,nvl(REASONS_BY_CONTRACTOR,'-') ,     nvl(CONTRACTOR_REP_MADE_UPD,'-'),nvl(AGREEMENT_COPY_PENALITY_UPD,'-'),nvl(SUPP_DOCUMENT_FOR_EXEMP_UPD,'-'),nvl(AEE_RECOMMEND,'-'),nvl(DEE_RECOMMEND,'-'),nvl(EE_RECOMMEND,'-'),nvl(SE_RECOMMEND,'-'),nvl(CE_RECOMMEND,'-'),nvl(EOAT_GRANT_AUTHORITY,'-'),nvl(SUPP_AGREE_NO,'-'), nvl(to_Char(SUPP_AGREE_DT,'dd-Mon-yyyy'),'-'),nvl(PREPARED_BY,'-'),nvl(to_Char(PREPARED_DATE,'dd-Mon-yyyy'),'-') from rws_eoat_tbl  where circle_office_code='"+circlecode+"' and division_office_code='"+dcode+"' and eoat_order_no='"+eoatno+"'";   
        //int slno=0;
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
 <td class=rptValue><%=++slno%></td>
<td class=rptValue><%=rs.getString(1)%></td>      			
 <td class=rptValue><%=rs.getFloat(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>	
<td class=rptValue><%=rs.getString(4)%></td>	
<td class=rptValue><%=rs.getString(5)%></td>	
<td class=rptValue><%=rs.getString(6)%></td>	
<td class=rptValue><%=rs.getString(7)%></td>	
<td class=rptValue><%=rs.getFloat(8)%></td>	
<td class=rptValue><%=rs.getString(9)%></td>
<td class=rptValue><%=rs.getString(10)%></td>      			
<td class=rptValue><%=rs.getString(11)%></td>
<td class=rptValue><%=rs.getString(12)%></td>	
<td class=rptValue><%=rs.getString(13)%></td>	
<td class=rptValue><%=rs.getString(14)%></td>	
<td class=rptValue><%=rs.getString(15)%></td>	
<td class=rptValue><%=rs.getFloat(16)%></td>	
<td class=rptValue><%=rs.getFloat(17)%></td>	
<td class=rptValue><%=rs.getString(18)%></td>
<td class=rptValue><%=rs.getString(19)%></td>
<td class=rptValue><%=rs.getString(20)%></td>	
<td class=rptValue><%=rs.getString(21)%></td>	
<td class=rptValue><%=rs.getString(22)%></td>
<td class=rptValue><%=rs.getString(23)%></td>	
<td class=rptValue><%=rs.getString(24)%></td>	
<td class=rptValue><%=rs.getString(25)%></td>	
<td class=rptValue><%=rs.getString(26)%></td>
<td class=rptValue><%=rs.getString(27)%></td>      			
<td class=rptValue><%=rs.getString(28)%></td>
<td class=rptValue><%=rs.getString(29)%></td>	
<td class=rptValue><%=rs.getString(30)%></td>	
<td class=rptValue><%=rs.getString(31)%></td>	
</tr>
<%}
		ps.close();   
		rs.close();   
	   }
	   if(circlecode!=null && divisioncode!=null && sdcode!=null && eoatno!=null)
			{
	   //out.println("in circle all,program al and  subprog all or subprog nt sel ,year all,month,al");
	   
	   str="select DISTINCT nvl(to_Char(EOAT_DATE,'dd-Mon-yyyy'),'-'),COST_ESCALATION_SOUGHT,EOAT_PERIOD,nvl(EOAT_OLD_REF_NO1,'-'),    nvl(to_Char(EOAT_OLD_REF_DT1,'dd-Mon-yyyy'),'-'),nvl(EOAT_OLD_REF_NO2,'-'),nvl(to_Char(EOAT_OLD_RED_DT2,'dd-Mon-yyyy'),'-'),FINE_IMPOSED,FINE_RECOVERED,    nvl(REASONS_FOR_NOT_RECOV_FINE,'-'),nvl(OFFICER_RESP1,'-'),nvl(OFFICER_RESP2,'-'),nvl(OFFICER_RESP3,'-'),nvl(EXEMPT_RECOMM_BY_SE,'-'),nvl(TOTAL_DAYS_EXEMPT_BY_SE,'-'),RATE_OF_PENALTY,TOTAL_PENALITY ,nvl(REASONS_BY_CONTRACTOR,'-') ,     nvl(CONTRACTOR_REP_MADE_UPD,'-'),nvl(AGREEMENT_COPY_PENALITY_UPD,'-'),nvl(SUPP_DOCUMENT_FOR_EXEMP_UPD,'-'),nvl(AEE_RECOMMEND,'-'),nvl(DEE_RECOMMEND,'-'),nvl(EE_RECOMMEND,'-'),nvl(SE_RECOMMEND,'-'),nvl(CE_RECOMMEND,'-'),nvl(EOAT_GRANT_AUTHORITY,'-'),nvl(SUPP_AGREE_NO,'-'), nvl(to_Char(SUPP_AGREE_DT,'dd-Mon-yyyy'),'-'),nvl(PREPARED_BY,'-'),nvl(to_Char(PREPARED_DATE,'dd-Mon-yyyy'),'-') from rws_eoat_tbl  where circle_office_code='"+circlecode+"' and division_office_code='"+divisioncode+"' and subdivision_office_code='"+sdcode+"' and eoat_order_no='"+eoatno+"'";   
        //int slno=0;
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
 <td class=rptValue><%=++slno%></td>
<td class=rptValue><%=rs.getString(1)%></td>      			
 <td class=rptValue><%=rs.getFloat(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>	
<td class=rptValue><%=rs.getString(4)%></td>	
<td class=rptValue><%=rs.getString(5)%></td>	
<td class=rptValue><%=rs.getString(6)%></td>	
<td class=rptValue><%=rs.getString(7)%></td>	
<td class=rptValue><%=rs.getFloat(8)%></td>	
<td class=rptValue><%=rs.getString(9)%></td>
<td class=rptValue><%=rs.getString(10)%></td>      			
<td class=rptValue><%=rs.getString(11)%></td>
<td class=rptValue><%=rs.getString(12)%></td>	
<td class=rptValue><%=rs.getString(13)%></td>	
<td class=rptValue><%=rs.getString(14)%></td>	
<td class=rptValue><%=rs.getString(15)%></td>	
<td class=rptValue><%=rs.getFloat(16)%></td>	
<td class=rptValue><%=rs.getFloat(17)%></td>	
<td class=rptValue><%=rs.getString(18)%></td>
<td class=rptValue><%=rs.getString(19)%></td>
<td class=rptValue><%=rs.getString(20)%></td>	
<td class=rptValue><%=rs.getString(21)%></td>	
<td class=rptValue><%=rs.getString(22)%></td>
<td class=rptValue><%=rs.getString(23)%></td>	
<td class=rptValue><%=rs.getString(24)%></td>	
<td class=rptValue><%=rs.getString(25)%></td>	
<td class=rptValue><%=rs.getString(26)%></td>
<td class=rptValue><%=rs.getString(27)%></td>      			
<td class=rptValue><%=rs.getString(28)%></td>
<td class=rptValue><%=rs.getString(29)%></td>	
<td class=rptValue><%=rs.getString(30)%></td>	
<td class=rptValue><%=rs.getString(31)%></td>	
</tr>
<%}
		ps.close();   
		rs.close();   
	   }
	 if(slno==0)
			{%>
		 <tr align="center">
           <td class=rptHeading colspan=10><a href="./rws_eoat_rpt_frm.jsp"><%="No Records For this Query"%></a></td></tr>

	 <% 
			} 
	  }
   catch(Exception e)
   {
	    e.printStackTrace();
   }
    finally
	{
	conn.close();
	}
	%>
	</table>
    </body>
	</html>
	<%@ include file = "footer.jsp" %>
