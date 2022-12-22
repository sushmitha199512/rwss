
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<style>
.thumbnail{
	position: relative;
	z-index: 0;
	}

	.thumbnail:hover{
	background-color: transparent;
	z-index: 60;
	}

	.thumbnail span{ /*CSS for enlarged image*/
	position: absolute;
	background-color: lightyellow;
	padding: 4px;
	left: -1000px;
	border: 1px dashed gray;
	visibility: hidden;
	color: black;
	text-decoration: none;
	}

	.thumbnail span img{ /*CSS for enlarged image*/
	border-width: 0;
	padding: 2px;
	}

	.thumbnail:hover span{ /*CSS for enlarged image on hover*/
	visibility: visible;
	top: -120px;
	left: -350px; /*position where enlarged image should offset horizontally */

	}
</style>
<html:html>
    <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css"> 

    </head>
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
    <%
    DecimalFormat ndf = new DecimalFormat("####.00");
        String coc = request.getParameter("coc");
        String con = request.getParameter("con");
        String doc = request.getParameter("doc");
        String don = request.getParameter("don");
        String soc = request.getParameter("soc");
        String son = request.getParameter("son");
        String pc = request.getParameter("pc");
        String pn = request.getParameter("pn");
        String mode = request.getParameter("mode");
        String mode1 = request.getParameter("mode1");
        String spc = request.getParameter("spc");
        String spn = request.getParameter("spn");

        int yearStart = 0;
        int yearEnd = 0;
        yearStart=Integer.parseInt(request.getParameter("yearStart"));
        yearEnd=Integer.parseInt(request.getParameter("yearEnd"));
     
        String schemes = request.getParameter("schemes");
        String sub = "ALL";
        if (request.getParameter("sub") != null) {
            sub = (String) request.getParameter("sub");
        }

        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";

    %>
    <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
        <caption>
            <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
                <a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;
                <a href="#" onClick="window.close();">Close</a>
            </table>
        </caption>
        <tr  align="center">
            <td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Abstract
					Progress Detailed Report for Physically Completed But Financially Not
					completed Works&nbsp;<%=yearStart%>-<%=yearEnd%> and  Programme:&nbsp;<%=pn%> </td>
        </tr>
    </table>
    <table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
        <%if (mode.equals("cWorks")) {%>
        <tr align=center>
            <td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
            <td class=gridhdbg ><b>District</b></td>
            <td class=gridhdbg ><b>Constituency</b></td>
            <td class=gridhdbg ><b>WorkId</b></td>
            <td class=gridhdbg ><b>Work Name </b></td>
            <td class=gridhdbg ><b>Sanction Number </b></td>
            <td class=gridhdbg ><b>Sanction Date </b></td>
            <td class=gridhdbg ><b>Est. Cost(In Lakhs.) </b></td>
            <td class=gridhdbg ><b>Cumulative Exp.(as on date since inception)(In Lakhs.) </b></td>
            <td class=gridhdbg ><b>Exp. during year </b></td>
			<td class=gridhdbg ><b>Stipulated Date of Completion </b></td>
            <td class=gridhdbg ><b>Probable Date of Completion </b></td>
            <td class=gridhdbg ><b>Work Completion Date </b></td>
            <td class=gridhdbg ><b>No. of Habs Sanctioned</b></td>
            <td class=gridhdbg ><b>No. of Habs Covered</b></td>
            <td class=gridhdbg ><b>Physical % </b></td>
            <td class=gridhdbg ><b>Image1 </b></td>
            <td class=gridhdbg ><b>Image2</b></td>
             <td class=gridhdbg ><b>EE Forword Date(Latest)</b></td>
              <td class=gridhdbg ><b>Bills raised so far</b></td>
            
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
              
        
                        
			query = "select distinct a.SANCTION_AMOUNT, a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--'),"
					+"ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation  from rws_work_admn_tbl a, rws_programme_tbl p,rws_work_completion_tbl c,rws_district_tbl dis where "
									+ "substr(a.work_id,5,2)=dis.dcode and WORK_CANCEL_DT is null and a.TYPE_OF_ASSET in (" + schemes
									+ ") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
									+ "AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
									+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
									+ yearStart + "' and c.dt_fin_completion is null ";
     
              
                if(spc!=null) {
                    query += " and a.subprogramme_code in (" + spc + ")";
                } 
                if(coc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,2,2)='"+coc+"'";
                }
                if(doc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,4,1)='"+doc+"'";
                }
                if(soc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,5,2)='"+soc+"'";
                }
                query += " order by a.work_id";
                

              // System.out.println("WOrk Related :- "+ query);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                double totEstCost=0,totCommExp=0,totExpDY=0,totBillAmt=0;
                while (rs.next()) {
                	
                	double estCost=rs.getDouble(1);
                	String  eeForwordDate="";
                    double billAmount=0;

                    String compDate = "",physicalStage="";
                    
                    String workCompletion = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='" + rs.getString(2) + "' and DATE_OF_COMPLETION is not null";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(workCompletion);
                    if (resultSet.next()) {
                        compDate = resultSet.getString(1);
                    } else {
                        compDate = "--";
                    }
                    statement.close();
                    resultSet.close();
                    
                    String stipDateComp="";
                    int phyPer=0;
                    String stipCompletion = "select nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'--'),PERCENT_COMPLETED  from RWS_CONTRACTOR_SELECTION_TBL where work_id='" + rs.getString(2) + "' ";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(stipCompletion);
                    if (resultSet.next()) {
                    	stipDateComp = resultSet.getString(1);
                    	phyPer=resultSet.getInt(2);
                    } else {
                    	stipDateComp = "--";
                    }
                    statement.close();
                    resultSet.close();
                    
                    String noofHabsCov = "",noofHabsSac = "";
                    String covhabs = "";
                   
                        covhabs = "select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='" + rs.getString(2) + "'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(covhabs);
                    if (resultSet.next()) {
                    	noofHabsCov = resultSet.getString(1);
                    } else {
                    	noofHabsCov = "0";
                    }
                    statement.close();
                    resultSet.close();
                    
                    //
                    
                    
                    //String billAmtQuerya = "select count(distinct a.hab_code) from RWS_ADMN_HAB_LNK_TBL a,rws_habitation_directory_tbl b where a.hab_code=b.hab_code and coverage_status<>'UI' and work_id='" + rs.getString(2) + "'";
                 // MAX( nvl(to_char(EE_FWD_DATE,'dd/mm/yyyy'),'--'))
                   ////////////// String billAmtQuery ="select SUM(BILL_AMT_ADMISSIBLE),MAX( to_char(EE_FWD_DATE,'dd-mm-yyyy')) from rws_work_bill_tbl a where not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=a.work_Id and b.bill_sl_no=a.bill_sl_no ) and a.work_id='" + rs.getString(2) + "'";
                    
                 String billAmtQuery ="select SUM(BILL_AMT_ADMISSIBLE),MAX( to_char(EE_FWD_DATE,'dd-mm-yyyy')) from rws_work_bill_tbl a where not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=a.work_Id and b.bill_sl_no=a.bill_sl_no ) and a.work_id='" + rs.getString(2) + "' and  a.EE_FWD_DATE is not null";
                    
                 
                 // System.out.println("###############"+billAmtQuery);
                   //String billAmount="",eeForwordDate="";
                    
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(billAmtQuery);
                    if (resultSet.next()) {
                    	billAmount = resultSet.getDouble(1);
                    	if(resultSet.getString(2)!=null){
                    		eeForwordDate = resultSet.getString(2);
                    	}
                    	else
                    	{
                    		eeForwordDate="-";
                    	}
                    	
                    	
                    } else {
                    	billAmount = 0.0;
                    	eeForwordDate="-";
                    	
                    }
                    statement.close();
                    resultSet.close();
                    
                    
                   
                    
                    
                    
                    //
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    String sachabs = "select count(distinct a.hab_code) from RWS_ADMN_HAB_LNK_TBL a,rws_habitation_directory_tbl b where a.hab_code=b.hab_code and coverage_status<>'UI' and work_id='" + rs.getString(2) + "'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(sachabs);
                    if (resultSet.next()) {
                    	noofHabsSac = resultSet.getString(1);
                    } else {
                    	noofHabsSac = "0";
                    }
                    statement.close();
                    resultSet.close();

				
					Double bankAmount=0.0,paoAmount=0.0,tot_amount=0.0;
					 String bank = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"+ rs.getString(2)+"' and BANK_SEND_DATE is not null and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'";            
					 statement=conn.createStatement();
					 resultSet=statement.executeQuery(bank);
	                  if (resultSet.next()) {
	                      bankAmount = resultSet.getDouble(1);

	                  }
	                  statement.close();
	                  resultSet.close();

	                  String paocurrMonth = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL  where work_id='"+ rs.getString(2)+"' and STATE_SEND_DATE is not null and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'";
	                  statement = conn.createStatement();
	                  resultSet = statement.executeQuery(paocurrMonth);
	                 
	                  if (resultSet.next()) {
	                      paoAmount = resultSet.getDouble(1);

	                  }
	                  statement.close();
	                  resultSet.close();
	                  tot_amount=bankAmount+paoAmount;
	                  
	                  String leadHab=rs.getString("lead_habitation");
	                  String constName="";
	                  if(!leadHab.equals("--")){
	                  String constQuery="select constituency_name from rws_constituency_tbl where dcode='"+leadHab.substring(0,2)+"' and mcode='"+leadHab.substring(5,7)+"'";
	                  statement = conn.createStatement();
	                  resultSet = statement.executeQuery(constQuery);
	                 
	                  if (resultSet.next()) {
	                	  constName = resultSet.getString(1);

	                  }
	                  statement.close();
	                  resultSet.close();
	                  }
	                  else{
	                	  constName=leadHab;
	                  }
	                  Double bankAmountDY=0.0,paoAmountDY=0.0,tot_amountDY=0.0;
						 String bankDY = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"+ rs.getString(2)+"' and TO_DATE(BANK_SEND_DATE)>='01-APR-"+yearStart+"' and TO_DATE(BANK_SEND_DATE)<='31-MAR-"+yearEnd+"'";
						 statement=conn.createStatement();
						 resultSet=statement.executeQuery(bankDY);
		                  if (resultSet.next()) {
		                      bankAmountDY = resultSet.getDouble(1);
		                  }
		                  statement.close();
		                  resultSet.close();
		                  String paoDY = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL  where work_id='"+ rs.getString(2)+"' and TO_DATE(STATE_SEND_DATE)>='01-APR-"+yearStart+"' and TO_DATE(STATE_SEND_DATE)<='31-MAR-"+yearEnd+"'";
		                  statement = conn.createStatement();
		                  resultSet = statement.executeQuery(paoDY);		                 
		                  if (resultSet.next()) {
		                      paoAmountDY = resultSet.getDouble(1);
		                  }
		                  statement.close();
		                  resultSet.close();
		                  tot_amountDY=bankAmountDY+paoAmountDY;
                    if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;
        %>
        <tr>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("dname")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=constName%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("ADMIN_NO")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(tot_amount/100000)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(tot_amountDY/100000)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=stipDateComp%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(5)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=compDate%></td>
                <td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=sacHabs&wid=<%=rs.getString(2)%>&pc=<%=pc%>&pn=<%=pn%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noofHabsSac%></a></td>
                <td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=covHabs&wid=<%=rs.getString(2)%>&pc=<%=pc%>&pn=<%=pn%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noofHabsCov%></a></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=phyPer%></td>
            <%
                    String image1 = "select WORK_IMAGE,dbms_lob.getlength(WORK_IMAGE) from rws_work_image_tbl where WORK_ID='" + rs.getString(2) + "'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(image1);

                    if (resultSet.next()) {
                    	int a=resultSet.getInt(2);
                    	   if(a==0){
     				    	%>
            			  		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                  			<%}else{
                  			%>
                         	  <td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image1"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image1"  width="350px" height="230px"/></span></a></td>

		            <%}} else {%>
		            <td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
		            <%}
                statement.close();
                resultSet.close();
                String image2 = "select WORK_IMAGE1,dbms_lob.getlength(WORK_IMAGE1) from rws_work_image_tbl where WORK_ID='" + rs.getString(2) + "'";
                statement = conn.createStatement();
                resultSet = statement.executeQuery(image2);
                if (resultSet.next()) {
                	int b=resultSet.getInt(2);
		    		 if(b==0){
		    			 %>
	              		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
	              		<%
		    	     }else{
	             		 %>
                         <td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image2"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image2"  width="350px" height="230px"/></span></a></td>

            		<%}} else {%>
           		 	<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
          		  	<%}
                %>
                <td class="<%=style%>" style="text-align: left;" align="right"><%=eeForwordDate%></td>
                               <td class="<%=style%>" style="text-align: left;" align="right"><%=ndf.format(billAmount/ 100000)%></td>
               
                <%
                statement.close();
                resultSet.close();
            %>
        </tr>
        <%              
        totEstCost+=estCost;
        totCommExp+=tot_amount;
        totExpDY+=tot_amountDY;
        totBillAmt+=billAmount;
                }
                stmt.close();
                rs.close();
                %>
                <tr>
                    <td class="btext" style="text-align: right;" colspan=7>Total:</td>
                    <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                    <td class="btext" style="text-align: right;"><%=ndf.format(totCommExp / 100000)%></td>
                    <td class="btext" style="text-align: right;"><%=ndf.format(totExpDY / 100000)%></td>
                    <td class="btext" style="text-align: right;" colspan=9></td> 
                    <td class="btext" style="text-align: right;"><%=ndf.format(totBillAmt/ 100000)%></td>
                                      
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
            <td class=gridhdbg ><b>SNO</b></td>
            <td class=gridhdbg ><b>District</b></td>
            <td class=gridhdbg ><b>Mandal</b></td>
            <td class=gridhdbg ><b>Panchayat</b></td>
            <td class=gridhdbg ><b>Village</b></td>
            <td class=gridhdbg ><b>Habitation Code</b></td>
            <td class=gridhdbg ><b>Habitation Name</b></td>
            <td class=gridhdbg ><b>Coverage Status</b></td>
            <td class=gridhdbg ><b>Total Population</b></td>
            <%if(mode.equals("cHabs")) {%>
            <td class=gridhdbg ><b>Habitation Covered Works </b></td>
            <%} %>
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
            	if (mode.equals("sacHabs")) {
                    query = "select  dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                               + " from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b, rws_habitation_directory_tbl hd, "
                               + " rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs where hd.hab_code=b.hab_code and "
                               + " WORK_CANCEL_DT is null and a.work_id=b.work_id and a.work_id='"+request.getParameter("wid")+"' and COVERAGE_STATUS<>'UI' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                               + " and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                               + " and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode ";
                  }
            	else if (mode.equals("covHabs")) {
            		 query = "select distinct dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                             + " from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b, rws_habitation_directory_tbl hd, "
                             + " rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs, rws_work_completion_tbl comp where hd.hab_code=b.hab_code and "
                             + " WORK_CANCEL_DT is null and a.work_id=comp.work_id "
                             + " and b.work_id=a.work_id and a.work_id='"+request.getParameter("wid")+"' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                             + " and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                             + " and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode ";
                
            	
                 }
                if(mode1!=null&&!mode1.equals("")&&mode1.equals("wrk"))
                {
                    query+=" and a.work_id='"+request.getParameter("wid")+"'";
                }
                if(coc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,2,2)='"+coc+"'";
                }
                if(doc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,4,1)='"+doc+"'";
                }
                if(soc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,5,2)='"+soc+"'";
                }
                if(spc!=null) {
                    query += " a.subprogramme_code in ("+spc+")";
                }
                query+= " group by dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,hd.coverage_status order by dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME";
               
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()) {
                	String covWorks="";
                	if(mode.equals("cHabs")) {
                	  String habWorksQry = "";              
                	  habWorksQry = "select distinct a.work_id,a.work_name from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                              + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                              + " a.programme_code in (" + pc + ")  and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"'  and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                              + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and h.hab_code='"+rs1.getString("hab_code")+"'";
                    //  System.out.println("COMPLTE habs"+habWorksQry);
                      Statement stmt1 = conn.createStatement();
                      ResultSet habWorksRs = stmt1.executeQuery(habWorksQry);
                      while(habWorksRs.next()) {
                    	  if(!covWorks.equals("")){
                    		  covWorks+= ","+habWorksRs.getString("work_id")+"-"+habWorksRs.getString("work_name");
                    	  }else{
                    		  covWorks=habWorksRs.getString("work_id")+"-"+habWorksRs.getString("work_name");
                    	  }                             
                      }
                      stmt1.close();
                      habWorksRs.close();                	
                	}
                	if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;
                %>
                <tr>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(1)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(2)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(3)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(4)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(6)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(5)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("coverage_status")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("pop")%></td>
                    <%	if(mode.equals("cHabs")) { %>	
                     <td class="<%=style%>" style="text-align: left;" align="right"><%=covWorks%></td>
                     <%} %>
                </tr>
                <%
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

</html:html>
