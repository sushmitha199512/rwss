<%
if((rSubDivision != null) && (!rSubDivision.equals("0")) && (rDivision != null) && (!rDivision.equals("0")) && (rCircle != null) && (!rCircle.equals("0")) && (rAssetType != null) && (!rAssetType.equals("0")) && (rAssetType.equals("01")) && (rMandal != null) && (!rMandal.equals("0")) &&  (rPanchayat != null) && (!rPanchayat.equals("0")) && (rVillage != null) && (!rVillage.equals("0")) && (rHabitation != null) && (!rHabitation.equals("0")) && (rScheme != null) && (!rScheme.equals("0")))
{
	//System.out.println("ASSET TYPE & CIRCLE & DIVISION & SUB DIVISION & MANDAL & PANCHAYAT & VILLAGE & HABITATION & SCHEME SELECTED...");
	
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt3=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt4=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt5=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt6=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	stmt7=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	
try
{	
	query = " SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_SUBCOMP_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND  SUBSTR(S.SCHEME_CODE,17,3) LIKE '%6%' AND A.HAB_CODE = '" +rHabitation+ "'  AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME='PWS' AND A.TYPE_OF_ASSET_CODE='01' AND SUBSTR(H.PUMP_CODE,1,16) = '" +rHabitation+ "' AND A.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND A.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND A.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' AND SUBSTR(H.PUMP_CODE,17,3) = '" +rScheme+ "' ";
	rs = stmt.executeQuery(query);
	rs.next();
	
	query1 = " SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_DISTRI_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND  SUBSTR(S.SCHEME_CODE,17,3) LIKE '%6%' AND A.HAB_CODE = '" +rHabitation+ "' AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME='PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.DISTRISC_CODE,1,16) = '" +rHabitation+ "' AND  A.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND A.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND A.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' AND SUBSTR(H.DISTRISC_CODE,17,3) = '" +rScheme+ "' ";
	rs1 = stmt1.executeQuery(query1);
	rs1.next();

	query2 = " SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_OHSR_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND  SUBSTR(S.SCHEME_CODE,17,3) LIKE '%6%' AND A.HAB_CODE = '" +rHabitation+ "' AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME='PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.OHSR_CODE,1,16) = '" +rHabitation+ "' AND A.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND A.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND A.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' AND SUBSTR(H.OHSR_CODE,17,3) = '" +rScheme+ "' ";
	rs2 = stmt2.executeQuery(query2);
	rs2.next();

	query3 = " SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_SP_HC_PC_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND  SUBSTR(S.SCHEME_CODE,17,3) LIKE '%6%' AND A.HAB_CODE = '" +rHabitation+ "' AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME='PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.SPHCPCSC_CODE,1,16) = '" +rHabitation+ "' AND A.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND A.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND A.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' AND SUBSTR(H.SPHCPCSC_CODE,17,3) = '" +rScheme+ "' ";
	rs3 = stmt3.executeQuery(query3);
	rs3.next();

	query4 = " SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_CIS_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND  SUBSTR(S.SCHEME_CODE,17,3) LIKE '%6%' AND A.HAB_CODE = '" +rHabitation+ "' AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME='PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.CISSC_CODE,1,16) = '" +rHabitation+ "' AND A.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND A.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND A.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' AND SUBSTR(H.CISSC_CODE,17,3) = '" +rScheme+ "' ";
	rs4 = stmt4.executeQuery(query4);
	rs4.next();

	query5 = " SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_CP_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND  SUBSTR(S.SCHEME_CODE,17,3) LIKE '%6%' AND A.HAB_CODE = '" +rHabitation+ "' AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME='PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.CPSC_CODE,1,16) = '" +rHabitation+ "' AND A.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND A.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND A.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' AND SUBSTR(H.CPSC_CODE,17,3) = '" +rScheme+ "' ";
	rs5 = stmt5.executeQuery(query5);
	rs5.next();

	query6 = " SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_GLSR_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND  SUBSTR(S.SCHEME_CODE,17,3) LIKE '%6%' AND A.HAB_CODE = '" +rHabitation+ "' AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME='PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.GLSR_CODE,1,16) = '" +rHabitation+ "' AND A.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND A.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND A.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' AND SUBSTR(H.GLSR_CODE,17,3) = '" +rScheme+ "' ";
	rs6 = stmt6.executeQuery(query6);
	rs6.next();

	query7 = " SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_PM_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND  SUBSTR(S.SCHEME_CODE,17,3) LIKE '%6%' AND A.HAB_CODE = '" +rHabitation+ "' AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME='PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.PM_CODE,1,16) = '" +rHabitation+ "' AND  A.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND A.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND A.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' AND SUBSTR(H.PM_CODE,17,3) = '" +rScheme+ "' ";
	rs7 = stmt7.executeQuery(query7);
	rs7.next();
	
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
		<td class=rptValue>BORE WELL</td>
		<td class=rptValue><%=rs.getString(1)%></td>
		<td class=rptValue>DISTRIBUTION</td>
		<td class=rptValue><%=rs1.getString(1)%></td>
		<td class=rptValue>OHSR</td>
		<td class=rptValue><%=rs2.getString(1)%></td>
		<td class=rptValue>PUMP HOUSE</td>
		<td class=rptValue></td>		
	</tr>
	<tr>
		<td class=rptValue>ROTARY BORE WELL</td>
		<td class=rptValue></td>
		<td class=rptValue>STAND POSTS</td>
		<td class=rptValue><%=rs3.getString(1)%></td>
		<td class=rptValue>CISTERNS</td>
		<td class=rptValue><%=rs4.getString(1)%></td>
		<td class=rptValue>CAPACITORS</td>
		<td class=rptValue><%=rs5.getString(1)%></td>
	</tr>
	<tr>
		<td class=rptValue>IN TAKE WELL</td>
		<td class=rptValue></td>
		<td class=rptValue>PUMPING MAIN</td>
		<td class=rptValue><%=rs7.getString(1)%></td>
		<td class=rptValue>GLSR</td>
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
	//System.out.println("The Error is in check list assetcirdivsdiv form= " +e);
}
}
%>