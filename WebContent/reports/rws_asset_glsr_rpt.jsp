<%@ include file = "conn.jsp" %>
<%
	//System.out.println("************************REPORT BEGINING************************");
	String query = null;
	ArrayList AR = new ArrayList();
	
	ResultSetMetaData rsm = null;
	
	int Count = 0;
	int c = 0;	
%>

<%	
	String rAssetType = request.getParameter("rAssetType");
	String rCircle = request.getParameter("rCircle");
	String rMandal = request.getParameter("rMandal");
	String rPanchayat = request.getParameter("rPanchayat");
	String rVillage = request.getParameter("rVillage");
	String rHabitation = request.getParameter("rHabitation");
	//System.out.println("assetType = " + rAssetType);
	//System.out.println("circleCode = " + rCircle);
	//System.out.println("mandalCode = " + rMandal);
	//System.out.println("panchayatCode = " + rPanchayat);
	//System.out.println("villageCode = " + rVillage);
	//System.out.println("habitationCode = " + rHabitation);
try
{
	stmt = conn.createStatement();
	if(rAssetType != null && rCircle == null && !rAssetType.equals("0") && rMandal == null && rPanchayat == null && rVillage == null && rHabitation == null)
	{
		//System.out.println("FIRST QUERY...");
	query = " SELECT P.PNAME, PR.PANCH_NAME, H.GLSR_CODE, H.GLSR_NO, H.GLSR_LOC, H.GLSR_CAP_LTS, H.GLSR_MADE, H.GLSR_COND, H.GLSR_FILL_HRS, H.GLSR_EMPTY_HRS, H.GLSR_DRA_COND, H.GLSR_HYG FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_GLSR_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T, RWS_PANCHAYAT_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.GLSR_CODE,17,3) LIKE '%6%' AND SUBSTR(H.GLSR_CODE,1,2) = P.DCODE AND SUBSTR(H.GLSR_CODE,6,2) = P.MCODE AND SUBSTR(H.GLSR_CODE,13,2) = P.PCODE AND SUBSTR(H.GLSR_CODE,1,16) = PR.PANCH_CODE ORDER BY H.GLSR_CODE " ; 
	}
	if(rAssetType != null && rCircle != null && !rAssetType.equals("0") && !rCircle.equals("0") && rMandal == null && rPanchayat == null && rVillage == null && rHabitation == null)
	{
		//System.out.println("SECOND QUERY...");
	query = " SELECT P.PNAME, PR.PANCH_NAME, H.GLSR_CODE, H.GLSR_NO, H.GLSR_LOC, H.GLSR_CAP_LTS, H.GLSR_MADE, H.GLSR_COND, H.GLSR_FILL_HRS, H.GLSR_EMPTY_HRS, H.GLSR_DRA_COND, H.GLSR_HYG FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_GLSR_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T, RWS_PANCHAYAT_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.GLSR_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(H.GLSR_CODE,17,3) LIKE '%6%' AND SUBSTR(H.GLSR_CODE,1,2) = P.DCODE AND SUBSTR(H.GLSR_CODE,6,2) = P.MCODE AND SUBSTR(H.GLSR_CODE,13,2) = P.PCODE AND SUBSTR(H.GLSR_CODE,1,16) = PR.PANCH_CODE ORDER BY H.GLSR_CODE " ; 
	}
	if(rAssetType != null && rCircle != null && !rAssetType.equals("0") && !rCircle.equals("0") && rMandal != null && !rMandal.equals("0") && rPanchayat == null && rVillage == null && rHabitation == null)
	{
		//System.out.println("THIRD QUERY...");
	query = " SELECT P.PNAME, PR.PANCH_NAME, H.GLSR_CODE, H.GLSR_NO, H.GLSR_LOC, H.GLSR_CAP_LTS, H.GLSR_MADE, H.GLSR_COND, H.GLSR_FILL_HRS, H.GLSR_EMPTY_HRS, H.GLSR_DRA_COND, H.GLSR_HYG FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_GLSR_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T, RWS_PANCHAYAT_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.GLSR_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(H.GLSR_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.GLSR_CODE,17,3) LIKE '%6%' AND SUBSTR(H.GLSR_CODE,1,2) = P.DCODE AND SUBSTR(H.GLSR_CODE,6,2) = P.MCODE AND SUBSTR(H.GLSR_CODE,13,2) = P.PCODE AND SUBSTR(H.GLSR_CODE,1,16) = PR.PANCH_CODE ORDER BY H.GLSR_CODE " ; 
	}
	if(rAssetType != null && rCircle != null && !rAssetType.equals("0") && !rCircle.equals("0") && rMandal != null && !rMandal.equals("0") && rPanchayat != null && !rPanchayat.equals("0") && rVillage == null && rHabitation == null)
	{
		//System.out.println("FOURTH QUERY...");
	query = " SELECT P.PNAME, PR.PANCH_NAME, H.GLSR_CODE, H.GLSR_NO, H.GLSR_LOC, H.GLSR_CAP_LTS, H.GLSR_MADE, H.GLSR_COND, H.GLSR_FILL_HRS, H.GLSR_EMPTY_HRS, H.GLSR_DRA_COND, H.GLSR_HYG FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_GLSR_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T, RWS_PANCHAYAT_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.GLSR_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(H.GLSR_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.GLSR_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(H.GLSR_CODE,17,3) LIKE '%6%' AND SUBSTR(H.GLSR_CODE,1,2) = P.DCODE AND SUBSTR(H.GLSR_CODE,6,2) = P.MCODE AND SUBSTR(H.GLSR_CODE,13,2) = P.PCODE AND SUBSTR(H.GLSR_CODE,1,16) = PR.PANCH_CODE ORDER BY H.GLSR_CODE " ; 
	}
	if(rAssetType != null && rCircle != null && !rAssetType.equals("0") && !rCircle.equals("0") && rMandal != null && !rMandal.equals("0") && rPanchayat != null && !rPanchayat.equals("0") && rVillage != null && !rVillage.equals("0") && rHabitation == null)
	{
		//System.out.println("FIFTH QUERY...");
	query = " SELECT P.PNAME, PR.PANCH_NAME, H.GLSR_CODE, H.GLSR_NO, H.GLSR_LOC, H.GLSR_CAP_LTS, H.GLSR_MADE, H.GLSR_COND, H.GLSR_FILL_HRS, H.GLSR_EMPTY_HRS, H.GLSR_DRA_COND, H.GLSR_HYG FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_GLSR_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T, RWS_PANCHAYAT_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.GLSR_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(H.GLSR_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.GLSR_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(H.GLSR_CODE,8,3) = '" +rVillage+ "' AND SUBSTR(H.GLSR_CODE,17,3) LIKE '%6%' AND SUBSTR(H.GLSR_CODE,1,2) = P.DCODE AND SUBSTR(H.GLSR_CODE,6,2) = P.MCODE AND SUBSTR(H.GLSR_CODE,13,2) = P.PCODE AND SUBSTR(H.GLSR_CODE,1,16) = PR.PANCH_CODE ORDER BY H.GLSR_CODE " ;
	}
	if(rAssetType != null && rCircle != null && !rAssetType.equals("0") && !rCircle.equals("0") && rMandal != null && !rMandal.equals("0") && rPanchayat != null && !rPanchayat.equals("0") && rVillage != null && !rVillage.equals("0") && rHabitation != null && !rHabitation.equals("0"))
	{
		//System.out.println("SIXTH QUERY...");
	query = " SELECT P.PNAME, PR.PANCH_NAME, H.GLSR_CODE, H.GLSR_NO, H.GLSR_LOC, H.GLSR_CAP_LTS, H.GLSR_MADE, H.GLSR_COND, H.GLSR_FILL_HRS, H.GLSR_EMPTY_HRS, H.GLSR_DRA_COND, H.GLSR_HYG FROM RWS_ASSET_MAST_TBL A, RWS_ASSET_SCHEME_TBL S, RWS_PWS_GLSR_SC_PARAM_TBL H, RWS_ASSET_TYPE_TBL T, RWS_PANCHAYAT_TBL P, RWS_PANCHAYAT_RAJ_TBL PR WHERE A.ASSET_CODE = S.ASSET_CODE AND A.ASSET_CODE = H.ASSET_CODE AND A.TYPE_OF_ASSET_CODE = T.TYPE_OF_ASSET_CODE AND T.TYPE_OF_ASSET_NAME = 'PWS' AND A.TYPE_OF_ASSET_CODE='" +rAssetType+ "' AND SUBSTR(H.GLSR_CODE,1,16) = '" +rHabitation+ "' AND SUBSTR(H.GLSR_CODE,17,3) LIKE '%6%' AND SUBSTR(H.GLSR_CODE,1,2) = P.DCODE AND SUBSTR(H.GLSR_CODE,6,2) = P.MCODE AND SUBSTR(H.GLSR_CODE,13,2) = P.PCODE AND SUBSTR(H.GLSR_CODE,1,16) = PR.PANCH_CODE ORDER BY H.GLSR_CODE " ;
	}
	//System.out.println("query is  "+query);
	rs = stmt.executeQuery(query);
	rsm = rs.getMetaData();
	Count = rsm.getColumnCount();
	//System.out.println("Count = "+Count);
	while (rs.next())
	{

		String [] S = new String [Count];
			for(int i=0; i<Count; i++)
			{				
				c = i + 1;
				S[i] = rs.getString(c);
			}
				AR.add(S);
	}
	session.setAttribute("glsr", AR);
	rs.close();
	stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error in assetpumpingmain_rpt.jsp = " + e);
}
%>
<%@ include file="./rws_asset_glsr_temp_rpt.jsp"%>