<%@ page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%
    int count = 1;
	DecimalFormat ndf = new DecimalFormat("####.00");
	/* HashMap adminSact = new HashMap();
	HashMap techSact = new HashMap();
	HashMap entrust = new HashMap();
    HashMap ground = new HashMap();
	HashMap underProg = new HashMap();
	HashMap complet = new HashMap();
	HashMap progMap = new HashMap(); */
	
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
                 <td class=btext >Not Grounded</td>
				 <td class=btext >Grounded</td>
                 <td class=btext >Completed</td>
				 <td class=btext >Commissioned</td>
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
		        int totadmin_sanc=0; int totgrounded=0;int totcommissioned=0;   int totcomp=0,totnotgrou=0;
				try {
					String programme = "";
					String schemes = "'01','02','03','10'";
					for (int i = 1; i <= programmeList.size(); i++) 
					{
                        int admin_sactioned = 0;
                        int grounded = 0;
                        int commissioned = 0;
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
						
						//************Related to works**************//
						//System.out.println("nnnnnnnnnnnnnnn");
						String admin_Query="select count(distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where WORK_CANCEL_DT is null and a.work_id not in "
                      +"(select work_id from rws_work_completion_tbl where  DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<='31-MAR-"+yearStart+"') and a.CORE_DASHBOARD_STATUS='Y'" 
                      +"and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("	+ schemes+ ") and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
                    	stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(admin_Query);      //  System.out.println("admin_Query"+admin_Query);
						if (rs1.next()) {
						admin_sactioned=rs1.getInt(1);
                        			}
						stmt1.close();
						rs1.close();
						/*  String Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a where a.work_id not in "
								   +"(select a.work_id from RWS_WORK_COMMENCEMENT_TBL a where GROUNDING_DATE is not null ) and a.work_id not in " 
                                 +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<='31-MAR-"+yearStart+"')  " 
                                 +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                                 +"  a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                                 +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') "; */
                                 
                          String Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a where a.work_id not in "
							   +"(select a.work_id from RWS_WORK_COMMENCEMENT_TBL a,rws_source_iden_fin_tbl b,rws_new_est_tbl c,RWS_CONTRACTOR_SELECTION_TBL d where a.work_id = b.work_id and a.work_id = c.work_id and a.work_id = d.work_id and GROUNDING_DATE is not null) and a.work_id not in " 
                                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null )  " 
                                +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                                +"  a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                                +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
								stmt2= conn.createStatement();     
					    System.out.println("Not Grounded_Query"+Not_Grounded_Query);
								rs2= stmt2.executeQuery(Not_Grounded_Query);
								if (rs2.next()) {
									not_grou=rs2.getInt(1);
					             }
								stmt2.close();
								rs2.close();
					  String Grounded_Query="select count (distinct a.work_id) from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                                      +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and b.GROUNDING_DATE is not null " 
                                      +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                                      +" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                                      +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
                                      
                    /*  String Grounded_Query="select count (distinct a.work_id) from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a where a.work_id not in "
                             +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and b.GROUNDING_DATE is not null " 
                             +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                             +" a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                             +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";  */
							stmt4= conn.createStatement();     
				              // System.out.println("Grounded_Query"+Grounded_Query);
							rs4= stmt4.executeQuery(Grounded_Query);
							if (rs4.next()) {
								grounded=rs4.getInt(1);
				 			}
							stmt4.close();
							rs4.close();                                                                                  
                                
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
						String comission_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id in "
                                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMM is not null and DATE_OF_COMM>='01-APR-"+yearStart+ "') and b.GROUNDING_DATE is not null " 
                                +" and  substr(a.work_id,7,2) in ("+ schemes+ ") and b.work_id=a.work_id and e.work_id=a.work_id and c.work_id=a.work_id and a.CORE_DASHBOARD_STATUS='Y' and "
                                +" s.work_id=a.work_id and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";                      
						stmt6= conn.createStatement();           //System.out.println("completed_Query"+completed_Query);
						rs6 = stmt6.executeQuery(comission_Query);
						if (rs6.next()) {
							commissioned=rs6.getInt(1);
                     }
						stmt6.close();
						rs6.close();
                       								
				if(	admin_sactioned == 0&&
                    grounded == 0&&
                    commissioned == 0&&
                    completed== 0&&
                    not_grou==0	){}else{
                    	if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
		%>		
			<tr>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=slno++%></td>
				<td class="<%=style%>" style="text-align: left;" align="left"><a href="./rws_min_work_flow_div_subdiv_cm_rpt.jsp?mode=circles&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>"><%=programmeName%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> admin_sactioned &year=<%=yearStart%>')"><%=admin_sactioned  %></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=not_grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Not Grounded  &year=<%=yearStart%>')"><%=not_grou   %></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> grounded  &year=<%=yearStart%>')"><%=grounded   %></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> completed  &year=<%=yearStart%>')"><%=completed   %></a></td>
                 <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=commissioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Commissioned  &year=<%=yearStart%>')"><%=commissioned   %></a></td>
			</tr>
			<% 
			}     		                
                totadmin_sanc+=admin_sactioned;
                totnotgrou+=not_grou;
                totgrounded+=grounded;
                totcomp+=completed;
                totcommissioned+=commissioned;               
         }                    
                                 
%>              
				<td class="btext" style="text-align: right;" colspan=2>Total</td>
				<td class="btext" style="text-align: right;"><%=totadmin_sanc %></td>
				<td class="btext" style="text-align: right;"><%=totnotgrou %></td>
				<td class="btext" style="text-align: right;"><%=totgrounded %></td>
				<td class="btext" style="text-align: right;"><%=totcomp %></td>
				<td class="btext" style="text-align: right;"><%=totcommissioned %></td>
				                       
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
</html>

