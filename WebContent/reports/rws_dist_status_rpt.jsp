<%
// //System.out.println("val    "+district);
String s=request.getParameter("start");
//// //System.out.println("val of start    "+dCode);
int slno=0;

try{
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
//String qu1 = "SELECT distinct d.dcode,d.dname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code order by d.dname";
String qu1 = "SELECT distinct d.dcode,d.dname  from rws_district_tbl d, rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(pr.hab_code,1,2) and pr.panch_code=h.hab_code and d.dcode = substr(pr.hab_code,1,2) order by d.dname";

//	r6=st6.executeQuery("SELECT dcode,dname FROM RWS_DISTRICT_tbl order by dname");	
	rs6=st6.executeQuery(qu1);	
	rs6.last();
	Count = rs6.getRow();
	// //System.out.println("coount of rows is    "+Count);
	
	rs6.beforeFirst();
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
		
		for(int j = start; j <=Count ; j++)
		{	//rs6.next();
			rs6.absolute(j);	
			String dtname=rs6.getString(2);
			//String mandcode=r6.getString(5);
			// //System.out.println("eeeeee555555555555555555");
			distcode[i]=rs6.getString(1);
			// //System.out.println("Dist name is "+distcode[i]);			
			
		String distcde=rs6.getString(2);
		


		if(temp.equals(dtname))
			{
				
				%>		<tr align=left bgcolor="#ffffff">
						<td class="mystyle1"><%=j %> </td>
						<td class="mystyle1"></td>
						
					
					
				
					</tr>
<%				}
			else
			{
				// //System.out.println("sadiq ali else");
				temp=rs6.getString(2);
					
				query="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='" +distcode[i]+"' and coverage_status='FC'"+ a1 ;

				String q11="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+distcode[i]+"' and coverage_status='PC1'"+ a1 ;

				String q22="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+distcode[i]+"' and coverage_status='PC2'"+ a1 ;

				String q33="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+distcode[i]+"' and coverage_status='PC3'"+ a1 ;

				String q44="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+distcode[i]+"' and coverage_status='PC4'"+ a1 ;

				String q55="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where 	p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+distcode[i]+"' and coverage_status='NC'"+ a1 ;

				String q66="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+distcode[i]+"' and coverage_status='NSS'"+ a1 ;
				
				String q77="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+distcode[i]+"' and coverage_status='UI'"+ a1 ;

			
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
				
				st6 = conn.createStatement();
				r6= st6.executeQuery(q66);

				st7 = conn.createStatement();
				r7= st7.executeQuery(q77);
				
				



				rs.next();	
				r1.next();	
				r2.next();	
				r3.next();	
				r4.next();	
				r5.next();	
				r6.next();
				r7.next();	
				
	

	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%=j %> </td>
			<td class="mystyle1"><%=rs6.getString(2) %> </td>

			<td class="mystyle1"><%=rs.getInt(1) %></td>
		    <td class="mystyle1"><%=r1.getInt(1) %></td> 
		     <td class="mystyle1"> <%= r2.getInt(1) %> </td> 
    	  <td class="mystyle1"> <%= r3.getInt(1)%> </td>  
		 <td class="mystyle1"><%= r4.getInt(1)%></td> 
		<td class="mystyle1"> <%= r5.getInt(1)%> </td>   
		<td class="mystyle1"> <%= r6.getInt(1)%> </td>
		<td class="mystyle1"> <%= r7.getInt(1)%> </td>   
	
 
		</tr>

		<%
			fcgtotal = fcgtotal + rs.getInt(1);	
			pc1gtotal = pc1gtotal + r1.getInt(1);	
			pc2gtotal = pc2gtotal + r2.getInt(1);	
			pc3gtotal = pc3gtotal + r3.getInt(1);	
			pc4gtotal = pc4gtotal + r4.getInt(1);	
			ncgtotal = ncgtotal + r5.getInt(1);	
			nssgtotal = nssgtotal + r6.getInt(1);
			uitotal = uitotal + r7.getInt(1);
		

		}
		
		}
			
				rs.close(); 
				r1.close();
				r2.close();
				r3.close();
				r4.close();
				r5.close();
				r6.close();
				r7.close();
				
				
				stmt.close();		
				st1.close();	
				st2.close();	
				st3.close();	
				st4.close();	
				st5.close();	
				st6.close();	
				st7.close();	
				
	%>
<tr>
		<td class="btext" colspan=2>TOTAL</td>
		
		<td class="btext"><%=fcgtotal%></td>
		<td class="btext"><%=pc1gtotal%></td>
		<td class="btext"><%=pc2gtotal%></td>
		<td class="btext"><%=pc3gtotal%></td>
		<td class="btext"><%=pc4gtotal%></td>
		<td class="btext"><%=ncgtotal%></td>
		<td class="btext"><%=nssgtotal%></td>
		<td class="btext"><%=uitotal%></td>
		

		</tr>
		
<%}else { // //System.out.println("There are no Recoreds");%>
<%="There are no Records"%>
<%}%>
