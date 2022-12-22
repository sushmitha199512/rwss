<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>

<%	
	String dcode = request.getParameter("dist");
	String dname = request.getParameter("dname");
	String mcode = request.getParameter("mand");
	String mname = request.getParameter("mname");
	String pcode = request.getParameter("panch");
	String pname = request.getParameter("pname");
	String vcode = request.getParameter("village");
	String vname = request.getParameter("vname");


	//System.out.println("dcode ="+dcode);
	//System.out.println("mcode ="+mcode);
	//System.out.println("pcode ="+pcode);

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
if(dcode.equals("0") && mcode.equals("null") && pcode.equals("null"))
{
	int slno=0; 
	query="SELECT d.dcode, d.dname, m.mcode, m.mname, p.pcode, p.pname, v.vcode, v.vname from RWS_DISTRICT_TBL D, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_village_TBL V WHERE D.DCODE=M.DCODE AND D.DCODE=P.DCODE AND D.DCODE=V.DCODE AND M.MCODE=P.MCODE AND M.MCODE=V.MCODE AND P.PCODE=V.PCODE ORDER BY D.dcode,M.mcode,P.pcode,V.vcode";	
%>
<br><br>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=9>List of Villages</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>District Code</td>
		<td class=textborder>District Name</td>
		<td class=textborder>Mandal Code</td>
		<td class=textborder>Mandal Name</td>
		<td class=textborder>Panchayat Code</td>
		<td class=textborder>Panchayat Name</td>
		<td class=textborder>Village Code</td>
		<td class=textborder>Village Name</td>
	</tr>
<%
	try
	{		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		String temp="";
		String temp1="";
		String temp2="";
		String temp3="";
		String temp4="";
		String temp5="";
		//System.out.println("In all Districts...");
		while (rs.next())
		{ 
		String distcode=rs.getString(1);
		String distname=rs.getString(2);
		String mandcode=rs.getString(3);
		String mandname=rs.getString(4);
		String panchcode=rs.getString(5);
		String panchname=rs.getString(6);
		slno++;
		
		if(temp.equals(distcode))
			{
			if(temp1.equals(distname))
				{
				if(temp2.equals(mandcode))
					{
					if(temp3.equals(mandname))
						{
						if(temp4.equals(panchcode))
							{
							if(temp5.equals(panchname))
								{
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
	</tr>
<%
								}
							}
						else
							{
							temp4=panchcode;
							temp5=panchname;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
	</tr>
<%
							}
						}
					}
				else
					{
					temp2=mandcode;
					temp3=mandname;
					temp4=panchcode;
					temp5=panchname;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
	</tr>
<%					
					}
				}
			}
			else
			{
			temp=distcode;
			temp1=distname;
			temp2=mandcode;
			temp3=mandname;
			temp4=panchcode;
			temp5=panchname;
%>

	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%= rs.getString(2)%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>
		<td class=bwborder><%= rs.getString(7)%></td>
		<td class=bwborder><%= rs.getString(8)%></td>
	</tr>

<%			}
		}
	}	
	catch(Exception e)
	{
	//System.out.println("The error in rws_village_rpt.jsp is"+e);
	}
	finally
	{
	conn.close();
	}
}// end of main if
else
	if(!dcode.equals("0") && mcode.equals("0") && pcode.equals("null"))
	{
//System.out.println("Coming in to District...");
%>
</table>
<br><br>
<table width="100%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
<% 
	if(dcode != null && !dcode.equals("")) 
	{
%>
	<td	class=myfontclr align=center><font color="#000000">District Name: <%= dname%></td>
<% 
	}
%>		
	</tr>
</table>
<%
int slno=0; 
query="SELECT distinct m.mcode, m.mname, p.pcode, p.pname, v.vcode, v.vname from rws_district_tbl d, rws_mandal_tbl m, rws_panchayat_tbl p, RWS_village_TBL v where d.dcode = '"+dcode+"' and d.dcode=m.dcode and d.dcode=p.dcode and d.dcode=v.dcode and m.mcode=p.mcode and m.mcode=v.mcode and p.pcode=v.pcode order by m.mcode, p.pcode, v.vcode ";	
%>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=7>List of Villages</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>
		<td class=textborder>Mandal Code</td>
		<td class=textborder>Mandal Name</td>
		<td class=textborder>Panchayat Code</td>
		<td class=textborder>Panchayat Name</td>
		<td class=textborder>Village Code</td>
		<td class=textborder>Village Name</td>		
	</tr>
<%
try
{		
	stmt = conn.createStatement();
	rs = stmt.executeQuery(query);
	String temp6="";
	String temp7="";
	String temp8="";
	String temp9="";
		while (rs.next())
		{ 
			String mandcode=rs.getString(1);
			String mandname=rs.getString(2);
			String panchcode=rs.getString(3);
			String panchname=rs.getString(4);
			slno++;
			if(temp6.equals(mandcode))
			{
				if(temp7.equals(mandname))
				{
					if(temp8.equals(panchcode))
					{
						if(temp9.equals(panchname))
						{

%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>
	</tr>
<%
						}
					}
				else
					{
					temp8=panchcode;
					temp9=panchname;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder></td>
		<td class=bwborder></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>
	</tr>
<%
					}
				}
			}
		else
			{
			temp6=mandcode;
			temp7=mandname;
			temp8=panchcode;
			temp9=panchname;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno%></td>
		<td class=bwborder><%= rs.getString(1)%></td>
		<td class=bwborder><%= rs.getString(2)%></td>
		<td class=bwborder><%= rs.getString(3)%></td>
		<td class=bwborder><%= rs.getString(4)%></td>
		<td class=bwborder><%= rs.getString(5)%></td>
		<td class=bwborder><%= rs.getString(6)%></td>
	</tr>

<%
			}
		}
}
catch(Exception e)
{
//System.out.println("The error in rws_village_rpt.jsp is"+e);
}
finally
{
conn.close();
}

}
else
if(!dcode.equals("0") && !mcode.equals("0") && pcode.equals("0"))
{
	//System.out.println("Coming in to District and Mandal...");
%>
</table>
<br><br>
<table width="100%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
<% 
	if(dcode != null && !dcode.equals("")) 
	{
%>
		<td	class=myfontclr align=center><font color="#000000">District Name: <%= dname%></td>
<% 
	}
%>
<% 
	if(mcode != null && !mcode.equals("")) 
	{
%>
		<td	class=myfontclr align=center><font color="#000000">Mandal Name: <%= mname%></td>
<% 
	}
%>
	</tr>
</table>
<%
int slno=0; 
query="SELECT distinct p.pcode, p.pname, v.vcode, v.vname from rws_district_tbl d, rws_mandal_tbl m, rws_panchayat_tbl p, RWS_village_TBL v where d.dcode=m.dcode and d.dcode=p.dcode and d.dcode=v.dcode and m.mcode=p.mcode and m.mcode=v.mcode and p.pcode=v.pcode and d.dcode = '"+dcode+"' and m.mcode = '"+mcode+"' order by p.pcode, v.vcode";	
%>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=5>List of Villages</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>		
		<td class=textborder>Panchayat Code</td>
		<td class=textborder>Panchayat Name</td>
		<td class=textborder>Village Code</td>
		<td class=textborder>Village Name</td>		
	</tr>
<%
try
{		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		String temp10="";
		String temp11="";
		String temp12="";
		String temp13="";
	while (rs.next())
	{
		 String panchcode=rs.getString(1);
		 String panchname=rs.getString(2);
		 slno++;
		 if(temp10.equals(panchcode))
		{
			 if(temp11.equals(panchname))
			{

%>

	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno %></td>		
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
			temp10=panchcode;
			temp11=panchname;
%>
	<tr align=left bgcolor="#ffffff">
		<td class=bwborder><%= slno %></td>		
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
//System.out.println("The error in rws_village_rpt.jsp is"+e);
}
finally
{
conn.close();
}
}
else
if(!dcode.equals("0") && !mcode.equals("0") && !pcode.equals("0"))
{
//System.out.println("Coming in to District, Mandal, Panchayat and Village...");
%>
</table>
<br><br>
<table width="75%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center style="border-collapse:collapse">
	<tr>
<% 
	if(dcode != null && !dcode.equals("")) 
	{
%>
		<td	class=myfontclr align=center><font color="#000000">District Name: <%= dname%></td>
<% 
	}
%>
<% 
	if(mcode != null && !mcode.equals(""))
	{
%>
		<td	class=myfontclr align=center><font color="#000000">Mandal Name: <%= mname%></td>
<% 
	}
%>
<% 
	if(pcode != null && !pcode.equals("")) 
	{ 
%>
		<td	class=myfontclr align=center><font color="#000000">Panchayat Name: <%= pname%></td>
<% 
	}
%>
	</tr>
</table>
<%
int slno=0; 
query="SELECT distinct v.vcode,v.vname from rws_district_tbl d, rws_mandal_tbl m, rws_panchayat_tbl p, RWS_village_TBL v where d.dcode=m.dcode and d.dcode=p.dcode and d.dcode=v.dcode and m.mcode=p.mcode and m.mcode=v.mcode and p.pcode=v.pcode and d.dcode = '"+dcode+"' and m.mcode = '"+mcode+"' and p.pcode = '"+pcode+"' order by v.vcode";	
%>
<table border=1 cellspacing=0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align=center width=75%>
	<tr>
		<td class=textborder colspan=3>List of Villages</td>
	</tr>
	<tr align=center bgcolor="#ffffff">
		<td class=textborder>SL.No</td>			
		<td class=textborder>Village Code</td>
		<td class=textborder>Village Name</td>		
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
//System.out.println("The error in rws_village_rpt.jsp is"+e);
}
finally
{
conn.close();
}
}
%>
</table>
</body>
</html>