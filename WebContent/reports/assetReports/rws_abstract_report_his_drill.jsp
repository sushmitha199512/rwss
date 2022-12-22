<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page import="java.text.DecimalFormat.*, java.util.Date,  java.util.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat ndf = new DecimalFormat("####.##");
    String SchemeType = request.getParameter("typeOfAsset"); 
    String Dcode = request.getParameter("dCode");
    String Dname = request.getParameter("dName");
    String Mcode = request.getParameter("mCode");
    String Mname = request.getParameter("mName");
    String Pcode = request.getParameter("pCode");
    String Pname = request.getParameter("pName");
    String Vcode = request.getParameter("vCode");
    String Vname = request.getParameter("vName");
    String Mode = request.getParameter("mode");    
    SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");
    Calendar c = Calendar.getInstance(); 
    c.setTime(new Date()); 
    Date d = c.getTime();
    
    c.add(Calendar.MONTH, -1);
    Date d1 = c.getTime();

	c.add(Calendar.MONTH, -1);
    Date d2 = c.getTime();
    
    c.add(Calendar.MONTH, -1);
    Date d3 = c.getTime();  
    
    c.add(Calendar.MONTH, -3);
    Date d6 = c.getTime();
    
    c.add(Calendar.MONTH, -6);
    Date d12 = c.getTime();   
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Abstract Report For Schemes</title>	
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
				<th align="center" class="gridhdbg" colspan="15">Inspection Abstract Report For Schemes (Repeated Inspections)( District :- <%=Dname %>	
					<%if (Mode != null && Mode.equals("Panchyat")){ %>
						And Mandal :- <%=Mname %>  				
					<%} else if (Mode != null && Mode.equals("Village")){ %> 
						, Mandal :- <%=Mname %> And Panchyat :- <%=Pname %>
					<%} else if (Mode != null && Mode.equals("Habitation")){ %>
						, Mandal :- <%=Mname %>, Panchyat :- <%=Pname %> And Village :- <%=Vname %>
					<%} %>  )
				</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
			    <th class="gridhdbg" rowspan="2"> <%if (Mode != null && Mode.equals("Mandal")){ %>Mandal<%}else if (Mode != null && Mode.equals("Panchyat")){ %> Panchyat <%} else if (Mode != null && Mode.equals("Village")){ %> Village <%} else if (Mode != null && Mode.equals("Habitation")){ %>Habitation<%} %></th>
			    <th class="gridhdbg" rowspan="2"> Total Schemes </th>
			    <th class="gridhdbg" colspan="8"> Inspected </th>
			    <th class="gridhdbg" rowspan="2"> Functioning </th>			   
			    <th class="gridhdbg" rowspan="2"> Not Functioning </th>
			</tr>
			<tr>
				<th class="gridhdbg"> <1 month </th>
				<th class="gridhdbg"> % (<1 month/Total schemes) </th>
				<th class="gridhdbg"> 1-2 months </th>
				<th class="gridhdbg"> 2-3 months </th>
				<th class="gridhdbg"> 3-6 months </th>
				<th class="gridhdbg"> 6-12 months </th>
				<th class="gridhdbg"> Total </th>
				<th class="gridhdbg">% (Total/Total Schemes)</th>
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
			</tr>
		</thead>
		<tbody>		
	<%		String query1="",query2="",query3="",query4="",query5="",query6="", query7="";
			PreparedStatement  ps1=null,ps2=null,ps3=null,ps4=null,ps5=null, ps6=null, ps7=null;
			ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
			String style="-", Temp="-";
			int styleCount=1, schemes=0, withInOneMonth=0, oneTwoMonth=0, twoThreeMonth=0, threeSixMonth=0, functioning=0, notFunctioning=0, safe=0, unSafe=0, totalScheme=0, totalWithInOneMonth=0, totalOneTwoMonth=0, totalTwoThreeMonth=0, totalThreeSixMonth=0, totalMoreThanSixMonth=0, totalHori=0, totalVert=0, totalFunctioningAssets=0, totalNotFunctioningAssets=0, totalSafeAssets=0, totalUnSafeAssets=0, moreThanSixMonths=0;
			try{			
				if (Mode != null && Mode.equals("Mandal")){
					query2="SELECT COUNT(*),C.MCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' GROUP BY C.MCODE";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query2="SELECT COUNT(*),C.PCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' GROUP BY C.PCODE";
				} else if (Mode != null && Mode.equals("Village")){ 
					query2="SELECT COUNT(*),C.VCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' GROUP BY C.VCODE";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query2="SELECT COUNT(*),C.PANCH_CODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+Vcode+"' GROUP BY C.PANCH_CODE";
				} 	
					ps2=conn.prepareStatement(query2);
					rs2=ps2.executeQuery();			
					Hashtable totalSchemes = new Hashtable();
					while(rs2.next()){
						totalSchemes.put(rs2.getString(2),rs2.getInt(1)); 
					}
				rs2.close();
				ps2.close();
				if (Mode != null && Mode.equals("Mandal")){
					query3="SELECT COUNT(*),C.MCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=1 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' GROUP BY C.MCODE";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query3="SELECT COUNT(*),C.PCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=1 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' GROUP BY C.PCODE";
				} else if (Mode != null && Mode.equals("Village")){ 
					query3="SELECT COUNT(*),C.VCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=1 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' GROUP BY C.VCODE";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query3="SELECT COUNT(*),C.PANCH_CODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=1 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+Vcode+"' GROUP BY C.PANCH_CODE";
				} 							
					ps3=conn.prepareStatement(query3);
					rs3=ps3.executeQuery();			
					Hashtable totalFunctioning = new Hashtable();
					while(rs3.next()){
						totalFunctioning.put(rs3.getString(2),rs3.getInt(1)); 
					}
				rs3.close();
				ps3.close();
				if (Mode != null && Mode.equals("Mandal")){
					query4="SELECT COUNT(*),C.MCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=2 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' GROUP BY C.MCODE";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query4="SELECT COUNT(*),C.PCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=2 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' GROUP BY C.PCODE";
				} else if (Mode != null && Mode.equals("Village")){ 
					query4="SELECT COUNT(*),C.VCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=2 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' GROUP BY C.VCODE";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query4="SELECT COUNT(*),C.PANCH_CODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=2 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+Vcode+"' GROUP BY C.PANCH_CODE";
				} 	
					ps4=conn.prepareStatement(query4);
					rs4=ps4.executeQuery();			
					Hashtable totalNotFunctioning = new Hashtable();
					while(rs4.next()){
						totalNotFunctioning.put(rs4.getString(2),rs4.getInt(1)); 
					}			
				rs4.close();
				ps4.close();
				if (Mode != null && Mode.equals("Mandal")){
					query5="SELECT MCODE, MNAME FROM RWS_MANDAL_TBL WHERE DCODE='"+Dcode+"' ORDER BY MNAME";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query5="SELECT PCODE, PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE='"+Dcode+"' AND MCODE='"+Mcode+"' ORDER BY PNAME";
				} else if (Mode != null && Mode.equals("Village")){ 
					query5="SELECT VCODE, VNAME FROM RWS_VILLAGE_TBL WHERE DCODE='"+Dcode+"' AND MCODE='"+Mcode+"' AND PCODE='"+Pcode+"' ORDER BY VNAME";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query5="SELECT PANCH_CODE, PANCH_NAME FROM RWS_COMPLETE_HAB_VIEW WHERE DCODE='"+Dcode+"' AND MCODE='"+Mcode+"' AND PCODE='"+Pcode+"' AND VCODE='"+Vcode+"' ORDER BY PANCH_NAME";
				} 	
				ps5=conn.prepareStatement(query5);
				rs5=ps5.executeQuery();			
				while(rs5.next()){
					withInOneMonth=0;
					oneTwoMonth=0;
					twoThreeMonth=0;
					threeSixMonth=0;
					moreThanSixMonths=0;				
					if(totalSchemes.get(rs5.getString(1)) != null){
						schemes =(Integer) totalSchemes.get(rs5.getString(1));
					}else{
						schemes = 0;
					}
					if(totalFunctioning.get(rs5.getString(1)) != null){
						functioning =(Integer) totalFunctioning.get(rs5.getString(1));
					}else{
						functioning = 0;
					}
					if(totalNotFunctioning.get(rs5.getString(1)) != null){
						notFunctioning =(Integer) totalNotFunctioning.get(rs5.getString(1));
					}else{
						notFunctioning = 0;
					}
					int count = 0;
					/* query7="SELECT MON, COUNT(ASSETCOUNT) FROM (SELECT D.UPDATE_DATE AS MON, A.ASSET_CODE AS ASSETCOUNT FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_IMAGE_TBL D WHERE A.ASSET_CODE=D.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+")";
							if (Mode != null && Mode.equals("Mandal")){
								query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+rs5.getString(1)+"'";
							}else if (Mode != null && Mode.equals("Panchyat")){  
								query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+rs5.getString(1)+"'";
							} else if (Mode != null && Mode.equals("Village")){ 
								query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+rs5.getString(1)+"'";
							} else if (Mode != null && Mode.equals("Habitation")){ 
								query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+Vcode+"' AND C.PANCH_CODE='"+rs5.getString(1)+"'";
							}
					query7 +="UNION SELECT D.UPDATE_DATE AS MON, A.ASSET_CODE AS ASSETCOUNT FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_IMAGE_HIS_TBL D WHERE A.ASSET_CODE=D.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+")";
							if (Mode != null && Mode.equals("Mandal")){
								query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+rs5.getString(1)+"'";
							}else if (Mode != null && Mode.equals("Panchyat")){  
								query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+rs5.getString(1)+"'";
							} else if (Mode != null && Mode.equals("Village")){ 
								query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+rs5.getString(1)+"'";
							} else if (Mode != null && Mode.equals("Habitation")){ 
								query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+Vcode+"' AND C.PANCH_CODE='"+rs5.getString(1)+"'";
							} 
					query7 +=") GROUP BY MON ORDER BY MON"; */
					
					query7="SELECT to_date(D.inspect_date), A.ASSET_CODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_INSPECTION_TBL D WHERE A.ASSET_CODE=D.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+")";
					if (Mode != null && Mode.equals("Mandal")){
						query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+rs5.getString(1)+"'";
					}else if (Mode != null && Mode.equals("Panchyat")){  
						query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+rs5.getString(1)+"'";
					} else if (Mode != null && Mode.equals("Village")){ 
						query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+rs5.getString(1)+"'";
					} else if (Mode != null && Mode.equals("Habitation")){ 
						query7 +=" AND  C.DCODE='"+Dcode+"' AND C.MCODE='"+Mcode+"' AND C.PCODE='"+Pcode+"' AND C.VCODE='"+Vcode+"' AND C.PANCH_CODE='"+rs5.getString(1)+"'";
					}
					query7 +=" group by to_date(D.inspect_date), A.ASSET_CODE";
					ps7=conn.prepareStatement(query7);
					rs7=ps7.executeQuery();			
					while(rs7.next()){
						if(rs7.getString(1) != null && rs7.getDate(1).after(d1) && rs7.getDate(1).before(d) ){
							withInOneMonth ++;
						}
						else if(rs7.getString(1) != null && rs7.getDate(1).after(d2) && rs7.getDate(1).before(d1)){
							oneTwoMonth ++;
						}
						else if(rs7.getString(1) != null && rs7.getDate(1).after(d3) && rs7.getDate(1).before(d2)){
							twoThreeMonth ++;
						}
						else if(rs7.getString(1) != null && rs7.getDate(1).after(d6) && rs7.getDate(1).before(d3)){
							threeSixMonth ++;
						}
						else if(rs7.getString(1) != null && rs7.getDate(1).after(d12) && rs7.getDate(1).before(d6)){
							moreThanSixMonths ++;
						}
					}
					rs7.close();
					ps7.close();
					 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                     } else {
                         style = "gridbg2";
                     }
					 totalHori = (withInOneMonth + oneTwoMonth + twoThreeMonth + threeSixMonth + moreThanSixMonths);	
					 double withInOneMonthDob=withInOneMonth;
					 double schemesDob=schemes;
					 double per=(withInOneMonthDob/schemesDob);
					 per*=100;					 
					 double totalHoriDob=totalHori;
					 double totPer=(totalHoriDob/schemesDob);
					 totPer*=100;
			%>
				<tr>
					<%if (Mode != null && Mode.equals("Mandal")){ %>
		 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
		 				<td class="<%=style%>" style="text-align: left;"> <a href="rws_abstract_report_his_drill.jsp?mode=Panchyat&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>"> <%=rs5.getString(2)%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=Total&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=schemes%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=oneMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=withInOneMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(per)%> </td>
	 					<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=twoMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=oneTwoMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=threeMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=twoThreeMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=greaterThan3Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=threeSixMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=greaterThan6Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=moreThanSixMonths%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=HorizontalTotal&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=totalHori%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(totPer)%> </td>
	 					<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=Functioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=functioning%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=NotFunctioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=notFunctioning%></a> </td>
		 			
		 			<%}else if (Mode != null && Mode.equals("Panchyat")){ %>  	
		 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
		 				<td class="<%=style%>" style="text-align: left;"> <a href="rws_abstract_report_his_drill.jsp?mode=Village&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>"> <%=rs5.getString(2)%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=Total&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=schemes%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=oneMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=withInOneMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(per)%> </td>	 					
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=twoMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=oneTwoMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=threeMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=twoThreeMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=greaterThan3Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=threeSixMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=greaterThan6Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=moreThanSixMonths%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=HorizontalTotal&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=totalHori%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(totPer)%> </td>
	 					<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=Functioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=functioning%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=NotFunctioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=notFunctioning%></a> </td>
		 				
	 				<%} else if (Mode != null && Mode.equals("Village")){ %> 
		 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
		 				<td class="<%=style%>" style="text-align: left;"> <a href="rws_abstract_report_his_drill.jsp?mode=Habitation&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>"> <%=rs5.getString(2)%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=Total&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=schemes%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=oneMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=withInOneMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(per)%> </td>	 					
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=twoMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=oneTwoMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=threeMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=twoThreeMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=greaterThan3Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=threeSixMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=greaterThan6Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=moreThanSixMonths%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=HorizontalTotal&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=totalHori%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(totPer)%> </td>
	 					<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=Functioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=functioning%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=NotFunctioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=notFunctioning%></a> </td>
		 				
	 				<%} else if (Mode != null && Mode.equals("Habitation")){ %>
		 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
		 				<td class="<%=style%>" style="text-align: left;"> <%=rs5.getString(2)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=Total&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=schemes%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=oneMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=withInOneMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(per)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=twoMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=oneTwoMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=threeMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=twoThreeMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=greaterThan3Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=threeSixMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=greaterThan6Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=moreThanSixMonths%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=HorizontalTotal&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=totalHori%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(totPer)%> </td>
	 					<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=Functioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=functioning%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_his_drill1.jsp?mode=NotFunctioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=notFunctioning%></a> </td>
		 				
	 				<%} %>	 							
	 			</tr>	
				<% 	         styleCount++;
							 totalScheme+=schemes; 
							 totalWithInOneMonth+=withInOneMonth; 
							 totalOneTwoMonth+=oneTwoMonth;
							 totalTwoThreeMonth+=twoThreeMonth; 
							 totalThreeSixMonth+=threeSixMonth; 
							 totalMoreThanSixMonth+=moreThanSixMonths;
							 totalVert+=totalHori; 
							 totalFunctioningAssets+=functioning; 
							 totalNotFunctioningAssets+=notFunctioning; 							
						}
				        
				}catch(Exception e){
						e.printStackTrace();
					}finally{
						if(rs5!=null){			
							   rs2.close();
						   }
						if(ps5!=null){			
							   ps2.close();
						   }
						if(conn!=null){
							conn.close();
						}
					}
				%>
		</tbody>
		<tfoot>
			<tr>
				<td class="gridhdbg" style="text-align: right;" colspan="2"> Total </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalScheme%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalWithInOneMonth%> </td>
 				<td class="gridhdbg" style="text-align: center;">  </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalOneTwoMonth%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalTwoThreeMonth%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalThreeSixMonth%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalMoreThanSixMonth%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalVert%> </td>
 				<td class="gridhdbg" style="text-align: center;">  </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalFunctioningAssets%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalNotFunctioningAssets%> </td>	
 			</tr>	
		</tfoot>		
	</table>
</body>
</html>