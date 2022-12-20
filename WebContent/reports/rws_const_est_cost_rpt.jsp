<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
try 
{
	//System.out.println("*****REPORT BEGINING*****");
	String rAssetType = null;
	String rFinYear = request.getParameter("finYear");
	//String fYear[] = new String [rFinYear.length]
	rAssetType = request.getParameter("assetType");	
	//System.out.println("rFinYear = " + rFinYear.substring(0,4));
	//System.out.println("rAssetType = " + rAssetType);
	String query,query1=null;	
	Statement stmt1=null;
	ResultSet rs1=null;
	int slno=0;
	
	String names12[] =  request.getParameterValues("const[]");
	String sr1[]= new String[names12.length];	
	if(names12 != null)
	{
		for (int M=0; M < names12.length; M++)
			{
				sr1[M] = names12[M].substring(0,names12[M].lastIndexOf("-"));
			    //System.out.println("YYYYYYYY dddddddddd  "+sr1[M]);	
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				query = "SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND P.CONSTITUENCY_CODE ='"+sr1[M]+"' ";

				if(!rAssetType.equals("null"))
				{
					query = query + " AND P.TYPE_OF_ASSET = '" + rAssetType + "' ";
				}
				if(rFinYear.length()>4 && rFinYear!= null)
				{
					//System.out.println("sasdi qali ");
					query = query + " AND SUBSTR(TO_CHAR(P.REP_DATE, 'dd/MM/yyyy'),7,4) >='" +rFinYear.substring(0,4)+ "'  AND SUBSTR(TO_CHAR(P.REP_DATE, 'dd/MM/yyyy'),7,4)<='" +rFinYear.substring(4,8)+ "' ";
				}
				if(rFinYear.length()==4 && rFinYear!= null)
				{
					//System.out.println("sasdi qali ");
					query = query + " AND SUBSTR(TO_CHAR(P.REP_DATE, 'dd/MM/yyyy'),7,4) >='" +rFinYear.substring(0,4)+ "'  AND SUBSTR(TO_CHAR(P.REP_DATE, 'dd/MM/yyyy'),7,4)<='" +rFinYear.substring(4,8)+ "' ";
				}
				//System.out.println("sasdi qali "+query);

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
				rs=stmt.executeQuery(query);	
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
	}	
}
catch(Exception e)
{
	//System.out.println("ERROR IN PRO_LIST " +e);
}
%>
	
</table>
</form>
</body>
</html>