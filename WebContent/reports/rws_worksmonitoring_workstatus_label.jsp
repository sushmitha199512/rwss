<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=29>DistrictWise-Works Report</font></td>	
	</tr>
<% 

	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		////System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="btext" colspan=29>District: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
		<td class=btext rowspan = 4>District</td>
		
			
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
	<td rowspan=3 colspan=1 class=btext align="center">Habs Covered(Completed Works)</td>	
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
	if(((rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1")) ||(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))) && drill.equals("1"))
	{
%>
   <tr  align="center">
		<td align="center" class="btext" colspan=29>District:<%if(districtName1!=null)out.println(districtName1); else out.println(districtName);%></td>
	</tr>	
		
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
		<td class=btext rowspan = 4>Division</td>
		
			
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
	<td rowspan=3 colspan=1 class=btext align="center">Habs Covered(Completed Works)</td>	
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

	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1"))
	{
		////System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE SELECTION LABEL...COVERAGE");

%>
	<tr  align="center">
		<td align="center" class="btext" colspan=29>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=districtName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Division:<%=constituencyName%></td>
		</tr>		
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
		<td class=btext rowspan = 4>Sub Division</td>
		
			
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
	<td rowspan=3 colspan=1 class=btext align="center">Habs Covered(Completed Works)</td>	
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
	if(drill.equals("2"))
	{
		////System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE SELECTION LABEL...COVERAGE");

%>
	<tr  align="center">
		<td align="center" class="btext" colspan=29>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=districtName1%></td>
		</tr>		
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
		<td class=btext rowspan = 4>Division</td>
		
			
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
	<td rowspan=3 colspan=1 class=btext align="center">Habs Covered(Completed Works)</td>	
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
	if(drill.equals("3"))
	{
		////System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE SELECTION LABEL...COVERAGE");

%>
	<tr  align="center">
		<td align="center" class="btext" colspan=29>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=districtName1%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Division:<%=rDivisonName%></td>
		</tr>		
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
		<td class=btext rowspan = 4>Sub Division</td>
		
			
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
	<td rowspan=3 colspan=1 class=btext align="center">Habs Covered(Completed Works)</td>	
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
%>