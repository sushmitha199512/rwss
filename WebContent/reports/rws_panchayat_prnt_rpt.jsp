<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>

<%	
	String dcode = request.getParameter("dist");
	String dname = request.getParameter("dname");
	String mcode = request.getParameter("mand");
	String mname = request.getParameter("mname");
	//System.out.println("dcode ="+dcode);
	//System.out.println("mcode ="+mcode);
%>


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

<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
<%
	if(dcode.equals("0") && mcode.equals("null"))
	{
	int slno=0; 
	query="SELECT distinct d.dcode, d.dname, m.mcode, m.mname, p.pcode, p.pname from RWS_DISTRICT_TBL d, RWS_MANDAL_TBL m, RWS_PANCHAYAT_TBL p WHERE d.dcode=m.dcode and d.dcode=p.dcode and m.mcode=p.mcode ORDER BY d.dcode, m.mcode, p.pcode";	
%>
<br><br>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=7>List of Panchayats</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>District Code</td>
		<td class=textborder>District Name</td>
		<td class=textborder>Mandal Code</td>
		<td class=textborder>Mandal Name</td>
		<td class=textborder>Panchayat Code</td>
		<td class=textborder>Panchayat Name</td>		
	</tr>
<%
	try
	{		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		String temp="";
		String temp1="";
		String distname="";
		String mandname="";
		//System.out.println("Here");
		while (rs.next())
		{ 
		
		String distcode=rs.getString(1);
		String mandcode=rs.getString(3);
		if(temp.equals(distcode))
		{
		if(temp1.equals(mandcode))
		{
		
		
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>		
	</tr>
<%		}
else{
	temp=rs.getString(1);
	temp1=rs.getString(3);
	 distname=rs.getString(2);
	 mandname=rs.getString(4);	 
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%=distname%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%=mandname%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>
	</tr>
<%	
}	}
else{
	temp=rs.getString(1);
	temp1=rs.getString(3);
	 distname=rs.getString(2);
	 mandname=rs.getString(4);
	 slno++;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%=distname%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%=mandname%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>
	</tr>
<%}
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
		if(!dcode.equals("0") && mcode.equals("0"))
		{
		//System.out.println("Coming in Mandal....");
    %>
	</table>
	<br><br>
	<table width="100%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
		<% if(dcode != null && !dcode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">District Name: <%= dname%></td>
		<% } %>		
	</tr>
</table>
<%
int slno=0; 
query="SELECT distinct m.mcode, m.mname, p.pcode, p.pname  from RWS_MANDAL_TBL M, RWS_panchayat_TBL P, rws_district_tbl d where d.dcode = '"+dcode+"' and d.dcode=m.dcode and d.dcode=p.dcode and m.mcode=p.mcode order by m.mcode";	
%>

<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=5>List of Panchayats</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>		
		<td class=textborder>Mandal Code</td>
		<td class=textborder>Mandal Name</td>
		<td class=textborder>Panchayat Code</td>
		<td class=textborder>Panchayat Name</td>		
	</tr>
	<%
	try
	{		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
			
		String temp2="";
		String temp3="";
		while (rs.next())
		{ 
		mcode=rs.getString(1);
		mname=rs.getString(2);
		if(temp2.equals(mcode))
		{
		if(temp3.equals(mname))
			{
	%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>		
	</tr>	
	<%	}
		}
		else
			{
			temp2 = rs.getString(1);
			temp3 = rs.getString(2);
		slno++;
	   %>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%= rs.getString(2)%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>		
	</tr>

<%  }
	}
}catch(Exception e)
	{
	//System.out.println("The error in rws_mandal_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}

 
	}
	else
	if(!dcode.equals("0") && !mcode.equals("0"))
	{
	//System.out.println("Coming in to District and Mandal...");
	//System.out.println("District Code = "+dcode);
	//System.out.println("Mandal Code = "+mcode);
%>
</table>
<br><br>
<table width=75% border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
		<% if(dcode != null && !dcode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">District Name: <%= dname%></td>
		<% } %>
		<% if(mcode != null && !mcode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">Mandal Name: <%= mname%></td>
		<% } %>
	</tr>
</table>
<%
	int slno=0; 
	query="SELECT distinct p.pcode, p.pname  from rws_district_tbl d, rws_mandal_tbl m, RWS_panchayat_TBL p where d.dcode = '"+dcode+"' and m.mcode = '"+mcode+"' and d.dcode=m.dcode and d.dcode=p.dcode and m.mcode=p.mcode order by pcode";	
%>

<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=3>List of Panchayats</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Panchayat Code</td>
		<td class=textborder>Panchayat Name</td>		
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
%>

<%
	 
	}
%>
</table>
</body>
</html>