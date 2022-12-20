<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
<%	

	int start, end, limit =10, j, slno=0, pgcnt, pgno=0, LNO=0;
	int line=0, Cnt=0, tot=0;	
	int  GOPG;
	String stt=request.getParameter("start");
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	
	if(request.getParameter("start") !=  null) 
		{
			start = Integer.parseInt(request.getParameter("start"));
		}
		else
			{
				start = 0;	
			}		
	if(request.getParameter("slno") !=  null) 
		{
			slno = Integer.parseInt(request.getParameter("slno"));
		}
		else
			{
				slno = 0;	
			}
				end = start + limit;

	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = myList1.iterator();

	int mylists1=myList1.size();
	//System.out.println("pgcnt is     "+mylists1);
		
	
	if(request.getParameter("pgcnt") !=  null) 
		{
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

	<p align="center"><b><font face="Verdana" size="2">WaterSoft<br>
	Panchayat Raj Engineering Department<br>
	Rural Water Supply<br>
	Govt.of Andhra Pradesh</font></p>

	<p align="center"><b><font face="Verdana" size="2">RWS Planning Format - I Report</font></p>
	<p align="right" class=dateFont><%=sdf.format(new java.util.Date())%></p>	
</head>


<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=prptLabel>Sl.No</td>				
		<td class=prptLabel>District Code</td>
		<td class=prptLabel>District Name</td>
		<td class=prptLabel>Assembly Constituency Code</td>
		<td class=prptLabel>Assembly Constituency Name</td>
		<td class=prptLabel>Mandal Code</td>
		<td class=prptLabel>MandalName</td>
		<td class=prptLabel>Parliamentary Constituency</td>
		<td class=prptLabel>Division</td>
		<td class=prptLabel>Village Code</td>
		<td class=prptLabel>Village Name</td>
		<td class=prptLabel>Habitation Code</td>
		<td class=prptLabel>Habitation Name</td>
		<td class=prptLabel>Panchayat Code</td>
		<td class=prptLabel>Panchayat Name</td>
		<td class=prptLabel>PR Hab Code</td>
		<td class=prptLabel>Total Population</td>
		<td class=prptLabel>SC Population</td>
		<td class=prptLabel>ST Population</td>
		<td class=prptLabel>Status (1.4.05)</td>
		<td class=prptLabel>NSS - Ty</td>
		<td class=prptLabel>NSS - Fl</td>
		<td class=prptLabel>NSS - Br</td>
		<td class=prptLabel>NSS - Ir</td>
	</tr>	
<% 
	Cnt=24; LNO=6;
try
{
	for(int z = start,sno=start+1; z < mylists1; z++,sno++,LNO++)
	{
		
		if(mylists1>z && LNO<=30)
		{		
			String[] record1 =(String[])myList1.get(z);			
%>

		<td class=rptValue nowrap><%=sno%></td>
<%
			for(int k=0; k<18;k++ ) 
			{
				if(k==6)
				{
%>
		<td class=rptValue nowrap>--</td>
			
<%
				}
%>
				
		<td class=rptValue nowrap><%=record1[k]%></td>
<% 
			}
				for(int k=18; k<22;k++ ) 
				{
%>
			<td class=rptValue nowrap>--</td>
<% 
				}
%>

	</tr>

<% 
		
		}
			else
				{				
				LNO=6;
				z--; sno--;				
%>
</table>
	<p align="center"><b><font face="Verdana" size="2">Designed and Developed By NIC APSC</b></font></p>
	<p style="page-break-before:always"></p>

	<p align="center"><b><font face="Verdana" size="2">WaterSoft<br>
	Panchayat Raj Engineering Department<br>
	Rural Water Supply<br>
	Govt.of Andhra Pradesh</font></p>

	<p align="center"><b><font face="Verdana" size="2">RWS Planning Format - I Report</font></p>
	<p align="right" class=dateFont><%=sdf.format(new java.util.Date())%></p>	

<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=prptLabel>Sl.No</td>				
		<td class=prptLabel>District Code</td>
		<td class=prptLabel>District Name</td>
		<td class=prptLabel>Assembly Constituency Code</td>
		<td class=prptLabel>Assembly Constituency Name</td>
		<td class=prptLabel>Mandal Code</td>
		<td class=prptLabel>MandalName</td>
		<td class=prptLabel>Parliamentary Constituency</td>
		<td class=prptLabel>Division</td>
		<td class=prptLabel>Village Code</td>
		<td class=prptLabel>Village Name</td>
		<td class=prptLabel>Habitation Code</td>
		<td class=prptLabel>Habitation Name</td>
		<td class=prptLabel>Panchayat Code</td>
		<td class=prptLabel>Panchayat Name</td>
		<td class=prptLabel>PR Hab Code</td>
		<td class=prptLabel>Total Population</td>
		<td class=prptLabel>SC Population</td>
		<td class=prptLabel>ST Population</td>
		<td class=prptLabel>Status (1.4.05)</td>
		<td class=prptLabel>NSS - Ty</td>
		<td class=prptLabel>NSS - Fl</td>
		<td class=prptLabel>NSS - Br</td>
		<td class=prptLabel>NSS - Ir</td>
	</tr>
<% 
				}//end of ELSE
	}//end of for
}
catch(Exception ee)
{
	//System.out.println("The error is="+ee);
}
%>
</body>
</html>
