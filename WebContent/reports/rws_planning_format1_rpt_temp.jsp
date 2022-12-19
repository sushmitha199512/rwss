<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%
	int start, end, limit =30, j, pgcnt, pgno=0;
	int line=0, Cnt=0, tot=0, slno=0;	
	int  GOPG;
	
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

	if(request.getParameter("gopg") !=  null) 
	{
		GOPG = Integer.parseInt(request.getParameter("gopg"));
		////System.out.println("Go pg no is    "+GOPG);
	}
		else 
			GOPG=0;	
	
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();
  
   String val[]=null;
   ArrayList myList2 = (ArrayList)session.getAttribute("format1");
   Iterator iterator1 = myList2.iterator();
   val=(String[])iterator1.next();

     //ResultSet r1 = (ResultSet)session.getAttribute("format2"); 

	//int mylists1=myList1.size();
	////System.out.println("pgcnt is     "+mylists1);

		
	
	if(request.getParameter("pgcnt") !=  null)
	{
		pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
		// //System.out.println("pgcnt is     "+pgcnt);
	}
		else
		{
			pgcnt = 1;
			////System.out.println("pgcnt is    "+pgcnt);	
		}
 %>
<html>
<head>
<title> WaterSoft </title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body bgcolor="#edf2f8">
<%
	//out.println(query);
%>

<form name=f1 method="post" action="./rws_planning_format1_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">		
				<a href="./rws_planning_format1_frm.jsp">Back |</a>
				<a href="../home.jsp">Home |</a>
				<!--<a href="rws_planning_format1_rpt_print.jsp" target="_new">Print |</a>
				<a href="rws_planning_format1_rpt_xls.jsp"target="_new">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td align="center" class="rptHeading" colspan=24>RWS Planning Format - I Report</font></td>	
	</tr>	
	<tr>
		<td valign=top>
			<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center width=100%>	
				<tr align=center>
					<td align="center" class="rptValue">District: <%=session.getAttribute("districtName")%></td>
<% 
	if(session.getAttribute("mandalName")!=null)
	{
%>
					<td align="center" class="rptValue">Mandal: <%=session.getAttribute("mandalName")%></td>
<%
	}
		if(session.getAttribute("panchayatName")!=null)
		{
%>
					<td align="center" nowrap class="rptValue">Panchayat: <%=session.getAttribute("panchayatName")%></td>
				</tr>
<%
		}
			if(session.getAttribute("villageName")!=null)
			{
%>
					<td align="center" nowrap class="rptValue">Village: <%=session.getAttribute("villageName")%></td>
				</tr>
<%
			}
				if(session.getAttribute("habitationName")!=null)
				{
%>
					<td align="center" nowrap class="rptValue">Habitation: <%=session.getAttribute("habitationName")%></td>
				</tr>
<%
				}
%>
		</td>
	</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	
<%
	if(GOPG<=((myList1.size()/30)+1))
	{
%>
		
		<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>District Code</td>
		<td class=btext>District Name</td>
		<td class=btext>Assembly Constituency Code</td>
		<td class=btext>Assembly Constituency Name</td>
		<td class=btext>Mandal Code</td>
		<td class=btext>MandalName</td>
		<td class=btext>Parliamentary Constituency Code</td>
        <td class=btext>Parliamentary Constituency Name</td>
		<td class=btext>Division</td>
		<td class=btext>Village Code</td>
		<td class=btext>Village Name</td>
		<td class=btext>Habitation Code</td>
		<td class=btext>Habitation Name</td>
		<td class=btext>Panchayat Code</td>
		<td class=btext>Panchayat Name</td>
		<td class=btext>PR Hab Code</td>
		<td class=btext>Total Population</td>
		<td class=btext>SC Population</td>
		<td class=btext>ST Population</td>
		<td class=btext>Status (1.4.05)</td>
		<td class=btext>NSS - Ty</td>
		<td class=btext>NSS - FI</td>
		<td class=btext>NSS - Br</td>
		<td class=btext>NSS - Ir</td>
	</tr>
<% 
			Cnt=24;
	}
	try
	{
		if(request.getParameter("gopg") !=  null) 
		{
			GOPG = Integer.parseInt(request.getParameter("gopg"));
			////System.out.println("Go pg no is    "+GOPG);
				if(GOPG==1)
				{
					start= 0;
					end = start + limit;
				}
				else 
					if(GOPG<=((myList1.size()/30)+1))
				{
					start=(GOPG * 30)-30;
					end = start + limit;
				}
				else
				{ 
%>
		<tr align="center" class="btext">
			<td><%="Invalid  Valid Page Number Enetered"%></td>
		</tr>
<%
			start=mylists1;
				}
		}

			for(int z = start,sno=start+1; z < end; z++,sno++)
			{	
				if(mylists1>z)
				{		
					String[] record1 =(String[])myList1.get(z);		
%>

			<td class=rptValue nowrap><%=sno%></td>
<%
					//for(int k=0; k<18;k++ ) 
			          for(int k=0; k<6; k++ ) 

					{ 
%>  
                      <td class=rptValue nowrap><%=record1[k]%></td>  
<%	
					}	
					//if(k==7)
						//{
                  for(int l=0;l<val.length;l++){
					  ////System.out.println("value is"+val.length);
					 ////System.out.println("laksdjf"+val[0]);
					 // //System.out.println("srikanth"+val[1]);
%>
			<td class=rptValue nowrap><%=val[l]%></td>
			
<%
						}
					//}
                     //for(int k=18; k<22;k++ ) 
                  for(int k=6; k<18;k++ ) 
						{
%>
			<!--<td class=rptValue nowrap>--</td>-->
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
			} 
	}
	catch(Exception e)
	{
	// //System.out.println("The error is="+e);
	}
	
%>
</table>

<table border=0 align=center width="100%">
	<tr>
		<td align="right" nowrap class=mystyle1>GO TO PAGE :</td>
		<td class = mystyle1><input size = 3 type="text" name="gopg"  onchange="this.form.submit()"></td>
		<td align="left" class=mystyle1>
<%
	if(request.getParameter("gopg") ==  null) 
	{
%>
		<td align="right" class=mystyle1>Page <font color=red><%= pgcnt %></font> of <font color=blue> <%= (myList1.size()/30)+1 %></font>
<%
	}
		else
		{
%>
		<td align="right" class=mystyle1>Page <font color=red><%= request.getParameter("gopg") %></font> of <font color=blue> <%= (myList1.size()/30)+1 %></font>
<% 
	
		}
%>
</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>