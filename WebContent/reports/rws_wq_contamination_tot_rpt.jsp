<%	
String q11=null,q22=null,q33=null,q44=null;
dCode=String.valueOf(session.getAttribute("dCode"));

                
                 if(dCode.equals("51"))
				 {
                 query="select count(distinct panch_code) as habcount from rws_wq_test_results_tbl w,rws_complete_hab_view v where v.panch_code=substr (source_code,1,16)  and COVERAGE_STATUS='NSS' ";
				 q11="select  count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id   and  testing_parameter_code='13' and testing_parameter_value>'1.5' ";
                 q22="select  count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id  and testing_parameter_code='05' and testing_parameter_value> 2000 ";
				 q33="select count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id     and testing_parameter_code='12' and  (0.03+((1.806*testing_parameter_value)/1000) > 1.836)  ";
				

				 }
				else if(!dCode.equals("51"))
				 { 
                   query="select count(distinct panch_code) as habcount from rws_wq_test_results_tbl w,rws_complete_hab_view v where v.panch_code=substr (source_code,1,16)  and COVERAGE_STATUS='NSS' and dcode='"+dCode+"'";
				   q11="select  count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id   and  testing_parameter_code='13' and testing_parameter_value>'1.5' and dcode='"+dCode+"' ";
                   q22="select  count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id  and testing_parameter_code='05' and testing_parameter_value> 2000  and dcode='"+dCode+"' ";
				   q33="select count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id     and testing_parameter_code='12' and  (0.03+((1.806*testing_parameter_value)/1000) > 1.836) and dcode='"+dCode+"'  ";
				
					//System.out.println("second"+query);
//System.out.println("second"+q11);
//System.out.println("second"+q22);
//System.out.println("second"+q33);
				 }
				
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
				
                st1 = conn.createStatement();
				r1 = st1.executeQuery(q11);


				st2 = conn.createStatement();
				r2 = st2.executeQuery(q22);

				st3 = conn.createStatement();
				r3= st3.executeQuery(q33);

				 
				rs.next();			
				r1.next();
				r2.next();
				r3.next();
				
				
         
		totfc=totfc+rs.getInt(1);
		totpc1=totpc1+r1.getInt(1);
		totpc2=totpc2+r2.getInt(1);
		totpc3=totpc3+r3.getInt(1);
		
			// tot=tot+rs.getInt(2);
	    tot=tot+totfc+totpc1+totpc2+totpc3;
	    //System.out.println("tot:::::::::;"+tot);
	    
			if(tot!=0)

		{ j=0;
			//System.out.println("in total"+tot);
			%>
			<tr>
				<td class="btext">S.No. </td>
				<td class="btext">Contamination Parameter</td> 
				<td class="btext"> Hab Count</td> 
			</tr>
			
		<tr>
			<td class="mystyle1"><%=++j%> </td>
			<td class="mystyle1">NSS</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totfc %></td>
			<% }
		     else {%>
			  <td class="mystyle1"><%=totfc%></td>
            <% } %>
		</tr>
			<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">Flouride</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc1 %></td>
			<% }
		     else {%>
			  <td class="mystyle1"><%=totpc1%></td>
            <% } %>
		</tr>
		

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">TDS</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc2 %></td>
			<% }
			 else {%>
			  <td class="mystyle1"><%=totpc2%> </td>
            <% } %>
		</tr>
		

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">Salinity</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc3%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc3%> </td>
            <% } %>
		</tr>
		

		
		<%  }
else {
	%>
	
	<tr><td align=center width="100%" class=btext nowrap>There are no Records</td></tr>
	
	<%}%>
             <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=tot%></td>

