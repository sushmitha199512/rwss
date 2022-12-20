<%@ page import="java.sql.*,nic.watersoft.*"%>
<%@ include file="conn.jsp"%>
<% java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<html>
<head>
<title> WaterSoft </title>
</head>
<link rel="stylesheet" type="text/css" href="../resources/style/rwsstyle.css">

<body bgcolor="#edf2f8">

<table border = 0 cellspacing = 0 cellpadding = 0 align = center width=100% style="border-collapse:collapse">
	<tr>
		<td align=center class=reportMainHeading><font color="#660000">Users & Password Details</td>
	</tr>
	<tr>
		<td align=center class=reportSubHeading><font color="#006600">Panchayat Raj Engneering Department</td>
	</tr>
	<tr>
		<td align=center class=reportHeading><font color="#6600FF">Rural Water Supply</td>
	</tr>		
	<tr>
		<td	class=datefont align="right" colspan=4><font color="#990000">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>

<table align=center width=75%>
<caption align="right">
<table width="20%" border=0 rules=none style="border-collapse:collapse" align = right>
	<tr>
		<td colspan=8 align=right><a href="./rws_master_list_frm.jsp">Back |</a></td>
		<td colspan=8 align=right><a href="../home.jsp">Home |</a></td>
		<!-- <td colspan=8 align=right><a href="../home.jsp">Excel |</a></td> -->
		<td colspan=8 align=right><a href="../home.jsp">Print</a></td>		
	</tr>
</table>
</caption>
<br>
<tr>
<td>
<%
	int slno=0; 
	query="select * from RWS_PUBLIC_REP_TBL order by rep_code	";
%>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="lavander">
		<td class=reportValue><font color="#ffffff"><b>Representative Codes / Names</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr align=center bgcolor="#ffffff">
		<td class=clrborder>SL.No</td>
		<td class=clrborder>Representative Code</td>		
		<td class=clrborder>Representative Name</td>		
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
		<td class=reportValue><%= slno%></td>
		<td class=reportValue><%= rs.getString(1)%></td>
		<td class=reportValue><%= rs.getString(2)%></td>				
	</tr>
<%
	}
		}
	catch(Exception e)
	{
	//System.out.println("The error in rws_qualification_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
%>
</table>
</td>
</tr>
</table>
</body>
</html>