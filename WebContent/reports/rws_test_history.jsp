<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	/*String sourceId=
	= request.getParameter("sourceid");
	String testCode = request.getParameter("testcode");
	String circCode = request.getParameter("circcode");
	String tdate = request.getParameter("date");*/
	String testId= null,query = null,testcode=null;
	testId=request.getParameter("testid");
	testcode=request.getParameter("testCode");
	
	

%>
<html>
<head>
<title>WaterSoft</title>

</head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width ="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="javascript:window.history.back()">Back</td> 
				</tr>
			</table>
		</caption>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="8">Test Parameter Details
			</td>	
		</tr>

	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Testing Name</td>
		<td class=btext>Testing Parameter Name</td>
		<td class=btext>Min Permissible Value</td>
		<td class=btext>Max Permissible Value</td>		
		<td class=btext>Testing Parameter Value</td>	
		<td class=btext>UnDesirable Effect</td>
	</tr>

	
<%
	int slno = 0;
	try
	{
	//RwsOffices rwsOffices = new RwsOffices(ds);
	stmt = conn.createStatement();
	query = "SELECT  distinct T.TEST_NAME, P.TESTING_PARAMETER_NAME, P.MIN_PERMISSIBLE_VALUE, P.MAX_PERMISSIBLE_VALUE, NVL(L.TESTING_PARAMETER_VALUE,'---'),nvl(P.UNDESIRE_EFFECT,'--') FROM  RWS_WQ_PARA_TEST_TBL P, RWS_WQ_TEST_RESULTS_LNK_TBL L, RWS_WATER_SAMPLE_COLLECT_TBL S, RWS_WATER_QUALITY_TEST_TBL T WHERE S.TEST_CODE = P.TEST_CODE  AND P.TESTING_PARAMETER_CODE = L.TESTING_PARAMETER_CODE AND T.TEST_CODE = S.TEST_CODE  and L.test_id='"+testId+"' and T.TEST_CODE='"+testcode+"'";

	
	/*query = "SELECT distinct T.TEST_NAME, P.TESTING_PARAMETER_NAME, P.MIN_PERMISSIBLE_VALUE, P.MAX_PERMISSIBLE_VALUE, NVL(L.TESTING_PARAMETER_VALUE,'---') FROM RWS_WQ_GEOLOGIST_TEST_TBL G, RWS_WQ_PARA_TEST_TBL P, RWS_WQ_TEST_RESULTS_LNK_TBL L, RWS_WATER_SAMPLE_COLLECT_TBL S, RWS_WATER_QUALITY_TEST_TBL T WHERE S.TEST_CODE = P.TEST_CODE  AND G.TEST_ID = L.TEST_ID AND P.TESTING_PARAMETER_CODE = L.TESTING_PARAMETER_CODE AND S.TEST_ID = G.TEST_ID AND T.TEST_CODE = S.TEST_CODE AND L.test_id='"+testId+"'";*/

	rs = stmt.executeQuery(query);
		while(rs.next())
		{
			slno++;	
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><%=rs.getString(1)%></td>
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue><%=rs.getString(5)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
		
	</tr>



<%  }
if(slno==0)
		{%> <tr align="center">
           <td class=rptHeading colspan=8 ><a href="javascript:window.history.back()"><%="No Records For this Query"%></a></td></tr>
		<%
		rs.close();
		stmt.close();
		}
	}
	catch(Exception e)
	{
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
