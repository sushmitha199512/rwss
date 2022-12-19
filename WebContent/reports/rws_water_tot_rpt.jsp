<%	
String q11=null,q22=null,q33=null,q44=null,q55=null,q66=null,q77=null;
int j=0;
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
String testcode="";

int Count1=0,Count2=0;
String dname="";
  dname=(String)session.getAttribute("dName");
 

dCode=request.getParameter("district");
fdate=request.getParameter("FDate");

                 if(dCode.equals("51"))
				 {
					 q11 ="select count(*),c.test_code,c.test_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_habitation_directory_tbl hd where w.test_code=c.test_code and w.SAMP_COLLECT_DATE is not null and to_char (w.SAMP_COLLECT_DATE,'yyyy')='"+fdate+"' and c.test_code<>'3' and hd.hab_code=w.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by c.test_code,c.test_name order by 3";
						/* "select count(*),c.test_code,c.test_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_habitation_directory_tbl hd where w.test_code=c.test_code and hd.hab_code=w.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by c.test_code,c.test_name order by 3"; 
					*/
						 
												 
                 }

				 else if(!dCode.equals("51") )
				 {
					 q11="select count(*),c.test_code,c.test_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_habitation_directory_tbl hd,rws_district_tbl d where  c.test_code<>'3' and d.dcode=substr(w.hab_code,1,2) and substr(w.hab_code,1,2)= '"+dCode+"' and w.test_code=c.test_code and w.SAMP_COLLECT_DATE is not null and to_char (w.SAMP_COLLECT_DATE,'yyyy')='"+fdate+"' and hd.hab_code=w.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by c.test_code,c.test_name order by 3";
					   
						 /*"select count(*),c.test_code,c.test_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_habitation_directory_tbl hd,rws_district_tbl d where substr(w.hab_code,1,2)=d.dcode and substr(w.hab_code,1,2)='"+dCode+"' and w.test_code=c.test_code and hd.hab_code=w.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by c.test_code,c.test_name order by 3";*/ 
					
					
						 
					
                  }
				stmt =conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                Debug.println("q11***water***"+q11);
				rs = stmt.executeQuery(q11);
				

			    rs.last();
				Count = rs.getRow();
				rs.beforeFirst();
				
		if(Count!=0)
				{
                j=0;
			
			%>
			<tr>
				<td class="btext">S.No </td>
                <td class="btext">Test Name</td>
				<td class="btext">No of Samples</td> 
			   </tr>
			   <%
			   while(rs.next())
			   {
				  

			   tot=tot+rs.getInt(1);
				%>
			  <tr>
			  <td class="mystyle1"><%=++j%> </td>
			  <td class="mystyle1"><%=rs.getString(3)%></td>
			   <td class="mystyle1"><a href="rws_watergraph_drill_rpt.jsp?&dName=<%=dname%>&testcode=<%=rs.getString(2)%>&year=<%=fdate%>&dcode=<%=dCode%>"><%=rs.getInt(1)%></a></td>
			   
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
				
				
			  
			
	      


				