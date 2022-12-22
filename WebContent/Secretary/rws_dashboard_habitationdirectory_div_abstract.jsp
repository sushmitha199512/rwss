
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>

<html>
<head>

<link rel="stylesheet" type="text/css"
	href="<rws:context page='/resources/style/table-fixed-header.css'/>">
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/jquery-1.7.2.min.js'/>"></script>
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/table-fixed-header.js'/>"></script>
<script type="text/javascript">
	function viewReport(URL) {

		TINY.box.show({
			url : URL,
			boxid : 'frameless',
			width : 1000,
			height : 600,
			fixed : true,
			maskid : 'bluemask',
			maskopacity : 40,
			closejs : function() {
				embedVisible();
				closeJS()
			}
		});

	}
</script>
</head>
<%
	DecimalFormat ndf = new DecimalFormat("####.##");

	String name = (String) session.getAttribute("name");
	String type = (String) session.getAttribute("type");
	String query = "";

	String finYear = (String) session.getAttribute("finYear");
	String dcode = (String) request.getParameter("dcode");
	String dname = (String) request.getParameter("dname");
	session.setAttribute("dcode", dcode);
	java.util.Date currentDate = new java.util.Date();
	int cyear = currentDate.getYear() + 1900;
	int pyear = currentDate.getYear() + 1900 - 1;

	String fyears[] = finYear.split("-");

	String habtable = "RWS_HABITATION_DIRECTORY_TBL";
	if (finYear != null) {
		String fy = fyears[0].substring(2, 4);

		if (fyears[0].equals(String.valueOf(cyear))) {
			habtable = "RWS_HABITATION_DIRECTORY_TBL";
		} else if (fyears[0].equals(String.valueOf(pyear))) {
			habtable = "RWS_HABITATION_DIR_HIS_TBL";
		} else if (Integer.parseInt(fyears[0]) > 2005) {
			habtable = "RWS_HABITATION_DIR_HIS" + fyears[0] + "_TBL";
		} else {
			habtable = "RWS_HABITATION_DIRECTORY_TBL";
		}

	}
	if (name.equals("Mandals") && type.equals("01")) {
		query = "SELECT d.dname,m.mname from rws_district_tbl d,rws_mandal_tbl m where d.dcode=m.dcode and d.dcode="
				+ dcode + " order by m.mname";
	} else if (name.equals("Panchayats") && type.equals("02")) {
		query = "SELECT distinct dname,pname,mname from rws_complete_hab_View where dcode="
				+ dcode + " order by pname";
	} else if (name.equals("Villages") && type.equals("03")) {
		query = "SELECT distinct ch.dname,ch.vname,ch.pname,ch.mname from rws_village_tBL a,rws_district_tbl d,rws_complete_hab_view ch  where ch.dcode=d.dcode and ch.vcode=a.vcode and d.dcode=a.dcode and d.dcode="
				+ dcode + " order by ch.vname";
	} else if (name.equals("Habitations") && type.equals("04")) {
		query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View  h,"
				+ habtable
				+ " ch  where  ch.hab_code=h.panch_code and dcode="
				+ dcode + " order by mname";
	} else if (name.equals("HabitationFC") && type.equals("05")) {
		query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View h  ,"
				+ habtable
				+ " ch  where  ch.hab_code=h.panch_code and dcode="
				+ dcode + " and ch.COVERAGE_STATUS='FC' order by mname";
	} else if (name.equals("HabitationPC4") && type.equals("06")) {
		query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View h ,"
				+ habtable
				+ " ch  where  ch.hab_code=h.panch_code and dcode="
				+ dcode
				+ " and ch.COVERAGE_STATUS='PC4' order by mname";
	} else if (name.equals("HabitationPC3") && type.equals("07")) {
		query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View h ,"
				+ habtable
				+ " ch  where  ch.hab_code=h.panch_code and dcode="
				+ dcode
				+ " and ch.COVERAGE_STATUS='PC3' order by mname";
	} else if (name.equals("HabitationPC2") && type.equals("08")) {
		query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View  h ,"
				+ habtable
				+ " ch  where  ch.hab_code=h.panch_code and dcode="
				+ dcode
				+ " and ch.COVERAGE_STATUS='PC2' order by mname";
	} else if (name.equals("HabitationPC1") && type.equals("09")) {
		query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View  h,"
				+ habtable
				+ " ch  where  ch.hab_code=h.panch_code and  dcode="
				+ dcode
				+ " and ch.COVERAGE_STATUS='PC1' order by mname";
	} else if (name.equals("HabitationNSS") && type.equals("10")) {
		query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU  from rws_complete_hab_View  h,"
				+ habtable
				+ " ch  where ch.hab_code=h.panch_code and  dcode="
				+ dcode
				+ " and ch.COVERAGE_STATUS='NSS' order by mname";
	} else if (name.equals("HabitationNC") && type.equals("11")) {
		query = "SELECT dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU from rws_complete_hab_View  h,"
				+ habtable
				+ " ch  where  ch.hab_code=h.panch_code and  dcode="
				+ dcode + " and ch.COVERAGE_STATUS='NC' order by mname";
	} else if (name.equals("PWS") && type.equals("12")) {
		//query = "SELECT h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,to_char(m.DATE_CREATION,'dd/mm/yyyy'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE dcode="+dcode+" and M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' and  SUBSTR(SCHEME_CODE,17,3) LIKE '6%' and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by h.mname,h.pname,h.vname";
		query = "SELECT distinct h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,nvl(to_char(m.DATE_CREATION,'dd/mm/yyyy'),'-'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE dcode="
				+ dcode
				+ "  AND M.TYPE_OF_ASSET_CODE='01' and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
				+ fyears[1]
				+ "' or DATE_CREATION is null) group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by m.ASSET_CODE";

	} else if (name.equals("MPWS") && type.equals("13")) {
		//query = "SELECT h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,to_char(m.DATE_CREATION,'dd/mm/yyyy'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE dcode="+dcode+" and M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02'  and  (SUBSTR(SCHEME_CODE,17,3) LIKE '40%' or SUBSTR(SCHEME_CODE,17,3) LIKE '41%' or SUBSTR(SCHEME_CODE,17,3) LIKE '42%' or SUBSTR(SCHEME_CODE,17,3) LIKE '43%' or SUBSTR(SCHEME_CODE,17,3) LIKE '44%')   and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by h.mname,h.pname,h.vname";
		query = "SELECT distinct h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,nvl(to_char(m.DATE_CREATION,'dd/mm/yyyy'),'-'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE dcode="
				+ dcode
				+ "  AND M.TYPE_OF_ASSET_CODE='02' and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
				+ fyears[1]
				+ "' or DATE_CREATION is null) group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by m.ASSET_CODE";
	} else if (name.equals("CPWS") && type.equals("14")) {
		//query = "SELECT h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,to_char(m.DATE_CREATION,'dd/mm/yyyy'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE dcode="+dcode+" and M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03'  and  SUBSTR(SCHEME_CODE,17,3) LIKE '8%'  and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by h.mname,h.pname,h.vname";
		query = "SELECT distinct h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,nvl(to_char(m.DATE_CREATION,'dd/mm/yyyy'),'-'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE dcode="
				+ dcode
				+ "  AND M.TYPE_OF_ASSET_CODE='03' and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
				+ fyears[1]
				+ "' or DATE_CREATION is null) group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by m.ASSET_CODE";
	} else if (name.equals("HandPumps") && type.equals("15")) {
		//query = "SELECT h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,to_char(m.DATE_CREATION,'dd/mm/yyyy'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE dcode="+dcode+" and M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%'or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "' group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by h.mname,h.pname,h.vname";
		query = "SELECT distinct h.dname,h.mname,h.pname,h.vname,m.ASSET_CODE,m.ASSET_NAME,nvl(to_char(m.DATE_CREATION,'dd/mm/yyyy'),'-'),m.ASSET_STATUS,nvl(m.LATITUDE,'0'),nvl(m.LONGITUDE,'0'),nvl(m.ELEVATION,'0'),nvl(m.WAY_POINT,'0'),COUNT(*),h.dcode,m.TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE dcode="
				+ dcode
				+ " AND M.TYPE_OF_ASSET_CODE='04' and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
				+ fyears[1]
				+ "' or DATE_CREATION is null) group by h.dname,h.mname,h.pname,h.vname,h.dcode,m.ASSET_CODE,m.ASSET_NAME,m.DATE_CREATION,m.ASSET_STATUS,m.LATITUDE,m.LONGITUDE,m.ELEVATION,m.WAY_POINT,m.TYPE_OF_ASSET_CODE order by m.ASSET_CODE";
	} else if (name.equals("Labs") && type.equals("16")) {
		query = "select dname,c.CIRCLE_OFFICE_NAME,d.DIVISION_OFFICE_NAME,w.LAB_CODE,w.LAB_NAME,w.LOCATION,count(*),dcode from rws_water_quality_lab_tbl w,rws_district_tbl,rws_circle_office_tbl c,rws_division_office_tbl d where substr(w.OFFICE_CODE,2,2)=c.CIRCLE_OFFICE_CODE and substr(w.OFFICE_CODE,4,1)=d.DIVISION_OFFICE_CODE and c.CIRCLE_OFFICE_CODE=d.CIRCLE_OFFICE_CODE  and  dcode="
				+ dcode
				+ " and substr(w.office_code,2,2)=dcode and w.status<>'UI' group by dname,c.CIRCLE_OFFICE_NAME,d.DIVISION_OFFICE_NAME,w.LAB_CODE,w.LAB_NAME,w.LOCATION,dcode";
	}

%>


<body>
	<form>
		<table border=1 cellspacing=0 cellpadding=0 width="100%"
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" ALIGN=CENTER>
			<caption>
				<table border=0 rules=none style="border-collapse: collapse" align="right">
					<tr align="right">
						<%
							if (name != null && name.equals("Mandals") && type.equals("01")) {
						%>
						<td class="bwborder"><a href="#"
							onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Mandals&type=01&finYear=<%=finYear%>','frameless')">Back</a>
							<%
								}
							
 							if (name.equals("Panchayats") && type.equals("02")) {
							 %>
						<td class="bwborder"><a href="#"
							onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Panchayats&type=02&finYear=<%=finYear%>','frameless')">Back</a>
						<%
							}
						%>

						<%
							if (name.equals("Villages") && type.equals("03")) {
						%>
						<td class="bwborder"><a href="#"
							onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Villages&type=03&finYear=<%=finYear%>','frameless')">Back</a>
						<%
							}
						%>

						<%
							if (name.equals("Habitations") && type.equals("04")){
								%>
								<td class="bwborder"><a href="#"
									onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Habitations&type=04&finYear=<%=finYear%>','frameless')">Back</a>
								<%
									}if(name.equals("HabitationFC") && type.equals("05")){%>
									
								<td class="bwborder"><a href="#"
									onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationFC&type=05&finYear=<%=finYear%>','frameless')">Back</a>
								
								<%  }if(name.equals("HabitationPC4") && type.equals("06")){%>
								
								<td class="bwborder"><a href="#"
								onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationPC4&type=06&finYear=<%=finYear%>','frameless')">Back</a>
								
								<%  }if(name.equals("HabitationPC3") && type.equals("07")){%>
								
								<td class="bwborder"><a href="#"
								onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationPC3&type=07&finYear=<%=finYear%>','frameless')">Back</a>
								
								<%  }if(name.equals("HabitationPC2") && type.equals("08")){%>
								
								<td class="bwborder"><a href="#"
								onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationPC2&type=08&finYear=<%=finYear%>','frameless')">Back</a>
								
								<%  }if(name.equals("HabitationPC1") && type.equals("09")){%>
								
								<td class="bwborder"><a href="#"
								onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationPC1&type=09&finYear=<%=finYear%>','frameless')">Back</a>
								
								<%  }if(name.equals("HabitationNSS") && type.equals("10")){%>
								
								<td class="bwborder"><a href="#"
								onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationNSS&type=10&finYear=<%=finYear%>','frameless')">Back</a>
								
								<%  }if(name.equals("HabitationNC") && type.equals("11")){%>
								
								<td class="bwborder"><a href="#"
								onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationNC&type=11&finYear=<%=finYear%>','frameless')">Back</a>
								
								<%  }%>
						


						<%
							if (name.equals("PWS") && type.equals("12")){%>
							
							<td class="bwborder"><a href="#"
							onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=PWS&type=12&finYear=<%=finYear%>','frameless')">Back</a>
							
							<%  }if(name.equals("MPWS") && type.equals("13")){%>
							
							<td class="bwborder"><a href="#"
							onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=MPWS&type=13&finYear=<%=finYear%>','frameless')">Back</a>
							
							<%  }if(name.equals("CPWS") && type.equals("14")){%>
							
							<td class="bwborder"><a href="#"
							onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=CPWS&type=14&finYear=<%=finYear%>','frameless')">Back</a>
							
							<%  }if(name.equals("HandPumps") && type.equals("15")){%>
							
							<td class="bwborder"><a href="#"
							onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HandPumps&type=15&finYear=<%=finYear%>','frameless')">Back</a>
							
							<%  }if (name.equals("Labs") && type.equals("16")) {%>
						<td class="bwborder"><a href="#"
							onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Labs&type=16&finYear=<%=finYear%>','frameless')">Back</a>
							
						<%}%>

						
					</tr>
				</table>
			</caption>

		</table>
		<div class='container'>
			<h2 id='mynav'></h2>
			<table class='table table-bordered table-striped table-fixed-header'
				width="100%">
				<thead class='header'>
					<%
						if ((name.equals("Habitations") && type.equals("04"))
								|| (name.equals("HabitationFC") && type.equals("05"))
								|| (name.equals("HabitationPC4") && type.equals("06"))
								|| (name.equals("HabitationPC3") && type.equals("07"))
								|| (name.equals("HabitationPC2") && type.equals("08"))
								|| (name.equals("HabitationPC1") && type.equals("09"))
								|| (name.equals("HabitationNSS") && type.equals("10"))
								|| (name.equals("HabitationNC") && type.equals("11"))) {
					%>
					<tr>
						<th align="center" class="gridhdbg" colspan="9"><%=dname%></th>
					</tr>
					<%
						} else if (name != null && name.equals("Mandals")
								&& type.equals("01")) {
					%><tr>
						<th align="center" class="gridhdbg" colspan="9"><%=dname%></th>
					</tr>
					<%
						} else if (name.equals("Panchayats") && type.equals("02")) {
					%><tr>
						<th align="center" class="gridhdbg" colspan="9"><%=dname%></th>
					</tr>
					<%
						} else if (name.equals("Villages") && type.equals("03")) {
					%><tr>
						<th align="center" class="gridhdbg" colspan="9"><%=dname%></th>
					</tr>
					<%
						} else if ((name.equals("PWS") && type.equals("12"))
								|| (name.equals("MPWS") && type.equals("13"))
								|| (name.equals("CPWS") && type.equals("14"))
								|| (name.equals("HandPumps") && type.equals("15"))) {
					%><tr>
						<th align="center" class="gridhdbg" colspan="12"><%=dname%></th>
					</tr>
					<%
						} else if (name.equals("Labs") && type.equals("16")) {
					%><tr>
						<th align="center" class="gridhdbg" colspan="6"><%=dname%></th>
					</tr>
					<%
						}
					%>
					<tr align=center>
						<th class=gridhdbg><b>SLNO </b></th>
						<%
							if (name != null && name.equals("Mandals") && type.equals("01")) {
						%>
						<th class=gridhdbg><b>Mandals </b></th>
						<%
							}
						%>

						<%
							if (name.equals("Panchayats") && type.equals("02")) {
						%>
						<th class=gridhdbg><b>Panchayats</b></th>
						<%
							}
						%>

						<%
							if (name.equals("Villages") && type.equals("03")) {
						%>
						<th class=gridhdbg><b>Villages</b></th>
						<%
							}
						%>

						<%
							if ((name.equals("Habitations") && type.equals("04"))
									|| (name.equals("HabitationFC") && type.equals("05"))
									|| (name.equals("HabitationPC4") && type.equals("06"))
									|| (name.equals("HabitationPC3") && type.equals("07"))
									|| (name.equals("HabitationPC2") && type.equals("08"))
									|| (name.equals("HabitationPC1") && type.equals("09"))
									|| (name.equals("HabitationNSS") && type.equals("10"))
									|| (name.equals("HabitationNC") && type.equals("11"))) {
						%>
						<th class=gridhdbg><b>Mandal</b></th>
						<th class=gridhdbg><b>Panchayat</b></th>
						<th class=gridhdbg><b>Village</b></th>
						<th class=gridhdbg><b>Habitation Code</b></th>
						<th class=gridhdbg><b>Habitation Name</b></th>
						<th class=gridhdbg><b>Census Plain Population</b></th>
						<th class=gridhdbg><b>Census SC Population</b></th>
						<th class=gridhdbg><b>Census ST Population</b></th>
						<%
							}
						%>


						<%
							if ((name.equals("PWS") && type.equals("12"))
									|| (name.equals("MPWS") && type.equals("13"))
									|| (name.equals("CPWS") && type.equals("14"))
									|| (name.equals("HandPumps") && type.equals("15"))) {
						%>
						<th class=gridhdbg><b>Mandal</b></th>
						<th class=gridhdbg><b>Panchayat</b></th>
						<th class=gridhdbg><b>Village</b></th>
						<th class=gridhdbg><b>Asset Code</b></th>
						<th class=gridhdbg><b>Asset Name</b></th>
						<th class=gridhdbg><b>Date of Creation</b></th>
						<th class=gridhdbg><b>Asset Status</b></th>
						<th class=gridhdbg><b>Latitude</b></th>
						<th class=gridhdbg><b>Longitude</b></th>
						<th class=gridhdbg><b>Elevation</b></th>
						<th class=gridhdbg><b>Way Point</b></th>
						<%
							}
						%>

						<%
							if (name.equals("Labs") && type.equals("16")) {
						%>
						<th class=gridhdbg><b>Circle</b></th>
						<th class=gridhdbg><b>Division</b></th>
						<th class=gridhdbg><b>Lab Code</b></th>
						<th class=gridhdbg><b>Lab Name</b></th>
						<th class=gridhdbg><b>Location</b></th>
						<%
							}
						%>



					</tr>
				</thead>
				<tbody>
					<%
						try {
							int count = 1;
							Statement stmt1 = null;
							ResultSet rs1 = null;
							String qry = "";
							stmt1 = conn.createStatement();
							String distname1 = "", distname2 = "";

							rs1 = stmt1.executeQuery(query);
							String style = "";
							int styleCount = 0;

							int workCount = 0;
							double sanctionAmount = 0;
							String oldAsset_code = "";
							while (rs1.next()) {
								String assettype = "", assetstatus = "";
								distname1 = "" + rs1.getString(1);

								if (styleCount % 2 == 0) {
									style = "gridbg1";
								} else {
									style = "gridbg2";
								}
								styleCount++;
					%>


					<%
						if ((name.equals("Mandals") && type.equals("01"))
										|| name.equals("Panchayats") && type.equals("02")
										|| name.equals("Villages") && type.equals("03")) {
					%>

					<tr>

						<td class=<%=style%> style="text-align: left;">&nbsp;<%=count++%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(2)%>
						</td>


					</tr>
					<%
						}
					%>

					<%
						if ((name.equals("Habitations") && type.equals("04"))
										|| (name.equals("HabitationFC") && type
												.equals("05"))
										|| (name.equals("HabitationPC4") && type
												.equals("06"))
										|| (name.equals("HabitationPC3") && type
												.equals("07"))
										|| (name.equals("HabitationPC2") && type
												.equals("08"))
										|| (name.equals("HabitationPC1") && type
												.equals("09"))
										|| (name.equals("HabitationNSS") && type
												.equals("10"))
										|| (name.equals("HabitationNC") && type
												.equals("11"))) {
					%>
					<tr>

						<td class=<%=style%> style="text-align: left;">&nbsp;<%=count++%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(2)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(3)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(4)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(5)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(6)%>
						</td>
						<td class=<%=style%> style="text-align: right;"><%=rs1.getString(7)%>
						</td>
						<td class=<%=style%> style="text-align: right;"><%=rs1.getString(8)%>
						</td>
						<td class=<%=style%> style="text-align: right;"><%=rs1.getString(9)%>
						</td>

					</tr>
					<%
						}
					%>

					<%
						if ((name.equals("PWS") && type.equals("12"))
										|| (name.equals("MPWS") && type.equals("13"))
										|| (name.equals("CPWS") && type.equals("14"))
										|| (name.equals("HandPumps") && type.equals("15"))) {
									assettype = rs1.getString(15);
									if (assettype != null
											&& (assettype.equals("03") || assettype
													.equals("01"))) {
										if (rs1.getInt(8) == 1) {
											assetstatus = "Working";
										} else if (rs1.getInt(8) == 2) {
											assetstatus = "Defunt";
										} else {
											assetstatus = "";
										}
									} else {
										if (rs1.getInt(8) == 1) {
											assetstatus = "Working";
										} else if (rs1.getInt(8) == 2) {
											assetstatus = "Not Working";
										} else if (rs1.getInt(8) == 3) {
											assetstatus = "Dried";
										} else if (rs1.getInt(8) == 4) {
											assetstatus = "Seasonal";
										} else if (rs1.getInt(8) == 5) {
											assetstatus = "Condemed";
										} else {
											assetstatus = "";
										}
									}
					%>
					<%
						if (!oldAsset_code.equals(rs1.getString(5))) {
					%>
					<tr>

						<td class=<%=style%> style="text-align: left;">&nbsp;<%=count++%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(2)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(3)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(4)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(5)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(6)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(7)%>
						</td>

						<td class=<%=style%> style="text-align: left;"><%=assetstatus%>
						</td>

						<td class=<%=style%> style="text-align: right;"><%=rs1.getString(9)%>
						</td>
						<td class=<%=style%> style="text-align: right;"><%=rs1.getString(10)%>
						</td>
						<td class=<%=style%> style="text-align: right;"><%=rs1.getString(11)%>
						</td>
						<td class=<%=style%> style="text-align: right;"><%=rs1.getString(12)%>
						</td>

					</tr>
					<%
						}
									oldAsset_code = rs1.getString(5);
								}
					%>


					<%
						if (name.equals("Labs") && type.equals("16")) {
					%>
					<tr>
						<td class=<%=style%> style="text-align: left;">&nbsp;<%=count++%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(2)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(3)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(4)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(5)%>
						</td>
						<td class=<%=style%> style="text-align: left;"><%=rs1.getString(6)%>
						</td>
					</tr>
					<%} %>



					<% 
           distname2 = distname1;
       }
       
       %>

					<tr>



					</tr>
					<% 
       
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
				</tbody>
			</table>
		</div>
		<script language='javascript' type='text/javascript'>
      $(document).ready(function(){
      $('.table-fixed-header').fixedHeader();
      });
    </script>
	</form>
</body>
</html>
