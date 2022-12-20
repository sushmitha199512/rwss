<%
     query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMP_HAB_LNK_TBL LN where w.work_id=con.work_id and w.work_id=com.work_id and W.WORK_ID=COMM.WORK_ID AND W.WORK_ID=LN.WORK_ID  and w.work_id='"+wCode+"'"; 
	 /*query ="select distinct nvl(con.work_id,'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.work_id=ten.work_id and  substr(con.work_id,5,2)='"+dCode+"'";*/
	 //t.println(query);
try{
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	// ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);


	 rs = stmt.executeQuery(query);
	 rs.setFetchSize(500);
	 rs.last();
	 Count = rs.getRow();
	 rs.beforeFirst();%>

<table border = 1 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
		
	<tr>
		<td align="left" class="rptHeading" colspan=12>VII. Work Completion Details</font></td>	
	</tr>

<%	
	 int wccsno=0,wcchabs=1,wcchabs1=0,wccha=1;
	if(Count!=0)
	{
	try
	{
	while(rs.next())
	{ 
		//System.out.println("WORKCOMPL");
		wccsno++;
		String wccqury1="select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD- MON-YYYY'),'-'),count(ln.hab_code) from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMP_HAB_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+wCode+"' group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION, COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM";
        
		//out.println(qury1);
        rs1 = st1.executeQuery(wccqury1);
	    rs1.beforeFirst();
	    try
	    {
		while(rs1.next())
		{
		//System.out.println("work rs1.getString(1)"+rs1.getString(1));
	%>
		<tr  bgcolor="#ffffff">
		<td class="btext">1. Start Date</td>
		<td class=rptValue ><%=rs1.getString(1)%></td>
		</tr>
		
		<tr  bgcolor="#ffffff">
		<td class="btext" >2. Stipulated Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue ><%=rs1.getString(2)%></td>
		</tr>
		
		<tr  bgcolor="#ffffff" >
		<td class="btext">3. Actual Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue ><%=rs1.getString(3)%></td>
		</tr>
		
		<tr  bgcolor="#ffffff" >
		<td class="btext" >4. Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Commissioning</td>
		<td class=rptValue ><%=rs1.getString(4)%></td>
		</tr>
		
		<tr  bgcolor="#ffffff">
		<td class="btext" >5. Habitations<br>&nbsp;&nbsp;&nbsp;&nbsp;Benefited</td>
		<td class=rptValue ><b><%=rs1.getString(5)%></b></td>
		</tr>
		
<% 
			String wccq="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),NVL(COVERAGE_STATUS,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_WORK_COMP_HAB_LNK_TBL ln,rws_habitation_directory_tbl h where  ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' order by pr.panch_code"; 

           rs2 = st2.executeQuery(wccq);
           rs2.setFetchSize(500);
           rs2.last();
           Cnt = rs2.getRow();
           rs2.beforeFirst();
           %>
        <table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	
        <tr  bgcolor="#ffffff">  
		<td class="btext" >6. Habitations</td>
		 <td class="btext">Plain Pop</td>
		  <td class="btext">SC Pop</td>
		  <td class="btext">ST Pop</td>
		  <td class="btext">Total</td>
		   <td class="btext">Coverage Status</td>
		   </tr>
		
           <%
		if(Cnt!=0)
		{
		try
		{
		int wccserial=0;
		while(rs2.next())
		{ 
		wccserial++;
		//System.out.println("work rs2.getString(2)"+rs2.getString(2));
		%>			
		<tr  bgcolor="#ffffff">  
		<td class=rptValue><%=wccserial%>.&nbsp;<%=rs2.getString(2)%></td>
		<td class=rptValue align="right"><%=rs2.getString(3)%></td>
		<td class=rptValue align="right"><%=rs2.getString(4)%></td>
		<td class=rptValue align="right"><%=rs2.getString(5)%></td>
		<td class=rptValue align="right"><%=rs2.getString(6)%></td>
		<td class=rptValue align="center"><%=rs2.getString(7)%></td>
		</tr>
		
<% 
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
		}
		}
		else
		{%>
		<tr bgcolor="#ffffff"> 
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center" >-</td>
		<td class=rptValue align="center">-</td>
		</tr>
		<% }
			%>
		</table>
		<%
		
         
	} 
	}catch(Exception e){
		System.out.println("Exception in workCompletion"+e.getMessage());
		}
		finally
		{
		try
		{
			if(rs1!=null)rs1.close();
			if(st1!=null)st1.close();
		}catch(Exception e){}
		}
		}
			}
			catch(Exception e){
			System.out.println("Exception in workCompletion"+e.getMessage());
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
		<tr  bgcolor="#ffffff">
		<td class="btext">1. Start Date</td>
		<td class=rptValue colspan="5">-</td>
		</tr>
		
		<tr  bgcolor="#ffffff">
		<td class="btext" >2. Stipulated Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue colspan="5">-</td>
		</tr>
		
		<tr  bgcolor="#ffffff" >
		<td class="btext">3. Actual Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue colspan="5">-</td>
		</tr>
		
		<tr  bgcolor="#ffffff" >
		<td class="btext" >4. Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Commissioning</td>
		<td class=rptValue colspan="5">-</td>
		</tr>
		
	<tr  bgcolor="#ffffff">
		<td class="btext">5. Habitations<br>&nbsp;&nbsp;&nbsp;&nbsp;Benefited</td>
		<td class=rptValue colspan="5">-</b></td>
	 </tr>
	 <tr bgcolor="#ffffff">  
		 <td class="btext" >6. Habitations</td>
		 <td class="btext">Plain Pop</td>
		 <td class="btext">SC Pop</td>
		 <td class="btext">ST Pop</td>
		 <td class="btext">Total</td>
		 <td class="btext">Coverage Status</td>
	 </tr>
	 <tr bgcolor="#ffffff"> 
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center" >-</td>
		<td class=rptValue align="center">-</td>
	</tr>
	 <!-- <tr bgcolor="#ffffff">
	 <td colspan=5></td>
	 <tr>
		<td class=rptValue colspan=18 align=center><b><font color="blue">No Work Completion Records</font></b></td>
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

