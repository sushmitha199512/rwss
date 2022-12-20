<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import = "java.util.*"%>
<html>
<head>
<title>Check List Report</title>
<%
	//System.out.println("************************REPORT BEGINING************************");
	String assetTypeName = (String) session.getAttribute("assetTypeName");
	String circleName = (String) session.getAttribute("circleName");
	String mandalName = (String) session.getAttribute("mandalName");	
	String panchayatName = (String) session.getAttribute("panchayatName");
	String villageName = (String) session.getAttribute("villageName");
	String habitationName = (String) session.getAttribute("habitationName");

	int CountNo = 0;	
	ArrayList ARBore = new ArrayList();
	ARBore = (ArrayList) session.getAttribute("boreWell");
	int limitPerPage = 20;
	String [] S1 = new String [ARBore.size()];
	int iPage = 0;
	String sPage = request.getParameter("pg");
	if(sPage != null && !sPage.equals("null"))
		iPage = Integer.parseInt(sPage);
%>
</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<%	
try
{		
%>
<table border=1 cellspacing=0 cellpadding=0 style="border-collapse:collapse" bgcolor="#edf2f8" width=100% bordercolor=#000000>
<%
	String assetCode = (String) session.getAttribute("assetTypeCode");
	//System.out.println("assetCode in Seeion = " + assetCode);
	String circleCode = (String) session.getAttribute("circleCode");
	//System.out.println("circleCode in Seeion = " + circleCode);
	String mandalCode = (String) session.getAttribute("mandalCode");
	//System.out.println("mandalCode in Seeion = " + mandalCode);
	String panchayatCode = (String) session.getAttribute("panchayatCode");
	//System.out.println("panchayatCode in Seeion = " + panchayatCode);
	String villageCode = (String) session.getAttribute("villageCode");
	//System.out.println("villageCode in Seeion = " + villageCode);
	String habitationCode = (String) session.getAttribute("habitationCode");
	//System.out.println("habitationCode in Seeion = " + habitationCode);
	
	if(assetCode != null && !assetCode.equals("0") && circleCode != null && circleCode.equals("0") && mandalCode != null && mandalCode.equals("0") && panchayatCode == null && villageCode == null && habitationCode == null)
	{
		//System.out.println("Label Asset Type Selected...");
%>
	<tr align=center>
		<td class=bwborder colspan=11>Asset Type: <%=assetTypeName%></td>
<%
	}	
%>
	</tr>
<%
	if(assetCode != null && !assetCode.equals("0") && circleCode !=null && !circleCode.equals("0") && mandalCode != null && mandalCode.equals("0") && panchayatCode == null && villageCode == null && habitationCode == null)
	{
		//System.out.println("Label Asset Type, Circle Selected...");
%>
	<tr align=center>
		<td class=bwborder colspan=5>Asset Type: <%=assetTypeName%></td>
		<td class=bwborder colspan=6>Circle: <%=circleName%></td>
<%
	}
%>
	</tr>
<%
	if(assetCode != null && !assetCode.equals("0") && circleCode !=null && !circleCode.equals("0") && mandalCode != null && !mandalCode.equals("0") && panchayatCode != null && panchayatCode.equals("0") && villageCode == null && habitationCode == null)
	{
		//System.out.println("Label Asset Type, Circle, Mandal Selected...");
%>
	<tr align=center>
		<td class=bwborder colspan=4>Asset Type: <%=assetTypeName%></td>
		<td class=bwborder colspan=4>Circle: <%=circleName%></td>
		<td class=bwborder colspan=3>Mandal: <%=mandalName%></td>
<%
	}
%>
	</tr>
<%
	if(assetCode != null && !assetCode.equals("0") && circleCode !=null && !circleCode.equals("0") && mandalCode != null && !mandalCode.equals("0") && panchayatCode != null && !panchayatCode.equals("0") && villageCode != null && villageCode.equals("0") && habitationCode == null)
	{
		//System.out.println("Label Asset Type, Circle, Mandal, Panchayat Selected...");
%>
	<tr align=center>
		<td class=bwborder colspan=3>Asset Type: <%=assetTypeName%></td>
		<td class=bwborder colspan=3>Circle: <%=circleName%></td>
		<td class=bwborder colspan=3>Mandal: <%=mandalName%></td>
		<td class=bwborder colspan=2>Panchayat: <%=panchayatName%></td>
<%
	}
%>
	</tr>
<%
	if(assetCode != null && !assetCode.equals("0") && circleCode !=null && !circleCode.equals("0") && mandalCode != null && !mandalCode.equals("0") && panchayatCode != null && !panchayatCode.equals("0") && villageCode != null && !villageCode.equals("0") && habitationCode != null && habitationCode.equals("0"))
	{
		//System.out.println("Label Asset Type, Circle, Mandal, Panchayat, Village Selected...");
%>
	<tr align=center>
		<td class=bwborder colspan=2>Asset Type: <%=assetTypeName%></td>
		<td class=bwborder colspan=2>Circle: <%=circleName%></td>
		<td class=bwborder colspan=2>Mandal: <%=mandalName%></td>
		<td class=bwborder colspan=2>Panchayat: <%=panchayatName%></td>
		<td class=bwborder colspan=3>Village: <%=villageName%></td>
<%
	}
%>
	</tr>
<%
	if(assetCode != null && !assetCode.equals("0") && circleCode !=null && !circleCode.equals("0") && mandalCode != null && !mandalCode.equals("0") && panchayatCode != null && !panchayatCode.equals("0") && villageCode != null && !villageCode.equals("0") && habitationCode != null && !habitationCode.equals("0"))
	{
		//System.out.println("Label Asset Type, Circle, Mandal, Panchayat, Village, Habitation Selected...");
%>
	<tr align=center>
		<td class=bwborder colspan=2>Asset Type: <%=assetTypeName%></td>
		<td class=bwborder colspan=2>Circle: <%=circleName%></td>
		<td class=bwborder colspan=1>Mandal: <%=mandalName%></td>
		<td class=bwborder colspan=2>Panchayat: <%=panchayatName%></td>
		<td class=bwborder colspan=2>Village: <%=villageName%></td>
		<td class=bwborder colspan=2>Habitation: <%=habitationName%></td>
<%
	}
%>
	</tr>

	<tr align=center>
		<td class=rptLabel rowspan=2>Sl.No</td>
		<td class=rptLabel rowspan=2>Panchayat Name<br>Habitation Name</td>
		<td class=rptLabel rowspan=2>Schme Code</td>
		<td class=rptLabel rowspan=2>Designed Population</td>
		<td class=rptLabel colspan=7>Source</td>				
	</tr>
	<tr>
		<td class=rptLabel>Name<br>Quality</td>				
		<td class=rptLabel>Yeild</td>
		<td class=rptLabel>Dependency</td>
		<td class=rptLabel>Depth</td>
		<td class=rptLabel>Diameter</td>
		<td class=rptLabel>Condition</td>
		<td class=rptLabel>Summer <br> Normal <br>Water Level</td>		
	</tr>

<%
	int totalpgs = Math.round(ARBore.size() / limitPerPage);
	
	if ((totalpgs % limitPerPage) > 0) totalpgs++;
	//System.out.println("total = " + totalpgs);
	int pr ;
	int pg = 0;
	int pgCntNo = 0;
	
	if(request.getParameter("pr") != null)
	{
		pr = Integer.parseInt(request.getParameter("pr"));
		pg = pr;
		//System.out.println(" if PR VALUE in if = " + pr);
	}
	else
		{
			pr = 0;
			//System.out.println("PR VALUE in else = " + pr);
		}
	if(request.getParameter("pgCntNo") != null)
	{
		pgCntNo = Integer.parseInt(request.getParameter("pgCntNo"));
		pgCntNo = pgCntNo + 1;		
		//System.out.println(" if PR VALUe in if = " + pgCntNo);
	}
	else
		{
			pgCntNo = 1;			
			//System.out.println("PR VALUe in else = " + pgCntNo);
		}

			//System.out.println("AR Size = " + ARBore.size());				
					for(int i = pr; i<limitPerPage + pg && i<ARBore.size(); i++)	
					{					
					S1 = (String[])ARBore.get(i);					
%>	
	<tr>
		<td class=bwborder><%=(i+1)%></td>
<%
						//for(int j=0; j<S1.length; j++)
						//{	

%>	
		<td class=bwborder><%=S1[0]%><br><%=S1[1]%></td>		
		<td class=bwborder><%=S1[2]%></td>
		<td class=bwborder><%=S1[3]%></td>		
		<td class=bwborder><%=S1[4]%><br><%=S1[5]%></td>		
		<td class=bwborder><%=S1[6]%></td>
		<td class=bwborder><%=S1[7]%></td>
		<td class=bwborder><%=S1[8]%></td>
		<td class=bwborder><%=S1[9]%></td>
		<td class=bwborder><%=S1[10]%></td>
		<td class=bwborder><%=S1[11]%><br><%=S1[12]%></td>		
		
<%
						//}
%>
	</tr>
<%
					}
%>
</table>
<table>
	<tr>
		<td colspan= 11>
<%
		if (pr > 0) 
		{
%>
				
			<a href="rws_asset_borewell_temp_rpt.jsp?pr=0">[First Page]</a> 
			<a href="rws_asset_borewell_temp_rpt.jsp?pr=<%=pr-limitPerPage%>&pg=<%=iPage-1%>">[Previous Page]</a> 
<%
		}
			if (pr < (totalpgs * limitPerPage) - limitPerPage) 
			{
%>
				<a href="rws_asset_borewell_temp_rpt.jsp?pr=<%=pr+limitPerPage%>&pg=<%=iPage+1%>">[Next Page]</a> 
				<a href="rws_asset_borewell_temp_rpt.jsp?pr=<%=(totalpgs * limitPerPage) - limitPerPage%>&pg=<%=(iPage * limitPerPage) - limitPerPage%>">[Last Page]</a> 
<%
			}
%>
				<td class=bwborder><%=(iPage + 1)%> Of <%=totalpgs%></td>
<%
	
}
catch(Exception e)
{
	//System.out.println("The Error in assetborewellrpt.jsp = " + e);
}
%>
		</td>
	</tr>
</table>
</body>
</html>