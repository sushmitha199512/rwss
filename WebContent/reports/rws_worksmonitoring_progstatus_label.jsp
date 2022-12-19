
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=29>Program Wise Works Report</font></td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="btext" colspan=29  >District: All &nbsp; &nbsp;Program: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
		<td class=btext rowspan = 4>Program</td>
		
			
	<td colspan=12 class=btext align="center">Admn. San.</td>
	<td rowspan=3 colspan=1 class=btext align=center>Rev. Sanc</td>
	<td rowspan=3 colspan=2 class=btext align=center>Habs Sanctioned</td>
    <td colspan=5 class=btext align="center">Financial</td>
	<td colspan=7 class=btext align="center">Physical</td>
	</tr>
	<tr>
	<td colspan=6 class=btext align="center">Works</td>
	<td colspan=6 class=btext align="center">Amount</td>
	
	<td rowspan=3 colspan=1 class=btext align="center">Exp. Upto Last Fin. Year</td>	
	<td rowspan=2 colspan=3 class=btext align="center">Exp. During The Year</td>	
	<td rowspan=3 colspan=1 class=btext align="center">Total Exp.</td>	
	<td rowspan=2 colspan=6 class=btext align="center">Works</td>	
	<td rowspan=3 colspan=1 class=btext align="center">Habs Covered</td>	
	</tr>
	<tr>
	<td colspan=3 class=btext align="center">Plan</td>
	<td colspan=3 class=btext align="center">Non-Plan</td>
	<td colspan=3 class=btext align="center">Plan</td>
	<td colspan=3 class=btext align="center">Non-Plan</td>
	</tr>
	<tr>
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>	
	<td rowspan=1 colspan=1 class=btext align="center">New</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>
	<td rowspan=1 colspan=1 class=btext align="center">New</td>		
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>	
	<td rowspan=1 colspan=1 class=btext align="center">New</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>
	<td rowspan=1 colspan=1 class=btext align="center">New</td>		
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>
	<td rowspan=1 colspan=1 class=btext align="center">Amt</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Plan</td>
	<td rowspan=1 colspan=1 class=btext align="center">Non-Plan</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Upto Prev. Month</td>		
	<td rowspan=1 colspan=1 class=btext align="center">During The Month</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Cum.</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Tech. Sanctioned</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Tendered</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Agreement Entered</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Grounded</td>
	<td rowspan=1 colspan=1 class=btext align="center">Completed<br>(Incl. New Works)</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Commis<br>sioned</td>	
	</tr>
	
<%
	}
	else
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="btext" colspan=29>District: All &nbsp; &nbsp;Program:All</td><td class=btext colspan=7>Amount in Rs.Lakhs</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Program</td>
		
			
	<td colspan=6 class=btext align="center">Admn. San.</td>
	<td rowspan=2 colspan=1 class=btext align=center>Rev. Sanc</td>
	<td rowspan=3 class=btext align=center>Habs Sanctioned</td>
    <td colspan=5 class=btext align="center">Financial</td>
	<td colspan=7 class=btext align="center">Physical</td>
	</tr>
	<tr>
	<td colspan=3 class=btext align="center">Works</td>
	<td colspan=3 class=btext align="center">Amount</td>
	
	<td rowspan=2 colspan=1 class=btext align="center">Exp. Upto Last Fin. Year</td>	
	<td rowspan=1 colspan=3 class=btext align="center">Exp. During The Year</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Total Exp.</td>	
	<td rowspan=1 colspan=6 class=btext align="center">Works</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Habs Covered</td>	
	</tr>
	<tr>
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>	
	<td rowspan=1 colspan=1 class=btext align="center">New</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>
	<td rowspan=1 colspan=1 class=btext align="center">New</td>		
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>
	<td rowspan=1 colspan=1 class=btext align="center">Amt</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Upto Prev. Month</td>		
	<td rowspan=1 colspan=1 class=btext align="center">During The Month</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Cum.</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Tech. Sanctioned</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Tendered</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Agreement Entered</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Grounded</td>
	<td rowspan=1 colspan=1 class=btext align="center">Completed<br>(Incl. New Works)</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Commis<br>sioned</td>	
	</tr>
	
<%
	}
	%>
	