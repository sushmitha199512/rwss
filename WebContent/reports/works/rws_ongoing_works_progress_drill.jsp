<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />


<html:html>

    <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css">

    </head>
    <script language="JavaScript">
        function viewWorks(URL) {

            var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
            if (URL != "") {
                myNewWin = window.open(URL, 'newWinddow', popFeatures);
                myNewWin.focus();
            }
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
<style type="text/css">
    body, body a {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 13px !important;
    }
    .btext {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 12px !important;
    }
    .rightPad td {
        padding-right: 3px !important;
    }
      
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





    <% 
        DecimalFormat ndf = new DecimalFormat("####.00");
        String dcode = request.getParameter("dcode");
        String dname = request.getParameter("dname");
        String ccode = request.getParameter("ccode");
        String cname = request.getParameter("cname");
        String programe = request.getParameter("programme");
        String mode=request.getParameter("mode");
        
        String schemes = "'01','02','03','10'";
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
       
        String financialstartyr="";

   	 java.util.Date sysdate1 = new java.util.Date();
   SimpleDateFormat format = new SimpleDateFormat("yyyy");
   SimpleDateFormat format1 = new SimpleDateFormat("M");
   String Year=format.format(sysdate1);
   String month=format1.format(sysdate1);
   int startyr=0,nextFinYear=0;
   startyr=Integer.parseInt(Year);
   if(Integer.parseInt(month)>=04)
   {
   	nextFinYear=startyr+1;
   }else{
   	startyr=startyr-1; 
   	nextFinYear=startyr+1;
   }
   financialstartyr=startyr+"-"+nextFinYear;
        
    

if(mode.equals("district")){%>
    <br/><br/>
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>Works Progress for <%=dname %> District</b></font>
            <!-- <br/><br/><font color="#889900" face="Maiandra GD" size="3px">(Amount in Lakhs)</font> -->
        </center>
    <br/>
            <table align="center" style="margin-top: -35px !important; width: 1200px !important;  text-align: center !important;">
                <tr>
                    <td style="width: 1000px !important;"></td>
                    <!-- <td style="width: 100px !important;" align="right">
                        <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="30px"/></a>&nbsp;&nbsp; 
                    </td> -->
                    <td style="width: 100px !important;" align="right">
                        <a href="#" onClick="window.close();">Close&nbsp;&nbsp;</a> 
                    </td>
                </tr>
            </table>
          <table width="1200px" border=1 style="border-collapse: collapse"
           ALIGN=CENTER>
          <tr align=center>
              <td class=btext><b>SNO </b></td>
              <td class=btext ><b>District</b></td>
              <td class=btext><b>Constituency </b></td>
              <td class=btext><b>WorkId</b></td>
              <td class=btext ><b>Work Name </b></td>
              <td class=btext ><b>Programme Name </b></td>
              <td class=btext ><b>Sanction Date </b></td>
              <td class=btext ><b>Est. Cost </b></td>
              <td class=btext ><b>No. of<br/>Habs </b></td>
              <td class=btext >Expenditure<br/>Upto<br/> 31-MAR-<%=startyr%></td> 
              <td class=btext >Expenditure during<br>(<%=startyr%>-<%=nextFinYear%>)</td>
              <td class=btext ><b>Target<br/>Date </b></td>
              <td class=btext ><b>Completion<br/>Date </b></td>
              <td class=btext ><b>Image1 </b></td>
              <td class=btext ><b>Image2</b></td>
          </tr>
         
          <%
              Statement statement = null;
              ResultSet resultSet = null;
              Statement stmt1 = null;
              ResultSet rs1 = null;
              double estCost = 0, bankLastYear = 0, bankDuringYear = 0, paoLastYear = 0,  paoDuringYear = 0, TotExp = 0;
              int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totHabs=0;
              double totarfc = 0, totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0;
              try {
                    
                    	
	                  	query="select a.work_id,a.SANCTION_AMOUNT,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),p.PROGRAMME_NAME,nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP,i.dname as dname,nvl(lead_habitation,'--') as lead_habitation from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_programme_tbl p where p.programme_code=a.programme_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	           		 
	                  	query+=" and substr(a.work_id,5,2)='"+dcode+"' and type_of_asset in("+schemes+") ";
	        		
	                  	query+=" and a.programme_code in ("+programe+")";
	                  	
                   
        		
                 
                  stmt = conn.createStatement();
                  rs = stmt.executeQuery(query);
                  while (rs.next()) {
                      String compDate = "";
                      estCost = rs.getDouble(2);
                      String workid = rs.getString("work_id");
                      String workCompletion = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='"
                              + rs.getString("work_id")
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
                      String habs = "select count(distinct h.hab_code) from RWS_WORK_ADMN_TBL a,RWS_ADMN_HAB_LNK_TBL h,rws_complete_hab_view c where a.work_id=h.work_id and a.work_id='"
                              + rs.getString("work_id") + "' and h.hab_code=c.panch_code ";
                     
                     
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(habs);
                      if (resultSet.next()) {
                          noofHabs = resultSet.getInt(1);
                      } else {
                          noofHabs = 0;
                      }
                      statement.close();
                      resultSet.close();
                      
					  String leadHabitation=rs.getString("lead_habitation");
                      
                      String constituency="--";
                      if(!leadHabitation.equals("--")){
                      String constituencyQuery = "select constituency_name from rws_constituency_tbl where dcode='" + leadHabitation.substring(0,2) + "' and mcode='"+ leadHabitation.substring(5,7) +"'";
                          
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(constituencyQuery);
                      if (resultSet.next()) {
                    	  constituency = resultSet.getString("constituency_name");
                      } 
                      statement.close();
                      resultSet.close();
                      }
                      else{
                    	  constituency=leadHabitation;
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
              <td class="<%=style%>" style="text-align: left;" align="right"><%=constituency%></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(1)%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("programme_name")%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(rs.getDouble(2))%></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=noofHabs%></td>
               <%
               
               
                  String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where  txid is not null and work_id='"
                          + workid
                          + "' and BANK_SEND_DATE<='31-MAR-"+startyr+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankLFY);
                
                  if (rs1.next()) {
                      bankLastYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();
                  String paoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where  state_txid is not null and work_id='"
                          + workid
                          + "' and STATE_SEND_DATE<='31-MAR-"+startyr+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(paoFLY);
                 
                  if (rs1.next()) {
                      paoLastYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();
  				
                  String finalamount = ndf
                          .format((bankLastYear + paoLastYear) / 100000);
                  
                  String bankDFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and BANK_SEND_DATE>='01-APR-"+startyr+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankDFY);
                 
                  if (rs1.next()) {
                      bankDuringYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();
                  String paoDFY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and STATE_SEND_DATE>='01-APR-"+startyr+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(paoDFY);
                 
                  if (rs1.next()) {
                      paoDuringYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();
  				
                  String finalamount1 = ndf
                          .format((bankDuringYear + paoDuringYear) / 100000);
              %>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount%></td> 
             <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount1%></td> 
             
             <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString("TARGET_DATE_COMP")%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=compDate%></td>

             <%
                  String image1 = "select WORK_IMAGE,dbms_lob.getlength(WORK_IMAGE) from rws_work_image_tbl where WORK_ID='"
                          + rs.getString("work_id") + "'";
                  statement = conn.createStatement();
                  resultSet = statement.executeQuery(image1);

                  if (resultSet.next()) {
                	  int b=resultSet.getInt(2);
			    		 if(b==0){
			    			 %>
		              		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
		              		<%
			    	     }else{
		             		 %>
		              		<td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=workid%>&mode=image1"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=workid%>&mode=image1"  width="350px" height="230px"/></span></a></td>
		              		<%
			     }} else {
     	            %>
       					<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
           			<%
               		}
                      statement.close();
                      resultSet.close();

                      String image2 = "select WORK_IMAGE1,dbms_lob.getlength(WORK_IMAGE1) from rws_work_image_tbl where WORK_ID='"
                              + rs.getString("work_id") + "'";
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(image2);

                      if (resultSet.next()) {
                    	  int a=resultSet.getInt(2);
                   	   if(a==0){
    				    	%>
           			  		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                 			<%}else{
                 			%>
             					<td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=workid%>&mode=image2"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=workid%>&mode=image2"  width="350px" height="230px"/></span></a></td>
		             		<%
             			} }else {
             			  	%>
           			  	<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                 			<%
                 		}
                      statement.close();
                      resultSet.close();
                      totEstCost = totEstCost + estCost;
                      totExpUptoLFY = totExpUptoLFY + bankLastYear
                              + paoLastYear;
                      
                      totTotExp = totTotExp + bankDuringYear
                              + paoDuringYear;
                      
                      totHabs+=noofHabs;
                  %>


          </tr>

          <%
              }
              stmt.close();
              rs.close();
          %>
          <tr>
              <td class="btext" style="text-align: right;" colspan=5>Total:</td>
              <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
              <td class="btext" style="text-align: right;"></td>
               <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td> 
              <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
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
         <%}else if(mode.equals("constituency")){ %>
         <br/><br/>
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>Works Progress for <%=dname %> District and <%=cname %> Constituency</b></font>
            <!-- <br/><br/><font color="#889900" face="Maiandra GD" size="3px">(Amount in Lakhs)</font> -->
        </center>
    <br/>
            <table align="center" style="margin-top: -35px !important; width: 1200px !important;  text-align: center !important;">
                <tr>
                    <td style="width: 1000px !important;"></td>
                    <!-- <td style="width: 100px !important;" align="right">
                        <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="30px"/></a>&nbsp;&nbsp; 
                    </td> -->
                    <td style="width: 100px !important;" align="right">
                        <a href="#" onClick="window.close();">Close&nbsp;&nbsp;</a> 
                    </td>
                </tr>
            </table>
          <table width="1200px" border=1 style="border-collapse: collapse"
           ALIGN=CENTER>
          <tr align=center>
              <td class=btext><b>SNO </b></td>
              <td class=btext ><b>District </b></td>
              <td class=btext ><b>Constituency </b></td>
              <td class=btext><b>WorkId</b></td>
              <td class=btext ><b>Work Name </b></td>
              <td class=btext ><b>Programme Name </b></td>
              <td class=btext ><b>Sanction Date </b></td>
              <td class=btext ><b>Est. Cost </b></td>
              <td class=btext ><b>No. of<br/>Habs </b></td>
              <td class=btext >Expenditure<br/>Upto<br/> 31-MAR-<%=startyr%></td> 
              <td class=btext >Expenditure during<br>(<%=startyr%>-<%=nextFinYear%>)</td>
              <td class=btext ><b>Target<br/>Date </b></td>
              <td class=btext ><b>Completion<br/>Date </b></td>
              <td class=btext ><b>Image1 </b></td>
              <td class=btext ><b>Image2</b></td>
          </tr>
         
          <%
              Statement statement = null;
              ResultSet resultSet = null;
              Statement stmt1 = null;
              ResultSet rs1 = null;
              double estCost = 0, bankLastYear = 0, bankDuringYear = 0, paoLastYear = 0,  paoDuringYear = 0, TotExp = 0;
              int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totHabs=0;
              double totarfc = 0, totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0;
              try {
                    
                    	
	                  	query="select a.work_id,a.SANCTION_AMOUNT,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),p.PROGRAMME_NAME,nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP,i.dname as dname,nvl(lead_habitation,'--') as lead_habitation from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_programme_tbl p,rws_constituency_tbl c where substr(lead_habitation,1,2)=c.dcode and substr(lead_habitation,6,2)=c.mcode and p.programme_code=a.programme_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	           		 
	                  	query+=" and substr(a.work_id,5,2)='"+dcode+"' and c.constituency_code='"+ccode+"' and type_of_asset in("+schemes+") ";
	        		
	                  	query+=" and a.programme_code in ("+programe+")";
	                  	
                   
        		
                 
                  stmt = conn.createStatement();
                  rs = stmt.executeQuery(query);
                  while (rs.next()) {
                      String compDate = "";
                      estCost = rs.getDouble(2);
                      String workid = rs.getString("work_id");
                      String workCompletion = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='"
                              + rs.getString("work_id")
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
                      String habs = "select count(distinct h.hab_code) from RWS_WORK_ADMN_TBL a,RWS_ADMN_HAB_LNK_TBL h,rws_complete_hab_view c where a.work_id=h.work_id and a.work_id='"
                              + rs.getString("work_id") + "' and h.hab_code=c.panch_code ";
                     
                      /* String habsSanctioned="select count(distinct b.hab_code) from RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c , rws_district_tbl i where a.work_id=b.work_id and b.hab_code=c.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
         			 
  			 		habsSanctioned+=" and substr(a.work_id,5,2)='"+dcode+"' ";
  				
  					habsSanctioned+=" and type_of_asset in("+scheme+") ";
  				
  					habsSanctioned+=" and a.programme_code in ("+programe+")  "; */
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(habs);
                      if (resultSet.next()) {
                          noofHabs = resultSet.getInt(1);
                      } else {
                          noofHabs = 0;
                      }
                      statement.close();
                      resultSet.close();
                      
                      
					  String leadHabitation=rs.getString("lead_habitation");
                      
                      String constituency="--";
                      if(!leadHabitation.equals("--")){
                      String constituencyQuery = "select constituency_name from rws_constituency_tbl where dcode='" + leadHabitation.substring(0,2) + "' and mcode='"+ leadHabitation.substring(5,7) +"'";
                          
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(constituencyQuery);
                      if (resultSet.next()) {
                    	  constituency = resultSet.getString("constituency_name");
                      } 
                      statement.close();
                      resultSet.close();
                      }
                      else{
                    	  constituency=leadHabitation;
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
              <td class="<%=style%>" style="text-align: left;" align="right"><%=constituency%></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(1)%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("programme_name")%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(rs.getDouble(2))%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=noofHabs%></td>
               <%
               
               
                  String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where  txid is not null and work_id='"
                          + workid
                          + "' and BANK_SEND_DATE<='31-MAR-"+startyr+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankLFY);
                 
                  if (rs1.next()) {
                      bankLastYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();
                  String paoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where  state_txid is not null and work_id='"
                          + workid
                          + "' and STATE_SEND_DATE<='31-MAR-"+startyr+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(paoFLY);
                 
                  if (rs1.next()) {
                      paoLastYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();
  				
                  String finalamount = ndf
                          .format((bankLastYear + paoLastYear) / 100000);
                  
                  String bankDFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and BANK_SEND_DATE>='01-APR-"+startyr+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankDFY);
                 
                  if (rs1.next()) {
                      bankDuringYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();
                  String paoDFY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and STATE_SEND_DATE>='01-APR-"+startyr+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(paoDFY);
                 
                  if (rs1.next()) {
                      paoDuringYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();
  				
                  String finalamount1 = ndf
                          .format((bankDuringYear + paoDuringYear) / 100000);
              %>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount%></td> 
             <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount1%></td> 
             
             <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString("TARGET_DATE_COMP")%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=compDate%></td>

             <%
                  String image1 = "select WORK_IMAGE,dbms_lob.getlength(WORK_IMAGE) from rws_work_image_tbl where WORK_ID='"
                          + rs.getString("work_id") + "'";
                  statement = conn.createStatement();
                  resultSet = statement.executeQuery(image1);

                  if (resultSet.next()) {
                	  int b=resultSet.getInt(2);
			    		 if(b==0){
			    			 %>
		              		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
		              		<%
			    	     }else{
		             		 %>
		              		<td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=workid%>&mode=image1"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=workid%>&mode=image1"  width="350px" height="230px"/></span></a></td>
		              		<%
			     }} else {
     	            %>
       					<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
           			<%
               		}
                      statement.close();
                      resultSet.close();

                      String image2 = "select WORK_IMAGE1,dbms_lob.getlength(WORK_IMAGE1) from rws_work_image_tbl where WORK_ID='"
                              + rs.getString("work_id") + "'";
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(image2);

                      if (resultSet.next()) {
                    	  int a=resultSet.getInt(2);
                   	   if(a==0){
    				    	%>
           			  		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                 			<%}else{
                 			%>
             					<td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=workid%>&mode=image2"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=workid%>&mode=image2"  width="350px" height="230px"/></span></a></td>
		             		<%
             			} }else {
             			  	%>
           			  	<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                 			<%
                 		}
                      statement.close();
                      resultSet.close();
                      totEstCost = totEstCost + estCost;
                      totExpUptoLFY = totExpUptoLFY + bankLastYear
                              + paoLastYear;
                      
                      totTotExp = totTotExp + bankDuringYear
                              + paoDuringYear;
                      
                      totHabs+=noofHabs;
                  %>


          </tr>

          <%
              }
              stmt.close();
              rs.close();
          %>
          <tr>
              <td class="btext" style="text-align: right;" colspan=7>Total:</td>
              <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
              <td class="btext" style="text-align: right;"></td>
               <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td> 
              <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
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
         <%} %>
<br/>
        <table height="20px" align="center">
            <tr height="1%">
                <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                    Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
                </td>
            </tr>
        </table>
<br/>
</html:html>
