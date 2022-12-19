<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1"%>

    <%@page import="nic.watersoft.works.WorksData1"%>

<%@page import="java.sql.Connection"%>

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%@ include file="/reports/conn.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- New JJM report Created on 04-06-2021 by subbu -->

<%    DecimalFormat ndf = new DecimalFormat("####.00");

   String scode="0"; //JJM program code

   

   String mode = "circles";

   if (request.getParameter("mode") != null)

   	mode = request.getParameter("mode");

   String programmeName= "JJM";

	if(request.getParameter("programmeName")!= null)

		programmeName= request.getParameter("programmeName");

   String programme = "89";

   String schemes = "01,02,03,10";

   String schemeName = "";

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

    String y="";

    if(request.getParameter("finyear")!=null){

    	y=request.getParameter("finyear");

    yearStart = Integer.parseInt(y.substring(0,4));

    yearEnd = yearStart + 1;

    }

    else{

    	if (month <= 3) {

            yearStart = cyear - 1;

            yearEnd = cyear;

        } else {

            yearStart = cyear;

            yearEnd = cyear + 1;

        }

    }

    int startFinYear=0;

    if (month <= 3) {

    	startFinYear = cyear - 1;

       

    } else {

    	startFinYear = cyear;

       

    }

    String ye=""+yearEnd;

    ye=ye.substring(2,4).toString();

    

    int yEnd=Integer.parseInt(ye);

    

    String InputPhyFinStr="";

  	//String names="";


%>

<html>

<script src="/pred/resources/graphs/jquery.min.js"></script>


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


<style type="text/css">

    body, body a {

        font-family: "Verdana", Georgia, Serif !important;

        font-size: 13px !important;

    }

    .btext {

        border: 1px solid #000000 !important;

        font-family: "Maiandra GD", Georgia, Serif !important;

        font-size: 12px !important;

    }

    .rightPad td {

        padding-right: 3px !important;

    }

</style>


<body>

<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>

    <br/>

    <br/>

    <form name=f1 id="f1" >

    <center>


            <font color="#663899" face="Maiandra GD" size="4px"><b>Works Abstract Progress Report(new)</b></font>

            <br/><br/><font color="#889900" face="Maiandra GD" size="3px"  >Programme: JJM

            <b><%if(mode.equals("divisions")){ %>

			 , Circle: <%=request.getParameter("cname") %>

			<%}else if(mode.equals("subdivisions")){  %>

			, Circle: <%=request.getParameter("cname") %>

			 , Division: <%=request.getParameter("divname") %>

			<%} %></b>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: <%=yearStart%>-<%=yEnd%></font>

         </center>           

       

     <br>

     <br>

		<table align="center"

			style="margin-top: -45px !important; width: 1050px !important; text-align: center !important;">

			<tr>

				<td style="width: 1000px !important; text-align: left !important;"><font

					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>

					<td style="width: 40px !important;">

                    <!-- <a href="rws_work_progress_CM_abstract_rpt.jsp?programme=00&mode1=Bar" style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a> --></td>

                     

				<td style="width: 100px !important;" align="right"><a

					href="javascript:history.back(-1)"><img

						src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;

			</td>

			</tr>

		</table>

		

		<br/><br/>

       <table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px" bordercolor=#000000 style="border-collapse: collapse; margin-top: 20px !important;" bgcolor="#ffffff" align="center">

		<tr align=center align=center>

			<td class=btext rowspan="2">Sl.No</td>

			<%if(mode.equals("circles")){ %>

			<td class=btext rowspan="2">Circle</td>

			<%}else if(mode.equals("divisions")){ %>

			<td class=btext rowspan="2">Division</td>

			<%}else if(mode.equals("subdivisions")){ %>

			<td class=btext rowspan="2">Sub Division</td>

			<%} %>

		 	<td class=btext rowspan="2">Works Sanctioned</td>

		 	<td class=btext rowspan="2" >Est. Cost</td>

            <td class=btext rowspan="2">No of Works Cancelled</td>

            <td class=btext rowspan="2">Est. Cost</td>

            <td class=btext  colspan="2">Achivements upto Previous year</td>

           <td class=btext  colspan="7">Balance Program for the current financial year</td>

         

          </tr>

          <tr> 

           <td class=btext align="center"  >Works<br/>Completed</td>

            <td class=btext align="center" >Expenditure for all works</td>

             <td class=btext align="center"  >Works</td>

             <td class=btext align="center" >Bal. Cost</td>

              <td class=btext align="center" >Expenditure</td>

            <td class=btext align="center" >Works<br/>Not<br/>Grounded</td>

            <td class=btext align="center"  >Works<br/>Grounded</td>

            <td class=btext align="center" >Works<br/>Comp.</td>

            <td class=btext >Bills raised so far</td>  

          </tr>            

		<%

		int styleCount = 0;

		String style = "";

		 Connection connection = null;

         Statement stmt1 = null;

         ResultSet rs1 = null;

         int slno = 0;

         Statement stmt2=null;

 		 ResultSet rs2=null; 

 		 double totbillamt=0.0,totCancelEstCst=0.0,totPrevExp=0.0,totBalCost=0.0,totCurrExp=0.0;

             int totNoOfWorks = 0,totCancelWork = 0,totPrevWorks = 0,totCurrWorks=0,  totWorksComp = 0, totWorksNotGround=0,totWorksGround=0,prevCompWorks=0;

             int noOfCancelWorks = 0,currentYearWorks = 0;

             double  totEstCost = 0,balCost = 0,totCurrBalCost=0,estCostCancelWorks = 0,expUptoPrevYearPAO = 0,expUptoPrevYearBank = 0,texpUptoPrevYear = 0;

            // double arfc = 0, nrdwparfc = 0, nrdwpEstCost = 0, nrdwpExpUptoLFY = 0, nrdwpExpUptoLM = 0, nrdwpExpDM = 0, nrdwpTotExp = 0, nrdwpExpPhyCompNotFin = 0, nrdwpBankPhyCompNotFin = 0, nrdwpPaoPhyCompNotFin = 0, nrdwpTotExpPhyCompNotFin = 0, nrdwpAmtInclPhyCompNotFin = 0;

             

             String query = "",cancelWorksQry="";String Not_Grounded_Query="",prevWorksQry = "";

             String groundWorks = "",expenditureUptoPrevQry="",currentYearWorksQry = "";

             


String compWorks = "";

//String comphabs = "";


String  bankCM= "";

String paoCM= "";


		String ccode = "",c_query="";

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

        }

		try{

	 		 if(mode.equals("circles")){

	 			c_query="select circle_office_code,circle_office_name from rws_circle_office_tbl  order by circle_office_code";

            }

            else if(mode.equals("divisions")){

            	c_query="select division_office_code,division_office_name from rws_division_office_tbl where  circle_office_code='"+ccode+"' and status <> 'UI' order by division_office_code";

            }

            else if(mode.equals("subdivisions")){

            	 c_query="select subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where  circle_office_code='"+ccode+"' and division_office_code='"+divCode+"' order by subdivision_office_code";

            }

         //System.out.println("query"+c_query);

          PreparedStatement preparedStatement = conn.prepareStatement(c_query);

          ResultSet res = preparedStatement.executeQuery();

          while(res.next()){

        	  double estCost = 0, bankYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0,expPhyCompNotFin = 0, expIncBankPhyCompNotFin=0, expIncPhyCompNotFin=0;
			  prevCompWorks = 0;

              int noOfWorks = 0,  worksComp = 0,  worksPhyCompNotFin = 0,worksNotGround=0,worksGround=0,worksComm=0;

              double billamount=0.0;

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

			    if (styleCount % 2 == 0) {

			        style = "gridbg1";

				} else {

					style = "gridbg2";

				}

				styleCount++;  


				/* if(programme.equals(scode) && schemeName.contains("laks")){

					//String schemeName = request.getParameter("schemeName");

					if(schemeName.contains("Below 5 laks")){

						 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"

		                           + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "

		                           + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "

		                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "

		                           + "and a.TYPE_OF_ASSET in (" + schemes + ")   and a.SANCTION_AMOUNT <=5 ";

					}else{

						 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"

		                           + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "

		                           + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "

		                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "

		                           + "and a.TYPE_OF_ASSET in (" + schemes + ")   and a.SANCTION_AMOUNT >5 ";

					}

				}else{ */

					
	                    query =     "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p "

	                           +" where  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and  "

								+"  a.TYPE_OF_ASSET in (" + schemes + ")   "

								+"   ";

				
			System.out.println("Total works Qry :"+query);
				  

			if(mode.equals("circles")){ 

				query  = query+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

			}

			else if(mode.equals("divisions")){

				query = query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

			}

			else if(mode.equals("subdivisions")){

				query = query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

			}

		//System.out.println("query "+query);	

		stmt1 = conn.createStatement();

		rs1 = stmt1.executeQuery(query);

		if(rs1.next())

		{

			 noOfWorks = rs1.getInt(2);

             estCost = rs1.getDouble(1);

	    }

		

		rs1.close();

		stmt1.close();

		//---------

			                 prevWorksQry    =     "select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a "
														+" where a.work_id in (select work_id from rws_work_completion_tbl where  "
													+" DATE_OF_COMPLETION<'01-APR-" + yearStart + "')   and  a.TYPE_OF_ASSET in (" + schemes + ") and "
													+"  a.PROGRAMME_CODE in (" + programme + ")   ";

				

			                 System.out.println("prevCompWorks"+prevWorksQry);  

			if(mode.equals("circles")){ 

				prevWorksQry  = prevWorksQry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

			}

			else if(mode.equals("divisions")){

				prevWorksQry = prevWorksQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

			}

			else if(mode.equals("subdivisions")){

				prevWorksQry = prevWorksQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

			}

			

		stmt1 = conn.createStatement();

		rs1 = stmt1.executeQuery(prevWorksQry);

		if(rs1.next())

		{

			 prevCompWorks = rs1.getInt(1);

            

	    }

		

		rs1.close();

		stmt1.close();

		

		///////

		cancelWorksQry = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p " 

							+" where WORK_CANCEL_DT is not null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") " 

 							+"  and a.TYPE_OF_ASSET in (" + schemes + ")   "

							+"  "; 

		System.out.println("cancelWorksQry "+cancelWorksQry);
		
		if(mode.equals("circles")){ 

			cancelWorksQry  = cancelWorksQry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

		}

		else if(mode.equals("divisions")){

			cancelWorksQry = cancelWorksQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

		}

		else if(mode.equals("subdivisions")){

			cancelWorksQry = cancelWorksQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

		}

	//System.out.println("query"+query);	

	stmt1 = conn.createStatement();

	rs1 = stmt1.executeQuery(cancelWorksQry);

	if(rs1.next())

	{

		 noOfCancelWorks = rs1.getInt(2);

         estCostCancelWorks = rs1.getDouble(1);

    }

	

	rs1.close();

	stmt1.close();

	

	expenditureUptoPrevQry = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m " 

							+" where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id"

							+" and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)<='31-MAR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'"; 

		

	if(mode.equals("circles")){ 

		expenditureUptoPrevQry  = expenditureUptoPrevQry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

	}

	else if(mode.equals("divisions")){

		expenditureUptoPrevQry = expenditureUptoPrevQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

	}

	else if(mode.equals("subdivisions")){

		expenditureUptoPrevQry = expenditureUptoPrevQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

	}

	//System.out.println("query"+query);	

	stmt1 = conn.createStatement();

	rs1 = stmt1.executeQuery(expenditureUptoPrevQry);

	if(rs1.next())

	{

		expUptoPrevYearPAO = rs1.getDouble(1);

	}

	

	rs1.close();

	stmt1.close();

	

	

	expenditureUptoPrevQry = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m " 

							+" where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and b.work_id=a.work_id and i.work_id(+)=a.work_id and " 

							+" c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)<='31-MAR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'"; 


		if(mode.equals("circles")){ 

		expenditureUptoPrevQry  = expenditureUptoPrevQry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

		}

		else if(mode.equals("divisions")){

		expenditureUptoPrevQry = expenditureUptoPrevQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

		}

		else if(mode.equals("subdivisions")){

		expenditureUptoPrevQry = expenditureUptoPrevQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

		}

		//System.out.println("query"+query);	

		stmt1 = conn.createStatement();

		rs1 = stmt1.executeQuery(expenditureUptoPrevQry);

		if(rs1.next())

		{

		expUptoPrevYearBank = rs1.getDouble(1);

		}

		

		rs1.close();

		stmt1.close();

		//double expPrevYear =  expUptoPrevYearBank + expUptoPrevYearPAO;
		double expUptoPrevYear = (expUptoPrevYearBank + expUptoPrevYearPAO) / 100000;

		

		

		/* currentYearWorksQry = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p " 

							 +" where   a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.work_cancel_dt is null and a.work_id not in (select work_id from rws_work_completion_tbl )"

				 			+"  and a.TYPE_OF_ASSET in (" + schemes + ")   "

							+"  ";


		System.out.println("currentYearWorksQry "+currentYearWorksQry);
				if(mode.equals("circles")){ 

					currentYearWorksQry  = currentYearWorksQry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

					}

					else if(mode.equals("divisions")){

						currentYearWorksQry = currentYearWorksQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

					}

					else if(mode.equals("subdivisions")){

						currentYearWorksQry = currentYearWorksQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

					}

					//System.out.println("query"+query);	

					stmt1 = conn.createStatement();

					rs1 = stmt1.executeQuery(currentYearWorksQry);

					if(rs1.next())

					{

					

					}

					

					rs1.close();

					stmt1.close(); */

					currentYearWorks = noOfWorks -(noOfCancelWorks+prevCompWorks);

		 String billsamtquery = "";

		/*  if(programme.equals(scode) && schemeName.contains("laks")){

			 if(schemeName.contains("Below 5 laks")){

		    		//schemeName +=" (Below 5 laks)";

		    		billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"

                      + "rws_contractor_selection_tbl m  ,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "

                      + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "

                      + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "

                      + "and a.TYPE_OF_ASSET in (" + schemes + ")   and  wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no ) and a.SANCTION_AMOUNT <=5";

		    	}else{

		    		//schemeName +=" (Above 5 laks)";

		    		billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"

                      + "rws_contractor_selection_tbl m ,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "

                      + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "

                      + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "

                      + "and a.TYPE_OF_ASSET in (" + schemes + ")   and   wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no ) and  a.SANCTION_AMOUNT >5 ";

		    	}

         	 //System.out.println("groundWorks :"+groundWorks);

         }else{ */

         	/* billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"

                      + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "

                      + " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) "

                      + " and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "

                      + " and a.TYPE_OF_ASSET in (" + schemes + ")   and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no )";
 */
 billsamtquery=" select sum(b.BILL_AMT_ADMISSIBLE) from rws_work_bill_tbl b,rws_work_admn_tbl a where a.work_id=b.work_id and a.programme_code=" + programme + " "
		 			+" and a.TYPE_OF_ASSET in (" + schemes + ") and not EXISTS  (select 1 from rws_bill_bank_bridge_tbl wb where b.work_id=wb.work_id "
		 		+"and b.bill_sl_no=wb.BILL_SL_NO)";

         //System.out.println("billsamtquery "+billsamtquery);

		 if(mode.equals("circles")){ 

			 billsamtquery = billsamtquery+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

			}else if(mode.equals("divisions")){

				billsamtquery = billsamtquery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

			}

			else if(mode.equals("subdivisions")){

				billsamtquery = billsamtquery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

			}

         

         stmt1 = conn.createStatement();

         rs1 = stmt1.executeQuery(billsamtquery);

         if (rs1.next()) {

           billamount = rs1.getDouble(1); 
           if(billamount != 0)
        	   billamount = billamount/100000;

         }

         stmt1.close();

         rs1.close();

		

		

		//////////

		

		

		if(programme.equals(scode) && schemeName.contains("laks")){

			//String schemeName = request.getParameter("schemeName");

			if(schemeName.contains("Below 5 laks")){

				 Not_Grounded_Query = "select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p "
			        		+" where a.work_id not in (select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null )  and WORK_CANCEL_DT is null "
			        		+" and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ")    and    a.PROGRAMME_CODE in ("+programme+") "
			        		+" and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-"+ yearStart+"')"

	            +"     and a.SANCTION_AMOUNT <=5";

			}else{

				 Not_Grounded_Query = "select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p "
			        		+" where a.work_id not in (select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null )  and WORK_CANCEL_DT is null "
			        		+" and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ")    and    a.PROGRAMME_CODE in ("+programme+") "
			        		+" and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-"+ yearStart+"') "

	            +"      and a.SANCTION_AMOUNT >5 ";

			}

		}else{
			
			/* Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "

					   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 

	            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION) >= '01-APR-"+yearStart+"' and TO_DATE(DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "')  " 

	            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ")    and  "

	            +"  a.PROGRAMME_CODE in ("+programme+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "

	            +"   "; */
		
	        Not_Grounded_Query = "select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p "
	        		+" where a.work_id not in (select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null )  and WORK_CANCEL_DT is null "
	        		+" and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ")    and    a.PROGRAMME_CODE in ("+programme+") "
	        		+" and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-"+ yearStart+"') ";

		}
		System.out.println("Not_Grounded_Query :"+Not_Grounded_Query);

		 if(mode.equals("circles")){ 

		 Not_Grounded_Query = Not_Grounded_Query+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 

		}else if(mode.equals("divisions")){

			Not_Grounded_Query = Not_Grounded_Query+ " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"; 		

		}else if(mode.equals("subdivisions")){

			Not_Grounded_Query= Not_Grounded_Query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

		}

      stmt1 = conn.createStatement();

      rs1 = stmt1.executeQuery(Not_Grounded_Query);

      if (rs1.next()) {

        worksNotGround = rs1.getInt(1);    

      }

      stmt1.close();

      rs1.close();                                                                                                                                                                       

      if(programme.equals(scode) && schemeName.contains("laks")){

			//String schemeName = request.getParameter("schemeName");

			if(schemeName.contains("Below 5 laks")){

		

				groundWorks = "select count(distinct a.work_id) "
	            		 +" from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m" 
	            		 +" where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
	            		 +" and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
	            		 +" and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  and a.TYPE_OF_ASSET in (" + schemes + ")   and a.SANCTION_AMOUNT <=5 ";

			}

			else

			{  groundWorks = "select count(distinct a.work_id) "
           		 +" from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m" 
           		 +" where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
           		 +" and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
           		 +" and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.SANCTION_AMOUNT >5";

				

			}

      }else

      {

    	/*   groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"

                  + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "

                  + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "

                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "

                  + "and a.TYPE_OF_ASSET in (" + schemes + ")   "; */
    	
                  
                  groundWorks = "select count(distinct a.work_id) "
            		 +" from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m" 
            		 +" where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
            		 +" and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
            		 +" and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  and a.TYPE_OF_ASSET in (" + schemes + ") ";

      }
      System.out.println("groundWorks :"+groundWorks);

        if(mode.equals("circles")){ 

        	groundWorks = groundWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 

		}else if(mode.equals("divisions")){

			groundWorks = groundWorks+ " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"; 		

		}else if(mode.equals("subdivisions")){

			groundWorks= groundWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

		}

        stmt1 = conn.createStatement();

        rs1 = stmt1.executeQuery(groundWorks);

        if (rs1.next()) {

          worksGround = rs1.getInt(1);    

        }

        stmt1.close();

        rs1.close();

		

        

        if(programme.equals(scode) && schemeName.contains("laks")){

			//String schemeName = request.getParameter("schemeName");

			if(schemeName.contains("Below 5 laks")){

				compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) "
		        		  +" from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd " 
		        		  +" where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and "
		        		  +" i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in (" + programme + ")   and " 
		        		  +" TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and " 
		        		  +" a.TYPE_OF_ASSET in (" + schemes + ") and a.SANCTION_AMOUNT <=5 ";//TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and

			}else

			{ compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) "
	        		  +" from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd " 
	        		  +" where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and "
	        		  +" i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in (" + programme + ")   and " 
	        		  +" TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and " 
	        		  +" a.TYPE_OF_ASSET in (" + schemes + ") and a.SANCTION_AMOUNT >5"; //TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and

				}

        }else

        { compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) "
        		  +" from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd " 
        		  +" where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and "
        		  +" i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in (" + programme + ")   and " 
        		  +" TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and " 
        		  +" a.TYPE_OF_ASSET in (" + schemes + ")";//TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and

			}

                if(mode.equals("circles")){ 

			compWorks = compWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 

		}else if(mode.equals("divisions")){

			compWorks = compWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

		}else if(mode.equals("subdivisions")){

			compWorks = compWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"; 

		}

		System.out.println("compWorks "+compWorks)	;	

		stmt2 = conn.createStatement();

		rs2 = stmt2.executeQuery(compWorks);

		while(rs2.next()){

			  worksComp = rs2.getInt(1);

		}

		rs2.close();

		stmt2.close();

		

			

		

		  

			   

		  if(programme.equals(scode) && schemeName.contains("laks")){

				//String schemeName = request.getParameter("schemeName");

				if(schemeName.contains("Below 5 laks")){


		  

		  

		  bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "

                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "

                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "

                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";

		

                 

				}else

				{  bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "

		                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "

		                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "

		                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";

				}

				}else

				{

					  bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "

				                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "

				                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "

				                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";

						

				}

                 

                 

                 if(mode.equals("circles")){ 

			bankCM = bankCM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

		}else if(mode.equals("divisions")){

			bankCM = bankCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

  		}else if(mode.equals("subdivisions")){

  			bankCM = bankCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

		}		

		 //System.out.println("bankCM"+bankCM);	

		stmt2 = conn.createStatement();

		rs2 = stmt2.executeQuery(bankCM);

		if(rs2.next()){

			 bankCurrentMonth = rs2.getDouble(1);

		}

		rs2.close();

		stmt2.close();

		if(programme.equals(scode) && schemeName.contains("laks")){

			//String schemeName = request.getParameter("schemeName");

			if(schemeName.contains("Below 5 laks")){



		

		

		 paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "

                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "

                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "

                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";

			}else

			{ paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "

	                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "

	                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "

	                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";

				}

		}else

		{ paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "

                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "

                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "

                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";

			}

                

                

                if(mode.equals("circles")){ 

			paoCM=paoCM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";

		}else if(mode.equals("divisions")){

			paoCM=paoCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";

		}else if(mode.equals("subdivisions")){

			paoCM=paoCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";

		}

		//System.out.println("paoCM"+paoCM);	

		stmt2 = conn.createStatement();

		rs2 = stmt2.executeQuery(paoCM);

		if(rs2.next()){

			 paoCurrentMonth = rs2.getDouble(1);

		}rs2.close();

			stmt2.close();

			//String amountCM = ndf.format((bankCurrentMonth + paoCurrentMonth) / 100000);

			double currBills = (bankCurrentMonth + paoCurrentMonth)/100000;
			double amountTot = ( bankCurrentMonth + paoCurrentMonth) / 100000;


			       balCost = estCost - (estCostCancelWorks + expUptoPrevYear);


            // arfc = estCost - (bankLastYear + paoLastYear + bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000;

            if(noOfWorks==0 && estCost==0  && worksComp==0   &&

            bankYear==0.0 && paoYear==0.0 && bankLastMonth ==0.0 && paoLastMonth==0.0 &&

              bankCurrentMonth ==0.0 && paoCurrentMonth==0.0 && worksPhyCompNotFin==0.0) {}else{

         %>

             <tr>            

            

                      <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>

                     <% if (mode.equals("circles")) {%>

                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_new_abstract_rpt.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&schemes=<%=schemes%>&schemeName=<%=schemeName %>"><%=cname%></a></td>
 <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=tWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td>

                      <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>

                      <td class="<%=style%>" style="text-align: right;" align="right"><%=noOfCancelWorks%></td>

                       <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCostCancelWorks)%></td>

                       <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=wcPrevYear&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%= prevCompWorks%></a></td> <!-- works completed last year -->

                       <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expUptoPrevYear)%></td>

                        <td class="<%=style%>" style="text-align: right;" align="right"><%=currentYearWorks%></td><!-- <a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=worksYear&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"> -->

                         <td class="<%=style%>" style="text-align: right;" align="right"><%= ndf.format(balCost )%></td> <!-- Bal Cost -->

                        <td class="<%=style%>" style="text-align: right;" align="right"><%= ndf.format(amountTot)%></td>
						 

                         <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=ngWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksNotGround%></a></td>
						  <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=gWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksGround%></a></td>
						   <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=cWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>

                         <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(billamount)%></td>



                     <% 

                     } else if (mode.equals("divisions")) {   %>

                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_new_abstract_rpt.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>"><%=divName%></a></td>
 <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=tWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td>

                      <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>

                      <td class="<%=style%>" style="text-align: right;" align="right"><%=noOfCancelWorks%></td>

                       <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCostCancelWorks)%></td>

                       <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=wcPrevYear&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%= prevCompWorks%></a></td> <!-- works completed last year -->

                       <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expUptoPrevYear)%></td>

                        <td class="<%=style%>" style="text-align: right;" align="right"><%=currentYearWorks%></td><!-- <a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=worksYear&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"> -->

                         <td class="<%=style%>" style="text-align: right;" align="right"><%= ndf.format(balCost )%></td> <!-- Bal Cost -->

                        <td class="<%=style%>" style="text-align: right;" align="right"><%= ndf.format(amountTot)%></td>
						 

                         <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=ngWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksNotGround%></a></td>
						  <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=gWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksGround%></a></td>
						   <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=cWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>

                         <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(billamount)%></td>

                                        
                     <% 


                     } else if (mode.equals("subdivisions")) { %>

                   	 <td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>

                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=tWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td>

                      <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>

                      <td class="<%=style%>" style="text-align: right;" align="right"><%=noOfCancelWorks%></td>

                       <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCostCancelWorks)%></td>

                       <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=wcPrevYear&soc=<%=subdivCode%>&son=<%=subdivName%>&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%= prevCompWorks%></a></td> <!-- works completed last year -->

                       <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expUptoPrevYear)%></td>

                        <td class="<%=style%>" style="text-align: right;" align="right"><%=currentYearWorks%></td><!-- <a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=worksYear&soc=<%=subdivCode%>&son=<%=subdivName%>&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"> -->

                         <td class="<%=style%>" style="text-align: right;" align="right"><%= ndf.format(balCost )%></td> <!-- Bal Cost -->

                        <td class="<%=style%>" style="text-align: right;" align="right"><%= ndf.format(amountTot)%></td>
						 

                         <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=ngWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksNotGround%></a></td>
						  <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=gWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksGround%></a></td>
						   <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=cWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>

                         <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(billamount)%></td>
                       
                      <%   

                      

                     } %> 

                                       
        		</tr>    

        			 

        <%       }

            	 totNoOfWorks = totNoOfWorks + noOfWorks;
                 totEstCost = totEstCost + estCost;
 					totCancelWork +=noOfCancelWorks;
                 
                 totCancelEstCst +=estCostCancelWorks;
                 totPrevWorks += prevCompWorks;
                 totPrevExp += expUptoPrevYear;
                 totCurrBalCost += balCost;
                 totCurrWorks += currentYearWorks;
                 totbillamt=totbillamt+billamount;
                 totWorksNotGround = totWorksNotGround + worksNotGround;
                 totWorksGround = totWorksGround + worksGround;
                 totWorksComp = totWorksComp + worksComp;              
                 totCurrExp += currBills;

          }

            

          

             if (slno == 0) {

         %>

     <tr>

         <td colspan="13" class="<%=style%>" style="text-align: center;">NO Records Found</td>

     </tr>

     <%

             }  %>

		 	<tr class="rightPad">

                <td class="btext" style="text-align: right;" colspan=2>Total:</td>

                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>

                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>

                <td class="btext" style="text-align: right;"><%=totCancelWork%></td>

                <td class="btext" style="text-align: right;"><%=ndf.format(totCancelEstCst)%></td>

                <td class="btext" style="text-align: right;"><%=totPrevWorks%></td>

                <td class="btext" style="text-align: right;"><%=ndf.format(totPrevExp)%></td>

                <td class="btext" style="text-align: right;"><%=totCurrWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totCurrBalCost)%></td>

                <td class="btext" style="text-align: right;"><%=ndf.format(totCurrExp)%></td>

                <td class="btext" style="text-align: right;"><%=totWorksNotGround%></td>

                <td class="btext" style="text-align: right;"><%=totWorksGround%></td>

                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
 <td class="btext" style="text-align: right;"><%=ndf.format(totbillamt)%></td>

              

            </tr>

		

		<%

		}catch (Exception e) {

			e.printStackTrace();

		}finally {

			try {

				if (conn != null) {

					conn.close();

				}

			} catch (Exception e) {

				e.printStackTrace();

			}finally{}

		}

			%>

		</table>

			<br/>

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

				

</body>

</html>


