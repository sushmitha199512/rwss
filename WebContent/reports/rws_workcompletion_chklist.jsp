<%
//String schName1 = String.valueOf(session.getAttribute("schName"));
String schName1 = String.valueOf(session.getAttribute("schName"));


//System.out.println("in work completionj:1::::::::"+schName1);
if(schName1.equals("SCHOOLS"))
{
    query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-'),type_of_asset  from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_school_LNK_TBL LN where w.work_id=con.work_id and w.work_id=com.work_id and W.WORK_ID=COMM.WORK_ID AND W.WORK_ID=LN.WORK_ID  and w.work_id='"+wCode+"'"; 
}
else if(schName1.equals("LAB"))
{
 query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-'),type_of_asset  from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMP_HAB_LNK_TBL LN where w.work_id=con.work_id and w.work_id=com.work_id and W.WORK_ID=COMM.WORK_ID AND W.WORK_ID=LN.WORK_ID  and w.work_id='"+wCode+"'"; 
}else
{
	 query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-'),type_of_asset  from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMP_HAB_LNK_TBL LN where w.work_id=con.work_id and w.work_id=com.work_id and W.WORK_ID=COMM.WORK_ID AND W.WORK_ID=LN.WORK_ID  and w.work_id='"+wCode+"'"; 
}
	 /*query ="select distinct nvl(con.work_id,'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.work_id=ten.work_id and  substr(con.work_id,5,2)='"+dCode+"'";*/
	 //t.println(query);
//System.out.println("in work completionj::::2:::::"+query);
 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//System.out.println("in work completionj:::3::::::"+rs.getString(3));

 rs = stmt.executeQuery(query);
rs.setFetchSize(500);
//System.out.println("in work completionj:::::4::::"+rs.getString(3));
 rs.last();
// System.out.println("in work completionj::::5::::");
Count = rs.getRow();
rs.beforeFirst();%>

<form>
<table >
		
	<tr >
		<td align="left" class="rptHeading" colspan=12> V. Work Completion Details</font></td>	
	</tr>

<%	

	 int wccsno=0,wcchabs=1,wcchabs1=0,wccha=1;
	 String wccqury1="";
	if(Count!=0)
	{
	while(rs.next())
	{ 
			
		wccsno++;
	
		if(rs.getString(3).equals("11"))
		{
		    wccqury1="select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD- MON-YYYY'),'-'),count(ln.hab_code) from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_school_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+wCode+"' group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION, COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM";
		}
		else if(rs.getString(3).equals("12"))
		{
           wccqury1="select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD- MON-YYYY'),'-'),count(ln.lab_code) from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_lab_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+wCode+"'  and ln.WORK_ID='"+wCode+"'  group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION, COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM";
		}
		else
		{
		  wccqury1="select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD- MON-YYYY'),'-'),count(ln.hab_code) from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMP_HAB_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+wCode+"' group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION, COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM";
		}

        //System.out.println("query:::in work completion:"+wccqury1);
		//out.println(qury1);
        rs1 = st1.executeQuery(wccqury1);
	    rs1.beforeFirst();
		while(rs1.next())
		{
		//System.out.println("work rs1.getString(1)"+rs1.getString(1));
	%>
		<tr  bgcolor="#ffffff">
		<td class="btext">1. Start Date</td>
		<td class=rptValue><%=rs1.getString(1)%></td>
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
		<%if(rs.getString(3).equals("11"))
		{%>
		<td class="btext" >5. No Of Schools</td>
		<%}else if(rs.getString(3).equals("12")){ %>
		<td class="btext" >5. No Of Labs</td>
		<%}else{%>
			<td class="btext" >5. Habitations<br>&nbsp;&nbsp;&nbsp;&nbsp;Benefited</td>
			<%}%>
		<td class=rptValue ><b><%=rs1.getString(5)%></b></td>
		</tr>
		
<% String wccq="";
	if(rs.getString(3).equals("11"))
		{
		    wccq="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),NVL(COVERAGE_STATUS,'-'),school_name  from RWS_PANCHAYAT_RAJ_TBL PR,RWS_WORK_school_LNK_TBL ln,rws_habitation_directory_tbl h,rws_school_master_tbl s where  ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and s.school_code=ln.school_code and s.hab_code=h.hab_code order by pr.panch_code"; 
		}
		else  if(rs.getString(3).equals("12"))
		{
          wccq="select distinct division_office_name,l.lab_code,lab_name   from rws_water_quality_lab_tbl l ,RWS_WORK_lab_LNK_TBL ln ,rws_division_office_tbl d where l.lab_code=ln.lab_code and   ln.work_id='"+wCode+"' and substr(l.office_code,4,1)=d.division_office_code  and substr(ln.work_id,5,2)=d.circle_office_code  order by l.lab_code"; 
		}
		else
		{
		  wccq="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),NVL(COVERAGE_STATUS,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_WORK_COMP_HAB_LNK_TBL ln,rws_habitation_directory_tbl h where  ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' order by pr.panch_code"; 
		}
//System.out.println("habitation details query:::"+wccq);
           rs2 = st2.executeQuery(wccq);
           rs2.setFetchSize(500);
           rs2.last();
           Cnt = rs2.getRow();
           rs2.beforeFirst();
           %>
       	  	
       <tr  bgcolor="#ffffff">  
		<%if(rs.getString(3).equals("12"))
		{%>
		  <td class="btext" align="left">6.Division</td>
		  <td class="btext" align="center">Lab Code</td>
		  <td class="btext" align="center">Lab Name </td>
		  </tr>
		  <%}else if(rs.getString(3).equals("11")){ %>
		<td class="btext" >6. School Name</td>
		 <td class="btext">Hab Name</td>
		 <td class="btext">Plain Pop</td>
		  <td class="btext">SC Pop</td>
		  <td class="btext">ST Pop</td>
		  <td class="btext">Total</td>
		   <td class="btext">Coverage Status</td>
		   </tr>
		   <%}else{%>
		<td class="btext" >6. Habitations</td>
		 <td class="btext">Plain Pop</td>
		  <td class="btext">SC Pop</td>
		  <td class="btext">ST Pop</td>
		  <td class="btext">Total</td>
		   <td class="btext">Coverage Status</td>
		   </tr>
		   <%}%>
           <%
		if(Cnt!=0)
		{
		 int wccserial=0;
		while(rs2.next())
		{ 
		wccserial++;
		//System.out.println("work rs2.getString(2)"+rs2.getString(2));
	if(rs.getString(3).equals("12"))
		{%>			
		<tr  bgcolor="#ffffff">  
		<td class=rptValue align="left"><%=wccserial%>.&nbsp;<%=rs2.getString(1)%></td>
		<td class=rptValue align="center"><%=rs2.getString(2)%></td>
		<td class=rptValue align="center"><%=rs2.getString(3)%></td>
		</tr>
		<%}else if(rs.getString(3).equals("11")){%>
		<tr  bgcolor="#ffffff">  
		<td class=rptValue><%=wccserial%>.&nbsp;<%=rs2.getString(8)%></td>
		<td class=rptValue><%=rs2.getString(2)%></td>
		<td class=rptValue align="right"><%=rs2.getString(3)%></td>
		<td class=rptValue align="right"><%=rs2.getString(4)%></td>
		<td class=rptValue align="right"><%=rs2.getString(5)%></td>
		<td class=rptValue align="right"><%=rs2.getString(6)%></td>
		<td class=rptValue><%=rs2.getString(7)%></td>
		</tr>
		<%}else{%>
		<tr  bgcolor="#ffffff">  
		<td class=rptValue><%=wccserial%>.&nbsp;<%=rs2.getString(2)%></td>
		<td class=rptValue align="right"><%=rs2.getString(3)%></td>
		<td class=rptValue align="right"><%=rs2.getString(4)%></td>
		<td class=rptValue align="right"><%=rs2.getString(5)%></td>
		<td class=rptValue align="right"><%=rs2.getString(6)%></td>
		<td class=rptValue><%=rs2.getString(7)%></td>
		</tr>
		<%}%>
<% 
		}
		}
		else
		{%>
		<tr bgcolor="#ffffff"> 
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue >-</td>
		<td class=rptValue >-</td>
		</tr>
		<% }
			%>
		
		<%
		
         
	} 
			}
		
			
	}
	
	else
	{
	
	%>
		<tr  bgcolor="#ffffff">
		<td class="btext">1. Start Date</td>
		<td class=rptValue >-</td>
		</tr>
		
		<tr  bgcolor="#ffffff">
		<td class="btext" >2. Stipulated Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue >-</td>
		</tr>
		
		<tr  bgcolor="#ffffff" >
		<td class="btext">3. Actual Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue >-</td>
		</tr>
		
		<tr  bgcolor="#ffffff" >
		<td class="btext" >4. Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;Commissioning</td>
		<td class=rptValue >-</td>
		</tr>
		
	<tr  bgcolor="#ffffff">
		<td class="btext" >5. Habitations<br>&nbsp;&nbsp;&nbsp;&nbsp;Benefited</td>
		<td class=rptValue >-</b></td>
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
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue >-</td>
		<td class=rptValue >-</td>
	</tr>
	 <!-- <tr bgcolor="#ffffff">
	 <td colspan=5></td>
	 <tr>
		<td class=rptValue colspan=18 align=center><b><font color="blue">No Work Completion Records</font></b></td>
		</tr>-->
		<% }
	%>
	
</table>
<br><br>
</form>

