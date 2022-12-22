<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<head>
<title></title>
</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<%
	//System.out.println("*****************Form Begined*****************");
	String query = null;
	String rAssetTypeName = (String) session.getAttribute("assetTypeName");
	String rAssetType = request.getParameter("rAssetType");
	String districtCode = request.getParameter("districtCode");
%>
<table> <!-- Main Table Starts Here -->
	<tr>
		<td>		

		<!-- Main Fieldset Starts Here (Asset Check List) -->
<fieldset>
	<legend class=btext>Mandal List For Scheme <%=rAssetTypeName%> In District <%=</legend>
		<label>
			<table border=1 cellspacing=0 cellpadding=0 style="border-collapse:collapse" bgcolor="#edf2f8" bordercolor=#000000 align=center width="100%">				
				<tr>
					<td class=rptLabel>District</td>
					<td class=rptLabel>Count</td>
				</tr>
<%
try
{
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	query = "SELECT COUNT(*) COUNT, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_PANCHAYAT_RAJ_TBL PR, RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_SUBCOMP_PARAM_TBL H, RWS_ASSET_TYPE_TBL T WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE = '" +rAssetType+ "' AND SUBSTR(H.PUMP_CODE,17,3)LIKE '%6%' AND PR.PANCH_CODE = SUBSTR(H.PUMP_CODE,1,16) AND SUBSTR(H.PUMP_CODE,1,2) = D.DCODE GROUP BY D.DNAME ";
	rs = stmt.executeQuery(query);
	while (rs.next())
	{
%>
				<tr>
					<td class=bwborder><a href="./rws_asset_mandal_rpt.jsp?rAssetType=<%=rAssetType%>" target=_new><%=rs.getString(2)%></td>
					<td class=bwborder><%=rs.getString(1)%></td>
				</tr>		
<%
	}
	rs.close();
	stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error in assetdistrictborewellrpt.jsp = " + e);
}
%>

			</table>
		</label>
</fieldset>
		</td>
	</tr>
</table>
<%@ include file = "footer.jsp" %>