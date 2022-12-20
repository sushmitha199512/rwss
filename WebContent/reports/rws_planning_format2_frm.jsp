<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.//out.println("*****FROM BEGINING*****");
	String query, query1, query2, query3, query4 = null;
	ResultSet rs1 = null;
	Statement stmt1 = null;	
%>
<html>
<head>

<script language="JavaScript">
  window.history.forward(1);
	function fnSubmit()
	{
		if(document.f1.district.selectedIndex == "")
		{
			alert("SELECT DISTRICT...");
			return false;
		}
		document.f1.action="./rws_planning_format2_rpt.jsp";
		document.f1.submit();		
	}

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post" action="<%= request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>RWS Planning Format - II</font></td>	
	</tr>
<%
		String rDistrict, rMandal, rPanchayat, rVillage, rHabitation = null;
		rDistrict = request.getParameter("district");
		rMandal = request.getParameter("mandal");		
		//System.//out.println("rDistrict = " +rDistrict);		
		//System.//out.println("rMandal = " +rMandal);
try
{
	if(rDistrict == null || rDistrict.equals("-1"))
	{
		//System.//out.println("IN DISTRICT STARTING...");

%>

	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDistrict);
	}
		
	
	else
		if(rDistrict != null || rDistrict.equals("00"))
		{
			//System.//out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("districtCode",null);
				session.setAttribute("districtName",rDistrict);

		
		} 
		else 
			if(!rDistrict.equals("-1"))  
			{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">ALL</option>
<%
					session.setAttribute("districtCode", rDistrict);
			}
				stmt = conn.createStatement();
				query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE order by d.dname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDistrict != null && rDistrict.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDistrict);
						session.setAttribute("districtName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDistrict);
						}
				}			
					rs.close();			
					stmt.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
			</select>
		</td>
	</tr>
<%
try
{
	
		if(rDistrict == null || rDistrict.equals("-1") || rDistrict.equals("00"))
		{	
			//System.//out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class=rptLabel>Mandal</td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", rMandal);
		}
		else
			if(rDistrict != null && !rDistrict.equals("-1") && !rDistrict.equals("00"))
			{
				//System.//out.println("IN MANDAL ALL...");
%>			
		<td class=rptLabel>Mandal</td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
	
<%
				if(rMandal != null && rMandal.equals("00"))
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
					query1 = "SELECT DISTINCT M.MCODE, M.MNAME FROM RWS_MANDAL_TBL M, RWS_HABITATION_DIRECTORY_TBL HD WHERE M.MCODE = SUBSTR(HD.HAB_CODE,6,2) AND M.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND M.DCODE = '"+rDistrict+"' ORDER BY M.MCODE order by m.mname";

					rs1 = stmt1.executeQuery(query1);
					while(rs1.next())
					{
						if(rMandal != null && rMandal.equals(rs1.getString(1)))
						{
%>
				<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
						session.setAttribute("mandalName",rs1.getString(2));
						session.setAttribute("mandalCode",rMandal);
						}
						else
						{
%>
					<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
						}
					}
					session.setAttribute("mandalCode",rMandal);
					rs1.close();
					stmt1.close();
			}			
				
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>
			</select>
		</td>
	</tr>	
<%	
	if(rDistrict != null)
	{
		//System.//out.println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	}
%>
</table>
<input type="hidden" name="pg" value=0>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>