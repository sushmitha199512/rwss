<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	DecimalFormat formatter = new DecimalFormat("##,##,##,###");
	String Finyear=request.getParameter("finYear");
	String DCode=request.getParameter("Dcode");
	String DName=request.getParameter("Dname");
	String MCode=request.getParameter("Mcode");
	String MName=request.getParameter("Mname");
	String PCode=request.getParameter("Pcode");
	String PName=request.getParameter("Pname");
	String VCode=request.getParameter("Vcode");
	String VName=request.getParameter("Vname");
	String Drill=request.getParameter("drill");
    String startFinYear = Finyear.substring(0, 4);
    String endFinYear = Finyear.substring(Finyear.length() - 4);
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
	</style>
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
				<th colspan="35"><a href="/pred/home.jsp?loginMode=watersoft">Home</a> | &nbsp;<a href="javascript:onclick=history.go(-1)">Back</a> | &nbsp;<a href="./rws_asset_hab_abstract_excel.jsp">Excel</a></th>
			</tr>  
			<tr>
				<th align="center" class="gridhdbg" colspan="35">Format F21 - Month Wise Progress Report of Approved Geotagged Photographs(<%=Finyear %>)</th>
			</tr>
			<tr>
				<th class="gridhdbg" colspan="35" align="Left"> District Name : - <%=DName %>  
				<%if(Drill.equals("P")){%>
			    	&nbsp;&nbsp;|&nbsp;&nbsp; Mandal Name : - <%=MName %>				
				<%}else if(Drill.equals("V")){%>
				 	&nbsp;&nbsp;|&nbsp;&nbsp; Mandal Name : - <%=MName %> &nbsp;&nbsp;|&nbsp;&nbsp; Panchayat Name : - <%=PName %>				
				<%}else if(Drill.equals("H")){%>
					&nbsp;&nbsp;|&nbsp;&nbsp; Mandal Name : - <%=MName %> &nbsp;&nbsp;|&nbsp;&nbsp; Panchayat Name : - <%=PName %>&nbsp;&nbsp;|&nbsp;&nbsp; Village Name : - <%=VName %>				
				<%} %> </th>
			</tr>
			<tr>
				<th class="gridhdbg" rowspan="2"> S.No. </th>
			    <th class="gridhdbg" rowspan="2"> <%if(Drill.equals("H")){%>
			    Habitation					
				<%}else if(Drill.equals("V")){%>
				Village					
				<%}else if(Drill.equals("P")){%>
				Panchayat					
				<%}else{  %>Mandal<%} %></th>
			    <th class="gridhdbg" colspan="2"> As on (01/04/<%=startFinYear %>) </th>
			    <th class="gridhdbg" colspan="2"> Apr </th>
			    <th class="gridhdbg" colspan="2"> May </th>
			    <th class="gridhdbg" colspan="2"> Jun </th>
			    <th class="gridhdbg" colspan="2"> Jul </th>			   
			    <th class="gridhdbg" colspan="2"> Aug </th>
				<th class="gridhdbg" colspan="2"> Sep </th>
				<th class="gridhdbg" colspan="2"> Oct </th>
				<th class="gridhdbg" colspan="2"> Nov </th>	
				<th class="gridhdbg" colspan="2"> Dec </th>	
				<th class="gridhdbg" colspan="2"> Jan </th>	
				<th class="gridhdbg" colspan="2"> Feb </th>	
				<th class="gridhdbg" colspan="2"> Mar </th>	
				<th class="gridhdbg" colspan="2"> Total Till (31/03/<%=endFinYear%>) </th>	
				<!-- <th class="gridhdbg" rowspan="2"> Total Nos. of Schemes for which these photographs have been loaded </th> -->		
			</tr>
			<tr>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			<th class="gridhdbg">Asset Images</th>
			<th class="gridhdbg">Component Images</th>
			</tr>
		</thead>
		<tbody>
			<%	PreparedStatement ps1=null, ps11=null, ps2=null, ps22=null, ps3=null;
				ResultSet rs1=null, rs11=null, rs2=null, rs22=null, rs3=null;
				String style=null, query1=null, query11=null, query2=null, query22=null, query3=null;
				int distATotalBeforFinApr=0, distATotalTillEndFinMar=0, AJan=0, AFeb=0, AMar=0, AApr=0, AMay=0, AJun=0, AJul=0, AAug=0, ASep=0, AOct=0, ANov=0, ADec=0, styleCount=1;//For Assets
				int totalABeforFinApr=0, totalATillEndFinMar=0, totalAJan=0, totalAFeb=0, totalAMar=0, totalAApr=0, totalAMay=0, totalAJun=0, totalAJul=0, totalAAug=0, totalASep=0, totalAOct=0, totalANov=0, totalADec=0;//For Assets
				int distCTotalBeforFinApr=0, distCTotalTillEndFinMar, CJan=0, CFeb=0, CMar=0, CApr=0, CMay=0, CJun=0, CJul=0, CAug=0, CSep=0, COct=0, CNov=0, CDec=0;//For Components
				int totalCBeforFinApr=0, totalCTillEndFinMar=0, totalCJan=0, totalCFeb=0, totalCMar=0, totalCApr=0, totalCMay=0, totalCJun=0, totalCJul=0, totalCAug=0, totalCSep=0, totalCOct=0, totalCNov=0, totalCDec=0;//For Components
				try{
					if(Drill.equals("H")){
						query1="SELECT DISTINCT HAB_CODE, COUNT(IMG_SIZE) FROM RWS_AST_ALL_COMP_ALL_IMG_VIEW WHERE UPDATE_DATES < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND DCODE='"+DCode+"' AND MCODE='"+MCode+"' AND PCODE='"+PCode+"' AND VCODE='"+VCode+"' AND IMG_SIZE <>'0' GROUP BY HAB_CODE ORDER BY HAB_CODE";
					}else if(Drill.equals("V")){
						query1="SELECT DISTINCT VCODE, COUNT(IMG_SIZE) FROM RWS_AST_ALL_COMP_ALL_IMG_VIEW WHERE UPDATE_DATES < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND DCODE='"+DCode+"' AND MCODE='"+MCode+"' AND PCODE='"+PCode+"' AND IMG_SIZE <>'0' GROUP BY VCODE ORDER BY VCODE";
					}else if(Drill.equals("P")){
						query1="SELECT DISTINCT PCODE, COUNT(IMG_SIZE) FROM RWS_AST_ALL_COMP_ALL_IMG_VIEW WHERE UPDATE_DATES < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND DCODE='"+DCode+"' AND MCODE='"+MCode+"' AND IMG_SIZE <>'0' GROUP BY PCODE ORDER BY PCODE";
					}else{ 
						query1="SELECT DISTINCT MCODE, COUNT(IMG_SIZE) FROM RWS_AST_ALL_COMP_ALL_IMG_VIEW WHERE UPDATE_DATES < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND DCODE='"+DCode+"' AND IMG_SIZE <>'0' GROUP BY MCODE ORDER BY MCODE";
					}
					//System.out.println("333="+assetqry);
					ps1=conn.prepareStatement(query1);
					rs1=ps1.executeQuery();
					Hashtable ImageCount_Districthash=new Hashtable();
					while(rs1.next()){
						ImageCount_Districthash.put(rs1.getString(1), rs1.getInt(2));
					}
					if(rs1!=null){
						rs1.close();
					}
					if(ps1!=null){
						ps1.close();
					}
					if(Drill.equals("H")){
						query11="SELECT A.HAB_CODE AS HCODE, COUNT(B.ASSET_IMAGE) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' AND SUBSTR(A.HAB_CODE,8,3)='"+VCode+"' GROUP BY A.HAB_CODE ORDER BY HCODE";
					}else if(Drill.equals("V")){
						query11="SELECT SUBSTR(A.HAB_CODE,8,3) AS VCODE, COUNT(B.ASSET_IMAGE) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' GROUP BY SUBSTR(A.HAB_CODE,8,3) ORDER BY VCODE";
					}else if(Drill.equals("P")){
						query11="SELECT SUBSTR(A.HAB_CODE,13,2) AS PCODE, COUNT(B.ASSET_IMAGE) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' GROUP BY SUBSTR(A.HAB_CODE,13,2) ORDER BY PCODE";
					}else{ 
						query11="SELECT SUBSTR(A.HAB_CODE,6,2) AS MCODE, COUNT(B.ASSET_IMAGE) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE < to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' GROUP BY SUBSTR(A.HAB_CODE,6,2) ORDER BY MCODE";
					}
					//System.out.println("333="+assetqry);
					ps11=conn.prepareStatement(query11);
					rs11=ps11.executeQuery();
					Hashtable ImageCount_Districthash1=new Hashtable();
					while(rs11.next()){
						ImageCount_Districthash1.put(rs11.getString(1), rs11.getInt(2));
					}
					if(rs11!=null){
						rs11.close();
					}
					if(ps1!=null){
						ps11.close();
					}
					if(Drill.equals("H")){
						query2="SELECT DISTINCT HAB_CODE, COUNT(IMG_SIZE), TO_CHAR(TRUNC(UPDATE_DATES), 'MM') FROM RWS_AST_ALL_COMP_ALL_IMG_VIEW WHERE UPDATE_DATES >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND UPDATE_DATES < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND DCODE='"+DCode+"' AND MCODE='"+MCode+"' AND PCODE='"+PCode+"' AND VCODE='"+VCode+"' AND IMG_SIZE <>'0' GROUP BY HAB_CODE, TO_CHAR(TRUNC(UPDATE_DATES), 'MM') ORDER BY HAB_CODE, TO_CHAR(TRUNC(UPDATE_DATES), 'MM')";
					}else if(Drill.equals("V")){
						query2="SELECT DISTINCT VCODE, COUNT(IMG_SIZE), TO_CHAR(TRUNC(UPDATE_DATES), 'MM') FROM RWS_AST_ALL_COMP_ALL_IMG_VIEW WHERE UPDATE_DATES >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND UPDATE_DATES < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND DCODE='"+DCode+"' AND MCODE='"+MCode+"' AND PCODE='"+PCode+"' AND IMG_SIZE <>'0' GROUP BY VCODE, TO_CHAR(TRUNC(UPDATE_DATES), 'MM') ORDER BY VCODE, TO_CHAR(TRUNC(UPDATE_DATES), 'MM')";
					}else if(Drill.equals("P")){
						query2="SELECT DISTINCT PCODE, COUNT(IMG_SIZE), TO_CHAR(TRUNC(UPDATE_DATES), 'MM') FROM RWS_AST_ALL_COMP_ALL_IMG_VIEW WHERE UPDATE_DATES >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND UPDATE_DATES < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND DCODE='"+DCode+"' AND MCODE='"+MCode+"' AND IMG_SIZE <>'0' GROUP BY PCODE, TO_CHAR(TRUNC(UPDATE_DATES), 'MM') ORDER BY PCODE, TO_CHAR(TRUNC(UPDATE_DATES), 'MM')";
					}else{ 
						query2="SELECT DISTINCT MCODE, COUNT(IMG_SIZE), TO_CHAR(TRUNC(UPDATE_DATES), 'MM') FROM RWS_AST_ALL_COMP_ALL_IMG_VIEW WHERE UPDATE_DATES >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND UPDATE_DATES < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND DCODE='"+DCode+"' AND IMG_SIZE <>'0' GROUP BY MCODE, TO_CHAR(TRUNC(UPDATE_DATES), 'MM') ORDER BY MCODE, TO_CHAR(TRUNC(UPDATE_DATES), 'MM')";
					}
					ps2=conn.prepareStatement(query2);
					rs2=ps2.executeQuery();
					Hashtable ImageCount_Monthhash=new Hashtable();
					while(rs2.next()){
						ImageCount_Monthhash.put(rs2.getString(1)+rs2.getString(3), rs2.getInt(2));
					}
					if(rs2!=null){
						rs2.close();
					}
					if(ps2!=null){
						ps2.close();
					}
					if(Drill.equals("H")){
						query22="SELECT A.HAB_CODE AS HCODE, COUNT(B.ASSET_IMAGE), TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM') FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' AND SUBSTR(A.HAB_CODE,8,3)='"+VCode+"' GROUP BY A.HAB_CODE, TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM') ORDER BY HCODE, TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')";
					}else if(Drill.equals("V")){
						query22="SELECT SUBSTR(A.HAB_CODE,8,3) AS VCODE, COUNT(B.ASSET_IMAGE), TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM') FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' AND SUBSTR(A.HAB_CODE,13,2)='"+PCode+"' GROUP BY SUBSTR(A.HAB_CODE,8,3), TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM') ORDER BY VCODE, TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')";
					}else if(Drill.equals("P")){
						query22="SELECT SUBSTR(A.HAB_CODE,13,2) AS PCODE, COUNT(B.ASSET_IMAGE), TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM') FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' AND SUBSTR(A.HAB_CODE,6,2)='"+MCode+"' GROUP BY SUBSTR(A.HAB_CODE,13,2), TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM') ORDER BY PCODE, TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')";
					}else{ 
						query22="SELECT SUBSTR(A.HAB_CODE,6,2) AS MCODE, COUNT(B.ASSET_IMAGE), TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM') FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_IMAGE_TBL B WHERE A.ASSET_CODE=B.ASSET_CODE AND B.UPDATE_DATE >=to_date('01-04-"+startFinYear+"','dd-MM-yyyy') AND B.UPDATE_DATE < to_date('01-04-"+endFinYear+"','dd-MM-yyyy') AND SUBSTR(A.HAB_CODE,1,2)='"+DCode+"' GROUP BY SUBSTR(A.HAB_CODE,6,2), TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM') ORDER BY MCODE, TO_CHAR(TRUNC(B.UPDATE_DATE), 'MM')";
					}
					ps22=conn.prepareStatement(query22);
					rs22=ps22.executeQuery();
					Hashtable ImageCount_Monthhash2=new Hashtable();
					while(rs22.next()){
						ImageCount_Monthhash2.put(rs22.getString(1)+rs22.getString(3), rs22.getInt(2));
					}
					if(rs22!=null){
						rs22.close();
					}
					if(ps2!=null){
						ps22.close();
					}
					if(Drill.equals("H")){
						query3="SELECT DISTINCT PANCH_CODE, PANCH_NAME FROM RWS_COMPLETE_HAB_VIEW WHERE DCODE='"+DCode+"' AND MCODE='"+MCode+"' AND PCODE='"+PCode+"' AND VCODE='"+VCode+"' ORDER BY PANCH_NAME";
					}else if(Drill.equals("V")){
						query3="SELECT DISTINCT VCODE, VNAME FROM RWS_COMPLETE_HAB_VIEW WHERE DCODE='"+DCode+"' AND MCODE='"+MCode+"' AND PCODE='"+PCode+"' ORDER BY VNAME";
					}else if(Drill.equals("P")){
						query3="SELECT DISTINCT PCODE, PNAME FROM RWS_COMPLETE_HAB_VIEW WHERE DCODE='"+DCode+"' AND MCODE='"+MCode+"' ORDER BY PNAME";
					}else{ 
						query3="SELECT DISTINCT MCODE, MNAME FROM RWS_COMPLETE_HAB_VIEW WHERE DCODE='"+DCode+"' ORDER BY MNAME";
					}
					ps3=conn.prepareStatement(query3);
					rs3=ps3.executeQuery();
					while(rs3.next()){
						distCTotalTillEndFinMar=0;//For Components
						distATotalTillEndFinMar=0;//For Assets
						if(styleCount%2==0){
							 style="gridbg1";
						 }else{
							 style="gridbg2";
						 }
						//Components Counting
						 if(ImageCount_Districthash.get(rs3.getString(1))!=null){distCTotalBeforFinApr=(Integer)ImageCount_Districthash.get(rs3.getString(1)); }else{distCTotalBeforFinApr=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"04")!=null){CApr=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"04");}else{CApr=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"05")!=null){CMay=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"05");}else{CMay=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"06")!=null){CJun=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"06");}else{CJun=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"07")!=null){CJul=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"07");}else{CJul=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"08")!=null){CAug=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"08");}else{CAug=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"09")!=null){CSep=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"09");}else{CSep=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"10")!=null){COct=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"10");}else{COct=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"11")!=null){CNov=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"11");}else{CNov=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"12")!=null){CDec=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"12");}else{CDec=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"01")!=null){CJan=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"01");}else{CJan=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"02")!=null){CFeb=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"02");}else{CFeb=0;}
						 if(ImageCount_Monthhash.get(rs3.getString(1)+"03")!=null){CMar=(Integer)ImageCount_Monthhash.get(rs3.getString(1)+"03");}else{CMar=0;}
						 distCTotalTillEndFinMar=(distCTotalBeforFinApr+CApr+CMay+CJun+CJul+CAug+CSep+COct+CNov+CDec+CJan+CFeb+CMar);
						 //Assets Counting
						 if(ImageCount_Districthash1.get(rs3.getString(1))!=null){distATotalBeforFinApr=(Integer)ImageCount_Districthash1.get(rs3.getString(1)); }else{distATotalBeforFinApr=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"04")!=null){AApr=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"04");}else{AApr=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"05")!=null){AMay=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"05");}else{AMay=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"06")!=null){AJun=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"06");}else{AJun=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"07")!=null){AJul=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"07");}else{AJul=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"08")!=null){AAug=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"08");}else{AAug=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"09")!=null){ASep=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"09");}else{ASep=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"10")!=null){AOct=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"10");}else{AOct=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"11")!=null){ANov=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"11");}else{ANov=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"12")!=null){ADec=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"12");}else{ADec=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"01")!=null){AJan=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"01");}else{AJan=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"02")!=null){AFeb=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"02");}else{AFeb=0;}
						 if(ImageCount_Monthhash2.get(rs3.getString(1)+"03")!=null){AMar=(Integer)ImageCount_Monthhash2.get(rs3.getString(1)+"03");}else{AMar=0;}
						 distATotalTillEndFinMar=(distATotalBeforFinApr+AApr+AMay+AJun+AJul+AAug+ASep+AOct+ANov+ADec+AJan+AFeb+AMar);
						 
				%>
				<tr>
	 				<td class="<%=style%>" style="text-align: center;"> <%=styleCount++%></td>
	 				<td class="<%=style%>" style="text-align: left;">
	 					<%if(Drill.equals("H")){%>
					    <%=rs3.getString(2)%>				
						<%}else if(Drill.equals("V")){%>
						<a href="rws_asset_image_capturing_drill.jsp?drill=H&finYear=<%=Finyear %>&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%>"> <%=rs3.getString(2)%></a>				
						<%}else if(Drill.equals("P")){%>
						<a href="rws_asset_image_capturing_drill.jsp?drill=V&finYear=<%=Finyear %>&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%>"> <%=rs3.getString(2)%></a>				
						<%}else{  %>
						<a href="rws_asset_image_capturing_drill.jsp?drill=P&finYear=<%=Finyear %>&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%>"> <%=rs3.getString(2)%></a>
						<%} %>
					</td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %><%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')"> <%=formatter.format(distATotalBeforFinApr)%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %><%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')"> <%=formatter.format(distCTotalBeforFinApr)%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=04<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AApr)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=04<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CApr)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=05<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AMay)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=05<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CMay)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=06<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AJun)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=06<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CJun)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=07<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AJul)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=07<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CJul)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=08<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AAug)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=08<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CAug)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=09<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(ASep)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=09<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CSep)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=10<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AOct)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=10<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(COct)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=11<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(ANov)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=11<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CNov)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=12<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(ADec)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=12<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CDec)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=01<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AJan)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=01<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CJan)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=02<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AFeb)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=02<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CFeb)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=03<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(AMar)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=startFinYear %>&endFinYear=<%=endFinYear %>&month=03<%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')" > <%=formatter.format(CMar)%></a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill1.jsp?startFinYear=<%=endFinYear %><%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')"> <%=formatter.format(distATotalTillEndFinMar)%> </a></td>
	 				<td class="<%=style%>" style="text-align: center;"><a href="#" onclick="viewWorks('./rws_assets_image_capturing_drill2.jsp?startFinYear=<%=endFinYear %><%if(Drill.equals("H")){%>&drill=H&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=VCode%>&Vname=<%=VName%>&Hcode=<%=rs3.getString(1)%>&Hname=<%=rs3.getString(2)%><%}else if(Drill.equals("V")){%>&drill=V&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=PCode%>&Pname=<%=PName%>&Vcode=<%=rs3.getString(1)%>&Vname=<%=rs3.getString(2)%><%}else if(Drill.equals("P")){%>&drill=P&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=MCode%>&Mname=<%=MName%>&Pcode=<%=rs3.getString(1)%>&Pname=<%=rs3.getString(2)%><%}else{  %>&drill=M&Dcode=<%=DCode%>&Dname=<%=DName%>&Mcode=<%=rs3.getString(1)%>&Mname=<%=rs3.getString(2)%><%}%>')"> <%=formatter.format(distCTotalTillEndFinMar)%> </a></td>
	 				<!-- <td class="<%=style%>" style="text-align: center;"> <%-- <%=%> --%></td> -->
	 			</tr>	
				<% 	  
				//Components Totaling
						totalCBeforFinApr=totalCBeforFinApr+distCTotalBeforFinApr; 
						totalCApr=totalCApr+CApr; 
						totalCMay=totalCMay+CMay; 
						totalCJun=totalCJun+CJun; 
						totalCJul=totalCJul+CJul; 
						totalCAug=totalCAug+CAug; 
						totalCSep=totalCSep+CSep; 
						totalCOct=totalCOct+COct; 
						totalCNov=totalCNov+CNov; 
						totalCDec=totalCDec+CDec;
						totalCJan=totalCJan+CJan; 
						totalCFeb=totalCFeb+CFeb; 
						totalCMar=totalCMar+CMar; 						
						totalCTillEndFinMar=totalCTillEndFinMar+distCTotalTillEndFinMar;
				//Asset Totaling
						totalABeforFinApr=totalABeforFinApr+distATotalBeforFinApr; 
						totalAApr=totalAApr+AApr; 
						totalAMay=totalAMay+AMay; 
						totalAJun=totalAJun+AJun; 
						totalAJul=totalAJul+AJul; 
						totalAAug=totalAAug+AAug; 
						totalASep=totalASep+ASep; 
						totalAOct=totalAOct+AOct; 
						totalANov=totalANov+ANov; 
						totalADec=totalADec+ADec;
						totalAJan=totalAJan+AJan; 
						totalAFeb=totalAFeb+AFeb; 
						totalAMar=totalAMar+AMar; 						
						totalATillEndFinMar=totalATillEndFinMar+distATotalTillEndFinMar;
						
				     }			
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						if(rs3!=null){
							rs3.close();
						}
						if(ps3!=null){
							ps3.close();
						}
						if(conn!=null){
						conn.close();}
					}
				%>
		</tbody>
		<tfoot>
			<tr>
 				<td class="gridhdbg" style="text-align: center;" colspan="2"> Total</td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalABeforFinApr)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCBeforFinApr)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAApr)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCApr)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAMay)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCMay)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAJun)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCJun)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAJul)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCJul)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAAug)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCAug)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalASep)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCSep)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAOct)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCOct)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalANov)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCNov)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalADec)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCDec)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAJan)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCJan)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAFeb)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCFeb)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalAMar)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCMar)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalATillEndFinMar)%></td>
 				<td class="gridhdbg" style="text-align: center;"> <%=formatter.format(totalCTillEndFinMar)%></td>
 				<!-- <td class="gridhdbg" style="text-align: center;"> <%-- <%=%> --%></td> -->
 			</tr>	
		</tfoot>
	</table>
</body>
</html>