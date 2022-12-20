
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<script type="text/javascript">
	function viewWorks(URL) {
		
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>

<style>
.thumbnail {
	position: relative;
	z-index: 0;
}

.thumbnail:hover {
	z-index: 50;
	cursor: pointer;
}

.thumbnail span { /*CSS for enlarged image*/
	position: absolute;
	left: -9999px;
	background-color: #eae9d4;
	padding: 10px;
	font-family: 'Droid Sans', sans-serif;
	font-size: .9em;
	text-align: center;
	color: #495a62;
	-webkit-box-shadow: 0 0 20px rgba(0, 0, 0, .75));
	-moz-box-shadow: 0 0 20px rgba(0, 0, 0, .75);
	box-shadow: 0 0 20px rgba(0, 0, 0, .75);
	-webkit-border-radius: 8px;
	-moz-border-radius: 8px;
	border-radius: 8px;
}

.thumbnail span img {
	padding: 2px;
	background: #ccc;
}

.thumbnail:hover span {
	top: -10px;
	left: -500px;
	width: 50px;
	height: 50px;
}
</style>

<%
String dcode=request.getParameter("dcode");
String mcode=request.getParameter("mcode");
String pcode=request.getParameter("pcode");
String dname=request.getParameter("dname");
String mname=request.getParameter("mname");
String pname=request.getParameter("pname");
String scheme=request.getParameter("scheme");

String typeOfasset=request.getParameter("typeOfasset");
String assetStatus=request.getParameter("assetStatus");

String startDate=request.getParameter("startDate");
String endDate=request.getParameter("endDate");
String startyear=request.getParameter("startyear");
String endyear=request.getParameter("endyear");
String asset_code="";
asset_code=request.getParameter("asset_code");

String whereCondition="";
String message="";
String month=request.getParameter("month");
String monthQuery="";
if(month!=null && month!=""){
monthQuery=" and to_char(b.UPDATE_DATE,'MON')='"+month+"'";
}
if(dcode!=null && dcode!="" && mcode!=null && mcode!="" && pcode!=null && pcode!=""){
	
	whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' and substr(a.hab_code,13,2)='"+pcode+"' ";

	message="Asset Functional Status for "+scheme+" From: "+startDate+" To: "+endDate;
	if(month!=null && month!=""){
		 message+=" And Month: "+month;
	} 
	message+=" For District: "+dname+", Mandal: "+mname+" And Panchayat: "+pname;
}

else if(dcode!=null && dcode!="" && mcode!=null && mcode!="" ){
	
	whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' ";
	
	message="Asset Functional Status for "+scheme+" From: "+startDate+" To: "+endDate;
	if(month!=null && month!=""){
		 message+=" And Month: "+month;
	} 
	message+=" For District: "+dname+" And Mandal: "+mname;
	
}
else if(dcode!=null && dcode!=""){
	
	whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' ";
	message="Asset Functional Status for "+scheme+" From: "+startDate+" To: "+endDate;
	
	if(month!=null && month!=""){
		 message+=" And Month: "+month;
	} 
	message+=" For District: "+dname+"";
}
if(assetStatus==null || assetStatus==""){
	

}
 %>
<form>
	<table border=1 cellspacing=0 cellpadding=0 width="100%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
			<table border=0 rules=none style="border-collapse: collapse"
				align="right">
				<tr align="right">
					<td class="bwborder"><a
						href="javascript:onclick=history.go(-1)">Back| <a href="#"
							onClick="window.close();">Close</a></td>
				</tr>
			</table>
		</caption>

	</table>
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
		style="border-collapse: collapse" ALIGN=CENTER>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="gridhdbg" colspan="15"><%=message %></td>
		</tr>
		<tr align=center>
			<td class=gridhdbg><b>SLNO </b></td>
			<td class=gridhdbg><b>Asset Code </b></td>
			<td class=gridhdbg><b>Asset Name </b></td>
			<td class=gridhdbg><b>Location </b></td>
			<td class=gridhdbg><b>Asset Cost </b></td>
			<%	if(assetStatus!=null && assetStatus!=""){%>
			<td class=gridhdbg><b>Latitude </b></td>
			<td class=gridhdbg><b>Longitude </b></td>
			<td class=gridhdbg><b>Image </b></td>
			<%	}else{ %>
			<td class=gridhdbg><b>Asset Status </b></td>
				<%if(asset_code!=null && !asset_code.equals("") ) {%>
					<td class=gridhdbg><b>Inspected Date </b></td>
			<%	}else{%>
					<td class=gridhdbg><b>Inspected during <%=startyear %> - <%=endyear %></b></td>
				<%} %>
			<%} %>
			<%if(assetStatus!=null && assetStatus.equals("2")){ %>
			<td class=gridhdbg><b>Comp Code </b></td>
			<td class=gridhdbg><b>Comp Name </b></td>
			<td class=gridhdbg><b>Comp Location </b></td>
			<td class=gridhdbg><b>Repair Type </b></td>
			<td class=gridhdbg><b>Repair Cost </b></td>
			<td class=gridhdbg><b>Repair Date </b></td>
			<td class=gridhdbg><b>Update Date </b></td>
			<td class=gridhdbg><b>Comp Latitude</b></td>
			<td class=gridhdbg><b>Comp Longitude </b></td>
			<td class=gridhdbg><b>Comp Image </b></td>
			<%} %>
		</tr>
		<%
	Statement  statement=null,statement1=null,statement2=null;
	ResultSet  resultSet=null,resultSet1=null,resultSet2=null;
	try
      { 		
		int count=1;      
       statement=conn.createStatement();		
      String query="";
		if(assetStatus!=null && assetStatus!=""){
			query="select a.ASSET_CODE as ASSET_CODE,ASSET_NAME,nvl(LOCATION,' ') as LOCATION,ASSET_COST,ASSET_LAT,ASSET_LON from RWS_ASSET_MAST_TBL a,RWS_ASSET_IMAGE_TBL b where a.ASSET_CODE=b.ASSET_CODE and TYPE_OF_ASSET_CODE='"+typeOfasset+"' and ASSET_STATUS='"+assetStatus+"' and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+"";
		}
		else{
			query="select a.ASSET_CODE as ASSET_CODE,ASSET_NAME,nvl(LOCATION,' ') as LOCATION,ASSET_COST,nvl(decode(ASSET_STATUS,1,'WORKING',2,'NOT WORKING',3,'DRIED',4,'SEASONAL',5,'CONDEMED'),' ') as ASSET_STATUS from RWS_ASSET_MAST_TBL a,RWS_COMPLETE_HAB_VIEW b where a.HAB_CODE=b.PANCH_CODE and TYPE_OF_ASSET_CODE='"+typeOfasset+"' and "+whereCondition+" ";
			if(asset_code!=null && !asset_code.equals("")){
				query="select a.ASSET_CODE as ASSET_CODE,ASSET_NAME,nvl(LOCATION,' ') as LOCATION,ASSET_COST,nvl(decode(c.ASSET_STATUS,1,'WORKING',2,'NOT WORKING',3,'DRIED',4,'SEASONAL',5,'CONDEMED'),' ') as ASSET_STATUS,inspect_date from RWS_ASSET_MAST_TBL a,RWS_COMPLETE_HAB_VIEW b,rws_asset_inspection_tbl c where a.asset_code=c.asset_code and  a.HAB_CODE=b.PANCH_CODE and TYPE_OF_ASSET_CODE='"+typeOfasset+"' and "+whereCondition+" and to_date(inspect_date,'dd-mm-yyyy') between to_date('01-04-"+startyear+"','dd-mm-yyyy') and to_date('31-03-"+endyear+"','dd-mm-yyyy') and a.asset_code='"+asset_code+"' order by to_date(inspect_date,'dd-mm-yyyy') desc";
			}
		}
       resultSet=statement.executeQuery(query);
       int styleCount=0,inspCount=0;
   		StringBuffer style=new StringBuffer();
       while(resultSet.next())
       {
    	   if(assetStatus!=null && assetStatus!=""){}
    	   else{
    		   if(asset_code!=null && !asset_code.equals("")){}else{
		    	   String inspCountQry="select  count(*) from RWS_ASSET_MAST_TBL a,rws_asset_inspection_tbl b where a.ASSET_CODE=b.ASSET_CODE and  a.asset_code='"+resultSet.getString("asset_code")+"' and to_date(inspect_date,'dd-mm-yyyy') between to_date('01-04-"+startyear+"','dd-mm-yyyy') and to_date('31-03-"+endyear+"','dd-mm-yyyy')  ";
		    	  // System.out.println(inspCountQry);
		    	   statement2=conn.createStatement();
		           resultSet2=statement2.executeQuery(inspCountQry);
		           while(resultSet2.next()){
		        	   inspCount=resultSet2.getInt(1);
		           }
		           statement2.close();
		           resultSet2.close();
		    	   }
    	   }
    	   
    	   if(styleCount%2==0){
				 style.delete(0,style.length());
				 style.append("gridbg1");
			 }else{
				 style.delete(0,style.length());
				 style.append("gridbg2");
			 }
			 styleCount++;
			 boolean flag=false;
		        %>
		<%if(assetStatus!=null && assetStatus.equals("2")){ 
		             String notWorkingComp="select SOURCE_CODE,LOCATION,SOURCE_NAME,NVL(COMPO_LAT,0) AS COMPO_LAT,NVL(COMPO_LON,0) AS COMPO_LON,NVL(REPAIR_CODE,0) as REPAIR_CODE,NVL(REPAIR_COST,0) as REPAIR_COST,NVL(TO_CHAR(REPAIR_DATE,'DD/MM/YYYY'),'--') AS REPAIR_DATE,TO_CHAR(UPDATE_DATE,'DD/MM/YYYY') AS UPDATE_DATE,IMG_SIZE from RWS_AST_ALL_COMP_ALL_IMG_VIEW a,RWS_ASSET_COMPONENT_REPAIR_TBL b where a.ASSET_CODE=b.ASSET_CODE and a.SOURCE_CODE=b.ASSET_COMP_CODE and a.ASSET_CODE='"+resultSet.getString("ASSET_CODE")+"'";
		             statement1=conn.createStatement(java.sql.ResultSet.TYPE_FORWARD_ONLY,java.sql.ResultSet.CONCUR_READ_ONLY);
		             resultSet1=statement1.executeQuery(notWorkingComp);
		             String sou_code="";
		             while(resultSet1.next()){
		            	 flag=true;
		            	 if(sou_code.equals("")){
		            %>
		<tr>
			<td class=<%=style.toString() %> style="text-align: left;"><%=count++%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_CODE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("LOCATION")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_COST")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_LAT")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_LON")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><a
				class="thumbnail" href="#"><img
					src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>&mode=component"
					width="30px" height="30px" border="0" /><span><img
						src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>&mode=component"
						width="350px" height="230px" /></span></a></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("SOURCE_CODE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("SOURCE_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("LOCATION")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("REPAIR_CODE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("REPAIR_COST")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("REPAIR_DATE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("UPDATE_DATE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("COMPO_LAT")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("COMPO_LON")%></td>
			<%if(resultSet1.getInt("IMG_SIZE")==0){ %>
			<td class=<%=style.toString() %> style="text-align: left;">Image
				not Exist</td>
			<%}else{ %>
			<td class=<%=style.toString() %> style="text-align: left;"><a
				class="thumbnail" href="#"><img
					src="../../masters/image.jsp?assetCode=<%=resultSet.getString("ASSET_CODE")%>&imgID=<%=resultSet1.getString("SOURCE_CODE")%>&mode=component"
					width="30px" height="30px" border="0" /><span><img
						src="../../masters/image.jsp?assetCode=<%=resultSet.getString("ASSET_CODE")%>&imgID=<%=resultSet1.getString("SOURCE_CODE")%>&mode=component" /></span></a></td>
			<%} %>
		</tr>
		<%
		            	 }else{%>
		<tr>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("SOURCE_CODE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("SOURCE_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("LOCATION")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("REPAIR_CODE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("REPAIR_COST")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("REPAIR_DATE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("UPDATE_DATE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("COMPO_LAT")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getString("COMPO_LON")%></td>
			<%if(resultSet1.getInt("IMG_SIZE")==0){ %>
			<td class=<%=style.toString() %> style="text-align: left;">Image
				not Exist</td>
			<%}else{ %>
			<td class=<%=style.toString() %> style="text-align: left;"><a
				class="thumbnail" href="#"><img
					src="../../masters/image.jsp?assetCode=<%=resultSet.getString("ASSET_CODE")%>&imgID=<%=resultSet1.getString("SOURCE_CODE")%>&mode=component"
					width="30px" height="30px" border="0" /><span><img
						src="../../masters/image.jsp?assetCode=<%=resultSet.getString("ASSET_CODE")%>&imgID=<%=resultSet1.getString("SOURCE_CODE")%>&mode=component" /></span></a></td>
			<%} %>
		</tr>
		<% }
			    	sou_code=resultSet1.getString("SOURCE_CODE");
		             }
			    	
			    	if(flag==false){
		             
		             %>
		<tr>
			<td class=<%=style.toString() %> style="text-align: left;"><%=count++%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_CODE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("LOCATION")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_COST")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_LAT")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_LON")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><a
				class="thumbnail" href="#"><img
					src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>&mode=component"
					width="30px" height="30px" border="0" /><span><img
						src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>&mode=component"
						width="350px" height="230px" /></span></a></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
			<td class=<%=style.toString() %> style="text-align: left;"></td>
		</tr>
		<%
		             }
       				}
		             else{
		             if(assetStatus!=null && !assetStatus.equals("2")){ 
		             %>
		<tr>
			<td class=<%=style.toString() %> style="text-align: left;"><%=count++%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_CODE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("LOCATION")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_COST")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_LAT")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_LON")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><a
				class="thumbnail" href="#"><img
					src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>&mode=component"
					width="30px" height="30px" border="0" /><span><img
						src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>&mode=component"
						width="350px" height="230px" /></span></a></td>

		</tr>
		<%}
		             else{
		            	 %>
		<tr>
			<td class=<%=style.toString() %> style="text-align: left;"><%=count++%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_CODE")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("LOCATION")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_COST")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_STATUS")%></td>
			<%if(asset_code!=null && !asset_code.equals("")){ %>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("inspect_date")%></td>
			<%}else{ %>
			<td class=<%=style.toString() %> style="text-align: left;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=<%=typeOfasset %>&scheme=<%=scheme %>&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>&startyear=<%=startyear%>&endyear=<%=endyear%>&asset_code=<%=resultSet.getString("ASSET_CODE")%>')"><%=inspCount%></a></td>
			<%} %>
		</tr>
		<% 
		             }
		             }
		           }
					statement.close();
					resultSet.close();

      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	finally
	{
		 StringBuffer qry=null; 
		  StringBuffer qry1=null;  
	       StringBuffer distname1=null; 
	       StringBuffer distname2=null; 
	     
	}
	%>

	</table>
</form>

