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
	query="SELECT * from rws_designation_tbl order by designation_code";	
%>

<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
<br><br>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	
	<tr>
		<td class=textborder colspan=3>List of Designation Codes / Names</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Designation Code</td>
		<td class=textborder>Designation Acronym</td>
		<td class=textborder>Designation Name</td>		
	</tr>

<%
	try
	{		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		while (rs.next())
		{ 
		slno++;

%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%= rs.getString(2)%></td>
		<td class=bwborder><%= rs.getString(3)%></td>		
	</tr>
<%
	}
		}
	catch(Exception e)
	{
	//System.out.println("The error in rws_designation_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
%>
</table>
</body>
</html>
