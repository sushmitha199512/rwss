<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>

<%@ include file="/reports/conn.jsp"%>
<%
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "inline; filename="
			+ "Work_Progress_Abstract_Report.xls");
%>
<%
	DecimalFormat ndf = new DecimalFormat("####.00");

	String rDistrict = "";
	String finyear = "";

	rDistrict = session.getAttribute("rDistrict").toString();
	

	String dname = session.getAttribute("dname").toString();
	

	String programe = session.getAttribute("programe").toString();
	
	finyear = session.getAttribute("finyear").toString();
	

	String startyr = finyear.substring(0, 4);

	String endyr = finyear.substring(5, 9);
	
	
	WorksData1 data1=new WorksData1();
	int cyear = Calendar.getInstance().get(Calendar.YEAR);
    int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
    int lMonth = Calendar.getInstance().get(Calendar.MONTH);
    int day = Calendar.getInstance().get(Calendar.DATE);
    String currentMonth=data1.getCurrentMonth(month);
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
%>
<BODY>
	<form name=f1 method="post">


		<table border=1 cellspacing=0 cellpadding=0 height=5% width="100%"
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" align="center">

			<tr align=center align=center>
				<td class="gridhdbg" colspan="12"><b>Work Progress Abstract
						Report for <%=finyear %></b></td>
			<tr align=center align=center>
				<td class=gridhdbg rowspan=2>Sl.No</td>
				<td class=gridhdbg rowspan=2>District</td>
				<td class=gridhdbg rowspan=2>Programme</td>
				<td class=gridhdbg rowspan=2>No. of Works</td>
				<td class=gridhdbg rowspan=2>Est. Cost</td>
				<td class=gridhdbg rowspan=2>Habs Sanctioned</td>
				<td class=gridhdbg rowspan=2>Works completed</td>
				<td class=gridhdbg rowspan=2>Habs Coved</td>
				<td class=gridhdbg rowspan=2>Exp. Upto Last Financial Year <br>(<%=(yearStart-1) %>-<%=(yearEnd-1) %>)</td>
				<td colspan=3 class=gridhdbg align="center">Exp. During the
					Financial Year <br>(<%=yearStart %>-<%=yearEnd %>)</td>

			</tr>
			<tr>
				<td colspan=1 class=gridhdbg align="center">Exp. Upto Last
					Month (<%=lastMonth %>)</td>
				<td colspan=1 class=gridhdbg align="center">Exp. During the
					Month (<%=currentMonth %>-<%=cyear %>)</td>
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
					int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0;
					double totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0;
					String query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),d.dname,p.PROGRAMME_NAME,d.dcode,a.programme_code from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE";
					if (rDistrict != null && !rDistrict.equals("00")) {
						query += " and d.dcode='" + rDistrict + "'";
					}
					query += " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programe
							+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  group by dname,p.PROGRAMME_NAME,d.dcode,a.programme_code  order by d.dcode,a.programme_code";
					stmt = conn.createStatement();
					rs = stmt.executeQuery(query);
					System.out.println("main query"+query);
					while (rs.next()) {

						double estCost = 0, bankLastYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoLastYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
						int noOfWorks = 0, habsSanctioned = 0, worksComp = 0, habsCov = 0;
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
				<td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
				<td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=noOfWorks%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=estCost%></td>
				<%
					String sacHabs = "select count(b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  and substr(a.WORK_ID,5,2)='"
									+ rs.getString(5)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code='"
									+ rs.getString(6) + "'";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(sacHabs);
							System.out.println("sacHabs"+sacHabs);
							if (rs1.next()) {
								habsSanctioned = rs1.getInt(1);
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSanctioned%></td>
				<%
					}
							stmt1.close();
							rs1.close();
				%>

				<%
					String compWorks = "select count(a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(5)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null) and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code='"
									+ rs.getString(6)
									+ "' and b.DATE_OF_COMPLETION is not null";

							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(compWorks);
							System.out.println("compWorks"+compWorks);
							if (rs1.next()) {
								worksComp = rs1.getInt(1);
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=worksComp%></td>
				<%
					}
							stmt1.close();
							rs1.close();
				%>


				<%
					String covHabs = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(5)
									+ "'   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code='"
									+ rs.getString(6)
									+ "' and b.DATE_OF_COMPLETION is not null";

							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(covHabs);
							System.out.println("covHabs"+covHabs);
							if (rs1.next()) {
								habsCov = rs1.getInt(1);
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCov%></td>
				<%
					}
							stmt1.close();
							rs1.close();
							//Integer lfy = (Integer.parseInt(endyr) - 1);
				%>
				<%
					String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(5)
									+ "' and a.programme_code='"
									+ rs.getString(6)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-"
									+ (yearEnd-1) + "'";

							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(bankLFY);
							System.out.println("bankLFY"+bankLFY);
							if (rs1.next()) {
								bankLastYear = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();

							String paoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(5)
									+ "' and a.programme_code='"
									+ rs.getString(6)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null)  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-"
									+ (yearEnd-1) + "'";

							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(paoFLY);
							System.out.println("paoFLY"+paoFLY);
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
									+ rs.getString(5)
									+ "' and a.programme_code='"
									+ rs.getString(6)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>='01-APR-"
									+ yearStart
									+ "' and BANK_SEND_DATE<'01-"
									+ currentMonth + "-" + yearEnd + "'";

							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(bankUptoLastMonth);
							System.out.println("bankUptoLastMonth"+bankUptoLastMonth);
							if (rs1.next()) {
								bankLastMonth = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();

							String paoUptoLastMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(5)
									+ "' and a.programme_code='"
									+ rs.getString(6)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>='01-APR-"
									+ yearStart
									+ "' and STATE_SEND_DATE<'01-"
									+ currentMonth + "-" + yearEnd + "'";

							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(paoUptoLastMonth);
							System.out.println("paoUptoLastMonth"+paoUptoLastMonth);
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
									+ rs.getString(5)
									+ "' and a.programme_code='"
									+ rs.getString(6)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and BANK_SEND_DATE>='01-"
									+ currentMonth
									+ "-"
									+ cyear
									+ "' and BANK_SEND_DATE<='" + cDate + "'";

							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(bankcurrMonth);
							System.out.println("bankcurrMonth"+bankcurrMonth);
							if (rs1.next()) {
								bankCurrentMonth = rs1.getDouble(1);

							}
							stmt1.close();
							rs1.close();

							String paocurrMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
									+ rs.getString(5)
									+ "' and a.programme_code='"
									+ rs.getString(6)
									+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>='01-"
									+ currentMonth
									+ "-"
									+ cyear
									+ "' and STATE_SEND_DATE<='" + cDate + "'";
									
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(paocurrMonth);
							System.out.println("paocurrMonth"+paocurrMonth);
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
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=finalamountCurrentMonth%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=finalTotalFY%></td>


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
					}
					stmt.close();
					rs.close();
			%>
			<tr>
				<td class="gridhdbg" style="text-align: right;" colspan=3>Total:</td>
				<td class="gridhdbg" style="text-align: right;"><%=totNoOfWorks%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=totHabsSanctioned%></td>
				<td class="gridhdbg" style="text-align: right;"><%=totWorksComp%></td>
				<td class="gridhdbg" style="text-align: right;"><%=totHabsCov%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpUptoLM / 100000)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpDM / 100000)%></td>
				<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
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

