<%@ include file = "conn.jsp" %>
<% try {
	ResultSet r1=null;	
	Statement stmt1 = null,s1=null,s2=null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement st3 = null;
	ResultSet rs3 = null,r2=null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	 ResultSet rs5=null;%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">
<!--
function fnSubmit()
{

	document.f1.action="./rws_new_asset_subcomp_rpt1.jsp";
	document.f1.submit();
	}
	function valSubmit()
	{ 
		alert("Please SELECT Circle");
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
	font-size:8pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
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
				<font color="#FFFFFF">Asset Sub Component Details</font>
			</td>	
		</tr>
<%

	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null,RepName=null,Const=null;
	String panchName=null;
	String repName=null;	
%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		<tr>
			<td class = btext> 
				<font color=navy><b>Circle</b> </font>
			</td>
			<td class = btext>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
				<%
					rDist = request.getParameter("district");
					// //System.out.println("Rdist   "   +rDist);	
					stmt = conn.createStatement();
					//rs =stmt.executeQuery("SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_ASSET_SUBCOMP_PARAM_TBL ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.asset_code=ac.asset_code order by c.circle_office_name");
	
		rs =stmt.executeQuery("SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c,  RWS_ASSET_MAST_TBL  am  where c.CIRCLE_OFFICE_CODE = am.CIRCLE_office_code order by circle_OFFICE_NAME");
					while(rs.next())
					{
						if(rDist != null && rDist.equals(rs.getString(1)) )
						{
				%>
							<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
							<% 			
							 distName=rs.getString(2);
							//session.setAttribute("dName",distName);		
						}// END OF IF
						else 
						{%>	
							<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
						<%		//session.setAttribute("dName",null);		
						} 
					}// END OF While

						%>
			</td>
		</tr>
		<tr>
			<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
			</td>
			<td class = btext>
				  <SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				<%
					rMand = request.getParameter("mandal");
					// //System.out.println("mandal name   "   +rMand);
					if(rDist != null && !rDist.equals("0"))
					{
						stmt1 = conn.createStatement();
						//String st="SELECT distinct d.division_office_code,d.division_OFFICE_NAME FROM RWS_ASSET_SUBCOMP_PARAM_TBL ac, RWS_ASSET_MAST_TBL  a,  RWS_division_OFFICE_TBL d where a.asset_code= ac.asset_code and d.circle_office_code=a.circle_office_code and d.division_office_code= a.division_office_code and a.circle_office_code="+rDist+" order by d.division_OFFICE_NAME";
						String st="SELECT distinct d.division_office_code,d.division_OFFICE_NAME FROM RWS_division_OFFICE_TBL d,  RWS_ASSET_MAST_TBL  am  where d.CIRCLE_OFFICE_CODE=am.CIRCLE_office_code and am.division_office_code=d.division_office_code and d.CIRCLE_OFFICE_CODE="+rDist+" order by division_OFFICE_NAME";

						rs1 =stmt1.executeQuery(st);
						while(rs1.next())
						{
							if(rMand != null && rMand.equals(rs1.getString(1)))
							{
					%>
								<option value="<%= rs1.getString(1)%>" SELECTed><%= rs1.getString(2) %>
								<%
									mandalName=rs1.getString(2);
									//out.println("DDDDDDDDDDDDDDDDDDDD"+mandalName);
									session.setAttribute("mName",mandalName);
							}// END OF IF
							else
							{
								%>
									<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
								<%	
							}
						}// END OF while 
					}// END OF 1 if
								%>
			</td>
		</tr>
		<tr>
			<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font>
			</td>
			<td class = btext>
				<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>	
				<%
					rPanch = request.getParameter("panchayat");
					if(rMand != null && !rMand.equals("0"))
					{
						stmt2 = conn.createStatement();
					String St2="SELECT distinct  d.subdivision_office_code,d.subdivision_OFFICE_NAME FROM  RWS_ASSET_MAST_TBL  a,  RWS_subdivision_OFFICE_TBL d where d.circle_office_code=a.circle_office_code and d.division_office_code= a.division_office_code and d.subdivision_office_code=a.subdivision_office_code and a.circle_office_code='"+rDist+"' and a.division_office_code='"+rMand+"' order by d.subdivision_OFFICE_NAME";
						rs2 =stmt2.executeQuery(St2);
						while(rs2.next())
						{
							if(rPanch != null && rPanch.equals(rs2.getString(1))) 
							{

					%>
						<option value="<%= rs2.getString(1)%>" SELECTed><%= rs2.getString(2) %>
					<%
						panchName=rs2.getString(2);
							}// END OF IF
							else
							{
					%>
								<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
					<%	
							}
					}// END OF WHILE
				}// END OF IF
					%>
			</td>
		</tr>
		<tr>
			<td  colspan="2"  class = btext nowrap >
				<font color=navy><b>Asset Type:</b> </font>
				<INPUT TYPE="radio" NAME="assetType" value="01">PWS
				<INPUT TYPE="radio" NAME="assetType" value="02">MPWS<BR>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<INPUT TYPE="radio" NAME="assetType" value="03">CPWS
				<INPUT TYPE="radio" NAME="assetType" value="04">HANDPUMPS
			</td>
		</tr>
	</table>
</TD>

<%
	String fYear = request.getParameter("finyear");
	// //System.out.println("Finantial year   "   +fYear);
	// //System.out.println(distName);
	// //System.out.println(mandalName);
	// //System.out.println(panchName);
	session.setAttribute("dName",distName);
session.setAttribute("mName",mandalName);
session.setAttribute("pName",panchName);
%>		
	<INPUT TYPE="hidden" name="dName" value="<%=distName%>">
	<INPUT TYPE="hidden" name="mName" value="<%=mandalName%>">
	<INPUT TYPE="hidden" name="pName" value="<%=panchName%>">
	<INPUT TYPE="hidden" name="rptName" value="<%=RepName%>">
	<INPUT TYPE="hidden" name="Cons" value="<%=Const%>">


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
 <%}
	else{ %>
	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = 	center>
		<tr>
			<td colspan=2 align=center>
				<input type=button onclick="valSubmit()" value="View Report" class = btext>
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
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ e.printStackTrace();}
	finally
	{
		conn.close();
	}%>