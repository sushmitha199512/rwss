
<%
     query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where w.work_id=con.work_id  and con.work_id=ten.work_id  and con.work_id='"+wCode+"'";
	 /*query ="select distinct nvl(con.work_id,'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.work_id=ten.work_id and  substr(con.work_id,5,2)='"+dCode+"'";*/
     
	 //t.println(query);
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);	
	 ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

		rs = stmt.executeQuery(query);
		rs.setFetchSize(500);
		rs.last();
		Count = rs.getRow();
		rs.beforeFirst();
		String a[]=new String[10];
%>


<form>
<table >
	
	<tr align="center">
		<td align="left" class="rptHeading" >VI.Contractor Details</font></td>	
	</tr>

	
	
<%	int csno=0,chabs=1,chabs1=0,cha=1;
	if(Count!=0)
	{
		while(rs.next())
		{
		// String cqury1="select distinct ten.TENDER_IDNO,ten.TENDER_AMOUNT,nvl(ten.CONTRACTOR_NAME,'-'),nvl(to_char(con.TENDER_APPROVED_ON,'dd-mm-yyyy'),'-'),nvl(TO_CHAR(con.LOA_ISSUED_ON,'DD-MON-YYYY'),'-'),nvl(con.AGREEMENT_REFERENCE_NO,'-'),nvl(TO_CHAR(con.AGREEMENT_DATE,'DD-MON-YYYY'),'-'),nvl(con.AGREEMENT_DURATION,'0'),nvl(con.AGREEMENT_VALUE,'0'),nvl(TO_CHAR(con.SITE_HAND_OVER_DATE,'DD-MON-YYYY'),'-'),nvl(TO_CHAR(con.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.TENDER_IDNO=ten.TENDER_IDNO and con.work_id='"+wCode+"'";
        String cqury1="select distinct ten.TENDER_IDNO,ten.TENDER_AMOUNT/100000,nvl(c.CONTRACTOR_NAME_company,'-'),nvl(to_char (con.TENDER_APPROVED_ON,'dd- mm-yyyy'),'-'),nvl(TO_CHAR(con.LOA_ISSUED_ON,'DD-MON-YYYY'),'-'),nvl (con.AGREEMENT_REFERENCE_NO,'-'),nvl(TO_CHAR (con.AGREEMENT_DATE,'DD-MON-YYYY'),'-'),nvl (con.AGREEMENT_DURATION,'0'),nvl (con.AGREEMENT_VALUE,'0'),nvl(TO_CHAR (con.SITE_HAND_OVER_DATE,'DD-MON-YYYY'),'-'),nvl (TO_CHAR (con.DATE_OF_COMPLETION,'DD-MON-YYYY'),'- '),con.work_id,ten.work_id from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten,rws_contractor_tbl c where con.TENDER_IDNO=ten.TENDER_IDNO and con.work_id=ten.work_id and con.CONTRACTOR_CODE =c.CONTRACTOR_CODE(+) and con.work_id='"+wCode+"'";
		//out.println(cqury1);
        rs1 = st1.executeQuery(cqury1);
       
	    rs1.beforeFirst();
		rs1.next();
		csno++;
 %>
	  
		<tr bgcolor="#ffffff" >
		<td class="btext" nowrap>1. Tender Notification Id</td>
		<td class=rptValue nowrap><font face="verdana" size="2" color="black"></b><%=rs1.getString(1)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >2. Tender Cost(In Lakhs)</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getFloat(2)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >3. Contractor Name</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(3)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext"  >4. Tender<br>&nbsp;&nbsp;&nbsp;&nbsp;Accepted Date</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(4)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		 <td class="btext">5. LOA<BR>&nbsp;&nbsp;&nbsp;&nbsp;issued on date</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(5)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >6. Agreement RefNo</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(6)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >7. Agreement Date</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(7)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >8. Agreement Duration<br>&nbsp;&nbsp;&nbsp;&nbsp;In Months</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(8)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >9. Agreement Value</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(9)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >10. Site Handing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Over Date</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(10)%></font></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >11. Stipulated Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue ><font face="verdana" size="2" color="black"></b><%=rs1.getString(11)%></font></td>
	    </tr>
		<% 
		String cq="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),mil.PERCENT_COMPLETED_WORK,nvl(mil.PERCENT_COMPLETED,0) from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code  and mil.work_id='"+wCode+"'"; 
		//	System.out.println("cq:"+cq);
           rs2 = st2.executeQuery(cq);
           rs2.setFetchSize(500);
           rs2.last();
           Cnt = rs2.getRow();
           rs2.beforeFirst();
		    rs2 = st2.executeQuery(cq);
		   int cserial=1;
		   int number=1;
		   %>
		   </table>
		   <h2 class="expand">Milestones</h2>
            <div class="collapse">
                <p>
  	<table border = 1 cellspacing = 0 cellpadding = 0 style="border-collapse:collapse" >	  	
	 <tr bgcolor="#ffffff">	   
		<td class="btext">Slno</td>
		<td class="btext" >Milestone</td>  
		<td class="btext">Stage</td>
		<td class="btext">TargetDate</td> 
		<td class="btext">Component to be <br>executed in the MileStone(s)<br>w.r.to total <br>Work Estimate Cost</td> 
		<td class=btext>Work- %<br> Achievement for<br> All Mile Stone(s) <br>till date	</td>
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
			<tr bgcolor="#ffffff">	   
		<td class=<%=style %> style="text-align: left;" ><%=cserial++%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString(1)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString(2)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString(3)%></td>
		<td class=<%=style %> style="text-align: right;"><%=rs2.getString(4)%></td>
		<td class=<%=style %> style="text-align: right;"><%=rs2.getString(5)%></td>
		</tr>
		
			<%//System.out.println("cserial Value "+cserial);
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
		</tr>
		
		<% }
		%>
		
		<%
         
	} 
		
	}
	else
	{%>
		<tr bgcolor="#ffffff" >
		<td class="btext" nowrap>1. Tender Notification Id</td>
		<td class=rptValue nowrap>-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >2. Tender Cost(In Lakhs)</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >3. Contractor Name</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext"  >4. Tender<br>&nbsp;&nbsp;&nbsp;&nbsp;Accepted Date</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		 <td class="btext">5. LOA<BR>&nbsp;&nbsp;&nbsp;&nbsp;issued on date</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >6. Agreement RefNo</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >7. Agreement Date</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >8. Agreement Duration<br>&nbsp;&nbsp;&nbsp;&nbsp;In Months</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >9. Agreement Value</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >10. Site Handing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Over Date</td>
		<td class=rptValue >-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >11. Stipulated Date Of<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Completion</td>
		<td class=rptValue >-</td>
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
		<% }%>
	
	<br>
	<br>
	</table>
	</div>
	
	
	</form>
