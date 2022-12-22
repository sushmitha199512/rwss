
<%@ page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%

	DecimalFormat ndf = new DecimalFormat("####.00");
	
    String coc = request.getParameter("coc");
    String con = request.getParameter("con");
    String doc = request.getParameter("doc");
    String don = request.getParameter("don");
	HashMap distMap = new HashMap();
	String rDistrict = "";
	String finyear = "";
	
	//String programe = "";
	String mode = "";
    if (request.getParameter("mode") != null){
		mode = request.getParameter("mode");
                
                }
	//System.out.println("mode"+mode);
	String programme = request.getParameter("programme");
      
	String programmeName=request.getParameter("programmeName");
        // System.out.println("programmeName"+programmeName);
	if (request.getParameter("finyear") != null)
		finyear = request.getParameter("finyear");
        // System.out.println("finyear"+finyear);}
	else {
		Statement stmtt = conn.createStatement(
				ResultSet.TYPE_SCROLL_SENSITIVE,
				ResultSet.CONCUR_UPDATABLE);
		ResultSet rss = stmtt.executeQuery("select distinct to_char(max(status_date),'dd-MON-yyyy') from rws_habitation_directory_tbl");
		while (rss.next()) {
			finyear = rss.getString(1);
		}
		int yr = Integer.parseInt(finyear.substring(7, finyear.length()));
		finyear = yr + "-" + (yr + 1);
	}
	String schemes=request.getParameter("schemes");
	session.setAttribute("finyear", finyear);
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
	lastMonth = lastMonth.substring(0, 1).toUpperCase()
			+ lastMonth.substring(1).toLowerCase();
	currentMonth = currentMonth.substring(0, 1).toUpperCase()
			+ currentMonth.substring(1).toLowerCase();
	String ye=""+yearEnd;
    ye=ye.substring(2,4).toString();    
    int yEnd=Integer.parseInt(ye);
    String names="";
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
			<font color="#663899" face="Maiandra GD" size="4px"><b>Work Flow and Progress Duration Status (as per stipulated date of completion) <br/><br/> Programme: <%=programmeName %>
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
				<td class=btext rowspan=3 style="width: 30px !important;">SNO</td>
				<%if(mode.equals("circles")){ %>
				<td class=btext rowspan=3>Circle</td>
				<%}else if(mode.equals("divisions")){ %>
				<td class=btext rowspan=3>Division</td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class=btext rowspan=3>Sub Division</td>
				<%} %>
             <td class=btext colspan="11">No. of Works </td>
        	 </tr>	
			<tr align=center align=center>
                 <td class=btext rowspan=2>Admin Sanctioned</td>
                 <td class=btext rowspan=2>Not Grounded<br>(3-5)</td>
				 <td class=btext rowspan=2>Grounded</td>
                 <td class=btext rowspan=2>Completed</td>
				 <td class=btext rowspan=2>Under Progress<br>(5-6)</td>
				 <td class=btext colspan="6">Time Exceeding from Stipulated date of completion</td> 				 
			</tr>
			<tr align=center align=center>
                 <td class=btext >Not Exceeded<br>(0 days)</td>
                 <td class=btext >1-6 Months</td>
				 <td class=btext >6-12 Months</td>
                 <td class=btext >1-2 Years</td>
				 <td class=btext >2-3 Years</td>
				 <td class=btext >>3 Years</td> 				 
			</tr>
			<tr align=center align=center>
				<td class=btext >1</td> 
				<td class=btext >2</td> 
				<td class=btext >3</td> 
				<td class=btext >4</td>
				<td class=btext >5</td> 
				<td class=btext >6</td> 
				<td class=btext >7</td> 
				<td class=btext >8</td>
				<td class=btext >9</td> 
				<td class=btext >10</td> 
				<td class=btext >11</td> 
				<td class=btext >12</td>   
				<td class=btext >13</td>	
			</tr>
			<%
				int styleCount = 0;
				String style = "";
				int total=0;
				Connection connection = null;
				Statement stmt1,stmt2,stmt3,stmt4,stmt5,stmt6;
				ResultSet rs1,rs2,rs3,rs4,rs5,rs6;
                stmt1=null;rs1=null;stmt2=null;rs2=null;stmt3=null;rs3=null;
                stmt4=null;rs4=null;stmt5=null;rs5=null;stmt6=null;rs6=null;
                int totadmin_sanc=0; 
               int totUnder_progress=0; int totgrounded=0;
                 int totcomp=0,totnotgr=0;    
                 int tot_days0=0;
                 int tot_mons1to6=0;
                 int tot_mons6to12=0;
                 int tot_yearsg1=0;
                 int tot_yearsg2=0;
                 int tot_yearsg3=0;
           String ccode = "";
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
                 //divname = request.getParameter("divname");
             }                                              
				try {
					//String schemes = "'01','02','03','10'";
					/* String districtQuery="select circle_office_code,INITCAP(circle_office_name) as circle_office_name from rws_circle_office_tbl order by circle_office_code";
					Statement statement1 = conn.createStatement();
					ResultSet resultSet1 = statement1.executeQuery(districtQuery);
					
					while (resultSet1.next()) {
						ccode=resultSet1.getString("circle_office_code");
						cname=resultSet1.getString("circle_office_name"); */
			  int slno = 0;
			  
           String adminworksQuery="";
		   String Not_Grounded_Query="";
            String groundedQuery="";
           String comission_Query="";
           String completedQuery="";
           String query = "";                                      
           if(mode.equals("circles")){
               query="select circle_office_code,circle_office_name from rws_circle_office_tbl  order by circle_office_code";
           }
           else if(mode.equals("divisions")){
                 query="select division_office_code,division_office_name from rws_division_office_tbl where  circle_office_code='"+ccode+"' and status <> 'UI' order by division_office_code";
           } else if(mode.equals("subdivisions")){
                 query="select subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where  circle_office_code='"+ccode+"' and division_office_code='"+divCode+"' order by subdivision_office_code";
           }
            //  System.out.println("query"+query);
          PreparedStatement preparedStatement = conn.prepareStatement(query);
          ResultSet res = preparedStatement.executeQuery();
          while(res.next()){  
        	  int admin_sactioned = 0;
			  int under_progres = 0;
              int grounded = 0;
              int completed= 0;
              int not_grou=0;
              int days0=0;
              int mons1to6=0;
              int mons6to12=0;
              int yearsg1=0;
              int yearsg2=0;
              int yearsg3=0;
       
		adminworksQuery="select count(distinct a.work_id) from RWS_WORK_ADMN_TBL a where "
	                +" WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') "
	                +"and substr(a.work_id,7,2) in ("+ schemes+ ") and PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and "
	                +"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.CORE_DASHBOARD_STATUS='Y'";
	   Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a where a.work_id not in "
							   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
                          +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null )  " 
                          +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                          +"  a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                          +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
	   groundedQuery="select count (distinct b.work_id) from RWS_WORK_COMMENCEMENT_TBL a,RWS_WORK_ADMN_TBL b,RWS_CONTRACTOR_SELECTION_TBL c,rws_new_est_tbl e,RWS_SOURCE_IDEN_FIN_TBL s where b.work_id not in "
	                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') " 
	                +" and substr(b.work_id,7,2) in ("+ schemes+ ") and  WORK_CANCEL_DT is null"
	                +" and b.work_id=e.work_id  and a.work_id=b.work_id and c.work_id=b.work_id and  b.CORE_DASHBOARD_STATUS='Y' and b.work_id=s.work_id and b.PROGRAMME_CODE in ("+programme+")"
	                +" and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	  /*  completedQuery="select count(distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s,rws_new_est_tbl e,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where a.work_id in "
	               +" (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>'31-MAR-"+yearStart+ "')" 
                   +" and h.work_id=a.work_id and hd.hab_code=h.hab_code and substr(a.work_id,7,2) in ("+ schemes+ ") and a.work_id=b.work_id and a.work_id=c.work_id and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=s.work_id and a.work_id=e.work_id"
                   +" and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')"; */
                   
        completedQuery="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id in "
                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+yearStart+ "') and b.GROUNDING_DATE is not null " 
                +" and  substr(a.work_id,7,2) in ("+ schemes+ ") and b.work_id=a.work_id and e.work_id=a.work_id and c.work_id=a.work_id and a.CORE_DASHBOARD_STATUS='Y' and "
                +" s.work_id=a.work_id and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
        String under_Query="select count (distinct a.work_id) from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and b.GROUNDING_DATE is not null " 
                +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                +" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
        String stip_qry="select distinct to_char(C.Date_Of_Completion,'DD-MM-YYYY'),a.work_id from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and b.GROUNDING_DATE is not null " 
                +"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                +" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' "
                +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
		if(mode.equals("circles")){
			adminworksQuery+=" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			Not_Grounded_Query+="  and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			groundedQuery+=" and substr(b.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			under_Query+=" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			completedQuery+=" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			stip_qry+=" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			adminworksQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			Not_Grounded_Query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			groundedQuery+=" and substr(b.office_code,2,2)='"+ccode+"' and substr(b.office_code,4,1)='"+res.getString("division_office_code")+"'";
			under_Query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			completedQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			stip_qry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			adminworksQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			Not_Grounded_Query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			groundedQuery+=" and substr(b.office_code,2,2)='"+ccode+"' and substr(b.office_code,4,1)='"+divCode+"' and substr(b.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			under_Query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			completedQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			stip_qry+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}                                                                                                      //   System.out.println("Queryyyyyyyyyyyyy"+adminworksQuery);
								PreparedStatement statement1 = conn.prepareStatement(adminworksQuery);
								ResultSet resultSet1 = statement1.executeQuery();
                            //System.out.println("techworksQueryQueryyyyyyyyyyyyy"+techworksQuery);
								/* PreparedStatement statement2 = conn.prepareStatement(Not_Grounded_Query);
								ResultSet resultSet2 = statement2.executeQuery(); */
                                 //   System.out.println("entrustedQueryQueryyyyyyyyyyyyy"+entrustedQuery);
								PreparedStatement statement4 = conn.prepareStatement(groundedQuery);
								ResultSet resultSet4 = statement4.executeQuery();
                                  //  System.out.println("underprogresQueryQueryyyyyyyyyyyyy"+underprogresQuery);
								PreparedStatement statement5 = conn.prepareStatement(under_Query);
								ResultSet resultSet5= statement5.executeQuery();
                            //  System.out.println("completedQueryQueryyyyyyyyyyyyy"+completedQuery);
								PreparedStatement statement6 = conn.prepareStatement(completedQuery);
								ResultSet resultSet6 = statement6.executeQuery(); 
								PreparedStatement statement7 = conn.prepareStatement(stip_qry);
								ResultSet resultSet7 = statement7.executeQuery(); 
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
								if (resultSet1.next()) {
								admin_sactioned=resultSet1.getInt(1);
		                                totadmin_sanc+=admin_sactioned;
		                         }else {
		                                admin_sactioned=0; }                                                                            	
							/* 	if (resultSet2.next()) {
									not_grou=resultSet2.getInt(1);
									totnotgr+=not_grou;                                             
            					} else {
            						not_grou=0; } */                                                                
								                                                              
								if (resultSet4.next()) {
									grounded=resultSet4.getInt(1);
                               		totgrounded+=grounded;
                                }else {
                                	grounded=0; } 
            						not_grou=admin_sactioned-grounded;
									totnotgr+=not_grou; 	
            						
                               if (resultSet5.next()) {
									under_progres=resultSet5.getInt(1);
                               		 totUnder_progress+=under_progres;
                                }else {
                                	under_progres=0;
                                }
								if (resultSet6.next()) {
									completed=resultSet6.getInt(1);
                                    totcomp+=completed;
                                } else {
                                   completed=0; }
								while (resultSet7.next()) {
									if(resultSet7.getString(1)!=null){
									String qry="SELECT MONTHS_BETWEEN (TO_DATE('"+today+"','DD-MM-YYYY'),TO_DATE('"+resultSet7.getString(1)+"','DD-MM-YYYY') ) as Months  FROM DUAL ";
									//System.out.println("betwwe"+qry);
									stmt1 = conn.createStatement();
									rs1 = stmt1.executeQuery(qry); 
									Double months=0.0;
									//System.out.println("admin_Query"+qry); 
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
								statement7.close();
								resultSet7.close();  
								
                                  
              if(admin_sactioned==0 && under_progres==0&&grounded==0&&completed==0&&not_grou==0){
              }else{
            	  if (styleCount % 2 == 0) {
      				style = "gridbg1";
      			} else {
      				style = "gridbg2";
      			}
      		styleCount++;
             
                  names+=res.getString(2)+",";                  
              %>
        	<tr>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_min_work_flow_stip_div_subdiv_rpt.jsp?mode=divisions&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&schemes=<%=schemes%>"><%=cname%></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_min_work_flow_stip_div_subdiv_rpt.jsp?mode=subdivisions&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>"><%=divName%></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
				<%} %>                                              
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Admin Sanctioned&ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=admin_sactioned %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Admin Sanctioned&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=admin_sactioned %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Admin Sanctioned&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=admin_sactioned %></a></td>
				<%} %>                                                
			<%-- 	<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=not_grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Not Grounded&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=not_grou %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=not_grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Not Grounded &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=not_grou %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=not_grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Not Grounded&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=not_grou %></a></td>
				<%} %>   --%> 
	
				<td class="<%=style%>" style="text-align: right;" align="right"><%=not_grou %></td>
				                                           
				                                            
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Grounded&ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=grounded %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Grounded&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=grounded %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Grounded&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=grounded %></a></td>
				<%} %>                                                
				                                                            
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Completed&ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=completed %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Completed&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=completed %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Completed&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=completed %></a></td>
				<%} %>
               <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=underprogress&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Under Progress &ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=under_progres %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=underprogress&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Under Progress &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=under_progres %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=underprogress&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Under Progress &ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=under_progres %></a></td>
				<%} %>
               <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=days0&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Time not Exceeded from Stipulated date of completion &ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=days0 %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=days0&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Time not Exceeded from Stipulated date of completion &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=days0 %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=days0&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Time not Exceeded from Stipulated date of completion &ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=days0 %></a></td>
				<%} %>
               <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=mons1to6&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Time Exceeding from Stipulated date of completion 1-6 months &ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=mons1to6 %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=mons1to6&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Time Exceeding from Stipulated date of completion 1-6 months &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=mons1to6 %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=mons1to6&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Time Exceeding from Stipulated date of completion 1-6 months &ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=mons1to6 %></a></td>
				<%} %>
               <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=mons6to12&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Time Exceeding from Stipulated date of completion 6-12 months&ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=mons6to12 %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=mons6to12&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Time Exceeding from Stipulated date of completion 6-12 months &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=mons6to12 %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=mons6to12&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Time Exceeding from Stipulated date of completion 6-12 months&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=mons6to12 %></a></td>
				<%} %>
               <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg1&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Time Exceeding from Stipulated date of completion > 1 year &ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg1 %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg1&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Time Exceeding from Stipulated date of completion > 1 year &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg1 %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg1&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Time Exceeding from Stipulated date of completion > 1 year &ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg1 %></a></td>
				<%} %>
	             <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg2&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Time Exceeding from Stipulated date of completion > 2 years  &ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg2 %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg2&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Time Exceeding from Stipulated date of completion > 2 years &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg2 %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg2&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Time Exceeding from Stipulated date of completion > 2 years  &ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg2 %></a></td>
				<%} %>
               <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg3&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Time Exceeding from Stipulated date of completion > 3 years &ccode=<%=ccode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg3 %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg3&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Time Exceeding from Stipulated date of completion > 3 years &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg3 %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_stip_date_drill.jsp?mode=yearsg3&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Time Exceeding from Stipulated date of completion > 3 years &ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>&schemes=<%=schemes%>')"><%=yearsg3 %></a></td>
				<%}                 
                   }
              tot_days0+=days0;
              tot_mons1to6+=mons1to6;
              tot_mons6to12+=mons6to12;
              tot_yearsg1+=yearsg1;
              tot_yearsg2+=yearsg2;
              tot_yearsg3+=yearsg3;
                 }
               
  %>
         
            <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total</td>
				<td class="btext" style="text-align: right;"><%=totadmin_sanc %></td>
				<td class="btext" style="text-align: right;"><%=totnotgr %></td>
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
		<br />
		 <table>
		  			<tr>
					<td>
					<font color="green" size="2">Note:</font>					
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">1.Grounded works = Technical Sanction + Source Identification + Contractor Management + Programme Schedule</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">2.Not Grounded Works = Admin Sanctioned Works - Grounded Works</font>
					</td>
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
		<br />
</BODY> 

