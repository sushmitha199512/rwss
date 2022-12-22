<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<head>
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
width:50px;
height:50px;
}
</style> 
</head>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{	
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
function wopen(url, name, w, h)
{
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

<form>
<%
	ResultSet rs1=null;
    PreparedStatement ps1=null;
    int slno=0;
    String qry="", str="",qr="", str1="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
    String habName="";
    String dcode=request.getParameter("district");
    session.setAttribute("dcode", dcode);    
    String fromdate=request.getParameter("fromDate");
    session.setAttribute("fromdate", fromdate);
    String todate=request.getParameter("toDate");
    session.setAttribute("todate", todate);
    String habcode=request.getParameter("habitation");
	session.setAttribute("habcode", habcode);
	String actdate=request.getParameter("actdate");
	session.setAttribute("actdate", actdate);
	String tankerregno=request.getParameter("tankerregno");
	session.setAttribute("tankerregno", tankerregno);
	//System.out.println("habname############"+actdate);
    //String status=request.getParameter("status");
    //session.setAttribute("status", status);
	/* String mcode=request.getParameter("mandal");
	session.setAttribute("mcode", mcode);
	String habcode=request.getParameter("habitation");
	session.setAttribute("habcode", habcode);
    String panchcode=request.getParameter("panchayat");
    session.setAttribute("panchcode",panchcode );
    String villcode=request.getParameter("village");
    session.setAttribute("villcode",villcode ); */
  //String type=request.getParameter("type");
    //session.setAttribute("type",type );
    
    /* String dname=String.valueOf(session.getAttribute("dName")) ;
    session.setAttribute("dName", dname);
	String mname=session.getAttribute("mName").toString();
	session.setAttribute("mName", mname);
	String panchname ="-Select-",villagename="-Select-",habName="-Select-";
	if(session.getAttribute("pName") != null)
    panchname=session.getAttribute("pName").toString();
    session.setAttribute("pName",panchname );
    if(session.getAttribute("vName") != null)
    villagename=session.getAttribute("vName").toString();
    session.setAttribute("vName",villagename ); */
    
    //String habName1=request.getParameter("hName");
	//System.out.println("habname############"+habName1);
    
   // System.out.println(""+session.getAttribute("hName").toString());
    if(request.getParameter("hName") != null)
    habName=request.getParameter("hName").toString();
	session.setAttribute("hName", habName);
	String approved_by_office="";
    //String trip_id=""; 
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
		</tr></table>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
	<tr align="right">
	<!-- <td ><a href="#" onClick="window.close();">Close</a>  </td> -->
	 <td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  </td> 
	</tr>  
	</table>
	</table>
	</caption>
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center>
   <%-- <%
   if(panchname.equalsIgnoreCase("-Select-")){ 
	   %>
	   		<td class="gridhdbg" colspan="30"><b>Tanker Movement Details for District:<%=dname%> and Mandal:<%=mname%> (From:<%=fromdate %> To:<%=todate %>)</b></td>
	   
    	 <% }else if(!panchname.equalsIgnoreCase("-Select-")&&villagename.equalsIgnoreCase("-Select-"))
    	 {%>
    	 
    	 		<td class="gridhdbg" colspan="30"><b>Tanker Movement Details for District:<%=dname%> and Mandal:<%=mname%> and Panchayat:<%=panchname%> (From:<%=fromdate %> To:<%=todate %>)</b></td>
    	 <%}
    else if(!villagename.equalsIgnoreCase("-Select-")&&habName.equalsIgnoreCase("-Select-"))
	 {%>
	 
	 		<td class="gridhdbg" colspan="30"><b>Tanker Movement Details for District:<%=dname%> and Mandal:<%=mname%> and Panchayat:<%=panchname%> and Vill.Name:<%=villagename%>(From:<%=fromdate %> To:<%=todate %>)</b></td>
	
	 <%}
    else{%>
    
    		 		<td class="gridhdbg" colspan="30"><b>Tanker Movement Details for District:<%=dname%> and Mandal:<%=mname%> and Panchayat:<%=panchname%> and Vill.Name:<%=villagename%> and Hab.Name:<%=habName%> (From:<%=fromdate %> To:<%=todate %>)</b></td>	
    
    
    <%}
   %> --%>
   
       		 		<td class="gridhdbg" colspan="30"><b>Tanker Statics  Details for  Hab.Name:<%=habName%> (From:<%=fromdate %> To:<%=todate %>)</b></td>	
   
		</tr>
	 <tr>
	<td class=gridhdbg rowspan="2">Sl.No</td>
	<%-- <% if (type.equalsIgnoreCase("2")){%>
	 <td class=gridhdbg rowspan="2">District</td>
	<td class=gridhdbg rowspan="2">Mandal</td>
	<td class=gridhdbg rowspan="2">Panchayat</td>
	<td class=gridhdbg rowspan="2">Village</td>
	<%} %> --%>
	<%-- <td class=gridhdbg rowspan="2">District Name</td>
	<td class=gridhdbg rowspan="2">Mandal Name</td>
	    <%if(!panchname.equalsIgnoreCase("-Select-")){ %>
	<td class=gridhdbg rowspan="2">Panchayat Name</td>
	<% } if(!panchname.equalsIgnoreCase("-Select-")&&!villagename.equalsIgnoreCase("-Select-")) {
		%>
		<td class=gridhdbg rowspan="2">Vill. Name</td>
	<% }%> --%>
    <td class=gridhdbg rowspan="2">Habitation Code/</br>Habitation Name</td>
    <td class=gridhdbg rowspan="2">Tanker Reg. No.</td>
    <td class=gridhdbg rowspan="2">Source Code</td>
    <td class=gridhdbg rowspan="2">Trip Id</td>
    <td class=gridhdbg colspan="5">Source</td>
    <td class=gridhdbg colspan="6">Destination</td>
<!--     <td class=gridhdbg rowspan="2">Distance</td>
 -->    <td class=gridhdbg rowspan="2">Distance(in Km)</td>
 
    <td class=gridhdbg rowspan="2">Trip Duration</td>
    <td class=gridhdbg rowspan="2">Trip Status</td>
    <td class=gridhdbg colspan="4">Inspection Details</td>
    <td class=gridhdbg rowspan="2">Approval Status</td>
   <!--  <td class=gridhdbg rowspan="2">Approval Status Update</td> -->
    <!--  <td class=gridhdbg rowspan="6">Approval Status</td>  -->
    </tr>
    <tr>
    <td class=gridhdbg>Date</td>
    <td class=gridhdbg>Latitude/Longitude</td>
    <!-- <td class=gridhdbg>Longitude</td> -->
    <td class=gridhdbg>Image 1</td>
    <td class=gridhdbg>Image 2</td>
    <td class=gridhdbg>Image 3</td>
    <td class=gridhdbg>Date</td>
    <td class=gridhdbg>Habitation</td><!-- bhagya -->
    <td class=gridhdbg>Latitude/Longitude</td>
    <!-- <td class=gridhdbg>Longitude</td> -->
     <td class=gridhdbg>Image 1</td>
    <td class=gridhdbg>Image 2</td>
    <td class=gridhdbg>Image 3</td>
    <td class=gridhdbg >Inspected By</td>
     <td class=gridhdbg > Date</td>
    <td class=gridhdbg > Mobile</td>
    
    <td class=gridhdbg > Image</td>
       </tr>
       	<%
       	PreparedStatement pstmt=null;
       	       try
		{
       	    	  /*  try{
       	    		SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy",Locale.ENGLISH);
   				  	Date date1 = format.parse (fromdate);
   				 	Date date2 = format.parse (todate);
   				  	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
   				 	fromdate = formatter.format(date1);  
   				 	todate = formatter.format(date2);  
       	    	   }catch(Exception e){
       	    		   e.printStackTrace();
       	    	   } */
       	    	 String sapp ;
        	    	String rootDir = getServletContext().getRealPath("/");//+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator;		
    			 if(rootDir != null && !rootDir.isEmpty() && rootDir.contains(File.separator+"webapps"+File.separator)){
    				 String sample[]  = rootDir.split( File.separator+"webapps"+File.separator);
    				 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
    				 rootDir = sample[0];
    			 }else{
    				 String sample[]  = rootDir.split( "webapps");
    				// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
    				 rootDir = sample[0];
    			 }
       	    	/* String tableName = "";
       	    	   //System.out.println("@!@@@@@@@@@@@@@@@@@@@@@!!");
           		if(dcode != null && dcode.equals("07") || dcode.equals("09") || dcode.equals("11") || dcode.equals("12") ){
           			tableName = "RWS_TANKER_MOVEMENT_PVT_TBL";
           		}else{
           			tableName = "RWS_TANKER_MOVEMENT_TBL";
           		} */
    	 /* if(panchname.equalsIgnoreCase("-Select-")){  
       	  
	   str="select a.TANKER_REG_NO,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(SOURCE_CODE,'--'),TANKER_SOURCE_LAT,TANKER_SOURCE_LOG,nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),TRIP_ID,	nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy'),'--'),nvl(dest_habitation,'--'),nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),999  as totalseconds,nvl(to_char(TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(INSP_MOBILE,'--'),nvl(to_char(INSPECTION_DATE ,'dd/mm/yyyy'),'--'),nvl(INSP_MOBILE,'--'),c.panch_code,c.panch_name,a.APPROVEL_STATUS "  
			   +",nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate from "+tableName+" a,rws_complete_hab_view c  where substr(a.dest_habitation,1,16)=c.panch_code   and substr(a.dest_habitation,1,2)='"+dcode+"' and substr(a.dest_habitation,6,2)='"+mcode+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy') order by a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc ";
	   
	   pstmt=conn.prepareStatement(str);  
	
		//System.out.println("dcode :"+dcode+" mcode:"+mcode+" fromdate:"+fromdate+" todate:"+todate);
    	 }else if(!panchname.equalsIgnoreCase("-Select-")&&villagename.equalsIgnoreCase("-Select-"))
    	 {
    		   str="select a.TANKER_REG_NO,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(SOURCE_CODE,'--'),TANKER_SOURCE_LAT,TANKER_SOURCE_LOG,nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),TRIP_ID,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(dest_habitation,'--'),nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),999  as totalseconds,nvl(to_char(TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(INSP_MOBILE,'--'),nvl(to_char(INSPECTION_DATE ,'dd/mm/yyyy'),'--'),nvl(INSP_MOBILE,'--'),c.panch_code,c.panch_name,a.APPROVEL_STATUS "+
    	 	",nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate,TANKER_TRIP_DISTANCE from "+tableName+" a,rws_complete_hab_view c where substr(a.dest_habitation,1,16)=c.panch_code and  substr(a.dest_habitation,1,2)='"+dcode+"' and substr(a.dest_habitation,6,2)='"+mcode+"' and substr(a.dest_habitation,13,2)='"+panchcode+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy') order by a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc";
    		   pstmt=conn.prepareStatement(str);  
    		
    	 }
    	 else if(!panchname.equalsIgnoreCase("-Select-")&&!villagename.equalsIgnoreCase("-Select-")&&habName.equalsIgnoreCase("-Select-"))
    	 {
    		   str="select a.TANKER_REG_NO,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(SOURCE_CODE,'--'),TANKER_SOURCE_LAT,TANKER_SOURCE_LOG,nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),TRIP_ID,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(dest_habitation,'--'),nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),999  as totalseconds,nvl(to_char(TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(INSP_MOBILE,'--'),nvl(to_char(INSPECTION_DATE ,'dd/mm/yyyy'),'--'),nvl(INSP_MOBILE,'--'),c.panch_code,c.panch_name,a.APPROVEL_STATUS "+
    	 ",nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate,TANKER_TRIP_DISTANCE from "+tableName+" a,rws_complete_hab_view c where substr(a.dest_habitation,1,16)=c.panch_code  and substr(a.dest_habitation,1,2)='"+dcode+"' and substr(a.dest_habitation,6,2)='"+mcode+"'  and substr(a.dest_habitation,13,2)='"+panchcode+"' and substr(a.dest_habitation,8,3)='"+villcode+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy') order by a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc";
    		   pstmt=conn.prepareStatement(str);  
   			
    	 }
    	 else
    	 { */
    		 
    		 //System.out.println("##############");
    	 /* str="select a.TANKER_REG_NO,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(SOURCE_CODE,'--'),TANKER_SOURCE_LAT,TANKER_SOURCE_LOG,nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),TRIP_ID,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(dest_habitation,'--'),nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),999  as totalseconds,nvl(to_char(TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(INSP_MOBILE,'--'),nvl(to_char(INSPECTION_DATE ,'dd/mm/yyyy'),'--'),nvl(INSP_MOBILE,'--'),c.panch_code,c.panch_name,a.APPROVEL_STATUS "+
    	 ",nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate,TANKER_TRIP_DISTANCE from "+tableName+" a,rws_complete_hab_view c where substr(a.dest_habitation,1,16)=c.panch_code and substr(a.dest_habitation,1,16)='"+habcode+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy') order by a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc";
    	   */
    	/*  str="select a.TANKER_REG_NO,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(SOURCE_CODE,'--'),TANKER_SOURCE_LAT,TANKER_SOURCE_LOG,nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),TRIP_ID,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(dest_habitation,'--'),nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),999  as totalseconds,nvl(to_char(TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(INSP_MOBILE,'--'),nvl(to_char(INSPECTION_DATE ,'dd/mm/yyyy'),'--'),nvl(INSP_MOBILE,'--'),c.panch_code,c.panch_name,a.APPROVEL_STATUS "+
    	    	 ",nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate,TANKER_TRIP_DISTANCE from "+tableName+" a,rws_complete_hab_view c where substr(a.dest_habitation,1,16)=c.panch_code and substr(a.dest_habitation,1,16)=? and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date(?,'dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy') order by a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc";
    	    */ 
    	    str="select a.TANKER_REG_NO,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(SOURCE_CODE,'--'),TANKER_SOURCE_LAT,TANKER_SOURCE_LOG,nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),TRIP_ID,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(dest_habitation,'--'),nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),999  as totalseconds,nvl(to_char(TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(INSP_MOBILE,'--'),nvl(to_char(INSPECTION_DATE ,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(INSP_MOBILE,'--'),c.panch_code,c.panch_name,a.APPROVEL_STATUS "+
       	    	 ",nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate,TANKER_TRIP_DISTANCE,nvl(APPROVED_BY,'--') as approvedby from RWS_TANKER_MOVEMENT_TBL a,rws_complete_hab_view c where substr(a.dest_habitation,1,16)=c.panch_code and substr(a.dest_habitation,1,16)=? and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') = ? and a.tanker_reg_no= ?  order by a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc";
       	    
    	 pstmt=conn.prepareStatement(str);  
    	 //System.out.println("##############  "+str);
 			/* pstmt.setString(1, tableName); */
 			pstmt.setString(1, habcode);
 			pstmt.setString(2, actdate);
 			pstmt.setString(3, tankerregno);
 			//pstmt.setString(3, actdate);
 			
    	/*  } */
    	// System.out.println("tanker query det@@@@ :    "+str);
	   //ps=conn.prepareStatement(str);
		 rs=pstmt.executeQuery();
		 if (!rs.isBeforeFirst() ) {    
			    %> 
			    
			    <table>
			    <tr><td><h1>No data found</h1></td></tr>
			    </table>
			    
			<%}
		 String distance = "0";
		 while(rs.next())
	   {
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;%>
			 <%
			   String strtDate=rs.getString(2);
			   String stri[]=strtDate.split("/");
			   String day= stri[0];
			   String month= stri[1];
			   String year= stri[2].substring(0,4);
			  // sapp = rootDir+ File.separator +"TankerImages"+ File.separator +year+ File.separator +month+ File.separator +day+File.separator ;
			   String imagesPath = File.separator+"mnt"+File.separator+"DATA-NAS"+ File.separator +"TankerImages";
			   sapp = imagesPath+ File.separator +year+ File.separator +month+ File.separator +day+File.separator ;
			   
			   %>
			 <tr>
			<td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	  <%--     <td class="<%=style%> "style="text-align: left;"><%=dname%></td>
	      <td class="<%=style%> "style="text-align: left;"><%=mname%></td>
	      <%if(!panchname.equalsIgnoreCase("-Select-")){ %>
	<td class="<%=style%> "style="text-align: left;"><%=panchname%></td>
	<% } if(!panchname.equalsIgnoreCase("-Select-")&&!villagename.equalsIgnoreCase("-Select-")) {
		%>
		<td class="<%=style%> "style="text-align: left;"><%=villagename%></td>
	<% }%> --%>
		             <td class="<%=style%> "style="text-align: left;"><%=rs.getString(23)%>/<br><%=rs.getString(24)%></td>
					  <%-- <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_tanker_movement_drill1_rpt.jsp?status=tanker&regno=<%=rs.getString(1)%>')"><%=rs.getString(1)%></a></td>
					  <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_tanker_movement_drill1_rpt.jsp?status=source&sourceCode=<%=rs.getString(4)%>')"><%=rs.getString(4)%></a></td>
					   --%>
					   <td class="<%=style%> "style="text-align: left;"><%=rs.getString(1)%></a></td>
					  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%></a></td>
<%-- 					  <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_tanker_movement_drill1_rpt.jsp?status=approval&tripId=<%=rs.getString(11)%>&hCode=<%=rs.getString(23)%>&hName=<%=rs.getString(24)%>')"><%=rs.getString(11)%></a></td>
 --%>					   <td class="<%=style%> "style="text-align: right;"><%=rs.getString(11)%></td> 
					  <td class="<%=style%> "style="text-align: right;"><%=rs.getString(2)%></td>
					  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(5)%>/<br><%=rs.getString(6)%></td>
					  <%-- <td class="<%=style%> "style="text-align: left;"><%=rs.getString(6)%></td> --%>
					 <%
							
				File stheImage1  = new File(sapp+rs.getString(11)+"src1.jpg");
					if(stheImage1.getAbsoluteFile().exists())
					{
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"src1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					%>
<%
					File stheImage2  = new File(sapp+rs.getString(11)+"src2.jpg");
					
					if(stheImage2.getAbsoluteFile().exists())
					{
						
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"src2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					%>
					
					  <%
					File stheImage3  = new File(sapp+rs.getString(11)+"src3.jpg");
					
					if(stheImage3.getAbsoluteFile().exists())
					{
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"src3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					//System.out.println("Habitation"+rs.getString(12)+"***"+rs.getString(13));
					
					%> 
					 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(3)%></td> 
					 
					  <%
					
					if(!rs.getString(13).equalsIgnoreCase("--"))
					{
					str1="select panch_name,panch_code  from rws_complete_hab_view where panch_code='"+rs.getString(13)+"'";
					   ps1=conn.prepareStatement(str1);
						 rs1=ps1.executeQuery();
					
						 while(rs1.next())
					   {
							 
					   %> <td class="<%=style%> "style="text-align: right;"><%=rs1.getString(1)%>/<%=rs1.getString(2)%></td> 
							 
					
					  <%  }rs1.close();
					}else
					{%>
						<td class="<%=style%> "style="text-align: right;">--</td>
					<%}
					
					%>
 				
					 <td class="<%=style%> "style="text-align: left;"><%=rs.getString(14)%>/<br><%=rs.getString(15)%></td> 
					<%
					File theImage1 = new File(sapp+rs.getString(11)+"dest1.jpg");
					if(theImage1.getAbsoluteFile().exists())
					{
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					File theImage2 = new File(sapp+rs.getString(11)+"dest2.jpg");
					
					if(theImage2.getAbsoluteFile().exists())
					{
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					%>
					<%
					File theImage3 = new File(sapp+rs.getString(11)+"dest3.jpg");
					
					if(theImage3.getAbsoluteFile().exists())
					{
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"dest3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					%>
					<%-- 
					 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(16)%></td>
					 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(17)%></td> --%>
					 <%if(rs.getString(17)!=null&&!rs.getString(17).isEmpty()){ 
					
					DecimalFormat decimalFormat=new DecimalFormat("####.##");
					if(Double.parseDouble(rs.getString(17))>999)
						distance = decimalFormat.format(Double.parseDouble(rs.getString(17))/1000.0);
					else
						distance = rs.getString(17);
					%>
		
					 <td class="<%=style%> "style="text-align: right;"><%=distance%></td> 
				
			<% 	}else{ %>
				
				
					 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(17)%></td>
					 <%} 
					 if(rs.getString("isStarted").equalsIgnoreCase("--")) {%>
					 <td class="<%=style%> "style="text-align: right;">--</td>
					 <td class="<%=style%> "style="text-align: right;"><font color="red">In Progress</font></td>
					 <%} else{
						 String s="";
						 try{
							 String strtTime=rs.getString("strDate");
							 String endTime=rs.getString("endDate");
							 //dd/mm/yyyy HH24:MI:SS
							 SimpleDateFormat format = new SimpleDateFormat(
		                    "dd/MM/yyyy HH:mm:ss");
		           Date d1 = format.parse(strtTime);
		           Date d2 = format.parse(endTime);

		            // in milliseconds
		            long diff = d2.getTime() - d1.getTime();

		            long diffSeconds = diff / 1000 % 60;
		            long diffMinutes = diff / (60 * 1000) % 60;
		            long diffHours = diff / (60 * 60 * 1000) % 24;
		            long diffDays = diff / (24 * 60 * 60 * 1000);
                     
                    //System.out.print( p2 + ":" + p3 + ":" + p1);
                    s=diffHours + " Hrs :" + diffMinutes + " Min:" + diffSeconds+" Sec";
						 }catch(Exception e){
							 e.printStackTrace();
						 }
					 %>
					 <td class="<%=style%> "style="text-align: center;"><%=s%></td> 
					 <td class="<%=style%> "style="text-align: right;"><font color="green">Completed</font></td>
					 <%} %>
					 
					 
					<%
					String pathWebcontent=request.getContextPath();
					%>
					<%
					if(!rs.getString(22).equalsIgnoreCase("--"))
					{
					str1="select  data_collector_name,designation  from rws_mobile_sms_register_tbl where mobile='"+rs.getString(22)+"'";
					//System.out.println("@@@@@@@$$$$$$$$$$$$$$$$**************%%%%%%%%%%%%"+str1);
					   ps1=conn.prepareStatement(str1);
						 rs1=ps1.executeQuery();
					
						 if (!rs1.isBeforeFirst() ) {    
							  
							  %>  
							   <td class="<%=style%> "style="text-align: right;">--</td>
						<%	}
						 
						 
						 
						 
						 
						 while(rs1.next())
					   {
							 String name=rs1.getString(1);
								name = name.substring(0,1).toUpperCase() + name.substring(1).toLowerCase();
					   
					   %>
							 <td class="<%=style%> "style="text-align: right;"><%=name%>/<%=rs1.getString(2)%></td> 

					  <%  }rs1.close();
					  ps1.close();
					}else
					{%>
					<td class="<%=style%> "style="text-align: right;">--</td>	
					<%}
					%>
					<td class="<%=style%> "style="text-align: right;"><%=rs.getString(21)%></td> 
					<td class="<%=style%> "style="text-align: right;"><%=rs.getString(22)%></td> 
					<%
					File stheImage2in  = new File(sapp+rs.getString(11)+"insp.jpg");
			
					if(stheImage2in.getAbsoluteFile().exists())
					{
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"insp.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"insp.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"insp.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					%> 
					
					<!-- <td class=gridhdbg rowspan="6">Approval Status</td> --> 
					
					<%if(rs.getString("APPROVEL_STATUS")!=null){
						
						if(rs.getString("approvedby")!=null && !rs.getString("approvedby").equalsIgnoreCase("--"))
						{
						if(rs.getString("approvedby").substring(1,3).equals("00"))
						{
							approved_by_office="Head Office User";
						}
						else if(rs.getString("approvedby").substring(3,6).equals("000")) 
						{
							approved_by_office="Circle Office User";
							}
						else if(rs.getString("approvedby").substring(4,6).equals("00")) 
						{
							approved_by_office="Division Office User";
							}
						else
						{
							approved_by_office="Sub Division Office User";
							}
						
						}else
						{
							approved_by_office="--";
						}
						
}
						%>
					
					
					<%if(rs.getString("APPROVEL_STATUS")!=null){ %>
					<%if(rs.getString("APPROVEL_STATUS").equalsIgnoreCase("Y")){ %>
					<td class="<%=style%> "style="text-align: left;"><font color="green">Approved <font color="black">By <font color="blue"><%=approved_by_office%>(<%=rs.getString("approvedby")%>)</td>
					<%}else if(rs.getString("APPROVEL_STATUS").equalsIgnoreCase("N")){ %>
					<td class="<%=style%> "style="text-align: left;"><font color="red">Disapproved <font color="black">By <font color="blue"><%=approved_by_office%>(<%=rs.getString("approvedby")%>)</td>
					<%}else { %>
					<td class="<%=style%> "style="text-align: right;">---</td> 
					<%} %>
					
					 
					<%}else{ %>
					<td class="<%=style%> "style="text-align: right;">--</td> 
					<%} %>
					
						<%-- 		<td colspan=3  align="center">
		
		
		
			<input type=button id="approve"  onclick="viewWorks('rws_tanker_movement_approval_status.jsp?status=approval&tripId=<%=rs.getString(11)%>')"  class=btext value="Approve">
			<input type=button id="disapprove"  onclick="viewWorks('rws_tanker_movement_approval_status.jsp?status=disapproval&tripId=<%=rs.getString(11)%>')"  class=btext value="Disapprove">
			
		
			
			
			
			<!-- <input type=button id="circ" onclick="fnSubmit()" value="Get Data" class = btext> -->
			
		
			
		</td> --%>
					
					
					</tr><%}rs.close();	 	    
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
    
  

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>