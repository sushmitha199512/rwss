	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=14>RWS Planning Format - II Report</font></td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00"))
		{
			//System.//out.println("IN DISTRICT ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=14>District: All</font></td>	
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && rMandal.equals("-1"))
		{
			System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=14>District: <%=districtName%></font></td>	
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
		{
			System.out.println("IN MANDAL ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=7>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=7>Mandal: All</font></td>
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00"))
		{
			System.out.println("IN MANDAL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=7>District: <%=districtName%></font></td>
		<td align="center" class="rptValue" colspan=7>Mandal: <%=mandalName%></font></td>	
	</tr>	
<%
		}
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>District</td>		
		<td class=btext>Mandal</td>		
		<td class=btext>NC</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		<td class=btext>FC</td>
		<td class=btext>NSS_F1</td>
		<td class=btext>NSS_Br</td>
		<td class=btext>NSS_Ir</td>
		<td class=btext>NSS_Others</td>
		<td class=btext>Total Hab's</td>	
	</tr>