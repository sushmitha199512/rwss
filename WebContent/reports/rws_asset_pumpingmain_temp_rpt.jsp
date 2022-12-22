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
	//System.out.println("MandalName = " + mandalName);
	String panchayatName = (String) session.getAttribute("panchayatName");
	String villageName = (String) session.getAttribute("villageName");
	String habitationName = (String) session.getAttribute("habitationName");
	int CountNo = 0;	
	ArrayList ARPumpingMain = new ArrayList();
	ARPumpingMain = (ArrayList) session.getAttribute("pumpingmain");
	int limitPerPage = 20;
	String [] S1 = new String [ARPumpingMain.size()];
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
	
	if(assetCode != null && !assetCode.equals("0") && circleCode !=null && circleCode.equals("0") && mandalCode != null && mandalCode.equals("0") && panchayatCode == null && villageCode == null && habitationCode == null)
	{
		//System.out.println("Label Asset Type Selected...");
%>
	<tr align=center>
		<td class=bwborder colspan=13>Asset Type: <%=assetTypeName%></td>
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
		<td class=bwborder colspan=6>Asset Type: <%=assetTypeName%></td>
		<td class=bwborder colspan=7>Circle: <%=circleName%></td>
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
		<td class=bwborder colspan=6>Asset Type: <%=assetTypeName%></td>
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
		<td class=bwborder colspan=4>Panchayat: <%=panchayatName%></td>
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
		<td class=bwborder colspan=3>Asset Type: <%=assetTypeName%></td>
		<td class=bwborder colspan=2>Circle: <%=circleName%></td>
		<td class=bwborder colspan=3>Mandal: <%=mandalName%></td>
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
		<td class=bwborder colspan=3>Circle: <%=circleName%></td>
		<td class=bwborder colspan=2>Mandal: <%=mandalName%></td>
		<td class=bwborder colspan=2>Panchayat: <%=panchayatName%></td>
		<td class=bwborder colspan=2>Village: <%=villageName%></td>
		<td class=bwborder colspan=2>Habitation: <%=habitationName%></td>
<%
	}
%>
	</tr>
	<tr align=center>
		<td class=btext rowspan=2>Sl.No</td>
		<td class=rptLabel rowspan=2>Panchayat Name <br> Habitation  Name</td>		
		<td class=rptLabel rowspan=2>Scheme Code</td>		
		<td class=rptLabel colspan=2>Pumping Main</td>
		<td class=rptLabel colspan=2>Air Valve</td>
		<td class=rptLabel colspan=2>Scour Valve</td>
		<td class=rptLabel colspan=2>Sluice Valve</td>
		<td class=rptLabel colspan=2>Reflux Valve</td>
	</tr>
	<tr>
		<td class=rptLabel>Material <br> Class <br> Diameter <br> Lenght <br> Condition</td>		
		<td class=rptLabel>PM Rep <br> PM Nat <br> PM Nat Loc</td>		
		<td class=rptLabel>No</td>
		<td class=rptLabel>Con NR<br> Con CP</td>
		<td class=rptLabel>No</td>
		<td class=rptLabel>Con NR<br> Con CP</td>
		<td class=rptLabel>No</td>
		<td class=rptLabel>Con NR<br> Con CP</td>
		<td class=rptLabel>No</td>
		<td class=rptLabel>Con NR<br> Con CP</td>
	</tr>

<%
	int totalpgs = Math.round(ARPumpingMain.size() / limitPerPage);
	
	if ((totalpgs % limitPerPage) > 0) totalpgs++;
	//System.out.println("total = " + totalpgs);
	int pr ;
	int pg = 0;
	
	if(request.getParameter("pr") != null)
	{
		pr = Integer.parseInt(request.getParameter("pr"));
		pg = pr;
		//System.out.println(" if PR VALUe in if = " + pr);
	}
	else
		{
			pr = 0;
			//System.out.println("PR VALUe in else = " + pr);
		}

			//System.out.println("AR Size = " + ARPumpingMain.size());				
					for(int i = pr; i<limitPerPage + pg && i<ARPumpingMain.size(); i++)	
					{					
					S1 = (String[])ARPumpingMain.get(i);					
%>	
	<tr>
		<td class=rptValue><%=(i+1)%></td>
<%
						//for(int j=0; j<S1.length; j++)
						//{	

%>	
		<td class=rptValue><%=S1[0]%> <br> <%=S1[1]%></td>		
		<td class=rptValue><%=S1[2]%></td>
		<td class=rptValue><%=S1[3]%> <br> <%=S1[4]%> <br> <%=S1[5]%> <br> <%=S1[6]%> <br> <%=S1[7]%></td>	
		<td class=rptValue><%=S1[8]%> <br> <%=S1[9]%> <br> <%=S1[10]%></td>				
		<td class=rptValue><%=S1[11]%></td>		
		<td class=rptValue><%=S1[12]%> <br> <%=S1[13]%></td>		
		<td class=rptValue><%=S1[14]%></td>
		<td class=rptValue><%=S1[15]%> <br> <%=S1[16]%></td>
		<td class=rptValue><%=S1[17]%></td>
		<td class=rptValue><%=S1[18]%> <br> <%=S1[19]%></td>
		<td class=rptValue><%=S1[20]%></td>
		<td class=rptValue><%=S1[21]%> <br> <%=S1[22]%></td>
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
				
			<a href="rws_asset_pumpingmain_temp_rpt.jsp?pr=0">[First Page]</a> 
			<a href="rws_asset_pumpingmain_temp_rpt.jsp?pr=<%=pr-limitPerPage%>">[Previous Page]</a> 
<%
		}
			if (pr < (totalpgs * limitPerPage) - limitPerPage) 
			{
%>
				<a href="rws_asset_pumpingmain_temp_rpt.jsp?pr=<%=pr+limitPerPage%>">[Next Page]</a> 
				<a href="rws_asset_pumpingmain_temp_rpt.jsp?pr=<%=(totalpgs * limitPerPage) - limitPerPage%>">[Last Page]</a> 
<%
			}
			

%>
				
<%
	
}
catch(Exception e)
{
	//System.out.println("The Error in assetpumpingmainrpt.jsp = " + e);
}
%>
		</td>
	</tr>
</table>
</body>
</html>