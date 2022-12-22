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
				<td align="center" class=gridhdbg colspan=16>Asset Functional Status From: <%=startDate %> To: <%=endDate %> <%if(month!=""){ %> And Month:<%=month %><%} %> <%if(mode.equals("mandal") || mode.equals("panchayat")){ %> For District: <%=dname %><%} %> <%if(mode.equals("panchayat")){ %> And Mandal: <%=mname %><%} %>
				
				</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg align=center>Sno</td>
				<%if(mode.equals("mandal")){ %>
				<td class=gridhdbg align=center>Mandal</td>
				<% }else if(mode.equals("panchayat")){%>
				<td class=gridhdbg align=center>Panchayat</td>
				<% }else{%>
				<td class=gridhdbg align=center>District</td>
				<%} %>
				<td class=gridhdbg align=center width=100>CPWS</td>
				<td class=gridhdbg align=center width=100>PWS</td>
				<td class=gridhdbg align=center width=100>MPWS</td>
				<td class=gridhdbg align=center >DIRECT PUMPING</td>
				<td class=gridhdbg align=center width=100>HAND PUMPS</td>
				<td class=gridhdbg align=center>SHALLOW HANDPUMPS</td>
			</tr>
			
			<%
				Statement statement = null;
				ResultSet resultSet = null;
				int sno = 1;
				
				int styleCount = 0;
				String style = "";

				String query = "";
				String whereCondition="";
				
				int totCpws=0,totPws=0,totMpws=0,totDp=0,totHp=0,totShp=0;
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
						int cpws=0,pws=0,mpws=0,dp=0,hp=0,shp=0;
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
						 String countQuery="select (select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b,rws_complete_hab_view c where a.HAB_CODE=c.panch_code and a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='03' and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as cpws,"
										  		+"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b,rws_complete_hab_view c where a.HAB_CODE=c.panch_code and a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='01' and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as pws,"
												+"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b,rws_complete_hab_view c where a.HAB_CODE=c.panch_code and a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='02' and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as mpws,"
												+"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b,rws_complete_hab_view c where a.HAB_CODE=c.panch_code and a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='09' and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as dp,"
												+"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b,rws_complete_hab_view c where a.HAB_CODE=c.panch_code and a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='04' and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as hp,"
												+"(select count(*) from rws_asset_mast_tbl a,rws_asset_image_tbl b,rws_complete_hab_view c where a.HAB_CODE=c.panch_code and a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='05' and "+whereCondition+" and to_date(b.UPDATE_DATE) between to_date('"+startDate+"','dd-mm-yyyy') and to_date('"+endDate+"','dd-mm-yyyy') "+monthQuery+") as shp from dual"; 
						//String countQuery="select count(*),TYPE_OF_ASSET_CODE,ASSET_STATUS from rws_asset_mast_tbl a,rws_asset_image_tbl b where a.asset_code=b.asset_code and TYPE_OF_ASSET_CODE='03' and ASSET_STATUS=1 and "+whereCondition+" and to_date(b.UPDATE_DATE) between '"+startDate+"' and '"+endDate+"' "+monthQuery+" group by TYPE_OF_ASSET_CODE,ASSET_STATUS order by TYPE_OF_ASSET_CODE,ASSET_STATUS";						
						  
						//System.out.println(countQuery);
						statement = conn.createStatement();
						resultSet = statement.executeQuery(countQuery);
						if(resultSet.next()){
							cpws=resultSet.getInt("cpws");							
							pws=resultSet.getInt("pws");							
							mpws=resultSet.getInt("mpws");							
							dp=resultSet.getInt("dp");							
							hp=resultSet.getInt("hp");							
							shp=resultSet.getInt("shp");							
						}
						resultSet.close();
						statement.close();
			%>
			<tr>
				<td class="<%=style%>"><%=sno++%></td>
				<%if(mode.equals("panchayat")){%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><%=pname%></td>
				<%}else if(mode.equals("mandal")){ %>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><a href="Rws_Ast_Functional_Status_Rpt.jsp?dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=mcode%>&mname=<%=mname%>&mode=panchayat&finyear=<%=finYear %>&month=<%=month%>&fromDate=<%=startDate%>&toDate=<%=endDate%>"><%=mname%></a></td>
				<%}else{%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><a href="Rws_Ast_Functional_Status_Rpt.jsp?dcode=<%=dcode%>&dname=<%=dname%>&mode=mandal&finyear=<%=finYear %>&month=<%=month%>&fromDate=<%=startDate%>&toDate=<%=endDate%>"><%=dname%></a></td>
				<%}%>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Ast_Functional_Status_drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=03&scheme=CPWS Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=cpws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Ast_Functional_Status_drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01&scheme=PWS Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=pws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Ast_Functional_Status_drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=02&scheme=MPWS Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=mpws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Ast_Functional_Status_drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=09&scheme=DP Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=dp%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Ast_Functional_Status_drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=04&scheme=HANDPUMP Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=hp%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Ast_Functional_Status_drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=05&scheme=SHALLOW HANDPUMP Working&assetStatus=1&startDate=<%=startDate%>&endDate=<%=endDate%>&month=<%=month%>')"><%=shp%></a></td>
			</tr>
			<%
			totCpws += cpws;			
			totPws+=pws;			
			totMpws+=mpws;			
			totDp+=dp;			
			totHp+=hp;			
			totShp+=shp;
			
						
					}
					rs.close();
					stmt.close();
			%>
			<tr>
				<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;"><%=totCpws%></td>				
				<td class=gridhdbg style="text-align: right;"><%=totPws%></td>				
				<td class=gridhdbg style="text-align: right;"><%=totMpws%></td>				
				<td class=gridhdbg style="text-align: right;"><%=totDp%></td>			
				<td class=gridhdbg style="text-align: right;"><%=totHp%></td>				
				<td class=gridhdbg style="text-align: right;"><%=totShp%></td>
				
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