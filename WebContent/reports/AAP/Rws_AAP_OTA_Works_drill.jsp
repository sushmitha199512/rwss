<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />


<html:html>

    <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css">

    </head>
    <script language="JavaScript">
    var counter=0;
        function viewWorks(URL) {
            
        	//var randomnumber = Math.floor((Math.random()*100)+1);
            var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
            if (URL != "") {
            	counter++;
            	//alert(counter);
               // myNewWin = window.open(URL, 'newWinddow', popFeatures);
                myNewWin = window.open(URL,"_blank",'PopUp',counter, popFeatures);
                myNewWin.focus(); 
            }
             
           // window.open(yoururl,"_blank",'PopUp',randomnumber,'scrollbars=1,menubar=0,resizable=1,width=850,height=500');
        }

        function wopen(url, name, w, h) {
            // Fudge factors for window decoration space.
            // In my tests these work well on all platforms & browsers.
            w += 32;
            h += 96;
            var win = window.open(url, name, 'width=' + w + ', height=' + h + ', '
                    + 'location=yes, menubar=no, '
                    + 'status=yes, toolbar=no, scrollbars=yes, resizable=yes');

            win.focus();
        }
    </script>






    <%    
    	
    	DecimalFormat ndf = new DecimalFormat("####.00");
        String dcode = request.getParameter("dcode");
        String dname = request.getParameter("dname");
        String programmeCode = request.getParameter("programmeCode");
        String mode = request.getParameter("mode");
        String mode1 = request.getParameter("mode1");
        String work_id = request.getParameter("workid");
        String scheme=request.getParameter("scheme");
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        String finyear = "";
        if (request.getParameter("finyear") != null) {
            finyear = request.getParameter("finyear");
            session.setAttribute("finyear", finyear);
        }

        String startyr = finyear.substring(0, 4);

        String endyr = finyear.substring(5, 9);
        WorksData1 data1 = new WorksData1();
        int cyear = Calendar.getInstance().get(Calendar.YEAR);
        int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
        int lMonth = Calendar.getInstance().get(Calendar.MONTH);
        int day = Calendar.getInstance().get(Calendar.DATE);
        String currentMonth = data1.getCurrentMonth(month);
        // System.out.println("currentMonth"+currentMonth);
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


    <table border=1 cellspacing=0 cellpadding=0 width="70%"
           bordercolor=#000000 style="border-collapse: collapse" ALIGN=CENTER>
        <caption>
            <table border=0 rules=none style="border-collapse: collapse"
                   align="right">
                <a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;
                <a href="#" onClick="window.close();">Close</a>


            </table>
        </caption>
        <tr align="center">
            <td align="center" class=gridhdbg></td>
            <%if(request.getParameter("progName")!=null && request.getParameter("subprogName")!=null){ %>
            <td align="center" class=gridhdbg>AAP During <%=finyear %> for District:&nbsp;<%=dname%>&nbsp;and&nbsp;Programme:<%=request.getParameter("progName") %> and&nbsp; Sub&nbsp;Programme:<%=request.getParameter("subprogName") %> </td>
            <%} else if(request.getParameter("progName")!=null){ %>
            <td align="center" class=gridhdbg>AAP During <%=finyear %> for District:&nbsp;<%=dname%>&nbsp;and&nbsp;Programme:<%=request.getParameter("progName") %> </td>
            <%}else{ %>
            <td align="center" class=gridhdbg>AAP During <%=finyear %> for District:&nbsp;<%=dname%>&nbsp;  </td>
            <%} %>
        </tr>

    </table>
    <table width="70%" border=1 style="border-collapse: collapse"
           ALIGN=CENTER>
        <%
            if (mode.equals("ongoingWorks") || mode.equals("targetWorks") || mode.equals("compWorks") || mode.equals("tobecompWorks") || mode.equals("totOngoingWorks")) {
        %>
        <tr align=center>


            <td class=gridhdbg ><b>SL&nbsp;NO </b></td>
            <td class=gridhdbg ><b>WorkId</b></td>
            <td class=gridhdbg ><b>Work Name </b></td>
            <td class=gridhdbg ><b>Program Name </b></td>
            <td class=gridhdbg ><b>Sanction Date </b></td>
            <td class=gridhdbg ><b>Probable Date of Completion </b></td>
            <td class=gridhdbg ><b>Est. Cost </b></td>
            <td class=gridhdbg >Expenditure</td>
            <td class=gridhdbg >Bal Est. Cost</td>
            <td class=gridhdbg ><b>Work Completion Date </b></td>
            <td class=gridhdbg ><b>No. of Habs </b></td>
            <td class=gridhdbg ><b>Image1 </b></td>
            <td class=gridhdbg ><b>Image2</b></td>


        </tr>

       
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            Statement stmt1 = null;
            ResultSet rs1 = null;
            double estCost = 0, bankExp = 0, paoExp = 0, exp = 0;
            int totHabs = 0;
            double  totEstCost = 0, totExp = 0,totBalEst=0;

            try {
            	String subprogCode=request.getParameter("subprogCode");
                if (mode.equals("ongoingWorks") || mode.equals("targetWorks")) {
                	
                	 query="select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--'),p.PROGRAMME_NAME from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_programme_tbl p where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+ dcode+ "'  and a.programme_code=p.programme_code  and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+")  and a.programme_code in ("+ programmeCode+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
                        if(mode.equals("targetWorks")){
                        	query+=" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
                        }
                        if(subprogCode!=null){
                        	query+=" and a.subprogramme_code='"+subprogCode+"'";
                        }
                        
                } 
                else if (mode.equals("totOngoingWorks") || mode.equals("tobecompWorks")) {
                	
	               	 query="select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--'),p.PROGRAMME_NAME from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_programme_tbl p where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+ dcode+ "'  and a.programme_code=p.programme_code  and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+")  and a.programme_code in ("+ programmeCode+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	                 if(mode.equals("tobecompWorks")){
	                 	query+=" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
	                 }
	                 if(subprogCode!=null){
                     	query+=" and a.subprogramme_code='"+subprogCode+"'";
                     }
	                 
         		} else if (mode.equals("compWorks")) {
                	
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--'),p.PROGRAMME_NAME,to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_programme_tbl p,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
                            + dcode
                            + "' and SUBSTR(a.work_id,7,2) not in ('11','12') and a.PROGRAMME_CODE=p.PROGRAMME_CODE and b.DATE_OF_COMPLETION between '01-APR-"
                            + yearStart
                            + "' and '31-MAR-"
                            + yearEnd
                            + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
                            + programmeCode
                            + ") and b.DATE_OF_COMPLETION is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
                    if(subprogCode!=null){
                    	query+=" and a.subprogramme_code='"+subprogCode+"'";
                    }
                    query += " order by b.DATE_OF_COMPLETION desc";
                    
                } 

                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                while (rs.next()) {

                    String compDate = "";
                    estCost = rs.getDouble(1);
                    String workid = rs.getString(2);
                    String workCompletion = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='"
                            + rs.getString(2)
                            + "' and DATE_OF_COMPLETION is not null";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(workCompletion);
                    if (resultSet.next()) {
                        compDate = resultSet.getString(1);
                    } else {
                        compDate = "--";
                    }
                    statement.close();
                    resultSet.close();
                    int noofHabs = 0;
                    String habs = "";
                    if (mode.equals("compWorks")) {
                        habs = "select count(hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='"
                                + rs.getString(2) + "'";
                    }else{
                    
                        habs = "select count(hab_code) from RWS_ADMN_HAB_LNK_TBL where work_id='"
                                + rs.getString(2) + "'";
                    } 
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(habs);
                    if (resultSet.next()) {
                        noofHabs = resultSet.getInt(1);
                    } else {
                        noofHabs = 0;
                    }
                    statement.close();
                    resultSet.close();
                    if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;
                   
        %>

        <tr>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(6)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(5)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(1)%></td>
            
            

            <%
                String bank = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"+ workid+ "'";
            	if (mode.equals("ongoingWorks") || mode.equals("targetWorks")) {
                       bank+= " and BANK_SEND_DATE<='31-MAR-"+ (yearEnd - 1) + "'";
            	}	

                stmt1 = conn.createStatement();
                rs1 = stmt1.executeQuery(bank);
                if (rs1.next()) {
                    bankExp = rs1.getDouble(1);

                }
                stmt1.close();
                rs1.close();

                String pao = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where work_id='"+ workid+ "'";
                
                if (mode.equals("ongoingWorks") || mode.equals("targetWorks")) {
                	pao+= " and STATE_SEND_DATE<='31-MAR-"+ (yearEnd - 1) + "'";
         	}
                stmt1 = conn.createStatement();
                rs1 = stmt1.executeQuery(pao);
                if (rs1.next()) {
                    paoExp = rs1.getDouble(1);

                }
                stmt1.close();
                rs1.close();
                double sacAmount=rs.getDouble(1);
                double bankPao=(bankExp + paoExp) / 100000;
    			double balAmount=sacAmount-bankPao;
    			
                String finalamount = ndf.format((bankExp + paoExp) / 100000);
            %>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(balAmount)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=compDate%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=noofHabs%></td>
			<%-- <td class="<%=style%>" style="text-align: left;" align="right"><a href="#"  onclick="viewWorks('./Rws_AAP_OTA_Works_drill.jsp?mode=ongoingHabs&mode1=work&workid=<%=rs.getString(2)%>&dcode=<%=dcode%>&programmeCode=<%=programmeCode%>&dname=<%=dname%>&finyear=<%=yearStart%>-<%=yearEnd%>')"><%=noofHabs%></a></td> --%>
            <%
                String image1 = "select WORK_IMAGE from rws_work_image_tbl where WORK_ID='"
                        + rs.getString(2) + "'";
                statement = conn.createStatement();
                resultSet = statement.executeQuery(image1);

                if (resultSet.next()) {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right"><a
                    href="#"
                    onclick="viewWorks('./rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image1')">View</a></td>

            <%
            } else {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right">Image
                Not Exist</td>
                <%
                    }
                    statement.close();
                    resultSet.close();

                    String image2 = "select WORK_IMAGE1 from rws_work_image_tbl where WORK_ID='"
                            + rs.getString(2) + "'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(image2);

                    if (resultSet.next()) {
                %>
            <td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image2')">View</a></td>

            <%
            } else {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right">Image
                Not Exist</td>
                <%
                    }
                    statement.close();
                    resultSet.close();
                    totEstCost = totEstCost + estCost;
                    totExp = totExp + bankExp + paoExp;
                    totBalEst=totBalEst+balAmount;
                    totHabs=totHabs+noofHabs;
                %>


        </tr>

        <%
            }
            stmt.close();
            rs.close();
        %>
        <tr>
            <td class="gridhdbg" style="text-align: right;" colspan=6>Total:</td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExp / 100000)%></td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totBalEst)%></td>
			<td class="gridhdbg" style="text-align: right;"></td>
            <td class="gridhdbg" style="text-align: right;"><%=totHabs %></td>
            <td class="gridhdbg" style="text-align: right;"></td>
            <td class="gridhdbg" style="text-align: right;"></td>
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
        } else {
        %>
        <tr align=center>
            <td class=gridhdbg><b>SL&nbsp;NO </b></td>
            <td class=gridhdbg><b>District</b></td>
            <td class=gridhdbg><b>Mandal</b></td>
            <td class=gridhdbg><b>Panchayat</b></td>
            <td class=gridhdbg><b>Village</b></td>
            <td class=gridhdbg><b>Habitation Code</b></td>
            <td class=gridhdbg><b>Habitation Name</b></td>
            <td class=gridhdbg><b>Coverage Status</b></td>
            <td class=gridhdbg><b>Total Population</b></td>
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
            	String subprogCode=request.getParameter("subprogCode");
                if (mode.equals("ongoingHabs") || mode.equals("targetHabs")) {
                  
                    query="select h.hab_code from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL h where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+") and a.programme_code in ("+ programmeCode+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  h.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
                   
	                 
	                if(mode.equals("targetHabs")){
	                	query+=" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
	                }
	                if(subprogCode!=null){
	                     query+=" and a.subprogramme_code='"+subprogCode+"'";
	                }
                   
                } else if (mode.equals("totOngoingHabs") || mode.equals("tobecompHabs")) {
                	query="select h.hab_code from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL h where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"+dcode+ "'   and c.GROUNDING_DATE is not null and a.type_of_asset in ("+scheme+") and a.programme_code in ("+ programmeCode+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and  h.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
                    
	                
	                if(mode.equals("tobecompHabs")){
	                	query+=" and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"'";
	                }
	                if(subprogCode!=null){
	                     query+=" and a.subprogramme_code='"+subprogCode+"'";
	                }
                } else if (mode.equals("compHabs")) {
                	
                    query = "select h.hab_code from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
                            + dcode
                            + "'  and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
                            + programmeCode
                            + ") and b.DATE_OF_COMPLETION between '01-APR-"
                            + yearStart
                            + "' and '31-MAR-"
                            + yearEnd
                            + "' and b.DATE_OF_COMPLETION is not null and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
				} 
                if (mode1!=null && mode1.equals("work")) {
	                   query += " and a.work_id='" + work_id + "'";
	                } 
                System.out.println(query);
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()) {

                    String hab_code = rs1.getString(1);
                    String habDetails = "select sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),COVERAGE_STATUS from rws_habitation_directory_tbl where hab_code='"
                            + hab_code + "' group by COVERAGE_STATUS";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(habDetails);
                    int population = 0;
                    String covStatus = "";
                    if (resultSet.next()) {
                        population = resultSet.getInt(1);
                        covStatus = resultSet.getString(2);
                    }
                    resultSet.close();
                    statement.close();
                    if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;

                    String details = "select dname,mname,pname,vname,panch_code,panch_name  from rws_complete_hab_view where panch_code='" + hab_code + "'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(details);

                    if (resultSet.next()) {
        %>

        <tr>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(1)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(4)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(5)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(6)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=covStatus%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=population%></td>
        </tr>
        

        <%
                        } else {
                            System.out.println(hab_code);
                        }
                        statement.close();
                        resultSet.close();
                    }
                    st.close();
                    rs1.close();
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
            }
        %>
    </table>
<%@ include file="/commons/rws_footer.jsp"%>
</html:html>
