<%
// //System.out.println("val    "+district);
String s=request.getParameter("start");
////System.out.println("val of start    "+dCode);
int slno=0;
try{
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String qu1 = "SELECT d.dcode, d.dname,m.mname,p.pname,pr.panch_name  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"' order by substr(h.hab_code,1,2),substr(h.hab_code,6,2)";
//	r6=st6.executeQuery("SELECT dcode,dname FROM RWS_DISTRICT_tbl order by dname");	
	r6=st6.executeQuery(qu1);	
	r6.last();
	Count = r6.getRow();
	// //System.out.println("coount of rows is    "+Count);
	
	r6.beforeFirst();
	// //System.out.println("eeeeee555555555555555555");
	}catch(Exception e){e.printStackTrace();}
	 String distcode[]=new String[Count];

		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";

		
	if(Count!=0){
	 if(request.getParameter("start") !=  null) {
	start = Integer.parseInt(request.getParameter("start"));
	// //System.out.println("start values  is "+start);
		}
		else
		{
			start = 1;
			// //System.out.println("start values  is "+start);	
		}
		end = start + limit;
		
		for(int j = start; j <= end ; j++)
		{	//rs6.next();
			r6.absolute(j);	
			String dtname=r6.getString(2);
			//String mandcode=r6.getString(5);
			// //System.out.println("eeeeee555555555555555555");
			distcode[i]=r6.getString(1);
			// //System.out.println("Dist name is "+distcode[i]);			
			
		String distcde=r6.getString(2);
		String mandcde=r6.getString(3);
		String panchcde=r6.getString(4);


		if(temp.equals(distcde))
		{
			if(temp1.equals(mandcde))
			{
				if(temp2.equals(panchcde))
				{
%>					<tr align=left bgcolor="#ffffff">
						<td class="mystyle1"><%=j%></td>
						<td class="mystyle1"></td>
						<td class="mystyle1"></td>
						<!-- <td class="mystyle1"></td> -->
				
					</tr>
<%				}
				else
				{
					temp=r6.getString(2);
					temp1=r6.getString(3);
					temp2=r6.getString(4);
%>
					<tr align=left bgcolor="#ffffff">
					<td class="mystyle1"><%= j%></td>
					<td class="mystyle1"></td>
				<!-- 	<td class="mystyle1"></td> -->
					<td class="mystyle1"><%= r6.getString(4)%></td>
					</tr>
<%				}
			}
			else
			{
					temp=r6.getString(2);
					temp1=r6.getString(3);
					temp2=r6.getString(4);
%>	
			<tr align=left bgcolor="#ffffff">
				<td class="mystyle1"><%= j%></td>
				<td class="mystyle1"></td>
				<td class="mystyle1"><%= r6.getString(3)%></td>
				<td class="mystyle1"><%= r6.getString(4)%></td>
				
			</tr>
	<%		}
	
		}
		else
		{
					temp=r6.getString(2);
					temp1=r6.getString(3);
					temp2=r6.getString(4);
%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%= j%></td>
			<!-- <td class="mystyle1"><%= r6.getString(2)%></td> -->
			<td class="mystyle1"><%= r6.getString(3)%></td>
			<td class="mystyle1"><%= r6.getString(4)%></td>
		
<% 
				// //System.out.println("sadiq ali else");
			
				query="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='" +distcode[i]+"' and coverage_status='FC'";

				String q11="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+distcode[i]+"' and coverage_status='PC1'";

				String q22="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+distcode[i]+"' and coverage_status='PC2'";

				String q33="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+distcode[i]+"' and coverage_status='PC3'";

				String q44="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+distcode[i]+"' and coverage_status='PC4'";

				String q55="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+distcode[i]+"' and coverage_status='NC'";



				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);

				st1 = conn.createStatement();
				r1 = st1.executeQuery(q11);


				st2 = conn.createStatement();
				r2 = st2.executeQuery(q22);

				st3 = conn.createStatement();
				r3= st3.executeQuery(q33);

				st4 = conn.createStatement();
				r4 = st4.executeQuery(q44);

				st5 = conn.createStatement();
				r5= st5.executeQuery(q55);


				rs.next();			
				r1.next();
				r2.next();
				r3.next();
				r4.next();
				r5.next();


	%>
		
			
			<td class="mystyle1"><%=rs.getInt(1) %></td>
		    <td class="mystyle1"><%=r1.getInt(1) %></td> 
		     <td class="mystyle1"> <%= r2.getInt(1) %> </td> 
    	  <td class="mystyle1"> <%= r3.getInt(1)%> </td>  
		 <td class="mystyle1"><%= r4.getInt(1)%></td> 
		<td class="mystyle1"> <%= r5.getInt(1)%> </td>   
 
		</tr>
		<%}
		}
}else { // //System.out.println("There are no Recoreds");%>
<%="There are no Recoreds"%>
<%}%>
