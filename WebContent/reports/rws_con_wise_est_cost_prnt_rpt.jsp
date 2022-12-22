<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("*****REPORT BEGINING*****");
	String rConstituency, rScheme, rYear = null;
	rConstituency = request.getParameter("rConstituency");
	rScheme = request.getParameter("rScheme");
	rYear = request.getParameter("rYear");
	//System.out.println("rConstituency = " +rConstituency);		
	//System.out.println("rScheme = " +rScheme);		
	//System.out.println("rYear = " +rYear);
	String query=null;
	int slno=0, k=1;
%>

<html>
<head>

<title>WaterSoft</title>
</head>
<link rel="stylesheet" type="text/css" href="/pred-rpt/resources/style/rwsstyle.css">
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

	<p align="center"><b><font face="Verdana" size="2">WaterSoft<br>
	Panchayat Raj Engineering Department<br>
	Rural Water Supply<br>
	Govt.of Andhra Pradesh</font></p>
	<p align="right" class=dateFont><%=sdf.format(new java.util.Date())%></p>

<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	
<tr bgcolor="#FFFFFF" align="center">
		<td align="center" class="prptLabel" colspan=6>Constituency Wise Estimate Cost Details</font></td>	
	</tr>

	<tr align=center bgcolor="#ffffff" align=center>
		<td class=prptLabel>Sl.No</td>				
		<td class=prptLabel>Scheme</td>		
		<td class=prptLabel>Work</td>
		<td class=prptLabel>Year</td>
		<td class=prptLabel>Estimate Cost - (Rs. in Lakhs)</td>
		<td class=prptLabel>Status</td>
	</tr>
<%
	if(rConstituency.equals("00") && (rScheme.equals("00") || rScheme.equals("-1")) && (rYear.equals("00") || rYear.equals("-1")))
	{
		//System.out.println("CONSTITUENCY ALL... SCHEME ALL... YEAR ALL...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ; 
	}
	if(rConstituency.equals("00") && !rScheme.equals("00") && !rScheme.equals("-1") &&  rYear.equals("-1"))
		{
			//System.out.println("CONSTITUENCY ALL... SCHEME SELECTED... YEAR IN SELECT...");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.TYPE_OF_ASSET = '"+rScheme+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(rConstituency.equals("00") && rScheme.equals("00") && !rScheme.equals("-1") &&  !rYear.equals("-1") && !rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY ALL... SCHEME ALL... YEAR VALUE...");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) = '"+rYear+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(rConstituency.equals("00") && !rScheme.equals("00") && !rScheme.equals("-1") &&  !rYear.equals("-1") && !rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY ALL... SCHEME VALUE... YEAR VALUE...");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.TYPE_OF_ASSET = '"+rScheme+"' AND SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) = '"+rYear+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && rScheme.equals("00") && !rScheme.equals("-1") &&  rYear.equals("-1") && !rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY VALUE... SCHEME ALL... YEAR SELECT...");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && !rScheme.equals("00") && !rScheme.equals("-1") &&  rYear.equals("-1") && !rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY VALUE... SCHEME VALUE... YEAR SELECT...");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' AND REP.TYPE_OF_ASSET = '"+rScheme+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && !rScheme.equals("00") && !rScheme.equals("-1") && !rYear.equals("-1") && rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY VALUE... SCHEME VALUE... YEAR ALL...");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' AND REP.TYPE_OF_ASSET = '"+rScheme+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && !rScheme.equals("00") && !rScheme.equals("-1") && !rYear.equals("-1") && !rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY VALUE... SCHEME VALUE... YEAR VALUE... LAST IF");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' AND REP.TYPE_OF_ASSET = '"+rScheme+"' AND SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) = '"+rYear+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && rScheme.equals("00") && !rScheme.equals("-1") && !rYear.equals("-1") && !rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY VALUE... SCHEME ALL... YEAR VALUE... ****** IF");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' AND SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) = '"+rYear+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && rScheme.equals("00") && !rScheme.equals("-1") && !rYear.equals("-1") && rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY VALUE... SCHEME ALL... YEAR ALL... &&&&&&&& IF");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
	if(!rConstituency.equals("00") && !rConstituency.equals("-1") && !rScheme.equals("00") && rScheme.equals("-1") && rYear.equals("-1") && !rYear.equals("00"))
		{
			//System.out.println("CONSTITUENCY VALUE... SCHEME SELECT... YEAR SELECT... &&&&&&&& IF");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			query = "SELECT CON.CONSTITUENCY_NAME, AST.TYPE_OF_ASSET_NAME, REP.ESTIMATE_COST, DECODE(REP.FLAG, 'A', 'ADMINISTRATIVE SANCTION', 'P', 'PENDING', 'C', 'CONSIDERED', 'D', 'DEFFERED'), CON.CONSTITUENCY_CODE, REP.PROPOSAL_NAME, SUBSTR(TO_CHAR(REP.REP_DATE,'dd/MM/yyyy'),7,4) FROM RWS_REP_PROPOSAL_TBL REP, RWS_ASSET_TYPE_TBL AST, RWS_CONSTITUENCY_TBL CON WHERE REP.CONSTITUENCY_CODE = CON.CONSTITUENCY_CODE AND REP. TYPE_OF_ASSET = AST.TYPE_OF_ASSET_CODE AND REP.CONSTITUENCY_CODE = '"+rConstituency+"' ORDER BY AST.TYPE_OF_ASSET_CODE, CON.CONSTITUENCY_NAME " ;
		}
		rs = stmt.executeQuery(query);
		String temp= "";
			while(rs.next())
			{
				slno++;
				if(temp.equals(rs.getString(5)))
				{
%>	
	<tr bgcolor="#ffffff">
		<td class=rptValue><%=slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
		<td class=rptValue><%=rs.getString(7)%></td>
		<td class=amountFont align=right><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>	
	</tr>	
<%
					}
					else
						{
						temp=rs.getString(5);
%>
	<tr bgcolor="#FFFFFF">
		<td class="prptLabel" colspan="11"><%=rs.getString(1)%> Constituency</td>	
	</tr>
	<tr bgcolor="#ffffff">
		<td class=rptValue><%=slno%></td>		
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
		<td class=rptValue><%=rs.getString(7)%></td>
		<td class=amountFont align=right><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>		
	</tr>
<%
						}
			}
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
<p align="center"><b><font face="Verdana" size="2">Designed and Developed By NIC APSC</b></font></p>

</form>
</body>
</html>