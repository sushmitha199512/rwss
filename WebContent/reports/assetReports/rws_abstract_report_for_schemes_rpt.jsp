<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page import="java.text.DecimalFormat.*, java.util.Date,  java.util.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% DecimalFormat ndf = new DecimalFormat("####.##");
    String typeOfAssetCode = request.getParameter("typeOfAsset");   
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
				<th align="center" class="bwborder" colspan="15">
					<form>
						<label><font color="navy"><b>Scheme Type : </b></font></label>
						<select name="typeOfAsset" style="width:150px" class="mycombo" onchange="this.form.submit()" >
							<option value="0">ALL</option>
							<% 
								String query1="",query2="",query3="",query4="",query5="",query6="", query7="";
								PreparedStatement  ps1=null,ps2=null,ps3=null,ps4=null,ps5=null, ps6=null, ps7=null;
								ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
								String style="-", SchemeType = "01,02,03,09", Temp="-";
							    int styleCount=1, schemes=0, withInOneMonth=0, oneTwoMonth=0, twoThreeMonth=0, threeSixMonth=0, functioning=0, notFunctioning=0, safe=0, unSafe=0, totalScheme=0, totalWithInOneMonth=0, totalOneTwoMonth=0, totalTwoThreeMonth=0, totalThreeSixMonth=0, totalMoreThanSixMonth=0, totalHori=0, totalVert=0, totalFunctioningAssets=0, totalNotFunctioningAssets=0, totalSafeAssets=0, totalUnSafeAssets=0, moreThanSixMonths=0;
								try{
										query1="SELECT TYPE_OF_ASSET_CODE, TYPE_OF_ASSET_NAME FROM RWS_ASSET_TYPE_TBL WHERE TYPE_OF_ASSET_CODE IN (01,02,03,09) ORDER BY TYPE_OF_ASSET_NAME";
										ps1=conn.prepareStatement(query1);
										rs1=ps1.executeQuery();
										while(rs1.next()){
											if(typeOfAssetCode != null && typeOfAssetCode.equals(rs1.getString(1)))	{	
							 %>	
							 <option value="<%= rs1.getString(1)%>" selected><%= rs1.getString(2) %>
							 <% } else { %>			
							<option value="<%=rs1.getString(1) %>"><%=rs1.getString(2) %></option>
							<% } } 
								rs1.close();
								ps1.close();
							%>
						</select>
					</form>
				</th> 
			</tr> 
			<tr>
				<th align="center" class="gridhdbg" colspan="15">Inspection Abstract Report For Schemes</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
			    <th class="gridhdbg" rowspan="2"> District </th>
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
			<%	if(typeOfAssetCode != null && !typeOfAssetCode.equals("0")){
					SchemeType = typeOfAssetCode;
				}
			  query2="SELECT COUNT(*),C.DCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") GROUP BY C.DCODE";
					ps2=conn.prepareStatement(query2);
					rs2=ps2.executeQuery();			
					Hashtable totalSchemes = new Hashtable();
					while(rs2.next()){
						totalSchemes.put(rs2.getString(2),rs2.getInt(1)); 
					}
				rs2.close();
				ps2.close();
				query3="SELECT COUNT(*),C.DCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=1 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") GROUP BY C.DCODE";
					ps3=conn.prepareStatement(query3);
					rs3=ps3.executeQuery();			
					Hashtable totalFunctioning = new Hashtable();
					while(rs3.next()){
						totalFunctioning.put(rs3.getString(2),rs3.getInt(1)); 
					}
				rs3.close();
				ps3.close();
				query4="SELECT COUNT(*),C.DCODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C WHERE A.HAB_CODE=C.PANCH_CODE AND A.ASSET_STATUS=2 AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") GROUP BY C.DCODE";
					ps4=conn.prepareStatement(query4);
					rs4=ps4.executeQuery();			
					Hashtable totalNotFunctioning = new Hashtable();
					while(rs4.next()){
						totalNotFunctioning.put(rs4.getString(2),rs4.getInt(1)); 
					}			
				rs4.close();
				ps4.close();
				query5="SELECT DCODE, DNAME FROM RWS_DISTRICT_TBL ORDER BY DNAME";
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
					
				 	//query7="SELECT MON, COUNT(ASSETCOUNT) FROM (SELECT max(D.UPDATE_DATE) AS MON, A.ASSET_CODE AS ASSETCOUNT FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_IMAGE_TBL D WHERE A.ASSET_CODE=D.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+")  AND C.DCODE=? UNION SELECT D.UPDATE_DATE AS MON, A.ASSET_CODE AS ASSETCOUNT FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_IMAGE_HIS_TBL D WHERE A.ASSET_CODE=D.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE=?) GROUP BY MON ORDER BY MON";
				 	query7="SELECT D.UPDATE_DATE, A.ASSET_CODE FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_IMAGE_TBL D WHERE A.ASSET_CODE=D.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND TYPE_OF_ASSET_CODE IN ("+SchemeType+")  AND C.DCODE=?";
				 	ps7=conn.prepareStatement(query7);
					ps7.setString(1,rs5.getString(1));
						
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
					totalHori = (withInOneMonth + oneTwoMonth + twoThreeMonth + threeSixMonth + moreThanSixMonths);
					 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                     } else {
                         style = "gridbg2";
                     }
					 double withInOneMonthDob=withInOneMonth;
					 double schemesDob=schemes;
					 double per=(withInOneMonthDob/schemesDob);
					 per*=100;
					 
					 double totalHoriDob=totalHori;
					 double totPer=(totalHoriDob/schemesDob);
					 totPer*=100;
			%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
	 				<td class="<%=style%>" style="text-align: left;"> <a href="rws_abstract_report_for_schemes_drill.jsp?mode=Mandal&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>"><%=rs5.getString(2)%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=Total&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=schemes%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=oneMonth&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=withInOneMonth%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(per)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=twoMonth&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=oneTwoMonth%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=threeMonth&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=twoThreeMonth%></a> </td>	 				
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=greaterThan3Month&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=threeSixMonth%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=greaterThan6Month&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=moreThanSixMonths%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=HorizontalTotal&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=totalHori%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=ndf.format(totPer)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=Functioning&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=functioning%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_schemes_drill1.jsp?mode=NotFunctioning&dCode=<%=rs5.getString(1)%>&dName=<%=rs5.getString(2)%>&typeOfAsset=<%=SchemeType%>')"><%=notFunctioning%></a> </td>
	 				<%-- <td class="<%=style%>" style="text-align: cend"> <%=unSafe%> </td>	 --%>			
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