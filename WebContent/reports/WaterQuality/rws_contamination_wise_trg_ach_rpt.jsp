<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat formatter = new DecimalFormat("##,##,##,###");
	String Finyear="2018-2019" ;
    String startFinYear = Finyear.substring(0, 4);
    String endFinYear = Finyear.substring(Finyear.length() - 4);
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Contamination Wise Target and Achievement Report</title>
	<style type="text/css">
	 .gridhdbg{
	 	padding:5px 5px;
	 }
	 .gridhdbg12{
	 	padding:5px 5px;
	 }
	</style>
	<script type="text/javascript">
		function viewWorks(URL) {
			var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
			if (URL != "") {
				myNewWin = window.open(URL, 'newWinddow', popFeatures);
				myNewWin.focus();
			}
		}
	</script>
</head>
<body>
	<table border="0" cellspacing="0" cellpadding="0" width="80%" style="border-collapse:collapse" align="center">
		<thead>
			<tr align="right">	
				<th colspan="35"><a href="/pred/home.jsp?loginMode=watersoft">Home</a> | &nbsp;<a href="javascript:onclick=history.go(-1)">Back</a></th>
			</tr>  
			<tr>
				<th align="center" class="gridhdbg" colspan="35">Contamination Wise Target and Achievement as on (<%=Finyear%>)</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
			    <th class="gridhdbg" rowspan="2"> District </th>
			    <th class="gridhdbg" colspan="3"> Total</th>
			    <th class="gridhdbg" colspan="3"> Arsenic </th>
			    <th class="gridhdbg" colspan="3"> Fluoride </th>
			    <th class="gridhdbg" colspan="3"> Iron </th>
			    <th class="gridhdbg" colspan="3"> Salinity </th>			   
			    <th class="gridhdbg" colspan="3"> Nitrate </th>				
			</tr>
			<tr>
				<th class="gridhdbg">As on (01/04/<%=startFinYear %>)</th>
				<th class="gridhdbg">Target</th>
				<th class="gridhdbg">Achievement</th>
				<th class="gridhdbg">As on (01/04/<%=startFinYear %>)</th>
				<th class="gridhdbg">Target</th>
				<th class="gridhdbg">Achievement</th>
				<th class="gridhdbg">As on (01/04/<%=startFinYear %>)</th>
				<th class="gridhdbg">Target</th>
				<th class="gridhdbg">Achievement</th>
				<th class="gridhdbg">As on (01/04/<%=startFinYear %>)</th>
				<th class="gridhdbg">Target</th>
				<th class="gridhdbg">Achievement</th>
				<th class="gridhdbg">As on (01/04/<%=startFinYear %>)</th>
				<th class="gridhdbg">Target</th>
				<th class="gridhdbg">Achievement</th>
				<th class="gridhdbg">As on (01/04/<%=startFinYear %>)</th>
				<th class="gridhdbg">Target</th>
				<th class="gridhdbg">Achievement</th>				
			</tr>
		</thead>
		<tbody>
			<%	PreparedStatement ps1=null, ps2=null, ps3=null, ps4=null, ps5=null, ps6=null, ps7=null, ps8=null;
				ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null, rs7=null, rs8=null;
				String style=null, Dcode=null;
				int  totalHAsOn=0, totalHTarget=0, totalHAchieve=0, AsAsOn=0, AsTarget=0, AsAchieve=0, FAsOn=0, FTarget=0, FAchieve=0, FeAsOn=0, FeTarget=0, FeAchieve=0, SaAsOn=0, SaTarget=0, SaAchieve=0, No3AsOn=0, No3Target=0, No3Achieve=0, styleCount=1;
				int totalVAsOn=0, totalVTarget=0, totalVAchieve=0, totalAsAsOn=0, totalAsTarget=0, totalAsAchieve=0, totalFAsOn=0, totalFTarget=0, totalFAchieve=0, totalFeAsOn=0, totalFeTarget=0, totalFeAchieve=0, totalSaAsOn=0, totalSaTarget=0, totalSaAchieve=0, totalNo3AsOn=0, totalNo3Target=0, totalNo3Achieve=0;
				int count=0;
				try{									
					String query1="SELECT DISTINCT DCODE, DNAME FROM RWS_COMPLETE_HAB_DYNA_VIEW ORDER BY DCODE";
					//System.out.println("query1 ="+query1);					
					ps1=conn.prepareStatement(query1);
					rs1=ps1.executeQuery();
					while(rs1.next()){
						totalHAsOn=0; totalHTarget=0; totalHAchieve=0; AsAsOn=0; AsTarget=0; AsAchieve=0; FAsOn=0; FTarget=0; FAchieve=0; FeAsOn=0; FeTarget=0; FeAchieve=0; SaAsOn=0; SaTarget=0; SaAchieve=0; No3AsOn=0; No3Target=0; No3Achieve=0; 
						if(styleCount%2==0){
							 style="gridbg1";
						 }else{
							 style="gridbg2";
						 }
						String query2="SELECT DISTINCT PANCH_CODE FROM RWS_COMPLETE_HAB_DYNA_VIEW WHERE COVERAGE_STATUS='NSS' AND DCODE=? ORDER BY PANCH_CODE";
						//System.out.println("query2 ="+query2);					
						ps2=conn.prepareStatement(query2);
						ps2.setString(1, rs1.getString(1));
						rs2=ps2.executeQuery();							
						while(rs2.next()){
							//System.out.println(count++ + " Hab_code = "+ rs2.getString(1));
							int Total=0, Arsenic=0, Fluoride=0, Iron=0, Salinity=0, Nitrate=0, Heavy_Metal=0;
							String query3="SELECT SOURCE_CODE, TO_CHAR(MAX(PREPARED_ON),'DD-MM-YYYY') FROM RWS_WQ_TEST_RESULTS_TBL A,RWS_WQ_TEST_RESULTS_LNK_TBL B WHERE A.TEST_ID=B.TEST_ID AND TEST_CODE='1' AND SUBSTR(SOURCE_CODE,1,16)=? AND PREPARED_ON < TO_DATE('01-04-2018','DD-MM-YYYY') GROUP BY SOURCE_CODE ORDER BY MAX(PREPARED_ON) DESC";
							//System.out.println("query3 ="+query3);					
							ps3=conn.prepareStatement(query3);
							ps3.setString(1, rs2.getString(1));
							rs3=ps3.executeQuery();		
							while(rs3.next()){			
									String query4="SELECT DISTINCT TEST_ID FROM RWS_WQ_TEST_RESULTS_TBL WHERE SOURCE_CODE=? AND PREPARED_ON=TO_DATE(?,'DD-MM-YYYY') ORDER BY TEST_ID";
									//System.out.println("query4 ="+query4);
									ps4=conn.prepareStatement(query4);
									ps4.setString(1, rs3.getString(1));
									ps4.setString(2, rs3.getString(2));
									rs4=ps4.executeQuery();						
									while(rs4.next()){
										String query5="SELECT DISTINCT NVL(TESTING_PARAMETER_CODE,0), NVL(TESTING_PARAMETER_VALUE,0.0) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=? ORDER BY NVL(TESTING_PARAMETER_CODE,0)";
										//System.out.println("query5 ="+query5);
										ps5=conn.prepareStatement(query5);
										ps5.setString(1, rs4.getString(1));
										rs5=ps5.executeQuery();
										while(rs5.next()){
											if(rs5.getInt(1) != 0 && rs5.getInt(1) == 24){
												if(rs5.getDouble(2) > 0.01){
													 Arsenic++; 												
												}
											}
											if(rs5.getInt(1) != 0 && rs5.getInt(1) == 13){
												if(rs5.getDouble(2) > 1.5){
													Fluoride++;
												}
											}
											if(rs5.getInt(1) != 0 && rs5.getInt(1) == 16){
												if(rs5.getDouble(2) > 1.0){
													Iron++;
												}
											}
											if(rs5.getInt(1) != 0 && rs5.getInt(1) == 05){
												if(rs5.getDouble(2) > 2000){
													Salinity++;
												}
											}											
											if(rs5.getInt(1) != 0 && rs5.getInt(1) == 15){
												if(rs5.getDouble(2) > 45){
													Nitrate++;
												}
											}
										}	
										if(rs5!=null){
											rs5.close();
										}
										if(ps5!=null){
											ps5.close();
										}	
									}
							if(rs4!=null){
								rs4.close();
							}
							if(ps4!=null){
								ps4.close();
							}
							}
							if(rs3!=null){
								rs3.close();
							}
							if(ps3!=null){
								ps3.close();
							}
							if((Arsenic > 0 || Fluoride > 0) || (Iron > 0 || Salinity > 0) || (Nitrate > 0)){
								totalHAsOn=totalHAsOn+1;
								String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query6 ="+query6);
								ps6=conn.prepareStatement(query6);
								ps6.setString(1, rs2.getString(1));
								rs6=ps6.executeQuery();
								while(rs6.next()){
									totalHTarget=totalHTarget+1;
									//System.out.println("totalHTarget ="+totalHTarget);
								}
								if(rs6!=null){
									rs6.close();
								}
								if(ps6!=null){
									ps6.close();
								}
								String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query7 ="+query7);
								ps7=conn.prepareStatement(query7);
								ps7.setString(1, rs2.getString(1));
								rs7=ps7.executeQuery();
								while(rs7.next()){
									totalHAchieve=totalHAchieve+1;
									//System.out.println("totalHAchieve ="+totalHAchieve);
								}
								if(rs7!=null){
									rs7.close();
								}
								if(ps7!=null){
									ps7.close();
								} 
							}
							if(Arsenic > 0){
								AsAsOn=AsAsOn+1;
								String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query6 ="+query6);
								ps6=conn.prepareStatement(query6);
								ps6.setString(1, rs2.getString(1));
								rs6=ps6.executeQuery();
								while(rs6.next()){
									AsTarget=AsTarget+1;
									//System.out.println("AsTarget ="+AsTarget);
								}
								if(rs6!=null){
									rs6.close();
								}
								if(ps6!=null){
									ps6.close();
								}
								String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query7 ="+query7);
								ps7=conn.prepareStatement(query7);
								ps7.setString(1, rs2.getString(1));
								rs7=ps7.executeQuery();
								while(rs7.next()){
									AsAchieve=AsAchieve+1;
									//System.out.println("AsAchieve ="+AsAchieve);
								}
								if(rs7!=null){
									rs7.close();
								}
								if(ps7!=null){
									ps7.close();
								} 							
							}
							if(Fluoride > 0){
								FAsOn=FAsOn+1;
								String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query6 ="+query6);
								ps6=conn.prepareStatement(query6);
								ps6.setString(1, rs2.getString(1));
								rs6=ps6.executeQuery();
								while(rs6.next()){
									FTarget=FTarget+1;
									//System.out.println("totalHTarget ="+totalHTarget);
								}
								if(rs6!=null){
									rs6.close();
								}
								if(ps6!=null){
									ps6.close();
								}
								String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query7 ="+query7);
								ps7=conn.prepareStatement(query7);
								ps7.setString(1, rs2.getString(1));
								rs7=ps7.executeQuery();
								while(rs7.next()){
									FAchieve=FAchieve+1;
									//System.out.println("FAchieve ="+FAchieve);
								}
								if(rs7!=null){
									rs7.close();
								}
								if(ps7!=null){
									ps7.close();
								} 
							}
							if(Iron > 0){
								FeAsOn=FeAsOn+1;
								String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query6 ="+query6);
								ps6=conn.prepareStatement(query6);
								ps6.setString(1, rs2.getString(1));
								rs6=ps6.executeQuery();
								while(rs6.next()){
									FeTarget=FeTarget+1;
									//System.out.println("FeTarget ="+FeTarget);
								}
								if(rs6!=null){
									rs6.close();
								}
								if(ps6!=null){
									ps6.close();
								}
								String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query7 ="+query7);
								ps7=conn.prepareStatement(query7);
								ps7.setString(1, rs2.getString(1));
								rs7=ps7.executeQuery();
								while(rs7.next()){
									FeAchieve=FeAchieve+1;
									//System.out.println("FeAchieve ="+FeAchieve);
								}
								if(rs7!=null){
									rs7.close();
								}
								if(ps7!=null){
									ps7.close();
								} 
							}
							if(Salinity > 0){
								SaAsOn=SaAsOn+1;
								String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query6 ="+query6);
								ps6=conn.prepareStatement(query6);
								ps6.setString(1, rs2.getString(1));
								rs6=ps6.executeQuery();
								while(rs6.next()){
									SaTarget=SaTarget+1;
									//System.out.println("SaTarget ="+SaTarget);
								}
								if(rs6!=null){
									rs6.close();
								}
								if(ps6!=null){
									ps6.close();
								}
								String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query7 ="+query7);
								ps7=conn.prepareStatement(query7);
								ps7.setString(1, rs2.getString(1));
								rs7=ps7.executeQuery();
								while(rs7.next()){
									SaAchieve=SaAchieve+1;
									//System.out.println("SaAchieve ="+SaAchieve);
								}
								if(rs7!=null){
									rs7.close();
								}
								if(ps7!=null){
									ps7.close();
								} 
							}
							if(Nitrate > 0){
								No3AsOn=No3AsOn+1;
								String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query6 ="+query6);
								ps6=conn.prepareStatement(query6);
								ps6.setString(1, rs2.getString(1));
								rs6=ps6.executeQuery();
								while(rs6.next()){
									No3Target=No3Target+1;
									//System.out.println("No3Target ="+No3Target);
								}
								if(rs6!=null){
									rs6.close();
								}
								if(ps6!=null){
									ps6.close();
								}
								String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query7 ="+query7);
								ps7=conn.prepareStatement(query7);
								ps7.setString(1, rs2.getString(1));
								rs7=ps7.executeQuery();
								while(rs7.next()){
									No3Achieve=No3Achieve+1;
									//System.out.println("No3Achieve ="+No3Achieve);
								}
								if(rs7!=null){
									rs7.close();
								}
								if(ps7!=null){
									ps7.close();
								} 
							}
							
						}
						if(rs2!=null){
							rs2.close();
						}
						if(ps2!=null){
							ps2.close();
						}						
				%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=TotalAsOn&Dcode=<%=rs1.getString(1)%>')"> <%=totalHAsOn%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=TotalTarget&Dcode=<%=rs1.getString(1)%>')"> <%=totalHTarget%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=TotalAchieve&Dcode=<%=rs1.getString(1)%>')"> <%=totalHAchieve%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=AsAsOn&Dcode=<%=rs1.getString(1)%>')"> <%=AsAsOn%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=AsTarget&Dcode=<%=rs1.getString(1)%>')"> <%=AsTarget%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=AsAchieve&Dcode=<%=rs1.getString(1)%>')"> <%=AsAchieve%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=FAsOn&Dcode=<%=rs1.getString(1)%>')"> <%=FAsOn%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=FTarget&Dcode=<%=rs1.getString(1)%>')"> <%=FTarget%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=FAchieve&Dcode=<%=rs1.getString(1)%>')"> <%=FAchieve%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=FeAsOn&Dcode=<%=rs1.getString(1)%>')"> <%=FeAsOn%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=FeTarget&Dcode=<%=rs1.getString(1)%>')"> <%=FeTarget%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=FeAchieve&Dcode=<%=rs1.getString(1)%>')"> <%=FeAchieve%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=SaAsOn&Dcode=<%=rs1.getString(1)%>')"> <%=SaAsOn%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=SaTarget&Dcode=<%=rs1.getString(1)%>')"> <%=SaTarget%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=SaAchieve&Dcode=<%=rs1.getString(1)%>')"> <%=SaAchieve%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=No3AsOn&Dcode=<%=rs1.getString(1)%>')"> <%=No3AsOn%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=No3Target&Dcode=<%=rs1.getString(1)%>')"> <%=No3Target%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_contamination_wise_trg_ach_drill.jsp?Drill=No3Achieve&Dcode=<%=rs1.getString(1)%>')"> <%=No3Achieve%> </a></td>
	 			</tr>	
				<% 		
				totalVAsOn=totalVAsOn+totalHAsOn; 
				totalVTarget=totalVTarget+totalHTarget;
				totalVAchieve=totalVAchieve+totalHAchieve;
				totalAsAsOn=totalAsAsOn+AsAsOn;
				totalAsTarget=totalAsTarget+AsTarget;
				totalAsAchieve=totalAsAchieve+AsAchieve;
				totalFAsOn=totalFAsOn+FAsOn;
				totalFTarget=totalFTarget+FTarget;
				totalFAchieve=totalFAchieve+FAchieve;
				totalFeAsOn=totalFeAsOn+totalFeAsOn;
				totalFeTarget=totalFeTarget+FeTarget;
				totalFeAchieve=totalFeAchieve+FeAchieve;
				totalSaAsOn=totalSaAsOn+SaAsOn; 
				totalSaTarget=totalSaTarget+SaTarget;
				totalSaAchieve=totalSaAchieve+SaAchieve;
				totalNo3AsOn=totalNo3AsOn+No3AsOn; 
				totalNo3Target=totalNo3Target+No3Target;
				totalNo3Achieve=totalNo3Achieve+No3Achieve;
					}
				}catch(Exception e){
						e.printStackTrace();
					}finally{
						if(rs1!=null){
							rs1.close();
						}
						if(ps1!=null){
							ps1.close();
						}
						if(conn!=null){
						conn.close();}
					}
				%>
		</tbody>
		<tfoot>
			<tr>
 				<td class="gridhdbg" style="text-align: center;" colspan="2"> Total</td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalVAsOn %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalVTarget %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalVAchieve %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalAsAsOn %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalAsTarget %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalAsAchieve %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalFAsOn %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalFTarget %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalFAchieve %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalFeAsOn %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalFeTarget %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalFeAchieve %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalSaAsOn %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalSaTarget %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalSaAchieve %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalNo3AsOn %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalNo3Target %> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalNo3Achieve %> </td>		
 			</tr>
		</tfoot>
	</table>
</body>
</html>