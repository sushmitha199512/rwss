<%@ page contentType="application/vnd.ms-excel"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%
	String type = request.getParameter("type");
	if (type.equals("count")) {
%>
<form>
	<%
		Statement stmt1 = null, stmt2 = null;
			ResultSet rs1 = null, rs2 = null;

			int totalHabs=0,updatedHabTotal=0,updatedCovTotal=0,notUpdatedTotal=0,notUpdateCov=0;
			String mandal = (String) session.getAttribute("mandal");
			String dname = (String) session.getAttribute("dname");
			String district = (String) session.getAttribute("district");
			int year1 = (Integer) session.getAttribute("year1");
			int year2 = (Integer) session.getAttribute("year2");

			String mname = "";

			String dcode = "";
			String mcode = "";

			int updated_hab=0,tot_habs=0,updated_cov=0;
			int notUpdated=0,notUpCovTot=0;
			int sno = 1;
			int styleCount = 0;
			String style = "";
	%>
	<table border=1 cellspacing=0 cellpadding=0 width="80%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
			<table border=0 rules=none style="border-collapse: collapse"
				align="right">

			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class=gridhdbg colspan="5">Habitation Status
				Details For <%=year1%>-<%=year2%> (District: <%=dname%>)
			</td>
		</tr>
	</table>
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
		style="border-collapse: collapse" ALIGN=CENTER>
		<tr align=center>



			<tr align=center>

			<td class=gridhdbg rowspan="3">Sl.No</td>
			<%
				if (district.equals("ALL")) {
			%>
			<td class=gridhdbg rowspan="3">District</td>
			<%
				} else {
			%>
			<td class=gridhdbg rowspan="3">Mandal</td>
			<%
				}
			%>
			<td class=gridhdbg rowspan="3">Total No.of habitations</td>
			<td class=gridhdbg colspan="4">Habotations In Current Financial
				Year</td>
		</tr>
		<tr>
			<td class=gridhdbg colspan="2">Habitation directory</td>
			<td class=gridhdbg colspan="2">Coverage Status Automation</td>	
		</tr>
		<tr align=center>
			<td class=gridhdbg>Updated</td>
			<td class=gridhdbg>Not Updated</td>
			<td class=gridhdbg>Updated</td>		
			<td class=gridhdbg>Not Updated</td>
		</tr><%
			try {

					String query = "";
					if (district.equals("ALL")) {
						query = "select distinct dname,dcode from rws_district_tbl";
					} else if (mandal.equals("ALL")) {
						query = "select distinct dname,mname,dcode,mcode from RWS_COMPLETE_HAB_DYNA_VIEW where dcode='"
								+ district + "'";
					} else {
						query = "select distinct dname,mname,dcode,mcode from RWS_COMPLETE_HAB_DYNA_VIEW where dcode='"
								+ district + "' and mcode='" + mandal + "'";
					}
					//System.out.println("query-----" + query);
					stmt = conn.createStatement();
					rs = stmt.executeQuery(query);
					while (rs.next()) {
						if (district.equals("ALL")) {
							dname = rs.getString(1);
							dcode = rs.getString(2);
						} else {

							mname = rs.getString(2);
							dcode = rs.getString(3);
							mcode = rs.getString(4);
						}

						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
		%>
		
		<tr>
			<td class="<%=style%>" style="text-align: center;"><%=sno++%></td>
			<%
				if (district.equals("ALL")) {
			%>
			<td class="<%=style%>" style="text-align: left;"><%=dname%></td>
			<%
				} else {
			%>

			<td class="<%=style%>" style="text-align: left;"><%=mname%></td>
			<%
				}
			%>

			<%
			 if(district.equals("ALL")){
				 query="select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and substr(HAB_CODE,1,2)='"+dcode+ "' and a.COVERAGE_STATUS <> 'UI'";
			 }
			 else{
				 query="select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and substr(HAB_CODE,1,2)='"+dcode+ "' and substr(HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI'";
			 }
			 stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);
	 		if (rs1.next()) {
	 			tot_habs = rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close(); 						
			 if(district.equals("ALL")){
				 query="select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and  UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "' and a.COVERAGE_STATUS <> 'UI'";
			 }
			 else{
				 query="select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and  UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "' and substr(HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI'";
			 }			 	
	 		//System.out.println("query-----" + query);
	 		stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);
	 		if (rs1.next()) {
	 			updated_hab = rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close();
	 		if(district.equals("ALL")){
	 			query = "select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and update_date<to_date('01/04/"+ year1 + "','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "'  and a.COVERAGE_STATUS <> 'UI'";
	 		 }
	 		 else{
	 			query = "select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and update_date<to_date('01/04/"+ year1 + "','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "' and substr(HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI'";
	 		 }	 		
	 	//	System.out.println("query-----" + query);
	 		stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);
	 		if (rs1.next()) {
	 			notUpdated = rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close();	 		
	 		if(district.equals("ALL")){
	 			query = "select count(a.HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and a.COVERAGE_STATUS <> 'UI' ";
	 		 }
	 		 else{
	 			query = "select count(a.HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and  substr(a.HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI' ";
			}	 		
	 	//	System.out.println("query-----" + query);
	 		stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);	 		
	 		if(rs1.next()) {
	 			updated_cov=rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close();
	 		if(district.equals("ALL")){
	 			query = "select count(a.HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE<to_date('01/04/"+year1+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and a.COVERAGE_STATUS <> 'UI' ";
	 		 }
	 		 else{
	 			query = "select count(a.HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE<to_date('01/04/"+year1+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and  substr(a.HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI' ";
			}	 		
	 	//	System.out.println("query-----" + query);
	 		stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);	 		
	 		if(rs1.next()) {
	 			notUpdateCov=rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close();
			%>
			<td class="<%=style%>" style="text-align: right;"><%=tot_habs%></a></td>
			<td class="<%=style%>" style="text-align: right;"><%=updated_hab%></td>
			<td class="<%=style%>" style="text-align: right;"><%=notUpdated%></a></td>
			<td class="<%=style%>" style="text-align: right;"><%=updated_cov%></td>
			<td class="<%=style%>" style="text-align: right;"><%=notUpdateCov%></td>
		</tr>
		<%
		 totalHabs=totalHabs+tot_habs;
		 updatedHabTotal=updatedHabTotal+updated_hab;
		 notUpdatedTotal=notUpdatedTotal+notUpdated;
		 updatedCovTotal=updatedCovTotal+updated_cov;
		 notUpCovTot=notUpCovTot+notUpdateCov;	

					}
					stmt.close();
					rs.close();
		%>

		<tr>
			<td class="gridhdbg" style="text-align: right;" colspan=2>Total:</td>
			<td class="gridhdbg" style="text-align: right;"><%=totalHabs %></td>
			<td class="gridhdbg" style="text-align: right;"><%=updatedHabTotal %></td>
			<td class="gridhdbg" style="text-align: right;"><%=notUpdatedTotal %></td>
			<td class="gridhdbg" style="text-align: right;"><%=updatedCovTotal %></td>
			<td class="gridhdbg" style="text-align: right;"><%=notUpCovTot %></td>

		</tr>
		<%
			} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {

						if (conn != null) {
							conn.close();
						}
					} catch (Exception r) {
						r.printStackTrace();
					}
				}
		%>
	</table>
</form>

</td>
</tr>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/reports/connClose.jsp"%>
<%
	} finally {
		}
%>


</span>


<%
	} else if (type.equals("drill")) {
%>



<%
	int count = 1;
		String district = (String) session.getAttribute("district");
		String dname = (String) session.getAttribute("dname");
		String dcode = (String) session.getAttribute("dcode");

		String mandal = (String) session.getAttribute("mandal");
		String mname = (String) session.getAttribute("mname");

		int year1 = (Integer) session.getAttribute("year1");
		int year2 = (Integer) session.getAttribute("year2");

		String status = (String) session.getAttribute("status");
		int styleCount = 0;
		String style = "";
%>

<table border=1 cellspacing=0 cellpadding=0 width="100%"
	bordercolor=#000000 style="border-collapse: collapse" ALIGN=CENTER>
	<caption>
		<table border=0 rules=none style="border-collapse: collapse"
			align="right">

			<a href="#" onClick="window.close();">Close</a> &nbsp;| &nbsp;
			<a href="./rws_habitation_status_rpt_xls.jsp?type=drill">Excel</a>



		</table>
	</caption>
	<tr align="center">
		<td align="center" class=gridhdbg></td>
		<td align="center" class=gridhdbg>Habitation Status Details For
			<%=year1%>-<%=year2%><br>(District:&nbsp;<%=dname%>
			&nbsp;&nbsp;
			<%if (mandal != null && mandal != "") { %>
			Mandal:&nbsp;<%=mname%><%} %>&nbsp;&nbsp;<%
			if(status.equals("UpdatedHabs")){
			%>Status:&nbsp;Updated Habitations in Habitation Directory 
			<%}else if(status.equals("NotUpdatedHabs")){
				%>Status:&nbsp;Not Updated Habitations in Habitation Directory
			<%}else if(status.equals("UpdatedCov")){
			%>Status:&nbsp;Updated Habitations in Coverage Status Automation
			<%}else if(status.equals("NotUpdatedcov")){
				%>Status:&nbsp;Not Updated Habitations in Coverage Status Automation
			<%} %>
			During The Financial Year)
		</td>
	</tr>

</table>
<table width="70%" border=1 style="border-collapse: collapse"
	ALIGN=CENTER>
	<tr align=center>

		<td class=gridhdbg><b>SL&nbsp;NO </b></td>
		<td class=gridhdbg><b>Mandal </b></td>
		<td class=gridhdbg><b>Panchayat </b></td>
		<td class=gridhdbg><b>Village</b></td>
		<td class=gridhdbg><b>Hab Code</b></td>
		<td class=gridhdbg><b>Hab Name</b></td>
		<%if (!status.equals("Total")){ %>
		<td class=gridhdbg><b>Hab Status Updated Date </b></td>
		<%} %>
		<%if (status.equals("UpdatedCov") || status.equals("NotUpdatedcov")) { %>
		<td class=gridhdbg><b>Coverage Status Updated Date </b></td>
		<%} %>


	</tr>


	<%
		Statement statement = null;
			ResultSet resultSet = null;
			try {
				String query = "";
				if (status.equals("Total")) {
					query = "select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,to_char(a.UPDATE_DATE,'dd/mm/yyyy'),b.MNAME from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and substr(HAB_CODE,1,2)='"+dcode+ "' and a.COVERAGE_STATUS <> 'UI'";
					if (mandal != null && mandal != "") {
						query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
					}
				} else if (status.equals("UpdatedHabs")) {
					query = "select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,to_char(a.UPDATE_DATE,'dd/mm/yyyy'),b.MNAME from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and  UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "' and a.COVERAGE_STATUS <> 'UI'";
					if (mandal != null && mandal != "") {
						query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
					}
				} else if (status.equals("NotUpdatedHabs")) {
					query = "select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),b.MNAME from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and update_date<to_date('01/04/"+ year1 + "','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "'  and a.COVERAGE_STATUS <> 'UI'";
					if (mandal != null && mandal != "") {
						query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
					}
				} else if (status.equals("UpdatedCov")) {
					query = "select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,to_char(a.UPDATE_DATE,'dd/mm/yyyy'),b.MNAME,nvl(to_char(c.UPDATE_DATE,'dd/mm/yyyy'),'--') from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and a.COVERAGE_STATUS <> 'UI' ";
					if (mandal != null && mandal != "") {
						query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
					}
				}else if (status.equals("NotUpdatedcov")) {
					query = "select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,to_char(a.UPDATE_DATE,'dd/mm/yyyy'),b.MNAME,nvl(to_char(c.UPDATE_DATE,'dd/mm/yyyy'),'--') from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE<to_date('01/04/"+year1+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and a.COVERAGE_STATUS <> 'UI' ";
					if (mandal != null && mandal != "") {
						query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
					}
				}
				statement = conn.createStatement();
				resultSet = statement.executeQuery(query);
				while (resultSet.next()) {

					if (styleCount % 2 == 0) {
						style = "gridbg1";
					} else {
						style = "gridbg2";
					}
					styleCount++;

	%>
	<tr>
		<td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
		<td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(6)%></td>
		<td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(1)%></td>
		<td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(2)%></td>
		<td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(3)%></td>
		<td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(4)%></td>
		<%if (!status.equals("Total")){ %>
		<td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(5)%></td>
		<%}if (status.equals("UpdatedCov") || status.equals("NotUpdatedcov")) { %>
		<td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(7)%></td>
		<%} %>
	</tr>
	<%
		}
			statement.close();
			resultSet.close();
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
<%}%>
