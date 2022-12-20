<%@ page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%
    int count = 1;
	DecimalFormat ndf = new DecimalFormat("####.00");
	HashMap adminSact = new HashMap();
	HashMap techSact = new HashMap();
	HashMap entrust = new HashMap();
    HashMap ground = new HashMap();
	HashMap underProg = new HashMap();
	HashMap complet = new HashMap();
	HashMap progMap = new HashMap();
	
	String inputWorks="";
    String admnSan="";
    String TechSan="";
    String entru="";
    String grou="";
    String undProg="";
    String comp="";
    String not_gr="";           
	String rDistrict = "";
	String finyear = "";
	String dname = "";
	String mode = "";

	if (request.getParameter("mode") != null){
			mode = request.getParameter("mode");
                         //System.out.println("mode"+mode);
        }

	if (request.getParameter("finyear") != null){
			finyear = request.getParameter("finyear");
               //  System.out.println("finyear"+finyear);
        }else {
			Statement stmtt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			ResultSet rss = stmtt.executeQuery("select distinct to_char(max(status_date),'dd-MON-yyyy') from rws_habitation_directory_tbl");
                                   // System.out.println("bbbbbbbbbbbbbb");
			while (rss.next()) {
				finyear = rss.getString(1);
			}
			int yr = Integer.parseInt(finyear.substring(7, finyear.length()));
			finyear = yr + "-" + (yr + 1);
	}
		session.setAttribute("finyear", finyear);

	HashMap programmeList = new HashMap();
	
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

	String CmDBQuery = "select PROGRAMME_CODE from  rws_programme_tbl where CM_CORE_DB='Y' and NRDWP_RELATED='N' order by 1";
    Statement stmtCmDB = conn.createStatement();
    ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
    while (rsCmDB.next()) {
    	programmeList.put(count,rsCmDB.getString(1));
    	count++;
    }
   
    programmeList.put(count, progCode);
   
	//System.out.println("programmeList"+programmeList.size());

	String startyr = finyear.substring(0, 4);
	String endyr = finyear.substring(5, 9);
	String divCode = "";
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
	lastMonth = lastMonth.substring(0, 1).toUpperCase() + lastMonth.substring(1).toLowerCase();
	currentMonth = currentMonth.substring(0, 1).toUpperCase() + currentMonth.substring(1).toLowerCase();
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
body{

}
</style>
<BODY>
		<br />
		<br />
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Works Progress - Work Flow</b></font> <br />
		</center>
		<br />
		<%
			if (mode.equals("divisions") ) {
		%>
		<table align="center" style="margin-top: -35px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 950px !important;"></td>
				<td style="width: 100px !important;" align="right">
                                                                        <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			} else {         //System.out.println("in else");
		%>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: left !important;"><font
					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>
					<td style="width: 40px !important;">
                    <!-- <a href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Bar"  style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a> --></td>
                    
				<td style="width: 50px !important; text-align: right !important">
					 <!-- <a
					href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Pie"
					 style="color: green !important; font-size: 13px;"
					id="showGraph"><img width="30px"
						src="/pred/resources/graphs/pie.png"></a> --> &nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			}
		%>
		<br/>
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px"
			bordercolor=#000000
			style="border-collapse: collapse; margin-top: 20px !important;"
			bgcolor="#ffffff" align="center">
			<tr align=center align=center>
				<td class=btext rowspan=2 style="width: 30px !important;">SNO</td>
				<td class=btext rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;Programme&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td class=btext colspan="7">No. of Works </td>         
            </tr>
			<tr align=center align=center>
                 <td class=btext >Admin Sanctioned</td>
                 <td class=btext >Tech. Sanctioned</td>
				 <td class=btext >Entrusted</td>
				 <td class=btext >Grounded</td>
                 <td class=btext >Under Progress</td>
                 <td class=btext >Completed</td>
				 <td class=btext >Not Grounded</td>
			</tr>
			<%
				int styleCount = 0;
				String style = "";
			%>      
            <%
				Connection connection = null;
				Statement stmt1,stmt2,stmt3,stmt4,stmt5,stmt6;
				ResultSet rs1,rs2,rs3,rs4,rs5,rs6;
                stmt1=null;rs1=null;stmt2=null;rs2=null;stmt3=null;rs3=null;
                stmt4=null;rs4=null;stmt5=null;rs5=null;stmt6=null;rs6=null;
                int slno = 1;                                                      
		        int totadmin_sanc=0; int tottech_sanc=0;int totentrusted=0; 
		        int totgrounded=0;int totunder_prog=0;   int totcomp=0,totnotgrou=0;
				try {
					String programme = "";
					String schemes = "'01','02','03','10'";
					for (int i = 1; i <= programmeList.size(); i++) 
					{
                        int admin_sactioned = 0;
                        int tech_sanctioned = 0;
                        int entrusted = 0;
                        int grounded = 0;
                        int under_progress = 0;
                        int completed= 0;
                        int not_grou=0;	
			            programme = (String) programmeList.get(i);
                                                      //   System.out.println("programme"+programme);
						String programmeName = "";

						if (programme.length() > 2) {
								programmeName = "NRDWP";
						} else {
								String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"+ programme + "'";
                                                                                                                            Statement statement1 = conn.createStatement();
								ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
							if (resultSet1.next()) {
								programmeName = resultSet1.getString("PROGRAMME_NAME");
							}
							//  System.out.println("programmeName"+programmeName);
							resultSet.close();
							statement.close();
						}
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
						//************Related to works**************//
						//System.out.println("nnnnnnnnnnnnnnn");
						String admin_Query="select count(distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where WORK_CANCEL_DT is null and a.work_id not in "
                      +"(select work_id from rws_work_completion_tbl where  DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and a.CORE_DASHBOARD_STATUS='Y'" 
                      +"and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("	+ schemes+ ") and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
                        /*select sum(a.SANCTION_AMOUNT),count(a.work_id) from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"')  and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and c.GROUNDING_DATE is not null  and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP>='01-APR-"
								+ yearStart
								+ "'  and  c.CORE_DASHBOARD_STATUS<>'N' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";*/
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(admin_Query);      //  System.out.println("admin_Query"+admin_Query);
						if (rs1.next()) {
						admin_sactioned=rs1.getInt(1);
                        			}
						stmt1.close();
						rs1.close();
                      String tech_Query="select count(distinct a.work_id) from rws_new_est_tbl b,RWS_WORK_ADMN_TBL a where a.work_id not in" 
                           +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"' ) and a.CORE_DASHBOARD_STATUS='Y'"
                           + " and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.work_id=b.work_id and PROGRAMME_CODE in ("+ programme+") and  TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and  ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
                                                    
						stmt2 = conn.createStatement();       //System.out.println("tech_Query"+tech_Query);
						rs2 = stmt2.executeQuery(tech_Query);
						if (rs2.next()) {
							tech_sanctioned=rs2.getInt(1);
                                                            			}
						stmt2.close();
						rs2.close();
                                                                                                            
						 String Entrusted_Query="select count(distinct a.work_id) from RWS_CONTRACTOR_SELECTION_TBL b, RWS_WORK_ADMN_TBL a,rws_new_est_tbl e where a.work_id not in "
                                               +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"')  and a.CORE_DASHBOARD_STATUS='Y'" 
                                               +" and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.work_id=b.work_id and a.work_id=e.work_id and "
                                               +" a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
                                                    
						stmt3= conn.createStatement();         
                                                                                                              //System.out.println("Entrusted_Query"+Entrusted_Query);
						rs3 = stmt3.executeQuery(Entrusted_Query);
						if (rs3.next()) {
							entrusted=rs3.getInt(1);
                                                            			}
						stmt3.close();
						rs3.close();
                                                                                                            
 
						 String Grounded_Query="select count (distinct a.work_id) from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                                               +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and b.GROUNDING_DATE is not null " 
                                               +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                                               +" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                                               +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
						stmt4= conn.createStatement();     

                                                                                                            // System.out.println("Grounded_Query"+Grounded_Query);
						rs4= stmt4.executeQuery(Grounded_Query);
						if (rs4.next()) {
							grounded=rs4.getInt(1);
                                                            			}
						stmt4.close();
						rs4.close();
                        String under_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                                          +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION < '01-APR-"+yearEnd+"') and b.GROUNDING_DATE is not null " 
                                          +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and  a.work_id=b.work_id and a.work_id=e.work_id and a.work_id=c.work_id "
                                          +"and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"'"
                                          +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						stmt5 = conn.createStatement();     // System.out.println("under_Query"+under_Query);
						rs5 = stmt5.executeQuery(under_Query);
						if (rs5.next()) {
							under_progress=rs5.getInt(1);
                                                            			}
						stmt5.close();
						rs5.close();
                     /*    String completed_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where a.work_id in "
                                                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+yearStart+ "') and b.GROUNDING_DATE is not null " 
                                                +" and h.work_id=a.work_id and hd.hab_code=h.hab_code and substr(a.work_id,7,2) in ("+ schemes+ ") and b.work_id=a.work_id and e.work_id=a.work_id and c.work_id=a.work_id and a.CORE_DASHBOARD_STATUS='Y' and "
                                                +" s.work_id=a.work_id and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')"; */
                                                
                        String completed_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id in "
                                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+yearStart+ "') and b.GROUNDING_DATE is not null " 
                                +" and  substr(a.work_id,7,2) in ("+ schemes+ ") and b.work_id=a.work_id and e.work_id=a.work_id and c.work_id=a.work_id and a.CORE_DASHBOARD_STATUS='Y' and "
                                +" s.work_id=a.work_id and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";                      
						stmt6= conn.createStatement();           //System.out.println("completed_Query"+completed_Query);
						rs6 = stmt6.executeQuery(completed_Query);
						if (rs6.next()) {
							completed=rs6.getInt(1);
                                                            			}
						stmt6.close();
						rs6.close();
                                                                                                                not_grou=entrusted-grounded;



                                                                        
					adminSact.put(programme, admin_sactioned);
					techSact.put(programme, tech_sanctioned);
					entrust.put(programme, entrusted);
                                                         ground.put(programme, grounded);
                                                         underProg.put(programme, under_progress);
                                                         complet.put(programme, completed);
                                                      //   not_gr.put(programme,not_grou);
					progMap.put(programme, programmeName);
				if(	admin_sactioned == 0&&
                    tech_sanctioned == 0&&
                     entrusted == 0&&
                    grounded == 0&&
                    under_progress == 0&&
                    completed== 0&&
                    not_grou==0	){}else{
		%>		
			<tr>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=slno++%></td>
				<td class="<%=style%>" style="text-align: left;" align="left"><a href="./rws_work_flow_div_subdiv_cm_rpt.jsp?mode=circles&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>"><%=programmeName%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> admin_sactioned &year=<%=yearStart%>')"><%=admin_sactioned  %></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_flow_status_cm_drill.jsp?mode=tech_sanctioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> tech_sanctioned  &year=<%=yearStart%>')"><%=tech_sanctioned   %></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_flow_status_cm_drill.jsp?mode=entrusted&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> entrusted  &year=<%=yearStart%>')"><%=entrusted   %></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> grounded  &year=<%=yearStart%>')"><%=grounded   %></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_flow_status_cm_drill.jsp?mode=under_progress&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> under_progress  &year=<%=yearStart%>')"><%=under_progress   %></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> completed  &year=<%=yearStart%>')"><%=completed   %></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=not_grou  %></td>
			</tr>
			<% }                                                
				admnSan+=admin_sactioned+",";
                TechSan+=tech_sanctioned+",";
                entru+=entrusted+",";
                grou+=grounded+",";
                undProg+=under_progress+",";
                comp+=completed+",";
                not_gr+=not_grou+",";
              //inputWorks += "[" + admin_sactioned + "," + tech_sanctioned + "," + entrusted + "," + grounded +"," + under_progress +"," + completed +"],";
              //System.out.println("inputWorks-------"+inputWorks);
              //+ underProg + "," + complet + "],";
                totadmin_sanc+=admin_sactioned;
                tottech_sanc+=tech_sanctioned;
                totentrusted+=entrusted;
                totgrounded+=grounded;
                totunder_prog+=under_progress;
                totcomp+=completed;
                totnotgrou+=not_grou;
                     } 
                    adminSact.put("00", totadmin_sanc);
					techSact.put("00", tottech_sanc);
					entrust.put("00", totentrusted);
                    ground.put("00", totgrounded);
					underProg.put("00", totunder_prog);
					complet.put("00", totcomp);
					progMap.put("00", "ALL");
					session.setAttribute("adminSact", adminSact);
					session.setAttribute("techSact", techSact);
					session.setAttribute("entrust", entrust);
					session.setAttribute("ground", ground);
					session.setAttribute("underProg", underProg);
					session.setAttribute("complet", entrust);
					session.setAttribute("progMap", progMap);
                   String[] adminparts=admnSan.split(",");
                   String[] TechSanparts=TechSan.split(",");
                   String[] entruparts=entru.split(",");
                   String[] grouparts=grou.split(",");
                   String[] undProgparts=undProg.split(",");
                   String[] compparts=comp.split(",");
                   String[] notgrparts=not_gr.split(",");
                       admnSan="";
                        TechSan="";
                         entru="";
                         grou="";
                         undProg="";
                         comp="";
                         not_gr="";
   
                  admnSan=adminparts[3]+","+adminparts[0]+","+adminparts[1]+","+adminparts[2];
                  TechSan=TechSanparts[3]+","+TechSanparts[0]+","+TechSanparts[1]+","+TechSanparts[2];
                  entru=entruparts[3]+","+entruparts[0]+","+entruparts[1]+","+entruparts[2];
                  grou=grouparts[3]+","+grouparts[0]+","+grouparts[1]+","+grouparts[2];
                  undProg=undProgparts[3]+","+undProgparts[0]+","+undProgparts[1]+","+undProgparts[2];
                  comp=compparts[3]+","+compparts[0]+","+compparts[1]+","+compparts[2];
                  not_gr=notgrparts[3]+","+notgrparts[0]+","+notgrparts[1]+","+notgrparts[2];
                  inputWorks += "[" + admnSan.substring(0, admnSan.length()) + "],[" + TechSan.substring(0, TechSan.length() )  + "],[" + entru.substring(0, entru.length() )  + "],[" + grou.substring(0, grou.length() )  +"],[" + undProg.substring(0, undProg.length() )  +"],[" + comp.substring(0, comp.length() )  +"],[" + not_gr.substring(0, not_gr.length() )  +"],";
				  inputWorks = inputWorks.substring(0, inputWorks.length() - 1);
					session.setAttribute("inputWorks", inputWorks);
                                                   //  System.out.println("inputWorks aaaaaaaaaaaaaaaaaaaaaaaaaa"+inputWorks);
%>              
				<td class="btext" style="text-align: right;" colspan=2>Total</td>
				<td class="btext" style="text-align: right;"><%=totadmin_sanc %></td>
				<td class="btext" style="text-align: right;"><%=tottech_sanc %></td>
				<td class="btext" style="text-align: right;"><%=totentrusted %></td>
				<td class="btext" style="text-align: right;"><%=totgrounded %></td>
				<td class="btext" style="text-align: right;"><%=totunder_prog %></td>
				<td class="btext" style="text-align: right;"><%=totcomp %></td>
				<td class="btext" style="text-align: right;"><%=totnotgrou %></td>
                        
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
       // if(session.getAttribute("adminSact")==null || session.getAttribute("techSact")==null || session.getAttribute("entrust")==null || session.getAttribute("ground")==null || session.getAttribute("progMap")==null || session.getAttribute("inputWorks")==null )
        //{
         //   response.sendRedirect("http://core.ap.gov.in/");
         //   return;
      // }
       /*  String programme = request.getParameter("programme");
        if(programme==null || programme==""){
        	programme="00";
        }
      //  System.out.println(programme);
        String mode1 = request.getParameter("mode");
        if(mode1==null || mode1==""){
        	mode1="Bar";
        }
          //System.out.println("mode1"+mode1);
        long workToCover = Long.parseLong(adminSact.get(programme).toString()) - Long.parseLong(techSact.get(programme).toString()) - Long.parseLong(entrust.get(programme).toString()) - Long.parseLong(ground.get(programme).toString());
       // long habToCover = Long.parseLong(adminSact.get(programme).toString()) - Long.parseLong(techSact.get(programme).toString()) - Long.parseLong(entrust.get(programme).toString()) - Long.parseLong(ground.get(programme).toString());
    // System.out.println("workToCover"+workToCover);
  //   System.out.println("habToCover"+habToCover);
        String distBars = "";
         String workPie = "[[\"Admin Sanctioned  \","+adminSact.get(programme)+"],"+"[\"Tech Sanctioned  \","+techSact.get(programme)+"],"+"[\"Entrusted \","+entrust.get(programme)+"],"+"[\"Grounded  \","+ground.get(programme)+"],";
         //String habPie = "[[\"Admin Sanctioned\","+adminSact.get(programme)+"],"+"[\"Tech Sanctioned\","+techSact.get(programme)+"],"+"[\"Entrusted \","+entrust.get(programme)+"],"+"[\"Grounded  \","+ground.get(programme)+"],";
         //,"+"[\"Under Progress  \","+underProg.get(programme)+"],"+"[\"Completed \","+complet.get(programme)+"]]";
         //String workPie = "[[\"Sanctioned Works\","+adminSact.get(programme)+"],"+"[\"Completed Works\","+complet.get(programme)+"],"+"[\"To Be Completed\","+underProg+"]]";
            //System.out.println("workPie"+workPie);
         //   System.out.println("habPie"+habPie);
         
        Set keySet2 = progMap.keySet();
         List keyList = new ArrayList(keySet2);
         Collections.sort(keyList); */
       //   System.out.println("keyList"+keyList);
        
    %>
   <%--  <head>
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
                 margin-left: 40px !important;
            }

        </style>
        <script>
            $(document).ready(function() {
                    $("#programme option[value='<%=programme%>']").prop('selected', true);
                    $("#programme").change(function() {
                        $("#graphParams").submit();
                    });
            });
        </script>

    </head>
    <body>
        <form id="graphParams" name="graphParams" action="rws_work_flow_status_cm_rpt.jsp">
            <input type="hidden" id="mode" name="mode" value="<%=mode1%>"/>
        <div class="wrap" style="margin-top: -20px !important; width: 1150px !important; text-align: center !important;">
            <br/><br/> 	

            <%
                if(mode1.equals("Bar"))
                {
            %>
                    <br/>
            <div id="distChart" style=" padding-left: 50px;  padding-bottom: 100px;   padding-top: 20px; border : 1px double #c67; border-radius: 8px;">
                <p style="font-weight: normal; text-align: center;">
                    <span style="background-color: #546E28;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;NRDWP&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="background-color: #EE761E;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;13TH FC&nbsp;&nbsp;&nbsp;&nbsp;
                   <span style="background-color: #C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;APRWSP-WB&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="background-color: #034f84;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;NABARD&nbsp;&nbsp;&nbsp;&nbsp;
                   
                   
                   <!--  <span style="background-color: #C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;NSS (No Safe Source) -->
                </p>
                <br/>
                <div class="chart" style="left: 30px ; height: 300px;">
                    <ul id="distChartUL" class="bar-chart" data-bars="<%=inputWorks%>" data-max="" data-unit="" data-width="15" style="margin-left: 10px;width: 800px;" >
                    <ul><li style="height:300px"></li></ul>
                    </ul>
                    <p style="transform: rotate(270deg);position: relative;top: 120px; left: -520px; font-weight: bold;	margin-left: -60px !important;">No. of Works</p>
                    <p style="margin-left: 25px !important;">
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                    
                   </p>
                    <br/>
                 
                    
                    <p style="margin-left: 40px !important;font-weight: bold;">
                        <h4 style="transform: rotate(-30deg);top: 20px;position: relative;left: -310px;">Admin Sactioned</h4>
                   <h4 style="transform: rotate(-30deg);top: 10px;position: relative;left: -200px;">Tech. Sanctioned</h4>
                   <h4 style="transform: rotate(-30deg);top: -10px;position: relative;left: -100px;">  Entrusted</h4>
                   <h4 style="transform: rotate(-30deg);top: -25px;position: relative;left:0px;">  Grounded</h4>
                    <h4 style="transform: rotate(-30deg);top: -50px;position: relative;left: 100px;">Under Progress</h4>
                    <h4 style="transform: rotate(-30deg);top: -65px;position: relative;left: 200px;">  Completed</h4>
                    <h4 style="transform: rotate(-30deg);top: -80px;position: relative;left: 300px;">  Not Grounded</h4>
              
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
                        Programme Wise Work Progress : &nbsp;
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
                                <h3 style="margin-left: 60px !important;">Work Progress</h3>
                                <div class="chart" style="width:200px !important; margin-left: 30px !important; text-align: left !important; ">
                                    <div class="pie-thychart" data-set='<%=workPie%>' data-colors="#0086b3,#FFA500,#006400,#d62929">
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

