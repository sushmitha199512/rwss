<%	
String q11=null,q22=null,q33=null,q44=null,q55=null,q66=null,q77=null;
int j=0;
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null;


int Count1=0,Count2=0;

dCode=request.getParameter("district"); 
fdate=request.getParameter("FDate"); 
/*
//Format formatter;

//formatter = new SimpleDateFormat("dd/MM/yyyy");

//=fdate.replace("/","-");


//int day=Integer.parseInt(fdate.substring(0,2));
//int month=Integer.parseInt(fdate.substring(3,5));
//int year=Integer.parseInt(fdate.substring(6,10));
//java.util.Date date = new java.util.Date(year-1900,month-1,day);

//formatter = new SimpleDateFormat("dd/MMM/yyyy");*/


//

String s="";

 int fctot=0;
 int pc1tot=0; 
int pc2tot=0;
 int pc3tot=0;
 int pc4tot=0;
 int nctot=0;
 int nsstot=0;
int tothab=0;
if(dCode.equals("51"))
{



                 	 q11 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='FC' "; 
				
				     
				
						 
												 
                 
					//
					 q22 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='PC1'  "; 
					
				//System.out.println("Query********"+q22);
				st8 =conn.createStatement();
				rs1 = st8.executeQuery(q22);
				
				 q55 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='PC2' "; 
				//System.out.println("Query********"+q55);	
				stmt3 =conn.createStatement();
				rs3 = stmt3.executeQuery(q55);
				
				
								 q66 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='PC3' "; 
					//System.out.println("Query********"+q66);
				stmt5 =conn.createStatement();
				rs5 = stmt5.executeQuery(q66);
				
				
				
				 q77 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='PC4' "; 
				//System.out.println("Query********"+q77);	
				stmt4 =conn.createStatement();
				rs4 = stmt4.executeQuery(q77);
				
				
				q44 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='NC' "; 
				//System.out.println("Query********"+q44);	
				stmt2 =conn.createStatement();
				rs2 = stmt2.executeQuery(q44);
                //System.out.println("Query********"+q11);
          
				stmt =conn.createStatement();
				rs = stmt.executeQuery(q11);
              //
                q99 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='NSS' "; 
				//System.out.println("Query********"+q99);	
				st99 =conn.createStatement();
				rs99 = st99.executeQuery(q99);
                //System.out.println("Query********"+q99);
             }
else
{
    q11 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='FC' and substr(panch_code,1,2)='"+dCode+"' "; 
				
				     
				
						 
												 
                 
					
				 q22 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='PC1'  and substr(panch_code,1,2)='"+dCode+"' "; 
					
				//System.out.println("Query********"+q22);
				st8 =conn.createStatement();
				rs1 = st8.executeQuery(q22);
				
				 q55 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='PC2' and substr(panch_code,1,2)='"+dCode+"' "; 
				//System.out.println("Query********"+q55);	
				stmt3 =conn.createStatement();
				rs3 = stmt3.executeQuery(q55);
				
				
								 q66 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='PC3'  and substr(panch_code,1,2)='"+dCode+"' "; 
					//System.out.println("Query********"+q66);
				stmt5 =conn.createStatement();
				rs5 = stmt5.executeQuery(q66);
				
				
				
				 q77 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='PC4' and substr(panch_code,1,2)='"+dCode+"' "; 
				//System.out.println("Query********"+q77);	
				stmt4 =conn.createStatement();
				rs4 = stmt4.executeQuery(q77);
				
				
				q44 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='NC' and substr(panch_code,1,2)='"+dCode+"' "; 
				//System.out.println("Query********"+q44);	
				stmt2 =conn.createStatement();
				rs2 = stmt2.executeQuery(q44);
                //System.out.println("Query********"+q11);
          
				stmt =conn.createStatement();
				rs = stmt.executeQuery(q11);
              //
                q99 ="select count(*) from rws_habitation_directory_tbl c,rws_complete_hab_view hd  where   hd.panch_code=c.hab_code  and   to_char(status_date,'dd-MON-yyyy')='"+fdate+"' and c.coverage_status='NSS' and substr(panch_code,1,2)='"+dCode+"' "; 
				//System.out.println("Query********"+q99);	
				st99 =conn.createStatement();
				rs99 = st99.executeQuery(q99);
                //System.out.println("Query********"+q99);

}
				
				
                rs.next();
				rs1.next();
				rs3.next();
				rs5.next();
				rs4.next();
				rs2.next();
                rs99.next();
				fctot=fctot+rs.getInt(1);
				pc1tot=pc1tot+rs1.getInt(1);
				pc2tot=pc2tot+rs3.getInt(1);
				pc3tot=pc3tot+rs5.getInt(1);
				pc4tot=pc4tot+rs4.getInt(1);
				nctot=nctot+rs2.getInt(1);
                nsstot=nsstot+rs99.getInt(1);
				tothab=tothab+fctot+pc1tot+pc2tot+pc3tot+pc4tot+nctot+nsstot;
				stmt.close();rs.close();
				stmt2.close();rs2.close();
				stmt4.close();rs4.close();
				stmt5.close();rs5.close();
				stmt3.close();rs3.close();
				st8.close();rs1.close();
                st99.close();rs99.close();
             
				
				
              
             %>
				<tr>
				<td class="btext" align=center>Sl.No</td>
				<td class="btext" align=center>Coverage Status </td> 
				<td class="btext" align=center> No.of Habitations</td> 
			</tr>
		<% if(fctot!=0) {
				%>
		<tr>
			<td class="mystyle1" align=center><%=++j %> </td>
			<td class="mystyle1" align=left>FC</td>
			<td class="mystyle1" align=center><a href="rws_coveragefc_status_rpt.jsp?&dcode=<%=dCode%>&status=<%=1%>&fd=<%=fdate%>"><%=fctot%></a> </td>
		</tr>
		<% }
			if(pc1tot!=0) {
				%>

		<tr>
			<td class="mystyle1" align=center><%=++j %> </td>
			<td class="mystyle1" align=left>PC1</td>
			<td class="mystyle1" align=center><a href="rws_coveragefc_status_rpt.jsp?&dcode=<%=dCode%>&status=<%=2%>&fd=<%=fdate%>"><%=pc1tot%></a> </td>
		</tr>
		<% } 
			if(pc2tot!=0) {
				%>

		<tr>
			<td class="mystyle1" align=center><%=++j %> </td>
			<td class="mystyle1" align=left>PC2</td>
			<td class="mystyle1" align=center><a href="rws_coveragefc_status_rpt.jsp?&dcode=<%=dCode%>&status=<%=3%>&fd=<%=fdate%>"><%=pc2tot %></a></td>
		</tr>
		<%}
			if(pc3tot!=0) {
				%>

		<tr>
			<td class="mystyle1" align=center><%=++j %> </td>
			<td class="mystyle1" align=left>PC3</td>
			<td class="mystyle1" align=center><a href="rws_coveragefc_status_rpt.jsp?&dcode=<%=dCode%>&status=<%=4%>&fd=<%=fdate%>"><%=pc3tot%></a> </td>
		</tr>
		<%}
		   if(pc4tot!=0) {
				%>

		<tr>
			<td class="mystyle1" align=center><%=++j %> </td>
			<td class="mystyle1" align=left>PC4</a></td>
			<td class="mystyle1" align=center><a href="rws_coveragefc_status_rpt.jsp?&dcode=<%=dCode%>&status=<%=5%>&fd=<%=fdate%>"><%=pc4tot%></a></td>
		</tr>
		<%}
			if(nctot!=0) {
				%>

		<tr>
			<td class="mystyle1" align=center><%=++j %> </td>
			<td class="mystyle1" align=left>NC</td>
			<td class="mystyle1" align=center><a href="rws_coveragefc_status_rpt.jsp?&dcode=<%=dCode%>&status=<%=6%>&fd=<%=fdate%>"><%=nctot%></a> </td>
		</tr>
		<%}
			if(nsstot!=0) {
				%>

		<tr>
			<td class="mystyle1" align=center><%=++j %> </td>
			<td class="mystyle1" align=left>NSS</td>
			<td class="mystyle1" align=center><a href="rws_coveragefc_status_rpt.jsp?&dcode=<%=dCode%>&status=<%=7%>&fd=<%=fdate%>"><%=nsstot%></a> </td>
		</tr>
		<%}	

		                  
				

			    
						   
			
		
		
		dist[0]="FC";
		dist[1]="PC1";
		dist[2]="PC2";
		dist[3]="PC3";
		dist[4]="PC4";
		dist[5]="NC";
		dist[6]="NSS";
		data[0]=fctot;
		
		data[1]=pc1tot;
		data[2]=pc2tot;
		data[3]=pc3tot;
		data[4]=pc4tot;
		data[5]=nctot;
		data[6]=nsstot;
			
		%>

		<tr>
		<td colspan=2 class="btext" align=center>Total:</td>
			   <td class="btext" align=center><font color=red><%=tothab%></font></td>
			
		</tr>
   

				
			  
			
	      


				