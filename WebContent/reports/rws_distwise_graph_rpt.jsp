<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
try 
{
	//System.out.println("*****REPORT BEGINING*****");
	String rDistrict, rMandal, rPanchayat, rStatus,rStatus1, query, query1 = null;
	rStatus = request.getParameter("status");
	if(rStatus.equals("C"))
     rStatus1="Condemened";
	else if(rStatus.equals("D"))
     rStatus1="Dried";
	else if(rStatus.equals("W"))
     rStatus1="Working";
	else if(rStatus.equals("S"))
     rStatus1="Seasonal";
	else
       rStatus1="NotWorking";

	//String rStatus1 = String.valueOf(session.setAttribute("rStatus"));
	
	int slno=0;
%>

<html>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="75%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
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
		<td align="center" class="rptHeading" colspan=5>Borewell Dist Wise <%=rStatus1%> Status</font></td>	
	</tr>			

	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>Distirct Name</td>		
		<td class=btext>Count</td>
	</tr>
<%
if(rStatus.equals("W"))
{
	//System.out.println("IN DISTRICT ALL working ...");
	query1="SELECT D.DCODE,DNAME,COUNT(status)FROM rws_hp_subcomp_param_tbl h ,RWS_DISTRICT_TBL D WHERE h.STATUS ='W'  AND D.DCODE = SUBSTR(H.HP_CODE,1,2) GROUP BY D.DCODE,DNAME,status";
}

if(rStatus.equals("C"))
{
	//System.out.println("IN DISTRICT ALL condemened..");
	query1="SELECT D.DCODE,DNAME,COUNT(status)FROM rws_hp_subcomp_param_tbl h ,RWS_DISTRICT_TBL D WHERE h.STATUS ='C'  AND D.DCODE = SUBSTR(H.HP_CODE,1,2) GROUP BY D.DCODE,DNAME,status";
}
if(rStatus.equals("S"))
{
	//System.out.println("IN DISTRICT ALL seasonal...");
	query1="SELECT D.DCODE,DNAME,COUNT(status)FROM rws_hp_subcomp_param_tbl h ,RWS_DISTRICT_TBL D WHERE h.STATUS ='S'  AND D.DCODE = SUBSTR(H.HP_CODE,1,2) GROUP BY D.DCODE,DNAME,status";
}

if(rStatus.equals("D"))
{
	//System.out.println("IN DISTRICT ALL DRIED...");
	query1="SELECT D.DCODE,DNAME,COUNT(status)FROM rws_hp_subcomp_param_tbl h ,RWS_DISTRICT_TBL D WHERE h.STATUS ='D'  AND D.DCODE = SUBSTR(H.HP_CODE,1,2) GROUP BY D.DCODE,DNAME,status";
}
if(rStatus.equals("N"))
{
	//System.out.println("IN DISTRICT ALL NotWorking...");
	query1="SELECT D.DCODE,DNAME,COUNT(status)FROM rws_hp_subcomp_param_tbl h ,RWS_DISTRICT_TBL D WHERE h.STATUS ='NW'  AND D.DCODE = SUBSTR(H.HP_CODE,1,2) GROUP BY D.DCODE,DNAME,status";
}
  int tot=0;
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	rs = stmt.executeQuery(query1);	
	while(rs.next())
	{	
		slno++;	
		tot=tot+rs.getInt(3);
%>

	
	<tr bgcolor="#ffffff">
		<td class=rptValue><%=slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><a href="./rws_distboredetails_rpt.jsp?dcode=<%=rs.getString(1)%>&status=<%=rStatus%>"><%=rs.getString(3)%></a></td>
		</tr>	

<%				
	}%>
  
   <tr bgcolor="#ffffff">
         <td class=btext colspan=2>Total:</td>
		 <td class=btext><%=tot%></td>
  </tr>
<%
      if(slno==0)
		{
%>
	<tr bgcolor="#FFFFFF" align="center">
		<td class="rptSubValue" colspan="3">NO RECORDS FOR YOUR QUERY...</td>	
	</tr>
<%
		}

}
catch(Exception e)
{
	//response.sendRedirect("./ErrorPage.jsp");
}
finally
{
	conn.close();
}
%>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>			