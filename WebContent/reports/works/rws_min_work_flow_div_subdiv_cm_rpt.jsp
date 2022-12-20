
<%@ page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
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
			<font color="#663899" face="Maiandra GD" size="4px"><b>Works Progress - Work Flow <br/><br/> Programme: <%=programmeName %>
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
				<td class=btext rowspan=2 style="width: 30px !important;">SNO</td>
				<%if(mode.equals("circles")){ %>
				<td class=btext rowspan=2>Circle</td>
				<%}else if(mode.equals("divisions")){ %>
				<td class=btext rowspan=2>Division</td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class=btext rowspan=2>Sub Division</td>
				<%} %>
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
				 int total=0;
				Connection connection = null;
				Statement stmt1,stmt2,stmt3,stmt4,stmt5,stmt6;
				ResultSet rs1,rs2,rs3,rs4,rs5,rs6;
               stmt1=null;rs1=null;stmt2=null;rs2=null;stmt3=null;rs3=null;
                stmt4=null;rs4=null;stmt5=null;rs5=null;stmt6=null;rs6=null;
                int totadmin_sanc=0; 
               int totCommissioned=0; int totgrounded=0;
                 int totcomp=0,totnotgr=0;                          
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
					String schemes = "'01','02','03','10'";
					/* String districtQuery="select circle_office_code,INITCAP(circle_office_name) as circle_office_name from rws_circle_office_tbl order by circle_office_code";
					Statement statement1 = conn.createStatement();
					ResultSet resultSet1 = statement1.executeQuery(districtQuery);
					
					while (resultSet1.next()) {
						ccode=resultSet1.getString("circle_office_code");
						cname=resultSet1.getString("circle_office_name"); */
			  int slno = 0;
			                                                                        // System.out.println("@@@@@@@@@@@@@@");
						//************Related to works**************//
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
           	  int commissioned = 0;
              int grounded = 0;
              int completed= 0;
              int not_grou=0;
            
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
	                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<='31-MAR-"+yearStart+"') " 
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
                comission_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id in "
                        +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMM is not null and DATE_OF_COMM>='01-APR-"+yearStart+ "') and b.GROUNDING_DATE is not null " 
                        +" and  substr(a.work_id,7,2) in ("+ schemes+ ") and b.work_id=a.work_id and e.work_id=a.work_id and c.work_id=a.work_id and a.CORE_DASHBOARD_STATUS='Y' and "
                        +" s.work_id=a.work_id and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		if(mode.equals("circles")){
			adminworksQuery+=" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			Not_Grounded_Query+="  and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			
			groundedQuery+=" and substr(b.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			comission_Query+=" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			completedQuery+=" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			adminworksQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			Not_Grounded_Query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			groundedQuery+=" and substr(b.office_code,2,2)='"+ccode+"' and substr(b.office_code,4,1)='"+res.getString("division_office_code")+"'";
			comission_Query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			completedQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			adminworksQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			Not_Grounded_Query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			groundedQuery+=" and substr(b.office_code,2,2)='"+ccode+"' and substr(b.office_code,4,1)='"+divCode+"' and substr(b.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			comission_Query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			completedQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}                                                                                                      //   System.out.println("Queryyyyyyyyyyyyy"+adminworksQuery);
								PreparedStatement statement1 = conn.prepareStatement(adminworksQuery);
								ResultSet resultSet1 = statement1.executeQuery();
                            //System.out.println("techworksQueryQueryyyyyyyyyyyyy"+techworksQuery);
								PreparedStatement statement2 = conn.prepareStatement(Not_Grounded_Query);
								ResultSet resultSet2 = statement2.executeQuery();
                                  //   System.out.println("entrustedQueryQueryyyyyyyyyyyyy"+entrustedQuery);
								PreparedStatement statement4 = conn.prepareStatement(groundedQuery);
								ResultSet resultSet4 = statement4.executeQuery();
                                  //  System.out.println("underprogresQueryQueryyyyyyyyyyyyy"+underprogresQuery);
								PreparedStatement statement5 = conn.prepareStatement(comission_Query);
								ResultSet resultSet5= statement5.executeQuery();
                            //  System.out.println("completedQueryQueryyyyyyyyyyyyy"+completedQuery);
								PreparedStatement statement6 = conn.prepareStatement(completedQuery);
								ResultSet resultSet6 = statement6.executeQuery();                                            
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
								if (resultSet2.next()) {
									not_grou=resultSet2.getInt(1);
									totnotgr+=not_grou;                                             
            					} else {
            						not_grou=0; }                                                                
								                                                              
								if (resultSet4.next()) {
									grounded=resultSet4.getInt(1);
                               		totgrounded+=grounded;
                                }else {
                                	grounded=0; }                                                                
                               if (resultSet5.next()) {
									commissioned=resultSet5.getInt(1);
                               		 totCommissioned+=commissioned;
                                }else {
                                	commissioned=0; }
								if (resultSet6.next()) {
									completed=resultSet6.getInt(1);
                                    totcomp+=completed;
                                } else {
                                   completed=0; }
                                  
              if(admin_sactioned==0 && commissioned==0&&grounded==0&&completed==0&&not_grou==0){
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
				<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_min_work_flow_div_subdiv_cm_rpt.jsp?mode=divisions&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>"><%=cname%></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_min_work_flow_div_subdiv_cm_rpt.jsp?mode=subdivisions&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>"><%=divName%></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
				<%} %>                                              
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Admin Sanctioned&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=admin_sactioned %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Admin Sanctioned&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=admin_sactioned %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=admin_sactioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Admin Sanctioned&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=admin_sactioned %></a></td>
				<%} %>                                                
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=not_grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Not Grounded&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=not_grou %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=not_grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Not Grounded &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=not_grou %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=not_grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Not Grounded&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=not_grou %></a></td>
				<%} %>                                            
				                                            
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Grounded&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=grounded %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Grounded&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=grounded %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=grounded&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Grounded&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=grounded %></a></td>
				<%} %>                                                
				                                                            
				<%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Completed&ccode=<%=ccode%>&year=<%=yearStart%>')"><%=completed %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Completed&ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=completed %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=completed&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Completed&ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=completed %></a></td>
				<%} %>
               <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=commissioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle <%=programmeName%> Commissioned &ccode=<%=ccode%>&year=<%=yearStart%>')"><%=commissioned %></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=commissioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division <%=programmeName%> Commissioned &ccode=<%=ccode%>&divcode=<%=divCode%>&year=<%=yearStart%>')"><%=commissioned %></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_min_work_flow_status_cm_drill.jsp?mode=commissioned&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=cname%> Circle, <%=divName%> Division, <%=subdivName%> SubDivision <%=programmeName%> Commissioned &ccode=<%=ccode%>&divcode=<%=divCode%>&subdivcode=<%=subdivCode%>&year=<%=yearStart%>')"><%=commissioned %></a></td>
				<%} 
                
                   }        
                 }
                              
  %>
          <tr>
                <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total</td>
				<td class="btext" style="text-align: right;"><%=totadmin_sanc %></td>
				<td class="btext" style="text-align: right;"><%=totnotgr %></td>
				<td class="btext" style="text-align: right;"><%=totgrounded %></td>
				<td class="btext" style="text-align: right;"><%=totcomp %></td>
                 <td class="btext" style="text-align: right;"><%=totCommissioned %></td>
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
        String mode1= request.getParameter("mode");
       // System.out.println("mode1"+mode1);
        if(mode1==null || mode1==""){
        	mode1="Bar";
        }
    %>
           <head>
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
            }
            .bar-chart ul{
                            margin-left: 30px !important; 
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
   <%--  <body>
        <%
               String ar[]=names.split(",");
                int width=0;

    	width=ar.length*120;
    	if(width>1000){
    		
    	}
    	else{
    		width=1050;
    	}
     %>
       
   
        <form id="graphParams" name="graphParams" action="rws_work_flow_div_subdiv_cm_rpt.jsp">
            <input type="hidden" id="mode1" name="mode1" value="<%=mode1%>"/>
        <div class="wrap" style="margin-top: -30px !important; width: <%=width%>px !important; text-align: center !important;">
           <br/><br/>
                     <%
           int top=35,left=-(52*ar.length);
                   int len=ar.length;
                   len=100*len;
                    if(ar.length<=3){
                	   len=85*(ar.length+1);
                     left=-(65*ar.length);
             
                   } 
                   //System.out.println(len);
                   int graphleft=ar.length*ar.length;
                 //  graphleft=-graphleft-480;
                   graphleft=-ar.length*55;
                   if(ar.length<=3){
                	   graphleft=-(ar.length+1)*85;
                   }
                 //  System.out.println(graphleft);
                  
                   
                   %><br/>   
            <div id="distChart" style=" padding-left: 50px;  padding-bottom: 100px;   padding-top: 20px; border : 1px double #c67; border-radius: 10px;">
               <div class="desc" style="text-align: center; font-weight: bold;">
            </div>
            <br/>
                <p style="font-weight: normal; text-align: center;">
                 <span style="background-color: #546E28;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Admin Sactioned&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="background-color: #EE761E;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Tech. Sanctioned&nbsp;&nbsp;&nbsp;&nbsp;
                   <!--<span style="background-color: #C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Entrusted&nbsp;&nbsp;&nbsp;&nbsp;-->
                    <span style="background-color: #C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Grounded&nbsp;&nbsp;&nbsp;&nbsp;
                  <!--  <span style="background-color: #C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Under Progress&nbsp;&nbsp;&nbsp;&nbsp;-->
                    <span style="background-color: #034f84;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Completed&nbsp;&nbsp;&nbsp;&nbsp;
                   
                </p>
                <br/>
     
     
                <div class="chart" style="left: 0px ; height: 300px;">
                    <ul id="distChartUL" class="bar-chart" data-bars="<%=inputWorks%>" data-max="" data-unit="" data-width="15" style="width: <%=len %>;" >
                    <ul><li style="height:300px"></li></ul>
                    </ul>
                    <p style="transform: rotate(270deg);position: relative;top: 120px; left: <%=graphleft%>px; font-weight: bold;margin-left: -60px !important;">No. of Works</p>
                   
                       
                    <p style="margin-left: 25px !important;">
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                    
                   <%
                   for(int i=0;i<ar.length;i++){
                	   top=top-16;
                    left=left+93;
                	   
                	  // System.out.println("left-----"+left);
                   %>
                   
                   <h4 style="transform: rotate(-30deg);top: <%=top%>px;position: relative;left: <%=left%>px;"><%=ar[i] %></h4>
                   
                   <%}%>
                   </p>
                    <br/>
                   
                </div>
             
            </div>
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
    </body>
</html> --%>
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

