<%
if((rAssetType != null) && (!rAssetType.equals("0")) && rAssetType.equals("01") && rCircle.equals("0"))
{
	//System.out.println("ASSET TYPE SELECTED...");

	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt3=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt4=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt5=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt6=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	stmt7=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	stmt8=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
try
{
	query = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_SUBCOMP_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.PUMP_CODE,17,3) LIKE '%6%' ";
	
	rs = stmt.executeQuery(query);
	rs.next();

	query1 = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_DISTRI_SC_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.DISTRISC_CODE,17,3) LIKE '%6%' " ;
	
	rs1 = stmt1.executeQuery(query1);
	rs1.next();

	query2 = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_OHSR_SC_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.OHSR_CODE,17,3) LIKE '%6%' ";	
	rs2 = stmt2.executeQuery(query2);
	rs2.next();

	query3 = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_SP_HC_PC_SC_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.SPHCPCSC_CODE,17,3) LIKE '%6%' " ;
	rs3 = stmt3.executeQuery(query3);
	rs3.next();

	query4 = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_CIS_SC_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.CISSC_CODE,17,3) LIKE '%6%' " ;
	rs4 = stmt4.executeQuery(query4);
	rs4.next();

	query5 = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_CP_SC_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.CPSC_CODE,17,3) LIKE '%6%' " ;
	rs5 = stmt5.executeQuery(query5);
	rs5.next();

	query6 = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_GLSR_SC_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.GLSR_CODE,17,3) LIKE '%6%' " ;
	rs6 = stmt6.executeQuery(query6);
	rs6.next();

	query7 = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_PM_SC_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.PM_CODE,17,3) LIKE '%6%' " ;
	rs7 = stmt7.executeQuery(query7);
	rs7.next();
	
	query8 = " SELECT COUNT(*) COUNT FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S,RWS_PWS_PUMPHOUSE_PARAM_TBL H ,RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.PUMPHOUSE_CODE,17,3) LIKE '%6%' " ;
	rs8 = stmt8.executeQuery(query8);
	rs8.next();

	
%>
<table border=1 cellspacing=0 cellpadding=0 style="border-collapse:collapse" bgcolor="#edf2f8" width=100%>
	<tr align=center>
		<td class=rptLabel colspan=2>SOURCE</td>		
		<td class=rptLabel colspan=2>PIPE LINE</td>
		<td class=rptLabel colspan=2>RESERVOIRS</td>
		<td class=rptLabel colspan=2>PUMPSETS</td>
	</tr>
	<tr>
		<td class=rptLabel>Name</td>
		<td class=rptLabel>No</td>
		<td class=rptLabel>Name</td>
		<td class=rptLabel>No</td>
		<td class=rptLabel>Name</td>
		<td class=rptLabel>No</td>
		<td class=rptLabel>Name</td>
		<td class=rptLabel>No</td>		
	</tr>
	<tr>
<%
		if(rs.getString(1).equals("0"))	
		{
%>
		<td class=rptValue>BORE WELL</td>
<%		
		}
		else 
		{
%>
		<td class=rptValue><a href="./rws_asset_district_borewell_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>BORE WELL</td>
<%
		}
%>
		<td class=rptValue><%=rs.getString(1)%></td>
<%		
		if(rs1.getString(1).equals("0")) 
		{		
%>
		
		<td class=rptValue>DISTRIBUTION</td>
<%		
		}
		else 
		{
%>
		<td class=rptValue><a href="./rws_asset_distric_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>DISTRIBUTION</td>
<%
		}
%>
		<td class=rptValue><%=rs1.getString(1)%></td>
<%		
		if(rs2.getString(1).equals("0")) 
		{
%>
		<td class=rptValue>OHSR</td>
<%		
		}
		else 
		{
%>
		<td class=rptValue><a href="./rws_asset_ohsr_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>OHSR</td>
<%
		}
%>
		<td class=rptValue><%=rs2.getString(1)%></td>
<%
		if(rs8.getString(1).equals("0"))
		{		
%>
		<td class=rptValue>PUMP HOUSE</td>
<%
		}
		else
		{
%>		
		<td class=rptValue><a href="./rws_asset_pumphouse_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>PUMP HOUSE</td>
<%
		}
%>
		<td class=rptValue><%=rs8.getString(1)%></td>
	</tr>
	<tr>
		<td class=rptValue>ROTARY BORE WELL</td>
		<td class=rptValue></td>
<%
		if(rs3.getString(1).equals("0")) 
		{
%>
		<td class=rptValue>STAND POSTS</td>
<%		
		}
		else 
		{
%>
		<td class=rptValue><a href="./rws_asset_standposts_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>STAND POSTS</td>
<%
		}
%>
		<td class=rptValue><%=rs3.getString(1)%></td>
<%
		if(rs4.getString(1).equals("0")) 
		{
%>
		<td class=rptValue>CISTERNS</td>
<%		
		}
		else 
		{
%>
		<td class=rptValue><a href="./rws_asset_cis_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>CISTERNS</td>
<%
		}
%>
		<td class=rptValue><%=rs4.getString(1)%></td>
<%
		if(rs5.getString(1).equals("0")) 
		{
%>
		<td class=rptValue>CAPACITORS</td>
<%		
		}
		else 
		{
%>
		<td class=rptValue><a href="./rws_asset_capac_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>CAPACITORS</td>
<%
		}
%>
		<td class=rptValue><%=rs5.getString(1)%></td>

	</tr>
	<tr>
		<td class=rptValue>IN TAKE WELL</td>
		<td class=rptValue></td>
<%
		if(rs7.getString(1).equals("0")) 
		{
%>
		<td class=rptValue>PUMPING MAIN</td>
<%		
		}
		else 
		{
%>
		<td class=rptValue><a href="./rws_asset_pumpingmain_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>PUMPING MAIN</td>
<%
		}
%>
		<td class=rptValue><%=rs7.getString(1)%></td>
<%
		if(rs6.getString(1).equals("0")) 
		{
%>
		<td class=rptValue>GLSR</td>
<%		
		}
		else 
		{
%>
		<td class=rptValue><a href="./rws_asset_glsr_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new>GLSR</td>
<%
		}
%>
		<td class=rptValue><%=rs6.getString(1)%></td>
	</tr>
	<tr>
		<td class=rptValue>IN FILTRATION WELL</td>
		<td class=rptValue></td>		
	</tr>
	<tr>
		<td class=rptValue>WATCHMAN QUARTER</td>
		<td class=rptValue></td>		
	</tr>
	<tr>
		<td class=rptValue>SOURCE TYPE</td>
		<td class=rptValue></td>		
	</tr>	
</table>
<%
	rs.close(); rs1.close(); rs2.close(); rs3.close(); rs4.close(); rs5.close(); rs6.close(); rs7.close();
	stmt.close(); stmt1.close(); stmt2.close(); stmt3.close(); stmt4.close(); stmt5.close(); stmt6.close(); stmt7.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in check list asset form= " +e);
}
}
%>