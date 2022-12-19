<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
try 
{
	//System.out.println("*****REPORT BEGINING*****");
	String rDistrict, rMandal, rPanchayat, rRep, query, query1 = null;
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rRep = request.getParameter("repname[]");
	//System.out.println("rDistrict = " +rDistrict);		
	//System.out.println("rMandal = " +rMandal);		
	//System.out.println("rPanchayat77777777777777777777777777777777777777 = " +rPanchayat);
	//System.out.println("rRep = " + rRep);
	String fdate=request.getParameter("FDate");
	String tdate=request.getParameter("TDate");
	Statement stmt1=null;
	ResultSet rs1=null;
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
				<!-- <td class="bwborder"><a href="../home.jsp">Print |</a></td>
				<td class="bwborder"><a href="../home.jsp">Excel</a></td>	 -->		
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=5><%=rRep%> Wise Proposal Details</font></td>	
	</tr>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>Proposal ID</td>		
		<td class=btext>Proposal Name</td>
		<td class=btext>Lead Habitation Code</td>
		<td class=btext>Lead Habitation Name</td>		
	</tr>
<%
							String a1 ="  ORDER BY PROPOSAL_ID";
if(rDistrict.equals("51"))
{
	//System.out.println("IN CIRCLE ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR, RWS_PUBLIC_REP_TBL REP WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND REP.REP_NAME = '"+rRep+"' AND REP.REP_CODE = P.REP_CODE  ";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && rMandal.equals("0"))
{
	//System.out.println("IN CIRCLE SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR, RWS_PUBLIC_REP_TBL REP WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"'AND REP.REP_NAME = '"+rRep+"' AND REP.REP_CODE = P.REP_CODE  ";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && rMandal.equals("52"))
{
	//System.out.println("IN DIVISION ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR, RWS_PUBLIC_REP_TBL REP WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND REP.REP_NAME = '"+rRep+"' AND REP.REP_CODE = P.REP_CODE ";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("52") && !rMandal.equals("0") && rPanchayat.equals("0"))
{
	//System.out.println("IN DIVISION SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR, RWS_PUBLIC_REP_TBL REP WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"'  AND REP.REP_NAME = '"+rRep+"' AND REP.REP_CODE = P.REP_CODE  ";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("52") && !rMandal.equals("0") && rPanchayat.equals("53"))
{
	//System.out.println("IN SUB DIVISION ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR, RWS_PUBLIC_REP_TBL REP WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"'  AND REP.REP_NAME = '"+rRep+"' AND REP.REP_CODE = P.REP_CODE  ";
}
if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0"))
	{
		query1 = query1 + " and to_char(P.PREPARED_ON,'dd/mm/yyyy') >='" + fdate +"' and to_char(P.PREPARED_ON,'dd/mm/yyyy') <= '"+ tdate +"' ";
	}
	query1 = query1 + a1;
	// //System.out.println("query is "+query1);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	
	rs = stmt.executeQuery(query1);
		
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
	//System.out.println("error is  "+e);
}
%>

				
