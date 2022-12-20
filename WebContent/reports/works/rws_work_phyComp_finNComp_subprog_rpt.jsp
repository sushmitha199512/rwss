
<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%    DecimalFormat ndf = new DecimalFormat("####.00");

    int NRDWPhabsSanctioned12=0;

	HashMap programmeName = new HashMap();
	int count = 1;
    String sub = "ALL";
    String mode = "initial";

    if (request.getParameter("sub") != null) {
        sub = (String) request.getParameter("sub");
    }
    if (request.getParameter("mode") != null) {
        mode = request.getParameter("mode");
    }

    String pcd = request.getParameter("pc");
    String pcn = request.getParameter("pn");
    String coc = request.getParameter("coc");
    String con = request.getParameter("con");
    String doc = request.getParameter("doc");
    String don = request.getParameter("don");
    
    String schemes=request.getParameter("scheme");
    String programme = request.getParameter("programme");
    String programName = request.getParameter("programmeName");
    String programe = "";
    String subProgrammeCode="",subProgrammeName="";
 
    int yearStart = 0;
    int yearEnd = 0;
    yearStart=Integer.parseInt( request.getParameter("yearStart"));
    yearEnd=Integer.parseInt(request.getParameter("yearEnd"));
    /* if (month <= 3) {
        yearStart = cyear - 1;
        yearEnd = cyear;
    } else {
        yearStart = cyear;
        yearEnd = cyear + 1;
    } */
    String ye=""+yearEnd;
    ye=ye.substring(2,4).toString();
    
    int yEnd=Integer.parseInt(ye);
	
	String names="";

%>
<html>
<script src="/pred/resources/graphs/jquery.min.js"></script>

<script language="JavaScript">



    function viewWorks(URL)
    {

        var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
        if (URL != "")
        {
            myNewWin = window.open(URL, 'newWinddow', popFeatures);
            myNewWin.focus();
        }
    }

    function wopen(url, name, w, h)
    {
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

<style type="text/css">
    body, body a {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 13px !important;
    }
    .btext {
        border: 1px solid #000000 !important;
        font-family: "Maiandra GD", Georgia, Serif !important;
        font-size: 12px !important;
    }
    .rightPad td {
        padding-right: 3px !important;
    }
</style>

<body>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
    <br/>
    <br/>
    <form name=f1 id="f1" method="post" action="rws_work_progress_abstract_list1.jsp">
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>Abstract
					Progress Report for Physically Completed But Financially Not
					completed Works</b></font>
            <br/><br/><font color="#889900" face="Maiandra GD" size="3px"  >Programme: <%=programName %>
            <%
                if (request.getParameter("con") != null) {
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle: <%=request.getParameter("con")%>
            <%
                }
                if (request.getParameter("don") != null) {
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Division: <%=request.getParameter("don")%>
            <%
                }
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: <%=yearStart%>-<%=yEnd%></font>
        </center>

        <br/><br/>
        <%
			if (!mode.equals("initial") ) {
		%>
		<table align="center"
			style="margin-top: -35px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 950px !important;"></td>
				<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img	src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
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
					<td style="width: 40px !important;">
                     
				<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img	src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			}
		%>
		<br/><br/>
        <table border=1 cellspacing=0 cellpadding=0 height=5% width="800px" class="baseTable"
               bordercolor=#000000 style="border-collapse: collapse; margin-top: -15px !important; "
               bgcolor="#ffffff" align="center">
            <tr align=center align=center class="thead">
                <td class=btext >SNO</td>
                <td class=btext >Programme</td>
                <td class=btext >Sub Programme</td>
              	<td class=btext>Scheme-No. of<br />Works
				</td>
				<td class=btext>Original Est Cost</td>
				<td class=btext align="center">Agreement Value</td>
				<td class=btext>Cum Exp. Upto 31.3.<%=yearStart%></td>
				<td class=btext>Bal Est Cost as on 1.4.<%=yearStart%><br>(5-7)
				</td>
				<td class=btext>Exp. During <%=yearStart%>-<%=yearEnd%></td>
				<td class=btext>Balance to be paid<br>(5-(7+9))</td>
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
                String programmeNam = "",subprogrammeNam = "";
                Connection connection = null;
                Statement stmt1 = null;
                ResultSet rs1 = null;
                int slno = 0;
                try {
                	int totNoOfWorks = 0;				
					double totarfc = 0, totEstCost = 0,totAgrCost=0, totExpUptoPY = 0, totBalEstCost14ys = 0, totTotExp = 0,totBalEstCost=0;
                    String query = "";
                    String mainProgramme = "",mainProgrammeName = "",dupeProgrammeName="";
                    String sa;
                    String schemeName="",oldprogName="";
                                       					
			             	String programmeQuery = "select a.PROGRAMME_CODE,PROGRAMME_NAME,SUBPROGRAMME_CODE,SUBPROGRAMME_NAME from  rws_programme_tbl a,rws_subprogramme_tbl b where a.PROGRAMME_CODE=b.PROGRAMME_CODE and a.PROGRAMME_CODE in("+ programme + ")";
			             	Statement statement1 = conn.createStatement();
			             	ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
			             	//System.out.println(programmeQuery);
			             	while (resultSet1.next()) {
			             		
			             		double estCost = 0, agreementValue = 0, bankUptoPrevYear = 0, bankYear = 0, paoUptoPrevYear = 0,
										paoYear = 0, TotExp = 0;
								int noOfWorks = 0;
			             		programmeNam = resultSet1.getString("PROGRAMME_NAME");
			             		programme=resultSet1.getString("PROGRAMME_CODE");
			             		subProgrammeCode=resultSet1.getString("SUBPROGRAMME_CODE");
			             		subProgrammeName=resultSet1.getString("SUBPROGRAMME_NAME");	     	
			          
                      /*   query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";    */ 
                                
                            	query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a, rws_programme_tbl p,rws_work_completion_tbl c where "
    									+ "WORK_CANCEL_DT is null and a.TYPE_OF_ASSET in (" + schemes
    									+ ") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
    									+ "AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    									+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
    									+ yearStart + "' and c.dt_fin_completion is null";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);
                   if (rs.next()) {                    	
                        	names+=programmeNam+",";                       
                        noOfWorks = rs.getInt(2);
                        estCost = rs.getDouble(1);
                    }         
                   stmt.close();
					rs.close();
                   String agreementValueQry = "";
					agreementValueQry ="select sum(con.agreement_value),count(distinct a.work_id) from rws_work_admn_tbl a, rws_programme_tbl p,"
							+"rws_work_completion_tbl c,rws_contractor_selection_tbl con where WORK_CANCEL_DT is null and a.work_id=con.work_id "
							+"and a.TYPE_OF_ASSET in ("+schemes+") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+programme+")  and a.subprogramme_code in (" + subProgrammeCode + ") "
							+" AND a.CORE_DASHBOARD_STATUS='Y' and ( a.TARGET_DATE_COMP is not null OR a.TARGET_DATE_COMP <> '') and "
							+" a.work_id=c.work_id  and c.DATE_OF_COMPLETION is not null and to_date(c.DATE_OF_COMPLETION)<='31-MAR-"+ yearStart 
							+"' and c.dt_fin_completion is null";
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
							+ ")  and a.programme_code in (" + programme + ")  and a.subprogramme_code in (" + subProgrammeCode + ")  AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
							+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
							+ yearStart + "' and c.dt_fin_completion is null and to_date(BANK_SEND_DATE)<='31-MAR-"
							+ yearStart + "'";
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
							+ ")  and a.programme_code in (" + programme + ")  and a.subprogramme_code in (" + subProgrammeCode + ")  AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
							+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
							+ yearStart + "' and c.dt_fin_completion is null and  to_date(STATE_SEND_DATE)<='31-MAR-" + yearStart + "'";
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
							+ ")  and a.programme_code in (" + programme + ")  and a.subprogramme_code in (" + subProgrammeCode + ")  AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
							+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
							+ yearStart + "' and c.dt_fin_completion is null and  to_date(BANK_SEND_DATE)>='01-APR-" + yearStart+"'";
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
							+ ")  and a.programme_code in (" + programme + ")  and a.subprogramme_code in (" + subProgrammeCode + ")  AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
							+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
							+ yearStart + "' and c.dt_fin_completion is null and  to_date(STATE_SEND_DATE)>='01-APR-" + yearStart+ "'"; 
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
							&& bankYear == 0.0 && paoYear == 0.0 )
                 {}else{     	 
                	 
                	 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                     } else {
                         style = "gridbg2";
                     }
                     styleCount++;  
                %>
                     <tr>  
                         <%if(!oldprogName.equals(programmeNam)){ %>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><%=++slno%></td>
                         <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><%=programmeNam%></td>
                         <%}else{ %>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"></td>
                         <td class="<%=style%>" style="text-align: left;" align="right" width="100px"></td>
                         <%} %>
                         <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><%=subProgrammeName%></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=cWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noOfWorks%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(estCost) %></td>
                     	<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=ndf.format(agreementValue/100000)%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=amountCumUptoPrevYear%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=BalEstCostys%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=amountTot%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=balEstCost%></td>
			         </tr>
                <%
               
                oldprogName=programmeNam;
                   }
			             	
                        totNoOfWorks = totNoOfWorks + noOfWorks;
                        totEstCost = totEstCost + estCost;
                    	totAgrCost=totAgrCost+agreementValue;
						totExpUptoPY = totExpUptoPY + bankUptoPrevYear + paoUptoPrevYear;
						totBalEstCost14ys = totBalEstCost14ys + (estCost -((bankUptoPrevYear + paoUptoPrevYear)/100000));
						totTotExp = totTotExp +bankYear + paoYear;
						totBalEstCost=totBalEstCost+ (estCost -((bankUptoPrevYear + paoUptoPrevYear+bankYear + paoYear)/100000));

			             	}
			             	resultSet1.close();
			             	statement1.close();
                   
                    stmt.close();
                    rs.close();
                    if (slno == 0) {
                %>
            <tr>
                <td colspan="15" class="<%=style%>" style="text-align: center;">NO Records Found</td>
            </tr>
            <%
                }      
                 
            %>
            <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=3>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
             	<td class="btext" style="text-align: right;"><%=ndf.format(totAgrCost / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoPY / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totBalEstCost14ys )%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totBalEstCost ) %></td>
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
    </form>
    <br/>
  

    <table height="20px" align="center">
        <tr height="1%">
            <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
            </td>
        </tr>
    </table>
    <br/>
</body>
</html>

