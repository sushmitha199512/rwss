<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>

<%@ include file = "header_rpt.jsp" %>

<%	Statement st1 = null,st2;
	ResultSet rs1 = null,rs2;
	ResultSetMetaData rsm=null;

	int start,end,limit =20,j,slno=0,pgcnt,pgno=0;
	int line=0;	
	String stt=request.getParameter("start");

	
	if(request.getParameter("start") !=  null) {
		start = Integer.parseInt(request.getParameter("start"));

		}
		else
		{
			start = 0;
	
		}
		
		if(request.getParameter("slno") !=  null) {
		slno = Integer.parseInt(request.getParameter("slno"));

		}
		else
		{
			slno = 0;
	
		}
		end = start + limit;

	//RwsOffices RS1=(RwsOffices)session.getAttribute("RSet1");
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = myList1.iterator();

	int mylists1=myList1.size();
		
	
	if(request.getParameter("pgcnt") !=  null) {
			pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
			////System.out.println("pgcnt is     "+pgcnt);

		}
		else
		{
			pgcnt = 1;
			////System.out.println("pgcnt is    "+pgcnt);	
		}
		
String asseType=String.valueOf(session.getAttribute("assetType"));
String ATName="";
if(!asseType.equals("null")){
if(asseType.equals("01")){ATName="PWS";}
else if(asseType.equals("02")){ATName="MPWS";} 
else if(asseType.equals("03")){ATName="CPWS";}
else if(asseType.equals("04")){ATName="HANDPUMPS";}
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
				 <a href="rws_asset_subcomp_rpt_print1.jsp" target="_new">Print&nbsp;|&nbsp;</a>
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


		for(int z = start,sno=start+1; z < end; z++,sno++)
		{	
		if(mylists1>z)
			{		
		
		String[] record1 =(String[])myList1.get(z);		
		String atcode=record1[3];
		String accode=record1[4];
		String ascode=record1[5];
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






















<%	
	try
	{		
		
		//int slno=0;
		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";
		String panchcode[]=new String[labelNames.length];		
		
		for(int z = start,sno=start+1; z < end; z++,sno++)
		{	
		if(mylists1>z)
			{		
		String[] record1 =(String[])myList1.get(z);		
		String distcode=record1[0];
		String mandcode=record1[1];
		if(temp.equals(distcode))
			{
			if(temp1.equals(mandcode))
			{
				
				%>		<tr align=left bgcolor="#ffffff">
						<td class="mystyle1"></td>
						<td class="mystyle1"></td>
						<td class="mystyle1"></td> 
					
								<% 
			for(int k=2; k<labelNames.length;k++ ) {
			

			if(panchcode[k]==null){
				panchcode[k]=record1[k];			
						// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
		%>
			<td class="mystyle1"><%= record1[k]%></td>
		
					<%} else if(panchcode[k].equals(record1[k])){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			panchcode[k]=record1[k];
			%>
		<td class="mystyle1"><%= record1[k]%></td>
		<%} 
	}%>
		</tr>
<%				}
				else
				{
						////System.out.println("heello");
					temp= record1[0];
					temp1= record1[1];
				//	temp2=rs.getString(3);
%>
					<tr align=left bgcolor="#ffffff">
				<!-- 	<td colspan=2 class="mystyle1"></td> tbis chagne 25/2 -->
					<td class="mystyle1"><%= sno%></td>
					<td  class="mystyle1"></td> 
					<td   class="mystyle1"><%= record1[1]%></td>
					
				<%	
		
		for(int k=2; k<labelNames.length;k++ ) {

			if(panchcode[k]==null){
				panchcode[k]= record1[k];			
							// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
			%>
				<td class="mystyle1"><%=record1[k]%></td>
			
						<%} else if(panchcode[k].equals(record1[k])){ %>
						
			<td class="mystyle1"></td> 
			<%}else{
				panchcode[k]=record1[k];
				%>
			<td class="mystyle1"><%= record1[k]%></td>
			<%} } %>
				
		</tr>
<%				}
			}
			
		else
		{		
			slno++;
			temp= record1[0];
			temp1= record1[1];
			//temp2=rs.getString(3);
			%>
		<tr align=left >
			<td  class="mystyle1"><%= sno%></td>
			<td  class="mystyle1"><%=  record1[0]%></td>
			<td  class="mystyle1"><%= record1[1]%></td>
		
<%		
		
		for(int k=2; k<labelNames.length;k++ ) {

			if(panchcode[k]==null){
				panchcode[k]= record1[k];			
							// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
			%>
				<td class="mystyle1"><%=record1[k]%></td>
			
						<%} else if(panchcode[k].equals(record1[k])){ %>
						
			<td class="mystyle1"></td> 
			<%}else{
				panchcode[k]=record1[k];
				%>
			<td class="mystyle1"><%= record1[k]%></td>
			<%} }			
			 %>
		</tr>

<% 
	}
	}//end of if 
		}//end of for
	}
	catch(Exception ee)
	{
	 //System.out.println("The error is="+ee);
	}
	
%>
</table>
</TD></TR>
</TABLE>
<table border=0 align=center width="30%">
<tr><td align="center"  class=mystyle1>GO TO PAGE :</td>
<td align="left" class=mystyle1><%for(int r=0,s=1;r<myList1.size(); r+=20,s++) { 
		// //System.out.println("panchayat  name is ");		
		if(pgcnt==s)
		{ 
		%><font color=red>	<%=s%></font>
		<%			
		}
		else {
			%>
			
		<a href="rws_asset_rpt_temp.jsp?start=<%=r%>&slno=<%=slno%>&pgcnt=<%=s%>"><%=s%></a>
<% 			}%>

				
		<%
		}

		%>
<td></table>
</body>
</html>
<%@ include file = "footer.jsp" %>