<%
	query ="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),count(ln.hab_code),nvl (e.TS_AMOUNT,'0'),nvl(e.TS_NO,'0'),nvl(to_char(e.TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e,RWS_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id  and w.work_id='"+wCode+"' group by nvl(w.WORK_NAME,'-'),nvl (e.work_id,'-'),nvl(e.TS_AMOUNT,'0'),e.TS_NO,e.ts_date,e.ssr_year";

try{	
//System.out.println("inside the technical");		
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 s1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	 rs = stmt.executeQuery(query);
	 rs.setFetchSize(500);
	 rs.last();
	 Count = rs.getRow();
	 //Debug.println("Total Records = "+Count);
	 rs.beforeFirst();%>

	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
	<tr>
		<td align="left" class="rptHeading" colspan=8>II. Technical Sanction Details</td>	
	</tr>
		
<%	
	if(Count!=0)
	{
	try
	{
	while(rs.next())
	{
		//System.out.println("TECHNICAL");
	//System.out.println("tech rs.getFloat(4)"+rs.getFloat(4));
	%>	
	    <tr bgcolor="#ffffff">
			<td class="btext">1. Sanction<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>
			<td class="rptValue"><%=rs.getFloat(4)%></td>
		</tr>
	    <tr bgcolor="#ffffff">
	    <td class="btext">2. Tech.SancNo/Tech.SancDate</td>
		<td class="rptValue"><%=rs.getString(5)%>/<br><%=rs.getString(6)%></td>			
		</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext">3. SSRYear</td>
    	<td class=rptValue><%=rs.getString(7)%></td>
    	</tr>
		<tr bgcolor="#ffffff">
		<td class="btext">4. No Of Habs</td>
		<td class=rptValue><b><%=rs.getString(3)%></b></td>
		</tr>
		<% 
	
		String qury ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e,RWS_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where w.work_id=e.work_id and e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+)  and ln.work_id='"+wCode+"' order by pr.panch_code";

		
		rs1 = st1.executeQuery(qury);
        rs1.setFetchSize(500);
        rs1.last();
        Count = rs1.getRow();
		rs1.beforeFirst();
		int sno=0;
		%>
		<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	
		<tr bgcolor="#ffffff">
		<td class="btext" >5. Habitations</td>
		<td class="btext">Total Population</td>
		<td class="btext" >Coverage Status</td>
		</tr>
		<%
		try
		{
		while(rs1.next())
		{
			//System.out.println("Tech Popuplation"+rs1.getString(2));
			%>
		<tr bgcolor="#ffffff">	
		<td class="rptValue"><%=++sno%>.&nbsp;<%=rs1.getString(2)%></td>
		<td class="rptValue" align="right"><%=rs1.getString(3)%></td>
		<td class="rptValue" align="center"><%=rs1.getString(4)%></td>
		</tr>
		
		<% }
		}
	catch(Exception e)
	{
	}
	finally
	{
	try
	{
		if(rs1!=null)rs1.close();
		if(st1!=null)st1.close();
	}catch(Exception e)
	{}
	}
		
    String q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),count(ln.hab_code),nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+wCode+"' group by w.WORK_NAME,e.work_id,e.rev_sanctioned_AMOUNT,e.rev_TS_NO,e.rev_TS_DATE,e.SSR_YEAR";
	
	//s2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	r= s.executeQuery(q1);
	r.setFetchSize(500);
	r.last();
	int tCounts = r.getRow();
	// Debug.println("Total Records = "+Count);
	r.beforeFirst();
	if(tCounts!=0)
	{
	try
	{
	while(r.next())
	{
		//System.out.println("Tech r.getString(1) rev"+r.getString(1));
%>	
		 <tr bgcolor="#ffffff">
			<td class="btext">(Revised To)</td>
		</tr>

		 <tr bgcolor="#ffffff">
			<td class="btext">1. Sanction<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>
			 <td class="rptValue" colspan="2"><%=r.getFloat(4)%></td>
		</tr>
	    <tr bgcolor="#ffffff">
	    <td class="btext">2. Tech.SancNo/Tech.SancDate</td>
		<td class="rptValue" colspan="2"><%=r.getString(5)%>/<br><%=r.getString(6)%></td>
		</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext">3. SSRYear</td>
    	<td class=rptValue colspan="2"><%=r.getString(7)%></td>
    	</tr>
		<tr bgcolor="#ffffff">
		<td class="btext">4. No Of Habs</td>
		<td class=rptValue align="left" colspan="2"><b><%=r.getString(3)%></b></td>
		</tr>
		
		<% 
	
		String q2 ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where  e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' order by pr.panch_code";

		r2 = s1.executeQuery(q2);
        r2.setFetchSize(500);
        r2.last();
        int Countss = r2.getRow();
		r2.beforeFirst();
		int sln=0;
		try
		{
		while(r2.next())
		{
%>
			
		<tr>
		<td class="rptValue"><%=++sln%>.&nbsp;<%=r2.getString(2)%></td>
		<td class="rptValue"><%=r2.getString(3)%></td>
		<td class="rptValue"><%=r2.getString(4)%></td>
		</tr>
		<% }
	
	}
	catch(Exception e){}
	finally
	{
	try
	{
		if(r2!=null)r2.close();

	}catch(Exception e){}
	}
	}	
	}
	catch(Exception e){}
	finally
	{
	try
	{
		if(r!=null)r.close();
		
	}catch(Exception e){}
	}
	}
	}
	}
	catch(Exception e){
	System.out.println("Exception in Technical"+e.getMessage());
	}
	finally
	{
	try
	{
		if(rs2!=null)rs2.close();
		if(stmt!=null)stmt.close();

	}catch(Exception e){}
	}
	}
else
	{%>
	 <tr bgcolor="#ffffff">
			<td class="btext" colspan="2">1. Sanction<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>
			<td class="rptValue">-</td>
		</tr>
	    <tr bgcolor="#ffffff">
	    <td class="btext" colspan="2">2. Tech.SancNo/Tech.SancDate</td>
		<td class="rptValue">-</td>			
		</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext" colspan="2">3. SSRYear</td>
    	<td class=rptValue>-</td>
    	</tr>
		<tr bgcolor="#ffffff">
		<td class="btext" colspan="2">4. No Of Habs</td>
		<td class=rptValue>-</td>
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext">5. Habitations</td>
		<td class="btext">Total Population</td>
		<td class="btext" >Coverage Status</td>
		</tr>
		<tr bgcolor="#ffffff">	
		<td class="rptValue">-</td>
		<td class="rptValue">-</td>
		<td class="rptValue">-</td>
		</tr>
	
		<% }
		}catch(Exception e)
		{}
		finally
		{
			if(s1!=null)s1.close();
			if(s!=null)s.close();
			if(stmt!=null)stmt.close();
			if(st1!=null)st1.close();
			
		}%>
</TABLE>
</table>
<br><br>
