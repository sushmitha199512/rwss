<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ page import="java.text.DecimalFormat.*, java.util.Date,  java.util.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat formatter = new DecimalFormat("##,##,##,###");
    String SchemeType = request.getParameter("typeOfAsset"); 
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
				<th align="center" class="gridhdbg" colspan="25">Inspection Abstract Report For Schemes (Repeated Inspections)( District :- <%=Dname %>	
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
			    <th class="gridhdbg" rowspan="2"> Type of Scheme </th>
			    <th class="gridhdbg" rowspan="2"> Name of the Scheme </th>
			    <th class="gridhdbg" rowspan="2"> Asset ID </th>
			    <th class="gridhdbg" colspan="4"> Location Details </th>
			    <th class="gridhdbg" rowspan="2"> No. of Habs for water being supplied </th>			   
			    <th class="gridhdbg" colspan="2"> Source test Results </th>	   
			    <th class="gridhdbg" rowspan="2"> Working/Not Working</th>			    
			    <th class="gridhdbg" rowspan="2"> Not Working Component Repair Details</th>
			    <th class="gridhdbg" rowspan="2"> Inspected by </th>			   
			    <th class="gridhdbg" rowspan="2"> Date of Inspection </th>
			    <th class="gridhdbg" colspan="3"> Image (Main Scheme) with co-ordinates </th>   
			</tr>
			<tr>
				<th class="gridhdbg"> Mandal </th>
				<th class="gridhdbg"> Gram Panchyat </th>
				<th class="gridhdbg"> Habitation </th>
				<th class="gridhdbg"> Habitation ID </th>
				<th class="gridhdbg"> Safe </th>
				<th class="gridhdbg"> Unsafe </th>				
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
			</tr>
		</thead>
		<tbody>		
	<%		String query1="",query2="",query3="",query4="",query5="",query6="", query7="";
			PreparedStatement  ps1=null,ps2=null,ps3=null,ps4=null,ps5=null, ps6=null, ps7=null;
			ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
			String style="-", ACode="-", ACompCount="0";
		    int styleCount=1, noOfHabs=0, TestSafe=0, TestUnsafe=0;
			try{	
				if (Mode != null && Mode.equals("Total")){
					query2="SELECT  A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D WHERE A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"'";
				}
				if (Mode != null && Mode.equals("Functioning")){
					query2="SELECT  A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D WHERE A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND A.ASSET_STATUS=1";
				}
				if (Mode != null && Mode.equals("NotFunctioning")){
					query2="SELECT  A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D WHERE A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND A.ASSET_STATUS=2";
				}
				if (Mode != null && Mode.equals("oneMonth")){
					query2="SELECT A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS, NVL(E.INSPECTED_BY,'-'), TO_CHAR(E.INSPECT_DATE,'DD-MM-YYYY') FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D, RWS_ASSET_INSPECTION_TBL E WHERE A.ASSET_CODE=E.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND (to_date(E.INSPECT_DATE) > '"+format.format(d1)+"')";
				}
				if (Mode != null && Mode.equals("twoMonth")){
					query2="SELECT A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS, NVL(E.INSPECTED_BY,'-'), TO_CHAR(E.INSPECT_DATE,'DD-MM-YYYY') FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D, RWS_ASSET_INSPECTION_TBL E WHERE A.ASSET_CODE=E.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND (to_date(E.INSPECT_DATE) > '"+format.format(d2)+"' AND to_date(E.INSPECT_DATE) <= '"+format.format(d1)+"')";
				}
				if (Mode != null && Mode.equals("threeMonth")){
					query2="SELECT A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS, NVL(E.INSPECTED_BY,'-'), TO_CHAR(E.INSPECT_DATE,'DD-MM-YYYY') FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D, RWS_ASSET_INSPECTION_TBL E WHERE A.ASSET_CODE=E.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND (to_date(E.INSPECT_DATE) > '"+format.format(d3)+"' AND to_date(E.INSPECT_DATE) <= '"+format.format(d2)+"')";
				}
				if (Mode != null && Mode.equals("greaterThan3Month")){
					query2="SELECT A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS, NVL(E.INSPECTED_BY,'-'), TO_CHAR(E.INSPECT_DATE,'DD-MM-YYYY') FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D, RWS_ASSET_INSPECTION_TBL E WHERE A.ASSET_CODE=E.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND (to_date(E.INSPECT_DATE) > '"+format.format(d6)+"' AND to_date(E.INSPECT_DATE) <= '"+format.format(d3)+"')";
				}	
				if (Mode != null && Mode.equals("greaterThan6Month")){
					query2="SELECT A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS, NVL(E.INSPECTED_BY,'-'), TO_CHAR(E.INSPECT_DATE,'DD-MM-YYYY') FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D, RWS_ASSET_INSPECTION_TBL E WHERE A.ASSET_CODE=E.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND (to_date(E.INSPECT_DATE) > '"+format.format(d12)+"' AND to_date(E.INSPECT_DATE) <= '"+format.format(d6)+"')";
				}
				if (Mode != null && Mode.equals("HorizontalTotal")){
					query2="SELECT A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS, NVL(E.INSPECTED_BY,'-'), TO_CHAR(E.INSPECT_DATE,'DD-MM-YYYY') FROM RWS_ASSET_MAST_TBL A, RWS_COMPLETE_HAB_VIEW C, RWS_ASSET_TYPE_TBL D, RWS_ASSET_INSPECTION_TBL E WHERE A.ASSET_CODE=E.ASSET_CODE AND A.HAB_CODE=C.PANCH_CODE AND A.TYPE_OF_ASSET_CODE=D.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET_CODE IN ("+SchemeType+") AND C.DCODE='"+Dcode+"' AND to_date(E.INSPECT_DATE) > '"+format.format(d12)+"'";
				}					
				if (Mcode != null && !Mcode.equals("null")){
					query2+=" AND C.MCODE='"+Mcode+"'";
				}
				if (Pcode != null && !Pcode.equals("null")){
					query2+=" AND C.PCODE='"+Pcode+"'";
				}
				if (Vcode != null && !Vcode.equals("null")){
					query2+=" AND C.VCODE='"+Vcode+"'";
				}
				if (Hcode != null && !Hcode.equals("null")){
					query2+=" AND C.PANCH_CODE='"+Hcode+"'";
				} 
				if (Mode != null && !Mode.equals("Total") && !Mode.equals("Functioning") && !Mode.equals("NotFunctioning")){
					query2+="GROUP by A.TYPE_OF_ASSET_CODE, D.TYPE_OF_ASSET_NAME, A.ASSET_NAME, A.ASSET_CODE, C.MNAME, C.PNAME, C.PANCH_NAME, C.PANCH_CODE, A.ASSET_STATUS, NVL(E.INSPECTED_BY,'-'), TO_CHAR(E.INSPECT_DATE,'DD-MM-YYYY')";
				}
					ps2=conn.prepareStatement(query2);
					rs2=ps2.executeQuery(query2);						
				while(rs2.next()){
					ACode="-";
					ACompCount="0";
					TestSafe=0; 
					TestUnsafe=0;
					noOfHabs=0;					
					query3="SELECT DISTINCT SOURCE_CODE FROM RWS_SOURCE_TBL WHERE ASSET_CODE=? ORDER BY SOURCE_CODE";
					ps3=conn.prepareStatement(query3);
					ps3.setString(1,rs2.getString(4));
					rs3=ps3.executeQuery();			
					while(rs3.next()){
						query1="SELECT DISTINCT NVL(A.TESTING_PARAMETER_VALUE,'0.0') AS TESTING_PARAMETER_VALUE, A.TESTING_PARAMETER_CODE  AS TESTING_PARAMETER_CODE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND  A.TESTING_PARAMETER_CODE IN (05,13,15,16) AND (B.SOURCE_CODE, B.PREPARED_ON) IN (SELECT SOURCE_CODE, MAX(PREPARED_ON) FROM RWS_WQ_TEST_RESULTS_TBL WHERE SOURCE_CODE='"+rs3.getString(1)+"' GROUP BY SOURCE_CODE)";
					    ps1=conn.prepareStatement(query1);
					    rs1=ps1.executeQuery();
					    int TestCount=0;
					    if(!rs1.next()){
					    	
					    }else{
					    	do{
							   if((rs1.getString(2).equals("05") &&  Double.parseDouble(rs1.getString(1)) > 2000.00) || (rs1.getString(2).equals("13") && Double.parseDouble(rs1.getString(1)) > 1.5) || (rs1.getString(2).equals("15") && Double.parseDouble(rs1.getString(1)) > 45.00) ||(rs1.getString(2).equals("16") && Double.parseDouble(rs1.getString(1)) > 1.0)){
								   TestCount = TestCount + 1;
								} 
							}while(rs1.next());
					    	if(TestCount > 0){
					    		TestUnsafe = TestUnsafe + 1;
					    	}else{
					    		TestSafe = TestSafe + 1;
					    	}
					    }
						rs1.close();
						ps1.close();
					}						
					rs3.close();
					ps3.close(); 
					if(rs2.getString(1) != null && rs2.getString(1).equals("03")){
                    	query4="SELECT COUNT(DISTINCT HAB_CODE) FROM RWS_ASSET_HAB_TBL WHERE ASSET_CODE=?";
						ps4=conn.prepareStatement(query4);
						ps4.setString(1,rs2.getString(4));
						rs4=ps4.executeQuery();			
						while(rs4.next()){
							noOfHabs = rs4.getInt(1);
						}						
						rs4.close();
						ps4.close();
					}
					query5="SELECT DISTINCT ASSET_CODE, NVl(COUNT(DISTINCT ASSET_COMP_CODE),'0') FROM RWS_ASSET_COMPONENT_REPAIR_TBL WHERE ASSET_CODE=? GROUP BY ASSET_CODE";
					ps5=conn.prepareStatement(query5);
					ps5.setString(1,rs2.getString(4));
					rs5=ps5.executeQuery();			
					while(rs5.next()){
						ACompCount = rs5.getString(2);
						ACode = rs5.getString(1);
					}						
					rs5.close();
					ps5.close();
					 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                     } else {
                         style = "gridbg2";
                     }
					 String AssetStatus = (rs2.getString(9) != null && rs2.getString(9).equals("1"))? "Working" : ((rs2.getString(9) != null && rs2.getString(9).equals("2"))? "Not Working" : "-");
					
			%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(2)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(3)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(4)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(5)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(6)%> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(7)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(8)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=noOfHabs%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks1('./rws_abstract_report_his_drill2.jsp?mode=TestSafe&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=Hcode%>&hName=<%=Hname%>&schemeType=<%=rs2.getString(2)%>&assetName=<%=rs2.getString(3)%>&assetCode=<%=rs2.getString(4)%>&status=<%=AssetStatus%>&schemeType=<%=rs2.getString(2)%>')"><%=TestSafe%></a> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks1('./rws_abstract_report_his_drill2.jsp?mode=TestUnsafe&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=Hcode%>&hName=<%=Hname%>&schemeType=<%=rs2.getString(2)%>&assetName=<%=rs2.getString(3)%>&assetCode=<%=rs2.getString(4)%>&status=<%=AssetStatus%>&schemeType=<%=rs2.getString(2)%>')"><%=TestUnsafe%></a> </td>
	 				<td class="<%=style%>" style="text-align: left;"> <%=AssetStatus%> </td>	 				
	 				<td class="<%=style%>" style="text-align: center;"> <%if (ACompCount != null && !ACompCount.equals("0")){ %><a href="#" onclick="viewWorks1('./rws_abstract_report_his_drill2.jsp?mode=CompnentDetails&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=Hcode%>&hName=<%=Hname%>&schemeType=<%=rs2.getString(2)%>&assetName=<%=rs2.getString(3)%>&assetCode=<%=ACode%>&status=<%=AssetStatus%>&schemeType=<%=rs2.getString(2)%>')"><%=ACompCount%></a><%}else{ %><%=ACompCount%><%} %> </td>
					<% if (rs2.getString(4) != null){
	 					query4="SELECT DISTINCT DBMS_LOB.GETLENGTH(ASSET_IMAGE), NVL(ASSET_LAT,'0.0'), NVL(ASSET_LON,'0.0'), NVL(INSPECTED_BY,'-'), TO_CHAR(UPDATE_DATE,'DD-MM-YYYY') FROM RWS_ASSET_IMAGE_TBL WHERE ASSET_CODE=?";
			 				ps4=conn.prepareStatement(query4);
							ps4.setString(1,rs2.getString(4));
							rs4=ps4.executeQuery();			
							if(!rs4.next()){ 
					%>
						<td class="<%=style%>" style="text-align: center;">  </td>
	 					<td class="<%=style%>" style="text-align: center;">  </td>
	 					<td class="<%=style%>" style="text-align: center;">  </td>
	 					<td class="<%=style%>" style="text-align: center;">  </td>
						<td class="<%=style%>" style="text-align: left;">-</td>	 
								
					<%	}else{
								do{
								if(rs4.getInt(1) != 0){
									if(Mode != null && (Mode.equals("NotFunctioning") || Mode.equals("Functioning") || Mode.equals("Total"))){
					%>	 	
						<td class="<%=style%>" style="text-align: center;"> <%=rs4.getString(4)%> </td>
	 					<td class="<%=style%>" style="text-align: center;"> <%=rs4.getString(5)%> </td>
	 					<td class="<%=style%>" style="text-align: center;"> <%=rs4.getString(2)%> </td>
	 					<td class="<%=style%>" style="text-align: center;"> <%=rs4.getString(3)%> </td>	 							
	 					<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img	src="../../masters/image.jsp?imgID=<%=rs2.getString(4)%>" width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?imgID=<%=rs2.getString(4)%>" width="350px" height="230px" /></span></a></td>
	 				<%}else{%>	 	
					<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(10)%> </td>
 					<td class="<%=style%>" style="text-align: center;"> <%=rs2.getString(11)%> </td>
 					<td class="<%=style%>" style="text-align: center;"> <%=rs4.getString(2)%> </td>
 					<td class="<%=style%>" style="text-align: center;"> <%=rs4.getString(3)%> </td>	 							
 					<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img	src="../../masters/image.jsp?imgID=<%=rs2.getString(4)%>" width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?imgID=<%=rs2.getString(4)%>" width="350px" height="230px" /></span></a></td>
 				<%}}else{ %>
	 					<td class="<%=style%>" style="text-align: center;"> - </td>
	 					<td class="<%=style%>" style="text-align: center;"> - </td>
	 					<td class="<%=style%>" style="text-align: center;"> - </td>
	 					<td class="<%=style%>" style="text-align: center;"> - </td>
						<td class="<%=style%>" style="text-align: left;">-</td>	 				
 					<%} }while(rs4.next());}rs4.close(); ps4.close();}else{ %>
 						<td class="<%=style%>" style="text-align: center;"> - </td>
	 					<td class="<%=style%>" style="text-align: center;"> - </td>
	 					<td class="<%=style%>" style="text-align: center;"> - </td>
	 					<td class="<%=style%>" style="text-align: center;"> - </td>
	 					<td class="<%=style%>" style="text-align: left;"> - </td>	 				
	 				<%} %>  
	 			</tr>	
				<% 	         styleCount++;							
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