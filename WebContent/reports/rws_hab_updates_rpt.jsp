<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	
	String rDistrict = String.valueOf(session.getAttribute("districtCode"));
	String distname=String.valueOf(session.getAttribute("districtName"));
	String dcode=null,dName=null, updateDate=null;
	dcode=request.getParameter("dcode");
	int pass=0;
	dName = request.getParameter("dName");
	updateDate=request.getParameter("updateDate");
		
	String query=null, query1 = null;
	ResultSet rs1 = null;
	Statement stmt1 = null;
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
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
 <caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		<tr align="right">
			<td class="bwborder"><a href="./rws_hab_updates_frm.jsp">Back </a>|</td>
			<td class="bwborder"><a href="../home.jsp">Home </a>|</td>
			<td class="bwborder"><a href="./rws_hab_updates_rpt_xls.jsp?dcode=<%=dcode%>&districtName=<%=distname%>&districtCode=<%=rDistrict%>&dName=<%=dName%>
			&updateDate=<%=updateDate%>&pass=<%=pass%>" target="_new">Excel</a></td>
 			<%--<td class="bwborder"><a href="./rws_excel_xls_prnt.jsp?dcode=<%=dcode%>&rDistrict=<%=rDistrict%>&dName=<%=dName%>
			&updateDate=<%=updateDate%>" target="_new">Print |</a></td>--%>
		</tr>
	 </table>
  </caption>

    <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="12">District-Habitation-Report</td>	
	</tr>
<% 
	if(rDistrict!= null && rDistrict.equals("00") && dName==null)
	{
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan="14">District: All</td>	
	</tr>	
<%
	}
	if(rDistrict.equals("00") && rDistrict!= null && dName!=null)
	{
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan="14">District: <%=dName%></td>	
	</tr>	
<%
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && distname!=null)
	{
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan="14">District: <%=distname%></td>	
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
<%	try{
    if(dcode == null && dName==null && rDistrict.equals("00") && updateDate!=null)
	{
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="SELECT DISTINCT D.DCODE, D.DNAME, PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and update_date is not null and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+updateDate+"' and hd.coverage_status is not null and hd.coverage_status<>'UI' ORDER BY D.DCODE,TO_DATE(update_date,'DD-MON-YYYY')";
	}
   /* if(dcode != null && dName!=null && rDistrict.equals("00") && updateDate==null)
	{
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		/*query="SELECT DISTINCT D.DCODE, D.DNAME, PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and update_date is not null ORDER BY D.DCODE,TO_DATE(update_date,'DD-MON-YYYY')";
	}*/
	if(dcode != null && dName!=null && rDistrict.equals("00") && updateDate!=null)
	{
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	   query="SELECT distinct d.dcode,D.DNAME,PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+dcode+"' and d.dname='"+dName+"' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+updateDate+"' and hd.coverage_status is not null and hd.coverage_status<>'UI' order by d.dcode,TO_DATE(update_date,'DD-MON-YYYY')";
	}
	if(dcode == null && dName==null && !rDistrict.equals("00") && updateDate!=null)
	{
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	   query="SELECT distinct d.dcode,D.DNAME,PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+updateDate+"' and hd.coverage_status is not null and hd.coverage_status<>'UI' order by d.dcode,TO_DATE(update_date,'DD-MON-YYYY')";
	}
	
	rs = stmt.executeQuery(query);
	rs.last();
    Count = rs.getRow();
	
	rs.beforeFirst();
	if(request.getParameter("pass") !=  null)
	{
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
	{
%>
   <td align="center" class="rptHeading" colspan=12><a align=center href="./rws_hab_updates_frm.jsp">There are no Records</a></td>
<%
	}
	}catch(Exception e)
	{
	try{
    rs.close(); 
	stmt.close(); 
	}catch(Exception e1){}
	}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
	try{
		conn.close();
		}catch(Exception e)
		{}
	}
%>
</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

