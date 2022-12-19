<%@ include file="/commons/rws_header1.jsp"%>

<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html>
<html>   
   <head>
		<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
		<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
		<script language="JavaScript">
			function viewWorks(URL){
				var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
				if(URL!=""){
					myNewWin = window.open(URL,'newWinddow',popFeatures);
					myNewWin.focus();	
				}	
			}
			
			function wopen(url, name, w, h){
			// Fudge factors for window decoration space.
			 // In my tests these work well on all platforms & browsers.
				w += 32;
				h += 96;
			 	var win = window.open(url,
			  	name, 
				  'width=' + w + ', height=' + h + ', ' +
				  'location=yes, menubar=no, ' +
				  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');	 
				 win.focus();
			}
		</script>
		<style>
			.thumbnail{
				position: relative;
				z-index: 0;
			}
			
			.thumbnail:hover{
				z-index: 50;
				cursor:pointer;
			}
			
			.thumbnail span{ /*CSS for enlarged image*/
				position:absolute;
				left: -9999px;
				background-color:#eae9d4;
				padding: 10px;
				font-family: 'Droid Sans', sans-serif;
				font-size:.9em;
				text-align: center; 
				color: #495a62; 
				-webkit-box-shadow: 0 0 20px rgba(0,0,0, .75));
				-moz-box-shadow: 0 0 20px rgba(0,0,0, .75);
				box-shadow: 0 0 20px rgba(0,0,0, .75);
				-webkit-border-radius: 8px; 
				-moz-border-radius: 8px; 
				border-radius:8px;
			}
			
			.thumbnail span img{ 
				padding:2px;
				background:#ccc;
			}
			
			.thumbnail:hover span{ 
				top: -280px; 
				left: -250px; 
			}
		</style>
	</head>
<body>
	<form>
	<%
	    int slno=0;
	    String qry="", str="";
	    int styleCount=0;
	    String style="";
	    String Comp_lat = "0", Comp_long = "0", Comp_Location="--";
	    int totalClippings=0;
	    String dcode=request.getParameter("dcode");
	    //System.out.println("dcode"+dcode);
	    String dname=request.getParameter("dname");
	    //System.out.println("dname"+dname);
	    String fromdate=request.getParameter("fromdate");
	    //System.out.println("fromdate"+fromdate);
	    String todate=request.getParameter("todate");
	    //System.out.println("todate"+todate);
	    String status=request.getParameter("status");
	    //System.out.println("status"+status);
		String mcode=request.getParameter("mcode");
		String habcode=request.getParameter("habcode");
		  //System.out.println("mcode"+mcode);
		String mname=request.getParameter("mname");
		  //System.out.println("mname"+mname);
	
		
	    
	
	   	%>
		<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
		<caption>
		
		<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
		<tr align="center">
		
			
			
			</tr></table>
		
			<table border=0 rules=none style="border-collapse:collapse" align = "right">
			
				
		<tr align="right">
		
		<td ><a href="#" onClick="window.close();">Close</a></td>
		
		 
		</tr>  
		
		
		</table>
		</caption>
		
		
			
	   	
	   <table width="75%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>Residual Chlorine Action Taken </b></td>
			
			</tr>
	  
		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/</br>Habitation Name</td>
	    <td class=gridhdbg>Asset Code</td>
	    
	    <td class=gridhdbg>Local Person Name</td>
	    <td class=gridhdbg>Latitude</td>
	    <td class=gridhdbg>Longitude</td>
	    <td class=gridhdbg>Location</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>RC PPM Value</td>
	    <td class=gridhdbg>Action Taken</td>
	    <td class=gridhdbg>Date Of Action</td>
	    <td class=gridhdbg>Remarks</td>
	    <td class=gridhdbg>Image</td>
	    <td class=gridhdbg>Map Location</td>
	    
	   
	   
		
	       </tr>
	       
	    <%
	       try{   	 
	    	   
				if(status.equals("rcA")){
				   	str="SELECT DISTINCT PANCH_NAME,NVL(B.ASSET_CODE,'-'),NVL(DATA_COLLECTOR_NAME,'-'),NVL(C.LOCATION,'-'), B.LOC_LAT, B.LOC_LON,PPM_VALUE,NVL(TO_CHAR(ACTION_DATE,'DD/MM/YYYY'),'-'),NVL(TO_CHAR(ACTION_ENTERED_DATE,'DD/MM/YYYY'),'-'),NVL(B.REMARKS,'-') ,NVL(C.HABITATION_CODE,'-'),NVL(TO_CHAR(TEST_DATE,'DD/MM/YYYY'),'-'), NVL(B.MESG_ID,'0'), NVL(B.SOURCE_CODE,'-') FROM RWS_PANCHAYAT_RAJ_TBL A,RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL C WHERE A.PANCH_CODE=C.HABITATION_CODE AND TO_CHAR(B.SMS_MOBILE) =C.MOBILE AND PPM_VALUE<0.2 AND  C.HABITATION_CODE='"+habcode+"' AND (ACTION_ENTERED_DATE IS NOT NULL OR ACTION_ENTERED_DATE <>'') AND TEST_DATE BETWEEN TO_DATE('"+fromdate+"','dd/mm/yyyy') AND TO_DATE('"+todate+"','dd/mm/yyyy')+1";
				}
				else if(status.equals("rcN")){
					str="SELECT DISTINCT PANCH_NAME,NVL(B.ASSET_CODE,'-'),NVL(DATA_COLLECTOR_NAME,'-'),NVL(C.LOCATION,'-'), B.LOC_LAT, B.LOC_LON,PPM_VALUE,NVL(TO_CHAR(ACTION_DATE,'DD/MM/YYYY'),'-'),NVL(TO_CHAR(ACTION_ENTERED_DATE,'DD/MM/YYYY'),'-'),NVL(B.REMARKS,'-') ,NVL(C.HABITATION_CODE,'-'),NVL(TO_CHAR(TEST_DATE,'DD/MM/YYYY'),'-'), NVL(B.MESG_ID,'0'), NVL(B.SOURCE_CODE,'-') FROM RWS_PANCHAYAT_RAJ_TBL A,RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL C WHERE A.PANCH_CODE=C.HABITATION_CODE AND TO_CHAR(B.SMS_MOBILE) =C.MOBILE AND PPM_VALUE<0.2 AND  C.HABITATION_CODE='"+habcode+"' AND (ACTION_ENTERED_DATE IS NULL OR ACTION_ENTERED_DATE='') AND TEST_DATE BETWEEN TO_DATE('"+fromdate+"','dd/mm/yyyy') AND TO_DATE('"+todate+"','dd/mm/yyyy')+1";
				}
				else if(status.equals("rcT")){
					str="SELECT  DISTINCT PANCH_NAME,NVL(B.ASSET_CODE,'-'),NVL(DATA_COLLECTOR_NAME,'-'),NVL(C.LOCATION,'-'), B.LOC_LAT, B.LOC_LON,PPM_VALUE,NVL(TO_CHAR(ACTION_DATE,'DD/MM/YYYY'),'-'),NVL(TO_CHAR(ACTION_ENTERED_DATE,'DD/MM/YYYY'),'-'),NVL(B.REMARKS,'-') ,NVL(C.HABITATION_CODE,'-'),NVL(TO_CHAR(TEST_DATE,'DD/MM/YYYY'),'-'), NVL(B.MESG_ID,'0'), NVL(B.SOURCE_CODE,'-') FROM RWS_PANCHAYAT_RAJ_TBL A,RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL C WHERE A.PANCH_CODE=C.HABITATION_CODE AND TO_CHAR(B.SMS_MOBILE) =C.MOBILE AND PPM_VALUE<0.2 AND  C.HABITATION_CODE='"+habcode+"' AND  TEST_DATE BETWEEN TO_DATE('"+fromdate+"','dd/mm/yyyy') AND TO_DATE('"+todate+"','dd/mm/yyyy')+1";
				}
					
				//System.out.println(str);
					 
		   
			  ps=conn.prepareStatement(str);
			  rs=ps.executeQuery();
		 	  while(rs.next()){				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
	   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(11)%>/</br><%=rs.getString(1)%></td>	              
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>				  
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				  <% if(rs.getString(6) != null && rs.getString(5) != null){%>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(5) != null?rs.getString(5):0.0%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(6) != null?rs.getString(6):0.0%></td>
				  <%}else{
					   if(rs.getString(2) != null || !rs.getString(2).equals('-') && rs.getString(14) != null || !rs.getString(14).equals('-')){	
						  	String qry1="SELECT COMPO_LAT, COMPO_LON FROM RWS_AST_COMP_ALL_IMG_VIEW WHERE DCODE=SUBSTR('"+rs.getString(11)+"',1,2) AND ASSET_CODE='"+rs.getString(2)+"' AND SOURCE_CODE='"+rs.getString(14)+"'";
						  	PreparedStatement ps2= conn.prepareStatement(qry1);
						 	ResultSet rs2 = ps2.executeQuery();
						 	if(!rs2.next()){
				%>
				<td class="<%=style%> "style="text-align: left;"><%=rs.getString(5) != null?rs.getString(5):0.0%></td>
				<td class="<%=style%> "style="text-align: left;"><%=rs.getString(6) != null?rs.getString(6):0.0%></td>				  
				<%			 		}else{%>
				<td class="<%=style%> "style="text-align: left;"><%=rs2.getString(1) != null?rs2.getString(1):0.0%></td>
				<td class="<%=style%> "style="text-align: left;"><%=rs2.getString(2) != null?rs2.getString(2):0.0%></td>						
				<%		 		}
						 }
				      }
				 %>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(12)%></td>
				  <td class="<%=style%> "style="text-align: right;"><%=rs.getDouble(7)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(8)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(9)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(10)%></td>				  
				  <% if(rs.getString(2) != null || !rs.getString(2).equals('-') && rs.getString(14) != null || !rs.getString(14).equals('-')){	
						  	qry="SELECT ASSET_CODE, ASSET_NAME, SOURCE_CODE, NVl(LOCATION,'--'), COMPO_LAT, COMPO_LON, IMG_SIZE FROM RWS_AST_COMP_ALL_IMG_VIEW WHERE DCODE=SUBSTR('"+rs.getString(11)+"',1,2) AND ASSET_CODE='"+rs.getString(2)+"' AND SOURCE_CODE='"+rs.getString(14)+"'";
						  	//System.out.println(qry);
					   		PreparedStatement ps1= conn.prepareStatement(qry);
						 	ResultSet rs1 = ps1.executeQuery();
						 	if(!rs1.next()){
						 		Comp_Location="--";
						 		Comp_lat="0";
						 		Comp_long="0";
				  %>				  
				  <td class="<%=style%> "></td>
				  <td class="<%=style%> "style="text-align: right;"><%if(rs.getString(5) != null && rs.getString(6) != null){ %><a href='#' onclick='javascript:window.open("rws_rc_detail_report_view_map.jsp?latCode=<%=rs.getString(5)%>&longCode=<%=rs.getString(6)%>&comp_LatCode=<%=Comp_lat %>&comp_LongCode=<%=Comp_long %>&location=<%=rs.getString(4)%>&comp_Location=<%=Comp_Location %>", "_blank", "scrollbars=1,resizable=1,height=300,width=450");' title='Pop Up'>View</a><%}%>
				  <%
						 	}else{
						 	do{
						 		if( rs1.getString(4)== null){
						 			Comp_Location="--";
						 		}else{
						 			Comp_Location = rs1.getString(4);							 		
						 		}
						 		if(rs1.getString(5) == null){
						 			Comp_lat="0";
						 		}else{
						 			Comp_lat = rs1.getString(5);							 		
						 		}
						 		if(rs1.getString(6) == null){
									Comp_long="0";
						 		}else{
						 			Comp_long = rs1.getString(6);									
						 		}
						 		//System.out.println(Comp_lat + " " + Comp_lat +" "+Comp_Location);
						 		int b=rs1.getInt("IMG_SIZE");					        	
				  %>
				  <td class="<%=style%> "><%if(b != 0){ %><a class="thumbnail"  href="#"><img src="../../masters/image.jsp?assetCode=<%=rs1.getString("ASSET_CODE")%>&imgID=<%=rs1.getString("SOURCE_CODE")%>&mode=component"  width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?assetCode=<%=rs1.getString("ASSET_CODE")%>&imgID=<%=rs1.getString("SOURCE_CODE")%>&mode=component"/></span></a><%}%></td>
				  <td class="<%=style%> "style="text-align: right;"><%if((rs.getString(5) != null && rs.getString(6) != null) || (rs1.getString(5) != null && rs1.getString(6) != null)){ %><a href='#' onclick='javascript:window.open("rws_rc_detail_report_view_map.jsp?latCode=<%=rs.getString(5)%>&longCode=<%=rs.getString(6)%>&comp_LatCode=<%=Comp_lat %>&comp_LongCode=<%=Comp_long %>&location=<%=rs.getString(4)%>&comp_Location=<%=Comp_Location %>", "_blank", "scrollbars=1,resizable=1,height=300,width=450");' title='Pop Up'>View</a><%} }while(rs1.next());}%></td>	 
					
			   </tr>
	              
	              
	              
	              
			    <%
		   }
			
			%> 
			<% }  
		   } catch(Exception e)
		   {
		   e.printStackTrace();
		   }
		   finally{
			  
		   conn.close();
		   }
		   %>
		
	    
	</table>
		</table>	
</form>
</body>
</html>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>