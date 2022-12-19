<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>



<%
    int count=2;
	DecimalFormat ndf = new DecimalFormat("####.00");
	HashMap habSancMap = new HashMap();
	HashMap habCovMap = new HashMap();
	HashMap workSancMap = new HashMap();
	HashMap workCovMap = new HashMap();
	HashMap costEstMap = new HashMap();
	HashMap costExpMap = new HashMap();
	HashMap distMap = new HashMap();
	String rDistrict = "";
	String finyear = "";
	String InputTarAchStr="";
	String names="";
	//String programe = "";
	String mode = "";

	if (request.getParameter("mode") != null)
		mode = request.getParameter("mode");
	
	String programme = request.getParameter("programme");
	String programmeName=request.getParameter("programmeName");
	if (request.getParameter("finyear") != null)
		finyear = request.getParameter("finyear");
	else {
		Statement stmtt = conn.createStatement(
				ResultSet.TYPE_SCROLL_SENSITIVE,
				ResultSet.CONCUR_UPDATABLE);
		ResultSet rss = stmtt
				.executeQuery("select distinct to_char(max(status_date),'dd-MON-yyyy') from rws_habitation_directory_tbl");
		while (rss.next()) {
			finyear = rss.getString(1);
		}
		int yr = Integer
				.parseInt(finyear.substring(7, finyear.length()));
		finyear = yr + "-" + (yr + 1);
	}

	session.setAttribute("finyear", finyear);

	/* if (request.getParameter("program") != null)
		programe = request.getParameter("program");
	else
		programe = "all"; */

	/* HashMap programmeList = new HashMap();
	/* if (programe.equals("all")) { */
	/* String progCode = "";
	String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
	Statement statement = conn.createStatement();
	ResultSet resultSet = statement.executeQuery(nrdwpQuery);
	while (resultSet.next()) {
		if (!progCode.equals("")) {
			progCode = progCode + "," + resultSet.getString(1);
		} else {
			progCode = resultSet.getString(1);
		}
	}
	resultSet.close();
	statement.close();

	programmeList.put(1, progCode);
	String CmDBQuery = "select PROGRAMME_CODE from  rws_programme_tbl where CM_CORE_DB='Y' and NRDWP_RELATED='N' order by PROGRAMME_NAME";
    Statement stmtCmDB = conn.createStatement();
    ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
    while (rsCmDB.next()) {
    	programmeList.put(count,rsCmDB.getString(1));
    	count++;
    } */ 
   	/* programe = progCode + ",04,65,57";
	
	}
	
	session.setAttribute("programe", programe);
	 */
	String startyr = finyear.substring(0, 4);

	String endyr = finyear.substring(5, 9);

	
	WorksData1 data1 = new WorksData1();
	int cyear = Calendar.getInstance().get(Calendar.YEAR);
	int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	int lMonth = Calendar.getInstance().get(Calendar.MONTH);
	int day = Calendar.getInstance().get(Calendar.DATE);
	String currentMonth = data1.getCurrentMonth(month);
	String lastMonth = "";
	if (currentMonth.equals("JAN")) {
		lastMonth = "DEC-" + (cyear - 1);
	} else {
		lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
	}
	String cDate = day + "-" + currentMonth + "-" + cyear;
	int yearStart = 0;
	int yearEnd = 0;
	if (month <= 3) {
		yearStart = cyear - 1;
		yearEnd = cyear;
	} else {
		yearStart = cyear;
		yearEnd = cyear + 1;
	}
	lastMonth = lastMonth.substring(0, 1).toUpperCase()
			+ lastMonth.substring(1).toLowerCase();
	currentMonth = currentMonth.substring(0, 1).toUpperCase()
			+ currentMonth.substring(1).toLowerCase();
	String ye=""+yearEnd;
    ye=ye.substring(2,4).toString();
    
    int yEnd=Integer.parseInt(ye);
%>
<script language="JavaScript">
	function viewWorks(URL) {

		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}

	function wopen(url, name, w, h) {
		w += 32;
		h += 96;
		var win = window.open(url, name, 'width=' + w + ', height=' + h + ', '
				+ 'location=yes, menubar=no, '
				+ 'status=yes, toolbar=no, scrollbars=yes, resizable=yes');

		win.focus();
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
	border: 1px solid #777777;
}

.rightPad td {
	padding-right: 3px !important;
}
</style>
<BODY>

		<br />
		<br />
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Works Progress - Target Vs Achievement <br/><br/> Programme: <%=programmeName %>
			<%if(mode.equals("divisions")){ %>
			 , Circle: <%=request.getParameter("cname") %>
			<%}else if(mode.equals("subdivisions")){  %>
			, Circle: <%=request.getParameter("cname") %>
			 , Division: <%=request.getParameter("divname") %>
			<%} %>
			</b></font> <br />
			
		</center>

		<br />
		<%
			if (mode.equals("circles") || mode.equals("divisions") || mode.equals("subdivisions")) {
		%>
		<table align="center"
			style="margin-top: -35px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: left !important;"><font
					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>
				<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img
						src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			} else {
		%>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: left !important;"><font
					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>
				<td style="width: 50px !important; text-align: right !important">
					<a
					href="/pred/resources/graphs/workGraphView.jsp?dcode=00&mode=Pie"
					target="_blank" style="color: green !important; font-size: 13px;"
					id="showGraph"><img width="30px"
						src="/pred/resources/graphs/pie.png"></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			}
		%>
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px"
			bordercolor=#000000
			style="border-collapse: collapse; margin-top: 20px !important;"
			bgcolor="#ffffff" align="center">

			<tr align=center align=center>
				<td class=btext rowspan=2 style="width: 30px !important;">SNO</td>
				<%if(mode.equals("circles")){ %>
				<td class=btext rowspan=2>Circle</td>
				<%}else if(mode.equals("divisions")){ %>
				<td class=btext rowspan=2>Division</td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class=btext rowspan=2>Sub Division</td>
				<%} %>
				<td class=btext rowspan=2>Works</td>
				<td class=btext rowspan=2>Est.cost</td>
				<td class=btext rowspan=2>Habs Sanctioned</td>
				<td class=btext rowspan=2>Pop. Benf</td>
				<td class=btext colspan="5">Target <%=yearStart %>-<%=yEnd %>(Habs)</td>
				<td class=btext colspan="5">Achievement<br/> <%=yearStart %>-<%=yEnd %>(Habs)</td>
				<td class=btext colspan="5">Percentage Completion <br/><%=yearStart %>-<%=yEnd %></td>
				<td class=btext colspan="5">Achievement during the previous year</td>
				<!-- <td class=btext colspan="5">Comparsion with Last Financial Year</td> -->
			</tr>
			<tr align=center align=center>
				<td class=btext >Q1</td>
				<td class=btext >Q2</td>
				<td class=btext >Q3</td>
				<td class=btext >Q4</td>
				<td class=btext >Total</td>
				<td class=btext >Q1</td>
				<td class=btext >Q2</td>
				<td class=btext >Q3</td>
				<td class=btext >Q4</td>
				<td class=btext >Total</td>
				<td class=btext >Q1</td>
				<td class=btext >Q2</td>
				<td class=btext >Q3</td>
				<td class=btext >Q4</td>
				<td class=btext >Total</td>
				<td class=btext >Q1</td>
				<td class=btext >Q2</td>
				<td class=btext >Q3</td>
				<td class=btext >Q4</td>
				<td class=btext >Total</td>
				<!-- <td class=btext >Q1</td>
				<td class=btext >Q2</td>
				<td class=btext >Q3</td>
				<td class=btext >Q4</td>
				<td class=btext >Total</td> -->
			</tr>

			<%
				int styleCount = 0;
				String style = "";
			%>
			<%
				Connection connection = null;
				Statement stmt1 = null;
				ResultSet rs1 = null;
				int slno = 0;
				int tothabsSacQ1=0,tothabsCovQ1=0,totprehabsCovQ1=0;
				int tothabsSacQ2 = 0, tothabsCovQ2 = 0, totprehabsCovQ2 = 0;
				int tothabsSacQ3 = 0, tothabsCovQ3 = 0, totprehabsCovQ3 = 0;
				int tothabsSacQ4 = 0, tothabsCovQ4 = 0, totprehabsCovQ4 = 0;
				int tothabsSacTot = 0, tothabsCovTot = 0, totprehabsCovTot = 0;
				String ccode="",cname="",divCode="",divName="",subdivCode="",subdivName="";
				double totExpDuringFY=0,totExpPreviousFY=0,totEstCost = 0;
				int totworks = 0, tothabsSac = 0, totpopBen=0;
				int totcompQ1 = 0, totcompQ2 = 0, totcompQ3=0, totcompQ4=0, totcompTot=0;
				double totpercentageQ1 = 0,totpercentageQ2 = 0,totpercentageQ3 = 0,totpercentageQ4 = 0,totpercentageTot = 0;
				try {
					String schemes = "'01','02','03','10'";
					/* String districtQuery="select circle_office_code,INITCAP(circle_office_name) as circle_office_name from rws_circle_office_tbl order by circle_office_code";
					Statement statement1 = conn.createStatement();
					ResultSet resultSet1 = statement1.executeQuery(districtQuery);
					
					while (resultSet1.next()) {
						ccode=resultSet1.getString("circle_office_code");
						cname=resultSet1.getString("circle_office_name"); */
						int works = 0, habsSac = 0, popBen=0;
						int habsSacQ1 = 0, habsCovQ1 = 0, prehabsCovQ1 = 0;
						int habsSacQ2 = 0, habsCovQ2 = 0, prehabsCovQ2 = 0;
						int habsSacQ3 = 0, habsCovQ3 = 0, prehabsCovQ3 = 0;
						int habsSacQ4 = 0, habsCovQ4 = 0, prehabsCovQ4 = 0;
						int habsSacTot = 0, habsCovTot = 0, prehabsCovTot = 0;
						double totExpBankDur=0,totExpPaoDur=0,totExpBankPre=0,totExpPaoPre=0, EstCost = 0;
						if(mode.equals("divisions")){
					        ccode = request.getParameter("ccode");
					        cname = request.getParameter("cname");
				        }
				          if(mode.equals("subdivisions")){
					        ccode = request.getParameter("ccode");
					        cname = request.getParameter("cname");
					        divCode = request.getParameter("divcode");
				        }String c_query="";
				          if(mode.equals("circles")){
					 			c_query="select circle_office_code,circle_office_name from rws_circle_office_tbl  order by circle_office_code";
				            }
				            else if(mode.equals("divisions")){
				            	c_query="select division_office_code,division_office_name from rws_division_office_tbl where  circle_office_code='"+ccode+"' and status <> 'UI' order by division_office_code";
				            }
				            else if(mode.equals("subdivisions")){
				            	 c_query="select subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where  circle_office_code='"+ccode+"' and division_office_code='"+divCode+"' order by subdivision_office_code";
				            }
				         //System.out.println("query"+c_query);
				          PreparedStatement preparedStatement = conn.prepareStatement(c_query);
				          ResultSet res = preparedStatement.executeQuery();
				          while(res.next()){

								if (styleCount % 2 == 0) {
									style = "gridbg1";
								} else {
									style = "gridbg2";
								}
								styleCount++; 			
				         
				        	  if(mode.equals("circles")){
				        		  names+=res.getString("circle_office_name")+",";
				        	      cname=res.getString("circle_office_name");
				              	  ccode=res.getString("circle_office_code");
				              }
				              if(mode.equals("divisions")){
				            	 
								divCode=res.getString("division_office_code");
								divName=res.getString("division_office_name");
								 names+=divName+",";
							  }
							if(mode.equals("subdivisions")){
								subdivCode=res.getString("subdivision_office_code");
								subdivName=res.getString("subdivision_office_name");
								names+=subdivName+",";
							}
						
						//************Related to works**************//
						String worksQuery="";
					 worksQuery="select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
								+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
								+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
								+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
						if(mode.equals("circles")){ 
							worksQuery  = worksQuery+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
						}
						else if(mode.equals("divisions")){
							worksQuery = worksQuery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							worksQuery = worksQuery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println(worksQuery);
								Statement statement1 = conn.createStatement();
								ResultSet resultSet1 = statement1.executeQuery(worksQuery);
					if(resultSet1.next()) {
						works=resultSet1.getInt(2);
						EstCost=resultSet1.getDouble(1);}
							
									
						String habsSanQuery = "select count(distinct b.hab_code),sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+"where substr(a.office_code,2,2)='"+ccode+"' and WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
								+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
								if(mode.equals("divisions")){
									habsSanQuery+=" and substr(a.office_code,4,1)='"+divCode+"'";
								}
								if(mode.equals("subdivisions")){
									habsSanQuery+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
								}
								//System.out.println("habsSanQuery"+habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(habsSanQuery);
						if (rs1.next()) {
							habsSac=rs1.getInt(1);
							popBen=rs1.getInt(2);
						}
						stmt1.close();
						rs1.close();
						//************Quarter 1**************//
						String targetHabsQ1 = "select count(DISTINCT b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and  substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP between '01-APR-"
								+ yearStart
								+ "' and '30-JUN-"
								+ yearStart
								+ "' and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						if(mode.equals("divisions")){
							targetHabsQ1+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							targetHabsQ1+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						//System.out.println(targetHabsQ1);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetHabsQ1);
						if (rs1.next()) {
							habsSacQ1 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achievementHabsQ1 = "select count(DISTINCT h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and ((b.DATE_OF_COMPLETION between '01-APR-"+ yearStart+"' and '30-JUN-"+ yearStart+ "' and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion between '01-APR-"+ yearStart+"' and '30-JUN-"+ yearStart+ "' and b.DATE_OF_COMPLETION is null)) "
								+" and  target_date_comp>='01-APR-" + yearStart + "' and a.CORE_DASHBOARD_STATUS='Y'";
						achievementHabsQ1 += " and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") ";
						if(mode.equals("divisions")){
							achievementHabsQ1+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							achievementHabsQ1+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achievementHabsQ1);
						if (rs1.next()) {
							habsCovQ1 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						double percentageQ1 = 0;
						if (habsSacQ1 > 0) {
							percentageQ1 = Double.parseDouble("" + habsCovQ1 * 100)
									/ Double.parseDouble("" + habsSacQ1);
						}
						
						String previousHabsQ1 = "select count(DISTINCT h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-APR-"
								+ (yearStart - 1)
								+ "' and '30-JUN-"
								+ (yearStart - 1)
								+ "' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
						if(mode.equals("divisions")){
							previousHabsQ1+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							previousHabsQ1+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						//System.out.println(previousHabsQ1);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(previousHabsQ1);
						if (rs1.next()) {
							prehabsCovQ1 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();

						//************Quarter 2**************//
						String targetHabsQ2 = "select count(DISTINCT b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and  substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP between '01-JUL-"
								+ yearStart
								+ "' and  '30-SEP-"
								+ yearStart
								+ "' and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						if(mode.equals("divisions")){
							targetHabsQ2+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							targetHabsQ2+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetHabsQ2);
						if (rs1.next()) {
							habsSacQ2 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achievementHabsQ2 = "select count(DISTINCT h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null  and substr(a.office_code,2,2)='"+ccode+"' "
								+ " and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme + ") and ((b.DATE_OF_COMPLETION between '01-JUL-"+ yearStart + "' and '30-SEP-"+ yearStart+ "'  and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion between  '01-JUL-"+ yearStart + "' and '30-SEP-"+ yearStart+ "'  and b.DATE_OF_COMPLETION is null))" 
								+" and target_date_comp>='01-APR-" + yearStart + "' and a.CORE_DASHBOARD_STATUS='Y'";
						achievementHabsQ2 += " and substr(a.work_id,7,2) in ("+ schemes	+ ") ";
						if(mode.equals("divisions")){
							achievementHabsQ2+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							achievementHabsQ2+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achievementHabsQ2);
						if (rs1.next()) {
							habsCovQ2 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						double percentageQ2 = 0;
						if (habsSacQ2 > 0) {
							percentageQ2 = Double.parseDouble("" + habsCovQ2 * 100)
									/ Double.parseDouble("" + habsSacQ2);
						}
						String previousHabsQ2 = "select count(DISTINCT h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-JUL-"
								+ (yearStart - 1)
								+ "' and '30-SEP-"
								+ (yearStart - 1)
								+ "' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in ("
								+ schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
						if(mode.equals("divisions")){
							previousHabsQ2+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							previousHabsQ2+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(previousHabsQ2);
						if (rs1.next()) {
							prehabsCovQ2 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						//************Quarter 3**************//
						String targetHabsQ3 = "select count(DISTINCT b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and  substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP between '01-OCT-"
								+ yearStart
								+ "' and '31-DEC-"
								+ yearStart
								+ "' and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						if(mode.equals("divisions")){
							targetHabsQ3+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							targetHabsQ3+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetHabsQ3);
						if (rs1.next()) {
							habsSacQ3 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achievementHabsQ3 = "select count(DISTINCT h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and ((b.DATE_OF_COMPLETION between '01-OCT-"+ yearStart+ "' and '31-DEC-"+ yearStart+"' and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion between  '01-OCT-"+ yearStart+ "' and '31-DEC-"+ yearStart+"' and b.DATE_OF_COMPLETION is null)) "
								+" and b.DATE_OF_COMPLETION is not null  and target_date_comp>='01-APR-" + yearStart + "' and a.CORE_DASHBOARD_STATUS='Y'";
						achievementHabsQ3 += " and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") ";
						if(mode.equals("divisions")){
							achievementHabsQ3+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							achievementHabsQ3+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achievementHabsQ3);
						if (rs1.next()) {
							habsCovQ3 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						double percentageQ3 = 0;
						if (habsSacQ3 > 0) {
							percentageQ3 = Double.parseDouble("" + habsCovQ3 * 100)
									/ Double.parseDouble("" + habsSacQ3);
						}

						String previousHabsQ3 = "select count(DISTINCT h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ " and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-OCT-"
								+ (yearStart - 1)
								+ "' and '31-DEC-"
								+ (yearStart - 1)
								+ "' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in ("
								+ schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
						if(mode.equals("divisions")){
							previousHabsQ3+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							previousHabsQ3+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(previousHabsQ3);
						if (rs1.next()) {
							prehabsCovQ3 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						//************Quarter 4**************//
						String targetHabsQ4 = "select count(DISTINCT b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and a.programme_code in ("
								+ programme
								+ ") and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP between '01-JAN-"
								+ yearEnd
								+ "' and '31-MAR-"
								+ yearEnd
								+ "' and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						if(mode.equals("divisions")){
							targetHabsQ4+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							targetHabsQ4+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetHabsQ4);
						if (rs1.next()) {
							habsSacQ4 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achievementHabsQ4 = "select count(DISTINCT h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ " and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and ((b.DATE_OF_COMPLETION between '01-JAN-"+ yearEnd	+ "' and '31-MAR-"+ yearEnd+ "' and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion between  '01-JAN-"+ yearEnd	+ "' and '31-MAR-"+ yearEnd+ "' and b.DATE_OF_COMPLETION is null))"
								+ " and b.DATE_OF_COMPLETION is not null  and target_date_comp>='01-APR-" + yearStart + "' and a.CORE_DASHBOARD_STATUS='Y'";
						achievementHabsQ4 += " and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") ";
						if(mode.equals("divisions")){
							achievementHabsQ4+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							achievementHabsQ4+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achievementHabsQ4);
						if (rs1.next()) {
							habsCovQ4 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						double percentageQ4 = 0;
						if (habsSacQ4 > 0) {
							percentageQ4 = Double.parseDouble("" + habsCovQ4 * 100)
									/ Double.parseDouble("" + habsSacQ4);
						}
						String previousHabsQ4 = "select count(DISTINCT h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.office_code,2,2)='"+ccode+"' "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-JAN-"
								+ (yearEnd - 1)
								+ "' and '31-MAR-"
								+ (yearEnd - 1)
								+ "' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in ("
								+ schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";
						if(mode.equals("divisions")){
							previousHabsQ4+=" and substr(a.office_code,4,1)='"+divCode+"'";
						}
						if(mode.equals("subdivisions")){
							previousHabsQ4+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
						}
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(previousHabsQ4);
						if (rs1.next()) {
							prehabsCovQ4 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						//************Total Physical**************//
						
						habsSacTot = habsSacQ1+habsSacQ2+habsSacQ3+habsSacQ4;
						habsCovTot = habsCovQ1+habsCovQ2+habsCovQ3+habsCovQ4;
						prehabsCovTot = prehabsCovQ1+prehabsCovQ2+prehabsCovQ3+prehabsCovQ4;
						double percentageTot = 0;
						if (habsSacTot > 0) {
							percentageTot = Double.parseDouble("" + habsCovTot * 100)
									/ Double.parseDouble("" + habsSacTot);
						}
						
						//****************Total Exp FY Wise***************//
					String totExpBankDurQuery="select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and BANK_SEND_DATE BETWEEN '01-APR-"+yearStart+"' AND '31-MAR-"+yearEnd+"'  and b.programme_code in ("+ programme+ ") and substr(a.office_code,2,2)='"+ccode+"'";
					if(mode.equals("divisions")){
						totExpBankDurQuery+=" and substr(b.office_code,4,1)='"+divCode+"'";
					}
					if(mode.equals("subdivisions")){
						totExpBankDurQuery+=" and substr(b.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
					}
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(totExpBankDurQuery);
					if (rs1.next()) {
					 totExpBankDur = rs1.getDouble(1);
					}
					stmt1.close();
					rs1.close();
									
					String totExpPaoDurQuery="select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and STATE_SEND_DATE BETWEEN '01-APR-"+yearStart+"' AND '31-MAR-"+yearEnd+"'  and b.programme_code in ("+ programme+ ") and substr(a.office_code,2,2)='"+ccode+"'";
					if(mode.equals("divisions")){
						totExpPaoDurQuery+=" and substr(b.office_code,4,1)='"+divCode+"'";
					}
					if(mode.equals("subdivisions")){
						totExpPaoDurQuery+=" and substr(b.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
					}
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(totExpPaoDurQuery);
					if (rs1.next()) {
						totExpPaoDur = rs1.getDouble(1);
					}
					stmt1.close();
					rs1.close();
					String totexpDur=ndf.format((totExpBankDur+totExpPaoDur)/100000);
					
					String totExpBankPreQuery="select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and BANK_SEND_DATE BETWEEN '01-APR-"+(yearStart-1)+"' AND '31-MAR-"+(yearEnd-1)+"'  and b.programme_code in ("+ programme+ ") and substr(a.office_code,2,2)='"+ccode+"'";
					if(mode.equals("divisions")){
						totExpBankPreQuery+=" and substr(b.office_code,4,1)='"+divCode+"'";
					}
					if(mode.equals("subdivisions")){
						totExpBankPreQuery+=" and substr(b.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
					}
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(totExpBankPreQuery);
					if (rs1.next()) {
					 totExpBankPre = rs1.getDouble(1);  
					}
					stmt1.close();
					rs1.close();
									
					String totExpPaoPreQuery="select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and STATE_SEND_DATE BETWEEN '01-APR-"+(yearStart-1)+"' AND '31-MAR-"+(yearEnd-1)+"'  and b.programme_code in ("+ programme+ ") and substr(a.office_code,2,2)='"+ccode+"'";
					if(mode.equals("divisions")){
						totExpPaoPreQuery+=" and substr(b.office_code,4,1)='"+divCode+"'";
					}
					if(mode.equals("subdivisions")){
						totExpPaoPreQuery+=" and substr(b.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+subdivCode+"'";
					}
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(totExpPaoPreQuery);
					if (rs1.next()) {
						totExpPaoPre = rs1.getDouble(1);
					}
					stmt1.close();
					rs1.close();
					String totexpPre=ndf.format((totExpBankPre+totExpPaoPre)/100000);
					InputTarAchStr += "[" + habsSacTot + "," + habsCovTot + "],";
					if(works ==0&& habsSac == 0&&popBen==0&&
							 habsSacQ1 ==0&& habsCovQ1 == 0&& prehabsCovQ1 == 0&&
							 habsSacQ2 == 0&& habsCovQ2 == 0&& prehabsCovQ2 == 0&&
							 habsSacQ3 == 0&& habsCovQ3 == 0&& prehabsCovQ3 == 0&&
							 habsSacQ4 == 0&& habsCovQ4 == 0&& prehabsCovQ4 == 0&&
							 habsSacTot == 0&& habsCovTot == 0&& prehabsCovTot == 0){}
							else{
			%>
			<tr>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_achie_analy_div_subdiv_cm_rpt.jsp?mode=divisions&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>"><%=cname%></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_achie_analy_div_subdiv_cm_rpt.jsp?mode=subdivisions&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divcode=<%=divCode%>&divname=<%=divName%>"><%=divName%></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
				<%} %>
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode1=works&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Works &ccode=<%=ccode%>&year=<%=yearStart%>')"><%=works %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode1=works&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Works &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=works %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode1=works&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Works &ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=works %></a></td>
				<%} %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(EstCost) %></td>
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sacHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Habs Sanctioned&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsSac %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sacHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Habs Sanctioned&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsSac %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sacHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Habs Sanctioned&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsSac %></a></td>
				<%} %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=popBen %></td>
				<% if(habsSacQ1>0){
					if(mode.equals("circles")){	%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=30-JUN-<%=yearStart%>&message=<%=cname%> Circle <%=programmeName%> Quarter-1 Target&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsSacQ1%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=30-JUN-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-1 Target&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsSacQ1%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=30-JUN-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-1 Target&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsSacQ1%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacQ1%></td>
				
				<%} if(habsSacQ2>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-JUL-<%=yearStart%>&yearEnd=30-SEP-<%=yearStart%>&message=<%=cname%> Circle <%=programmeName%> Quarter-2 Target&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsSacQ2%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-JUL-<%=yearStart%>&yearEnd=30-SEP-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-2 Target&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsSacQ2%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-JUL-<%=yearStart%>&yearEnd=30-SEP-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-2 Target&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsSacQ2%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacQ2%></td>
				
				<%} if(habsSacQ3>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-OCT-<%=yearStart%>&yearEnd=31-DEC-<%=yearStart%>&message=<%=cname%> Circle <%=programmeName%> Quarter-3 Target&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsSacQ3%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-OCT-<%=yearStart%>&yearEnd=31-DEC-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-3 Target&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsSacQ3%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-OCT-<%=yearStart%>&yearEnd=31-DEC-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-3 Target&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsSacQ3%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacQ3%></td>
				
				<%} if(habsSacQ4>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-JAN-<%=yearEnd%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Quarter-4 Target&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsSacQ4%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-JAN-<%=yearEnd%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-4 Target&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsSacQ4%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-JAN-<%=yearEnd%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-4 Target&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsSacQ4%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacQ4%></td>
				<%} if(habsSacTot>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Total Target&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsSacTot%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Total Target&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsSacTot%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Total Target&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsSacTot%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacTot%></td>
				<%} %>
				
				
				<% if(habsCovQ1>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=30-JUN-<%=yearStart%>&message=<%=cname%> Circle <%=programmeName%> Quarter-1 Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsCovQ1%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=30-JUN-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-1 Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsCovQ1%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=30-JUN-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-1 Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsCovQ1%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovQ1%></td>
				<%}%>
				
				<% if(habsCovQ2>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-JUL-<%=yearStart%>&yearEnd=30-SEP-<%=yearStart%>&message=<%=cname%> Circle <%=programmeName%> Quarter-2 Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsCovQ2%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-JUL-<%=yearStart%>&yearEnd=30-SEP-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-2 Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsCovQ2%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-JUL-<%=yearStart%>&yearEnd=30-SEP-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-2 Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsCovQ2%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovQ2%></td>
				<%} %>
				
				<% if(habsCovQ3>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-OCT-<%=yearStart%>&yearEnd=31-DEC-<%=yearStart%>&message=<%=cname%> Circle <%=programmeName%> Quarter-3 Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsCovQ3%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-OCT-<%=yearStart%>&yearEnd=31-DEC-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-3 Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsCovQ3%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-OCT-<%=yearStart%>&yearEnd=31-DEC-<%=yearStart%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-3 Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsCovQ3%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovQ3%></td>
				<%} %>
				
				<% if(habsCovQ4>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-JAN-<%=yearEnd%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Quarter-4 Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsCovQ4%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-JAN-<%=yearEnd%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-4 Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsCovQ4%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-JAN-<%=yearEnd%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-4 Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsCovQ4%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovQ4%></td>
				
				<%} if(habsCovTot>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Total Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=habsCovTot%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Total Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=habsCovTot%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Total Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=habsCovTot%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovTot%></td>
				<%} %>
				
				<td class="<%=style%>" style="text-align: right;" align="right"><%=Math.round(percentageQ1)%>%</td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=Math.round(percentageQ2)%>%</td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=Math.round(percentageQ3)%>%</td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=Math.round(percentageQ4)%>%</td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=Math.round(percentageTot)%>%</td>
				
				
				<% if(prehabsCovQ1>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-APR-<%=(yearStart-1)%>&yearEnd=30-JUN-<%=(yearStart-1)%>&message=<%=cname%> Circle <%=programmeName%> Quarter-1 Previous FY Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=prehabsCovQ1%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-APR-<%=(yearStart-1)%>&yearEnd=30-JUN-<%=(yearStart-1)%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-1 Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=prehabsCovQ1%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-APR-<%=(yearStart-1)%>&yearEnd=30-JUN-<%=(yearStart-1)%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-1 Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=prehabsCovQ1%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovQ1%></td>
				<%} %>
				
				<% if(prehabsCovQ2>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-JUL-<%=(yearStart-1)%>&yearEnd=30-SEP-<%=(yearStart-1)%>&message=<%=cname%> Circle <%=programmeName%> Quarter-2 Previous FY Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=prehabsCovQ2%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-JUL-<%=(yearStart-1)%>&yearEnd=30-SEP-<%=(yearStart-1)%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-2 Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=prehabsCovQ2%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-JUL-<%=(yearStart-1)%>&yearEnd=30-SEP-<%=(yearStart-1)%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-2 Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=prehabsCovQ2%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovQ2%></td>
				<%} %>
				
				<% if(prehabsCovQ3>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-OCT-<%=(yearStart-1)%>&yearEnd=31-DEC-<%=(yearStart-1)%>&message=<%=cname%> Circle <%=programmeName%> Quarter-3 Previous FY Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=prehabsCovQ3%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-OCT-<%=(yearStart-1)%>&yearEnd=31-DEC-<%=(yearStart-1)%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-3 Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=prehabsCovQ3%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-OCT-<%=(yearStart-1)%>&yearEnd=31-DEC-<%=(yearStart-1)%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-3 Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=prehabsCovQ3%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovQ3%></td>
				<%} %>
				
				<% if(prehabsCovQ4>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-JAN-<%=(yearEnd-1)%>&yearEnd=31-MAR-<%=(yearEnd-1)%>&message=<%=cname%> Circle <%=programmeName%> Quarter-4 Previous FY Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=prehabsCovQ4%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-JAN-<%=(yearEnd-1)%>&yearEnd=31-MAR-<%=(yearEnd-1)%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Quarter-4 Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=prehabsCovQ4%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-JAN-<%=(yearEnd-1)%>&yearEnd=31-MAR-<%=(yearEnd-1)%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Quarter-4 Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=prehabsCovQ4%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovQ4%></td>
				<%} if(prehabsCovTot>0){
				if(mode.equals("circles")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-APR-<%=(yearStart-1)%>&yearEnd=31-MAR-<%=(yearEnd-1)%>&message=<%=cname%> Circle <%=programmeName%> Total Previous FY Achievement&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=prehabsCovTot%></a></td>
				<%}else if(mode.equals("divisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-APR-<%=(yearStart-1)%>&yearEnd=31-MAR-<%=(yearEnd-1)%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Total Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=prehabsCovTot%></a></td>
				<%}else if(mode.equals("subdivisions")){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rwsr_ach_analy_habs_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-APR-<%=(yearStart-1)%>&yearEnd=31-MAR-<%=(yearEnd-1)%>&message=<%=cname%> Circle <%=programmeName%> Total Previous FY Achievement&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=prehabsCovTot%></a></td>
				<%}}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovTot%></td>
				<%} %>
				<%-- <%
				int compQ1=habsCovQ1-prehabsCovQ1;
				int compQ2=habsCovQ2-prehabsCovQ2;
				int compQ3=habsCovQ3-prehabsCovQ3;
				int compQ4=habsCovQ4-prehabsCovQ4;
				int compTot=habsCovTot-prehabsCovTot;
				if(compQ1>0){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/up.jpg"/><%= compQ1%></td>
				<%} else{%>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(compQ1)%></td>
				<%} if(compQ2>0){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/up.jpg"/><%= compQ2%></td>
				<%} else{%>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(compQ2)%></td>
				<%} if(compQ3>0){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/up.jpg"/><%= compQ3%></td>
				<%} else{%>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(compQ3)%></td>
				<%} if(compQ4>0){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/up.jpg"/><%= compQ4%></td>
				<%} else{%>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(compQ4)%></td>
				<%} if(compTot>0){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/up.jpg"/><%= compTot%></td>
				<%} else{%>
				<td class="<%=style%>" style="text-align: right;" align="right"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(compTot)%></td>
				<%} %> --%>
			</tr>
			
			<%
			} tothabsSacQ1 += habsSacQ1;
			 tothabsCovQ1 += habsCovQ1;
			 totprehabsCovQ1 += prehabsCovQ1;
			 tothabsSacQ2 += habsSacQ2;
			 tothabsCovQ2 += habsCovQ2;
			 totprehabsCovQ2 += prehabsCovQ2;
			 tothabsSacQ3 += habsSacQ3;
			 tothabsCovQ3 += habsCovQ3;
			 totprehabsCovQ3 += prehabsCovQ3;
			 tothabsSacQ4 += habsSacQ4;
			 tothabsCovQ4 += habsCovQ4;
			 totprehabsCovQ4 += prehabsCovQ4;
			 tothabsSacTot += habsSacTot;
			 tothabsCovTot += habsCovTot;
			 totprehabsCovTot += prehabsCovTot;
			 totExpDuringFY+=totExpBankDur+totExpPaoDur;
			 totExpPreviousFY+=totExpBankPre+totExpPaoPre;
			 totEstCost +=EstCost; 
			 totworks += works;
			 tothabsSac += habsSac;
			 totpopBen+=popBen;
				if (tothabsSacQ1 > 0) {
					totpercentageQ1 = Double.parseDouble("" + tothabsCovQ1 * 100)
							/ Double.parseDouble("" + tothabsSacQ1);
				}
				if (tothabsSacQ2 > 0) {
					totpercentageQ2 = Double.parseDouble("" + tothabsCovQ2 * 100)
							/ Double.parseDouble("" + tothabsSacQ2);
				}
				if (tothabsSacQ3 > 0) {
					totpercentageQ3 = Double.parseDouble("" + tothabsCovQ3 * 100)
							/ Double.parseDouble("" + tothabsSacQ3);
				}
				if (tothabsSacQ4 > 0) {
					totpercentageQ4 = Double.parseDouble("" + tothabsCovQ4 * 100)
							/ Double.parseDouble("" + tothabsSacQ4);
				}
				if (tothabsSacTot > 0) {
					totpercentageTot = Double.parseDouble("" + tothabsCovTot * 100)
							/ Double.parseDouble("" + tothabsSacTot);
				}
			 /* totcompQ1 += compQ1;
			 totcompQ2 += compQ2;
			 totcompQ3 += compQ3;
			 totcompQ4 += compQ4;
			 totcompTot += compTot; */ 
				}
					/* double percentageTot = 0;
					if (habsSacTot > 0) {
						percentageTot = Double.parseDouble("" + habsCovTot * 100)
								/ Double.parseDouble("" + habsSacTot);
					} */
					InputTarAchStr = InputTarAchStr.substring(0, InputTarAchStr.length() - 1);
					session.setAttribute("InputTarAchStr", InputTarAchStr);
				%>
			<tr class="rightPad">
				<td class="btext" style="text-align: right;" colspan=2>Total</td>
				<td class="btext" style="text-align: right;"><%=totworks %></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)  %></td>
				<td class="btext" style="text-align: right;"><%=tothabsSac %></td>
				<td class="btext" style="text-align: right;"><%=totpopBen %></td>
				
				<td class="btext" style="text-align: right;"><%=tothabsSacQ1 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsSacQ2 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsSacQ3 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsSacQ4 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsSacTot %></td>
				
				<td class="btext" style="text-align: right;"><%=tothabsCovQ1 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovQ2 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovQ3 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovQ4 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovTot %></td>
				
				<td class="btext" style="text-align: right;"><%= Math.round(totpercentageQ1) %>%</td>
				<td class="btext" style="text-align: right;"><%= Math.round(totpercentageQ2) %>%</td>
				<td class="btext" style="text-align: right;"><%= Math.round(totpercentageQ3) %>%</td>
				<td class="btext" style="text-align: right;"><%= Math.round(totpercentageQ4) %>%</td>
				<td class="btext" style="text-align: right;"><%= Math.round(totpercentageTot) %>%</td>
				
				<td class="btext" style="text-align: right;"><%=totprehabsCovQ1 %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovQ2 %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovQ3 %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovQ4 %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovTot %></td>
				
				<%-- <%if(totcompQ1>0){ %>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/up.jpg"/><%= totcompQ1%></td>
				<%} else{%>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(totcompQ1)%></td>
				<%} %>
				<%if(totcompQ2>0){ %>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/up.jpg"/><%= totcompQ2%></td>
				<%} else{%>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(totcompQ2)%></td>
				<%} %>
				<%if(totcompQ3>0){ %>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/up.jpg"/><%= totcompQ3%></td>
				<%} else{%>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(totcompQ3)%></td>
				<%} %>
				<%if(totcompQ4>0){ %>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/up.jpg"/><%= totcompQ4%></td>
				<%} else{%>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(totcompQ4)%></td>
				<%} %>
				<%if(totcompTot>0){ %>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/up.jpg"/><%= totcompTot%></td>
				<%} else{%>
				<td class="btext" style="text-align: right;"><img src="/pred/resources/graphs/down.jpg"/><%= Math.abs(totcompTot)%></td>
				<%} %> --%>
			
			</tr>
			<%
				         
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
		
		<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<!doctype html>
<html>
    <%
        /* if(session.getAttribute("habSancMap")==null || session.getAttribute("habTarMap")==null || session.getAttribute("habCovMap")==null)
        {
            response.sendRedirect("http://core.ap.gov.in/");
            return;
        } 
          programme = request.getParameter("programme");
        if(programme==null || programme==""){
        	programme="00";
        }
        System.out.println(programme); */
        String mode1 = request.getParameter("mode1");
        if(mode1==null || mode1==""){
        	mode1="Bar";
        }
        /* long habToCover = Long.parseLong(habTarMap.get(programme).toString()) - Long.parseLong(habCovMap.get(programme).toString());
     
        String distBars = "";
         String habPie = "[[\"Sanctioned Habs \","+habSancMap.get(programme)+"],"+"[\"Target Habs \","+habTarMap.get(programme)+"],"+"[\"Covered Habs \","+habCovMap.get(programme)+"],"+"[\"To Be Covered \","+habToCover+"]]";
         String QuarterTarPie = "[[\"Quarter-1 \","+q1TarMap.get(programme)+"],"+"[\"Quarter-2 \","+q2TarMap.get(programme)+"],"+"[\"Quarter-3 \","+q3TarMap.get(programme)+"],"+"[\"Quarter-4 \","+q4TarMap.get(programme)+"]]"; 
         String QuarterAchPie = "[[\"Quarter-1 \","+q1AchMap.get(programme)+"],"+"[\"Quarter-2 \","+q2AchMap.get(programme)+"],"+"[\"Quarter-3 \","+q3AchMap.get(programme)+"],"+"[\"Quarter-4 \","+q4AchMap.get(programme)+"]]";
         
       
         
        Set keySet2 = progMap.keySet();
         List keyList = new ArrayList(keySet2);
         Collections.sort(keyList);
          */
          
          String ar[]=names.split(",");
          int width=0;
          if (mode.equals("initial")) {
          width=1000;
          }
          else{
          	width=ar.length*102;
          	if(width>1000){
          		
          	}
          	else{
          		width=1050;
          	}
          }
    %>
    <head>
        <meta charset="utf-8">
        <meta name="description" content="A jquery plugin to create simple donut, bar or line charts with dom nodes, style with css.">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title></title>

        <script src="/pred/resources/graphs/jquery.min.js"></script>
        <link rel="stylesheet" href="/pred/resources/graphs/cssCharts.css">
        <script src="/pred/resources/graphs/jquery.chart.js"></script>

        <style>
            /* page specific styles*/
         h1{text-align:center;font-family:sans-serif;font-size:28px;color:#333;padding:40px 0 0 0;}
            h2{text-align:center;font-family:sans-serif;font-size:18px;color:#333;padding:40px 0 0 0;}
            hr{width:60%;height:1px;background:none;border:none;border-bottom:1px dashed rgba(0,0,0,0.1);outline:none;margin:40px auto 60px auto;}

            .desc p{text-align:center;font-size:16px;color:rgba(0,0,0,0.6);padding:20px 0 0 0;font-family:sans-serif;}
            .desc a{color:blue;}
            .wrap{margin:0 auto;width:640px;padding-bottom:100px;}
            #line{width:400px;}
              
          .distbar ul {
                margin-right: 10px !important;
            }
            .bar-chart span{
                    margin: 0 0px !important;
            }
            
            .chart.pie .pie-legend {
                margin-right: 20px !important;
                margin-top: 180px !important;
            }
           
            .bar-chart span:before {
                width: 20px !important;
                word-wrap: normal !important;
            }
            .bar-chart ul{
                 margin-left: 30px !important;
            }
			.bar-chart ul {
    		margin-left: 70px
    		}
        </style>
        <%-- <script>
            $(document).ready(function() {
                    $("#programme option[value='<%=programme%>']").prop('selected', true);
                    $("#programme").change(function() {
                        $("#graphParams").submit();
                    });
            });
        </script> --%>

    </head>
    <%-- <body>
        <form id="graphParams" name="graphParams" action="rws_achie_analy_div_subdiv_cm_rpt.jsp">
            <input type="hidden" id="mode1" name="mode1" value="<%=mode1%>"/>
        <div class="wrap" style="margin-top: -30px !important; width: <%=width%>px !important; text-align: center !important;">
            <br/><br/> 	

            <%
                if(mode1.equals("Bar"))
                {
                	int top=35,left=-(39*ar.length);
                	if(ar.length<=3){
                		left=-(60*ar.length);
                	}
                    int len=ar.length;
                    len=75*len;
                     if(ar.length<=3){
                 	   len=85*(ar.length+1);
                    } 
                    //System.out.println(len);
                    int graphleft=ar.length*ar.length;
                  //  graphleft=-graphleft-480;
                    graphleft=-ar.length*50;
                    if(ar.length<=3){
                 	   graphleft=-(ar.length+1)*85;
                    }
               
            %>
                    <br/>
            <div id="distChart" style=" padding-left: 50px;  padding-bottom: 100px;   padding-top: 20px; border : 1px double #c67; border-radius: 8px;">
                <p style="font-weight: normal; text-align: center;">
                    <span style="background-color: #546E28;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Target&nbsp;&nbsp;&nbsp;&nbsp;
                   <span style="background-color: #EE761E;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Acheivement&nbsp;&nbsp;&nbsp;&nbsp;
                   <!--  <span style="background-color: #C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;NSS (No Safe Source) -->
                </p>
                <br/>
                <div class="chart" style="left: 0px ; height: 300px;">
                    <ul id="distChartUL" class="bar-chart" data-bars="<%=InputTarAchStr%>" data-max="" data-unit="" data-width="16" style="margin-left: 0px;width: <%=len %>px;" >
                    <ul><li style="height:300px"></li></ul>
                    </ul>
                    <p style="transform: rotate(270deg);position: relative;top: 120px; left: <%=graphleft%>px; font-weight: bold;	margin-left: -0px !important;">Targets and Achievements count</p>
                    <p style="margin-left: 25px !important;">
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                     <%
                   for(int i=0;i<ar.length;i++){
                	   top=top-15;
                	   left=left+65;
                	   /* if(ar.length<=3){
                	   left=left+40;
                	   }
                	   else{
                		   left=left+65;
                	   } */
                	  // System.out.println("left-----"+left);
                   %>
                   
                   <h4 style="transform: rotate(-30deg);top: <%=top%>px;position: relative;left: <%=left%>px;"><%=ar[i] %></h4>
                   
                   <%}%> 
                    </p>
                </div>
            </div>
            <%
                }
                else if(mode1.equals("Pie"))
                {
            %>
            <br/>
            
            <div id="pieChart" style="padding-bottom: 130px;  border : 1px double #c67; border-radius: 8px; vertical-align: top !important;">
                    <div class="desc" style="text-align: center; font-weight: bold;">
               
                 <font color="#663899" face="Maiandra GD" size="6px"><b>Works Progress - Target Vs Achievement </b></font>
                <br/><font color="#889900" face="Maiandra GD" size="3px">( Programme: <%=progMap.get(programme)%> )</font>
                
            </div>
                     <div id="distPieDiv" style=" margin-left: 380px !important;width:480px !important; text-align: center !important; font-weight: bold; margin-top: 50px !important;">
                        Programme Wise Habs Progress : &nbsp;
                        <select name="programme" id="programme" style="width: 120px !important;">
                            <%
                                for(Object key: keyList)
                                {
                                    %>
                                    <option value="<%=key%>"><%=progMap.get(key)%></option>
                                    <%
                                }
                            %>
                        </select>&nbsp;&nbsp;
                    </div> 
                    <br/>
                    <table>
                        <tr>
                            <td >
                                <h3 style="margin-left: 60px !important;">Habs Progress</h3>
                                <div class="chart" style="width:200px !important; margin-left: 30px !important; text-align: left !important; ">
                                    <div class="pie-thychart" data-set='<%=habPie%>' data-colors="#0086b3,#FFA500,#006400,#d62929">
                                    </div>
                                </div>
                            </td>
                             <td>
                                <h3 style="margin-left: 140px !important;">Quarter Wise Target Habs</h3>
                                <div class="chart" style="width:200px !important; margin-left: 180px !important; text-align: left !important;">
                                    <div class="pie-thychart" data-set='<%=QuarterTarPie%>' data-colors="#0086b3,#FFA500,#006400,#d62929">
                                    </div>
                                </div>
                            </td>
                           <td>
                                <h3 style="margin-left: 90px !important;margin-right: 60px !important;">Quarter Wise Achivement Habs</h3>
                                <div class="chart" style="width:200px !important; margin-left: 180px !important; text-align: left !important;">
                                    <div class="pie-thychart" data-set='<%=QuarterAchPie%>' data-colors="#0086b3,#FFA500,#006400,#d62929">
                                    </div>
                                </div>
                            </td> 
                        </tr>
                    </table>

            </div>
            <%
                }
            %>
        </div>
        </form>
        
        <script>
            $(function () {
                $('.bar-chart').cssCharts({type: "bar"});
                $('.donut-chart').cssCharts({type: "donut"}).trigger('show-donut-chart');
                $('.line-chart').cssCharts({type: "line"});
                $('.pie-thychart').cssCharts({type: "pie"});
            });
        </script>
    </body> --%>
</html>
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
</BODY>

