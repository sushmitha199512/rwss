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
	       
	String rDistrict = "";
	String finyear = "";
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
	String today=day + "-" + month + "-" + cyear;
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
	   
	    		String schemes = "";
	    			String schemeType = "";
	    			if (request.getParameter("schemeType") != null ) {				
	    				schemeType = request.getParameter("schemeType");
	    			}else
	    				schemeType="";
	    			if(schemeType.equals("svs"))
	    				schemes="01,02";
	    			else if(schemeType.equals("mvs"))
	    				schemes = "03";
	    			else
	    				schemes = "01,02,03,10";			
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

body {
	
}
</style>
<BODY>
	<form>
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Work Flow and Progress Duration Status (as per stipulated date of completion)</b></font> 
		</center>
		
		<br><br>
		
			<font color="#663899" face="Maiandra GD" size="4px"><b>Select Scheme Type:</b></font><font color="red">*</font> 
			<SELECT name="schemeType" id="schemeType" style="width: 140px" onchange="this.form.submit()">
				<%if(schemeType.equals("svs")){%>
					<option value="" >ALL</option>
					<option value="svs" selected>SVS</option>
					<option value="mvs" >MVS</option>
				<% }else if(schemeType.equals("mvs")){%>
					<option value="" >ALL</option>
					<option value="svs" >SVS</option>
					<option value="mvs" selected>MVS</option>
				<%	}else{	%>
					<option value="" selected>ALL</option>
					<option value="svs" >SVS</option>
					<option value="mvs" >MVS</option>
					<%}	%>				
			</SELECT>
			
		<br><br>
		<br>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: left !important;"><font
					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>
				<td style="width: 40px !important;">
					<!-- <a href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Bar"  style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a> -->
				</td>

				<td style="width: 50px !important; text-align: right !important">
					<!-- <a href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Pie" style="color: green !important; font-size: 13px;"	id="showGraph"><img width="30px"
						src="/pred/resources/graphs/pie.png"></a> --> &nbsp;&nbsp;
				</td>
			</tr>
		</table>

		<br />
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px"
			bordercolor=#000000
			style="border-collapse: collapse; margin-top: 20px !important;"
			bgcolor="#ffffff" align="center">
			<tr align=center align=center>
				<td class=btext rowspan=3 style="width: 30px !important;">SNO</td>
				<td class=btext rowspan=3>&nbsp;&nbsp;&nbsp;&nbsp;Programme&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td class=btext colspan="11">No. of Works</td>
			</tr>
			<tr align=center align=center>
				<td class=btext rowspan=2>Admin Sanctioned</td>
				<td class=btext rowspan=2>Not Grounded<br>(3-5)
				</td>
				<td class=btext rowspan=2>Grounded</td>
				<td class=btext rowspan=2>Completed</td>
				<td class=btext rowspan=2>Under Progress<br>(5-6)
				</td>
				<td class=btext colspan="6">Time Exceeding from Stipulated date
					of completion</td>
			</tr>
			<tr align=center align=center>
				<td class=btext>Not Exceeded<br>(0 days)
				</td>
				<td class=btext>1-6 Months</td>
				<td class=btext>6-12 Months</td>
				<td class=btext>1-2 Years</td>
				<td class=btext>2-3 Years</td>
				<td class=btext>>3 Years</td>
			</tr>
			<tr align=center align=center>
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
				<td class=btext>11</td>
				<td class=btext>12</td>
				<td class=btext>13</td>
			</tr>

			<%
				int styleCount = 0;
				String style = "";
				Connection connection = null;
				Statement stmt1,stmt2,stmt3,stmt4,stmt5,stmt6;
				ResultSet rs1,rs2,rs3,rs4,rs5,rs6;
                stmt1=null;rs1=null;stmt2=null;rs2=null;stmt3=null;rs3=null;
                stmt4=null;rs4=null;stmt5=null;rs5=null;stmt6=null;rs6=null;
                int slno = 1;                                                      
		        int totadmin_sanc=0; int totgrounded=0;int totUnder_progress=0;   int totcomp=0,totnotgrou=0;
		        int tot_days0=0;
                int tot_mons1to6=0;
                int tot_mons6to12=0;
                int tot_yearsg1=0;
                int tot_yearsg2=0;
                int tot_yearsg3=0;
				try {
					String programme = "";
					//String schemes = "'01','02','03','10'";
					for (int i = 1; i <= programmeList.size(); i++) 
					{
                        int admin_sactioned = 0;
                        int grounded = 0;
                        int under_progres = 0;
                        int completed= 0;
                        int not_grou=0;	
                        int days0=0;
                        int mons1to6=0;
                        int mons6to12=0;
                        int yearsg1=0;
                        int yearsg2=0;
                        int yearsg3=0;
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
						rs1 = stmt1.executeQuery(admin_Query);        //System.out.println("admin_Query"+admin_Query);
						if (rs1.next()) {
						admin_sactioned=rs1.getInt(1);
                        }
						stmt1.close();
						rs1.close();
						/*  String Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a where a.work_id not in "
								   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
                                 +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
                                 +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                                 +"  a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                                 +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
						stmt2= conn.createStatement();     
			           //System.out.println("Not Grounded_Query"+Not_Grounded_Query);
						rs2= stmt2.executeQuery(Not_Grounded_Query);
						if (rs2.next()) {
							not_grou=rs2.getInt(1);
			             }
						stmt2.close();
						rs2.close(); */
					
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
                                not_grou=admin_sactioned-grounded;
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
						String under_Query="select count (distinct a.work_id) from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and b.GROUNDING_DATE is not null " 
                                +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                                +" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                                +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";                      
						stmt6= conn.createStatement();           //System.out.println("completed_Query"+completed_Query);
						rs6 = stmt6.executeQuery(under_Query);
						if (rs6.next()) {
							under_progres=rs6.getInt(1);
                     }
						stmt6.close();
						rs6.close();  
						String stip_qry="select distinct to_char(C.Date_Of_Completion,'DD-MM-YYYY'),a.work_id from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and b.GROUNDING_DATE is not null " 
                                +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                                +" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                                +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";                                     
              /*  String Grounded_Query="select count (distinct a.work_id) from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a where a.work_id not in "
                       +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and b.GROUNDING_DATE is not null " 
                       +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                       +" a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                       +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";  */
						stmt4= conn.createStatement();     
			               //System.out.println("Grounded_Query"+stip_qry);
						rs4= stmt4.executeQuery(stip_qry);
						while (rs4.next()) {
							if(rs4.getString(1)!=null){
							String qry="SELECT MONTHS_BETWEEN (TO_DATE('"+cDate+"','DD-MM-YYYY'),TO_DATE('"+rs4.getString(1)+"','DD-MM-YYYY') ) as Months  FROM DUAL ";
							//System.out.println("betwwe"+qry);
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(qry); 
							Double months=0.0;
						//	System.out.println("admin_Query"+qry); 
							if (rs1.next()) {
								months=rs1.getDouble("Months");
								//System.out.println("Months"+months);								
							if(months>36)
								yearsg3++;	
							else if(months>24)
								yearsg2++;
							else if(months>12)
								yearsg1++;
							else if(months>6)
								mons6to12++;
							else if(months>0)
								mons1to6++;								 
	                        else if(months<=0)
	                        	days0++;
							}
							stmt1.close();
							rs1.close();
			 			}}
						stmt4.close();
						rs4.close();   
						
						
						
				if(	admin_sactioned == 0&&
                    grounded == 0&&
                    under_progres == 0&&
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
				<td class="<%=style%>" style="text-align: left;" align="left"><a
					href="./rws_min_work_flow_stip_div_subdiv_rpt.jsp?mode=circles&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>&schemes=<%=schemes%>"><%=programmeName%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> admin_sactioned &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=admin_sactioned%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right">
					<%-- <a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=not_grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Not Grounded  &year=<%=yearStart%>')"> --%><%=not_grou%><!-- </a> -->
				</td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> grounded  &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=grounded%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> completed  &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=completed%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=underprogress&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Under Progress &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=under_progres%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=days0&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Time Not Exceeded from Stipulated date of completion  &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=days0%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=mons1to6&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Time Exceeding from Stipulated date of completion 1 to 6 months &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=mons1to6%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=mons6to12&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Time Exceeding from Stipulated date of completion 6 to 12 months &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=mons6to12%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg1&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Time Exceeding from Stipulated date of completion greater than 1 year  &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg1%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg2&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Time Exceeding from Stipulated date of completion greater than 2 years &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg2%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg3&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Time Exceeding from Stipulated date of completion greater than 3 years &year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg3%></a></td>
			</tr>
			<% 
			}     		                
                totadmin_sanc+=admin_sactioned;
                totnotgrou+=not_grou;
                totgrounded+=grounded;
                totcomp+=completed;
                totUnder_progress+=under_progres;
                tot_days0+=days0;
                tot_mons1to6+=mons1to6;
                tot_mons6to12+=mons6to12;
                tot_yearsg1+=yearsg1;
                tot_yearsg2+=yearsg2;
                tot_yearsg3+=yearsg3;
                
                
         }                                                     
%>
			<tr>
				<td class="btext" style="text-align: right;" colspan=2>Total</td>
				<td class="btext" style="text-align: right;"><%=totadmin_sanc %></td>
				<td class="btext" style="text-align: right;"><%=totnotgrou %></td>
				<td class="btext" style="text-align: right;"><%=totgrounded %></td>
				<td class="btext" style="text-align: right;"><%=totcomp %></td>
				<td class="btext" style="text-align: right;"><%=totUnder_progress %></td>
				<td class="btext" style="text-align: right;"><%=tot_days0 %></td>
				<td class="btext" style="text-align: right;"><%=tot_mons1to6 %></td>
				<td class="btext" style="text-align: right;"><%=tot_mons6to12 %></td>
				<td class="btext" style="text-align: right;"><%=tot_yearsg1 %></td>
				<td class="btext" style="text-align: right;"><%=tot_yearsg2 %></td>
				<td class="btext" style="text-align: right;"><%=tot_yearsg3 %></td>
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
		<table>
			<tr>
				<td><font color="green" size="2">Note:</font></td>
			</tr>
			<tr>
				<td><font color="red" size="1">1.Grounded works =
						Technical Sanction + Source Identification + Contractor Management
						+ Programme Schedule</font></td>
			</tr>
			<tr>
				<td><font color="red" size="1">2.Not Grounded Works =
						Admin Sanctioned Works - Grounded Works</font></td>
			</tr>
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
		
	</form>
</BODY>
</html>

