<%
if((rDivision != null) && (!rDivision.equals("0")) && (rCircle != null) && (!rCircle.equals("0")) && (rAssetType != null) && (!rAssetType.equals("0")) && (rAssetType.equals("01")) && (rSubDivision.equals("0")) && (rMandal != null) && (!rMandal.equals("0")) && (rPanchayat.equals("0")))
{
	//System.out.println("ASSET TYPE & CIRCLE & DIVISION & MANDAL SELECTED...");
	
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
	
	query = " SELECT COUNT(*) FROM RWS_PWS_SUBCOMP_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.PUMP_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.PUMP_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.PUMP_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.PUMP_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE " ;
	rs = stmt.executeQuery(query);
	rs.next();

	query1 = " SELECT COUNT(*) FROM RWS_PWS_DISTRI_SC_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.DISTRISC_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.DISTRISC_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.DISTRISC_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.DISTRISC_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE ";	
	rs1 = stmt1.executeQuery(query1);
	rs1.next();

	query2 = " SELECT COUNT(*) FROM RWS_PWS_OHSR_SC_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.OHSR_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.OHSR_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.OHSR_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.OHSR_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE ";
	rs2 = stmt2.executeQuery(query2);
	rs2.next();

	query3 = " SELECT COUNT(*) FROM RWS_PWS_SP_HC_PC_SC_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.SPHCPCSC_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.SPHCPCSC_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.SPHCPCSC_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.SPHCPCSC_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE ";
	rs3 = stmt3.executeQuery(query3);
	rs3.next();

	query4 = " SELECT COUNT(*) FROM RWS_PWS_CIS_SC_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.CISSC_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.CISSC_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.CISSC_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.CISSC_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE ";	
	rs4 = stmt4.executeQuery(query4);
	rs4.next();

	query5 = " SELECT COUNT(*) FROM RWS_PWS_CP_SC_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.CPSC_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.CPSC_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.CPSC_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.CPSC_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE ";
	rs5 = stmt5.executeQuery(query5);
	rs5.next();

	query6 = " SELECT COUNT(*) FROM RWS_PWS_GLSR_SC_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.GLSR_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.GLSR_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.GLSR_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.GLSR_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE ";
	rs6 = stmt6.executeQuery(query6);
	rs6.next();

	query7 = " SELECT COUNT(*) FROM RWS_PWS_PM_SC_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.PM_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.PM_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.PM_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.PM_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE ";
	rs7 = stmt7.executeQuery(query7);
	rs7.next();	

	query8 = " SELECT COUNT(*) COUNT FROM RWS_PWS_PUMPHOUSE_PARAM_TBL A, RWS_ASSET_MAST_TBL B, RWS_ASSET_SCHEME_TBL C WHERE  B.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND B.DIVISION_OFFICE_CODE = '" +rDivision+ "' AND SUBSTR(A.PUMPHOUSE_CODE,1,16) = B.HAB_CODE AND SUBSTR(A.PUMPHOUSE_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(A.PUMPHOUSE_CODE,6,2) = '" +rMandal+ "' AND B.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(A.PUMPHOUSE_CODE,17,3) LIKE '%6%' AND A.ASSET_CODE = C.ASSET_CODE ";	
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
		//System.out.println("HERE BORE WELL CIRDIVMAND");
%>
		<td class=rptValue>BORE WELL</td>
<%		
		}
		else 
		{
			//System.out.println("NOT HERE");
%>
		<td class=rptValue><a href="./rws_asset_cirdivmand_borewell_rpt.jsp">BORE WELL</td>
<%
		}
%>
		<td class=rptValue><%=rs1.getString(1)%></td>
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
		<td class=rptValue><a href="./rws_asset_cirdivmand_distri_rpt.jsp">DISTRIBUTION</td>
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
		<td class=rptValue><a href="./rws_asset_cirdivmand_ohsr_rpt.jsp">OHSR</td>
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
			<td class=rptValue><a href="./rws_asset_cirdivmand_pumphouse_rpt.jsp">PUMP HOUSE</td>
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
		<td class=rptValue><a href="./rws_asset_cirdivmand_standposts_rpt.jsp">STAND POSTS</td>
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
		<td class=rptValue><a href="./rws_asset_cirdivmand_cis_rpt.jsp">CISTERNS</td>
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
		<td class=rptValue><a href="./rws_asset_cirdivmand_capac_rpt.jsp">CAPACITORS</td>
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
		<td class=rptValue><a href="./rws_asset_cirdivmand_pumpingmain_rpt.jsp">PUMPING MAIN</td>
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
		<td class=rptValue><a href="./rws_asset_cirdivmand_glsr_rpt.jsp">GLSR</td>
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
	//System.out.println("The Error is in check list assetcirdiv form= " +e);
}
}
%>