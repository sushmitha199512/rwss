<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("***********************REPORT BEGINING***********************");
	String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, distvalue, distname, convalue, conname, manvalue, manname, panvalue, panname, vilvalue, vilname = null;
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rVillage = request.getParameter("village");
	rConstituency = request.getParameter("constituency");
	distvalue = request.getParameter("distvalue");
	distname = request.getParameter("distname");
	convalue = request.getParameter("convalue");
	conname = request.getParameter("conname");
	manvalue = request.getParameter("manvalue");
	manname = request.getParameter("manname");
	panvalue = request.getParameter("panvalue");
	panname = request.getParameter("panname");
	vilvalue = request.getParameter("vilvalue");
	vilname = request.getParameter("vilname");
	String districtName = (String)session.getAttribute("districtName");
	String mandalName = (String)session.getAttribute("mandalName");
	String panchayatName = (String)session.getAttribute("panchayatName");
	String villageName = (String)session.getAttribute("villageName");
	String constituencyName = (String)session.getAttribute("constituencyName");		
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs2=null;
	Statement stmt1 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	//int[] gcount = new int[8];
	//int[] gcount1= new int[8];
	//String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4","UI"};
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
	System.out.println("rDistrict "+rDistrict+" rConstituency "+rConstituency+" rMandal " +rMandal+" rPanchayat "+rPanchayat+" rVillage "+rVillage);
	stmt1= conn.createStatement();
	if(!rDistrict.equals("") && rDistrict.equals("00"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +distvalue+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +manvalue+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +panvalue+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +convalue+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +manvalue+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +panvalue+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +convalue+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +manvalue+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +panvalue+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +convalue+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +manvalue+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +panvalue+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +manvalue+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +panvalue+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +panvalue+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("00") && !rPanchayat.equals("-1"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +panvalue+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && rVillage.equals("-1"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		query2="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +vilvalue+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and hd.coverage_status is not null and hd.coverage_status!='UI' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}

	rs2 = stmt1.executeQuery(query2);
%>
<%@ include file="./rws_const_coverage_status_habitation_label.jsp"%>
<%		
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
	while(rs2.next())
	{
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
<%
		if(!rDistrict.equals("") && rDistrict.equals("00") && rConstituency.equals("-1") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1"))
		{		
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>
<%
		}
		if(!rDistrict.equals("") && !rDistrict.equals("00") && rConstituency.equals("-1") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{	
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>
<%
		}
		if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && rConstituency.equals("00") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{		
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>
<%
		}
		if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{	
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>
<%
		}
		if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{	
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>
<%
		}
		if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{		
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>	
<%
		}
		if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && rPanchayat.equals("00") && rVillage.equals("-1"))
		{
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>
<%
		}
		if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
		{
			
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>
<%
		}
		if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
		{
%>
		<td class=rptValue><%=rs2.getString(2)%><%="-"%><%=rs2.getString(1)%></td>
<%
		}
%>
		
		<td class=btext><%=rs2.getInt(10)%></td>
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
        grandtotal=fcTotal+ncTotal+nssTotal+pc1Total+pc2Total+pc3Total+pc4Total;
	
%>
</tr>
	<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext><font color="blue"><%=grandtotal%></font></td>
		<td class=btext><%=fcTotal%></td>
		<td class=btext><%=ncTotal%></td>
		<td class=btext><%=nssTotal%></td>
		<td class=btext><%=pc1Total%></td>
		<td class=btext><%=pc2Total%></td>
		<td class=btext><%=pc3Total%></td>
		<td class=btext><%=pc4Total%></td>

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
