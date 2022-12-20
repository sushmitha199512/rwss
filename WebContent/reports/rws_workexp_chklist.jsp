
<%	
	/*query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-'),count(ln.hab_code),nvl(SANCTION_AMOUNT,'0'),nvl(w.ADMIN_NO,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),p.programme_name from RWS_WORK_ADMN_TBL w,RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_circle_office_tbl c where substr(w.office_code,2,2)=c.circle_office_code and w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and w.programme_code=p.programme_code  and  substr(w.office_code,2,2)='"+dCode+"' group by nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-'),nvl(SANCTION_AMOUNT,'0'),nvl(w.ADMIN_NO,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),p.programme_name";*/
	/*query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id(+)=prg.work_id and w.programme_code=prg.programme_code and substr(w.office_code,2,2)='"+dCode+"'" ;*/

     query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_expenditure_tbl e where w.work_id=e.work_id and w.work_id='"+wCode+"'";

	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

   	rs = stmt.executeQuery(query);
		rs.setFetchSize(500);
		rs.last();
		Count = rs.getRow();
		rs.beforeFirst();%>

<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

<tr align="center">
		<td align="left" class="rptHeading" colspan=10>VI. Work Expenditure Details</td>	
	</tr>

	    	
<%	
	if(Count!=0)
	{
	while(rs.next())
	{
	%>	
	    
		<!--<tr bgcolor="#ffffff"><td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%>/<br><%=rs.getString(1)%></td>-->
	   
		
		<%
         int esno=0,ehabs=1,ehabs1=0,eserial=0,eha=1;
		 String qury="select distinct e.programme_code,p.programme_name from rws_work_expenditure_tbl e,rws_programme_tbl p where e.programme_code=p.programme_code and e.work_id='"+wCode+"'";
		
		
       
		//out.println(qury1);
        r=s.executeQuery(qury);
		r.setFetchSize(500);
        r.last();
        Cnt = r.getRow();
        r.beforeFirst();

        if(Cnt!=0)
		{
		while(r.next())
			{
			float total=0;
			%>
			  <tr bgcolor="#ffffff">
				<td class="btext">1. ProgrammeName</td>
				 <td class="rptValue" ><%=++esno%>.&nbsp;<%=r.getString(2)%></td>
				 </tr>
           <%

			 String qury2="select distinct nvl(prev.expenditure_upto_the_pre_year,'0') from rws_work_expenditure_tbl e,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL prev where e.work_id='"+wCode+"' and e.programme_code='"+r.getString(1)+"'";
             
			 rs2 = st2.executeQuery(qury2);
			 if(rs2.next())
			{
			//System.out.println("work exp rs2.getFloat(1) "+rs2.getFloat(1));
			%>
			 <tr bgcolor="#ffffff">
				<td class="btext" >2. Expenditure During<br>&nbsp;&nbsp;&nbsp;&nbsp;The Prev Year<br>&nbsp;&nbsp;&nbsp;&nbsp;(Rs In Lakhs)</td>
				<td class="rptValue" ><%=rs2.getFloat(1)%></td>
			</tr>
			<%
			
		}
		else
			{
		%>
	         <td class="rptValue" >-</td>
		 <%}

			String equry1="select distinct nvl(e.Year,'-'),nvl(decode(e.Month,'01','January','02','February','03','March','04','April','05','May','06','June','07','July','08','August','09','September','10','October','11','November','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl(e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0')  from rws_work_expenditure_tbl e  where  e.work_id='"+wCode+"' and e.programme_code='"+r.getString(1)+"'";
			rs1 = st1.executeQuery(equry1);
			rs1.last();
            Counts = rs1.getRow();
			int Counts1=Counts;
			
            rs1.beforeFirst();
			int i=1;float total1=0;
			int sno=1;
%>

<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	

	 <tr bgcolor="#ffffff">
	 	<td class="btext">Slno</td>
		<td class="btext">Year</td>
	    <td class="btext">Month</td>
	    <td class="btext">Upto Previous<br>Month</td>
		<td class="btext">During The<br> Month</td>
		<td class="btext">Value of work<br>done but not paid</td>
	</tr>	
<%
	    while(rs1.next())
		{
			if(i==1)
			{
			total1=rs1.getFloat(3)+rs1.getFloat(4)+rs2.getFloat(1);
			//total1=total1+rs1.getFloat(4)+rs1.getFloat(3)+rs2.getFloat(1);
			}
			else
			{
				total1=rs1.getFloat(3)+rs1.getFloat(4)+rs2.getFloat(1);
				//total1=total1+rs1.getFloat(4)+rs1.getFloat(3);
			}

	%>
	 <tr bgcolor="#ffffff">
	  	<td class="rptValue"><%=sno++%></td> 
	    <td class="rptValue" ><%=rs1.getString(1)%></td>
		<td class="rptValue" ><%=rs1.getString(2)%></td>
		<td class="rptValue" ><%=rs1.getFloat(3)%></td>
		<td class="rptValue" ><%=rs1.getFloat(4)%></td>
		<td class="rptValue" ><%=rs1.getFloat(5)%></td>
	</tr>
	
		<% if(i==1 && Counts==1)
			{
			//System.out.println("i value in works 1"+i);
		%>
		<tr bgcolor="#ffffff">
			<td></td>
			<td></td>
			<td></td>
			<td class="btext" >Total Expenditure(Rs In Lakhs) </td>
			<td class="rptValue"><b><%=Math.round(total1*100)/100f%></b></td>
		</tr> 
		<%
			}
		    else if(i>=1 && Counts > 1 && i!=Counts )
			{ //System.out.println("i value in works2 "+i+" "+Counts);
			%>
		<!-- 	<tr bgcolor="#ffffff">
			<td class="rptValue"></td>
			</tr>
		--> 
		<%
			}
			else if(i>1  && Counts > 1 && i==Counts) 
			{
			//System.out.println("i value in works3 "+i);
			%>
		   <tr bgcolor="#ffffff">
			<td></td>
			<td></td>
			<td></td>
			<td class="btext">Total Expenditure<br>(Rs In Lakhs) </td>
			<td class="rptValue"><b><%=Math.round(total1*100)/100f%></b></td>
			</tr> 
			<%}%>
			
		</tr>
		
<% 
	i++;			
}
		}
		}
		
			else
		{%>
		<tr bgcolor="#ffffff">
		<td class=rptValue align="center">-</td>
	    <td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		</tr>
	
		<% }%>
</table>
	
</tr>	
	
<% }//end of main while

	}
else
	{%>
	
	<tr bgcolor="#ffffff">
		<td class="btext">1. ProgrammeName</td>
	   <td class="rptValue" >-</td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" >2. Expenditure During<br>&nbsp;&nbsp;&nbsp;&nbsp;The Prev Year<br>&nbsp;&nbsp;&nbsp;&nbsp;(Rs In Lakhs)</td>
		<td class="rptValue" >-</td>
	</tr>
	<tr bgcolor="#ffffff">
	 	<td class="btext">Slno</td>
		<td class="btext">Year</td>
	    <td class="btext">Month</td>
	    <td class="btext">Upto Previous<br>Month</td>
		<td class="btext">During The<br> Month</td>
		<td class="btext">Value of work<br>done but not paid</td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class=rptValue align="left">-</td>
	    <td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
	</tr>	
				 
<!-- 	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=10 align=center><b><font color="blue">No Work Expenditure Records</font></b></td>
		</tr>-->
		<% }

%>

</table>
<br><br>
