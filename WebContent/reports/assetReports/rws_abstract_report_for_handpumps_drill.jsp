<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page import="java.text.DecimalFormat.*, java.util.Date,  java.util.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat ndf = new DecimalFormat("####.##");
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
	<title>Abstract Report For Hand Pumps</title>	
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
				<th align="center" class="gridhdbg" colspan="15">Inspection Abstract Report For Hand Pumps (&ensp;District :- <%=Dname %>	
					<%if (Mode != null && Mode.equals("Panchyat")){ %>
						And&ensp;Mandal :- <%=Mname %>  				
					<%} else if (Mode != null && Mode.equals("Village")){ %> 
						,&ensp;Mandal :- <%=Mname %> 
						And&ensp;Panchyat :- <%=Pname %>
					<%} else if (Mode != null && Mode.equals("Habitation")){ %>
						,&ensp;Mandal :- <%=Mname %> 
						,&ensp;Panchyat :- <%=Pname %>
						And &ensp;Village :- <%=Vname %>
					<%} %> 	)</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
			    <th class="gridhdbg" rowspan="2"> <%if (Mode != null && Mode.equals("Mandal")){ %>Mandal<%}else if (Mode != null && Mode.equals("Panchyat")){ %> Panchyat <%} else if (Mode != null && Mode.equals("Village")){ %> Village <%} else if (Mode != null && Mode.equals("Habitation")){ %>Habitation<%} %> </th>
			    <th class="gridhdbg" rowspan="2"> Borewells (HP &amp; SHP) </th>
			    <th class="gridhdbg" rowspan="2"> Having Platforms </th>
			    <th class="gridhdbg" rowspan="2"> Soakpits </th>
			    <th class="gridhdbg" colspan="8"> Inspected </th>
			    <th class="gridhdbg" rowspan="2"> Functioning </th>			   
			    <th class="gridhdbg" rowspan="2"> Not Functioning </th>
			   <!--  <th class="gridhdbg"colspan="2"> As per Test Results </th> -->
			</tr>
			<tr>
				<th class="gridhdbg"> Within 1 month </th>
				<th class="gridhdbg"> % (<1 month/Borewells) </th>
				<th class="gridhdbg"> 1-2 months </th>
				<th class="gridhdbg"> 2-3 months </th>
				<th class="gridhdbg"> 3-6 months </th>
				<th class="gridhdbg"> 6-12 months </th>
				<th class="gridhdbg"> Total </th>
				<th class="gridhdbg">% (Total/Borewells)</th>
				
				<!-- <th class="gridhdbg"> Safe </th>
				<th class="gridhdbg"> Un-safe </th> -->
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
				<!-- <th class="gridhdbg"> 13 </th>	 -->										
			</tr>
		</thead>
		<tbody>		
			<%	String query1="",query2="",query3="",query4="",query33="",query44="",query5="",query6="",query7="";
			PreparedStatement  ps1=null,ps2=null,ps3=null,ps4=null,ps33=null,ps44=null,ps5=null,ps6=null,ps7=null;
			ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs33=null,rs44=null,rs5=null,rs6=null,rs7=null;
			String style="-", Temp="-";
		    int styleCount=1, hpCount=0,  havingPlatform=0, soakpits=0, withInOneMonth=0, oneTwoMonth=0, twoThreeMonth=0, moreThan3Month=0,moreThanSixMonths=0, functioning=0, notFunctioning=0, safe=0, unSafe=0, totalhpCount=0, totalhavingPlatform=0, totalsoakpits=0, totalWithInOneMonth=0, totalOneTwoMonth=0, totalTwoThreeMonth=0, totalMoreThan3Month=0, totalMoreThan6Month=0, totalHori=0, totalVert=0, totalFunctioningHandpumps=0, totalNotFunctioningHandpumps=0, totalSafeHandpumps=0, totalUnSafeHandpumps=0;
			try{
				
			  /* query1="SELECT DISTINCT B.SOURCE_CODE AS SOURCE_CODE, NVL(A.TESTING_PARAMETER_VALUE,'0.0') AS TESTING_PARAMETER_VALUE, A.TESTING_PARAMETER_CODE  AS TESTING_PARAMETER_CODE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND  A.TESTING_PARAMETER_CODE IN (05,13,15,16) AND (B.SOURCE_CODE, B.PREPARED_ON) IN (SELECT SOURCE_CODE, MAX(PREPARED_ON) FROM RWS_WQ_TEST_RESULTS_TBL GROUP BY SOURCE_CODE)";
				    ps1=conn.prepareStatement(query1);
				    rs1=ps1.executeQuery();
				    Hashtable contaminatedSource = new Hashtable();					   
					while(rs1.next()){
					   if((rs1.getString(3).equals("05") &&  Double.parseDouble(rs1.getString(2)) > 2000.00) || (rs1.getString(3).equals("13") && Double.parseDouble(rs1.getString(2)) > 1.5) || (rs1.getString(3).equals("15") && Double.parseDouble(rs1.getString(2)) > 45.00) ||(rs1.getString(3).equals("16") && Double.parseDouble(rs1.getString(2)) > 1.0)){
				    		//System.out.println(rs1.getString(3) +"  "+Double.parseDouble(rs1.getString(2)));
				    		contaminatedSource.put(rs1.getString(1),rs1.getString(1));
				    	}
							
					}
				rs1.close();
				ps1.close();   */
				   
				if (Mode != null && Mode.equals("Mandal")){
					query2="SELECT MCODE, COUNT(DISTINCT HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,6,2) AS MCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C  WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,6,2) AS MCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"') GROUP BY MCODE ORDER BY MCODE";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query2="SELECT PCODE, COUNT(DISTINCT HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,13,2) AS PCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C  WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,13,2) AS PCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"') GROUP BY PCODE ORDER BY PCODE";
				} else if (Mode != null && Mode.equals("Village")){ 
					query2="SELECT VCODE, COUNT(DISTINCT HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,8,3) AS VCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C  WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,8,3) AS VCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"') GROUP BY VCODE ORDER BY VCODE";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query2="SELECT HCODE, COUNT(DISTINCT HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,1,16) AS HCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C  WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP_CODE,8,3)='"+Vcode+"' UNION ALL SELECT HP.HAB_CODE AS HCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP.HAB_CODE,8,3)='"+Vcode+"') GROUP BY HCODE ORDER BY HCODE";
				} 
				//	System.out.println(Dcode + query2);
					ps2=conn.prepareStatement(query2);
					rs2=ps2.executeQuery();			
					Hashtable totalHpCount = new Hashtable();
					while(rs2.next()){
						totalHpCount.put(rs2.getString(1),rs2.getInt(2)); 
					}
				rs2.close();
				ps2.close();
				if (Mode != null && Mode.equals("Mandal")){
					query3="SELECT MCODE, COUNT(DISTINCT HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,6,2) AS MCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.PLATFORM_EXISTING='Y' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,6,2) AS MCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE  AND HP.PLATFORM_EXISTING='Y' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"') GROUP BY MCODE ORDER BY MCODE";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query3="SELECT PCODE, COUNT(DISTINCT HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,13,2) AS PCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.PLATFORM_EXISTING='Y' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,13,2) AS PCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.PLATFORM_EXISTING='Y' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"') GROUP BY PCODE ORDER BY PCODE";
				} else if (Mode != null && Mode.equals("Village")){ 
					query3="SELECT VCODE, COUNT(DISTINCT HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,8,3) AS VCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.PLATFORM_EXISTING='Y' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,8,3) AS VCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.PLATFORM_EXISTING='Y' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"') GROUP BY VCODE ORDER BY VCODE";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query3="SELECT HCODE, COUNT(DISTINCT HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,1,16) AS HCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.PLATFORM_EXISTING='Y' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP_CODE,8,3)='"+Vcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,1,16) AS HCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.PLATFORM_EXISTING='Y' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP.HAB_CODE,8,3)='"+Vcode+"') GROUP BY HCODE ORDER BY HCODE";
				} 
					//System.out.println(Dcode + query3);
					ps3=conn.prepareStatement(query3);
					rs3=ps3.executeQuery();			
					Hashtable totalHavingPlatform = new Hashtable();
					while(rs3.next()){
						totalHavingPlatform.put(rs3.getString(1),rs3.getInt(2)); 
					}
				rs3.close();
				ps3.close();
				if (Mode != null && Mode.equals("Mandal")){
					query4="SELECT MCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,6,2) AS MCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C  WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.SOAK_PIT='Y' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,6,2) AS MCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.SOAK_PIT='Y' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"') GROUP BY MCODE ORDER BY MCODE";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query4="SELECT PCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,13,2) AS PCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C  WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.SOAK_PIT='Y' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,13,2) AS PCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.SOAK_PIT='Y' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"') GROUP BY PCODE ORDER BY PCODE";
				} else if (Mode != null && Mode.equals("Village")){ 
					query4="SELECT VCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,8,3) AS VCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C  WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.SOAK_PIT='Y' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,8,3) AS VCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.SOAK_PIT='Y' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"') GROUP BY VCODE ORDER BY VCODE";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query4="SELECT HCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,1,16) AS HCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C  WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.SOAK_PIT='Y' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP_CODE,8,3)='"+Vcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,1,16) AS HCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.SOAK_PIT='Y' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP.HAB_CODE,8,3)='"+Vcode+"') GROUP BY HCODE ORDER BY HCODE";
				} 
				//	System.out.println(Dcode + query4);
					ps4=conn.prepareStatement(query4);
					rs4=ps4.executeQuery();			
					Hashtable totalSoakpits = new Hashtable();
					while(rs4.next()){
						totalSoakpits.put(rs4.getString(1),rs4.getInt(2)); 
					}			
				rs4.close();
				ps4.close();
				if (Mode != null && Mode.equals("Mandal")){
					query33="SELECT MCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,6,2) AS MCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='W' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,6,2) AS MCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.STATUS='W' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"') GROUP BY MCODE ORDER BY MCODE";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query33="SELECT PCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,13,2) AS PCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='W' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,13,2) AS PCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.STATUS='W' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"') GROUP BY PCODE ORDER BY PCODE";
				} else if (Mode != null && Mode.equals("Village")){ 
					query33="SELECT VCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,8,3) AS VCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='W' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,8,3) AS VCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.STATUS='W' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"') GROUP BY VCODE ORDER BY VCODE";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query33="SELECT HCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,1,16) AS HCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='W' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP_CODE,8,3)='"+Vcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,1,16) AS HCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.STATUS='W' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP.HAB_CODE,8,3)='"+Vcode+"') GROUP BY HCODE ORDER BY HCODE";
				} 
				//System.out.println(Dcode + query33);
				ps33=conn.prepareStatement(query33);
				rs33=ps33.executeQuery();			
				Hashtable totalFunctioning = new Hashtable();
				while(rs33.next()){
					totalFunctioning.put(rs33.getString(1),rs33.getInt(2)); 
				}
				rs33.close();
				ps33.close();
				if (Mode != null && Mode.equals("Mandal")){
					query44="SELECT MCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,6,2) AS MCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='N' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,6,2) AS MCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP.HAB_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='N' AND HP.HAB_CODE='"+Dcode+"') GROUP BY MCODE ORDER BY MCODE";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query44="SELECT PCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,13,2) AS PCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='N' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,13,2) AS PCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.STATUS='N' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"') GROUP BY PCODE ORDER BY PCODE";
				} else if (Mode != null && Mode.equals("Village")){ 
					query44="SELECT VCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,8,3) AS VCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='N' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,8,3) AS VCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.STATUS='N' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"') GROUP BY VCODE ORDER BY VCODE";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query44="SELECT HCODE, COUNT( HPCOUNT) FROM (SELECT SUBSTR(HP_CODE,1,16) AS HCODE, HP_CODE AS HPCOUNT FROM RWS_HP_SUBCOMP_PARAM_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND SUBSTR(HP_CODE,1,16)=C.PANCH_CODE AND HP.STATUS='N' AND SUBSTR(HP_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP_CODE,8,3)='"+Vcode+"' UNION ALL SELECT SUBSTR(HP.HAB_CODE,1,16) AS HCODE, SHALLOWHP_CODE AS HPCOUNT FROM RWS_SHALLOWHANDPUMPS_TBL HP, RWS_ASSET_MAST_TBL AM,RWS_COMPLETE_HAB_VIEW C WHERE HP.ASSET_CODE=AM.ASSET_CODE AND HP.HAB_CODE=C.PANCH_CODE AND HP.STATUS='N' AND SUBSTR(HP.HAB_CODE,1,2)='"+Dcode+"' AND SUBSTR(HP.HAB_CODE,6,2)='"+Mcode+"' AND SUBSTR(HP.HAB_CODE,13,2)='"+Pcode+"' AND SUBSTR(HP.HAB_CODE,8,3)='"+Vcode+"') GROUP BY HCODE ORDER BY HCODE";
				} 
					//System.out.println(Dcode + query44);
					ps44=conn.prepareStatement(query44);
					rs44=ps44.executeQuery();			
					Hashtable totalNotFunctioning = new Hashtable();
					while(rs44.next()){
						totalNotFunctioning.put(rs44.getString(1),rs44.getInt(2)); 
					}			
				rs44.close();
				ps44.close(); 
				if (Mode != null && Mode.equals("Mandal")){
					query5="SELECT MCODE, MNAME FROM RWS_MANDAL_TBL WHERE DCODE='"+Dcode+"' ORDER BY MNAME";
				}else if (Mode != null && Mode.equals("Panchyat")){  
					query5="SELECT PCODE, PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE='"+Dcode+"' AND MCODE='"+Mcode+"' ORDER BY PNAME";
				} else if (Mode != null && Mode.equals("Village")){ 
					query5="SELECT VCODE, VNAME FROM RWS_VILLAGE_TBL WHERE DCODE='"+Dcode+"' AND MCODE='"+Mcode+"' AND PCODE='"+Pcode+"' ORDER BY VNAME";
				} else if (Mode != null && Mode.equals("Habitation")){ 
					query5="SELECT PANCH_CODE, PANCH_NAME FROM RWS_COMPLETE_HAB_VIEW WHERE DCODE='"+Dcode+"' AND MCODE='"+Mcode+"' AND PCODE='"+Pcode+"' AND VCODE='"+Vcode+"' ORDER BY PANCH_NAME";
				} 	
				//System.out.println(Dcode + query5);
				ps5=conn.prepareStatement(query5);
				rs5=ps5.executeQuery();			
				while(rs5.next()){
					withInOneMonth=0;
					oneTwoMonth=0;
					twoThreeMonth=0;
					moreThan3Month=0;
					moreThanSixMonths=0;
					if(totalHpCount.get(rs5.getString(1)) != null){
						hpCount =(Integer) totalHpCount.get(rs5.getString(1));
					}else{
						hpCount = 0;
					}
					if(totalHavingPlatform.get(rs5.getString(1)) != null){
						havingPlatform =(Integer) totalHavingPlatform.get(rs5.getString(1));
					}else{
						havingPlatform = 0;
					}
					if(totalSoakpits.get(rs5.getString(1)) != null){
						soakpits =(Integer) totalSoakpits.get(rs5.getString(1));
					}else{
						soakpits = 0;
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
					/* query6="SELECT DISTINCT SOURCECODE FROM (SELECT HP_CODE AS SOURCECODE FROM RWS_HP_SUBCOMP_PARAM_TBL WHERE SUBSTR(HP_CODE,1,16) IN (SELECT PANCH_CODE FROM RWS_COMPLETE_HAB_VIEW) UNION ALL SELECT SHALLOWHP_CODE AS SOURCECODE FROM RWS_SHALLOWHANDPUMPS_TBL WHERE SUBSTR(HP.HAB_CODE,1,16) IN (SELECT PANCH_CODE FROM RWS_COMPLETE_HAB_VIEW))";
					if (Mode != null && Mode.equals("Mandal")){
						query6 +=" WHERE SUBSTR(SOURCECODE,1,2)='"+Dcode+"' AND SUBSTR(SOURCECODE,6,2)='"+rs5.getString(1)+"'";
					}else if (Mode != null && Mode.equals("Panchyat")){  
						query6 +=" WHERE SUBSTR(SOURCECODE,1,2)='"+Dcode+"' AND SUBSTR(SOURCECODE,6,2)='"+Mcode+"' AND SUBSTR(SOURCECODE,13,2)='"+rs5.getString(1)+"'";
					} else if (Mode != null && Mode.equals("Village")){ 
						query6 +=" WHERE SUBSTR(SOURCECODE,1,2)='"+Dcode+"' AND SUBSTR(SOURCECODE,6,2)='"+Mcode+"' AND SUBSTR(SOURCECODE,13,2)='"+Pcode+"' AND SUBSTR(SOURCECODE,8,3)='"+rs5.getString(1)+"'";
					} else if (Mode != null && Mode.equals("Habitation")){ 
						query6 +=" WHERE SUBSTR(SOURCECODE,1,2)='"+Dcode+"' AND SUBSTR(SOURCECODE,6,2)='"+Mcode+"' AND SUBSTR(SOURCECODE,13,2)='"+Pcode+"' AND SUBSTR(SOURCECODE,8,3)='"+Vcode+"' AND SUBSTR(SOURCECODE,1,16)='"+rs5.getString(1)+"'";
					}
					query6 +=" ORDER BY SOURCECODE";
					//System.out.println(SchemeType + query2);
					ps6=conn.prepareStatement(query6);
					rs6=ps6.executeQuery();			
					while(rs6.next()){
						if(contaminatedSource.get(rs6.getString(1)) != null){
							count = count+1;
						}
					}
					rs6.close();
					ps6.close();	 */	
					unSafe = count;
					safe = hpCount - unSafe;
					query7 ="SELECT TO_DATE(UPDATE_DATE) FROM RWS_HP_SHP_COMP_REPAIR_VIEW  WHERE";
					if (Mode != null && Mode.equals("Mandal")){
						query7 +="   SUBSTR(SOURCE_CODE,1,2)='"+Dcode+"' AND SUBSTR(SOURCE_CODE,6,2)='"+rs5.getString(1)+"'";
					}else if (Mode != null && Mode.equals("Panchyat")){  
						query7 +="  SUBSTR(SOURCE_CODE,1,2)='"+Dcode+"' AND SUBSTR(SOURCE_CODE,6,2)='"+Mcode+"' AND SUBSTR(SOURCE_CODE,13,2)='"+rs5.getString(1)+"'";
					} else if (Mode != null && Mode.equals("Village")){ 
						query7 +="  SUBSTR(SOURCE_CODE,1,2)='"+Dcode+"' AND SUBSTR(SOURCE_CODE,6,2)='"+Mcode+"' AND SUBSTR(SOURCE_CODE,13,2)='"+Pcode+"' AND SUBSTR(SOURCE_CODE,8,3)='"+rs5.getString(1)+"'";
					} else if (Mode != null && Mode.equals("Habitation")){ 
						query7 +="  SUBSTR(SOURCE_CODE,1,2)='"+Dcode+"' AND SUBSTR(SOURCE_CODE,6,2)='"+Mcode+"' AND SUBSTR(SOURCE_CODE,13,2)='"+Pcode+"' AND SUBSTR(SOURCE_CODE,8,3)='"+Vcode+"' AND SUBSTR(SOURCE_CODE,1,16)='"+rs5.getString(1)+"'";
					}
					query7 +="  ORDER BY TO_DATE(UPDATE_DATE)";
					//System.out.println(Dcode + query7);
					ps7=conn.prepareStatement(query7);
					rs7=ps7.executeQuery();			
					while(rs7.next()){
						if(rs7.getString(1) != null && rs7.getDate(1).after(d1) && rs7.getDate(1).before(d)){
							withInOneMonth ++;
						}else if(rs7.getString(1) != null && rs7.getDate(1).after(d2) && rs7.getDate(1).before(d1)){
							oneTwoMonth ++;
						}else if(rs7.getString(1) != null && rs7.getDate(1).after(d3) && rs7.getDate(1).before(d2)){
							twoThreeMonth ++;
						}else if(rs7.getString(1) != null && rs7.getDate(1).after(d6) && rs7.getDate(1).before(d3)){
							moreThan3Month ++;
						}else if(rs7.getString(1) != null && rs7.getDate(1).after(d12) && rs7.getDate(1).before(d6)){
							moreThanSixMonths++;
						}
					}
					rs7.close();
					ps7.close();
					if (styleCount % 2 == 0) {
	                    style = "gridbg1";
	                } else {
	                    style = "gridbg2";
	                }
					totalHori = (withInOneMonth + oneTwoMonth + twoThreeMonth + moreThan3Month+moreThanSixMonths);
					
					double withInOneMonthDob=withInOneMonth;
					 double schemesDob=hpCount;
					 double per=(withInOneMonthDob/schemesDob);
					 per*=100;
					 
					 double totalHoriDob=totalHori;
					 double totPer=(totalHoriDob/schemesDob);
					 totPer*=100;
					 if(schemesDob==0){
						 per=0;
						 totPer=0;
					 }
			%>
				<tr>
					<%if (Mode != null && Mode.equals("Mandal")){ %>
						<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
		 				<td class="<%=style%>" style="text-align: left;"> <a href="rws_abstract_report_for_handpumps_drill.jsp?mode=Panchyat&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>"><%=rs5.getString(2)%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=Borewells&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=hpCount%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=PlatforExisting&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=havingPlatform%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=SoakPit&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=soakpits%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=oneMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=withInOneMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"><%=ndf.format(per)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=twoMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=oneTwoMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=threeMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=twoThreeMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=greaterThan3Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=moreThan3Month%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=greaterThan6Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=moreThanSixMonths%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=HorizontalTotal&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=totalHori%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"><%=ndf.format(totPer)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=Functioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=functioning%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=NotFunctioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=rs5.getString(1)%>&mName=<%=rs5.getString(2)%>')"><%=notFunctioning%></a> </td>
		 				<%-- <td class="<%=style%>" style="text-align: center;"> <%=safe%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=unSafe%> </td>	 --%>
		 				
	 				<%}else if (Mode != null && Mode.equals("Panchyat")){ %>  	
		 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
		 				<td class="<%=style%>" style="text-align: left;"> <a href="rws_abstract_report_for_handpumps_drill.jsp?mode=Village&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>"><%=rs5.getString(2)%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=Borewells&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=hpCount%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=PlatforExisting&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=havingPlatform%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=SoakPit&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=soakpits%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=oneMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=withInOneMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"><%=ndf.format(per)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=twoMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=oneTwoMonth%></a> </td>		 				
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=threeMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=twoThreeMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=greaterThan3Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=moreThan3Month%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=greaterThan6Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=moreThanSixMonths%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=HorizontalTotal&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=totalHori%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"><%=ndf.format(totPer)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=Functioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=functioning%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=NotFunctioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=rs5.getString(1)%>&pName=<%=rs5.getString(2)%>')"><%=notFunctioning%></a> </td>
		 			<%-- 	<td class="<%=style%>" style="text-align: center;"> <%=safe%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=unSafe%> </td>	 --%>
		 				
	 				<%} else if (Mode != null && Mode.equals("Village")){ %> 
		 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
		 				<td class="<%=style%>" style="text-align: left;"> <a href="rws_abstract_report_for_handpumps_drill.jsp?mode=Habitation&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>"><%=rs5.getString(2)%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=Borewells&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=hpCount%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=PlatforExisting&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=havingPlatform%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=SoakPit&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=soakpits%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=oneMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=withInOneMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"><%=ndf.format(per)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=twoMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>)"><%=oneTwoMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=threeMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>)"><%=twoThreeMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=greaterThan3Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=moreThan3Month%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=greaterThan6Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=moreThanSixMonths%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=HorizontalTotal&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=totalHori%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"><%=ndf.format(totPer)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=Functioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=functioning%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=NotFunctioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=rs5.getString(1)%>&vName=<%=rs5.getString(2)%>')"><%=notFunctioning%></a> </td>
		 				<%-- <td class="<%=style%>" style="text-align: center;"> <%=safe%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=unSafe%> </td> --%>	
		 						 				
	 				<%} else if (Mode != null && Mode.equals("Habitation")){ %>
		 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount%></td>
		 				<td class="<%=style%>" style="text-align: left;"> <%=rs5.getString(2)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=Borewells&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=hpCount%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=PlatforExisting&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=havingPlatform%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=SoakPit&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=soakpits%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=oneMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=withInOneMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"><%=ndf.format(per)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=twoMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=oneTwoMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=threeMonth&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=twoThreeMonth%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=greaterThan3Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=moreThan3Month%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=greaterThan6Month&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=moreThanSixMonths%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=HorizontalTotal&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=totalHori%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"><%=ndf.format(totPer)%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=Functioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=functioning%></a> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <a href="#" onclick="viewWorks('./rws_abstract_report_for_handpumps_drill1.jsp?mode=NotFunctioning&dCode=<%=Dcode %>&dName=<%=Dname %>&mCode=<%=Mcode%>&mName=<%=Mname%>&pCode=<%=Pcode%>&pName=<%=Pname%>&vCode=<%=Vcode%>&vName=<%=Vname%>&hCode=<%=rs5.getString(1)%>&hName=<%=rs5.getString(2)%>')"><%=notFunctioning%></a> </td>
		 			<%-- 	<td class="<%=style%>" style="text-align: center;"> <%=safe%> </td>
		 				<td class="<%=style%>" style="text-align: center;"> <%=unSafe%> </td>	 --%>		
	 				<%} %>	 						
	 			</tr>	
				<% 	         styleCount++;
							 totalhpCount+=hpCount; 
							 totalhavingPlatform+=havingPlatform; 
							 totalsoakpits+=soakpits; 
							 totalWithInOneMonth+=withInOneMonth; 
							 totalOneTwoMonth+=oneTwoMonth;
							 totalTwoThreeMonth+=twoThreeMonth; 
							 totalMoreThan3Month+=moreThan3Month; 
							 totalMoreThan6Month+=moreThanSixMonths;
							 totalVert+=totalHori; 
							 totalFunctioningHandpumps+=functioning; 
							 totalNotFunctioningHandpumps+=notFunctioning; 
							/*  totalSafeHandpumps+=safe; 
							 totalUnSafeHandpumps+=unSafe; */
							
						}
				        
				}catch(Exception e){
					e.printStackTrace();
					System.out.println("Exception in rws_abstract_report_for_handpumps_drill.jsp"+e);
					}finally{						
						if(conn!=null){
						conn.close();}
					}
				%>
		</tbody>
		<tfoot>
			<tr>
				<td class="gridhdbg" style="text-align: right;" colspan="2"> Total </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalhpCount%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalhavingPlatform%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalsoakpits%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalWithInOneMonth%> </td>
 				<td class="gridhdbg" style="text-align: center;"> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalOneTwoMonth%> </td> 				
 				<td class="gridhdbg" style="text-align: center;"> <%=totalTwoThreeMonth%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalMoreThan3Month%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalMoreThan6Month%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalVert%> </td>
 				<td class="gridhdbg" style="text-align: center;"> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalFunctioningHandpumps%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalNotFunctioningHandpumps%> </td>	 				
 				<%-- <td class="gridhdbg" style="text-align: center;"> <%=totalSafeHandpumps%> </td>
 				<td class="gridhdbg" style="text-align: center;"> <%=totalUnSafeHandpumps%> </td> --%>
 			</tr>	
		</tfoot>		
	</table>
</body>
</html>