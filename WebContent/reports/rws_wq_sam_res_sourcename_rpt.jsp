<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<head>
<title>WaterSoft</title>

</head>
<body bgcolor="#edf2f8">

<%
     Statement stmt1=null,stmt2=null,stmt3=null;
     ResultSet rs1=null,rs2=null,rs3=null;
    String query = null,testId=null,testName=null,testcode=null,scode=null,location="";
	testId = request.getParameter("testId");
    testName = request.getParameter("testName");
	testcode = request.getParameter("testCode");
	scode=request.getParameter("sourcecode");
	String sType=request.getParameter("sctype");
	location=request.getParameter("location");
	//System.out.println("location "+location);
	/* String yearcode=request.getParameter("year");
	String tdsfy[]=yearcode.split("/");
	String yearStart = tdsfy[0];
	String yearEnd = tdsfy[1];
	String financialYear = tdsfy[2]; */
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
	nic.watersoft.wquality.RwsWQualityData rwsdata=new  nic.watersoft.wquality.RwsWQualityData(); 
	/* location=rwsdata.getSourceNames(scode,sType.substring(0,2)); */
	
stmt1 = conn.createStatement();
String qry="select * from rws_complete_hab_view  where panch_code='"+scode.substring(0,16)+"' ";
rs1=stmt1.executeQuery(qry);
if(rs1.next())
{ %>
    <table border = 0 width=25% align=center>   
	<tr><td class=btext><font face=verdana>District:</font><font face=verdana color=black size=1><%=rs1.getString(2)%></font></td>
	<td class=btext>Mandal:<font face=verdana color=black size=1><%=rs1.getString(4)%></font></td> 
		   <td class=btext>Panchayat:<font face=verdana color=black size=1><%=rs1.getString(6)%></font></td> 
		   <td class=btext>Village:<font face=verdana color=black size=1><%=rs1.getString(8)%></font></td> 
		   <td class=btext>Habitation:<font face=verdana color=black size=1><%=rs1.getString(10)%></font></td> 
		   
<%}
rs1.close();
stmt1.close();
%>
<td class=btext>SourceCode:<font face=verdana color=black size=1><%=scode%></font></td> 
<td class=btext>Location:<font face=verdana color=black size=1><%=location%></font></td> 
<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="javascript:window.close()">Close</A>&nbsp;|<a href="JavaScript:window.print();">Print </a> </td>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width ="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="8">Test Details Of <%=testName%>
			</td>	
		</tr>

	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Test Name</td>
		<td class=btext>Testing Parameter Name</td>
		<td class=btext>Min Permissible Value</td>
		<td class=btext>Max Permissible Value</td>		
		<td class=btext>Undesirable Effect</td>
		<td class=btext>Testing Parameter Value</td>
	</tr>

	
<%
	int slno = 0;
	try
	{
	//RwsOffices rwsOffices = new RwsOffices(ds);
	stmt = conn.createStatement();
	//query = "SELECT distinct T.TEST_NAME, P.TESTING_PARAMETER_NAME, nvl(P.MIN_PERMISSIBLE_VALUE,'-'), nvl(P.MAX_PERMISSIBLE_VALUE,'-'), NVL(L.TESTING_PARAMETER_VALUE,'---'),nvl(P.UNDESIRE_EFFECT,'--'),L.TESTING_PARAMETER_CODE  FROM  RWS_WQ_PARA_TEST_TBL P, RWS_WQ_TEST_RESULTS_LNK_TBL L, RWS_WATER_SAMPLE_COLLECT_TBL S, RWS_WATER_QUALITY_TEST_TBL T WHERE S.TEST_CODE = P.TEST_CODE  AND P.TESTING_PARAMETER_CODE = L.TESTING_PARAMETER_CODE  AND T.TEST_CODE = S.TEST_CODE AND L.TEST_ID = '"+testId+"' and T.test_code='"+testcode+"'  order by L.TESTING_PARAMETER_CODE  ";
     //AND G.TEST_ID = L.TEST_ID AND S.TEST_ID = G.TEST_ID,RWS_WQ_GEOLOGIST_TEST_TBL G
   query="SELECT distinct T.TEST_NAME, P.TESTING_PARAMETER_NAME, nvl(P.MIN_PERMISSIBLE_VALUE,'-'), nvl(P.MAX_PERMISSIBLE_VALUE,'- '),nvl(P.UNDESIRE_EFFECT,'--'),p.TESTING_PARAMETER_CODE FROM RWS_WQ_PARA_TEST_TBL P,RWS_WATER_QUALITY_TEST_TBL T WHERE T.test_code='"+testcode+"' and p.test_code=t.test_code order by p.TESTING_PARAMETER_CODE ";
   ////////System.out..println(query);
   	rs = stmt.executeQuery(query);
	stmt2= conn.createStatement();
		while(rs.next())
		{
			slno++;	
%>
	<tr align=center bgcolor="#ffffff" >
		<td class=rptValue align="center"><%=slno%></td>
		<td class=rptValue align="left"><%=rs.getString(1)%></td>
		<td class=rptValue align="left"><%=rs.getString(2)%></td>
		<td class=rptValue align="right"><%=rs.getString(3)%></td>
		<td class=rptValue align="right"><%=rs.getString(4)%></td>
		<td class=rptValue align="left"><%=rs.getString(5)%></td>
	<% String qry1="SELECT nvl(testing_parameter_value,'-')  from RWS_WQ_TEST_RESULTS_LNK_TBL wr,RWS_WATER_SAMPLE_COLLECT_TBL ws WHERE ws.TEST_ID = '"+testId+"' and wr.test_id=ws.test_id and testing_parameter_code='"+rs.getString(6)+"' and ws.assigned_on BETWEEN '"+fromDate+"' AND '"+toDate+"'";
     
	// System.out.println(qry1);
	 	rs2 = stmt2.executeQuery(qry1); 
		if(rs2.next())
			{
			  %>
			  <td class=rptValue align="right"><%=rs2.getString(1)%></td>
		   <%
			}
			 else  {%>
			   <td class=rptValue align="right">-</td>
			   <%}
			rs2.close();
			//stmt2.close();
			%>   
	</tr>



<%  }
if(slno==0)
		{%> <tr align="center">
           <td class=rptHeading colspan=8 ><a href="javascript:window.history.back()"><%="Parameter Values are Not Entered For This Sample "%></a></td></tr>
		<%
		rs.close();
		stmt.close();
		}
	}
	catch(Exception e)
	{
		//////System.out.println("Exception in source loc  rpt:"+e)
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