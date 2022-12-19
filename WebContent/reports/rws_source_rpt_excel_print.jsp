<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
<%@ page contentType="application/vnd.ms-excel" %>


<%	

	int start,end,limit =20,j,slno=0,pgcnt,pgno=0;
	int line=0;	
	String stt=request.getParameter("start");
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	
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

	RwsOffices RS1=(RwsOffices)session.getAttribute("RSet1");
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	ArrayList meList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = meList1.iterator();

	int mylists1=meList1.size();
		
	
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
<title>WaterSoft</title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body topmargin="0">

<p width="100%" align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Department Of Panchayat Raj and Engineering <br>
Rural Water Supply<br>
Govt.of Andhra Pradesh<br><br></font>
</p>
<p width="100%" align="center"><b><font face="Verdana" size="3">Source Type Habitation  Status  Report</font>
	</p>
<p width="100%" align="right"><b><font face="Verdana" size="2">
	Report Date :<%=fmt.format(new java.util.Date()) %></font>
</p>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</head>
<body><%	//out.println(query);%>

<p>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align=center>	
	<tr>
	<td align="center" class="mystyle1"><font color="black">Source Type Name: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="black">Sub Source Type Name: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>

</table>
</p>
<%}%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	

	<tr >
		<td class = btext>S.No</td>
		
		
		<%		int i=0;
				for(j=0; j<labelNames.length;j++ ) {			
			%>
		<td class = btext><%= labelNames[j] %></td>
	<%
			} %>
	</tr>	
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
		
		for(int z = start,sno=start+1; z <mylists1; z++,sno++)
		{	
		if(mylists1>z)
		{		
		String[] record1 =(String[])meList1.get(z);		
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

<p width="100%" align="center">
Designed & Developed by National Informatics Centre, AP State Centre
</p>
</body>
</html>