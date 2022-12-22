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
		
		if(document.f1.district.selectedIndex == "00")
		{
			alert("SELECT DISTRICT...");
			return false;
		}
		
        document.f1.action="./rws_countable.jsp";
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
		<td align="center" class="rptHeading" colspan=3>District-Habitation-MonthWise-Report</font></td>	
	</tr>
<%
		String rDistrict= null;
		String fromDate=null;
		rDistrict = request.getParameter("district");
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
				<option value="00">All</option>
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDistrict);
	}
		
	
	else
		if(rDistrict != null || rDistrict.equals("00"))
		{
			//.out.println("IN DISTRICT ALL...");
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
					stmt.close();%>
	<tr>

			<td class = btext nowrap>
				<font color=navy><b>Month</b> </font>
				<font color="red">*</font></td>
			</td>
			<td class = btext >
				<SELECT name="FDate"  class="mycombo" style="width:150px"onChange="this.form.submit()">
				<!--<option value="0">SELECT...</option>-->	
			<%
					fromDate = request.getParameter("FDate");
	// //System.out.println("Rdist   "   +rDist);
     stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	
	/*rs1=stmt1.executeQuery("select distinct  to_char(status_date,'dd-MON-yyyy') from rws_habitation_dir_his_tbl where to_char(status_date,'yyyy')< to_char(sysDate,'YYYY')Union select distinct to_char(status_date,'dd-MON-yyyy') from rws_habitation_directory_tbl where to_char(status_date,'yyyy')=to_char(sysDate,'YYYY')"); */
    rs1=stmt1.executeQuery("select distinct substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)  from rws_habitation_directory_tbl hd where update_date is not null");
	
	while(rs1.next()) 
	{
		
		if(fromDate != null && fromDate.equals(rs1.getString(1)) )
		{
%>
		<option value="<%= rs1.getString(1) %>" SELECTed><%= rs1.getString(1) %>
			

<% 			
	 String FDATE=rs1.getString(1);


	session.setAttribute("FDATE",FDATE);		
		}// END OF IF
		else 
		{
%>		<option value="<%= rs1.getString(1) %>" ><%= rs1.getString(1) %>
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
				rs1.beforeFirst(); %>
			</td>
			</TR>
<% }
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