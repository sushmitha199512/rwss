<%@ include file = "header_rpt.jsp" %>
<%@ include file = "conn.jsp" %>
<%		
	Statement st1 = null,st2;
	ResultSet rs1 = null,rs2;
	ResultSetMetaData rsm=null;
	String st[]=new String[40];
		int j,Count,Cnt;
	
		
	String query = null;
	

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 
 // //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);
int a=0; 
String assetType=request.getParameter("assetType");
 // //System.out.println("Asset type="+assetType);
String ATName="";
if(assetType!=null){
if(assetType.equals("01")){ATName="PWS";}
else if(assetType.equals("02")){ATName="MPWS";} 
else if(assetType.equals("03")){ATName="CPWS";}
else if(assetType.equals("04")){ATName="HANDPUMPS";}
}
// //System.out.println("assetType="+assetType); 

String q1="";
/*String names[] = request.getParameterValues("ch");
if(names != null)
{
	String[] w1=new String[names.length];	
	// //System.out.println("MMMMM   "  +names.length);
	for (int i=0; i < names.length; i++)
	{
		// //System.out.println(names[i]);
		String sr1 = names[i].substring(0,names[i].lastIndexOf(","));
		// //System.out.println("YYYYYYYY   "+sr1);
		String sr2 = names[i].substring(names[i].lastIndexOf(",")+1, names[i].length());
		// //System.out.println("YYYYYYYY   "+sr2);
		w1[i]=sr1 + " AS \"" + sr2 +"\"";
		q1=q1+","+w1[i];
	}
}
String q3="Asset_name" + " AS \"Asset Name\", PANCH_NAME "+ " AS \"Habitation\""+q1;*/
String q3="Asset_name" + " AS \"Asset Name\", PANCH_NAME "+ " AS \"Habitation\"";
// //System.out.println("query is "  +q3);		
try
{
		
if(!district.equals("0") && mandal.equals("0"))
 {
query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name, a.type_of_asset_code, "+q3+", nvl(ac.asset_component_code,'--') "+" as \"Asset Component Name\", nvl(ac.asset_subcomponent_code,'--')"+" as \"Asset Sub Component Name\",ac.MEASURE_TYPE"+" as \"Measure Type\", ac.MEASURE_VALUE"+" as \"Measure Value\" from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_ASSET_SUBCOMP_PARAM_TBL ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.hab_code=p.panch_code and a.asset_code=ac.asset_code and ac.MEASURE_VALUE is not null and a.circle_office_code="+district;

   // //System.out.println("panchayat="+panchayat);
 }
 else if(!mandal.equals("0") && panchayat.equals("0"))
 {

query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name, a.type_of_asset_code, "+q3+", nvl(ac.asset_component_code,'--') "+" as \"Asset Component Name\", nvl(ac.asset_subcomponent_code,'--')"+" as \"Asset Sub Component Name\",nvl(ac.MEASURE_TYPE,'--')"+" as \"Measure Type\", nvl(ac.MEASURE_VALUE,'0')"+" as \"Measure Value\" from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_ASSET_SUBCOMP_PARAM_TBL ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.hab_code=p.panch_code and a.asset_code=ac.asset_code and ac.MEASURE_VALUE is not null and a.circle_office_code="+district+" and a.division_office_code="+mandal;

 }
 else
 {
query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name, a.type_of_asset_code, "+q3+", nvl(ac.asset_component_code,'--') "+" as \"Asset Component Name\", nvl(ac.asset_subcomponent_code,'--')"+" as \"Asset Sub Component Name\",nvl(ac.MEASURE_TYPE,'--')"+" as \"Measure Type\", nvl(ac.MEASURE_VALUE,'0')"+" as \"Measure Value\" from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_ASSET_SUBCOMP_PARAM_TBL ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.hab_code=p.panch_code and a.asset_code=ac.asset_code and ac.MEASURE_VALUE is not null and a.circle_office_code="+district+" and a.division_office_code="+mandal+" and a.subdivision_office_code="+panchayat;

/*query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+"  from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, rws_asset_hab_tbl h, RWS_ASSET_SUBCOMP_PARAM_TBL ac where a.hab_code=h.hab_code and a.hab_code=p.panch_code and h.hab_code=p.panch_code and a.asset_code=ac.asset_code and a.asset_code=h.asset_code and ac.asset_code=h.asset_code";*/

 }
 String a1=" order by a.asset_name";
 if(assetType!=null)
	 {// //System.out.println("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
	query=query+ " and a.type_of_asset_code="+assetType;}

 query=query+a1;
// //System.out.println("query     is "  +query);		
}

catch(Exception e)
{
	//System.out.println("for enumeration "+e);
}
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs = stmt.executeQuery(query);
		rs.last();
Count = rs.getRow();
// //System.out.println("Total Records = "+Count);
rs.beforeFirst();

rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();
 // //System.out.println("get columb coint                                    "+ Cnt);
 Cnt=Cnt+2;
 try{
	String[] colLabel=null;
	ArrayList labelcol = new ArrayList();

	colLabel=new String[Cnt];
	for(int p=0,c=1; p<Cnt;p++,c++)
	{
		colLabel[p]=rsm.getColumnLabel(c);
	}
	labelcol.add(colLabel);

	session.setAttribute("arrayLabel", labelcol);
	String[] record = null;
	ArrayList myList = new ArrayList();
	while(rs.next())
	{
		record = new String[Cnt];
		for(int z=0,c=1;z<Cnt && c<=Cnt;z++,c++)
		{
		record[z] = rs.getString(c);
		}
		myList.add(record);

	}

session.setAttribute("arrList", myList);
//RwsOffices rw=new RwsOffices(ds);
//session.setAttribute("RSet1",rw);

}catch(Exception e)
{
	//System.out.println("knk error is   "+e);
	//e.printStackTrace();
}

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
	font-family:Arial;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:Arial;
	font-size:9pt;
}

</style>
</head>
<body bgcolor="#edf2f8"><%	//out.println(query);%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
	
	
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_asset_new_subcomp_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
				<a href="rws_asset_subcomp_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>
				<a href="rws_asset_subcomp_rpt_excel_print.jsp"target="_new">Excel</a>
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Asset Sub Component Status  Report </font></td>
</tr>
<tr><td>
	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr>
<tr>
	<td align="center" class="mystyle1"><font color="navy">Circle: <%=request.getParameter("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(!request.getParameter("mName").equals("null")){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=request.getParameter("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(!request.getParameter("pName").equals("null")){%>
<td align="center" class="mystyle1"><font color="navy">Sub Division: <%=request.getParameter("pName") %></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<%}%>

<%if(assetType!=null){%>
<td align=center colspan=8 class="mystyle1"><font color="navy">Asset Type:&nbsp;&nbsp;<%=ATName %> </font></td>
</tr>
<%}%>
</table>

<%if(Count!=0){%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%   bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	

	<tr>
		<td class="btext">S.No</td>
		

		<%	if(!rs.equals("0")){
		int i=0;
	//	rsm=rs.getMetaData();
		for(j=5; j<=rsm.getColumnCount();j++ ) {
		 // //System.out.println("get columb lables are  "+rsm.getColumnLabel(j));
			
		%>
		<td class="btext"><%= rsm.getColumnLabel(j) %></td>
	<%} }%>
	</tr>	
<%
	try
	{		
		
		int slno=0;
		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";
	String panchcode[]=new String[Cnt];		


		while (rs.next())
		{			
		
		String atcode=rs.getString(4);
		String  accode=rs.getString(7);
		String ascode=rs.getString(8);
		// //System.out.println("atcode   "+atcode);
		// //System.out.println("atcode   "+accode);
		// //System.out.println("atcode   "+ascode);
		
		st1=conn.createStatement();
		String q2="SELECT ASSET_SUBCOMPONENT_NAME from RWS_ASSET_SUBCOMPONENT_TBL where TYPE_OF_ASSET_CODE='"+atcode+"' and ASSET_COMPONENT_CODE='"+accode+"' and ASSET_SUBCOMPONENT_CODE='"+ascode+"'";
		rs1=st1.executeQuery(q2);
		rs1.next();
		// //System.out.println("name is   "+rs1.getString(1));
		
		st2=conn.createStatement();
		String q4="SELECT ASSET_COMPONENT_NAME from RWS_ASSET_COMPONENT_TYPE_TBL  where TYPE_OF_ASSET_CODE='"+atcode+"' and ASSET_COMPONENT_CODE='"+accode+"'";
		rs2=st2.executeQuery(q4);
		rs2.next();
		// //System.out.println("name is   "+rs2.getString(1));


		String distcode=rs.getString(5);
		String mandcode=rs.getString(6);
//		String panchcode=rs.getString(3);
		if(temp.equals(distcode))
			{
			if(temp1.equals(mandcode))
			{
				//slno++;
				%>		<tr align=left bgcolor="#ffffff">
						<!--  <td class="mystyle1"><%= slno%></td> -->
						<td colspan=3 class="mystyle1"></td>
						<!-- <td class="mystyle1"></td>
						<td class="mystyle1"></td>  -->
					
					<% 
						 
		for(int k=7;k<=rsm.getColumnCount()-1;k++){ 
	
		if(panchcode[k]==null){
			 if(rsm.getColumnLabel(k).equals("Asset Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%= rs2.getString(1)%></td>	<%	}
			
			else if(rsm.getColumnLabel(k).equals("Asset Sub Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%=rs1.getString(1)%></td>	<%	}

			else {

			panchcode[k]=rs.getString(k);			
						// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
		%>
			<td class="mystyle1"><%= rs.getString(k)%></td>
		
					<%} }else if(panchcode[k].equals(rs.getString(k))){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			 if(rsm.getColumnLabel(k).equals("Asset Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%= rs2.getString(1)%></td>	<%	}
			
			else if(rsm.getColumnLabel(k).equals("Asset Sub Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%=rs1.getString(1)%></td>	<%	}
				
				else{
			panchcode[k]=rs.getString(k);
			%>
		<td class="mystyle1"><%= rs.getString(k)%></td>
		<%} }}%>
			<td class="mystyle1"><%= rs.getString(10)%></td>
					</tr>
<%				}
				else
				{
					temp=rs.getString(5);
					temp1=rs.getString(6);
				//	temp2=rs.getString(3);
%>
					<tr align=left bgcolor="#ffffff">
			 	<td colspan=2 class="mystyle1"></td>  
<!-- 				<td class="mystyle1"></td> -->
					<td class="mystyle1"><%= rs.getString(6)%></td>
					
					
					<% 
						 
		for(int k=7;k<=rsm.getColumnCount()-1;k++){ 
	
		if(panchcode[k]==null){
			 if(rsm.getColumnLabel(k).equals("Asset Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%= rs2.getString(1)%></td>	<%	}
			
			else if(rsm.getColumnLabel(k).equals("Asset Sub Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%=rs1.getString(1)%></td>	<%	}

			else {

			panchcode[k]=rs.getString(k);			
						// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
		%>
			<td class="mystyle1"><%= rs.getString(k)%></td>
		
					<%} }else if(panchcode[k].equals(rs.getString(k))){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			 if(rsm.getColumnLabel(k).equals("Asset Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%= rs2.getString(1)%></td>	<%	}
			
			else if(rsm.getColumnLabel(k).equals("Asset Sub Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%=rs1.getString(1)%></td>	<%	}
				
				else{
			panchcode[k]=rs.getString(k);
			%>
		<td class="mystyle1"><%= rs.getString(k)%></td>
		<%} }}%>
		<td class="mystyle1"><%= rs.getString(10)%></td>
					</tr>
<%				}
			}
			
		else
		{
			slno++;
			temp=rs.getString(5);
			temp1=rs.getString(6);
			//temp2=rs.getString(3);
			
		
%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%= slno%></td>
			<td class="mystyle1"><%= rs.getString(5)%></td>
			<td class="mystyle1"><%= rs.getString(6)%></td>
			<%			
			
		for(int k=7;k<=rsm.getColumnCount()-1;k++){ 
	
		if(panchcode[k]==null){
			 if(rsm.getColumnLabel(k).equals("Asset Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%= rs2.getString(1)%></td>	<%	}
			
			else if(rsm.getColumnLabel(k).equals("Asset Sub Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%=rs1.getString(1)%></td>	<%	}

			else {

			panchcode[k]=rs.getString(k);			
						// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
		%>
			<td class="mystyle1"><%= rs.getString(k)%></td>
		
					<%} }else if(panchcode[k].equals(rs.getString(k))){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			 if(rsm.getColumnLabel(k).equals("Asset Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%= rs2.getString(1)%></td>	<%	}
			
			else if(rsm.getColumnLabel(k).equals("Asset Sub Component Name"))
			{	
					panchcode[k]=rs.getString(k);	
				// //System.out.println("EEE   "+k +"   is "+panchcode[k]);%>
			<td class="mystyle1"><%=rs1.getString(1)%></td>	<%	}
				
				else{
			panchcode[k]=rs.getString(k);
			%>
		<td class="mystyle1"><%= rs.getString(k)%></td>
		<%} }}%>
		<td class="mystyle1"><%= rs.getString(10)%></td>
		</tr>
<% 
	}
			rs1.close();
			rs2.close();
			st1.close();st2.close();
	}
	}
	
	
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	finally
	{
	conn.close();
	}

%>
</table>
<%} else {%>
<table border=0 align=center height="70%" width="100%">
<tr><td align="center" class="mystyle"><font color="navy">There are No Records </font></td></tr>
</table><%}%>

<!-- <table  width="100%" border="0"> 
<tr><td align="right" class="mystyle"><A HREF="./Tf1.jsp">Next</A></td></tr>
</table> -->
</TD></TR>
</TABLE>
</body>
</html>
<%@ include file = "footer.jsp" %>