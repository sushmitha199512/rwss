<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<% String pgNo =null; %>
<head>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> --><!-- Commented on 22-04-2022 for Security Audit-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"  integrity="sha384-MBO5IDfYaE6c6Aao94oZrIOiC6CGiSN2n4QUbHNPhzk5Xhm0djZLQqTpL0HzTUxk" crossorigin="anonymous"></script>
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
 
function fnSubmit(tripId){
	   
    //document.forms[0].action="./rws_tanker_movement_drill1_rpt.jsp?status=update";
    //var tId=document.getElementById("tid").value;
    alert(tripId+'');
   
   //var tid=document.f1.tid.value;
   //alert(tid);
    document.forms[0].action="./rws_tanker_movement_approval_status.jsp?status=approval&tripId="+tripId;
   // &name2="+name2
	document.forms[0].submit();  
 
	//window.close();
 
}
function fnSubmit1(tripId){
	   
    //document.forms[0].action="./rws_tanker_movement_drill1_rpt.jsp?status=update";
    //document.forms[0].action="./rws_tanker_movement_approval_status.jsp?status=disapproval";
    document.forms[0].action="./rws_tanker_movement_approval_status.jsp?status=disapproval&tripId="+tripId;
	document.forms[0].submit();  
 
	//window.close();
 
}


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
//String itype;
	ResultSet rs1=null;
   PreparedStatement ps1=null;
    int slno=0;
    String qry="",qry1="",str="", str1="",qr="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
    String dcode=request.getParameter("dcode");
    session.setAttribute("dcode", dcode);
    //System.out.println("dcode"+dcode);
    String dname=request.getParameter("dname");
    session.setAttribute("dname", dname);
    //System.out.println("dname"+dname);
    String fromdate=request.getParameter("fromdate");
    
    session.setAttribute("fromdate", fromdate);
   // System.out.println("fromdate"+fromdate);
    String todate=request.getParameter("todate");
    
    session.setAttribute("todate", todate);
  //  System.out.println("todate"+todate);
    String status=request.getParameter("status");
    session.setAttribute("status", status);
   // System.out.println("status"+status);
	String mcode=request.getParameter("mcode");
	session.setAttribute("mcode", mcode);
	
	String habcode=request.getParameter("habcode");
	session.setAttribute("habcode", habcode);
	String habName=request.getParameter("habname");
	session.setAttribute("habname", habName);
	 // System.out.println("mcode"+mcode);
	String mname=request.getParameter("mname");
	session.setAttribute("mname", mname);
	
    String type=request.getParameter("type");
    session.setAttribute("type",type );

    String panchname=request.getParameter("panchname");
    session.setAttribute("panchname",panchname );
    
    String villagename=request.getParameter("villagename");
    session.setAttribute("villagename",villagename );
    
    //String pgNo = request.getParameter("pgno");
    String actTotal = request.getParameter("total");
   
    double total = Math.ceil(Integer.parseInt(request.getParameter("total"))/100.0); 
    
    String approved_by_office="";
	String trip_id="";
	
	 /* String dt = todate; 
    	   SimpleDateFormat sdf1 = new SimpleDateFormat("dd/mm/yyyy");
    	   Calendar c = Calendar.getInstance();
    	   c.setTime(sdf1.parse(dt));
    	   c.add(Calendar.DATE, 1);  
    	   dt = sdf1.format(c.getTime());   */
   	if(request.getParameter("pgNo") != null)
   		pgNo = request.getParameter("pgNo").toString();
   		
   	int prevPGNO = 0;
   		if(pgNo == null){
   			pgNo = "1";
   			prevPGNO = 0;
   		}else
   			prevPGNO = Integer.parseInt(pgNo)-1;
   		//nextPGNO = Integer.parseInt(pgNo)+1;
   		
   		slno =  prevPGNO*100;
   		
   		//System.out.println("pgNo pages :"+pgNo+"  nextPGNO :"+prevPGNO+" param "+request.getParameter("pgNo"));
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
		</tr></table>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">

	<tr align="right">
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<!-- <td ><a href="javascript:onclick=history.go(-1)">Back  </td> --> 
	 <td ><a href="rws_tanker_movement_drill_rpt.jsp?mode1=hab&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>">Back  </td>  
	</tr>  
	</table>
	</table>
	</caption>
<table width="100%" border=1 style="border-color: gray; border-collapse:collapse; border-bottom-width: 0px;">
	<tr align="center" >
	   <td colspan="4"  style="font-size: 11px; font-weight: 600;">District    :  <font size="2px;" style="color: #7a0a20">  <%=dname%> </font> </td>
	   <%
   if(mname != null && !mname.equalsIgnoreCase("-Select-")){ 
	   %>
  <td colspan="4" style="font-size: 11px; font-weight: 600;">Mandal   :   <font size="2px;" style="color: #7a0a20"> <%=mname %></font> </td>
  <% } if(panchname != null && !panchname.equalsIgnoreCase("-Select-")){ 
	   %>
   <td colspan="4" style="font-size: 11px; font-weight: 600;">Panchayat   :  <font size="2px;" style="color: #7a0a20">  <%=panchname %> </font></td>
   <%} if(villagename != null && !villagename.equalsIgnoreCase("-Select-"))
	 { %>
  <td colspan="4" style="font-size: 11px; font-weight: 600;">Vill.Name   :  <font size="2px;" style="color: #7a0a20">  <%=villagename %> </font></td> 
  <%} if(habName != null && !habName.equalsIgnoreCase("-Select-")){ %>
  <td  colspan="4" style="font-size: 11px; font-weight: 600;">Hab.Name   :  <font size="2px;" style="color: #7a0a20">  <%=habName %></font> </td>
  <%} %>
  </tr>
	</table>
<div id="tabs" >
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center bordercolor="#436f8a" style="  border: none; border-color:#0f4c75; ">
		<td class="gridhdbg" colspan="30" style="background-color:#436f8a; border: none; border-color:#0f4c75; "><b>Tanker Movement Details  </b> &nbsp; (From:<%=fromdate %> To:<%=todate %>)</td>
		</tr>
  <%-- <tr align="center" bgcolor="green">
  <td class="gridhdbg" colspan="7" style=" padding-top:10px; padding-bottom:10px; background-color:#436f8a"><font size="2px;" style="color: #e8eddf">District    :  </font>  <%=dname%>  </td>
  <td class="gridhdbg" colspan="7" style=" padding-top:10px; padding-bottom:10px; background-color:#436f8a"><font size="2px;" style="color: #e8eddf">Habitaion   :  </font>  <%=habName %> / <%=habcode%> </td>
  <td class="gridhdbg" colspan="16"/>
  </tr> --%>
	 <tr>
	<td class=gridhdbg rowspan="2">Sl.No</td>
    <!-- <td class=gridhdbg rowspan="2">Habitation Code/</br>Habitation Name</td> -->
    <td class=gridhdbg rowspan="2">Tanker Reg. No.</td>
    <td class=gridhdbg rowspan="2">Source Code</td>
    <td class=gridhdbg rowspan="2">Trip Id</td>
    <td class=gridhdbg colspan="5" style="background-color: #4e83a3;">Source</td>
    <td class=gridhdbg colspan="6" style="background-color: #798794;">Destination</td>
<!--     <td class=gridhdbg rowspan="2">Distance</td> -->
    <td class=gridhdbg rowspan="2">Aerial Distance(in Km)</td>
    
    <td class=gridhdbg rowspan="2">Trip Duration</td>
    <td class=gridhdbg rowspan="2">Trip Status</td>
    <td class=gridhdbg colspan="4">Inspection Details</td>
    <td class=gridhdbg rowspan="2">Approval Status</td>
    <td class=gridhdbg rowspan="2">Approval Status Update</td>
    
    </tr>
    <tr>
    <td class=gridhdbg style="background-color: #4e83a3;">Date</td>
    <td class=gridhdbg style="background-color: #4e83a3;">Latitude/Longitude</td>
    <td class=gridhdbg style="background-color: #4e83a3;">Source Image 1</td>
    <td class=gridhdbg style="background-color: #4e83a3;">Source Image 2</td>
    <td class=gridhdbg style="background-color: #4e83a3;">Source Image 3</td>
    <td class=gridhdbg style="background-color: #798794;">Date</td>
    <td class=gridhdbg style="background-color: #798794;">Habitation</td><!-- bhagya -->
    <td class=gridhdbg style="background-color: #798794;">Latitude/Longitude</td>
   
     <td class=gridhdbg style="background-color: #798794;">Dest Image 1</td>
    <td class=gridhdbg style="background-color: #798794;">Dest Image 2</td>
    <td class=gridhdbg style="background-color: #798794;">Dest Image 3</td>
    <td class=gridhdbg >Inspected By</td>
    
    <td class=gridhdbg > Mobile</td>
    <td class=gridhdbg > Date</td>
    <td class=gridhdbg > Image</td>
       </tr>
       	<%
       try
		{	
    	   String sapp;
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
    	   if(dcode != null && dcode.equals("07") || dcode.equals("09") || dcode.equals("11") || dcode.equals("12") ){
    		   tableName = " RWS_TANKER_MOVEMENT_PVT_TBL ";
    	   } else{
    		   tableName = " RWS_TANKER_MOVEMENT_TBL ";
    	   } */
    	   
    	   str = "SELECT * FROM ( "+
    			  " SELECT  a.TANKER_REG_NO, nvl(to_char(a.TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'), nvl(to_char(a.TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(a.SOURCE_CODE,'--'), a.TANKER_SOURCE_LAT,a.TANKER_SOURCE_LOG,nvl(a.TANKER_DEST_LAT,0),nvl(a.TANKER_DEST_LOG,0),nvl(a.TANKER_TRIP_DISTANCE,0),nvl(a.TANKER_ARIAL_DISTANCE,0),a.TRIP_ID,nvl(a.dest_habitation,'--'),999  as totalseconds,nvl(to_char(a.TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(a.INSP_MOBILE,'--'),nvl(to_char(a.INSPECTION_DATE ,'dd/mm/yyyy HH:MI:SS AM'),'--'),a.APPROVEL_STATUS,nvl(to_char(a.TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(a.TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate,nvl(APPROVED_BY,'--') as approvedby, "+
    			      " row_number() over (ORDER BY a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc) line_number "+
    			   " FROM RWS_TANKER_MOVEMENT_TBL a where a.dest_habitation=? and to_date(to_char(a.TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date(?,'dd/mm/yyyy') and to_date(to_char(a.TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy') "+
    			" order by a.TANKER_TRIP_START_DATE_TIME,a.tanker_reg_no "+
    			"  ) WHERE line_number BETWEEN "+prevPGNO+"01 AND "+pgNo+"00 ORDER BY line_number";
	   ps=conn.prepareStatement(str);
	   //System.out.println("tanker query@@@@@@@@@@@ :"+str);
	   ps.setString(1, habcode);
	   ps.setString(2, fromdate);
	   ps.setString(3, todate);
		 rs=ps.executeQuery();
		 
		/*  int total1 = Integer.parseInt(total);
		 double total2 = Math.ceil(total1/100.0); 
		// System.out.println("total1 :"+total1+" total2:"+total2);
		 //System.out.println("total :"+total);*/
		
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
			
			 styleCount++;
			  String strtDate=rs.getString(2);
			   String stri[]=strtDate.split("/");
			   String day= stri[0];
			   String month= stri[1];
			   String year= stri[2].substring(0,4); 
			  // System.out.println("date in rept :"+strtDate);
			  // sapp = rootDir+ File.separator +"TankerImages"+ File.separator +year+ File.separator +month+ File.separator +day+File.separator ;
			  String imagesPath = File.separator+"mnt"+File.separator+"DATA-NAS"+ File.separator +"TankerImages";
			   sapp = imagesPath+ File.separator +year+ File.separator +month+ File.separator +day+File.separator ;
			   
			   
			   %>
			 <tr>
			<td class="<%=style%> "style="text-align: center;"><%=++slno%></td>

		             <%-- <td class="<%=style%> "style="text-align: left;"><%=habcode%>/<br><%=habName%></td> --%>
					  <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_tanker_movement_drill1_rpt.jsp?status=tanker&regno=<%=rs.getString(1)%>')"><%=rs.getString(1)%></a></td>
					 
					  <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_tanker_movement_drill1_rpt.jsp?status=source&sourceCode=<%=rs.getString(4)%>')"><%=rs.getString(4)%></a></td>
					 
<%-- 					
  <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_tanker_movement_drill1_rpt.jsp?status=approval&tripId=<%=rs.getString(11)%>&tripEndTime=<%=rs.getString(3)%>')"><%=rs.getString(11)%></a></td>
 --%>					
<%--   <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_tanker_movement_drill1_rpt.jsp?status=approval&tripId=<%=rs.getString(11)%>&hCode=<%=habcode%>&hName=<%=habName%>')"><%=rs.getString(11)%></a></td>
 --%>					  
					  <%-- <td class="<%=style%> "style="text-align: right;"><%=rs.getString(11)%></td> --%>
					  <td class="<%=style%> "style="text-align: right;"><%=rs.getString(11)%></td> 
					  <td class="<%=style%> "style="text-align: right;"><%=rs.getString(2)%></td>
					  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(5)%>/<br><%=rs.getString(6)%></td>
					<%
					//String spath1 = sapp+rs.getString(11)+"src1.jpg";
				//itype="src1.jpg";
				//String is1=File.separator+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator+rs.getString(11)+"src1.jpg";
				File stheImage1  = new File(sapp+rs.getString(11)+"src1.jpg");
				//System.out.println("img1 absolute path :"+stheImage1.getAbsoluteFile());
				if(stheImage1.getAbsoluteFile().exists())
				{
					//System.out.println("img1 absolute path : in if"+stheImage1.getAbsoluteFile());
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"src1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src1.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<% }
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					File stheImage2  = new File(sapp+rs.getString(11)+"src2.jpg");
					//itype="src2.jpg";
					//String is2=File.separator+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator+rs.getString(11)+"src2.jpg";

					//System.out.println("img1 absolute path :"+stheImage2.getAbsoluteFile());
					if(stheImage2.getAbsoluteFile().exists())
					{
						//System.out.println("img1 absolute path : in if"+stheImage2.getAbsoluteFile());
						
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"src2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src2.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					
					//ServletContext sapp2 = getServletContext();
					///String spath3 = sapp+rs.getString(11)+"src3.jpg";
					//itype="src3.jpg";
					File stheImage3  = new File(sapp+rs.getString(11)+"src3.jpg");
					//String is3=File.separator+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator+rs.getString(11)+"src3.jpg";
					//System.out.println("img1 absolute path :"+stheImage3.getAbsoluteFile());
					if(stheImage3.getAbsoluteFile().exists())
					{
						//System.out.println("img1 absolute path : in if"+stheImage3.getAbsoluteFile());
					   %> 
						<td class="<%=style%>" ><a class="thumbnail"  href="tankerImage.jsp?imageId=<%=rs.getString(11)+"src3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" target="blank"><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>"  width="60px" height="60px" border="0" /><span><img src="tankerImage.jsp?imageId=<%=rs.getString(11)+"src3.jpg"%>&year=<%=year%>&month=<%=month%>&day=<%=day%>" width="350px" height="230px"/></span></a></td> 

					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
					%> 
					 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(3)%></td> 

					 <%
					
					if(!rs.getString(12).equalsIgnoreCase("--"))
					{
					str1="select panch_name,panch_code  from rws_complete_hab_view where panch_code='"+rs.getString(12)+"'";
					//System.out.println("@@@@@@@$$$$$$$$$$$$$$$$**************%%%%%%%%%%%%"+str1);
					   ps1=conn.prepareStatement(str1);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
					   {
					   %>
							 <td class="<%=style%> "style="text-align: right;"><%=rs1.getString(1)%> / <%=rs1.getString(2)%></td> 
					  <%  }rs1.close();
					  ps1.close();
					}else
					{%>
						<td class="<%=style%> "style="text-align: right;">--</td>
					<%}
					%>

					 <td class="<%=style%> "style="text-align: left;"><%=rs.getString(7)%>/<br><%=rs.getString(8)%></td> 
					<%
					//ServletContext app = getServletContext();
					///String path1 = sapp+rs.getString(11)+"dest1.jpg";
					//itype="dest1.jpg";
					File theImage1 = new File(sapp+rs.getString(11)+"dest1.jpg");
					///String id1=File.separator+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator+rs.getString(11)+"dest1.jpg";

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
					
					//String path2 = sapp+rs.getString(11)+"dest2.jpg";
					//itype="dest2.jpg";
					File theImage2 = new File(sapp+rs.getString(11)+"dest2.jpg");
					//String id2=File.separator+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator+rs.getString(11)+"dest2.jpg";

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

					//String path3 = sapp+rs.getString(11)+"dest3.jpg";
					//itype="dest3.jpg";
					File theImage3 = new File(sapp+rs.getString(11)+"dest3.jpg");
					//String id3=File.separator+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator+rs.getString(11)+"dest3.jpg";

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
					 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(15)%></td>
					 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(16)%></td> --%>
					 <%if(rs.getString(10)!=null&&!rs.getString(10).isEmpty()){ 
					
					DecimalFormat decimalFormat=new DecimalFormat("####.##");
					if(Double.parseDouble(rs.getString(10))>999)
						distance = decimalFormat.format(Double.parseDouble(rs.getString(10))/1000.0);
					else
						distance = rs.getString(10);
				
					%>
		
					 <td class="<%=style%> "style="text-align: right;"><%=distance%></td> 
				
			<% 	}else{ %>
				
				
					 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(10) %></td>
					 <%} 
					  if(rs.getString("isStarted").equalsIgnoreCase("--")) {%>
					 <td class="<%=style%> "style="text-align: right;">--</td>
					 <td class="<%=style%> "style="text-align: right;"><font color="red">In Progress</font></td>

					 <%} else{
					 String s="";
					 try{
						 
						/*  String strtTime=rs.getString(2);
						 String endTime=rs.getString(3); */
						 
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
					 <%-- <td class="<%=style%> "style="text-align: right;">Completed</td> --%>
					 <td class="<%=style%> "style="text-align: right;"><font color="green">Completed</font></td>
					 
					 <%}
					 String pathWebcontent=request.getContextPath();
					
					if(!rs.getString(15).equalsIgnoreCase("--"))
					{
					str1="select  data_collector_name,designation  from rws_mobile_sms_register_tbl where mobile='"+rs.getString(15)+"'";
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
					<td class="<%=style%> "style="text-align: right;"><%=rs.getString(15)%></td> 
					<td class="<%=style%> "style="text-align: right;"><%=rs.getString(16)%></td> 

					<%
					//ServletContext sapp1in = getServletContext();
					//String spath2in = sapp+rs.getString(11)+"insp.jpg";
					//itype="insp.jpg";
					File stheImage2in  = new File(sapp+rs.getString(11)+"insp.jpg");

					///String ins=File.separator+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator+rs.getString(11)+"insp.jpg";

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
					<td class="<%=style%> "style="text-align: right;">--</td> 
					<%} %>
					
					 
					<%}else{ %>
					<td class="<%=style%> "style="text-align: right;">--</td> 
					<%} %>
					
					
					<%if(rs.getString("APPROVEL_STATUS")!=null){ %>
								<td  align="center">
			<input type=button id="approve" disabled="disabled" onclick="viewWorks('rws_tanker_movement_approval_status.jsp?status=approval&tripId=<%=rs.getString(11)%>')"  class=btext value="Approve">
			<input type=button id="disapprove" disabled="disabled" onclick="viewWorks('rws_tanker_movement_approval_status.jsp?status=disapproval&tripId=<%=rs.getString(11)%>')"  class=btext value="Disapprove">
		</td>
					
				<%} else{%>	
				<td  align="center">
			<input type=button id="approve" onclick="viewWorks('rws_tanker_movement_approval_status.jsp?status=approval&tripId=<%=rs.getString(11)%>')"  class=btext value="Approve">
			<input type=button id="disapprove"  onclick="viewWorks('rws_tanker_movement_approval_status.jsp?status=disapproval&tripId=<%=rs.getString(11)%>')"  class=btext value="Disapprove">
		</td> 
				<%} %>
					
 
			 </tr>

			<% 

		}rs.close();	 	    
		} catch(Exception e)
	   {
	   e.printStackTrace();
	   }
	   finally{
		   if(ps != null)
		  ps.close();
	   conn.close();
	   }
	   %>
	
    
</table>
</div>
<tr align="center">
<td>
<table>
<tr align="center"><% for(int i=1;i<=total;i++){ %>
<td>
<%-- <a href="#tabs"  onclick='refreshPage(<%= i %>);<%  request.setAttribute("pgNo", String.valueOf(i)); %>'><%= i %></a>
href="rws_tanker_movement_detailed_drill.jsp?&status=source&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=habcode%>&habname=<%=habName%>&total=<%= actTotal%>&pgNo=<%= i %>" --%>
  <a href="rws_tanker_movement_detailed_drill.jsp?&status=source&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=habcode%>&habname=<%=habName%>&total=<%= actTotal%>&pgNo=<%= i %>" ><%= i %></a>  
 </td> 
<%}  %>
</tr>
</table>
</td>
</tr>

	</table>	
    
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
<% System.gc(); %>
</p>