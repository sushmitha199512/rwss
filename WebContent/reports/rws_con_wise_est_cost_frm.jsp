<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("*****FROM BEGINING*****");		
%>
<html>
<head>
<script language="JavaScript">
//<!--
	function fnSubmit()
	{
		if(document.f1.contituency.selectedIndex == "00")
		{
			alert("SELECT Constituency To View The Report...");
			return false;
		}
		document.f1.action="./rws_con_wise_est_cost_rpt.jsp";
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
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Constituency - Scheme - Year Wise Estimate Cost Details</font></td>	
	</tr>

<%
		String rConstituency, rScheme, rYear = null;
		rConstituency = request.getParameter("contituency");
		rScheme = request.getParameter("scheme");
		rYear = request.getParameter("year");		
		//System.out.println("rConstituency = " +rConstituency);		
		//System.out.println("rScheme = " +rScheme);		
		//System.out.println("rYear = " +rYear);
		String query=null;
	
	try
	{
		if(rConstituency == null || rConstituency.equals("-1"))
		{
			//System.out.println("IN CONTITUENCY STARTING...");
%>	
	<tr>
		<td class=rptLabel>Constituency</td>
		<td class=btext>
			<select name="contituency" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("contituencyCode",null);
				session.setAttribute("contituencyName",rConstituency);
		}
		else
			if(rConstituency != null || rConstituency.equals("00"))
			{
				//System.out.println("IN CONTITUENCY ALL...");
%>
		<td class=rptLabel>Constituency</td>
		<td class=btext>
			<select name="contituency" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("contituencyCode",null);
				session.setAttribute("contituencyName",rConstituency);	
			} 
			else 
				if(!rConstituency.equals("-1"))  
				{
%>
		<td class=rptLabel>Constituency</td>
		<td class=btext>
			<SELECT name="contituency"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("contituencyCode",rConstituency);
				}
					stmt = conn.createStatement();
					query = "SELECT UNIQUE CON.CONSTITUENCY_CODE, CON.CONSTITUENCY_NAME from RWS_REP_PROPOSAL_TBL REP, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE";
					rs = stmt.executeQuery(query);
					while(rs.next())
					{
						if(rConstituency != null && rConstituency.equals(rs.getString(1)))
						{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%>--<%=rs.getString(1)%></option>
<%
						session.setAttribute("contituencyCode", rConstituency);
						session.setAttribute("contituencyName", rs.getString(2));
						}
						else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%>--<%=rs.getString(1)%></option>
<%
						session.setAttribute("contituencyCode", rConstituency);
						}
					}			
					rs.close();			
					stmt.close();
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN CONSTITUECY... " +e);
	}
%>
			</select>
		</td>
	</tr>
<%
	try
		{
			if(rScheme == null || rScheme.equals("-1"))
			{
				//System.out.println("IN SCHEME STARTING...");
%>	
	<tr>
		<td class=rptLabel>Scheme</td>
		<td class=btext>
			<select name="scheme" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("schemeCode",null);
				session.setAttribute("schemeName",rScheme);
			}
			else
				if(rScheme != null || rScheme.equals("00"))
				{
					//System.out.println("IN SCHEME ALL...");
%>
		<td class=rptLabel>Scheme</td>
		<td class=btext>
			<select name="scheme" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("schemeCode",null);
				session.setAttribute("schemeName",rScheme);	
				} 
				else 
					if(!rScheme.equals("-1"))  
					{
%>
		<td class=rptLabel>Scheme</td>
		<td class=btext>
			<SELECT name="scheme"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("schemeCode",rScheme);
					}
					stmt = conn.createStatement();
					query = "SELECT UNIQUE AST.TYPE_OF_ASSET_CODE, AST.TYPE_OF_ASSET_NAME FROM RWS_ASSET_TYPE_TBL AST, RWS_REP_PROPOSAL_TBL REP WHERE REP.TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE ORDER BY AST.TYPE_OF_ASSET_CODE";
					rs = stmt.executeQuery(query);
						while(rs.next())
						{
							if(rScheme != null && rScheme.equals(rs.getString(1)))
							{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%>--<%=rs.getString(1)%></option>
<%
						session.setAttribute("schemeCode", rScheme);
						session.setAttribute("schemeName", rs.getString(2));
							}
							else
							{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%>--<%=rs.getString(1)%></option>
<%
						session.setAttribute("schemeCode", rConstituency);
							}
						}			
					rs.close();			
					stmt.close();
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN SCHEME... " +e);
	}
%>
			</select>
		</td>
	</tr>

<%
	try
		{
			if(rYear == null || rYear.equals("-1"))
			{
				//System.out.println("IN YEAR STARTING...");
%>	
	<tr>
		<td class=rptLabel>Year</td>
		<td class=btext>
			<select name="year" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%				
				session.setAttribute("year",rYear);
			}
			else
				if(rScheme != null || rScheme.equals("00"))
				{
					//System.out.println("IN YEAR ALL...");
%>
		<td class=rptLabel>Year</td>
		<td class=btext>
			<select name="year" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 				
				session.setAttribute("year",rYear);	
				} 
				else 
					if(!rYear.equals("-1"))  
					{
%>
		<td class=rptLabel>Year</td>
		<td class=btext>
			<SELECT name="year"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("year",rYear);
					}
					stmt = conn.createStatement();
					query = "SELECT UNIQUE SUBSTR(TO_CHAR(REP_DATE, 'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL";
					rs = stmt.executeQuery(query);
						while(rs.next())
						{
							if(rYear != null && rYear.equals(rs.getString(1)))
							{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(1)%></option>
<%						
						session.setAttribute("year", rs.getString(1));
							}
							else
							{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(1)%></option>
<%
						session.setAttribute("year", rYear);
							}
						}			
					rs.close();			
					stmt.close();
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN YEAR... " +e);
	}
%>
			</select>
		</td>
	</tr>
	
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=8 align=center>
			<input type=button onclick="fnSubmit()" class=btext value="View Report">
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