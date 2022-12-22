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
		<td colspan=8 align=right><a href="./rws_office_details_prnt_rpt.jsp" target="_new">Print</a></td>		
	</tr>
</table>
</caption>
<br>
<tr>
<td>
<%
	int slno=0; 
	query="select o.office_code, nvl(o.address1, '&nbsp;'), nvl(o.address2, '&nbsp;'), nvl(o.address3, '&nbsp;'), nvl(o.city, '---'), nvl(o.pincode, '&nbsp;'), nvl(o.phone, '---'),  nvl(o.fax, '--'), nvl(o.email, '---'), decode(o.building, 'O', 'Own', 'R', 'Rented'), o.head_of_office, decode(o.project, 'P', 'Project', 'R', 'Regular'), d.designation_name from rws_office_tbl o, rws_designation_tbl d where o.head_of_office=d.designation_code";	
%>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="lavander">
		<td class=textborder><font color="#ffffff">RWS Office Details</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr align=center bgcolor="#ffffff">
		<td class=clrborder>SL.No</td>
		<td class=clrborder>Office Name</td>	
		<td class=clrborder>Address</td>
		<td class=clrborder nowrap>Phone No</td>
		<td class=clrborder>Fax</td>
		<td class=clrborder nowrap>E-Mail</td>
		<td class=clrborder>Building</td>
		<td class=clrborder>Head Of Office</td>
		<td class=clrborder>Project</td>		
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
</td>
</tr>
</table>
<%@ include file="/commons/rws_footer.jsp"%>