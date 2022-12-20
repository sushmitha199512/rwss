
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
    // Fudge factors for window decoration space.
            // In my tests these work well on all platforms & browsers.
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
    if(request.getParameter("yearStart")!=null && request.getParameter("yearEnd")!=null){
    	yearStart=Integer.parseInt( request.getParameter("yearStart"));
    	yearEnd=Integer.parseInt(request.getParameter("yearEnd"));
    }else{        
        if (month <= 3) {
        	yearStart = cyear - 1;
        	yearEnd = cyear;
        } else {
        	yearStart = cyear;
        	yearEnd = cyear + 1;
        } 
    }
    /* if (month <= 3) {
    	yearStart = cyear - 1;
    	yearEnd = cyear;
    } else {
    	yearStart = cyear;
    	yearEnd = cyear + 1;
    } */
        String pcode = request.getParameter("programme");
        String pname = request.getParameter("programmeName");
        /* String year = request.getParameter("year");
        String startYear = request.getParameter("startyear");
        String message = request.getParameter("message"); */       
        String mode = request.getParameter("mode");
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        String schemes = "'01','02','03','10'";
    %>
    <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
        <caption>
            <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
                <a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;
                <a href="#" onClick="window.close();">Close</a>
            </table>
        </caption>
        <tr  align="center">
            <td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Works for Programme<%=pname%>  </td>
        </tr>
    </table>
    <table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >       
        <tr align=center>
            <td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
            <td class=gridhdbg ><b>District</b></td>
             <td class=gridhdbg ><b>Constituency</b></td>
            <td class=gridhdbg ><b>WorkId</b></td>
            <td class=gridhdbg ><b>Work Name </b></td>
            <td class=gridhdbg ><b>Sanction Number </b></td>
            <td class=gridhdbg ><b>Sanction Date </b></td>
            <td class=gridhdbg ><b>Est. Cost </b></td>
            <td class=gridhdbg ><b>Exp. </b></td>
            <td class=gridhdbg ><b>Physical Stage </b></td>
			<td class=gridhdbg ><b>Stipulated Date of Completion </b></td>
            <td class=gridhdbg ><b>Probable Date of Completion </b></td>
            <td class=gridhdbg ><b>Work Completion Date </b></td>
            <td class=gridhdbg ><b>No. of Habs </b></td>
            <td class=gridhdbg ><b>Physical % </b></td>
            <td class=gridhdbg ><b>Image1 </b></td>
            <td class=gridhdbg ><b>Image2</b></td>
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
               
                if (mode.equals("ongoing")) {
                	query="SELECT SANCTION_AMOUNT,a.work_id,work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--'),ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl dis where dis.dcode=substr(a.work_id,5,2) and WORK_CANCEL_DT is null "
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code='"+pcode+"' and substr(a.work_id,7,2)  in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<='31-MAR-"+yearStart+"')";
                } else if (mode.equals("achieve")) {                    
                	query="SELECT SANCTION_AMOUNT,a.work_id,work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--'),ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation FROM Rws_Work_Completion_Tbl comp,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl dis where dis.dcode=substr(a.work_id,5,2) and  WORK_CANCEL_DT is null "
    						+" and comp.work_id=a.work_id  and a.programme_code=p.PROGRAMME_CODE and a.programme_code='"+pcode+"' and substr(a.work_id,7,2)  in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION >= '01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) ";
                } /* else if (mode.equals("afterStipDate")) {                    
                	query="SELECT SANCTION_AMOUNT,w.work_id,work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--'),ADMIN_NO FROM RWS_WORK_ADMN_TBL W,Rws_Contractor_Selection_Tbl c,Rws_Work_Completion_Tbl com WHERE C.Work_Id=W.Work_Id and w.work_id=Com.Work_Id and W.Work_Cancel_Dt is null and C.Date_Of_Completion is not null and Com.Date_Of_Completion is not null and C.Date_Of_Completion<Com.Date_Of_Completion and W.PROGRAMME_CODE='"+pcode+"' and ADMIN_DATE>='01-JAN-2010'";
                 } */
                 
               /*  if(coc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,2,2)='"+coc+"'";
                }
                if(doc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,4,1)='"+doc+"'";
                }
                if(soc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,5,2)='"+soc+"'";
                }
                query += " order by a.work_id"; */
                System.out.println(query);

                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                while (rs.next()) {

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
                    
                    String noofHabs = "";
                    String habs = "";
                    if (mode.equals("cWorks")) {
                        habs = "select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='" + rs.getString(2) + "'";
                    } else {
                        habs = "select count(distinct hab_code) from RWS_ADMN_HAB_LNK_TBL where work_id='" + rs.getString(2) + "'";
                    }
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(habs);
                    if (resultSet.next()) {
                        noofHabs = resultSet.getString(1);
                    } else {
                        noofHabs = "0";
                    }
                    statement.close();
                    resultSet.close();                   

					query = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='"+rs.getString(2)+"' and DATE_OF_COMPLETION is not null";
					statement=conn.createStatement();
					resultSet=statement.executeQuery(query);
					//System.out.println(query);
					if(resultSet.next()){
						
						if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
							physicalStage="Completed";
						}
					}
					else{						
						resultSet.close();
						statement.close();
						query = "select to_char(GROUNDING_DATE,'dd/mm/yyyy') from rws_work_commencement_tbl where work_id='"+rs.getString(2)+"' and GROUNDING_DATE is not null";
						statement=conn.createStatement();
						resultSet=statement.executeQuery(query);
						//System.out.println(query);
						if(resultSet.next()){
							
							if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
								physicalStage="Grounded";
							}
						}
						else{
							physicalStage="Not Grounded";
						}
						resultSet.close();
						statement.close();
											
					}
					resultSet.close();
					statement.close();
					Double bankAmount=0.0,paoAmount=0.0,tot_amount=0.0;
					 String bank = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"+ rs.getString(2)+"' and BANK_SEND_DATE is not null";
					 statement=conn.createStatement();
					 resultSet=statement.executeQuery(bank);
	                  if (resultSet.next()) {
	                      bankAmount = resultSet.getDouble(1);

	                  }
	                  statement.close();
	                  resultSet.close();

	                  String paocurrMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL  where work_id='"+ rs.getString(2)+"' and STATE_SEND_DATE is not null";
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
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("work_name")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("ADMIN_NO")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(rs.getDouble("sanction_amount"))%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(tot_amount)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=physicalStage%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=stipDateComp%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(5)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=compDate%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=noofHabs%></td>
            
            <td class="<%=style%>" style="text-align: right;" align="right"><%=phyPer%></td>
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
                statement.close();
                resultSet.close();

            %>
        </tr>
        <%                }
                stmt.close();
                rs.close();
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

</html:html>
