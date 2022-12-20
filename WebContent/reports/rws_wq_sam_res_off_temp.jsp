<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("****************************");
	//System.out.println("CONNECTION OPENED = " + conn);
	Statement stmt1 = null;
	ResultSet rs1 = null;
	String query1 = null;
	Statement stmt2 = null;
	ResultSet rs2 = null;
	String query2 = null;
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

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff">		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_wq_sam_res_off_temp.jsp">Home</td> 
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

	//System.out.println("rCircle = " +rCircle);
	//System.out.println("rDivision = " +rDivision);
	//System.out.println("rSubDivision = " +rSubDivision);

	try
	{
		if(rCircle == null || rCircle.equals("00"))
		{
			//System.out.println("IN CIRCLE OFFICE STARTING...");
%>
	<tr>
		<td class=btext colspan=3 align=left><font color=navy><b>Circle Office</b></font></td>
		<td class=btext colspan=3 align=center>
			<select name="circleOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
				<option value="51">All</option>
<%
		}
		else
			if(rCircle != null || rCircle.equals("51"))
			{
				//System.out.println("CIRCLE OFFICE SELECTION...");
%>
	<tr>
		<td class=btext colspan=3 align=left><font color=navy><b>Circle Office</b></font></td>
		<td class=btext colspan=3 align=center>
			<select name="circleOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
				<option value="51" SELECTED>All</option>
<%
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
		if(rCircle == null || rCircle.equals("00"))
			{
				//System.out.println("IN DIVISION OFFICE STARTING...");
%>
	<tr>
		<td class=btext colspan=3 align=left><font color=navy><b>Division Office</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>
<%
			session.setAttribute("divisionCode", null);
			session.setAttribute("divisionName", rDivision);
			}
			else
			if(rCircle != null && !rCircle.equals("00") && !rCircle.equals("51")) 
			{
				//System.out.println("IN DIVISION OFFICE ALL...");
%>
		<td class=btext colspan=3 align=left><font color=navy><b>Division Office</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>
<%				
					if(rDivision != null && rDivision.equals("55555"))
					{
%>
					<option value="55555" SELECTED>ALL</option>				
<%
					}
					else
					{
%>
					<option value="55555">ALL</option>					
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
						session.setAttribute("divisionName",rs1.getString(2));
						session.setAttribute("divisionCode",rDivision);
						}
						else
						{
%>
						<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
						}
					}
					session.setAttribute("divisionCode",rDivision);
					rs1.close();
					stmt1.close();		
                    
				if(!rCircle.equals("51") && rDivision.equals("55555"))				
				{
%>
		<tr>
			<td class=btext colspan=3 align=left><font color=navy><b>Sub Division Office</b></font></td>
			<td class=btext colspan=3 align=center>
				<SELECT name="subDivisionOffice" style="width:150px" class="mycombo" disabled>
					<option value="00">SELECT...</option></select>
		            
<% 
				}
			
				else
					if(rCircle.equals("51"))
					{
%>
		<tr>
			<td class=btext colspan=3 align=left><font color=navy><b>Division Office</b></font></td>
			<td class=btext colspan=3 align=center>
				<SELECT name="divisionOffice" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
					<option value="0">SELECT...</option></select>
		<tr>
			<td class=btext colspan=3 align=left><font color=navy><b>Sub Division Office</b></font></td>
		    <td class=btext colspan=3 align=center>
				<SELECT name="subDivisionOffice" style="width:150px" class="mycombo" disabled>
					<option value="00">SELECT...</option></select>
<%
					}
			}
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN DIVISION OFFICE..." + e);
	}
%>
			</select>
		</td>
	</tr>
</table>
<%	
	conn.close();	
	//System.out.println("CONNECTION CLOSED = "+conn);
%>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>