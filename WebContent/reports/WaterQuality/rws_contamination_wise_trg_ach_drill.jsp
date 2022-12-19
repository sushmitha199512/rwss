<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat formatter = new DecimalFormat("##,##,##,###");
	String  Dcode= request.getParameter("Dcode");
	String  Drill= request.getParameter("Drill");
	//System.out.println(Drill +"  " + Dcode);
	String Finyear="2018-2018" ;
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
				<th class="gridhdbg" > S.No. </th>
			    <th class="gridhdbg" > District Name</th>
			    <th class="gridhdbg" > Mandal Name</th>
			    <th class="gridhdbg" > Panchyat Name </th>
			    <th class="gridhdbg" > Village Name</th>
			    <th class="gridhdbg" > Habitation Code</th>
			    <th class="gridhdbg" > Habitation Name </th>			   
			    <th class="gridhdbg" > Total Population </th>
			    <th class="gridhdbg" > Coverage Status </th>		
			</tr>			
		</thead>
		<tbody>
			<%	PreparedStatement ps1=null, ps2=null, ps3=null, ps4=null, ps5=null, ps6=null, ps7=null, ps8=null;
				ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null, rs7=null, rs8=null;
				String style=null;
				int   styleCount=1;
				try{									
					String query1="SELECT DISTINCT DNAME, MNAME, PNAME, VNAME, PANCH_CODE, PANCH_NAME, SUM(CENSUS_PLAIN_POPU+ CENSUS_SC_POPU + CENSUS_ST_POPU), COVERAGE_STATUS FROM RWS_COMPLETE_HAB_DYNA_VIEW WHERE DCODE=? AND COVERAGE_STATUS='NSS' GROUP BY DNAME, MNAME, PNAME, VNAME, PANCH_CODE, PANCH_NAME, COVERAGE_STATUS ORDER BY MNAME, PNAME, VNAME, PANCH_NAME";
					//System.out.println("query1 ="+query1);					
					ps1=conn.prepareStatement(query1);
					ps1.setString(1, Dcode);
					rs1=ps1.executeQuery();
					while(rs1.next()){
						if(styleCount%2==0){
							 style="gridbg1";
						 }else{
							 style="gridbg2";
						 }
						int Total=0, Arsenic=0, Fluoride=0, Iron=0, Salinity=0, Nitrate=0, Heavy_Metal=0;
						String query3="SELECT SOURCE_CODE, TO_CHAR(MAX(PREPARED_ON),'DD-MM-YYYY') FROM RWS_WQ_TEST_RESULTS_TBL A,RWS_WQ_TEST_RESULTS_LNK_TBL B WHERE A.TEST_ID=B.TEST_ID AND TEST_CODE='1' AND SUBSTR(SOURCE_CODE,1,16)=? AND PREPARED_ON < TO_DATE('01-04-2018','DD-MM-YYYY') GROUP BY SOURCE_CODE ORDER BY MAX(PREPARED_ON) DESC";
						//System.out.println("query3 ="+query3);					
						ps3=conn.prepareStatement(query3);
						ps3.setString(1, rs1.getString(5));
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
							if(Drill != null && Drill.equals("TotalAsOn")){
				%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
				<%
							}
							if(Drill != null && Drill.equals("TotalTarget")){
								String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query6 ="+query6);
								ps6=conn.prepareStatement(query6);
								ps6.setString(1, rs1.getString(5));
								rs6=ps6.executeQuery();
								while(rs6.next()){
									%>
									<tr>
										<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
					 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
						 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
						 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
						 			</tr>
									<%	
								}
								if(rs6!=null){
									rs6.close();
								}
								if(ps6!=null){
									ps6.close();
								}
							}
							if(Drill != null && Drill.equals("TotalAchieve")){
								String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
								//System.out.println("query7 ="+query7);
								ps7=conn.prepareStatement(query7);
								ps7.setString(1, rs1.getString(5));
								rs7=ps7.executeQuery();
								while(rs7.next()){
									%>
									<tr>
										<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
					 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
						 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
						 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
						 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
						 			</tr>
									<%
								}
								if(rs7!=null){
									rs7.close();
								}
								if(ps7!=null){
									ps7.close();
								} 
						  }
					 }
					 if(Arsenic > 0){
						if(Drill != null && Drill.equals("AsAsOn")){
				%>
							<tr>
								<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
			 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
				 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
				 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
				 			</tr>
				<%
						}
						if(Drill != null && Drill.equals("AsTarget")){
							String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query6 ="+query6);
							ps6=conn.prepareStatement(query6);
							ps6.setString(1, rs1.getString(5));
							rs6=ps6.executeQuery();
							while(rs6.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs6!=null){
								rs6.close();
							}
							if(ps6!=null){
								ps6.close();
							}
						}
						if(Drill != null && Drill.equals("AsAchieve")){										
							String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query7 ="+query7);
							ps7=conn.prepareStatement(query7);
							ps7.setString(1, rs1.getString(5));
							rs7=ps7.executeQuery();
							while(rs7.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs7!=null){
								rs7.close();
							}
							if(ps7!=null){
								ps7.close();
							} 	
					  	}
					 }
					 if(Fluoride > 0){
						if(Drill != null && Drill.equals("FAsOn")){
				%>
							<tr>
								<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
			 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
				 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
				 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
				 			</tr>
				<%
						}
						if(Drill != null && Drill.equals("FTarget")){
							String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query6 ="+query6);
							ps6=conn.prepareStatement(query6);
							ps6.setString(1, rs1.getString(5));
							rs6=ps6.executeQuery();
							while(rs6.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs6!=null){
								rs6.close();
							}
							if(ps6!=null){
								ps6.close();
							}
						}
						if(Drill != null && Drill.equals("FAchieve")){
							String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query7 ="+query7);
							ps7=conn.prepareStatement(query7);
							ps7.setString(1, rs1.getString(5));
							rs7=ps7.executeQuery();
							while(rs7.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs7!=null){
								rs7.close();
							}
							if(ps7!=null){
								ps7.close();
							} 
						}
					 }
					if(Iron > 0){
						if(Drill != null && Drill.equals("FeAsOn")){
				%>
							<tr>
								<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
			 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
				 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
				 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
				 			</tr>
				<%
						}
						if(Drill != null && Drill.equals("FeTarget")){							
							String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query6 ="+query6);
							ps6=conn.prepareStatement(query6);
							ps6.setString(1, rs1.getString(5));
							rs6=ps6.executeQuery();
							while(rs6.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs6!=null){
								rs6.close();
							}
							if(ps6!=null){
								ps6.close();
							}
						}
						if(Drill != null && Drill.equals("FeAchieve")){
							String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query7 ="+query7);
							ps7=conn.prepareStatement(query7);
							ps7.setString(1, rs1.getString(5));
							rs7=ps7.executeQuery();
							while(rs7.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs7!=null){
								rs7.close();
							}
							if(ps7!=null){
								ps7.close();
							} 
						 }
					 }
					 if(Salinity > 0){
						if(Drill != null && Drill.equals("SaAsOn")){
				%>
							<tr>
								<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
			 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
				 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
				 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
				 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
				 			</tr>
				<%
						}
						if(Drill != null && Drill.equals("SaTarget")){
							String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query6 ="+query6);
							ps6=conn.prepareStatement(query6);
							ps6.setString(1, rs1.getString(5));
							rs6=ps6.executeQuery();
							while(rs6.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs6!=null){
								rs6.close();
							}
							if(ps6!=null){
								ps6.close();
							}
						}
						if(Drill != null && Drill.equals("SaAchieve")){
							String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query7 ="+query7);
							ps7=conn.prepareStatement(query7);
							ps7.setString(1, rs1.getString(5));
							rs7=ps7.executeQuery();
							while(rs7.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs7!=null){
								rs7.close();
							}
							if(ps7!=null){
								ps7.close();
							}
					  }
				  }
				  if(Nitrate > 0){
					  if(Drill != null && Drill.equals("No3AsOn")){
				%>
						<tr>
							<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
			 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
			 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
			 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
			 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
		 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
			 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
			 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
			 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
			 			</tr>
				<%
					  }
					  if(Drill != null && Drill.equals("No3Target")){
							String query6="SELECT B.HAB_CODE FROM RWS_WORK_ADMN_TBL A, RWS_ADMN_HAB_LNK_TBL B WHERE A.WORK_ID=B.WORK_ID AND (A.TARGET_DATE_COMP BETWEEN '01-APR-1700' AND '31-MAR-2018') AND (A.TARGET_DATE_COMP IS NOT NULL OR A.TARGET_DATE_COMP <> '') AND WORK_CANCEL_DT IS NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query6 ="+query6);
							ps6=conn.prepareStatement(query6);
							ps6.setString(1, rs1.getString(5));
							rs6=ps6.executeQuery();
							while(rs6.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%
							}
							if(rs6!=null){
								rs6.close();
							}
							if(ps6!=null){
								ps6.close();
							}
						}
						if(Drill != null && Drill.equals("No3Achieve")){
							String query7="SELECT DISTINCT B.HAB_CODE FROM RWS_WORK_COMPLETION_TBL A, RWS_WORK_COMP_HAB_LNK_TBL B , RWS_WORK_ADMN_TBL C WHERE A.WORK_ID=B.WORK_ID AND A.WORK_ID=C.WORK_ID AND B.WORK_ID=C.WORK_ID AND (A.DATE_OF_COMPLETION  BETWEEN '01-APR-1700' AND '31-MAR-2018') AND C.TARGET_DATE_COMP < TO_DATE('01-04-2018','DD-MM-YYYY') AND C.WORK_CANCEL_DT IS NULL AND A.DATE_OF_COMPLETION IS NOT NULL AND B.HAB_CODE=? GROUP BY B.HAB_CODE";
							//System.out.println("query7 ="+query7);
							ps7=conn.prepareStatement(query7);
							ps7.setString(1, rs1.getString(5));
							rs7=ps7.executeQuery();
							while(rs7.next()){
								%>
								<tr>
									<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(4)%> </td>
				 					<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
					 				<td class="<%=style%>" style="text-align: left;"> <%=rs1.getString(6)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
					 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
					 			</tr>
								<%									
							}
							if(rs7!=null){
								rs7.close();
							}
							if(ps7!=null){
								ps7.close();
							} 
						}
					}				 			
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
	</table>
</body>
</html>