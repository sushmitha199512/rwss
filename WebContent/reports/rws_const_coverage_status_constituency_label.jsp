<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Constituency Wise Coverage Status Report</font></td>	
	</tr>
<% 
	if(rDistrict!=null && rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...CONST");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=10>District: <%=distname%></td>		
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Constituency</td>	
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
%>