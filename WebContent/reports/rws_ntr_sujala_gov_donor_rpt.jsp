<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormat.*"%>
<%@ include file="/reports/conn.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	DecimalFormat formatter = new DecimalFormat("##,##,##,###");

	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Status of Water Purification Plants installed through
	Donors/Government Report</title>
<style type="text/css">
.gridhdbg {
	padding: 5px 5px;
}

.gridhdbg12 {
	padding: 5px 5px;
}

.rightPad td {
	padding-right: 3px !important;
}

.thumbnail {
	position: relative;
	z-index: 0;
}

.thumbnail:hover {
	background-color: transparent;
	z-index: 60;
}

.thumbnail span { /*CSS for enlarged image*/
	position: absolute;
	background-color: lightyellow;
	padding: 4px;
	left: -1000px;
	border: 1px dashed gray;
	visibility: hidden;
	color: black;
	text-decoration: none;
}

.thumbnail span img { /*CSS for enlarged image*/
	border-width: 0;
	padding: 2px;
}

.thumbnail:hover span { /*CSS for enlarged image on hover*/
	visibility: visible;
	top: -120px;
	left: -350px;
	/*position where enlarged image should offset horizontally */
}
</style>
<script type="text/javascript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
	function funDelete() {
		if (confirm("Are You Sure You Want Delete Selected Record")) {
			return true;
		} else {
			return false;
		}
	}
</script>
</head>
<body>
	<table border="0" cellspacing="0" cellpadding="0" width="80%"
		style="border-collapse: collapse" align="center">
		<thead>
			<tr align="right">
				<th colspan="35"><a href="/pred/home.jsp?loginMode=watersoft">Home</a>
					| &nbsp;<a href="javascript:onclick=history.go(-1)">Back</a></th>
			</tr>
			<tr>
				<th align="center" class="gridhdbg" colspan="35">Status of
					Water Purification Plants installed through Donors/Government</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2">S.No.</th>
				<th class="gridhdbg" rowspan="2">District</th>
				<th class="gridhdbg" rowspan="2">Constituency</th>
				<th class="gridhdbg" rowspan="2">Mandal</th>
				<th class="gridhdbg" rowspan="2">Panchayat</th>
				<th class="gridhdbg" rowspan="2">Village</th>
				<th class="gridhdbg" rowspan="2">Habitation Code</th>
				<th class="gridhdbg" rowspan="2">Habitation</th>
				<th class="gridhdbg" rowspan="2">Total Population</th>
				<th class="gridhdbg" rowspan="2">Habitation Status</th>
				<th class="gridhdbg" rowspan="2">Year/Date of Installation</th>
				<th class="gridhdbg" colspan="2">Source Details</th>
				<th class="gridhdbg" rowspan="2">Cost of the Plant (Rs. in
					lakhs)</th>
				<th class="gridhdbg" rowspan="2">Type of Plant Installed
					(RO/UV/Ultrafiltration/EDF/Terrafil/Nano Technology</th>
				<th class="gridhdbg" rowspan="2">Capacity of Plant
					Installed(LPH)</th>
				<th class="gridhdbg" rowspan="2">Average cans supplied per day
				</th>
				<th class="gridhdbg" rowspan="2">Grant/Programme under which
					the plant is installed</th>
				<th class="gridhdbg" rowspan="2">Type of Agency for
					Installation (Agency/Firm/NGO/SHG/Sponsor/GP/Government)</th>
				<th class="gridhdbg" rowspan="2">Name of Installation Agency</th>
				<th class="gridhdbg" rowspan="2">Name of Maintenance Agency</th>
				<th class="gridhdbg" colspan="1">Status</th>
				<th class="gridhdbg" colspan="4">Geo Tagging</th>
				<%
					if (loggedUser.equals("100000")) {
				%>
				<th class="gridhdbg" rowspan="2">Action</th>
				<%
					}
				%>
			</tr>
			<tr>
				<th class="gridhdbg">Source Code/Source Name</th>
				<th class="gridhdbg">Surface/Sub Surface</th>
				<th class="gridhdbg">Working/Not Working</th>
				<th class="gridhdbg">Latitude</th>
				<th class="gridhdbg">Longitude</th>
				<th class="gridhdbg">Location</th>
				<th class="gridhdbg">Image</th>
			</tr>
		</thead>
		<tbody>
			<%
				PreparedStatement ps1 = null, ps2 = null, ps3 = null, ps4 = null;
				ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
				String Dname = "-", Cname = "-", Mname = "-", Pname = "-", Vname = "-", Hname = "-", Hcode = "-",
						TotPopulation = "-", Hstatus = "-";
				String style = "-", sourceDetails = "-", sourceType = "-", status = "-", GPUWTI = "-";
				int styleCount = 1;
				try {
					String query3 = "SELECT A.HAB_CODE, A.SOURCE_CODE, NVL(B.SOURCE_NAME,'-'), NVL(C.SOURCE_TYPE_NAME,'-') FROM RWS_NTR_SUJALA_MASTER_TBL A, RWS_SOURCE_TBL B, RWS_SOURCE_TYPE_TBL C WHERE A.SOURCE_CODE=B.SOURCE_CODE AND B.SOURCE_TYPE_CODE=C.SOURCE_TYPE_CODE ";
					query3 += "UNION SELECT A.HAB_CODE, A.SOURCE_CODE, 'HAND PUMP', 'SUBSURFACE SOURCE' FROM RWS_NTR_SUJALA_MASTER_TBL A, RWS_HP_SUBCOMP_PARAM_TBL B WHERE A.SOURCE_CODE=B.HP_CODE ";
					query3 += "UNION SELECT A.HAB_CODE, A.SOURCE_CODE, 'OPEN WELL', 'SUBSURFACE SOURCE' FROM RWS_NTR_SUJALA_MASTER_TBL A, RWS_OPEN_WELL_MAST_TBL B WHERE A.SOURCE_CODE=B.OPENWELL_CODE ";
					query3 += "UNION SELECT A.HAB_CODE, A.SOURCE_CODE, 'SHALLOW HAND PUMP', 'SUBSURFACE SOURCE' FROM RWS_NTR_SUJALA_MASTER_TBL A, RWS_SHALLOWHANDPUMPS_TBL B WHERE A.SOURCE_CODE=B.SHALLOWHP_CODE";
					//System.out.println("query3 ="+query3);					
					ps3 = conn.prepareStatement(query3);
					rs3 = ps3.executeQuery();
					Hashtable SourceDetailList = new Hashtable();
					while (rs3.next()) {
						SourceDetailList.put(rs3.getString(1),
								rs3.getString(2) + "/" + rs3.getString(3) + "#" + rs3.getString(4));
					}
					if (rs3 != null) {
						rs3.close();
					}
					if (ps3 != null) {
						ps3.close();
					}

					String query1 = "SELECT TO_CHAR(A.IMPLEMENTATION_DT,'DD-MM-YYYY'), A.PLANT_TYPE_INSTALLED, A.PLANT_CAPACITY, A.INSTALLATION_AGENCY_TYPE, A.INSTALLATION_AGENCY_NAME, A.MAINTENANCE_AGENCY_NAME, NVL(B.COMP_COST,0), NVL(B.LOCATION,'-'), NVL(B.LATITUDE,0.0), NVL(B.LONGITUDE,0.0), NVL(B.STATUS,'-'), SUBSTR(B.ASSET_CODE,1,2), NVL(B.WTPSC_CODE,'-'), NVL(A.HABITATION_CODE,'-'),NVL(A.ASSET_CODE,'-'),A.HABITATION_CODE  FROM RWS_NTR_SUJALA_HAB_IMPL_TBL A LEFT JOIN RWS_AST_WTP_SC_PARAM_TBL B ON A.ASSET_CODE=B.ASSET_CODE AND A.WTPSC_CODE=B.WTPSC_CODE ORDER BY A.HABITATION_CODE";
					//System.out.println("query1 ="+query1);					
					ps1 = conn.prepareStatement(query1);
					rs1 = ps1.executeQuery();
					while (rs1.next()) {
						//System.out.println(rs1.getString(1));
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						String query2 = "SELECT A.DNAME, B.CONSTITUENCY_NAME, A.MNAME, A.PNAME, A.VNAME, A.PANCH_CODE, A.PANCH_NAME, SUM(A.CENSUS_PLAIN_POPU+A.CENSUS_SC_POPU+A.CENSUS_ST_POPU), A.COVERAGE_STATUS FROM RWS_COMPLETE_HAB_VIEW A, RWS_CONSTITUENCY_TBL B WHERE A.DCODE=B.DCODE AND A.MCODE=B.MCODE AND A.PANCH_CODE=? GROUP BY A.DNAME, B.CONSTITUENCY_NAME, A.MNAME, A.PNAME, A.VNAME, A.PANCH_CODE, A.PANCH_NAME, A.COVERAGE_STATUS  ORDER BY A.DNAME, B.CONSTITUENCY_NAME, A.MNAME, A.PNAME, A.VNAME, A.PANCH_NAME ";
						//System.out.println("query2 ="+query2);					
						ps2 = conn.prepareStatement(query2);
						ps2.setString(1, rs1.getString(14));
						rs2 = ps2.executeQuery();
						if (!rs2.next()) {
							Dname = "-";
							Cname = "-";
							Mname = "-";
							Pname = "-";
							Vname = "-";
							Hname = "-";
							Hcode = "-";
							TotPopulation = "-";
							Hstatus = "-";
						} else {
							do {
								Dname = rs2.getString(1);
								Cname = rs2.getString(2);
								Mname = rs2.getString(3);
								Pname = rs2.getString(4);
								Vname = rs2.getString(5);
								Hname = rs2.getString(7);
								Hcode = rs2.getString(6);
								TotPopulation = rs2.getString(8);
								Hstatus = rs2.getString(9);
							} while (rs2.next());
						}
						if (rs2 != null) {
							rs2.close();
						}
						if (ps2 != null) {
							ps2.close();
						}
						String SourceDet = "" + SourceDetailList.get(rs1.getString(14));
						if (SourceDet != null && !SourceDet.equals("") && !SourceDet.equals("null")) {
							String[] SourceD = SourceDet.split("#");
							sourceDetails = SourceD[0];
							sourceType = SourceD[1];
						} else {
							sourceDetails = "-";
							sourceType = "-";
						}
						if (rs1.getString(11) != null && rs1.getString(11).equals("W")) {
							status = "Working";
						} else {
							status = "-";
						}
						if (rs1.getString(12) != null && rs1.getString(12).equals("81")) {
							GPUWTI = " SUJALA";
						} else {
							GPUWTI = "-";
						}
			%>
			<tr>
				<td class="<%=style%>" style="text-align: center;"><%=styleCount++%></td>
				<td class="<%=style%>" style="text-align: left;"><%=Dname%></td>
				<td class="<%=style%>" style="text-align: left;"><%=Cname%></td>
				<td class="<%=style%>" style="text-align: left;"><%=Mname%></td>
				<td class="<%=style%>" style="text-align: left;"><%=Pname%></td>
				<td class="<%=style%>" style="text-align: left;"><%=Vname%></td>
				<td class="<%=style%>" style="text-align: center;"><%=Hcode%></td>
				<td class="<%=style%>" style="text-align: left;"><%=Hname%></td>
				<td class="<%=style%>" style="text-align: center;"><%=TotPopulation%>
				</td>
				<td class="<%=style%>" style="text-align: center;"><%=Hstatus%>
				</td>
				<td class="<%=style%>" style="text-align: center;"><%=rs1.getString(1)%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=sourceDetails%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=sourceType%>
				</td>
				<td class="<%=style%>" style="text-align: center;"><%=rs1.getString(7)%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(2)%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(3)%>
				</td>
				<td class="<%=style%>" style="text-align: left;">-</td>
				<td class="<%=style%>" style="text-align: left;"><%=GPUWTI%></td>
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(4)%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(5)%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(6)%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=status%></td>
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(9)%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(10)%>
				</td>
				<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(8)%>
				</td>
				<%
					String req = "Select dbms_lob.getlength(COMPO_IMAGE) From RWS_ASSET_COMPONENT_IMAGE_TBL  Where ASSET_COMPONENT =?";
							PreparedStatement stmt1 = conn.prepareStatement(req);
							stmt1.setString(1, rs1.getString(13));
							ResultSet rset = stmt1.executeQuery();
							if (rset.next()) {
								if (rset.getInt(1) != 0) {
				%>
				<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img
						src="./rws_assets_image_capturing1.jsp?imgID=<%=rs1.getString(13)%>"
						width="30px" height="30px" border="0" /><span><img
							src="./rws_assets_image_capturing1.jsp?imgID=<%=rs1.getString(13)%>"
							width="350px" height="230px" /></span></a></td>
				<%
					} else {
				%>
				<td class="<%=style%>" style="text-align: left;">-</td>
				<%
					}
							} else {
				%>
				<td class="<%=style%>" style="text-align: left;">-</td>
				<%
					}
							rset.close();
							stmt1.close();
				%>
				  <%  if(loggedUser.equals("100000")) { 
				    if(rs1.getString(15).equals("-")){
				    	%> 
				    	<td class="<%=style%>" style="text-align: center;"><a href="./rws_ntr_donor_del.jsp?habCode=<%=rs1.getString(16) %>&date=<%=rs1.getString(1) %>" onclick="return funDelete()"><font color="#6600CC">Delete&nbsp;</font></a>
				    	</td>
				    	<%}else{ %>
				    <td class="<%=style%>" style="text-align: left;"> Converted to Asset </td> 
				    <%}} %>
			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
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
<%@ include file="/commons/rws_alert.jsp"%>
</html>