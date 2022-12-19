<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>

<table bgcolor="#F8FCEE" width="100%" height="40px" cellspacing="0" cellpadding="0" border="0" >
<!-- Page header starts here-->
<tr height="1%">
	<td class="pageHeading" align="center">
		<bean:message key="app.title1" />
		 <span style="font-family:verdana; font-size: 8pt; "></span>		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="app.heading2" />
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>
</table>


<%
	DecimalFormat ndf = new DecimalFormat("####.00");

	String rDistrict = "";
	String finyear = "";
	String dname = "";
	String programe = "";
	String mode = "";
        
                  if (request.getParameter("mode") != null)
		mode = request.getParameter("mode");
	else
		mode="districts";
        
	if (request.getParameter("district") != null)
		rDistrict = request.getParameter("district");
	else
		rDistrict = "00";
	session.setAttribute("rDistrict", rDistrict);
	
	if (request.getParameter("dname") != null)
		dname = request.getParameter("dname");
	else
		dname = "ALL";
	session.setAttribute("dname", dname);
	
	
	if (request.getParameter("finyear") != null)
		finyear = request.getParameter("finyear");
	else
	{
		Statement stmtt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ResultSet rss=stmtt.executeQuery("select distinct to_char(max(status_date),'dd-MON-yyyy') from rws_hab_directory_view");
        while(rss.next()) 
        {
        	finyear = rss.getString(1);
        }
	}
	
	session.setAttribute("finyear", finyear);
	
	if (request.getParameter("program") != null)
		programe = request.getParameter("program");
	else
		programe = "all";
	
	//programe = request.getParameter("program");
	if(programe.equals("all")){
		String progCode = "";
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
		programe=progCode+",04,65,57";
		//System.out.println("------"+programe);
	}
	
	session.setAttribute("programe", programe);

	String startyr = finyear.substring(0, 4);

	String endyr = finyear.substring(5, 9);
	
	String divCode="";
	WorksData1 data1=new WorksData1();
	int cyear = Calendar.getInstance().get(Calendar.YEAR);
    int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
    int lMonth = Calendar.getInstance().get(Calendar.MONTH);
    int day = Calendar.getInstance().get(Calendar.DATE);
    String currentMonth=data1.getCurrentMonth(month);
   // System.out.println("currentMonth"+currentMonth);
    String lastMonth="";
    if(currentMonth.equals("JAN")){
    	 lastMonth="DEC-"+(cyear-1);
    }
    else{
     lastMonth=data1.getCurrentMonth(lMonth)+"-"+cyear;
    }
    String cDate=day+"-"+currentMonth+"-"+cyear;
    int yearStart=0;
    int yearEnd=0;
    if (month <= 3) {
    	yearStart=cyear - 1;
	    yearEnd=cyear;
    } else {
    	yearStart=cyear;
	    yearEnd=cyear + 1;
    }
//     System.out.println("@________year start"+yearStart);
//     System.out.println("##_______year end"+yearEnd);
%>
<script language="JavaScript">

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
<BODY>
	<form name=f1 method="post">


		<table border=1 cellspacing=0 cellpadding=0 height=5% width="100%"
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" align="center">
                                        <%
                                        if(mode.equals("divisions")||mode.equals("subdivisions"))
                                        {
                                        %>
			<caption>
				<table border=0 rules=none style="border-collapse: collapse"
					align="right">
					<tr align="right">
						<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;&nbsp;</td>
					</tr>
				</table>
			</caption>
                                        <%
                                        }
                                        %>
			<tr align=center align=center>
				<td class="gridhdbg" colspan="14"><b>Work Progress Abstract
						Report for <%=finyear %></b></td>
			<tr align=center align=center>
				<td class=gridhdbg rowspan=2>Sl.No</td>
				<%if(mode.equals("divisions")){ %>
				<td class=gridhdbg rowspan=2>Division</td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class=gridhdbg rowspan=2>Sub Division</td>
				<%}else{ %>
				<td class=gridhdbg rowspan=2>District</td>
				<%}%>
				<td class=gridhdbg rowspan=2>No. of Works</td>
				<td class=gridhdbg rowspan=2>Habs Sanctioned</td>
				<td class=gridhdbg rowspan=2>Est. Cost</td>
				
				<td class=gridhdbg rowspan=2>Exp. Upto Last Financial Year <br>(<%=(yearStart-1) %>-<%=(yearEnd-1) %>)</td>
				<td colspan=3 class=gridhdbg align="center">Exp. During the
					Financial Year <br>(<%=yearStart %>-<%=yearEnd %>)</td>
				<td class=gridhdbg rowspan=2>ARFC(Est.Cost-Cum. Exp.)</td>
				<td class=gridhdbg rowspan=2>Works completed</td>
				<td class=gridhdbg rowspan=2>Habs Coved</td>
				<td class=gridhdbg rowspan=1 colspan=2 style="width: 250px !important;">Physically Completed But<br/>Not Financially Completed<br/>(<%=yearStart-1 %>-<%=yearEnd-1 %>)</td>
				
			</tr>
			<tr>
				<td colspan=1 class=gridhdbg align="center">Exp. Upto Last
					Month (<%=lastMonth %>)</td>
				<td colspan=1 class=gridhdbg align="center">Exp. During the
					Month (<%=currentMonth %>-<%=cyear %>)</td>
				<td colspan=1 class=gridhdbg align="center">Total Exp.</td>
				<td colspan=1 class=gridhdbg align="center">No. of Works</td>
				<td colspan=1 class=gridhdbg align="center">Total Exp.</td>


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
				
				

				try {
					int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totWorksPhyCompNotFin = 0;
					double totarfc=0,totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, totExpPhyCompNotFin=0;
					String query = "";
					if(mode.equals("divisions")){
						query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),d.dname,d.dcode,div.division_office_code,div.division_office_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_division_office_tbl div where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE";
                                                                                                            query += " and d.dcode='" + rDistrict + "' and d.dcode=div.circle_office_code and div.division_office_code=substr(a.office_code,4,1)";
                                                                                                            query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                                                                                                            query += " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
                                                                                                                    + programe
                                                                                                                    + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  group by dname,d.dcode,div.division_office_code,div.division_office_name order by d.dcode,div.division_office_code";
					}
					else if(mode.equals("subdivisions")){
						divCode=request.getParameter("divCode");
						query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),d.dname,d.dcode,div.division_office_code,div.division_office_name,sdiv.subdivision_office_code,sdiv.subdivision_office_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_division_office_tbl div,rws_subdivision_office_tbl sdiv where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE";
						query += " and d.dcode='" + rDistrict + "' and d.dcode=div.circle_office_code and div.division_office_code=substr(a.office_code,4,1) and div.circle_office_code=sdiv.circle_office_code and div.division_office_code=sdiv.division_office_code and sdiv.division_office_code='"+divCode+"' and sdiv.subdivision_office_code=substr(a.office_code,5,2)";
						query+="  and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                                                                                                            query += " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
                                                                                                                        + programe
                                                                                                                        + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  group by dname,d.dcode,div.division_office_code,div.division_office_name,sdiv.subdivision_office_code,sdiv.subdivision_office_name order by d.dcode,div.division_office_code,sdiv.subdivision_office_code";
					//System.out.println("main query"+query);
					}
					else{
                                                                                                            query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),d.dname,d.dcode from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE";
                                                                                                            if (rDistrict != null && !rDistrict.equals("00")) {
                                                                                                                    query += " and d.dcode='" + rDistrict + "'";
                                                                                                            }
                                                                                                            query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                                                                                                            query += " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programe
							+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  group by dname,d.dcode order by d.dcode";
					}
					stmt = conn.createStatement();
					rs = stmt.executeQuery(query);
					System.out.println("_____********_____no of works query:  "+query);
					while (rs.next()) {

						double estCost = 0, bankLastYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoLastYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0, expPhyCompNotFin=0, bankPhyCompNotFin=0, paoPhyCompNotFin=0;
						int noOfWorks = 0, habsSanctioned = 0, worksComp = 0, habsCov = 0, worksPhyCompNotFin=0;
						noOfWorks = rs.getInt(2);
						estCost = rs.getDouble(1);
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
			%>
			<tr>

				<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
				<%if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: left;" align="right"><a href="./rws_CM_work_progress_abstract_list.jsp?mode=subdivisions&district=<%=rs.getString(4)%>&program=<%=programe%>&dname=<%=rs.getString(3)%>&finyear=<%=finyear%>&divCode=<%=rs.getString(5)%>&finyear=<%=finyear%>"><%=rs.getString(6)%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=tWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&finyear=<%=finyear%>')"><%=noOfWorks%></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(8)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=tWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&subdivCode=<%=rs.getString(7)%>&finyear=<%=finyear%>')"><%=noOfWorks%></a></td>
				<%} else{%>
				<td class="<%=style%>" style="text-align: left;" align="right"><a href="./rws_CM_work_progress_abstract_list.jsp?mode=divisions&district=<%=rs.getString(4)%>&program=<%=programe%>&dname=<%=rs.getString(3)%>&finyear=<%=finyear%>"><%=rs.getString(3)%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=tWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&finyear=<%=finyear%>')"><%=noOfWorks%></a></td>
				<%}%>
				
				
				<%
				
					String sacHabs = "select count(b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
									+ programe + ")";
					if(mode.equals("divisions")){
						sacHabs+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
					}
					if(mode.equals("subdivisions")){
						sacHabs+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
					}
					query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(sacHabs);
							System.out.println("_____********_____sanc habs query:  "+sacHabs);
							if (rs1.next()) {
								habsSanctioned = rs1.getInt(1);
				%>
				<%if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=sHabs&mode1=normal&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&finyear=<%=finyear%>')"><%=habsSanctioned%></a></td>
				<%}
				else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=sHabs&mode1=normal&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&subdivCode=<%=rs.getString(7)%>&finyear=<%=finyear%>')"><%=habsSanctioned%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=sHabs&mode1=normal&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&finyear=<%=finyear%>')"><%=habsSanctioned%></a></td>
				<%}
					}
							stmt1.close();
							rs1.close();
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=estCost%></td>
				
				<%
					String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.programme_code in ("
									+ programe
									+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-"
									+ (yearEnd-1) + "'";
								if(mode.equals("divisions")){
									bankLFY+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
								}
								if(mode.equals("subdivisions")){
									bankLFY+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
								}
								query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(bankLFY);
							//System.out.println("bankLFY"+bankLFY);
							if (rs1.next()) {
								bankLastYear = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();

							String paoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.programme_code in ("
									+ programe
									+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-"
									+ (yearEnd-1) + "'";
							if(mode.equals("divisions")){
								paoFLY+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
							}
							if(mode.equals("subdivisions")){
								paoFLY+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
							}
							query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(paoFLY);
							//System.out.println("paoFLY"+paoFLY);
							if (rs1.next()) {
								paoLastYear = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();

							String finalamount = ndf
									.format((bankLastYear + paoLastYear) / 100000);
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount%></td>

				<%
					String bankUptoLastMonth = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.programme_code in ("
									+ programe
									+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>='01-APR-"
									+ yearStart
									+ "' and BANK_SEND_DATE<'01-"
									+ currentMonth + "-" + yearEnd + "'";
							if(mode.equals("divisions")){
								bankUptoLastMonth+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
							}
							if(mode.equals("subdivisions")){
								bankUptoLastMonth+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
							}
							query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
								stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(bankUptoLastMonth);
							//System.out.println("bankUptoLastMonth"+bankUptoLastMonth);
							if (rs1.next()) {
								bankLastMonth = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();

							String paoUptoLastMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.programme_code in ("
									+ programe
									+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>='01-APR-"
									+ yearStart
									+ "' and STATE_SEND_DATE<'01-"
									+ currentMonth + "-" + yearEnd + "'";
							if(mode.equals("divisions")){
								paoUptoLastMonth+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
							}
							if(mode.equals("subdivisions")){
								paoUptoLastMonth+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
							}
							query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(paoUptoLastMonth);
							//System.out.println("paoUptoLastMonth"+paoUptoLastMonth);
							if (rs1.next()) {
								paoLastMonth = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();
							String finalamountUptoLastMonth = ndf
									.format((bankLastMonth + paoLastMonth) / 100000);
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=finalamountUptoLastMonth%></td>

				<%
					String bankcurrMonth = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.programme_code in ("
									+ programe
									+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and BANK_SEND_DATE>='01-"
									+ currentMonth
									+ "-"
									+ cyear
									+ "' and BANK_SEND_DATE<='" + cDate + "'";
							if(mode.equals("divisions")){
								bankcurrMonth+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
							}
							if(mode.equals("subdivisions")){
								bankcurrMonth+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
							}
							query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(bankcurrMonth);
							//System.out.println("bankcurrMonth"+bankcurrMonth);
							if (rs1.next()) {
								bankCurrentMonth = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();

							String paocurrMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.programme_code in ("
									+ programe
									+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>='01-"
									+ currentMonth
									+ "-"
									+ cyear
									+ "' and STATE_SEND_DATE<='" + cDate + "'";
							if(mode.equals("divisions")){
								paocurrMonth+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
							}
							if(mode.equals("subdivisions")){
								paocurrMonth+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
							}
							query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(paocurrMonth);
							//System.out.println("paocurrMonth"+paocurrMonth);
							if (rs1.next()) {
								paoCurrentMonth = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();
							String finalamountCurrentMonth = ndf
									.format((bankCurrentMonth + paoCurrentMonth) / 100000);
							String finalTotalFY = ndf
									.format((bankLastMonth + paoLastMonth
											+ bankCurrentMonth + paoCurrentMonth) / 100000);
							double cexp=((bankLastYear+paoLastYear+bankLastMonth+paoLastMonth+bankCurrentMonth+paoCurrentMonth)/100000);
							double arfc=estCost-cexp;
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=finalamountCurrentMonth%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=finalTotalFY%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%= ndf.format(arfc)%></td>
<%
					/* String compWorks = "select count(a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null and DT_FIN_COMPLETION is not null) and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
									+ programe
									+ ") and b.DATE_OF_COMPLETION is not null"; */
					String compWorks = "select count(a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "'  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
									+ programe
									+ ") and b.DATE_OF_COMPLETION between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' and b.DATE_OF_COMPLETION is not null";
							if(mode.equals("divisions")){
								compWorks+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
							}
							if(mode.equals("subdivisions")){
								compWorks+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
							}
							/* if(type.equals("MVS")){
								query+=" and substr(a.work_id,7,2)='03'";
							}
							else{
								query+=" and substr(a.work_id,7,2) <> '03'";
							} */
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(compWorks);
							System.out.println("_____********_____comp works query:  "+compWorks);
							if (rs1.next()) {
								worksComp = rs1.getInt(1);
				%>
				<%if(mode.equals("divisions")){ %>
				
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=cWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&finyear=<%=finyear%>')"><%=worksComp%></a></td>
				<%}
				else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=cWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&subdivCode=<%=rs.getString(7)%>&finyear=<%=finyear%>')"><%=worksComp%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=cWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&finyear=<%=finyear%>')"><%=worksComp%></a></td>
				<%}
					}
							stmt1.close();
							rs1.close();
				%>


				<%
					/* String covHabs = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null and DT_FIN_COMPLETION is not null)  and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
									+ programe
									+ ") and b.DATE_OF_COMPLETION is not null"; */
									
						String covHabs = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "'   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
									+ programe
									+ ") and b.DATE_OF_COMPLETION between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' and b.DATE_OF_COMPLETION is not null";
								if(mode.equals("divisions")){
									covHabs+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
								}
								if(mode.equals("subdivisions")){
									covHabs+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
								}
								/* if(type.equals("MVS")){
									query+=" and substr(a.work_id,7,2)='03'";
								}
								else{
									query+=" and substr(a.work_id,7,2) <> '03'";
								} */
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(covHabs);
							System.out.println("_____********_____habs cov query:  "+covHabs);
							if (rs1.next()) {
								habsCov = rs1.getInt(1);
				%>
				<%if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=cHabs&mode1=normal&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&finyear=<%=finyear%>')"><%=habsCov%></a></td>
				<%}
				else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=cHabs&mode1=normal&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&subdivCode=<%=rs.getString(7)%>&finyear=<%=finyear%>')"><%=habsCov%></a></td>
				<%}else{ %>
				
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=cHabs&mode1=normal&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&finyear=<%=finyear%>')"><%=habsCov%></a></td>
				<%}
					}
							stmt1.close();
							rs1.close();
							
				%>
				
				
				<!-- @@@@@@@@@@@@@@@@@@@@@@@ Added by Srivenu on 12/05/2016 @@@@@@@@@@@@@@@@@@@@@@@@@@ -->
				
				
				<%
					String phyCompNotFinWorks = "select count(a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_programme_tbl p  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "'  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.PROGRAMME_CODE=p.PROGRAMME_CODE  and a.programme_code in ("
									+ programe
									+ ") and b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMPLETION between '01-APR-"+(yearStart-1)+"' and '31-MAR-"+(yearEnd-1)+"' and b.DT_FIN_COMPLETION is null";
							if(mode.equals("divisions")){
								phyCompNotFinWorks+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
							}
							if(mode.equals("subdivisions")){
								phyCompNotFinWorks+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
							}
							stmt1 = conn.createStatement();
							System.out.println("_____********_____phy comp not fin works query:  "+phyCompNotFinWorks);
							rs1 = stmt1.executeQuery(phyCompNotFinWorks);
							if (rs1.next()) {
								worksPhyCompNotFin = rs1.getInt(1);
								%>
								<%if(mode.equals("divisions")){ %>
								<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=pnfWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&finyear=<%=finyear%>')"><%=worksPhyCompNotFin%></a></td>
								<%}
								else if(mode.equals("subdivisions")){ %>
								<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=pnfWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&divCode=<%=rs.getString(5)%>&subdivCode=<%=rs.getString(7)%>&finyear=<%=finyear%>')"><%=worksPhyCompNotFin%></a></td>
								<%}else{ %>
								<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=pnfWorks&dcode=<%=rs.getString(4)%>&programmeCode=<%=programe%>&dname=<%=rs.getString(3)%>&finyear=<%=finyear%>')"><%=worksPhyCompNotFin%></a></td>
								<%}
							}
							stmt1.close();
							rs1.close();
				%>
				
				
				<%
					String phyCompNotFinExpBANK = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_work_completion_tbl wc where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.programme_code in ("
									+ programe
									+ ") and a.work_id=wc.work_id and wc.DATE_OF_COMPLETION is not null and wc.DATE_OF_COMPLETION between '01-APR-"+(yearStart-1)+"' and '31-MAR-"+(yearEnd-1)+"' and wc.DT_FIN_COMPLETION is null and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-"
									+ (yearEnd-1) + "'";
								if(mode.equals("divisions")){
									phyCompNotFinExpBANK+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
								}
								if(mode.equals("subdivisions")){
									phyCompNotFinExpBANK+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
								}
								query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
							stmt1 = conn.createStatement();
							//System.out.println("phyCompNotFinExpBANK Query:  "+phyCompNotFinExpBANK);
							rs1 = stmt1.executeQuery(phyCompNotFinExpBANK);
							if (rs1.next()) {
								bankPhyCompNotFin = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();

							String phyCompNotFinExpPAO = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_work_completion_tbl wc where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(4)
									+ "' and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.programme_code in ("
									+ programe
									+ ") and a.work_id=wc.work_id and wc.DATE_OF_COMPLETION is not null and wc.DATE_OF_COMPLETION between '01-APR-"+(yearStart-1)+"' and '31-MAR-"+(yearEnd-1)+"' and wc.DT_FIN_COMPLETION is null and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-"
									+ (yearEnd) + "'";
							if(mode.equals("divisions")){
								phyCompNotFinExpPAO+=" and substr(a.office_code,4,1)='"+rs.getString(5)+"'";
							}
							if(mode.equals("subdivisions")){
								phyCompNotFinExpPAO+=" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+rs.getString(7)+"'";
							}
							query+=" and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
							stmt1 = conn.createStatement();
							//System.out.println("phyCompNotFinExpPAO Query: "+phyCompNotFinExpPAO);
							rs1 = stmt1.executeQuery(phyCompNotFinExpPAO);
							if (rs1.next()) {
								paoPhyCompNotFin = rs1.getDouble(1);
							}
							stmt1.close();
							rs1.close();

							String finAmount = ndf.format((bankPhyCompNotFin + paoPhyCompNotFin) / 100000);
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=finAmount%></td>
				
			<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
				
			</tr>
			<%
						totNoOfWorks = totNoOfWorks + noOfWorks;
						totEstCost = totEstCost + estCost;
						totHabsSanctioned = totHabsSanctioned + habsSanctioned;
						totWorksComp = totWorksComp + worksComp;
						totHabsCov = totHabsCov + habsCov;
						totExpUptoLFY = totExpUptoLFY + bankLastYear + paoLastYear;
						totExpUptoLM = totExpUptoLM + bankLastMonth + paoLastMonth;
						totExpDM = totExpDM + bankCurrentMonth + paoCurrentMonth;
						totTotExp = totExpUptoLM + totExpDM;
						totWorksPhyCompNotFin = totWorksPhyCompNotFin + worksPhyCompNotFin;
						totExpPhyCompNotFin = totExpPhyCompNotFin + bankPhyCompNotFin + paoPhyCompNotFin;
						totarfc=totarfc+arfc;
					}
					stmt.close();
					rs.close();
			%>
			<tr>
				<td class="gridhdbg" style="text-align: right;" colspan=2>Total:</td>
				<td class="gridhdbg" style="text-align: right;"><%=totNoOfWorks%></td>
				
				<td class="gridhdbg" style="text-align: right;"><%=totHabsSanctioned%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
				
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpUptoLM / 100000)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpDM / 100000)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totarfc)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=totWorksComp%></td>
				<td class="gridhdbg" style="text-align: right;"><%=totHabsCov%></td>
				<td class="gridhdbg" style="text-align: right;"><%=totWorksPhyCompNotFin%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpPhyCompNotFin/100000)%></td>
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
		<%@ include file="/commons/rws_footer.jsp"%>
</BODY>

