<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

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
<form>
<%
 


    Statement stmt1=null;
	ResultSet rs1=null;
	int slno=0;
    String qry="", str="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
   
    String status=request.getParameter("status");
   
	
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
	
		
		
		</tr></table>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<td ><a href="#" onClick="window.close();">Close</a>  </td>

	 
	</tr>  
	
	 
	</table>
	</caption>
	
	</table>
	
	
	
		<% if(status.equals("tanker")){
		  String tankerregno=request.getParameter("regno"); 
				
		 %>
   
   <table width="75%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="14"><b>Tanker Registration Details</b></td>
		
		</tr>
  
	 <tr>
	
	<td class=gridhdbg>Sl.No</td>
	<td class=gridhdbg>District</td>
	<td class=gridhdbg>Mandal</td>
	<td class=gridhdbg>Panchayat</td>
	<td class=gridhdbg>Village</td>
	<td class=gridhdbg>HabCode/<br/>HabName</td>
	<td class=gridhdbg>Registration No.</td>
	<td class=gridhdbg>RC No.</td>
    <td class=gridhdbg>RC Name</td>
	<td class=gridhdbg>Capacity in KLTS</td>
	<td class=gridhdbg>Owner Name</td>
	<td class=gridhdbg>Owner Aadhar</td>
    <td class=gridhdbg>Mobile</td>
    <td class=gridhdbg>Remarks</td>
    
	
       </tr>
       
       	<%
       try
		{
    	 
    	   
	
	   str="select TANKER_REG_NO,TANKER_CAPACITY_IN_KLTS,TANKER_OWNER_NAME,TANKER_OWNER_AADHAAR,TANKER_OWNER_MOBILE,HABITATION_CODE,NVL(REMARKS,'--'),TANKER_RC_NO,TANKER_RC_NAME from  RWS_TANKER_REG_TBL  where TANKER_REG_NO='"+tankerregno+"'";
		
	      
		 stmt1=conn.createStatement();
	   
	     
		 rs=stmt1.executeQuery(str);
		 while(rs.next())
	   {
			 String query="select dname,mname,pname,vname,panch_name,panch_code from rws_district_tbl a,rws_mandal_tbl b,rws_panchayat_tbl c,rws_village_tbl d,rws_panchayat_raj_tbl e where a.dcode=b.dcode and a.dcode=c.dcode and a.dcode=d.dcode and a.dcode=substr(e.panch_code,1,2) and b.mcode=c.mcode and b.mcode=d.mcode and b.mcode=substr(e.panch_code,6,2) and c.pcode=d.pcode and c.pcode=substr(e.panch_code,13,2) and d.vcode=substr(e.panch_code,8,3) and e.panch_code='"+rs.getString(6)+"'";
			// System.out.println("222222222222:"+query);
			 stmt=conn.createStatement();
			 rs1=stmt.executeQuery(query);
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
		   %>
              
              <tr>
              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
              <%if(rs1.next()){ %>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(1)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(2)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(3)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(4)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(5)%>/<br/><%=rs1.getString(6)%></td>
			  <%} %>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(1)%></td>
			  <td class="<%=style%> "style="text-align: right;"><%=rs.getString(8)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(9)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(5)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(7)%></td>
			 			
				</tr>
              
              
              
              
		    <%
	   }
		
		%> 
		<%   
	   } catch(Exception e)
	   {
	   e.printStackTrace();
	   }
	   finally{
		  
	   conn.close();
	   }
		
	   %>
	
    
</table>
		<%
		}else if(status.equals("source")){
			String sourceCode=request.getParameter("sourceCode");
		 %>
   
   <table width="75%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="14"><b>Source Details</b></td>
		
		</tr>
  
	 <tr>
	
	<td class=gridhdbg>Sl.No</td>
	<td class=gridhdbg>District</td>
	<td class=gridhdbg>Mandal</td>
	<td class=gridhdbg>Panchayat</td>
	<td class=gridhdbg>Village</td>
	<td class=gridhdbg>HabCode/<br/>HabName</td>
	<td class=gridhdbg>Source Code</td>
	<td class=gridhdbg>Location</td>
	<%if(sourceCode.substring(16,21).equals("PVTHP")){ %>
    <td class=gridhdbg>Owner Name</td>
	<td class=gridhdbg>Mobile</td>
	<%} %>
    <td class=gridhdbg>Latitude</td>
    <td class=gridhdbg>Longitude</td>
    <%if(sourceCode.substring(16,21).equals("PVTHP")){%>
    <td class=gridhdbg>Image</td>
    <%} %>
	
       </tr>
       
       	<%
       try
		{
    	 
    	   
	if(sourceCode.substring(16,21).equals("PVTHP")){
		//System.out.println("inside if");
	   str="SELECT SOURCE_CODE AS SOURCE_CODE,SOURCE_LOCATION AS LOCATION,SOURCE_OWNER_NAME,SOURCE_OWNER_MOBILE,SOURCE_IMG_LAT AS LATITUDE,SOURCE_IMG_LOG AS LONGITUDE FROM RWS_PVT_SOURCES_TBL WHERE SOURCE_CODE='"+sourceCode+"' ";
	  // System.out.println(str+"");
	}
	else{
		if(sourceCode.substring(19,21).equals("HP")){
			str="SELECT HP_CODE AS SOURCE_CODE,nvl(LOCATION,'--') AS LOCATION,LATITUDE,LONGITUDE FROM RWS_HP_SUBCOMP_PARAM_TBL WHERE HP_CODE='"+sourceCode+"' ";
		}
		else if(sourceCode.substring(19,21).equals("SH")){
			str="SELECT SHALLOWHP_CODE AS SOURCE_CODE,nvl(LOCATION,'--') AS LOCATION,LATITUDE,LONGITUDE FROM RWS_SHALLOWHANDPUMPS_TBL WHERE SHALLOWHP_CODE='"+sourceCode+"' ";
		}
		else if(sourceCode.substring(19,21).equals("OW")){
			str="SELECT OPENWELL_CODE AS SOURCE_CODE,nvl(LOCATION,'--') AS LOCATION,LATITUDE,LONGITUDE FROM RWS_OPEN_WELL_MAST_TBL WHERE OPENWELL_CODE='"+sourceCode+"' ";
		}
		else if(sourceCode.substring(19,21).equals("SO")){
			str="SELECT SOURCE_CODE AS SOURCE_CODE,nvl(LOCATION,'--') AS LOCATION,LATITUDE,LONGITUDE FROM RWS_SOURCE_TBL WHERE SOURCE_CODE='"+sourceCode+"' ";
		}
	}
	      
		 stmt1=conn.createStatement();
	   
	     
		 rs=stmt1.executeQuery(str);
		 while(rs.next())
	   {
			 String habcode=rs.getString(1).substring(0,16);
			 String query="select dname,mname,pname,vname,panch_name,panch_code from rws_district_tbl a,rws_mandal_tbl b,rws_panchayat_tbl c,rws_village_tbl d,rws_panchayat_raj_tbl e where a.dcode=b.dcode and a.dcode=c.dcode and a.dcode=d.dcode and a.dcode=substr(e.panch_code,1,2) and b.mcode=c.mcode and b.mcode=d.mcode and b.mcode=substr(e.panch_code,6,2) and c.pcode=d.pcode and c.pcode=substr(e.panch_code,13,2) and d.vcode=substr(e.panch_code,8,3) and e.panch_code='"+habcode+"'";
			 
			// System.out.println("222222222222:"+query);
			 stmt=conn.createStatement();
			 rs1=stmt.executeQuery(query);
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
		   %>
              
              <tr>
              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
              <%if(rs1.next()){ %>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(1)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(2)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(3)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(4)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(5)%>/<br/><%=rs1.getString(6)%></td>
			  <%} %>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString("SOURCE_CODE")%></td>
			  <td class="<%=style%> "style="text-align: right;"><%=rs.getString("LOCATION")%></td>
			  <%if(sourceCode.substring(16,21).equals("PVTHP")){ %>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString("SOURCE_OWNER_NAME")%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString("SOURCE_OWNER_MOBILE")%></td>
			  <%} %>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString("LATITUDE")%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString("LONGITUDE")%></td>
			  <%-- <%if(sourceCode.substring(16,21).equals("PVTHP")){ %>			 		
 
			 				     <td class="<%=style%>" ><a class="thumbnail"  href="#"><img src="../../reports/smsmobile/rws_tanker_image_view.jsp?status=sourceImg&sourceCode=<%=rs.getString(1)%>"  width="30px" height="30px" border="0" /><span><img src="../../reports/smsmobile/rws_tanker_image_view.jsp?status=sourceImg&sourceCode=<%=rs.getString(1)%>"  width="350px" height="230px"/></span></a></td>
 		 		
			 		
			 		<%} %>	 --%>
			 		
			 					  <%if(sourceCode.substring(16,21).equals("PVTHP")){ 
			  
			  
			  String imagePath=getServletContext().getRealPath("/") ;
				 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
					 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
					 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
					 imagePath = sample[0];
					 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
				 }else{
					 String sample[]  = imagePath.split( "webapps");
					// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
					 imagePath = sample[0];
					//System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
				 }
				 imagePath = imagePath+ File.separator+"PrivateSourceImages";
			  	String spath1 = imagePath+ File.separator+rs.getString("SOURCE_CODE")+".jpg";
				String is1=File.separator+"PrivateSourceImages"+File.separator+rs.getString("SOURCE_CODE")+".jpg";
				//System.out.println("spath1	"+spath1);
				//System.out.println("is1	"+is1);
				File stheImage1  = new File(spath1);
				//System.out.println("img1 absolute path :"+stheImage1.getAbsoluteFile());
				//System.out.println("@@@@@@@@@@ "+pageContext.request.contextPath);
				if(stheImage1.getAbsoluteFile().exists())
				{
					//System.out.println("img1 absolute path : in if"+stheImage1.getAbsoluteFile());
					   %> 
						<%-- <td class="<%=style%>" ><a class="thumbnail"  href="#"><img src="${pageContext.request.contextPath}<%=is1%>"  width="60px" height="60px" border="0" /><span><img src="${pageContext.request.contextPath}<%=is1%>" width="350px" height="230px"/></span></a></td> --%> 
                        <td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/smsmobile/rws_private_source_Image.jsp?imageId=<%=rs.getString("SOURCE_CODE")%>"
															width="60px" height="60px" border="0" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/smsmobile/rws_private_source_Image.jsp?imageId=<%=rs.getString("SOURCE_CODE")%>"
																 id="bigImage" width="350px" height="230px"/></span></a></td>
					<%}
					else
					{
					%>
						  <td class="<%=style%> "style="text-align: right;">--</td> 
					<%}
			  
			  
		
			 		} %>
				</tr>
              
              
              
              
		    <%
	   }
		
		%> 
		<%   
	   } catch(Exception e)
	   {
	   e.printStackTrace();
	   }
	   finally{
		  
	   conn.close();
	   }
		
	   %>
	
    
</table>
		<%	
		}
		%>
    
  </form>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>