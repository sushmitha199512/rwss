<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ page import="java.text.DecimalFormat.*, java.util.Date,  java.util.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	String Dcode = request.getParameter("dCode");
    String Dname = request.getParameter("dName");
    String Mcode = request.getParameter("mCode");
    String Mname = request.getParameter("mName");
    String Pcode = request.getParameter("pCode");
    String Pname = request.getParameter("pName");
    String Vcode = request.getParameter("vCode");
    String Vname = request.getParameter("vName");
    String Hcode = request.getParameter("hCode");
    String Hname = request.getParameter("hName");
    String OneMonth = request.getParameter("oneMonth");
    String LastMonth = request.getParameter("lastMonth");
    String Mode = request.getParameter("mode");    
    SimpleDateFormat format = new SimpleDateFormat("dd-MMM-YYYY");
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
	<title>Abstract Report For Hand Pumps</title>	
	<style type="text/css">
	 	.gridhdbg{
		 	padding:5px 5px;
		}
		.gridhdbg12{
			padding:5px 5px;
		}
		.rightPad td {
				padding-right: 3px !important;
		}		
		.thumbnail {
			position: relative;
			z-index: 0;
		}		
		.thumbnail:hover {
			background-color: transparent;
			z-index: 60;
		}		
		.thumbnail span { /*CSS for enlarged image*/
			position: absolute;
			background-color: lightyellow;
			padding: 4px;
			left: -1000px;
			border: 1px dashed gray;
			visibility: hidden;
			color: black;
			text-decoration: none;
		}		
		.thumbnail span img { /*CSS for enlarged image*/
			border-width: 0;
			padding: 2px;
		}		
		.thumbnail:hover span { /*CSS for enlarged image on hover*/
			visibility: visible;
			top: -120px;
			left: -350px;
			/*position where enlarged image should offset horizontally */
		}		 
    </style> 	
	<script type="text/javascript">
		function viewWorks1(URL) {
			var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
			if (URL != "") {
				myNewWin = window.open(URL, 'new1Winddow', popFeatures);
				myNewWin.focus();
			}
		}
	</script>
</head>
<body style="margin-top: 10%">
	<table border="0" cellspacing="0" cellpadding="0" width="80%" style="border-collapse:collapse" align="center">
		<thead>
			<tr>
				<th align="center" class="gridhdbg" colspan="25">Inspection Abstract Report For Hand Pumps ( District :- <%=Dname %>	
					<%if  (Mname != null){ %>
						, Mandal :- <%=Mname %>  				
					<%} if (Pname != null){ %> 
						, Panchyat :- <%=Pname %>
					<%} if (Vname != null){ %>
						, Village :- <%=Vname %>
					<%} if (Hname != null){ %>
					 	, Habitation :- <%=Hname %>
					<%} %> )
				</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
			    <th class="gridhdbg" rowspan="2"> Source Code/Source Name </th>
			    <th class="gridhdbg" rowspan="2"> Location </th>
			    <th class="gridhdbg" rowspan="2"> Asset ID </th>
			    <th class="gridhdbg" colspan="4"> Location Details </th>
			    <th class="gridhdbg" rowspan="2"> Having Platform </th>			    
			    <th class="gridhdbg" rowspan="2"> Having Saokpit </th>				    
			    <th class="gridhdbg" rowspan="2"> Status </th>			    
			    <th class="gridhdbg" colspan="3"> Repair Details </th>
			    <th class="gridhdbg" rowspan="2"> Inspected by </th>			   
			    <th class="gridhdbg" rowspan="2"> Date of Inspection </th>
			    <th class="gridhdbg" rowspan="2"> Source test Results </th>				    
			    <th class="gridhdbg" colspan="3"> Image (Hand Pumps) with co-ordinates </th>   
			</tr>
			<tr>
				<th class="gridhdbg"> Mandal </th>
				<th class="gridhdbg"> Gram Panchyat </th>
				<th class="gridhdbg"> Habitation </th>
				<th class="gridhdbg"> Habitation ID </th>				
				<th class="gridhdbg"> Type of Problem </th>
				<th class="gridhdbg"> Amount Required (Rupees) </th>
				<th class="gridhdbg"> Repair Date </th>
				<th class="gridhdbg"> Latitude </th>			   
			    <th class="gridhdbg"> Longitude </th>
			    <th class="gridhdbg"> Image </th>
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
			</tr>
		</thead>
		<tbody>		
	<%		String query1="",query2="",query3="",query4="";
			PreparedStatement  ps1=null,ps2=null,ps3=null,ps4=null;
			ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
			String style="-", TestSafe="-";
		    int styleCount=1;
			try{
				if (Mode != null && Mode.equals("Borewells") ||  Mode != null && Mode.equals("SoakPit") || Mode != null && Mode.equals("PlatforExisting") ||  Mode != null && Mode.equals("Functioning") || Mode != null && Mode.equals("NotFunctioning")){
				query2="SELECT DISTINCT A.HNAME, A.LOCATION, A.HCODE, A.ACODE, D.MNAME, D.PNAME, D.PANCH_NAME, D.PANCH_CODE, A.PLATEXIST, A.SOAKPIT, A.STATUS, NVL(C.REPAIR_DESC,'-'), NVL(B.REPAIR_COST,'0.0'), NVL(TO_CHAR(B.REPAIR_DATE,'DD-MM-YYYY'),'-'), NVL(B.INSPECTED_BY,'-'), NVL(TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY'),'-')  FROM (SELECT 'HAND PUMP' AS HNAME, NVL(LOCATION,'-') AS LOCATION,  HP_CODE AS HCODE, ASSET_CODE AS ACODE, NVL(PLATFORM_EXISTING,'-') AS PLATEXIST, NVL(SOAK_PIT,'-') AS SOAKPIT, NVL(STATUS,'-') AS STATUS  FROM RWS_HP_SUBCOMP_PARAM_TBL UNION ALL SELECT 'SHALLOW HAND PUMP' AS HNAME, NVL(LOCATION,'-') AS LOCATION,  SHALLOWHP_CODE AS HCODE, ASSET_CODE AS ACODE, NVL(PLATFORM_EXISTING,'-') AS PLATEXIST, NVL(SOAK_PIT,'-') AS SOAKPIT, NVL(STATUS,'-') AS STATUS FROM RWS_SHALLOWHANDPUMPS_TBL) A LEFT JOIN RWS_ASSET_COMPONENT_REPAIR_TBL B ON (A.ACODE=B.ASSET_CODE AND A.HCODE=B.ASSET_COMP_CODE) LEFT JOIN  RWS_REPAIR_MASTER_TBL C ON B.REPAIR_CODE=C.REPAIR_CODE, RWS_COMPLETE_HAB_VIEW D, RWS_ASSET_MAST_TBL E WHERE A.ACODE=E.ASSET_CODE AND SUBSTR(A.HCODE,1,16)=D.PANCH_CODE AND D.DCODE='"+Dcode+"'";
				if (Mode != null && Mode.equals("SoakPit")){
					query2+=" AND A.SOAKPIT='Y'";
				}
				if (Mode != null && Mode.equals("PlatforExisting")){
					query2+=" AND A.PLATEXIST='Y'";
				}
				if (Mode != null && Mode.equals("Functioning")){
					query2+=" AND A.STATUS='W'";
				}
				if (Mode != null && Mode.equals("NotFunctioning")){
					query2+=" AND A.STATUS='N'";
				}
				if (Mcode != null && !Mcode.equals("null")){
					query2+=" AND D.MCODE='"+Mcode+"'";
				}
				if (Pcode != null && !Pcode.equals("null")){
					query2+=" AND D.PCODE='"+Pcode+"'";
				}
				if (Vcode != null && !Vcode.equals("null")){
					query2+=" AND D.VCODE='"+Vcode+"'";
				}
				if (Hcode != null && !Hcode.equals("null")){
					query2+=" AND D.PANCH_CODE='"+Hcode+"'";
				} 
				query2+=" ORDER BY A.HCODE, D.PNAME";
				}
				else{
				query2="SELECT NAME,LOCATION,SOURCE_CODE,ASSET_CODE,MNAME,PNAME,PANCH_NAME,PANCH_CODE,PLATEXIST,SOAKPIT,STATUS,REPAIR_DESC,REPAIR_COST,REPAIR_DATE,INSPECTED_BY,to_char(UPDATE_DATE,'DD-MM-YYYY') FROM RWS_HP_SHP_COMP_REPAIR_VIEW  WHERE  DCODE='"+Dcode+"'";
			
				if (Mode != null && Mode.equals("oneMonth")){
					query2+=" AND (UPDATE_DATE > '"+format.format(d1)+"')";
				}
				if (Mode != null && Mode.equals("twoMonth")){
					query2+=" AND (UPDATE_DATE > '"+format.format(d2)+"' AND UPDATE_DATE <= '"+format.format(d1)+"')";
				}
				if (Mode != null && Mode.equals("threeMonth")){
					query2+=" AND (UPDATE_DATE > '"+format.format(d3)+"' AND UPDATE_DATE <= '"+format.format(d2)+"')";
				}
				if (Mode != null && Mode.equals("greaterThan3Month")){
					query2+=" AND (UPDATE_DATE > '"+format.format(d6)+"' AND UPDATE_DATE <= '"+format.format(d3)+"')";
				}
				if (Mode != null && Mode.equals("greaterThan6Month")){
					query2+=" AND (UPDATE_DATE > '"+format.format(d12)+"' AND UPDATE_DATE <= '"+format.format(d6)+"')";
				}					
				if (Mode != null && Mode.equals("HorizontalTotal")){
					query2+=" AND UPDATE_DATE > '"+format.format(d12)+"' ";
				}					
				if (Mcode != null && !Mcode.equals("null")){
					query2+=" AND MCODE='"+Mcode+"'";
				}
				if (Pcode != null && !Pcode.equals("null")){
					query2+=" AND PCODE='"+Pcode+"'";
				}
				if (Vcode != null && !Vcode.equals("null")){
					query2+=" AND VCODE='"+Vcode+"'";
				}
				if (Hcode != null && !Hcode.equals("null")){
					query2+=" AND PANCH_CODE='"+Hcode+"'";
				} 
				query2+=" ORDER BY UPDATE_DATE";
				}
			//	System.out.println("query 2" + Dcode +"  "+ query2);
					ps2=conn.prepareStatement(query2);
					rs2=ps2.executeQuery();						
				while(rs2.next()){
					TestSafe="-";
					query1="SELECT DISTINCT NVL(A.TESTING_PARAMETER_VALUE,'0.0') AS TESTING_PARAMETER_VALUE, A.TESTING_PARAMETER_CODE  AS TESTING_PARAMETER_CODE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND  A.TESTING_PARAMETER_CODE IN (05,13,15,16) AND (B.SOURCE_CODE, B.PREPARED_ON) IN (SELECT SOURCE_CODE, MAX(PREPARED_ON) FROM RWS_WQ_TEST_RESULTS_TBL WHERE SOURCE_CODE='"+rs2.getString(3)+"' GROUP BY SOURCE_CODE)";
				    ps1=conn.prepareStatement(query1);
				    rs1=ps1.executeQuery();
				   	while(rs1.next()){
					   if((rs1.getString(2).equals("05") &&  Double.parseDouble(rs1.getString(1)) > 2000.00) || (rs1.getString(2).equals("13") && Double.parseDouble(rs1.getString(1)) > 1.5) || (rs1.getString(2).equals("15") && Double.parseDouble(rs1.getString(1)) > 45.00) ||(rs1.getString(2).equals("16") && Double.parseDouble(rs1.getString(1)) > 1.0)){
						   		TestSafe = "Unsafe";
				    		}else{
								TestSafe = "Safe";
							}								
						}
					rs1.close();
					ps1.close();
					 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                     } else {
                         style = "gridbg2";
                     }
					 String SourceStatus = (rs2.getString(11) != null && rs2.getString(11).equals("W"))? "Working" : ((rs2.getString(11) != null && rs2.getString(11).equals("N"))? "Not Working" : ((rs2.getString(11) != null && rs2.getString(11).equals("D"))? "Dried" : ((rs2.getString(11) != null && rs2.getString(11).equals("C"))? "Condemned" : ((rs2.getString(11) != null && rs2.getString(11).equals("S"))? "Seasonal" : "-"))));
					
			%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(3)+"/"+rs2.getString(1)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(2)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(4)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(5)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(6)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(7)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(8)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=(rs2.getString(9) != null && rs2.getString(9).equals("Y"))? "YES" : "NO"%> </td>	 				
	 				<td class="<%=style%>" style="text-align: center;"> <%=(rs2.getString(10) != null && rs2.getString(10).equals("Y"))? "YES" : "NO"%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=SourceStatus%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(12)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(13)%> </td>	 				
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(14)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(15)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(16)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks1('./rws_abstract_report_for_handpumps_drill2.jsp?dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=Hcode%>&hName=<%=Hname%>&sourceCode=<%=rs2.getString(3)%>&sourceName=<%=rs2.getString(1)%>&assetCode=<%=rs2.getString(4)%>&status=<%=SourceStatus%>')"><%=TestSafe%></a> </td>
	 				<% if (rs2.getString(3) != null){
	 					query4="SELECT DISTINCT DBMS_LOB.GETLENGTH(COMPO_IMAGE), NVL(COMPO_LAT,'0.0'), NVL(COMPO_LON,'0.0') FROM RWS_ASSET_COMPONENT_IMAGE_TBL WHERE ASSET_CODE=? AND ASSET_COMPONENT=?";
		 				//System.out.println("query 4" query4);
						ps4=conn.prepareStatement(query4);
						ps4.setString(1,rs2.getString(4));
						ps4.setString(2,rs2.getString(3));
						rs4=ps4.executeQuery();			
						if(!rs4.next()){ 
				%>
					<td class="<%=style%>" style="text-align: center;">  </td>
 					<td class="<%=style%>" style="text-align: center;">  </td>
					<td class="<%=style%>" style="text-align: left;">-</td>	 
							
				<%		}else{
							do{
							if(rs4.getInt(1) != 0){
				%>	 	
					<td class="<%=style%>" style="text-align: center;"> <%=rs4.getString(2)%> </td>
 					<td class="<%=style%>" style="text-align: center;"> <%=rs4.getString(3)%> </td>	 							
 					<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img	src="../../masters/image.jsp?imgID=<%=rs2.getString(3)%>" width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?imgID=<%=rs2.getString(3)%>" width="350px" height="230px" /></span></a></td>
 				<%}else{ %>
 					<td class="<%=style%>" style="text-align: center;"> - </td>
 					<td class="<%=style%>" style="text-align: center;"> - </td>
					<td class="<%=style%>" style="text-align: left;">-</td>	 				
					<%} }while(rs4.next());}rs4.close(); ps4.close();}else{ %>
					<td class="<%=style%>" style="text-align: center;"> - </td>
 					<td class="<%=style%>" style="text-align: center;"> - </td>
 					<td class="<%=style%>" style="text-align: left;"> - </td>	 				
 				<%} %> 			
	 			</tr>	
				<% 	         styleCount++;							
						}
				}catch(Exception e){
					System.out.println("Exception in rws_abstract_report_for_handpumps_drill1.jsp"+e);
					}finally{
						if(rs2!=null){			
							   rs2.close();
						   }
						if(ps2!=null){			
							   ps2.close();
						   }
						if(conn!=null){			
						   conn.close();
					   }
					}
				%>
		</tbody>	
	</table>
</body>
</html>