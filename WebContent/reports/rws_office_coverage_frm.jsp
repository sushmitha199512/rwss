<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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
window.history.forward(1);
/*function unview()
{
    var a=document.getElementById('circ1').value;
	
	if(a=="-1")
	{
       document.getElementById('circ').disabled=true;
	}
	 
}*/
function fnSubmit()
{
	
		
		if(document.f1.district.selectedIndex=="")
		{
		alert("SELECT CIRCLE...");		
		return false;
		}
}
		function fnCircSubmit()
	{
		//if(document.f1.district.options[document.f1.district.selectedIndex].text == "All")
		//{
			//document.f1.action = "./rws_circle_status_rpt.jsp";
			document.f1.action="./rws_off.jsp";
			document.f1.submit();
		//}
		//else
		//{
		//document.f1.action="./rws_cir_div_status_rpt.jsp";
		//document.f1.submit();
		//}
	
}
function fnDivSubmit()
{
	document.f1.action="./rws_cir_div_status_rpt.jsp";
	document.f1.submit();
	
}
function fnSubDivSubmit()
{
	document.f1.action="./rws_cir_div_subdiv_status_rpt.jsp";
	document.f1.submit();
	
}
function fnManSubmit()
{
	document.f1.action="./rws_subdiv_mandal_coverage_rpt.jsp";
	document.f1.submit();
	
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

<form name=f1 method="post" action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Office Wise Coverage Status Report</font>
			</td>	
		</tr>
<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String aType = null;
	String aCode = null;
	aType = request.getParameter("assetType");
	rDist = request.getParameter("district");
	rMand = request.getParameter("mandal");
	rPanch = request.getParameter("panchayat");

%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		
<%
	try
{
	if(rDist == null || rDist.equals("-1"))
	{
		System.out.println("IN DISTRICT STARTING...");

%>

	<tr>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDist);
				
	}
		
	
	else
		if(rDist != null || rDist.equals("00"))
		{
		System.out.println("IN DISTRICT ALL...");
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("districtCode",null);
                session.setAttribute("dName",rDist);
				//session.setAttribute("dName",distName);
				session.setAttribute("mName",mandalName);
				session.setAttribute("pName",panchName);
                 
		
		} 
		else 
			if(!rDist.equals("-1"))  
			{
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="district" id="circ1" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">ALL</option>
<%
					session.setAttribute("districtCode", rDist);
			}
				stmt = conn.createStatement();
				
				String query = "SELECT distinct c.circle_office_code,c.circle_office_name from rws_circle_office_tbl c,  rws_habitation_directory_tbl  am  where c.CIRCLE_OFFICE_CODE=am.CIRCLE_office_code order by c.circle_office_code,circle_OFFICE_NAME";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDist);
						session.setAttribute("dName",rs.getString(2));
					   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDist);
						}
				}			
					rs.close();			
					stmt.close();
}
catch(Exception e)
{
	System.out.println("THE ERROR IN DISTRICT... " +e);
}
%>
			</select>
		</td>
	</tr>

<%
try
{
	
		if(rDist == null || rDist.equals("-1") || rDist.equals("00"))
		{	
			System.out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", rMand);
		}
		else
			if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
			{
				System.out.println("IN MANDAL ALL...");
%>			
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
	
<%
				if(rMand != null && rMand.equals("00"))
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
					String query = "SELECT distinct d.division_office_code,d.division_OFFICE_NAME FROM RWS_division_OFFICE_TBL d,  rws_habitation_directory_tbl  am  where d.CIRCLE_OFFICE_CODE=am.CIRCLE_office_code and am.division_office_code=d.division_office_code and d.CIRCLE_OFFICE_CODE="+rDist+" order by division_OFFICE_NAME ";

					rs1 = stmt1.executeQuery(query);
					while(rs1.next())
					{
						if(rMand != null && rMand.equals(rs1.getString(1)))
						{
%>
				<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
						session.setAttribute("mName",rs1.getString(2));
						session.setAttribute("mandalCode",rMand);
						}
						else
						{
%>
					<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
						}
					}
					session.setAttribute("mandalCode",rMand);
					rs1.close();
					stmt1.close();
			}			
								
}
catch(Exception e)
{
	System.out.println("The ERROR IN MANDAL..." + e);
}

%>
			</select>
		</td>
	</tr>
	<tr>
<%
try
{
		
	
		if(rDist == null || rDist.equals("-1") || rMand == null || rMand.equals("-1") || rMand.equals("00"))
		{
		System.out.println("IN PANCHAYAT STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("panchayatName",null);
				session.setAttribute("panchayatCode",null);
		}
		else
			if(rDist != null || !rDist.equals("-1") || rMand != null)
			{
			System.out.println("IN PANCHAYAT ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rPanch != null && rPanch.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("panchayatName", null);
					session.setAttribute("panchayatCode", rPanch);		
				}
				else
				{					
%>
				<option value="00">ALL</option>
<%
				}
				stmt2 = conn.createStatement();
				String query = "SELECT distinct sd.subdivision_office_code,sd.subdivision_OFFICE_NAME FROM RWS_subdivision_OFFICE_TBL sd, rws_habitation_directory_tbl  am where sd.CIRCLE_OFFICE_CODE=am.CIRCLE_OFFICE_CODE and am.division_office_code=sd.division_office_code and am.subdivision_office_code=sd.subdivision_office_code  and  sd.division_office_code='"+rMand+"' and sd.circle_office_code='"+rDist+"' order by sd.subdivision_OFFICE_NAME";
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(rPanch != null && rPanch.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("pName", rs2.getString(2));
					session.setAttribute("panchayatCode", rs2.getString(1));
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("panchayatCode",rPanch);
					}
				}
				rs2.close();
				stmt2.close();
			}
			
}
catch(Exception e)
{
	System.out.println("THE ERROR IN PANCHAYAT... " +e);
}
%>
			</select>
		</td>
	</tr>
	</table>
</TD>
<%
	
// System.out.println(distName);
// System.out.println(mandalName);
// System.out.println(panchName);

	%>		
<INPUT TYPE="hidden" name="dName" value="<%=distName%>">
<INPUT TYPE="hidden" name="mName" value="<%=mandalName%>">
<INPUT TYPE="hidden" name="pName" value="<%=panchName%>">

<TR>
<TD colspan=2 align=center valign=top>
	<% /*if(rDist!=null && rDist.equals("00")) {*/
if(rDist!=null && !rDist.equals("-1") && rDist.equals("00"))
	{
%>

	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button id="circ" onclick="fnCircSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
<%} /*else if(rDist!=null && !rDist.equals("00") && rMand!=null && (rMand.equals("-1") || rMand.equals("00") ) )*/
else if(rDist!=null && !rDist.equals("-1") && !rDist.equals("00") && (rMand.equals("-1") || rMand.equals("00")))
{%>

	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button  id="circ" onclick="fnDivSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
<%} /*else if(rDist!=null && !rDist.equals("00") && rMand!=null && !rMand.equals("00") && rPanch!=null && (rPanch.equals("-1") || rPanch.equals("00") ))*/
else if(rDist!=null && !rDist.equals("-1") && !rDist.equals("00") && rMand!=null && !rMand.equals("00") && (rPanch.equals("-1") || rPanch.equals("00")))
{%>

	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button id="circ" onclick="fnSubDivSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>

 <%} /*else if(rDist!=null && !rDist.equals("0") && !rDist.equals("51") && rMand!=null && !rMand.equals("5200") && !rPanch.equals("0") && !rPanch.equals("5300"))*/
 else if(rDist!=null && !rDist.equals("-1") && !rDist.equals("00") && rMand!=null && !rMand.equals("00") && !rPanch.equals("-1") && !rPanch.equals("00"))
 { %>
	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = 	center>
		<tr>
			<td colspan=2 align=center>
				<input type=button id="circ" onclick="fnManSubmit()" value="View Report" class = btext>
			</td>
		</tr>
	</table>
<% } 
 else{ %>
	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = 	center>
		<tr>
			<td colspan=2 align=center>
				<input type=button id="circ" onclick="fnSubmit()" value="View Report" class = btext>
			</td>
		</tr>
	</table>
<% } 
 conn.close(); 
 } catch(Exception e){ e.printStackTrace();}
 
 %>
</TD>
</TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>

