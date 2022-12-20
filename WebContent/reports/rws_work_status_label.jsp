<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Prajapatham Works Report</font></td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=11>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		
		<td class=btext colspan = 8 align="right">Amount In Rs. Lakhs&nbsp;&nbsp;</td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		//System.out.println("IN DISTRICT SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=11>District: <%=districtName%></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Constituency</td>
	
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY ALL SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=6>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Constituency</td>
	
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=6>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=5>Constituency: <%=constituencyName%></td>
	</tr>	
	<tr align=center align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Mandal</td>	
		
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY MANDAL ALL SELECTION LABEL...COVERAGE");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=4>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=4>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=3>Mandal: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Mandal</td>	
		
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") & rPanchayat.equals("-1"))
	{
		//System.out.println("DISTRICT CONSTITUENCY MANDAL SELETION LABEL...COVERAGE");
%>
	<tr align="center">
		<td align="center" class="rptValue" colspan=4>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=4>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=3>Mandal: <%=mandalName%></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Panchayat</td>
		
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("00") && !rPanchayat.equals("-1"))
	{
		//System.out.println("DISTRICT MANDAL CONSTITUENCY PANCHAYAT ALL SELECTION LABEL...COVERAGE");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=3>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=3>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=3>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=2>Panchayat: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Panchayat</td>
		
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && rVillage.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=2>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=2>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=2>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=2>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=3>Village: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Village</td>
		
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE ALL SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=2>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=2>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=2>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=2>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=3>Village: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Village</td>
	
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && !rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=2>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=2>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=2>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=2>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=3>Village: <%=villageName%></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>
		
		<td class=btext colspan = 8></td>
	</tr>
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimated Cost</td>
		<td class=btext>Expenditure Up To Prev. Month</td>
		<td class=btext>Expenditure During The Month</td>
		<td class=btext>Total Expenditure</td>
		<td class=btext>Value Of Workdone But Not Paid</td>
		
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
%>