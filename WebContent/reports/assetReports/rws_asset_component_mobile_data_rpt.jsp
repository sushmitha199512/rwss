<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script src = "https://maps.googleapis.com/maps/api/js"></script>
 <script type="text/javascript">
         /* function loadMap() {
			alert("hai");
            var mapOptions = {
               center:new google.maps.LatLng(19.373341, 78.662109),
               zoom:7
            }
			var map = new google.maps.Map(document.getElementById("sample"),mapOptions);
               var marker = new google.maps.Marker({
               position: new google.maps.LatLng(17.088291, 78.442383),
               map: map,
            });
         } */
      </script>

<script language="JavaScript">

        function viewWorks(URL)
        {

            var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
            if (URL != "")
            {
                myNewWin = window.open(URL, 'newWinddow', popFeatures);
                myNewWin.focus();
            }
        }
        </script>
        <style>
        /***Override the styling of images set in step 3 to make the frame smaller and the background darker***/
        ul.enlarge span img{
        padding: 2px; /*size of the frame*/
        background: #ccc; /*colour of the frame*/
        }
        /***Style the <span> containing the framed images and the caption***/
        ul.enlarge span{
        /**Style the frame**/
        padding: 10px; /*size of the frame*/
        background:#eae9d4; /*colour of the frame*/
        /*add a drop shadow to the frame*/
        -webkit-box-shadow: 0 0 20px rgba(0,0,0, .75));
        -moz-box-shadow: 0 0 20px rgba(0,0,0, .75);
        box-shadow: 0 0 20px rgba(0,0,0, .75);
        /*give the corners a curve*/
        -webkit-border-radius: 8px;
        -moz-border-radius: 8px;
        border-radius:8px;
        /**Style the caption**/
        font-family: 'Droid Sans', sans-serif; /*Droid Sans is available from Google fonts*/
        font-size:.9em;
        text-align: center;
        color: #495a62;
        }
</style>
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
    <BODY >
<form>
<%
String mcode="",pcode="",district="",type="",tempconst="";
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
String longitute=null, latitute=null,assetName=null,date_Of_Creation=null,asset_Cost=null,asset_location=null;
if(request.getParameter("mandal")!=null){
 mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);}
if(request.getParameter("panchayath")!=null){
 pcode=request.getParameter("panchayath");
session.setAttribute("pcode",pcode);}
DecimalFormat ndf = new DecimalFormat("####.##");
type=request.getParameter("type");
session.setAttribute("type",type);
String findimage=request.getParameter("findimage");
session.setAttribute("findimage",findimage);
//System.out.println("find image"+findimage);
int styleCount=0;
String style="";
int sno=1;
String dataQuery="";
String dataQuery1="";
String dataQuery2="";
String dname="",mname="",pname="";
    try{
		if(dcode !=null && !dcode.equals("")){
    		
    		dataQuery="select dname from rws_district_tbl where dcode='"+dcode+"'" ;
		}
    	if(mcode !=null && !mcode.equals("")){
    		dataQuery1="select mname from rws_mandal_tbl where dcode='"+dcode+"' and mcode='"+mcode+"'";
		}
		if(pcode !=null && !pcode.equals("")){
			dataQuery2="select pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"'";
		}			
    	Statement statement=conn.createStatement();
    	ResultSet resultSet=statement.executeQuery(dataQuery);
    	if(resultSet.next()){
    		dname=resultSet.getString("dname");
    	}
    	resultSet.close();
    	statement.close();
    	if(mcode !=null && !mcode.equals("")){
    	Statement statement1=conn.createStatement();
    	ResultSet rs1=statement1.executeQuery(dataQuery1);
    	if(rs1.next()){
    		mname=rs1.getString("mname");
    	}
    	rs1.close();
    	statement1.close();
       	}
    	if(pcode !=null && !pcode.equals("")){
    	Statement statement2=conn.createStatement();
    	ResultSet rs2=statement2.executeQuery(dataQuery2);
    	if(rs2.next()){
    		pname=rs2.getString("pname");
    	}
    	rs2.close();
    	statement2.close();
    	}
    }
    catch(Exception e){
    	e.printStackTrace();
    }
    	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back |&nbsp; </td>
	<td><a href="./rws_asset_component_mobile_data_xls.jsp">Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="gridhdbg" > Assets and Components - Image Status
	<br/>District: <%=dname %> 
	<% if(mcode !=null && !mcode.equals("")){%> And Mandal: <%=mname %> <%} %>
	<% if(pcode !=null && !pcode.equals("")){%> And Panchayat: <%=pname %> <%} %>
	</td>
	</tr>
    
	</table>
   <%if(type.equals("Assets")){ String status="--"; %>
   <table width="60%" border=0 style="border-collapse:collapse"  ALIGN=CENTER >    
	<tr>	
	 	<th class=gridhdbg>Sl.No</th>
	    <th class=gridhdbg>Asset Code</th>
	    <th class=gridhdbg>Asset Name</th>
	    <th class=gridhdbg>Asset Location</th>
	    <th class=gridhdbg>Panchayat</th>
	    <th class=gridhdbg>Village</th>
	    <th class=gridhdbg>Hab Code / Hab Name</th>
	    <th class=gridhdbg>Latitude</th>
	    <th class=gridhdbg>Longitude</th>
	    <th class=gridhdbg>Updated Date</th>
	    <th class=gridhdbg>Image</th>
	    <th class=gridhdbg>Location</th>
	</tr>
<%

String assetStatus="";
try
{
	Statement st1=null,st=null,statement=null;
	ResultSet rset=null,rset1=null,resultSet=null;
	st1=conn.createStatement();
	String assetsQuery="select a.ASSET_CODE,nvl(ASSET_NAME,'--') as ASSET_NAME,nvl(LOCATION,'--') as LOCATION,nvl(ASSET_STATUS,0) as ASSET_STATUS,nvl(ASSET_COST,0) as ASSET_COST,nvl(START_YEAR,'--') as START_YEAR,type_of_asset_name,pname,vname,panch_code,panch_name from RWS_ASSET_MAST_TBL a,RWS_ASSET_SCHEME_TBL b,rws_asset_type_tbl c,rws_complete_hab_view d where a.asset_code=b.asset_code and a.type_of_asset_code=c.type_of_asset_code and a.hab_code=d.panch_code AND A.TYPE_OF_ASSET_CODE IN (01,02,03,09) and dcode='"+dcode+"'";
	if(mcode !=null && !mcode.equals("")){
		assetsQuery+=" and mcode='"+mcode+"'";
	}
	if(pcode !=null && !pcode.equals("")){
		assetsQuery+=" and pcode='"+pcode+"'";
	}
	assetsQuery+=" order by a.type_of_asset_code";
	//System.out.println("111="+assetsQuery);
	rset1=st1.executeQuery(assetsQuery);
	String typeOfAsset="";
	if(!rset1.next()){
		%>
		<tr>
			<td class="<%=style%> "style="text-align: center;" colspan="15"> No records Available</td>
		</tr>
		<%	}else{
				do{		if(styleCount%2==0){
							 style="gridbg1";
						 }else{
							 style="gridbg2";
						 }
					    styleCount++;
					 String assetImage="SELECT ASSET_LAT,ASSET_LON,TO_CHAR(UPDATE_DATE,'DD/MM/YYYY') AS UPDATE_DATE, NVL(DBMS_LOB.GETLENGTH(ASSET_IMAGE),0) AS IMG_SIZE FROM RWS_ASSET_IMAGE_TBL WHERE ASSET_CODE='"+rset1.getString("ASSET_CODE")+"'";
					 statement=conn.createStatement();
					 resultSet=statement.executeQuery(assetImage);
					 if(resultSet.next()){
						 	int b=resultSet.getInt("IMG_SIZE");
					        if(b==0){
								status="noView";
							}
							else{
								status="View";
							}							       						
			if(findimage.equalsIgnoreCase("Assets With Images")){ 
				if(status.equals("View")){
		%>
		<tr>        		
			 <td class="<%=style%>" style="text-align: right;"> <%=sno++%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("VNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PANCH_CODE")%> &nbsp;/ <%=rset1.getString("PANCH_NAME")%></td>
		     <td class="<%=style%>" style="text-align: left;"> <%=resultSet.getString("ASSET_LAT")%></td>
		     <td class="<%=style%>" style="text-align: left;"> <%=resultSet.getString("ASSET_LON")%></td>
			 <td class="<%=style%>" style="text-align: right;" > <%=resultSet.getString("UPDATE_DATE")%></td>
		     <td class="<%=style%>" ><a class="thumbnail"  href="#"><img src="../../masters/image.jsp?imgID=<%=rset1.getString("ASSET_CODE")%>&mode=component"  width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?imgID=<%=rset1.getString("ASSET_CODE")%>&mode=component"  width="350px" height="230px"/></span></a></td>
			 <td class="<%=style%>" style="text-align: right;"><a href='#' onclick='javascript:window.open("rws_Asset_Component_Image_view_map.jsp?latCode=<%=resultSet.getString("ASSET_LAT")%>&longCode=<%=resultSet.getString("ASSET_LON")%>&assetName=<%=rset1.getString("ASSET_NAME")%>&habName=<%=rset1.getString("PANCH_NAME")%>&location=<%=rset1.getString("LOCATION")%>", "_blank", "scrollbars=1,resizable=1,height=300,width=450");' title='Pop Up'>View</a></td>
		</tr>
		<%} 
			}else if(findimage.equalsIgnoreCase("empty")){ 
				if(status.equals("View")){
		%>
		<tr>
			 <td class="<%=style%>" style="text-align: right;"> <%=sno++%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("VNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PANCH_CODE")%> &nbsp;/ <%=rset1.getString("PANCH_NAME")%></td>
		     <td class="<%=style%>" style="text-align: left;"> <%=resultSet.getString("ASSET_LAT")%></td>
		   	 <td class="<%=style%>" style="text-align: left;"> <%=resultSet.getString("ASSET_LON")%></td>
			 <td class="<%=style%>" style="text-align: right;" ><%=resultSet.getString("UPDATE_DATE")%></td>
		     <td class="<%=style%>" ><a class="thumbnail"  href="#"><img src="../../masters/image.jsp?imgID=<%=rset1.getString("ASSET_CODE")%>&mode=component"  width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?imgID=<%=rset1.getString("ASSET_CODE")%>&mode=component"  width="350px" height="230px"/></span></a></td>
			 <td class="<%=style%>" style="text-align: right;"><a href='#' onclick='javascript:window.open("rws_Asset_Component_Image_view_map.jsp?latCode=<%=resultSet.getString("ASSET_LAT")%>&longCode=<%=resultSet.getString("ASSET_LON")%>&assetName=<%=rset1.getString("ASSET_NAME")%>&habName=<%=rset1.getString("PANCH_NAME")%>&location=<%=rset1.getString("LOCATION")%>", "_blank", "scrollbars=1,resizable=1,height=300,width=450");' title='Pop Up'>View</a></td>
		</tr>
		<%		}if(status.equals("noView")){%>
		<tr>
			 <td class="<%=style%>" style="text-align: right;"> <%=sno++%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("VNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PANCH_CODE")%> &nbsp;/ <%=rset1.getString("PANCH_NAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
		</tr>
		<%		}
			}else if(findimage.equalsIgnoreCase("Assets Without Images")){ 
					if(status.equals("noView")){
			%>
			<tr>
			 <td class="<%=style%>" style="text-align: right;"> <%=sno++%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("VNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PANCH_CODE")%> &nbsp;/ <%=rset1.getString("PANCH_NAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
		</tr>
		<%	} }else{%>
		<tr>			
				<td class="<%=style%>" style="text-align: left;" colspan="12"> No records</td>
			</tr>
		<%}}else{if( findimage.equalsIgnoreCase("empty") || findimage.equalsIgnoreCase("Assets Without Images")){ %>
			<tr>
			 <td class="<%=style%>" style="text-align: right;"> <%=sno++%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("VNAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> <%=rset1.getString("PANCH_CODE")%> &nbsp;/ <%=rset1.getString("PANCH_NAME")%></td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
			 <td class="<%=style%>" style="text-align: left;"> --</td>
		</tr>
		<%	}
			}
				}while(rset1.next());		
					rset1.close();
					st1.close();
				}
			}catch(Exception e){
				e.printStackTrace();
			}%>
</table>
<%}else if(type.equals("Components")){
	 byte brr[]=null;
	 OutputStream o=null;
	 %>
	   <table width="60%" border=0 style="border-collapse:collapse"  ALIGN=CENTER >
	    <tr>
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Asset Code / Component Code</td>
	    <td class=gridhdbg>Asset Name</td>
	   <!--  <td class=gridhdbg>Component Code</td> -->
	    <td class=gridhdbg>Component Location</td>
	    <td class=gridhdbg>Panchayat</td>
	    <td class=gridhdbg>Village</td>
	    <td class=gridhdbg>Hab Code / Hab Name</td>
	    <td class=gridhdbg>Latitude</td>
	    <td class=gridhdbg>Longitude</td>
	    <td class=gridhdbg>Updated Date</td>
	    <td class=gridhdbg>Image</td>
	    <td class=gridhdbg>Location</td>
		</tr>
	<%
	String assetStatus="";
	try
	{
		Statement st1=null,st=null,statement=null;
		ResultSet rset=null,rset1=null,resultSet=null;
		st1=conn.createStatement();
		String Query="select ASSET_CODE,ASSET_NAME,SOURCE_CODE,LOCATION,substr(SOURCE_CODE,1,16) as habcode,hab_name,pname,vname,ASSET_COST,TO_char(UPDATE_DATES,'dd/MM/yyyy') as UPDATE_DATES,COMPO_LAT,COMPO_LON,img_size from RWS_AST_COMP_ALL_IMG_VIEW where dcode='"+dcode+"' ";
		
				if(mcode !=null && !mcode.equals("")){
					Query+=" and mcode='"+mcode+"'";
				} 
				if(pcode !=null && !pcode.equals("")){
					Query+=" and pcode='"+pcode+"'";
				}
				if(findimage.equalsIgnoreCase("empty"))
				{
				Query+=" order by TO_DATE(UPDATE_DATES,'DD-MM-YYYY') desc nulls last";
				}
				/* if(findimage.equalsIgnoreCase("Assets Without Images"))
				{
				Query+=" order by TO_DATE(UPDATE_DATES,'DD-MM-YYYY') desc ";
				} */
				if(findimage.equalsIgnoreCase("Assets With Images"))
				{
					Query+=" ORDER BY TO_DATE(UPDATE_DATES,'DD-MM-YYYY') desc";
				}
       		 //System.out.println("Query is "+Query);
       		//System.out.println("findimage "+findimage);
		String status="--";
		rset1=st1.executeQuery(Query);
		if(!rset1.next()){%>
		<tr>
		 <td class="<%=style%> "style="text-align: left;" colspan="12"> No records</td>
	 </tr>
	<%}
		else{
		do{	
			
			if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;			
			 int b=rset1.getInt("img_size");
	        if(b==0){
	        	status="noView";
			}
			else{
				status="View";
			}
	      //  System.out.println("status"+status);
	        %><tr><%			
	        if(findimage.equalsIgnoreCase("Assets With Images")){ %>			 
				 <%if(status.equals("View")){%>
				 <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%> &nbsp;/<%=rset1.getString("SOURCE_CODE")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("pname")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("vname")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("habcode")%> &nbsp;/ <%=rset1.getString("hab_name")%></td>
			     <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("COMPO_LAT")%></td>
			     <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("COMPO_LON")%></td>
				 <td class="<%=style%> "style="text-align: right;" > <%=rset1.getString("UPDATE_DATES")%></td>
			     <td class="<%=style%> "><a class="thumbnail"  href="#"><img src="../../masters/image.jsp?assetCode=<%=rset1.getString("ASSET_CODE")%>&imgID=<%=rset1.getString("SOURCE_CODE")%>&mode=component"  width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?assetCode=<%=rset1.getString("ASSET_CODE")%>&imgID=<%=rset1.getString("SOURCE_CODE")%>&mode=component"/></span></a></td>
				 <td class="<%=style%> "style="text-align: right;"><a href='#' onclick='javascript:window.open("rws_Asset_Component_Image_view_map.jsp?latCode=<%=rset1.getString("COMPO_LAT")%>&longCode=<%=rset1.getString("COMPO_LON")%>&assetName=<%=rset1.getString("ASSET_NAME")%>&habName=<%=rset1.getString("hab_name")%>&location=<%=rset1.getString("LOCATION")%>", "_blank", "scrollbars=1,resizable=1,height=300,width=450");' title='Pop Up'>View</a><!-- <div id = "sample"  style = "width:100px; height:100px;"></div> -->  </td>
				<%} 
			}else if(findimage.equalsIgnoreCase("empty")){ %>
			 	 <%if(status.equals("View")){%>
				 <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%> &nbsp;/<%=rset1.getString("SOURCE_CODE")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("pname")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("vname")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("habcode")%> &nbsp;/ <%=rset1.getString("hab_name")%></td>
			     <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("COMPO_LAT")%></td>
			   	 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("COMPO_LON")%></td>
				 <td class="<%=style%> "style="text-align: right;" > <%=rset1.getString("UPDATE_DATES")%></td>
			     <td class="<%=style%> "><a class="thumbnail"  href="#"><img src="../../masters/image.jsp?assetCode=<%=rset1.getString("ASSET_CODE")%>&imgID=<%=rset1.getString("SOURCE_CODE")%>&mode=component"  width="30px" height="30px" border="0" /><span><img src="../../masters/image.jsp?assetCode=<%=rset1.getString("ASSET_CODE")%>&imgID=<%=rset1.getString("SOURCE_CODE")%>&mode=component"/></span></a></td>
				 <td class="<%=style%> "style="text-align: right;"><a href='#' onclick='javascript:window.open("rws_Asset_Component_Image_view_map.jsp?latCode=<%=rset1.getString("COMPO_LAT")%>&longCode=<%=rset1.getString("COMPO_LON")%>&assetName=<%=rset1.getString("ASSET_NAME")%>&habName=<%=rset1.getString("hab_name")%>&location=<%=rset1.getString("LOCATION")%>", "_blank", "scrollbars=1,resizable=1,height=300,width=450");' title='Pop Up'>View</a><!-- <div id = "sample"  style = "width:100px; height:100px;"></div> -->  </td>
				<%}if(status.equals("noView")){%>
				 <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%> &nbsp;/<%=rset1.getString("SOURCE_CODE")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("pname")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("vname")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("habcode")%> &nbsp;/ <%=rset1.getString("hab_name")%></td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				 <td class="<%=style%> "style="text-align: left;" > --</td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				<%}
				}else if(findimage.equalsIgnoreCase("Assets Without Images")){ 
				   if(status.equals("noView")){%>
				 <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("ASSET_CODE")%> &nbsp;/<%=rset1.getString("SOURCE_CODE")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("ASSET_NAME")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("LOCATION")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("pname")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("vname")%></td>
				 <td class="<%=style%> "style="text-align: left;"> <%=rset1.getString("habcode")%> &nbsp;/ <%=rset1.getString("hab_name")%></td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				 <td class="<%=style%> "style="text-align: left;"> --</td>
				<%}
			 }else{%>			
				 <td class="<%=style%> "style="text-align: left;" colspan="12"> No records</td>
			<%}
		}while(rset1.next());	
			rset1.close();
			st1.close();
			 %>
			</tr>
					
		<%	
		
		}
	
	}
	catch(Exception e)
			{
			e.printStackTrace();
			}

	finally{
		if(conn!=null){
			conn.close();
		}
	}
	
	%>
	  </table> 
	
	<%
} //else ending%>
</form>
</BODY>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>

