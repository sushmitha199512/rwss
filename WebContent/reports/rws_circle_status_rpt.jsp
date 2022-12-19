<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="";

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 
  //System.out.println("district="+district);
  //System.out.println("mandal="+mandal);
  //System.out.println("panchayat="+panchayat);

// //System.out.println("dDDDDDDDDDDDDDDD"+session.getAttribute("dName") );
 // //System.out.println("mMMMMMMMMMMMMMMl="+session.getAttribute("mName"));
 // //System.out.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pName"));
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

////System.out.println("dDDDDDDDDDDDDDDD       "+dCode ); 
// //System.out.println("mMMMMMMMMMcode  ="+mCode);
// //System.out.println("pPPPPPPPPPPPPPPPP=   "+pCode);
 String fdate=request.getParameter("FDate");
String tdate=request.getParameter("TDate");



int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	

%>
<html>
<head>
<title> WaterSoft </title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}


</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_office_coverage_frm.jsp">Back |</a>
				<a href="../home.jsp">Home |</a>
				<!--<a href="./rws_cir_div_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;-->
				<a href="./rws_cir_div_status_rpt_print_excel.jsp" target="_new">Excel</a>
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Habitation Office Coverage Status  Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	

	<tr><% if(!dCode.equals("51") && (!dCode.equals("null"))) {%>
	<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("districtName") %><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Subdivision: <%=session.getAttribute("pName") %></font></td>
</tr>
<%} %>


</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// //System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr >
	
		
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>Circle Name</td>
		
		<td align="center" class="btext" colspan=9> Habitation Status</td> 
<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		<td class="btext">UI</td>
		</tr>
		

<%
int Count=0,i=0;
String s=request.getParameter("start");

int slno=0;

try{
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

/*String qu1 = "SELECT distinct c.circle_office_code , c.circle_office_name as \"Circle Name\" from rws_panchayat_raj_tbl tm, rws_habitation_directory_tbl am, rws_circle_office_tbl c where c.circle_office_code=am.circle_office_code and am.hab_code=tm.panch_code  order by c.circle_office_code , c.circle_office_name";*/

String qu1 = "SELECT distinct c.circle_office_code , c.circle_office_name as \"Circle Name\" from  rws_habitation_directory_tbl am, rws_circle_office_tbl c where c.circle_office_code=am.circle_office_code order by c.circle_office_code , c.circle_office_name";

 ////System.out.println("sadiq ali else  "+qu1);
	rs6=st6.executeQuery(qu1);	
	rs6.last();
	Count = rs6.getRow();

	
	rs6.beforeFirst();

	
	 String distcode[]=new String[Count];

		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";

		
	if(Count!=0){
	// if(request.getParameter("start") !=  null) {
	//start = Integer.parseInt(request.getParameter("start"));
	// //System.out.println("start values  is "+start);
		//}
		//else
		//{
		//start = 1;
			// //System.out.println("start values  is "+start);	
		//}
		end = start + limit;
		
		//for(int j = start; j <=Count ; j++)
		int j=0;
		//{	
          while(rs6.next())
		{
			  j++;
			//rs6.absolute(j);	
			String dtname=rs6.getString(2);
			//String mandcode=r6.getString(5);
			// //System.out.println("eeeeee555555555555555555");
			distcode[i]=rs6.getString(1);
			// //System.out.println("Dist name is "+distcode[i]);			
			
		//String distcde=rs6.getString(2);
		  //String temp=rs6.getString(2);


		//if(temp.equals(dtname))
			//{
				
				%>		<!--<tr align=left bgcolor="#ffffff">
						<td class="mystyle1"><%=j %> </td>
						<td class="mystyle1"></td>
						
					
					
				
					</tr>-->
<%				//}
			//else
			//{
				 ////System.out.println("sadiq ali else");
				 temp=rs6.getString(2);
					
				query="SELECT count(*) from rws_habitation_directory_tbl h  where  h.circle_office_code='"+distcode[i]+"' and coverage_status='FC'"+ a1 ;

				String q11="SELECT count(*) from rws_habitation_directory_tbl h  where  h.circle_office_code='"+distcode[i]+"' and coverage_status='PC1'"+ a1 ;

				String q22="SELECT count(*) from rws_habitation_directory_tbl h  where  h.circle_office_code='"+distcode[i]+"' and coverage_status='PC2'"+ a1 ;

				String q33="SELECT count(*) from rws_habitation_directory_tbl h  where  h.circle_office_code='"+distcode[i]+"' and coverage_status='PC3'"+ a1 ;

				String q44="SELECT count(*) from rws_habitation_directory_tbl h  where  h.circle_office_code='"+distcode[i]+"' and coverage_status='PC4'"+ a1 ;

				String q55="SELECT count(*) from rws_habitation_directory_tbl h  where 	 h.circle_office_code='"+distcode[i]+"' and coverage_status='NC'"+ a1 ;

				String q66="SELECT count(*) from rws_habitation_directory_tbl h  where  h.circle_office_code='"+distcode[i]+"' and coverage_status='NSS'"+ a1 ;
				
				String q77="SELECT count(*) from rws_habitation_directory_tbl h  where  h.circle_office_code='"+distcode[i]+"' and coverage_status='UI'"+ a1 ;

			
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
			<td class="mystyle1">
			<a href="rws_cir_div_status_rpt.jsp?dcode=<%=rs6.getString(1)%>&dname=<%=rs6.getString(2)%>"><%=rs6.getString(2)%></a></td>

			<td class="mystyle1"><%=rs.getInt(1) %></td>
		    <td class="mystyle1"><%=r1.getInt(1) %></td> 
		     <td class="mystyle1"><%=r2.getInt(1)%> </td> 
    	  <td class="mystyle1"> <%=r3.getInt(1)%> </td>  
		 <td class="mystyle1"><%=r4.getInt(1)%></td> 
		<td class="mystyle1"> <%=r5.getInt(1)%> </td>   
		<td class="mystyle1"> <%=r6.getInt(1)%> </td>
		<td class="mystyle1"> <%=r7.getInt(1)%> </td>   
	
 
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
		//}
		
		
			
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
		}		
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
		</table></form></body></html>
		
<%
conn.close();	
}else { // //System.out.println("There are no Recoreds");%>
<%="There are no Records"%>
<%}
}catch(Exception e){e.printStackTrace();}%>
<%@ include file = "footer.jsp" %>
