<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Constituency Wise Coverage Status Report</font></td>	
	</tr>
<% 
	if(!rDistrict.equals("") && rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...VILL");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=distname%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=conname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
	<tr align=center bgcolor="#ffffff" align=center>
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		//System.out.println("IN DISTRICT SELECTION LABEL...VILL");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=conname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
	<tr align=center bgcolor="#ffffff" align=center>
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY ALL SELECTION LABEL...VILL");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=conname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
	<tr align=center bgcolor="#ffffff" align=center>
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY SELETION LABEL...VILL");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
	<tr align=center bgcolor="#ffffff" align=center>
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY MANDAL ALL SELECTION LABEL...VILL");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
	<tr align=center bgcolor="#ffffff" align=center>
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		//System.out.println("DISTRICT MANDAL CONSTITUENCY SELECTION LABEL...VILL");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
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
	if(!rDistrict.equals("") && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") &&  !rPanchayat.equals("-1")&& rPanchayat.equals("00"))
	{
		//System.out.println("DISTRICT MANDAL CONSTITUENCY PANCHAYAT ALL SELECTION LABEL...VILL");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="center" class="rptValue" colspan=5>Mandal: <%=manname%></td>
		<td align="center" class="rptValue" colspan=5>Panchayat: <%=panname%></td>
		</tr>
	
	<tr align=center bgcolor="#ffffff" align=center>
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
%>