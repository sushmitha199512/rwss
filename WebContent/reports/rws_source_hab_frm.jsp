<%@ include file = "conn.jsp" %>

<%		try{
	Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement st3 = null;
	ResultSet rs3 = null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	ResultSet rs5=null;	

%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">
<!--
function fnSubmit()
{

	document.f1.action="./rws_source_hab_rpt.jsp";
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

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="60%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
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
				<font color="#FFFFFF">Source Habitation Details</font>
			</td>	
		</tr>
<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	
%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		<tr>
			<td class = btext> 
				<font color=navy nowrap><b>Source Type Name</b> </font>
			</td>
			<td class = btext>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
<%
	rDist = request.getParameter("district");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt = conn.createStatement();
	rs =stmt.executeQuery("select * from RWS_SOURCE_TYPE_TBL");
	
	while(rs.next())
	{
		
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
			

<% 			 distName=rs.getString(2);

		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%		
		} 
	}// END OF While

%>
</td>
		</tr>
		<tr>
			<td class = btext nowrap>
				<font color="navy" nowrap><b>Sub Source Type Name</b></font>
			</td>
			<td class = btext>
				  <SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
<%
	rMand = request.getParameter("mandal");
	// //System.out.println("mandal code  "   +rMand);
		if(rDist != null && !rDist.equals("0"))
		{
		stmt1 = conn.createStatement();
		/*String st="SELECT division_office_code,division_OFFICE_NAME FROM RWS_division_OFFICE_TBL where CIRCLE_OFFICE_CODE="+rDist+" order by division_OFFICE_NAME";*/
		String st="select * from RWS_SUBSOURCE_TYPE_TBL   where  SOURCE_TYPE_CODE ="+rDist+" order by SUBSOURCE_TYPE_CODE";

		rs1 =stmt1.executeQuery(st);
		while(rs1.next())
		{
			if(rMand != null && rMand.equals(rs1.getString(2)))
			{
%>
		<option value="<%= rs1.getString(2)%>" SELECTed><%= rs1.getString(3) %>
		<% mandalName=rs1.getString(3);
			}// END OF IF
			else
			{
%>
		<option value="<%= rs1.getString(2)%>"><%= rs1.getString(3) %>
		
		
<%	
			}
		}// END OF IF 
		}// END OF While

%>
			</td>
		</tr>
	
	</table>
</TD>

<TD  valign=top height=20% align="center" width="30%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Source Habitation Details</font>
			</td>
			</tr>	
		</table>
<div  style="position:relative;overflow-y:auto;left:0;height:150;width:300;top:0;">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
		<tr><td ><INPUT TYPE="checkbox" NAME="ch" id="ck" value="SOURCE_NAME,Source Name"  ></td><td class = btext>Source Name</td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch" id="ck" value="NO_OF_HABITAITONS_COVERD,No. of Habs Covered"></td> <td class = btext>No. of Habs Covered</td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch" id="ck" value="POPULATION_BENIFITED,Population Benifited"></td> <td class = btext>Population Benifited</td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch" id="ck" value="decode(SEASONAL,'Y','Yes','N','No'),Seasonal"></td><td class = btext>Seasonal  </td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch" id="ck" value="decode(PRESENT_CONDITION,'W','Working','D','Dried','N','Not Working'),Present Condition"></td><td class = btext>Present Condition </td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch" id="ck" value= "WATER_QUALITY,Water Quality"></td><td class = btext>Water Quality</td>
		<tr><td ><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(STATIC_WATER_LEVEL,'0'),Static Water Level"  ></td><td class = btext>Static Water Level</td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch"  id="ck" value="nvl(SUMMER_WATER_LEVEL,'0'),Summer Water Level"  ></td><td class = btext>Summer Water Level </td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch"  id="ck" value="nvl(YIELD,'--'),Yield"  ></td><td class = btext>Yield</td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(DIST_NEAR_PRIVATE_SOURCE,'0'),Dist. Near Private Source"></td> <td class = btext>Dist. Near Private Source  </td>
		<tr><td><INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(LOCATION,'--'),Location"></td> <td class = btext>Location  </td>
	</tr>
	</table>
	</div>
		<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
			<tr>
					<td width="100%" colspan="2" align="center" class = btext nowrap>
					<A HREF="javascript:checkAll('ch','ck')">checkAll Fields</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<A HREF="javascript:clearAll('ch','ck')">clearAll Fields</A>
				</td>
			</tr>	
		</table>
</TD>
<%
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
