<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@page import="nic.watersoft.works.WorksData1"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat formatter = new DecimalFormat("##,##,##,###");
	String SchemeType = request.getParameter("schemeType");
    String AssetCode = request.getParameter("assetCode"); 
    String AssetName = request.getParameter("assetName");
    String Status = request.getParameter("status");
    String Dcode = request.getParameter("dCode");
    String Dname = request.getParameter("dName");
    String Mcode = request.getParameter("mCode");
    String Mname = request.getParameter("mName");
    String Pcode = request.getParameter("pCode");
    String Pname = request.getParameter("pName");
    String Vcode = request.getParameter("vCode");
    String Vname = request.getParameter("vName");
    String Hcode = request.getParameter("hCode");
    String Hname = request.getParameter("hName");
    String Mode = request.getParameter("mode");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Abstract Report For Schemes</title>
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
				myNewWin = window.open(URL, 'newWinddow', popFeatures);
				myNewWin.focus();
			}
		}
	</script>
</head>
<body style="margin-top: 10%">
	<table border="0" cellspacing="0" cellpadding="0" width="80%" style="border-collapse:collapse" align="center">
		<thead>
			<tr>
				<th align="center" class="gridhdbg" colspan="25">Inspection Abstract Report For Schemes(Repeated Inspections) ( Scheme Type :- <%=SchemeType %>
						, Asset Name :- <%=AssetName %>
						, Asset Working Status :- <%=Status %>  
						, District :- <%=Dname %>	
					<%if (Mname != null && !Mname.equals("null")){ %>
						, Mandal :- <%=Mname %>  				
					<%} if (Pname != null && !Pname.equals("null")){ %> 
						, Panchyat :- <%=Pname %>
					<%} if (Vname != null && !Vname.equals("null")){ %>
						, Village :- <%=Vname %>
					<%} if (Hname != null && !Hname.equals("null")){ %>
					 	, Habitation :- <%=Hname %>
					<%} %>  )</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
				<th class="gridhdbg" rowspan="2"> Source Code </th>   
			<% if (Mode != null && Mode.equals("CompnentDetails")){%>
			    <th class="gridhdbg" rowspan="2"> Component Status </th>
			    <th class="gridhdbg" rowspan="2"> Type of problem</th>
			    <th class="gridhdbg" rowspan="2"> Amount Required (Rupees) </th>
			    <th class="gridhdbg" rowspan="2"> Repaired Date (if repaired)</th>			   
			    <th class="gridhdbg" rowspan="2"> Inspected by </th>	   
			    <th class="gridhdbg" rowspan="2"> Date of Inspection</th>			    
			    <th class="gridhdbg" colspan="3"> 	Image with co-ordinates </th> 
			<%}else{ %>
				<th class="gridhdbg" rowspan="2"> Source Name </th>
			    <th class="gridhdbg" rowspan="2"> Location </th>
			    <th class="gridhdbg" rowspan="2"> Test Date </th>
			    <th class="gridhdbg" colspan="1"> Brackish </th>			   
			    <th class="gridhdbg" colspan="1"> Fluoride (As F) </th>	   
			    <th class="gridhdbg" colspan="1"> Iron (As Fe)</th>			    
			    <th class="gridhdbg" colspan="1"> Nitrate (As NO3)</th>   
			<%} %>
			</tr>
			<tr>
				<% if (Mode != null && Mode.equals("CompnentDetails")){%>
				    <th class="gridhdbg" > Latitude </th>
				    <th class="gridhdbg" > longitude </th>
				    <th class="gridhdbg" > Image </th>
				<%}else{ %>
					<th class="gridhdbg"> Safe Permissible Value =< 2000 </th>
					<th class="gridhdbg"> Safe Permissible Value =< 1.5 </th>
					<th class="gridhdbg"> Safe Permissible Value =< 1.0 </th>
					<th class="gridhdbg"> Safe Permissible Value =< 45 </th>
				<%} %>
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
				<% if (Mode != null && Mode.equals("CompnentDetails")){%>
					<th class="gridhdbg"> 10 </th>
					<th class="gridhdbg"> 11 </th>
				<%} %>							
			</tr>
		</thead>
		<tbody>		
	<%		String query1="",query2="",query3="",query4="",query5="",query6="", query7="";
			PreparedStatement  ps1=null,ps2=null,ps3=null,ps4=null,ps5=null, ps6=null, ps7=null;
			ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
			String style="-", TestDate="-";
		    int styleCount=1;	
		    double Brackish= 0.0 , Fluoride=0.0 , Iron=0.0 , Nitrate=0.0;
			try{
					if (Mode != null && Mode.equals("CompnentDetails")){
						query2="SELECT DISTINCT A.ASSET_COMP_CODE, A.STATUS, NVL(B.REPAIR_DESC,'-'), NVL(A.REPAIR_COST,'0.0'), NVL(TO_CHAR(A.REPAIR_DATE,'DD-MM-YYYY'),'-'), NVL(A.INSPECTED_BY,'-'), NVL(TO_CHAR(UPDATE_DATE,'DD-MM-YYYY'),'-')  FROM RWS_ASSET_COMPONENT_REPAIR_TBL A LEFT JOIN RWS_REPAIR_MASTER_TBL B ON A.REPAIR_CODE=B.REPAIR_CODE WHERE A.ASSET_CODE=? AND A.UPDATE_DATE IN (SELECT MAX(UPDATE_DATE) FROM RWS_ASSET_COMPONENT_REPAIR_TBL GROUP BY ASSET_COMP_CODE)  ORDER BY A.ASSET_COMP_CODE";
							ps2=conn.prepareStatement(query2);
							ps2.setString(1,AssetCode);
							rs2=ps2.executeQuery();
							while(rs2.next()){
								 if (styleCount % 2 == 0) {
			                         style = "gridbg1";
			                     } else {
			                         style = "gridbg2";
			                     }
								 String ComponentStatus = (rs2.getString(2) != null && rs2.getString(2).equals("W"))?"Working":((rs2.getString(2) != null && rs2.getString(2).equals("N"))?"Not Working":((rs2.getString(2) != null && rs2.getString(2).equals("D"))?"Dried":((rs2.getString(2) != null && rs2.getString(2).equals("S"))?"Seasonal":((rs2.getString(2) != null && rs2.getString(2).equals("C"))?"Condemned":"-"))));
	%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(1)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=ComponentStatus%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(3)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(4)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(5)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(6)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(7)%> </td>
	 				<% if (rs2.getString(1) != null){
	 					query4="SELECT DISTINCT DBMS_LOB.GETLENGTH(COMPO_IMAGE), NVL(COMPO_LAT,'0.0'), NVL(COMPO_LON,'0.0') FROM RWS_ASSET_COMPONENT_IMAGE_TBL WHERE ASSET_CODE=? AND ASSET_COMPONENT=?";
			 				ps4=conn.prepareStatement(query4);
							ps4.setString(1,AssetCode);
							ps4.setString(2,rs2.getString(1));
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
	 					<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img	src="../../masters/image.jsp?imgID=<%=rs2.getString(1)%>" width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?imgID=<%=rs2.getString(1)%>" width="350px" height="230px" /></span></a></td>
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
	<% styleCount++; }}else{
				query2="SELECT DISTINCT SOURCE_CODE, NVL(SOURCE_NAME,'-'), NVL(LOCATION,'-') FROM RWS_SOURCE_TBL WHERE ASSET_CODE=? ORDER BY SOURCE_CODE";
					ps2=conn.prepareStatement(query2);
					ps2.setString(1,AssetCode);
					rs2=ps2.executeQuery();						
				while(rs2.next()){	
					TestDate="-";
					 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                     } else {
                         style = "gridbg2";
                     }
					 query1="SELECT DISTINCT TO_CHAR(B.PREPARED_ON,'DD-MM-YYYY'), NVL(A.TESTING_PARAMETER_VALUE,'0.0') AS TESTING_PARAMETER_VALUE, A.TESTING_PARAMETER_CODE  AS TESTING_PARAMETER_CODE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND B.SOURCE_CODE=? AND  A.TESTING_PARAMETER_CODE IN (05,13,15,16) AND (B.SOURCE_CODE, B.PREPARED_ON) IN (SELECT SOURCE_CODE, MAX(PREPARED_ON) FROM RWS_WQ_TEST_RESULTS_TBL GROUP BY SOURCE_CODE)";
					    ps1=conn.prepareStatement(query1);
					    ps1.setString(1,rs2.getString(1));						
					    rs1=ps1.executeQuery();
					    if(!rs1.next()){
					    	Brackish= 0.0; 
					    	Fluoride=0.0; 
					    	Iron=0.0; 
					    	Nitrate=0.0;
					    }else{
						   do{
								TestDate=rs1.getString(1);
							   if(rs1.getString(3) != null && rs1.getString(3).equals("05")){
								   Brackish = rs1.getDouble(2);
							   }
							   if(rs1.getString(3) != null && rs1.getString(3).equals("16")){
								   Iron = rs1.getDouble(2);
							   }
							   if(rs1.getString(3) != null && rs1.getString(3).equals("13")){
								   Fluoride = rs1.getDouble(2);
							   }
							   if(rs1.getString(3) != null && rs1.getString(3).equals("15")){
								   Nitrate = rs1.getDouble(2);
							   }
							}while(rs1.next());
					    }
					rs1.close();
					ps1.close();
				if(Brackish != 0.0 || Fluoride != 0.0 || Iron != 0.0 || Nitrate != 0.0){
					if (Mode != null && Mode.equals("TestUnsafe")){
						if(Brackish > 2000.00 || Fluoride > 1.5 || Nitrate > 45.00 || Iron > 1.0){ 
			    %>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(1)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(2)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(3)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=TestDate%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=Brackish%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=Fluoride%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=Iron%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=Nitrate%> </td>
	 			</tr>	
		        <% 	   styleCount++;}
				
					}if (Mode != null && Mode.equals("TestSafe")){
						if(Brackish <= 2000.00 || Fluoride <= 1.5 || Nitrate <= 45.00 || Iron <= 1.0){ 
			    %>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(1)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(2)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(3)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=TestDate%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=Brackish%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=Fluoride%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=Iron%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=Nitrate%> </td>
	 			</tr>	
				<% 	      styleCount++;}
													
						}
					  }
	                }
				  }
				}catch(Exception e){
						e.printStackTrace();
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