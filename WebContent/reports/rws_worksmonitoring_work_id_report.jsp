<tr bgcolor="#8A9FCD" align="center">
<%	//	nic.watersoft.commons.Debug.println("IN DISTRICT ALL LABEL...COVERAGE"); %>
		<td align="center" class="rptHeading" colspan=40>Work Id Based Report</font></td>	
	</tr>
<% 

if(work_id!=null || work_id!="")
	{

%>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Work ID</td>
		<td class=btext rowspan = 2>Work Name</td>
		<td class=btext rowspan = 2>Program</td>
		<td class=btext rowspan = 2>Sub Program</td>
		<td colspan=5 class=btext align="center">Administrative Sanction</td>
		<td colspan=3 class=btext align="center">Technical Sancation</td>
		<td colspan=1 class=btext align="center">Source Identification</td>
		<td colspan=5 class=btext align="center">Contractor Management</td>
		<td colspan=1 class=btext align="center">Work Expenditure</td>				
		<td colspan=7 class=btext align="center">Work Completion</td>		
	</tr>
	<tr>
			<td colspan=1 class=btext align="center">Number</td>
			<td colspan=1 class=btext align="center">Date</td>
			<td colspan=1 class=btext align="center">Est. Cost<br>(In Lakhs)</td>
			<td colspan=1 class=btext align="center">Programme Name(more than one prog)</td>
			<td colspan=1 class=btext align="center">Sanction Amt(more than one prog)</td>
			
			<td colspan=1 class=btext align="center">Number</td>
			<td colspan=1 class=btext align="center">Date</td>
			<td colspan=1 class=btext align="center">Amount<br>(In Lakhs)</td>
			
			<td colspan=1 class=btext align="center">Source Name</td>

			<td colspan=1 class=btext align="center">Contractor Name</td>
			<td colspan=1 class=btext align="center">Agreement No</td>
			<td colspan=1 class=btext align="center">Agreement Duration<br>(in months)</td>
			<td colspan=1 class=btext align="center">Agreement Date</td>
			<td colspan=1 class=btext align="center">Site Hand <BR> Over Date</td>

			
			<td colspan=1 class=btext align="center">Total Exp.(In Lakh)</td>
		
			<td colspan=1 class=btext align="center">Stipulated<br>Date Of<br>Completion</td>
			<td colspan=1 class=btext align="center">Actual Date<br>Of Completion</td>
			<td colspan=1 class=btext align="center">Date Of <br>Commissioning</td>
			<td colspan=1 class=btext align="center">Habitations<br>Sanctioned</td>
			<td colspan=1 class=btext align="center">Habitations<br>Benefited</td>
			<td colspan=1 class=btext align="center">Physical Stage <br>/ Remarks</td>

	</tr>
<%
}
%>