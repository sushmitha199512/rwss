<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%
String schemes = request.getParameter("schemes");
//String schemes = "01,02,03";
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

int yearStart =0;
int yearEnd = 0;
yearStart=Integer.parseInt( request.getParameter("yearStart"));
yearEnd=Integer.parseInt(request.getParameter("yearEnd"));

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
			<font color="#663899" face="Maiandra GD" size="4px"><b>Abstract
					Progress Report for Physically Completed But Financially Not
					completed Works</b></font></br><br><font color="#889900" face="Maiandra GD" size="3px"  > Programme :- <%=programmeName %>
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
			<td class=btext >Sl.No</td>
			<%if(mode.equals("circles")){ %>
			<td class=btext >Circle</td>
			<%}else if(mode.equals("divisions")){ %>
			<td class=btext >Division</td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class=btext>Sub Division</td>
			<%} %>
		 	<td class=btext >No. of<br/>Works</td>
         	<td class=btext>Original Est Cost</td>
			<td class=btext align="center">Agreement Value</td>
			<td class=btext>Cum Exp. Upto 31.3.<%=yearStart%></td>
			<td class=btext>Bal Est Cost as on 1.4.<%=yearStart%><br>(4-6)
			</td>
			<td class=btext>Exp. During <%=yearStart%>-<%=yearEnd%></td>
			<td class=btext>Balance to be paid<br>(4-(6+8))</td>
			<td class=btext >Bills raised so far</td>
			</tr>
			<tr align=center align=center class="thead">
				<td class=btext>1</td>
				<td class=btext>2</td>
				<td class=btext>3</td>
				<td class=btext>4</td>
				<td class=btext>5</td>
				<td class=btext>6</td>
				<td class=btext>7</td>
				<td class=btext>8</td>
				<td class=btext>9</td>
				<td class=btext>10</td>
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
             int totNoOfWorks = 0;
             double billamount=0,totbillamt=0;
             double totarfc = 0, totEstCost = 0,totAgrCost=0, totExpUptoPY = 0, totBalEstCost14ys = 0, totTotExp = 0,totBalEstCost=0;
        String query = "",billAmtsQuery="";
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
          PreparedStatement preparedStatement = conn.prepareStatement(c_query);
          ResultSet res = preparedStatement.executeQuery();
          while(res.next()){
        		double estCost = 0, agreementValue = 0, bankUptoPrevYear = 0, bankYear = 0, paoUptoPrevYear = 0,
						paoYear = 0, TotExp = 0;
        	  int noOfWorks = 0;
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
				
				
				billAmtsQuery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a, rws_programme_tbl p,rws_work_completion_tbl c ,RWS_WORK_BILL_TBL wb where "
						+ "WORK_CANCEL_DT is null and a.TYPE_OF_ASSET in (" + schemes
						+ ") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
						+ "AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
						+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
						+ yearStart + "' and c.dt_fin_completion is null and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no )";
			if(mode.equals("circles")){ 
				billAmtsQuery  = billAmtsQuery+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				billAmtsQuery = billAmtsQuery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				billAmtsQuery = billAmtsQuery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
		//System.out.println("billAmtsQuery*****  "+billAmtsQuery);	
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(billAmtsQuery);
		if(rs1.next())
		{
			// noOfWorks = rs1.getInt(2);
             billamount = rs1.getDouble(1);
	    }
		rs1.close();
		stmt1.close();
				
				
				
				query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a, rws_programme_tbl p,rws_work_completion_tbl c where "
						+ "WORK_CANCEL_DT is null and a.TYPE_OF_ASSET in (" + schemes
						+ ") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
						+ "AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
						+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
						+ yearStart + "' and c.dt_fin_completion is null";
			if(mode.equals("circles")){ 
				query  = query+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				query = query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				query = query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
		//System.out.println("query*****  "+query);	
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(query);
		if(rs1.next())
		{
			 noOfWorks = rs1.getInt(2);
             estCost = rs1.getDouble(1);
	    }
		rs1.close();
		stmt1.close();
		
		
		
	/* 	   String billsamtquery = "";
           
       	billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
                    + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                    + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
                    + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
                    + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no )";
       	if(mode.equals("circles")){ 
       		billsamtquery  = billsamtquery+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			billsamtquery = billsamtquery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			billsamtquery = billsamtquery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
       //System.out.println(groundWorks);
    
       stmt1 = conn.createStatement();
       rs1 = stmt1.executeQuery(billsamtquery);
       if (rs1.next()) {
         billamount = rs1.getDouble(1);    
       }
       stmt1.close();
       rs1.close();
       
		 */
		
		
		
		
		String agreementValueQry = "";
		agreementValueQry ="select sum(con.agreement_value),count(distinct a.work_id) from rws_work_admn_tbl a, rws_programme_tbl p,"
				+"rws_work_completion_tbl c,rws_contractor_selection_tbl con where WORK_CANCEL_DT is null and a.work_id=con.work_id "
				+"and a.TYPE_OF_ASSET in ("+schemes+") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+programme+")"
				+" AND a.CORE_DASHBOARD_STATUS='Y' and ( a.TARGET_DATE_COMP is not null OR a.TARGET_DATE_COMP <> '') and "
				+" a.work_id=c.work_id  and c.DATE_OF_COMPLETION is not null and to_date(c.DATE_OF_COMPLETION)<='31-MAR-"+ yearStart 
				+"' and c.dt_fin_completion is null";
		if(mode.equals("circles")){ 
			agreementValueQry  = agreementValueQry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			agreementValueQry = agreementValueQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			agreementValueQry = agreementValueQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(agreementValueQry);
		if (rs1.next()) {
			agreementValue = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();
		String bankCum = "";
		bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
				+"rws_work_completion_tbl c where  WORK_CANCEL_DT is null and b.work_id=a.work_id and a.TYPE_OF_ASSET in (" + schemes
				+ ")  and a.programme_code in (" + programme + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
				+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
				+ yearStart + "' and c.dt_fin_completion is null and to_date(BANK_SEND_DATE)<='31-MAR-"
				+ yearStart + "'";
		if(mode.equals("circles")){ 
			bankCum  = bankCum+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			bankCum = bankCum+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			bankCum = bankCum+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(bankCum);
		if (rs1.next()) {
			bankUptoPrevYear = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();
		String paoCum = "";
		paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
				+"rws_work_completion_tbl c where  WORK_CANCEL_DT is null and b.work_id=a.work_id and a.TYPE_OF_ASSET in (" + schemes
				+ ")  and a.programme_code in (" + programme + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
				+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
				+ yearStart + "' and c.dt_fin_completion is null and  to_date(STATE_SEND_DATE)<='31-MAR-"
				+ yearStart + "'";
		if(mode.equals("circles")){ 
			paoCum  = paoCum+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			paoCum = paoCum+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			paoCum = paoCum+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(paoCum);
		if (rs1.next()) {
			paoUptoPrevYear = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();
		String amountCumUptoPrevYear = ndf.format((bankUptoPrevYear + paoUptoPrevYear) / 100000);
		String BalEstCostys = ndf.format(estCost - ((bankUptoPrevYear + paoUptoPrevYear) / 100000));
		String bankTot = "";
		bankTot = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
				+"rws_work_completion_tbl c where  WORK_CANCEL_DT is null and b.work_id=a.work_id and a.TYPE_OF_ASSET in (" + schemes
				+ ")  and a.programme_code in (" + programme + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
				+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
				+ yearStart + "' and c.dt_fin_completion is null and  to_date(BANK_SEND_DATE)>='01-APR-" + yearStart+"'";
		if(mode.equals("circles")){ 
			bankTot  = bankTot+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			bankTot = bankTot+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			bankTot = bankTot+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
				
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(bankTot);
		if (rs1.next()) {
			bankYear = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();
		String paoTot = "";
		paoTot = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
				+"rws_work_completion_tbl c where  WORK_CANCEL_DT is null and b.work_id=a.work_id and a.TYPE_OF_ASSET in (" + schemes
				+ ")  and a.programme_code in (" + programme + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
				+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
				+ yearStart + "' and c.dt_fin_completion is null and  to_date(STATE_SEND_DATE)>='01-APR-" + yearStart+ "'"; 
		if(mode.equals("circles")){ 
			paoTot  = paoTot+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}
		else if(mode.equals("divisions")){
			paoTot = paoTot+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			paoTot = paoTot+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(paoTot);
		if (rs1.next()) {
			paoYear = rs1.getDouble(1);
		}
		stmt1.close();
		rs1.close();
		String amountTot = ndf.format((bankYear + paoYear) / 100000);
		String balEstCost= ndf.format(estCost-(bankUptoPrevYear+paoUptoPrevYear+bankYear + paoYear) / 100000);
		if (noOfWorks == 0 && estCost == 0 &&agreementValue==0
				&& bankUptoPrevYear == 0.0 && paoUptoPrevYear == 0.0
				&& bankYear == 0.0 && paoYear == 0.0 ) {}
		else{
         %>
             <tr>            
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
                     <% if (mode.equals("circles")) {%>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_prog_phyComp_finNot_circle_div_rpt.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=cname%></a></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=cWorks&coc=<%=ccode%>&con=<%=programmeName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noOfWorks%></a></td>
                     <% } else if (mode.equals("divisions")) {   %>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_prog_phyComp_finNot_circle_div_rpt.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=divName%></a></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=cWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noOfWorks%></a></td>
                     <% } else if (mode.equals("subdivisions")) { %>
                   	 <td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=cWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noOfWorks%></a></td>
                      <%   } %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>                    
                    <td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=ndf.format(agreementValue/100000)%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=amountCumUptoPrevYear%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=BalEstCostys%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=amountTot%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=balEstCost%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=ndf.format(billamount/100000)%></td>
        		</tr>    
        			 
        <%       }
             	totNoOfWorks = totNoOfWorks + noOfWorks;
				totEstCost = totEstCost + estCost;
				totAgrCost=totAgrCost+agreementValue;
				totExpUptoPY = totExpUptoPY + bankUptoPrevYear + paoUptoPrevYear ;
				totBalEstCost14ys = totBalEstCost14ys + (estCost -( (bankUptoPrevYear + paoUptoPrevYear)/100000));
				totTotExp = totTotExp +bankYear + paoYear;
				totBalEstCost=totBalEstCost+ (estCost -((bankUptoPrevYear + paoUptoPrevYear+bankYear + paoYear)/100000));;
               totbillamt=totbillamt+billamount;
          }
             if (slno == 0) {
         %>
     <tr>
         <td colspan="12" class="<%=style%>" style="text-align: center;">No Records Found</td>
     </tr>
     <%
             }  %>
		 	<tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
         		<td class="btext" style="text-align: right;"><%=ndf.format(totAgrCost / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoPY / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totBalEstCost14ys )%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totBalEstCost ) %></td>
					<td class="btext" style="text-align: right;"><%=ndf.format(totbillamt/100000 ) %></td>    
				<%-- <td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=ndf.format(totbillamt/100000 ) %></td> --%>           
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