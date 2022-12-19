<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>

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
	String startDate="";
	String endDate="";
	String startyear="";
	String endyear="";
	
	String mode="";
	if(request.getParameter("mode")!=null && request.getParameter("mode")!=""){
		mode=request.getParameter("mode");
	}
	String finYear=request.getParameter("finyear");
	String month="";
	String monthQuery="";	
	
	if(!finYear.equals("0")){
	startDate="1-4-"+finYear.substring(0,4);
	endDate="31-3-"+finYear.substring(5,9);
	month=request.getParameter("month");
	if(month!=""){
	monthQuery=" and to_char(b.UPDATE_DATE,'MON')='"+month+"'";
	}
	}
	else{
	startDate=request.getParameter("fromDate");
	endDate=request.getParameter("toDate");
	
	}
	startyear=request.getParameter("startyear");
	endyear=request.getParameter("endyear");
	
	String dcode="";
	String dname="";
	if(request.getParameter("dcode")!=null){
		dcode=request.getParameter("dcode");
		dname=request.getParameter("dname");
	}
	
	String mcode="";
	String mname="";
	if(request.getParameter("mcode")!=null){
		mcode=request.getParameter("mcode");
		mname=request.getParameter("mname");
	}
	
	String pcode="";
	String pname="";
	if(request.getParameter("pcode")!=null){
		pcode=request.getParameter("pcode");
		pname=request.getParameter("pname");
	}
	//System.out.println(startyear);
	//System.out.println(endyear);
%>

<body bgcolor="#edf2f8">
	<form>
		<table border=0 cellspacing=0 cellpadding=0 height=5%
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" align="center">
			<caption>
				<table border=0 rules=none style="border-collapse: collapse"
					align="right">
					<tr>
						<td align="right" class="bwborder"><a
							href="javascript:history.go(-1)">Back</a>| <a
							href="/pred/home.jsp?loginMode=watersoft">Home </a></td>
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class=gridhdbg colspan=20>Asset Functional Status From: <%=startDate %> To: <%=endDate %> <%if(month!=""){ %> And Month:<%=month %><%} %> <%if(mode.equals("mandal") || mode.equals("panchayat")){ %> For District: <%=dname %><%} %> <%if(mode.equals("panchayat")){ %> And Mandal: <%=mname %><%} %>
				
				</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg rowspan=2 align=center>Sno</td>
				<%if(mode.equals("mandal")){ %>
				<td class=gridhdbg rowspan=2 align=center>Mandal</td>
				<% }else if(mode.equals("panchayat")){%>
				<td class=gridhdbg rowspan=2 align=center>Panchayat</td>
				<% }else{%>
				<td class=gridhdbg rowspan=2 align=center>District</td>
				<%} %>
				<td class=gridhdbg colspan=3 align=center>CPWS</td>
				<td class=gridhdbg colspan=3 align=center>PWS</td>
				<td class=gridhdbg colspan=3 align=center>MPWS</td>
				<td class=gridhdbg colspan=3 align=center>DIRECT PUMPING</td>
				<td class=gridhdbg colspan=3 align=center>HAND PUMPS</td>
				<td class=gridhdbg colspan=3 align=center>SHALLOW HANDPUMPS</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Working</td>
				<td class=gridhdbg>Not Working</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Working</td>
				<td class=gridhdbg>Not Working</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Working</td>
				<td class=gridhdbg>Not Working</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Working</td>
				<td class=gridhdbg>Not Working</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Working</td>
				<td class=gridhdbg>Not Working</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Working</td>
				<td class=gridhdbg>Not Working</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg>1</td>
				<td class=gridhdbg>2</td>
				<td class=gridhdbg>3</td>
				<td class=gridhdbg>4</td>
				<td class=gridhdbg>5</td>
				<td class=gridhdbg>6</td>
				<td class=gridhdbg>7</td>
				<td class=gridhdbg>8</td>
				<td class=gridhdbg>9</td>
				<td class=gridhdbg>10</td>
				<td class=gridhdbg>11</td>
				<td class=gridhdbg>12</td>
				<td class=gridhdbg>13</td>
				<td class=gridhdbg>14</td>
				<td class=gridhdbg>15</td>
				<td class=gridhdbg>16</td>
				<td class=gridhdbg>17</td>
				<td class=gridhdbg>18</td>
				<td class=gridhdbg>19</td>
				<td class=gridhdbg>20</td>
			</tr>
			<%
				Statement statement = null;
				ResultSet resultSet = null;
				int sno = 1;
				
				
				int styleCount = 0;
				String style = "";

				String query = "";
				String whereCondition="";
				
				int totCpwsW=0,totCpwsNW=0,totPwsW=0,totPwsNW=0,totMpwsW=0,totMpwsNW=0,totDpW=0,totDpNW=0,totHpW=0,totHpNW=0,totShpW=0,totShpNW=0;
				
				int totCpwsTot=0,totPwsTot=0,totMpwsTot=0,totDpTot=0,totHpTot=0,totShpTot=0;
				
				try {
					
						
					if(mode.equals("mandal")){
						
						query = "select mcode,mname from rws_mandal_tbl  where dcode='"+dcode+"' order by mcode";
						
					}
					else if(mode.equals("panchayat")){
						
						query = "select pcode,pname from rws_panchayat_tbl where  dcode='"+dcode+"' and mcode='"+mcode+"' order by mcode";
						
					}
					else{
						query = "select dcode,dname from rws_district_tbl ";
						if(!dcode.equals("")){
							query+=" where dcode='"+dcode+"'";
						}
						query+="order by dcode";
					}
					//System.out.println(query);
					stmt = conn.createStatement();
					rs = stmt.executeQuery(query);
					
					while (rs.next()) {
						int cpwsW=0,cpwsNW=0,pwsW=0,pwsNW=0,mpwsW=0,mpwsNW=0,dpW=0,dpNW=0,hpW=0,hpNW=0,shpW=0,shpNW=0;
						
						int cpwstot=0,pwstot=0,mpwstot=0,dptot=0,hptot=0,shptot=0;
						
						if(mode.equals("panchayat")){
							pname=rs.getString("pname");
							pcode=rs.getString("pcode");
							
							whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' and substr(a.hab_code,13,2)='"+pcode+"' ";
						}
						else if(mode.equals("mandal")){
							mname=rs.getString("mname");
							mcode=rs.getString("mcode");
							whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' ";
						}
						else{
						dname=rs.getString("dname");
						dcode=rs.getString("dcode");
						whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' ";
						}
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
						
						 String countQuery="select (select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='03' and ASSET_STATUS=1 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as cpwsw,"
										  		 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='03' and ASSET_STATUS=2 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as cpwsnw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='01' and ASSET_STATUS=1 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as pwsw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='01' and ASSET_STATUS=2 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as pwsnw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='02' and ASSET_STATUS=1 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as mpwsw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='02' and ASSET_STATUS=2 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as mpwsnw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='09' and ASSET_STATUS=1 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as dpw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='09' and ASSET_STATUS=2 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as dpnw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='04' and ASSET_STATUS=1 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as hpw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='04' and ASSET_STATUS=2 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as hpnw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='05' and ASSET_STATUS=1 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as shpw,"
												 +"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='05' and ASSET_STATUS=2 and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as shpnw from dual"; 
												
						//String countQuery="select count(*),TYPE_OF_ASSET_CODE,ASSET_STATUS from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='03' and ASSET_STATUS=1 and "+whereCondition+" and b.UPDATE_DATE between '"+startDate+"' and '"+endDate+"' "+monthQuery+" group by TYPE_OF_ASSET_CODE,ASSET_STATUS order by TYPE_OF_ASSET_CODE,ASSET_STATUS";						
						  
						//System.out.println(countQuery);
						statement = conn.createStatement();
						resultSet = statement.executeQuery(countQuery);
						if(resultSet.next()){
							
							cpwsW=resultSet.getInt("cpwsw");
							cpwsNW=resultSet.getInt("cpwsnw");
							pwsW=resultSet.getInt("pwsw");
							pwsNW=resultSet.getInt("pwsnw");
							mpwsW=resultSet.getInt("mpwsw");
							mpwsNW=resultSet.getInt("mpwsnw");
							dpW=resultSet.getInt("dpw");
							dpNW=resultSet.getInt("dpnw");
							hpW=resultSet.getInt("hpw");
							hpNW=resultSet.getInt("hpnw");
							shpW=resultSet.getInt("shpw");
							shpNW=resultSet.getInt("shpnw");
						}
						resultSet.close();
						statement.close();
						
						
						 String totCountQuery="select (select count(*) from rws_asset_mast_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and TYPE_OF_ASSET_CODE='03' and "+whereCondition+") as cpwstot,"
											  		+"(select count(*) from rws_asset_mast_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and TYPE_OF_ASSET_CODE='01' and "+whereCondition+") as pwstot,"
													+"(select count(*) from rws_asset_mast_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and TYPE_OF_ASSET_CODE='02' and "+whereCondition+") as mpwstot,"
													+"(select count(*) from rws_asset_mast_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and TYPE_OF_ASSET_CODE='09' and "+whereCondition+") as dptot,"
													+"(select count(*) from rws_asset_mast_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and TYPE_OF_ASSET_CODE='04' and "+whereCondition+") as hptot,"
													+"(select count(*) from rws_asset_mast_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and TYPE_OF_ASSET_CODE='05' and "+whereCondition+") as shptot from dual"; 
											 	
						 
						statement = conn.createStatement();
						resultSet = statement.executeQuery(totCountQuery);
						if(resultSet.next()){
							
							cpwstot=resultSet.getInt("cpwstot");
							pwstot=resultSet.getInt("pwstot");
							mpwstot=resultSet.getInt("mpwstot");
							dptot=resultSet.getInt("dptot");
							hptot=resultSet.getInt("hptot");
							shptot=resultSet.getInt("shptot");
							
						}
						resultSet.close();
						statement.close();
			%>
			<tr>
				<td class="<%=style%>"><%=sno++%></td>
				<%if(mode.equals("panchayat")){%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><%=pname%></td>
				<%}else if(mode.equals("mandal")){ %>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><a href="Rws_Asset_Functional_Status_Rpt.jsp?dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=mcode%>&mname=<%=mname%>&mode=panchayat&finyear=<%=finYear %>&month=<%=month%>&fromDate=<%=startDate%>&toDate=<%=endDate%>&startyear=<%=startyear%>&endyear=<%=endyear%>"><%=mname%></a></td>
				<%}else{%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><a href="Rws_Asset_Functional_Status_Rpt.jsp?dcode=<%=dcode%>&dname=<%=dname%>&mode=mandal&finyear=<%=finYear %>&month=<%=month%>&fromDate=<%=startDate%>&toDate=<%=endDate%>&startyear=<%=startyear%>&endyear=<%=endyear%>"><%=dname%></a></td>
				<%}%>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=03&scheme=Total CPWS&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>&startyear=<%=startyear%>&endyear=<%=endyear%>')"><%=cpwstot%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=03&scheme=CPWS Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=cpwsW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=03&scheme=CPWS NotWorking&assetStatus=2&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=cpwsNW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01&scheme=Total PWS&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>&startyear=<%=startyear%>&endyear=<%=endyear%>')"><%=pwstot%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01&scheme=PWS Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=pwsW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01&scheme=PWS NotWorking&assetStatus=2&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=pwsNW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=02&scheme=Total MPWS&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>&startyear=<%=startyear%>&endyear=<%=endyear%>')"><%=mpwstot%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=02&scheme=MPWS Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=mpwsW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=02&scheme=MPWS NotWorking&assetStatus=2&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=mpwsNW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=09&scheme=Total DP&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>&startyear=<%=startyear%>&endyear=<%=endyear%>')"><%=dptot%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=09&scheme=DP Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=dpW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=09&scheme=DP NotWorking&assetStatus=2&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=dpNW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=04&scheme=Total HANDPUMP&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>&startyear=<%=startyear%>&endyear=<%=endyear%>')"><%=hptot%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=04&scheme=HANDPUMP Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=hpW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=04&scheme=HANDPUMP NotWorking&assetStatus=2&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=hpNW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=05&scheme=Total SHALLOW HANDPUMP&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>&startyear=<%=startyear%>&endyear=<%=endyear%>')"><%=shptot%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=05&scheme=SHALLOW HANDPUMP Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=shpW%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=05&scheme=SHALLOW HANDPUMP NotWorking&assetStatus=2&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=shpNW%></a></td>
			</tr>
			<%
			totCpwsW += cpwsW;
			totCpwsNW+=cpwsNW;
			totPwsW+=pwsW;
			totPwsNW+=pwsNW;
			totMpwsW+=mpwsW;
			totMpwsNW+=mpwsNW;
			totDpW+=dpW;
			totDpNW+=dpNW;
			totHpW+=hpW;
			totHpNW+=hpNW;
			totShpW+=shpW;
			totShpNW+=shpNW;
			
			totCpwsTot += cpwstot;
			totPwsTot += pwstot;
			totMpwsTot += mpwstot;
			totDpTot += dptot;
			totHpTot += hptot;
			totShpTot += shptot;
						
					}
					rs.close();
					stmt.close();
			%>
			<tr>
				<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;"><%=totCpwsTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=totCpwsW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totCpwsNW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totPwsTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=totPwsW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totPwsNW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totMpwsTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=totMpwsW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totMpwsNW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totDpTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=totDpW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totDpNW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totHpTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=totHpW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totHpNW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totShpTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=totShpW%></td>
				<td class=gridhdbg style="text-align: right;"><%=totShpNW%></td>
			</tr>
		</table>
		
		<%
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (conn != null)
					conn.close();
			}
		%>
	</form>
</body>
<p align=center>
	<%@ include file="/commons/rws_footer.jsp"%>
</p>