<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%@ include file = "conn.jsp" %>
<%
	//.out.println("***********************REPORT BEGINING***********************");
	String rDistrict="", rConstituency, rMandal, rPanchayat, rVillage, distvalue, distname, convalue, conname = null;
	rDistrict = request.getParameter("rDistrict");
	System.out.println("contituency report rdistrict "+rDistrict);	
	String district=request.getParameter("district");
	distname=request.getParameter("distname");
	rMandal = request.getParameter("rMandal");
	rPanchayat = request.getParameter("rPanchayat");
	rVillage = request.getParameter("rVillage");
	rConstituency = request.getParameter("rConstituency");
	distvalue = request.getParameter("distvalue");
	distname = request.getParameter("distname");
	String districtName = (String)session.getAttribute("districtName");
	String mandalName = (String)session.getAttribute("mandalName");
	String panchayatName = (String)session.getAttribute("panchayatName");
	String villageName = (String)session.getAttribute("villageName");
	String constituencyName = (String)session.getAttribute("constituencyName");		
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs2=null;
	Statement stmt1 = null;
	Statement stmt2 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	int[] gcount = new int[8];
	int[] gcount1= new int[8];
	String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4"};
	//System.out.println("contituency report start 0");	
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

<form name="f1" method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<%
	//stmt = conn.createStatement();
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	if(rDistrict!=null && rDistrict.equals("00"))
	{
	//System.out.println("inside the query");
		query2="SELECT C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME, SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC, SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1, SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2, SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3, SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL RAJ where HD.HAB_CODE=RAJ.PANCH_CODE AND (SUBSTR(HD.HAB_CODE,1,2) = C.DCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE and constituency_type='A') and substr(HD.hab_code,1,2)='"+district+"' and hd.coverage_status is not null and hd.coverage_status<>'UI' GROUP BY C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME";
		//System.out.println("inside the query"+query2);
	}
	//rs = stmt.executeQuery(query);
	//System.out.println("qyr: :"+query2);	
	rs2 = stmt1.executeQuery(query2);
	
%>
<%@ include file="./rws_const_coverage_status_constituency_label.jsp"%>
	
<%	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
	System.out.println("out of include1 ");
	while(rs2.next())
	{
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>

<%//System.out.println("out of include10 "+rDistrict);
	if(!rDistrict.equals("") && rDistrict.equals("00"))
	{			
		//System.out.println("out of include11 ");
%>
		<td class=rptValue><%=rs2.getString(2)%></td>
<%
		}
		//System.out.println("out of include 12");
		%>
		
			<td class=rptValue><%=rs2.getInt(10)%></td>
			<td class=rptValue><%=rs2.getInt(3)%></td>
			<% fcTotal+=rs2.getInt(3); %>
			<td class=rptValue><%=rs2.getInt(4)%></td>
			<% ncTotal+=rs2.getInt(4); %>
			<td class=rptValue><%=rs2.getInt(5)%></td>
			<% nssTotal+=rs2.getInt(5); %>
			<td class=rptValue><%=rs2.getInt(6)%></td>
			<% pc1Total+=rs2.getInt(6); %>
			<td class=rptValue><%=rs2.getInt(7)%></td>
			<% pc2Total+=rs2.getInt(7); %>
			<td class=rptValue><%=rs2.getInt(8)%></td>
			<% pc3Total+=rs2.getInt(8); %>
			<td class=rptValue><%=rs2.getInt(9)%></td>
			<% pc4Total+=rs2.getInt(9); %>
			</tr>
<%
			}//end of while
			rs2.close();
			int grandtotal=0;
            grandtotal=fcTotal+ncTotal+nssTotal+pc1Total+pc2Total+pc3Total+pc4Total+uiTotal;
  
			%>
			
</tr>
	<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=rptValue><font color="blue"><%=grandtotal%></font></td>
		<td class=rptValue><%=fcTotal%></td>
		<td class=rptValue><%=ncTotal%></td>
		<td class=rptValue><%=nssTotal%></td>
		<td class=rptValue><%=pc1Total%></td>
		<td class=rptValue><%=pc2Total%></td>
		<td class=rptValue><%=pc3Total%></td>
		<td class=rptValue><%=pc4Total%></td>

	</tr>
</table>
<%
	
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
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
