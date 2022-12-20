<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("&&&&&&&&&&&&&&&&&&&REPORT BEGINING&&&&&&&&&&&&&&&&&&&");
	String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, value, name, convalue, conname = null;
	rDistrict = request.getParameter("rDistrict");
	rMandal = request.getParameter("rMandal");
	rPanchayat = request.getParameter("rPanchayat");
	rVillage = request.getParameter("rVillage");
	rConstituency = request.getParameter("rConstituency");
	value = request.getParameter("value");
	name = request.getParameter("name");
	//System.out.println("rDistrict = " +rDistrict);
	//System.out.println("rConstituency = " +rConstituency);
	//System.out.println("rMandal = " +rMandal);
	//System.out.println("rPanchayat = " +rPanchayat);
	//System.out.println("rVillage = " +rVillage);
	//System.out.println("value = " + value);
	//System.out.println("name = " + name);	
	String districtName = (String)session.getAttribute("districtName");
	String mandalName = (String)session.getAttribute("mandalName");
	String panchayatName = (String)session.getAttribute("panchayatName");
	String villageName = (String)session.getAttribute("villageName");
	String constituencyName = (String)session.getAttribute("constituencyName");		
	String query=null, query1 = null;
	ResultSet rs1 = null;
	Statement stmt1 = null;
	PreparedStatement pstmt = null;
	int slno = 0;
	int i = 0;
	int gcount = 0;
	String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4","UI"};
try
{
%>
<html>
<head>
</head>
<body bgcolor="#edf2f8">

<form name=f1 action="./rws_const_coverage_district_rpt.jsp">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<!-- <td class="bwborder"><a href="./rws_const_coverage_status_frm.jsp">Back |</a></td> -->
				<!-- <td class="bwborder"><a href="../home.jsp">Home |</a></td> -->
				<td class="bwborder"><a href="">Print |</a></td>
				<td class="bwborder"><a href="">Excel</a></td>
			</tr>
		</table>
	</caption>


<% 
	stmt = conn.createStatement();
	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		//System.out.println("IN DISTRICT ALL SELECTION...");		
		query = "SELECT C.CONSTITUENCY_NAME, C.CONSTITUENCY_CODE FROM RWS_CONSTITUENCY_TBL C WHERE C.DCODE = '" +value+ "' ORDER BY C.CONSTITUENCY_CODE";
		//System.out.println("query = " + query);
	}	
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY SELECTION...");		
		query = "SELECT DISTINCT M.MNAME, M.MCODE FROM RWS_MANDAL_TBL M, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY M.MCODE";		
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL ALL SELECTION...");		
		query = "SELECT DISTINCT M.MNAME, M.MCODE FROM RWS_MANDAL_TBL M, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY M.MCODE";		
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && rPanchayat.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL SELECTION...");		
		query = "SELECT DISTINCT P.PNAME, P.PCODE FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND P.MCODE = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,6,2) = P.MCODE AND C.DCODE = P.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY P.PCODE";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && rPanchayat.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT ALL SELECTION...");		
		query = "SELECT DISTINCT P.PNAME, P.PCODE FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND P.MCODE = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,6,2) = P.MCODE AND C.DCODE = P.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY P.PCODE";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT SELECTION...");		
		query = "SELECT DISTINCT V.VNAME, V.VCODE FROM RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = V.DCODE AND V.DCODE = '" +rDistrict+ "' AND V.MCODE = '" +rMandal+ "' AND V.PCODE = '" +rPanchayat+ "' AND SUBSTR(H.HAB_CODE,6,2) = V.MCODE AND C.DCODE = V.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY V.VCODE";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT, VILLAGE ALL SELECTION...");	
		query = "SELECT DISTINCT V.VNAME, V.VCODE FROM RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = V.DCODE AND V.DCODE = '" +rDistrict+ "' AND V.MCODE = '" +rMandal+ "' AND V.PCODE = '" +rPanchayat+ "' AND SUBSTR(H.HAB_CODE,6,2) = V.MCODE AND C.DCODE = V.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY V.VCODE";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT, VILLAGE SELECTION...");	
		query = "SELECT DISTINCT P.PANCH_NAME, H.HAB_CODE FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H, RWS_PANCHAYAT_RAJ_TBL P WHERE H.HAB_CODE = P.PANCH_CODE AND SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(H.HAB_CODE,8,3) = '" +rVillage+ "' AND C.DCODE = SUBSTR(H.HAB_CODE,1,2) AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY H.HAB_CODE";
	}


	
	rs = stmt.executeQuery(query);
%>
	<%@ include file="./rws_const_coverage_status_district_label.jsp"%>
	<tr bgcolor="#ffffff">
<%		
	while(rs.next())
	{
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><a href="./rws_const_coverage_status_constituency_rpt.jsp?rDistrict=<%=rDistrict%>&rMandal=<%=rMandal%>&rPanchayat=<%=rPanchayat%>&rVillage=<%=rVillage%>&rConstituency=<%=rConstituency%>&convalue=<%=rs.getString(2)%>&conname=<%=rs.getString(1)%>&value=<%=value%>&name=<%=name%>" target=_new><%=rs.getString(1)%></a></td>		
<%

try
{
		for (i=0; i<coveragestatus.length; i++)
		{			
			if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" + value + "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}			
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("-1"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" + rDistrict + "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" + rDistrict + "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" + rDistrict + "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,13,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && rPanchayat.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" + rDistrict + "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,13,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" + rDistrict + "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,8,3) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" + rDistrict + "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,8,3) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE H.HAB_CODE = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			pstmt = conn.prepareStatement(query1);
			//pstmt.setString(1,rs.getString(2));
			pstmt.setString(1,coveragestatus[i]);
			rs1 = pstmt.executeQuery();
			if (rs1.next())
			{		
				gcount += rs1.getInt(1);
%>
				<td class=rptValue><%=rs1.getString(1)%></td>
<%
			}
			else
			{
%>
		<td class=rptValue>0</td>
<%
			}

		}
		
}
catch(Exception e)
{
	//System.out.println(e);
}
		rs1.close();
		pstmt.close();
		
%>
	</tr>
<%
	}
%>

</table>
<%	
}
catch(Exception e)
{
	//System.out.println("The Error Is In rws_const_coverage_status_rpt.jsp" +e);
}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
<%
	conn.close();
%>