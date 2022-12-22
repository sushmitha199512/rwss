<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%
String schemes = "'01','02','03','10'";
DecimalFormat ndf = new DecimalFormat("####.00");
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
<br />
		<br />
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Works Progress - Physical & Financial</b></font></br><font color="#889900" face="Maiandra GD" size="3px"  > Programme :- <%=programmeName %>
			<b><%if(mode.equals("divisions")){ %>
			 , Circle: <%=request.getParameter("cname") %>
			<%}else if(mode.equals("subdivisions")){  %>
			, Circle: <%=request.getParameter("cname") %>
			 , Division: <%=request.getParameter("divname") %>
			<%} %></b></font><br/>
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
			 <td class=btext rowspan=3>No. of<br/>Works</td>
                <td class=btext rowspan=3>Est. Cost</td>
                <td class=btext rowspan=3>Habs<br/>Sanc.</td>
                <td class=btext rowspan=3>Pop<br/>Benefited</td>
                <td class=btext colspan=3>Physical Progress</td>
                <%if (month == 4) { %>
                <td class=btext colspan=4>Financial Progress</td>
                <%}else{ %>
                <td class=btext colspan=5>Financial Progress</td>
                <%} %>
                <td class=btext colspan=2>Balance Program</td>
            </tr>
            <tr>
                <td class=btext align="center" rowspan=2>Works<br/>Comp.</td>
                <td class=btext align="center" rowspan=2>Habs<br/>Covered</td>
                <td class=btext align="center" rowspan=2>Pop<br/>Covered</td>
                <td class=btext align="center" rowspan=2>Expenditure<br/>Upto<br/><%=(yearStart - 1)%>-<%=(yearEnd - 1)%></td>
               <%if (month == 4) { %>
                <td class=btext align="center" colspan=2>During the Current Year</td>
                <%}else{ %>
                <td class=btext align="center" colspan=3>During the Current Year</td>
                <%} %>
                <td class=btext align="center" rowspan=2>Total Exp<br/>Including<br/>Phy Comp But<br/>Fin. Not Comp Works</td>
                <td class=btext align="center" rowspan=2>Works</td>
                <td class=btext align="center" rowspan=2>ARFC</td>
            </tr>
            <tr>
            	<%if (month != 4) { %>
                
                <td class=btext align="center" >Upto Last Month<br/><font size="1px"><i>(<%=lastMonth%>)</i></font></td>
                <%} %>
                <td class=btext align="center" >Current Month<br/> <font size="1px"><i>(<%=currentMonth%>-<%=cyear%>)</i></font></td>
                <td class=btext align="center" >Total Exp. During <br/><%=yearStart%>-<%=yearEnd%></td>
            </tr>
		<%
		int styleCount = 0;
		String style = "";
		 Connection connection = null;
         Statement stmt1 = null;
         ResultSet rs1 = null;
         int slno = 0;
         Statement stmt2=null;
 		ResultSet rs2=null;
        
             int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totWorksPhyCompNotFin = 0;
             long totPopBenf = 0, totPopCov = 0, popBenf = 0, popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0;
             double totarfc = 0, totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, expPhyCompNotFin = 0, bankPhyCompNotFin = 0, paoPhyCompNotFin = 0, totExpPhyCompNotFin = 0, totalAmtInclPhyCompNotFin = 0;
             double arfc = 0, nrdwparfc = 0, nrdwpEstCost = 0, nrdwpExpUptoLFY = 0, nrdwpExpUptoLM = 0, nrdwpExpDM = 0, nrdwpTotExp = 0, nrdwpExpPhyCompNotFin = 0, nrdwpBankPhyCompNotFin = 0, nrdwpPaoPhyCompNotFin = 0, nrdwpTotExpPhyCompNotFin = 0, nrdwpAmtInclPhyCompNotFin = 0;
             
             String query = "";
		String ccode = "",c_query="";
        String divCode = "";
        String cname = "";
        String divName = "";
        String subdivCode = "";
        String subdivName = "";
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
        	  double estCost = 0, bankLastYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoLastYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
              int noOfWorks = 0, habsSanctioned = 0, worksComp = 0, habsCov = 0, worksPhyCompNotFin = 0;
         
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
		
				   query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                           + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                           + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                           + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                           + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
			if(mode.equals("circles")){ 
				query  = query+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				query = query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				query = query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
		//System.out.println("query"+query);	
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(query);
		if(rs1.next())
		{
			 noOfWorks = rs1.getInt(2);
             estCost = rs1.getDouble(1);
	    }
		
		rs1.close();
		stmt1.close();
		String sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                  + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                  + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			sacHabs = sacHabs+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			sacHabs = sacHabs+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			sacHabs = sacHabs+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
	  //System.out.println("hab_query"+hab_query)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(sacHabs);
		if(rs2.next()){
			 habsSanctioned = rs2.getInt(1); 
             popBenf = rs2.getLong(2);
		}
		
		rs2.close();
		stmt2.close();
		String compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ")   and b.DATE_OF_COMPLETION >= '01-APR-" + yearStart + "'  and b.DATE_OF_COMPLETION is not null and "
                + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			compWorks = compWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
		}else if(mode.equals("divisions")){
			compWorks = compWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			compWorks = compWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"; 
		}
		//System.out.println("compWorks"+compWorks)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(compWorks);
		while(rs2.next()){
			  worksComp = rs2.getInt(1);
		}
		rs2.close();
		stmt2.close();
		String comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ")  and ((b.DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion >= '01-APR-" + yearStart +"' and b.DATE_OF_COMPLETION is null)) and "
                + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			comphabs = comphabs+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
		}else if(mode.equals("divisions")){
			comphabs = comphabs+ " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"; 		
		}else if(mode.equals("subdivisions")){
			comphabs= comphabs+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("bankpaos"+comphabs)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(comphabs);
		if(rs2.next()){
			 habsCov = rs2.getInt(1);
             popCov = rs2.getLong(2);  
		}
		rs2.close();
		stmt2.close();
		String   bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                   + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                   + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE<='31-MAR-" + yearStart + "' "
                   + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			bankLFI = bankLFI+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";			
		}else if(mode.equals("divisions")){
			bankLFI = bankLFI+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			bankLFI = bankLFI+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("bankLFI"+bankLFI)	;	
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(bankLFI);
		if(rs1.next())
		{
			  bankLastYear = rs1.getDouble(1);
		}
		rs1.close();
		stmt1.close();
		 String paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                  + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                  + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE<='31-MAR-" + yearStart + "' "
                  + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			paoLFI = paoLFI+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			paoLFI = paoLFI+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			paoLFI = paoLFI+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("paoLFI"+paoLFI)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(paoLFI);
		if(rs2.next()){
			paoLastYear = rs2.getDouble(1);
		}rs2.close();
		stmt2.close();
		  String amountLFI = ndf.format((bankLastYear + paoLastYear) / 100000);
		String  bankLM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                  + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                  + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE>='01-APR-" + yearStart + "' "
                  + "and BANK_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			bankLM = bankLM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			bankLM = bankLM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			bankLM = bankLM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
//System.out.println("bankLM"+bankLM);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(bankLM);
		if(rs2.next()){
			 bankLastMonth = rs2.getDouble(1);
		}		
		rs2.close();
		stmt2.close();
		String paoLM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE>='01-APR-" + yearStart + "' "
                 + "and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		
		if(mode.equals("circles")){ 
			paoLM = paoLM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			paoLM = paoLM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			paoLM = paoLM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("paoLM"+paoLM);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(paoLM);
		while(rs2.next()){
			 paoLastMonth = rs2.getDouble(1);
		}
		rs2.close();
		stmt2.close();
		  String amountLM = ndf.format((bankLastMonth + paoLastMonth) / 100000);
		 String  bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                   + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                   + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                   + "and BANK_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			bankCM = bankCM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			bankCM = bankCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			bankCM = bankCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}		
		 //System.out.println("bankCM"+bankCM);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(bankCM);
		if(rs2.next()){
			 bankCurrentMonth = rs2.getDouble(1);
		}
		rs2.close();
		stmt2.close();
		String paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                 + "and STATE_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			paoCM=paoCM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			paoCM=paoCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			paoCM=paoCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("paoCM"+paoCM);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(paoCM);
		if(rs2.next()){
			 paoCurrentMonth = rs2.getDouble(1);
		}rs2.close();
			stmt2.close();
			String amountCM = ndf.format((bankCurrentMonth + paoCurrentMonth) / 100000);

            String amountTot = ndf.format((bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000);
			 String phyCompNotFinBank = "";
             phyCompNotFinBank =  "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and BANK_SEND_DATE>='01-APR-" + yearStart + "'"
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
			if(mode.equals("circles")){ 
				phyCompNotFinBank=phyCompNotFinBank+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
			}else if(mode.equals("divisions")){
				phyCompNotFinBank= phyCompNotFinBank+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				phyCompNotFinBank= phyCompNotFinBank+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
				//	System.out.println("fin_banksendQuery"+fin_banksendQuery);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(phyCompNotFinBank);
			while(rs2.next()){
				 bankPhyCompNotFin = rs2.getDouble(1);
			}
			rs2.close();
			stmt2.close();
			 String phyCompNotFinPAO = "";                    
             phyCompNotFinPAO = "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and STATE_SEND_DATE>='01-APR-" + yearStart + "'"
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
			if(mode.equals("circles")){ 
				phyCompNotFinPAO=phyCompNotFinPAO+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
			}else if(mode.equals("divisions")){
				phyCompNotFinPAO=phyCompNotFinPAO+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				phyCompNotFinPAO= phyCompNotFinPAO+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
					//System.out.println("phyCompNotFinPAO"+phyCompNotFinPAO);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(phyCompNotFinPAO);
			if(rs2.next()){
				paoPhyCompNotFin = rs2.getDouble(1);
			}
			rs2.close();
			stmt2.close();
			 String amountPhyCompNotFin = ndf.format((bankPhyCompNotFin + paoPhyCompNotFin) / 100000);
             arfc = estCost - (bankLastYear + paoLastYear + bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000;
            if(noOfWorks==0 && estCost==0 && habsSanctioned==0 && worksComp==0 &&  habsCov==0 && popCov==0 &&
            popBenf==0 && bankLastYear==0.0 && paoLastYear==0.0 && bankLastMonth ==0.0 && paoLastMonth==0.0 &&
              bankCurrentMonth ==0.0 && paoCurrentMonth==0.0 && worksPhyCompNotFin==0.0) {}else{

         %>
             <tr>            
            
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
                     <% if (mode.equals("circles")) {%>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_CM_div_sudiv.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>"><%=cname%></a></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=tWorks&coc=<%=ccode%>&con=<%=programmeName%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=noOfWorks%></a></td>
                     <% } else if (mode.equals("divisions")) {   %>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_CM_div_sudiv.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>"><%=divName%></a></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=tWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=noOfWorks%></a></td>
                     <% } else if (mode.equals("subdivisions")) { %>
                   	 <td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=tWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=noOfWorks%></a></td>
                      <%   } %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>
                    
                      <%  if (mode.equals("circles")) { %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=habsSanctioned%></a></td>
                      <%  } else if (mode.equals("divisions")) {  %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=habsSanctioned%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=habsSanctioned%></a></td>
                      <% }%>
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=popBenf%></td>
                  
                     <%  if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=worksComp%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=worksComp%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=worksComp%></a></td>
                      <%}                        	
                		 
                      if (mode.equals("circles")) {  %>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=habsCov%></a></td>
                     <%} else if (mode.equals("divisions")) {%>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=habsCov%></a></td>
                     <% } else if (mode.equals("subdivisions")) { %>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=habsCov%></a></td>
                     <%      }           %>
                     <td class="<%=style%>" style="text-align: right;" align="right"><%=popCov%></td>
		                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountLFI%></td>
		                 <%if (month != 4) { %>
			                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountLM%></td>
			                <%} %>
		                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountCM%></td>
		                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountTot%></td>
		                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountPhyCompNotFin%></td>
                    
		                <%  if (mode.equals("circles")) {             %>
		                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=fWorks&coc=<%=ccode%>&con=<%=programmeName%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=noOfWorks - worksComp%></a></td>
		                <% } else if (mode.equals("divisions")) { %>
		                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=fWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=con%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=noOfWorks - worksComp%></a></td>
		                <%} else if (mode.equals("subdivisions")) { %>
		                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=fWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=con%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>')"><%=noOfWorks - worksComp%></td>
		                <%}  %>                
        				 <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(arfc)%></td>
        			 </tr>    
        			 
        <%       }
            	 totNoOfWorks = totNoOfWorks + noOfWorks;
                 totEstCost = totEstCost + estCost;
                 totHabsSanctioned = totHabsSanctioned + habsSanctioned;
                 totWorksComp = totWorksComp + worksComp;
                 totHabsCov = totHabsCov + habsCov;
                 totPopCov = totPopCov + popCov;
                 totPopBenf = totPopBenf + popBenf;
                 totExpUptoLFY = totExpUptoLFY + bankLastYear + paoLastYear;
                 totExpUptoLM = totExpUptoLM + bankLastMonth + paoLastMonth;
                 totExpDM = totExpDM + bankCurrentMonth + paoCurrentMonth;
                 totTotExp = totExpUptoLM + totExpDM;
                 totarfc = totarfc + arfc;
                 totWorksPhyCompNotFin = totWorksPhyCompNotFin + worksPhyCompNotFin;
                 totExpPhyCompNotFin = totExpPhyCompNotFin + bankPhyCompNotFin + paoPhyCompNotFin;
          }
            
          
             if (slno == 0) {
         %>
     <tr>
         <td colspan="12" class="<%=style%>" style="text-align: center;">NO Records Found</td>
     </tr>
     <%
             }  %>
		 <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                <td class="btext" style="text-align: right;"><%=totHabsSanctioned%></td>
                <td class="btext" style="text-align: right;"><%=totPopBenf%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=totHabsCov%></td>
                <td class="btext" style="text-align: right;"><%=totPopCov%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td>
                <%if (month != 4) { %>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLM / 100000)%></td>
                <%} %>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpDM / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpPhyCompNotFin / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks - totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totarfc)%></td>
            </tr>
		
		<%
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally{}
		}
			%>
		</table>
			<br/>
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