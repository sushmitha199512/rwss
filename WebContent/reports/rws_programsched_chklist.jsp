<% query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,RWS_WORK_COMMENCEMENT_TBL con where w.work_id=con.work_id  and w.work_id='"+wCode+"'";
	 /*query ="select distinct nvl(con.work_id,'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.work_id=ten.work_id and  substr(con.work_id,5,2)='"+dCode+"'";*/
     
	 //t.println(query);

 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//and w.work_id=ten.work_id,RWS_MILESTONE_TARGET_ACH_TBL ten

 rs = stmt.executeQuery(query);
rs.setFetchSize(500);
 rs.last();
Count = rs.getRow();
rs.beforeFirst();%>


<%@page import="org.apache.commons.lang.StringUtils"%><form>
<table >

<tr  align="center">
		<td align="left" class="rptHeading" colspan=4>VII. Programme Schedule  Details</font></td>	
	</tr>
	
<%	
	int psno=0,phabs=1,phabs1=0,pha=1;
	if(Count!=0)
	{
	 while(rs.next())
	 {
		
	/*String qury1="select distinct sd.subdivision_office_name, com.officer_assigned_to,com.grounding_date,m.milestone_name, st.milestone_stage_name,mil.TARGET_DATE,mil.ACHIEVE_DATE,mil.PERCENT_COMPLETED from rws_work_commencement_tbl com,rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st,rws_subdivision_office_tbl sd  where substr(com.office_code,5,2)=sd.subdivision_office_code and m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and com.work_id='"+rs.getString(1)+"'";*/
	/*String qury1="select distinct sd.subdivision_office_name,NVL(com.officer_assigned_to,'-'),NVL(To_Char (com.grounding_date,'DD-MON-YYYY'),'-') from rws_work_commencement_tbl com,rws_subdivision_office_tbl sd where substr(com.office_code,2,2) =sd.circle_office_code and substr(com.office_code,4,1)=sd.division_office_code and substr(com.office_code,5,2) =sd.subdivision_office_code and com.work_id='"+rs.getString(1)+"'";*/

	String pqury1="select distinct sd.subdivision_office_name,NVL(com.officer_assigned_to,'-'),NVL(com.officer_assigned_to1,'-'),NVL(com.officer_assigned_to2,'-'),NVL(com.officer_assigned_to3,'-'),NVL(To_Char(com.grounding_date,'DD-MON-YYYY'),'-') from rws_work_commencement_tbl com,rws_subdivision_office_tbl sd  where substr(com.office_code,2,2) =sd.circle_office_code and substr(com.office_code,4,1)=sd.division_office_code and substr(com.office_code,5,2) =sd.subdivision_office_code and com.work_id='"+wCode+"'";

	//out.println(qury1);
	String pqury2="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),mil.PERCENT_COMPLETED_WORK,nvl(mil.PERCENT_COMPLETED,0) from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code  and mil.work_id='"+wCode+"'";

	/*String qury2="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),mil.PERCENT_COMPLETED from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+rs.getString(1)+"'";*/

        rs1 = st1.executeQuery(pqury1);
        rs1.beforeFirst();
         
		rs2 = st2.executeQuery(pqury2);
        rs2.last();
        Cnt = rs2.getRow();
        rs2.beforeFirst();
	//	System.out.println("pqury2:"+pqury2);
		    rs2 = st2.executeQuery(pqury2);
		while(rs1.next())
		{
			
			String eng1=rs1.getString(2);
			String eng2=rs1.getString(3);
			String eng3=rs1.getString(4);
			String eng4=rs1.getString(5);
			if(StringUtils.isNumeric(eng1) && !eng1.equals("-")){
				String qEmp="select EMPLOYEE_CODE ,EMPLOYEE_NAME,EMPLOYEE_SURNAME  from rws_employee_tbl where EMPLOYEE_CODE in ('"+eng1+"')";
				Statement sst1=conn.createStatement();
				 ResultSet rss_r = sst1.executeQuery(qEmp);
				 if(rss_r.next()){
					 eng1=rss_r.getString(3);
					 eng1+="  "+rss_r.getString(2);
					 eng1+=",";
				 }
			}
			if(StringUtils.isNumeric(eng2) && !eng2.equals("-")){
				String qEmp="select EMPLOYEE_CODE ,EMPLOYEE_NAME,EMPLOYEE_SURNAME  from rws_employee_tbl where EMPLOYEE_CODE in ('"+eng2+"')";
				Statement sst1=conn.createStatement();
				 ResultSet rss_r = sst1.executeQuery(qEmp);
				 if(rss_r.next()){
					 eng2=rss_r.getString(3);
					 eng2+="  "+rss_r.getString(2);
					 eng2+=",";
				 }
			}
			if(StringUtils.isNumeric(eng3) && !eng3.equals("-")){
				String qEmp="select EMPLOYEE_CODE ,EMPLOYEE_NAME,EMPLOYEE_SURNAME  from rws_employee_tbl where EMPLOYEE_CODE in ('"+eng3+"')";
				Statement sst1=conn.createStatement();
				 ResultSet rss_r = sst1.executeQuery(qEmp);
				 if(rss_r.next()){
					 eng3=rss_r.getString(3);
					 eng3+="  "+rss_r.getString(2);
					 eng3+=",";
				 }
			}
			if(StringUtils.isNumeric(eng4) && !eng4.equals("-")){
				String qEmp="select EMPLOYEE_CODE ,EMPLOYEE_NAME,EMPLOYEE_SURNAME  from rws_employee_tbl where EMPLOYEE_CODE in ('"+eng4+"')";
				Statement sst1=conn.createStatement();
				 ResultSet rss_r = sst1.executeQuery(qEmp);
				 if(rss_r.next()){
					 eng4=rss_r.getString(3);
					 eng4+="  "+rss_r.getString(2);
					 eng4+=",";
				 }
			}
			
			
 %>
	  	<tr  >
		<td class="btext" >1. SubDivision Assigned to:</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(1)%></font></b></td>
		</tr>
		
		<tr  >
		<td class="btext" >2. Engineer(s) Assigned to:</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=!eng1.equals("-")?eng1:""%>&nbsp;&nbsp;<%=!eng2.equals("-")?eng2:""%>&nbsp;&nbsp;<%=!eng3.equals("-")?eng3:"" %>&nbsp;&nbsp;<%=!eng4.equals("-")?eng4:""%></b></font></td>
		</tr>
		
		<tr>
		<td class="btext" >3. Work Start Date:</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(6)%></b></font></td>
		</tr>
		
<%int number=1;
  int pserial=1;
%>
  	
  	</table>
  	 <!--<h2 class="expand">Milestones Achievement</h2>
            <div class="collapse">
                <p>
                --><table border=0 style="border-collapse:collapse" bordercolor=white>
                
           <tr align="center">
		<td align="center" class="rptHeading">Milestones Achievement</font></td>	
	</tr>
                
 	<tr >
		<td class="btext">Slno</td>
		<td class="btext">&nbsp;&nbsp;Milestone</td>
		<td class="btext">Stage</td>
		<td class="btext">TargetDate</td>
		<td class="btext">Achievement<br>Date</td>
		<td class="btext">Percent<br>Completed</td>
	</tr>
<%
	if(Cnt!=0)
			{
               int styleCount=0;
               String style="";
		   	while(rs2.next())
			{	 
		   		if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			%>
			<tr >	   
		<td class=<%=style %> style="text-align: left;"><%=pserial++%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString(1)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString(2)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString(3)%></td>
		<td class=<%=style %> style="text-align: right;"><%=rs2.getString(4)%></td>
		<td class=<%=style %> style="text-align: right;"><%=rs2.getString(5)%></td>
		</tr>
			<%//System.out.println("cserial Value "+cserial);
			}}
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
  		
		
<%          
	}
	} 
	}
	else
	{
%>
	<tr bgcolor="#ffffff" >
		<td class="btext" >1. SubDivision<br>&nbsp;&nbsp;&nbsp;&nbsp;Assigned to</td>
		<td class=rptValue>-</td>
		</tr>
		
		<tr bgcolor="#ffffff" >
		<td class="btext" >2. Engineer(s)<br>&nbsp;&nbsp;&nbsp;&nbsp;Assigned to</td>
		<td class=rptValue >-</td>
		</tr>
		
		<tr bgcolor="#ffffff" >
		<td class="btext" >3. Work Start<br>&nbsp;&nbsp;&nbsp;&nbsp;Date</td>
		<td class=rptValue >-</td>
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
	%>


<br><br>
</table>
</p>
</div>

</form>

