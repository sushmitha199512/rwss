<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>District-Habitation-Report</font></td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=14>District: All</font></td>	
	</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1"))
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=14>District: <%=districtName%></font></td>	
	</tr>	

	<%
		}
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>District</td>	
		<td class=btext>Habitation Name</td>	
		<td class=btext>Habitation Status</td>
		<td class=btext>UpdateDate</td>
	 </tr>