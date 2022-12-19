<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//.out.println("***********************REPORT BEGINING***********************");
	String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, distvalue, distname, convalue, conname, manvalue, manname, panvalue, panname = null;
	rDistrict = request.getParameter("rDistrict");
	rMandal = request.getParameter("rMandal");
	rPanchayat = request.getParameter("rPanchayat");
	rVillage = request.getParameter("rVillage");
	rConstituency = request.getParameter("rConstituency");
	distvalue = request.getParameter("distvalue");
	distname = request.getParameter("distname");
	convalue = request.getParameter("convalue");
	conname = request.getParameter("conname");
	manvalue = request.getParameter("manvalue");
	manname = request.getParameter("manname");	
	System.out.println("canname m"+rMandal); 
	System.out.println("canname p"+rPanchayat);
	System.out.println("canname v"+rVillage );
	System.out.println("canname c"+rConstituency);
	System.out.println("rDistrict"+rDistrict);
	System.out.println("distvalue"+distvalue);
	System.out.println("distName"+distname);
	System.out.println("convalue"+convalue);
	System.out.println("canname"+conname);
	
	String districtName = (String)session.getAttribute("districtName");
	String mandalName = (String)session.getAttribute("mandalName");
	String panchayatName = (String)session.getAttribute("panchayatName");
	String villageName = (String)session.getAttribute("villageName");
	String constituencyName = (String)session.getAttribute("constituencyName");		
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs2=null;
	Statement stmt1 = null;
	PreparedStatement pstmt = null;
	int slno = 0;
	int i = 0;
	int[] gcount = new int[8];
	int[] gcount1= new int[8];
	String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4"};
	int total=0;
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

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="98%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_const_coverage_status_frm.jsp">Back|</a></td>
				<td class="bwborder"><a href="../home.jsp">Home|</a></td>
				<td class="bwborder"><a href="./rws_const_coverage_status_panchayat_xls.jsp?distvalue=<%=distvalue%>&distname=<%=distname%>&convalue=<%=convalue%>&conname=<%=conname%>&manvalue=<%=manvalue %>&manname=<%=manname %>&district=<%=rDistrict%>&constituency=<%=rConstituency%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>" target="_new">Excel</a></td>
				<!--<td class="bwborder"><a href="./constituency_excelprnt.jsp?district=<%=rDistrict%>&constituency=<%=rConstituency%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>" target="_new">Print</a></td>-->
			</tr>
		</table>
	</caption>
<% 
	//stmt = conn.createStatement();
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	if(rDistrict != null && rDistrict.equals("00"))
	{
		query2="SELECT DISTINCT P.PCODE,P.PNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD ,RWS_PANCHAYAT_RAJ_TBL RAJ where HD.HAB_CODE=RAJ.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +distvalue+ "' AND  SUBSTR(HD.HAB_CODE,6,2) = P.MCODE and P.MCODE ='" +manvalue+ "' AND  SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+convalue+ "' and C.DCODE = P.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE  and hd.coverage_status is not null and hd.coverage_status<>'UI' GROUP BY P.PCODE,P.PNAME";//code added into the query and UI field is removed
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		query2="SELECT DISTINCT P.PCODE,P.PNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*)FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD ,RWS_PANCHAYAT_RAJ_TBL RAJ where HD.HAB_CODE=RAJ.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND  SUBSTR(HD.HAB_CODE,6,2) = P.MCODE and P.MCODE ='" +manvalue+ "' AND  SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+convalue+ "' and C.DCODE = P.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE and hd.coverage_status is not null and hd.coverage_status<>'UI' GROUP BY P.PCODE,P.PNAME";
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
		query2="SELECT DISTINCT P.PCODE,P.PNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD ,RWS_PANCHAYAT_RAJ_TBL RAJ where HD.HAB_CODE=RAJ.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND  SUBSTR(HD.HAB_CODE,6,2) = P.MCODE and P.MCODE ='" +manvalue+ "' AND  SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+convalue+ "' and C.DCODE = P.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE and hd.coverage_status is not null and hd.coverage_status<>'UI' GROUP BY P.PCODE,P.PNAME";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		query2="SELECT DISTINCT P.PCODE,P.PNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD ,RWS_PANCHAYAT_RAJ_TBL RAJ where HD.HAB_CODE=RAJ.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND  SUBSTR(HD.HAB_CODE,6,2) = P.MCODE and P.MCODE ='" +manvalue+ "' AND  SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and C.DCODE = P.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE and hd.coverage_status is not null and hd.coverage_status<>'UI' GROUP BY P.PCODE,P.PNAME";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		query2="SELECT DISTINCT P.PCODE,P.PNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD ,RWS_PANCHAYAT_RAJ_TBL RAJ where HD.HAB_CODE=RAJ.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND  SUBSTR(HD.HAB_CODE,6,2) = P.MCODE and P.MCODE ='" +manvalue+ "' AND  SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '"+rConstituency+ "' and C.DCODE = P.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE  and hd.coverage_status is not null and hd.coverage_status<>'UI' GROUP BY P.PCODE,P.PNAME";
	}
	
	rs2 = stmt1.executeQuery(query2);
%>
<%@ include file="./rws_const_coverage_status_panchayat_label.jsp"%>
<%		
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
	while(rs2.next())
	{
		++ slno;
	
%>		<tr>
		<td class=rptValue><%=slno%></td>
<%
		if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1"))
		{			
%>
		<td class=rptValue><a href="./rws_const_coverage_status_village_rpt.jsp?distvalue=<%=distvalue%>&distname=<%=distname%>&convalue=<%=convalue%>&conname=<%=conname%>&manvalue=<%=manvalue%>&manname=<%=manname%>&panvalue=<%=rs2.getString(1)%>&panname=<%=rs2.getString(2)%>&rDistrict=<%=rDistrict%>&rMandal=<%=rMandal%>&rPanchayat=<%=rPanchayat%>&rVillage=<%=rVillage%>&rConstituency=<%=rConstituency%>"><%=rs2.getString(2)%></a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{			
%>
		<td class=rptValue><a href="./rws_const_coverage_status_village_rpt.jsp?rDistrict=<%=rDistrict%>&rMandal=<%=rMandal%>&rPanchayat=<%=rPanchayat%>&rVillage=<%=rVillage%>&rConstituency=<%=rConstituency%>&distvalue=<%=distvalue%>&distname=<%=distname%>&conname=<%=conname%>&convalue=<%=convalue%>&manname=<%=manname%>&manvalue=<%=manvalue%>&panvalue=<%=rs2.getString(1)%>&panname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && rConstituency.equals("00") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{			
%>
		<td class=rptValue><a href="./rws_const_coverage_status_village_rpt.jsp?rDistrict=<%=rDistrict%>&rMandal=<%=rMandal%>&rPanchayat=<%=rPanchayat%>&rVillage=<%=rVillage%>&rConstituency=<%=rConstituency%>&distvalue=<%=distvalue%>&distname=<%=distname%>&conname=<%=conname%>&convalue=<%=convalue%>&manname=<%=manname%>&manvalue=<%=manvalue%>&panvalue=<%=rs2.getString(1)%>&panname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1")) 
		{			
%>
		<td class=rptValue><a href="./rws_const_coverage_status_village_rpt.jsp?rDistrict=<%=rDistrict%>&rMandal=<%=rMandal%>&rPanchayat=<%=rPanchayat%>&rVillage=<%=rVillage%>&rConstituency=<%=rConstituency%>&distvalue=<%=distvalue%>&distname=<%=distname%>&convalue=<%=convalue%>&conname=<%=conname%>&manvalue=<%=manvalue%>&manname=<%=manname%>&panvalue=<%=rs2.getString(1)%>&panname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && rPanchayat.equals("-1") && rVillage.equals("-1") && rMandal.equals("00")) 
		{			
%>
		<td class=rptValue><a href="./rws_const_coverage_status_village_rpt.jsp?rDistrict=<%=rDistrict%>&rMandal=<%=rMandal%>&rPanchayat=<%=rPanchayat%>&rVillage=<%=rVillage%>&rConstituency=<%=rConstituency%>&distvalue=<%=distvalue%>&distname=<%=distname%>&convalue=<%=convalue%>&conname=<%=conname%>&manvalue=<%=manvalue%>&manname=<%=manname%>&panvalue=<%=rs2.getString(1)%>&panname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
<%
		}
%>
		
			<td class=btext><%=rs2.getInt(10)%></td>
			<td class=rptValue><%=rs2.getString(3)%></td>
			<% fcTotal+=rs2.getInt(3); %>
			<td class=rptValue><%=rs2.getString(4)%></td>
			<% ncTotal+=rs2.getInt(4); %>
			<td class=rptValue><%=rs2.getString(5)%></td>
			<% nssTotal+=rs2.getInt(5); %>
			<td class=rptValue><%=rs2.getString(6)%></td>
			<% pc1Total+=rs2.getInt(6); %>
			<td class=rptValue><%=rs2.getString(7)%></td>
			<% pc2Total+=rs2.getInt(7); %>
			<td class=rptValue><%=rs2.getString(8)%></td>
			<% pc3Total+=rs2.getInt(8); %>
			<td class=rptValue><%=rs2.getString(9)%></td>
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
  		<%-- <td class=btext><%=uiTotal%></td>--%> 
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
