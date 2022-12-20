
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
<p width="100%" align="center"><b><font face="Verdana" size="3">Assets in Habitation </font>
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
	<font color="navy">District: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
<% if(session.getAttribute("mName")!=null){%>
Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%}%>
<% if(session.getAttribute("pName")!=null){%>
Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%}%>
<% if(session.getAttribute("vName")!=null){%>
Village: <%=session.getAttribute("vName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%}%>
<% if(session.getAttribute("hName")!=null){%>
Habitation:<%=session.getAttribute("hName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%}%>
</p>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	

	<tr >
		<td ><b>S.No</b></td>
		
		
		<%		int i=0;
				for(j=1; j<labelNames.length;j++ ) {			
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
		
		for(int z = start,sno=start+1; z < mylists1; z++,sno++)
		{	
			
				String[] record1 =(String[])myList1.get(z);		
				String distcode=record1[0];
				String mandcode=record1[1];
				slno++;
	%>
			<tr align=left >
			<td  class="mystyle1"><%= sno%></td>
<%		
			for(int k=1; k<labelNames.length;k++ )
	        //for(int k=2; k<labelNames.length;k++ )
			{
%>
				<td class="mystyle1"><%=record1[k]%></td>
<% 
			}
%>
		</tr>

<% 
	
	
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
<p align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</p>
</body>
</html>
