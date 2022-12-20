
<%
     query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where w.work_id=con.work_id  and con.work_id=ten.work_id  and con.work_id='"+wCode+"'";
	 /*query ="select distinct nvl(con.work_id,'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.work_id=ten.work_id and  substr(con.work_id,5,2)='"+dCode+"'";*/
     try{
	 //t.println(query);
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);	
	// ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	rs = stmt.executeQuery(query);
	rs.setFetchSize(500);
	rs.last();
	Count = rs.getRow();
	rs.beforeFirst();
	String a[]=new String[10];
%>



<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
	<tr align="center">
		<td align="left" class="rptHeading" colspan=10>IV.Contractor Details</font></td>	
	</tr>

	
	
<%	int csno=0,chabs=1,chabs1=0,cha=1;
	if(Count!=0)
	{
	try
	{
		while(rs.next())
		{
		// System.out.println("contractor");
		 String cqury1="select distinct ten.TENDER_IDNO,ten.TENDER_AMOUNT,nvl(ten.CONTRACTOR_NAME,'-'),nvl(to_char(con.TENDER_APPROVED_ON,'dd-mm-yyyy'),'-'),nvl(TO_CHAR(con.LOA_ISSUED_ON,'DD-MON-YYYY'),'-'),nvl(con.AGREEMENT_REFERENCE_NO,'-'),nvl(TO_CHAR(con.AGREEMENT_DATE,'DD-MON-YYYY'),'-'),nvl(con.AGREEMENT_DURATION,'0'),nvl(con.AGREEMENT_VALUE,'0'),nvl(TO_CHAR(con.SITE_HAND_OVER_DATE,'DD-MON-YYYY'),'-'),nvl(TO_CHAR(con.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.TENDER_IDNO=ten.TENDER_IDNO and con.work_id='"+wCode+"'";
        
		//out.println(qury1);
        rs1 = st1.executeQuery(cqury1);       
	    rs1.beforeFirst();
	    try
	    {
		while(rs1.next())
		{
		csno++;
 %>
	  
		<tr bgcolor="#ffffff" >
		<td class="btext" nowrap>1. Tender Notification Id</td>
		<td class=rptValue nowrap><%=rs1.getString(1)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >2. Tender Cost(In Lakhs)</td>
		<td class=rptValue ><%=rs1.getFloat(2)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >3. Contractor Name</td>
		<td class=rptValue ><%=rs1.getString(3)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext"  >4. Tender<br>&nbsp;&nbsp;&nbsp;&nbsp;Accepted Date</td>
		<td class=rptValue ><%=rs1.getString(4)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		 <td class="btext">5. LOA<BR>&nbsp;&nbsp;&nbsp;&nbsp;issued on date</td>
		<td class=rptValue ><%=rs1.getString(5)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >6. Agreement RefNo</td>
		<td class=rptValue ><%=rs1.getString(6)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >7. Agreement Date</td>
		<td class=rptValue ><%=rs1.getString(7)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >8. Agreement Duration<br>&nbsp;&nbsp;&nbsp;&nbsp;In Months</td>
		<td class=rptValue ><%=rs1.getString(8)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >9. Agreement Value</td>
		<td class=rptValue ><%=rs1.getString(9)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >10. Site Handing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Over Date</td>
		<td class=rptValue ><%=rs1.getString(10)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >11. Stipulated Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue ><%=rs1.getString(11)%></td>
	    </tr>
		<% }
		}
		catch(Exception e){}
		finally
		{
		try
		{
			if(rs1!=null)rs1.close();
			if(st1!=null)st1.close();
		}catch(Exception e){}
		}
		
	   String cq="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),mil.PERCENT_COMPLETED from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+wCode+"'"; 
		
       rs2 = st2.executeQuery(cq);
       rs2.setFetchSize(500);
       rs2.last();
       Cnt = rs2.getRow();
       rs2.beforeFirst();
	   int cserial=1;
	   int number=1;
 %>
	  	<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	
		 <tr bgcolor="#ffffff">	   
			<td class="btext">Slno</td>
			<td class="btext" >Milestone</td>  
			<td class="btext">Stage</td>
			<td class="btext">TargetDate</td> 
			<td class="btext">Percent<br>Completed</td> 
		</tr>	   
  <%
	   if(Cnt!=0)
	   {
	   try
	   {
	   	while(rs2.next())
		{	 
		//System.out.println("cserial Value "+cserial);		
		if(number==1)
		{
		number++;
	%>
	<tr bgcolor="#ffffff">	   
		<td class=rptValue ><%=cserial%></td>
		<td class=rptValue ><%=rs2.getString(1)%></td>
		<td class=rptValue><%=rs2.getString(2)%></td>
		<td class=rptValue><%=rs2.getString(3)%></td>
		<td class=rptValue><%=rs2.getString(4)%></td>
		</tr>
		<%}if(cserial>1)
		{
		for(int i=1;i<cserial;i++)
		{ 
		//System.out.println("cserial in For "+cserial); 
		%>
	<tr bgcolor="#ffffff">	   
		
		<td class=rptValue><%=cserial%></td>
		<td class=rptValue><%=rs2.getString(1)%></td>
		<td class=rptValue><%=rs2.getString(2)%></td>
		<td class=rptValue><%=rs2.getString(3)%></td>
		<td class=rptValue><%=rs2.getString(4)%></td>
		</tr>
		<%
		}
		}
		%>
	
 	<%cserial++;
		}
		}
	catch(Exception e){}
	finally
	{
	try
	{
		if(rs2!=null)rs2.close();
		if(st2!=null)st2.close();
	}catch(Exception e){}
	} %>
	  
		 	
		<% 		
		}
		else
		{%>
	<tr bgcolor="#ffffff">	
		<td class=rptValue align="center">-</td>
	 	<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		</tr>
		
		<% }
		%>
		</table>
		<%
         
	} 
	}
	catch(Exception e){
	System.out.println("Exception in Contract"+e.getMessage());
	}
	finally
	{
	try
	{
		if(rs!=null)rs.close();
		if(stmt!=null)stmt.close();
	}catch(Exception e){}
	}
		
	}
	else
	{%>
		<tr bgcolor="#ffffff" >
		<td class="btext" nowrap>1. Tender Notification Id</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext">2. Tender Cost(In Lakhs)</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext">3. Contractor Name</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext">4. Tender<br>&nbsp;&nbsp;&nbsp;&nbsp;Accepted Date</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		 <td class="btext">5. LOA<BR>&nbsp;&nbsp;&nbsp;&nbsp;issued on date</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext">6. Agreement RefNo</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext">7. Agreement Date</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext" >8. Agreement Duration<br>&nbsp;&nbsp;&nbsp;&nbsp;In Months</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext">9. Agreement Value</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext">10. Site Handing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Over Date</td>
		<td class=rptValue colspan="4">-</td>
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext" >11. Stipulated Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue colspan="4">-</td>
	    </tr>
	     <tr bgcolor="#ffffff">	   
		<td class="btext">Slno</td>
		<td class="btext" >Milestone</td>  
		<td class="btext">Stage</td>
		<td class="btext">TargetDate</td> 
		<td class="btext">Percent<br>Completed</td> 
	</tr>	
	<tr bgcolor="#ffffff">	
		<td class=rptValue align="left">-</td>
	 	<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		</tr>
	<!--  <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=18 align=center><b><font color="blue">No Contract details</font></b></td>
		</tr>-->
		<% }
		}catch(Exception e)
		{}
		finally
		{
		  if(stmt!=null)stmt.close();
		  if(st1!=null)st1.close();
		  if(st2!=null)st2.close();
		}
		
		%>
		</table>
	<br>
	<br>
	
	
