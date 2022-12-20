
<%
// //System.out.println("val    "+district);
String s=request.getParameter("start");
// //System.out.println("val of start    "+s);
int slno=0;
try{
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String qu1 = "SELECT p.pcode, d.dname,m.mname,p.pname,pr.panch_name,coverage_status  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and  substr(h.hab_code,13,2)='"+panchayat+"' order by pr.panch_name";
//	r6=st6.executeQuery("SELECT dcode,dname FROM RWS_DISTRICT_tbl order by dname");	
	r6=st6.executeQuery(qu1);	
	r6.last();
	Count = r6.getRow();
	// //System.out.println("coount of rows is    "+Count);
	
	r6.beforeFirst();
	// //System.out.println("eeeeee555555555555555555");
	}catch(Exception e){
		//e.printStackTrace();
		}
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
			
		}
		end = start + limit;
		
		for(int j = start; j <= Count ; j++)
		{	//rs6.next();
			r6.absolute(j);	
			String dtname=r6.getString(4);
			String mandcode=r6.getString(5);
			// //System.out.println("eeeeee555555555555555555");
			distcode[i]=r6.getString(1);
						
query="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+district+"' and substr(hab_code,6,2)='"+mandal+"' and substr(hab_code,13,2)='"+panchayat+"' and  coverage_status='FC'";

String q1="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+district+"' and substr(hab_code,6,2)='"+mandal+"' and substr(hab_code,13,2)='"+panchayat+"' and coverage_status='PC1'";

String q2="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+district+"'  and substr(hab_code,6,2)='"+mandal+"' and substr(hab_code,13,2)='"+panchayat+"' and coverage_status='PC2'";

String q3="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+district+"' and substr(hab_code,6,2)='"+mandal+"' and substr(hab_code,13,2)='"+panchayat+"' and coverage_status='PC3'";

String q4="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+district+"' and substr(hab_code,6,2)='"+mandal+"' and substr(hab_code,13,2)='"+panchayat+"' and coverage_status='PC4'";

String q5="SELECT count(*) from rws_habitation_directory_tbl where substr(hab_code,1,2)='"+district+"'  and substr(hab_code,6,2)='"+mandal+"' and substr(hab_code,13,2)='"+panchayat+"' and coverage_status='NC'";

				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);

				st1 = conn.createStatement();
				r1 = st1.executeQuery(q1);


				st2 = conn.createStatement();
				r2 = st2.executeQuery(q2);

				st3 = conn.createStatement();
				r3= st3.executeQuery(q3);

				st4 = conn.createStatement();
				r4 = st4.executeQuery(q4);

				st5 = conn.createStatement();
				r5= st5.executeQuery(q5);


				rs.next();			
				r1.next();
				r2.next();
				r3.next();
				r4.next();
				r5.next();


	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%=j %> </td>
			<td class="mystyle1"><%=r6.getString(5) %> </td> 
			<td class="mystyle1"><%=r6.getString(6) %> </td>
		</tr>
		<%
				rs.close();		stmt.close();	
				r1.close();		st1.close();
				r2.close();		st2.close();
				r3.close();		st3.close();
				r4.close();		st4.close();
				r5.close();		st5.close();
		}
}else { // //System.out.println("There are no Recoreds");%>
<%="There are no Recoreds"%>
<%}%>

