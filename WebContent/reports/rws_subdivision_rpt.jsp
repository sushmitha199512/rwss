
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>

<%
	String hcode=request.getParameter("head");
	String hname=request.getParameter("hname");
	String ccode=request.getParameter("circle");
	String cname=request.getParameter("cname");
	String dcode=request.getParameter("division");
	String dname=request.getParameter("dname");

	
	//System.out.println("Head Office Name : "+hname);
	//System.out.println("Head Office Code : "+hcode);
	//System.out.println("Circle Office Name : "+cname);
	//System.out.println("Circle Office Code : "+ccode);
	//System.out.println("Division Office Name : "+dname);
	//System.out.println("Division Office Code : "+dcode);
%>

<table align=center width=75%>
<caption align="right">
<table width="20%" border=0 rules=none style="border-collapse:collapse" align = right>
	<tr>
		<td colspan=8 align=right><a href="./rws_offices_frm.jsp">Back |</a></td>
		<td colspan=8 align=right><a href="../home.jsp">Home |</a></td>
		<!-- <td colspan=8 align=right><a href="../home.jsp">Excel |</a></td> -->
		<td colspan=8 align=right><a href="./rws_subdivision_prnt_rpt.jsp?head=<%=hcode%>&hname=<%=hname%>&circle=<%=ccode%>&cname=<%=cname%>&division=<%=dcode%>&dname=<%=dname%>" target="_new">Print</a></td>		
	</tr>
</table>
</caption>
<br>
<tr>
<td>
<%
	if(hcode.equals("0"))
	{
		//System.out.println("Main for Sub Division...");
	int slno=0; 
	query="select h.head_office_code, h.head_office_name, c.circle_office_code, c.circle_office_name, d.division_office_code, d.division_office_name, sd.subdivision_office_code, sd.subdivision_office_name from rws_head_office_tbl h, rws_circle_office_tbl c, rws_division_office_tbl d, rws_subdivision_office_tbl sd where h.head_office_code=c.head_office_code and h.head_office_code=d.head_office_code and h.head_office_code=sd.head_office_code and c.circle_office_code=d.circle_office_code and c.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code order by h.head_office_code, c.circle_office_code, d.division_office_code, sd.subdivision_office_code";	
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="lavander">
		<td class=textborder><font color="#ffffff">List of Sub Division Offices</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr align=center bgcolor="#ffffff">
		<td class=clrborder>SL.No</td>
		<td class=clrborder>Head Office Code</td>
		<td class=clrborder>Head Office Name</td>
		<td class=clrborder>Circle Office Code</td>
		<td class=clrborder>Circle Office Name</td>
		<td class=clrborder>Division Office Code</td>
		<td class=clrborder>Division Office Name</td>
		<td class=clrborder>Sub Division Office Code</td>
		<td class=clrborder>Sub Division Office Name</td>
	</tr>

<%
	try
	{	
		String temp="";
		String temp1="";
		String temp2="";
		String temp3="";
		String temp4="";
		String temp5="";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		while (rs.next())
		{
			
			String hOC=rs.getString(1);
			String hON=rs.getString(2);
			String cOC=rs.getString(3);
			String cON=rs.getString(4);
			String dOC=rs.getString(5);
			String dON=rs.getString(6);
			String sdOC=rs.getString(7);
			String sdON=rs.getString(8);
			if(temp.equals(hOC))
			{
				if(temp1.equals(hON))
				{
					if(temp2.equals(cOC))
					{
						if(temp3.equals(cON))
						{
							if(temp4.equals(dOC))
							{
								if(temp5.equals(dON))
								{
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder nowrap></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
	</tr>
<%
								}
							}
						else
							{
							temp4=dOC;
							temp5=dON;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder nowrap><%= rs.getString(6)%></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
	</tr>
<%
							}
						}
					}
				else
					{
					temp2=cOC;
					temp3=cON;
					temp4=dOC;
					temp5=dON;
					slno++;

%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder nowrap><%= rs.getString(6)%></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
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
			temp4=dOC;
			temp5=dON;
			slno++;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%= rs.getString(2)%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder nowrap><%= rs.getString(6)%></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
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
	query="select c.circle_office_code, c.circle_office_name, d.division_office_code, d.division_office_name, sd.subdivision_office_code, sd.subdivision_office_name from rws_head_office_tbl h, rws_circle_office_tbl c, rws_division_office_tbl d, rws_subdivision_office_tbl sd where h.head_office_code='"+hcode+"' and h.head_office_code=c.head_office_code and h.head_office_code=d.head_office_code and h.head_office_code=sd.head_office_code and c.circle_office_code=d.circle_office_code and c.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code order by c.circle_office_code, d.division_office_code, sd.subdivision_office_code";	
%>
<table width="100%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
		<% if(hcode != null && !hcode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">Head Office : <%= hname%></td>
		<% } %>		
	</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="lavander">
		<td class=bwborder><font color="#ffffff"><b>List of Sub Division Offices</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr align=center bgcolor="#ffffff">
		<td class=clrborder>SL.No</td>
		<td class=clrborder>Circle Office Code</td>
		<td class=clrborder>Circle Office Name</td>
		<td class=clrborder>Division Office Code</td>
		<td class=clrborder>Division Office Name</td>
		<td class=clrborder>Sub Division Office Code</td>
		<td class=clrborder>Sub Division Office Name</td>
	</tr>

<%
	try
	{	
		String temp6="";
		String temp7="";
		String temp8="";
		String temp9="";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		while (rs.next())
		{
			
			String cOC=rs.getString(1);
			String cON=rs.getString(2);
			String dOC=rs.getString(3);
			String dON=rs.getString(4);
			String sdOC=rs.getString(5);
			String sdON=rs.getString(6);
			if(temp6.equals(cOC))
			{
				if(temp7.equals(cON))
				{
					if(temp8.equals(dOC))
					{
						if(temp9.equals(dON))
						{
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder nowrap></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder nowrap><%= rs.getString(6)%></td>
	</tr>
<%
						}
					}
				else
					{
					temp8=dOC;
					temp9=dON;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder nowrap><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder nowrap><%= rs.getString(6)%></td>
	</tr>
<%
					}
				}
			}
		else
			{
			temp6=cOC;
			temp7=cON;
			temp8=dOC;
			temp9=dON;
			slno++;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%= rs.getString(2)%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder nowrap><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
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
	}// END OF IF
	else
	if(!hcode.equals("0") && !ccode.equals("00") && dcode.equals("0"))
	{
		//System.out.println("In Head and Circle Code...");
		int slno=0; 
	query="select d.division_office_code, d.division_office_name, sd.subdivision_office_code, sd.subdivision_office_name from rws_head_office_tbl h, rws_circle_office_tbl c, rws_division_office_tbl d, rws_subdivision_office_tbl sd where h.head_office_code='"+hcode+"' and c.circle_office_code='"+ccode+"' and h.head_office_code=c.head_office_code and h.head_office_code=d.head_office_code and h.head_office_code=sd.head_office_code and c.circle_office_code=d.circle_office_code and c.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code order by d.division_office_code, sd.subdivision_office_code";	
%>
<table width="100%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
		<% if(hcode != null && !hcode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">Head Office : <%= hname%></td>
		<% } %>	
		<% if(ccode != null && !ccode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">Circle Office : <%= cname%></td>
		<% } %>	
	</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="lavander">
		<td class=bwborder><font color="#ffffff"><b>List of Sub Division Offices</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr align=center bgcolor="#ffffff">
		<td class=clrborder>SL.No</td>		
		<td class=clrborder>Division Office Code</td>
		<td class=clrborder>Division Office Name</td>
		<td class=clrborder>Sub Division Office Code</td>
		<td class=clrborder>Sub Division Office Name</td>
	</tr>

<%
	try
	{		
		String temp10="";
		String temp11="";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		while (rs.next())
		{
			if(temp10.equals(rs.getString(1)))
			{
				if(temp11.equals(rs.getString(2)))
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
			}
			else
			{
				temp10=rs.getString(1);
				temp11=rs.getString(2);
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
	//System.out.println("The error in rws_circle_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
	}// END OF IF 
	else
	if(!hcode.equals("0") && !ccode.equals("00") && !dcode.equals("0"))
	{
		//System.out.println("In Head and Circle and Division Code...");
		int slno=0; 
	query="select sd.subdivision_office_code, sd.subdivision_office_name from rws_head_office_tbl h, rws_circle_office_tbl c, rws_division_office_tbl d, rws_subdivision_office_tbl sd where h.head_office_code=c.head_office_code and h.head_office_code=d.head_office_code and h.head_office_code=sd.head_office_code and c.circle_office_code=d.circle_office_code and c.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and h.head_office_code='"+hcode+"' and c.circle_office_code='"+ccode+"' and d.division_office_code='"+dcode+"' ";	
%>
<table width="100%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
		<% if(hcode != null && !hcode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">Head Office : <%= hname%></td>
		<% } %>	
		<% if(ccode != null && !ccode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">Circle Office : <%= cname%></td>
		<% } %>
		<% if(dcode != null && !dcode.equals("")) { %>
			<td	class=myfontclr align=center><font color="#000000">Division Office : <%= dname%></td>
		<% } %>
	</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="lavander">
		<td class=bwborder><font color="#ffffff"><b>Sub Division Office Codes</td>
	</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr align=center bgcolor="#ffffff">
		<td class=clrborder>SL.No</td>		
		<td class=clrborder>Sub Division Office Code</td>
		<td class=clrborder>Sub Division Office Name</td>
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
		<td class=bwborder><%=slno%></td>		
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
</td>
</tr>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
