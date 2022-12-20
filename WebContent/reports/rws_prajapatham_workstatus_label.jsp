<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=17>Works Status Report</font></td>	
</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=17>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext colspan = 15 align="right">Amount In Rs. Lakhs&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td class=btext colspan = 2 align="center">Administrative Sanction </td>
		<td class=btext colspan = 2 align="center">Revised Administrative Sanction </td>
		<td class=btext colspan = 2 align="center">Technical Sanction</td>
		<td class=btext colspan = 2 align="center">Revised Technical Sanction</td>
		
	
	</tr>
	<tr align = center>
		
		
		<td class=btext>No</td>
		<!-- <td class=btext>Administrative Sanction Estimate Amount</td> -->
		<td class=btext>Amount</td>
		
		<td class=btext>No</td>
		<!-- <td class=btext>Revised Administrative Sanction Estimate Amount</td> -->
		<td class=btext>Amount</td>
		
		<td class=btext>No</td>
		<!-- <td class=btext>Estimate Amount</td> -->
		<td class=btext>Amount</td>
		
		<td class=btext>No</td>
		<!-- <td class=btext>Revised Estimates Amount</td> -->
		<td class=btext>Amount</td>
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1")|| rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))
	/*if(rDistrict != null && !rDistrict.equals("00") && rConstituency!=null && rConstituency.equals("00")&& convalue==null || (rDistrict != null && rDistrict.equals("00") && distvalue!=null && convalue==null))*/
	{
	
		//System.out.println("IN DISTRICT SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=17>District: <%=districtName%>&nbsp;&nbsp;Division:All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Division</td>
		
		<td class=btext colspan = 15 align="right">Amount In Rs. Lakhs&nbsp;&nbsp;</td>
		
	</tr>
	<tr>
		<td class=btext colspan = 2 align="center">Administrative Sanction</td>
		<td class=btext colspan = 2 align="center">Revised Administrative Sanction</td>
		<td class=btext colspan = 2 align="center">Technical Sanction</td>
		<td class=btext colspan = 2 align="center">Revised Technical Sanction</td>
		
	
	</tr>
	<tr align = center>
		
		
		<td class=btext>No</td>
		<!-- <td class=btext>Administrative Sanction Estimate Amount</td> -->
		<td class=btext>Amount</td>
		
		<td class=btext>No</td>
		<!-- <td class=btext>Revised Administrative Sanction Estimate Amount</td> -->
		<td class=btext>Amount</td>
		
		<td class=btext>No</td>
		<!-- <td class=btext>Estimate Amount</td> -->
		<td class=btext>Amount</td>
		
		<td class=btext>No</td>
		<!-- <td class=btext>Revised Estimates Amount</td> -->
		<td class=btext>Amount</td>
	</tr>
<%
	}%>