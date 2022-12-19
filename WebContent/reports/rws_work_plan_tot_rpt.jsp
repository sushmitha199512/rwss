<%	
String q11=null,q22=null,q33=null,q44=null,q55=null,q66=null,q77=null;
int j=0;
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;

int Count1=0,Count2=0;

dCode=request.getParameter("district");
 fdate=request.getParameter("FDate");

                 if(dCode.equals("51"))
				 {
					 q11 ="select count(work_id),c.plan_code,plan_name from rws_plan_nonplan_tbl c,rws_work_admn_tbl w where w.admin_date is not null and to_char (w.admin_date,'yyyy')='"+fdate+"' and w.work_id not in (select work_id from rws_work_completion_tbl) and w.plan_code=c.plan_code and work_cancel_dt is null group by c.plan_code,plan_name order by c.plan_code ";
						 
												 
                 }

				 else if(!dCode.equals("51") )
				 {
					 q11="select count(work_id),c.plan_code,plan_name from rws_plan_nonplan_tbl c,rws_work_admn_tbl w,rws_district_tbl d where d.dcode=substr(w.work_id,5,2) and substr(w.work_id,5,2)='"+dCode+"' and w.admin_date is not null and to_char (w.admin_date,'yyyy')='"+fdate+"' and w.work_id not in (select work_id from rws_work_completion_tbl) and w.plan_code=c.plan_code and work_cancel_dt is null group by c.plan_code,plan_name order by c.plan_code ";
						 
						/* "select count(work_id),c.plan_code,plan_name from rws_plan_nonplan_tbl c,rws_work_admn_tbl w,rws_district_tbl d  where d.dcode=substr(w.work_id,5,2) and substr(w.work_id,5,2)='"+dCode+"' and  w.plan_code=c.plan_code group by c.plan_code,plan_name order by c.plan_code";*/
					 
					
                  }
				stmt =conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs = stmt.executeQuery(q11);
				//System.out.println("plan on plan qry......"+q11);
				%>

				<tr>
				<td class="btext">S.No </td>
                <td class="btext">Plan Name</td>
				<td class="btext">No of Works</td> 
			   </tr>
			  
			   <%
			    rs.last();
				Count = rs.getRow();
				rs.beforeFirst();
				if(Count!=0)
				{
                j=0;
			
			
		
			   
			   while(rs.next())
			   {
				  

			   tot=tot+rs.getInt(1);
				%>
			  <tr>
			  <td class="mystyle1"><%=++j%> </td>
			  <td class="mystyle1"> <%=rs.getString(3)%></td>
			   <td class="mystyle1"><%=rs.getInt(1)%></a></td>
        </tr>
		<%
			   }
			   %>

				
				
			  
			
		 <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=tot%></td>
			</tr>
			<%
			   }
			   else {
	%>
	<tr class="btext"><td>There are no Records</td></tr>
	<%
			   }
	%>
	
          


				