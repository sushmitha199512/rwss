<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	String SourceCode = request.getParameter("sourceCode");
    String AssetCode = request.getParameter("assetCode"); 
    String SourceName = request.getParameter("sourceName");
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
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Abstract Report For Schemes</title>	
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
				<th align="center" class="gridhdbg" colspan="25">Inspection Abstract Report For Schemes (&ensp;Source Code:- <%=SourceCode %>
						,&ensp;Source Name:- <%=SourceName %>
						,&ensp;Asset Code:- <%=AssetCode %>
						,&ensp;Working Status :- <%=Status %> 
						,&ensp;District :- <%=Dname %>	
					<%if (Mname != null && !Mname.equals("null")){ %>
						,&ensp;Mandal :- <%=Mname %>  				
					<%} if (Pname != null && !Pname.equals("null")){ %> 
						,&ensp;Panchyat :- <%=Pname %>
					<%} if (Vname != null && !Vname.equals("null")){ %>
						,&ensp;Village :- <%=Vname %>
					<%} if (Hname != null && !Hname.equals("null")){ %>
					 	,&ensp;Habitation :- <%=Hname %>
					<%} %> )
				</th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
				<th class="gridhdbg" rowspan="2"> Source Code </th>   
				<th class="gridhdbg" rowspan="2"> Source Name </th>
			    <th class="gridhdbg" rowspan="2"> Location </th>
			    <th class="gridhdbg" rowspan="2"> Test Date </th>
			    <th class="gridhdbg" colspan="1"> Brackish </th>			   
			    <th class="gridhdbg" colspan="1"> Fluoride (As F) </th>	   
			    <th class="gridhdbg" colspan="1"> Iron (As Fe)</th>			    
			    <th class="gridhdbg" colspan="1"> Nitrate (As NO3)</th>  
			</tr>
			<tr>
				<th class="gridhdbg"> Safe Permissible Value =< 2000 </th>
				<th class="gridhdbg"> Safe Permissible Value =< 1.5 </th>
				<th class="gridhdbg"> Safe Permissible Value =< 1.0 </th>
				<th class="gridhdbg"> Safe Permissible Value =< 45 </th>
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
					query2="SELECT DISTINCT HCODE, HNAME, LOCATION, ACODE FROM (SELECT 'HAND PUMP' AS HNAME, NVL(LOCATION,'-') AS LOCATION,  HP_CODE AS HCODE, ASSET_CODE AS ACODE FROM RWS_HP_SUBCOMP_PARAM_TBL UNION ALL SELECT 'SHALLOW HAND PUMP' AS HNAME, NVL(LOCATION,'-') AS LOCATION,  SHALLOWHP_CODE AS HCODE, ASSET_CODE AS ACODE FROM RWS_SHALLOWHANDPUMPS_TBL) WHERE HCODE=? AND ACODE=? ORDER BY HCODE, ACODE";
					//System.out.println("query 2" + Dcode +"  "+query2);
					ps2=conn.prepareStatement(query2);
					ps2.setString(1,SourceCode);
					ps2.setString(2,AssetCode);					
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
		        <% 	    	styleCount++;
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