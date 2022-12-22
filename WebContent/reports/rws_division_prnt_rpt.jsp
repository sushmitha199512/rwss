
<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>
<% java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
	String hcode=request.getParameter("head");
	String hname=request.getParameter("hname");
	String ccode=request.getParameter("circle");
	String cname=request.getParameter("cname"); 
	//System.out.println("Head Office Name : "+hname);
	//System.out.println("Head Office Code : "+hcode);
	//System.out.println("Circle Office Name : "+cname);
	//System.out.println("Circle Office Code : "+ccode);
%>

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

<br><br>
<%
	if(hcode.equals("0"))
	{
	int slno=0; 
	query="select h.head_office_code, h.head_office_name, c.circle_office_code, c.circle_office_name, d.division_office_code, d.division_office_name from rws_head_office_tbl h, rws_circle_office_tbl c, rws_division_office_tbl d where h.head_office_code=c.head_office_code and h.head_office_code=d.head_office_code and c.circle_office_code=d.circle_office_code order by h.head_office_code, c.circle_office_code, d.division_office_code";
%>


<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder>List of Division Offices</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Head Office Code</td>
		<td class=textborder>Head Office Name</td>
		<td class=textborder>Circle Office Code</td>
		<td class=textborder>Circle Office Name</td>
		<td class=textborder>Division Office Code</td>
		<td class=textborder>Division Office Name</td>		
	</tr>

<%
	try
	{	
		String temp="";
		String temp1="";
		String temp2="";
		String temp3="";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		while (rs.next())
		{
			slno++;
			String hOC=rs.getString(1);
			String hON=rs.getString(2);
			String cOC=rs.getString(3);
			String cON=rs.getString(4);
			if(temp.equals(hOC))
			{
				if(temp1.equals(hON))
				{
					if(temp2.equals(cOC))
					{
						if(temp3.equals(cON))
						{
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder nowrap></td>
		<td class=bwborder nowrap></td>
		<td class=bwborder nowrap></td>
		<td class=bwborder nowrap></td>
		<td class=bwborder nowrap><%= rs.getString(5)%></td>
		<td class=bwborder nowrap><%= rs.getString(6)%></td>
	</tr>
<%
						}
					}
				else
					{
					temp2=cOC;
					temp3=cON;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder nowrap></td>
		<td class=bwborder nowrap></td>
		<td class=bwborder nowrap><%= rs.getString(3)%></td>
		<td class=bwborder nowrap><%= rs.getString(4)%></td>
		<td class=bwborder nowrap><%= rs.getString(5)%></td>
		<td class=bwborder nowrap><%= rs.getString(6)%></td>
	</tr>
<%
					}
				}
			}
		else
			{
			temp=hOC;
			temp1=hON;
			temp2=cOC;
			temp3=cON;
%>

	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder nowrap><%= rs.getString(1)%></td>
		<td class=bwborder nowrap><%= rs.getString(2)%></td>
		<td class=bwborder nowrap><%= rs.getString(3)%></td>
		<td class=bwborder nowrap><%= rs.getString(4)%></td>
		<td class=bwborder nowrap><%= rs.getString(5)%></td>
		<td class=bwborder nowrap><%= rs.getString(6)%></td>
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
	if(!hcode.equals("0") && ccode.equals("00"))
	{
		//System.out.println("In Head Code...");
	int slno=0; 
	query="select h.head_office_code, c.circle_office_code, c.circle_office_name, d.division_office_code, d.division_office_name from rws_head_office_tbl h, rws_circle_office_tbl c, rws_division_office_tbl d where h.head_office_code = '"+hcode+"' and h.head_office_code=c.head_office_code and h.head_office_code=d.head_office_code and c.circle_office_code=d.circle_office_code";	
%>
</table>
<br><br>
<table width="75%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
		<% if(hcode != null && !hcode.equals("")) { %>
			<td	class=textborder align=center><font color="#000000">Head Office : <%= hname%></td>
		<% } %>		
	</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center>
	<tr>
		<td class=textborder>List of Division Offices</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Circle Office Code</td>
		<td class=textborder>Circle Office Name</td>
		<td class=textborder>Division Office Code</td>
		<td class=textborder>Division Office Name</td>
	</tr>

<%
	try
	{	
		String temp4="";
		String temp5="";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		while (rs.next())
		{
			if(temp4.equals(rs.getString(2)))
			{
				if(temp5.equals(rs.getString(3)))
				{
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
	</tr>
<%
			}
				}
			else
			{
				slno++;
				temp4=rs.getString(2);
				temp5=rs.getString(3);
%>

	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(2)%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
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
	}// END OF IF
	else
	if(!hcode.equals("0") && !ccode.equals("00"))
	{
		//System.out.println("coming here");
		int slno=0; 
	query="select h.head_office_code, c.circle_office_code, c.circle_office_name, d.division_office_code, d.division_office_name from rws_head_office_tbl h, rws_circle_office_tbl c, rws_division_office_tbl d where h.head_office_code = '"+hcode+"' and c.circle_office_code = '"+ccode+"' and h.head_office_code=c.head_office_code and h.head_office_code=d.head_office_code and c.circle_office_code=d.circle_office_code";	
%>
</table>
<br><br>

<table width="75%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse" align=center>
	<tr>
		<% if(hcode != null && !hcode.equals("")) { %>
			<td	class=textborder align=center><font color="#000000">Head Office : <%= hname%></td>
		<% } %>	
		<% if(ccode != null && !ccode.equals("")) { %>
			<td	class=textborder align=center><font color="#000000">Circle Office : <%= cname%></td>
		<% } %>	
	</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center>
	<tr>
		<td class=textborder>List of Division Offices</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>		
		<td class=textborder>Division Office Code</td>
		<td class=textborder>Division Office Name</td>
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
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
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
