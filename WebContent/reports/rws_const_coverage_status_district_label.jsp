	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Constituency Wise Coverage Status Report</font></td>	
	</tr>
<%
	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		//System.out.println("IN DISTRICT ALL SELECTION LABEL...");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=10>District: <%=name%></td>		
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Constituency</td>		
		<td class=btext colspan = 8>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>No Data</td>		
	</tr>
<%
	}	
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("-1"))
	{
		//System.out.println("IN DISTRICT, CONSTITUENCY SELECTION LABEL...");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Mandal</td>		
		<td class=btext colspan = 8>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>No Data</td>		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && rMandal.equals("00"))
	{
		//System.out.println("IN DISTRICT, CONSTITUENCY MANDAL ALL SELECTION LABEL...");	
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=3>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=3>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=4>Mandal: All</td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Mandal</td>		
		<td class=btext colspan = 8>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>No Data</td>		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && rPanchayat.equals("-1"))
	{
		//System.out.println("IN DISTRICT, CONSTITUENCY MANDAL SELECTION LABEL...");	
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=3>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=3>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=4>Mandal: <%=mandalName%></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Panchayat</td>		
		<td class=btext colspan = 8>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>No Data</td>		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && rPanchayat.equals("00"))
	{
		//System.out.println("IN DISTRICT, CONSTITUENCY MANDAL PANCHAYAT ALL SELECTION LABEL...");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=3>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=3>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=2>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=2>Panchayat: All</td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Panchayat</td>		
		<td class=btext colspan = 8>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>No Data</td>		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
	{
		//System.out.println("IN DISTRICT, CONSTITUENCY MANDAL PANCHAYAT SELECTION LABEL...");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=3>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=3>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=2>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=2>Panchayat: <%=panchayatName%></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Village</td>		
		<td class=btext colspan = 8>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>No Data</td>		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT, CONSTITUENCY MANDAL PANCHAYAT, VILLAGE ALL SELECTION LABEL...");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=2>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=2>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=2>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=2>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=2>Village: All</td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Village</td>		
		<td class=btext colspan = 8>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>No Data</td>		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("00") && !rMandal.equals("-1") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT, CONSTITUENCY MANDAL PANCHAYAT, VILLAGE SELECTION LABEL...");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=2>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=2>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=2>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=2>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=2>Village: <%=villageName%></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>		
		<td class=btext colspan = 8>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>No Data</td>		
	</tr>
<%
	}
%>