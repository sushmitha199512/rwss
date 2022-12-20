<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Constituency Wise Coverage Status Report</font></td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00"))
	{
		//Debug.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr align="center" bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=10><b>District:</b> All</td>		
	</tr>	
	<tr align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center >
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=10>District: <%=districtName%></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Constituency</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Constituency</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		//Debug.println("IN DISTRICT CONSTITUENCY SELECTION LABEL...COVERAGE");
%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
	</tr>	
	<tr align=center align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Mandal</td>	
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
	{
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: All</td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Mandal</td>	
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") & rPanchayat.equals("-1"))
	{
		//Debug.println("DISTRICT CONSTITUENCY MANDAL SELETION LABEL...COVERAGE");
%>
	<tr align="center" bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Panchayat</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
			
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("00") && !rPanchayat.equals("-1"))
	{
		//Debug.println("DISTRICT MANDAL CONSTITUENCY PANCHAYAT ALL SELECTION LABEL...COVERAGE");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Panchayat</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && rVillage.equals("-1"))
	{
		//Debug.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT SELECTION LABEL...COVERAGE");
%>
	<tr align="center" bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panchayatName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: All</td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Village</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		//Debug.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE ALL SELECTION LABEL...COVERAGE");
%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panchayatName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: All</td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Village</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
			
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && !rVillage.equals("00"))
	{
		//Debug.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE SELECTION LABEL...COVERAGE");
%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panchayatName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=villageName%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
<%
	}
%>