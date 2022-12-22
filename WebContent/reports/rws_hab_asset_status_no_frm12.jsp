<%@		include file="conn.jsp" %>
<%!
	String rDist = null, distName = null, rMand = null, mandName = null, rPanch = null, panchName = null;
	ResultSet rs1=null;
%>

<html>
<head>

<title>Habitation Asset Status No. Details</title>
<script language="JavaScript">
<!--
function fnSubmit()
{
		var d = document.f1.district.selectedIndex;
		
		if(document.f1.district.selectedIndex=="")
		{
		alert("SELECT DISTRICT...");		
		return false;
		}
		
		if (d == 1)
		{
			document.f1.action = "./rws_dist_asset_status_no_rpt.jsp";
			document.f1.submit();
		}
		
		else
		{
		document.f1.action="./rws_hab_asset_status_no_rpt.jsp";
		document.f1.submit();
		}
}
	
//-->
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">
<%@ include file = "header_rpt.jsp" %>
<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Assets in Habitation </font>
			</td>	
		</tr>
		<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		<tr>
			<td class = btext> 
				<font color=navy><b>District</b> </font>
				<font color=red><b>*</b> </font>
			</td>
			<td class = btext>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
<%
		rDist = request.getParameter("district");
		if (rDist == null || !rDist.equals("-1"))
		{
%>	
			<option value="-1">ALL</option>
<%
		}

	
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname from rws_district_tbl d,  RWS_HAB_SUPPLY_STATUS_TBL HS  where d.dCODE = substr(HS.hab_code,1,2) order by dNAME");

	if (rDist != null && rDist.equals("-1"))
	{
		session.setAttribute("dName",null);
		session.setAttribute("dCode",null);	
%>
		<option value="-1" selected>ALL</option>
<%
	}

	while(rs.next())
	{
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>

<% 			distName=rs.getString(2);
			session.setAttribute("dName",distName);

		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%		
		} 
	}	// END OF While
	stmt.close();
	rs.close();
%>
</td>
		</tr>


<%try
			{
		rMand = request.getParameter("mandal");
		rPanch = request.getParameter("panchayat");
	
		if(rDist == null || rDist.equals("-1") || rDist.equals("0"))
		{	
			//System.out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class=rptLabel>Mandal</td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>
<%
				session.setAttribute("mCode", null);
				session.setAttribute("mName", null);
		}
		else
			if(rDist != null && !rDist.equals("-1") && !rDist.equals("0"))
			{
				//System.out.println("IN MANDAL ALL...");
%>			
		<td class=rptLabel>Mandal</td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>				
	
<%
				if(rMand != null && rMand.equals("-1"))
				{
				session.setAttribute("mCode",rMand);
%>
				<option value="-1" SELECTED>ALL</option>
<%
				}
				else
					{
%>
				<option value="-1">ALL</option>
<%
					}
					stmt = conn.createStatement();
					String query1 = "SELECT distinct m.mcode,m.mNAME FROM RWS_mandal_TBL m,  RWS_HAB_SUPPLY_STATUS_TBL HS  where m.dCODE = substr(HS.hab_code,1,2) AND m.mcode = substr(HS.hab_code,6,2) and m.dCODE="+rDist+" order by MNAME";

					rs1 = stmt.executeQuery(query1);
					while(rs1.next())
					{
						if(rMand != null && rMand.equals(rs1.getString(1)))
						{
%>
				<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
						session.setAttribute("mName",rs1.getString(2));
						session.setAttribute("mCode",rMand);
						}
						else
						{
%>
					<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
						}
					}
					
					rs1.close();
					stmt.close();
			}			
				
}
catch(Exception e)
{
	//System.out.println("The ERROR IN MANDAL..." + e);
}

%>
</SELECT></td>
</tr>
		<tr>
			<td nowrap class = btext>
				<font color="navy"><b>Panchayat</b></font>
			</td>
			<td class = btext>
				<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>	
<%
	rPanch = request.getParameter("panchayat");

	if(rMand != null && !rMand.equals("0"))
	{
		stmt = conn.createStatement();
		
		String St2="SELECT distinct p.pcode,p.PNAME FROM RWS_panchayat_TBL p, RWS_HAB_SUPPLY_STATUS_TBL HS  where p.dCODE = substr(HS.hab_code,1,2) AND p.mcode = substr(HS.hab_code,6,2) and p.pcode = substr(HS.hab_code,13,2) and p.dCODE="+rDist+" AND p.mcode ='"+rMand+"' order by p.PNAME";
		rs =stmt.executeQuery(St2);
		while(rs.next())
		{
			if(rPanch != null && rPanch.equals(rs.getString(1))) 
			{
%>
				<option value="<%= rs.getString(1)%>" SELECTed><%= rs.getString(2) %>
<%    
				panchName=rs.getString(2);
				session.setAttribute("pName",panchName);

			}// END OF IF
			else
			{
%>
				<option value="<%= rs.getString(1)%>"><%= rs.getString(2) %>
<%	
			}
		}// END OF FOR
	}// END OF IF
	else
	{
		session.setAttribute("pName",null);

	}

%>
			</td>
		</tr>
		</table>
		</td>

<TR>
<TD colspan=2 align=center valign=top>
	<% if(rDist!=null) {%>

	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
 <%} else{ %>
	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = 	center>
		<tr>
			<td colspan=2 align=center>
				<input type=button onclick="fnSubmit()" value="View Report" class = btext>
			</td>
		</tr>
	</table>
<% } %>
</TD>
</TR>
</TABLE>


</form>
</body>
</html>

