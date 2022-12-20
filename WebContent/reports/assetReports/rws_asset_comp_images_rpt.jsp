<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>

<script type="text/javascript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>
<%
	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String dcode = "00";
	if (!loggedUser.equals(Constants.ADMIN)
			&& !loggedUser.equals(Constants.LAKH_USER)&& !loggedUser.equals(Constants.MINISTER) && !loggedUser.equals(Constants.SEC_USER) && !loggedUser.equals(Constants.ENC) && !loggedUser.substring(0,2).equals("ce")) {
		dcode = loggedUser.substring(1, 3);
	} else if (request.getParameter("dcode") != null
			&& !request.getParameter("dcode").equals("")) {
		dcode = request.getParameter("dcode");
	}
	String ast_type = request.getParameter("ast_type");
	//	System.out.println("ast_type"+ast_type);
	String dname = "";
	String mode = "";
	if (dcode.equals("") || dcode.equals("00")) {
		mode = "district";
	} else {
		mode = "mandal";
	}
	//System.out.println("mode"+mode);
	try {
		if (mode.equals("mandal")) {
			String sql = "select dname from rws_district_tbl where dcode='"
					+ dcode + "'";
			Statement st = conn.createStatement();
			ResultSet re = st.executeQuery(sql);
			if (re.next())
				dname = re.getString("dname");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<body bgcolor="#edf2f8">
	<form>
		<table border=0 cellspacing=0 cellpadding=0 height=5%
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" align="center">
			<caption>
				<table border=0 rules=none style="border-collapse: collapse"
					align="right">
					<tr>
						<td align="right" class="bwborder"><a
							href="javascript:history.go(-1)">Back</a>| <a
							href="/pred/home.jsp?loginMode=watersoft">Home </a>| <!-- <a href="" target=_new>Excel</a> --></td>
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class=gridhdbg colspan=16>Status of Images
					Uploaded <%
					if (mode.equals("mandal")) {
				%>- &nbsp;<%=dname%> <%
 	}
 	if (!ast_type.equals("") && ast_type != null) {
 %>- &nbsp; <%
 	if (ast_type.equals("01"))
 %> PWS <%
 	else if (ast_type.equals("02"))
 %> MPWS <%
 	else if (ast_type.equals("03"))
 %> CPWS <%
 	else if (ast_type.equals("09"))
 %> Direct Pumping <%
 	}
 %>
				</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg rowspan=2 align=center>Sno</td>
				<%
					if (mode.equals("district")) {
				%>
				<td class=gridhdbg rowspan=2 align=center>District</td>
				<%
					} else if (mode.equals("mandal")) {
				%>
				<td class=gridhdbg rowspan=2 align=center>Mandal</td>
				<%
					}
				%>
				<td class=gridhdbg colspan=2 align=center>SOURCES</td>
				<td class=gridhdbg colspan=2 align=center>OHSR</td>
				<td class=gridhdbg colspan=2 align=center>OHBR</td>
				<td class=gridhdbg colspan=2 align=center>GLSR</td>
				<td class=gridhdbg colspan=2 align=center>GLBR</td>
				<td class=gridhdbg colspan=2 align=center>CISTERNS</td>
				<td class=gridhdbg colspan=2 align=center>STAND POSTS</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Images Uploaded</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Images Uploaded</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Images Uploaded</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Images Uploaded</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Images Uploaded</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Images Uploaded</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Images Uploaded</td>
			</tr>
			<%
				Statement stmt1 = null;
				ResultSet rs1 = null;
				int sno = 1;
				String mcode = "", mname = "";
				int styleCount = 0;
				String style = "";

				String query = "", souQuery = "", souImgQuery = "", ohsrQuery = "", ohbrQuery = "", glsrQuery = "", glbrQuery = "", stpostsQuery = "", cisternQuery = "", ohsrImgQuery = "", ohbrImgQuery = "", glsrImgQuery = "", glbrImgQuery = "", stptImgQuery = "", cisImgQuery = "";
				try {
					int tot_glbr = 0, tot_sources = 0, tot_ohbr = 0, tot_glsr = 0, tot_ohsr = 0, tot_stposts = 0, tot_cisterns = 0;
					int tot_img_sources = 0, tot_img_ohsr = 0, tot_img_ohbr = 0, tot_img_glsr = 0, tot_img_glbr = 0, tot_img_stposts = 0, tot_img_cisterns = 0;
					//System.out.println("dcode   "+dcode);
					if (mode.equals("district")) {
						query = "select dcode,dname from rws_district_tbl order by dcode";
					} else if (mode.equals("mandal")) {
						query = "select b.mcode,b.mname from rws_district_tbl a,rws_mandal_tbl b where a.dcode=b.dcode and a.dcode='"
								+ dcode + "' order by  b.mcode";
					}
					stmt = conn.createStatement();
					rs = stmt.executeQuery(query);
					while (rs.next()) {
						int ohbr = 0, sources = 0, glbr = 0, glsr = 0, ohsr = 0, stposts = 0, cisterns = 0;
						int img_sources = 0, img_ohsr = 0, img_ohbr = 0, img_glsr = 0, img_glbr = 0, img_stposts = 0, img_cisterns = 0;
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
						if (mode.equals("district")) {
							dcode = rs.getString("dcode");
							dname = rs.getString("dname");
						} else if (mode.equals("mandal")) {
							mcode = rs.getString("mcode");
							mname = rs.getString("mname");
						}
						souQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,Rws_Source_Tbl d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							souQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "' ";
						}
						//	System.out.println(souQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(souQuery);
						while (rs1.next()) {
							sources = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						ohsrQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_OHSR_SC_PARAM_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							ohsrQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "' ";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(ohsrQuery);
						if (rs1.next()) {
							ohsr = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						ohbrQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_OHBR_SC_PARAM_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							ohbrQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "' ";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(ohbrQuery);
						if (rs1.next()) {
							ohbr = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						glsrQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_GLSR_SC_PARAM_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							glsrQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "' ";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(glsrQuery);
						if (rs1.next()) {
							glsr = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						glbrQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_GLBR_SC_PARAM_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							glbrQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "' ";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(glbrQuery);
						if (rs1.next()) {
							glbr = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						cisternQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_CIS_SC_PARAM_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							cisternQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "' ";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(cisternQuery);
						if (rs1.next()) {
							cisterns = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						stpostsQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_STANDPOST_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							stpostsQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "' ";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(stpostsQuery);
						if (rs1.next()) {
							stposts = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();

						souImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_SOURCE_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.SOURCE_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							souImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						//System.out.println(HpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(souImgQuery);
						if (rs1.next()) {
							img_sources = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						ohsrImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_OHSR_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.OHSR_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							ohsrImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						//System.out.println(HpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(ohsrImgQuery);
						if (rs1.next()) {
							img_ohsr = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						ohbrImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_OHBR_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.OHBR_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							ohbrImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						//System.out.println(HpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(ohbrImgQuery);
						if (rs1.next()) {
							img_ohbr = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						glsrImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_GLSR_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.GLSR_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							glsrImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						//System.out.println(HpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(glsrImgQuery);
						if (rs1.next()) {
							img_glsr = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						glbrImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_GLBR_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.GLBR_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							glbrImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						//System.out.println(HpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(glbrImgQuery);
						if (rs1.next()) {
							img_glbr = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						cisImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_CIS_SC_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.CISSC_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							cisImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						//System.out.println(HpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(cisImgQuery);
						if (rs1.next()) {
							img_cisterns = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						stptImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_AST_STANDPOST_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.STANDPOST_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='"
								+ ast_type
								+ "' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							stptImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						//System.out.println(HpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(stptImgQuery);
						if (rs1.next()) {
							img_stposts = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
			%>
			<tr>
				<td class="<%=style%>"><%=sno++%></td>
				<%
					if (mode.equals("district")) {
				%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><a
					href="./rws_asset_comp_images_rpt.jsp?dcode=<%=dcode%>&ast_type=<%=ast_type%>"><%=dname%></a></td>
				<%
					} else if (mode.equals("mandal")) {
				%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><%=mname%></td>
				<%
					}
				%>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=sources%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=<%=ast_type%>&mode=source')"><%=img_sources%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=ohsr%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=<%=ast_type%>&mode=ohsr')"><%=img_ohsr%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=ohbr%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=<%=ast_type%>&mode=ohbr')"><%=img_ohbr%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=glsr%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=<%=ast_type%>&mode=glsr')"><%=img_glsr%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=ohsr%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=<%=ast_type%>&mode=glbr')"><%=img_glbr%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=cisterns%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=<%=ast_type%>&mode=cisterns')"><%=img_cisterns%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=stposts%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=<%=ast_type%>&mode=stposts')"><%=img_stposts%></a></td>
			</tr>
			<%
				tot_sources += sources;
						tot_ohsr += ohsr;
						tot_ohbr += ohbr;
						tot_glsr += glsr;
						tot_glbr += glbr;
						tot_cisterns += cisterns;
						tot_stposts += stposts;
						tot_img_sources += img_sources;
						tot_img_ohsr += img_ohsr;
						tot_img_ohbr += img_ohbr;
						tot_img_glsr += img_glsr;
						tot_img_glbr += img_glbr;
						tot_img_cisterns += img_cisterns;
						tot_img_stposts += img_stposts;
					}
					rs.close();
					stmt.close();
			%>
			<tr>
				<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;"><%=tot_sources%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_sources%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_ohsr%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_ohsr%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_ohbr%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_ohbr%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_glsr%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_glsr%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_glbr%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_glbr%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_cisterns%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_cisterns%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_stposts%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_stposts%></td>
			</tr>
		</table>
		<!-- <table>
			<tr>
				<td><font color="green" size="2">Note:</font></td>
			</tr>
			<tr>
				<td><font color="red" size="1">1.Hand Pumps,Shallow Hand
						Pumps,Open Wells are having Single Components</font></td>
			</tr>
		</table> -->
		<%
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (conn != null)
					conn.close();
			}
		%>
	</form>
</body>
<p align=center>
	<%@ include file="/commons/rws_footer.jsp"%>
</p>