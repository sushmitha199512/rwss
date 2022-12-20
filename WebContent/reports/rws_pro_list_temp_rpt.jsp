<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
try 
{
	//System.out.println("*****REPORT BEGINING*****");
	String rDistrict, rMandal, rPanchayat, rConstituency, rFinYear, rAssetType = null, rGrantType = null;
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rConstituency = request.getParameter("cons");
	rFinYear = request.getParameter("finYear");
	rAssetType = request.getParameter("assetType");
	rGrantType = request.getParameter("grantName");

	//System.out.println("rDistrict = " +rDistrict);		
	//System.out.println("rMandal = " +rMandal);		
	//System.out.println("rPanchayat = " +rPanchayat);
	//System.out.println("rConstituency = " +rConstituency);
	//System.out.println("rFinYear = " +rFinYear);
	//System.out.println("rAssetType = " +rAssetType);
	//System.out.println("rGrantType = " +rGrantType);

	String query,query1=null;	
	Statement stmt1=null;
	ResultSet rs1=null;
	int slno=0;	
	String cost1=request.getParameter("distname2[]");
	//System.out.println("cost is========== "+cost1);	
%>

<html>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width=700 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:window.history.back()">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=5>Proposal Details</font></td>	
	</tr>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>Proposal ID</td>		
		<td class=btext>Proposal Name</td>
		<td class=btext>Lead Habitation Code</td>
		<td class=btext>Lead Habitation Name</td>		
	</tr>
<%
	if(rDistrict!=null && !rDistrict.equals("0"))
	{
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, rws_panchayat_raj_tbl PR WHERE SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND PR.PANCH_CODE = P.LEAD_HAB_CODE";	
	}
else
	if(rMandal!=null && !rMandal.equals("0"))
	{
		query1="P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, rws_panchayat_raj_tbl PR WHERE SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND PR.PANCH_CODE = P.LEAD_HAB_COD AND SUBSTR(OFFICE_CODE,5,1) = '"+rMandal+"' ";
	}
else
	if(rPanchayat!=null && !rPanchayat.equals("0"))
	{
		query1="P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, rws_panchayat_raj_tbl PR WHERE SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND PR.PANCH_CODE = P.LEAD_HAB_COD AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"' AND SUBSTR(OFFICE_CODE,6,2) = '"+rPanchayat+"' ";
	}
	if(rConstituency != null && !rConstituency.equals("0"))
	{
		query1= query1 + "   AND P.CONSTITUENCY_CODE =  '" + rConstituency + "' ";
	}
	/*if(rFinYear != null && !rFinYear.equals("0"))
	{
		query1= query1 + "   AND SUBSTR(TO_CHAR(P.REP_DATE, 'dd/MM/yyyy'),7,4) =  '" + rFinYear + "' ";
	}*/
	if(rFinYear != null && !rFinYear.equals("0"))
	{
		int yr = Integer.parseInt(rFinYear);
		yr = yr - 2;
		String finyr = String.valueOf(yr);
		//System.out.println("year is  "+yr);
		
		query1 = query1 + "   AND SUBSTR(TO_CHAR(P.REP_DATE, 'dd/MM/yyyy'),7,4) >='" + finyr +"' and   SUBSTR(TO_CHAR(P.REP_DATE, 'dd/MM/yyyy'),7,4)<='" + rFinYear + "' ";
	}
	if(rAssetType != null && !rAssetType.equals("null"))
	{
		query1= query1 + "   AND P.TYPE_OF_ASSET =  '" + rAssetType + "' ";
	}
	if(rGrantType != null && !rGrantType.equals("0"))
	{
		query1= query1 + "   AND P.PROGRAMME_CODE =  '" + rGrantType + "' ";
	}

	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	// query="SELECT ESTIMATE_COST FROM RWS_REP_PROPOSAL_TBL";
	if(request.getParameter("distname2[]").equals(">=0 and <=25000"))
	{
		//System.out.println("cost sad========== "+cost1);
		query1= query1 + " and estimate_cost >=0 and estimate_cost<=25000 ";
	}
	if(request.getParameter("distname2[]").equals(">25000 and <=200000"))
	{
		//System.out.println("cost sad========== "+cost1);
		query1= query1 + " and estimate_cost >25000/100000 and estimate_cost<=200000/100000 ";
	}
	if(request.getParameter("distname2[]").equals(">200000 and <=1000000"))
	{
		//System.out.println("cost sad========== "+cost1);
		query1= query1 + " and estimate_cost >200000/100000 and estimate_cost<=1000000/100000 ";
	}
	if(request.getParameter("distname2[]").equals(">1000000 and <=5000000"))
	{
		//System.out.println("cost sad========== "+cost1);
		query1= query1 + " and estimate_cost >1000000/100000 and estimate_cost<=5000000/100000 ";
	}
	if(request.getParameter("distname2[]").equals(">5000000"))
	{
		//System.out.println("cost ali========== "+cost1);
		query1= query1 + " and estimate_cost >5000000/100000 ";
	}
	
	//System.out.println("query is========== "+query1);
	rs=stmt.executeQuery(query1);	
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
}
catch(Exception e)
{
	//System.out.println("ERROR IN PRO_LIST " +e);
}
%>

				
