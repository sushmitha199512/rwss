<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css">

</head>
<script language="JavaScript">
	function wopen(url, name, w, h) {
		// Fudge factors for window decoration space.
		// In my tests these work well on all platforms & browsers.
		w += 32;
		h += 96;
		var win = window.open(url, name, 'width=' + w + ', height=' + h + ', '
				+ 'location=yes, menubar=no, '
				+ 'status=yes, toolbar=no, scrollbars=yes, resizable=yes');

		win.focus();
	}
</script>
<%
	int count = 1;
	String district = (String) session.getAttribute("district");
	String dname = (String) session.getAttribute("dname");
	String dcode = request.getParameter("dcode");
	String mandal = request.getParameter("mcode");
	String mname = request.getParameter("mname");
	int year1 = (Integer) session.getAttribute("year1");
	int year2 = (Integer) session.getAttribute("year2");
	session.setAttribute("district", district);
	session.setAttribute("mandal", mandal);
	session.setAttribute("dname", dname);
	session.setAttribute("mname", mname);
	session.setAttribute("year1", year1);
	session.setAttribute("year2", year2);
	session.setAttribute("dcode", dcode);
	String status = request.getParameter("status");
	session.setAttribute("status", status);
	//System.out.println("status"+status);
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
				/* query = "select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,to_char(a.UPDATE_DATE,'dd/mm/yyyy'),b.MNAME,nvl(to_char(c.UPDATE_DATE,'dd/mm/yyyy'),'--') from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE<to_date('01/04/"+year1+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and a.COVERAGE_STATUS <> 'UI' ";
				if (mandal != null && mandal != "") {
					query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
				} */
				query = "select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,to_char(a.UPDATE_DATE,'dd/mm/yyyy'),b.MNAME,nvl(to_char(c.UPDATE_DATE,'dd/mm/yyyy'),'--') from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE<to_date('01/04/"+year1+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and a.COVERAGE_STATUS <> 'UI' ";
				if (mandal != null && mandal != "") {
					query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
				}
				query += "union select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,to_char(a.UPDATE_DATE,'dd/mm/yyyy'),b.MNAME,'--' from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where a.HAB_CODE=b.PANCH_CODE and a.COVERAGE_STATUS <> 'UI' and b.PANCH_CODE not in (select hab_code from RWS_HAB_SUPPLY_STATUS_TBL) and substr(a.HAB_CODE,1,2)='"+dcode+"'";
				if (mandal != null && mandal != "") {
					query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
				}
				query += "union select b.PNAME,b.VNAME,b.PANCH_CODE,b.PANCH_NAME,to_char(a.UPDATE_DATE,'dd/mm/yyyy'),b.MNAME,'--' from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE is null and substr(a.HAB_CODE,1,2)='"+dcode+"' and a.COVERAGE_STATUS <> 'UI' ";
				if (mandal != null && mandal != "") {
					query += " and substr(a.HAB_CODE,6,2)='" + mandal + "'";
				}	
			}
			// System.out.println("query"+query);
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

