
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

<%
	String dcode = request.getParameter("dcode");
	String mcode = request.getParameter("mcode");
	String pcode = request.getParameter("pcode");
	String dname = request.getParameter("dname");
	String mname = request.getParameter("mname");
	String pname = request.getParameter("pname");
	String scheme = request.getParameter("scheme");
	String typeOfasset = request.getParameter("typeOfasset");
	String mode = request.getParameter("mode");
	

	String whereCondition = "";
	String message = "";
	if (dcode != null && dcode != "" && mcode != null && mcode != "" && pcode != null && pcode != "") {

		whereCondition = " substr(a.hab_code,1,2)='" + dcode + "' and substr(a.hab_code,6,2)='" + mcode
				+ "' and substr(a.hab_code,13,2)='" + pcode + "' ";

		message = "Asset Non Functional Status of " + scheme + " For District: " + dname + ", Mandal: " + mname
				+ " And Panchayat: " + pname;
	}

	else if (dcode != null && dcode != "" && mcode != null && mcode != "") {

		whereCondition = " substr(a.hab_code,1,2)='" + dcode + "' and substr(a.hab_code,6,2)='" + mcode + "' ";

		message = "Asset Non Functional Status of " + scheme + " For District: " + dname + " And Mandal: "
				+ mname;

	} else if (dcode != null && dcode != "") {

		whereCondition = " substr(a.hab_code,1,2)='" + dcode + "' ";
		message = "Asset Non Functional Status of " + scheme + " For District: " + dname + "";
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

				</tr>
			</table>
		</caption>

	</table>
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
		style="border-collapse: collapse" ALIGN=CENTER>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="gridhdbg" colspan="15"><%=message%></td>
		</tr>
		<tr align=center>
			<td class=gridhdbg><b>SLNO </b></td>
			<td class=gridhdbg><b>Asset Code </b></td>
			<td class=gridhdbg><b>Asset Name </b></td>
			<td class=gridhdbg><b>Location </b></td>
			<td class=gridhdbg><b>Asset Cost </b></td>
			<td class=gridhdbg><b>Latitude </b></td>
			<td class=gridhdbg><b>Longitude </b></td>
			<td class=gridhdbg><b>Image </b></td>
			<%if(mode!=null) {%>
			<td class=gridhdbg><b>Source Code </b></td>
			<td class=gridhdbg><b>Location </b></td>
			<td class=gridhdbg><b>Non Functional Status</b></td>
			<td class=gridhdbg><b>Alternative Arrangements </b></td>
			<td class=gridhdbg><b>Latitude </b></td>
			<td class=gridhdbg><b>Longitude </b></td>
			<td class=gridhdbg><b>Image </b></td>
			<%} %>
		</tr>
		<%
			Statement statement = null, statement1 = null;
			ResultSet resultSet = null, resultSet1 = null;
			try {

				int count = 1;
				statement = conn.createStatement();
				String query = "";
				query = "select a.ASSET_CODE as ASSET_CODE,ASSET_NAME,nvl(LOCATION,' ') as LOCATION,ASSET_COST,ASSET_LAT,ASSET_LON"  
						+" from RWS_ASSET_MAST_TBL a,RWS_COMPLETE_HAB_VIEW b,RWS_ASSET_IMAGE_TBL c where a.HAB_CODE=b.PANCH_CODE "
						+" and a.asset_code=c.asset_code and TYPE_OF_ASSET_CODE in ("	+ typeOfasset + ") and " + whereCondition ;
				if(scheme.equals("Seasonal"))
					query+=" and ASSET_STATUS='4')";
				else if(scheme.equals("Dried/Condemned"))
					query+=" and ASSET_STATUS in(3,5) ";
				else
					query+=" and ASSET_STATUS='2'";
					
				if(mode!=null) {
					
					query="select distinct a.ASSET_CODE,a.ASSET_NAME,nvl(a.LOCATION,' ') as LOCATION,a.ASSET_COST,ASSET_LAT,ASSET_LON,b.SOURCE_CODE,"
							+"nvl(b.LOCATION,'-') as comp_location,"
							+"nvl(b.COMPO_LAT,'0') as COMPO_LAT,nvl(b.COMPO_LON,'0') as COMPO_LON,b.IMG_SIZE "
							+" from rws_asset_mast_tbl a,RWS_AST_ALL_COMP_ALL_IMG_VIEW b ,RWS_ASSET_IMAGE_TBL c "
							+" where a.asset_code=b.asset_code and a.asset_code=c.asset_code and a.TYPE_OF_ASSET_CODE in ("	+ typeOfasset + ") and  " 
							+ whereCondition + " and  b.STATUS='N' "  ;
					if(scheme.equals("Seasonal"))
						query+=" and a.ASSET_STATUS='4')";
					else if(scheme.equals("Dried/Condemned"))
						query+=" and a.ASSET_STATUS in(3,5) ";
					else
						query+=" and a.ASSET_STATUS='2'";				
					if(mode.equals("source"))
						query+=" and TYPENAME='SOURCE'";
					else if(mode.equals("headWorks"))
						query+=" and TYPENAME='HEADWORKS'";
					else if(mode.equals("pipeline"))
						query+=" and TYPENAME='PIPELINE'";
					else if(mode.equals("srreservoirs"))
						query+=" and TYPENAME='SR.RESERVOIRS'";
					else if(mode.equals("pumping"))
						query+=" and TYPENAME='PUMPING'";
					else  if(mode.equals("others"))
						query+=" and TYPENAME='OTHERS'";
					else
						query+=" and TYPENAME in ('SOURCE','HEADWORKS','PIPELINE','SR.RESERVOIRS','PUMPING','OTHERS')";
				}
				
				//System.out.println(query);

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
			<td class=<%=style.toString()%> style="text-align: left;"><%=count++%></td>
			<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("ASSET_CODE")%></td>
			<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("ASSET_NAME")%></td>
			<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("LOCATION")%></td>
			<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("ASSET_COST")%></td>
			<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("ASSET_LAT")%></td>
			<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("ASSET_LON")%></td>
			<td class=<%=style.toString()%> style="text-align: left;"><a
				class="thumbnail" href="#"><img
					src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>"
					width="30px" height="30px" border="0" /><span><img
						src="../../masters/image.jsp?imgID=<%=resultSet.getString("ASSET_CODE")%>"
						width="350px" height="230px" /></span></a></td>
			<%
			if(mode!=null){%>
				<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("SOURCE_CODE")%></td>
				<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("comp_location")%></td>
				<%
				
					statement1=conn.createStatement();
					String q="select nvl(decode(NOT_FUNCTIONAL_STATUS,'P','Permanent','T','Temporary'),'-') as NOT_FUNCTIONAL_STATUS,nvl(ALT_ARNGMT,'-') as ALT_ARNGMT "
					+" from RWS_ASSET_COMPONENT_REPAIR_TBL where ASSET_CODE='"+resultSet.getString("ASSET_CODE")+"'   and  ASSET_COMP_CODE='"+resultSet.getString("SOURCE_CODE")+"' and update_date=(select max(update_date) from RWS_ASSET_COMPONENT_REPAIR_TBL where ASSET_CODE='"+resultSet.getString("ASSET_CODE")+"'   and  ASSET_COMP_CODE='"+resultSet.getString("SOURCE_CODE")+"')";
					//System.out.println(q);
					resultSet1 = statement1.executeQuery(q);
					if(resultSet1.next()){
						%>
						<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet1.getString("NOT_FUNCTIONAL_STATUS")%></td>
						<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet1.getString("ALT_ARNGMT")%></td>
				<%	}
					else{
						%>
						<td class=<%=style.toString()%> style="text-align: left;">-</td>
						<td class=<%=style.toString()%> style="text-align: left;">-</td>
				<%	
					}
					resultSet1.close();
					statement1.close();
				%>
				<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("COMPO_LAT")%></td>
				<td class=<%=style.toString()%> style="text-align: left;"><%=resultSet.getString("COMPO_LON")%></td>
			<%if(resultSet.getInt("IMG_SIZE")!=0) {%>
				<td class=<%=style.toString()%> style="text-align: left;"><a
					class="thumbnail" href="#"><img
						src="../../masters/image.jsp?imgID=<%=resultSet.getString("SOURCE_CODE")%>"
						width="30px" height="30px" border="0" /><span><img
							src="../../masters/image.jsp?imgID=<%=resultSet.getString("SOURCE_CODE")%>"
							width="350px" height="230px" /></span></a></td>
				<%}else {%>
					<td class=<%=style.toString()%> style="text-align: left;">Image not exist</td>
				
				<%}
		}
			%>
		</tr>
		<%
			}
				statement.close();
				resultSet.close();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(conn!=null)
					conn.close();
			}
		%>

	</table>
</form>

