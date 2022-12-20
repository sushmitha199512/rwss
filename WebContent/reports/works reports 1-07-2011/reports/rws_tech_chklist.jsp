<%
String qurysdd ="";
	query ="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),count(ln.hab_code),nvl (e.TS_AMOUNT,'0'),nvl(e.TS_NO,'0'),nvl(to_char(e.TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-'),TYPE_OF_ASSET,no_of_schools,no_of_labs  from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e,RWS_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id  and w.work_id='"+wCode+"' group by nvl(w.WORK_NAME,'-'),nvl (e.work_id,'-'),nvl(e.TS_AMOUNT,'0'),e.TS_NO,e.ts_date,e.ssr_year,TYPE_OF_ASSET,no_of_schools,no_of_labs";
			
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	 rs = stmt.executeQuery(query);
	// System.out.println("qq::"+query);
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
	{%>
	
	<% while(rs.next())
	{
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
		<% 
		//System.out.println("asset::"+rs.getString(8));
		 if(rs.getString(8).equals("11"))
		{
		%>
		<td class="btext">4. No Of Schools</td>
		<td class=rptValue><b><%=rs.getString(9)%></b></td>
		</tr>
		<%}else  if(rs.getString(8).equals("12")){%>
		<td class="btext">4. No Of Labs</td>
		<td class=rptValue><b><%=rs.getString(10)%></b></td>
		</tr>
		<%}else{%>
		<td class="btext">4. No Of Habs</td>
		<td class=rptValue><b><%=rs.getString(3)%></b></td>
		</tr>
		<%}%>
		
		<% 
	 if(rs.getString(8).equals("11"))
		{
	      qurysdd ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-'),school_name from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e,RWS_work_school_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h ,rws_school_master_tbl s where w.work_id=e.work_id and e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+)  and ln.work_id='"+wCode+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code order by pr.panch_code";
		}
		else  if(rs.getString(8).equals("12"))
		{
		  qurysdd ="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name  from rws_division_office_tbl d ,rws_work_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+wCode+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
		}else
		{
          qurysdd ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e,RWS_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where w.work_id=e.work_id and e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+)  and ln.work_id='"+wCode+"' order by pr.panch_code";
		}

		//System.out.println("qwqwqw::"+qurysdd);
		rs1 = st1.executeQuery(qurysdd);
        rs1.setFetchSize(500);
        rs1.last();
        Count = rs1.getRow();
		rs1.beforeFirst();
		int sno=0;
		%>
		<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	
		<tr bgcolor="#ffffff">
          <%if(rs.getString(8).equals("11")){%>
          <td class="btext" >5. Habitation/School Name</td>
		  <%}else if(rs.getString(8).equals("12")){%>
        <td class="btext" >5. Division/Lab Name</td>
		<%}else{%>
			<td class="btext" >5. Habitations</td>
			<%}%>
		<td class="btext">Total Population</td>
		<td class="btext" >Coverage Status</td>
		</tr>
		<%
		while(rs1.next())
		{
			//System.out.println("Tech Popuplation"+rs1.getString(2));
			%>
		<tr bgcolor="#ffffff">	
		 <%if(rs.getString(8).equals("11")){%>
			 <td class="rptValue"><%=++sno%>.&nbsp;<%=rs1.getString(2)%>/<%=rs1.getString(5)%></td>
			 <td class="rptValue" align="right"><%=rs1.getString(3)%></td>
			 <td class="rptValue" align="center"><%=rs1.getString(4)%></td>
      <%}else if(rs.getString(8).equals("12")){%>
			<td class="rptValue"><%=++sno%>.&nbsp;<%=rs1.getString(2)%>/<%=rs1.getString(3)%></td>
			<td class=rptValue align="center">-</td>
			<td class=rptValue align="center">-</td>
  <%}else{%>
			<td class="rptValue"><%=++sno%>.&nbsp;<%=rs1.getString(2)%></td>
			<td class="rptValue" align="right"><%=rs1.getString(3)%></td>
			<td class="rptValue" align="center"><%=rs1.getString(4)%></td>
   <%}%>
		</tr>
		<% }
			 String q1="";
			if(rs.getString(8).equals("11"))
			 {
      	       q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),no_of_schools,nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-'),TYPE_OF_ASSET  from RWS_REVISED_ADM_SANC_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_school_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+wCode+"' group by w.WORK_NAME,e.work_id,e.rev_sanctioned_AMOUNT,e.rev_TS_NO,e.rev_TS_DATE,e.SSR_YEAR,TYPE_OF_ASSET,no_of_schools";
			}
			else if(rs.getString(8).equals("12"))
			{
              q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),no_of_labs,nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-'),TYPE_OF_ASSET  from RWS_REVISED_ADM_SANC_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_lab_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+wCode+"' group by w.WORK_NAME,e.work_id,e.rev_sanctioned_AMOUNT,e.rev_TS_NO,e.rev_TS_DATE,e.SSR_YEAR,TYPE_OF_ASSET,no_of_labs";
			}
			else
		   {
			 q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),count(ln.hab_code),nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-'),TYPE_OF_ASSET  from RWS_REVISED_ADM_SANC_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+wCode+"' group by w.WORK_NAME,e.work_id,e.rev_sanctioned_AMOUNT,e.rev_TS_NO,e.rev_TS_DATE,e.SSR_YEAR,TYPE_OF_ASSET";
		}
		//System.out.println("qqqq:"+q1);
 s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 s1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
// s2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

r= s.executeQuery(q1);
r.setFetchSize(500);
 r.last();
int tCounts = r.getRow();
// Debug.println("Total Records = "+Count);
r.beforeFirst();
if(tCounts!=0)
		{
	while(r.next())
			{
			//System.out.println("Tech r.getString(1) rev"+r.getString(1));
               %>	
	    <tr bgcolor="#ffffff">
	    <td class=rptValue colspan="2"><b><%=r.getString(1)%><br>(Revised To)</br></b></td>
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
		<% 
		//System.out.println("asset::"+rs.getString(8));
		 if(r.getString(8).equals("11"))
		{
		%>
		<td class="btext">4. No Of Schools</td>
		<%}else  if(r.getString(8).equals("12")){%>
		<td class="btext">4. No Of Labs</td>
		<%}else{%>
		<td class="btext" >4. No Of Habs</td>
		<%}%>
		<td class=rptValue colspan="2"><b><%=r.getString(3)%></b></td>
		</tr>
		
 
	<% 
			String q2 ="";
	 if(rs.getString(8).equals("11"))
		{
	    // q2 ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-'),school_name from RWS_REVISED_ADM_SANC_TBL w,RWS_NEW_EST_TBL e,RWS_work_school_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h ,rws_school_master_tbl s where w.work_id=e.work_id and e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+)  and ln.work_id='"+wCode+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code order by pr.panch_code";
		q2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') AS TOTAL,nvl(coverage_status,'-') AS STATUS ,school_name from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_school_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h ,rws_school_master_tbl s where e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' AND H.COVERAGE_STATUS IS NOT NULL AND H.COVERAGE_STATUS<>'UI' and s.school_code=ln.school_code and h.hab_code=s.hab_code order by pr.panch_code";
		}
		else  if(rs.getString(8).equals("12"))
		{
	q2 ="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name  from rws_division_office_tbl d ,rws_work_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+wCode+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
		}else
		{
          q2 ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_REVISED_ADM_SANC_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where  e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' order by pr.panch_code";
		}
	 
//System.out.println("query in revised:::"+q2);
		r2 = s1.executeQuery(q2);
	//	System.out.println("query in revised::1:");
        r2.setFetchSize(500);
	//	System.out.println("query in revised::2:");
        r2.last();
        int Countss = r2.getRow();
	//	System.out.println("query in revised::3:"+Countss);
		r2.beforeFirst();
		int sln=0;
    //    System.out.println("query in revised::4:"+sln);
		%>
		<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	
		<tr bgcolor="#ffffff">
		 <%if(rs.getString(8).equals("11")){//System.out.println("query in revised::5:"+rs.getString(8));%>
          <td class="btext" >5. Habitation/School Name</td>
		  <%}else if(rs.getString(8).equals("12")){%>
        <td class="btext" >5. Division/Lab Name</td>
		<%}else{%>
			<td class="btext" >5. Habitations</td>
			<%}%>
		<td class="btext">Total Population</td>
		<td class="btext" >Coverage Status</td>
		</tr>
		<%
		while(r2.next())
		{
		%>
		
		<tr bgcolor="#ffffff">	
		<%if(rs.getString(8).equals("11")){//System.out.println("query in revised::6:"+rs.getString(8));%>
			 <td class="rptValue"><%=++sln%>.&nbsp;<%=r2.getString(2)%>/<%=r2.getString(5)%></td>
			 <td class="rptValue" align="right"><%=r2.getString(3)%></td>
			 <td class="rptValue" align="center"><%=r2.getString(4)%></td>
      <%}else if(rs.getString(8).equals("12")){%>
			<td class="rptValue"><%=++sln%>.&nbsp;<%=r2.getString(2)%>/<%=r2.getString(3)%></td>
			<td class=rptValue align="center">-</td>
			<td class=rptValue align="center">-</td>
  <%}else{%>
			<td class="rptValue"><%=++sln%>.&nbsp;<%=r2.getString(2)%></td>
			<td class="rptValue" align="right"><%=r2.getString(3)%></td>
			<td class="rptValue" align="center"><%=r2.getString(4)%></td>
   <%}%>
		</tr>
	
		<% }
			
			}
} 
	}
	}
else
	{%>
	 <tr bgcolor="#ffffff">
			<td class="btext">1. Sanction<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>
			<td class="rptValue">-</td>
		</tr>
	    <tr bgcolor="#ffffff">
	    <td class="btext">2. Tech.SancNo/Tech.SancDate</td>
		<td class="rptValue">-</td>			
		</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext">3. SSRYear</td>
    	<td class=rptValue>-</td>
    	</tr>
		<tr bgcolor="#ffffff">
		<td class="btext">4. No Of Habs</td>
		<td class=rptValue>-</td>
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext" >5. Habitations</td>
		<td class="btext">Total Population</td>
		<td class="btext" >Coverage Status</td>
		</tr>
		<tr bgcolor="#ffffff">	
		<td class="rptValue">-</td>
		<td class="rptValue">-</td>
		<td class="rptValue">-</td>
		</tr>
	
	<!--  <tr bgcolor="#ffffff">
		<td class=rptValue colspan=7 align=center><b><font color=blue>No Technical Sanction Records</font></b></td>
		
		</tr>-->
		<% }%>
</TABLE>
</table>
<br><br>
