<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%
String schemes = "'01','02','03','10'";
DecimalFormat ndf = new DecimalFormat("####.00");
String populationType = request.getParameter("populationType");
String coc = request.getParameter("coc");
String con = request.getParameter("con");
String doc = request.getParameter("doc");
String don = request.getParameter("don");
String mode = "";
if (request.getParameter("mode") != null)
	mode = request.getParameter("mode");
//System.out.println("mode"+mode);
String programme = request.getParameter("programme");
String programmeName=request.getParameter("programmeName");
WorksData1 data1 = new WorksData1();
int cyear = Calendar.getInstance().get(Calendar.YEAR);
int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
int nmonth= Calendar.getInstance().get(Calendar.MONTH) +2;
int lMonth = Calendar.getInstance().get(Calendar.MONTH);
int day = Calendar.getInstance().get(Calendar.DATE);
String currentMonth = data1.getCurrentMonth(month);
String lastMonth = "";
if (currentMonth.equals("JAN")) {
	lastMonth = "DEC-" + (cyear - 1);
} else {
	lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
}
String nextMonth="";
if (currentMonth.equals("DEC")) {
	nextMonth = "JAN-" + (cyear + 1);
} else {
	nextMonth = data1.getCurrentMonth(nmonth) + "-" + cyear;
}
String cDate = day + "-" + currentMonth + "-" + cyear;
int yearStart = 0;
int yearEnd = 0;
int nextYear=0;
/* if (month <= 3) {
	yearStart = cyear - 1;
	yearEnd = cyear;
} else {
	yearStart = cyear;
	yearEnd = cyear + 1;
} */
yearStart=Integer.parseInt( request.getParameter("yearStart"));
yearEnd=Integer.parseInt(request.getParameter("yearEnd"));
String selectMonth=request.getParameter("selectMonth");
nextYear = yearEnd+1;
%>
<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>
<body>
<br/><br/><br />
	<center>
		<font color="#663899" face="Maiandra GD" size="4px"><b>Progress Report (Key Performance Indicators-Extended Report)</b> <br />
			<b>Programme: <%=programmeName %>&nbsp;</br>
			<%if(mode.equals("divisions")){ %>
			  Circle: <%=request.getParameter("cname") %>
			<%}else if(mode.equals("subdivisions")){  %>
			, Circle: <%=request.getParameter("cname") %>
			 , Division: <%=request.getParameter("divname") %>
			<%} %></b></font>
	</center>
	<br/><br/><br/>
	<table align="center"
		style="margin-top: -45px !important; width: 800px !important; text-align: center !important;">
		<tr>
			<td style="width: 1000px !important; text-align: right !important;">
				<font color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font>
			</td>
			<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img
						src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
			</td>
			<!-- <td style="width: 40px !important;">
                   <a href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Bar"  style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a></td>
               <td style="width: 50px !important; text-align: right !important">
				 <a	href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Pie" style="color: green !important; font-size: 13px;"
				id="showGraph"><img width="30px" src="/pred/resources/graphs/pie.png"></a> &nbsp;&nbsp;
			</td> -->
		</tr>
	</table>
	<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px" bordercolor=#000000 style="border-collapse: collapse; margin-top: 20px !important;" bgcolor="#ffffff" align="center">
			<tr align=center align=center>
				<td class=btext rowspan=3>Sl.No</td>
				<%if(mode.equals("circles")){ %>
				<td class=btext rowspan=3>Circle</td>
				<%}else if(mode.equals("divisions")){ %>
				<td class=btext rowspan=3>Division</td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class=btext rowspan=3>Sub Division</td>
				<%} %>
				<td class=btext rowspan=3>Total Works</td>
				<td class=btext rowspan=3>Est.cost</td>
				<td class=btext rowspan=3>Cum. Exp. Upto 31.3.<%=yearStart %></td>
				<td class=btext rowspan=3>Bal Est Cost as on 1.4.<%=yearStart %></td>
				<td class=btext rowspan=3>Exp. During month</td>
				<td class=btext rowspan=3>Exp. During year</td>
				<td class=btext rowspan=3>Total Exp. Including Physically completed but financially not completed before by 31.3.<%=yearStart %></td>
				<td class=btext colspan=8>Habs Sanctioned</td>
				<td class=btext rowspan=3>Works Targeted(<%=yearStart %>-<%=yearEnd%>)</td>
				<td class=btext rowspan=3>Works completed(<%=yearStart %>-<%=yearEnd%>)</td>
				<td class=btext colspan=8>Habs Targeted (<%=yearStart %>-<%=yearEnd%>)</td>
				<td class=btext colspan=8>Achievements(<%=yearStart %>-<%=yearEnd%>)</td>
				<td class=btext colspan=8>Habs Targeted (<%=yearEnd%>-<%=nextYear %>)</td>
			</tr>
			<tr align=center >
				<td class=btext rowspan=2>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=2>QA</td>
				<td class=btext rowspan=2>Total</td>
				<td class=btext rowspan=2>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=2>QA</td>
				<td class=btext rowspan=2>Total</td>
				<td class=btext rowspan=2>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=2>QA</td>
				<td class=btext rowspan=2>Total</td>
				<td class=btext rowspan=2>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=2>QA</td>
				<td class=btext rowspan=2>Total</td>				
			</tr>
			<tr align=center >
				<td class=btext rowspan=1>PC4</td>
				<td class=btext rowspan=1>PC3</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>NC</td>
				<td class=btext rowspan=1>PC4</td>
				<td class=btext rowspan=1>PC3</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>NC</td>
				<td class=btext rowspan=1>PC4</td>
				<td class=btext rowspan=1>PC3</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>NC</td>
				<td class=btext rowspan=1>PC4</td>
				<td class=btext rowspan=1>PC3</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>NC</td>				
			</tr>
		<%
		int styleCount = 0;
		String style = "";
		Statement stmt1 = null;
		ResultSet rs1 = null;
		int slno = 0;
		String ccode = "",c_query="";
        String divCode = "";
        String cname = "";
        String divName = "";
        String subdivCode = "";
        String subdivName = "";
        int tot_works=0,tot_targetWorks=0,tot_compWorks=0;
		int tot_sanPC4Habs=0,tot_sanPC3Habs=0,tot_sanPC2Habs=0,tot_sanPC1Habs=0,tot_sanNCHabs=0,tot_sanFCHabs=0,tot_sanQAHabs=0,tot_sanHabs=0;
		int tot_tarPC4Habs=0,tot_tarPC3Habs=0,tot_tarPC2Habs=0,tot_tarPC1Habs=0,tot_tarNCHabs=0,tot_tarFCHabs=0,tot_tarQAHabs=0,tot_tarHabs=0;
		int tot_achCYPC4Habs=0,tot_achCYPC3Habs=0,tot_achCYPC2Habs=0,tot_achCYPC1Habs=0,tot_achCYNCHabs=0,tot_achCYFCHabs=0,tot_achCYQAHabs=0,tot_achCYHabs=0;
		int tot_tarNYPC4Habs=0,tot_tarNYPC3Habs=0,tot_tarNYPC2Habs=0,tot_tarNYPC1Habs=0,tot_tarNYNCHabs=0,tot_tarNYFCHabs=0,tot_tarNYQAHabs=0,tot_tarNYHabs=0;
		Double tot_EstCost=0.0,tot_amountLFI=0.0,tot_amountBAL=0.0,tot_amountPhyCompNotFin=0.0,tot_expCMAmt=0.0,tot_expBMAmt=0.0;
        if(mode.equals("divisions")){
	        ccode = request.getParameter("ccode");
	        cname = request.getParameter("cname");
        }
          if(mode.equals("subdivisions")){
	        ccode = request.getParameter("ccode");
	        cname = request.getParameter("cname");
	        divCode = request.getParameter("divCode");
        }
		try{
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
        	  int works = 0,targetWorks=0,compWorks=0;
				int sanFCHabs=0,sanPC4Habs=0,sanPC3Habs=0,sanPC2Habs=0,sanPC1Habs=0,sanNCHabs=0,sanHabs=0,sanQAHabs=0;
				int tarFCHabs=0,tarPC4Habs=0,tarPC3Habs=0,tarPC2Habs=0,tarPC1Habs=0,tarNCHabs=0,tarHabs=0,tarQAHabs=0;
				int tarNYFCHabs=0,tarNYPC4Habs=0,tarNYPC3Habs=0,tarNYPC2Habs=0,tarNYPC1Habs=0,tarNYNCHabs=0,tarNYHabs=0,tarNYQAHabs=0;
				int achCYFCHabs=0,achCYPC4Habs=0,achCYPC3Habs=0,achCYPC2Habs=0,achCYPC1Habs=0,achCYNCHabs=0,achCYHabs=0,achCYQAHabs=0;
				double EstCost=0.0,bankLastYear = 0.0,paoLastYear = 0.0,bankPhyCompNotFin=0.0,paoPhyCompNotFin=0.0;
				double bankCMAmt=0.0,paoCMAmt=0.0,expCMAmt=0.0,bankBMAmt=0.0,paoBMAmt=0.0,expBMAmt=0.0;
        	  if(mode.equals("circles")){
                  cname=res.getString("circle_office_name");
              	  ccode=res.getString("circle_office_code");
              }
              if(mode.equals("divisions")){
				divCode=res.getString("division_office_code");
				divName=res.getString("division_office_name");
			  }
			if(mode.equals("subdivisions")){
				subdivCode=res.getString("subdivision_office_code");
				subdivName=res.getString("subdivision_office_name");
			}
			    if (styleCount % 2 == 0) {
			        style = "gridbg1";
				} else {
					style = "gridbg2";
				}
				styleCount++;         
				String worksQuery="select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
						+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
						+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
						+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
			if(mode.equals("circles")){ 
				worksQuery+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				worksQuery+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				worksQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(worksQuery);
			if (rs1.next()) {
				works=rs1.getInt(2);
				EstCost=rs1.getDouble(1);
			}
			stmt1.close();
			rs1.close();
			String bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                    + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                    + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and TO_DATE(BANK_SEND_DATE)<='31-MAR-" + yearStart + "' "
                    + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
			if(mode.equals("circles")){ 
				bankLFI+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				bankLFI+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				bankLFI+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
        stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(bankLFI);
        if (rs1.next()) {
            bankLastYear = rs1.getDouble(1);
        }
        stmt1.close();
        rs1.close();
        String paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and TO_DATE(STATE_SEND_DATE)<='31-MAR-" + yearStart + "' "
                + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
        if(mode.equals("circles")){ 
        	paoLFI+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			paoLFI+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			paoLFI+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
         stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(paoLFI);
        if (rs1.next()) {
            paoLastYear = rs1.getDouble(1);
        }
        stmt1.close();
        rs1.close();
        Double amountLFI = bankLastYear + paoLastYear;
        Double amountBAL =(EstCost*100000)-(bankLastYear + paoLastYear);
        String bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
        if(!selectMonth.equals("JAN") && !selectMonth.equals("FEB") && !selectMonth.equals("MAR") ){
     	   bankCM+=" and to_char(BANK_SEND_DATE,'MON-YYYY')='"+selectMonth+"-" + yearStart + "' " ;
        }else{
     	   bankCM+=" and to_char(BANK_SEND_DATE,'MON-YYYY')='"+selectMonth+"-" + yearEnd + "' " ;
        }
     	 bankCM+= " and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";       
                             
        if(mode.equals("circles")){ 
        	bankCM+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			bankCM+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			bankCM+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
        stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(bankCM);
        if (rs1.next()) {
        	bankCMAmt = rs1.getDouble(1);
        }
        stmt1.close();
        rs1.close();
        String paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
        
        if(!selectMonth.equals("JAN") && !selectMonth.equals("FEB") && !selectMonth.equals("MAR") ){
        	paoCM+=" and to_char(STATE_SEND_DATE,'MON-YYYY')='"+selectMonth+"-" + yearStart + "' " ;
        }else{
        	paoCM+=" and to_char(STATE_SEND_DATE,'MON-YYYY')='"+selectMonth+"-" + yearEnd + "' " ;
        }          		
        paoCM+= " and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
               
        if(mode.equals("circles")){ 
        	paoCM+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			paoCM+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			paoCM+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
        stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(paoCM);
        if (rs1.next()) {
        	paoCMAmt = rs1.getDouble(1);
        }
        stmt1.close();
        rs1.close();
        expCMAmt = bankCMAmt + paoCMAmt ;
        String bankDY = "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
				+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and a.TYPE_OF_ASSET in (" + schemes + ") and TO_DATE(BANK_SEND_DATE)>='01-APR-" + yearStart + "'  and TO_DATE(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
				+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
				+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
				+" and target_date_comp>='01-APR-" + yearStart + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "')";
        if(mode.equals("circles")){ 
        	bankDY+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			bankDY+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			bankDY+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
        stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(bankDY);
        if (rs1.next()) {
        	bankBMAmt = rs1.getDouble(1);
        }
        stmt1.close();
        rs1.close();
        String paoDY = "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
    			+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    			+ " and a.TYPE_OF_ASSET in (" + schemes + ") and TO_DATE(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and TO_DATE(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
    			+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    			+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
    			+" and target_date_comp>='01-APR-" + yearStart + "' AND a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "')";
        if(mode.equals("circles")){ 
        	paoDY+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			paoDY+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			paoDY+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
        stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(paoDY);
        if (rs1.next()) {
        	paoBMAmt = rs1.getDouble(1);
        }
        stmt1.close();
        rs1.close();
        expBMAmt = bankBMAmt + paoBMAmt ;
        String phyCompNotFinBank= "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
				+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and a.TYPE_OF_ASSET in (" + schemes + ") and TO_DATE(BANK_SEND_DATE)>='01-APR-" + yearStart + "'  and TO_DATE(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
				+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
				+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
        if(mode.equals("circles")){ 
        	phyCompNotFinBank+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			phyCompNotFinBank+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			phyCompNotFinBank+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
        stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(phyCompNotFinBank);
        if (rs1.next()) {
            bankPhyCompNotFin = rs1.getDouble(1);
        }
        stmt1.close();
        rs1.close();
        String phyCompNotFinPAO ="select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
				+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and a.TYPE_OF_ASSET in (" + schemes + ") and TO_DATE(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and TO_DATE(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
				+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
				+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
        if(mode.equals("circles")){ 
        	phyCompNotFinPAO+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			phyCompNotFinPAO+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			phyCompNotFinPAO+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
        stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(phyCompNotFinPAO);
        if (rs1.next()) {
            paoPhyCompNotFin = rs1.getDouble(1);
        }
        stmt1.close();
        rs1.close();
        Double amountPhyCompNotFin = bankPhyCompNotFin + paoPhyCompNotFin;
        String sanFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
        	sanFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	sanFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	sanFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(mode.equals("circles")){ 
        	sanFCHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			sanFCHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			sanFCHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
      //	System.out.println("habsSanQuery :- "+ sanFCHabQry);
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(sanFCHabQry);
		if (rs1.next()) {
			sanFCHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close(); 
		String sanPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			sanPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	sanPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	sanPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		 if(mode.equals("circles")){ 
			 sanPC4HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				sanPC4HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				sanPC4HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(sanPC4HabQry);
		if (rs1.next()) {
			sanPC4Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String sanPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			sanPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	sanPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	sanPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
				sanPC3HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				sanPC3HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				sanPC3HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(sanPC3HabQry);
		if (rs1.next()) {
			sanPC3Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String sanPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			sanPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	sanPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	sanPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			sanPC2HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			sanPC2HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			sanPC2HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(sanPC2HabQry);
		if (rs1.next()) {
			sanPC2Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String sanPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			sanPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	sanPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	sanPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			sanPC1HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			sanPC1HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			sanPC1HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(sanPC1HabQry);
		if (rs1.next()) {
			sanPC1Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String sanNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			sanNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	sanNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	sanNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			sanNCHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			sanNCHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			sanNCHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(sanNCHabQry);
		if (rs1.next()) {
			sanNCHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String sanQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			sanQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	sanQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	sanQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);		
		if(mode.equals("circles")){ 
			sanQAHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			sanQAHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			sanQAHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(sanQAHabQry);
		if (rs1.next()) {
			sanQAHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String sanHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS <>'UI'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			sanHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	sanHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	sanHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			sanHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			sanHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			sanHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(sanHabQry);
		if (rs1.next()) {
			sanHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String targetworksQuery="select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null"; 
		if(!selectMonth.equals("JAN") && !selectMonth.equals("FEB") && !selectMonth.equals("MAR") ){
			targetworksQuery+=" and DATE_OF_COMPLETION<=LAST_DAY(to_date('"+selectMonth+"-" + yearStart + "','MON-YYYY')) " ;
        }else{
        	targetworksQuery+=" and DATE_OF_COMPLETION<=LAST_DAY(to_date('"+selectMonth+"-" + yearEnd + "','MON-YYYY')) " ;
        }       	
			
		targetworksQuery+=")  and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and "
				+" '31-MAR-"+yearEnd+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			targetworksQuery+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			targetworksQuery+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			targetworksQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(targetworksQuery);
		if (rs1.next()) {
			targetWorks=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String compworksQuery="select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
				+"where  WORK_CANCEL_DT is null and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
				+"a.work_id  in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION>='01-APR-"+yearStart+"') and TARGET_DATE_COMP > '01-APR-"+yearStart+"' and "
				+" ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			compworksQuery+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			compworksQuery+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			compworksQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(compworksQuery);
		if (rs1.next()) {
			compWorks=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and TARGET_DATE_COMP<='31-MAR"+yearEnd+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ sanFCHabQry);
		if(mode.equals("circles")){ 
			tarFCHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarFCHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarFCHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarFCHabQry);
		if (rs1.next()) {
			tarFCHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close(); 
		String tarPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and TARGET_DATE_COMP<='31-MAR"+yearEnd+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarPC4HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarPC4HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarPC4HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarPC4HabQry);
		if (rs1.next()) {
			tarPC4Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and TARGET_DATE_COMP<='31-MAR"+yearEnd+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarPC3HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarPC3HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarPC3HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarPC3HabQry);
		if (rs1.next()) {
			tarPC3Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and TARGET_DATE_COMP<='31-MAR"+yearEnd+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarPC2HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarPC2HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarPC2HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarPC2HabQry);
		if (rs1.next()) {
			tarPC2Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and TARGET_DATE_COMP<='31-MAR"+yearEnd+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarPC1HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarPC1HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarPC1HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarPC1HabQry);
		if (rs1.next()) {
			tarPC1Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and TARGET_DATE_COMP<='31-MAR"+yearEnd+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarNCHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNCHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNCHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNCHabQry);
		if (rs1.next()) {
			tarNCHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and TARGET_DATE_COMP<='31-MAR"+yearEnd+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarQAHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarQAHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarQAHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarQAHabQry);
		if (rs1.next()) {
			tarQAHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and TARGET_DATE_COMP<='31-MAR"+yearEnd+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarHabQry);
		if (rs1.next()) {
			tarHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarNYFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+yearEnd+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNYFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNYFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNYFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ sanFCHabQry);
		if(mode.equals("circles")){ 
			tarNYFCHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNYFCHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNYFCHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNYFCHabQry);
		if (rs1.next()) {
			tarNYFCHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close(); 
		String tarNYPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+yearEnd+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNYPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNYPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNYPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarNYPC4HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNYPC4HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNYPC4HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNYPC4HabQry);
		if (rs1.next()) {
			tarNYPC4Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarNYPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+yearEnd+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNYPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNYPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNYPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarNYPC3HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNYPC3HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNYPC3HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNYPC3HabQry);
		if (rs1.next()) {
			tarNYPC3Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarNYPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+yearEnd+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNYPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNYPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNYPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarNYPC2HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNYPC2HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNYPC2HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNYPC2HabQry);
		if (rs1.next()) {
			tarNYPC2Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarNYPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+yearEnd+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNYPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNYPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNYPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarNYPC1HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNYPC1HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNYPC1HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNYPC1HabQry);
		if (rs1.next()) {
			tarNYPC1Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarNYNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+yearEnd+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNYNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNYNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNYNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarNYNCHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNYNCHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNYNCHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNYNCHabQry);
		if (rs1.next()) {
			tarNYNCHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarNYQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
			    +"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+yearEnd+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNYQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNYQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNYQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarNYQAHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNYQAHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNYQAHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNYQAHabQry);
		if (rs1.next()) {
			tarNYQAHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String tarNYHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
						+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+yearEnd+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			tarNYHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	tarNYHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	tarNYHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			tarNYHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			tarNYHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			tarNYHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(tarNYHabQry);
		if (rs1.next()) {
			tarNYHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String achCYFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION<='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+yearStart+"' and partial_date_of_completion <='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			achCYFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	achCYFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	achCYFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ sanFCHabQry);
		if(mode.equals("circles")){ 
			achCYFCHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			achCYFCHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			achCYFCHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(achCYFCHabQry);
		if (rs1.next()) {
			achCYFCHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close(); 
		String achCYPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION<='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+yearStart+"' and partial_date_of_completion <='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			achCYPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	achCYPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	achCYPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			achCYPC4HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			achCYPC4HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			achCYPC4HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(achCYPC4HabQry);
		if (rs1.next()) {
			achCYPC4Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String achCYPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION<='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+yearStart+"' and partial_date_of_completion <='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			achCYPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	achCYPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	achCYPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			achCYPC3HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			achCYPC3HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			achCYPC3HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(achCYPC3HabQry);
		if (rs1.next()) {
			achCYPC3Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String achCYPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION<='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+yearStart+"' and partial_date_of_completion <='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			achCYPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	achCYPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	achCYPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			achCYPC2HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			achCYPC2HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			achCYPC2HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(achCYPC2HabQry);
		if (rs1.next()) {
			achCYPC2Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String achCYPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION<='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+yearStart+"' and partial_date_of_completion <='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			achCYPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	achCYPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	achCYPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			achCYPC1HabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			achCYPC1HabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			achCYPC1HabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(achCYPC1HabQry);
		if (rs1.next()) {
			achCYPC1Habs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String achCYNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION<='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+yearStart+"' and partial_date_of_completion <='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			achCYNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	achCYNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	achCYNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			achCYNCHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			achCYNCHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			achCYNCHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(achCYNCHabQry);
		if (rs1.next()) {
			achCYNCHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String achCYQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION<='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+yearStart+"' and partial_date_of_completion <='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			achCYQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	achCYQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	achCYQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			achCYQAHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			achCYQAHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			achCYQAHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(achCYQAHabQry);
		if (rs1.next()) {
			achCYQAHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		String achCYHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
				+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
				+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION<='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+yearStart+"' and partial_date_of_completion <='31-MAR-"+yearEnd+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
				+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
		if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
			achCYHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}	
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
        	achCYHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}
        if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
        	achCYHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
		}//System.out.println("habsSanQuery :- "+ habsSanQuery);
		if(mode.equals("circles")){ 
			achCYHabQry+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			achCYHabQry+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			achCYHabQry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(achCYHabQry);
		if (rs1.next()) {
			achCYHabs=rs1.getInt(1);						
		}
		stmt1.close();
		rs1.close();
		tot_works+=works;
		tot_EstCost+=EstCost;
		tot_amountLFI+=amountLFI;
		tot_amountBAL+=amountBAL;
		tot_expCMAmt+=expCMAmt;
		tot_expBMAmt+=expBMAmt;
		tot_amountPhyCompNotFin+=amountPhyCompNotFin;
		tot_sanFCHabs+=sanFCHabs;
		tot_sanPC4Habs+=sanPC4Habs;
		tot_sanPC3Habs+=sanPC3Habs;
		tot_sanPC2Habs+=sanPC2Habs;
		tot_sanPC1Habs+=sanPC1Habs;
		tot_sanNCHabs+=sanNCHabs;
		tot_sanQAHabs+=sanQAHabs;
		tot_sanHabs+=sanHabs;
		tot_tarFCHabs+=tarFCHabs;
		tot_tarPC4Habs+=tarPC4Habs;
		tot_tarPC3Habs+=tarPC3Habs;
		tot_tarPC2Habs+=tarPC2Habs;
		tot_tarPC1Habs+=tarPC1Habs;
		tot_tarNCHabs+=tarNCHabs;
		tot_tarQAHabs+=tarQAHabs;
		tot_tarHabs+=tarHabs;
		tot_tarNYFCHabs+=tarNYFCHabs;
		tot_tarNYPC4Habs+=tarNYPC4Habs;
		tot_tarNYPC3Habs+=tarNYPC3Habs;
		tot_tarNYPC2Habs+=tarNYPC2Habs;
		tot_tarNYPC1Habs+=tarNYPC1Habs;
		tot_tarNYNCHabs+=tarNYNCHabs;
		tot_tarNYQAHabs+=tarNYQAHabs;
		tot_tarNYHabs+=tarNYHabs;
		tot_achCYFCHabs+=achCYFCHabs;
		tot_achCYPC4Habs+=achCYPC4Habs;
		tot_achCYPC3Habs+=achCYPC3Habs;
		tot_achCYPC2Habs+=achCYPC2Habs;
		tot_achCYPC1Habs+=achCYPC1Habs;
		tot_achCYNCHabs+=achCYNCHabs;
		tot_achCYQAHabs+=achCYQAHabs;
		tot_achCYHabs+=achCYHabs;
		tot_targetWorks+=targetWorks;
		tot_compWorks+=compWorks;
		 if(works == 0&&targetWorks==0&&compWorks==0&&
			sanFCHabs==0&&sanPC4Habs==0&&sanPC3Habs==0&&sanPC2Habs==0&&sanPC1Habs==0&&sanNCHabs==0&&sanHabs==0&&sanQAHabs==0&&
			tarFCHabs==0&&tarPC4Habs==0&&tarPC3Habs==0&&tarPC2Habs==0&&tarPC1Habs==0&&tarNCHabs==0&&tarHabs==0&&tarQAHabs==0&&
			tarNYFCHabs==0&&tarNYPC4Habs==0&&tarNYPC3Habs==0&&tarNYPC2Habs==0&&tarNYPC1Habs==0&&tarNYNCHabs==0&&tarNYHabs==0&&tarNYQAHabs==0&&
			achCYFCHabs==0&&achCYPC4Habs==0&&achCYPC3Habs==0&&achCYPC2Habs==0&&achCYPC1Habs==0&&achCYNCHabs==0&&achCYHabs==0&&achCYQAHabs==0&&
			EstCost==0.0&&bankLastYear == 0.0&&paoLastYear == 0.0&&bankPhyCompNotFin==0.0&&paoPhyCompNotFin==0.0&&
			bankCMAmt==0.0&&paoCMAmt==0.0&&expCMAmt==0.0&&bankBMAmt==0.0&&paoBMAmt==0.0&&expBMAmt==0.0){
		}else{ 
			%>
		<tr>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_key_per_extend_div_subdiv_rpt.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>"><%=cname%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_key_per_extend_div_subdiv_rpt.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>"><%=divName%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
			<%} 
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=total&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=works %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=total&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=works %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=total&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=works %></a></td>
			<%}%>	
		    <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(EstCost)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountLFI/100000)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountBAL/100000)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expCMAmt/100000) %></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expBMAmt/100000)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountPhyCompNotFin/100000)%></td>
		  	<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=sanFCHabs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=sanFCHabs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=sanFCHabs %></a></td>
			<%} 	
			 if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=sanPC4Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=sanPC4Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=sanPC4Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=sanPC3Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=sanPC3Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=sanPC3Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=sanPC2Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=sanPC2Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=sanPC2Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=sanPC1Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=sanPC1Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=sanPC1Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=sanNCHabs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=sanNCHabs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=sanNCHabs %></a></td>
			<%}
			%>			
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=sanQAHabs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=sanQAHabs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=sanQAHabs%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=san&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=sanHabs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=san&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=sanHabs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=san&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=sanHabs%></a></td>
			<%}%>			
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=targeted&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=targetWorks%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=targeted&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=targetWorks%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=targeted&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=targetWorks%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=completed&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=compWorks%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=completed&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=compWorks%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=completed&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=compWorks%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarFCHabs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarFCHabs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarFCHabs %></a></td>
			<%} 	
			 if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarPC4Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarPC4Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarPC4Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarPC3Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarPC3Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarPC3Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarPC2Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarPC2Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarPC2Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarPC1Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarPC1Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarPC1Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNCHabs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNCHabs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNCHabs %></a></td>
			<%}
			%>			
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarQAHabs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarQAHabs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarQAHabs%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tar&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarHabs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tar&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarHabs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tar&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarHabs%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=achCYFCHabs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=achCYFCHabs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=achCYFCHabs %></a></td>
			<%} 	
			 if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=achCYPC4Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=achCYPC4Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=achCYPC4Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=achCYPC3Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=achCYPC3Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=achCYPC3Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=achCYPC2Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=achCYPC2Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=achCYPC2Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=achCYPC1Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=achCYPC1Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=achCYPC1Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=achCYNCHabs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=achCYNCHabs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=achCYNCHabs %></a></td>
			<%}
			%>			
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=achCYQAHabs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=achCYQAHabs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=achCYQAHabs%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCY&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=achCYHabs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCY&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=achCYHabs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCY&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=achCYHabs%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNYFCHabs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNYFCHabs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNYFCHabs %></a></td>
			<%} 	
			 if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNYPC4Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNYPC4Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNYPC4Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNYPC3Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNYPC3Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNYPC3Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNYPC2Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNYPC2Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNYPC2Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNYPC1Habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNYPC1Habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNYPC1Habs %></a></td>
			<%}
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNYNCHabs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNYNCHabs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNYNCHabs %></a></td>
			<%}
			%>			
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNYQAHabs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNYQAHabs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNYQAHabs%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNY&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tarNYHabs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNY&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tarNYHabs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNY&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=tarNYHabs%></a></td>
			<%}%>			
			
		</tr>
		<%}}%>
		<tr >
			<td class="btext" style="text-align: right;" colspan="2">Total </td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_works%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_EstCost)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountLFI/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountBAL/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_expCMAmt/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_expBMAmt/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountPhyCompNotFin/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_sanFCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_sanPC4Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_sanPC3Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_sanPC2Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_sanPC1Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_sanNCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_sanQAHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_sanHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_targetWorks%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_compWorks%>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarFCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarPC4Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarPC3Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarPC2Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarPC1Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarQAHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCYFCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCYPC4Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCYPC3Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCYPC2Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCYPC1Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCYNCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCYQAHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCYHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYFCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYPC4Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYPC3Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYPC2Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYPC1Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYNCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYQAHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYHabs%></td>
						
		</tr>
		<%	
		}catch (Exception e) {
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
		</body>
</html>