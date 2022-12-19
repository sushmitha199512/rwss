
<%@ page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>



<%

	DecimalFormat ndf = new DecimalFormat("####.00");
	
  
	
	String finyear = "";
	
	//String programe = "";
	String mode = "";
        String inputWorks="";
                    String admnSan="";
                     String TechSan="";
                      String entru="";
                      String grou="";
                       String undProg="";
                       String comp="";
                       

	if (request.getParameter("mode") != null){
		mode = request.getParameter("mode");
                
                }
	String dcode = "",dname="",mcode="",mname="";
    if(mode.equals("mandals")){
   	 dcode = request.getParameter("dcode");
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
		if(rss != null)
			rss.close();
		if(stmtt != null)
			stmtt.close();
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
			<font color="#663899" face="Maiandra GD" size="4px"><b>JJM Works Progress - Work Flow <br/><br/> Programme: JJM
			<% 
			//HttpSession session = request.getSession();
			if(mode != null && mode.equals("districts")){
			RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
			
			final String userId = user.getUserId();
			String circle = userId.substring(1, 3);
			//String[] circleCode = {"01","02","03","04","05","06","07","08","09","10","11","12","13"};
			if (circle.matches("[0-9]{1,13}(\\.[0-9]*)?")){
				if(circle.equalsIgnoreCase("00"))
					mode = "districts";
				else{
					mode = "mandals";
					dcode = circle;
				}
			}
			}
			
			if(mode.equals("mandals")){ %>
			 , District: <%=request.getParameter("dname") %>
			<%} %>
			</b></font> <br />
			
		</center>

		<br />
		
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
		
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px"
			bordercolor=#000000
			style="border-collapse: collapse; margin-top: 20px !important;"
			bgcolor="#ffffff" align="center">
			<tr align=center align=center>
				<td class=btext rowspan=2 style="width: 30px !important;">SNO</td>
				<%if(mode.equals("districts")){ %>
				<td class=btext rowspan=2>District</td>
				<%}else if(mode.equals("mandals")){ %>
				<td class=btext rowspan=2>Mandal</td>
				<%}%>
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
				 int total=0;
				Connection connection = null;
				Statement stmt1,stmt2,stmt3,stmt4,stmt5,stmt6;
				ResultSet rs1,rs2,rs3,rs4,rs5,rs6;
               stmt1=null;rs1=null;stmt2=null;rs2=null;stmt3=null;rs3=null;
                stmt4=null;rs4=null;stmt5=null;rs5=null;stmt6=null;rs6=null;
                int totadmin_sanc=0; int tottech_sanc=0;
               int totentrusted=0; int totgrounded=0;int totunder_prog=0;
                 int totcomp=0,totnotgr=0;                          
          
           
                                                        
				try {
					String schemes = "'01','02','03','10'";
					
			  int slno = 0;
			  int admin_sactioned = 0;
           	  int tech_sanctioned = 0;
              int entrusted = 0;
              int grounded = 0;
              int under_progress = 0;
              int completed= 0;
              int not_grou=0;;                                                                         // System.out.println("@@@@@@@@@@@@@@");
						//************Related to works**************//
		   String adminworksQuery="";
           String  techworksQuery="";
           String entrustedQuery="";
           String groundedQuery="";
           String underprogresQuery="";
           String completedQuery="";
           String query = "";       
           String amtCondition = "";
           if(mode.equals("districts")){
               query=" select dcode,dname from RWS_DISTRICT_TBL order by DCODE";
           }
           else if(mode.equals("mandals")){
                 query="select mcode,mname from RWS_MANDAL_TBL where DCODE='"+dcode+"' order by mcode";
           } 
          PreparedStatement preparedStatement = conn.prepareStatement(query);
          ResultSet res = preparedStatement.executeQuery();
          while(res.next()){                                               	
             if (styleCount % 2 == 0) {
				style = "gridbg1";
			} else {
				style = "gridbg2";
			}
		styleCount++; 
		
		
		if(programme.equals("89")){
			if(programmeName.contains("Below")){
				amtCondition = " and SANCTION_AMOUNT <=5 ";
			}else{
				amtCondition = " and SANCTION_AMOUNT >=5 ";
			}
		}else{
			amtCondition = "";
		}
		adminworksQuery="select count(distinct a.work_id) from RWS_WORK_ADMN_TBL a where "
	                +" WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') "
	                +"and substr(a.work_id,7,2) in ("+ schemes+ ") and PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and "
	                +"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.CORE_DASHBOARD_STATUS='Y' "+amtCondition;
	                
	   techworksQuery="select count(distinct a.work_id) from rws_new_est_tbl b,RWS_WORK_ADMN_TBL a where "
	                + " WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl "
	                +" where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and a.CORE_DASHBOARD_STATUS='Y' " 
	                +" and substr(a.work_id,7,2) in ("+schemes+ ") and a.work_id=b.work_id and PROGRAMME_CODE in ("+programme+")  and TARGET_DATE_COMP>='01-APR-"+ yearStart+"'"
	                +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') "+amtCondition;
	                
	  entrustedQuery="select count(distinct a.work_id) from RWS_CONTRACTOR_SELECTION_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e  where "
	                + " WORK_CANCEL_DT is null and a.work_id "
	                +" not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') "
	                +"and substr(a.work_id,7,2) in ("+ schemes+ ") and a.work_id=b.work_id and a.work_id=e.work_id and a.PROGRAMME_CODE in ("+programme+") and "
	                +" TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.CORE_DASHBOARD_STATUS='Y' "+amtCondition;
	                
	  groundedQuery="select count (distinct b.work_id) from RWS_WORK_COMMENCEMENT_TBL a,RWS_WORK_ADMN_TBL b,RWS_CONTRACTOR_SELECTION_TBL c,rws_new_est_tbl e,RWS_SOURCE_IDEN_FIN_TBL s where b.work_id not in "
	                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') " 
	                +" and substr(b.work_id,7,2) in ("+ schemes+ ") and  WORK_CANCEL_DT is null"
	                +" and b.work_id=e.work_id  and a.work_id=b.work_id and c.work_id=b.work_id and  b.CORE_DASHBOARD_STATUS='Y' and b.work_id=s.work_id and b.PROGRAMME_CODE in ("+programme+") "
	                +" and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') "+amtCondition;
	                
	  underprogresQuery="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s,rws_new_est_tbl e where a.work_id not in "
	                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION < '01-APR-"+yearEnd+"') " 
	                +" and substr(a.work_id,7,2) in ("+ schemes+ ") and  WORK_CANCEL_DT is null and "
	                +" a.work_id=b.work_id and a.work_id=e.work_id  and a.work_id=c.work_id and  a.CORE_DASHBOARD_STATUS='Y' and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+ programme+") "
	                +" and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') "+amtCondition;
	 /*  completedQuery="select count(distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s,rws_new_est_tbl e,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where a.work_id in "
	               +" (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>'31-MAR-"+yearStart+ "')" 
                   +" and h.work_id=a.work_id and hd.hab_code=h.hab_code and substr(a.work_id,7,2) in ("+ schemes+ ") and a.work_id=b.work_id and a.work_id=c.work_id and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=s.work_id and a.work_id=e.work_id"
                   +" and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')"; */
                   
        completedQuery="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id in "
                +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+yearStart+ "') and b.GROUNDING_DATE is not null " 
                +" and  substr(a.work_id,7,2) in ("+ schemes+ ") and b.work_id=a.work_id and e.work_id=a.work_id and c.work_id=a.work_id and a.CORE_DASHBOARD_STATUS='Y' and "
                +" s.work_id=a.work_id and a.PROGRAMME_CODE in ("+ programme+") and TARGET_DATE_COMP>='01-APR-"+ yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') "+amtCondition;
		
                /*
                As Chandana madam told that get works from district and mandals based on the lead habitation on 18-02-2021 
                */
                if(mode.equals("districts")){
			adminworksQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+res.getString("dcode")+"'";
			techworksQuery+="  and substr(a.LEAD_HABITATION,1,2)='"+res.getString("dcode")+"'";
			entrustedQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+res.getString("dcode")+"'";
			groundedQuery+=" and substr(b.LEAD_HABITATION,1,2)='"+res.getString("dcode")+"'";
			underprogresQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+res.getString("dcode")+"'";
			completedQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+res.getString("dcode")+"'";
		}else if(mode.equals("mandals")){ 
			adminworksQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+dcode+"' and substr(a.LEAD_HABITATION,6,2)='"+res.getString("mcode")+"'";
			techworksQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+dcode+"' and substr(a.LEAD_HABITATION,6,2)='"+res.getString("mcode")+"'";
			entrustedQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+dcode+"' and substr(a.LEAD_HABITATION,6,2)='"+res.getString("mcode")+"'";
			groundedQuery+=" and substr(b.LEAD_HABITATION,1,2)='"+dcode+"' and substr(b.LEAD_HABITATION,6,2)='"+res.getString("mcode")+"'";
			underprogresQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+dcode+"' and substr(a.LEAD_HABITATION,6,2)='"+res.getString("mcode")+"'";
			completedQuery+=" and substr(a.LEAD_HABITATION,1,2)='"+dcode+"' and substr(a.LEAD_HABITATION,6,2)='"+res.getString("mcode")+"'";
		}                                                                                                    //   System.out.println("Queryyyyyyyyyyyyy"+adminworksQuery);
								PreparedStatement statement1 = conn.prepareStatement(adminworksQuery);
								ResultSet resultSet1 = statement1.executeQuery();
                            //System.out.println("techworksQueryQueryyyyyyyyyyyyy"+techworksQuery);
								PreparedStatement statement2 = conn.prepareStatement(techworksQuery);
								ResultSet resultSet2 = statement2.executeQuery();
                                  //   System.out.println("entrustedQueryQueryyyyyyyyyyyyy"+entrustedQuery);
								PreparedStatement statement3 = conn.prepareStatement(entrustedQuery);
								ResultSet resultSet3 = statement3.executeQuery();
                      //System.out.println("groundedQueryQueryyyyyyyyyyyyy"+groundedQuery);
								PreparedStatement statement4 = conn.prepareStatement(groundedQuery);
								ResultSet resultSet4 = statement4.executeQuery();
                                  //  System.out.println("underprogresQueryQueryyyyyyyyyyyyy"+underprogresQuery);
								PreparedStatement statement5 = conn.prepareStatement(underprogresQuery);
								ResultSet resultSet5= statement5.executeQuery(underprogresQuery);
                            //  System.out.println("completedQueryQueryyyyyyyyyyyyy"+completedQuery);
								PreparedStatement statement6 = conn.prepareStatement(completedQuery);
								ResultSet resultSet6 = statement6.executeQuery();                                            
							    if(mode.equals("districts")){
                                    dname=res.getString("dname");
                                	dcode=res.getString("dcode");
                                    }
                                    if(mode.equals("mandals")){
										mcode=res.getString("mcode");
										mname=res.getString("mname");
									}
									
								if (resultSet1.next()) {
								admin_sactioned=resultSet1.getInt(1);
		                                totadmin_sanc+=admin_sactioned;
		                         }else {
		                                admin_sactioned=0; }                                                                            	
								if (resultSet2.next()) {
									tech_sanctioned=resultSet2.getInt(1);
                                   tottech_sanc+=tech_sanctioned;                                             
            					} else {
                   					 tech_sanctioned=0; }                                                                
								if (resultSet3.next()) {
									entrusted=resultSet3.getInt(1);
                                    totentrusted+=entrusted;                        
    							}else {
                                 entrusted=0; 
                                 }                                                                
								if (resultSet4.next()) {
									grounded=resultSet4.getInt(1);
                               		totgrounded+=grounded;
                                }else {
                                	grounded=0; }                                                                
                               if (resultSet5.next()) {
									under_progress=resultSet5.getInt(1);
                               		 totunder_prog+=under_progress;
                                }else {
                                    under_progress=0; }
								if (resultSet6.next()) {
									completed=resultSet6.getInt(1);
                                    totcomp+=completed;
                                } else {
                                   completed=0; }
                                   not_grou=entrusted-grounded;
                                   totnotgr+=not_grou;
              if(admin_sactioned==0 && tech_sanctioned==0&&entrusted==0&&grounded==0&&under_progress==0&&completed==0&&not_grou==0){
              }else{
                  names+=res.getString(2)+",";                  
              %>
              <tr>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
              <%if(mode.equals("districts")){  %>
              <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_flow_dist_mandal_cm_rpt.jsp?mode=mandals&dcode=<%=dcode%>&dname=<%=dname%>&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>"><%=dname%></a></td>
              
               <%}else if(mode.equals("mandals")){ %>
                 <td class="<%=style%>" style="text-align: left;" align="left" ><%=mname%></td>
              <%} %>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=admin_sactioned %></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=tech_sanctioned %></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=entrusted %></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=grounded %></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=under_progress %></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=completed %></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=not_grou %></td>
             <%
             if(resultSet6 != null)
            	 resultSet6.close();
             
             if(resultSet5 != null)
            	 resultSet5.close();
             
             if(resultSet4 != null)
            	 resultSet4.close();
             
             if(resultSet3 != null)
            	 resultSet3.close();
             
             if(resultSet2 != null)
            	 resultSet2.close();
             
             if(resultSet1 != null)
            	 resultSet1.close();
             
             if(statement6 != null)
            	 statement6.close();
             if(statement5 != null)
            	 statement5.close();
             if(statement4 != null)
            	 statement4.close();
             if(statement3 != null)
            	 statement3.close();
             if(statement2 != null)
            	 statement2.close();
             if(statement1 != null)
            	 statement1.close();
             // inputWorks += "[" + admin_sactioned + "," + tech_sanctioned + "," + grounded +"," + completed +"],";   
                   }        
                 }
                /*  inputWorks = inputWorks.substring(0, inputWorks.length() - 1);
                   System.out.println("inputWorks"+inputWorks);
                   session.setAttribute("inputWorks", inputWorks); */
                   
                   if(res != null)
            		   res.close();
            	   if(preparedStatement != null)
            		   preparedStatement.close();
                   %>
             </tr>
      
          <tr>
                <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total</td>
				<td class="btext" style="text-align: right;"><%=totadmin_sanc %></td>
				<td class="btext" style="text-align: right;"><%=tottech_sanc %></td>
				<td class="btext" style="text-align: right;"><%=totentrusted %></td>
				<td class="btext" style="text-align: right;"><%=totgrounded %></td>
				<td class="btext" style="text-align: right;"><%=totunder_prog %></td>
				<td class="btext" style="text-align: right;"><%=totcomp %></td>
                 <td class="btext" style="text-align: right;"><%=totnotgr %></td>
                 </tr>
                 
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

