	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=24>RWS Planning Format - I Report</font></td>	
	</tr>

<% 
	if(rDistrict != null && rDistrict.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=24>District: All</font></td>	
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && rMandal.equals("-1"))
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=24>District: <%=districtName%></font></td>	
	</tr>
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1"))
		{
			//System.out.println("IN MANDAL ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=12>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=12>Mandal: All</font></td>
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
		{
			//System.out.println("IN MANDAL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=12>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=12>Mandal: <%=mandalName%></font></td>	
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && rPanchayat.equals("00"))
		{
			//System.out.println("IN PANCHAYAT ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=8>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=8>Mandal: <%=mandalName%></font></td>
		<td align="center" class="rptValue" colspan=8>Panchayat: All</font></td>	
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
		{
			//System.out.println("IN PANCHAYAT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=8>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=8>Mandal: <%=mandalName%></font></td>
		<td align="center" class="rptValue" colspan=8>Panchayat: <%=panchayatName%></font></td>
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
		{
			//System.out.println("IN VILLAGE ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=6>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=6>Mandal: <%=mandalName%></font></td>
		<td align="center" class="rptValue" colspan=6>Panchayat: <%=panchayatName%></font></td>
		<td align="center" class="rptValue" colspan=6>Village: All</font></td>
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && rHabitation.equals("-1"))
		{
			//System.out.println("IN VILLAGE SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=6>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=6>Mandal: <%=mandalName%></font></td>
		<td align="center" class="rptValue" colspan=6>Panchayat: <%=panchayatName%></font></td>
		<td align="center" class="rptValue" colspan=6>Village: <%=villageName%></font></td>
	</tr>
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && !rHabitation.equals("-1") && rHabitation.equals("00"))
		{
			//System.out.println("IN HABITATION ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=4>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=4>Mandal: <%=mandalName%></font></td>
		<td align="center" class="rptValue" colspan=4>Panchayat: <%=panchayatName%></font></td>
		<td align="center" class="rptValue" colspan=6>Village: <%=villageName%></font></td>
		<td align="center" class="rptValue" colspan=6>Habitation: All</font></td>
	</tr>
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && !rHabitation.equals("-1") && !rHabitation.equals("00"))
		{
			//System.out.println("IN HABITATION SELECTION LABEL...");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=4>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=4>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=4>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=6>Village: <%=villageName%></td>
		<td align="center" class="rptValue" colspan=6>Habitation: <%=habitationName%></td>		
	</tr>
<%
		}
%>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>District Code</td>
		<td class=btext>District Name</td>
		<td class=btext>Assembly Constituency Code</td>
		<td class=btext>Assembly Constituency Name</td>
		<td class=btext>Mandal Code</td>
		<td class=btext>MandalName</td>
		<td class=btext>Parliamentary Constituency</td>
		<td class=btext>Division</td>
		<td class=btext>Village Code</td>
		<td class=btext>Village Name</td>
		<td class=btext>Habitation Code</td>
		<td class=btext>Habitation Name</td>
		<td class=btext>Panchayat Code</td>
		<td class=btext>Panchayat Name</td>
		<td class=btext>PR Hab Code</td>
		<td class=btext>Total Population</td>
		<td class=btext>SC Population</td>
		<td class=btext>ST Population</td>
		<td class=btext>Status (1.4.05)</td>
		<td class=btext>NSS - Ty</td>
		<td class=btext>NSS - FI</td>
		<td class=btext>NSS - Br</td>
		<td class=btext>NSS - Ir</td>
	</tr>