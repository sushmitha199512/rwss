<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat formatter = new DecimalFormat("##,##,##,###");
	String DCode=request.getParameter("Dcode");
	String DName=request.getParameter("Dname");
	String MCode=request.getParameter("Mcode");
	String MName=request.getParameter("Mname");
	String PCode=request.getParameter("Pcode");
	String PName=request.getParameter("Pname");
	String VCode=request.getParameter("Vcode");
	String VName=request.getParameter("Vname");
	String HCode=request.getParameter("Hcode");
	String HName=request.getParameter("Hname");
	String Drill=request.getParameter("drill");
	String Month=request.getParameter("month");
    String startFinYear = request.getParameter("startFinYear");
    String endFinYear = request.getParameter("endFinYear");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Asset Image Capturing Data</title>	
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
</head>
<body>
	<table border="0" cellspacing="0" cellpadding="0" width="80%" style="border-collapse:collapse" align="center">
		<thead>
			<tr align="right">	
				<th colspan="15"><a href="#" onClick="window.close();"><img src="/pred/resources/graphs/close.png" height="30px" /></a>&nbsp;&nbsp;</th>
			</tr>  
			<tr>
				<th align="center" class="gridhdbg" colspan="15">Format F21 - Month Wise Progress Report of Approved Geotagged Photographs(<%=startFinYear %>-<%if (endFinYear != null && endFinYear.equals("")){%><%=endFinYear%><%}else{%><%=Integer.parseInt(startFinYear)+1%><%} %>)</th>
			</tr>
			<tr>
				<th class="gridhdbg" colspan="15" align="Left"> District Name : - <%=DName %>  
				<%if(Drill.equals("M")){%>
			    	&nbsp;&nbsp;|&nbsp;&nbsp; Mandal Name : - <%=MName %>				
				<%}else if(Drill.equals("P")){%>
				 	&nbsp;&nbsp;|&nbsp;&nbsp; Mandal Name : - <%=MName %> &nbsp;&nbsp;|&nbsp;&nbsp; Panchayat Name : - <%=PName %>				
				<%}else if(Drill.equals("V")){%>
					&nbsp;&nbsp;|&nbsp;&nbsp; Mandal Name : - <%=MName %> &nbsp;&nbsp;|&nbsp;&nbsp; Panchayat Name : - <%=PName %>&nbsp;&nbsp;|&nbsp;&nbsp; Village Name : - <%=VName %>				
				<%}else if(Drill.equals("H")){%>
					&nbsp;&nbsp;|&nbsp;&nbsp; Mandal Name : - <%=MName %> &nbsp;&nbsp;|&nbsp;&nbsp; Panchayat Name : - <%=PName %>&nbsp;&nbsp;|&nbsp;&nbsp; Village Name : - <%=VName %>&nbsp;&nbsp;|&nbsp;&nbsp; Habitation Name : - <%=HName %>				
				<%} %> </th>
			</tr>
			<tr>
				<th class="gridhdbg" > <b>S.No.</b> </th>
			    <th class="gridhdbg" > <b>Asset Code</b> </th>
				<th class="gridhdbg" > <b>Asset Name</b> </th>
				<th class="gridhdbg" > <b>Aseet Cost</b> </th>
			    <th class="gridhdbg" > <b>Asset Satus</b> </th>
			    <th class="gridhdbg" > <b>Asset Creation</b> </th>
			    <th class="gridhdbg" > <b>Location</b> </th>
			    <th class="gridhdbg" > <b>Lattittude</b> </th>			   
			    <th class="gridhdbg" > <b>Longitude</b> </th>
			    <th class="gridhdbg" > <b>Update Date</b> </th>
			    <th class="gridhdbg" > <b>Image</b> </th>
		 	</tr>			
		</thead>
		<tbody>
			<%	PreparedStatement ps1=null;
				ResultSet rs1=null;
				int styleCount=1;
				String style=null, query1=null;
				try{
					if(Month!=null && !Month.equals("")){
						if(Drill.equals("H")){
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')='"+Month+"' AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' AND SUBSTR(A.HAB_CODE,8,3)='"+VCode+"' AND A.HAB_CODE='"+HCode+"' ORDER BY ACODE";
						}else if(Drill.equals("V")){
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')='"+Month+"' AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' AND SUBSTR(A.HAB_CODE,8,3)='"+VCode+"' ORDER BY ACODE";
						}else if(Drill.equals("P")){
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')='"+Month+"' AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' ORDER BY ACODE";
						}else if(Drill.equals("M")){
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')='"+Month+"' AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' ORDER BY ACODE";
						}else{ 
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')='"+Month+"' AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' ORDER BY ACODE";
						}
					}else{
						if(Drill.equals("H")){
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE  FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' AND SUBSTR(A.HAB_CODE,8,3)='"+VCode+"' AND A.HAB_CODE='"+HCode+"' ORDER BY ACODE";
						}else if(Drill.equals("V")){
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE  FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' AND SUBSTR(A.HAB_CODE,8,3)='"+VCode+"' ORDER BY ACODE";
						}else if(Drill.equals("P")){
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE  FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' ORDER BY ACODE";
						}else if(Drill.equals("M")){
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE  FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' ORDER BY ACODE";
						}else{ 
							query1="SELECT A.ASSET_CODE AS ACODE, A.ASSET_NAME AS ANAME, A.Asset_Cost AS ACOST, NVL(A.ASSET_STATUS,'0') AS ASTATUS, TO_CHAR(A.DATE_CREATION,'DD-MM-YYYY') AS ADCREATION, NVL(A.LOCATION,'-') AS ALOCATION, B.ASSET_LAT AS ALAT, B.ASSET_LON AS ALONG, TO_CHAR(B.UPDATE_DATE,'DD-MM-YYYY') AS AUDATE  FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' ORDER BY ACODE";
						}
					}
					ps1=conn.prepareStatement(query1);
					rs1=ps1.executeQuery();					
					while(rs1.next()){
						if(styleCount%2==0){
							 style="gridbg1";
						 }else{
							 style="gridbg2";
						 }						 
				%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(1)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(2)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(3)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%if (rs1.getString(4).equals("1")){%>Working<%}else if (rs1.getString(4).equals("2")){%>Not Working<%}else if (rs1.getString(4).equals("3")){%>Dried<%}else if (rs1.getString(4).equals("4")){%>Seasonal<%}else if (rs1.getString(4).equals("5")){%>Condemed<%}else{%>--<%} %></td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(5)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(6)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(7)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(8)%> </td>
	 				<td class="<%=style%>" style="text-align: center;"> <%=rs1.getString(9)%> </td>
	 				<td class="<%=style%> "><a class="thumbnail" href="#thumb"><img	src="./rws_assets_image_capturing.jsp?imgID=<%=rs1.getString(1)%>" width="30px" height="30px" border="0" /><span><img src="./rws_assets_image_capturing.jsp?imgID=<%=rs1.getString(1)%>" width="350px" height="230px" /></span></a></td>
	 			</tr>	
				<% 
				     }			
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						if(rs1!=null){
							rs1.close();
						}
						if(ps1!=null){
							ps1.close();
						}
						if(conn!=null){
						conn.close();}
					}
				%>
		</tbody>
	</table>
	<table height="20px" align="center">
		<tr height="1%">
			<td align="center" valign="bottom"
				style="font-family: verdana; font-size: 8pt; font-weight: bold; width: 100%; color: #6600CC;">
				Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>,
				Designed & Developed by <a href="http://www.nic.in" target="_blank">National
					Informatics Centre</a>, AP State Centre
			</td>
		</tr>
	</table>
</body>
</html>