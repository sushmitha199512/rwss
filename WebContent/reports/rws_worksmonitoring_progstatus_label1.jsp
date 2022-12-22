<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>Works Report</font></td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00") && progvalue!=null && distvalue==null)
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="btext" colspan=18>District:All &nbsp;Program:<%=progname%></td><td class=btext colspan=7>Amount in Rs Lakhs</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
			
		
	
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
	<td rowspan=1 colspan=1 class=btext align="center">Completed</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Commissioned</td>	
	</tr>
	
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency!=null && rConstituency.equals("00")&& progvalue!=null && convalue==null || (rDistrict != null && rDistrict.equals("00")&& progvalue!=null && distvalue!=null && convalue==null))
	{
		//System.out.println("IN DISTRICT SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="btext" colspan=18>District:<%=districtName%>&nbsp;Division:All&nbsp;&nbsp;Program: <%=progname%></td><td class=btext colspan=7>Amount in Rs Lakhs</td>
		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Division</td>
			
		
	
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
	<td rowspan=1 colspan=1 class=btext align="center">Completed</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Commissioned</td>	
	</tr>
<%
	}
	
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency!=null && !rConstituency.equals("00") && !rConstituency.equals("-1") && progvalue!=null || (rDistrict!=null && !rDistrict.equals("00")  && rConstituency==null && convalue!=null && progvalue!=null)|| (rDistrict != null && rDistrict.equals("00")&& progvalue!=null && convalue!=null && distvalue!=null))
	{
	
%>
	<tr  align="center">
		<td align="center" class="btext" colspan=18>District:<%=districtName%>&nbsp;&nbsp;Division: <%=constituencyName%>&nbsp;&nbsp;Program:<%=progname%></td><td class=btext colspan=7>Amount in Rs Lakhs</td>
		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>WorkName</td>
			
		
	
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
	<td rowspan=1 colspan=1 class=btext align="center">Completed</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Commissioned</td>	
	</tr>
<%
	}%>
	
	