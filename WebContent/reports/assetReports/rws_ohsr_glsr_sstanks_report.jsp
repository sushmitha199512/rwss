<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*"%>
<%@ include file="/reports/conn.jsp"%>
<script type="text/javascript"
	src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css"
	type="text/css">
<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>

	<%
		String rDistrict = request.getParameter("rDistrict");
		session.setAttribute("rDistrict", rDistrict);
		String rDistrictName = request.getParameter("rDistrictName");
		session.setAttribute("rDistrictName", rDistrictName);
		String sourceType = request.getParameter("sourceType");

		nic.watersoft.works.WorksData1 w = new nic.watersoft.works.WorksData1();

		String query = "";
		int styleCount = 0;
		String style = "";
	%>
	<table border=0 cellspacing=0 cellpadding=0 width="70%"
		style="border-collapse: collapse" ALIGN=CENTER>
		<caption>

			<table border=0 rules=none style="border-collapse: collapse"
				align="center">


				
					
					<tr align="right">

						<td><a href="/pred/home.jsp?loginMode=watersoft">Home
								|&nbsp; </td>
						<td><a href="javascript:onclick=history.go(-1)">Back
								&nbsp; </td>

					</tr>

				</table>
				</caption>
				

			
				<tr>
					<td align="center" class="gridhdbg" colspan="17">Source Details for <%=sourceType %></td>
				</tr>
			<table width="60%" border=1 style="border-collapse: collapse"
				ALIGN=CENTER>
				
				<tr>
					<td class=gridhdbg >Sl.No</td>
					<td class=gridhdbg >District</td>
					<td class=gridhdbg >Mandal</td>
					<td class=gridhdbg >Panchayath</td>
					<td class=gridhdbg >Village</td>
					<td class=gridhdbg >Hab Code</td>
					<td class=gridhdbg >Hab Name</td>
					<%
						if (sourceType.equals("OHSR")) {
					%>
					<td class=gridhdbg >OHSR Code</td>
					<td class=gridhdbg >OHSR Location</td>
					<td class=gridhdbg >OHSR Capacity</td>
					<td class=gridhdbg >No of Fillings</td>
					<%
						} else if (sourceType.equals("GLSR")) {
					%>
					<td class=gridhdbg >GLSR Code</td>
					<td class=gridhdbg >GLSR Location</td>
					<td class=gridhdbg >GLSR Capacity</td>
					<td class=gridhdbg >No of Fillings</td>
					<%
						} else if (sourceType.equals("OHBR")) {
					%>
					<td class=gridhdbg >OHBR Code</td>
					<td class=gridhdbg >OHBR Location</td>
					<td class=gridhdbg >OHBR Capacity</td>
					
					<%
						} else if (sourceType.equals("GLBR")) {
					%>
					<td class=gridhdbg >GLBR Code</td>
					<td class=gridhdbg >GLBR Location</td>
					<td class=gridhdbg >GLBR Capacity</td>
					
					<%
						} else if (sourceType.equals("SSTanks")) {
					%>
					<td class=gridhdbg >SS Tank Code</td>
					<td class=gridhdbg >SS Tank Location</td>
					<td class=gridhdbg >SS Size</td>
					<td class=gridhdbg >Capacity Days</td>
					<%
						} else if (sourceType.equals("Cistern")) {
					%>
					<td class=gridhdbg >Cistern Code</td>
					<td class=gridhdbg >Cistern Location</td>
					<td class=gridhdbg >Cistern Capacity</td>
					<td class=gridhdbg >Cistern Condition</td>
					<%
						}
					%>
					<td class=gridhdbg >Asset Code</td>
					<td class=gridhdbg >Asset Name</td>
					<td class=gridhdbg >Asset Type</td>
					<td class=gridhdbg >Source Code</td>
					<td class=gridhdbg >Source Type</td>
					<td class=gridhdbg >Source Name</td>
					<td class=gridhdbg >Source Location</td>


				</tr>

<tr></tr>

				<%
					try {

						Statement stmt8 = null;
						ResultSet rs8 = null;

						int sno = 1;
		
						//System.out.println(rDistrict);
						stmt8 = conn.createStatement();
						if (sourceType != null && sourceType.equals("GLSR")) {
							query = "select a.ASSET_CODE,GLSR_CODE as sourceCode,nvl(GLSR_CAP_LTS,0) as capacity,nvl(GLSR_LOC,'--') as loc,nvl(GLSR_NO_OF_FILLING,0) as numof,SOURCE_CODE,nvl(SOURCE_NAME,'--') as sourceName,decode(SOURCE_TYPE_CODE,1,'SUBSURFACE SOURCE',2,'SURFACE SOURCE') as sourceType,nvl(b.LOCATION,'--') as location,panch_code,dname,mname,pname,vname,panch_name from RWS_AST_GLSR_SC_PARAM_TBL a,rws_source_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and substr(a.GLSR_CODE,1,16)=c.panch_code";
							if(!rDistrict.equals("00")){
								query+=" and substr(a.GLSR_CODE,1,2)='"+rDistrict+"'";
							}
							
						} else if (sourceType != null && sourceType.equals("OHSR")) {
							query = "select a.ASSET_CODE,OHSR_CODE as sourceCode,nvl(OHSR_CAP_LTS,0) as capacity,nvl(OHSR_LOC,'--') as loc,nvl(OHSR_NO_OF_FILLING,0) as numof,SOURCE_CODE,nvl(SOURCE_NAME,'--') as sourceName,decode(SOURCE_TYPE_CODE,1,'SUBSURFACE SOURCE',2,'SURFACE SOURCE') as sourceType,nvl(b.LOCATION,'--') as location,panch_code,dname,mname,pname,vname,panch_name from RWS_AST_OHSR_SC_PARAM_TBL a,rws_source_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and substr(a.OHSR_CODE,1,16)=c.panch_code";
							if(!rDistrict.equals("00")){
								query+=" and substr(a.OHSR_CODE,1,2)='"+rDistrict+"'";
							}
							
						}else if (sourceType != null && sourceType.equals("GLBR")) {
							query = "select a.ASSET_CODE,GLBR_CODE as sourceCode,nvl(GLBR_CAP_LTS,0) as capacity,nvl(GLBR_LOC,'--') as loc,SOURCE_CODE,nvl(SOURCE_NAME,'--') as sourceName,decode(SOURCE_TYPE_CODE,1,'SUBSURFACE SOURCE',2,'SURFACE SOURCE') as sourceType,nvl(b.LOCATION,'--') as location,panch_code,dname,mname,pname,vname,panch_name from RWS_AST_GLBR_SC_PARAM_TBL a,rws_source_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and substr(a.GLBR_CODE,1,16)=c.panch_code";
							if(!rDistrict.equals("00")){
								query+=" and substr(a.GLBR_CODE,1,2)='"+rDistrict+"'";
							}
							
						} else if (sourceType != null && sourceType.equals("OHBR")) {
							query = "select a.ASSET_CODE,OHBR_CODE as sourceCode,nvl(OHBR_CAP_LTS,0) as capacity,nvl(OHBR_LOC,'--') as loc,SOURCE_CODE,nvl(SOURCE_NAME,'--') as sourceName,decode(SOURCE_TYPE_CODE,1,'SUBSURFACE SOURCE',2,'SURFACE SOURCE') as sourceType,nvl(b.LOCATION,'--') as location,panch_code,dname,mname,pname,vname,panch_name from RWS_AST_OHBR_SC_PARAM_TBL a,rws_source_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and substr(a.OHBR_CODE,1,16)=c.panch_code";
							if(!rDistrict.equals("00")){
								query+=" and substr(a.OHBR_CODE,1,2)='"+rDistrict+"'";
							}
							
						} else if (sourceType != null && sourceType.equals("SSTanks")) {
							query = "select a.ASSET_CODE,SSSC_CODE as sourceCode,nvl(SS_SIZE,0) as capacity,nvl(a.LOCATION,'--') as loc,nvl(CAPACITY_DAYS,0) as numof,SOURCE_CODE,nvl(SOURCE_NAME,'--') as sourceName,decode(SOURCE_TYPE_CODE,1,'SUBSURFACE SOURCE',2,'SURFACE SOURCE') as sourceType,nvl(b.LOCATION,'--') as location,panch_code,dname,mname,pname,vname,panch_name from RWS_AST_SS_SC_PARAM_TBL a,rws_source_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and substr(a.SSSC_CODE,1,16)=c.panch_code";
							if(!rDistrict.equals("00")){
								query+=" and substr(a.SSSC_CODE,1,2)='"+rDistrict+"'";
							}
							
						}
						else if (sourceType != null && sourceType.equals("Cistern")) {
							query = "select a.ASSET_CODE,CISSC_CODE as sourceCode,nvl(CIS_CAP_LTS,0) as capacity,nvl(CIS_LOC,'--') as loc,nvl(CIS_COND,'--') as numof,SOURCE_CODE,nvl(SOURCE_NAME,'--') as sourceName,decode(SOURCE_TYPE_CODE,1,'SUBSURFACE SOURCE',2,'SURFACE SOURCE') as sourceType,nvl(b.LOCATION,'--') as location,panch_code,dname,mname,pname,vname,panch_name from RWS_AST_CIS_SC_PARAM_TBL a,rws_source_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and substr(a.CISSC_CODE,1,16)=c.panch_code";
							if(!rDistrict.equals("00")){
								query+=" and substr(a.CISSC_CODE,1,2)='"+rDistrict+"'";
							}
							
						}
						
						query+=" order by panch_code";
						//System.out.println(query);

						rs8 = stmt8.executeQuery(query);
						
						while (rs8.next()) {
							String assetName="";
							String assetType="";
							String assetQuery="select asset_name,b.TYPE_OF_ASSET_NAME from rws_asset_mast_tbl a,rws_asset_type_tbl b where a.TYPE_OF_ASSET_CODE=b.TYPE_OF_ASSET_CODE and asset_code='"+rs8.getString("asset_code")+"'";
							stmt = conn.createStatement();
							rs = stmt.executeQuery(assetQuery);
							if(rs.next()){
								assetName=rs.getString("asset_name");
								assetType=rs.getString("TYPE_OF_ASSET_NAME");
							}
							rs.close();
							stmt.close();
							if (styleCount % 2 == 0) {
								style = "gridbg1";
							} else {
								style = "gridbg2";
							}
							styleCount++;
				%>
				
				<tr>

					<td class="<%=style%>" style="text-align: right;"><%=sno++%></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("dname") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("mname") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("pname") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("vname") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("panch_code") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("panch_name") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("sourceCode") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("loc") %></td>
					<td class="<%=style%>" style="text-align: right;"><%= rs8.getString("capacity") %></td>
					<%if(sourceType.equals("OHBR") || sourceType.equals("GLBR")){ %>
					
					<%} else{%>
					<td class="<%=style%>" style="text-align: right;"><%= rs8.getString("numof") %></td>
					<%} %>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("asset_code") %></td>
					<td class="<%=style%>" style="text-align: left;"><%=assetName %></td>
					<td class="<%=style%>" style="text-align: left;"><%=assetType %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("source_code") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("sourceType") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("sourceName") %></td>
					<td class="<%=style%>" style="text-align: left;"><%= rs8.getString("location") %></td>
				</tr>



				<%
						}
				%>
				
				<%
					if (stmt8 != null) {
							stmt8.close();
						}
						if (rs8 != null) {
							rs8.close();
						}

					} catch (Exception e) {
						e.printStackTrace();
					}
				finally{
					if(conn!=null){
						conn.close();
					}
				}
				%>

			</table>

			<p align=center>
				<%@ include file="/commons/rws_footer.jsp"%>
			</p>