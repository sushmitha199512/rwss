<%@page import="java.sql.*" %>

<%		
 if(request.getParameter("start") !=  null) {
	start = Integer.parseInt(request.getParameter("start"));
	// //System.out.println("start values  is "+start);
		}
		else
		{
			start = 1;
			// //System.out.println("start values  is "+start);	
		}

 String dcode=String.valueOf(session.getAttribute("dCode"));
 ////System.out.println("val dcode             "+dcode);
 

	String qq2="SELECT distinct  m.mcode, m.mname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"' order by m.mname"; 

	st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
	rs6=st6.executeQuery(qq2);	
	rs6.last();
	Count = rs6.getRow();
	////System.out.println("coount of rows is  CCCCCCCCCCCCCCC  "+Count);
	rs6.beforeFirst();


	 String mandcode[]=new String[Count];
	 String temp="";
	if(Count!=0){
		end = start + limit;
		try{	
			//for(int j = start; j<=Count ; j++)
			int j=0;
				while(rs6.next())
					{	
					j++;
				String dtname=rs6.getString(2);
			// mandname=r6.getString(3);

			////System.out.println("eeeeee555555555555555555");
			
				mandcode[i]=rs6.getString(1);
			// //System.out.println("mandal  name is "+mandcode[i]);		
			// //System.out.println("sadiq ali else");
				temp=rs6.getString(2);
				//temp1=rs6.getString(5);
				//temp2=rs.getString(3);

				query="SELECT count(*) from rws_habitation_directory_tbl  h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"' and substr(h.hab_code,6,2)='"+mandcode[i]+"' and  coverage_status='FC'"+ a1 ;

				String q1="SELECT count(*) from rws_habitation_directory_tbl  h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"' and substr(h.hab_code,6,2)='"+mandcode[i]+"' and coverage_status='PC1'"+ a1 ;

				String q2="SELECT count(*) from rws_habitation_directory_tbl  h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"'  and substr(h.hab_code,6,2)='"+mandcode[i]+"' and coverage_status='PC2'"+ a1 ;

				String q3="SELECT count(*) from rws_habitation_directory_tbl  h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"' and substr(h.hab_code,6,2)='"+mandcode[i]+"' and coverage_status='PC3'"+ a1 ;

				String q4="SELECT count(*) from rws_habitation_directory_tbl  h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"' and substr(h.hab_code,6,2)='"+mandcode[i]+"' and coverage_status='PC4'"+ a1 ;

				String q5="SELECT count(*) from rws_habitation_directory_tbl  h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"'  and substr(h.hab_code,6,2)='"+mandcode[i]+"' and coverage_status='NC'"+ a1 ;

				String q6="SELECT count(*) from rws_habitation_directory_tbl  h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"'  and substr(h.hab_code,6,2)='"+mandcode[i]+"' and coverage_status='NSS'"+ a1 ;

				String q77="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"' and substr(h.hab_code,6,2)='"+mandcode[i]+"' and coverage_status='UI'"+ a1 ;

				
			
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

				st8 = conn.createStatement();
				rs8= st8.executeQuery(q77);

				
	
			
				rs.next();
				rs1.next();
				rs2.next();
				rs3.next();
				rs4.next();
				rs5.next();
				rs7.next();
				rs8.next();
				
			
		
		%>	

		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%=j %> </td>			
			<td class="mystyle1"><%=rs6.getString(2) %> </td>
		    <td class="mystyle1"> <%= rs.getString(1)%> </td> 
		   <td class="mystyle1"> <%= rs1.getString(1)%> </td> 
			<td class="mystyle1"><%= rs2.getString(1)%></td> 
    		<td class="mystyle1"> <%= rs3.getString(1)%> </td> 
		 <td class="mystyle1"><%= rs4.getString(1)%></td> 
		<td class="mystyle1"> <%= rs5.getString(1)%> </td> 
		<td class="mystyle1"> <%= rs7.getString(1)%> </td> 
		<td class="mystyle1"> <%= rs8.getString(1)%> </td> 
		
		</tr>
<%			fcgtotal = fcgtotal + rs.getInt(1);	
			pc1gtotal = pc1gtotal + rs1.getInt(1);	
			pc2gtotal = pc2gtotal + rs2.getInt(1);	
			pc3gtotal = pc3gtotal + rs3.getInt(1);	
			pc4gtotal = pc4gtotal + rs4.getInt(1);	
			ncgtotal = ncgtotal + rs5.getInt(1);	
			nssgtotal = nssgtotal + rs7.getInt(1);	
			uitotal = uitotal + rs8.getInt(1);	
				
			// //System.out.println("sadiq lai bye");
				rs.close();  stmt.close();
				rs1.close();
				rs2.close();
				rs3.close();
				rs4.close();
				rs5.close();	
				rs7.close();	
				rs8.close(); 
						
				st1.close();	
				st2.close();	
				st3.close();	
				st4.close();
				st5.close();
				st7.close();
				st8.close();
					
					
		}%>
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
	<%}catch(Exception e){  //System.out.println("error is"+e);
	}


			
}else { // //System.out.println("There are no Recoreds");
%>
<%="There are no Recoreds sadiq"%>
<%}%>
