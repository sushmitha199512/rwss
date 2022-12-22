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
			&& !loggedUser.equals(Constants.LAKH_USER) && !loggedUser.equals(Constants.MINISTER) && !loggedUser.equals(Constants.SEC_USER) && !loggedUser.equals(Constants.ENC) && !loggedUser.substring(0,2).equals("ce")) {
		dcode = loggedUser.substring(1, 3);
	} else if (request.getParameter("dcode") != null
			&& !request.getParameter("dcode").equals("")) {
		dcode = request.getParameter("dcode");
	}
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
				<td class=gridhdbg colspan=2 align=center>CPWS</td>
				<td class=gridhdbg colspan=2 align=center>PWS</td>
				<td class=gridhdbg colspan=2 align=center>MPWS</td>
				<td class=gridhdbg colspan=2 align=center>DIRECT PUMPING</td>
				<td class=gridhdbg colspan=2 align=center>HAND PUMPS</td>
				<td class=gridhdbg colspan=2 align=center>OPEN WELLS</td>
				<td class=gridhdbg colspan=2 align=center>SHALLOW HANDPUMPS</td>
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

				String query = "", astQuery = "", astImgQuery = "", HpQuery = "", ShpQuery = "", OwQuery = "", HpImgQuery = "", ShpImgQuery = "", OwImgQuery = "";
				try {
					int tot_cpws = 0, tot_pws = 0, tot_mpws = 0, tot_dp = 0, tot_hp = 0, tot_shp = 0, tot_ow = 0;
					int tot_img_cpws = 0, tot_img_pws = 0, tot_img_mpws = 0, tot_img_dp = 0, tot_img_hp = 0, tot_img_shp = 0, tot_img_ow = 0;
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
						int cpws = 0, pws = 0, mpws = 0, dp = 0, hp = 0, shp = 0, ow = 0;
						int img_cpws = 0, img_pws = 0, img_mpws = 0, img_dp = 0, img_hp = 0, img_shp = 0, img_ow = 0;
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
						astQuery = "select B.Type_Of_Asset_Code,count(A.Asset_Code) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c where A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code not in('04','05','06','07','08','11','12') and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							astQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "' ";
						}
						astQuery += "  group by B.Type_Of_Asset_Code";
						//System.out.println(astQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(astQuery);
						while (rs1.next()) {
							if (rs1.getString("Type_Of_Asset_Code").equals("01"))
								pws = rs1.getInt(2);
							if (rs1.getString("Type_Of_Asset_Code").equals("02"))
								mpws = rs1.getInt(2);
							if (rs1.getString("Type_Of_Asset_Code").equals("03"))
								cpws = rs1.getInt(2);
							if (rs1.getString("Type_Of_Asset_Code").equals("09"))
								dp = rs1.getInt(2);
						}
						rs1.close();
						stmt1.close();
						HpQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_HP_SUBCOMP_PARAM_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='04' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							HpQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "' ";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(HpQuery);
						if (rs1.next()) {
							hp = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();

						ShpQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_SHALLOWHANDPUMPS_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code  and B.Type_Of_Asset_Code='05' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							ShpQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "'";
						}
						//System.out.println(ShpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(ShpQuery);
						if (rs1.next()) {
							shp = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();

						OwQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_OPEN_WELL_MAST_TBL d where a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code  and B.Type_Of_Asset_Code='06' and A.Hab_Code=C.Panch_Code and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							OwQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "'";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(OwQuery);
						if (rs1.next()) {
							ow = rs1.getInt(1);
						}
						/* if(rs1.getString("Type_Of_Asset_Code").equals("05"))
							shp=rs1.getInt(2);
						if(rs1.getString("Type_Of_Asset_Code").equals("06"))
							ow=rs1.getInt(2);					
						 */
						rs1.close();
						stmt1.close();

						astImgQuery = "select B.Type_Of_Asset_Code,count(A.Asset_Code) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,Rws_Asset_Image_Tbl d where A.Asset_Code=D.Asset_Code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code not in('04','05','06','07','08','11','12') and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(D.Asset_Image)<>0 and D.Asset_Lat<>0  and D.Asset_Lon<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "'";
						if (mode.equals("mandal")) {
							astImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						astImgQuery += " group by B.Type_Of_Asset_Code";
						//System.out.println(astImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(astImgQuery);
						while (rs1.next()) {
							if (rs1.getString("Type_Of_Asset_Code").equals("01"))
								img_pws = rs1.getInt(2);
							if (rs1.getString("Type_Of_Asset_Code").equals("02"))
								img_mpws = rs1.getInt(2);
							if (rs1.getString("Type_Of_Asset_Code").equals("03"))
								img_cpws = rs1.getInt(2);
							if (rs1.getString("Type_Of_Asset_Code").equals("09"))
								img_dp = rs1.getInt(2);
						}
						rs1.close();
						stmt1.close();

						HpImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_HP_SUBCOMP_PARAM_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.HP_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code  and B.Type_Of_Asset_Code='04' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							HpImgQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "'";
						}
						//System.out.println(HpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(HpImgQuery);
						if (rs1.next()) {
							img_hp = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();
						ShpImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_SHALLOWHANDPUMPS_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.SHALLOWHP_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='05' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0 and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							ShpImgQuery += " and substr(c.panch_code,6,2)='"
									+ mcode + "'";
						}
						//System.out.println(ShpImgQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(ShpImgQuery);
						if (rs1.next()) {
							img_shp = rs1.getInt(1);
						}
						rs1.close();
						stmt1.close();

						OwImgQuery = "select count(1) from Rws_Asset_Mast_Tbl a,Rws_Asset_Type_Tbl b,Rws_Complete_Hab_View c,RWS_OPEN_WELL_MAST_TBL d,Rws_Asset_Component_Image_Tbl e where a.asset_code=e.asset_code and d.OPENWELL_CODE=e.ASSET_COMPONENT and a.asset_code=d.asset_code and A.Type_Of_Asset_Code=B.Type_Of_Asset_Code and B.Type_Of_Asset_Code='06' and A.Hab_Code=C.Panch_Code and dbms_lob.getlength(e.COMPO_IMAGE)<>0 and e.COMPO_LAT<>0  and e.COMPO_LON<>0 and substr(c.panch_code,1,2)='"
								+ dcode + "' ";
						if (mode.equals("mandal")) {
							OwImgQuery += " and substr(c.panch_code,6,2)='" + mcode
									+ "' ";
						}
						//System.out.println(HpQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(OwImgQuery);
						if (rs1.next()) {
							img_ow = rs1.getInt(1);
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
					href="./rws_asset_images_rpt.jsp?dcode=<%=dcode%>"><%=dname%></a></td>
				<%
					} else if (mode.equals("mandal")) {
				%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><%=mname%></td>
				<%
					}
				%>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=cpws%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=03&mode=asset')"><%=img_cpws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=pws%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=01&mode=asset')"><%=img_pws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=mpws%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=02&mode=asset')"><%=img_mpws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=dp%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=09&mode=asset')"><%=img_dp%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=hp%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=04&mode=asset')"><%=img_hp%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=ow%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=06&mode=asset')"><%=img_ow%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><%=shp%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a
					href="#"
					onclick="viewWorks('./rws_asset_images_drill.jsp?dcode=<%=dcode%><%if (mode.equals("mandal")) {%>&mcode=<%=mcode%><%}%>&asset_type=05&mode=asset')"><%=img_shp%></a></td>
			</tr>
			<%
				tot_cpws += cpws;
						tot_pws += pws;
						tot_mpws += mpws;
						tot_dp += dp;
						tot_hp += hp;
						tot_ow += ow;
						tot_shp += shp;
						tot_img_cpws += img_cpws;
						tot_img_pws += img_pws;
						tot_img_mpws += img_mpws;
						tot_img_dp += img_dp;
						tot_img_hp += img_hp;
						tot_img_ow += img_ow;
						tot_img_shp += img_shp;
					}
					rs.close();
					stmt.close();
			%>
			<tr>
				<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;"><%=tot_cpws%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_cpws%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_pws%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_pws%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_mpws%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_mpws%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_dp%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_dp%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_hp%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_hp%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_ow%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_ow%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_shp%></td>
				<td class=gridhdbg style="text-align: right;"><%=tot_img_shp%></td>
			</tr>
		</table>
		<table>
			<tr>
				<td><font color="green" size="2">Note:</font></td>
			</tr>
			<tr>
				<td><font color="red" size="1">1.Hand Pumps,Shallow Hand
						Pumps,Open Wells are Components</font></td>
			</tr>
		</table>
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