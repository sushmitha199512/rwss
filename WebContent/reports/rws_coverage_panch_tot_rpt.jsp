<%
String q1=null,q2=null,q3=null,q4=null,q5=null,q6=null,q7=null;
String currentYear=null;
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate = new java.util.Date();
currentYear= dateFormat.format(currentDate).substring(0,4);
 if(fdate.substring(7,11).equals(currentYear))
			   {
                   // out.println("in 07");

		query=" SELECT count(*) from rws_habitation_directory_tbl  h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='FC' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";
         
	 q1="SELECT count(*) from rws_habitation_directory_tbl  h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and   substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"'  and coverage_status='PC1' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI'";

	 q2="SELECT count(*) from rws_habitation_directory_tbl  h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and     substr(h.hab_code,1,2)='"+district+"'  and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='PC2' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";

		 q3="SELECT count(*) from rws_habitation_directory_tbl  h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='PC3' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";

	 q4="SELECT count(*) from rws_habitation_directory_tbl  h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='PC4' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";

	 q5="SELECT count(*) from rws_habitation_directory_tbl  h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"'  and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='NC' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";
 	
	 q6="SELECT count(*) from rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='NSS' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";
			   }
			   else
			   {

		query=" SELECT count(*) from RWS_HABITATION_DIRECTORY_TBL h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='FC' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";
         
	 q1="SELECT count(*) from RWS_HABITATION_DIRECTORY_TBL h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and    substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"'  and coverage_status='PC1' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI'";

	 q2="SELECT count(*) from RWS_HABITATION_DIRECTORY_TBL  h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and     substr(h.hab_code,1,2)='"+district+"'  and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='PC2' and coverage_status is not null and status_date ='" + fdate +"'  AND COVERAGE_STATUS <> 'UI'";

	 q3="SELECT count(*) from RWS_HABITATION_DIRECTORY_TBL h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='PC3' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";

	 q4="SELECT count(*) from RWS_HABITATION_DIRECTORY_TBL h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and 	 substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='PC4' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";

 q5="SELECT count(*) from RWS_HABITATION_DIRECTORY_TBL h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"'  and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='NC' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";
 	
	 q6="SELECT count(*) from RWS_HABITATION_DIRECTORY_TBL h,rws_panchayat_raj_tbl pr where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and coverage_status='NSS' and coverage_status is not null and status_date ='" + fdate +"' AND COVERAGE_STATUS <> 'UI' ";
			   }
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
		st1 = conn.createStatement();
		rs1 = st1.executeQuery(q1);
		
		st2 = conn.createStatement();
		rs2 = st2.executeQuery(q2);
		
		st3 = conn.createStatement();
		rs3= st3.executeQuery(q3);
	
		st4 = conn.createStatement();
		rs4 = st4.executeQuery(q4);
	
		st5 = conn.createStatement();
		rs5= st5.executeQuery(q5);
	
		st7 = conn.createStatement();
		rs7= st7.executeQuery(q6);

		rs.next();
		rs1.next();
		rs2.next();
		rs3.next();
		rs4.next();
		rs5.next();
		rs7.next();
		//out.println("coount of row1 is "+rs.getString(1));

		totfc=totfc+rs.getInt(1);
		totpc1=totpc1+rs1.getInt(1);
		totpc2=totpc2+rs2.getInt(1);
		totpc3=totpc3+rs3.getInt(1);
		totpc4=totpc4+rs4.getInt(1);
		totnc=totnc+rs5.getInt(1);
		totnss=totnss+rs7.getInt(1);
		tot=tot+totfc+totpc1+totpc2+totpc3+totpc4+totnc+totnss;
		//System.out.println("total is"+tot);
		%>	

				
		<%	// //System.out.println("panchayat  name is "+panchcode[i]);
				rs.close();
			rs1.close();
			rs2.close();
			rs3.close();
			rs4.close();
			rs5.close();
			rs7.close();
			stmt.close();	
			st1.close();	st2.close();st3.close();st4.close();st5.close();
		
			
		j=0;
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
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=
			<%=panchayat%>&cstatus=<%="FC"%>&date=<%=fdate%>&year=<%=currentYear%>">FC</a>
			</td>
			<td class="mystyle1"><%=totfc %></td>
		</tr>
		<% }
			if(totpc1!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="PC1"%>&date=<%=fdate%>&year=<%=currentYear%>">PC1</a></td>
			<td class="mystyle1"><%=totpc1 %></td>
		</tr>
		<% } 
			if(totpc2!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">
			<a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="PC2"%>&date=<%=fdate%>&year=<%=currentYear%>">PC2</a></td>
			<td class="mystyle1"><%=totpc2 %> </td>
		</tr>
		<%}
			if(totpc3!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">
			<a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="PC3"%>&date=<%=fdate%>&year=<%=currentYear%>">PC3</a></td>
			<td class="mystyle1"><%=totpc3%> </td>
		</tr>
		<%}
		   if(totpc4!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">
			<a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="PC4"%>&date=<%=fdate%>&year=<%=currentYear%>">PC4</a></td>
			<td class="mystyle1"><%=totpc4 %> </td>
		</tr>
		<%}
			if(totnc!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">
			<a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="NC"%>&date=<%=fdate%>&year=<%=currentYear%>">NC</a></td>
			<td class="mystyle1"><%=totnc %> </td>
		</tr>
		<%}
			if(totnss!=0) {
				%>

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">
			<a href="./rws_hab_details_list_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cstatus=<%="NSS"%>&date=<%=fdate%>&year=<%=currentYear%>">NSS</a></td>
			<td class="mystyle1"><%=totnss %> </td>
		</tr>
		<%}	
		tot = totfc + totpc1 + totpc2 + totpc3 + totpc4 + totnc + totnss;
			%>
			<tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=tot %></td>
		<%}
			else { %>
	
			<tr>
				<td align=center width="100%" class=btext nowrap>There are no Records</td>
			</tr>
	
		<%}
	%>