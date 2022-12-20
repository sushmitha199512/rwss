
<%
// //System.out.println("val    "+district);
String s=request.getParameter("start");
// //System.out.println("val of start    "+s);
int slno=0;
try{
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String qu1 = "SELECT p.pcode, d.dname,m.mname,p.pname,pr.panch_name,nvl(coverage_status,'--')  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and  substr(h.hab_code,13,2)='"+panchayat+"' order by pr.panch_name";
//	r6=st6.executeQuery("SELECT dcode,dname FROM RWS_DISTRICT_tbl order by dname");	
	r6=st6.executeQuery(qu1);	
	r6.last();
	Count = r6.getRow();
	// //System.out.println("coount of rows is    "+qu1);
	
	r6.beforeFirst();
	// //System.out.println("eeeeee555555555555555555");
	}catch(Exception e){e.printStackTrace();}
	 
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
			
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%=j %> </td>
			<td class="mystyle1"><%=r6.getString(5) %> </td> 
			<td class="mystyle1"><%=r6.getString(6) %> </td>
		</tr>
		<%
		}
}else { // //System.out.println("There are no Recoreds");%>
<%="There are no Records"%>
<%}%>

