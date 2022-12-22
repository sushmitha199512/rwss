
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
<%@ page contentType="application/vnd.ms-excel" %>

<%	

	int start,end,limit =10,j,slno=0,pgcnt,pgno=0;
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
<title>WaterSoft</title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body topmargin="0">

<p width="100%" align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Department Of Panchayat Raj and Engineering <br>
Rural Water Supply<br>
Govt.of Andhra Pradesh<br><br></font>
</p>
<p width="100%" align="center"><b><font face="Verdana" size="3">Asset Habitation Sub Component Report</font>
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


<P border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align="center">	
	<font color="navy">Circle: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
<% if(session.getAttribute("mName")!=null){%>
Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%}%>
<% if(session.getAttribute("pName")!=null){%>
Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%}%>
<%if(!asseType.equals("null")){%>
Asset Type:&nbsp;&nbsp;<%=ATName %> </font>
<%}%>
</p>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	

	<tr >
		<td ><b>S.No</b></td>
		
		
		<%		int i=0;
				for(j=4; j<labelNames.length;j++ ) {			
			%>
		<td><b><%= labelNames[j] %></b></td>
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
		String[] record1 =(String[])myList1.get(z);		
		String distcode=record1[4];
		String mandcode=record1[5];
		if(temp.equals(distcode))
			{
			if(temp1.equals(mandcode))
			{
				
				%>		<tr align=left bgcolor="#ffffff">
						<td class="mystyle1"></td>
						<td class="mystyle1"></td>
						<td class="mystyle1"></td> 
					
								<% 
			for(int k=6; k<labelNames.length;k++ ) {
			

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
					temp= record1[4];
					temp1= record1[5];
				//	temp2=rs.getString(3);
%>
					<tr align=left bgcolor="#ffffff">
				<!-- 	<td colspan=2 class="mystyle1"></td> tbis chagne 25/2 -->
					<td class="mystyle1"><%= sno%></td>
					<td  class="mystyle1"></td> 
					<td   class="mystyle1"><%= record1[5]%></td>
					
				<%	
		
		for(int k=6; k<labelNames.length;k++ ) {

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
			temp= record1[4];
			temp1= record1[5];
			//temp2=rs.getString(3);
			%>
		<tr align=left >
			<td  class="mystyle1"><%= sno%></td>
			<td  class="mystyle1"><%=  record1[4]%></td>
			<td  class="mystyle1"><%= record1[5]%></td>
		
<%		
		
		for(int k=6; k<labelNames.length;k++ ) {

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
	 //ee.printStackTrace();
	}
	
%>

</table>
</TD></TR>
</TABLE>
<p align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</p>
</body>
</html>
