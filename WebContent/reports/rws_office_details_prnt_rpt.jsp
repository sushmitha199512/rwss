<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>

<% java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<html>
<head>
<title>WaterSoft</title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</font></p>


<%
	int slno=0; 
	query="select o.office_code, nvl(o.address1, '&nbsp;'), nvl(o.address2, '&nbsp;'), nvl(o.address3, '&nbsp;'), nvl(o.city, '---'), nvl(o.pincode, '&nbsp;'), nvl(o.phone, '---'),  nvl(o.fax, '--'), nvl(o.email, '---'), decode(o.building, 'O', 'Own', 'R', 'Rented'), o.head_of_office, decode(o.project, 'P', 'Project', 'R', 'Regular'), d.designation_name from rws_office_tbl o, rws_designation_tbl d where o.head_of_office=d.designation_code";	
%>
<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
<br><br>

<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	
	<tr>
		<td class=textborder>RWS Office Details</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Office Name</td>	
		<td class=textborder>Address</td>
		<td class=textborder nowrap>Phone No</td>
		<td class=textborder>Fax</td>
		<td class=textborder nowrap>E-Mail</td>
		<td class=textborder>Building</td>
		<td class=textborder>Head Of Office</td>
		<td class=textborder>Project</td>		
	</tr>

<%
	try
	{		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		  RwsOffices rwsOffices = new RwsOffices(dataSource);
		  		

		while (rs.next())
		{ 
		slno++;
		/*
		String st=rs.getString(1);
		String st1=st.substring(0,1);
		String st2=st.substring(1,3);
		String st3=st.substring(3,4);
		String st4=st.substring(4,6);

		
		if(!st4.equals("00"))
			{
				
				String query2="select subdivision_office_name from rws_subdivision_office_tbl where  head_office_code='"+st1+"' and circle_office_code='"+st2+"' and division_office_code='"+st3+"' and subdivision_office_code='"+st4+"'";
				Statement st5 = conn.createStatement();
				ResultSet rs5 = st5.executeQuery(query2);			
			while (rs5.next())
				{				
				st=rs5.getString(1);
				}
			
			}
		else
			if(!st3.equals("0"))
			{
				String query3="select division_office_name from rws_division_office_tbl where head_office_code='"+st1+"' and circle_office_code='"+st2+"' and division_office_code='"+st3+"'";
				
				Statement st6 = conn.createStatement();
				ResultSet rs6 = st6.executeQuery(query3);
			while (rs6.next())
				{
				st=rs6.getString(1);
				}				
			}

		else
			if(!st2.equals("00"))
			{
				String query4="select circle_office_name from rws_circle_office_tbl where head_office_code='"+st1+"' and circle_office_code='"+st2+"'";
				
				Statement st7 = conn.createStatement();
				ResultSet rs7 = st7.executeQuery(query4);
			while (rs7.next())
				{
				st=rs7.getString(1);
				}				
			}
		else
			if(!st1.equals("0"))
			{
				String query5="select head_office_name from rws_head_office_tbl where head_office_code='"+st1+"'";

				Statement st8 = conn.createStatement();
				ResultSet rs8 = st8.executeQuery(query5);
			while (rs8.next())
				{
				st=rs8.getString(1);
				}
			}
			*/
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rwsOffices.getOfficeName(rs.getString(1),true)%></td>
		<td class=bwborder><%= rs.getString(2)%><br><%= rs.getString(3)%><br><%= rs.getString(4)%><br><%= rs.getString(5)%><br><%= rs.getString(6)%></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
		<td class=bwborder><%= rs.getString(9)%></td>
		<td class=bwborder><%= rs.getString(10)%></td>
		<td class=bwborder><%= rs.getString(13)%></td>
		<td class=bwborder><%= rs.getString(12)%></td>		
	</tr>
<%
	}
		}
	
	catch(Exception e)
	{
	//System.out.println("The error in rws_office_details_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
%>
</table>
</body>
</html>