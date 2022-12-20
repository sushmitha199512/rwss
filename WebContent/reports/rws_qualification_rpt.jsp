<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>

<table align=center width=75%>
<caption align="right">
<table width="20%" border=0 rules=none style="border-collapse:collapse" align = right>
	<tr>
		<td colspan=8 align=right><a href="./rws_master_list_frm.jsp">Back |</a></td>
		<td colspan=8 align=right><a href="../home.jsp">Home |</a></td>
		<!-- <td colspan=8 align=right><a href="../home.jsp">Excel |</a></td> -->
		<td colspan=8 align=right><a href="./rws_qualification_prnt_rpt.jsp" target="_new">Print</a></td>		
	</tr>
</table>
</caption>
<br>
<tr>
<td>
<%
	int slno=0; 
	query="SELECT * from rws_qualification_tbl order by qual_code";	
%>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="lavander">
		<td class=textborder><font color="#ffffff">List of Qualification Codes / Names</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr align=center bgcolor="#ffffff">
		<td class=clrborder>SL.No</td>
		<td class=clrborder>Qualification Code</td>		
		<td class=clrborder>Qualification Name</td>		
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
<%@ include file="/commons/rws_footer.jsp"%>