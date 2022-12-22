<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@page import="nic.watersoft.works.WorksData1"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat formatter = new DecimalFormat("##,##,##,###");
String  cirCode = request.getParameter("CirCode");
String  cirName = request.getParameter("CirName");
String divCode = request.getParameter("DivCode");
String divName = request.getParameter("DivName");
String mode = "";
if (request.getParameter("mode") != null){
	mode = request.getParameter("mode");
}
//System.out.println("mode"+mode);
String  majorProgrammeName=request.getParameter("MajorProgrammeName");
String programme = request.getParameter("Programme");
String programmeName=request.getParameter("ProgrammeName");
String subProgramme = request.getParameter("SubProgramme");
String subProgrammeName=request.getParameter("SubProgrammeName");
String schemeCode=request.getParameter("SchemeCode");
String schemeName=request.getParameter("SchemeName");
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
int ys = 0;
int ye = 0;
if (month <= 3) {
	ys = cyear - 1;
    ye = cyear;
} else {
	ys = cyear;
    ye = cyear + 1;
} 
%>
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
				<th align="center" class="gridhdbg" colspan="35">Action Plan for <%=ys %>-<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %> as per Probable Date of Completion
					</br><font face="Maiandra GD" size="3px"  >Main Programme :- <%=majorProgrammeName %> <%if(programmeName != null && !programmeName.equals("null")){ %> Programme :- <%=programmeName %><% } if(subProgrammeName != null  && !subProgrammeName.equals("null")){ %> Sub Programme :- <%=subProgrammeName %><%} %>
					</br><b><%if(mode.equals("divisions")){ %>
					  Circle: <%=cirName %>
					<%}else if(mode.equals("subdivisions")){  %>
					, Circle: <%=cirName %>
					 , Division: <%=divName %>
					<%} %></b></font><br/>
				</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
				<%if(mode.equals("circles")){ %>
				<td class="gridhdbg"  rowspan="2">Circle</td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="gridhdbg"  rowspan="2">Division</td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="gridhdbg" rowspan="2">Sub Division</td>
				<%} %>
			    <th class="gridhdbg" rowspan="2"> No. of  Ongoing Works </th>
			    <th class="gridhdbg" colspan="12"> Targets <%=ys %>-<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %> </th>			   
			    <th class="gridhdbg" colspan="12"> Achievements <%=ys %>-<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %> </th>				
			</tr>
			<tr>
				<th class="gridhdbg"> Apr'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %>  </th>
				<th class="gridhdbg"> May'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Jun'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Jul'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Aug'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Sep'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Oct'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Nov'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Dec'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Jan'<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %>  </th>
				<th class="gridhdbg"> Feb'<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %>  </th>
				<th class="gridhdbg"> Mar'<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %>  </th>
				<th class="gridhdbg"> Apr'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> May'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Jun'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Jul'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Aug'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Sep'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Oct'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Nov'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Dec'<%=Integer.toString(ys).substring(Integer.toString(ys).length() - 2) %> </th>
				<th class="gridhdbg"> Jan'<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %>  </th>
				<th class="gridhdbg"> Feb'<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %>  </th>
				<th class="gridhdbg"> Mar'<%=Integer.toString(ye).substring(Integer.toString(ye).length() - 2) %>  </th>											
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
			</tr>
		</thead>
		<tbody>
			<%	PreparedStatement ps1=null, ps2=null, ps3=null, ps4=null ;
				ResultSet rs1=null, rs2=null, rs3=null, rs4=null;
			    String style="-", Tot_Ongoing_Work="", c_query="", subDivCode="", subDivName="" ;
			    int styleCount=1;
				int Total_Ongoing_Work=0, TotJan=0, TotFeb=0, TotMar=0, TotApr=0, TotMay=0, TotJun=0, TotJul=0, TotAug=0, TotSep=0, TotOct=0, TotNov=0, TotDec=0, TotAJan=0, TotAFeb=0, TotAMar=0, TotAApr=0, TotAMay=0, TotAJun=0, TotAJul=0, TotAAug=0, TotASep=0, TotAOct=0, TotANov=0, TotADec=0;
				
				try{					
					 	if(mode.equals("circles")){
				 			c_query="SELECT CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL  ORDER BY CIRCLE_OFFICE_CODE";
			            }
			            else if(mode.equals("divisions")){
			            	c_query="SELECT DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE  CIRCLE_OFFICE_CODE='"+cirCode+"' AND STATUS <> 'UI' ORDER BY DIVISION_OFFICE_CODE";
			            }
			            else if(mode.equals("subdivisions")){
			            	 c_query="SELECT SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE  CIRCLE_OFFICE_CODE='"+cirCode+"' AND DIVISION_OFFICE_CODE='"+divCode+"' ORDER BY SUBDIVISION_OFFICE_CODE";
			            }
			         //System.out.println("query"+c_query);
			          PreparedStatement preparedStatement = conn.prepareStatement(c_query);
			          ResultSet res = preparedStatement.executeQuery();
			          while(res.next()){
			        	   if(mode.equals("circles")){
			                  cirName=res.getString("circle_office_name");
			              	  cirCode=res.getString("circle_office_code");
			              }
			              if(mode.equals("divisions")){
							divCode=res.getString("division_office_code");
							divName=res.getString("division_office_name");
						  }
						if(mode.equals("subdivisions")){
							subDivCode=res.getString("subdivision_office_code");
							subDivName=res.getString("subdivision_office_name");
						}					
		                if (styleCount % 2 == 0) {
					        style = "gridbg1";
						} else {
							style = "gridbg2";
						}										 
				
					String query2="SELECT COUNT(DISTINCT A.WORK_ID) AS WORKS FROM RWS_WORK_ADMN_TBL A,RWS_PROGRAMME_TBL P, RWS_SUBPROGRAMME_TBL SP,RWS_SOURCE_IDEN_FIN_TBL I,RWS_WORK_COMMENCEMENT_TBL C ,RWS_CONTRACTOR_SELECTION_TBL M WHERE WORK_CANCEL_DT IS NULL"
							+ "  AND A.PROGRAMME_CODE=P.PROGRAMME_CODE AND A.SUBPROGRAMME_CODE=SP.SUBPROGRAMME_CODE AND A.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+ys+"' AND (TARGET_DATE_COMP IS NOT NULL OR TARGET_DATE_COMP <> '')"
							+ " AND A.WORK_ID NOT IN(SELECT WORK_ID FROM RWS_WORK_COMPLETION_TBL WHERE DATE_OF_COMPLETION IS NOT NULL AND DATE_OF_COMPLETION<'01-APR-"+ys+"') AND I.WORK_ID(+)=A.WORK_ID  AND C.WORK_ID(+)=A.WORK_ID AND M.WORK_ID(+)=A.WORK_ID";
							if(schemeCode != null && !schemeCode.equals("null")){ 
								query2  += " AND SUBSTR(A.WORK_ID,7,2) IN (" + schemeCode + ") ";
							}
							if(programme != null && !programme.equals("null")){ 
								query2  += " AND A.PROGRAMME_CODE IN (" + programme + ") ";
							}
							if(subProgramme != null && !subProgramme.equals("null")){ 
								query2  += " AND A.SUBPROGRAMME_CODE IN (" + subProgramme +") ";
							}									
							if(mode.equals("circles")){ 
								query2  += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+res.getString("circle_office_code")+"'";
							}
							else if(mode.equals("divisions")){
								query2 += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+cirCode+"' AND SUBSTR(A.OFFICE_CODE,4,1)='"+res.getString("division_office_code")+"'";
							}
							else if(mode.equals("subdivisions")){
								query2 += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+cirCode+"' AND SUBSTR(A.OFFICE_CODE,4,1)='"+divCode+"' AND SUBSTR(A.OFFICE_CODE,5,2)='"+res.getString("subdivision_office_code")+"'";
							}
				   // System.out.println("query2 ="+query2);					
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
						    + " RWS_WORK_COMMENCEMENT_TBL C ,RWS_CONTRACTOR_SELECTION_TBL M WHERE WORK_CANCEL_DT IS NULL AND A.PROGRAMME_CODE=P.PROGRAMME_CODE AND A.SUBPROGRAMME_CODE=SP.SUBPROGRAMME_CODE AND A.CORE_DASHBOARD_STATUS='Y'"
						    + " AND TARGET_DATE_COMP>='01-APR-"+ys+"'  AND ( TARGET_DATE_COMP IS NOT NULL OR TARGET_DATE_COMP <> '') AND A.WORK_ID NOT IN(SELECT WORK_ID FROM RWS_WORK_COMPLETION_TBL WHERE DATE_OF_COMPLETION IS NOT NULL AND DATE_OF_COMPLETION<'01-APR-"+ye+"')"
							+ " AND I.WORK_ID(+)=A.WORK_ID  AND C.WORK_ID(+)=A.WORK_ID AND M.WORK_ID(+)=A.WORK_ID AND TARGET_DATE_COMP < TO_DATE('01/04/"+ye+"','DD/MM/YYYY')";
							if(schemeCode != null  && !schemeCode.equals("null")){ 
								query_target += " AND SUBSTR(A.WORK_ID,7,2) IN (" + schemeCode + ") ";
							}
							if(programme != null && !programme.equals("null")){ 
								query_target += " AND A.PROGRAMME_CODE IN (" + programme + ") ";
							}
							if(subProgramme != null && !subProgramme.equals("null")){ 
								query_target += " AND A.SUBPROGRAMME_CODE IN (" + subProgramme +") ";
							}
							if(mode.equals("circles")){ 
								query_target += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+res.getString("circle_office_code")+"'";
							}
							else if(mode.equals("divisions")){
								query_target += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+cirCode+"' AND SUBSTR(A.OFFICE_CODE,4,1)='"+res.getString("division_office_code")+"'";
							}
							else if(mode.equals("subdivisions")){
								query_target += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+cirCode+"' AND SUBSTR(A.OFFICE_CODE,4,1)='"+divCode+"' AND SUBSTR(A.OFFICE_CODE,5,2)='"+res.getString("subdivision_office_code")+"'";
							}
							query_target += " GROUP BY TO_CHAR(TARGET_DATE_COMP,'MM')"; 
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
					String query_achv = "SELECT TO_CHAR(COM.DATE_OF_COMPLETION,'MM') AS MONTH, COUNT(DISTINCT A.WORK_ID) FROM  RWS_WORK_COMP_HAB_LNK_TBL H,RWS_HABITATION_DIRECTORY_TBL HD,RWS_WORK_ADMN_TBL A,RWS_PROGRAMME_TBL P, RWS_SUBPROGRAMME_TBL SP,RWS_SOURCE_IDEN_FIN_TBL I, RWS_WORK_COMMENCEMENT_TBL C ,RWS_CONTRACTOR_SELECTION_TBL M, RWS_WORK_COMPLETION_TBL COM"
							+ " WHERE A.WORK_ID=COM.WORK_ID AND WORK_CANCEL_DT IS NULL AND H.WORK_ID=A.WORK_ID AND HD.HAB_CODE=H.HAB_CODE AND A.PROGRAMME_CODE=P.PROGRAMME_CODE AND A.SUBPROGRAMME_CODE=SP.SUBPROGRAMME_CODE AND A.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP >='01-APR-"+ys+"' AND ( TARGET_DATE_COMP IS NOT NULL OR TARGET_DATE_COMP <> '') "
							+ " AND (com.DATE_OF_COMPLETION >= TO_DATE('01/04/"+ys+"','DD/MM/YYYY') AND com.DATE_OF_COMPLETION IS NOT NULL AND com.DATE_OF_COMPLETION <= TARGET_DATE_COMP) AND I.WORK_ID(+)=A.WORK_ID AND C.WORK_ID(+)=A.WORK_ID AND M.WORK_ID(+)=A.WORK_ID ";
							if(schemeCode != null  && !schemeCode.equals("null")){ 
								query_achv += " AND SUBSTR(A.WORK_ID,7,2) IN (" + schemeCode + ") ";
							}
							if(programme != null && !programme.equals("null")){ 
								query_achv += " AND A.PROGRAMME_CODE IN (" + programme + ") ";
							}
							if(subProgramme != null && !subProgramme.equals("null")){ 
								query_achv += " AND A.SUBPROGRAMME_CODE IN (" + subProgramme +") ";
							}	
							if(mode.equals("circles")){ 
								query_achv += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+res.getString("circle_office_code")+"'";
							}
							else if(mode.equals("divisions")){
								query_achv += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+cirCode+"' AND SUBSTR(A.OFFICE_CODE,4,1)='"+res.getString("division_office_code")+"'";
							}
							else if(mode.equals("subdivisions")){
								query_achv += " AND SUBSTR(A.OFFICE_CODE,2,2)='"+cirCode+"' AND SUBSTR(A.OFFICE_CODE,4,1)='"+divCode+"' AND SUBSTR(A.OFFICE_CODE,5,2)='"+res.getString("subdivision_office_code")+"'";
							}
							query_achv += " GROUP BY TO_CHAR(COM.DATE_OF_COMPLETION,'MM')";
						//System.out.println("Achievement query"+query_achv);	
						ps4 = conn.prepareStatement(query_achv);
						rs4 = ps4.executeQuery();
						while(rs4.next())
						{
						  Ach+=Integer.parseInt(rs4.getString(2));
						  //System.out.println(programmeName+" "+rs4.getString(1)+" "+rs4.getString(2));
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
						if(Tot_Ongoing_Work != null && !Tot_Ongoing_Work.equals("0")) {
				%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
	 				<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" ><a href="rws_action_plan_as_per_prodate_drill.jsp?mode=divisions&Programme=<%=programme%>&MajorProgrammeName=<%=majorProgrammeName%>&ProgrammeName=<%=programmeName%>&SubProgramme=<%=subProgramme%>&SubProgrammeName=<%=subProgrammeName%>&SchemeCode=<%=schemeCode %>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>"><%=cirName %></a></td>
					<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=ongoing&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Tot_Ongoing_Work%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=04&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Apr%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=05&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=May%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=06&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Jun%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=07&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Jul%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=08&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Aug%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=09&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Sep%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=10&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Oct%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=11&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Nov%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=12&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Dec%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=01&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Jan%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=02&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Feb%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=03&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=Mar%></a> </td>	 				
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=04&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AApr%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=05&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AMay%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=06&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AJun%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=07&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AJul%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=08&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AAug%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=09&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=ASep%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=10&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AOct%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=11&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=ANov%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=12&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=ADec%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=01&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AJan%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=02&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AFeb%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=03&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>')"><%=AMar%></a> </td>				
	 				<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" ><a href="rws_action_plan_as_per_prodate_drill.jsp?mode=subdivisions&Programme=<%=programme%>&MajorProgrammeName=<%=majorProgrammeName%>&ProgrammeName=<%=programmeName%>&SubProgramme=<%=subProgramme%>&SubProgrammeName=<%=subProgrammeName%>&SchemeCode=<%=schemeCode %>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>"><%=divName %></a></td>
					<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=ongoing&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Tot_Ongoing_Work%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=04&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Apr%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=05&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=May%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=06&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Jun%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=07&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Jul%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=08&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Aug%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=09&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Sep%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=10&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Oct%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=11&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Nov%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=12&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Dec%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=01&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Jan%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=02&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Feb%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=03&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=Mar%></a> </td>	 				
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=04&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AApr%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=05&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AMay%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=06&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AJun%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=07&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AJul%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=08&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AAug%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=09&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=ASep%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=10&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AOct%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=11&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=ANov%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=12&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=ADec%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=01&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AJan%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=02&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AFeb%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=03&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>')"><%=AMar%></a> </td>				
	 			
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>"><%=subDivName %></td>
					<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=ongoing&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Tot_Ongoing_Work%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=04&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Apr%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=05&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=May%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=06&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Jun%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=07&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Jul%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=08&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Aug%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=09&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Sep%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=10&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Oct%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=11&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Nov%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=12&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Dec%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=01&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Jan%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=02&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Feb%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=target&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=03&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=Mar%></a> </td>	 				
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=04&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AApr%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=05&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AMay%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=06&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AJun%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=07&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AJul%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=08&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AAug%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=09&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=ASep%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=10&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AOct%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=11&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=ANov%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=12&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=ADec%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=01&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AJan%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=02&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AFeb%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_action_plan_as_per_prodate_work_drill.jsp?mode=achieve&MajorProgrammeName=<%=majorProgrammeName%>&programme=<%=programme%>&programmeName=<%=programmeName%>&subprogramme=<%=subProgramme%>&subprogrammeName=<%=subProgrammeName%>&monthCode=03&Schemes=<%=schemeCode%>&SchemeName=<%=schemeName %>&CirCode=<%=cirCode %>&CirName=<%=cirName %>&DivCode=<%=divCode %>&DivName=<%=divName %>&SubDivCode=<%=subDivCode %>&SubDivName=<%=subDivName %>')"><%=AMar%></a> </td>				
	 				<%} %>	 								
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
				<td class="gridhdbg" style="text-align: right;" colspan="2"> Total </td>
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