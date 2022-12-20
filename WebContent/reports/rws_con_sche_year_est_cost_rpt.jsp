<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("*****REPORT BEGINING*****");
	String rConstituency, rScheme, rYear, rProposalId = null;
	rConstituency = request.getParameter("constituency");
	rScheme = request.getParameter("scheme");
	rYear = request.getParameter("year");
	rProposalId = request.getParameter("proposalId");
	//System.out.println("rConstituency = " +rConstituency);		
	//System.out.println("rScheme = " +rScheme);		
	//System.out.println("rYear = " +rYear);
	//System.out.println("rProposalId = " +rProposalId);
	String query=null;
	int slno=0;	
%>

<html>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:window.history.back()">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
				<!-- <td class="bwborder"><a href="./rws_con_wise_est_cost_prnt_rpt.jsp?rConstituency=<%=rConstituency%>&rScheme=<%=rScheme%>&rYear=<%=rYear%>" target="_new">Print |</a></td>
				<td class="bwborder"><a href="./rws_con_wise_est_cost_xls_rpt.jsp?type=excel&rConstituency=<%=rConstituency%>&rScheme=<%=rScheme%>&rYear=<%=rYear%>" target="_new">Excel</a></td> -->			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=5>Constituency - Scheme - Year Wise Estimate Cost Details</font></td>	
	</tr>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>Prposal Id</td>		
		<td class=btext>Prposal Name</td>
		<td class=btext>Lead Hab Code</td>
		<td class=btext>Lead Hab Name</td>		
	</tr>
<%
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	query = " SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.PROPOSAL_ID = '" +rProposalId+ "' AND P.LEAD_HAB_CODE = PR.PANCH_CODE ";
	rs = stmt.executeQuery(query);
	while(rs.next())
	{
		slno++;
%>
	
	<tr bgcolor="#ffffff">
		<td class=rptValue><%=slno%></td>				
		<td class=rptValue><a href="./rws_new_proposal_list_rpt.jsp?proposalId=<%=rs.getString(1)%>" target ="_new"><%=rs.getString(1)%></a></td>		
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>		
	</tr>
<%
	}
%>
</table>
<%	
	conn.close();	
%>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>