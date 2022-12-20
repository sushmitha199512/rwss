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
<%@page import="org.json.JSONArray"%>
<%@page import="javax.ws.rs.client.Client"%>
<%@page import="javax.ws.rs.client.ClientBuilder"%>
<%@page import="javax.ws.rs.client.Entity"%>
<%@page import="javax.ws.rs.client.WebTarget"%>
<%@page import="javax.ws.rs.core.MediaType"%>


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
    System.out.println("%%%%%%%%%%%%%%%%%%%%%%"+tanker);
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
    <td class=gridhdbg >Original Image.</td>
    <td class=gridhdbg >Compressed Image</td>
    <!-- <td class=gridhdbg >Source Longitude</td>
    <td class=gridhdbg >Destination Latitude</td>
    <td class=gridhdbg >Destination Longitude</td>
    <td class=gridhdbg >Calculated Distance(in Km)</td> -->
    </tr>
   
       	<%
        double oriSize =0,compSize=0;
       	String originalSize="",compressedSize="";
      // 	tanker="AP03TA5310";
       	try{
    	URL url = new URL("https://rwss.ap.gov.in/RwsRest/RestFul/RwsWaterTankerService/tankerTripsImg");
		HttpURLConnection connHttp = (HttpURLConnection) url.openConnection();
		connHttp.setRequestMethod("POST");
		connHttp.setRequestProperty("Content-Type", "application/json");
		connHttp.setDoOutput(true);
		String input = "{\"tankerNo\":\""+tanker+"\"}";
		  OutputStream os = connHttp.getOutputStream();
		    os.write(input.getBytes());
		    os.flush();
		    os.close();
		   
		    int responseCode = connHttp.getResponseCode();
		    JSONObject  resObj = null ;
		    if(responseCode == 200){
		    	BufferedReader br = new BufferedReader(new InputStreamReader((connHttp.getInputStream())));
				String output;
				
				while ((output = br.readLine()) != null) {
					resObj = new JSONObject(output);
					System.out.println("output :"+resObj);
				}
		    }
				JSONArray jArray = resObj.getJSONArray("DATA");
				JSONObject jsonObj;
		         int j=0;
		         for(int i=0;i<jArray.length();i++) {
		       	  if(j>=20)
					  break;
		       	jsonObj = jArray.getJSONObject(i);
		       	  
if(!jsonObj.isNull("SOURCEIMG1") && jsonObj.getString("SOURCEIMG1").trim().length()>0) {
					//System.out.println("inside source img1"); 

					String imageName = j+".jpg";
					/* java.nio.charset.StandardCharsets */
					input = "{\"encFile\":\""+jsonObj.getString("SOURCEIMG1")+"\",\"fileName\":\""+imageName+"\"}";
				
					/* JSONObject compJson = null;
				
					 Client client = ClientBuilder.newClient();
					    //sending to test1
					    WebTarget target = client.target("https://noc.ap.nic.in/sless/scompress");

					    String resp = target.request()
					                            .post(Entity.entity(input, MediaType.APPLICATION_JSON_TYPE), String.class);
					    compJson = new JSONObject(resp); */
					    url = new URL("https://noc.ap.nic.in/sless/scompress");
						connHttp = (HttpURLConnection) url.openConnection();
						connHttp.setRequestMethod("POST");
						
						connHttp.setDoOutput(true);
						connHttp.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
						connHttp.connect();
						  OutputStream osComp = connHttp.getOutputStream();
						  osComp.write(input.getBytes());
					   /*  try(OutputStream osComp = connHttp.getOutputStream()) {
					    	osComp.write(input);
					    }catch(Exception e){
					    	e.printStackTrace();
					    } */
					    osComp.write(input.getBytes());
					    osComp.flush();
					    osComp.close();
					   
					    responseCode = connHttp.getResponseCode();
					    JSONObject  compJson = null ;
					    if(responseCode == 200){
					    	BufferedReader br = new BufferedReader(new InputStreamReader((connHttp.getInputStream())));
							String output;
							
							while ((output = br.readLine()) != null) {
								compJson = new JSONObject(output);
								System.out.println("output comp :"+compJson);
							}
					    }
					   
					    oriSize =0;compSize=0;
					    originalSize ="";compressedSize="";
				        if(!compJson.isNull("compSize")) {
				        	compSize = Double.parseDouble(compJson.getString("compSize").replace("kb", ""));
				       
				        }
				        if(!compJson.isNull("originalSize")) {
				        	oriSize = Double.parseDouble(compJson.getString("originalSize").replace("kb", ""));
				        }
				        if(oriSize<compSize) {
				        	originalSize = compSize +" kb";
				        	compressedSize = oriSize+ " kb";
				        	
				        }else{
				        	originalSize = oriSize +" kb";
				        	compressedSize = compSize+ " kb";
				        
				        }
					    
						%>
						<tr>
						<td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
						<td class="<%=style%>  "style="text-align: center;"><div style="width:100%; text-align:center; height: 70%">
                  <h5 style="font-weight: 900;"><b><%= compJson.getString("originalSize") %></b></h5><img src="data:image/jpg;base64,<%= jsonObj.getString("SOURCEIMG1") %>" width="240" height="300"/></div></td>
					<td class="<%=style%>  "style="text-align: center;"><div style="width:100%; text-align:center; height: 70%">
                  <h5 style="font-weight: 900;"><b><%= compJson.getString("compSize") %></b></h5><img src="data:image/jpg;base64,<%= compJson.getString("encFile") %>" width="240" height="300"/></div></td>
					</tr>
						<%
						j++;
						//System.out.println("sorce image 1 output :"+output);
					}


				
		         }
       	
		
		 /* String distance = "0";
		
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++; */
			 
		 
			 	    
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
	
    
  

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>