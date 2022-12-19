
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>

<html:html>
<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>
<style type="text/css">
body, body a {
	font-family: "Verdana", Georgia, Serif !important;
	font-size: 13px !important;
}

.btext {
	font-family: "Verdana", Georgia, Serif !important;
	font-size: 12px !important;
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
<%
	String dcode = request.getParameter("dcode");
		String mcode = "";
		if (request.getParameter("mcode") != null
				&& !request.getParameter("mcode").equals("")) {
			mcode = request.getParameter("mcode");
		}
		String mode = request.getParameter("mode");
		String asset_type = request.getParameter("asset_type");
		int count = 1;
		int styleCount = 0;
		String style = "";
		String query = "";
		String dname = "";
		String mname = "";
		String sql = "";
		//	System.out.println("asset type"+mcode);
		try {
			Statement st = null;
			ResultSet re = null;
			if (!dcode.equals("") && dcode != null) {
				sql = "select dname from rws_district_tbl where dcode='"
						+ dcode + "'";
				st = conn.createStatement();
				re = st.executeQuery(sql);
				if (re.next())
					dname = re.getString("dname");
			}
			re.close();
			st.close();
			if (!mcode.equals("") && mcode != null) {
				sql = "select mname from rws_district_tbl a,rws_mandal_tbl b where a.dcode=b.dcode and a.dcode='"
						+ dcode + "' and b.mcode='" + mcode + "'";
				st = conn.createStatement();
				re = st.executeQuery(sql);
				if (re.next())
					mname = re.getString("mname");
			}
			st.close();
			re.close();

			//System.out.println("asset type"+asset_type);
%>
<br />
<br />
<center>
	<font color="#663899" face="Maiandra GD" size="4px"><b> <br />Status
			of Images Uploaded - <%=dname%> District <%
 	if (!mcode.equals("") && mcode != null) {
 %> -<%=mname%> Mandal <%
 	}
 %> <%
 	if (asset_type.equals("03")) {
 %> - CPWS <%
 	} else if (asset_type.equals("02")) {
 %> - MPWS <%
 	} else if (asset_type.equals("01")) {
 %> - PWS <%
 	} else if (asset_type.equals("04")) {
 %> - Hand Pumps <%
 	} else if (asset_type.equals("05")) {
 %> - Shallow Hand Pumps <%
 	} else if (asset_type.equals("06")) {
 %> - Open Wells <%
 	} else if (asset_type.equals("09")) {
 %> - Direct Pumping <%
 	}
 %> <%
 	if (mode.equals("source")) {
 %> - Sources <%
 	} else if (mode.equals("ohsr")) {
 %> - OHSR <%
 	} else if (mode.equals("ohbr")) {
 %> - OHBR <%
 	} else if (mode.equals("glsr")) {
 %> - GLSR <%
 	} else if (mode.equals("glbr")) {
 %> - GLBR <%
 	} else if (mode.equals("cisterns")) {
 %> - Cisterns <%
 	} else if (mode.equals("stposts")) {
 %> - Stand Posts <%
 	}
 %> <br />
	</b></font>
	<!-- <br/><br/><font color="#889900" face="Maiandra GD" size="3px">(Amount in Lakhs)</font> -->
</center>
<br />
<table align="center"
	style="margin-top: -35px !important; width: 1200px !important; text-align: center !important;">
	<tr>
		<td style="width: 1000px !important;"></td>
		<!-- <td style="width: 100px !important;" align="right">
                        <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="30px"/></a>&nbsp;&nbsp; 
                    </td> -->
		<td style="width: 100px !important;" align="right"><a href="#"
			onClick="window.close();"><img
				src="/pred/resources/graphs/close.png" height="30px" /></a>&nbsp;&nbsp;
		</td>
	</tr>
</table>

<table width="1000px" border=1 style="border-collapse: collapse"
	ALIGN=CENTER>
	<tr align=center>
		<td class=btext rowspan=1><b>SNO </b></td>
		<%
			if (mode.equals("asset")) {
						if (asset_type.equals("01") || asset_type.equals("02")
								|| asset_type.equals("03")
								|| asset_type.equals("09")) {
		%>
		<td class=btext rowspan=1><b>Asset Code</b></td>
		<td class=btext rowspan=1><b>Asset Name </b></td>
		<%
			} else {
		%>
		<td class=btext rowspan=1><b>Asset Code /<br>Asset Name
		</b></td>
		<td class=btext rowspan=1><b>Component Code /<br>
				Component Name
		</b></td>
		<%
			}
					} else {
		%>
		<td class=btext rowspan=1><b>Asset Code /<br>Asset Name
		</b></td>
		<td class=btext rowspan=1><b>Component Code /<br>
				Component Name
		</b></td>
		<%
			}
		%>
		<td class=btext rowspan=1><b>Aseet Cost </b></td>
		<!-- <td class=btext rowspan=1><b>Asset Satus </b></td> -->
		<td class=btext rowspan=1><b>Asset Creation </b></td>
		<td class=btext rowspan=1><b>Location </b></td>
		<td class=btext rowspan=1><b>Lattittude</b></td>
		<td class=btext rowspan=1><b>Longitude </b></td>
		<td class=btext rowspan=1><b>Image</b></td>
	</tr>

	<%
		Statement statement = null;
				ResultSet resultSet = null;
				Statement stmt1 = null;
				ResultSet rs1 = null;
				String Query = "";

				if (mode.equals("asset")) {
					if (asset_type.equals("01") || asset_type.equals("02")
							|| asset_type.equals("03")
							|| asset_type.equals("09")) {
						Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(A.Location,'-') as Location,D.Asset_Lat,D.Asset_Lon from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,Rws_Asset_Image_Tbl d where A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code not in('07','08','11','12') and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(D.Asset_Image)<>0 and D.Asset_Lat<>0  and D.Asset_Lon<>0 and substr(c.panch_code,1,2)='"
								+ dcode
								+ "' and B.Type_Of_Asset_Code='"
								+ asset_type + "'";
					} else if (asset_type.equals("04")) {
						Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.Location,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.HP_CODE as SOURCE_CODE,'Hand Pump' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_HP_SUBCOMP_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.HP_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
								+ asset_type
								+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode
								+ "' and B.Type_Of_Asset_Code='"
								+ asset_type + "'";
					} else if (asset_type.equals("05")) {
						Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.Location,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.SHALLOWHP_CODE as SOURCE_CODE,'Shallow Hand Pump' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_SHALLOWHANDPUMPS_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.SHALLOWHP_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
								+ asset_type
								+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
								+ dcode
								+ "' and B.Type_Of_Asset_Code='"
								+ asset_type + "'";
					} else if (asset_type.equals("06")) {
						Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.Location,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.OPENWELL_CODE as SOURCE_CODE,'Open Well' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_OPEN_WELL_MAST_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.OPENWELL_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
								+ asset_type
								+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
								+ dcode
								+ "' and B.Type_Of_Asset_Code='"
								+ asset_type + "'";
					}
				} else if (mode.equals("source")) {
					Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.Location,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.SOURCE_CODE as SOURCE_CODE,nvl(SOURCE_NAME,'Source') as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_SOURCE_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.SOURCE_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
							+ asset_type
							+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
							+ dcode
							+ "' and B.Type_Of_Asset_Code='"
							+ asset_type + "'";
				} else if (mode.equals("ohsr")) {
					Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.OHSR_LOC,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.OHSR_CODE as SOURCE_CODE,'OHSR' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_OHSR_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.OHSR_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
							+ asset_type
							+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
							+ dcode
							+ "' and B.Type_Of_Asset_Code='"
							+ asset_type + "'";
				} else if (mode.equals("ohbr")) {
					Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.OHBR_LOC,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.OHBR_CODE as SOURCE_CODE,'OHBR' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_OHBR_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.OHBR_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
							+ asset_type
							+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
							+ dcode
							+ "' and B.Type_Of_Asset_Code='"
							+ asset_type + "'";
				} else if (mode.equals("glsr")) {
					Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.GLSR_LOC,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.GLSR_CODE as SOURCE_CODE,'GLSR' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_GLSR_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.GLSR_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
							+ asset_type
							+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
							+ dcode
							+ "' and B.Type_Of_Asset_Code='"
							+ asset_type + "'";
				} else if (mode.equals("glbr")) {
					Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.GLBR_LOC,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.GLBR_CODE as SOURCE_CODE,'GLBR' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_GLBR_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.GLBR_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
							+ asset_type
							+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
							+ dcode
							+ "' and B.Type_Of_Asset_Code='"
							+ asset_type + "'";
				} else if (mode.equals("cisterns")) {
					Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.CIS_LOC,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.CISSC_CODE as SOURCE_CODE,'Cistern' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_CIS_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.CISSC_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
							+ asset_type
							+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
							+ dcode
							+ "' and B.Type_Of_Asset_Code='"
							+ asset_type + "'";
				} else if (mode.equals("stposts")) {
					Query = "select A.Asset_Code,A.Asset_Name,A.Asset_Cost,A.Asset_Status,to_char(A.Date_Creation,'dd-MM-yyyy') as Date_Creation,nvl(d.Location,'-') as Location,e.COMPO_LAT,e.COMPO_LON,d.STANDPOST_CODE as SOURCE_CODE,'Stand Post' as source_name from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_STANDPOST_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.STANDPOST_CODE=e.ASSET_COMPONENT and A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and A.Hab_Code=C.Panch_Code and B.Type_Of_Asset_Code='"
							+ asset_type
							+ "' and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LON<>0  and e.COMPO_LAT<>0 and substr(c.panch_code,1,2)='"
							+ dcode
							+ "' and B.Type_Of_Asset_Code='"
							+ asset_type + "'";
				}

				if (mcode != null && !mcode.equals(""))
					Query += " and substr(c.panch_code,6,2)='" + mcode
							+ "' ";
				//System.out.println(Query);
				statement = conn.createStatement();
				rs = statement.executeQuery(Query);
				while (rs.next()) {
					if (styleCount % 2 == 0) {
						style = "gridbg1";
					} else {
						style = "gridbg2";
					}
					styleCount++;
	%>

	<tr>
		<td class="<%=style%>" style="text-align: right;"><%=count++%></td>
		<%
			if (mode.equals("asset")) {
							if (asset_type.equals("01")
									|| asset_type.equals("02")
									|| asset_type.equals("03")
									|| asset_type.equals("09")) {
		%>
		<td class="<%=style%>" style="text-align: left;"><%=rs.getString("Asset_Code")%></td>
		<td class="<%=style%>" style="text-align: left;"><%=rs.getString("Asset_Name")%></td>
		<%
			} else {
		%>
		<td class="<%=style%>" style="text-align: left;"><%=rs.getString("Asset_Code")%>/<br><%=rs.getString("Asset_Name")%></td>
		<td class="<%=style%>" style="text-align: left;"><%=rs.getString("SOURCE_CODE")%>/<br><%=rs.getString("source_name")%></td>
		<%
			}
						} else {
		%>
		<td class="<%=style%>" style="text-align: left;"><%=rs.getString("Asset_Code")%>/<br><%=rs.getString("Asset_Name")%></td>
		<td class="<%=style%>" style="text-align: left;"><%=rs.getString("SOURCE_CODE")%>/<br><%=rs.getString("source_name")%></td>
		<%
			}
		%>
		<td class="<%=style%>" style="text-align: right;"><%=rs.getDouble("Asset_Cost")%></td>
		<%-- <td class="<%=style%>" style="text-align: left;"><%=rs.getString("Asset_Status")%></td> --%>
		<td class="<%=style%>" style="text-align: right;"><%=rs.getString("Date_Creation")%></td>
		<td class="<%=style%>" style="text-align: left;"><%=rs.getString("Location")%></td>
		<%
			if (mode.equals("asset")) {
							if (asset_type.equals("01")
									|| asset_type.equals("02")
									|| asset_type.equals("03")
									|| asset_type.equals("09")) {
		%>
		<td class="<%=style%>" style="text-align: right;"><%=rs.getString("Asset_Lat")%></td>
		<td class="<%=style%>" style="text-align: right;"><%=rs.getString("Asset_Lon")%></td>
		<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img
				src="./rws_asset_image.jsp?imgID=<%=rs.getString("ASSET_CODE")%>"
				width="30px" height="30px" border="0" /><span><img
					src="./rws_asset_image.jsp?imgID=<%=rs.getString("ASSET_CODE")%>"
					width="350px" height="230px" /></span></a></td>
		<%
			} else {
		%>
		<td class="<%=style%>" style="text-align: right;"><%=rs.getString("COMPO_LAT")%></td>
		<td class="<%=style%>" style="text-align: right;"><%=rs.getString("COMPO_LON")%></td>
		<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img
				src="../../masters/image.jsp?assetCode=<%=rs.getString("ASSET_CODE")%>&imgID=<%=rs.getString("SOURCE_CODE")%>&mode=component"
				width="30px" height="30px" border="0" /><span><img
					src="../../masters/image.jsp?assetCode=<%=rs.getString("ASSET_CODE")%>&imgID=<%=rs.getString("SOURCE_CODE")%>&mode=component"
					width="350px" height="230px" /></span></a></td>
		<%
			}
						} else {
		%>
		<td class="<%=style%>" style="text-align: right;"><%=rs.getString("COMPO_LAT")%></td>
		<td class="<%=style%>" style="text-align: right;"><%=rs.getString("COMPO_LON")%></td>
		<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img
				src="../../masters/image.jsp?assetCode=<%=rs.getString("ASSET_CODE")%>&imgID=<%=rs.getString("SOURCE_CODE")%>&mode=component"
				width="30px" height="30px" border="0" /><span><img
					src="../../masters/image.jsp?assetCode=<%=rs.getString("ASSET_CODE")%>&imgID=<%=rs.getString("SOURCE_CODE")%>&mode=component"
					width="350px" height="230px" /></span></a></td>
		<%
			}
		%>
	</tr>
	<%
		}
				statement.close();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
	%>
</table>
<br />
<table height="20px" align="center">
	<tr height="1%">
		<td align="center" valign="bottom"
			style="font-family: verdana; font-size: 8pt; font-weight: bold; width: 100%; color: #6600CC;">
			Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>,
			Designed & Developed by <a href="http://www.nic.in" target="_blank">National
				Informatics Centre</a>, AP State Centre
		</td>
	</tr>
</table>
<br />
</html:html>
