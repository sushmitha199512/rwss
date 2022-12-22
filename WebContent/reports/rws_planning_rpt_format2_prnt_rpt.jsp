<%
	//java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<%@ include file = "conn.jsp" %>
<%
System.out.println("in print form");
	String rDistrict, rMandal, rPanchayat, rVillage, rHabitation = null;
	rDistrict = request.getParameter("rDistrict");
	System.out.println("in print form");
	rMandal = request.getParameter("rMandal");	
	System.out.println("in print form");
	
	System.out.println("in print form");
	int limitPerPage = 20;	
	int iPage = 0;
	String sPage = request.getParameter("pg");
	System.out.println("in print form");
	if(sPage != null && !sPage.equals("null"))
		iPage = Integer.parseInt(sPage);
	int pr = 1 ;
	System.out.println("in print form");
	int pg = 0;
	int pgCntNo = 0;
	int totalpgs = 0;
	String districtName = String.valueOf(session.getAttribute("districtName"));
	System.out.println("in print form"+districtName);
String mandalName = String.valueOf(session.getAttribute("mandalName"));	
	System.out.println("*****REPORT BEGINING*****"+rMandal);
	System.out.println("in print form"+mandalName);
	
	String query=null, query1 = null, query2 = null, query3 = null, query4 = null, query5 = null, query6 = null, query7 = null, query8 = null, query9 = null, query10 = null, query11 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null;
	Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, stmt7 = null, stmt8 = null, stmt9 = null, stmt10 = null, stmt11 = null ;
	int slno = 0;
	int Count = 0, LCount = 0, NOP = 0;	

%>
<html>
<head>
<script language="JavaScript">
	window.history.forward(1);
</script>

</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post" action="./rws_planning_format2_rpt.jsp">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
<%@ include file="./rws_planning_format2_label.jsp"%>

<%	
try
{
	if(rDistrict != null && rDistrict.equals("00"))
	{
		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		query ="SELECT DISTINCT D.DCODE, D.DNAME, M.MCODE, M.MNAME,sum(case when hd.coverage_status='NC' then 1 else 0 end) as nc,sum(case when hd.coverage_status='PC1' then 1 else 0 end) as pc1,sum(case when hd.coverage_status='PC2' then 1 else 0 end) as pc2,sum(case when hd.coverage_status='PC3' then 1 else 0 end) as pc3,sum(case when hd.coverage_status='PC4' then 1 else 0 end) as pc4,sum(case when hd.coverage_status='FC' then 1 else 0 end) as fc,sum(case when hd.coverage_status='NSS_Fl' then 1 else 0 end) as nss_fl,sum(case when hd.coverage_status='NSS_Br' then 1 else 0 end) as nss_br,sum(case when hd.coverage_status='NSS_Ir' then 1 else 0 end) as nss_ir,sum(case when hd.coverage_status='NSS_Others' then 1 else 0 end) as nss_others,count(*)FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_MANDAL_TBL M  WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND (substr(hd.hab_code,1,2)=m.dcode and SUBSTR(HD.HAB_CODE,6,2) = M.MCODE)  group BY D.DCODE,D.DNAME,M.MCODE,M.MNAME";

	}
	if(rDistrict != null && !rDistrict.equals("00") && !rDistrict.equals("-1") && rMandal.equals("-1"))
	{
		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		query="SELECT DISTINCT D.DCODE, D.DNAME, M.MCODE, M.MNAME,sum(case when hd.coverage_status='NC' then 1 else 0 end) as nc,sum(case when hd.coverage_status='PC1' then 1 else 0 end) as pc1,sum(case when hd.coverage_status='PC2' then 1 else 0 end) as pc2,sum(case when hd.coverage_status='PC3' then 1 else 0 end) as pc3,sum(case when hd.coverage_status='PC4' then 1 else 0 end) as pc4,sum(case when hd.coverage_status='FC' then 1 else 0 end) as fc,sum(case when hd.coverage_status='NSS_Fl' then 1 else 0 end) as nss_fl,sum(case when hd.coverage_status='NSS_Br' then 1 else 0 end) as nss_br,sum(case when hd.coverage_status='NSS_Ir' then 1 else 0 end) as nss_ir,sum(case when hd.coverage_status='NSS_Others' then 1 else 0 end) as nss_others,count(*) FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_MANDAL_TBL M  WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND substr(hd.hab_code,1,2)=m.dcode andSUBSTR(HD.HAB_CODE,6,2) = M.MCODE  AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"'  group BY D.DCODE,D.DNAME,M.MCODE,M.MNAME";


		
	}
	if(rDistrict != null && !rDistrict.equals("00")&& !rDistrict.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
	{
		//System.//out.println("IN MANDAL ALL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
        query="SELECT DISTINCT D.DCODE, D.DNAME, M.MCODE, M.MNAME,sum(case when hd.coverage_status='NC' then 1 else 0 end) as nc,sum(case when hd.coverage_status='PC1' then 1 else 0 end) as pc1,sum(case when hd.coverage_status='PC2' then 1 else 0 end) as pc2,sum(case when hd.coverage_status='PC3' then 1 else 0 end) as pc3,sum(case when hd.coverage_status='PC4' then 1 else 0 end) as pc4,sum(case when hd.coverage_status='FC' then 1 else 0 end) as fc,sum(case when hd.coverage_status='NSS_Fl' then 1 else 0 end) as nss_fl,sum(case when hd.coverage_status='NSS_Br' then 1 else 0 end) as nss_br,sum(case when hd.coverage_status='NSS_Ir' then 1 else 0 end) as nss_ir,sum(case when hd.coverage_status='NSS_Others' then 1 else 0 end) as nss_others,count(*) FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_MANDAL_TBL M  WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND substr(hd.hab_code,1,2)=m.dcode AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"'   group BY D.DCODE,D.DNAME,M.MCODE,M.MNAME";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00"))
	{
		//System.//out.println("IN MANDAL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		query="SELECT DISTINCT D.DCODE, D.DNAME, M.MCODE, M.MNAME,sum(case when hd.coverage_status='NC' then 1 else 0 end) as nc,sum(case when hd.coverage_status='PC1' then 1 else 0 end) as pc1,sum(case when hd.coverage_status='PC2' then 1 else 0 end) as pc2,sum(case when hd.coverage_status='PC3' then 1 else 0 end) as pc3,sum(case when hd.coverage_status='PC4' then 1 else 0 end) as pc4,sum(case when hd.coverage_status='FC' then 1 else 0 end) as fc,sum(case when hd.coverage_status='NSS_Fl' then 1 else 0 end) as nss_fl,sum(case when hd.coverage_status='NSS_Br' then 1 else 0 end) as nss_br,sum(case when hd.coverage_status='NSS_Ir' then 1 else 0 end) as nss_ir,sum(case when hd.coverage_status='NSS_Others' then 1 else 0 end) as nss_others,count(*)FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_MANDAL_TBL M  WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND substr(hd.hab_code,1,2)=m.dcode AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"'  group BY D.DCODE,D.DNAME,M.MCODE,M.MNAME";


	}	
	rs = stmt.executeQuery(query);
	 while(rs.next())
	{%>
		<tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue align="right"><%=rs.getInt(5)%></td>
		<td class=rptValue align="right"><%=rs.getInt(6)%></td>
		<td class=rptValue align="right"><%=rs.getInt(7)%></td>
		<td class=rptValue align="right"><%=rs.getInt(8)%></td>
		<td class=rptValue align="right"><%=rs.getInt(9)%></td>
		<td class=rptValue align="right"><%=rs.getInt(10)%></td>
		<td class=rptValue align="right"><%=rs.getInt(11)%></td>
		<td class=rptValue align="right"><%=rs.getInt(12)%></td>
		<td class=rptValue align="right"><%=rs.getInt(13)%></td>
		<td class=rptValue align="right"><%=rs.getInt(14)%></td>		
		<td class=rptValue align="right"><%=rs.getInt(15)%></td>	
	</tr>
   <%
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}%>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp"%>


