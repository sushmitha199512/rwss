<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %> 
<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>

<%
	String hcode = request.getParameter("head");
	String hname = request.getParameter("hname");		
	//System.out.println("Head Office Name : "+hname);
	//System.out.println("Head Office Code : "+hcode);
%>
<%  fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
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
<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
<%
	if(hcode.equals("0"))
	{
	int slno=0; 
	query="select h.head_office_code, h.head_office_name, c.circle_office_code, c.circle_office_name  from rws_circle_office_tbl c, rws_head_office_tbl h where h.head_office_code = c.head_office_code";	
%>



<br><br>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	
	<tr>
		<td class=textborder colspan=3>List of Head Offices</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Head Office Code</td>
		<td class=textborder>Head Office Name</td>
		<td class=textborder>Circle Office Code</td>
		<td class=textborder>Circle Office Name</td>		 
	</tr>

<%
	try
	{		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		String temp="";
		String temp1="";
		
		while (rs.next())
		{ 
		slno++;
		String hOC=rs.getString(1);
		String hON=rs.getString(2);
		if(temp.equals(hOC))
			{
			if(temp1.equals(hON))
				{

%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>
	</tr>
<%
				}
			}
		else
			{
			temp=hOC;
			temp1=hON;
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
	//System.out.println("The error in rws_circle_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
	}// END OF MAIN IF
	else
	if(!hcode.equals("0"))
	{
	int slno=0; 
	query="select circle_office_code, circle_office_name  from rws_circle_office_tbl where head_office_code = '"+hcode+"' ";	
%>
</table>
<br><br>

<table width="75%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
		<% if(hcode != null && !hcode.equals("")) { %>
			<td	class=textborder align=center><font color="#000000">Head Office : <%=hname%></td>
		<% } %>		
	</tr>
</table>

<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	
	<tr>
		<td class=textborder colspan=3>List of Head Offices</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Circle Office Code</td>
		<td class=textborder>Circle Office Name</td>		 
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
<%
		}
	}
	catch(Exception e)
	{
	//System.out.println("The error in rws_circle_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
	}// END OF IF
%>
</table>
</body>
</html>