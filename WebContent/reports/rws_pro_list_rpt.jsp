<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
try 
{
	//System.out.println("*****REPORT BEGINING*****");
	String rDistrict=null, rMandal=null, rPanchayat=null, query=null, query1=null,code=null,fdate=null,tdate=null;
	rDistrict = request.getParameter("district");
	code = request.getParameter("code");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	fdate=request.getParameter("FDate");
   // tdate=request.getParameter("TDate");
	
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
				String a1 ="  ORDER BY PROPOSAL_ID";
if(rDistrict.equals("51") && code==null)
{
	//System.out.println("IN CIRCLE ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE and p.rep_date is not null";
}
else if(rDistrict.equals("51") && code!=null)
	{
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+code+"' and p.rep_date is not null ";
	}

else if(!rDistrict.equals("51") && !rDistrict.equals("0") && rMandal.equals("0") && code!=null)
	{
       query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+code+"' and p.rep_date is not null ";
	}
 else if(!rDistrict.equals("51") && !rDistrict.equals("0") && rMandal.equals("0") && code==null)
	{
       query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' and p.rep_date is not null ";
	}
  else if(!rDistrict.equals("51") && rMandal.equals("5200")&& code==null)
{
	//System.out.println("IN CIRCLE SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' and p.rep_date is not null";
}
else if(!rDistrict.equals("51") && rMandal.equals("5200")&& code!=null)
{
	//System.out.println("IN CIRCLE SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' and SUBSTR(OFFICE_CODE,4,1)='"+code+"' and p.rep_date is not null";
}
/*else if(!rDistrict.equals("51") && !rDistrict.equals("0") && rMandal.equals("5200"))
{
	//System.out.println("IN DIVISION ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"'";
}*/
else if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("5200") && !rMandal.equals("0") && rPanchayat.equals("0"))
{
	//System.out.println("IN DIVISION SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"' and p.rep_date is not null";
}
else if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("5200") && !rMandal.equals("0") && rPanchayat.equals("5300") && code==null)
{
	//System.out.println("IN SUB DIVISION ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"' and p.rep_date is not null";
}
else if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("5200") && !rMandal.equals("0") && rPanchayat.equals("5300") && code!=null)
{
	//System.out.println("IN SUB DIVISION ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"'  and SUBSTR(OFFICE_CODE,5,2)= '"+code+"' and p.rep_date is not null";
}
 else if(!rDistrict.equals("51") && !rMandal.equals("5200") && !rPanchayat.equals("5300"))
	{
      query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"'  and SUBSTR(OFFICE_CODE,5,2)= '"+rPanchayat+"' and p.rep_date is not null";
	}
 if(fdate!=null && !fdate.equals("0"))
	{   
	 //P.PREPARED_ON
		query1 = query1 + " and to_char(P.PREPARED_ON,'yyyy')='" + fdate +"'";
	}
	query1 = query1 + a1;
	//System.out.println(" query  is   "+query1);

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

finally
{
conn.close();
}%>
				
