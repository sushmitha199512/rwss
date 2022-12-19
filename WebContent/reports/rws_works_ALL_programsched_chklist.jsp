<%  query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,RWS_WORK_COMMENCEMENT_TBL con where w.work_id=con.work_id  and w.work_id='"+wCode+"'";
	 /*query ="select distinct nvl(con.work_id,'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.work_id=ten.work_id and  substr(con.work_id,5,2)='"+dCode+"'";*/
     
	 //t.println(query);
	 try
	 {

	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	// ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//and w.work_id=ten.work_id,RWS_MILESTONE_TARGET_ACH_TBL ten
	
	rs = stmt.executeQuery(query);
	rs.setFetchSize(500);
	rs.last();
	Count = rs.getRow();
	rs.beforeFirst();%>

<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

	<tr align="center">
		<td align="left" class="rptHeading" colspan=8>V. Programme Schedule  Details</font></td>	
	</tr>
	
<%	
	int psno=0,phabs=1,phabs1=0,pha=1;
	if(Count!=0)
	{
	try
	{
	 while(rs.next())
	 {	
	 	//System.out.println("programsched");	

	String pqury1="select distinct sd.subdivision_office_name,NVL(com.officer_assigned_to,'-'),NVL(com.officer_assigned_to1,'-'),NVL(com.officer_assigned_to2,'-'),NVL(com.officer_assigned_to3,'-'),NVL(To_Char(com.grounding_date,'DD-MON-YYYY'),'-') from rws_work_commencement_tbl com,rws_subdivision_office_tbl sd where substr(com.office_code,2,2) =sd.circle_office_code and substr(com.office_code,4,1)=sd.division_office_code and substr(com.office_code,5,2) =sd.subdivision_office_code and com.work_id='"+wCode+"'";
	//out.println(qury1);
	String pqury2="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(mil.ACHIEVE_DATE,'DD-MON-YYYY'),'-'),nvl(mil.PERCENT_COMPLETED,'0') from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+wCode+"'";
	/*String qury2="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),mil.PERCENT_COMPLETED from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+rs.getString(1)+"'";*/

    rs1 = st1.executeQuery(pqury1);
    rs1.beforeFirst();
     
	rs2 = st2.executeQuery(pqury2);
    rs2.last();
    Cnt = rs2.getRow();
    rs2.beforeFirst();
	try
	{
	while(rs1.next())
	{
 %>
	  	<tr bgcolor="#ffffff" >
		<td class="btext" >1. SubDivision<br>&nbsp;&nbsp;&nbsp;&nbsp;Assigned to</td>
		<td class=rptValue ><%=rs1.getString(1)%></td>
		</tr>
		
		<tr bgcolor="#ffffff" >
		<td class="btext" >2. Engineer(s)<br>&nbsp;&nbsp;&nbsp;&nbsp;Assigned to</td>
		<td class=rptValue ><%=rs1.getString(2)%><br><%=rs1.getString(3)%><br><%=rs1.getString(4)%><br><%=rs1.getString(5)%></td>
		</tr>
		
		<tr bgcolor="#ffffff" >
		<td class="btext" >3. Work Start<br>&nbsp;&nbsp;&nbsp;&nbsp;Date</td>
		<td class=rptValue ><%=rs1.getString(6)%></td>
		</tr>
		
<%int number=1;
  int pserial=1;
%>
<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	
 	<tr bgcolor="#ffffff">
		<td class="btext">Slno</td>
		<td class="btext">Milestone</td>
		<td class="btext">Stage</td>
		<td class="btext">TargetDate</td>
		<td class="btext">Achievement<br>Date</td>
		<td class="btext">Percent<br>Completed</td>
	</tr>
<%
	if(Cnt!=0)
	{
	try{
		while(rs2.next())
		{
			if(number==1)
			{
		 	 number++;
		 	 //System.out.println("pserial value "+pserial);
		%>
		<tr bgcolor="#ffffff" >
			<td class=rptValue ><%=pserial%></td>
		    <td class=rptValue ><%=rs2.getString(1)%></td>
			<td class=rptValue ><%=rs2.getString(2)%></td>
			<td class=rptValue ><%=rs2.getString(3)%></td>
			<td class=rptValue ><%=rs2.getString(4)%></td>
			<td class=rptValue ><%=rs2.getString(5)%></td>
		</tr>
		
<%		}if(pserial>1)
			{
			for(int i=1;i<pserial;i++)
			{ 
				//System.out.println("Pserial in For() "+pserial); 
				//if(pserial<=3)
				//{
				//System.out.println("inside "+pserial); 
%>
	  <tr bgcolor="#ffffff">	   
			<td class=rptValue ><%=pserial%></td>
	    	<td class=rptValue ><%=rs2.getString(1)%></td>
			<td class=rptValue ><%=rs2.getString(2)%></td>
			<td class=rptValue ><%=rs2.getString(3)%></td>
			<td class=rptValue ><%=rs2.getString(4)%></td>
			<td class=rptValue ><%=rs2.getString(5)%></td>
		</tr>
<%//}
		}
		}
%>	
<%	pserial++;
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
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		</tr>
	<% }
	%>  		
  		</table> 
		
<%          
	}
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
	} 
	}
	catch(Exception e){
	System.out.println("Exception in Progrsched"+e.getMessage());
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
	{
%>
	<tr bgcolor="#ffffff" >
		<td class="btext">1. SubDivision<br>&nbsp;&nbsp;&nbsp;&nbsp;Assigned to</td>
		<td class=rptValue colspan="5">-</td>
		</tr>
		
		<tr bgcolor="#ffffff" >
		<td class="btext">2. Engineer(s)<br>&nbsp;&nbsp;&nbsp;&nbsp;Assigned to</td>
		<td class=rptValue colspan="5">-</td>
		</tr>
		
		<tr bgcolor="#ffffff">
		<td class="btext">3. Work Start<br>&nbsp;&nbsp;&nbsp;&nbsp;Date</td>
		<td class=rptValue colspan="5">-</td>
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext">Slno</td>
		<td class="btext">Milestone</td>
		<td class="btext">Stage</td>
		<td class="btext">TargetDate</td>
		<td class="btext">Achievement<br>Date</td>
		<td class="btext">Percent<br>Completed</td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		</tr>
	<!--  <tr bgcolor="#ffffff">
	 <td colspan=5></td>
	 <tr>
		<td class=rptValue colspan=10 align=center><b><font color="blue">No Program Schedule Records</font></b></td>
	</tr>--> 
	<%
	 }
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

<br><br>

