<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
	//System.out.println("****************************");	
	Statement stmt1 = null;
	ResultSet rs1 = null;
	String query1 = null;
	Statement stmt2 = null;
	ResultSet rs2 = null;
	String query2 = null;
	Statement stmt5 = null;
	ResultSet rs5 = null;
	String query3 = null;
	Statement stmt6 = null;
	ResultSet rs6 = null;	
%>

<html>
<head>

<title>WaterSoft</title>
<link rel="stylesheet" type="text/css" href="rwsstyle.css">

<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}

</style>
<script language="JavaScript">
<!--
	function fnSubmit()
	{
		if(document.f1.circleOffice.selectedIndex == "00")
		{
			alert("SELECT Circle Office to VIEW REPORT");
			return false;
		}
		if(document.f1.fromdate.selectedIndex == "00")
		{
			alert("SELECT From Date to VIEW REPORT");
			return false;
		}
		if(document.f1.todate.selectedIndex == "00")
		{
			alert("SELECT To Date to VIEW REPORT");
			return false;
		}
		document.f1.action="./rws_wq_off_rpt.jsp";
		document.f1.submit();		
	}
//-->
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff">		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_wq_off_rpt_frm.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="mystyle" colspan="4"><font color="navy">Water Quality Status Report</font></td>	
	</tr>
<%
	
	String rCircle = null;
	rCircle = request.getParameter("circleOffice");
	String rDivision = null;
	rDivision = request.getParameter("divisionOffice");
	String rSubDivision = null;
	rSubDivision = request.getParameter("subDivisionOffice");
	String fromDate = request.getParameter("fromdate");
	String toDate = request.getParameter("todate");	

	//System.out.println("rCircle = " +rCircle);
	//System.out.println("rDivision = " +rDivision);
	//System.out.println("rSubDivision = " +rSubDivision);

	try
	{
		if(rCircle == null || rCircle.equals("-1"))
		{
			//System.out.println("IN CIRCLE OFFICE STARTING...");
%>
			<tr>
				<td class=btext colspan=3 align=left><font color=navy><b>Circle Office</b></font></td>
				<td class=btext colspan=3 align=center>
					<select name="circleOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
						<option value="-1">SELECT...</option>
						<option value="00">All</option>
	
	
<%
				session.setAttribute("circleCode", null);
				session.setAttribute("circleName", rCircle);
		}
		else
			if(rCircle != null || rCircle.equals("00"))
			{
				//System.out.println("IN CIRCLE OFFICE ALL...");
%>
				<td class=btext align=left colspan=3><font color=navy><b>Circle Office</b></font></td>
				<td class=btext align=center colspan=3>
					<select name="circleOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
						<option value="-1">SELECT...</option>
						<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("circleCode",null);
				session.setAttribute("circleName",rCircle);

		
			} 
			else 
				if(!rCircle.equals("-1"))  
				{
%>
					<td class = btext colspan=3><font color=navy><b>Circle Office</b> </font></td>
					<td class = btext colspan=3>
					<SELECT name="district"  class="mycombo" style="width:150px" onChange="this.form.submit()">
						<option value="-1">SELECT...</option>
						<option value="00">ALL</option>
<%
					session.setAttribute("circleCode", rCircle);
				}
					stmt = conn.createStatement();
					query = "SELECT UNIQUE CIR.CIRCLE_OFFICE_CODE, CIR.CIRCLE_OFFICE_NAME "
						+ " FROM RWS_CIRCLE_OFFICE_TBL CIR, RWS_WATER_SAMPLE_COLLECT_TBL SAM "
						+ " WHERE CIR.CIRCLE_OFFICE_CODE = SAM.CIRCLE_OFFICE_CODE AND "
						+ " HEAD_OFFICE_CODE = '1' ORDER BY CIR.CIRCLE_OFFICE_CODE ";
					rs = stmt.executeQuery(query);
					while(rs.next())
					{
						if(rCircle != null && rCircle.equals(rs.getString(1)))
						{					
%>
							<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rCircle);
						session.setAttribute("circleName", rs.getString(2));
						}
						else
						{					
%>
							<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rCircle);
						}
					}			
					rs.close();			
					stmt.close();
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN CIRCLE OFFICE... " +e);
	}
%>
			</select>
		</td>
	</tr>
	
<%
	try
	{
		if(rCircle == null)
		{
			//System.out.println("DIVISION DISABLED...");
%>
		<td class=btext align=left colspan=3><font color=navy><b>Division Office</b></font></td>
				<td class=btext align=center colspan=3>
					<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
						<option value="-1">SELECT...</option>
<%
		}
	else
		if(rCircle == null || rCircle.equals("-1"))
			{	
				//System.out.println("IN DIVISION OFFICE STARTING...");
%>
		<tr>
			<td class=btext align=left colspan=3><font color=navy><b>Division Office</b></font></td>
			<td class=btext align=center colspan=3>
				<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>
<%
				session.setAttribute("dCode", null);
				session.setAttribute("dName", rDivision);
			}
			else
				if(rCircle != null && !rCircle.equals("-1") && !rCircle.equals("00"))
				{
					//System.out.println("IN DIVISION OFFICE ALL...");
%>			
			<td class=btext align=left colspan=3><font color=navy><b>Division Office</b></font></td>
			<td class=btext align=center colspan=3>
				<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>				
	
<%
					if(rDivision != null && rDivision.equals("00"))
					{
%>
					<option value="00" SELECTED>ALL</option>
<%
					}
					else
					{
%>
					<option value="00">ALL</option>
<%
					}
					stmt1 = conn.createStatement();
					query1 = "SELECT UNIQUE "
							+ " DIV.DIVISION_OFFICE_CODE, DIV.DIVISION_OFFICE_NAME "
							+ " FROM "
							+ " RWS_DIVISION_OFFICE_TBL DIV, RWS_CIRCLE_OFFICE_TBL CIR, "
							+ " RWS_HEAD_OFFICE_TBL HEA, "
							+ " RWS_WATER_SAMPLE_COLLECT_TBL SAM "
							+ " WHERE "
							+ " DIV.DIVISION_OFFICE_CODE = SAM.DIVISION_OFFICE_CODE AND "
							+ " DIV.CIRCLE_OFFICE_CODE = SAM.CIRCLE_OFFICE_CODE AND "
							+ " DIV.CIRCLE_OFFICE_CODE = CIR.CIRCLE_OFFICE_CODE AND "
							+ " HEA.HEAD_OFFICE_CODE = '1' AND "
							+ " CIR.CIRCLE_OFFICE_CODE = "+rCircle+" ";

					rs1 = stmt1.executeQuery(query1);
					while(rs1.next())
					{
						if(rDivision != null && rDivision.equals(rs1.getString(1)))
						{
%>
					<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
						session.setAttribute("dName",rs1.getString(2));
						session.setAttribute("dCode",rDivision);
						}
						else
						{
%>
					<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
						}
					}
					session.setAttribute("dCode",rDivision);
					rs1.close();
					stmt1.close();
				}
				else
					if(rCircle.equals("00"))
					{
%>
				<td class=btext align=left colspan=3><font color=navy><b>Division Office</b></font></td>
				<td class=btext align=center colspan=3>
					<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
						<option value="-1">SELECT...</option>		
<%
					}
				
	}
	catch(Exception e)
	{
		//System.out.println("The ERROR IN DIVISION..." + e);
	}

%>
				</select>
			</td>
		</tr>
		<tr>
<%
	try
	{
		
		if(rDivision == null || rCircle.equals("00") || rDivision.equals("00") || rDivision.equals("-1"))
		{
			//System.out.println("SUB DIVISION DISABLED...");
%>
			<td class=btext align=left colspan=3><font color=navy><b>Sub Division Office</b></font></td>
			<td class=btext align=center colspan=3>
				<SELECT name="subDivisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
					<option value="-1">SELECT...</option>
<%
		}
	else
		if(rCircle == null || rCircle.equals("-1") || rDivision == null || rDivision.equals("-1"))
		{
			//System.out.println("IN SUB DIVISION OFFICE STARTING...");
%>
			<td class = btext nowrap colspan=3><font color="navy"><b>Sub Division Office</b></font></td>
			<td class = btext colspan=3>
				<SELECT name="subDivisionOffice" style="width:150px" class="mycombo" onchange="this.form.submit()" >
					<option value="-1">SELECT...</option>
<%
				session.setAttribute("sDName",null);
				session.setAttribute("sDCode",null);
		}
		else
			if(rCircle != null || !rCircle.equals("-1") || rDivision != null)
			{
				//System.out.println("IN SUB DIVISION OFFICE ALL...");
%>
			<td class=btext align=left colspan=3><font color=navy><b>Sub Division Office</b></font></td>
			<td class=btext align=center colspan=3>

				<SELECT name="subDivisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>
<%
				if(rSubDivision != null && rSubDivision.equals("00"))
				{					
%>
					<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("sDName", null);
					session.setAttribute("sDCode", rSubDivision);		
				}
				else
				{					
%>
					<option value="00">ALL</option>
<%
				}
				stmt2 = conn.createStatement();
				query2 = "SELECT  UNIQUE "
						+ " SUB.SUBDIVISION_OFFICE_CODE, SUB.SUBDIVISION_OFFICE_NAME "
						+ " FROM "
						+ " RWS_SUBDIVISION_OFFICE_TBL SUB, RWS_DIVISION_OFFICE_TBL DIV, " 
						+ " RWS_CIRCLE_OFFICE_TBL CIR, "
						+ " RWS_HEAD_OFFICE_TBL HEA, RWS_WATER_SAMPLE_COLLECT_TBL SAM  "
						+ " WHERE "
						+ " SUB.SUBDIVISION_OFFICE_CODE = SAM.SUBDIVISION_OFFICE_CODE AND "
						+ " SUB.DIVISION_OFFICE_CODE = SAM.DIVISION_OFFICE_CODE AND "
						+ " SUB.CIRCLE_OFFICE_CODE = SAM.CIRCLE_OFFICE_CODE AND "
						+ " SUB.DIVISION_OFFICE_CODE = DIV.DIVISION_OFFICE_CODE AND "
						+ " SUB.CIRCLE_OFFICE_CODE = CIR.CIRCLE_OFFICE_CODE AND "
						+ " SUB.HEAD_OFFICE_CODE = HEA.HEAD_OFFICE_CODE AND "
						+ " DIV.DIVISION_OFFICE_CODE = SAM.DIVISION_OFFICE_CODE AND "
						+ " DIV.CIRCLE_OFFICE_CODE = CIR.CIRCLE_OFFICE_CODE AND "
						+ " CIR.CIRCLE_OFFICE_CODE = SAM.CIRCLE_OFFICE_CODE AND "
						+ " HEA.HEAD_OFFICE_CODE = '1' AND "
						+ " CIR.CIRCLE_OFFICE_CODE = "+rCircle+" AND "
						+ " DIV.DIVISION_OFFICE_CODE = "+rDivision+" " ;
				rs2 = stmt2.executeQuery(query2);		
				while(rs2.next())
				{					
					if(rSubDivision != null && rSubDivision.equals(rs2.getString(1)))
					{
%>
					<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sDName", rs.getString(2));
					session.setAttribute("sDCode", rs.getString(1));
					}
					else
					{
%>
					<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					}
				}
			}
%>
			

<%		
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN SUB DIVISION OFFICE... " +e);
	}
%>
				</select>
			</td>
		</tr>
		<tr bgcolor="#8A9FCD" align= center>
		<td class=btext colspan = 4><font color=navy><b>Select Dates</b></font></td>		
	</tr>
	<tr>
		<td class=btext><font color=navy><b>From</b> </font></td>
		<td class=btext>
			<SELECT name="fromdate" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
<%		
		stmt5 = conn.createStatement();
		
		String st4="select UNIQUE to_char(SAMP_COLLECT_DATE, 'dd/MM/yyyy') as samp_date from RWS_WATER_SAMPLE_COLLECT_TBL ";
		rs5 =stmt5.executeQuery(st4);
		
		while(rs5.next())
		{			
		if(fromDate != null && fromDate.equals(rs5.getString(1)))
			{
%>
			<option value="<%=rs5.getString(1)%>" SELECTED><%=rs5.getString(1)%></option>
<%
			}
			else
			{
%>
			<option value="<%=rs5.getString(1)%>"><%=rs5.getString(1)%></option>
<%
			}
		}
%>
			</select>
		</td>	
		<td class=btext><font color=navy><b>To</b></font></td>
		<td class=btext>
			<SELECT name="todate" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>

<%	
	if(fromDate != null && !fromDate.equals("00"))
	{		
		try
		{			
		stmt6 = conn.createStatement();		
		query3="select UNIQUE to_char(SAMP_COLLECT_DATE, 'dd/MM/yyyy') from RWS_WATER_SAMPLE_COLLECT_TBL where SAMP_COLLECT_DATE >= to_date('"+fromDate+"', 'dd/MM/yyyy')";	
		
		rs6 = stmt6.executeQuery(query3);
			while(rs6.next())
			{		
				if(toDate != null && toDate.equals(rs6.getString(1)))
				{
%>
				<option value="<%=rs6.getString(1)%>" SELECTED><%=rs6.getString(1)%></option>
<%
				}
				else
				{
%>
				<option value="<%=rs6.getString(1)%>"><%=rs6.getString(1)%></option>
<%		

				}
			}		
		}	
		catch(Exception e)
		{
			//System.out.println("THE ERROR IN TODATE " +e);
		}	
	}
%>
			</select>
		</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=4 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
<%	
	conn.close();	
%>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>