
<%				
                 String q11=null,q22=null,q33=null,q44=null,q55=null,q66=null;
				 String currentYear=null;
                 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
                 java.util.Date currentDate = new java.util.Date();
                 currentYear= dateFormat.format(currentDate).substring(0,4);
                if(fdate.substring(7,11).equals(currentYear))
			   {
                    //out.println("in 07");

             query="SELECT count(*) from rws_habitation_directory_tbl h,rws_complete_hab_view pr  where coverage_status='FC' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code"; 
	                    

				 q11="SELECT count(*) from rws_habitation_directory_tbl  h ,rws_complete_hab_view pr  where coverage_status='PC1' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code";

				 q22="SELECT count(*) from rws_habitation_directory_tbl  h ,rws_complete_hab_view pr  where coverage_status='PC2' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code";

				 q33="SELECT count(*) from rws_habitation_directory_tbl  h ,rws_complete_hab_view pr  where coverage_status='PC3' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code";

				q44="SELECT count(*) from rws_habitation_directory_tbl  h ,rws_complete_hab_view pr  where coverage_status='PC4' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code";

				q55="SELECT count(*) from rws_habitation_directory_tbl  h ,rws_complete_hab_view pr  where coverage_status='NC' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code";

				 q66="SELECT count(*) from rws_habitation_directory_tbl  h ,rws_complete_hab_view pr  where coverage_status='NSS' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code";
                
				/*q77="SELECT count(*) from rws_habitation_directory_tbl  h ,rws_complete_hab_view pr  where coverage_status='UI' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code";*/
			   }
			   else
			   {

                 //out.println("in 06");
				  query="SELECT count(*) from rws_habitation_directory_tbl h,rws_complete_hab_view pr  where coverage_status='FC' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code" ;
	

			q11="SELECT count(*) from rws_habitation_directory_tbl h,rws_complete_hab_view pr  where coverage_status='PC1' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code" ;
	

				q22="SELECT count(*) from rws_habitation_directory_tbl h,rws_complete_hab_view pr  where coverage_status='PC2' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code" ;

				 q33="SELECT count(*) from rws_habitation_directory_tbl h,rws_complete_hab_view pr  where coverage_status='PC3' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code" ;

				  q44="SELECT count(*) from rws_habitation_directory_tbl h,rws_complete_hab_view pr  where coverage_status='PC4' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code" ;

			 q55="SELECT count(*) from rws_habitation_directory_tbl h,rws_complete_hab_view pr  where coverage_status='NC' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code" ;

				 q66="SELECT count(*) from rws_habitation_directory_tbl h,rws_complete_hab_view pr  where coverage_status='NSS' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code" ;
                
				/*q77="SELECT count(*) from rws_habitation_dir_HIS_tbl h,rws_complete_hab_view pr  where coverage_status='UI' AND status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=h.hab_code" ;*/
			   }
				
                 stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
              //    System.out.println(query);
				st1 = conn.createStatement();
				r1 = st1.executeQuery(q11);
                //System.out.println(q11);
				st2 = conn.createStatement();
				r2 = st2.executeQuery(q22);
                 //System.out.println(q22);
				st3 = conn.createStatement();
				r3= st3.executeQuery(q33);
                // System.out.println(q33);
				st4 = conn.createStatement();
				r4 = st4.executeQuery(q44);
               // System.out.println(q44);
				st5 = conn.createStatement();
				r5= st5.executeQuery(q55);
				//System.out.println(q55);
				st8 = conn.createStatement();
				r8= st8.executeQuery(q66);
                //System.out.println(q66);
				/*st6 = conn.createStatement();
				rs2= st6.executeQuery(q77);*/



		// //System.out.println("sadiq ali else1  7");
				rs.next();	
				//System.out.println(rs.getInt(1));	
				r1.next();
				//System.out.println(r1.getInt(1));
				r2.next();
				//System.out.println(r2.getInt(1));
				r3.next();
				//System.out.println(r3.getInt(1));
				r4.next();
				//System.out.println(r4.getInt(1));
				r5.next();
				//System.out.println(r5.getInt(1));
				//r8.next();
				r8.next();
				// //System.out.println("sadiq ali else1  7");
				
				

		totfc=totfc+rs.getInt(1);
		totpc1=totpc1+r1.getInt(1);
		totpc2=totpc2+r2.getInt(1);
		totpc3=totpc3+r3.getInt(1);
		totpc4=totpc4+r4.getInt(1);
		totnc=totnc+r5.getInt(1);
		totnss=totnss+r8.getInt(1);
		//totui=totui+rs2.getInt(1);
		tot=tot+totfc+totpc1+totpc2+totpc3+totpc4+totnc+totnss;
	
	
				rs.close();			stmt.close();
				r1.close();			st1.close();
				r2.close();			st2.close();
				r3.close();			st3.close();
				r4.close();			st4.close();
				r5.close();			st5.close();
		     j=0;
			// //System.out.println("eeeeee555555555555555555");	
		tot = totfc + totpc1 + totpc2 + totpc3 + totpc4 + totnc + totnss;
			if(tot!=0)

		{
			%>
			<tr>
				<td class="btext" >S.No. </td>
				<td class="btext" >Coverage Status </td> 
				<td class="btext" > No. of Habitations</td> 
			</tr>
			<% if(totfc!=0) {
			
				%>
		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="FC"%>&date=<%=fdate%>&year=<%=currentYear%>">FC</a></td>
			<td class="mystyle1"><%=totfc %> </td>
		</tr>
		<% }
			if(totpc1!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="PC1"%>&date=<%=fdate%>&year=<%=currentYear%>">PC1</a></td>
			<td class="mystyle1"><%=totpc1 %> </td>
		</tr>
		<% } 
			if(totpc2!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="PC2"%>&date=<%=fdate%>&year=<%=currentYear%>">PC2</a></td>
			<td class="mystyle1"><%=totpc2 %> </td>
		</tr>
		<%}
			if(totpc3!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="PC3"%>&date=<%=fdate%>&year=<%=currentYear%>">PC3</a></td>
			<td class="mystyle1"><%=totpc3%> </td>
		</tr>
		<%}
		   if(totpc4!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="PC4"%>&date=<%=fdate%>&year=<%=currentYear%>">PC4</a></td>
			<td class="mystyle1"><%=totpc4 %> </td>
		</tr>
		<%}
			if(totnc!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="NC"%>&date=<%=fdate%>&year=<%=currentYear%>">NC</a></td>
			<td class="mystyle1"><%=totnc %> </td>
		</tr>
		<%}
			if(totnss!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="NSS"%>&date=<%=fdate%>&year=<%=currentYear%>">NSS</a></td>
			<td class="mystyle1"><%=totnss %> </td>
		</tr>
		<%}%>
			<tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=tot %></td>

<%}else {
	%>
	
	<tr><td align=center width="100%" class=btext nowrap>There are no Records</td></tr>
	
	<%}

	
%>
