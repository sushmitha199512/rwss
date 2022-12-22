<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Constituency Wise Coverage Status Report</font></td>	
	</tr>
<% 
	if(!rDistrict.equals("") && rDistrict.equals("00"))
	{
		//nic.watersoft.commons.Debug.println("IN DISTRICT ALL LABEL...HABI");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=distname%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=conname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=vilname%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		nic.watersoft.commons.Debug.println("IN DISTRICT SELECTION LABEL...HABI");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=conname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=vilname%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
		<td class=btext rowspan = 2>Total</td>	
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
			
	</tr>
<%
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
		nic.watersoft.commons.Debug.println("IN DISTRICT CONDTITUTENCY ALL SELECTION LABEL...HAB");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=conname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=vilname%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		nic.watersoft.commons.Debug.println("IN DISTRICT CONSTITUENCY SELETION...HAB");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=vilname%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
	{
		nic.watersoft.commons.Debug.println("DISTRICT CONSTITUENCY MANDAL ALL LABEL...HAB");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=vilname%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1") && rVillage.equals("-1"))
	{
		nic.watersoft.commons.Debug.println("DISTRIC MANDAL CONSTITUENCY SELECTION LABEL...HABI");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=vilname%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && rPanchayat.equals("00") && rVillage.equals("-1")) 
	{
		nic.watersoft.commons.Debug.println("IN DISTRICT MANDAL CONSTITUENCY PANCHAYAT ALL SELECTION LABEL...HAB");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=vilname%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1")) 
	{
		nic.watersoft.commons.Debug.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT SELECTION LABEL...HAB");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panchayatName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Village: <%=vilname%></td>
		<td align="center" class="rptValue" colspan=5></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>
		<td class=btext rowspan = 2>Total</td>	
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
				
	</tr>
<%
	}
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("-1") && !rConstituency.equals("00") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00")) 
	{
		nic.watersoft.commons.Debug.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE ALL SELECTION LABEL...HAB");
%>
	<tr bgcolor="#edf2f8" align="center">
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
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
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
%>