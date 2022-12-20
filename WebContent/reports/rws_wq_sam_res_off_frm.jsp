<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
	Statement stmt1 = null;
	ResultSet rs1 = null;
	String query1 = null;
	Statement stmt2 = null;
	ResultSet rs2 = null;
	String query2 = null;
	Statement stmt3 = null;
	ResultSet rs3 = null;
	Statement stmt4 = null;
	ResultSet rs4 = null;	
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
		document.f1.action="./rws_wq_sam_res_off_rpt.jsp";
		document.f1.submit();		
	}
//-->
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

<table border=1 align=center cellspacing=0 cellpadding=0 rules="rows" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_wq_sam_res_off_frm.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="mystyle" colspan="4"><font color="navy">Water Quality Status Report</font></td>	
	</tr>
<%
	//System.out.println("********************************");
	//System.out.println("URL for this FORM = " + request.getRequestURI());	
	String rCircle = null;
	String circleName = null;
	rCircle = request.getParameter("circleOffice");
	//System.out.println("CIRCLE OFFICE... " + rCircle);
	String rDivision = null;
	String divisionName = null;
	rDivision = request.getParameter("divisionOffice");
	//System.out.println("DIVISION OFFICE..." + rDivision);
	String rSubDivision = null;
	String subDivisionName = null;
	rSubDivision = request.getParameter("subDivisionOffice");
	//System.out.println("SUB DIVISION OFFICE..." + rSubDivision);
	String fromDate = request.getParameter("fromdate");
	String toDate = request.getParameter("todate");	
	try
	{
			if(rCircle == null || rCircle.equals("-1"))
			{			
%>
	
	<tr>
		<td class=btext colspan=3 align=left><font color=navy><b>Circle Office</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="circleOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>

<%
			session.setAttribute("cName", null);
			session.setAttribute("cCode", rCircle);
			}
			else
				if(rCircle != null || rCircle.equals("00"))
				{				
%>
		<td class=btext colspan=3 align=left><font color=navy><b>Circle Office</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="circleOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<%
				session.setAttribute("cCode", rCircle);				
				}stmt = conn.createStatement();
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
					session.setAttribute("cCode", rCircle);
					session.setAttribute("cName", rs.getString(2));
					}
					else
					{
%>
					<option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option>
<%
					session.setAttribute("cCode", rCircle);
					}
				}
				rs.close();
				stmt.close();
	}
	catch(Exception e)
	{
		//System.out.println("The Error in CIRCLE SELECTION..." + e);
	}
%>
			</select>
		</td>
	</tr>
<%
	try
	{
			if(rCircle == null || rCircle.equals("-1"))
			{				
%>
		<tr>
			<td class=btext colspan=3 align=left><font color=navy><b>Division Office</b></font></td>
			<td class=btext colspan=3 align=center>
				<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>
<%
				session.setAttribute("dCode", null);
				session.setAttribute("dName", rDivision);
			}
			else
				if(rCircle != null && !rCircle.equals("-1") && !rCircle.equals("00"))
				{
%>			
			<td class=btext colspan=3 align=left><font color=navy><b>Division Office</b></font></td>
			<td class=btext colspan=3 align=center>
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
							+ " RWS_DIVISION_OFFICE_TBL DIV, RWS_CIRCLE_OFFICE_TBL CIR, RWS_HEAD_OFFICE_TBL HEA, "
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
				<td class=btext colspan=3 align=left><font color=navy><b>Division Office</b></font></td>
				<td class=btext colspan=3 align=center>
					<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
						<option value="-1">SELECT...</option>
<%
					}
				
	}
	catch(Exception e)
	{
		//System.out.println("The Error in DIVISION SELECTION..." + e);
	}

%>
				</select>
			</td>
		</tr>
<%
	try
	{	
		if(rCircle == null || !rCircle.equals("-1") || !rCircle.equals("00") || rDivision == null || !rDivision.equals("-1") || !rDivision.equals("00"))
		{
			//System.out.println("HERE");

%>
	<tr>
			<td class=btext colspan=3 align=left><font color=navy><b>Sub Division Office</b></font></td>
			<td class=btext colspan=3 align=center>
				<SELECT name="subDivisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>

<%
		}
		else
			if(rCircle == null || rDivision == null)
			{
				//System.out.println("NOT HERE");
%>
		<tr>
			<td class=btext colspan=3 align=left><font color=navy><b>Sub Division Office</b></font></td>
			<td class=btext colspan=3 align=center>
				<SELECT name="subDivisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>
<%
				session.setAttribute("sDName",null);
				session.setAttribute("sDCode",null);				
		}
		else
			if(rCircle != null || rCircle.equals("-1") || rDivision != null)
			{				
%>
			<td class=btext colspan=3 align=left><font color=navy><b>Sub Division Office</b></font></td>
			<td class=btext colspan=3 align=center>

				<SELECT name="subDivisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
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
						+ " RWS_SUBDIVISION_OFFICE_TBL SUB, RWS_DIVISION_OFFICE_TBL DIV, RWS_CIRCLE_OFFICE_TBL CIR, "
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
				rs2.close();
				stmt2.close();
			}		
			
	}
	catch(Exception e)
	{
		//System.out.println("The Error in SUB DIVISION SELECTION..." + e);
	}
%>
				</select>
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