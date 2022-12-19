<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="org.json.JSONObject"%>

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
    String dcode=request.getParameter("districts");
    session.setAttribute("dcode", dcode);    
    String fromdate=request.getParameter("fromDate1");
    session.setAttribute("fromdate", fromdate);
 //   System.out.println("fromdate$ "+fromdate);
    String todate=request.getParameter("toDate1");
    session.setAttribute("todate", todate);
    //String status=request.getParameter("status");
    //session.setAttribute("status", status);
	String mcode=request.getParameter("mandals");
	session.setAttribute("mcode", mcode);
	/* String habcode=request.getParameter("habitation");
	session.setAttribute("habcode", habcode); */
    String panchcode=request.getParameter("panchayats");
    session.setAttribute("panchcode",panchcode );
    String tanker=request.getParameter("tanker");
    session.setAttribute("tanker",tanker );
  //String type=request.getParameter("type");
    //session.setAttribute("type",type );
    
    String dname=String.valueOf(session.getAttribute("dName")) ;
    session.setAttribute("dName", dname);
	String mname=session.getAttribute("mName").toString();
	session.setAttribute("mName", mname);
	String panchname ="-Select-";
	if(session.getAttribute("pName") != null)
    panchname=session.getAttribute("pName").toString();
    session.setAttribute("pName",panchname );
   /*  if(session.getAttribute("tName") != null)
    tanker=session.getAttribute("tName").toString();
    session.setAttribute("tName",tanker ); */
    /* if(session.getAttribute("hName") != null)
    habName=session.getAttribute("hName").toString();
	session.setAttribute("hName", habName); */
    String trip_id="";
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
		</tr></table>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
	<tr align="right">
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  </td>
	</tr>  
	</table>
	</table>
	</caption>
	<table width="80%" border=1 style="border-color: gray; border-collapse:collapse; border-bottom-width: 0px;">
	<tr align="center" >
	   <td colspan="4"  style="font-weight: 600; font-size: 11px;">District    :  <font size="2px;" style="color: #7a0a20">  <%=dname%> </font> </td>
	   <%
   if(mname != null && !mname.equalsIgnoreCase("-Select-")){ 
	   %>
  <td colspan="4" style="font-weight: 600; font-size: 11px;">Mandal   :   <font size="2px;" style="color: #7a0a20"> <%=mname %></font> </td>
  <% } if(panchname != null && !panchname.equalsIgnoreCase("-Select-")){ 
	   %>
   <td colspan="4" style="font-weight: 600; font-size: 11px;">Panchayat   :  <font size="2px;" style="color: #7a0a20">  <%=panchname %> </font></td>
   <%}  if(tanker != null && !tanker.equalsIgnoreCase("-Select-")){ %>
  <td  colspan="4" style="font-weight: 600; font-size: 11px;">Tanker No.   :  <font size="2px;" style="color: #7a0a20">  <%=tanker %></font> </td>
  <%} %>
  </tr>
	</table>
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
  <!--  <tr align=center> -->
   <%
   if(!fromdate.isEmpty()||!todate.isEmpty()){ 
	   %>
	   <tr align=center>
	       	 		<td class="gridhdbg" colspan="30"><b>Tanker Movement Details   (From:<%=fromdate %> To:<%=todate %>)</b></td>
	   </tr>
	   
    	 <% }else 
    	 {%>
    	  <tr align=center>
    	 	   		<td class="gridhdbg" colspan="30"><b>Tanker Movement Details </b></td>
    	  </tr>
	  
    	 <%}
    
   %>
    
	 <tr>
	<td class=gridhdbg >Sl.No</td>
    <td class=gridhdbg >Tanker Reg. No.</td>
    <td class=gridhdbg >Source Latitude</td>
    <td class=gridhdbg >Source Longitude</td>
    <td class=gridhdbg >Destination Latitude</td>
    <td class=gridhdbg >Destination Longitude</td>
    <td class=gridhdbg >Calculated Distance(in Km)</td>
    </tr>
   
       	<%
       	PreparedStatement pstmt=null;
       	       try
		{
       	    
    	 if(!fromdate.isEmpty()||!todate.isEmpty()){  
       	  
	   str="select a.TANKER_REG_NO,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(SOURCE_CODE,'--'),TANKER_SOURCE_LAT,TANKER_SOURCE_LOG,nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),TRIP_ID,	nvl(dest_habitation,'--'),999  as totalseconds,nvl(to_char(TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(INSP_MOBILE,'--'),nvl(to_char(INSPECTION_DATE ,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(INSP_MOBILE,'--'),c.panch_code,c.panch_name,a.APPROVEL_STATUS "  
			   +",nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate,TANKER_TRIP_DISTANCE from RWS_TANKER_MOVEMENT_TBL a,rws_complete_hab_view c  where  a.tanker_reg_no=? and substr(a.dest_habitation,1,16)=c.panch_code   and substr(a.dest_habitation,1,2)=? and substr(a.dest_habitation,6,2)=? and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date(?,'dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy') order by a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc ";
	   
	   pstmt=conn.prepareStatement(str);  
	   
	   pstmt.setString(1,tanker );
	   pstmt.setString(2, dcode);
	   pstmt.setString(3, mcode);
	   pstmt.setString(4, fromdate);
	   pstmt.setString(5,todate );
	   
	
		//System.out.println("dcode :"+dcode+" mcode:"+mcode+" fromdate:"+fromdate+" todate:"+todate);
    	 }else
    	 {
    		 str="select a.TANKER_REG_NO,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(SOURCE_CODE,'--'),TANKER_SOURCE_LAT,TANKER_SOURCE_LOG,nvl(TANKER_DEST_LAT,0),nvl(TANKER_DEST_LOG,0),nvl(TANKER_TRIP_DISTANCE,0),nvl(TANKER_ARIAL_DISTANCE,0),TRIP_ID,nvl(dest_habitation,'--'),999  as totalseconds,nvl(to_char(TANKER_TRIP_END_DATE_TIME),'--') as isStarted ,nvl(INSP_MOBILE,'--'),nvl(to_char(INSPECTION_DATE ,'dd/mm/yyyy HH:MI:SS AM'),'--'),nvl(INSP_MOBILE,'--'),c.panch_code,c.panch_name,a.APPROVEL_STATUS "  
    				   +",nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as strDate,nvl(to_char(TANKER_TRIP_END_DATE_TIME,'dd/mm/yyyy HH24:MI:SS'),'--') as endDate,TANKER_TRIP_DISTANCE from RWS_TANKER_MOVEMENT_TBL a,rws_complete_hab_view c  where  a.tanker_reg_no=? and substr(a.dest_habitation,1,16)=c.panch_code   and substr(a.dest_habitation,1,2)=? and substr(a.dest_habitation,6,2)=?  order by a.tanker_reg_no,a.TANKER_TRIP_START_DATE_TIME desc ";
    		   
    		 pstmt=conn.prepareStatement(str); 
    		  pstmt.setString(1,tanker );
    		   pstmt.setString(2, dcode);
    		   pstmt.setString(3, mcode);
    		 
    	 }
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
			 styleCount++;
			 
			 if(styleCount==30)
			 {
				break; 
			 }
			 if(slno==30)
			 {
				break; 
			 }
			 if(rs.getString(5)!=null &&!rs.getString(5).equals("0")&&rs.getString(6)!=null && !rs.getString(6).equals("0")&& rs.getString(7) !=null &&!rs.getString(7).equals("0")&&rs.getString(8)!=null &&!rs.getString(8).equals("0"))
			 { 
			 %>
			 
			 
			 <tr>
			<td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
					 
					   <td class="<%=style%> "style="text-align: center;"><%=rs.getString(1)%></td> 
					  <td class="<%=style%> "style="text-align: center;"><%=rs.getString(5)%></td>
					  <td class="<%=style%> "style="text-align: center;"><%=rs.getString(6)%></td>
					  <%-- <td class="<%=style%> "style="text-align: left;"><%=rs.getString(6)%></td> --%>
					 <td class="<%=style%> "style="text-align: center;"><%=rs.getString(7)%></td> 
					 <td class="<%=style%> "style="text-align: center;"><%=rs.getString(8)%></td> 
					<%  
					URL url = new URL("https://noc.ap.nic.in/sless/sdistance?srcLat="+rs.getString(5)+"&srcLon="+rs.getString(6)+"&destLat="+rs.getString(7)+"&destLon="+rs.getString(8));
					HttpURLConnection connHttp = (HttpURLConnection) url.openConnection();
					connHttp.setRequestMethod("GET");
					connHttp.setRequestProperty("Accept", "application/json");
					if (connHttp.getResponseCode() != 200) {
						throw new RuntimeException("Failed : HTTP error code : " + connHttp.getResponseCode());
					}
					BufferedReader br = new BufferedReader(new InputStreamReader((connHttp.getInputStream())));
					String output;
					JSONObject jsonObj = null;
					while ((output = br.readLine()) != null) {
						jsonObj = new JSONObject(output);
						//message = jsonObj.getString("message");
						System.out.println("distance output :"+output);
					}
					%>
					<td class="<%=style%> "style="text-align: center;"><%=jsonObj.getString("distance") %></td> 
					
					</tr><%}}
		 
		 rs.close();	 	    
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
	</table>	
    
  

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>