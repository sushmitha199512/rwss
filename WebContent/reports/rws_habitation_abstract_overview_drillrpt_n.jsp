<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%
String lpcdrange = request.getParameter("lpcdrange");
String poptype = request.getParameter("poptype");
String rDistrict = request.getParameter("rDistrict");
String finYear = request.getParameter("finyear");
String rMandal = "", rPanchayat = "", habTableName = "", year="", s="";
if(request.getParameter("rMandal")!= null && !request.getParameter("rMandal").equals("")){
	rMandal = request.getParameter("rMandal");
}
if(request.getParameter("rPanchayat")!= null && !request.getParameter("rPanchayat").equals("")){
	rPanchayat = request.getParameter("rPanchayat");
}
Calendar cal = Calendar.getInstance();
year = String.valueOf(cal.get(Calendar.YEAR));
int prevYear = Integer.parseInt(year.toString()) - 1;
s = finYear.substring(0, 4);
if (finYear.toString().substring(0, 4).equals(year.toString())) {
	habTableName = "RWS_HABITATION_DIRECTORY_TBL";

} else if (finYear.toString().substring(0, 4).equals(String.valueOf(prevYear))) {
	habTableName = "RWS_HABITATION_DIR_HIS_TBL";
} else {
	habTableName = "RWS_HABITATION_DIR_HIS" + s + "_TBL";
}
%>
<html>
	<head>
		<script type="text/javascript">	
			function viewWorks(URL){
				var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
				if(URL!=""){
					myNewWin = window.open(URL,'newWinddow',popFeatures);
					myNewWin.focus();	
				}	
			}
			
			function wopen(url, name, w, h){
				w += 32;
				h += 96;
			 	var win = window.open(url,
			  	name, 
			  	'width=' + w + ', height=' + h + ', ' +
			  	'location=yes, menubar=no, ' +
			  	'status=yes, toolbar=no, scrollbars=yes, resizable=yes'); 
			 	win.focus();
			}
		</script>
	</head>
	<body bgcolor="#edf2f8">		
		<div id="loading">
		  <img id="loading-image" src="../imagess/loading.gif" alt="Loading..." />
		</div>
		<table border=0 cellspacing=0 cellpadding=0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse"	bgcolor="#ffffff" align="center">
			<thead align="right">
				<!-- <tr>
					<th align="right" class="bwborder" colspan="35"><a href="../home.jsp">Home</a>|<a href="./rws_habitation_abstract_rpt1_excel.jsp" target=_new>Excel</a></th>
				</tr>
				 -->
				<tr bgcolor="#8A9FCD" align="center">
					<th align="center" class="gridhdbg" colspan="35">Habitation-Status-Abstract-Report</th>
				</tr>
				<tr align="center">
					<th class="gridhdbg" rowspan="02">Sno</th>
					<th class="gridhdbg" rowspan="02" align="Left">District Name</th>
					<th class="gridhdbg" rowspan="02" align="Left">Mandal Name</th>
					<th class="gridhdbg" rowspan="02" align="Left">Panchayat Name</th>
					<th class="gridhdbg" rowspan="02" align="Left">Village Name</th>
					<th class="gridhdbg" rowspan="02" align="Left">Habitation Name</th>
					<th class="gridhdbg" rowspan="02" align="Left">Habitation Code</th>
					<th class="gridhdbg" rowspan="02">Plain Population</th>	
					<th class="gridhdbg" rowspan="02">SC Population</th>
					<th class="gridhdbg" rowspan="02">ST Population</th>	
<!-- 					<th class="gridhdbg" rowspan="02">Minority Population</th>
 -->					<!-- <th class="gridhdbg" rowspan="02">Floating Population</th>  
					<th class="gridhdbg" rowspan="02">Reason for Floating Population</th> -->
					<th class="gridhdbg" rowspan="02">Total Population</th>
					<!-- <th class="gridhdbg" rowspan="02">Plain Population Covered</th>  
					<th class="gridhdbg" rowspan="02">SC Population. Covered</th>
					<th class="gridhdbg" rowspan="02">ST Population Covered</th> 	
					<th class="gridhdbg" rowspan="02">Total Population Covered</th>	
 -->					<th class="gridhdbg" rowspan="02">No. Of HouseConnections</th>
					<th class="gridhdbg" rowspan="02">No. Of HouseHolds</th>					
					<th class="gridhdbg" rowspan="02">No. Of Cattles</th>  
					<th class="gridhdbg" rowspan="02">No. Of Existing Sources</th>  
					<th class="gridhdbg" rowspan="02">No. Of Safe Sources</th>  
					<th class="gridhdbg" rowspan="02">UNSAFE LPCD</th>
					<th class="gridhdbg" rowspan="02">SAFE LPCD</th>
					<th class="gridhdbg" rowspan="02">PREVIOUS YEAR COVERAGE STATUS</th>  
					<th class="gridhdbg" rowspan="02">CURRENT YEAR COVERAGE STATUS</th>  
					<th class="gridhdbg" rowspan="02">LATITUDE</th>
					<th class="gridhdbg" rowspan="02">LONGITUDE</th> 
					<th class="gridhdbg" rowspan="02">ELEVATION</th>
					<th class="gridhdbg" rowspan="02">WAY POINT</th>
					<th class="gridhdbg" rowspan="02" align="Left">LANDMARK</th> 		
				</tr>
			</thead>
			<tbody>
				<%  	PreparedStatement ps1 = null;
						ResultSet rs1 = null;
						String style=null, query= null;
						int styleCount=1, sno=1;
					try{
						query="SELECT D.DNAME, M.MNAME, P.PNAME, V.VNAME, PR.PANCH_NAME, HD.ACT_PLAIN_POPU, HD.ACT_SC_POPU, HD.ACT_ST_POPU, HD.CENSUS_MINORITY_POPU, HD.FLOAT_POP, NVL(HD.FLOAT_POP_REASONS,'-'), HD.PLAIN_POPU_COVERED, HD.SC_POP_COVERED, HD.ST_POP_COVERED, HD.NO_OF_HOUSECONN_GIVEN, HD.HOUSEHOLDS_SC, HD.HOUSEHOLDS_ST, HD.HOUSEHOLDS_PLAIN, HD.HOUSEHOLDS_MINORITY, HD.NO_OF_CATTLE, HD.EXISTING_SOURCES_NO, HD.SAFE_SOURCES_NO, HD.UNSAFE_LPCD, HD.SAFE_LPCD, HD.PREVIOUS_YR_STATUS, HD.ACT_COVERAGE_STATUS, NVL(PR.LATITUDE,0.0), NVL(PR.LONGITUDE,0.0), NVL(PR.ELEVATION,0.0), NVL(PR.WAY_POINT,0), NVL(PR.LANDMARK,'-'), PR.PANCH_CODE FROM RWS_DISTRICT_TBL D, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_PANCHAYAT_RAJ_TBL PR, RWS_COMPLETE_HAB_VIEW H, "+habTableName+" HD WHERE  D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE =P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE AND SUBSTR (PR.PANCH_CODE,1,2) = V.DCODE AND SUBSTR(PR.PANCH_CODE,6,2) = V.MCODE AND SUBSTR(PR.PANCH_CODE,13,2) = V.PCODE AND SUBSTR (PR.PANCH_CODE,8,3) = V.VCODE AND PR.PANCH_CODE = HD.HAB_CODE AND H.PANCH_CODE=HD.HAB_CODE AND HD.ACT_COVERAGE_STATUS IS NOT NULL AND HD.ACT_COVERAGE_STATUS not in('UI','NW')";
						//query="SELECT D.DNAME, M.MNAME, P.PNAME, V.VNAME, PR.PANCH_NAME, HD.ACT_PLAIN_POPU, HD.ACT_SC_POPU, HD.ACT_ST_POPU, HD.CENSUS_MINORITY_POPU, HD.FLOAT_POP, NVL(HD.FLOAT_POP_REASONS,'-'), HD.PLAIN_POPU_COVERED, HD.SC_POP_COVERED, HD.ST_POP_COVERED, HD.NO_OF_HOUSECONN_GIVEN, HD.HOUSEHOLDS_SC, HD.HOUSEHOLDS_ST, HD.HOUSEHOLDS_PLAIN, HD.HOUSEHOLDS_MINORITY, HD.NO_OF_CATTLE, HD.EXISTING_SOURCES_NO, HD.SAFE_SOURCES_NO, HD.UNSAFE_LPCD, HD.SAFE_LPCD, HD.PREVIOUS_YR_STATUS, HD.ACT_COVERAGE_STATUS, NVL(PR.LATITUDE,0.0), NVL(PR.LONGITUDE,0.0), NVL(PR.ELEVATION,0.0), NVL(PR.WAY_POINT,0), NVL(PR.LANDMARK,'-'), PR.PANCH_CODE FROM RWS_DISTRICT_TBL D, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_PANCHAYAT_RAJ_TBL PR, RWS_COMPLETE_HAB_VIEW H, "+habTableName+" HD WHERE  D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE =P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE AND SUBSTR (PR.PANCH_CODE,1,2) = V.DCODE AND SUBSTR(PR.PANCH_CODE,6,2) = V.MCODE AND SUBSTR(PR.PANCH_CODE,13,2) = V.PCODE AND SUBSTR (PR.PANCH_CODE,8,3) = V.VCODE AND PR.PANCH_CODE = HD.HAB_CODE AND  HD.ACT_COVERAGE_STATUS IS NOT NULL AND HD.ACT_COVERAGE_STATUS not in('UI','NW')";

						/////////////query="SELECT D.DNAME, M.MNAME, P.PNAME, V.VNAME, PR.PANCH_NAME, HD.ACT_PLAIN_POPU, HD.ACT_SC_POPU, HD.ACT_ST_POPU, HD.CENSUS_MINORITY_POPU, HD.FLOAT_POP, NVL(HD.FLOAT_POP_REASONS,'-'), HD.PLAIN_POPU_COVERED, HD.SC_POP_COVERED, HD.ST_POP_COVERED, HD.NO_OF_HOUSECONN_GIVEN, HD.HOUSEHOLDS_SC, HD.HOUSEHOLDS_ST, HD.HOUSEHOLDS_PLAIN, HD.HOUSEHOLDS_MINORITY, HD.NO_OF_CATTLE, HD.EXISTING_SOURCES_NO, HD.SAFE_SOURCES_NO, HD.UNSAFE_LPCD, HD.SAFE_LPCD, HD.PREVIOUS_YR_STATUS, HD.ACT_COVERAGE_STATUS, NVL(PR.LATITUDE,0.0), NVL(PR.LONGITUDE,0.0), NVL(PR.ELEVATION,0.0), NVL(PR.WAY_POINT,0), NVL(PR.LANDMARK,'-'), PR.PANCH_CODE FROM RWS_DISTRICT_TBL D, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_PANCHAYAT_RAJ_TBL PR,  "+habTableName+" HD WHERE  D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE =P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE AND SUBSTR (PR.PANCH_CODE,1,2) = V.DCODE AND SUBSTR(PR.PANCH_CODE,6,2) = V.MCODE AND SUBSTR(PR.PANCH_CODE,13,2) = V.PCODE AND SUBSTR (PR.PANCH_CODE,8,3) = V.VCODE AND PR.PANCH_CODE = HD.HAB_CODE AND  HD.ACT_COVERAGE_STATUS IS NOT NULL AND HD.ACT_COVERAGE_STATUS not in('UI','NW')";
						
						//query="SELECT D.DNAME, M.MNAME, P.PNAME, V.VNAME, PR.PANCH_NAME, HD.ACT_PLAIN_POPU, HD.ACT_SC_POPU, HD.ACT_ST_POPU, HD.CENSUS_MINORITY_POPU, HD.FLOAT_POP, NVL(HD.FLOAT_POP_REASONS,'-'), HD.PLAIN_POPU_COVERED, HD.SC_POP_COVERED, HD.ST_POP_COVERED, HD.NO_OF_HOUSECONN_GIVEN, HD.HOUSEHOLDS_SC, HD.HOUSEHOLDS_ST, HD.HOUSEHOLDS_PLAIN, HD.HOUSEHOLDS_MINORITY, HD.NO_OF_CATTLE, HD.EXISTING_SOURCES_NO, HD.SAFE_SOURCES_NO, HD.UNSAFE_LPCD, HD.SAFE_LPCD, HD.PREVIOUS_YR_STATUS, HD.ACT_COVERAGE_STATUS, NVL(PR.LATITUDE,0.0), NVL(PR.LONGITUDE,0.0), NVL(PR.ELEVATION,0.0), NVL(PR.WAY_POINT,0), NVL(PR.LANDMARK,'-'), PR.PANCH_CODE FROM RWS_DISTRICT_TBL D, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_COMPLETE_HAB_VIEW PR,  "+habTableName+" HD WHERE  D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE =P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE AND SUBSTR (PR.PANCH_CODE,1,2) = V.DCODE AND SUBSTR(PR.PANCH_CODE,6,2) = V.MCODE AND SUBSTR(PR.PANCH_CODE,13,2) = V.PCODE AND SUBSTR (PR.PANCH_CODE,8,3) = V.VCODE AND PR.PANCH_CODE = HD.HAB_CODE AND  HD.ACT_COVERAGE_STATUS IS NOT NULL AND HD.ACT_COVERAGE_STATUS not in('UI','NW')";

						if(rDistrict != null && !rDistrict.equals("")){
							query += " AND D.DCODE= "+rDistrict;
						}
						if(rMandal != null && !rMandal.equals("")){
							query += " AND M.MCODE= "+rMandal;
						}
						if(rPanchayat != null && !rPanchayat.equals("")){
							query += " AND P.PCODE= "+rPanchayat;
						}
						
						//System.out.println("new$$$$$$$$$"+query);
						/* if (lpcdrange.toString().equals("55")) {
							if (poptype.toString() != null && !poptype.toString().equals("") && !poptype.toString().equals("ALL")) {
								if (poptype.toString().equals("SC")) {
									query += " and  (nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0'))<= hd.CENSUS_SC_POPU and  (nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0'))> hd.CENSUS_ST_POPU  ";
								} else if (poptype.toString().equals("ST")) {
									query += "  AND  (NVL(HD.CENSUS_PLAIN_POPU,'0')+NVL(HD.CENSUS_SC_POPU,'0')+NVL(HD.CENSUS_ST_POPU,'0'))<= HD.CENSUS_ST_POPU ";
								} else {
									query += " AND  (NVL(HD.CENSUS_PLAIN_POPU,'0')+NVL(HD.CENSUS_SC_POPU,'0')+NVL(HD.CENSUS_ST_POPU,'0'))> HD.CENSUS_SC_POPU AND  (40/100)*(NVL(HD.CENSUS_PLAIN_POPU,'0')+NVL(HD.CENSUS_SC_POPU,'0')+NVL(HD.CENSUS_ST_POPU,'0'))> HD.CENSUS_ST_POPU  ";
								}
							}
						}else{
							if (poptype.toString() != null && !poptype.toString().equals("") && !poptype.toString().equals("ALL")) {
								if (poptype.toString().equals("SC")) {
									query += " and  (nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0'))<= hd.CENSUS_SC_POPU and  (nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0'))> hd.CENSUS_ST_POPU  ";
								} else if (poptype.toString().equals("ST")) {
									query += "  AND  (NVL(HD.CENSUS_PLAIN_POPU,'0')+NVL(HD.CENSUS_SC_POPU,'0')+NVL(HD.CENSUS_ST_POPU,'0'))<= HD.CENSUS_ST_POPU ";
								} else {
									query += " AND  (NVL(HD.CENSUS_PLAIN_POPU,'0')+NVL(HD.CENSUS_SC_POPU,'0')+NVL(HD.CENSUS_ST_POPU,'0')> HD.CENSUS_SC_POPU AND  (40/100)*(NVL(HD.CENSUS_PLAIN_POPU,'0')+NVL(HD.CENSUS_SC_POPU,'0')+NVL(HD.CENSUS_ST_POPU,'0'))> HD.CENSUS_ST_POPU  ";
								}
							}
						} */
						if (lpcdrange.toString().equals("55")) {
							if (poptype.toString() != null && !poptype.toString().equals("") && !poptype.toString().equals("ALL")) {
								if (poptype.toString().equals("SC")) {
									query += " and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
								} else if (poptype.toString().equals("ST")) {
									query += "  AND  (NVL(HD.ACT_PLAIN_POPU,'0')+NVL(HD.ACT_SC_POPU,'0')+NVL(HD.ACT_ST_POPU,'0'))<= HD.ACT_ST_POPU ";
								} else {
									query += " AND  (NVL(HD.ACT_PLAIN_POPU,'0')+NVL(HD.ACT_SC_POPU,'0')+NVL(HD.ACT_ST_POPU,'0'))> HD.ACT_SC_POPU AND  (40/100)*(NVL(HD.ACT_PLAIN_POPU,'0')+NVL(HD.ACT_SC_POPU,'0')+NVL(HD.ACT_ST_POPU,'0'))> HD.ACT_ST_POPU  ";
								}
							}
						}else{
							if (poptype.toString() != null && !poptype.toString().equals("") && !poptype.toString().equals("ALL")) {
								if (poptype.toString().equals("SC")) {
									query += " and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
								} else if (poptype.toString().equals("ST")) {
									query += "  AND  (NVL(HD.ACT_PLAIN_POPU,'0')+NVL(HD.ACT_SC_POPU,'0')+NVL(HD.ACT_ST_POPU,'0'))<= HD.ACT_ST_POPU ";
								} else {
									query += " AND  (NVL(HD.ACT_PLAIN_POPU,'0')+NVL(HD.ACT_SC_POPU,'0')+NVL(HD.ACT_ST_POPU,'0')> HD.ACT_SC_POPU AND  (40/100)*(NVL(HD.ACT_PLAIN_POPU,'0')+NVL(HD.ACT_SC_POPU,'0')+NVL(HD.ACT_ST_POPU,'0'))> HD.ACT_ST_POPU  ";
								}
							}
						}

						query += " ORDER BY D.DNAME, M.MNAME, P.PNAME, V.VNAME, PR.PANCH_NAME";
						//System.out.println(query);
						//System.out.println("new$$$$$$$$$"+query);
						ps1 = conn.prepareStatement(query);
						rs1 = ps1.executeQuery();
						rs1.setFetchSize(10000);
						long t1 = System.currentTimeMillis();
						while(rs1.next()){							
							if (styleCount % 2 == 0) {
								style = "gridbg1";
							} else {
								style = "gridbg2";
							}
							styleCount++;
						
				%>
				<tr>
					<td class="<%=style%>"><%=sno++%></td>
					<td class="<%=style%>" style="text-align:left;"><%=rs1.getString(1)%></td>
					<td class="<%=style%>" style="text-align:left;"><%=rs1.getString(2)%></td>
					<td class="<%=style%>" style="text-align:left;"><%=rs1.getString(3)%></td>
					<td class="<%=style%>" style="text-align:left;"><%=rs1.getString(4)%></td>
					<td class="<%=style%>" style="text-align:left;"><%=rs1.getString(5)%></td>
					<td class="<%=style%>" style="text-align:left;"><%=rs1.getString(32)%></td>
					<td class="<%=style%>"><%=rs1.getString(6)%></td>
					<td class="<%=style%>"><%=rs1.getString(7)%></td>
					<td class="<%=style%>"><%=rs1.getString(8)%></td>
<%-- 					<td class="<%=style%>"><%=rs1.getString(9)%></td>
 --%><%-- 					<td class="<%=style%>"><%=rs1.getString(10)%></td>
					<td class="<%=style%>"><%=rs1.getString(11)%></td> --%>
					<td class="<%=style%>"><%=rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)%></td>
					<%-- <td class="<%=style%>"><%=rs1.getString(12)%></td>
					<td class="<%=style%>"><%=rs1.getString(13)%></td>
					<td class="<%=style%>"><%=rs1.getString(14)%></td>
					<td class="<%=style%>"><%=rs1.getInt(12)+rs1.getInt(13)+rs1.getInt(14)%></td>
					 --%><td class="<%=style%>"><%=rs1.getString(15)%></td>
					<td class="<%=style%>"><%=rs1.getInt(16)+rs1.getInt(17)+rs1.getInt(18)+rs1.getInt(19)%></td>
					<td class="<%=style%>"><%=rs1.getString(20)%></td>
					<td class="<%=style%>"><%=rs1.getString(21)%></td>
					<td class="<%=style%>"><%=rs1.getString(22)%></td>
					<td class="<%=style%>"><%=rs1.getString(23)%></td>
					<td class="<%=style%>"><%=rs1.getString(24)%></td>
					<td class="<%=style%>"><%=rs1.getString(25)%></td>
					<td class="<%=style%>"><%=rs1.getString(26)%></td>
					<td class="<%=style%>"><%=rs1.getString(27)%></td>
					<td class="<%=style%>"><%=rs1.getString(28)%></td>
					<td class="<%=style%>"><%=rs1.getString(29)%></td>
					<td class="<%=style%>"><%=rs1.getString(30)%></td>
					<td class="<%=style%>" style="text-align:left;"><%=rs1.getString(31)%></td>						
				</tr>
				<%}
						   //System.out.println("Time to iterate ResultSet -> " + (System.currentTimeMillis() - t1));
					}catch(Exception ex){
						ex.printStackTrace();
					}finally{
						if (rs1 != null) {
							rs1.close();
						}
						if (ps1 != null) {
							ps1.close();
						}
						if (conn != null) {
							conn.close();
						}						
					}
				%>			
				
				
			</tbody>	
		</table>	
	</body>
	<%@ include file="/reports/footer.jsp"%>
</html>
		
