<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat formatter = new DecimalFormat("##,##,##,###");%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Action Plan for financial year as per Probable Date of Completion</title>	
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
				<th align="center" class="gridhdbg" colspan="35">Action Plan for 2018-19 as per Probable Date of Completion</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
			    <th class="gridhdbg" rowspan="2"> Main Programme </th>
			    <th class="gridhdbg" rowspan="2"> Programme </th>
			    <th class="gridhdbg" rowspan="2"> Sub Programme </th>
			    <th class="gridhdbg" rowspan="2"> Scheme - No. of  Ongoing Works </th>
			    <th class="gridhdbg" colspan="12"> Targets 2018-19 </th>			   
			    <th class="gridhdbg" colspan="12"> Achievements 2018-19 </th>				
			</tr>
			<tr>
				<th class="gridhdbg"> Apr'18 </th>
				<th class="gridhdbg"> May'18 </th>
				<th class="gridhdbg"> Jun'18 </th>
				<th class="gridhdbg"> Jul'18 </th>
				<th class="gridhdbg"> Aug'18 </th>
				<th class="gridhdbg"> Sep'18 </th>
				<th class="gridhdbg"> Oct'18 </th>
				<th class="gridhdbg"> Nov'18 </th>
				<th class="gridhdbg"> Dec'18 </th>
				<th class="gridhdbg"> Jan'19 </th>
				<th class="gridhdbg"> Feb'19 </th>
				<th class="gridhdbg"> Mar'19 </th>
				<th class="gridhdbg"> Apr'18 </th>
				<th class="gridhdbg"> May'18 </th>
				<th class="gridhdbg"> Jun'18 </th>
				<th class="gridhdbg"> Jul'18 </th>
				<th class="gridhdbg"> Aug'18 </th>
				<th class="gridhdbg"> Sep'18 </th>
				<th class="gridhdbg"> Oct'18 </th>
				<th class="gridhdbg"> Nov'18 </th>
				<th class="gridhdbg"> Dec'18 </th>
				<th class="gridhdbg"> Jan'19 </th>
				<th class="gridhdbg"> Feb'19 </th>
				<th class="gridhdbg"> Mar'19 </th>											
			</tr>
			<tr>
				<th class="gridhdbg"> 01 </th>
				<th class="gridhdbg"> 02 </th>
				<th class="gridhdbg"> 03 </th>
				<th class="gridhdbg"> 04 </th>
				<th class="gridhdbg"> 05 </th>
				<th class="gridhdbg"> 06 </th>
				<th class="gridhdbg"> 07 </th>
				<th class="gridhdbg"> 08 </th>
				<th class="gridhdbg"> 09 </th>
				<th class="gridhdbg"> 10 </th>
				<th class="gridhdbg"> 11 </th>
				<th class="gridhdbg"> 12 </th>
				<th class="gridhdbg"> 13 </th>
				<th class="gridhdbg"> 14 </th>
				<th class="gridhdbg"> 15 </th>
				<th class="gridhdbg"> 16 </th>
				<th class="gridhdbg"> 17 </th>
				<th class="gridhdbg"> 18 </th>
				<th class="gridhdbg"> 19 </th>
				<th class="gridhdbg"> 20 </th>
				<th class="gridhdbg"> 21 </th>
				<th class="gridhdbg"> 22 </th>
				<th class="gridhdbg"> 23 </th>
				<th class="gridhdbg"> 24 </th>
				<th class="gridhdbg"> 25 </th>
				<th class="gridhdbg"> 26 </th>
				<th class="gridhdbg"> 27 </th>
				<th class="gridhdbg"> 28 </th>
				<th class="gridhdbg"> 29 </th>											
			</tr>
		</thead>
		<tbody>
			<%	PreparedStatement ps1=null, ps2=null, ps3=null, ps4=null ;
				ResultSet rs1=null, rs2=null, rs3=null, rs4=null;
			    String style="-", Sub_programme="-", schemes = "'01','02','03','10'";
				int styleCount=1;
				int Total_Ongoing_Work=0, TotJan=0, TotFeb=0, TotMar=0, TotApr=0, TotMay=0, TotJun=0, TotJul=0, TotAug=0, TotSep=0, TotOct=0, TotNov=0, TotDec=0, TotAJan=0, TotAFeb=0, TotAMar=0, TotAApr=0, TotAMay=0, TotAJun=0, TotAJul=0, TotAAug=0, TotASep=0, TotAOct=0, TotANov=0, TotADec=0;
				
				try{					
					int count=1;
					String CmDBQuery = "SELECT PROGRAMME_CODE FROM  RWS_PROGRAMME_TBL WHERE CM_CORE_DB='Y' OR NRDWP_RELATED='Y' ORDER BY NRDWP_RELATED";
					PreparedStatement stmtCmDB = conn.prepareStatement(CmDBQuery);
					ResultSet rsCmDB = stmtCmDB.executeQuery();
					Hashtable programmeList=new Hashtable();
					while (rsCmDB.next()) {
						programmeList.put(count,rsCmDB.getString(1));
						count++;
					}								
					String programme = "";									
					for (int i = 1; i <= programmeList.size(); i++){
						programme = (String) programmeList.get(i);
					    String programmename = "", majorProgrammename="";
					       	String programmeQuery = "SELECT PROGRAMME_CODE,PROGRAMME_NAME, NRDWP_RELATED FROM  RWS_PROGRAMME_TBL WHERE PROGRAMME_CODE=?";
					       	PreparedStatement statement1 = conn.prepareStatement(programmeQuery);
					       	statement1.setString(1,programme);
			             	ResultSet resultSet1 = statement1.executeQuery();
			             	if (resultSet1.next()) {			             	
			             		if(resultSet1.getString(3) != null && resultSet1.getString(3).equals("Y")){
			             			majorProgrammename = "NRDWP";
			             			programmename = resultSet1.getString("PROGRAMME_NAME");
			             		}else{
			             			majorProgrammename = resultSet1.getString("PROGRAMME_NAME");
			             			programmename = resultSet1.getString("PROGRAMME_NAME");
			             		}
			             	}
			             	resultSet1.close();
			             	statement1.close();
			             	
			                if (styleCount % 2 == 0) {
						        style = "gridbg1";
							} else {
								style = "gridbg2";
							}										 
				 String query1="SELECT DISTINCT SUBPROGRAMME_CODE, SUBPROGRAMME_NAME FROM  RWS_SUBPROGRAMME_TBL WHERE PROGRAMME_CODE IN ("+programme+") ORDER BY SUBPROGRAMME_NAME";
					//System.out.println("query1 ="+query1);					
					ps1=conn.prepareStatement(query1);
					rs1=ps1.executeQuery();	
					if(!rs1.next()){
						Sub_programme="-";
					}else{ int j=1;
					String programme_name="", Tot_Ongoing_Work="-", major_ProgrammeName="-" ;
						do{
							String query2="SELECT COUNT(DISTINCT A.WORK_ID) AS WORKS FROM RWS_WORK_ADMN_TBL A,RWS_PROGRAMME_TBL P, RWS_SUBPROGRAMME_TBL SP,RWS_SOURCE_IDEN_FIN_TBL I,RWS_WORK_COMMENCEMENT_TBL C ,RWS_CONTRACTOR_SELECTION_TBL M WHERE WORK_CANCEL_DT IS NULL"
									+ " AND SUBSTR(A.WORK_ID,7,2)  IN (" + schemes + ") AND A.PROGRAMME_CODE=P.PROGRAMME_CODE AND A.PROGRAMME_CODE IN (" + programme + ") AND A.SUBPROGRAMME_CODE=SP.SUBPROGRAMME_CODE AND A.SUBPROGRAMME_CODE IN (" + rs1.getString(1)
									+ ")AND A.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-2018' AND (TARGET_DATE_COMP IS NOT NULL OR TARGET_DATE_COMP <> '')"
									+ " AND A.WORK_ID NOT IN(SELECT WORK_ID FROM RWS_WORK_COMPLETION_TBL WHERE DATE_OF_COMPLETION IS NOT NULL AND DATE_OF_COMPLETION<'01-APR-2018') AND I.WORK_ID(+)=A.WORK_ID  AND C.WORK_ID(+)=A.WORK_ID AND M.WORK_ID(+)=A.WORK_ID";
							//System.out.println("query3 ="+query3);					
							ps2=conn.prepareStatement(query2);
							rs2=ps2.executeQuery();	
							if(!rs2.next()){
								Tot_Ongoing_Work="-";
							}
							else{
								do{								
									Tot_Ongoing_Work=rs2.getString(1);
								}while(rs2.next());
							}					
							if(rs2!=null){
								rs2.close();
							}
							if(ps2!=null){
								ps2.close();
							}
						int Tar=0, Jan=0, Feb=0, Mar=0, Apr=0, May=0, Jun=0, Jul=0, Aug=0, Sep=0, Oct=0, Nov=0, Dec=0;
						String query_target = "SELECT TO_CHAR(A.TARGET_DATE_COMP,'MM') AS MONTH, COUNT(DISTINCT A.WORK_ID) AS WORKS FROM RWS_WORK_ADMN_TBL A,RWS_PROGRAMME_TBL P, RWS_SUBPROGRAMME_TBL SP,RWS_SOURCE_IDEN_FIN_TBL I,"
								    + " RWS_WORK_COMMENCEMENT_TBL C ,RWS_CONTRACTOR_SELECTION_TBL M WHERE WORK_CANCEL_DT IS NULL AND SUBSTR(A.WORK_ID,7,2)  IN (" + schemes + ") AND A.PROGRAMME_CODE=P.PROGRAMME_CODE AND A.PROGRAMME_CODE IN ("
									+ programme	+ ") AND A.SUBPROGRAMME_CODE=SP.SUBPROGRAMME_CODE AND A.SUBPROGRAMME_CODE IN ("	+ rs1.getString(1) + ") AND A.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-2018'  AND"
									+ " ( TARGET_DATE_COMP IS NOT NULL OR TARGET_DATE_COMP <> '') AND A.WORK_ID NOT IN(SELECT WORK_ID FROM RWS_WORK_COMPLETION_TBL WHERE DATE_OF_COMPLETION IS NOT NULL AND DATE_OF_COMPLETION<'01-APR-2019')"
									+ " AND I.WORK_ID(+)=A.WORK_ID  AND C.WORK_ID(+)=A.WORK_ID AND M.WORK_ID(+)=A.WORK_ID AND TARGET_DATE_COMP < TO_DATE('01/04/2019','DD/MM/YYYY') GROUP BY TO_CHAR(TARGET_DATE_COMP,'MM') ";
							//System.out.println("Target query"+query_target);	
							ps3 = conn.prepareStatement(query_target);
							rs3 = ps3.executeQuery();
							while(rs3.next())
							{
							  Tar+=Integer.parseInt(rs3.getString(1));
							  if(rs3.getString(1) != null && rs3.getString(1).equals("01")){
								  Jan += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("02")){
								  Feb += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("03")){
								  Mar += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("04")){
								  Apr += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("05")){
								  May += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("06")){
								  Jun += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("07")){
								  Jul += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("08")){
								  Aug += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("09")){
								  Sep += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("10")){
								  Oct += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("11")){
								  Nov += Integer.parseInt(rs3.getString(2));
							  }
							  if(rs3.getString(1) != null && rs3.getString(1).equals("12")){
								  Dec += Integer.parseInt(rs3.getString(2));
							  }
						   	}
							rs3.close();
							ps3.close();
							
							int Ach=0, AJan=0, AFeb=0, AMar=0, AApr=0, AMay=0, AJun=0, AJul=0, AAug=0, ASep=0, AOct=0, ANov=0, ADec=0;
							String query_achv = "SELECT TO_CHAR(COM.DATE_OF_COMPLETION,'MM') AS MONTH, COUNT(DISTINCT A.WORK_ID) FROM  RWS_WORK_COMP_HAB_LNK_TBL H,RWS_HABITATION_DIRECTORY_TBL HD,RWS_WORK_ADMN_TBL A,RWS_PROGRAMME_TBL P, RWS_SUBPROGRAMME_TBL SP,RWS_SOURCE_IDEN_FIN_TBL I,"
									+ " RWS_WORK_COMMENCEMENT_TBL C ,RWS_CONTRACTOR_SELECTION_TBL M, RWS_WORK_COMPLETION_TBL COM WHERE A.WORK_ID=COM.WORK_ID AND WORK_CANCEL_DT IS NULL AND SUBSTR(A.WORK_ID,7,2) IN (" + schemes + ") AND H.WORK_ID=A.WORK_ID AND HD.HAB_CODE=H.HAB_CODE"
									+ " AND A.PROGRAMME_CODE=P.PROGRAMME_CODE AND A.PROGRAMME_CODE IN (" + programme + ") AND A.SUBPROGRAMME_CODE=SP.SUBPROGRAMME_CODE AND A.SUBPROGRAMME_CODE IN (" + rs1.getString(1) + ") AND A.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP >='01-APR-2018'"
									+ " AND ( TARGET_DATE_COMP IS NOT NULL OR TARGET_DATE_COMP <> '') AND (com.DATE_OF_COMPLETION >= TO_DATE('01/04/2018','DD/MM/YYYY') AND com.DATE_OF_COMPLETION IS NOT NULL AND com.DATE_OF_COMPLETION <= TARGET_DATE_COMP) AND I.WORK_ID(+)=A.WORK_ID"
									+ " AND C.WORK_ID(+)=A.WORK_ID AND M.WORK_ID(+)=A.WORK_ID GROUP BY TO_CHAR(COM.DATE_OF_COMPLETION,'MM')";
								System.out.println("Achievement query"+query_achv);	
								ps4 = conn.prepareStatement(query_achv);
								rs4 = ps4.executeQuery();
								while(rs4.next())
								{
								  Ach+=Integer.parseInt(rs4.getString(2));
								  //System.out.println(programme_name+" "+rs4.getString(1)+" "+rs4.getString(2));
								  if(rs4.getString(1) != null && rs4.getString(1).equals("01")){
									  AJan += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("02")){
									  AFeb += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("03")){
									  AMar += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("04")){
									  AApr += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("05")){
									  AMay += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("06")){
									  AJun += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("07")){
									  AJul += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("08")){
									  AAug += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("09")){
									  ASep += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("10")){
									  AOct += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("11")){
									  ANov += Integer.parseInt(rs4.getString(2));
								  }
								  if(rs4.getString(1) != null && rs4.getString(1).equals("12")){
									  ADec += Integer.parseInt(rs4.getString(2));
								  }							  
							   	}
								rs4.close();
								ps4.close();
								
						if((Tot_Ongoing_Work != null && !Tot_Ongoing_Work.equals("0")) || (Tar != 0) || (Ach != 0)){	
							if(j==1){
								major_ProgrammeName=majorProgrammename;
								programme_name=programmename;
								j++;
							}else{
								major_ProgrammeName="";
								programme_name="";
							}						
							Sub_programme=rs1.getString(2);
							
				%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=major_ProgrammeName%>  </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=programme_name%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=Sub_programme%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>')"><%=Tot_Ongoing_Work%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=04')"><%=Apr%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=05')"><%=May%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=06')"><%=Jun%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=07')"><%=Jul%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=08')"><%=Aug%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=09')"><%=Sep%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=10')"><%=Oct%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=11')"><%=Nov%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=12')"><%=Dec%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=01')"><%=Jan%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=02')"><%=Feb%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=03')"><%=Mar%></a> </td>	 				
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=04')"><%=AApr%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=05')"><%=AMay%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=06')"><%=AJun%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=07')"><%=AJul%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=08')"><%=AAug%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=09')"><%=ASep%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=10')"><%=AOct%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=11')"><%=ANov%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=12')"><%=ADec%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=01')"><%=AJan%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=02')"><%=AFeb%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programme_name%>&subprogramme=<%=rs1.getString(1)%>&subprogrammeName=<%=Sub_programme%>&monthCode=03')"><%=AMar%></a> </td>				
	 			</tr>	
				<% 	         styleCount++;
							 Total_Ongoing_Work+=Integer.parseInt(Tot_Ongoing_Work); 
							 TotJan+=Jan; 
							 TotFeb+=Feb; 
							 TotMar+=Mar; 
							 TotApr+=Apr; 
							 TotMay+=May; 
							 TotJun+=Jun; 
							 TotJul+=Jul; 
							 TotAug+=Aug; 
							 TotSep+=Sep; 
							 TotOct+=Oct; 
							 TotNov+=Nov; 
							 TotDec+=Dec; 
							 TotAJan+=AJan; 
							 TotAFeb+=AFeb; 
							 TotAMar+=AMar; 
							 TotAApr+=AApr; 
							 TotAMay+=AMay; 
							 TotAJun+=AJun; 
							 TotAJul+=AJul; 
							 TotAAug+=AAug; 
							 TotASep+=ASep; 
							 TotAOct+=AOct; 
							 TotANov+=ANov; 
							 TotADec+=ADec;	
				          }	
					    }while(rs1.next());
					  }
					}
				}catch(Exception e){
						e.printStackTrace();
					}finally{						
						if(conn!=null){
						conn.close();}
					}
				%>
		</tbody>
		<tfoot>
			<tr>
 				<td class="gridhdbg" style="text-align: right;" colspan="4"> Total </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=Total_Ongoing_Work%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotApr%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotMay%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotJun%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotJul%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAug%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotSep%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotOct%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotNov%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotDec%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotJan%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotFeb%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotMar%> </td>	 				
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAApr%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAMay%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAJun%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAJul%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAAug%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotASep%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAOct%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotANov%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotADec%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAJan%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAFeb%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=TotAMar%> </td>				
 			</tr>	
		</tfoot>		
	</table>
</body>
</html>