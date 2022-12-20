<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("*****REPORT BEGINING*****");
	String rDistrict = String.valueOf(session.getAttribute("districtCode"));
	//System.out.println(rDistrict);
	String distname=String.valueOf(session.getAttribute("districtName"));
	String dcode=null;
	//dcode=  String.valueOf(session.getAttribute("districtCode"));
	dcode=  request.getParameter("dcode");
	//System.out.println(dcode);
	int pass=0;
	String dName = request.getParameter("dName");
	String updateDate=request.getParameter("updateDate");
	//System.out.println(dName);
	//System.out.println(updateDate);
	String query=null, query1 = null, query2 = null, query3 = null, query4 = null, query5 = null, query6 = null, query7 = null, query8 = null, query9 = null, query10 = null, query11 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null;
	Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, stmt7 = null, stmt8 = null, stmt9 = null, stmt10 = null, stmt11 = null ;
	int slno = 0;
	int Count = 0, LCount = 0, NOP = 0;	
try
{

%>
<html>
<head>
<script>
window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_hab_update_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
				<!--<td class="bwborder"><a href="./rws_excel_xls_prnt.jsp?dcode=<%=dcode%>&rDistrict=<%=rDistrict%>&dName=<%=dName%>
				&updateDate=<%=updateDate%>" target="_new">Print |</a></td>
			    <td class="bwborder"><a href="./rws_excel_xls.jsp?dcode=<%=dcode%>&rDistrict=<%=rDistrict%>&dName=<%=dName%>
				&updateDate=<%=updateDate%>" target="_new">Excel</a></td>-->
			</tr>
		</table>
	</caption>


<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="12">District-Habitation-Report</font></td>	
	</tr>
<% 
	if(rDistrict!= null && rDistrict.equals("00") && dName==null)
		{
			//System.out.println("IN DISTRICT ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan="14">District: All</font></td>	
	</tr>	
<%
		}
		if(rDistrict.equals("00") && rDistrict!= null && dName!=null)
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan="14">District: <%=dName%></font></td>	
	</tr>	

	<%
		}

	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && distname!=null)
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan="14">District: <%=distname%></font></td>	
	</tr>	

	<%
		}
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>District</td>	
		<td class=btext>Habitation Name</td>	
		<td class=btext>Habitation Status</td>
		<td class=btext>Update Date</td>
	 </tr>
<%	
	//if(rDistrict != null && rDistrict.equals("00"))
     if(dcode == null && dName==null && rDistrict.equals("00") && updateDate==null)
	{
       //System.out.println("IN DISTRICT ALL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="SELECT DISTINCT D.DCODE, D.DNAME, PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and update_date is not null ORDER BY D.DCODE,TO_DATE(update_date,'DD-MON-YYYY')";
	}
    if(dcode != null && dName!=null && rDistrict.equals("00") && updateDate==null)
	{
		//System.out.println("IN DISTRICT ALL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		/*query="SELECT distinct d.dcode,D.DNAME,PR.PANCH_NAME,nvl(HD.COVERAGE_STATUS,'--'),TO_DATE(HD.update_date,'DD-MON-YYYY')from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where HD.update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE order by d.dcode,TO_DATE(HD.update_date,'DD-MON-YYYY')";*/

		query="SELECT DISTINCT D.DCODE, D.DNAME, PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and update_date is not null ORDER BY D.DCODE,TO_DATE(update_date,'DD-MON-YYYY')";

		
	}
	if(dcode != null && dName!=null && rDistrict.equals("00") && updateDate!=null)
	{
		//System.out.println("IN DISTRICT SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
        query="SELECT distinct d.dcode,D.DNAME,PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+dcode+"' and d.dname='"+dName+"' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+updateDate+"' order by d.dcode,TO_DATE(update_date,'DD-MON-YYYY')";
	}

	if(dcode == null && dName==null && !rDistrict.equals("00") && updateDate==null)
	{
		//System.out.println("IN DISTRICT SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
        query="SELECT distinct d.dcode,D.DNAME,PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' order by d.dcode,TO_DATE(update_date,'DD-MON-YYYY')";
		
		
	}
	
	rs = stmt.executeQuery(query);
	rs.last();
    Count = rs.getRow();
	System.out.println("Count is"+Count);
	rs.beforeFirst();
	if(request.getParameter("pass") !=  null) {
	pass = Integer.parseInt(request.getParameter("pass"));
     }
	if(Count!=0)
	 {
	 for(int j = pass; j < Count ; j++)
		 {
	     rs.absolute(j+1);
	 %>
	 <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
        <td class=rptValue><%=rs.getString(4)+'-'%><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(5)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
	  </tr>
	  <% 
		 rs.next();
		 }
	 }
	else
	{%>
	  <td align="center" class="rptHeading" colspan=12>There are no Records</td><br>
	  <p><a align=center href="./rws_hab_update_frm.jsp">GO BACK</a></p>
	  <%
	}
    rs.close(); rs1.close(); rs2.close(); rs3.close(); rs4.close(); rs5.close(); rs6.close(); rs7.close(); rs8.close(); rs9.close(); rs10.close(); rs11.close();
	stmt.close(); stmt1.close(); stmt2.close(); stmt3.close(); stmt4.close(); stmt5.close(); stmt6.close(); stmt7.close(); stmt8.close(); stmt9.close(); stmt10.close(); stmt11.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>

</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

