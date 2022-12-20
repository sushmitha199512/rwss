<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_habitation_abstract_rpt1_excel_n.xls"); %>
<head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
<script type="text/javascript">
function fncheck(){
	alert(1);
	 var lpcdrange=document.getElementById('lpcdrange').value;
	alert("lpcdrange"+lpcdrange);
}
function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";

	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
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
<%
	////System.out.println("dsss");
	StringBuffer query = new StringBuffer();
	Calendar cal = Calendar.getInstance();
	StringBuffer year = new StringBuffer();
	year.append(String.valueOf(cal.get(Calendar.YEAR)));
	//System.out.println("year"+year);
	String FC = "FC";
	String PC4 = "PC4";
	String PC3 = "PC3";
	String PC2 = "PC2";
	String PC1 = "PC1";
	String NSS = "NSS";
	String NC = "NC";
	int prevYear = Integer.parseInt(year.toString()) - 1;
	StringBuffer finYear = new StringBuffer();
	//String finYear="";
	if (request.getParameter("finyear") != null) {
		finYear.append(request.getParameter("finyear"));
	} else {
		finYear.append(session.getAttribute("finYear"));
	}
	////System.out.println("finYear="+year.toString());
	session.setAttribute("finYear", finYear);
	StringBuffer lpcdrange = new StringBuffer();
	//String lpcdrange="";
	if (request.getParameter("lpcdrange") != null) {
		lpcdrange.append(request.getParameter("lpcdrange"));
	} else {
		lpcdrange.append("55");
	}
	session.setAttribute("lpcdrange", lpcdrange);
	//  //System.out.println("s***lpcdrange**"+lpcdrange);
	StringBuffer poptype = new StringBuffer();
	if (request.getParameter("poptype") != null
			&& !request.getParameter("poptype").equals("")
			&& !request.getParameter("poptype").equals("ALL")) {
		//System.out.println("anupama");
		poptype.append(request.getParameter("poptype"));
	} else {
		poptype.append("ALL");
	}
	//System.out.println("anupama123");
	session.setAttribute("poptype", poptype);

	//System.out.println("poptype"+poptype);
	StringBuffer habTableName = new StringBuffer();
	//String habTableName="";
	java.util.Date d = new java.util.Date();
	////System.out.println("year"+year);
	////System.out.println("finYear"+finYear);
	////System.out.println("prevYear"+prevYear);
	//session.setAttribute("prevYear",prevYear);
	//String s=finYear.substring(0,4);
	////System.out.println("s*****"+s);

	StringBuffer s = new StringBuffer();
	s.append(finYear.substring(0, 4));
	if (finYear.toString().substring(0, 4).equals(year.toString())) {
		habTableName.append("rws_habitation_directory_tbl");

	} else if (finYear.toString().substring(0, 4)
			.equals(String.valueOf(prevYear))) {
		habTableName.append("RWS_HABITATION_DIR_HIS_TBL");
	} else {
		habTableName.append("RWS_HABITATION_DIR_HIS" + s + "_TBL");
	}
	//System.out.println("hab table"+habTableName);
	session.setAttribute("habTableName", habTableName);
	////System.out.println("Hab Table"+habTableName);
	//java.util.Date d=new java.util.Date();
	//if(d.getMonth()==3){
	//habTableName="rws_habitation_directory_tbl";
	//}

	StringBuffer rDistrict = new StringBuffer();
	StringBuffer rDistrictName = new StringBuffer();
	StringBuffer rMandal = new StringBuffer();

	StringBuffer rMandalName = new StringBuffer();
	StringBuffer rPanchayat = new StringBuffer();
	StringBuffer rPanchayatName = new StringBuffer();
	StringBuffer dname = new StringBuffer();
	StringBuffer drill = new StringBuffer();
	StringBuffer style = new StringBuffer();

	StringBuffer year1 = new StringBuffer();
	StringBuffer dnamee = new StringBuffer();

	////.out.println("habTableName:"+habTableName);
	////System.out.println("rDistrict:"+request.getParameter("rDistrict"));
	//String rDistrict=null,rDistrictName=null,rMandal=null,rMandalName=null,rPanchayat=null,rPanchayatName=null;
	ResultSet rs1 = null, rs2 = null, prs = null, vrs = null, hrs = null;
	Statement pst = null, vst = null, hst = null, getHabSt = null, stmt1 = null;
	PreparedStatement ps1 = null;
	if (request.getParameter("rDistrict") != null) {

		rDistrict.append(request.getParameter("rDistrict"));
	} else {
		rDistrict.append(session.getAttribute("rDistrict"));
	}

	if (rDistrict.toString() != null) {
		session.setAttribute("rDistrict", rDistrict);
	}
	////System.out.println("s1*****"+rDistrict);
	if (request.getParameter("rDistrictName") != null) {
		rDistrictName.append(request.getParameter("rDistrictName"));
	}

	else {
		rDistrictName.append(session.getAttribute("rDistrictName"));
	}
	if (rDistrictName.toString() != null) {
		session.setAttribute("rDistrictName", rDistrictName);
	}
	////System.out.println("s2*****"+rDistrictName);
	rMandal.append(request.getParameter("rMandal"));
	if (rMandal.toString() != null) {
		session.setAttribute("rMandal", rMandal);
	}
	////System.out.println("s3*****"+rMandal);
	rMandalName.append(request.getParameter("rMandalName"));
	if (rMandalName.toString() != null) {
		session.setAttribute("rMandalName", rMandalName);
	}
	////System.out.println("s4*****"+rMandalName);
	rPanchayat.append(request.getParameter("rPanchayat"));
	if (rPanchayat.toString() != null) {
		session.setAttribute("rPanchayat", rPanchayat);
	}
	////System.out.println("s5*****"+rPanchayat);
	rPanchayatName.append(request.getParameter("rPanchayatName"));
	if (rPanchayatName.toString() != null) {
		session.setAttribute("rPanchayatName", rPanchayatName);
	}
	////System.out.println("s6*****"+rPanchayatName);
	//String dname ="",drill="";
	if (request.getParameter("rDistrictName") != null) {
		dname.append(request.getParameter("rDistrictName"));
	} else {
		dname.append(session.getAttribute("rDistrictName"));
	}
	if (rDistrictName.toString() != null) {
		session.setAttribute("rDistrictName", dname);
	}
	////System.out.println("s7*****"+dname);
	if (request.getParameter("drill") != null) {
		drill.append(request.getParameter("drill"));
	} else {
		drill.append(session.getAttribute("drill"));
	}
	if (drill.toString() != null) {
		session.setAttribute("drill", drill);
	}
	int styleCount = 0;

	StringBuffer getDnameQuery = new StringBuffer();
	StringBuffer pQuery = new StringBuffer();

	StringBuffer vQuery = new StringBuffer();
	StringBuffer hQuery = new StringBuffer();
	StringBuffer hquery1 = new StringBuffer();

	//String style="";
	////System.out.println("Drill:"+drill);
	if (drill.toString().equals("null")) {
%>
<html>
<head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
<script type="text/javascript">
function fnValidate(){
	//alert("Fsdfd");
	document.getElementById('lpcdrange').value='<%=lpcdrange.toString()%>';
	document.getElementById('poptype').value='<%=poptype.toString()%>';
	}
</script>
</head>
<body bgcolor="#edf2f8" onload="fnValidate();">
	<form>
		<table border=0 cellspacing=0 cellpadding=0 height=5% width="100%"
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" align="center">
			<caption>
				<table border=0 rules=none style="border-collapse: collapse"
					align="right">
					<!-- <tr>
						
						<td align="right" class="bwborder"><a
							href="javascript:history.go(-1)">Back</a>| <a href="../home.jsp">Home</a>|
							<a href="./rws_habitation_abstract_rpt1_excel_n.jsp" target=_new>Excel</a>
						</td>
					</tr> -->
				</table>
			</caption>
			<%-- <tr align="center">

				<td class=rptLabel colspan=20>Select Type:<font color="red">*</font><SELECT
					name="poptype" id="poptype" style="width: 140px"
					onchange="this.form.submit()">
					<% if (poptype.toString().equals("ALL")) {%>
						<option value="ALL" selected>ALL</option>
						<option value="SC">SC</option>
						<option value="ST">ST</option>
						<option value="PLAIN">PLAIN</option>
					<% }else if (poptype.toString().equals("SC")) {%>
						<option value="ALL">ALL</option>
						<option value="SC" selected>SC</option>
						<option value="ST">ST</option>
						<option value="PLAIN">PLAIN</option>
					<% }else if (poptype.toString().equals("ST")) {%>
						<option value="ALL">ALL</option>
						<option value="SC">SC</option>
						<option value="ST" selected>ST</option>
						<option value="PLAIN">PLAIN</option>
					<% }else if (poptype.toString().equals("PLAIN")) {%>
						<option value="ALL">ALL</option>
						<option value="SC">SC</option>
						<option value="ST">ST</option>
						<option value="PLAIN" selected>PLAIN</option>						
					<% }else{%>
						<option value="ALL">ALL</option>
						<option value="SC">SC</option>
						<option value="ST">ST</option>
						<option value="PLAIN">PLAIN</option>						
					<% }%>

				</SELECT></td>
			</tr> --%>
			<%-- <TR align="center">
				<td class=rptLabel colspan=20>As Per LPCD:<font color="red">*</font><SELECT
					name="lpcdrange" id="lpcdrange" style="width: 140px"
					onchange="this.form.submit()">
					<% if (lpcdrange.toString().equals("55")) {%> 
						<option value="55" selected>55</option>
						<option value="40">40</option>
					<% }else if (lpcdrange.toString().equals("40")) {%>
						<option value="55">55</option>
						<option value="40" selected>40</option>
					<% }else{%>
						<option value="55">55</option>
						<option value="40">40</option>						
					<% }%>
				</SELECT></td>
			</tr> --%>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class=gridhdbg colspan=20>Habitation-Status-Abstract-Report</td>
			</tr>
			<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->


			<%
				try {

						if (rDistrict.toString() != null
								&& rDistrict.toString().equals("00")) {
			%>
			<tr align="center">
				<td class=gridhdbg rowspan=2>Sno</td>
				<td class=gridhdbg rowspan=2>District</td>
				<td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>
				<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>
				<td class=gridhdbg rowspan=2>No. of Habs</td>
				<td class=gridhdbg rowspan=2>Pop</td>
				<td class=gridhdbg colspan=14 align=center nowrap>Status as <%=finYear%>
					[(as per level of water supply (LPCD)]
				</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg>FC</td>
				<td class=gridhdbg>Pop</td>
				<td class=gridhdbg>PC4</td>
				<td class=gridhdbg>Pop</td>
				<td class=gridhdbg>PC3</td>
				<td class=gridhdbg>Pop</td>
				<td class=gridhdbg>PC2</td>
				<td class=gridhdbg>Pop</td>
				<td class=gridhdbg>PC1</td>
				<td class=gridhdbg>Pop</td>
				<td class=gridhdbg>NSS</td>
				<td class=gridhdbg>Pop</td>
				<td class=gridhdbg>NC</td>
				<td class=gridhdbg>Pop</td>
			</tr>
			<%
				getDnameQuery.delete(0, getDnameQuery.length());
							getDnameQuery
									.append("select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode");
							String scstplain = "";
							////System.out.println("getDnameQuery:"+getDnameQuery);
							ps1 = conn.prepareStatement(getDnameQuery.toString());
							rs2 = ps1.executeQuery();
							int sno = 1;
							double Lpcd = 0.0;
							int rowTotal = 0, columnTotal1 = 0, columnTotal2 = 0, columnTotal3 = 0, columnTotal4 = 0, columnTotal5 = 0, columnTotal6 = 0, columnTotal7 = 0, columnTotal8 = 0, columnTotal9 = 0, columnTotal10 = 0;
							int count1 = 0, count2 = 0, count3 = 0, count4 = 0, count5 = 0, count6 = 0, count7 = 0;
							int pcount = 0, vcount = 0, hcount = 0;
							String calCoverageStatus = "";
							int FCpop = 0, PC4pop = 0, PC3pop = 0, PC2pop = 0, PC1pop = 0, NCpop = 0, NSSpop = 0, totalpop = 0, Gtotalpop = 0;
							int FCpopTotal = 0, PC4popTotal = 0, PC3popTotal = 0, PC2popTotal = 0, PC1popTotal = 0, NCpopTotal = 0, NSSpopTotal = 0;
							//date = new Date();
							////System.out.println("1:"+dateFormat.format(date));
							while (rs2.next()) {
								////System.out.println("11111111111111");
								//pQuery.delete(0, pQuery.length());
								//pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS <> 'UI'  and d.dcode='"+rs2.getString(1)+"'");
								//vQuery.delete(0, vQuery.length());
								//vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS <> 'UI'  and d.dcode='"+rs2.getString(1)+"'");
								//Query modified by pranavi
								//hQuery.delete(0, hQuery.length());
								//hQuery.append("select distinct h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0')) as totalpop,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS <> 'UI'  and d.dcode='"+rs2.getString(1)+"'");
								//hquery1.delete(0, hquery1.length());
								//hquery1.append("select distinct h.panch_code,nvl(ACT_PLAIN_POPU,0)+nvl(ACT_SC_POPU,0)+nvl(ACT_ST_POPU,0),nvl(total_water_supply,0),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS <> 'UI'  and d.dcode='"+rs2.getString(1)+"'");

								pQuery.delete(0, pQuery.length());
								pQuery.append("select distinct substr(h.panch_code,1,2)||substr(h.panch_code,6,2)||substr(h.panch_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"
										+ habTableName
										+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
										+ rs2.getString(1) + "' ");
								vQuery.delete(0, vQuery.length());
								vQuery.append("select distinct substr(h.panch_code,1,2)||substr(h.panch_code,6,2)||substr(h.panch_code,13,2)||substr(h.panch_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"
										+ habTableName
										+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
										+ rs2.getString(1) + "' ");
								//Query modified by pranavi
								hQuery.delete(0, hQuery.length());
								hQuery.append("select distinct h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0')) as totalpop,nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0),hd.ACT_SC_POPU from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"
										+ habTableName
										+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
										+ rs2.getString(1) + "' ");
								if (poptype.toString() != null
										&& !poptype.toString().equals("")
										&& !poptype.toString().equals("ALL")) {
									if (poptype.toString().equals("SC")) {
										hQuery.append(" and (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
									} else if (poptype.toString().equals("ST")) {
										hQuery.append("  and (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
									} else {
										hQuery.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");

									}
								}
								hquery1.delete(0, hquery1.length());
								hquery1.append("select distinct h.panch_code,nvl(hd.ACT_PLAIN_POPU,0)+nvl(hd.ACT_SC_POPU,0)+nvl(hd.ACT_ST_POPU,0),nvl(hd.total_water_supply,0),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"
										+ habTableName
										+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
										+ rs2.getString(1) + "' ");
								if (poptype.toString() != null
										&& !poptype.toString().equals("")
										&& !poptype.toString().equals("ALL")) {

									if (poptype.toString().equals("SC")) {
										hquery1.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
									} else if (poptype.toString().equals("ST")) {
										hquery1.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
									} else {
										hquery1.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");

									}
								}

								pcount = 0;
								vcount = 0;
								hcount = 0;
								count1 = 0;
								count2 = 0;
								count3 = 0;
								count4 = 0;
								count5 = 0;
								count6 = 0;
								count7 = 0;
								FCpop = 0;
								PC4pop = 0;
								PC3pop = 0;
								PC2pop = 0;
								PC1pop = 0;
								NCpop = 0;
								NSSpop = 0;
								totalpop = 0;
								//System.out.println("pQuery:  "+pQuery);
								//System.out.println("vQuery:  "+vQuery);
								//System.out.println("@@@@@@@hQuery:  " + hQuery);
								//System.out.println("@@@@@@@hQuery1:" + hquery1);
								////////System.out.println("-------------");
								pst = conn.createStatement();
								vst = conn.createStatement();
								hst = conn.createStatement();

								prs = pst.executeQuery(pQuery.toString());
								vrs = vst.executeQuery(vQuery.toString());

								if (lpcdrange.toString().equals("55")) {
									//System.out.println("hQuery  "+hQuery);
									hrs = hst.executeQuery(hQuery.toString());

								} else {
									////System.out.println("hQuery1"+hquery1);
									hrs = hst.executeQuery(hquery1.toString());
								}

								//date = new Date();
								// //System.out.println("2:"+dateFormat.format(date));

								while (prs.next())
									pcount++;
								while (vrs.next())
									vcount++;
								//date = new Date();
								//  //System.out.println("3:"+dateFormat.format(date));
								////System.out.println("22222222222");
								stmt1 = conn.createStatement();
								////System.out.println("pcount:"+pcount);
								//	//System.out.println("vcount:"+vcount);	
								if (lpcdrange.toString().equals("55")) {
									//System.out.println("in 55 lpcd");
									while (hrs.next()) {

										hcount++;
										totalpop = totalpop + hrs.getInt(4);
										int total_pop = hrs.getInt(4);
										int scpopu = hrs.getInt(7);

										//System.out.println("totalpop="+total_pop);
										//System.out.println("scpopu="+scpopu);
										double water_supply = hrs.getDouble(2);
										double safelpcd = hrs.getDouble(5);
										double unsafelpcd = hrs.getDouble(6);
										////System.out.println("===watersupply"+water_supply);
										double lpcd = (safelpcd + unsafelpcd)
												/ total_pop;

										////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
										if (safelpcd == 0 && unsafelpcd != 0) {

											count6++;
											NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
										} else {
											if (safelpcd == 0) {
												count7++;
												NCpop = NCpop + total_pop;
											} else if (safelpcd >= 55) {
												count1++;
												FCpop = FCpop + total_pop;
											} else if (safelpcd > 0
													&& safelpcd < 13.75) {
												count2++;
												PC1pop = PC1pop + total_pop;
											} else if (safelpcd >= 13.75
													&& safelpcd < 27.50) {
												count3++;
												PC2pop = PC2pop + total_pop;
											} else if (safelpcd >= 27.50
													&& safelpcd < 41.25) {
												count4++;
												PC3pop = PC3pop + total_pop;
											} else if (safelpcd >= 41.25
													&& safelpcd < 55) {
												count5++;
												PC4pop = PC4pop + total_pop;
											}
										}
									}
								} else {
									//System.out.println("in 40 lpcd");
									while (hrs.next()) {

										hcount++;
										totalpop = totalpop + hrs.getInt(2);
										int total_pop = hrs.getInt(2);
										////System.out.println("totalpop="+total_pop);
										double water_supply = hrs.getDouble(3);
										double safelpcd = hrs.getDouble(4);
										double unsafelpcd = hrs.getDouble(5);
										////System.out.println("===watersupply"+water_supply);
										double lpcd = (safelpcd + unsafelpcd)
												/ total_pop;

										////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
										if (safelpcd == 0 && unsafelpcd != 0) {

											count6++;
											NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
										} else {
											if (safelpcd == 0) {
												count7++;
												NCpop = NCpop + total_pop;
											} else if (safelpcd > 40) {
												count1++;
												FCpop = FCpop + total_pop;
											} else if (safelpcd > 0
													&& safelpcd <= 10) {
												count2++;
												PC1pop = PC1pop + total_pop;
											} else if (safelpcd > 10
													&& safelpcd <= 20) {
												count3++;
												PC2pop = PC2pop + total_pop;
											} else if (safelpcd > 20
													&& safelpcd <= 30) {
												count4++;
												PC3pop = PC3pop + total_pop;
											} else if (safelpcd > 30
													&& safelpcd <= 40) {
												count5++;
												PC4pop = PC4pop + total_pop;
											}
										}
									}
								}
								style.delete(0, style.length());
								if (styleCount % 2 == 0) {
									style.append("gridbg1");
								} else {
									style.append("gridbg2");
								}
								styleCount++;

								//date = new Date();
								////System.out.println("5*******************5:"+dateFormat.format(date));
			%>
			<tr>
				<td class="<%=style%>"><%=sno++%></td>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><%=rs2.getString(2)%></td>
				<td class="<%=style%>" style="text-align: right;"><%=pcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=vcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
				<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
			</tr>
			<%
				columnTotal1 += pcount;
								columnTotal2 += vcount;
								columnTotal3 += hcount;
								columnTotal4 += count1;
								columnTotal5 += count5;
								columnTotal6 += count4;
								columnTotal7 += count3;
								columnTotal8 += count2;
								columnTotal9 += count6;
								columnTotal10 += count7;
								FCpopTotal += FCpop;
								PC4popTotal += PC4pop;
								Gtotalpop += totalpop;
								PC3popTotal += PC3pop;
								PC2popTotal += PC2pop;
								PC1popTotal += PC1pop;
								NCpopTotal += NCpop;
								NSSpopTotal += NSSpop;
							}
							String Dcode="", Dname="";
			%>
			<tr>
				<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal1%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal2%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
				<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
				<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC4popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
				<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
				<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
			</tr>
			<%
				//style="";styleCount=0;
						} else {

							//System.out.println("in next 123anupama");
			%>
			<html>
<head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
</head>
<body bgcolor="#edf2f8">

	<table border=1 cellspacing=0 cellpadding=0 height=5% width="100%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" align="center">
		<!--<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td style="text-align: right;" class="bwborder">
					<!--<a href="excelrpt.jsp">Excel
					</td>-->
		<!-- <td style="text-align: right;" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					 <a href="./rws_habitation_abstract_rpt1_excel.jsp" target=_new>Excel</a> 
					</td>
				</tr>
			</table>
		</caption>
		  <TR align="center">
		<td class=rptLabel colspan=20>LPCD Range:<font color="red">*</font><SELECT name="lpcdrange" id="lpcdrange" style="width:140px" onchange="this.form.submit()" >

				 
				 <option value="55">55</option>
				 <option value="40">40</option>
				 </SELECT></td>
		</tr>
		 
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=20>Habitation-Status-Abstract-Report</td>	
		</tr> -->
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

		<%
			try {
		%>
		<tr align="center" bgcolor="#ffffff">
			<td class=gridhdbg rowspan=2>Sno*&&&</td>
			<td class=gridhdbg rowspan=2>Mandal*</td>
			<td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>
			<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>
			<td class=gridhdbg rowspan=2>Pop</td>
			<td class=gridhdbg colspan=14 align=center nowrap>Status as on
				01.04.<%=s.toString()%> [(as per level of water supply (LPCD)]
			</td>
		</tr>
		<tr align="center">
			<td class=gridhdbg>FC</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC4</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC3</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC2</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC1</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NSS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NC</td>
			<td class=gridhdbg>Pop</td>
		</tr>
		<%
			//String getDnameQuery = "select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mcode";
							getDnameQuery.delete(0, getDnameQuery.length());
							getDnameQuery
									.append("select mcode,mname,dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and d.dcode = '"
											+ rDistrict.toString()
											+ "' order by m.mcode");
							////System.out.println("query:"+getDnameQuery);
							getHabSt = conn.createStatement(
									ResultSet.TYPE_SCROLL_SENSITIVE,
									ResultSet.CONCUR_UPDATABLE);
							rs2 = getHabSt.executeQuery(getDnameQuery
									.toString());
							rs2.next();
							dnamee.delete(0, dnamee.length());
							dnamee.append(rs2.getString(3));
							////System.out.println("dnamee:"+dnamee);
		%>
		<tr>
			<td class="btext" colspan="20">District:<%=dnamee.toString()%></td>
		</tr>
		<%
			rs2.previous();
							int sno = 1;
							double Lpcd = 0.0;
							int rowTotal = 0, columnTotal1 = 0, columnTotal2 = 0, columnTotal3 = 0, columnTotal4 = 0, columnTotal5 = 0, columnTotal6 = 0, columnTotal7 = 0, columnTotal8 = 0, columnTotal9 = 0, columnTotal10 = 0;
							int count1 = 0, count2 = 0, count3 = 0, count4 = 0, count5 = 0, count6 = 0, count7 = 0;
							int pcount = 0, vcount = 0, hcount = 0;
							String calCoverageStatus = "";
							int FCpop = 0, PC4pop = 0, PC3pop = 0, PC2pop = 0, PC1pop = 0, NCpop = 0, NSSpop = 0, totalpop = 0, Gtotalpop = 0;
							int FCpopTotal = 0, PC4popTotal = 0, PC3popTotal = 0, PC2popTotal = 0, PC1popTotal = 0, NCpopTotal = 0, NSSpopTotal = 0;

							while (rs2.next()) {
								pQuery.delete(0, pQuery.length());
								pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
										+ habTableName
										+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
										+ rDistrict
										+ "'  and m.mcode='"
										+ rs2.getString(1) + "'");
								vQuery.delete(0, vQuery.length());
								vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
										+ habTableName
										+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
										+ rDistrict
										+ "'  and m.mcode='"
										+ rs2.getString(1) + "'");
								hQuery.delete(0, hQuery.length());
								//Query modified by pranavi
								hQuery.append("select h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0')) as totalpop,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
										+ habTableName
										+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
										+ rDistrict
										+ "'  and m.mcode='"
										+ rs2.getString(1) + "'");

								if (poptype.toString() != null
										&& !poptype.toString().equals("")
										&& !poptype.toString().equals("ALL")) {
									if (poptype.toString().equals("SC")) {
										hQuery.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
									} else if (poptype.toString().equals("ST")) {
										hQuery.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
									} else {
										hQuery.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
									}
								}

								hquery1.delete(0, hquery1.length());
								hquery1.append("select h.panch_code,nvl(ACT_PLAIN_POPU,0)+nvl(ACT_SC_POPU,0)+nvl(ACT_ST_POPU,0),nvl(total_water_supply,0) as totalpop ,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
										+ habTableName
										+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
										+ rDistrict
										+ "'  and m.mcode='"
										+ rs2.getString(1) + "'");

								if (poptype.toString() != null
										&& !poptype.toString().equals("")
										&& !poptype.toString().equals("ALL")) {
									if (poptype.toString().equals("SC")) {
										hquery1.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
									} else if (poptype.toString().equals("ST")) {
										hquery1.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
									} else {
										hquery1.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");

									}
								}

								////System.out.println("hQuery:"+hquery1);
								pcount = 0;
								vcount = 0;
								hcount = 0;
								count1 = 0;
								count2 = 0;
								count3 = 0;
								count4 = 0;
								count5 = 0;
								count6 = 0;
								count7 = 0;
								FCpop = 0;
								PC4pop = 0;
								PC3pop = 0;
								PC2pop = 0;
								PC1pop = 0;
								NCpop = 0;
								NSSpop = 0;
								totalpop = 0;
								pst = conn.createStatement();
								vst = conn.createStatement();
								hst = conn.createStatement();

								prs = pst.executeQuery(pQuery.toString());
								vrs = vst.executeQuery(vQuery.toString());
								//hrs = hst.executeQuery(hQuery);
								if (lpcdrange.toString().equals("55")) {
									////System.out.println("hQuery"+hQuery);
									hrs = hst.executeQuery(hQuery.toString());
								} else {
									////System.out.println("hQuery1"+hquery1);
									hrs = hst.executeQuery(hquery1.toString());
								}
								while (prs.next())
									pcount++;
								while (vrs.next())
									vcount++;
								stmt1 = conn.createStatement();
								if (lpcdrange.toString().equals("55")) {
									//System.out.println("in 55 lpcd");
									while (hrs.next()) {

										hcount++;
										totalpop = totalpop + hrs.getInt(4);
										int total_pop = hrs.getInt(4);
										////System.out.println("totalpop="+total_pop);
										double water_supply = hrs.getDouble(2);
										double safelpcd = hrs.getDouble(5);
										double unsafelpcd = hrs.getDouble(6);
										////System.out.println("===watersupply"+water_supply);
										double lpcd = (safelpcd + unsafelpcd)
												/ total_pop;

										////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
										if (safelpcd == 0 && unsafelpcd != 0) {

											count6++;
											NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
										} else {
											if (safelpcd == 0) {
												count7++;
												NCpop = NCpop + total_pop;
											} else if (safelpcd >= 55) {
												count1++;
												FCpop = FCpop + total_pop;
											} else if (safelpcd > 0
													&& safelpcd < 13.75) {
												count2++;
												PC1pop = PC1pop + total_pop;
											} else if (safelpcd >= 13.75
													&& safelpcd < 27.50) {
												count3++;
												PC2pop = PC2pop + total_pop;
											} else if (safelpcd >= 27.50
													&& safelpcd < 41.25) {
												count4++;
												PC3pop = PC3pop + total_pop;
											} else if (safelpcd >= 41.25
													&& safelpcd < 55) {
												count5++;
												PC4pop = PC4pop + total_pop;
											}
										}
									}
								} else {
									//System.out.println("in 40 lpcd");
									while (hrs.next()) {

										hcount++;
										totalpop = totalpop + hrs.getInt(2);
										int total_pop = hrs.getInt(2);
										////System.out.println("totalpop="+total_pop);
										double water_supply = hrs.getDouble(3);
										double safelpcd = hrs.getDouble(4);
										double unsafelpcd = hrs.getDouble(5);
										////System.out.println("===watersupply"+water_supply);
										double lpcd = (safelpcd + unsafelpcd)
												/ total_pop;

										////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
										if (safelpcd == 0 && unsafelpcd != 0) {

											count6++;
											NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
										} else {
											if (safelpcd == 0) {
												count7++;
												NCpop = NCpop + total_pop;
											} else if (safelpcd > 40) {
												count1++;
												FCpop = FCpop + total_pop;
											} else if (safelpcd > 0
													&& safelpcd <= 10) {
												count2++;
												PC1pop = PC1pop + total_pop;
											} else if (safelpcd > 10
													&& safelpcd <= 20) {
												count3++;
												PC2pop = PC2pop + total_pop;
											} else if (safelpcd > 20
													&& safelpcd <= 30) {
												count4++;
												PC3pop = PC3pop + total_pop;
											} else if (safelpcd > 30
													&& safelpcd <= 40) {
												count5++;
												PC4pop = PC4pop + total_pop;
											}
										}
									}
								}
								style.delete(0, style.length());
								if (styleCount % 2 == 0) {
									style.append("gridbg1");
								} else {
									style.append("gridbg2");
								}
								styleCount++;
		%>
		<tr>
			<td class="<%=style%>"><%=sno++%></td>
			<td class="rptValue" style="text-align: left;"><a
				href="rws_habitation_abstract_rpt1_n.jsp?drill=next1&rDistrict=<%=rDistrict%>&rDistrictName=<%=rDistrictName%>&rMandal=<%=rs2.getString(1)%>&rMandalName=<%=rs2.getString(2)%>&finyear=<%=finYear%>&poptype=<%=poptype%>&lpcdrange=<%=lpcdrange%>"><%=rs2.getString(2)%></a></td>
			<td class="<%=style%>" style="text-align: right;"><%=pcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=vcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
			<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
		</tr>
		<%
			columnTotal1 += pcount;
								columnTotal2 += vcount;
								columnTotal3 += hcount;
								columnTotal4 += count1;
								columnTotal5 += count5;
								columnTotal6 += count4;
								columnTotal7 += count3;
								columnTotal8 += count2;
								columnTotal9 += count6;
								columnTotal10 += count7;
								FCpopTotal += FCpop;
								PC4popTotal += PC4pop;
								Gtotalpop += totalpop;
								PC3popTotal += PC3pop;
								PC2popTotal += PC2pop;
								PC1popTotal += PC1pop;
								NCpopTotal += NCpop;
								NSSpopTotal += NSSpop;

							}
							//style="";styleCount=0;
		%>
		<tr>
			<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal1%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal2%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
			<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
			<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
			<td class=gridhdbg><%=PC4popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
			<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
			<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
		</tr>


		<%
			} catch (Exception e) {
							e.printStackTrace();
						}

					}
		%>


		<%
			} catch (Exception e) {
					e.printStackTrace();
				} finally {

					dname = null;
					rDistrictName = null;
					rMandal = null;
					rMandalName = null;
					rPanchayat = null;
					rPanchayatName = null;
					year = null;
					rDistrict = null;
					style = null;
					pQuery = null;
					getDnameQuery = null;
					vQuery = null;
					hQuery = null;
					hquery1 = null;
					dnamee = null;
					year1 = null;

					try {
						if (hrs != null) {
							hrs.close();
						}
						if (hst != null) {
							hst.close();
						}
						if (vrs != null) {
							vrs.close();
						}
						if (vst != null) {
							vst.close();
						}
						if (prs != null) {
							prs.close();
						}
						if (pst != null) {
							pst.close();
						}
						if (rs2 != null) {
							rs2.close();
						}
						if (getHabSt != null) {
							getHabSt.close();
						}
						if (ps1 != null) {
							ps1.close();
						}
						if (rs1 != null) {
							rs1.close();
						}
						if (stmt1 != null) {
							stmt1.close();
						}
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			} else if (drill.toString() != null
					&& drill.toString().equals("next")) {

				String rDistrict1 = request.getParameter("rDistrictName");
				String type = request.getParameter("poptype");
				String lpcdrange2 = request.getParameter("lpcdrange");
				//	System.out.println("in next annnn rDistrict1"+rDistrict1);
				////	System.out.println("in next  type"+type);
				//	System.out.println("in next  lpcdrange2"+lpcdrange2);
				//S//ystem.out.println("in next annnn");
		%>
		<html>
<head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->


<script type="text/javascript">
	function fncheck() {
		alert(1);
		var lpcdrange = document.getElementById('lpcdrange').selectedIndex;
		var lpcdrangevalue = document.getElementById('lpcdrange')[lpcdrange].text;
		alert("lpcdrangevalue" + lpcdrangevalue);
		window.location.replace("rws_habitation_abstract_rpt1_n.jsp?lpcdrange="
				+ lpcdrange);
		alert("lpcdrange" + lpcdrange);

	}
</script>

<%
	String lpcdrange1 = request.getParameter("lpcdrange");
		session.setAttribute("lpcdrange1", lpcdrange1);
		//System.out.println("lpcdrange1 anupama"+lpcdrange1);
%>
</head>
<body bgcolor="#edf2f8" onload="fnValidate();">

	<table border=1 cellspacing=0 cellpadding=0 height=5% width="100%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" align="center">
		<caption>
			<table border=0 rules=none style="border-collapse: collapse"
				align="right">


				<tr>
					<!--<td style="text-align: right;" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td style="text-align: right;" class="bwborder"><a
						href="javascript:history.go(-1)">Back</a>| <a href="../home.jsp">Home</a>|
						<a href="./rws_habitation_abstract_rpt1_excel_n.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<!--  <tr  align="center" >
		
		<td class=rptLabel colspan=20>Select Type:<font color="red">*</font><SELECT name="poptype" id="poptype" style="width:140px" onchange="this.form.submit()" >

			<option value="ALL">ALL</option>
			<option value="SC">SC</option>
			<option value="ST">ST</option>
			<option value="PLAIN">PLAIN</option>

				 </SELECT></td>
				 </tr>
				 <TR align="center">
		<td class=rptLabel colspan=20>LPCD Range:<font color="red">*</font><SELECT name="lpcdrange" id="lpcdrange" style="width:140px" onchange="this.form.submit()" >

				 
				 <option value="55">55</option>
				 <option value="40">40</option>
				 </SELECT></td>
		</tr>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=20>Habitation-Status-Abstract-Report</td>	
		</tr> -->
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

		<%
			try {
		%>
		<tr align="center" bgcolor="#ffffff">
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>Mandal</td>
			<td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>
			<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>
			<td class=gridhdbg rowspan=2>Pop</td>
			<td class=gridhdbg colspan=14 align=center nowrap>Status as on
				01.04.<%=s.toString()%> [(as per level of water supply (LPCD)]
			</td>
		</tr>
		<tr align="center">
			<td class=gridhdbg>FC</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC4</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC3</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC2</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC1</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NSS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NC</td>
			<td class=gridhdbg>Pop</td>
		</tr>
		<%
			//String getDnameQuery = "select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mcode";
					getDnameQuery.delete(0, getDnameQuery.length());
					getDnameQuery
							.append("select mcode,mname,dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and d.dcode = '"
									+ rDistrict.toString()
									+ "' order by m.mcode");
					////System.out.println("query:"+getDnameQuery);
					getHabSt = conn.createStatement(
							ResultSet.TYPE_SCROLL_SENSITIVE,
							ResultSet.CONCUR_UPDATABLE);
					rs2 = getHabSt.executeQuery(getDnameQuery.toString());
					rs2.next();
					dnamee.delete(0, dnamee.length());
					dnamee.append(rs2.getString(3));
					////System.out.println("dnamee:"+dnamee);
		%>
		<tr>
			<td class="btext" colspan="2">District:<%=dnamee.toString()%></td>
			<td class="btext" colspan="1">Type:<%=poptype%></td>
			<td class="btext" colspan="17">LPCDRange:<%=lpcdrange2%></td>
		</tr>
		<%
			rs2.previous();
					int sno = 1;
					double Lpcd = 0.0;
					int rowTotal = 0, columnTotal1 = 0, columnTotal2 = 0, columnTotal3 = 0, columnTotal4 = 0, columnTotal5 = 0, columnTotal6 = 0, columnTotal7 = 0, columnTotal8 = 0, columnTotal9 = 0, columnTotal10 = 0;
					int count1 = 0, count2 = 0, count3 = 0, count4 = 0, count5 = 0, count6 = 0, count7 = 0;
					int pcount = 0, vcount = 0, hcount = 0;
					String calCoverageStatus = "";
					int FCpop = 0, PC4pop = 0, PC3pop = 0, PC2pop = 0, PC1pop = 0, NCpop = 0, NSSpop = 0, totalpop = 0, Gtotalpop = 0;
					int FCpopTotal = 0, PC4popTotal = 0, PC3popTotal = 0, PC2popTotal = 0, PC1popTotal = 0, NCpopTotal = 0, NSSpopTotal = 0;

					while (rs2.next()) {
						pQuery.delete(0, pQuery.length());
						pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rs2.getString(1) + "'");
						
						//System.out.println("@@@  "+pQuery);
						vQuery.delete(0, vQuery.length());
						vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rs2.getString(1) + "'");
						hQuery.delete(0, hQuery.length());
						//Query modified by pranavi
						hQuery.append("select h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0')) as totalpop,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rs2.getString(1) + "'");
						if (poptype.toString() != null
								&& !poptype.toString().equals("")
								&& !poptype.toString().equals("ALL")) {
							if (poptype.toString().equals("SC")) {
								hQuery.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							} else if (poptype.toString().equals("ST")) {
								hQuery.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
							} else {
								hQuery.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							}
						}
						hquery1.delete(0, hquery1.length());
						hquery1.append("select h.panch_code,nvl(ACT_PLAIN_POPU,0)+nvl(ACT_SC_POPU,0)+nvl(ACT_ST_POPU,0),nvl(total_water_supply,0) as totalpop ,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rs2.getString(1) + "'");
						if (poptype.toString() != null
								&& !poptype.toString().equals("")
								&& !poptype.toString().equals("ALL")) {
							if (poptype.toString().equals("SC")) {
								hquery1.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							} else if (poptype.toString().equals("ST")) {
								hquery1.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
							} else {
								hquery1.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							}
						}

						//System.out.println("pQuery:*** "+pQuery);
						//System.out.println("vQuery:*** "+vQuery);
						//System.out.println("hQuery:***  "+hQuery);
						
						//System.out.println("hQuery1:*** "+hquery1);
						pcount = 0;
						vcount = 0;
						hcount = 0;
						count1 = 0;
						count2 = 0;
						count3 = 0;
						count4 = 0;
						count5 = 0;
						count6 = 0;
						count7 = 0;
						FCpop = 0;
						PC4pop = 0;
						PC3pop = 0;
						PC2pop = 0;
						PC1pop = 0;
						NCpop = 0;
						NSSpop = 0;
						totalpop = 0;
						pst = conn.createStatement();
						vst = conn.createStatement();
						hst = conn.createStatement();

						prs = pst.executeQuery(pQuery.toString());
						vrs = vst.executeQuery(vQuery.toString());
						//hrs = hst.executeQuery(hQuery);
						if (lpcdrange.toString().equals("55")) {
							////System.out.println("hQuery"+hQuery);
							hrs = hst.executeQuery(hQuery.toString());
						} else {
							////System.out.println("hQuery1"+hquery1);
							hrs = hst.executeQuery(hquery1.toString());
						}
						while (prs.next())
							pcount++;
						while (vrs.next())
							vcount++;
						stmt1 = conn.createStatement();
						if (lpcdrange.toString().equals("55")) {
							//System.out.println("in 55 lpcd");
							while (hrs.next()) {

								hcount++;
								totalpop = totalpop + hrs.getInt(4);
								int total_pop = hrs.getInt(4);
								////System.out.println("totalpop="+total_pop);
								double water_supply = hrs.getDouble(2);
								double safelpcd = hrs.getDouble(5);
								double unsafelpcd = hrs.getDouble(6);
								////System.out.println("===watersupply"+water_supply);
								double lpcd = (safelpcd + unsafelpcd)
										/ total_pop;

								////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
								if (safelpcd == 0 && unsafelpcd != 0) {

									count6++;
									NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
								} else {
									if (safelpcd == 0) {
										count7++;
										NCpop = NCpop + total_pop;
									} else if (safelpcd >= 55) {
										count1++;
										FCpop = FCpop + total_pop;
									} else if (safelpcd > 0 && safelpcd < 13.75) {
										count2++;
										PC1pop = PC1pop + total_pop;
									} else if (safelpcd >= 13.75
											&& safelpcd < 27.50) {
										count3++;
										PC2pop = PC2pop + total_pop;
									} else if (safelpcd >= 27.50
											&& safelpcd < 41.25) {
										count4++;
										PC3pop = PC3pop + total_pop;
									} else if (safelpcd >= 41.25
											&& safelpcd < 55) {
										count5++;
										PC4pop = PC4pop + total_pop;
									}
								}
							}
						} else {
							//System.out.println("in 40 lpcd");
							while (hrs.next()) {

								hcount++;
								totalpop = totalpop + hrs.getInt(2);
								int total_pop = hrs.getInt(2);
								////System.out.println("totalpop="+total_pop);
								double water_supply = hrs.getDouble(3);
								double safelpcd = hrs.getDouble(4);
								double unsafelpcd = hrs.getDouble(5);
								////System.out.println("===watersupply"+water_supply);
								double lpcd = (safelpcd + unsafelpcd)
										/ total_pop;

								////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
								if (safelpcd == 0 && unsafelpcd != 0) {

									count6++;
									NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
								} else {
									if (safelpcd == 0) {
										count7++;
										NCpop = NCpop + total_pop;
									} else if (safelpcd > 40) {
										count1++;
										FCpop = FCpop + total_pop;
									} else if (safelpcd > 0 && safelpcd <= 10) {
										count2++;
										PC1pop = PC1pop + total_pop;
									} else if (safelpcd > 10 && safelpcd <= 20) {
										count3++;
										PC2pop = PC2pop + total_pop;
									} else if (safelpcd > 20 && safelpcd <= 30) {
										count4++;
										PC3pop = PC3pop + total_pop;
									} else if (safelpcd > 30 && safelpcd <= 40) {
										count5++;
										PC4pop = PC4pop + total_pop;
									}
								}
							}
						}
						style.delete(0, style.length());
						if (styleCount % 2 == 0) {
							style.append("gridbg1");
						} else {
							style.append("gridbg2");
						}
						styleCount++;
		%>
		<tr>
			<td class="<%=style%>"><%=sno++%></td>
			<td class="rptValue" style="text-align: left;"><a
				href="rws_habitation_abstract_rpt1_n.jsp?drill=next1&rDistrict=<%=rDistrict%>&rDistrictName=<%=rDistrictName%>&rMandal=<%=rs2.getString(1)%>&rMandalName=<%=rs2.getString(2)%>&finyear=<%=finYear%>&poptype=<%=poptype%>&lpcdrange=<%=lpcdrange%>"><%=rs2.getString(2)%></a></td>
			<td class="<%=style%>" style="text-align: right;"><%=pcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=vcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
			<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
		</tr>
		<%
			columnTotal1 += pcount;
						columnTotal2 += vcount;
						columnTotal3 += hcount;
						columnTotal4 += count1;
						columnTotal5 += count5;
						columnTotal6 += count4;
						columnTotal7 += count3;
						columnTotal8 += count2;
						columnTotal9 += count6;
						columnTotal10 += count7;
						FCpopTotal += FCpop;
						PC4popTotal += PC4pop;
						Gtotalpop += totalpop;
						PC3popTotal += PC3pop;
						PC2popTotal += PC2pop;
						PC1popTotal += PC1pop;
						NCpopTotal += NCpop;
						NSSpopTotal += NSSpop;

					}
					//style="";styleCount=0;
		%>
		<tr>
			<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal1%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal2%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
			<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
			<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
			<td class=gridhdbg><%=PC4popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
			<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
			<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
		</tr>


		<%
			} catch (Exception e) {
					e.printStackTrace();
				} finally {

					dname = null;
					rDistrictName = null;
					rMandal = null;
					rMandalName = null;
					rPanchayat = null;
					rPanchayatName = null;
					year = null;
					rDistrict = null;
					style = null;
					pQuery = null;
					getDnameQuery = null;
					vQuery = null;
					hQuery = null;
					hquery1 = null;
					dnamee = null;
					year1 = null;

					try {
						if (hrs != null) {
							hrs.close();
						}
						if (hst != null) {
							hst.close();
						}
						if (vrs != null) {
							vrs.close();
						}
						if (vst != null) {
							vst.close();
						}
						if (prs != null) {
							prs.close();
						}
						if (pst != null) {
							pst.close();
						}
						if (rs2 != null) {
							rs2.close();
						}
						if (getHabSt != null) {
							getHabSt.close();
						}
						if (ps1 != null) {
							ps1.close();
						}
						if (rs1 != null) {
							rs1.close();
						}
						if (stmt1 != null) {
							stmt1.close();
						}
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}

				}

			} else if (drill.toString() != null
					&& drill.toString().equals("next1")) {

				//System.out.println("in next1");
		%>
		<html>
<head>

<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->

<script type="text/javascript">
	function fncheck() {
		alert(1);
		var lpcdrange = document.getElementById('lpcdrange').selectedIndex;
		var lpcdrangevalue = document.getElementById('lpcdrange')[lpcdrange].text;
		alert("lpcdrangevalue" + lpcdrangevalue);
		window.location.replace("rws_habitation_abstract_rpt1_n.jsp?lpcdrange="
				+ lpcdrange);
		alert("lpcdrange" + lpcdrange);

	}
</script>
</head>
<body bgcolor="#edf2f8">

	<table border=1 cellspacing=0 cellpadding=0 height=5% width="100%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" align="center">
		<caption>
			<table border=0 rules=none style="border-collapse: collapse"
				align="right">
				<tr>

					<td style="text-align: right;" class="bwborder"><a
						href="javascript:history.go(-1)">Back</a>| <a href="../home.jsp">Home</a>|
						<a href="./rws_habitation_abstract_rpt1_excel_n.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<!-- <tr bgcolor="#8A9FCD" align="center">
		<td class=rptLabel colspan=20>LPCD Range:<font color="red">*</font><SELECT name="lpcdrange" id="lpcdrange" style="width:140px" onchange="return fncheck()" >

				 
				 <option value="55">55</option>
				 <option value="40">40</option>
				 </SELECT></td>
		</tr> -->
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=19>Habitation-Status-Abstract-Report</td>
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->
		<%
			String lpcdrange1 = request.getParameter("lpcdrange");
				//System.out.println("lpcdrange1"+lpcdrange1);
				String rMandal1 = request.getParameter("rMandal");
				//System.out.println("rMandal"+rMandal1);
		%>

		<%
			try {

					Calendar cal1 = Calendar.getInstance();
					year1.delete(0, year1.length());
					year1.append("" + cal1.get(Calendar.YEAR));
		%>
		<tr align="center" bgcolor="#ffffff">
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>Panchayat</td>
			<!-- <td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>-->
			<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>
			<td class=gridhdbg rowspan=2>Pop</td>
			<td class=gridhdbg colspan=14 align=center nowrap>Status as on
				01.04.<%=year1%> [(as per level of water supply (LPCD)]
			</td>
		</tr>
		<tr align="center">
			<td class=gridhdbg>FC</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC4</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC3</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC2</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC1</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NSS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NC</td>
			<td class=gridhdbg>Pop</td>
		</tr>
		<%
			//String getDnameQuery = "select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mcode";
					//String getDnameQuery = "select mcode,mname,dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and d.dcode = '"+rDistrict+"' order by m.mcode";
					getDnameQuery.delete(0, getDnameQuery.length());
					getDnameQuery
							.append("select p.pcode,p.pname,dname from rws_panchayat_tbl p,rws_district_tbl d where d.dcode = p.dcode and p.dcode = '"
									+ rDistrict
									+ "' and p.mcode='"
									+ rMandal
									+ "' order by p.pcode");

					//System.out.println("query:"+getDnameQuery);
					getHabSt = conn.createStatement(
							ResultSet.TYPE_SCROLL_SENSITIVE,
							ResultSet.CONCUR_UPDATABLE);
					rs2 = getHabSt.executeQuery(getDnameQuery.toString());
					rs2.next();

					dnamee.delete(0, dnamee.length());

					dnamee.append(rs2.getString(3));
		%>
		<tr>
			<td class="btext" colspan="19">District:<%=dnamee%>&nbsp;&nbsp;&nbsp;Mandal:<%=rMandalName%></td>
		</tr>
		<%
			rs2.previous();
					int sno = 1;
					double Lpcd = 0.0;
					int rowTotal = 0, columnTotal1 = 0, columnTotal2 = 0, columnTotal3 = 0, columnTotal4 = 0, columnTotal5 = 0, columnTotal6 = 0, columnTotal7 = 0, columnTotal8 = 0, columnTotal9 = 0, columnTotal10 = 0;
					int count1 = 0, count2 = 0, count3 = 0, count4 = 0, count5 = 0, count6 = 0, count7 = 0;
					int pcount = 0, vcount = 0, hcount = 0;
					String calCoverageStatus = "";
					int FCpop = 0, PC4pop = 0, PC3pop = 0, PC2pop = 0, PC1pop = 0, NCpop = 0, NSSpop = 0, totalpop = 0, Gtotalpop = 0;
					int FCpopTotal = 0, PC4popTotal = 0, PC3popTotal = 0, PC2popTotal = 0, PC1popTotal = 0, NCpopTotal = 0, NSSpopTotal = 0;

					while (rs2.next()) {
						pQuery.delete(0, pQuery.length());
						pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rMandal
								+ "' and p.pcode='" + rs2.getString(1) + "'");
						vQuery.delete(0, vQuery.length());
						vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rMandal
								+ "' and p.pcode='" + rs2.getString(1) + "'");
						hQuery.delete(0, hQuery.length());
						//Query modified by pranavi
						hQuery.append("select h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0')) as totalpop, nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rMandal
								+ "' and p.pcode='" + rs2.getString(1) + "'");
						if (poptype.toString() != null
								&& !poptype.toString().equals("")
								&& !poptype.toString().equals("ALL")) {
							if (poptype.toString().equals("SC")) {
								hQuery.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							} else if (poptype.toString().equals("ST")) {
								hQuery.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
							} else {
								hQuery.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							}
						}

						hquery1.delete(0, hquery1.length());
						hquery1.append("select h.panch_code,nvl(ACT_PLAIN_POPU,0)+nvl(ACT_SC_POPU,0)+nvl(ACT_ST_POPU,0),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0),nvl(total_water_supply,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rMandal
								+ "' and p.pcode='" + rs2.getString(1) + "'");
						if (poptype.toString() != null
								&& !poptype.toString().equals("")
								&& !poptype.toString().equals("ALL")) {
							if (poptype.toString().equals("SC")) {
								hquery1.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							} else if (poptype.toString().equals("ST")) {
								hquery1.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
							} else {
								hquery1.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							}
						}
						//System.out.println("hquery1 next2"+hquery1);
						//System.out.println("hQuery next2" +hQuery);
						///System.out.println("pQuery next2"+pQuery);
						//System.out.println("vQuery next2"+vQuery);

						//System.out.println("hQuery:"+hquery1);
						pcount = 0;
						vcount = 0;
						hcount = 0;
						count1 = 0;
						count2 = 0;
						count3 = 0;
						count4 = 0;
						count5 = 0;
						count6 = 0;
						count7 = 0;
						FCpop = 0;
						PC4pop = 0;
						PC3pop = 0;
						PC2pop = 0;
						PC1pop = 0;
						NCpop = 0;
						NSSpop = 0;
						totalpop = 0;
						pst = conn.createStatement();
						vst = conn.createStatement();
						hst = conn.createStatement();

						prs = pst.executeQuery(pQuery.toString());
						vrs = vst.executeQuery(vQuery.toString());
						//hrs = hst.executeQuery(hQuery);
						if (lpcdrange.toString().equals("55")) {
							////System.out.println("hQuery"+hQuery);
							hrs = hst.executeQuery(hQuery.toString());
						} else {
							////System.out.println("hQuery1"+hquery1);
							hrs = hst.executeQuery(hquery1.toString());
						}
						while (prs.next())
							pcount++;
						while (vrs.next())
							vcount++;
						stmt1 = conn.createStatement();
						if (lpcdrange.toString().equals("55")) {
							//	//System.out.println("in 55 lpcd");
							while (hrs.next()) {

								hcount++;
								totalpop = totalpop + hrs.getInt(4);
								int total_pop = hrs.getInt(4);
								////System.out.println("totalpop="+total_pop);
								double water_supply = hrs.getDouble(2);
								double safelpcd = hrs.getDouble(5);
								double unsafelpcd = hrs.getDouble(6);
								////System.out.println("===watersupply"+water_supply);
								double lpcd = (safelpcd + unsafelpcd)
										/ total_pop;

								////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
								if (safelpcd == 0 && unsafelpcd != 0) {

									count6++;
									NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
								} else {
									if (safelpcd == 0) {
										count7++;
										NCpop = NCpop + total_pop;
									} else if (safelpcd >= 55) {
										count1++;
										FCpop = FCpop + total_pop;
									} else if (safelpcd > 0 && safelpcd < 13.75) {
										count2++;
										PC1pop = PC1pop + total_pop;
									} else if (safelpcd >= 13.75
											&& safelpcd < 27.50) {
										count3++;
										PC2pop = PC2pop + total_pop;
									} else if (safelpcd >= 27.50
											&& safelpcd < 41.25) {
										count4++;
										PC3pop = PC3pop + total_pop;
									} else if (safelpcd >= 41.25
											&& safelpcd < 55) {
										count5++;
										PC4pop = PC4pop + total_pop;
									}
								}
							}
						} else {
							//System.out.println("in 40 lpcd");
							while (hrs.next()) {

								hcount++;
								totalpop = totalpop + hrs.getInt(2);
								int total_pop = hrs.getInt(2);
								////System.out.println("totalpop="+total_pop);
								double water_supply = hrs.getDouble(5);
								double safelpcd = hrs.getDouble(3);
								double unsafelpcd = hrs.getDouble(4);
								////System.out.println("===watersupply"+water_supply);
								double lpcd = (safelpcd + unsafelpcd)
										/ total_pop;

								////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
								if (safelpcd == 0 && unsafelpcd != 0) {

									count6++;
									NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
								} else {
									if (safelpcd == 0) {
										count7++;
										NCpop = NCpop + total_pop;
									} else if (safelpcd > 40) {
										count1++;
										FCpop = FCpop + total_pop;
									} else if (safelpcd > 0 && safelpcd <= 10) {
										count2++;
										PC1pop = PC1pop + total_pop;
									} else if (safelpcd > 10 && safelpcd <= 20) {
										count3++;
										PC2pop = PC2pop + total_pop;
									} else if (safelpcd > 20 && safelpcd <= 30) {
										count4++;
										PC3pop = PC3pop + total_pop;
									} else if (safelpcd > 30 && safelpcd <= 40) {
										count5++;
										PC4pop = PC4pop + total_pop;
									}
								}
							}
						}
						style.delete(0, style.length());
						if (styleCount % 2 == 0) {
							style.append("gridbg1");
						} else {
							style.append("gridbg2");
						}
						styleCount++;
		%>
		<tr>
			<td class="<%=style%>"><%=sno++%></td>
			<td class="rptValue" style="text-align: left;"><a
				href="rws_habitation_abstract_rpt1_n.jsp?drill=next2&rDistrict=<%=rDistrict%>&rDistrictName=<%=rDistrictName%>&rMandal=<%=rMandal%>&rMandalName=<%=rMandalName%>&rPanchayat=<%=rs2.getString(1)%>&rPanchayatName=<%=rs2.getString(2)%>&finyear=<%=finYear%>&poptype=<%=poptype%>&lpcdrange=<%=lpcdrange%>"><%=rs2.getString(2)%></a></td>
			<!-- <td class="<%=style%>"><%=pcount%></td>-->
			<td class="<%=style%>" style="text-align: right;"><%=vcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
			<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
		</tr>
		<%
			columnTotal1 += pcount;
						columnTotal2 += vcount;
						columnTotal3 += hcount;
						columnTotal4 += count1;
						columnTotal5 += count5;
						columnTotal6 += count4;
						columnTotal7 += count3;
						columnTotal8 += count2;
						columnTotal9 += count6;
						columnTotal10 += count7;
						FCpopTotal += FCpop;
						PC4popTotal += PC4pop;
						Gtotalpop += totalpop;
						PC3popTotal += PC3pop;
						PC2popTotal += PC2pop;
						PC1popTotal += PC1pop;
						NCpopTotal += NCpop;
						NSSpopTotal += NSSpop;

					}
					//style="";styleCount=0;
		%>
		<tr>
			<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
			<!-- <td class=gridhdbg><%=columnTotal1%></td>-->
			<td class=gridhdbg style="text-align: right;"><%=columnTotal2%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
			<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
			<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC4popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
			<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
			<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
		</tr>


		<%
			} catch (Exception e) {
					e.printStackTrace();
				} finally {

					dname = null;
					rDistrictName = null;
					rMandal = null;
					rMandalName = null;
					rPanchayat = null;
					rPanchayatName = null;
					year = null;
					rDistrict = null;
					style = null;
					pQuery = null;
					getDnameQuery = null;
					vQuery = null;
					hQuery = null;
					hquery1 = null;
					dnamee = null;
					year1 = null;

					try {
						if (hrs != null) {
							hrs.close();
						}
						if (hst != null) {
							hst.close();
						}
						if (vrs != null) {
							vrs.close();
						}
						if (vst != null) {
							vst.close();
						}
						if (prs != null) {
							prs.close();
						}
						if (pst != null) {
							pst.close();
						}
						if (rs2 != null) {
							rs2.close();
						}
						if (getHabSt != null) {
							getHabSt.close();
						}
						if (ps1 != null) {
							ps1.close();
						}
						if (rs1 != null) {
							rs1.close();
						}
						if (stmt1 != null) {
							stmt1.close();
						}
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

			} else if (drill.toString() != null
					&& drill.toString().equals("next2")) {

				////System.out.println("in next2");
		%>
		<html>
<head>
<script type="text/javascript">
	function fncheck() {
		alert(1);
		var lpcdrange = document.getElementById('lpcdrange').selectedIndex;
		var lpcdrangevalue = document.getElementById('lpcdrange')[lpcdrange].text;
		alert("lpcdrangevalue" + lpcdrangevalue);
		window.location.replace("rws_habitation_abstract_rpt1_n.jsp?lpcdrange="
				+ lpcdrange);
		alert("lpcdrange" + lpcdrange);

	}
</script>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
</head>
<body bgcolor="#edf2f8">

	<table border=1 cellspacing=0 cellpadding=0 height=5% width="100%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" align="center">
		<caption>
			<table border=0 rules=none style="border-collapse: collapse"
				align="right">
				<tr>

					<td style="text-align: right;" class="bwborder"><a
						href="javascript:history.go(-1)">Back</a>| <a href="../home.jsp">Home</a>|
						<a href="./rws_habitation_abstract_rpt1_excel_n.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<!-- <tr bgcolor="#8A9FCD" align="center">
		<td class=rptLabel colspan=20>LPCD Range:<font color="red">*</font><SELECT name="lpcdrange" id="lpcdrange" style="width:140px" onchange="return fncheck()" >

				 
				 <option value="55">55</option>
				 <option value="40">40</option>
				 </SELECT></td>
		</tr>
		 -->
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=18>Habitation-Status-Abstract-Report</td>
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->
		<%
			String lpcdrange1 = request.getParameter("lpcdrange");
				//System.out.println("lpcdrange1"+lpcdrange1);
		%>

		<%
			try {
		%>
		<tr align="center" bgcolor="#ffffff">
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>Village</td>
			<!--<td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>
			<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>-->
			<td class=gridhdbg rowspan=2>No. of Habs</td>
			<td class=gridhdbg rowspan=2>Pop</td>
			<td class=gridhdbg colspan=14 align=center nowrap>Status as on
				01.04.09 [(as per level of water supply (LPCD)]</td>
		</tr>
		<tr align="center">
			<td class=gridhdbg>FC</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC4</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC3</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC2</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC1</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NSS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NC</td>
			<td class=gridhdbg>Pop</td>
		</tr>
		<%
			//String getDnameQuery = "select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mcode";
					//String getDnameQuery = "select mcode,mname,dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and d.dcode = '"+rDistrict+"' order by m.mcode";

					//String getDnameQuery = "select p.pcode,p.pname,dname from rws_panchayat_tbl p,rws_district_tbl d where d.dcode = p.dcode and p.dcode = '"+rDistrict+"' and p.mcode='"+rMandal+"' order by p.pcode";

					getDnameQuery.delete(0, getDnameQuery.length());

					//getDnameQuery.append("select v.vcode,v.vname,dname,panch_code from rws_village_tbl v,rws_district_tbl d where d.dcode = v.dcode and v.dcode = '"+rDistrict+"' and v.mcode='"+rMandal+"'  and v.pcode='"+rPanchayat+"' order by v.vcode");
					getDnameQuery
							.append("select v.vcode,v.vname,d.dname,panch_code from rws_village_tbl v,rws_district_tbl d,rws_complete_hab_view c where d.dcode = v.dcode and c.dcode=d.dcode and c.dcode=v.dcode and c.mcode=v.mcode and c.pcode=v.pcode and v.dcode = '"
									+ rDistrict
									+ "' and v.mcode='"
									+ rMandal
									+ "'  and v.pcode='"
									+ rPanchayat
									+ "' order by v.vcode");

					////System.out.println("getDnameQuery:"+getDnameQuery);
					getHabSt = conn.createStatement(
							ResultSet.TYPE_SCROLL_SENSITIVE,
							ResultSet.CONCUR_UPDATABLE);
					rs2 = getHabSt.executeQuery(getDnameQuery.toString());
					rs2.next();
					dnamee.delete(0, dnamee.length());
					dnamee.append(rs2.getString(3));
		%>
		<tr>
			<td class="btext" colspan="18">District:<%=dnamee.toString()%>&nbsp;&nbsp;&nbsp;Mandal:<%=rMandalName.toString()%>&nbsp;&nbsp;&nbsp;Panchayat:<%=rPanchayatName.toString()%></td>
		</tr>
		<%
			rs2.previous();
					int sno = 1;
					double Lpcd = 0.0;
					int rowTotal = 0, columnTotal1 = 0, columnTotal2 = 0, columnTotal3 = 0, columnTotal4 = 0, columnTotal5 = 0, columnTotal6 = 0, columnTotal7 = 0, columnTotal8 = 0, columnTotal9 = 0, columnTotal10 = 0;
					int count1 = 0, count2 = 0, count3 = 0, count4 = 0, count5 = 0, count6 = 0, count7 = 0;
					int pcount = 0, vcount = 0, hcount = 0;
					String calCoverageStatus = "";
					int FCpop = 0, PC4pop = 0, PC3pop = 0, PC2pop = 0, PC1pop = 0, NCpop = 0, NSSpop = 0, totalpop = 0, Gtotalpop = 0;
					int FCpopTotal = 0, PC4popTotal = 0, PC3popTotal = 0, PC2popTotal = 0, PC1popTotal = 0, NCpopTotal = 0, NSSpopTotal = 0;
					String hab = null;
					while (rs2.next()) {

						pQuery.delete(0, pQuery.length());
						pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rMandal
								+ "' and p.pcode='"
								+ rPanchayat
								+ "' and v.vcode='" + rs2.getString(1) + "'");
						vQuery.delete(0, vQuery.length());
						vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rMandal
								+ "' and p.pcode='"
								+ rPanchayat
								+ "' and v.vcode='" + rs2.getString(1) + "'");
						hQuery.delete(0, hQuery.length());
						//Query modified by pranavi
						hQuery.append("select h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0')) as totalpop,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rMandal
								+ "' and p.pcode='"
								+ rPanchayat
								+ "' and v.vcode='"
								+ rs2.getString(1)
								+ "' and h.panch_code='"
								+ rs2.getString(4)
								+ "'");

						if (poptype.toString() != null
								&& !poptype.toString().equals("")
								&& !poptype.toString().equals("ALL")) {
							if (poptype.toString().equals("SC")) {
								hQuery.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							} else if (poptype.toString().equals("ST")) {
								hQuery.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
							} else {
								hQuery.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							}
						}
						hquery1.delete(0, hquery1.length());
						hquery1.append("select h.panch_code,nvl(ACT_PLAIN_POPU,0)+nvl(ACT_SC_POPU,0)+nvl(ACT_ST_POPU,0),nvl(total_water_supply,0),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"
								+ habTableName
								+ " hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"
								+ rDistrict
								+ "'  and m.mcode='"
								+ rMandal
								+ "' and p.pcode='"
								+ rPanchayat
								+ "' and v.vcode='"
								+ rs2.getString(1)
								+ "' and h.panch_code='"
								+ rs2.getString(4)
								+ "'");

						if (poptype.toString() != null
								&& !poptype.toString().equals("")
								&& !poptype.toString().equals("ALL")) {
							if (poptype.toString().equals("SC")) {
								hquery1.append(" and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							} else if (poptype.toString().equals("ST")) {
								hquery1.append("  and  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ");
							} else {
								hquery1.append(" AND  (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ");
							}
						}

						////System.out.println("hQuery:"+hQuery);
						pcount = 0;
						vcount = 0;
						hcount = 0;
						count1 = 0;
						count2 = 0;
						count3 = 0;
						count4 = 0;
						count5 = 0;
						count6 = 0;
						count7 = 0;
						FCpop = 0;
						PC4pop = 0;
						PC3pop = 0;
						PC2pop = 0;
						PC1pop = 0;
						NCpop = 0;
						NSSpop = 0;
						totalpop = 0;
						pst = conn.createStatement();
						vst = conn.createStatement();
						hst = conn.createStatement();

						prs = pst.executeQuery(pQuery.toString());
						vrs = vst.executeQuery(vQuery.toString());
						//hrs = hst.executeQuery(hQuery);
						if (lpcdrange.toString().equals("55")) {
							////System.out.println("hQuery"+hQuery);
							hrs = hst.executeQuery(hQuery.toString());
						} else {
							////System.out.println("hQuery1"+hquery1);
							hrs = hst.executeQuery(hquery1.toString());
						}
						while (prs.next())
							pcount++;
						while (vrs.next())
							vcount++;
						stmt1 = conn.createStatement();
						if (lpcdrange.toString().equals("55")) {
							//System.out.println("in 55 lpcd");
							while (hrs.next()) {

								hcount++;
								totalpop = totalpop + hrs.getInt(4);
								int total_pop = hrs.getInt(4);
								////System.out.println("totalpop="+total_pop);
								double water_supply = hrs.getDouble(2);
								double safelpcd = hrs.getDouble(5);
								double unsafelpcd = hrs.getDouble(6);
								////System.out.println("===watersupply"+water_supply);
								double lpcd = (safelpcd + unsafelpcd)
										/ total_pop;

								////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
								if (safelpcd == 0 && unsafelpcd != 0) {

									count6++;
									NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
								} else {
									if (safelpcd == 0) {
										count7++;
										NCpop = NCpop + total_pop;
									} else if (safelpcd >= 55) {
										count1++;
										FCpop = FCpop + total_pop;
									} else if (safelpcd > 0 && safelpcd < 13.75) {
										count2++;
										PC1pop = PC1pop + total_pop;
									} else if (safelpcd >= 13.75
											&& safelpcd < 27.50) {
										count3++;
										PC2pop = PC2pop + total_pop;
									} else if (safelpcd >= 27.50
											&& safelpcd < 41.25) {
										count4++;
										PC3pop = PC3pop + total_pop;
									} else if (safelpcd >= 41.25
											&& safelpcd < 55) {
										count5++;
										PC4pop = PC4pop + total_pop;
									}
								}
							}
						} else {
							//System.out.println("in 40 lpcd");
							while (hrs.next()) {

								hcount++;
								totalpop = totalpop + hrs.getInt(2);
								int total_pop = hrs.getInt(2);
								////System.out.println("totalpop="+total_pop);
								double water_supply = hrs.getDouble(3);
								double safelpcd = hrs.getDouble(4);
								double unsafelpcd = hrs.getDouble(5);
								////System.out.println("===watersupply"+water_supply);
								double lpcd = (safelpcd + unsafelpcd)
										/ total_pop;

								////System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
								if (safelpcd == 0 && unsafelpcd != 0) {

									count6++;
									NSSpop = NSSpop + total_pop;////System.out.print(hrs.getString(1)+",");
								} else {
									if (safelpcd == 0) {
										count7++;
										NCpop = NCpop + total_pop;
									} else if (safelpcd > 40) {
										count1++;
										FCpop = FCpop + total_pop;
									} else if (safelpcd > 0 && safelpcd <= 10) {
										count2++;
										PC1pop = PC1pop + total_pop;
									} else if (safelpcd > 10 && safelpcd <= 20) {
										count3++;
										PC2pop = PC2pop + total_pop;
									} else if (safelpcd > 20 && safelpcd <= 30) {
										count4++;
										PC3pop = PC3pop + total_pop;
									} else if (safelpcd > 30 && safelpcd <= 40) {
										count5++;
										PC4pop = PC4pop + total_pop;
									}
								}
							}
						}
						style.delete(0, style.length());
						if (styleCount % 2 == 0) {
							style.append("gridbg1");
						} else {
							style.append("gridbg2");
						}
						styleCount++;
		%>
		<tr>
			<td class="<%=style%>"><%=sno++%></td>
			<td class="<%=style%>" style="text-align: left;"><%=rs2.getString(2)%></td>
			<!--<td class="<%=style%>"><%=pcount%></td>
				<td class="<%=style%>"><%=vcount%></td>-->
			<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
			<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
		</tr>
		<%
			columnTotal1 += pcount;
						columnTotal2 += vcount;
						columnTotal3 += hcount;
						columnTotal4 += count1;
						columnTotal5 += count5;
						columnTotal6 += count4;
						columnTotal7 += count3;
						columnTotal8 += count2;
						columnTotal9 += count6;
						columnTotal10 += count7;
						FCpopTotal += FCpop;
						PC4popTotal += PC4pop;
						Gtotalpop += totalpop;
						PC3popTotal += PC3pop;
						PC2popTotal += PC2pop;
						PC1popTotal += PC1pop;
						NCpopTotal += NCpop;
						NSSpopTotal += NSSpop;
					}
					//style="";styleCount=0;
		%>
		<tr>
			<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
			<!--<td class=gridhdbg><%=columnTotal1%></td>
				<td class=gridhdbg><%=columnTotal2%></td>-->
			<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
			<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
			<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC4popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
			<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
			<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
		</tr>


		<%
			} catch (Exception e) {
					e.printStackTrace();
				} finally {
					////System.out.println("Memory recollecting");

					dname = null;
					rDistrictName = null;
					rMandal = null;
					rMandalName = null;
					rPanchayat = null;
					rPanchayatName = null;
					year = null;
					rDistrict = null;
					style = null;
					pQuery = null;
					getDnameQuery = null;
					vQuery = null;
					hQuery = null;
					hquery1 = null;
					dnamee = null;
					year1 = null;

					try {
						if (hrs != null) {
							hrs.close();
						}
						if (hst != null) {
							hst.close();
						}
						if (vrs != null) {
							vrs.close();
						}
						if (vst != null) {
							vst.close();
						}
						if (prs != null) {
							prs.close();
						}
						if (pst != null) {
							pst.close();
						}
						if (rs2 != null) {
							rs2.close();
						}
						if (getHabSt != null) {
							getHabSt.close();
						}
						if (ps1 != null) {
							ps1.close();
						}
						if (rs1 != null) {
							rs1.close();
						}
						if (stmt1 != null) {
							stmt1.close();
						}
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}

				}

			}
		%>
			
	</table>
	<table align="center">
	<tr>
					<td>
					<font color="green" size="2">Note:</font>					
					
					<font color="red" size="1"> This report generated using static habitation directory </font>
					</td>
			</tr>
	
	</table>
	
	
	</form>
</body>
		</html>
		<%@ include file="footer.jsp"%>


