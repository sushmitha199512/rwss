<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//.out.println("*****FROM BEGINING*****");
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
		
        document.f1.action="./rws_counts.jsp";
		document.f1.submit();		
	}

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>District-Mandal Wise Coverage Planning Report</font></td>	
	</tr>
<%
		String rDistrict= null,rMandal=null;
		rDistrict = request.getParameter("district");
		rMandal = request.getParameter("mandal");
		//.out.println("rDistrict = " +rDistrict);		
		
try
{
	if(rDistrict == null || rDistrict.equals("-1"))
	{
		//.out.println("IN DISTRICT STARTING...");

%>

	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!--<option value="00">All</option>-->
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", null);
	}
		
	else 
			if(!rDistrict.equals("-1"))  
			{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!--<option value="00">ALL</option>-->
<%
					session.setAttribute("districtCode", rDistrict);
			}
				stmt = conn.createStatement();
				query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2)= D.DCODE order by d.dname";
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
%>
			</select>
		</td>
	</tr>
	<%
	
	if(rDistrict == null || rDistrict.equals("-1"))
	{
		//.out.println("IN DISTRICT STARTING...");

%>

	<tr>
		<td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!--<option value="00">All</option>-->
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", null);
	}
		
	else 
			if(!rDistrict.equals("-1"))  
			{
%>
		<td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!--<option value="00">ALL</option>-->
<%
					session.setAttribute("mandalCode", rMandal);
			}
				stmt = conn.createStatement();
				query = "SELECT DISTINCT m.mcode, m.mname FROM RWS_mandal_TBL m, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2)= m.DCODE and SUBSTR(HD.HAB_CODE,6,2)= m.mCODE and SUBSTR(HD.HAB_CODE,1,2)='"+rDistrict+"' order by m.mname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rMandal != null && rMandal.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("mandalCode", rMandal);
						session.setAttribute("mandalName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("mandalCode", rMandal);
						}
				}			
					rs.close();			
					stmt.close();
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
		//.out.println("View Report Enabled...");
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
<input type="hidden" name="pass" value=0>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>