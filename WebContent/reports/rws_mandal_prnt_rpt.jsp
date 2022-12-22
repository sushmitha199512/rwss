<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>

<%	
	String dcode = request.getParameter("dcode");
	String dname = request.getParameter("dname");
	//System.out.println("dcode="+dcode);
%>
<% java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<html>
<head>
<title>WaterSoft</title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body topmargin="0">

<table border=0 cellspacing=0 cellpadding=0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
<tr>
	<td>
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</font></p>
	</td>
</tr>

<tr>
	<td>
<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
	</td>
</tr>
	

<%
	if(dcode.equals("0"))
	{
	int slno=0; 
	query="SELECT distinct d.dcode, d.dname, m.mcode, m.mname  from RWS_DISTRICT_TBL d, RWS_MANDAL_TBL m where d.dcode=m.dcode ORDER BY d.dcode";	
%>

<br><br>
<tr>
	<td>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=3>List of Mandals</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>District Code</td>
		<td class=textborder>District Name</td>
		<td class=textborder>Mandal Code</td>
		<td class=textborder>Mandal Name</td>		
	</tr>
<%
	try
	{		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		String temp="";
		String distname="";
		while (rs.next())
		{ 
		
		String distcode=rs.getString(1);
		if(temp.equals(distcode))
			{
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>		
	</tr>
<%
		}
else
	{
	temp=rs.getString(1);
	slno++;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%= rs.getString(2)%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>		
	</tr>
<%
  }
	}
		}
	
	catch(Exception e)
	{
	//System.out.println("The error in rws_mandal_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
}// end of main if
	else
		{
    %>
</table>
	</td>
</tr>
	
<br><br>
	<td>
<tr>
	<table border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse" width=75%>
	<tr>
		<% if(dcode != null && !dcode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">District Name: <%= dname%></td>
		<% } %>		
	</tr>
</table>
	</td>
</tr>
<%
int slno=0; 
query="SELECT distinct mcode, mname  from RWS_MANDAL_TBL where dcode = '" +dcode+ "' order by mcode ";	
%>
<tr>
	<td>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=3>List of Mandals</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Mandal Code</td>
		<td class=textborder>Mandal Name</td>		
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
	</tr>
<%      }
}
catch(Exception e)
	{
	//System.out.println("The error in rws_mandal_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
}
%>
</table>
	</td>
</tr>
</table>
		
</body>
</html>