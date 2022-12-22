<% 
	if(request.getParameter("type") != null && request.getParameter("type").equals("excel")) 
	{
		response.setContentType("application/vnd.ms-excel"); 
	}
%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("*****REPORT BEGINING*****");
	String rConstituency, rScheme, rYear = null;
	rConstituency = request.getParameter("contituency");
	rScheme = request.getParameter("scheme");
	rYear = request.getParameter("year");
	//System.out.println("rConstituency = " +rConstituency);		
	//System.out.println("rScheme = " +rScheme);		
	//System.out.println("rYear = " +rYear);
	String query=null;
	int slno=0, k=1;
	double total=0, conTotal=0;
	String conName="";
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
				<td class="bwborder"><a href="./rws_con_wise_est_cost_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				<td class="bwborder"><a href="./rws_con_wise_est_cost_prnt_rpt.jsp?rConstituency=<%=rConstituency%>&rScheme=<%=rScheme%>&rYear=<%=rYear%>" target="_new">Print |</a></td>
				<td class="bwborder"><a href="./rws_con_wise_est_cost_xls_rpt.jsp?type=excel&rConstituency=<%=rConstituency%>&rScheme=<%=rScheme%>&rYear=<%=rYear%>" target="_new">Excel</a></td>			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=6>Constituency - Scheme - Year Wise Estimate Cost Details</font></td>	
	</tr>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>Scheme</td>		
		<td class=btext>Work</td>
		<td class=btext>Year</td>
		<td class=btext>Estimate Cost - (Rs. in Lakhs)</td>
		<td class=btext>Status</td>
	</tr>
<%	
	if(rConstituency.equals("00") && (rScheme.equals("00") || rScheme.equals("-1")) && (rYear.equals("00") || rYear.equals("-1")))
	{
		//System.out.println("CONSTITUENCY ALL... SCHEME ALL... YEAR ALL...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME ";	
	}
	if(rConstituency.equals("00") && !rScheme.equals("00") && !rScheme.equals("-1") &&  rYear.equals("-1"))
	{
		//System.out.println("CONSTITUENCY ALL... SCHEME SELECTED... YEAR IN SELECT...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.TYPE_OF_ASSET = '"+rScheme+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	if(rConstituency.equals("00") && rScheme.equals("00") && !rScheme.equals("-1") &&  !rYear.equals("-1") && !rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY ALL... SCHEME ALL... YEAR VALUE...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) = '"+rYear+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	if(rConstituency.equals("00") && !rScheme.equals("00") && !rScheme.equals("-1") &&  !rYear.equals("-1") && !rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY ALL... SCHEME VALUE... YEAR VALUE...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.TYPE_OF_ASSET = '"+rScheme+"' AND SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) = '"+rYear+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && rScheme.equals("00") && !rScheme.equals("-1") &&  rYear.equals("-1") && !rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY VALUE... SCHEME ALL... YEAR SELECT...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && !rScheme.equals("00") && !rScheme.equals("-1") &&  rYear.equals("-1") && !rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY VALUE... SCHEME VALUE... YEAR SELECT...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' AND REP.TYPE_OF_ASSET = '"+rScheme+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && !rScheme.equals("00") && !rScheme.equals("-1") && !rYear.equals("-1") && rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY VALUE... SCHEME VALUE... YEAR ALL...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' AND REP.TYPE_OF_ASSET = '"+rScheme+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && !rScheme.equals("00") && !rScheme.equals("-1") && !rYear.equals("-1") && !rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY VALUE... SCHEME VALUE... YEAR VALUE... LAST IF");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' AND REP.TYPE_OF_ASSET = '"+rScheme+"' AND SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) = '"+rYear+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && rScheme.equals("00") && !rScheme.equals("-1") && !rYear.equals("-1") && !rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY VALUE... SCHEME ALL... YEAR VALUE... ****** IF");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' AND SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) = '"+rYear+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && rScheme.equals("00") && !rScheme.equals("-1") && !rYear.equals("-1") && rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY VALUE... SCHEME ALL... YEAR ALL... &&&&&&&& IF");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && !rScheme.equals("00") && rScheme.equals("-1") && rYear.equals("-1") && !rYear.equals("00"))
	{
		//System.out.println("CONSTITUENCY VALUE... SCHEME SELECT... YEAR SELECT... &&&&&&&& IF");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4), REP.PROPOSAL_ID FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
	}
	rs = stmt.executeQuery(query);
	String temp= "";
	int temp1= 0;
		while(rs.next())
		{
		// conName=rs.getString(1);
		slno++;
			if(temp.equals(rs.getString(5)))
			{	
				conTotal=conTotal+rs.getDouble(3);
%>	
	<tr bgcolor="#ffffff">
		<td class=rptValue><%=slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><a href="./rws_con_sche_year_est_cost_rpt.jsp?constituency=<%=rConstituency%>&scheme=<%=rScheme%>&year=<%=rYear%>&proposalId=<%=rs.getString(8)%>"><%=rs.getString(6)%></a></td>
		<td class=rptValue><%=rs.getString(7)%></td>
		<td class=amountFont align=right><%=rs.getDouble(3)%></td>
		<td class=rptValue><%=rs.getString(4)==null ? "-" : rs.getString(4)%> </td>	
	</tr>	
<%
			}
			else
				{				
				temp=rs.getString(5);
					if(temp1!=0)
					{
						
%>
	<tr bgcolor="#FFFFFF">
		<td class="btext" colspan="4" align="right"><%=conName%> Total Estimate Cost</td>
		<td class="btext" align="right"><%=conTotal%></td>
	</tr>
<%
					}
					conTotal=rs.getDouble(3);
					temp1++;					
					conName=rs.getString(1);
%>
	<tr bgcolor="#FFFFFF">
		<td class="rptSubValue" colspan="11"><%=rs.getString(1)%> Constituency</td>	
	</tr>	
	<tr bgcolor="#ffffff">
		<td class=rptValue><%=slno%></td>		
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><a href="./rws_con_sche_year_est_cost_rpt.jsp?constituency=<%=rConstituency%>&scheme=<%=rScheme%>&year=<%=rYear%>&proposalId=<%=rs.getString(8)%>"><%=rs.getString(6)%></a></td>
		<td class=rptValue><%=rs.getString(7)%></td>
		<td class=amountFont align=right><%=rs.getDouble(3)%></td>
		<td class=rptValue><%=rs.getString(4)==null ? "-" : rs.getString(4)%></td>
	</tr>		
<%					
				}				
				total=total+rs.getDouble(3);				
		}		
%>
	<tr bgcolor="#FFFFFF">
		<td class="btext" colspan="4" align="right"><%=conName%> Total Estimate Cost</td>
		<td class="btext" align=right><%=conTotal%></td>
	</tr>

	<tr bgcolor="#FFFFFF">
		<td class="rptSubValue" colspan="4" align="right">Total Estimate Cost:</td>
		<td class="rptSubValue" align=right><%=total%></td>
	</tr>
<%			
			rs.close();
			stmt.close();
				if(slno==0)
				{
%>
	<tr bgcolor="#FFFFFF" align="center">
		<td class="rptSubValue" colspan="6">NO RECORDS FOR YOUR QUERY...</td>	
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
<input type="hidden" name=constituency value=<%=rConstituency%>>
<input type="hidden" name=scheme value=<%=rScheme%>>
<input type="hidden" name=year value=<%=rYear%>>