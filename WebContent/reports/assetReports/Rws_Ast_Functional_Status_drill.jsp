
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
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
<script type="text/javascript">
	function viewWorks(URL) {
		
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>

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
//System.out.println(whereCondition);


 %>
<form>
	<table border=1 cellspacing=0 cellpadding=0 width="100%" bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
		<br>
		<br>
			<table border=0 rules=none style="border-collapse: collapse" align="right">
				<tr align="right">
					<td class="bwborder"><a	href="javascript:onclick=history.go(-1)">Back| <a href="#"	onClick="window.close();">Close</a></td>
				</tr>			
			</table>
			<br>	
		</caption>
	</table>
	
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
		style="border-collapse: collapse" ALIGN=CENTER>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="gridhdbg" colspan="15"><%=message %></td>
		</tr>
		<tr align=center>
			<td class=gridhdbg rowspan=2><b>SL NO </b></td>
			<td class=gridhdbg rowspan=2><b>Type of Scheme</b></td>
			<td class=gridhdbg rowspan=2><b>Name of the Scheme </b></td>
			<td class=gridhdbg rowspan=2><b>Asset Code </b></td>
			<td class=gridhdbg colspan=4><b>Location </b></td>
			<td class=gridhdbg rowspan=2><b>No. of Habs water being	supplied </b></td>
			<td class=gridhdbg rowspan=2><b>Functional Status of Assets<br>(Working/Not	Working)</b></td>
			<td class=gridhdbg rowspan=2><b>Inspected by SE/EE/DEE/AE/Field Assitant </b></td>
			<td class=gridhdbg rowspan=2><b>Source test Results (to be uploaded) </b></td>
			<td class=gridhdbg rowspan=2><b>Image (Main Scheme)</b></td>
			<td class=gridhdbg rowspan=2><b>Image (Public Tap)</b></td>
		</tr>
		<tr align=center>
			<td class=gridhdbg rowspan=1><b>Mandal</b></td>
			<td class=gridhdbg rowspan=1><b>Panchayat</b></td>
			<td class=gridhdbg rowspan=1><b>Habitation</b></td>
			<td class=gridhdbg rowspan=1><b>Habitation Code</b></td>
		</tr>
		
		<%
			Statement  statement=null,statement1=null;
			ResultSet  resultSet=null,resultSet1=null;
			try
		      { 		
				int count=1;            
		       	statement = conn.createStatement();
				String query = "";
				query = "select c.TYPE_OF_ASSET_NAME,a.ASSET_CODE as ASSET_CODE,ASSET_NAME,d.MNAME,d.MNAME,d.PANCH_NAME,d.PANCH_CODE,decode(a.ASSET_STATUS,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') as status,nvl(INSPECTED_BY,'--') as INSPECTED_BY from "
						+" RWS_ASSET_MAST_TBL a,RWS_ASSET_IMAGE_TBL b,RWS_ASSET_TYPE_TBL c,RWS_COMPLETE_HAB_VIEW d where "
						+" a.HAB_CODE=d.PANCH_CODE and a.TYPE_OF_ASSET_CODE=c.TYPE_OF_ASSET_CODE and a.ASSET_CODE=b.ASSET_CODE and a.TYPE_OF_ASSET_CODE='"
						+ typeOfasset + "' and " + whereCondition
						+ " and to_date(b.UPDATE_DATE) between to_date('" + startDate + "','dd-mm-yyyy') and to_date('" + endDate + "','dd-mm-yyyy') " + monthQuery + "";
				System.out.println(query);
				resultSet = statement.executeQuery(query);
				int styleCount = 0;
				StringBuffer style = new StringBuffer();
				while (resultSet.next()) {
					if (styleCount % 2 == 0) {
						style.delete(0, style.length());
						style.append("gridbg1");
					} else {
						style.delete(0, style.length());
						style.append("gridbg2");
					}
					styleCount++;		               
		            %>
		<tr>
			<td class=<%=style.toString() %> style="text-align: left;"><%=count++%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("TYPE_OF_ASSET_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("ASSET_CODE")%></td>			
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("MNAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("MNAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("PANCH_NAME")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("PANCH_CODE")%></td>
			<%
			String No_of_habs="select count(*) from RWS_ASSET_HAB_TBL a,RWS_COMPLETE_HAB_VIEW b where a.HAB_CODE=b.PANCH_CODE and a.ASSET_CODE='"+resultSet.getString("ASSET_CODE")+"'";
			statement1=conn.createStatement();
			resultSet1=statement1.executeQuery(No_of_habs);
			if(resultSet1.next()){
				 /* if(resultSet1.getInt(1)>1){ */
				%> 									
				<td class=<%=style.toString() %> style="text-align: left;"><a href="#" onclick="viewWorks('Rws_Ast_Functional_Status_Habs_drill.jsp?asset_code=<%=resultSet.getString("ASSET_CODE")%>')"><%=resultSet1.getInt(1)%></td>
				<%/* }else{ */ %>
				<%-- <td class=<%=style.toString() %> style="text-align: left;"><%=resultSet1.getInt(1)%></td> --%>
				<%/* } */ %>
			<%}else{ %>
			<td class=<%=style.toString() %> style="text-align: left;">0</td>
			<%} 
			resultSet1.close();
			statement1.close();
			%>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("status")%></td>
			<td class=<%=style.toString() %> style="text-align: left;"><%=resultSet.getString("INSPECTED_BY")%></td>
			<%
			String source_code="";
			if(typeOfasset.equals("04")){
				source_code="select count(b.HP_CODE) from RWS_HP_SUBCOMP_PARAM_TBL b,RWS_COMPLETE_HAB_VIEW c where substr(b.HP_CODE,1,16)=c.PANCH_CODE and b.ASSET_CODE='"+resultSet.getString("ASSET_CODE")+"'";
			}else if(typeOfasset.equals("05")){
				source_code="select count(b.SHALLOWHP_CODE) from RWS_SHALLOWHANDPUMPS_TBL b,RWS_COMPLETE_HAB_VIEW c where substr(b.SHALLOWHP_CODE,1,16)=c.PANCH_CODE and b.ASSET_CODE='"+resultSet.getString("ASSET_CODE")+"'";
			}else{
				source_code="select count(b.SOURCE_CODE) from RWS_SOURCE_TBL b,RWS_COMPLETE_HAB_VIEW c where b.hab_code=c.PANCH_CODE and b.ASSET_CODE='"+resultSet.getString("ASSET_CODE")+"'";
			}
			statement1=conn.createStatement();
			resultSet1=statement1.executeQuery(source_code);
			if(resultSet1.next()){
			 %>
			<td class=<%=style.toString() %> style="text-align: left;"><a href="#" onclick="viewWorks('Rws_Ast_Functional_Status_Sources_drill.jsp?asset_code=<%=resultSet.getString("ASSET_CODE")%>&typeOfasset=<%=typeOfasset%>')"><%=resultSet1.getInt(1)%></a></td>				
			<%}else{ %>
			<td class=<%=style.toString() %> style="text-align: left;">--</td>
			<%} 
			resultSet1.close();
			statement1.close();
			%>				
			<td class=<%=style.toString() %> style="text-align: left;"><a class="thumbnail" href="#"><img
					src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>"
					width="30px" height="30px" border="0" /><span><img
						src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>"
						width="350px" height="230px" /></span></a></td>	
				<%
				 String publicTapQry = "select dbms_lob.getlength(PUBLIC_TAP_IMAGE) from RWS_ASSET_PUBLIC_TAP_IMAGE_TBL where ASSET_CODE='" + resultSet.getString(2) + "'";
				statement1 = conn.createStatement();
				resultSet1 = statement1.executeQuery(publicTapQry);
                if (resultSet1.next()) {
                	int b=resultSet1.getInt(1);
		    		 if(b==0){
		    			 %>
	              		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
	              		<%
		    	     }else{
	             		 %>
                        <td class=<%=style.toString() %> style="text-align: left;"><a class="thumbnail" href="#"><img
					src="../../masters/rws_ast_public_tap_image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>"
					width="30px" height="30px" border="0" /><span><img
						src="../../masters/rws_ast_public_tap_image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>"
						width="350px" height="230px" /></span></a></td>	

            		<%}} else {%>
           		 	<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
          		  	<%}
                statement1.close();
                resultSet1.close();
				
				
				
				
				%>		
						
			<%-- <td class=<%=style.toString() %> style="text-align: left;">--</td>	 --%>
		</tr>		
		<%}	           
					statement.close();
					resultSet.close();
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	finally
	{
		if(conn!=null)
			conn.close();
	     
	}
	%>

	</table>
</form>

